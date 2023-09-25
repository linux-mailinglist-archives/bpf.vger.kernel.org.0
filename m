Return-Path: <bpf+bounces-10762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7997ADDF6
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 19:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 1F6261F24F22
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 17:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAED21113;
	Mon, 25 Sep 2023 17:47:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A94F1CA9E
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 17:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E92C433C8;
	Mon, 25 Sep 2023 17:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695664063;
	bh=Kd5DB5lD9N9X5cbnp5J7jsLmId4kH+fDVReORU0+IDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZcB+V3TgdH6MzxVKhGXICVICPUyFCbPYSuXdFtbe6jVmY0Ja+qbPuCs8ALEe4gf8u
	 09dfdya+O/JKqgJKTwNr7DHo+S3P4pAGLVahnxLmMqqyHJqiMAhmF7j+2WaQQ2O1S2
	 AQDZoc9RCfn3lxnYbGOnmJat99ll720ebys7FCs0HokP9EyQLkYX4sQ3JX+Wos79wB
	 GTBbiMaWb3imtinrQaCeLWyF6ZuKzMB5ZqVh2q4wuTNct3fnjiaAzuzC+PvbSrHTAz
	 zwCGl9LakzazBi6/SsaKMmhDKm0AwlhaIRncuN1SXbpQmYiaxnGa0X0rpSry0EPUS9
	 5Hj2lE8NGoBbA==
Date: Mon, 25 Sep 2023 13:47:42 -0400
From: Sasha Levin <sashal@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>,
	clm@fb.com, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.5 13/41] btrfs: do not block starts waiting on
 previous transaction commit
Message-ID: <ZRHHvrAf/3BIO4E+@sashalap>
References: <20230924131529.1275335-1-sashal@kernel.org>
 <20230924131529.1275335-13-sashal@kernel.org>
 <20230925130112.GK13697@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230925130112.GK13697@suse.cz>

On Mon, Sep 25, 2023 at 03:01:12PM +0200, David Sterba wrote:
>On Sun, Sep 24, 2023 at 09:15:01AM -0400, Sasha Levin wrote:
>> From: Josef Bacik <josef@toxicpanda.com>
>>
>> [ Upstream commit 77d20c685b6baeb942606a93ed861c191381b73e ]
>>
>> Internally I got a report of very long stalls on normal operations like
>> creating a new file when auto relocation was running.  The reporter used
>> the 'bpf offcputime' tracer to show that we would get stuck in
>> start_transaction for 5 to 30 seconds, and were always being woken up by
>> the transaction commit.
>>
>> Using my timing-everything script, which times how long a function takes
>> and what percentage of that total time is taken up by its children, I
>> saw several traces like this
>>
>> 1083 took 32812902424 ns
>>         29929002926 ns 91.2110% wait_for_commit_duration
>>         25568 ns 7.7920e-05% commit_fs_roots_duration
>>         1007751 ns 0.00307% commit_cowonly_roots_duration
>>         446855602 ns 1.36182% btrfs_run_delayed_refs_duration
>>         271980 ns 0.00082% btrfs_run_delayed_items_duration
>>         2008 ns 6.1195e-06% btrfs_apply_pending_changes_duration
>>         9656 ns 2.9427e-05% switch_commit_roots_duration
>>         1598 ns 4.8700e-06% btrfs_commit_device_sizes_duration
>>         4314 ns 1.3147e-05% btrfs_free_log_root_tree_duration
>>
>> Here I was only tracing functions that happen where we are between
>> START_COMMIT and UNBLOCKED in order to see what would be keeping us
>> blocked for so long.  The wait_for_commit() we do is where we wait for a
>> previous transaction that hasn't completed it's commit.  This can
>> include all of the unpin work and other cleanups, which tends to be the
>> longest part of our transaction commit.
>>
>> There is no reason we should be blocking new things from entering the
>> transaction at this point, it just adds to random latency spikes for no
>> reason.
>>
>> Fix this by adding a PREP stage.  This allows us to properly deal with
>> multiple committers coming in at the same time, we retain the behavior
>> that the winner waits on the previous transaction and the losers all
>> wait for this transaction commit to occur.  Nothing else is blocked
>> during the PREP stage, and then once the wait is complete we switch to
>> COMMIT_START and all of the same behavior as before is maintained.
>>
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> Reviewed-by: David Sterba <dsterba@suse.com>
>> Signed-off-by: David Sterba <dsterba@suse.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Please postpone adding this patch to stable trees until 6.6 is
>released. Thanks.

Ack.

-- 
Thanks,
Sasha

