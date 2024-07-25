Return-Path: <bpf+bounces-35611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D27193BC72
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 08:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBE41F25291
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 06:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC181662E5;
	Thu, 25 Jul 2024 06:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLBZqKqy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BE11CA8A
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 06:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721888305; cv=none; b=oHDoRWRZTaXAEu8ME+5Cd7CDYrNd10aw/v7QOB8JNfOdCNTz6nlqHCvnNVNannOT8pTJ4XwXg0fMODlYxOYkSurqRNs8JQDjPG/9e5iTGsnFu9SmCZZL7yzInDbHo6kqD3EVOEfllOKge8oQGIwoOsmuiN6+oLgexmYI6kZ4Hck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721888305; c=relaxed/simple;
	bh=Z0IuHHEx74HRwKR3MPiXncKu5fOzdNgOZMKLrvqMnTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgDv2wNYlzDmvGwVEDsj9VB9T6wvxiDTHxdnW3fPqLMHy+avezv8ADfO6p7kcyevu/NlhLPXwvZVHQYz7TP6Ze6l/Ky9Z0zxkFIAcsMIHdqW1algMKepUuqLyaSnJ1aArxjhZS/4ZBCyjAnh38cUFiFkfitcMBi5J8qQN3MfHPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLBZqKqy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3684407b2deso303511f8f.1
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 23:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721888302; x=1722493102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEThHYQrb83773ukz70PGJVvnEwNCiPOrbcuCao9Q7o=;
        b=VLBZqKqyd3EMDXQjx8PRGbq75xB0I/t3ySfyM/a0i+xBXiD15wtxAzkxeuLJBkeuOd
         JuFNtOoqK9JEvqAB6PHxD18H5+EmOCOOYnOGSZ2aKy6tblMrguBeFAod9rYxCkxUmOQw
         /kDNMWd37+Wz/h1hUR+Y+K54IAwOT45fE3WGhmaloM/p3g//6bVL3nhLaU9oW391DE+e
         aEABC0y8gzaq626a54Nt/xHcYfbNlmb2snPJmqfabO0gxizvg5zcP9JdclEly8YdO8wo
         sw1YLXUkV90UgGtEto/LAj9HXkXAd3rgJu0RzVABk36u/g79VhrG1N1ahwkd3Bctjh63
         KIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721888302; x=1722493102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEThHYQrb83773ukz70PGJVvnEwNCiPOrbcuCao9Q7o=;
        b=HQCWmHUh/128Piz5WQ2GZ8kcgPE3dBmKKMYuhWkTpcf4GanzI7mgK/XmURhe/cuqFJ
         lVEzhAz0uf5wNHTU+KdQiClCccChNTDMsVM5fSSy5CRNvlvPQHS8t/W168+g4rszId1D
         nG+GCIjvaAKpwDJhsVMW1Kinx4gHGyrPi0O9blX27IhI4J48BH91AVClxKmYMIJNrLmb
         Yi4UhsgpgIFXMSLbppfLNwGDq/txzzsHDfBCtPb4qC9Qxifu+79513OizdN/YIM4dOBD
         ulqubzi8L3YwfnzYADeOAATEhevhw+CLzx+GFlmXolV46MwMMF8uKri6UWOBJEj9W6GF
         4agA==
X-Forwarded-Encrypted: i=1; AJvYcCUaWVZYHhBTre0vIpP6V4xa0+s0TWr1cBIWkw0faIEuBEv0faYj5akKA6vqJ0uchCOTruYakpHywLplnjGobxlJJlxt
X-Gm-Message-State: AOJu0YwDEd95sMPhZFzT4ggMARkPImp1DHpw5WLqFQOL8g59OH0DSnDQ
	3k6Y/snciYFicTenRIDhaVEyxCG5Czr2mcCS3Wk9b5b6RGNjiyEDPY64G0b9msR0Vqf636bByyA
	j8VqKKrjNzoQbPYL+3bWGsRkUELBZeU3G
X-Google-Smtp-Source: AGHT+IG8BGuVglqWlr4SiZ23R1fmlH/2ftS6Ebws1uGojXa7WBxTNWY86992l5omgeqQM+0TGHFwp9jrv2mLe/XU+PA=
X-Received: by 2002:adf:a1c7:0:b0:366:f469:a8d with SMTP id
 ffacd0b85a97d-36b363ad7a7mr672484f8f.35.1721888301835; Wed, 24 Jul 2024
 23:18:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711054525.20748-1-flyingpeng@tencent.com> <CAADnVQJ+UxmOe_G+UL_wFEZOFTVL4XQ=D8X1N29CT=zHNmi6NQ@mail.gmail.com>
