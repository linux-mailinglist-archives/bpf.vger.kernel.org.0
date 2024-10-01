Return-Path: <bpf+bounces-40640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6F998B30F
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 06:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2FB283D7F
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 04:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B950A1B78E0;
	Tue,  1 Oct 2024 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXMQZdMD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CEA43152
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 04:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727757151; cv=none; b=CsbaXHmigUQuBnIvKnBs4h2PREBOG8huv07xhGsW/1NLep98W8LkUxy1m+Wt6dfC0Dt0fhxVGoHS/wda0VMJD+RRn2qf0CuG0MBwN+qmhlieatGhfpZhAIgsOm4zwk5Tm4UXXOLw5LBvwM5xfvotAEgwoyfPSRKggPxo3M+lPwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727757151; c=relaxed/simple;
	bh=L5JVB+YAVORL7FZYL78nInGyYAwO0QJqwIYcEUDrWsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClAthDvvacAC1DkAbSZtc4TCiUhii7tgfbwXHrIIB0uEa3/ziYWa4Iioc2GszgrZfq69EVnpb8zMrmv6crSd/Pos777A1MtyTgXGTtcoTjIpq6gYTEeiFUgjrW1QW1LKdtu6g5ynxkiFNBtdhE7gZhtkgLE0U5nzY1+w0c5T4SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXMQZdMD; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5c89f3e8a74so1778810a12.0
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 21:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727757148; x=1728361948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rE+8njTBmv7cLVckSOMN5Yyjmi4b1RDPhi4Ymt/CGVE=;
        b=KXMQZdMDiOj0/nF/bqszkHs0dfsvojluDJ4hzb8CEzcX9+Ymd67M0H66YuyTScgKqh
         D4+mPJNhHEro9CKY6p7W47sAVyo7fa4gcNFGMmvZ6MjDVK7Heubuv10PrmlYxoMFhtp2
         PoLvp6frxfTtwGIKM7onjnyrMx0OeNmuTdp33uzbgm+Ve/biBXNfYcybEW6wBFao6aNw
         ITSV6HOzg1N9kMNJP9NAS30ajtn6JlKRjXGgzHBmNMIKTuiD5Q575lHTc5ATng2HCSER
         kY44l7Dka7BKSydsIrdjHTMcWF77BTTibzXl6ici+eG6ZZLDHuWFKsd7cz/AFGFrDMSQ
         gmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727757148; x=1728361948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rE+8njTBmv7cLVckSOMN5Yyjmi4b1RDPhi4Ymt/CGVE=;
        b=KFuJt0+srXsOz438OyC4zwwhG+98hMx1ODfXKdJCIWIgXvyJ0ENUQHYI0qO+J/BIbl
         i9KHgxcl2wKpD8bryom5KZ2SFr45wNztZtyzhgnGLI0sJCe26xjFo6nL6O7+wYlid7FT
         BWTNs71GkA2PmrDSNgL7u1ZYP2Ppns3xyebIBJryy+e70weRyADPcMY/519rmIdNuqe2
         HZNSdmwPkngEA/loqkrmnY+j9FhccjzPeN9Ie0WNnkASXQ6PRl8PWjvosNHwmmJkdW+U
         G7lkPtXx0NT2N1uug9kbTgzqBmH9r73hSZ3+fRKny3MTj9Yo73XPpTrQIx1CB8NYEru0
         GTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/UyGovoHRXVB98YbL9jjlasAAsKn7vJoq5wjAymPlAi8uQ3P8UJtKWjeQwkVqLyBwUVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfmJy5lP39mnE4MFYJ0JsFLovFLkbdFkz+qAxavJ/Ea5/WHgaT
	9mNe+zPEJR9EtvgyRV7ptFM3Cm4AnbTrNdWUHhg7c9Q0KOd05yCHQtiGusf8vpgG3RtmzPwFCB3
	8rCAVCu6RH+ciVlzV94ZncfmGrGM=
X-Google-Smtp-Source: AGHT+IFhI90cFvrlXO3kxkuExL2oZa4CV+4C2Hhd/flS2BysG0wM/x6a7AinnS7lgqmD6U57XYzFoYPKR4bni2Whsxk=
X-Received: by 2002:a17:907:742:b0:a86:7fc3:8620 with SMTP id
 a640c23a62f3a-a93c492a261mr1479994466b.31.1727757147582; Mon, 30 Sep 2024
 21:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <20240926234526.1770736-1-yonghong.song@linux.dev> <CAADnVQ+v3u=9PEHQ0xJEf6wSRc2iR928Sc+6CULh390i3TDR=w@mail.gmail.com>
