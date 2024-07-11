Return-Path: <bpf+bounces-34601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D96E92F13A
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 23:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03DC3284090
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 21:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA5019FA77;
	Thu, 11 Jul 2024 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1dd43OS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF14712F385
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720734027; cv=none; b=G9pkCa01w7YtezD/4Ky0mYkVcp3kAaQSR4azucTICrfE3dP7w+huMfqZKS1/SoMgVuVOhh71ZfAilUrl2Zthe3MOIFg5POZX7ntIrRqHq4qYaqXKskYtVKQwNeKUtrKMnmFVZOoIpEtShSFFsJfzvgZrcVNua9+U9g5By/sKzOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720734027; c=relaxed/simple;
	bh=y9/J/eI/iFxMvY+cnPEiWiAFdWlVsHAlO+JFui6ihyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqmBKHM1OKTmrMLdgqWHkfgQ8XxJsWzIOCpmR6IiuD8fQJvqFbDhcYT0WtWcRoixH7D4kVKNUsvDdiRSlFyqHXyxLGDBQuwRCITvoMCob/XQWPhQgm3Xco5nc4ai1xMN2REQ9WB4ySn13LcJBdw/gnNZUkzVszhunblL5lP/Kfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1dd43OS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a728f74c23dso199826266b.1
        for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 14:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720734024; x=1721338824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nn8qKp5OXrABAjJ+H5Y54f57CMANI/FAulGWFrQvP4Q=;
        b=E1dd43OSEnpurz1Y2uKI//KoxtgNqVDxjfK7doVm2fuizyxU+/TGClF1GVfAxnwysR
         Cf/Ln6OCw8J8iG6v0bcT3UAQu+JsN/OvG7YHmteGQPEfy9Zhf9frqaweBRgm/j63Ttvu
         pqg+gh/FxXnhaSCXKc8vO0naakWHg6A9PpNpbZsD9kPZZ2Za4r7+FJBMX7kHnvsudu9N
         SyDiMu9InmWHoqA8fkVRp+hIRDh+7mMQGDQ7YJa/6CxCDWcJpoJ2SbiCgCXpj4oJVg6p
         VW1xzLRT5qscWOUekwp3Yj4Efd5DybxRaXHfcVnOiTPMk24EfWXtMRly188aK33sTSiB
         LlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720734024; x=1721338824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nn8qKp5OXrABAjJ+H5Y54f57CMANI/FAulGWFrQvP4Q=;
        b=E/1VY4bBowyv/5Plu9ZofF+N7A2fz+lGGVwWbk3tsxnsuxP3S3XrA3efZNgm+RGIbU
         5cQSXLA8dnPzZc7rwe2U4atenLcMo7JK9XLDXD9WX+IcQUNyj4Ox1H4M0wdOXWFOzwvJ
         ZZTjQxONDJY69IJiMlzN+tbLxZb+ZOzqpAnRfmzAlYm0RuWL8Adgdx9aMUtDnG5kAPuZ
         g6blF7TVskPOD8/1R8S6cTZ4DIg90BevaxXgyM+MuAO5EWNinuUm1u/3RzGK6RUi2UmI
         Hy8xX451BTvb/nqTN9w7b7W7il8vxWIe8/dX/YOaWgPBux6z82+27QpGt3yCXQOxnSJc
         I3Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWVlR03t2fRgAg1r9ltBSAyZ+vUIqEWOMIb2xcMelC/CCBOmRb9RAtxKDi5gVe3s13SZBvwObQKzTsv/0/DjgS1jL6d
X-Gm-Message-State: AOJu0Yz9KsF6R40H44mT5YG9LsuVAbOAcYw1atqNKm9RAQ8sVVH1jb3V
	+/UQDhE32/3oIxXHkaHMw4cSNsSNJnXLoE04gpi44izI+EZjN9/N
X-Google-Smtp-Source: AGHT+IEWvuEMasaxcJWtOnrLSBqxqLaOA4nZEICGYAe4lzpGqjUoBLDMuWXyzoQ16t60f7WCm3cGTg==
X-Received: by 2002:a17:906:4893:b0:a72:6b08:ab1a with SMTP id a640c23a62f3a-a780b705160mr578819666b.46.1720734023958;
        Thu, 11 Jul 2024 14:40:23 -0700 (PDT)
Received: from [192.168.178.20] (dh207-43-148.xnet.hr. [88.207.43.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bc88csm283943266b.6.2024.07.11.14.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 14:40:23 -0700 (PDT)
Message-ID: <92c9d047-f058-400c-9c7d-81d4dc1ef71b@gmail.com>
Date: Thu, 11 Jul 2024 23:40:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: annotate BTF show functions with __printf
 [FIXED]
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

Hi,

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

The error returned from your patch is here:

./kernel/bpf/btf.c: In function ‘btf_type_seq_show_flags’:
./kernel/bpf/btf.c:7553:21: error: assignment left-hand side might be a candidate for a format attribute [-Werror=suggest-attribute=format]
 7553 |         sseq.showfn = btf_seq_show;
      |                     ^
./kernel/bpf/btf.c: In function ‘btf_type_snprintf_show’:
./kernel/bpf/btf.c:7604:31: error: assignment left-hand side might be a candidate for a format attribute [-Werror=suggest-attribute=format]
 7604 |         ssnprintf.show.showfn = btf_snprintf_show;
      |                               ^

The patch is quite straightforward:

-----------------------><-------------------------------
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4ff11779699e..9711ee6a31e5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -415,7 +415,7 @@ const char *btf_type_str(const struct btf_type *t)
 struct btf_show {
        u64 flags;
        void *target;   /* target of show operation (seq file, buffer) */
-       void (*showfn)(struct btf_show *show, const char *fmt, va_list args);
+       __printf(2, 0) void (*showfn)(struct btf_show *show, const char *fmt, va_list args);
        const struct btf *btf;
        /* below are used during iteration */
        struct {
--


Life long and prosper!

Best regards,
Mirsad Todorovac

