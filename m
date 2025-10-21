Return-Path: <bpf+bounces-71613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B60BF80AF
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 20:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 181204ECBDD
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 18:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EA734F259;
	Tue, 21 Oct 2025 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Smyh9A02"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365193451DF
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071164; cv=none; b=OzRSGFKmleg1RipBCu0GujJNzXsRQmcFlDL/SIMymP/SVmqbpNw2kT0pwBGy3cLam6RWLJifp4Obw6n1XQxlFqMhwvVnx2SEsRL42LMd6sxmrosX7Ws1w2edKGEnS7sJgWyOF/4XP/7Oaz978qYchtM9aea8YFHTA36atILhi2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071164; c=relaxed/simple;
	bh=kpj6aLukt/YKBoGEQxbQjwL4VOk/WvbRVbmsgNiMwik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLPvpblrz7msby1Cl+zXrAMVwg2nW7BDkWBXQ4S0FjY7yqWq2KjZV6tqgteOFsT53f9tX9ka37l6Rvg1Hne2FNdOg66gQwbLA1EuAw+lb7HNlb/CG+HPS8Qyr/YYGezBFBUYC7FNiciATm01ZKFXdJZ0WrP/cvZaXK0CNhY7yHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Smyh9A02; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47495477241so10991835e9.3
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761071160; x=1761675960; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ANsTxB4TdfBvBgFJRqmuGWNDtJE+ywQjEhMagi1EgVo=;
        b=Smyh9A02MwshjSrdeKAEFS8NyO8HUmBZzZ315bDs9LOp4aazr77fi/73v4lsXj6TKt
         SOoocbMRseVFwZP17GpTnTL4Typgyw0ElrnS+TKuSQwZthfO95LSBdSTuLs1hZpt908Q
         EhFZulP8mShjBvE0LOVC9nli4wzVChpcphYSkDow/sxFgq5kTArNf8d6CA+z+xJD3pIW
         sX0LU+PreugYcyHxP/HZsJGWIna//hSLyaVDNBvY9OkWa7kRLk5rjXN0RPpzGKGeLAJQ
         5izadryNPorYEbwGuvt2ZWm4ymTcySaA5DYZH09EJdsYUjfBL9idKJ4nrwJr/jEOZlNV
         Udgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071160; x=1761675960;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANsTxB4TdfBvBgFJRqmuGWNDtJE+ywQjEhMagi1EgVo=;
        b=E8+f7HTvWYlGt1Jiq9nuYSU7tFbyVKWcF5Wb4DYr57nb6kj5NPzoENYciNo2OrCBGS
         hmClnyb2mRzpFNyf30frkVZHnJy9cxDeF1G1jOr2PhV+GQoNkRzMgy3LuLX/2/zzytr+
         lUurAJarHcM8j5Bdl/7R3X/jmnOFYMW9MrcBr1pLHX7K99ShYvU+aKV2wO3V7H+E41JD
         oHPjNyRB/IIeA6LlsJNSzmiBLIKwVN58Rdhc19ZoX9aXGO4aU5S6rkWUMfETCPiA9mr2
         Uqh77Jm4IZ5pQctshwlQsMt/l0+d+I4o95Em+Q4o5NJNOgasDxuSTZ9RhTpqoYA0FmR7
         gkTw==
X-Gm-Message-State: AOJu0YyAWNFoyFCfjI6NC0rO/PudWkXXwv0FTlHA7n5qjLXn2AmHTUiS
	DN0GzpOcA2SU1UTWAdZ6ulPbNur3O/MLHlw66bsoKzqG4tECI3kx3yP1
X-Gm-Gg: ASbGncvEDqJ5CCeefN1M3HNMcgoD+rHf68d+uefGVOM/psH/4YF2hsyEzxayKEYuzR1
	AahagTFGMXQDPTLuyiBBjJpK8k344zlnrAHhsE3Yga/lLl9QusqlspD8IGXANk9THovOw9ihowa
	MAf9YtJX4Y6c885YeoDsjCfky/55dodyjUe063wl0xovThwhHGlBfihlmuOKpWQ0GOVO752HN2b
	uaASMVJb0FwB+feT5WVc/647wQUoWuvJafNndZ9lWIJ7ht96glFWX4uamfjFtrZiryQykpgc1n8
	Ogl+bs5r/veoal0C5+DZxX/wM7VfL/9fAPoE3SFmuzGQhGir46jyqE1dL/xVbUEa+be35Rrhl/Y
	eodGiiZTXrON90pbz9JKlDxT+wfufJNyz9nq7CkLWSu2Acus7be62hkoxFpDd2RMASorElMjaKp
	1FG3hdwbp+lEWdOy8ANITb