In-Reply-To: <CAADnVQJ+UxmOe_G+UL_wFEZOFTVL4XQ=D8X1N29CT=zHNmi6NQ@mail.gmail.com>
From: Hao Peng <flyingpenghao@gmail.com>
Date: Thu, 25 Jul 2024 14:18:09 +0800
Message-ID: <CAPm50aLhVegFY=H=PTGD3+Ny_KFszWn5bNiCzwyV39z_j2QnQA@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: make function do_misc_fixups as noinline_for_stack
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Peng Hao <flyingpeng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 13, 2024 at 12:43=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jul 10, 2024 at 10:45=E2=80=AFPM <flyingpenghao@gmail.com> wrote:
> >
> >
> > By tracing the call chain, we found that do_misc_fixups consumed a lot
> > of stack space. mark it as noinline_for_stack to prevent it from spread=
ing
> > to bpf_check's stack size.
>
> ...
> > -static int do_misc_fixups(struct bpf_verifier_env *env)
> > +static noinline_for_stack int do_misc_fixups(struct bpf_verifier_env *=
env)
>
> Now we're getting somewhere, but this is not a fix.
> It may shut up the warn, but it will only increase the total stack usage.
> Looking at C code do_misc_fixups() needs ~200 bytes worth of stack
> space for insn_buf[16] and spill/fill.
> That's far from the artificial 2k limit.
>
> Please figure out what exact variable is causing kasan to consume
> so much stack. You may need to analyze compiler internals and
> do more homework.
> What is before/after stack usage ? with and without kasan?
> With gcc try
> +CFLAGS_verifier.o +=3D -fstack-usage
>
> I see:
> sort -k2 -n kernel/bpf/verifier.su |tail -10
> ../kernel/bpf/verifier.c:13087:12:adjust_ptr_min_max_vals    240
> dynamic,bounded
> ../kernel/bpf/verifier.c:20804:12:do_check_common    248    dynamic,bound=
ed
> ../kernel/bpf/verifier.c:19151:12:convert_ctx_accesses    256    static
> ../kernel/bpf/verifier.c:7450:12:check_mem_reg    256    static
> ../kernel/bpf/verifier.c:7482:12:check_kfunc_mem_size_reg    256    stati=
c
> ../kernel/bpf/verifier.c:10268:12:check_helper_call.isra    272
> dynamic,bounded
> ../kernel/bpf/verifier.c:21562:5:bpf_check    296    dynamic,bounded
> ../kernel/bpf/verifier.c:19860:12:do_misc_fixups    320    static
> ../kernel/bpf/verifier.c:13991:12:adjust_reg_min_max_vals    392    stati=
c
> ../kernel/bpf/verifier.c:12280:12:check_kfunc_call.isra    408
> dynamic,bounded
>
> do_misc_fixups() is not the smallest, but not that large either.
>
If I use gcc, I get the same result as you, but if I use llvm to build
the kernel, the result is like this=EF=BC=9A
# sort -k2 -n kernel/bpf/verifier.su | tail -10
kernel/bpf/verifier.c:14026:adjust_reg_min_max_vals     440     static
kernel/bpf/verifier.c:7432:check_mem_reg        440     static
kernel/bpf/verifier.c:15955:check_cfg   472     static
kernel/bpf/verifier.c:7464:check_kfunc_mem_size_reg     472     static
kernel/bpf/verifier.c:15104:check_cond_jmp_op   504     static
kernel/bpf/verifier.c:4166:__mark_chain_precision       504     static
kernel/bpf/verifier.c:10239:check_helper_call   536     static
kernel/bpf/verifier.c:17744:do_check    792     static
kernel/bpf/verifier.c:12248:check_kfunc_call    984     static
kernel/bpf/verifier.c:21486:bpf_check   2456    static

Obviously, do_misc_fixups is automatically inlined into bpf_check.
So adding noinline_for_stack to the do_misc_fixups function is a solution.

Thanks.

> Do in-depth analysis instead of silencing the warn.
>
> pw-bot: cr

