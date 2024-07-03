Return-Path: <bpf+bounces-33840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21547926C5C
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 01:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AD01F22AE7
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 23:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DF9194A61;
	Wed,  3 Jul 2024 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOj4bcYu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9D01DA313
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 23:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720048489; cv=none; b=uLAoELof+WnuStxi2+XxstgZxY4rirJhfmmiDc6T0maEtLfVekF9Vtq2BfAt3dXaraFA+kRDAjmW1asUGWsBC1MwYg8c/WPO07JRVtW3R/5qUMKN/ilHrj6nEZhERNKUjRmL+2b8lcR5M00mxrGc3SUqYJqcIqffwzt+xBG4f2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720048489; c=relaxed/simple;
	bh=ClfMWHgZbVIRpsDwl+PJEpfxhXO2bWdE0hLr//d/soA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lo9sfky0PBUjpIzPe7OHBSm9VX8WghEtibnbtO4kYrS+AUhdbJrAYk8cdR+/Ynicb7rkm3T5CTzJCkCzlfLj4KRoAHqcF+SU7c0A9xbwyuYN56K+oa8y68IXqiLMXUel9dyGbM4O1/BZvkad+YI/F2RuCTWO+Fm4KdPV+Un2N0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOj4bcYu; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c96f037145so67824a91.3
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2024 16:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720048487; x=1720653287; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PpqS3Slm1dd2XhZRczt+LZpvl5fdtTb54Mr36DAFG6s=;
        b=EOj4bcYuD0lOH0fDRZT0OJUx4wij5P3f7/oNWLVJp+sPFMEWDShcvEZmf5d9GGFSqt
         q7w0GeqvG6CHT8YnzZOi6RkwQ9NL7OgrX+HSMUWkr3jGJ3cDbxfWUKDUTqBVLHYkl9Lb
         Bh0phiMjVJuGKNVoSW709vHO79e2Dd0gvXFplSaANka8N5KuDl8X0PFKAlcyTKkrq0qx
         EGQFuTt9kKA41HuuiCYqvbva6VLNqPJA2v3NabIiWmYT27+s5dYz7E6f9muypmKs9s+z
         Zj4ymegnwjxt4CFYhU9u98lhDWa0qlAHJgds+oN7906BgGAOVWq22FF1pijoHybSJm56
         mBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720048487; x=1720653287;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PpqS3Slm1dd2XhZRczt+LZpvl5fdtTb54Mr36DAFG6s=;
        b=OvYqIc9DEhATDrz9axjY4ldWLzbrONB9j6S5Ck67aJLxlzDtVTAG9L+MeWRL3gnoSe
         gkwyzKvgxNrgXYYB9haRzstUgL1UgkkquyP4x3jSFpSgnesAB1Qcn5Lup5fwL3Im9bqs
         2xnt3n7UgbyuP30xBjBqD/XWhm1KcYi6/wXYKrz5QTbHbAi5N9V1V/zCZfMgCm1RUEF+
         r52t2eiNVM4JNRppkrTdJmVHXWbFPLf1nSoCHIIpEAVke9WaGVxOPNhdhbzXTpCy6+3i
         7NOzotNeeJUYzxmaHtb1sa0/pM8IfuT6RHsoo9611UcAYDk9Dx32T7/tRvPknjzQR8Fo
         oF2A==
X-Gm-Message-State: AOJu0YzopnUWBX6dHXRMlVwMlwLA6LSQN6a/+QvsL7ZwJyQDfG+KBQmA
	64cZ1DgtnyUnV6Ojiu8A6wmzLDd1vqoo4NB5MxlzXDAnSykdybcz
X-Google-Smtp-Source: AGHT+IEN0ZyFdxQzhoCGET86oa/D0sVnSsSdDyuVm6YiJn6gHmn/xP4kmfFc3dl1ksL7rIWs9m7wqg==
X-Received: by 2002:a17:90b:1186:b0:2c9:e44:fb98 with SMTP id 98e67ed59e1d1-2c93d765056mr10029632a91.37.1720048487409;
        Wed, 03 Jul 2024 16:14:47 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a95197asm70618a91.16.2024.07.03.16.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 16:14:46 -0700 (PDT)
Message-ID: <f9f7326c570b6163279a991d71ed0a354ef6f80e.camel@gmail.com>
Subject: Re: [RFC bpf-next v1 3/8] bpf, x86: no_caller_saved_registers for
 bpf_get_smp_processor_id()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  jose.marchesi@oracle.com, puranjay12@gmail.com
Date: Wed, 03 Jul 2024 16:14:41 -0700
In-Reply-To: <mb61ped8ak95g.fsf@kernel.org>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
	 <20240629094733.3863850-4-eddyz87@gmail.com>
	 <CAEf4BzangPmSY3thz6MW5rMzcA+eOgjD4QNfg2b594u8Qx-45A@mail.gmail.com>
	 <ab7694e6802ddab1ea49994663ca787e98aa25a1.camel@gmail.com>
	 <CAEf4Bza7nmnFDvuPLU2xRQ-mZifUKLSiq3ZuE91MCaPoTqtBXw@mail.gmail.com>
	 <mb61ped8ak95g.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-03 at 11:27 +0000, Puranjay Mohan wrote:

[...]

> > > > > @@ -16030,7 +16030,14 @@ static u8 get_helper_reg_mask(const stru=
ct bpf_func_proto *fn)
> > > > >   */
> > > > >  static bool verifier_inlines_helper_call(struct bpf_verifier_env=
 *env, s32 imm)
> > > > >  {
> > > > > -       return false;
> > > > > +       switch (imm) {
> > > > > +#ifdef CONFIG_X86_64
> > > > > +       case BPF_FUNC_get_smp_processor_id:
> > > > > +               return env->prog->jit_requested && bpf_jit_suppor=
ts_percpu_insn();
> > > > > +#endif
> > > >=20
> > > > please see bpf_jit_inlines_helper_call(), arm64 and risc-v inline i=
t
> > > > in JIT, so we need to validate they don't assume any of R1-R5 regis=
ter
> > > > to be a scratch register
>=20
> They don't assume any register to be scratch (except R0) so we can
> enable this on arm64 and riscv.

Puranjay, just out of curiosity and tangential to this patch-set,
I see that get_smp_processor_id is implemented as follows in riscv jit:

  emit_ld(bpf_to_rv_reg(BPF_REG_0, ctx), offsetof(struct thread_info, cpu),
	  RV_REG_TP, ctx);

Where bpf_to_rv_reg() refers to regmap, which in turn has the following lin=
e:

  static const int regmap[] =3D {
	[BPF_REG_0] =3D	RV_REG_A5,
	...
  }

At the same time, [1] says:

> 18.2 RVG Calling Convention
> ...
> Values are returned from functions in integer registers a0 and a1 and
> floating-point registers fa0 and fa1.

[1] https://riscv.org/wp-content/uploads/2015/01/riscv-calling.pdf

So, I would expect r0 to be mapped to a0, do you happen to know why is it a=
5?

[...]

