Return-Path: <bpf+bounces-21902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8179D853E81
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F551C2111B
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 22:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C118E6215E;
	Tue, 13 Feb 2024 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hT3S+trr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CFA60BA6
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 22:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707862869; cv=none; b=B7bNIbbZSHu7XEYgv5pK0TKDeu40WEGOzmCmCdLnXSjED1QqlbfwDGf8yP6NfJUoD18VtBLHJyb6+LkuSEszCaDY25i9Dkmuif+yumJbX2WZTmG+ayhebUAfWpDDqcu/g6XH8CU8wgsXj0WKsoiuVYB6Zj3cpnCBlWoT/pML2UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707862869; c=relaxed/simple;
	bh=Mk8ZTHRldRHNxLLz1ayRYLuy9diQLGqtS0v9VPBWDJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddnVvn4PQYx8ZrR/nSGLwHdWCB2CTPJFDCdE22AQpMtZ32gWWHv0zXgWiHkbHtH6MhVhufCzDsOpOdiVU51B1zTJPoXeEUKkgoJ27USW7VEbCRcWIxmzKZ3C8IjMGF3WidtePgYYOMMCRsHOOyb7C4P9P2QcHwxC0enMaXGo9H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hT3S+trr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-411a5b8765bso1084585e9.1
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 14:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707862866; x=1708467666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyEiM7uR4OLHXno74RQU8w/bYjz4MAG5Dd8MilyY158=;
        b=hT3S+trre+vmr0lqRcIHtvnXH+6wSGX2zhFWzEdlf12klu5tPb8x/EBqGbJwU4JzXq
         8RcIR/8+YEIJZovK8EPjPaUaaO4sRiGVYwqioP8nUNR36a0cYG9zXJcppN4Y9yr9zXwp
         EGiI2WUYYZfl+dCwvh0bseoNQj9uNZ0R5KpzHbMYondklKpc7f9P4c/F9sQcQ4ILhPcK
         Q3GAXcPqGDWeMVBU8DZuq7ny39ipxNK+g/gBnZTW9hKECkVByfKChVPgaaOKnLaq8LVD
         7sxvpUvjUwnTZ+C4Udjt2kB7EfDsvp59VBUd/Ycqf/9EUvD6M5tlXnpVT6BgsYGxhkUU
         bnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707862866; x=1708467666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyEiM7uR4OLHXno74RQU8w/bYjz4MAG5Dd8MilyY158=;
        b=TpmF2uVcD6nzNC4u/GKz/UhcAtOQNeGJzqgpuGqsVdsOfGvhml8x8yPh0gBI2Uuw0K
         JNZhnnCqvwfR814w78yi4Kvn9g8UQQUXsF4hRFlZQ8GaDt6UlFOjXXYLjxZ6yqa4Bkcv
         mPn05TCyIvc2ZLlb0e67SQdK7Yhrb0E2vebkngEhDNWMxaaozAmysIpBfXaaG/H9n/q4
         yuWtvYEZK1dWDnNQ6OnoQ12dOClkp0iL58mEWq6gptAacUbSYav8hNN3P1cIz5aO6fZ1
         wBsqiE6XIu6C9+xY30p1rTWad0uAFJAIfWGCWef0IuEsDyB0BYSPYA7fbC+CY89TiX/l
         Zz4w==
X-Gm-Message-State: AOJu0Ywejci7SHHzfzyDicvOG/YrED4CD7F1M2/cT5kdk5M13QhAOTRx
	KpoTTNmPmXmkEWWgE025LkRNP2LcwDO1rHS9ipSg1FZyjbBLhVyPF8u6NWNGXomjcOsN5SN6/SO
	fwlzjwQ7KzgqWCIkPFdusRJj+P2o=