In-Reply-To: <CAADnVQ+v3u=9PEHQ0xJEf6wSRc2iR928Sc+6CULh390i3TDR=w@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 1 Oct 2024 06:31:51 +0200
Message-ID: <CAP01T77-bU5Ewu79QLJDTnt_E8h_VFHuABOD5=oct7_TC_yYGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/5] bpf, x86: Add jit support for private stack
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Sept 2024 at 17:03, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 26, 2024 at 4:45=E2=80=AFPM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
> >
> > Add jit support for private stack. For a particular subtree, e.g.,
> >   subtree_root <=3D=3D stack depth 120
> >    subprog1    <=3D=3D stack depth 80
> >     subprog2   <=3D=3D stack depth 40
> >    subprog3    <=3D=3D stack depth 160
> >
> > Let us say that private_stack_ptr is the memory address allocated for
> > private stack. The frame pointer for each above is calculated like belo=
w:
> >   subtree_root  <=3D=3D subtree_root_fp =3D private_stack_ptr + 120
> >    subprog1     <=3D=3D subtree_subprog1_fp =3D subtree_root_fp + 80
> >     subprog2    <=3D=3D subtree_subprog2_fp =3D subtree_subprog1_fp + 4=
0
> >    subprog3     <=3D=3D subtree_subprog1_fp =3D subtree_root_fp + 160
> >
> > For any function call to helper/kfunc, push/pop prog frame pointer
> > is needed in order to preserve frame pointer value.
> >
> > To deal with exception handling, push/pop frame pointer is also used
> > surrounding call to subsequent subprog. For example,
> >   subtree_root
> >    subprog1
> >      ...
> >      insn: call bpf_throw
> >      ...
> >
> > After jit, we will have
> >   subtree_root
> >    insn: push r9
> >    subprog1
> >      ...
> >      insn: push r9
> >      insn: call bpf_throw
> >      insn: pop r9
> >      ...
> >    insn: pop r9
> >
> >   exception_handler
> >      pop r9
> >      ...
> > where r9 represents the fp for each subprog.
>
> Kumar,
> please review the interaction of priv_stack with exceptions.
>

Hm, I think it works fine (because of push_r9 around subprog calls),
but I think it's not needed (unless I missed something).

The kernel won't care about r9's value, so the only reason pop_r9 is
being done in ex_handler is to restore the private stack value?
In that case you can just push_r9 once for
prog->aux->exception_boundary after emit_private_frame_ptr, since only
this main subprog's stack will be reused to run the exception
callback. Then keep the pop_r9 as is. And then you don't need to
push_r9 and pop_r9 around subprog calls.

But do you need to do it? It seems later on it will just be overwritten.
Since exception_cb is a PSTACK_TREE_ROOT, you will set its r9 using mov.

So it seems all of this may be unnecessary.

Let me know if I misunderstood something.

...

Another issue that I came across when reading through patches is how
this interacts with extension progs.
Say right now I have this call chain:

main_subprog
  global_subprog (overriden by ext prog)
    subprog1
      call helper
  subprog2

global_subprog (which is a separate ext prog attached there using
freplace) is not using private stack, but main prog is.
So when main_subprog calls into it, it is possible r9 gets overwritten
since JIT didn't preserve it for helper calls from the ext prog.

When subprog2 is called, this will mean r9 equals garbage?

There was a vaguely similar decision to make for exceptions: if we
keep unwinding beyond an extension prog frame, we might end up in the
main subprog frame that did not push the necessary registers to
restore kernel state from exception_cb (because it did not have
bpf_throw during verification). So I ended up making the ext prog
itself an exception boundary, so unwinding stops there and it would
return a result to its caller prog which may or may not use
exceptions.

In my case, I cannot go and re-JIT old progs to make them exception
aware (short of always pushing r12 and all callee regs).
But in your case the changes would be contained to ext_prog, so you
could just figure that out from the tgt_prog seen in
bpf_check_attach_target (i.e. whether it is using priv_stack or not,
and if so, extra JIT instrumentation to reuse and push/pop r9 around
helper calls is necessary for this ext_prog).

> >
> > [...]

