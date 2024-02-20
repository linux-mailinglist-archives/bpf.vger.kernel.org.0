Return-Path: <bpf+bounces-22296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 055DF85B72C
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 10:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9397BB26A29
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 09:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F4F5F87F;
	Tue, 20 Feb 2024 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="lQFRjvtM"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AEF5F48B;
	Tue, 20 Feb 2024 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420795; cv=none; b=SilOFOdhnNKP40P5XMFLjrZohN0RB+SPVA0ujWaMdtC+zqd27xy+TdFauXLZ21D7Hcd1Bd7+YO29+AIedusv/RBlG4Tbn6636cN9G3pq9WQQPF+Y6fvHaHjGiroGHR/6a79xW5AtzbB0trrP5QAraYK/LoSGN/Kj0oSf/ckLwm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420795; c=relaxed/simple;
	bh=bwT3c4fTnCDe05dvq1l/DYWXthS7YYkrWruFJpPD8tc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lNv7a7ALQpKd3j74bftWH2f5RlDUnK0y8wxXK7q1relj9r54k99CFV8i/e1nqUmZKUhRhk9IXQaKpmZ48usVS7NdxNvxvq+uJWaE6Zl6zSXBZEZX9kYK0YBia9DKp5PKdO1dvvHIMtY6H+F5v66zKDBfvV4/GcP+4n5U5Q9K4JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=lQFRjvtM; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pnB5JW9TLOshndb6+kfruCaB3IU6xVBqoQ1BTt8gcAY=; b=lQFRjvtM2mkLsBg5Xqe+eZ07n6
	Bgw+WRmbTlgGAfjMwbv/1RP1wa13H0Mj8G+FNxXb8a89ejwXhAZaING9OMZhnGj1Svx6yFUpcMKwT
	x25yPhIrrj3r2aAbS6yjGS8LMRT/u8l1xKfnMGB4N+Ek10FMkFyt5a6AEfeyAosQaddc5C2Ow9ug+
	lFn2Q51kUpSlvJuHt0IC1PeL44DbUYUGEakvSBOfsN11Zz+nrLx1qOfNWlLEBnXpW4e6zIFTFuQlz
	KYzn6XYuvw7ypx25tGD+DM4l3gsgzk4TCOzZzlBEN7Kq7prKpYWwpbrZ3D+Q/YXgIbE7uEfRmRUYR
	ojRFTuFA==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rcMHv-000NpA-HC; Tue, 20 Feb 2024 10:19:43 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rcMHu-000Dqw-Vd; Tue, 20 Feb 2024 10:19:43 +0100
Subject: Re: [PATCH net-next 0/3] Change BPF_TEST_RUN use the system page pool
 for live XDP frames
To: Paolo Abeni <pabeni@redhat.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?=
 =?UTF-8?Q?sen?= <toke@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240215132634.474055-1-toke@redhat.com> <87wmr0b82y.fsf@toke.dk>
 <631d6b12-fb5c-3074-3770-d6927aea393d@iogearbox.net>
 <b5a062465f9afe36106fe1d624b2e9e129bea0f4.camel@redhat.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9b211443-a6a1-981c-b2a8-42ec0e876fba@iogearbox.net>
Date: Tue, 20 Feb 2024 10:19:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b5a062465f9afe36106fe1d624b2e9e129bea0f4.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27190/Mon Feb 19 10:24:27 2024)

On 2/20/24 10:03 AM, Paolo Abeni wrote:
> On Tue, 2024-02-20 at 09:39 +0100, Daniel Borkmann wrote:
>> On 2/19/24 7:52 PM, Toke Høiland-Jørgensen wrote:
>>> Toke Høiland-Jørgensen <toke@redhat.com> writes:
>>>
>>>> Now that we have a system-wide page pool, we can use that for the live
>>>> frame mode of BPF_TEST_RUN (used by the XDP traffic generator), and
>>>> avoid the cost of creating a separate page pool instance for each
>>>> syscall invocation. See the individual patches for more details.
>>>>
>>>> Toke Høiland-Jørgensen (3):
>>>>     net: Register system page pool as an XDP memory model
>>>>     bpf: test_run: Use system page pool for XDP live frame mode
>>>>     bpf: test_run: Fix cacheline alignment of live XDP frame data
>>>>       structures
>>>>
>>>>    include/linux/netdevice.h |   1 +
>>>>    net/bpf/test_run.c        | 138 +++++++++++++++++++-------------------
>>>>    net/core/dev.c            |  13 +++-
>>>>    3 files changed, 81 insertions(+), 71 deletions(-)
>>>
>>> Hi maintainers
>>>
>>> This series is targeting net-next, but it's listed as delegate:bpf in
>>> patchwork[0]; is that a mistake? Do I need to do anything more to nudge it
>>> along?
>>
>> I moved it over to netdev, it would be good next time if there are dependencies
>> which are in net-next but not yet bpf-next to clearly state them given from this
>> series the majority touches the bpf test infra code.
> 
> This series apparently causes bpf self-tests failures:
> 
> https://github.com/kernel-patches/bpf/actions/runs/7929088890/job/21648828278
> 
> I'm unsure if that is blocking, or just a CI glitch.
> 
> The series LGTM, but I think it would be better if someone from the
> ebpf team could also have a look.

The CI was not able to apply the patches, so this looks unrelated :

Cmd('git') failed due to: exit code(128)
   cmdline: git am --3way
   stdout: 'Applying: net: Register system page pool as an XDP memory model
Patch failed at 0001 net: Register system page pool as an XDP memory model
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".'
   stderr: 'error: sha1 information is lacking or useless (include/linux/netdevice.h).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch'

