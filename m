Return-Path: <bpf+bounces-37864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2C995B712
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 15:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008C6280CAB
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 13:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB651CB318;
	Thu, 22 Aug 2024 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTZT6gVX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561BB1E87B
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334442; cv=none; b=fCYtgeMgwm3llLJkk2NUdcR+yufdeZddHN9HKnwLWrWJ+loNyfLXNjXxCh8pXtiUa+5XVFkGeCQYqYZli1g8KYhSS5UDijV9Q1+/b4qajRVVZloOBPKb6SlYv5owPeyn9b3EEYOUzBXaM22XI79nUSkSz20A7AaEPVastaGODWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334442; c=relaxed/simple;
	bh=X6e6DH3cSmwoGNPU9msOZWzsJ/U83yp/3i5pRS9qE5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfUUDJbksUucvirfrJY9UQRs+kJn4Z4b04h5NgOPC8vJLlQyU+3YEMsHMM4q6GZy7mTe6/Qy0E9Pss84+5CiKMMX1ljyvuuk7nQm/DYQirKj4v4c4/xwvTEOqcSHs8a1Wq40ld0Xex14WyJKPsIPYhxSHg4zN1CfIKOO46vpyCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTZT6gVX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428e0d18666so5912115e9.3
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 06:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724334440; x=1724939240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDH+NVCNwYObLdKiUoI9AuNDjIKVSCLSMnS+bBoa/hQ=;
        b=fTZT6gVXzSNyqUbJf0UiJXZ4w1Tyr2iRGHFsQ19LaQZ2mbsrjVZmMb4ovPXFSJFwqa
         qH3GG2yGZTFT3ulPjMrvo4YgTxq9wADUQh4wsGz4KS97nG/81BV8ojBJOJUE4oQYbUJ+
         OmjeKlixPwFpa86FkjEjk+t/4PWJb+i+O80BZakIObChPsvCTSLDdydpf0VttJs0Ki7/
         2OuBl0WVrUdvdkEh71hansGeuCIzzk0nRa4Pso0ThZrBcMrotvtQl3N+zWTDj6wAPCk6
         d7rOYKzgAHaqRtyocG3d+DJuVYu/bpRxM13nwtdefKYDQHXD869OJzfHwJwDf99PjkKn
         HdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334440; x=1724939240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDH+NVCNwYObLdKiUoI9AuNDjIKVSCLSMnS+bBoa/hQ=;
        b=r4ZUAyol30ugcXnfFUy+wTUs/MdxJ7e9Rs///KHjY9pCZ4oih8J3VV6XNROAkWXVkT
         8FwjnMAWStc4QuMLG0okr/n1cTXBH7izQbgWlIZyQ8q5kxCHz4kVDi9g7LtkaTaAQUzr
         0Dp6m5vaUEpRfdBf2kaeNNd5mKfvtLbvDAv94pZGmCHiKNYe61K6ESe6jT/yLyhtd1+l
         PHpfx77HPg+HSF0k6hVMYQVg1aM/Us9iPoqQfMnhAkPETcXWpd+si94ABN5SfhKR8Wpo
         F3eA1YvfIC2cMvHhplXSeM/qRTV/d6XT2rWKL32HtRQfSbeZR1pA80WxBJdntK00OXfn
         uKMw==
X-Gm-Message-State: AOJu0YynKtO84RpNbxhCVBX3E7k3NoRdFn1lqBA7igMRi5CwnGFCxw2y
	6MAT4B09TVDowM/f3yk67FQNSKKHm57wIlTbXJJIdWcssBV9hjaFZFagk/Q8AbPnxZHnEYhCQBj
	leNGTh+wyh6CGzbZo7js4Nz96QNmyEw==
