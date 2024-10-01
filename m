Return-Path: <bpf+bounces-40641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D44198B317
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 06:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459C11C22FD7
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 04:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF35F1B86EE;
	Tue,  1 Oct 2024 04:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XthGdYwo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8921B0108
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 04:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727757497; cv=none; b=LUKzWl3v3ibP6NgP+/5hnxfupYWzDkCHB9taY2MDCsRQaRWKEf79rm56yujJ3tgjVTGSVFEKSq9dNEF0v9HjbZzm6DI/sm9IHzBwlviLDcqZFX0aENSlcEXizQeOcbhicl+jbJq99VP0xvVB52Kd58Y3FOXRmrT3bFoW2M2wTDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727757497; c=relaxed/simple;
	bh=o9PnBFIrBMBip0+zMjjmJBi9Vezzlf046Z470dcLlxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bwe209tQAauzdmXQJyAYnyVrRY/qNFQ1KAjQO2EZeRr8GQIpLQty9eXiLog24uUdL4tVAUNc+J3kwWdPbFvIrRHyuK75igdlcHTIg7E6NUdqV/+zkme/f5wbXf/FO5kZzTWVce/7mywBQj00cr7+NXdY8ZANJlEJGzpuGc1o9fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XthGdYwo; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3770320574aso3395418f8f.2
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 21:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727757494; x=1728362294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KR2BZ56sL4z9dqDtG/p+vPyH2hp4/LTN7UyCp6qV/Fo=;
        b=XthGdYwowTmPbLIPzJ3+mjfJuKVLvX5rudGv14RGsuO/UeRkOCJW3rLMMUAqTHS2ZN
         XS8UiNAm3Li3/MdAq8x3BMe7fSk7mhRNfZl4f/cRnjatKvw+532g6QXoBb+3BqELy9e7
         QVao3Y79cR17Xg/UXHwW9OtiWd/JWesvRwLGedZJmsibo7NsXcO3ElcIOmrFKOUQiGC1
         igMsnhrLmjM4zlM6PoigW/wdtFc4kQgT3IhEl8NK1xwUrFHodfsZS8mPJHvRN5NWXn2n
         zKkNhShdADxAC/3oDxel0xKTWiSH4rsqCWnOdloEV9vcqA65taSg2P1/DxJRbjDiPZaQ
         5qjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727757494; x=1728362294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KR2BZ56sL4z9dqDtG/p+vPyH2hp4/LTN7UyCp6qV/Fo=;
        b=wAdsRQg0VaoAmX1yYa64uuPPqBVFVH389rEQnX6tzZM9lMb9xtX87J+jsgpbWV7cuo
         MDw52IZYfRBtbuBy6OnjxHX01/oMOzo+0vrthVaLpombpSfSqd6ILRamFHTvDplDqzN8
         3eIBwNgUAM5foFoa+j8ax5PL4yKDBKbJkTEgsPxGpqtFB4+SRcRXV4W8A+E+PcHm1FoN
         wQ2SOyOOjkbd0UGy0ViGXihLiPqpm0ieso7jhFLItCLnrsjjU0N65ydz9be9Xh+g58Q7
         Jvg0YkIigZ9XPJK5Z8s1eY9fr5S/hY/Y5DcyfAk770Rm8G/ur1c/boiF+UdTf34QoeA0
         p88A==
X-Forwarded-Encrypted: i=1; AJvYcCUAwnT/siGH4Dc1ObN9S2poAeZZX8wMnlSRDwVcyc5nxOmkisxwYcLsfDuszw9Dh2n3jzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyObQxF+Iyii1crF/FYHGh0S98iFYWFLKQ0Owhr6m7ARE0dASIe
	gG7yv9aV7OrJRMt6RnxBAfiOmSGr3l+9lUCoibvr81tY2ufohNoWS//IR0aMuzKFDIsZW4iolFc
	LGj2kE2v+AS7jSwoQquOPdKAGGP4=
X-Google-Smtp-Source: AGHT+IFYJ7CeSJk4ypsQA6JVRNGG2GT7xOtdg5po8y0T0DNAFcKQIvTr1BEyAVFwzpo82JypEwI4ollHSY5TCChT+2o=
X-Received: by 2002:adf:e7c7:0:b0:37c:d2d9:f3f0 with SMTP id
 ffacd0b85a97d-37cd5a77bf1mr7506960f8f.16.1727757493459; Mon, 30 Sep 2024
 21:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <20240926234526.1770736-1-yonghong.song@linux.dev> <CAADnVQ+v3u=9PEHQ0xJEf6wSRc2iR928Sc+6CULh390i3TDR=w@mail.gmail.com>
 <CAP01T77-bU5Ewu79QLJDTnt_E8h_VFHuABOD5=oct7_TC_yYGQ@mail.gmail.com>
