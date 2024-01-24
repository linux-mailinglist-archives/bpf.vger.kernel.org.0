Return-Path: <bpf+bounces-20215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C4C83A6CC
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 11:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6981F23C77
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 10:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B8F18E29;
	Wed, 24 Jan 2024 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="fgg61qzG"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F235A19477;
	Wed, 24 Jan 2024 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092177; cv=none; b=TdWk/l+mbKJS2RsOnE5x+kdwic3B4qdSJM6Ll+H4O0Xt3l2CGK12pp0GyR4aClXxAMuhOPM6o5D0DuW7s13pi3QpsspkVMZ/6va0O8Ly+epQzSrSUFYIRw9wMcFizl24L/UBKTuy5JgXlO9JwevtFucnWvkcevtdK8BmH2O2oDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092177; c=relaxed/simple;
	bh=Dmx5SuChduxCEeVi8pipanPYbUlTU9+SQdk+aCCDLl4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BPW0/sNFp/iuILpayo3HW8UfJ3X2SsOFvhf7BbUN9BSlVGdJ2d8+K1PxN4VYUjStB2p2LAwRIq2MLUYuXNg4ieG42PaBwWFoUM2tXPcG1b61TmrUFvxXDIhlhUm4nTTGgPItrfFlIBgYfr7zRdiwDQWtKFFW7hO9Htm5deiZx5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=fgg61qzG; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=D864anpPxA/M/z0+gC+pfM7u04tkcLvvuRBDrZXY//4=; b=fgg61qzG9tT159hHX2d9OKGJLX
	oebo7sUnlaxj4Jk6BxJiM9Jc+iMdPvHoAy3Oe2lEjOL2jauwZfl5HxGKAWMZj3rDS1pEiWCda98I4
	jYZbmklKm5v3LBCp7v3vAezMdt4VMe+ym8YXGObz2X5f+U5AYA79CO+r0XkDvRf7rs2fgk23GGJ20
	snng/ugdN9IVfuHAwZPNftgL9+O8GD3uWmnho7yigmnEBLkWlAQp98Kj9pwUdmJ+jssExZpgWahvs
	lluhPxIdrfFVBk+sbS2LZSly8DRM2659JMrvB51QrCnRMDgQMhIwy8WZF5JGQS2NuWdorffN9C+Fx
	s33yAcxg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rSaVc-000Py7-Vl; Wed, 24 Jan 2024 11:29:29 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rSaVc-000ONc-C8; Wed, 24 Jan 2024 11:29:28 +0100
Subject: Re: [RFC PATCH v7 7/8] samples/bpf: Add an example of bpf fq qdisc
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, toke@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <cover.1705432850.git.amery.hung@bytedance.com>
 <52a0e08033292a88865aab37b0b3bd294b93e13c.1705432850.git.amery.hung@bytedance.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1f48019a-fb72-324c-7626-ba5ccb9307b0@iogearbox.net>
Date: Wed, 24 Jan 2024 11:29:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <52a0e08033292a88865aab37b0b3bd294b93e13c.1705432850.git.amery.hung@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27163/Tue Jan 23 10:42:11 2024)

On 1/17/24 10:56 PM, Amery Hung wrote:
> tc_sch_fq.bpf.c
> A simple bpf fair queueing (fq) qdisc that gives each flow a euqal chance
> to transmit data. The qdisc respects the timestamp in a skb set by an
> clsact rate limiter. It can also inform the rate limiter about packet drop
> when enabled to adjust timestamps. The implementation does not prevent hash
> collision of flows nor does it recycle flows.
> 
> tc_sch_fq.c
> A user space program to load and attach the eBPF-based fq qdisc, which
> by default add the bpf fq to the loopback device, but can also add to other
> dev and class with '-d' and '-p' options.
> 
> To test the bpf fq qdisc with the EDT rate limiter:
> $ tc qdisc add dev lo clsact
> $ tc filter add dev lo egress bpf obj tc_clsact_edt.bpf.o sec classifier
> $ ./tc_sch_fq -s

Would be nice if you also include a performance comparison (did you do
production tests with it?) with side-by-side to native fq and if you see
a delta elaborate on what would be needed to address it.

> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---
>   samples/bpf/Makefile            |   8 +-
>   samples/bpf/bpf_experimental.h  | 134 +++++++
>   samples/bpf/tc_clsact_edt.bpf.c | 103 +++++
>   samples/bpf/tc_sch_fq.bpf.c     | 666 ++++++++++++++++++++++++++++++++
>   samples/bpf/tc_sch_fq.c         | 321 +++++++++++++++
>   5 files changed, 1231 insertions(+), 1 deletion(-)
>   create mode 100644 samples/bpf/bpf_experimental.h
>   create mode 100644 samples/bpf/tc_clsact_edt.bpf.c
>   create mode 100644 samples/bpf/tc_sch_fq.bpf.c
>   create mode 100644 samples/bpf/tc_sch_fq.c

