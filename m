Return-Path: <bpf+bounces-68670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1DFB80601
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 17:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74CC51C80DDC
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9078335935;
	Wed, 17 Sep 2025 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7eM08Ec"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D472EE608
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121098; cv=none; b=SgrHEzG/2f1/BNAY/Ae2eL76l8hImDAc7bxkKUbeirKbERYg1Yo2pMFVhwOUUN7jTwhODhQOO3QulOFjREOtp68aDhwhm+1Fymm42ro+71Ld2BPAlVV4h5ELdUDl5C42wfhtFGL4urobe3OYS3QWnvOLQt86ARWga+rQai+IJ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121098; c=relaxed/simple;
	bh=89RqL3dKNRzXAN5gswG3FpeqGJw8aAV8f7M32uLMJ3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIdoQO+VX1LOW4iVMkdXdOpxAtGbpePVsd9RgaVlCmTbXDg4vG5J42LqpEBJApwYXKjwpxt2fPHAHbq+q/OO/hZmyijlJr5Vow+EQ1lO3098bhf/vkPkaBfh00lTxgaTHzkV9ZQps8j3MXgNutH57v8Ato5t9nS9S/qnZrO3GZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7eM08Ec; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b07d4d24d09so563078366b.2
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758121094; x=1758725894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zY99cLVt0d3tdNy7XCHIQG67f12UlCGnFw1dUkPjQvI=;
        b=c7eM08EcRH4rAbKOzEekE4h6Gapvslq41rbHNshADDNJOxK5XqncvuLPcfIebpcPBm
         BqzUSIBT2FtkD5tcJZyRPSJ+3QLJpJpyThvGEBCe52ukdbHP8EbiN0rGBnevGA0x9Q1E
         ye6Mqt/f+77KOJckzu0WN6+jNRkx9C5unJ1ZH8hL3dNvMR1ZyO1zkHCfrg7dwrhqTzEV
         FBQBqgNSH3sMIGBqGIrcbsW66eqbFfwUHNMTBsmLDpVulgMuaw3LvihgxsnXgRNZYXxf
         ItvGDCvQa/whHLGHMTglJ7LRWUNLP2x6UZQUJWKuzxTdaDOM+1lKhJNjwDnswq5JrPxS
         NvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121094; x=1758725894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zY99cLVt0d3tdNy7XCHIQG67f12UlCGnFw1dUkPjQvI=;
        b=aTiZuV9HfJwzwk/F/GLZePmC7+WO412cjypSjzmE0M/nNscYMN0d+pK96U/5DlDAOP
         UuNn9EQMWbcoNqhbAtYDdMCfXZZU+aVwv47K2xyIVqoomElYeUkQKqtPrhbFuB+hklbP
         4AkcxZcVRGe6G11Vg5PgZSw6WKnMwI6G6L2W3hmBXcvb46gO3bH1nRtEYdMnTC/Scwb3
         PsxS3jnoYuRHEczILfmjGokrqTkmxqmrYpMlPn1wHEjUobQtZHXU5ORCNhSzsFHZMBYY
         5ByTjw9TkarpJP56Hf64veUr0giWF7p+Z8SUwKciM5ZeDM/CU7tgd6m3vrtbphZutQqt
         1Jog==
X-Forwarded-Encrypted: i=1; AJvYcCVM+Xt+AVnR8BesTuE3aauiwLiUaL4RUhN636SlWsRM+xvfBxrBHwg+EVqG5yrWfjxs0fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxatTdaTTkVRtVqU0G1wji4Z2RGknFYKp5SwO2Mx/tkB05Ls+b
	u8HtSebEAyCIxlCjRky8MnH4MZ76FhQ9y2sHnFNxJcob5A4erbzAjX8bZ4OmfVdTxvoSVgRHf6+
	I2Pj1j1JLuU9p71rDMOd/AgImnSYti5c=
X-Gm-Gg: ASbGnctZWLKe40jd4O/3r1mdlAK2dm6D6GHQSI9qsWu0DniC1zx+FblUptgDGlFxlyN
	nn5r9rOSaQ8zPHq6AMfJoP9502+cQojDlycYswi1UNPlwJReiK2/t9mYEvP37fPB+z/37JXMmSQ
	EH073e9XWESpEhng6S8HacvQAKGDkxij82GjYvsV6oFVs4mDSRyZZE8fUuHcVvmqsx1bkZKEvSK
	UJ2JOHzumMSA61Be8s00fzcZSTWWhKtceV70/nt
X-Google-Smtp-Source: AGHT+IGnt2+Oy4GmTBEsaUMczsVN+lHEMBC4UvW+VABXiL7v+Qp6AqSwuvDpHRUL57kCRit85yRN/j7PCWeczSP3VEg=
X-Received: by 2002:a17:907:3fa7:b0:b10:aab8:3816 with SMTP id
 a640c23a62f3a-b1bb8ab9007mr298555066b.32.1758121093782; Wed, 17 Sep 2025
 07:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com>
 <3b65db27f2cd4575875a090f9cce0ca0f138daea.camel@gmail.com>
 <CAADnVQLe+5C8MH9SEU2MxHP9iaCHJHXdnuXTHkqvnVwsHTynwA@mail.gmail.com>
 <5e2fff56d3465ca921dbee96f512bf0443f66346.camel@gmail.com> <bf202c1aabb6247cdc6c651c6cac3ff3982115db.camel@gmail.com>
In-Reply-To: <bf202c1aabb6247cdc6c651c6cac3ff3982115db.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Sep 2025 07:58:01 -0700
X-Gm-Features: AS18NWDF5efzHiGEZCP6sZEnoSZWp4Nbdvt27WoWNu8Rbc441CgjTSB-UfNGrTw
Message-ID: <CAADnVQ+UAr=kcw_dom=DqqcBWrxK1yWTn2dsabLq9_wopw8Cmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 0/8] bpf: Introduce deferred task context execution
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:51=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2025-09-16 at 21:44 -0700, Eduard Zingerman wrote:
>
> [...]
>
> > In v4 the function invocation looked like:
> >
> >   err =3D check_map_field_pointer(env, regno, BPF_TIMER, map->record->t=
imer_off, "bpf_timer");
> >
>
> One option is to pass an address:
>
>   err =3D check_map_field_pointer(env, regno, BPF_TIMER, &map->record->ti=
mer_off, "bpf_timer");
>
> But still looks a bit ugly.

and then check that this pointer is > PAGE_SIZE and only then
access it ?
I guess that works, but why not something like:
map->record ? map->record->timer_off : -1

