Return-Path: <bpf+bounces-72641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D26C17387
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 23:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65531A23B7F
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 22:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAC93570DE;
	Tue, 28 Oct 2025 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="pQssramd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC6D3570CF
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761691320; cv=none; b=PFAP0si8q4oWlQmCDztQvuPQ50D3+8b/04Z2IcemKpVh1dsZAUT4MUXPpU4bxGCpNOweqf1SV7/yGSt84ooWyYCPMwUt+jqzs88RmlPlcN8LeoXXZ+T5jPrJjoNs4MYU2Yqe8cRGABXZg1hvj+hz8mwrXuviiOXzUHi2JA9oj3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761691320; c=relaxed/simple;
	bh=83BsrsHd9DtHXIvdniBfXhWCcsdNkwUdX9oNRcxQWWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMyZehMPQNSp9EX0GZtTKMEz2VzsM1VUP3EVtfk5wRzlgM0TKgA2PPm7X8lnAyWlWyip8Cz63FVNxjEur9FlgBHSv+lJEq5ucxuxY1bSNLrBhp+R0Qx8TMQQeLG7hqfqtlyrpNWKClYombI5k3ozZTSVkUgcYyABLRtFBMgykOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=pQssramd; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34003f73a05so424941a91.1
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761691318; x=1762296118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rhdhypFJDWIT7pOJW2kZUfFCC11WfHBrz2Nq1/pPCBQ=;
        b=pQssramdldvU+onZlFa28wD8JgrFRyeL3IrR/aJioO0jQ/255UX+naCkWP+mX9SqSQ
         +lNHcB25t1k0zI6/t/Pf0bDAdJDU3yLYWGk9PZt81kEuqQzvVz9AqpYv9tWprH80XZg4
         tgbycR2DBtSxkOmP2S5zqdv1PRovgJnoBRcTWXjeR/cCf3DRVO0loEr/Pf+DwR3tXpPk
         qFvE6tqVKouzNXjQg0DBTo20YnThIB2znsMA6rBgQBuUkXdThGYPN1X2S+SQl+AndbdZ
         QV/G39u8Lpl4i5iWxmtfAU58xOulFG1LfwkNGA/j91blo9ZckOWAZlmtwrQv99878dfa
         YFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761691318; x=1762296118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhdhypFJDWIT7pOJW2kZUfFCC11WfHBrz2Nq1/pPCBQ=;
        b=q7wPhjeet6gUeWvko8g9DTOBc8VsyWtpq0AA0D7GFhfTL82AEcncuu4ODtvDVTXMLZ
         R9Ep2aj087iN3dVXp5pP0N3PUlScUStwuwdT+mn3uq0NZEFl97kBAb54Lh4McLecCbNf
         /N6WNzJLGc/qqfecSi4tZfQlNZLaLb2Bx+upXlAU2lkMOIAWT/GjIRNeQlBfAe1HVSOu
         Y53zzMemjcYbYZgmwDfuLY5vg5IBiCebkFkK/n1fnIJxnDzdcnabYWC02tDJ55JuQKKr
         ioCnfMJwUMSQHAYAGoN/2/1lB0CP3p5rUAnL50YhHXtxe1pBMru+ygByzO6dm20AOib4
         Uklw==
X-Forwarded-Encrypted: i=1; AJvYcCVzC+QX2TOUE+qMhMyJCUKjp2YyLP0ZpZOP1WMI2hzSV1tKStcpfh2he2rJJNLlMW3/MMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMS+dT1dERgpbWWU3nE6nIDN0G2FYQ6NKf4BX49hYW4C0K0yuu
	3AvROLFia1kGZxpw8BLxeHIlb6dyXgE83cYMkgrufqTU1GSoVrJq0NCvgBg3X+IUtrQ=
X-Gm-Gg: ASbGncsbmNnXcVCtWegHtzAhM7mzSP83wQLSMnCywVSHD+e34Fp71jfsNcLNAJV7twM
	TMtiNZ/FiQJnXJH2E5ui8+YtvCPFH5pw5ReUkbbd4zotTFndxYaELjBviUbFj8KmlMpNNv7Kymr
	qj3Xi6Of7NlRBAeXFHqb3gmm6dVtAJ4RylTGeFyiHzie1MS6bXBedXmf+BGrYYmqm/wXHt9nvh2
	XGHzg2mi+W8Zziu5fIsgX57cHoCLjhiHxNLSw5/qxmiMed8lWpS7LMU/ueqWzqE0iNkPLNqKRc9
	LZ6bvEjEd/IWtA6Bm8WUhG5YmUnWqq0SzY3z2oDZe7aCPDnaqL7kSS19fhx4kNIQdOrNAy2audc
	lje8jkSlhaKOg+leyjHD2MCm0ZVXHy3LclJW/W1do9FMIjrfkW0TGU1vq2c8dPL3pLRn+UilYSm
	+5HISjwqWN8rXQoIwwoXe/Lwj+P8Xrcqx0DazgjI1Y/DiTFh4PVvl2ONjO8o8sd0IjSaLf
X-Google-Smtp-Source: AGHT+IG0iE584jRlKe5lISrbNMv41T1x67kLdkM9KYyyXjy+vROKVbk6iFfK4oAYQFvskuvGDu3KNw==
X-Received: by 2002:a17:90b:134c:b0:32e:72bd:6d5a with SMTP id 98e67ed59e1d1-3403963d448mr861274a91.1.1761691317762;
        Tue, 28 Oct 2025 15:41:57 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::5:1375])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81b40fsm13255992a91.16.2025.10.28.15.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 15:41:57 -0700 (PDT)
Message-ID: <2f2333fb-707a-4d21-a32d-776489ddc343@davidwei.uk>
Date: Tue, 28 Oct 2025 15:41:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 02/15] net: Implement
 netdev_nl_bind_queue_doit
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-3-daniel@iogearbox.net>
 <20251023192842.31a2efc0@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20251023192842.31a2efc0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-23 19:28, Jakub Kicinski wrote:
> On Mon, 20 Oct 2025 18:23:42 +0200 Daniel Borkmann wrote:
>> +void netdev_rx_queue_peer(struct net_device *src_dev,
>> +			  struct netdev_rx_queue *src_rxq,
>> +			  struct netdev_rx_queue *dst_rxq)
>> +{
>> +	netdev_assert_locked(src_dev);
>> +	netdev_assert_locked(dst_rxq->dev);
>> +
>> +	netdev_hold(src_dev, &src_rxq->dev_tracker, GFP_KERNEL);
> 
> Isn't ->dev_tracker already used by sysfs?

You're right, it is. Can netdevice_tracker not be shared?

> 
> Are you handling the underlying device going away?

Ah, good point, no we're not handling that right now. Reading the code
and intuitively, it doesn't look like holding the netdev refc will
prevent something like unplugging the device...

I take it an unregistration notifier e.g. xsk_notifier() is the way to
handle it?

> 
>> +	__netdev_rx_queue_peer(src_rxq, dst_rxq);
>> +}

