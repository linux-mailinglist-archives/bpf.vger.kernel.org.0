Return-Path: <bpf+bounces-10755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325CA7AD89D
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 15:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 7AEBAB20A69
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 13:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287941B28F;
	Mon, 25 Sep 2023 13:07:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608E613ACF
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 13:07:53 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AC19F;
	Mon, 25 Sep 2023 06:07:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC9B52184B;
	Mon, 25 Sep 2023 13:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1695647269;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uogSkl/Z/WJ9T6hoo/bSUzNSf4lFK3ehh10RUHSsUbk=;
	b=WuWEKx9uZNgebRn1eXtir9EL0GP9mnPuaumM2XM5cW+RLX12hK6xegeqM1q2kkX83OB7jJ
	u3dUveWRAftHa6zIdyE+ykmq0sqYx1hq3we3sJ3jnrR8RocOEC6cp9olX+gwdnSgMX/IMn
	/DTfy8hKpQJPCzfF8tEmTcH481J21jA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1695647269;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uogSkl/Z/WJ9T6hoo/bSUzNSf4lFK3ehh10RUHSsUbk=;
	b=dZm2wZEDU14MGy4UEhTV0Ga3DgrWFnu/B+ar28xBiul6F1kx4A8yuuBn8jC5n7B5ztwP5b
	oOqWTQwozvJo8ZBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75B4313580;
	Mon, 25 Sep 2023 13:07:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id H8xEGyWGEWU6BAAAMHmgww
	(envelope-from <dsterba@suse.cz>); Mon, 25 Sep 2023 13:07:49 +0000
Date: Mon, 25 Sep 2023 15:01:12 +0200
From: David Sterba <dsterba@suse.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>,
	clm@fb.com, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.5 13/41] btrfs: do not block starts waiting on
 previous transaction commit
Message-ID: <20230925130112.GK13697@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230924131529.1275335-1-sashal@kernel.org>
 <20230924131529.1275335-13-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230924131529.1275335-13-sashal@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 24, 2023 at 09:15:01AM -0400, Sasha Levin wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> [ Upstream commit 77d20c685b6baeb942606a93ed861c191381b73e ]
> 
> Internally I got a report of very long stalls on normal operations like
> creating a new file when auto relocation was running.  The reporter used
> the 'bpf offcputime' tracer to show that we would get stuck in
> start_transaction for 5 to 30 seconds, and were always being woken up by
> the transaction commit.
> 
> Using my timing-everything script, which times how long a function takes
> and what percentage of that total time is taken up by its children, I
> saw several traces like this
> 
> 1083 took 32812902424 ns
>         29929002926 ns 91.2110% wait_for_commit_duration
>         25568 ns 7.7920e-05% commit_fs_roots_duration
>         1007751 ns 0.00307% commit_cowonly_roots_duration
>         446855602 ns 1.36182% btrfs_run_delayed_refs_duration
>         271980 ns 0.00082% btrfs_run_delayed_items_duration
>         2008 ns 6.1195e-06% btrfs_apply_pending_changes_duration
>         9656 ns 2.9427e-05% switch_commit_roots_duration
>         1598 ns 4.8700e-06% btrfs_commit_device_sizes_duration
>         4314 ns 1.3147e-05% btrfs_free_log_root_tree_duration
> 
> Here I was only tracing functions that happen where we are between
> START_COMMIT and UNBLOCKED in order to see what would be keeping us
> blocked for so long.  The wait_for_commit() we do is where we wait for a
> previous transaction that hasn't completed it's commit.  This can
> include all of the unpin work and other cleanups, which tends to be the
> longest part of our transaction commit.
> 
> There is no reason we should be blocking new things from entering the
> transaction at this point, it just adds to random latency spikes for no
> reason.
> 
> Fix this by adding a PREP stage.  This allows us to properly deal with
> multiple committers coming in at the same time, we retain the behavior
> that the winner waits on the previous transaction and the losers all
> wait for this transaction commit to occur.  Nothing else is blocked
> during the PREP stage, and then once the wait is complete we switch to
> COMMIT_START and all of the same behavior as before is maintained.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Please postpone adding this patch to stable trees until 6.6 is
released. Thanks.

