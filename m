Return-Path: <bpf+bounces-59715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B87ACEDD4
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 12:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49DB33AB73D
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 10:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EB3214A79;
	Thu,  5 Jun 2025 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZ8ogUey"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BEE204098;
	Thu,  5 Jun 2025 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119903; cv=none; b=hlKlQzhwx74fZSu5Roz9sJZZokLrEDjSo2KstPi9q/EMmuS5wcdTnu2/A3vSYanb3OH7A9UtulasFyZWnOL/w8QZu+FAEIb0iCfRX+CjyJ8TImlYTUlzlo77O8DOiHQY8sI3C5NNROjFJ24RhFJE76a8EINZ5VXbOtuqvmXLvZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119903; c=relaxed/simple;
	bh=bfRjnsuICz1RBo9mLvF/gDjDomrofY/FmmnDYuUULVo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GXOihr/hoab3xrra8h99dKGaLmGPYhww4VjO4VabJA0uG14aa00vSjPJi2gDvQF6tVQP6iv2U87N3CivWmrtrkHySFkxfbMxPPsWzoT1S98zCL4kELqmaJdvviMgJ8yj24ZGcWGkKtYBGqKwY/XulAFPmTTyEk9rRCFvS0s04+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZ8ogUey; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad574992fcaso134724566b.1;
        Thu, 05 Jun 2025 03:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749119899; x=1749724699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g1mQV2GX4SFqvH9eeb9tY7RL+iprLrEQ6gUJTtclCgA=;
        b=AZ8ogUey7UIfkDNr0ftgR41dEhSb0ZfPkHiXmeof15d3pOWaS6cvCnYNijPPQA2G6X
         db21fyoaCMrm61K2Vah/Xtwj9xjvy95Qir32QXcjf4BR/ggydhVH1HLtjs6DNEiKrblV
         wzrqUIWhD75djucEaCwcZJeJTCk7nhgKPw/lk+bF6z+K716bHB6wMVAK1dooLdt+EicE
         H+Soy8mb60FW4GL+s3dkrQa+WvjkqILuLTMkXRpXcTw0iOhC6hdtiMh5yusz8ir7ZoRE
         BaZkEH/0zehXANGJF2Yl0pQwGQsGtQcYVY4XTXU1Tuql/zziHF1uyBlA+5UrDHJkxngF
         X0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749119899; x=1749724699;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1mQV2GX4SFqvH9eeb9tY7RL+iprLrEQ6gUJTtclCgA=;
        b=tBF3okAUKMA3dgIHvh9Q36h8g8hymAVumpadHa8lq8bMCy4IZyxxCGj/mt3Nw8N3pL
         7oKuT4LajivfVK88A/qszbs63P9a0yDebpj/ZeVESlWprtW09kYPW3jQyNWwSeeHHETp
         /1XovvM2UtF2EJCeYPCi2TnhznrqQmuffHynKHcJ4cGa/448WldIX5qBGjBTPpo0oMDd
         WMHNwfvFwUNQwuQBZ/Vv52mEIMd+YTjDysBri8+DF+HzjSviZAJB6Y1rUlrghkpOmk12
         rM63tmKnicSSTR8jL+wjP0bzBQU4f60lkdPBl7Y9uIMftmYPKyVfgrL0qiFrOGBv7wyO
         PDIQ==
X-Forwarded-Encrypted: i=1; AJvYcCURMrMTbrobc9vzCJ3jRj8HCTffy6Y1plJ5KHdWtW8L51DyDt2AQGBeZdrM8BxVIs1PxNuwB9HD@vger.kernel.org, AJvYcCVs1Ve8nQDGdTz8KV/P9zYLHPMvn/ci+MwbQT0qfP2vcdNBCgdhDA37giqnX3g4zUG9n9k=@vger.kernel.org, AJvYcCXbF//naUY3KY6Hmqxaj8Y7y5Ry+tZ5UXVaYjjRSswGCZASs+48VjEbLsS3Jez6bUzM9nY5bh22w4tk5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOzhitkfLRSxbuUyPbizhBjPEQ19Exev5aoIN/DekiQyMaF7J2
	Aig1L1SkGfXFHh9U+BeRTDCWv5z1Gj1s4OJ4CTtexvrSYC4iXW0Nb6iu
X-Gm-Gg: ASbGncvd/gyt/cg/Ks6/v+go88VI0OZgAs6QqKYorGQQZe6+a0BX8Sw5kdeZXBXtqiR
	MLKDaPsc2BHBQPso/vSSt89xgzzg+CdLxqFHvcDXzDnUeYYLvqTD2OcKorp+dk235iaKFQif8mL
	1p0h/ZYWKhgA9xLCEPDAs03lLsmBiOvFmC/xqdveO2D4hhnUEGIi03TdbJoaxL6JP0BuVmbA8+x
	Ly3aVpjGRyb1sEhDe0BdNJfrhRxsb/0bpgJfy39oYd7jgRsZDVszQLn7hmttgvXLCR5ibyvP7yK
	0tFR0MwtLnPo6i3Y/wHyd7J9Lc/0Vq4afgYMgS/FHHrIEVpkLIntCNRE/eIFyhHt
X-Google-Smtp-Source: AGHT+IGxYXG/SuapgXvdgueyn0PUoyYCKu9UE6yrqyyrqY+UM08cN7TL9mVC4MtQyEfeOVk3Ug7Spw==
X-Received: by 2002:a17:907:9689:b0:add:ed0d:a583 with SMTP id a640c23a62f3a-addf8cd14a6mr642809566b.19.1749119898645;
        Thu, 05 Jun 2025 03:38:18 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::22f? ([2620:10d:c092:600::1:d66f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb390f09c8sm986936566b.45.2025.06.05.03.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:38:17 -0700 (PDT)
Message-ID: <78cc50c9-052b-446f-bd27-9eea73386e60@gmail.com>
Date: Thu, 5 Jun 2025 11:39:36 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 09/18] page_pool: rename __page_pool_put_page() to
 __page_pool_put_netmem()
From: Pavel Begunkov <asml.silence@gmail.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-10-byungchul@sk.com>
 <fc705cd6-ad20-4f1a-bdaf-d3046f062d20@gmail.com>
Content-Language: en-US
In-Reply-To: <fc705cd6-ad20-4f1a-bdaf-d3046f062d20@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/25 11:35, Pavel Begunkov wrote:
> On 6/4/25 03:52, Byungchul Park wrote:
>> Now that __page_pool_put_page() puts netmem, not struct page, rename it
>> to __page_pool_put_netmem() to reflect what it does.
> 
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

Actually, the function is for non-mp struct pages only, would make
sense to use struct page instead. I'd even argue that it's better
to change the argument to struct page *.

-- 
Pavel Begunkov


