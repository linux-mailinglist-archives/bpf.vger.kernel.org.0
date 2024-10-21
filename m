Return-Path: <bpf+bounces-42597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F1B9A64C4
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 12:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F703280E73
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 10:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359461F8915;
	Mon, 21 Oct 2024 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOD5v52F"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E411F819A
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507474; cv=none; b=ry0Z6AqAD9tLD9bJm8ct+SJCZl4ghFvBmLdBEApDCERdzE5fwvMASKxpzKWT1d6DKQv5jN7r+cdX3B3N+ruk3ouUsAKyZuEa8+KtBoOHiytZF1ZPGt0Hh99dRIDakItFA7xfd6Wnmtd1/4Pw4e07uFjmz5oosteQjZQJVvQHfMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507474; c=relaxed/simple;
	bh=QszUSC+eDikLq/z2gASxiOYZierjrRupuXUewlv1aoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcvAEl4sAE7VezL4QVrzx3ztj3fcw95UBs59lLLIY+y+BqYMFNfpila2nvuYsvF2Uqedo7xOa1vKADmG5GOuXpUSIT3zx+qDM7nRYcIoI1w2SdULhI+IrJ8dgwxIXSUevyo4n9eHswGWl1Z7mOIrEuP5iBWS5euskvnVyqKutH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WOD5v52F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729507471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESVSTYYZIF0hJLrudzMovh5iFWIQNUs6HLNbYhgpPLs=;
	b=WOD5v52FaTR+5/VQVjJ7ldayZ2sCfn+cIhbFLeZRjAut1WEzX9ghu0Y2VWdVY3PzrT1Gdv
	1tsFdddnHe7Ml4tRpRBZiEy6RJkLB8X96cCN2DuUQQfZxY7cfBUYViXLiSTGBGcdIyQTtt
	HvXTVC9XtxqZz6IhWEID7g6zwNXVdmI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-4V8MvD7dM4e-se5ZMXSN3A-1; Mon, 21 Oct 2024 06:44:30 -0400
X-MC-Unique: 4V8MvD7dM4e-se5ZMXSN3A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d45de8bbfso3040884f8f.3
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 03:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507469; x=1730112269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESVSTYYZIF0hJLrudzMovh5iFWIQNUs6HLNbYhgpPLs=;
        b=uVAlO8fKp0ImiSLswOmiGbr4OulX2f5lk5sVVKqJJ2XzpmYwvEQcYCnEJ9S6a7pNi+
         DF+Xzr5B8Otc9bucqFemO2zrcvt3zc007h7jNrit4RebYBHQ6hFzt+//wJLXbxl6dNYg
         KEFQHQiPLw9FCgn9MPw+bY1e7ei8Fo+v6VajUJSywUwPlfBTzf4dhwm+p4hRA+sKLLQC
         6ZUc+g0o7sB7J3txpII6JAqINrpk7m2RtudZSMpMhjhFS9thS4LFjCegGl2pFWs7Xqaa
         TvTQOSeznXJq9/gkciYU5rZffpaZ+reXeWj7Dss2j+quwAKyhAtl15dFdxpseWZcKlRF
         VYkg==
X-Forwarded-Encrypted: i=1; AJvYcCVnvY/X6ryqgaUTLHHJZ6E1mgO6Tv8tGsmdXWdjtQLqUmd62OvTYsozERTLEOjrOvhiAss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOnooMzQcZ3Zbv5bKE+Yzw+UmXet/JciTSavjRJ9Df8bb7vPto
	YD/9RoF1e8Ld/IL40F8zYv+wCa6JeuQGpSNpvv22mc1GP3EP8oXvzw/KT79FMVSgDM91/fv5GDm
	B62KTNk+6STJSATelzCUecX9JbJo+CIvTpzuFOlUsFSd159wVcQ==
X-Received: by 2002:adf:e005:0:b0:37d:5042:c8de with SMTP id ffacd0b85a97d-37ea21d960cmr9407827f8f.22.1729507469422;
        Mon, 21 Oct 2024 03:44:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEjJ5g1Du8OWB8p2Bdce9qpXw/gQOJX9TgsNNH+Knj/WJjb8z0dN/BAeiBh4kBOoGsx2V9lw==
X-Received: by 2002:adf:e005:0:b0:37d:5042:c8de with SMTP id ffacd0b85a97d-37ea21d960cmr9407810f8f.22.1729507469018;
        Mon, 21 Oct 2024 03:44:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37b07sm4049451f8f.1.2024.10.21.03.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 03:44:28 -0700 (PDT)
Message-ID: <c6e8f053-32bb-4ebd-871b-af416d0b0531@redhat.com>
Date: Mon, 21 Oct 2024 12:44:26 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 07/10] net: ip: make ip_route_input_noref()
 return drop reasons
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com,
 bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org,
 dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
 <20241015140800.159466-8-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241015140800.159466-8-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/24 16:07, Menglong Dong wrote:
> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index e0ca24a58810..a4652f2a103a 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -98,6 +98,7 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
>  		skb_dst_drop(skb);
>  		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
>  					   ip4h_dscp(iph), dev);
> +		err = err ? -EINVAL : 0;

Please introduce and use a drop_reason variable here instead of 'err',
to make it clear the type conversion.

Thanks,

Paolo


