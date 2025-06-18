Return-Path: <bpf+bounces-60948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2D2ADF0A1
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 17:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2D83A628A
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D762EE5EC;
	Wed, 18 Jun 2025 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxjAL65u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A858D2EB5C9
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258965; cv=none; b=NGsczBk9k8kuFz4wchcBr2pVRusMTUORiC6L4IvsPBCrUoH6gJM3Poty83LEDNRFgPnVv2mLpzg40YX/PUjbIz8L9lmYOcV3+QyMvL8Gk3pszdckLq88xskOf7ZoYA/dajMldB2ttQ3fa8X8ykzYMplN1pu6TXLbmXh7r9/Kot0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258965; c=relaxed/simple;
	bh=sXkDppOa6rcnZZR7hP9SjEuI1jqbfhQ9DYE07E0Nu4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0NgxrCL3v0nPhN5TJTy00cOdlKbr2vNaTEdxzi+cGbrNrww/QzuUD9vV3RciytXsNOQFqmWZmwNafZ4DGTb/tLEt7ekxXwyEymp//s4HclGEqv/faOPRGQxU3LLJVSXILLCL3BIQJWleAtFFYEDxoXK8ErIzc6j+jqOyEZVLvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxjAL65u; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a36748920cso8383151f8f.2
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 08:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750258962; x=1750863762; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dnHoNavC/AzvzFvuJVlV26ty+sgzg5ysQfyg3r41LGI=;
        b=bxjAL65uhXu8sLV0WJZ+UE+secOvIxDs3Lz1FQXqXMrzzHg0M3phIpdX02xw94IL41
         3tXaP/hQcrHlyvD3Qw2haLMquIl98FlE8il977+GZjlHZrTKVmsxBQF3w2kpgD4t3Spa
         92tai7zPNZPgdxjKYS4jLqlXwC2xv8rZfZqe5j3jw8D4Cm59rAFK4WHRADz4CbMcSh5A
         r1ZIpsXwHulOvc1OIPi8lcMIs+aOvLPRl8D+WA537kU5PySfQafm3w+DLyzbqIYMCrJe
         1GuFf+vMX4onBcgBck97tDZJVFvkaAiE7NJnL45NxJqt7YkiYH0qsrUNQl1uesiVv6yS
         2Q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750258962; x=1750863762;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnHoNavC/AzvzFvuJVlV26ty+sgzg5ysQfyg3r41LGI=;
        b=OLhf7jG11+pkuhMoXrIu+vD+7bB98Fmd4ZD9r8cApKES4kM9rw5D3xIQXPLtCfUwWL
         z+h9FeU4JITcMXVl7ueNRhQwW40MDrX1II2Jl+17jTipRLD4+NF46eyECNhjjgQ391LD
         nT64ltURzD1VLbwFIPhWcIpVg7QNDAOstEjj69iArSIrfIETwVI4KhrrkmpVrViVIR2q
         9mlD2AFEEqvdPbcAOnjC/Y2pqz/Z9sX+LRV7Igo2ZpR/9G7iELkvi7hb4g9vV2Yfc9tX
         0uaiuftbJK99tXLPMzbpXqbV9dyqDK+4tdj1+vvF23YMA/HZXg9kmWTQz3M/YCZP64Zk
         F+mw==
X-Gm-Message-State: AOJu0Yw56FTO3JkyqK+ulduApvJVnqU/q3KwBNx9oo5oEr+vUM2DPmDR
	ATBI9CdCADAByB0euImQFafFRVOoajH8sjmr48Qj32NUiQbh4E0c715F
X-Gm-Gg: ASbGncuiswHfUqUOpwor3wyAsI8Pwyy6/lujMygYWpM8CIGEHRvBTUkGcMoOGmUi3iK
	jNXQ5v90nR4QVITt/fAimg4w0ab+Dl4ZLphAso8NXyYOpjWtMIp1lSyzNGNq/Ue4Yr9MRiK83Fs
	Nnj9bRLcwSpqwggr59mBeE8IV9Tz1RZYTsijQXx6g+/yK0O8Wry2pzizbCnmO3n13QrdYKTiBjI
	JHwwru6LiW9Ebxer7EECawY0OBuxMZQIa5aqHcpEA04J2BIdxVxQ5lLE6OmrmEpZ6QHVQrNDUkV
	wskeGuFBo/BfaVGZonsxuTGARaCHSe03kCswfGddQAhzRzcZrbP57iixqhCrjRojrlupp5FFiA=
	=
