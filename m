Return-Path: <bpf+bounces-74194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4DEC4CAC0
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 10:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5A53B329B
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 09:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A442EB876;
	Tue, 11 Nov 2025 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dydDUy0r";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d91VcPOb"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195BD2777E0
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853409; cv=none; b=HJZchhRUKfB5RiGSFPqNVCbiCqdfrYZsrEPS3+4JDvB+iA8q+LSzPYsFb855HCB80ywQyPjOunXYtPwAekzbnbWnKmE3m6p0I8lqvLBZJxIvMYyDi2P7sTwuyE17nCnLb7CfC6hsbJEpSqnaK7VrkC5v61vs3cCooH8SRpExUk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853409; c=relaxed/simple;
	bh=wexyvat/0SYqqKjEF/5VtMpaGazcWYImhu/WttpvyBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ee6oK8kpP13uhIK9UZ7pjrChVrfFOlUCJRuoT5YdillwTmCU1xm6jvt1jQNwkfGB7k8cw1HqOjIYD+sDfhxYbCXTJobonFR4YnpuW5+UEuW/HKPus/5kH4Lts/RsvHtPszxNPJr1h4U/i5EdfeA/slC4Kh63ZxbonJh/hlyMpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dydDUy0r; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d91VcPOb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762853406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+yful8XuD1rOWAT4s6PVlCJAW6mP+A9zgtwVM3K1L1M=;
	b=dydDUy0r/ofaDO+DVukTLYOsNMPlmV3ZIDT4yS9Nvgg/ebWwXQvW+oTkREY/zUjUKO49Sk
	e2Dd5OUoaEa0pa1wOABCgsggvqw3onSU/0RN4gPtr76RYI0UL8bINofyuyqoT8aqYkU7ih
	O9e24+sU+dZU87ESv+30GZynAj68OVk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-t-Zhc3z0MNeAAwwyYNZnDA-1; Tue, 11 Nov 2025 04:30:03 -0500
X-MC-Unique: t-Zhc3z0MNeAAwwyYNZnDA-1
X-Mimecast-MFC-AGG-ID: t-Zhc3z0MNeAAwwyYNZnDA_1762853402
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b352355a1so260692f8f.1
        for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 01:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762853402; x=1763458202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yful8XuD1rOWAT4s6PVlCJAW6mP+A9zgtwVM3K1L1M=;
        b=d91VcPObXpRHQNM8tQxVPult8PQc8HfTSP7WYvQ0i0MNr66xtfgTYAdOa7/sakgOcF
         /4BkyrZ02vdxdM81ORL0igEWuea5xNefCsung/rJQv7ognM0Vdtdf3PfWsDhT8jJrEfD
         tVK4c+tUh2txxyyBevI1VH8uYgQZt4AOGfLO3ZpxrTmvIYY8KZttnQdWiSyFH/Wq+Is5
         LFt+hvdFDC0rByjybqekGrkyL35RKca7P0RxrNePp2M+HoN6hQSvwbXIIPXo2qj1e1Vx
         ak430DsojIFVe8RPiTyqXDHC38jCJZ5zP+4TdhupHAIrNeTYJtY0KNlDhC2N4dRl6hYR
         gKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853402; x=1763458202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yful8XuD1rOWAT4s6PVlCJAW6mP+A9zgtwVM3K1L1M=;
        b=PXz2LZbAsEPtwWkLCWAmY4Wpy2zq0pAGkjdG30NP4g6R9yxAVL/LKR8BSKvkvM/ymj
         jS5zZQ/RZ0C4XpiRZ6ZYwp25Eu1RiasCuH8xNLH3Sqzg89ZQxUsASdVm1lnOeD8ap7g8
         qeSnkT1dMSTNX5zs+OloLZLaC91BOv4fyAV6thA31fM9axbTCJsvSx0Z5iLQjIuWp9n1
         8A0urH8dckBRmJWNra5s8ttW5FuL61qycG7wcNojvTHHOW2FJ7W6+knYoVeq1ZNrYPMt
         gZdOhCL7//2Jd8eXjHzAyb82u1lZaVazMw53MhLy6UbetsUFgwKgK6msFaw/czc4V/kS
         p4bA==
