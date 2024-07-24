Return-Path: <bpf+bounces-35472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A6F93AC02
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 06:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A791C22C29
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 04:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460D136B0D;
	Wed, 24 Jul 2024 04:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mISuk5gp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632A01C2A3
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 04:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721796196; cv=none; b=P4lHELYPFq70HO4dnu91V3rBpJrxNXFuSfVIvuj6AzxTw711vqu+KgBcs+BWNB4kE4g7g0eewIoUPDOmWDQ68kQ0yYHi1vALXAA300u/0PCtTTEtwzy470nHzvRSMT091ZUsltg85hLY8jK8qf+r6uQACgDm9zTQoONj4adYNNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721796196; c=relaxed/simple;
	bh=/LueyWdXZ2SqFhTWTvYAYhphx03rXWobAU519wh8rLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6puBOi4TEdUGBIEDtsKTMisknNPhMTMfv1GLSHuMXzvCkdeiU+rxKXJLo6oc5FVBLYLo25mn+Ew4lvo9uq8iSEnCRZ6FThaad8gKftIYTEC7+iw0pyCaNnm3bhN0aptnslvFId8UmUi51Ehqq4YGKWymqM0jgh3qfKbPer9XVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mISuk5gp; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-643f3130ed1so62626127b3.2
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 21:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721796194; x=1722400994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHM1vjsTPScaivP9rqnmYqBOJzc8xgNnoLrJ41BE6H8=;
        b=mISuk5gphwkhxJx670lecFA8WzQ+L2CYtQcorF6YsFKQWHZKo2Fo34WTRI29TSsc9y
         fXen8BeA3tZWUqrZGXVSoAPUAEtwlQ9ENdDEbCtgJN4oyYb5zs5FKac2TaoKbNHtd/O9
         QXjcpWKv2fDbOaESSRgxNkkU+Gpzwz0kVeLomftFGOPCtugeleiS/Smc68rChshnxtwD
         NjkUPDCBH3DiHLRidezdqzgHJC95YNHJ4YlI4nOptNRbqDVWbgD9E3Gm024OJSHrPqAI
         JAHdDWJn+KxdXz3QXPM5n7KFpFzdzawkq/rgnt37Wk6unWyq6bCp6q/C0C//Q+GT/H8f
         kZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721796194; x=1722400994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHM1vjsTPScaivP9rqnmYqBOJzc8xgNnoLrJ41BE6H8=;
        b=ubBbNBYFKLJwd8vJ++FTHbMzE0tl7tlogZhmz6CNRip0tcUxlElFzPBg682hEw1a3S
         PlOFHSmXuBs1QHRB1VAPkPGY97MFAuHvujfJbU7T4nPZgBLZcj+YZf2fdYGr9nThD9sj
         6v/EnD4HvvHhL/KJAoQcCreVHEK/Cxm46DOI7Dzb0TGuW+ylKg7RexesIqxAzolSN195
         07QTuuoxfX3uZIf5wY+XDejMN0vkBbcvBDrEeYK+ivwLz4CkKewEtUjzFP3iuz2VbpH2
         6fvWWpkIvnAjGzbBP+rIyLBY9Hi7nq4nVulVB5hP+pnyRXmvFZ0pX0OBUbgNGUuXOQzx
         TWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHDX7TCLOlZTA77b2cWRtCSkIHBVaYTi7am12v98kJDbmYrbPqLHMmTyG2m/G9C4DeyLkfhm5PComwmOmYSZg8W447
X-Gm-Message-State: AOJu0YwLQOR5O9SiwzDqO7ICqbiSBVy9tcEcDLCDUKt2DYg9mFiSfdf5
	lY9on/fCPz2W6RJXKPApdEbZK8+WXZmT8QYoNFFh0enr711vYvGQ
X-Google-Smtp-Source: AGHT+IGg2hCN7lpHdZ2nlwxpsgpTPB3m6zl0hnKvcK4x69a2sBvX7X0FJ+pDyXZCY96Rvw3vWyTIrQ==
X-Received: by 2002:a05:690c:1a:b0:617:c578:332c with SMTP id 00721157ae682-6727962c07bmr14885917b3.4.1721796194272;
        Tue, 23 Jul 2024 21:43:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:8343:a788:55dc:60a4? ([2600:1700:6cf8:1240:8343:a788:55dc:60a4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66b7f2ec9f9sm13677787b3.25.2024.07.23.21.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 21:43:13 -0700 (PDT)
Message-ID: <5be6678d-d310-4961-a57c-45b311879017@gmail.com>
Date: Tue, 23 Jul 2024 21:43:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: export btf_find_by_name_kind and bpf_base_func_proto
To: Ming Lei <ming.lei@redhat.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, andrii@kernel.org, drosen@google.com,
 kuifeng@meta.com
Cc: thinker.li@gmail.com, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina <jikos@kernel.org>
References: <20240724031930.2606568-1-ming.lei@redhat.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240724031930.2606568-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/23/24 20:19, Ming Lei wrote:
> Export btf_find_by_name_kind and bpf_base_func_proto, so that kernel
> module can use them.
> 
> Almost all existed struct_ops users(hid, sched_ext, ...) need the two APIs.
> 
> Without this change, hid-bpf can't be built as module.

Could you give me more context?
Give me a link of an example code or something?
Or explain the use case?

Thanks!

> 
> Cc: Benjamin Tissoires <bentiss@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   kernel/bpf/btf.c     | 1 +
>   kernel/bpf/helpers.c | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index d5019c4454d6..fdc4c0c1829d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -567,6 +567,7 @@ s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
>   
>   	return -ENOENT;
>   }
> +EXPORT_SYMBOL_GPL(btf_find_by_name_kind);
>   
>   s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
>   {
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b5f0adae8293..18d1a76f96d2 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2033,6 +2033,7 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		return NULL;
>   	}
>   }
> +EXPORT_SYMBOL_GPL(bpf_base_func_proto);
>   
>   void bpf_list_head_free(const struct btf_field *field, void *list_head,
>   			struct bpf_spin_lock *spin_lock)

