Return-Path: <bpf+bounces-59399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7FBAC98A0
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 02:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DADCA1BA45E1
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 00:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1899B8479;
	Sat, 31 May 2025 00:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmMIt2fA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368A86FBF
	for <bpf@vger.kernel.org>; Sat, 31 May 2025 00:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748651099; cv=none; b=gLrdyzGbcZVPztZsEdhazUwmouO6PFjtnn9g7Db8NWoPNGHjP3/CYvPuaH8D7RxOx4UX8Blpj5lVf6pqpxRSmPpy5MF6qKZT/YgYKWNTCFK9rNy732qJSaFtjnuPQ5KT58RAU9xmFDvrJ+ryIHRlKw2Es5N+nLBqGAwNm1EuSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748651099; c=relaxed/simple;
	bh=+RM3BqbkOYJrOsYEn6ur/zP/Hv3r9BVp5TrINXCX0nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dhj5IQ32iFa/fh0vQ1nkXJngogdL8Vi6joHdoS/wvHhhEnKiukoB+CG6OrmTK+C6op5CXRb4X9t2DzxbZjuzJYv99CztoqaIjIvd10A/zOu+irWqr4yrHVy1PK8y1SLhxpsPYWX3z99T0CYWGUaaRgHm0AN4iqSVZX30Yf5FdQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmMIt2fA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22e033a3a07so35979435ad.0
        for <bpf@vger.kernel.org>; Fri, 30 May 2025 17:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748651097; x=1749255897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UYshLYZNdCyzvY1WL0ou6uEaltusNid9PQYoWYIfmYs=;
        b=XmMIt2fAPAKSyXpC7sGV/ieAQSVIpN8z2h4SX+CSEMI6XHXmFICwzbsXRMrsJzs/LH
         OlsEBh34YKjEpeu22yILVjfVAK0ZFHN2ZHSGTHAGTpxAdAPPyUEYRHyIjqLOR3QxBVB7
         ayrv2kaGPk19N4xo4gnz3nuQOooX+VP8vLvlkcdCd2hFp0MSrDGXhpjGil6gwCFpI6P/
         dATWjkK9dHHNTF+vVmyq6MkW63necCZAg+RvVHr83FTC4aWcq7elKuRjRf0PeZjZlqBU
         F0nsVRL7fYi3XrBRWywput1tTayzw5NhDRGA3eCZvrDGC2nlomnZCVd2Lt5FcdCNv0WR
         nRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748651097; x=1749255897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYshLYZNdCyzvY1WL0ou6uEaltusNid9PQYoWYIfmYs=;
        b=AX3LwVwtNPboRXqTJksW8TGFlP7SQugPi8NFAm0nfpAqm9GQh+9PWn5JllJEfAR11l
         +ltAeETLvjiz1Y4tTaBX2326U6yf6zJEGdCkS7hID4KbT8yUAC4XxXId1SgTBSOvwKgR
         ymtQIBqVZw9SCmLQ30fLkypj/ZKBfUt0jvTvK1xEvznwOeEzCZYAmZQzFEgs6oyJa1Nq
         APuGnvAUz7pBLkCFM3g0etJHwcar5veaRonPbmuYQjgx6OEh1tWQ1/EucjHks5apkVCq
         6rPpVmm9Arg/ujxqSmaCIliaXVZY555jS7J7Bxe4s5DoeF0ghCtvZTrrShxC/Zkio+7k
         p4Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXKIMSee7teKNMqyK8KNhAn/Z8OdQNIf4e/9oysdqmJkK/B8BSJ0V+tIn4MJHb6ji75nSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyj7P3agnkSKmu6XW3Hzng+bp/G3FVz3EA4aEjJWa6t0NyZaBR
	VRWxY0kMhJH2BEunSf1gufKSB6GbV7btpQyWc4sgSWlEp5ZKiRK69+AB
X-Gm-Gg: ASbGncttDH+fpqC2HVqa3O2NmZPnxGmf0F4k0iZJt6/4AFKgzs7M2ccisVgPI7Zwrjy
	aM/2c4/DW2LCAHC/045JBKeh1EKMKrOB/FOKE3KbWKD2+KVTFiEeevqZ09Ak3ot2OaUP30FKhwf
	8btHMZEoZmy9zI/S5dGTL4g8aw6fG+IlmdjasV1UShOBA41IlqGbtVCCE9HPVh5rj51ENrAeIo0
	cewFhjOA4ANsO49AoOEj6xswrVsi6V/kMUr0GcFEfiJmXAJXLp/jORse9zWAw/a14/D7ALkv5AU
	iidZjeG9QjZIycmTxaly1yVkomb/43PgRQI9kb1fnN9pOgk+vshQ7cr0mQmV/JuyHqR6/vvTRdg
	Kg/vQJjRwM9EMMZ4bdf8vpywopcoN+1g=
X-Google-Smtp-Source: AGHT+IFsz4hFI848hu4zMOCG3aH0A9+EBpFQTMHuQeXoI/PTRFCjcWbYL0cEW3YAQEfdyf16KqLAxQ==
X-Received: by 2002:a17:902:74c6:b0:234:a44c:18d with SMTP id d9443c01a7336-235290e435emr72673885ad.22.1748651097394;
        Fri, 30 May 2025 17:24:57 -0700 (PDT)
Received: from [192.168.2.10] (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2355c58ecbfsm1008015ad.17.2025.05.30.17.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 17:24:56 -0700 (PDT)
Message-ID: <f5ce8d33-23a7-408b-a18a-db75ee56d9d5@gmail.com>
Date: Fri, 30 May 2025 17:24:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix selftest
 btf_tag/btf_type_tag_percpu_vmlinux_helper failure
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20250529201151.1787575-1-yonghong.song@linux.dev>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <20250529201151.1787575-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/25 1:11 PM, Yonghong Song wrote:
> Ihor Solodrai reported selftest 'btf_tag/btf_type_tag_percpu_vmlinux_helper'
> failure ([1]) during 6.16 merge window. The failure log:
> 
>    ...
>    7: (15) if r0 == 0x0 goto pc+1        ; R0=ptr_css_rstat_cpu()
>    ; *(volatile int *)rstat; @ btf_type_tag_percpu.c:68
>    8: (61) r1 = *(u32 *)(r0 +0)
>    cannot access ptr member updated_children with moff 0 in struct css_rstat_cpu with off 0 size 4
> 
> Two changes are needed. First, 'struct cgroup_rstat_cpu' needs to be
> replaced with 'struct css_rstat_cpu' to be consistent with new data
> structure. Second, layout of 'css_rstat_cpu' is changed compared
> to 'cgroup_rstat_cpu'. The first member becomes a pointer so
> the bpf prog needs to do 8-byte load instead of 4-byte load.
> 
>    [1] https://lore.kernel.org/bpf/6f688f2e-7d26-423a-9029-d1b1ef1c938a@linux.dev/
> 
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: JP Kobryn <inwardvessel@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: JP Kobryn <inwardvessel@gmail.com>


