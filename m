Return-Path: <bpf+bounces-33500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 617E691E321
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 17:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073E41F21CCF
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF90E16C84C;
	Mon,  1 Jul 2024 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjnKpk9J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC2016B739;
	Mon,  1 Jul 2024 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846101; cv=none; b=icRjMsahMsVKsCqnv8JSstcNeKdnmbZ3ir5KmGCw78ZMsewRVVPRtlHZCyD/DCXOBN92YLhmd5l+ZLqy1ihWJGEJvgpKdBfgYwNVPYImRwVX0bdoctVqW7lfOuJS4OvpcyDYSmwIwvmBo4nwt8gaoTi+gPKciTm1djqlUCmFR0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846101; c=relaxed/simple;
	bh=ABvpPirgDymHngsRUpcwej27uh5jlGJQls9PaiHXP0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NrlPsPkb21l1L7XkUXLvsV6jehEdPRs093eZdtNqhG35xSfk5Wc/OJnwdRmY634x+4fwtB2R7c6uQ8LsDmgFWK6oSE2Lb5zEtiaQjNljD+yNT9GW80T0lg0mJVtzU91F2LhD2RqD3tTdOZEvWsya13uFDa2jIyI23o7YQ0diGTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjnKpk9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDB2C4AF0D;
	Mon,  1 Jul 2024 15:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719846101;
	bh=ABvpPirgDymHngsRUpcwej27uh5jlGJQls9PaiHXP0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cjnKpk9Jxta1tmVipwVY/V7wlzDa4mS07YJGE5Lq4VrcBYJGTqn03Lt4BM2mOqXTL
	 /FjSbK285snVcCUdW9vir7Rla+U7V5ztPY8FPLZTthwJmk0BPRsuwg35lABoT8b0Wf
	 kbpzLayDlDCogXaKDQHg2ItopU4E90F151oMQVLIzvwTW2logbQxq/eNxlKvPahGKs
	 kiHx+N7e0jtdU6x+Ptf3eL0cR0dytTTESAjYYkvM1JVh4Eh2UNgXJre3rEatMGhRvm
	 38NgzXMla1PazEs7uUzvOYz+KxJ38NHzIgCC5bFPErCCQxP64NKgU6cM8Gyjfnyh2Z
	 qFf/EVvXbU4ww==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a724a8097deso374592266b.1;
        Mon, 01 Jul 2024 08:01:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUY2xOsf9rVTL7U9mFE6Jrd6/0bbkmjFRBLysKNz21dzfAKBcXIjSbZKz8bI2zPC2ouuMENUAJK3foAAjltWmvMAm5PAafAqpsTF931ATvPnotg4hY50oZXS7gLiVRyPRb4fxB4IFoA7x5iJ0tBttgvAnAFQwnLCOoN3wyNi+LlUuDxPKpj
X-Gm-Message-State: AOJu0YxIxnlfjPD5sA0p8JzoaTCy0Qd/oHi2DWqqHdeS8bxBJYH04hE9
	NkxrxgCJxEWh1g19jciT1sVaOi640QA7plrQzpI5XeI+w+qh93S0KYWWRrKsOk/9CLFRNdA25S+
	g81ypv2c9gi7juWgkB1K5LFoKGCU=
X-Google-Smtp-Source: AGHT+IH9cvBZlZ9SVpr1fbztwtyHo/IWmpwga95XhMPugjWfjFCA0EEYNnDOD02gQFtrn7M18jzGcoZrhDNm4C9nHBs=
X-Received: by 2002:a17:907:a0c9:b0:a6f:bc02:a008 with SMTP id
 a640c23a62f3a-a7514402354mr459434866b.4.1719846099486; Mon, 01 Jul 2024
 08:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627173806.GC21813@redhat.com> <37f79351-a051-3fa9-7bfb-960fb2762e27@loongson.cn>
 <20240629133747.GA4504@redhat.com> <CAAhV-H4tCrTuWJa88JE96N93U2O_RUsnA6WAAUMOWR6EzM9Mzw@mail.gmail.com>
 <20240629150313.GB4504@redhat.com> <0ed72555-372a-64ff-5d0e-a6567650bd91@loongson.cn>
In-Reply-To: <0ed72555-372a-64ff-5d0e-a6567650bd91@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 1 Jul 2024 23:01:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5Pr2UmOTezMtO8GfAWEbWkSJ4aUJFusLWxDNn3VyTXXA@mail.gmail.com>
Message-ID: <CAAhV-H5Pr2UmOTezMtO8GfAWEbWkSJ4aUJFusLWxDNn3VyTXXA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: make the users of larch_insn_gen_break() constant
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Oleg Nesterov <oleg@redhat.com>, andrii.nakryiko@gmail.com, andrii@kernel.org, 
	bpf@vger.kernel.org, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, mhiramat@kernel.org, nathan@kernel.org, 
	rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 2:22=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn>=
 wrote:
>
> On 06/29/2024 11:03 PM, Oleg Nesterov wrote:
> > LoongArch defines UPROBE_SWBP_INSN as a function call and this breaks
> > arch_uprobe_trampoline() which uses it to initialize a static variable.
> >
> > Add the new "__builtin_constant_p" helper, __emit_break(), and redefine
> > the current users of larch_insn_gen_break() to use it.
> >
> > The patch adds check_emit_break() into kprobes.c and uprobes.c to test
> > this change. They can be removed if LoongArch boots at least once, but
> > otoh these 2 __init functions will be discarded by free_initmem().
> >
> > Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return =
probe")
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Closes: https://lore.kernel.org/all/20240614174822.GA1185149@thelio-399=
0X/
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
>
> Tested on LoongArch machine with Loongson-3A5000 and Loongson-3A6000
> CPU, based on 6.10-rc3,
>
> KPROBE_BP_INSN =3D=3D larch_insn_gen_break(BRK_KPROBE_BP)
> KPROBE_SSTEPBP_INSN =3D=3D larch_insn_gen_break(BRK_KPROBE_SSTEPBP)
> UPROBE_SWBP_INSN  =3D=3D larch_insn_gen_break(BRK_UPROBE_BP)
> UPROBE_XOLBP_INSN =3D=3D larch_insn_gen_break(BRK_UPROBE_XOLBP)
>
> The two functions check_emit_break() can be removed in
> arch/loongarch/kernel/kprobes.c and arch/loongarch/kernel/uprobes.c
>
> Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Queued, thanks.

Huacai
>
> Thanks,
> Tiezhu
>
>

