Return-Path: <bpf+bounces-54290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF33A67054
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 10:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36ED21886C8C
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 09:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BA9207A0F;
	Tue, 18 Mar 2025 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKvCOpkE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77091F180C;
	Tue, 18 Mar 2025 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291547; cv=none; b=ORbX2FCbRu/zDcRnxlQ4PJxIdPSR7bMIXaLuvtixzbrNygYPUCnznbODQ5wkHxPn0RvcSBx4LoawmJMs01Wwny+/hJV4CCVIHDw9RewdvHKDqwsGRwxwZsNiMlq7mX9IFswUWAKYEszkpQ2VDMaDLAUQBNYULSDpq3mf22DAvMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291547; c=relaxed/simple;
	bh=uT6topeQGMU31LB4uXHJ0a4KZR0fXhTWh//rqKHoDOY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5H0K3Mifl0k2R6ETxM0iiDklKr0WkIiOdcWPWQpUWROf+tqShKGZW9klpwgcz/2wxlg6pxoIyyD6wfYzdCcGeDx1W/vuV97IkV9WzObDFqSoRYOoGgXdfX/qV61Rf6JF5rNnjOT0u0yH6dSE1ofa0+V5H6I7gISFtvrVtVQsMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKvCOpkE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so9322660a12.2;
        Tue, 18 Mar 2025 02:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742291543; x=1742896343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JeX+KrW/EvBHt4dW28OU/pGCmkcVm+7hPwgvlnCKYIs=;
        b=nKvCOpkEpWMhlE9Q1xThPjiHg9dGhkozQ957A8wKqTn6amLFm7ow5tG/aPzix28sI6
         MT7oRVRmTqktStsTuVFIDLd7rhClBJox8Yza0KStiWvoQ/TuEYoN/sHkQiXkdlti3aG2
         R713ifOeKTroC2UiGNvIIU20DZwc/Qhky6i0gW89+pa4Wv6fxn6mBq9mAYzs8dudfZcn
         BdN44Dl4jNJqENspMasbQzc5WDI6IRl0IuU2BjRHDVnfta3ZQoZnA4t3h6A7Atnx3jPM
         WH+wVGWTk7PHdOPhSpW7hpp8E5kIM8LB2ZuWnqV5GQ0l3vy6PUDojZTgGq61EktiQlHu
         RuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742291543; x=1742896343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeX+KrW/EvBHt4dW28OU/pGCmkcVm+7hPwgvlnCKYIs=;
        b=YO7jKUPmgzSCflDpso32Lk1pz7jpPtjlGLT72/N7joZv+Xw/l3yeV9n7pd7xHHiTDr
         VGufZmf1es5r5/7zasobGe2/MHCC566gBJfPPk31yCcwJbPnlTQ+OjiE21GAvSUnu0ut
         Bkxy7OuYpdltob0seYGabkToT2xqCZdDWmaZgOdHhDVfC9jGcM9/tdP71wzlJqGxgqga
         +w8IyZs667tybDvRosESDajFnSHd/hJEcRNxHlDHb8FCMmAxdw5iM1UuBU71Rf94zYVI
         sLYAbaS4+GPgGYQznCvRNp0anKUDmGst2MGSa50mXGXqFpUQg8K5YAIdYWJ7kI8SoYGy
         R08A==
X-Forwarded-Encrypted: i=1; AJvYcCUOjE1eLzI/nr0/EA16q/AHcTwHqPzYtZYUjMdefI+1mZyakQaX6rC6cbD9UqIdozDBPPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7p4mj+wquWRiM5KJTTbSxa/3FQ8Rqf4g9pejMeluVMAHonZH
	dAyBJkVsn+n2tbaJSEDV8tRMxZfpstKqOvC+yOaivBm7Iay4hcQUC22Nwcqw+cbhsQ==
X-Gm-Gg: ASbGncvKxbg+8D802jPdfxPE9UCjCuMNpOy1HIWEd8P+h3KOlaXwm18zOFCEAjRYncR
	8iBs4gu2CfyYGNd+XQng4XxNtzMU5lD0936OJOtJyh7xnsCQjz0ptCfHbzqCCHqKLr126Wem64F
	OIr2UGOdCHNV/eAQ4LCRL6Vi6Giq9kDS2+xiWRabfDxQ0YQpWlP8G2qDxvBvtC2tw1fGxbvelcb
	y1VlrG00sgdY+46SDjqIuqWmUQGiunanpKv63OKZnj+nKAKwbdz8MqwgVnaDWDVnKXhX2+E8FhB
	swGLiw2NAH4IvC2F5JleKNODCZmMw+w=
X-Google-Smtp-Source: AGHT+IF9N/ANNQJhDZ2/vF0mFdUGt1UhozVjw/vf47VxbyKTaephnWcPJvuSE9WXY8AQ6G4+ZEccEA==
X-Received: by 2002:a17:907:3f23:b0:ac2:8118:27e7 with SMTP id a640c23a62f3a-ac33041af9bmr1524261466b.50.1742291542616;
        Tue, 18 Mar 2025 02:52:22 -0700 (PDT)
Received: from krava ([173.38.220.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816974016sm7484941a12.24.2025.03.18.02.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 02:52:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 18 Mar 2025 10:52:20 +0100
To: Sami Tolvanen <samitolvanen@google.com>
Cc: dwarves@vger.kernel.org, acme@kernel.org, yonghong.song@linux.dev,
	ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, song@kernel.org, eddyz87@gmail.com,
	olsajiri@gmail.com, stephen.s.brennan@oracle.com,
	laura.nao@collabora.com, ubizjak@gmail.com, alan.maguire@oracle.com,
	xiyou.wangcong@gmail.com
Subject: Re: [PATCH dwarves] btf_encoder: Filter out __gendwarfksyms_ptr_
Message-ID: <Z9lCVHIyjLjQ4BOs@krava>
References: <20250317222424.3837495-1-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317222424.3837495-1-samitolvanen@google.com>

On Mon, Mar 17, 2025 at 10:24:24PM +0000, Sami Tolvanen wrote:
> With CONFIG_GENDWARFKSYMS, __gendwarfksyms_ptr_<symbol>
> variables are added to the kernel in EXPORT_SYMBOL() to ensure
> DWARF type information is available for exported symbols in the
> TUs where they're actually exported. These symbols are dropped
> when linking vmlinux, but dangling references to them remain
> in DWARF, which results in thousands of 0 address variables
> that pahole needs to validate (since commit 9810758003ce
> ("btf_encoder: Verify 0 address DWARF variables are in ELF
> section")).
> 
> Filter out symbols with the __gendwarfksyms_ptr_ name prefix in
> filter_variable_name() instead of calling variable_in_sec()
> for all of them. This reduces the time it takes to process
> .tmp_vmlinux1 by ~77% on my test system:
> 
> Before: 35.775 +- 0.121  seconds time elapsed  ( +-  0.34% )
>  After: 8.3516 +- 0.0407 seconds time elapsed  ( +-  0.49% )

makes sense to me, I just can't reproduce the speedup
could you please share your .config?

thanks,
jirka


> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  btf_encoder.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 1bde310..2bf7c59 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -2239,6 +2239,7 @@ static bool filter_variable_name(const char *name)
>  		X("__UNIQUE_ID"),
>  		X("__tpstrtab_"),
>  		X("__exitcall_"),
> +		X("__gendwarfksyms_ptr_"),
>  		X("__func_stack_frame_non_standard_")
>  		#undef X
>  	};
> 
> base-commit: a0be596ae76c720d21eef257dec1cf2462130da1
> -- 
> 2.49.0.rc1.451.g8f38331e32-goog
> 

