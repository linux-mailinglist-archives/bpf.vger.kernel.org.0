Return-Path: <bpf+bounces-18882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FE18234BA
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180A01C23E06
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 18:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407D21C6AE;
	Wed,  3 Jan 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FewsH0tV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7191CA84
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso3786330a12.3
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 10:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704307350; x=1704912150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12z/7eZwzjQgvD7n3ZzbEFwk06jSjkCIo19hQhYwpUA=;
        b=FewsH0tVKxXOSFd2pZM+DuxYodgkc+hFl746HRn7yj9Cdm3vZL4lM+PuV2RmvkZOoo
         j4tLJ0zCm9SqSCpQzSuge1AxUUVwlQ8N2GXcI90P47K2thIf1bQK5FE2AvccZVTShMbn
         30zrfOk76dODvrPOYleC5pjHDtf/7qmzvfApGy7D/+OQkQsyaZu/Iny6PLnacOXsd8ym
         bXwZBIOqeJfMjl0TaCZ6jhNk2VizC685G/5yxUUFPdDMYFl9UnyjBkNcwPyV3D7636WS
         lxeh9lH9W3QlTKjKiq3SDw0sItuF4Ad6PrqG7D0N8qDZeycNTJnmHCHS4ODdpNLFEJ0c
         o1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704307350; x=1704912150;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=12z/7eZwzjQgvD7n3ZzbEFwk06jSjkCIo19hQhYwpUA=;
        b=fDlwHz84xPfHnr1MS091IJLBxuFkvMEKrKNu/GtTYWBRQh5BholuVw8N8ecCI5w3e0
         h+8lXczern3yc15wrPPG+kjnoZmd7GF4LKztSNTP/iO5+a4/rGgcBLZUjm6xMEp4U23p
         lLVYtM9qMuDTuYIoGlGTngITciMkXCg7JXQXNidn+ASdEnLMU1mMYbRVkCkE2j1qEyHE
         DrHaem4y9EL8rGOvBQ2N4XlA2IrIIKVxI0ONum4K8wioVOgI76bR9hUn92zhd98wzr1t
         kkvXFdYUUsfnGeFYx82OIQ4tGJIArTL6+twFCgACwYEUfPUiuqJlqbF9U9xpAZfy34q+
         kVIA==
X-Gm-Message-State: AOJu0YyJzFlda0NDh16OwwdpUBuEFXef9PMzulEXXYDmLu++g0L2ggYg
	rEewZr/aw8onwtuB3W+dMfbVUuLGa44=
X-Google-Smtp-Source: AGHT+IGs/jhELuVq7vuCwOHZIGvnuKX6nnjVEG4O/GRoKNkp8YyWAdoSOHNLaIF1STlgkbI8D38bbQ==
X-Received: by 2002:a17:90a:7786:b0:28a:dfa7:3aa4 with SMTP id v6-20020a17090a778600b0028adfa73aa4mr6769067pjk.87.1704307349843;
        Wed, 03 Jan 2024 10:42:29 -0800 (PST)
Received: from localhost ([98.97.37.198])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090b068b00b0028658c6209dsm2091285pjz.2.2024.01.03.10.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 10:42:29 -0800 (PST)
Date: Wed, 03 Jan 2024 10:42:27 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, 
 Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <6595aa93aaf56_256122085f@john.notmuch>
In-Reply-To: <20240102193531.3169422-2-iii@linux.ibm.com>
References: <20240102193531.3169422-1-iii@linux.ibm.com>
 <20240102193531.3169422-2-iii@linux.ibm.com>
Subject: RE: [PATCH bpf 1/3] s390/bpf: Fix gotol with large offsets
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ilya Leoshkevich wrote:
> The gotol implementation uses a wrong data type for the offset: it
> should be s32, not s16.
> 
> Fixes: c690191e23d8 ("s390/bpf: Implement unconditional jump with 32-bit offset")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/net/bpf_jit_comp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index bf06b7283f0c..c7fbeedeb0a4 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -779,7 +779,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
>  				 int i, bool extra_pass, u32 stack_depth)
>  {
>  	struct bpf_insn *insn = &fp->insnsi[i];
> -	s16 branch_oc_off = insn->off;
> +	s32 branch_oc_off = insn->off;
>  	u32 dst_reg = insn->dst_reg;
>  	u32 src_reg = insn->src_reg;
>  	int last, insn_count = 1;
> -- 
> 2.43.0
> 
> 

Acked-by: John Fastabend <john.fastabend@gmail.com>

