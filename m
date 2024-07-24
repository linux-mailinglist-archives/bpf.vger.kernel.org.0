Return-Path: <bpf+bounces-35503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5711B93B077
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 13:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0FC1F24CFE
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 11:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC521581F9;
	Wed, 24 Jul 2024 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="X4NhvTVA"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3712E22EF2
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721821020; cv=none; b=kft3gt39KqvPAhWxTR3QBYNLSfcR8kQRWdO5j94xyzseif1C/1Aic4wlzx2HvRIwxx2RGGPS2HZm6YVZSgc+2CWJn9KA2GmBMMIahcsUAKk+U4mqfinp3eeeKyWkZEGDmCUHALBAD7f9k2j1jKbusKA0lwGDeK7i2OGqhR1nq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721821020; c=relaxed/simple;
	bh=SXk3WsBNjDynq25pQIZDkUSYM0QZ+9ZSPnd9uSTDHmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVz3U1ei+yux6KWmqSLHm9xtPy0c7El0dFfvbjEyrOsCuk5lyIwmxxmt1ZrmiDEOHCYyXfm9gfTesiMBG1pr4cgPxar2iOIpH4HqW64duaiJRfCstgUkpn79vO0W0ZQo9VA2Eg4MQz5/ZHe3W4lpt38G8RrmsNVYemMYr+IOJgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=X4NhvTVA; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sWaIh-008OJE-4A; Wed, 24 Jul 2024 13:36:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=nzhloxqdtHODiwkBOZMF69gQ3m2/iOf10YyFwS7HwfY=; b=X4NhvTVACjVdZVtl2XLVA+Oqaq
	h9EehNzvXSsP1E0Y9a6pDVy7LLjlqRYDBGjWv0+Ox+dsi8AMYhC/9m5h/P6yT1HNllERX57TOhved
	PIWEThDhGTVa8sky19dKNDwl3j8i3KUIa3mvULi5XOEvZrw//myCuPKbUGEDmXaaSs5XnFki3PoeP
	bKYNDeE/I5pn0jGWmnoxxqnjsHBdfBbZ9K/5aNhTJImTEi8i45I4l4qrn9rcBNyS8aSZqM3fKYO5h
	RgMZJRGQcqMRwr9lTakKEYbmBo/4UuAhs9PIBFP5hbvlUsr2uHsVdDyMpwU01cuZaUZU0Cpwv4eRl
	XZaMgrlA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sWaIa-0004L0-V4; Wed, 24 Jul 2024 13:36:49 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sWaIQ-00GwhV-Eg; Wed, 24 Jul 2024 13:36:38 +0200
Message-ID: <1612714f-a362-4f42-a05b-53f57b90d6f2@rbox.co>
Date: Wed, 24 Jul 2024 13:36:36 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 2/4] selftest/bpf: Support SOCK_STREAM in
 unix_inet_redir_to_connected()
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 john.fastabend@gmail.com, kuniyu@amazon.com, Rao.Shoaib@oracle.com,
 cong.wang@bytedance.com, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>
References: <20240707222842.4119416-1-mhal@rbox.co>
 <20240707222842.4119416-3-mhal@rbox.co> <87zfqqnbex.fsf@cloudflare.com>
 <fb95824c-6068-47f2-b9eb-894ea9182ede@rbox.co>
 <87ikx962wm.fsf@cloudflare.com>
 <2eae7943-38d7-4839-ae72-97f9a3123c8a@rbox.co>
 <87sew57i4v.fsf@cloudflare.com>
 <027fdb41-ee11-4be0-a493-22f28a1abd7c@rbox.co>
 <87ed7lcjnw.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <87ed7lcjnw.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/24 21:26, Jakub Sitnicki wrote:
> On Mon, Jul 22, 2024 at 03:07 PM +02, Michal Luczaj wrote:
>>> Classic cleanup with goto to close sockets is all right, but if you're
>>> feeling brave and aim for something less branchy, I've noticed we have
>>> finally started using __attribute__((cleanup)):
>>>
>>> https://elixir.bootlin.com/linux/v6.10/source/tools/testing/selftests/bpf/progs/iters.c#L115
>>
>> I've tried. Is such "ownership passing" (to inhibit the cleanup) via
>> construct like take_fd()[1] welcomed?
> 
> I'm fine with having such a helper to complement the cleanup attribute.
> Alternatively, we can always open code it like it used to be in systemd
> at first [1], if other reviewers don't warm up to it :-)
> 
> [1] https://github.com/systemd/systemd/blob/main/coccinelle/take-fd.cocci

OK, so I've kept create_pair()'s __cleanupfication as the last part of the
series:
https://lore.kernel.org/netdev/20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co

>> [1] https://lore.kernel.org/all/20240627-work-pidfs-v1-1-7e9ab6cc3bb1@kernel.org/
>>
>> static inline void close_fd(int *fd)
>> {
>> 	if (*fd >= 0)
>> 		xclose(*fd);
>> }
>>
>> #define __closefd __attribute__((cleanup(close_fd)))
>>
>> static inline int create_pair(int family, int sotype, int *c, int *p)
>> {
>> 	struct sockaddr_storage addr;
>> 	socklen_t len = sizeof(addr);
>> 	int err;
>>
>> 	int s __closefd = socket_loopback(family, sotype);
>> 	if (s < 0)
>> 		return s;
>>
>> 	err = xgetsockname(s, sockaddr(&addr), &len);
>> 	if (err)
>> 		return err;
>>
>> 	int s0 __closefd = xsocket(family, sotype, 0);
> 
> I'd stick to no declarations in the body. Init to -1 or -EBADF.

All right, it just felt wrong to (demand to) initialize variables with some
magic values. __attribute__((setup(set_negative))) would solve that :) I've
toyed with `DEFINE_CLASS(fd, int, if (_T >= 0) xclose(_T), -EBADF, void)`
but it felt wrong, too.

>> 	case SOCK_STREAM:
>> 	case SOCK_SEQPACKET:
>> 		*p = xaccept_nonblock(s, NULL, NULL);
> 
> I wouldn't touch output arguments until we have succedeed.  Another
> local var will be handy.

OK, sure. Thanks.

