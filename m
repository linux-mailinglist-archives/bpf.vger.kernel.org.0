Return-Path: <bpf+bounces-64473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F911B13318
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 04:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE250165C8E
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 02:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04DC1F3BA4;
	Mon, 28 Jul 2025 02:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6DcBs3W"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2517E7DA93;
	Mon, 28 Jul 2025 02:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753670578; cv=none; b=l1/5QW3jXRr2kl1FRPyTTiLfUiIzrQN4J3IFMcfDGJUDmozhJfENfdy1fE0MuajSBw963ZFU0GHodlzsXaNVDchL/lGXbfCmR1J3/mZhi8AYqT8cBgvgskpBDTaN3RCf4LvxedHxhOoeMj38AtJvmJBRhNFo+1/XdRwjNGgeT9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753670578; c=relaxed/simple;
	bh=+ZFXkLf61aLkfibNILDeIzWrO9OCofPYG73YDnpuTgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3pOXSzYIsUVoHdGHm5YpQ6ZtMRMXfgnGc8siHOj4jMpPpd9V8IKUVXjYPKcD74VKhgcFCGfUD0g4XSkKMflEr55r4mFGOoPPoF1ZfsaAR6knbB7GlPYDtJALJ1pPZV5aFNNGBZn8TVDeU15ObheiEcqxvhqWojjlNGp6qp2Zrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6DcBs3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE4EC4AF09;
	Mon, 28 Jul 2025 02:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753670577;
	bh=+ZFXkLf61aLkfibNILDeIzWrO9OCofPYG73YDnpuTgM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F6DcBs3Wpqfm/cGFxQUJEGUwMDIzbAaCJ/yX0eBfmSobqng+GqCCO7pXfkuGUn6FB
	 HYelZkqfFZQQI3C//ORpzasxUhO+0JZWcZS5WaKwXMdSV5A0ZfQ8BpevTe12TJQZZt
	 0uwLpHqzgKSbma9GoIKWbuyolcXlgHbYfj/XrxxARYJYfkkiloNY0QWK4j+sdnXan7
	 ppxY/OxVOAou9dEsGYPWpKPc4Mg4MvAI7NHHKrQskGm/wcx/EwhbB/BKN92WLQBmOJ
	 bZoyrNmncS7+5M7y/5iF9cFuPe0OPJdTEZUp2ct8qkiuAbmCCZGRXJt50+AfrOzqGZ
	 MhVboyQSosvOQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aec5a714ae9so549080166b.3;
        Sun, 27 Jul 2025 19:42:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMZluTlyOD1zOFIMxEuAeqquwQskHcLFoIIuDgjvQWwph+IyPMiJTh7paboFhK9BeZ6ZBF5H8DBWU0aPOh@vger.kernel.org, AJvYcCXsxc2s/IC4qJHknE8c17NR/1iGjcNeTTAeZ7MGEq7HY31t396dg+ZSf2ZVfH32E3HwLVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyog7DF/FRSfiRRT9JDPDkEJV64TeJ3Q6oAFfr9vm5/wfSicpe3
	RpDaIjYQ9JGE7G8rOPfFlED1Vjq7ScQ9cE4p9XkrkMGwKE8+xz30Z0Kv4ghF8hEbq9uLt6UoeU8
	s5slT10+2Rke/8EUZWsiOZE+yPKEb2sM=
X-Google-Smtp-Source: AGHT+IHndJ+0yahCGSN8pkWQx7GixFZRTGUFgRMI6PGyIdHt+uIOCB4oJ9hM+wyRpr22uFUEABlyiFCvIn9LOv3YE10=
X-Received: by 2002:a17:907:3d0d:b0:ae2:60ba:da91 with SMTP id
 a640c23a62f3a-af61ca99878mr1194111166b.15.1753670576128; Sun, 27 Jul 2025
 19:42:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724141929.691853-1-duanchenghao@kylinos.cn> <c4bf63161e13ce1b51a288b1fd0f3fb0b1170f22.camel@kernel.org>
In-Reply-To: <c4bf63161e13ce1b51a288b1fd0f3fb0b1170f22.camel@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 28 Jul 2025 10:42:45 +0800
X-Gmail-Original-Message-ID: <CAAhV-H67QrAOf=u2onBO-13m8grVn8PxMaF+huxK5tQTWWHUsA@mail.gmail.com>
X-Gm-Features: Ac12FXw6DsLQatIhv84ndR_uR-p0z2VH5B2EE3ZtCtDioi3KHw1nxBErgy4wb4E
Message-ID: <CAAhV-H67QrAOf=u2onBO-13m8grVn8PxMaF+huxK5tQTWWHUsA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Support trampoline for LoongArch
To: Geliang Tang <geliang@kernel.org>
Cc: Chenghao Duan <duanchenghao@kylinos.cn>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, yangtiezhu@loongson.cn, hengqi.chen@gmail.com, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn, 
	vincent.mc.li@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 9:00=E2=80=AFAM Geliang Tang <geliang@kernel.org> w=
