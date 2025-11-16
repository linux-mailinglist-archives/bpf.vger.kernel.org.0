Return-Path: <bpf+bounces-74673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B90DC61509
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 13:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343C53B5B87
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 12:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A192D7D27;
	Sun, 16 Nov 2025 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W60ndAve"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13B22BDC03
	for <bpf@vger.kernel.org>; Sun, 16 Nov 2025 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763297469; cv=none; b=hsvxRENiWYVsiCcfQwuoHOvQ00kMe1m9rnPEC5c6EJ8/nwswFBXbNqnRf35eTqbRAwEN3IrhJDZp1EQN1Ls6g1K6l/aSXY9tTH1c68Pirj+QCfNVsFBgVYJe6zRG+TZa7oW+W3wE7WVcKQKXB0NT86KuGpJCLp2xmnJ8YmzyE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763297469; c=relaxed/simple;
	bh=b1DsF2a9SEn1VvYicPEK5Nvfoxk6SrdgZFuI+6TNVsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQjP2saWZ8P+QLZ9F8ivJv2mGX0UvSBEWwta+PB/J3zKS7l93nc7s8kw9vB0aYd+M6EAsdbZlMh4HOJ0l40+En/I5vWLw/txYb+1TZL3Jf4zC8JllMtogQzvCJHVm+T7dT+dp6jvVfzfR1shmKvj0+LO9ouruWsXsiyy7mllgxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W60ndAve; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477632d45c9so25371865e9.2
        for <bpf@vger.kernel.org>; Sun, 16 Nov 2025 04:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763297466; x=1763902266; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RkqiuLxPEnNwNaXdB6UKXa//24qbLorapHa2Yrmt154=;
        b=W60ndAveHojX9HV5H76hmTiyv1lnK9pVs5Q2aIRY93QTjUCuEBxWo4QDUxfGNaNyI6
         y1rIcbUPmjvDtGa8loBFgC1bYcMwgT4OLxKC1Manex+vDzK6Pfclpc2cKB8kYyhLCW+c
         X/g03b/nC67k+BlRaM4X9anddLWfKF2Kca5IfoSFxmt0Gg8x42bRYOQRYL4HVwQ26cNW
         u41dcZ0pJKGVcmVYSpHEpjVlAsNC1tki2z5nGh7lZdhbxJjbfQRwtagt1Gbd7p+0GSUD
         W16eUyzPUegCR5jFqXt1OI8AzHrchhSHNp7/OeiQi6dfiCqSNgQK8tz2LKuLlaZBY3aU
         2zPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763297466; x=1763902266;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RkqiuLxPEnNwNaXdB6UKXa//24qbLorapHa2Yrmt154=;
        b=PXvLU/HH5ZmfzolCOFphdnn5EzfmeEoB6x6OIOmUVGKseN7iDH9E4zutR5W6QizfnZ
         cJGM/j5KT8udXpawDssn2Sno8GdQwL8GpYDV/e61DFMPrkl6kfyTkkrGQRN9W7soM4df
         iKVb4d2zZpLL7/uldN6DWJ4An4p/CzrwD53L4zsmDVYAz2a1yF9rLWMJZCHQfq7sA86M
         tpCaUs0x+9MWEWe4lkrDh/J3iimb3x1BY4blSucKz/RZ+dMDabJaWg4mpwMBaVVkLQuS
         aaW0EmoW+aELw9fuhE4GLxbutnipCJZI1ifze5X2RrGY96n4YOWM4TwCkRCMiJO2s7Sc
         ERew==
X-Gm-Message-State: AOJu0YxvV80Yi7cvELIxQbiRnlLyhhR/bZ0R6Qwe0Tr1Z8MXUQSJ2BKk
	PqBInPLDBRbk9wePNG429WcWFUdXr2cd3Ku2nPN4fz2nBYk3gvQzIT9Y
X-Gm-Gg: ASbGncvc6uqeXsdjJemvLl6KpA2oDoYwHbloCaTGAbWGFloO/yeWBqVYKGj1f313VBV
	mm10Wk3Q/AO1ze43WR/AevxLdXjXv8xqfS/wXVyeTqc8qRR85HSzU9bSB5UI161x6kVZEUSr+7k
	CVrpaqzKrWviHCPoyM/VuGDmylWDG/BjjrL0H+nff/41uzhFSCqaOlpFsWBcIhWCu+SbjizhoXN
	SJ8MSNQ8Qk/y9MFppEEO6P8h3e+Nbwz0kmJtAVge2grJbElZRwi0a385NfNkahFAUDsLPoAvTdS
	Dnv8DOdCji7l/jGjt2z2TJ8GSNaeOcpFQve1gm7bW97VSrsVBbTs/3kQfBtPIbITbGWNzsQMWqf
	SciKN7bW63zqWagDVen5tF5nkdexAJx+vSKCjKLC+oqF4Gxa+CFF0bNiS271piG20Dv0KZ2rHJn
	ycbmb8dlLTzC6/CW8kYj6i
