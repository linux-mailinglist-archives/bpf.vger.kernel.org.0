Return-Path: <bpf+bounces-30681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD378D07D2
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 18:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269EB2A43C9
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 16:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9FB16079A;
	Mon, 27 May 2024 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm9QvyP8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81CE155C91;
	Mon, 27 May 2024 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825640; cv=none; b=Tq0cVepPbk3rQ5MaXfbiATs+TVLXyL1Mibhy3CbMnl36dCWiBmf0nqIehQpm1ndckGTE0NSP7K6toWKxJ9y5GnMHi0iFO12xSXTYd7SVEWolW+a9d2kHiZUFdR3g00f8RqeZJFEMBYo450B22fI7bBk5egrVnYER7nA2pm205L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825640; c=relaxed/simple;
	bh=9mYmjRBk0P5Q0AObg6ek9rZm4zLIX9lqhsl2xATV73U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qxpe0b2KiW3TAeVDzywjQsUpNd0/sy0cyrJCiHvIolCYupRVsDUbZosqyXiHzxaXnwapt4DjILf0qtlmWI3K0vndMqJ/zsDY4POqxsrdXNiJBgPjoaLxY/mjYfQ4T22ISq4lWukbYQFS8rH9y5Pl6YQp8svIACLV6+BbsSmLQJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dm9QvyP8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42102c51524so24643595e9.1;
        Mon, 27 May 2024 09:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716825637; x=1717430437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GnnpD0FzpzbYfq1ngxZSbacY0kBYXWsANl4BUlAOofU=;
        b=dm9QvyP8eUBJ50JdJhIcaV0rurpq3CkNMH3uVVK/7FK9fiM7MlitSillV4unV1JWbh
         lG08OsNcqTZB1bFfSol2uBGUDwDS25nC+IkHclg6xabQ76vAQAnw7GEtKcVXTirys2WX
         hQCSUokD+723uni2SWLCTu5U9mRB8UXERKBK0fueZdQlvExSryqxoGZCLX3JcZAQlUe1
         eKHBUEIj4qMRyzrdI2ZPQiOPHLqXbPYi9LDAEFQ2LCB69qgfY5upZvX+P1D/vHO90Fti
         I1kUVVHft2hZOySIzSxTwjJ5EfdLYud7KZ1Wdrevpk9HOoImSrY1NzGJ51ouXfmGqcYj
         pIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716825637; x=1717430437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnnpD0FzpzbYfq1ngxZSbacY0kBYXWsANl4BUlAOofU=;
        b=E0u/pb2SqeLgpE7KLaV91/VmN7y2XqC+21JcnSI9AHsjuZods9ORiuQfwShuoxPKb5
         +WXvk8oyyV8HRwYICNjhcDevmyFkWhEdPSBNGN5D/Eyd0HAw5Qd8B0mzWtojjZrDw3Q6
         r550HuJy8H4NQ65TfozOwa7U3KhvWA4Sah8IVIXIqNnTD5eYqOb62RJ4pGup+1nMuXiQ
         CDBHVvOK7facgVFX7y5KHhbtBu5MYEj/a54Z+DKhVX+l0MEJgEbkfZdIhIN5Lly4HhvY
         qF7nMdffkECDcnBQuFGHMt9oXvynU8EdsM9PRmBqfM+kjH+kgJOdR/7VSKeP1mX9pE+p
         Jc7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqqaoK8dZr/AMRiMEGoX+hspt9sTSwUADRp0XzHHg+s4Ad8YmeSmXMT5n+AxiCP7CGDRjU6jGKj5FvDvP+eLMFdpfyDqzhHEztwPdD5XTX0jpQW1y0ldxm69cvo4mnvVAb
X-Gm-Message-State: AOJu0YzCeXYuD+8KA5WM/vhFmv/KXgi6JqWdAIIv35RSChi6nBZECmej
	RCAHtYdfrMEA+7BEyPqVlOKLsGQxEg7/Q4D3v0NgIGxSAVhrUIhir8xLLA==
X-Google-Smtp-Source: AGHT+IGtO7+X98RuvpMG2dActz0xWJmVguWHzph/jBeY6LMcG/4HZrsbQNDsc+iimhUZE7+DFXGchw==
X-Received: by 2002:a05:600c:450a:b0:41a:8035:af77 with SMTP id 5b1f17b1804b1-421015c7259mr107577395e9.12.1716825636675;
        Mon, 27 May 2024 09:00:36 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089667fbsm113219105e9.9.2024.05.27.09.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 09:00:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 27 May 2024 18:00:34 +0200
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH -fixes] bpf: resolve_btfids: Fix integer overflow when
 calling elf_update()
Message-ID: <ZlSuIu1aFLzAiH_1@krava>
References: <20240527153137.271933-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527153137.271933-1-alexghiti@rivosinc.com>

On Mon, May 27, 2024 at 05:31:37PM +0200, Alexandre Ghiti wrote:
> The following error was encoutered in [1]:
> 
> FAILED elf_update(WRITE): no error

hi,
this fix got already in, check this patch:
  https://patchwork.kernel.org/project/netdevbpf/patch/20240514070931.199694-1-friedrich.vock@gmx.de/

thanks,
jirka

> 
> elf_update() returns the total size of the file which here happens to be
> a ~2.5GB vmlinux file: this size overflows the integer used to hold the
> return value of elf_update() and is then interpreted as being negative.
> 
> So fix this by using the correct type expected by elf_update() which is
> off_t.
> 
> Fixes: fbbb68de80a4 ("bpf: Add resolve_btfids tool to resolve BTF IDs in ELF object")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218887 [1]
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  tools/bpf/resolve_btfids/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index d9520cb826b3..af393c7dee1f 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -728,7 +728,7 @@ static int sets_patch(struct object *obj)
>  
>  static int symbols_patch(struct object *obj)
>  {
> -	int err;
> +	off_t err;
>  
>  	if (__symbols_patch(obj, &obj->structs)  ||
>  	    __symbols_patch(obj, &obj->unions)   ||
> -- 
> 2.39.2
> 

