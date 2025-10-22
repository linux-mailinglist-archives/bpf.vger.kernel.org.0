Return-Path: <bpf+bounces-71712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3F7BFBF9F
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 14:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8803718942D9
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 12:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598553446A6;
	Wed, 22 Oct 2025 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="UNS2drj+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC83491DA
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137429; cv=none; b=DUBi/kcp+UzSTCPCQ7Oteui37dHGbh+5Swn9M2R7hShiwx/bEz5MALJJBIcr7j2Fb1D63U4Xfz/lqKTi9frs8dGY3+mWFseuRnnDoH0HsyJ7MSXIZbjDVgorAcB9+s9ybDJwmLrO1rFTOczOIU0RiYaGHTAk/ydH8mtjLZS7ako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137429; c=relaxed/simple;
	bh=ZXohKXzTXjxyhGmIta74tVz7YubZEcgHibf5y0hQrzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsL/APsJ1/07VsJG7bXqOHlGqw0E8ABNvXgIGhBm1c97tmBjkQWQNK/nGmQBuKkZLXCiMS2D1xjZEUkT5v99nGn055NnqEuVTIW6xUspKlXIo3cdbsJ7ouIRqNR/mTU+0IOaxFVOR/y6j8mtnU6Ug4pFAcrzr82j8tZ+XhVpbeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=UNS2drj+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so1302212966b.0
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761137421; x=1761742221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OlBzXeLMRR7oz24/jCJCTbfxBakkjsQ0pgWftELTrS4=;
        b=UNS2drj+Nt/qR4ZfAnlpRfG8ploIjPfOdCa7LIwderQ2zx1Wb5UvuJL/FtbD4G18xi
         VB1IVyaQm7gbSNzJoZxVCL16kuGgGdIg0jBAetw1m9QEwuLTiegmY9JckKG4qHIv17tz
         9+lVxvn89f1CgCz+dygcoewS9TlJU0tn9ldDf7AzeMQqOQVDPb4iTJQ9Eg/yrurTQB36
         NBVQ3agKEOdjbh0ZEK+htdV2HuiycS86FIjiMdmFBH232pHsA8yhlh9Dv6Ke5hzTQ4KW
         PbXpM+UqnX/+l4soczXV+ySTUsDqqer0g/cxZzKK+P/+MJOQya9NeKWJfCfDCehQtlJ3
         cnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137421; x=1761742221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OlBzXeLMRR7oz24/jCJCTbfxBakkjsQ0pgWftELTrS4=;
        b=UMLj8QxG9fj0PrPRIAgofEe5CpxsFHJyproRWb5oqRYhaRiDLIqPw+br6ja0J0KQt/
         /SC+uoerJOY8ysubo8qbVDYLQ+sRLEE6eHT6TQGsZK46CaolcyCq7Kra43yHgLs6nfsK
         ZnFn9N4zJnU0NKWelfdfy+HKjxnkLtQRD7LIkCdrVCV3JBeg0KQ7oxLVmwkY6qXvlBxI
         gNR3nt65cbnAPlthm+AWv1rW8T/poWi830FUHVFZ+YtUIiuWY6damh3uXz7Rewmy+Yv7
         xGVSWHsU8oMPKotCbGx96zIQoJFWzb33lm8fs3BJIs+v2wXkZv9tXxJiW6sNvk9Cr7ca
         aF9Q==
X-Gm-Message-State: AOJu0YxugH8pOsFy2i7dP3mSOqgjEYHv/WxXiiuXw9FANc/yHW72XdzE
	uEgMItw5GRSG2A8jjjTA8iK8PO+mf6HWQuyaV36NYgtlvIIlCPRoIr5CqDKFn/aGkMg=
X-Gm-Gg: ASbGncuiDvtg5QLGGVyZF4TZnw65ix+1YCctlCA72uiwE8OyGmb4mTVzHAeR2Nl5es2
	h/LV96tuXYxhhw/VU9UTW5xc67iA7+uZdXUJe7bhizxcsI19Ahaakk+nasam9yNgbJ49XYKqjmo
	LrfFkZCcNGsUgndUx0+MApKWTKyXMucNU6bzNc9kcNSmB/N5v73BAHKHhhX8Sr21NgBkU8nhb89
	+q69DZeXn2bi2dt+soLcTQFetEjKd3N1vWI/SkI3IkjvXda/x19iA1MS4ug3iEqvsdtahQFpKE6
	QMocHwVyl5GeHI/wrLxrI2hY8ntwvEO4Lza+AzMoR4AUaAr2qrsguaNwM1kRGAeDokqQGwa201s
	T1tzOrscyUUt+bS7XK4tOfzoNd41wmHZuBI3ng8xrGzL/T1LmkemrXyUcHejJp0wg1rcgiwOqOC
	SzVxkYWPMXnm5kivfsXVYYZPme3nvcC/m2if0eZW8Fj1s=
X-Google-Smtp-Source: AGHT+IGK2M2QMmjt0Ltj+ax30YpGqmkyiLmafC7IwyMavI6cGNjRmi8OmQnBBPx18MSOTcJS0+DWug==
X-Received: by 2002:a17:906:9fc1:b0:b41:3c27:e3ca with SMTP id a640c23a62f3a-b6474039b13mr2332953366b.7.1761137420912;
        Wed, 22 Oct 2025 05:50:20 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d3501ed5esm144343666b.70.2025.10.22.05.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 05:50:20 -0700 (PDT)
Message-ID: <f610a76a-c482-4e3d-b652-237261955553@blackwall.org>
Date: Wed, 22 Oct 2025 15:50:19 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 05/15] net: Proxy net_mp_{open,close}_rxq for
 mapped queues
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-6-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-6-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> When a process in a container wants to setup a memory provider, it will
> use the virtual netdev and a mapped rxq, and call net_mp_{open,close}_rxq
> to try and restart the queue. At this point, proxy the queue restart on
> the real rxq in the physical netdev.
> 
> For memory providers (io_uring zero-copy rx and devmem), it causes the
> real rxq in the physical netdev to be filled from a memory provider that
> has DMA mapped memory from a process within a container.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/net/page_pool/memory_provider.h |  4 +-
>  net/core/netdev_rx_queue.c              | 57 +++++++++++++++++--------
>  2 files changed, 41 insertions(+), 20 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


