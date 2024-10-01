Return-Path: <bpf+bounces-40707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB9D98C5AE
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 20:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B231F25FA7
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 18:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EA81CCED6;
	Tue,  1 Oct 2024 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGYdqi9V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A96D1CCB49
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808607; cv=none; b=kv1PbiRpLM8XEjgXjvbMDiwKbgza7Lh+Ibj1cHfE6EmhZ/rKyWjgKjR9StiCyOv/f+tczPHKJxaBOk7OdHwU3/D+GWMX5TfzW3gNMLu8TZJ2wDHvXAuSrTMFdMBgV0xQAW4Qhlr5yx1ebrYHqJXDf8cbG3C9HfdxPDQ02Bzo/gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808607; c=relaxed/simple;
	bh=VMvt81A/cfQMu+CcZ6MhZVFLDGbD2i1SLb6KCs4wMjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eN2EgBSP4aAQnI1/iSP3Ykbb82g40sBtTVC2//8AfxBSaQYaa8nk5H0ZTDVHk1KXefCPK1Vx7OhhWXUqXOS3OK9DIldsfZPTQK1rpQzudqaLBv8vp/t2ZopC3B6NIzeWZ5egPSwbmqPtGxcUH2HV3Tap/tbEynp8plX8cEY5zkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGYdqi9V; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cae102702so43885975e9.0
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 11:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727808604; x=1728413404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iURHl1mbColaqKo1pFDkKvI+69Y52wtDsCi9HT2jF74=;
        b=fGYdqi9VpKu4nXELu90dUh+04FSkR9Q4B2yPAewbhEJ604oI4CSm6t+vs+hSY2XYFq
         rv8hj+sslHvj247eIHjRF8qoQZkhj2/xwpRwBV6FmK2hOCbKO6WLk7Z7szdAuwHzMP0Z
         CEEeBDiO1dYr+gSsFD4LjeEp6CLRA6n0s1kSVX/gzXin3CxeqtRh9Ds6NTjY8Ej18s0X
         Wyf+wchR0UNNT6FO1Tc5GD4nIh1TugtJlOX8hFdRCmFFLLZQLRjNlOVXQ5gO3es1wgO9
         cwaJ775U4GAgoSDYrTnx39uRcbmFzPYdrHpMCSZCTgBvVpY3JUCiNt+YeI49Ha539hIh
         8MCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727808604; x=1728413404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iURHl1mbColaqKo1pFDkKvI+69Y52wtDsCi9HT2jF74=;
        b=r6i4t1zKi+PRehnauTV74kdYE5DXKwah+oBin19gG0tyM1bkDvLcX1dk0tFitHUTvl
         rrOKEzbhRTPs3tSvtOjy0uqZjgOqV8+xPuumiJtuj6mywJ54Neb01ZJeZKxaD2Uak+1X
         NDDI8//9I9H4uT7s+ZYK2nzZZhYczOhnBmAyFhUeE8k+SfIGp1oC94x1eT7pVY9ecXkX
         i0kkHKRlBWntoxpU3QnysLfw5nCrGZoIYOndOj4+rYv+yrZMcgTfPP4VoX14h9wGAlHZ
         EMa/wYoSwmEhxRlIb4iAxzUTmV7eLPk9SCmTO0jG+5RId1w8b0vH3woyedbOHacfyZK/
         ScSg==
X-Forwarded-Encrypted: i=1; AJvYcCV3JTCaLQfWNb4ENc3rT+mcoH2pExy67goNCLCuJh2i44IpfThD73PDbwVwAZlP05zW05w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLPA4X9Unn9r1S3sIFZhkqfQJI/pmTXLTQYnnZtNo8GjSyOpFy
	axoHdaJsZTDYNv4fznrH/o63CLCkafq6PKx4/+/AYolSTd7qJHePZuAep4Q2VFQYwjUTwVeOzUF
	NAuTODV4Tcky00dHxLNxHtyXdZ1Q=
X-Google-Smtp-Source: AGHT+IH1IlpEEihDBx9mcUs1+NcAQ/Eod+0zcX8bEDrjLTv9tybUYGxf0nojHAxQzdFn0jSa9ZLmxwn8jWFg6ViuEUE=
X-Received: by 2002:a05:6000:a84:b0:374:cd96:f73 with SMTP id
 ffacd0b85a97d-37cfb8b6405mr372004f8f.3.1727808603940; Tue, 01 Oct 2024
 11:50:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <20240926234526.1770736-1-yonghong.song@linux.dev> <CAADnVQ+v3u=9PEHQ0xJEf6wSRc2iR928Sc+6CULh390i3TDR=w@mail.gmail.com>
 <CAP01T77-bU5Ewu79QLJDTnt_E8h_VFHuABOD5=oct7_TC_yYGQ@mail.gmail.com> <CAP01T76UnVfn3x7zZH4vJgZMGv_Ygewxg=9gUA-xuOa7pwGr3A@mail.gmail.com>
