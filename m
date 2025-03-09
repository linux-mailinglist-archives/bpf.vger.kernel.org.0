Return-Path: <bpf+bounces-53698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B97A58951
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 00:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55993A7C34
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 23:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766FF22173F;
	Sun,  9 Mar 2025 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="dwsqqJrY"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008921CCEDB;
	Sun,  9 Mar 2025 23:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741563788; cv=none; b=Ps5jymeuQFG6LALKBumdAJaMS3RlYf9jU1Yt5YsAE/3iFR4vjnaQq20Jq8pEBQFwZZ0iroDB5HfKVejS0LcwNOqqle0kKau/hb+eIVdhRcIBDgFB5yMscS6eGtxVWE5/xBm2EflDy2DN8fALh6ggUWEA9azupFUSJj2fwvoacc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741563788; c=relaxed/simple;
	bh=PvVE9HNj59mpecuBm7xZloSjNqHLHfoojcoFAF8X8Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9P/8gAA/HLVWKZ7SqVGR/AEtyJ5O7z5t4Sft33Tmr7Ou8zvrhYFE71Tx1MKMUdo7Paxn0MVBOtwj0dRwASHZQXpvySXJN4QkJtH8q6eahLSx20JnBPsFdcnwBkDVW19Ut4r9xay1aLNzaSbiHsJdlxtGQbTRmrTiTpJPnI3N64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=dwsqqJrY; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1trQI9-00APFn-Jy; Mon, 10 Mar 2025 00:42:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=UA39vXffBnMW+SSvM+/rFys1woMllWZP1w5Kuj2MQXQ=; b=dwsqqJrY28vfkbNyGknUJD2jhw
	eUhHlxrvKjF18S3OvAaFe4zZ2eVSubaNOJA2+YaQTRIdyZ6kPSIiZjPPbwIyCktm30OsH2ddXn52G
	Qwzugu1FCYgdd/jvoZtUFOr8XuyouGsHdUqmjg+sVYmps8osfYbOL2ZBAk5Smun2rrpE2WRuUmAZ4
	mghvZM6zy03SsYnGo5dtoaLm16sZRn2yumOPRp4rxnUu0vdN+nZKVzKaOfk5Iymqrny78UbodPs1+
	5S3KivaFKoQIH4dGhOI0+9iy0SWUZOaCNFhcnGJZa+KUSafyaKFwzcn7eLghAThOhG8L9LZoEsz1h
	OdvOPnWg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1trQI8-0007qd-KA; Mon, 10 Mar 2025 00:42:44 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1trQHt-004zM5-LR; Mon, 10 Mar 2025 00:42:29 +0100
Message-ID: <be935429-2125-4fea-844b-abce83f7324e@rbox.co>
Date: Mon, 10 Mar 2025 00:42:28 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
To: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/25 10:27, Michal Luczaj wrote:
> Signal delivered during connect() may result in a disconnect of an already
> TCP_ESTABLISHED socket. Problem is that such established socket might have
> been placed in a sockmap before the connection was closed. We end up with a
> SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
> reassign (unconnected) vsock's transport to NULL, breaks the sockmap
> contract. As manifested by WARN_ON_ONCE.
> 
> Ensure the socket does not stay in sockmap.
> 
> WARNING: CPU: 10 PID: 1310 at net/vmw_vsock/vsock_bpf.c:90 vsock_bpf_recvmsg+0xb4b/0xdf0
> CPU: 10 UID: 0 PID: 1310 Comm: a.out Tainted: G        W          6.14.0-rc4+
>  sock_recvmsg+0x1b2/0x220
>  __sys_recvfrom+0x190/0x270
>  __x64_sys_recvfrom+0xdc/0x1b0
>  do_syscall_64+0x93/0x1b0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fixes: 634f1a7110b4 ("vsock: support sockmap")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

This fix is insufficient; warning can be triggered another way. Apologies.

maintainer-netdev.rst says author can do that, so:
pw-bot: cr


