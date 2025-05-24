Return-Path: <bpf+bounces-58891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1386DAC2D59
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 06:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004A2189895B
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 04:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417DF1A4F1F;
	Sat, 24 May 2025 04:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWzjuTjC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182CA1EB3D
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 04:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748061709; cv=none; b=dn2qo27TWekLlkjlYy+3D6KqYXN6nmdwHCnZk7dLwwzi2sEooQEbiocPyvGPBMPLeWXEVq8+/kBjISr/ZmLlvOPbgNnOw6x013ad6mIbhldOxRlpaRC+kSJ/GYTrRgWLVmwNP5IOjsYG2NjPkfi6DCZ23MBEzNlNoG4i22uETp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748061709; c=relaxed/simple;
	bh=F8CZbtJK3M18e+AKY/nI1gOFCprFGP/d78cwEqVJRBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7FtV7rTcd54T6lKE7j9RWxhsMJZB+ZqWhlthzwEfog0Uhf0Pnv7izf6rRYV9/yWvLglb4AjQpmgOchWOuaBqtuGxeuGFxWEckgoOT3NeBplcT/ywPvIUpCnBYHYuLUlPBKnTnXb663TIscOTEM7+GZUtrfMaXdR+ymmLLQegbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWzjuTjC; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-6000f2f217dso946386a12.1
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 21:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748061706; x=1748666506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V62lSblJ6iVYH5WVMzhGOaxhQkyExi5v1vkx2OQJ3AE=;
        b=FWzjuTjCr2bsufCAkpVPT2T61WOuWf8pWnGhd9t+PATPbSwm2/LcA6EzVx3wHitmit
         D9Bp30sjDMJtwg8LE8HZXX5VH8i+Tpe6jl0XrE+N3c958DmXomlDLqFZ4b+ntBR7ixM/
         jVNniI3V/zsW24HfoR05toA6O26XApo0z+7xnwVw2A4d9+6NcZAMVDKnyqI9hQ/nN37V
         SXOpdoRL6RpZIILhbqnUUGUMyOuLW/3c+lAmYIEcGlj7aclHOzwLpTKxwVKnJvuf/ZmA
         UbHnlkb4NGPaALH2nchhXynpCTYq7Ke7sTGahRElNNtdv9UpRaOShzA6rdIazCXEBC2G
         m6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748061706; x=1748666506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V62lSblJ6iVYH5WVMzhGOaxhQkyExi5v1vkx2OQJ3AE=;
        b=mh4wHzcK4VW39DO5LiSIPBfGiY+sZI6scOFBWb2mUlX582qa7VlODUhL5cRn8KYnMO
         +RtkvyM5g98xAGx7nbR1fi+9/nv97XJ+tJ0Ea7iK06XmmaSzyHdzAQtXenrIfAa83ium
         qJwWk8MA9H60AZvGkntGQUsBfsNgpG9l/RdDrFBPqonrWL4SgaHTMQFJVn3umj+zwPs1
         JRUj3K4lEwe2rMoJ43CFx3Ig9yUTp0r2j13RPjsQGLzj0ZtMEFuCJ7Fl963a3zP983Vp
         aeVeBTiTwbq8XVYzBOBtSFpZjVP+NyOoVrh8FWmayfKbhpWUTYuyjQwXo0wTE920BOg1
         VNpA==
X-Gm-Message-State: AOJu0YwF6PGAOMRqMd0G8bK2v4dL+ZSfZ5PsZEpaHwoEMLIEjlCPfXdS
	yFYF97kHzqHRKhWq+1dGwO/wLIrM74NbBIKKJTTl4GoG6+5M29toMoTCDe8j8W19Z7ZN/x+i3lx
	jyJxnanh6eD/S4AkYordan7JChXSdXhCbkPh2QfQ=
X-Gm-Gg: ASbGncsikqNwxCexHSWl5OJuYnyfSU3mk2WoZaLKgcU834tVuyQPYmbSjIg1EIn63XJ
	0ZGG99qhXRFSbFh+9mp5PhxT0dGV8FE68WftatdM2rZks/BhSDpi1ggmNekgoG6XL7tvs5EuW94
	t3PDPNGcGWfzZDJ6RARoKpwhvf3glE+p/96JFSemWUaNf14/Om3N8FdhFUMh9QRMXA3yyI5QIFJ
	xxtJw==
X-Google-Smtp-Source: AGHT+IE6tvAA8TNnz5/990E9R6wzlA4BY2xqRKCe7AFQGdlxQ+Sllg+UsMFbjbZLCjG/ZZuaPKNhuvzMhykNEwECtEI=
X-Received: by 2002:a17:907:e98a:b0:ad5:3a7b:de91 with SMTP id
 a640c23a62f3a-ad85b1bfa4amr161043266b.27.1748061705786; Fri, 23 May 2025
 21:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524011849.681425-1-memxor@gmail.com> <20250524011849.681425-5-memxor@gmail.com>
In-Reply-To: <20250524011849.681425-5-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 24 May 2025 06:41:08 +0200
X-Gm-Features: AX0GCFtqfa82grOhr4H3KsmQblz8zGMHvAGkzNclT0yXFSMPYvPp5vFEWkODpVo
Message-ID: <CAP01T76sCLH8qCrEqr=oYLW3CpbZA-+ifbA3DOCXT93Lk0LN5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 04/11] bpf: Hold RCU read lock in bpf_prog_ksym_find
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 May 2025 at 03:18, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> The bpf_ksym_find must be called with RCU read protection, wrap the call
> to bpf_ksym_find in bpf_prog_ksym_find with RCU read lock so that
> callers do not have to care about holding it specifically.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 8d381ca9f2fa..959538f91c60 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -782,7 +782,11 @@ bool is_bpf_text_address(unsigned long addr)
>
>  struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
>  {
> -       struct bpf_ksym *ksym = bpf_ksym_find(addr);
> +       struct bpf_ksym *ksym;
> +
> +       rcu_read_lock();
> +       ksym = bpf_ksym_find(addr);
> +       rcu_read_unlock();
>
>         return ksym && ksym->prog ?
>                container_of(ksym, struct bpf_prog_aux, ksym)->prog :

This isn't right, we need to have the read section open around ksym
access as well.
We can end the section and return the prog pointer.
The caller is responsible to ensure prog outlives RCU protection, or
otherwise hold it if necessary for prog's lifetime.

We're using this to pick programs who have an active stack frame, so
they aren't going away.
But the ksym access itself needs to happen under correct protection.

I can fix it in a respin, whatever is best.

> --
> 2.47.1
>