In-Reply-To: <CAP01T76UnVfn3x7zZH4vJgZMGv_Ygewxg=9gUA-xuOa7pwGr3A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Oct 2024 11:49:53 -0700
Message-ID: <CAADnVQ+caNh8+fgCj2XeZDrXniYif5Y+rw6vsMOojBO3Qwk+Nw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/5] bpf, x86: Add jit support for private stack
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 9:38=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, 1 Oct 2024 at 06:31, Kumar Kartikeya Dwivedi <memxor@gmail.com> w=
rote:
> >
> > On Mon, 30 Sept 2024 at 17:03, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Sep 26, 2024 at 4:45=E2=80=AFPM Yonghong Song <yonghong.song@=
linux.dev> wrote:
> > > >
> > > > Add jit support for private stack. For a particular subtree, e.g.,
> > > >   subtree_root <=3D=3D stack depth 120
> > > >    subprog1    <=3D=3D stack depth 80
> > > >     subprog2   <=3D=3D stack depth 40
> > > >    subprog3    <=3D=3D stack depth 160
> > > >
> > > > Let us say that private_stack_ptr is the memory address allocated f=
or
> > > > private stack. The frame pointer for each above is calculated like =
below:
> > > >   subtree_root  <=3D=3D subtree_root_fp =3D private_stack_ptr + 120
> > > >    subprog1     <=3D=3D subtree_subprog1_fp =3D subtree_root_fp + 8=
0
> > > >     subprog2    <=3D=3D subtree_subprog2_fp =3D subtree_subprog1_fp=
 + 40
> > > >    subprog3     <=3D=3D subtree_subprog1_fp =3D subtree_root_fp + 1=
60
> > > >
> > > > For any function call to helper/kfunc, push/pop prog frame pointer
> > > > is needed in order to preserve frame pointer value.
> > > >
> > > > To deal with exception handling, push/pop frame pointer is also use=
d
> > > > surrounding call to subsequent subprog. For example,
> > > >   subtree_root
> > > >    subprog1
> > > >      ...
> > > >      insn: call bpf_throw
> > > >      ...
> > > >
> > > > After jit, we will have
> > > >   subtree_root
> > > >    insn: push r9
> > > >    subprog1
> > > >      ...
> > > >      insn: push r9
> > > >      insn: call bpf_throw
> > > >      insn: pop r9
> > > >      ...
> > > >    insn: pop r9
> > > >
> > > >   exception_handler
> > > >      pop r9
> > > >      ...
> > > > where r9 represents the fp for each subprog.
> > >
> > > Kumar,
> > > please review the interaction of priv_stack with exceptions.
> > >
> >
> > Hm, I think it works fine (because of push_r9 around subprog calls),
> > but I think it's not needed (unless I missed something).
> >
> > The kernel won't care about r9's value, so the only reason pop_r9 is
> > being done in ex_handler is to restore the private stack value?
> > In that case you can just push_r9 once for
> > prog->aux->exception_boundary after emit_private_frame_ptr, since only
> > this main subprog's stack will be reused to run the exception
> > callback. Then keep the pop_r9 as is. And then you don't need to
> > push_r9 and pop_r9 around subprog calls.
> >
> > But do you need to do it? It seems later on it will just be overwritten=
.
> > Since exception_cb is a PSTACK_TREE_ROOT, you will set its r9 using mov=
.
> >
> > So it seems all of this may be unnecessary.
> >
> > Let me know if I misunderstood something.
> >
> > ...
> >
> > Another issue that I came across when reading through patches is how
> > this interacts with extension progs.
> > Say right now I have this call chain:
> >
> > main_subprog
> >   global_subprog (overriden by ext prog)
> >     subprog1
> >       call helper
> >   subprog2
> >
> > global_subprog (which is a separate ext prog attached there using
> > freplace) is not using private stack, but main prog is.
> > So when main_subprog calls into it, it is possible r9 gets overwritten
> > since JIT didn't preserve it for helper calls from the ext prog.
> >
> > When subprog2 is called, this will mean r9 equals garbage?
> >
> > There was a vaguely similar decision to make for exceptions: if we
> > keep unwinding beyond an extension prog frame, we might end up in the
> > main subprog frame that did not push the necessary registers to
> > restore kernel state from exception_cb (because it did not have
> > bpf_throw during verification). So I ended up making the ext prog
> > itself an exception boundary, so unwinding stops there and it would
> > return a result to its caller prog which may or may not use
> > exceptions.
> >
> > In my case, I cannot go and re-JIT old progs to make them exception
> > aware (short of always pushing r12 and all callee regs).
> > But in your case the changes would be contained to ext_prog, so you
> > could just figure that out from the tgt_prog seen in
> > bpf_check_attach_target (i.e. whether it is using priv_stack or not,
> > and if so, extra JIT instrumentation to reuse and push/pop r9 around
> > helper calls is necessary for this ext_prog).
> >
>
> Oh, on second thought:
> I guess the second issue is not a problem (yet) because you always push
> and pop r9 around subprog calls.
> But say you dropped that (if the earlier comment is correct about it
> being unnecessary for exceptions), then such a case would surface.

...

> push_r9 and pop_r9 around subprog calls.

I don't see how you can avoid that.
subprog will adjust r9, so the main prog needs to go back
to its r9 value after subprog finishes.
So it's either push/pop around subprogs or
subprog has to r9 +=3D sz in the prologue and r9 -=3D sz in the epilogue.
while keeping r9 intact for the duration.
It would still need to push/pop around kfuncs/helpers,
since the kernel might use it.

imo push/pop around every call is easier to reason about.