X-Google-Smtp-Source: AGHT+IGOKfdd+q+Y9Wac9kMWkeEwI/U40khcn1iHzpEWA3/HDYRmvAl6LtdDs5WYsFFxiFCIceEtCT5OQY8CjwZLc5U=
X-Received: by 2002:a05:600c:3590:b0:411:c45a:3914 with SMTP id
 p16-20020a05600c359000b00411c45a3914mr127994wmq.3.1707862865716; Tue, 13 Feb
 2024 14:21:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-8-alexei.starovoitov@gmail.com> <b8e3b8382dbb58418a89a74995732e5aade6d4df.camel@gmail.com>
In-Reply-To: <b8e3b8382dbb58418a89a74995732e5aade6d4df.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Feb 2024 14:20:54 -0800
Message-ID: <CAADnVQ+iUMb54KFtfgGhoF5bkUWSPGa=QHZa8z0P198V+HOrPg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 07/20] bpf: Add x86-64 JIT support for
 PROBE_MEM32 pseudo instructions.
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 9:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2024-02-08 at 20:05 -0800, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW] instruc=
tions.
> > They are similar to PROBE_MEM instructions with the following differenc=
es:
> > - PROBE_MEM has to check that the address is in the kernel range with
> >   src_reg + insn->off >=3D TASK_SIZE_MAX + PAGE_SIZE check
> > - PROBE_MEM doesn't support store
> > - PROBE_MEM32 relies on the verifier to clear upper 32-bit in the regis=
ter
> > - PROBE_MEM32 adds 64-bit kern_vm_start address (which is stored in %r1=
2 in the prologue)
> >   Due to bpf_arena constructions such %r12 + %reg + off16 access is gua=
ranteed
> >   to be within arena virtual range, so no address check at run-time.
> > - PROBE_MEM32 allows STX and ST. If they fault the store is a nop.
> >   When LDX faults the destination register is zeroed.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
>
> It would be great to add support for these new probe instructions in disa=
sm,
> otherwise commands like "bpftool prog dump xlated" can't print them.
>
> I sort-of brute-force verified jit code generated for new instructions
> and disassembly seem to be as expected.

yeah. added a fix to the verifier patch.

> [...]
>
> > @@ -1564,6 +1697,52 @@ st:                    if (is_imm8(insn->off))
> >                       emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, sr=
c_reg, insn->off);
> >                       break;
> >
> > +             case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
> > +             case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
> > +             case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
> > +             case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
> > +                     start_of_ldx =3D prog;
> > +                     emit_st_r12(&prog, BPF_SIZE(insn->code), dst_reg,=
 insn->off, insn->imm);
> > +                     goto populate_extable;
> > +
> > +                     /* LDX: dst_reg =3D *(u8*)(src_reg + r12 + off) *=
/
> > +             case BPF_LDX | BPF_PROBE_MEM32 | BPF_B:
> > +             case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
> > +             case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
> > +             case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
> > +             case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
> > +             case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
> > +             case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
> > +             case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
> > +                     start_of_ldx =3D prog;
> > +                     if (BPF_CLASS(insn->code) =3D=3D BPF_LDX)
> > +                             emit_ldx_r12(&prog, BPF_SIZE(insn->code),=
 dst_reg, src_reg, insn->off);
> > +                     else
> > +                             emit_stx_r12(&prog, BPF_SIZE(insn->code),=
 dst_reg, src_reg, insn->off);
> > +populate_extable:
> > +                     {
> > +                             struct exception_table_entry *ex;
> > +                             u8 *_insn =3D image + proglen + (start_of=
_ldx - temp);
> > +                             s64 delta;
> > +
> > +                             if (!bpf_prog->aux->extable)
> > +                                     break;
> > +
> > +                             ex =3D &bpf_prog->aux->extable[excnt++];
>
> Nit: this seem to mostly repeat exception logic for
>      "BPF_LDX | BPF_MEM | BPF_B" & co,
>      is there a way to abstract it a bit?

I don't see a good way. A macro is meh.
A helper with 5+ args is also meh.

>      Also note that there excnt is checked for overflow.

indeed. added overflow check.