X-Gm-Message-State: AOJu0YwpvF+1WgBdBCs5mNAdJvNBAa2bO86ZHjJYKW1NPv/Cd01rUUqt
	SL8rT3ri1Aw2P3x0AwUprYOhGDg2JsHZIsIgWwjAzdXB8+m+Besup6tu65H2Ed03mtMvQ/0ZFkn
	yL4219g4ld8tVjDOz2UUx7JxSLISqhaEWuZYmU8YfAtRWLfT5Uswm1Q==
X-Gm-Gg: ASbGnctFCnS7ucXXgSzPyJq69SuAoTXkdvjsyvycthcfXPJBl4JEdmY47kVPkD+UkYM
	d68DS26jImaIF+AQ2uad5xy7oh6GcW7+VUhj2h+vYmoinHs3KiGiDgjS95QTvb01QZorVcAE3Ps
	m5xt2tQG8YsTGA7K2pW8AGNMLMNdcNl6ugenXCWLnbWpbuBK8+NT+F86poBiS5aiNw0wp/Fe/TD
	YCMpi7i68MhSuqjSsEkWBu5GFzY31JhmTDAfTzwCZv2dLDH/vPkaWZ5xBGYi+e0rWqUHb4cqwDw
	Z2rTuHZvgTQcn/CeWARWUaUWTLJ0pyLczXJfLxt7PsA7jlgy1NHugE5SPQ/kDtRbKloTH9MW5vs
	jqw==
X-Received: by 2002:a05:6000:4312:b0:42b:3455:e4a1 with SMTP id ffacd0b85a97d-42b432c93d0mr2041926f8f.15.1762853402424;
        Tue, 11 Nov 2025 01:30:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYsOpckTu4T5+pAfy7v94Qj5GGQZdQQIzQt5CZrzblwz3VQAr9XYobfFM+3VkqMQLnNjiYOA==
X-Received: by 2002:a05:6000:4312:b0:42b:3455:e4a1 with SMTP id ffacd0b85a97d-42b432c93d0mr2041903f8f.15.1762853401941;
        Tue, 11 Nov 2025 01:30:01 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2b08a91esm21407249f8f.2.2025.11.11.01.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 01:30:01 -0800 (PST)
Message-ID: <a84ce374-8693-4f53-876b-973c9ddff031@redhat.com>
Date: Tue, 11 Nov 2025 10:29:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] xsk: add indirect call for xsk_destruct_skb
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20251031103328.95468-1-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251031103328.95468-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/25 11:33 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Since Eric proposed an idea about adding indirect call wrappers for
> UDP and managed to see a huge improvement[1], the same situation can
> also be applied in xsk scenario.
> 
> This patch adds an indirect call for xsk and helps current copy mode
> improve the performance by around 1% stably which was observed with
> IXGBE at 10Gb/sec loaded. If the throughput grows, the positive effect
> will be magnified. I applied this patch on top of batch xmit series[2],
> and was able to see <5% improvement from our internal application
> which is a little bit unstable though.
> 
> Use INDIRECT wrappers to keep xsk_destruct_skb static as it used to
> be when the mitigation config is off.
> 
> Be aware of the freeing path that can be very hot since the frequency
> can reach around 2,000,000 times per second with the xdpsock test.
> 
> [1]: https://lore.kernel.org/netdev/20251006193103.2684156-2-edumazet@google.com/
> [2]: https://lore.kernel.org/all/20251021131209.41491-1-kerneljasonxing@gmail.com/
> 
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

My take here is that this should not impact too negatively the
maintenance cost, and I agree that virtio_net is a legit/significant
use-case.

Cheers,

Paolo