In-Reply-To: <CAP01T77-bU5Ewu79QLJDTnt_E8h_VFHuABOD5=oct7_TC_yYGQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 1 Oct 2024 06:37:37 +0200
Message-ID: <CAP01T76UnVfn3x7zZH4vJgZMGv_Ygewxg=9gUA-xuOa7pwGr3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/5] bpf, x86: Add jit support for private stack
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Oct 2024 at 06:31, Kumar Kartikeya Dwivedi <memxor@gmail.com> wro=
te:
>
> On Mon, 30 Sept 2024 at 17:03, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Sep 26, 2024 at 4:45=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> > >
> > > Add jit support for private stack. For a particular subtree, e.g.,
> > >   subtree_root <=3D=3D stack depth 120
> > >    subprog1    <=3D=3D stack depth 80
> > >     subprog2   <=3D=3D stack depth 40
> > >    subprog3    <=3D=3D stack depth 160
> > >
> > > Let us say that private_stack_ptr is the memory address allocated for
> > > private stack. The frame pointer for each above is calculated like be=
low:
> > >   subtree_root  <=3D=3D subtree_root_fp =3D private_stack_ptr + 120
> > >    subprog1     <=3D=3D subtree_subprog1_fp =3D subtree_root_fp + 80
> > >     subprog2    <=3D=3D subtree_subprog2_fp =3D subtree_subprog1_fp +=
 40
> > >    subprog3     <=3D=3D subtree_subprog1_fp =3D subtree_root_fp + 160
> > >
> > > For any function call to helper/kfunc, push/pop prog frame pointer
> > > is needed in order to preserve frame pointer value.
> > >
> > > To deal with exception handling, push/pop frame pointer is also used
> > > surrounding call to subsequent subprog. For example,
> > >   subtree_root
> > >    subprog1
> > >      ...
> > >      insn: call bpf_throw
> > >      ...
> > >
> > > After jit, we will have
> > >   subtree_root
> > >    insn: push r9
> > >    subprog1
> > >      ...
> > >      insn: push r9
> > >      insn: call bpf_throw
> > >      insn: pop r9
> > >      ...
> > >    insn: pop r9
> > >
> > >   exception_handler
> > >      pop r9
> > >      ...
> > > where r9 represents the fp for each subprog.
> >
> > Kumar,
> > please review the interaction of priv_stack with exceptions.
> >
>
> Hm, I think it works fine (because of push_r9 around subprog calls),
> but I think it's not needed (unless I missed something).
>
> The kernel won't care about r9's value, so the only reason pop_r9 is
> being done in ex_handler is to restore the private stack value?
> In that case you can just push_r9 once for
> prog->aux->exception_boundary after emit_private_frame_ptr, since only
> this main subprog's stack will be reused to run the exception
> callback. Then keep the pop_r9 as is. And then you don't need to
> push_r9 and pop_r9 around subprog calls.
>
> But do you need to do it? It seems later on it will just be overwritten.
> Since exception_cb is a PSTACK_TREE_ROOT, you will set its r9 using mov.
>
> So it seems all of this may be unnecessary.
>
> Let me know if I misunderstood something.
>
> ...
>
> Another issue that I came across when reading through patches is how
> this interacts with extension progs.
> Say right now I have this call chain:
>
> main_subprog
>   global_subprog (overriden by ext prog)
>     subprog1
>       call helper
>   subprog2
>
> global_subprog (which is a separate ext prog attached there using
> freplace) is not using private stack, but main prog is.
> So when main_subprog calls into it, it is possible r9 gets overwritten
> since JIT didn't preserve it for helper calls from the ext prog.
>
> When subprog2 is called, this will mean r9 equals garbage?
>
> There was a vaguely similar decision to make for exceptions: if we
> keep unwinding beyond an extension prog frame, we might end up in the
> main subprog frame that did not push the necessary registers to
> restore kernel state from exception_cb (because it did not have
> bpf_throw during verification). So I ended up making the ext prog
> itself an exception boundary, so unwinding stops there and it would
> return a result to its caller prog which may or may not use
> exceptions.
>
> In my case, I cannot go and re-JIT old progs to make them exception
> aware (short of always pushing r12 and all callee regs).
> But in your case the changes would be contained to ext_prog, so you
> could just figure that out from the tgt_prog seen in
> bpf_check_attach_target (i.e. whether it is using priv_stack or not,
> and if so, extra JIT instrumentation to reuse and push/pop r9 around
> helper calls is necessary for this ext_prog).
>

Oh, on second thought:
I guess the second issue is not a problem (yet) because you always push
and pop r9 around subprog calls.
But say you dropped that (if the earlier comment is correct about it
being unnecessary for exceptions), then such a case would surface.

> > >
> > > [...]