rote:
>
> Hi Chenghao, Huacai, Tuezhu,
>
> I first discovered this Loongarch BPF trampoline issue when debugging
> MPTCP BPF selftests on a Loongarch machine last June (see my commit
> eef0532e900c "selftests/bpf: Null checks for links in bpf_tcp_ca"), and
> reported it to Huachui. Tiezhu and I started implementing BPF
> trampoline last June. I also called on more Chinese kernel engineers to
> participate in the development of the Loongarch BPF trampoline at the
> openEuler Developer Day 2024 and CLSF 2024 conferences. Although this
> work was finally handed over to Chenghao, it is also necessary to
> mention me as the reporter and our early developers in the commit log.
Thank you for reminding me, since the 3rd patch need to be fixed,
chenghao can do that as soon as possible, then adjust the SOB together
in V5.

Huacai

>
> Thanks,
> -Geliang
>
> On Thu, 2025-07-24 at 22:19 +0800, Chenghao Duan wrote:
> > v4:
> > 1. Delete the #3 patch of version V3.
> >
> > 2. Add 5 NOP instructions in build_prologue().
> >    Reserve space for the move_imm + jirl instruction.
> >
> > 3. Differentiate between direct jumps and ftrace jumps of trampoline:
> >    direct jumps skip 5 instructions.
> >    ftrace jumps skip 2 instructions.
> >
> > 4. Remove the generation of BL jump instructions in
> > emit_jump_and_link().
> >    After the trampoline ends, it will jump to the specified register.
> >    The BL instruction writes PC+4 to r1 instead of allowing the
> >    specification of rd.
> >
> > ---------------------------------------------------------------------
> > --
> > Historical Version:
> > v3:
> > 1. Patch 0003 adds EXECMEM_BPF memory type to the execmem subsystem.
> >
> > 2. Align the size calculated by arch_bpf_trampoline_size to page
> > boundaries.
> >
> > 3. Add the flush icache operation to larch_insn_text_copy.
> >
> > 4. Unify the implementation of bpf_arch_xxx into the patch
> > "0004-LoongArch-BPF-Add-bpf_arch_xxxxx-support-for-Loong.patch".
> >
> > 5. Change the patch order. Move the patch
> > "0002-LoongArch-BPF-Update-the-code-to-rename-validate_.patch" before
> > "0005-LoongArch-BPF-Add-bpf-trampoline-support-for-Loon.patch".
> >
> > URL for version v3:
> > https://lore.kernel.org/all/20250709055029.723243-1-duanchenghao@kylino=
s.cn/
> > ---------
> > v2:
> > 1. Change the fixmap in the instruction copy function to
> > set_memory_xxx.
> >
> > 2. Change the implementation method of the following code.
> >       - arch_alloc_bpf_trampoline
> >       - arch_free_bpf_trampoline
> >       Use the BPF core's allocation and free functions.
> >
> >       - bpf_arch_text_invalidate
> >       Operate with the function larch_insn_text_copy that carries
> >       memory attribute modifications.
> >
> > 3. Correct the incorrect code formatting.
> >
> > URL for version v2:
> > https://lore.kernel.org/all/20250618105048.1510560-1-duanchenghao@kylin=
os.cn/
> > ---------
> > v1:
> > Support trampoline for LoongArch. The following feature tests have
> > been
> > completed:
> >       1. fentry
> >       2. fexit
> >       3. fmod_ret
> >
> > TODO: The support for the struct_ops feature will be provided in
> > subsequent patches.
> >
> > URL for version v1:
> > https://lore.kernel.org/all/20250611035952.111182-1-duanchenghao@kylino=
s.cn/
> > ---------------------------------------------------------------------
> > --
> >
> > Chenghao Duan (4):
> >   LoongArch: Add larch_insn_gen_{beq,bne} helpers
> >   LoongArch: BPF: Update the code to rename validate_code to
> >     validate_ctx
> >   LoongArch: BPF: Add bpf_arch_xxxxx support for Loongarch
> >   LoongArch: BPF: Add bpf trampoline support for Loongarch
> >
> > Tiezhu Yang (1):
> >   LoongArch: BPF: Add struct ops support for trampoline
> >
> >  arch/loongarch/include/asm/inst.h |   3 +
> >  arch/loongarch/kernel/inst.c      |  60 ++++
> >  arch/loongarch/net/bpf_jit.c      | 521
> > +++++++++++++++++++++++++++++-
> >  arch/loongarch/net/bpf_jit.h      |   6 +
> >  4 files changed, 589 insertions(+), 1 deletion(-)

