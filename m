Return-Path: <bpf+bounces-44064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CFF9BD3B8
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 18:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0811F234C3
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 17:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDDC1E1311;
	Tue,  5 Nov 2024 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBcnnqkx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27F53BBC9
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828855; cv=none; b=nmtUt46TvEfLLOeGDFyZVKn4vAlMO8A7f0QdquPpKrJi097ju+LC5s5E67V2CQpaNh2+Ru6lvG0PURmFHPk4sC3jddouT6p5R1t8gySxryulCeNF+uSW9iargCZMKM01ldtNrIX+rCvj8vH5w7/uJNwDEejOeLxeZsc9iBpzkxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828855; c=relaxed/simple;
	bh=qUV1GWOOIGac2dN82guLT9341syYKzimG42SL6zr7R4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adKZgFXykpygEzNVxzQu9uQ7IaObaHEniiS/o4dswVFyZzD5/ePGMOoIHGdx7D/RxJT+zwaucjYfPxtXdPIncDiZZnZNP1HvueJqm0wbmCig5KCN5AfaY98oMMtZ9XdkD0d8X/BFWc/A8U1AyxYTs59r6Y+gFLUO4QvrbuqXOCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBcnnqkx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so3386921f8f.1
        for <bpf@vger.kernel.org>; Tue, 05 Nov 2024 09:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730828852; x=1731433652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auL/VRpHHQnAgXuAuWu+GG3j1ij4ZYdqKdvzMhPx9tk=;
        b=LBcnnqkxBuUVEv3+vM99z8XitmJNEQv5AY6t90rZ+0WXWw8W2wutuzmFPcZPVvzUul
         UeXmiEOLjriFXqT7WpCooEl50FQW3etOwnHcueIPoiWjvPozHPAubVP9s6Gc3X9deMyU
         Xiq6Oi/QoihYUcDPOIPc0rA4D5Jnn9YBv4kIs5xDIi4OUoHmw7yOMXao8vduCjy1rJzS
         9C2cWSIw5JSBWP7R2vu8PIMR2e8szpo9hLccZtMSbpUzCVUt7k0+Yhk8snikOphCNz/q
         aQvKCQoi3QKtk/sbA4Ijp845KWYL1ymon+IZ4pfAEHZHSneuuQ48soflrfzTRgY7QgBy
         xM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828852; x=1731433652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auL/VRpHHQnAgXuAuWu+GG3j1ij4ZYdqKdvzMhPx9tk=;
        b=V/wtMPMCD2DppBjjYYV7oUNJ1q0H8rCG88NblIClKByZ5JMDDN6ydEduj1xsXmb5wb
         WMA23Id9aQfqasQc/aifIMkODKP+S3Hj2jChkjEFAsMAsWQQm1Fd07bAY6jH2zDDDG9c
         eDAYe0p2CcNfFK+2uBH2iBY+Szm6Gfl+J6LUcBtb3UUEe4H5uk+hkgpE+a+NtQpLgMyI
         vQ7G1uvVqUd4j6Th2r/8ZhSYh/saIbBC4AMhff7/2ssJ32crGjUBpyOKew/1whkuO5kk
         3kBhhoJny+1MhUfx+RtjOat3RNB+eZTaP+zJm6m9GFEybo4dTBJRcrYVA0NyWIaajbgW
         Yn6w==
X-Gm-Message-State: AOJu0Yxe9izqBnzup9jRUf7lC/w7Pwy/IzqBmuv0RXZifW1KsTJRDJdw
	Ku4EsLWvw0iy2p/sklgu62PQhB+5mTsd8d52hpc/IMyD1buWS9Bh7XlYcc3Md0UgrcYrrwcAGy+
	O7OxvA6bXMwkWFtoAlpAclpWJXvw=
