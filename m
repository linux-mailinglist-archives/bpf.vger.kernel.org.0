Return-Path: <bpf+bounces-53409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C5FA50DEF
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18ECC167B51
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 21:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96C225D1EA;
	Wed,  5 Mar 2025 21:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2fI1x6C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAE925C6F5
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211022; cv=none; b=jmqehe24iaEM9lb2RF8HkHMlpsUc7n3nZtc9rAPm9rnvsPH48laRwgVeV4fyzB+iRLR/0cYcwwwyiTXKG8gKdTX1ccVxtn2450oiGTKfNtLSNTpf8s/Qlr3O499AZnPVG0cs2GUBt+dIUwbf36nXFc4N+KImfRVmMxl6jdFQ0V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211022; c=relaxed/simple;
	bh=DZpq57oIlZ33n+TuMcNKWFIPKGJPQcIN9DPL/aVqHEI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i78iMZ/MvmHRM2Vx3tCxKVk4K5Vj7p3V662nWzqdxk83NMwCfPYSKGXyjE0CBNhx71CBxO4rWzvNcnYg1UkqEBH3UTECJvq0yK0QUySiNiMZPfVTi0OQ0CrAQfGd46RJSRvGABvYjxTtBLPW3mLaWghwoUeL7kIziy4GtFH9MUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2fI1x6C; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22359001f1aso169072495ad.3
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 13:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741211020; x=1741815820; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B46iIpprjukpCIigB6dCIcwBBOBkECIs9+H8f0b/D9Y=;
        b=c2fI1x6CYEHzFblCiFrVWrf+mTiNuMXeB9PsF12Ko5PFL8Dd14OJArgPA8dYmRzA4/
         AZUcR93zg/UmB1jT+kc05eed+FO8Vef1OU95EXW/aPXDOLKa8t8RV9NuRmKxNJQI23CU
         yRxfUtSSryBP9001VadgAfZgMv3cHol2cDBTKiG16vFZVk3E/jYCneYJj5j6FTTDlltp
         2rpfFB7Wsp2HFFA7OPjT5Vr1C6QrKKBDc1h0bwtWWAQwIb6XJ+L2bS8uqSMB1DcW0lxD
         2GH6u5i39r4qkBqULriizsBaXSNQigDcD2xwuiJi1HetzFCnWwDhDKAuN66xxQ8T2rK0
         5TvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741211020; x=1741815820;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B46iIpprjukpCIigB6dCIcwBBOBkECIs9+H8f0b/D9Y=;
        b=AVmqZd4PRotGy2UfPMLRRnPtjN1LSJimmx/K4W/CmxgC0ynZktNkSDHibE8iF3QIGx
         eEmxLLPIx6S0xxAJnMcKqtRH1T5sahHDS1kv5U6E4ePouEQFSTlT794Bn8JTOKYgz47L
         RH98dJz+NA2OPqgP79aiT2JIm8tf+hQ2R4DnggCooQ1MxPCSzQhpYU6AdJccriAFH3CY
         Kse75M8HfIzE1VycfZlRSsjSZHS5Og0rkBA1KLpTv+xu6irXQBvasxwoHc6ymPowt99e
         D4ZT1MMcEQikfl96mQm09vOsKU8mmJF3FIJWP/yFvO031y+XHnFZa+wofjGpQJho69Of
         dGvg==
X-Forwarded-Encrypted: i=1; AJvYcCW3/vv3BOIzgEYYddInDEPdmRkgkFCorZW32twmlkM2OIBntM9Lkji166V148RKSaeSeW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRei6WrOz4Ynw5ahRE7D3jaCkONG5RZCqoD41/Jg+7tu3M27KN
	EN/A7lq4DulNJeDWKlKjj+CLmBRVZUG5XWqk4BGOltFkkpnRqKRP
X-Gm-Gg: ASbGncv/P6tUptM0zRAX0rBa7BIUchN4NkpZ/z4RDYGABZhHbdbLQODq5gHG9QnapTl
	vzdWqlDR3Lm3V811d+D2QcYrf4wLEiTnfTZZEXcONBEuan/f//wyrxqQLoK8I80DuxIMTxICJrV
	NU8QvdXDz9xuVp1sBHmJ+pSLQ6OI3FinZlH6JPo8VXUQxiXw8gKkpk6Fgj86Pq//RhIVslp23+y
	sipFBdhVAw45I/eGEwynHzyNumUWYphCkq/dJI2X9a1QqkSSQFyvSiNo/nKcnBCMLi86QMMaCey
	Y+MEFic4sMI4HS543/igPF+xYGyx2jtFjQMsu1+Xbg==
X-Google-Smtp-Source: AGHT+IFECjgLW1jYbAj8X6rWSg2nD1J2/JTHN6Av7XMAwA9bp43ia45a1xlUAW5ELbq+E1K89aVTUA==
X-Received: by 2002:a17:903:2f8d:b0:223:6180:1bea with SMTP id d9443c01a7336-223f1d212bamr78014935ad.37.1741211018965;
        Wed, 05 Mar 2025 13:43:38 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f9e3bsm117828425ad.82.2025.03.05.13.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:43:38 -0800 (PST)
Message-ID: <317f9cbed81d6178b167efbc796ed1fc1bfa07a6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: Fix dangling stdout seen
 by traffic monitor thread
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Date: Wed, 05 Mar 2025 13:43:35 -0800
In-Reply-To: <20250305182057.2802606-3-ameryhung@gmail.com>
References: <20250305182057.2802606-1-ameryhung@gmail.com>
	 <20250305182057.2802606-3-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-03-05 at 10:20 -0800, Amery Hung wrote:
> Traffic monitor thread may see dangling stdout as the main thread closes
> and reassigns stdout without protection. This happens when the main threa=
d
> finishes one subtest and moves to another one in the same netns_new()
> scope.
>=20
> The issue can be reproduced by running test_progs repeatedly with traffic
> monitor enabled:
>=20
> for ((i=3D1;i<=3D100;i++)); do
>    ./test_progs -a flow_dissector_skb* -m '*'
> done
>=20
> For restoring stdout in crash_handler(), since it does not really care
> about closing stdout, simlpy flush stdout and restore it to the original
> one.
>=20
> Then, Fix the issue by consolidating stdio_restore_cleanup() and
> stdio_restore(), and protecting the use/close/assignment of stdout with
> a lock. The locking in the main thread is always performed regradless of
> whether traffic monitor is running or not for simplicity. It won't have
> any side-effect.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


