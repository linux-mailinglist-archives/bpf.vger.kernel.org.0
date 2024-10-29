Return-Path: <bpf+bounces-43382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF099B4983
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 13:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB0F1C222C1
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 12:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80A1206050;
	Tue, 29 Oct 2024 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YuyTlG44"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895CC205E09
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730204345; cv=none; b=Zm/5OGM9Bw7pwuGatxRYbjaHhjCHkU4ynEplmztEI1kyj0Q65bivwR+iwWT5/XpGTFHdr8kAoOs7n26s2MSCuNqv1yT5Jn0CjcEQfTyuPsyXfq1wKuBE8QqeZmIntAiPs78UGLTYqp7obn4e2fDighcJpMGIvALKnTua6nHpkZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730204345; c=relaxed/simple;
	bh=0I7kvJtFLDqQM0siDKT0j8ymg14gRFLwbFQ5gaEXjw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U/ZV1iMX/pdVx+m+LC7TDMKFMN2DtjVwgSRAtrqNp2T8l8D6rLnhnr0xnDL1kDX0mYVjPKCn22R58KeZ2yiVpvEN0AvLQeBvJa8orpP7n13/q/gPZUn2VRfl+T77CFZ23a4K6KW9a9hiQ5L2holjQns/d6eyJ4QCPxcAlNjQoO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YuyTlG44; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730204342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfuf4xyKDvT9u1kPEhld7930e8myJyX3Zvs5SawIvSg=;
	b=YuyTlG44rGdGOTGNMYOmP7O4m4uLkLMn+8UHTndNLpN/lAHsUpJAMWwvuBJM5IsouhxHX/
	x0LwU71GKh9sUK63OKZbfVXUcQgqRMLlnSsLs9CLRyjzrJvPMoSoF2GBUgerm2BTaKLAjW
	+4J9jA1btXqasr+JoAiG+dLbbmcOEBw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-t_DeL_PnPGyvAnQbrEG-MQ-1; Tue, 29 Oct 2024 08:19:01 -0400
X-MC-Unique: t_DeL_PnPGyvAnQbrEG-MQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315e8e9b1cso30784065e9.1
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 05:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730204340; x=1730809140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfuf4xyKDvT9u1kPEhld7930e8myJyX3Zvs5SawIvSg=;
        b=ZxpuKjqNwsSydf0YmKgXAaXGnL36dWKq6nWQeD3bNpyKIfPO8NlQZqwpKZJuxPYu15
         rtl7x99VmF6Jvb8ZmYUyoy80RqO59PCwz/69vTMJvqy+QnSHxRci6doSy5e/fowFWMGp
         97/tScxV64C56cGORTAhJc0dzkv6e5srNJGNWC4JfFk84m15/w1zUeP3yfERAgfKohvs
         DXvmxNiZ0bw69eOQ08J3QSnPMPN1ITT8h9WROeHBffdyB4UrnlKCbuuduYAdMIImotIC
         t7835LHpJWzUiScPcn8hy6FQrYJBs/Z/XRPBg/0GRfa6Ko6B48qakc8e6+Gz7NV/CT20
         fZwg==
X-Forwarded-Encrypted: i=1; AJvYcCXiUAIO4KsJYXbgdlOtGBepPmSOvLzrLIy1jZpx066xrPXioCuBoEACgkWYHTVvdT3RL5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtI0wOC3el148ImgckmCdgmYcJl2BdnFZnMzh5kml0gTYAC5D0
	QybFILPu4+wYUV8tktqiJHs0O9Qxp1cnIVWihPaU/N96ke6JDs+YWYmIMbQlOc2+BdEF3fmrO1I
	PaZexqew6FhKRFLzGjAwcYE6DcI3KdSDZaFkLlENSq6LCumP06A==
X-Received: by 2002:a05:600c:3555:b0:42c:b166:913 with SMTP id 5b1f17b1804b1-431b5727f7fmr14851975e9.11.1730204339717;
        Tue, 29 Oct 2024 05:18:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmrOsa0Gr67Yj5/cS+/SQl29FfUNpizydNLzGmFEG+bAVc4wyWPLsRt8+pgyP6z3kTKadvOg==
X-Received: by 2002:a05:600c:3555:b0:42c:b166:913 with SMTP id 5b1f17b1804b1-431b5727f7fmr14851665e9.11.1730204339372;
        Tue, 29 Oct 2024 05:18:59 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b5430edsm173654585e9.2.2024.10.29.05.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 05:18:59 -0700 (PDT)
Message-ID: <c0a4d1ad-cb3a-4d61-93b5-471c1033d67d@redhat.com>
Date: Tue, 29 Oct 2024 13:18:56 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 11/14] tcp: allow ECN bits in TOS/traffic
 class
To: chia-yu.chang@nokia-bell-labs.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, netfilter-devel@vger.kernel.org, kadlec@netfilter.org,
 coreteam@netfilter.org, pablo@netfilter.org, bpf@vger.kernel.org,
 joel.granados@kernel.org, linux-fsdevel@vger.kernel.org, kees@kernel.org,
 mcgrof@kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20241021215910.59767-1-chia-yu.chang@nokia-bell-labs.com>
 <20241021215910.59767-12-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241021215910.59767-12-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 23:59, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -2178,6 +2185,7 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
>  int tcp_v4_rcv(struct sk_buff *skb)
>  {
>  	struct net *net = dev_net(skb->dev);
> +	enum tcp_tw_status tw_status;
>  	enum skb_drop_reason drop_reason;
>  	int sdif = inet_sdif(skb);
>  	int dif = inet_iif(skb);

Minor nit: please respect the reverse x-mas tree order.

More instances below.

Cheers,

Paolo