X-Google-Smtp-Source: AGHT+IGL56lYIOOQBYzTkTeR+HSpqzU+sjQGhCpiynE5kY0B0U4DouYHeMxLBfWqqvCC4ersEpx/2A==
X-Received: by 2002:a05:600c:a47:b0:477:7a53:f493 with SMTP id 5b1f17b1804b1-4778fe78b15mr89079825e9.23.1763297465913;
        Sun, 16 Nov 2025 04:51:05 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47799768409sm83085965e9.3.2025.11.16.04.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 04:51:05 -0800 (PST)
Date: Sun, 16 Nov 2025 12:58:04 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v11 bpf-next 01/12] bpf, x86: add new map type:
 instructions array
Message-ID: <aRnKXNPkENDiRcnO@mail.gmail.com>
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
 <20251105090410.1250500-2-a.s.protopopov@gmail.com>
 <CAADnVQ+MmpDpSsQZW42K3nozcuM5yJMRRZRABjiTiybNQpBJRA@mail.gmail.com>
 <aQxx3Zphpu43l1/p@mail.gmail.com>
 <CAADnVQJmg17Z9jWWZ8ejCCNWcnSU0YeRiDHSp__+A0C8QtTMvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJmg17Z9jWWZ8ejCCNWcnSU0YeRiDHSp__+A0C8QtTMvg@mail.gmail.com>

On 25/11/06 09:08AM, Alexei Starovoitov wrote:
> On Thu, Nov 6, 2025 at 1:54 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > On 25/11/05 06:03PM, Alexei Starovoitov wrote:
> > > On Wed, Nov 5, 2025 at 12:58 AM Anton Protopopov
> > > <a.s.protopopov@gmail.com> wrote:
> > > > @@ -21695,6 +21736,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> > > >                 func[i]->aux->jited_linfo = prog->aux->jited_linfo;
> > > >                 func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
> > > >                 func[i]->aux->arena = prog->aux->arena;
> > > > +               func[i]->aux->used_maps = env->used_maps;
> > > > +               func[i]->aux->used_map_cnt = env->used_map_cnt;
> > >
> > > ...
> > >
> > > > It might be called before the used_maps are copied into aux...
> > >
> > > wat?
> >
> > It is called from fixup_call_arg() which happens before
> > the env->prog->aux->used_maps is populated as a copy of
> > env->used_maps.
> >
> > In any case, I will take a closer look and follow up on
> > this after Kubecon (which is the next week).
> 
> Pls look at the diff
> and also
> line 22074:
> func[i]->aux->main_prog_aux = prog->aux;
> line 22099:
> func[i]->aux->used_maps = env->used_maps;

[Sorry for the delay, I was travelling and didn't have access to my lab.]

I've seen this diff and tested it before sending the previous reply.
It didn't work, and it doesn't work now on bpf-next/master: the
"./test_progs -a bpf_insn_array/deletions-with-functions" test
still breaks.

The reason is as follows. There are two cases for which JIT is called
differently.

1) For a program without sub-functions the JIT is called from the
bpf_prog_select_runtime() function. By this time
aux->main_prog_aux->used_maps are populated and thus
aux->main_prog_aux could be used; or just aux, as there is only one
prog.

2) When program has sub-functions, say one, the jit is called from
jit_subprogs() and later the call in bpf_prog_select_runtime() is
skipped. The jit_subprogs() is called before the bpf_check()
epilogue, and thus not func[i]->aux nor aux->main_prog_aux
contain a copy of used_maps, it is only copied later.

To make two cases look the same ("aux->used_maps is correct"), I've
added

    func[i]->aux->used_maps = env->used_maps;
    func[i]->aux->used_map_cnt = env->used_map_cnt;

Note, again, that in case 2, without this copy, no functions will
have used_maps set, even main_prog.

> > > on top of the set:
> > > diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> > > index 61ce52882632..97fcde6d7f07 100644
> > > --- a/kernel/bpf/bpf_insn_array.c
> > > +++ b/kernel/bpf/bpf_insn_array.c
> > > @@ -278,8 +278,8 @@ void bpf_prog_update_insn_ptrs(struct bpf_prog
> > > *prog, u32 *offsets, void *image)
> > >         if (!offsets || !image)
> > >                 return;
> > >
> > > -       for (i = 0; i < prog->aux->used_map_cnt; i++) {
> > > -               map = prog->aux->used_maps[i];
> > > +       for (i = 0; i < prog->aux->main_prog_aux->used_map_cnt; i++) {
> > > +               map = prog->aux->main_prog_aux->used_maps[i];
> > >                 if (!is_insn_array(map))
> > >                         continue;
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 1268fa075d4c..53b9a6cee156 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -22096,8 +22096,6 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> > >                 func[i]->aux->jited_linfo = prog->aux->jited_linfo;
> > >                 func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
> > >                 func[i]->aux->arena = prog->aux->arena;
> > > -               func[i]->aux->used_maps = env->used_maps;
> > > -               func[i]->aux->used_map_cnt = env->used_map_cnt;
> > >                 num_exentries = 0;
> > >                 insn = func[i]->insnsi;
> > >                 for (j = 0; j < func[i]->len; j++, insn++) {
> > >
> > >
> > > all tests still pass.
> > >
> > > If I'm not missing anything, please send a follow up.
> > >
> > > The plan is to split prog_aux into main and subprog,
> > > and subprog will be a fraction of main.
> > > Right now we copy more and more fields for no good reason.
> > > Let's avoid this.

