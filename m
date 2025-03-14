Return-Path: <bpf+bounces-54054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 390FEA614DC
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 16:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2AB31B636C3
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 15:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66DD202C41;
	Fri, 14 Mar 2025 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="OFH+x/XU"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9799420298F
	for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966175; cv=none; b=C4jRSM5H8CjmFozq1N+BYKNfsYBnwLCGkgFEj9QF4uesZFn80zrp+HHidVHXUCB+mlvW73NH4kLgkYxfK+MgN2vHwKPYa8/q/4N+2XdvmdyBb2gf4pgyTrBFkOYyXAHY7yNdnZEeP3wDV/BrwruAR4hU0l7sQ2M+nAebaV2VDpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966175; c=relaxed/simple;
	bh=AIVfsPIsIRzyAO05tfFfzBfO6lIyoQWUnj1Eegx6UUw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D1ku3+E7+x9IvOMMzSFb+CFWqNa+aIO+g+6eL1b4BcmJ+XRhlMV+qMOTNmXbIvfbe10MWSQBYwLSFiAkiucmraclKgv6j30v/g0V+Y3CeQwTDO6mNZXseLZMd10gaqX2NBmtzX6koBE5HBWWkwMtB8JWRCRx0CO7vPFBUW5TWwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=OFH+x/XU; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tt6yT-006VZU-AR; Fri, 14 Mar 2025 16:29:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=OkJKNKakgINYlhEVlves1w/VP3lzwcypnJF7eTZTI1s=; b=OFH+x/XUcfSMgxYdqLBIT8yONk
	kWkDXL+dKaWTHbIXW62G6XiZehuQipzFy8hYUYjgh7SoyHgWgonLvarkii5E+NlTt6/xtaoNrBdOx
	QRKDX363Mh7YvYq7zi4DceJ5/24EiuGrYXo559jjb8LgR+NcVTePuN1JOJj1J+wgHwanXDx3aZ49l
	QwnIXWVSDN9lqyKVaq3cOA8tUKBav4afFSO+3xOMgmSTT011CEQzz3EUgj8T+L6KbaugCtmsg+Map
	dSE1sfEOH/69KIRSHjmlSTWh7yvMV4KLtEiHc37ZcM3/jZuhUw9Y8zuAtxk4eSrR/PAR0v86UiC99
	wmAOVKUQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tt6yS-00057I-AI; Fri, 14 Mar 2025 16:29:24 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tt6y8-00H2aH-Tn; Fri, 14 Mar 2025 16:29:04 +0100
Message-ID: <24efb98c-d6ba-42c2-91b7-71b969179aff@rbox.co>
Date: Fri, 14 Mar 2025 16:29:03 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
To: John Fastabend <john.fastabend@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
 <20250311162304.5xcnjeue2uwrhswg@gmail.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <20250311162304.5xcnjeue2uwrhswg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 17:23, John Fastabend wrote:
> On 2025-03-07 10:27:50, Michal Luczaj wrote:
>> Signal delivered during connect() may result in a disconnect of an already
>> TCP_ESTABLISHED socket. Problem is that such established socket might have
>> been placed in a sockmap before the connection was closed. We end up with a
>> SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
>> reassign (unconnected) vsock's transport to NULL, breaks the sockmap
>> contract. As manifested by WARN_ON_ONCE.
>>
>> Ensure the socket does not stay in sockmap.
>>
>> WARNING: CPU: 10 PID: 1310 at net/vmw_vsock/vsock_bpf.c:90 vsock_bpf_recvmsg+0xb4b/0xdf0
>> CPU: 10 UID: 0 PID: 1310 Comm: a.out Tainted: G        W          6.14.0-rc4+
>>  sock_recvmsg+0x1b2/0x220
>>  __sys_recvfrom+0x190/0x270
>>  __x64_sys_recvfrom+0xdc/0x1b0
>>  do_syscall_64+0x93/0x1b0
>>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> Fixes: 634f1a7110b4 ("vsock: support sockmap")
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> 
> Hi Michal,
> 
> Unhashing the socket to stop any references from sockmap side if the
> sock is being put into CLOSING state makes sense to me. Was there
> another v2 somewhere? I didn't see it in my inbox or I missed it.
> I think you mentioned more fixes were needed.

Great, thanks for checking. I was worried I might be missing some
subtleties of sock_map_unhash() not calling `sk_psock_stop(psock)` nor
`cancel_delayed_work_sync(&psock->work)`. Especially since user still has
socket descriptor open and can play with such "unhashed" socket.

I've just sent v2: https://lore.kernel.org/netdev/20250314-vsock-trans-signal-race-v2-0-421a41f60f42@rbox.co/

Repro is adapted to sockmap_basic. And to answer your question from
another thread: test triggers warning in a second. Currently timeout is 2s.
I'm not sure how useful it may be for other families, but let me know if
you'd rather have it somehow more generic.

Thanks,
Michal