X-Google-Smtp-Source: AGHT+IHdLMZUBx0IJN5N+O1UJ8QFUYj9pThGPIdmaye2UTrWl2tBjjL/Zfjzx/GB0NmKQ1zsML6WrWNq/+cDsS75c1g=
X-Received: by 2002:a05:600c:4e93:b0:427:fa39:b0a1 with SMTP id
 5b1f17b1804b1-42abd253b01mr32609785e9.36.1724334439254; Thu, 22 Aug 2024
 06:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821233440.1855263-1-martin.lau@linux.dev>
 <20240821233440.1855263-8-martin.lau@linux.dev> <CAADnVQK4LUVsKQYHdaw0x9-CryA0wQX6stkvhFnNoDh1tt0jhg@mail.gmail.com>
 <7a4aa80b-b5fe-4f9a-95a3-743d2a218927@linux.dev>
In-Reply-To: <7a4aa80b-b5fe-4f9a-95a3-743d2a218927@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Aug 2024 06:47:07 -0700
Message-ID: <CAADnVQ+b1Y3cb4mEMWMPw32=+q5_Gb26Ejuqj+=_LMwGvjROkw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 7/8] bpf: Allow pro/epilogue to call kfunc
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Amery Hung <ameryhung@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 11:10=E2=80=AFPM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 8/21/24 6:32 PM, Alexei Starovoitov wrote:
> > On Wed, Aug 21, 2024 at 4:35=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >> From: Martin KaFai Lau <martin.lau@kernel.org>
> >>
> >> The existing prologue has been able to call bpf helper but not a kfunc=
.
> >> This patch allows the prologue/epilogue to call the kfunc.
> >>
> >> The subsystem that implements the .gen_prologue and .gen_epilogue
> >> can add the BPF_PSEUDO_KFUNC_CALL instruction with insn->imm
> >> set to the btf func_id of the kfunc call. This part is the same
> >> as the bpf prog loaded from the sys_bpf.
> >
> > I don't understand the value of this feature, since it seems
> > pretty hard to use.
> > The module (qdisc-bpf or else) would need to do something
> > like patch 8/8:
> > +BTF_ID_LIST(st_ops_epilogue_kfunc_list)
> > +BTF_ID(func, bpf_kfunc_st_ops_inc10)
> > +BTF_ID(func, bpf_kfunc_st_ops_inc100)
> >
> > just to be able to:
> >    BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0,
> >                 st_ops_epilogue_kfunc_list[0]);
> >
> > So a bunch of extra work on the module side and
> > a bunch of work in this patch to enable such a pattern,
> > but what is the value?
> >
> > gen_epilogue() can call arbitrary kernel function.
> > It doesn't have to be a helper.
> > kfunc-s provide calling convention conversion from bpf to native,
> > but the same thing is achieved by BPF_CALL_N macro.
> > The module can use that macro without adding an actual bpf helper
> > to uapi bpf.h.
> > Then in gen_epilogue() the extra bpf insn can use:
> > BPF_EMIT_CALL(module_provided_helper_that_is_not_helper)
> > which will use
> > BPF_CALL_IMM(x) ((void *)(x) - (void *)__bpf_call_base)
>
> BPF_EMIT_CALL() was my earlier thought. I switched to the kfunc in this p=
atch
> because of the bpf_jit_supports_far_kfunc_call() support for the kernel m=
odule.
> Using kfunc call will make supporting it the same.

I believe far calls are typically slower,
so it may be a foot gun.
If something like qdisc-bpf adding a function call to bpf_exit
it will be called every time the program is called, so
it needs to be really fast.
Allowing such callable funcs in modules may be a performance issue
that we'd need to fix.
So imo making a design requirement that such funcs for gen_epilogoue()
need to be in kernel text is a good thing.

> I think the future bpf-qdisc can enforce built-in. bpf-tcp-cc has already=
 been
> built-in only also. I think the hid_bpf is built-in only also.

I don't think hid_bpf has any need for such gen_epilogue() adjustment.
tcp-bpf-cc probably doesn't need it either.
it's cleaner to fix up on the kernel side, no?
qdisc-bpf and ->dev stuff is probably the only upcoming user.
And that's a separate discussion. I'm not sure such gen_epilogoue()
concept is really that great.
Especially considering all the complexity involved.