X-Google-Smtp-Source: AGHT+IE1KllU0BKfq0C6G6b4T4fWVOrdmyBsIhxMmquIi+NhcA+d9oI9IjYjXsgQrkAxQLw4IRQkcA==
X-Received: by 2002:a05:6000:2c10:b0:3a4:de02:208 with SMTP id ffacd0b85a97d-3a57238421cmr15813090f8f.25.1750258961118;
        Wed, 18 Jun 2025 08:02:41 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a577e928f7sm13663159f8f.64.2025.06.18.08.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 08:02:40 -0700 (PDT)
Date: Wed, 18 Jun 2025 15:08:24 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
Message-ID: <aFLWaNSsV7M2gV98@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
 <CAADnVQKhVyh4WqjUgxYLZwn5VMY6hSMWyLoQPxt4TJG1812DcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKhVyh4WqjUgxYLZwn5VMY6hSMWyLoQPxt4TJG1812DcA@mail.gmail.com>

On 25/06/17 08:22PM, Alexei Starovoitov wrote:
> On Sun, Jun 15, 2025 at 1:55 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > The final line generates an indirect jump. The
> > format of the indirect jump instruction supported by BPF is
> >
> >     BPF_JMP|BPF_X|BPF_JA, SRC=0, DST=Rx, off=0, imm=fd(M)
> >
> > and, obviously, the map M must be the same map which was used to
> > init the register rX. This patch implements this in the following,
> > hacky, but so far suitable for all existing use-cases, way. On
> > encountering a `gotox` instruction libbpf tracks back to the
> > previous direct load from map and stores this map file descriptor
> > in the gotox instruction.
> 
> ...
> 
> > +/*
> > + * This one is too dumb, of course. TBD to make it smarter.
> > + */
> > +static int find_jt_map_fd(struct bpf_program *prog, int insn_idx)
> > +{
> > +       struct bpf_insn *insn = &prog->insns[insn_idx];
> > +       __u8 dst_reg = insn->dst_reg;
> > +
> > +       /* TBD: this function is such smart for now that it even ignores this
> > +        * register. Instead, it should backtrack the load more carefully.
> > +        * (So far even this dumb version works with all selftests.)
> > +        */
> > +       pr_debug("searching for a load instruction which populated dst_reg=r%u\n", dst_reg);
> > +
> > +       while (--insn >= prog->insns) {
> > +               if (insn->code == (BPF_LD|BPF_DW|BPF_IMM))
> > +                       return insn[0].imm;
> > +       }
> > +
> > +       return -ENOENT;
> > +}
> > +
> > +static int bpf_object__patch_gotox(struct bpf_object *obj, struct bpf_program *prog)
> > +{
> > +       struct bpf_insn *insn = prog->insns;
> > +       int map_fd;
> > +       int i;
> > +
> > +       for (i = 0; i < prog->insns_cnt; i++, insn++) {
> > +               if (!insn_is_gotox(insn))
> > +                       continue;
> > +
> > +               if (obj->gen_loader)
> > +                       return -EFAULT;
> > +
> > +               map_fd = find_jt_map_fd(prog, i);
> > +               if (map_fd < 0)
> > +                       return map_fd;
> > +
> > +               insn->imm = map_fd;
> > +       }
> 
> This is obviously broken and cannot be made smarter in libbpf.
> It won't be doing data flow analysis.
> 
> The only option I see is to teach llvm to tag jmp_table in gotox.
> Probably the simplest way is to add the same relo to gotox insn
> as for ld_imm64. Then libbpf has a direct way to assign
> the same map_fd into both ld_imm64 and gotox.

This would be nice.

> Uglier alternatives is to redesign the gotox encoding and
> drop ld_imm64 and *=8 altogether.
> Then gotox jmp_table[R5] will be like jumbo insn that
> does *=8 and load inside and JIT emits all that.
> But it's ugly and likely has other downsides.

I did this in my initial draft for LLVM (and supporting different
kind of instructions was done using bits in SRC). But the "native"
approach looks better for me now, especially if compiles can be
taught to link load&gotox.