X-Google-Smtp-Source: AGHT+IGHksfQEjfUMJIvbxz8N6XkF4Vw/iCWKmj5/2+2MVsr4KlqSqNGiz38vHUtsvvaTle8QMuMkO+TfqqApWaqqHU=
X-Received: by 2002:a05:6000:1f8e:b0:37d:3301:9891 with SMTP id
 ffacd0b85a97d-381c7a4c0e6mr11279289f8f.17.1730828852057; Tue, 05 Nov 2024
 09:47:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193505.3242662-1-yonghong.song@linux.dev> <CAADnVQLr5Rz+L=4CWPxjBGLcYEctLRpPfh642LtNjXKTbyKPgQ@mail.gmail.com>
 <36294e71-4d0b-465d-9bf5-c5640aa3a089@linux.dev> <CAADnVQLXbsuzHX6no+CSTAOYxt27jNY5qgtrML6vqEVsggfgRQ@mail.gmail.com>
 <6c78f973-341e-4260-aed4-a5cb8e873acc@linux.dev> <29e2658c-02c9-4ef1-a633-ee5017e72bc3@linux.dev>
 <CAADnVQL54BFUpzAWx-4B6_UFyHp4O88=+x8zeWJupiyjNarRfg@mail.gmail.com>
 <97ea8f52-96c3-4109-92b7-cf2631a34e2d@linux.dev> <CAADnVQK-AXqxEhDwWK=RKx-dA0PZ=N1j6vSshBWS4bGNfv=a7g@mail.gmail.com>
 <43dc0d7d-ca6e-4ba1-a831-e2a1e43f6311@linux.dev> <CAADnVQJpm2JreS2peqcEZ07FvY5jb+t2xPjpZm4N1UE3_hjxTQ@mail.gmail.com>
 <893eb66c-8122-4b28-8dfa-2a7beddbb511@linux.dev>
