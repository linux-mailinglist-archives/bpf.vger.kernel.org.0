Return-Path: <bpf+bounces-55377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53306A7D229
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 04:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 138957A1BB5
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 02:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B188A211A24;
	Mon,  7 Apr 2025 02:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX/CSUl6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE322C9A;
	Mon,  7 Apr 2025 02:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743992871; cv=none; b=Q3NJbjBrY1ovsn7aypQ2XjzpM4GAPWvSq5H+SW4wMHKhQQxgL4GLXocPc1Pj0LfsU/MMGKqY2IkC0bPsBL4k3RRPxfPdhLrywv0qQusmQ1PRxqKgCt7odHQnGZANlw8N2DpzC3YcBw9dFjiFdiMF2I8neiAybH5uyBJVcgcwvUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743992871; c=relaxed/simple;
	bh=lBAsK4128QqAndyQK1xQuEI3avTd269+XLXJMVQegYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fc9P0McQNemAAqhv0LC1esqGlzwC/agkRZTzXlu7eVsD1MF10N6aC6zgDoxI1BCEyBeddZwKaCjBf4rinYJslbIEQyfAcimz9l5Jkz8waJ3F74ecQiNGWS45uT1IwTDEgY1UZ135/V7GJyL68sfheInnngAS+F27G6dKjQgASmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX/CSUl6; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3031354f134so2823930a91.3;
        Sun, 06 Apr 2025 19:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743992869; x=1744597669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZMXI96KY1NlyfuaSnxUqUHlO9ydv3v+nJJ7C8/Y0/PY=;
        b=gX/CSUl6n0Z4UEA/2mk2BnlXdD4MJkYdKhiSU6DiHNh66zSoHTrOgjZLRp0mHvtuaH
         qhtgYOI5pgVxGFtl4h3Gcjq+EzAfsy+qNQXzyC5LDeWhB0IR9hLz1xYNRkQsMXTXaJaZ
         SgBs69U7/HW1Jq2nma0cgPySoR2ng+yHQjQqRdcSQlPMHy5fRUOeE0tcFw28h+RiQm/U
         5GrV5X4yhKdg1DsUoU/PoYyzsQLMwxC6sJX6zCzW5nzA8Igd78WNRypM/8HWcwPZgsfs
         pRy/zjfeIyLlIgL7+KfkyNd8Vo+hCQXZd6Tfg/A5x8R63VBk/FCl8Ruyn3gix7APVDvz
         fPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743992869; x=1744597669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMXI96KY1NlyfuaSnxUqUHlO9ydv3v+nJJ7C8/Y0/PY=;
        b=HZk2Xtwu/LOJR+VkKU3FJJ7LILXfz95Q16doS0iGagv31GKeQ7Fjt98jIUgsRDgc7j
         XU57Q4Y9AQiZjD0JEWZN9oyuE8SlKHyE9kNtwofnPJvoE5TxYixI/Q1w0n8wR2xnh/X7
         isit0mHI8R8GJKDACgubevQuhfhgTKFyr55s9V9XSi/P+o+dbpkvMC75b33eNQ8rpdJg
         cG5QmMySUnn73kT/BsqDGiwUC8wV1cWdx7eB67sACXlTfUWOHah8n3KhRiIJZsTnaPDI
         kO1tbHA3K1vbvaFEzbTmtlLs8baCQIWisEuN/CLV564lxtbLCYnO14LGeNds8gnKjyBC
         jpjg==
X-Forwarded-Encrypted: i=1; AJvYcCV4qdSzFv1Ya9HPjy6Dg8FK6Cty//BYDa9FKA+L0lWKCf+97X19zgI5IIvCioYyAkjOIxXqCvEC@vger.kernel.org, AJvYcCXLgvVDENkrsIzjPgQUpdnt4QzCuXjiVDq+8EH7jW31Zfm9oKSOo3FEcdWJD81w6UfFe/ym5RMMgXFSnSLY@vger.kernel.org, AJvYcCXLjF+vFxpiJrjlZHcNYpjN3A0OLORQkhdHuZpujrOTKztKKvU/EHP8oMeX4gk9WV4bshc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm4F65bthLblNM2A/Yefi8UGrcwTm4h1hRVKaYszv1Sb6BSvKd
	f2DWHuABrG93HBunSHpmIH+CqIshcKxL6cxmssSlr+sRAZDJIbTi
X-Gm-Gg: ASbGncui30tA6waPepwB5miD357KK5BY24/KqiOXCb/s8eCT8o4WU0ShiCxDax5E3DI
	IG5Dx6fR/xbQOTLi/sE8PeBusbs+l25poHDTrKSipqAge20yLzZ2SDHeCRMJKzE+EQSzPJJxJPV
	mCK/3NWJbEW8/0amx1oZLZTnLHwcFsZJlgcV8ufKPVBu/4EYic/hg2B0Cx2odL5M/ZYBMjA73Md
	y2eexDWz3TNeTEsm3/TVAQr1xabNmXNv2fLYolUOQBKUuTsCT1Tl9NlKcdQjIYwyTPTFGFviVST
	mBsDWfq9JqUCqeokHVemXboCdm11aG1sXZBNUKb3AxQZkBTOs8AcjoJrEMkckHCKUvnGkod+Dah
	naLEQQ+tFKJAoDDrUyDcqLqU=
X-Google-Smtp-Source: AGHT+IFLx8dLNxCZzv12MywXhBO0lTHHnKGTceaSSuaAjzKfGMQlupPZA3H1O36DYRXf2E9QaW3B+w==
X-Received: by 2002:a17:90b:2552:b0:305:5f32:d9f5 with SMTP id 98e67ed59e1d1-306a60eddc1mr15700652a91.7.1743992869012;
        Sun, 06 Apr 2025 19:27:49 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:cbc1:cad1:513d:e384? ([2001:ee0:4f0e:fb30:cbc1:cad1:513d:e384])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3058494aa8csm7608800a91.16.2025.04.06.19.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Apr 2025 19:27:48 -0700 (PDT)
Message-ID: <30419bd6-13b1-4426-9f93-b38b66ef7c3a@gmail.com>
Date: Mon, 7 Apr 2025 09:27:41 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: disable delayed refill when pausing rx
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20250404093903.37416-1-minhquangbui99@gmail.com>
 <1743987836.9938157-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <1743987836.9938157-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/25 08:03, Xuan Zhuo wrote:
> On Fri,  4 Apr 2025 16:39:03 +0700, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
>> napi_disable() on the receive queue's napi. In delayed refill_work, it
>> also calls napi_disable() on the receive queue's napi. This can leads to
>> deadlock when napi_disable() is called on an already disabled napi. This
>> scenario can be reproducible by binding a XDP socket to virtio-net
>> interface without setting up the fill ring. As a result, try_fill_recv
>> will fail until the fill ring is set up and refill_work is scheduled.
>
> So, what is the problem? The refill_work is waiting? As I know, that thread
> will sleep some time, so the cpu can do other work.

When napi_disable is called on an already disabled napi, it will sleep 
in napi_disable_locked while still holding the netdev_lock. As a result, 
later napi_enable gets stuck too as it cannot acquire the netdev_lock. 
This leads to refill_work and the pause-then-resume tx are stuck altogether.

Thanks,
Quang Minh.