X-Google-Smtp-Source: AGHT+IGA9ec1iouUvWHeUsZYV37jpQq7eEQAwrODHGIAVFsv2X+t+7y5uEqN0uNlsVfRDemug/GFBw==
X-Received: by 2002:a05:600c:4e93:b0:471:9da:524c with SMTP id 5b1f17b1804b1-4711789e39emr125989155e9.12.1761071160196;
        Tue, 21 Oct 2025 11:26:00 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c42b1260sm5727805e9.13.2025.10.21.11.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:25:59 -0700 (PDT)
Date: Tue, 21 Oct 2025 18:32:40 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v6 bpf-next 04/17] bpf, x86: add new map type:
 instructions array
Message-ID: <aPfRyNQVP53swJ0l@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
 <20251019202145.3944697-5-a.s.protopopov@gmail.com>
 <CAADnVQLOtQWMb4eOtLXyXhWrkPV8DKdYajb+DbG=sSucEbtJFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLOtQWMb4eOtLXyXhWrkPV8DKdYajb+DbG=sSucEbtJFw@mail.gmail.com>

On 25/10/21 10:49AM, Alexei Starovoitov wrote:
> On Sun, Oct 19, 2025 at 1:15 PM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index d4c93d9e73e4..c8e628410d2c 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1691,6 +1691,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
> >         prog = temp;
> >
> >         for (i = 1; i <= insn_cnt; i++, insn++) {
> > +               u32 abs_xlated_off = bpf_prog->aux->subprog_start + i - 1;
> >                 const s32 imm32 = insn->imm;
> >                 u32 dst_reg = insn->dst_reg;
> >                 u32 src_reg = insn->src_reg;
> > @@ -2751,6 +2752,13 @@ st:                      if (is_imm8(insn->off))
> >                                 return -EFAULT;
> >                         }
> >                         memcpy(rw_image + proglen, temp, ilen);
> > +
> > +                       /*
> > +                        * Instruction arrays need to know how xlated code
> > +                        * maps to jitted code
> > +                        */
> > +                       bpf_prog_update_insn_ptr(bpf_prog, abs_xlated_off, proglen,
> > +                                                image + proglen);
> 
> ...
> 
> > +void bpf_prog_update_insn_ptr(struct bpf_prog *prog,
> > +                             u32 xlated_off,
> > +                             u32 jitted_off,
> > +                             void *jitted_ip)
> > +{
> > +       struct bpf_insn_array *insn_array;
> > +       struct bpf_map *map;
> > +       int i, j;
> > +
> > +       for (i = 0; i < prog->aux->used_map_cnt; i++) {
> > +               map = prog->aux->used_maps[i];
> > +               if (!is_insn_array(map))
> > +                       continue;
> > +
> > +               insn_array = cast_insn_array(map);
> > +               for (j = 0; j < map->max_entries; j++) {
> > +                       if (insn_array->ptrs[j].user_value.xlated_off == xlated_off) {
> > +                               insn_array->ips[j] = (long)jitted_ip;
> > +                               insn_array->ptrs[j].jitted_ip = jitted_ip;
> > +                               insn_array->ptrs[j].user_value.jitted_off = jitted_off;
> > +                       }
> > +               }
> > +       }
> > +}
> 
> This algorithm doesn't scale.
> You're calling bpf_prog_update_insn_ptr() for every insn
> and doing it as many times as they're JIT passes.
> There could be up to 20 passes and hundreds of thousands of insns.
> x86 JIT already keeps the mapping from insn to IP in jit_datat->addrs[].
> Use it. Roughly like:
> insn_array = cast_insn_array(map);
> for (j = 0; j < map->max_entries; j++) {
>    ip = addrs[insn_array->ptrs[j].user_value.xlated_off -
> subprog_start] + image;
> And this is done once per insn_array after JIT is done.

Thanks! Will do.

