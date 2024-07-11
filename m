Return-Path: <bpf+bounces-34600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3946A92F11F
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 23:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1B2DB20C86
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 21:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62E419FA74;
	Thu, 11 Jul 2024 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwtd2Bs5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32F116EB4E
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720733387; cv=none; b=mf6AHPbhc/iPxWfKFy1UCLjFk21UKUtAKXxmTp8w7l9gxijJK2OG1w24IBZ3U8Xn+HWNFjRoylacGpE4/eNtTNGLxqgSAaER9Mna8Mv5WoN+iJGAeGPNQwmTS+/tjaW5sGaRykZwyL13tRS+/gqKVAa8gWc6NeEUMVkHaEZ/Zq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720733387; c=relaxed/simple;
	bh=jMZTV98l0vlii+EH1GZrvMLJY/b1U2ERU+NjvxSm5Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgA1fXFI7VaR6SO2TQCQo6bqhEsBjp1ES/F0DMWHBqlmVCfBozWMiJBZMydhhB7AfkmYyFz8CblVAsAxKz2wQ2/UVbW32Vh2oG1/fVbpTHpcN3h9sSmAqG0ehiwLmPiu6XoQb9hH2ZQGfTdMlN1WPVtuE1Uwij2IU9T5KHrzan0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwtd2Bs5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77c7d3e8bcso184007666b.1
        for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 14:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720733384; x=1721338184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwG3wctrW6rhnnxSwv3x1h047W+BENiOjIbD95bwLAQ=;
        b=bwtd2Bs57K1dek8ywT4VTem8fb36mJfvp7ps508did9wDswKCMh0nQVUpcQxIVPhb5
         1l0jSnKgZFoLDRXU+2by+9UEEJZjdbphYYqTEH/cdK8R2wubtrRSrpVRREpLUbupu6o8
         EF+DG23APLMi+kBGlzi2FThqaPR3CLK9tUt+uh2WB1RwRLfjoL9ZSkxol+GtZe9jY6Cy
         mRrOL0eMKyUdCb4MZDDT4jd5TqAg8XV32dcsBcFw5M2/396fMIrI17jnwiT95xd4kiKN
         Uh9xhRvKb7ELHxe3TF22MK90SObSGCWCRuRseorgEeM6W6azOWJJuJEyfkKpJrvxJRhN
         ZgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720733384; x=1721338184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwG3wctrW6rhnnxSwv3x1h047W+BENiOjIbD95bwLAQ=;
        b=aymxrnvhbXwwev2cPYsEHPx0YQrVUPdEHicAsdmCG+1CMEiXFFJh9pR3wGMWob+AnI
         F4vsNxMEeAblStN6xL/mPxM0J5oXwQ2FRX1thU3I0p4NvPXgPdPqMtVmPpqpQ25tJKab
         iDxUo9K7so25M1+WnS2GW0G3shF2KVBiw7f24I0YZUT0hLOILrJ4JQlsSE+dzgLUxIGs
         pSyQgXFIdc0uv5rI4xL34vD9feJJAiSGiLwktpDlPaeygp+aJHp87Ks5JdXB2Gli/Yu7
         d9DXWU5n7aGdW60CUwVAkVvMQg9hoCNsKzpjOa2UVttnrVZC4PhTpDacX9Z6EzEbLAGJ
         ICng==
X-Forwarded-Encrypted: i=1; AJvYcCU2gBiKYLEhV4qfks3QmwCh8fVGAvNnCjgH/9lp8T+235OJrbN9Hqe/c1vxUQUlWc0VPBwM+Bw1jXdeiHfoIHvakpvj
X-Gm-Message-State: AOJu0Yxme0HxNX/ngLV7V2QscV5z2KHlLCIrLcgy9JJAZf3Kcme7hqgp
	2cLrJtt/Hx0S3KZdITwXT3lr65il1wgx7aNPpJKR34jCrGLeSvsz
X-Google-Smtp-Source: AGHT+IER7puTkZ38JZhHan8oU7mkPg8UWF0Pipxs1u/TUVvYj0U3BG5Yv88QrDk4wR+niV0R6vE3Kg==
X-Received: by 2002:a17:907:6d26:b0:a77:c84b:5a60 with SMTP id a640c23a62f3a-a780b6b3f7amr809644766b.26.1720733384062;
        Thu, 11 Jul 2024 14:29:44 -0700 (PDT)
Received: from [192.168.178.20] (dh207-43-148.xnet.hr. [88.207.43.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bc8adsm291964266b.14.2024.07.11.14.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 14:29:43 -0700 (PDT)
Message-ID: <7217de82-f84d-42c6-a67e-b11e8e7a66a9@gmail.com>
Date: Thu, 11 Jul 2024 23:29:42 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: annotate BTF show functions with __printf
To: Alan Maguire <alan.maguire@oracle.com>, martin.lau@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <20240711182321.963667-1-alan.maguire@oracle.com>
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <20240711182321.963667-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/11/24 20:23, Alan Maguire wrote:
> -Werror=suggest-attribute=format warns about two functions
> in kernel/bpf/btf.c [1]; add __printf() annotations to silence
> these warnings since for CONFIG_WERROR=y they will trigger
> build failures.
> 
> [1] https://lore.kernel.org/bpf/a8b20c72-6631-4404-9e1f-0410642d7d20@gmail.com/
> 
> Fixes: 31d0bc81637d ("bpf: Move to generic BTF show support, apply it to seq files/strings")
> Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  kernel/bpf/btf.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 4ff11779699e..d5019c4454d6 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7538,8 +7538,8 @@ static void btf_type_show(const struct btf *btf, u32 type_id, void *obj,
>  	btf_type_ops(t)->show(btf, t, type_id, obj, 0, show);
>  }
>  
> -static void btf_seq_show(struct btf_show *show, const char *fmt,
> -			 va_list args)
> +__printf(2, 0) static void btf_seq_show(struct btf_show *show, const char *fmt,
> +					va_list args)
>  {
>  	seq_vprintf((struct seq_file *)show->target, fmt, args);
>  }
> @@ -7572,8 +7572,8 @@ struct btf_show_snprintf {
>  	int len;		/* length we would have written */
>  };
>  
> -static void btf_snprintf_show(struct btf_show *show, const char *fmt,
> -			      va_list args)
> +__printf(2, 0) static void btf_snprintf_show(struct btf_show *show, const char *fmt,
> +					     va_list args)
>  {
>  	struct btf_show_snprintf *ssnprintf = (struct btf_show_snprintf *)show;
>  	int len;

Hi,

Unfortunately, there seems to be a side-effect to your patch:

./kernel/bpf/btf.c: In function ‘btf_type_seq_show_flags’:
./kernel/bpf/btf.c:7553:21: error: assignment left-hand side might be a candidate for a format attribute [-Werror=suggest-attribute=format]
 7553 |         sseq.showfn = btf_seq_show;
      |                     ^
./kernel/bpf/btf.c: In function ‘btf_type_snprintf_show’:
./kernel/bpf/btf.c:7604:31: error: assignment left-hand side might be a candidate for a format attribute [-Werror=suggest-attribute=format]
 7604 |         ssnprintf.show.showfn = btf_snprintf_show;
      |                               ^

Thanks.

Best regards,
Mirsad Todorovac