In-Reply-To: <893eb66c-8122-4b28-8dfa-2a7beddbb511@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Nov 2024 09:47:20 -0800
Message-ID: <CAADnVQJCWo39yka+HqcBT+Ce1R2_sSXxU1UPp1XgU6u4iwxC-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 02/10] bpf: Return false for
 bpf_prog_check_recur() default case
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 8:48=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
>
> On 11/5/24 8:38 AM, Alexei Starovoitov wrote:
> > On Tue, Nov 5, 2024 at 8:33=E2=80=AFAM Yonghong Song <yonghong.song@lin=
ux.dev> wrote:
> >>
> >>
> >>
> >> On 11/5/24 7:50 AM, Alexei Starovoitov wrote:
> >>> On Mon, Nov 4, 2024 at 10:02=E2=80=AFPM Yonghong Song <yonghong.song@=
linux.dev> wrote:
> >>>>> I also don't understand the point of this patch 2.
> >>>>> The patch 3 can still do:
> >>>>>
> >>>>> + switch (prog->type) {
> >>>>> + case BPF_PROG_TYPE_KPROBE:
> >>>>> + case BPF_PROG_TYPE_TRACEPOINT:
> >>>>> + case BPF_PROG_TYPE_PERF_EVENT:
> >>>>> + case BPF_PROG_TYPE_RAW_TRACEPOINT:
> >>>>> +   return PRIV_STACK_ADAPTIVE;
> >>>>> + default:
> >>>>> +   break;
> >>>>> + }
> >>>>> +
> >>>>> + if (!bpf_prog_check_recur(prog))
> >>>>> +   return NO_PRIV_STACK;
> >>>>>
> >>>>> which would mean that iter, lsm, struct_ops will not be allowed
> >>>>> to use priv stack.
> >>>> One example is e.g. a TC prog. Since bpf_prog_check_recur(prog)
> >>>> will return true (means supporting recursion), and private stack
> >>>> does not really support TC prog, the logic will become more
> >>>> complicated.
> >>>>
> >>>> I am totally okay with removing patch 2 and go back to my
> >>>> previous approach to explicitly list prog types supporting
> >>>> private stack.
> >>> The point of reusing bpf_prog_check_recur() is that we don't
> >>> need to duplicate the logic.
> >>> We can still do something like:
> >>> switch (prog->type) {
> >>>    case BPF_PROG_TYPE_KPROBE:
> >>>    case BPF_PROG_TYPE_TRACEPOINT:
> >>>    case BPF_PROG_TYPE_PERF_EVENT:
> >>>    case BPF_PROG_TYPE_RAW_TRACEPOINT:
> >>>       return PRIV_STACK_ADAPTIVE;
> >>>    case BPF_PROG_TYPE_TRACING:
> >>>    case BPF_PROG_TYPE_LSM:
> >>>    case BPF_PROG_TYPE_STRUCT_OPS:
> >>>       if (bpf_prog_check_recur())
> >>>         return PRIV_STACK_ADAPTIVE;
> >>>       /* fallthrough */
> >>>     default:
> >>>       return NO_PRIV_STACK;
> >>> }
> >> Right. Listing trampoline related prog types explicitly
> >> and using bpf_prog_check_recur() will be safe.
> >>
> >> One thing is for BPF_PROG_TYPE_STRUCT_OPS, PRIV_STACK_ALWAYS
> >> will be returned. I will make adjustment like
> >>
> >> switch (prog->type) {
> >>    case BPF_PROG_TYPE_KPROBE:
> >>    case BPF_PROG_TYPE_TRACEPOINT:
> >>    case BPF_PROG_TYPE_PERF_EVENT:
> >>    case BPF_PROG_TYPE_RAW_TRACEPOINT:
> >>       return PRIV_STACK_ADAPTIVE;
> >>    case BPF_PROG_TYPE_TRACING:
> >>    case BPF_PROG_TYPE_LSM:
> >>    case BPF_PROG_TYPE_STRUCT_OPS:
> >>       if (bpf_prog_check_recur()) {
> >>         if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS)
> >>             return PRIV_STACK_ALWAYS;
> > hmm. definitely not unconditionally.
> > Only when explicitly requested in callback.
> >
> > Something like this:
> >     case BPF_PROG_TYPE_TRACING:
> >     case BPF_PROG_TYPE_LSM:
> >        if (bpf_prog_check_recur())
> >           return PRIV_STACK_ADAPTIVE;
> >     case BPF_PROG_TYPE_STRUCT_OPS:
> >        if (prog->aux->priv_stack_requested)
> >           return PRIV_STACK_ALWAYS;
> >     default:
> >        return NO_PRIV_STACK;
> >
> > and then we also change bpf_prog_check_recur()
> >   to return true when prog->aux->priv_stack_requested
>
> This works too. I had another thinking about
>     case BPF_PROG_TYPE_LSM:
>        if (bpf_prog_check_recur())
>           return PRIV_STACK_ADAPTIVE;
>     case BPF_PROG_TYPE_STRUCT_OPS:
>        if (bpf_prog_check_recur())
>           return PRIV_STACK_ALWAYS;
>
> Note that in bpf_prog_check_recur(), for struct_ops,
> will return prog->aux->priv_stack_request.
> But think it is too verbose so didn't propose.
>
> So explicitly using prog->aux->priv_stack_requested
> is more visible. Maybe we can even do
>
>     case BPF_PROG_TYPE_TRACING:
>     case BPF_PROG_TYPE_LSM:
>     case BPF_PROG_TYPE_STRUCT_OPS:
>        if (prog->aux->priv_stack_requested)
>           return PRIV_STACK_ALWYAS;
>        else if (bpf_prog_check_recur())
>           return PRIV_STACK_ADAPTIVE;
>        /* fallthrough */
>     default:
>        return NO_PRIV_STACK;

The last version makes sense to me.
bpf_prog_check_recur() should also return true when
prog->aux->priv_stack_requested to make sure trampoline adds a
run-time check.

