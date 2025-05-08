Return-Path: <bpf+bounces-57817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1C5AB067F
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 01:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95BB84C6165
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 23:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A022153D3;
	Thu,  8 May 2025 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4/Ss5TK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB542557C
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 23:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747023; cv=none; b=ukGPS7IoG2wHtrgMhdnlOpF9317k14HM2FlwHBzfVntEYl+di7YU/UuPfgcAVcp2Ls6xBIUWxoxePaA/C13YA13JhOpKUTK1Dhlug3TmNkKzF7ngKC8ggeTneao+Rh15GKnNRdj9J4mivnj30bXDYGW6A42xSuMvRVb6Ezn8gYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747023; c=relaxed/simple;
	bh=7e9r7Qu2vPCOI11t4h7S6OTA5B7RXmjcIxPDpThbcB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9p8ovCog5HkV09AxvSRAOXEJ2tXgfuMtdxpljiVExa35o+mI7cfJk617mwn+aPm+Mhg3UsmgS18UMlavNxaOhfnUm1rl2B+k90d3A+XjsC2uDINbOlYyZNyb3yWG1kcPVAaRgJPucVCPh20cKVQyXMm04cqpZ3JS9LjphmV7XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4/Ss5TK; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ad216a5a59cso71243566b.3
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 16:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746747020; x=1747351820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nAEqILxJMrgaHw8P+5Bb3j8jE37bco0r2yORoNgWHi8=;
        b=F4/Ss5TK9SChAgfx5VSCsU6lYilr0ouguubQwH5hMHVCoFSpoB6taxYxYJTJC2sca7
         cLcUYaJLW8mG0rOeHiSN/NThRW9/yJZfvVodoJAzp1TMT1xmhwg3nh1umEHiB8kH3zrP
         0pKD0mc1f3Pc0kdCWQKcMJnFAqt0FWLAOV8Tf+VU+dNgwViNLQu329HWjjuRW+X0UXUN
         PLAT823ens/UxadE+ZKydWL27yt0/SfvXMLVaAfD9KnFJ69I8kA7oyjI1TZVW6RLlkh0
         5mgvPrTtf1Ahc05Ch7wpnftQlnTJ7W7UeKS6xcFl3Q3p8EdUyYxMERPgTSg9hD+rmOWK
         np9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746747020; x=1747351820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nAEqILxJMrgaHw8P+5Bb3j8jE37bco0r2yORoNgWHi8=;
        b=o7/02I/XhjvPDq69rQxj7046trK3CZyevnYnXdDklugRmhDEO03/D6gka/sT1w0o/P
         B0gEC3tZngtxAuiTklQpGhgPNR5JNj4A+I4OKTMZ/3gY4Ymos1aTy7+91NnB3H806EXw
         u+r3YKu+D9mxO764xqQAFiST0RvRz8QnwT6JnVjZUzuB0m/04Z/eayqPolE3T3ln78/c
         RCcOdqQQa/JW2PJt3jFeckN/iaBoDv4c/3m0Jl8zl6kNkrqI3Im5QrTfDw1iACLffNQ1
         rJH9Jnu5N5aj2zS0SkWEhooji3NUofCpTShZM+lffitACR5Uc6TaU4Nr5YEO04fxoLXi
         6rQQ==
X-Gm-Message-State: AOJu0YxqId2ibEsU0lZu4dIHyQSm+PnyFWbU8TWt/z5/TuU8J3GpQRPY
	FKRhcMZd9dtVjjBcS0yJAX0G/EWJ1AnDgZjFRv/Lk/Npm22Yj7J9NNMrO5Pw477YDO2tDcDNr91
	uqKHkEj+t/iMxQ2CDOjEXjaG4DZw=
X-Gm-Gg: ASbGncs1kwdpI0ar32nmQlkfmeu0LEvN1ZXXfNU0t+6fvOhVHhGlKf0DDcx0/cRXYBa
	gbMoxIwYfGrU3YRsfWwVxsKQNCGh3GtTRRKngc2CTEiYqvrPu3egJfimRsX4G0WrB7w+kkaJaSd
	a2uXfnZrfWt5+BPYaP9bm6h+p49bXwLteKsDsaw0VpHCpnYBrXqN0iYo7+
X-Google-Smtp-Source: AGHT+IFyon3gtl9nCotDM7++PNZw0AAPxqjFhIk0/7CCcLHaA2HzBhTO36v7baUlaXzmpeN68TfwVPbBG9yuFh0o1FM=
X-Received: by 2002:a17:907:8e07:b0:ace:3ede:9d26 with SMTP id
 a640c23a62f3a-ad21900b400mr131080466b.27.1746747019945; Thu, 08 May 2025
 16:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-5-memxor@gmail.com>
 <43ab09ea0150f8d987106604235886f28a73ebd8.camel@gmail.com>
In-Reply-To: <43ab09ea0150f8d987106604235886f28a73ebd8.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 9 May 2025 01:29:43 +0200
X-Gm-Features: AX0GCFtttvQJd4chSWatfkPvX1gSGoZwz62sOQwNacuAo6m6MlrHx_jP3jVawaQ
Message-ID: <CAP01T75QAq4Em7NL3Nw-3OC+cfkV_Yy69E88dxA2q9T9yDwA6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 04/11] bpf: Add function to find program from
 stack trace
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 May 2025 at 01:07, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2025-05-07 at 10:17 -0700, Kumar Kartikeya Dwivedi wrote:
> > In preparation of figuring out the closest program that led to the
> > current point in the kernel, implement a function that scans through the
> > stack trace and finds out the closest BPF program when walking down the
> > stack trace.
> >
> > Special care needs to be taken to skip over kernel and BPF subprog
> > frames. We basically scan until we find a BPF main prog frame. The
> > assumption is that if a program calls into us transitively, we'll
> > hit it along the way. If not, we end up returning NULL.
> >
> > Contextually the function will be used in places where we know the
> > program may have called into us.
> >
> > Due to reliance on arch_bpf_stack_walk(), this function only works on
> > x86 with CONFIG_UNWINDER_ORC, arm64, and s390. Remove the warning from
> > arch_bpf_stack_walk as well since we call it outside bpf_throw()
> > context.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index df1bae084abd..dcb665bff22f 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -3244,3 +3244,29 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
> >               *linep += 1;
> >       return BPF_LINE_INFO_LINE_NUM(linfo[idx].line_col);
> >  }
> > +
> > +struct walk_stack_ctx {
> > +     struct bpf_prog *prog;
> > +};
> > +
> > +static bool find_from_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
> > +{
> > +     struct walk_stack_ctx *ctxp = cookie;
> > +     struct bpf_prog *prog;
> > +
> > +     if (!is_bpf_text_address(ip))
> > +             return true;
> > +     prog = bpf_prog_ksym_find(ip);
>
> Nit: both bpf_prog_ksym_find() and is_bpf_text_address()
>      use bpf_ksym_find(), so it ends up called twice.
>

Good point, will fix.

> > +     if (bpf_is_subprog(prog))
> > +             return true;
> > +     ctxp->prog = prog;
> > +     return false;
> > +}
> > +
> > +struct bpf_prog *bpf_prog_find_from_stack(void)
> > +{
> > +     struct walk_stack_ctx ctx = {};
> > +
> > +     arch_bpf_stack_walk(find_from_stack_cb, &ctx);
> > +     return ctx.prog;
> > +}
>
>

