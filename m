Return-Path: <bpf+bounces-56655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A74BA9BBE0
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 02:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924A21BA5F9E
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 00:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBB519BBC;
	Fri, 25 Apr 2025 00:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTqSdbT1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF85C3595B
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745541083; cv=none; b=sjIRham6VFPhFC18knkZ5XEquiOQ2cm4r03COiAlexjj74hl5SBIXVohciMeT8wmaG9+caf6Z7LNcr1W0L0KB176frSwL4GfT8esg5Bq/YTrA/aKfqCmiaN7k/NZkLPDkMbR790RSMvCx9qorbHjg/u1EzLQqhK2lp5UE2eViUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745541083; c=relaxed/simple;
	bh=dWU6Qze0uF7WO13VitlqlYvn4iOM7KI9Q9KIXMi0QYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urIaa9E49pNfFg3VtEp2XNNbVBmiqDIEsFb6q4o6jGj1T1fot8lidixH4XUdkbS8xFbn767qxO6r80oqmZXJE/4opCusDu6wIYucM4RWd8ey31djMqeJ0qNSXEv1874MWrHutpNbKrtHgZhZl3YxRrCRM9ao6UA0tD8gz22dN6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTqSdbT1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39d83782ef6so2001934f8f.0
        for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 17:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745541080; x=1746145880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nLCvCwPElFYap+SeDIvREcmSk4nWLNu2Do0GhX2bHbM=;
        b=gTqSdbT1/EzEFNSa6E+8ZuGRdHoAS79ltORyqHyCS3+k6bKyJ8IcWG9N7Bxit3Tvtp
         Utm3QDh3HLiLz1o8u0cKCBAIxSWv//kDKa6olzuvtqgzD9ubTrSU+BkarKTSUAb0dHZT
         LkmrUcdQBc5S50paQ65krhGOpUosQCsTn17MI323J6UtaBFlgPxCZXiZBaox0zFk6mek
         brIrE1WPAvyEeC7Nc8ek7ZoQCkPh4164YWnIYnqHA6KYG2Cyml1wuCFX0ofN8WTJZZXo
         V609O3Bw3aP78Q9iqYLvoaoCWb/EiB/E8cBmxFwPK0jMVwhq/6iNJ9W+j3FxeE9ANnpC
         qZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745541080; x=1746145880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLCvCwPElFYap+SeDIvREcmSk4nWLNu2Do0GhX2bHbM=;
        b=RNhvxy5LexAHL/Zi9q7kjR5yjR6kILIagt36GUkyB/KInp6BO8BJXKEHBk1hFCeL60
         yH+wyD3fPwwbcq3S8lA08LRUuXmy0XXK2oWFsyDX+005GZ5Oe71/S6nOUXiIDJAOWF2+
         Xzzz1X/ywe3eyXQJRqyfh8ugl9rQwVwlnYGSYL2ymprdzwi+oVJlGe+O6cUgqoY2HqGR
         ZhUIOcvHWT5tQEa2Oim0MXwInB6AWbvAIAk2KmBrS1wnq5amKmNtTExRZsaOgTfR9EkW
         yAeAQ3ckajRe2rzo6UBt8/JAMnJyg8hGBmNiADgg/Lvb7vL3/fklCMt/nyAG+MJ64Azp
         bV9w==
X-Forwarded-Encrypted: i=1; AJvYcCVV6zPfwTfDVhoNAC1vmXa72N3xKZdzEnpYfy4lXroxYaNB93xCix703w7tFtgPqxsCrK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzodOrA9ZpoxRum63pioPNmUcuMRPgAI2XmAu7xF+2RzTP+b6o9
	pfBCh0gdPvKmgYu54/lxr6Q8+O4I8WdBDHhGC0lk9CH93pbxANGg
X-Gm-Gg: ASbGncvCDxZu+reTzbx8H/XTXqZpyB2fjklZ1WBisKyRifgd47Vjl0TsuyzJ02y8ceG
	MHDBOwnJEWnEKduMZR1czV01NX+zK0LSx0D8GH577g5siuv36s1wutHAquOupBWxZ9bbtzhs80O
	03pTfigp2DMe4gS9fizd5WX6FgsOpl2CDbgSa9IAd1atfeoBw6buULu/bPadwhWzHzy3x8XE6Lw
	4z5USeX96NZTu0dcSNljQvCorIM3rmmEATCRHG2jkPL+iuRlDPZczv5AMq0yhCZbnLfcChhk+zi
	L8gX9an+DSBPXD3BwQFz6xLbOK8Hou8N8qf2ctmjI8qxchVxU3Alx3iy1Px7fg62jMzDuzuL+2j
	i59wMzAwyy/2zz2qRxLfoRA==
X-Google-Smtp-Source: AGHT+IHRU4ATvkkY+W4bsYGliznxpSTsjGnYEBXg79bra4UnVQHzhWXv4WS2QeYZLJ6aDT5H9caWqA==
X-Received: by 2002:a05:6000:2483:b0:39f:cfc:d520 with SMTP id ffacd0b85a97d-3a074d07b3dmr125778f8f.15.1745541079892;
        Thu, 24 Apr 2025 17:31:19 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10? ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073cb2acbsm741577f8f.40.2025.04.24.17.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 17:31:19 -0700 (PDT)
Message-ID: <55eb79ff-4020-40ba-b690-756ab746ade7@gmail.com>
Date: Fri, 25 Apr 2025 01:31:17 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] Use thread-safe function pointer in libbpf_print
To: ">" <jonathan.wiepert@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Mykyta Yatsenko
 <yatsenko@meta.com>, Yonghong Song <yonghong.song@linux.dev>,
 Jordan Rome <linux@jordanrome.com>, Jiri Olsa <jolsa@kernel.org>,
 Kernel Team <kernel-team@fb.com>
References: <20250424221457.793068-1-jonathan.wiepert@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250424221457.793068-1-jonathan.wiepert@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/25 23:14, > wrote:
> From: Jonathan Wiepert <jonathan.wiepert@gmail.com>
>
> This patch fixes a thread safety bug where libbpf_print uses the
> global variable storing the print function pointer rather than the local
> variable that had the print function set via __atomic_load_n.
>
> Signed-off-by: Jonathan Wiepert <jonathan.wiepert@gmail.com>
> ---
>   tools/lib/bpf/libbpf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 56250b5ac5b0..ea97a84460cd 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -284,7 +284,7 @@ void libbpf_print(enum libbpf_print_level level, const char *format, ...)
>   	old_errno = errno;
>   
>   	va_start(args, format);
> -	__libbpf_pr(level, format, args);
> +	print_fn(level, format, args);
>   	va_end(args);
>   
>   	errno = old_errno;
Acked-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>

