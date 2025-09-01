Return-Path: <bpf+bounces-67132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9489FB3F13E
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 00:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE671B21CAF
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 22:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11756284696;
	Mon,  1 Sep 2025 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3QOhF8e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD5D2673B7
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756766728; cv=none; b=qQHghxQN/a9VmtqvdFI5/oGBTCEKTQJrBWEPQfXoJZKQDDn/Lg765fVtIYGat786+PzYX8S0Qux0QATTuJfKW29SPyGyUQJHx4hWtzJ8bt275ao7T3a/TTjLnn0quhz+scDyhEj2aRXFTlJMQxlVGEaFfDyKLLHRPXV3yMCfhUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756766728; c=relaxed/simple;
	bh=qR42YfqJASD0y/o1/Oa0Uw0TRQxNmHyoDb1NMbJmwRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/+gh+TjVt8QuOc9xna+q+unrjfYMuwrgQPv9Di3i4ct6t33ZTZqvNkPaHznXmpzzGEjyirgHWJGuXEp2SPYGB18OQ+lzAfztfUVeecRw+hD84pkwJviQxw/HQ7tCN2AlIiSy0pUuuvN144QrB00VhFb4acqAkSOmcTeBzb4UO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3QOhF8e; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-6188b7550c0so5672968a12.2
        for <bpf@vger.kernel.org>; Mon, 01 Sep 2025 15:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756766725; x=1757371525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kk7sPG0jKvqaxdr4efba0QSysbV64YWjMYkvJGfPKQU=;
        b=J3QOhF8eFmKeoW+7++CwOzHyfWBIsEJuDyKF+cdj+zf3m/A3Mlhfef3zxpbw8jagxJ
         yf5vA7rLpdpJpHn1Um0u9KtWv8w0ALTw1K2ps4JV+hJLVvJTS7Q8X7bIWZrwwtEs+sbI
         pWMsCVV6xYyQzD03X5bUwYUM10fJF6Yy32hn4VfxmyCVrKC23wIkcLk/KOfcuuf2E5G2
         dYIM7IXeSVDfx9eEf/JHBI6ev4rNOThjaFVHMCG2yQe4nIDCRv97JHiO1Kdna7hSAyfv
         OgMzFIHzp3E7ys0vH+564jzD5rfsFzO1Ae5JDOwIeevg4Mheee/Hlvh58m9bJV2NdVEV
         YwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756766725; x=1757371525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kk7sPG0jKvqaxdr4efba0QSysbV64YWjMYkvJGfPKQU=;
        b=Dk531XtKplcR0F2Vk31hv2WthtxVpDJWwnSjW8TFIdTP3Vchg2Pswu1iwJi6OBqdEL
         iFVmb/Blk78N2AYxOAGlOAZIK1Vvpdlscm+0TAovv7Fv9DiqISXOOhR+4qFGIl02hbnm
         KDHa8oFdn3U1sa9tAqPuxz2SrNJwWXFzXaSRpSrwf0lHIahTmJPQAMtze4oC3Mi0XHwn
         SXquASYNV6wdLuj5cIooXRQeYIoqq2UUF9HdfPP83WTneELUAyYb3EMH9m9chWivLQv1
         kfMtu5vbPbwQtOnl7i5myHAHlq5jRGwQEbKnn4R+e+V/HtYX4sIwFQbwd5Ctzkqx3xtP
         jzBw==
X-Forwarded-Encrypted: i=1; AJvYcCXKWkAA7MLW+DF5demoqEWIdFZ7dNmN5EqEf5pmgHwNCRRCQA+8iLnlvNt6RjDx4md6IHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiEekhIXTx77LbSs7rH9an3Ak0ya/oo6q3bHd2RLfU8oEBwExR
	2apFJNmjxKaDyNGGTgZy9+JkaRf0fJRRCsI9gs5rcIkH6tQhFz8hRwZTSgfnC5mIL0WWNqBb6u9
	MEtJYn5VJkpnNEDKiVvHrCIouHyX12Jk=
X-Gm-Gg: ASbGncs6fdZtDe04V9bDNYRkzzURX8eDu6QEl/87NI2w3Hk6kvcsHe93ZzHXYi80Mdw
	0JV9XWVOwG+5GIlCpHg0SxhPn4USQP9wO795iEAcezlHSdQRq/XSrVzqN7neDOUPRE3Q6+rpNXs
	3tjjkINkgh5vz6E+Icpj1PIgR5DYdvRAUaZjddka4xR+JJ9KqkIAubtpoBL6BG9Ae4hQOdrcBbu
	3FB+4mM
X-Google-Smtp-Source: AGHT+IGeIi52B8yZ80HycwMNDSnH7u5TPFIE9KFLGfsK+ndDDhK+7L+89Ud8oJBSQ/HERanPh0whlHhqwuIq7AgVQ1Q=
X-Received: by 2002:a05:6402:26d3:b0:61d:57a:2fe9 with SMTP id
 4fb4d7f45d1cf-61d269a0a6emr9023719a12.16.1756766724825; Mon, 01 Sep 2025
 15:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827153728.28115-1-puranjay@kernel.org> <20250827153728.28115-3-puranjay@kernel.org>
 <99bb1aa8-885b-4819-beb3-723a73960f67@huaweicloud.com> <CAADnVQKp-FXhVtxCSE8rako8BBnAU4Qt-dxviqrJUr-Fpfm+4w@mail.gmail.com>
 <mb61p4itmjnze.fsf@kernel.org> <CAADnVQKPLwGF25YOzA=a4Vr==0UZFycv6GkLbwszkFrBiHGCcw@mail.gmail.com>
 <mb61p1poqj7vd.fsf@kernel.org>
In-Reply-To: <mb61p1poqj7vd.fsf@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 2 Sep 2025 00:44:48 +0200
X-Gm-Features: Ac12FXzy_HipBL4ton9Y9hIZ-atmn4Jl48Nz8WR5RTVY2WvIGZHV_6ftcWGx1H0
Message-ID: <CAP01T74DdVsxtdivHg6hi5Ei8k=iT_FMvRr8XE7zEqBXYyz6EQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] bpf: Report arena faults to BPF stderr
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Sept 2025 at 21:22, Puranjay Mohan <puranjay@kernel.org> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Mon, Sep 1, 2025 at 6:34=E2=80=AFAM Puranjay Mohan <puranjay@kernel.=
org> wrote:
> >>
> >> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> >>
> >> > On Fri, Aug 29, 2025 at 3:30=E2=80=AFAM Xu Kuohai <xukuohai@huaweicl=
oud.com> wrote:
> >> >>
> >> >> > +
> >> >> > +void bpf_prog_report_arena_violation(bool write, unsigned long a=
ddr)
> >> >> > +{
> >> >> > +     struct bpf_stream_stage ss;
> >> >> > +     struct bpf_prog *prog;
> >> >> > +     u64 user_vm_start;
> >> >> > +
> >> >> > +     prog =3D bpf_prog_find_from_stack();
> >> >>
> >> >> bpf_prog_find_from_stack depends on arch_bpf_stack_walk, which isn'=
t available
> >> >> on all archs. How about switching to bpf_prog_ksym_find with the fa=
ult pc?
> >> >
> >> > Out of archs that support bpf arena only riscv doesn't
> >> > support arch_bpf_stack_walk(), which is probably fixable.
> >> > But I agree that direct bpf_prog_ksym_find() is cleaner here.
> >> > We need to make sure it works for subprogs, since streams[2] are
> >> > valid only for main prog.
> >> > I think we can add:
> >> > struct bpf_prog_aux {
> >> >   ...
> >> >   struct bpf_prog_aux *main_prog;
> >> > };
> >> > init it during jit_subprogs() and use it for stream access.
> >> > We can also remove skipping of subprogs in find_from_stack_cb() then=
.
> >> >
> >> > Kumar, wdyt?
> >>
> >> So, IIUC, after adding struct bpf_prog_aux *main_prog_aux in struct
> >> bpf_prog_aux,
> >>
> >> We can do in bpf_prog_alloc_no_stats():
> >>    fp->aux->main_prog_aux =3D aux;
> >>
> >> and in jit_subprogs():
> >>     func[i]->aux->main_prog_aux =3D prog->aux;
> >>
> >> and then all users of bpf_stream_get() can do
> >>     bpf_stream_get(stream_id, prog->aux->main_prog_aux);
> >>
> >> with above we can allow find_from_stack_cb() to return subprogs.
> >> and bpf_prog_ksym_find() can be used in
> >> bpf_prog_report_arena_violation() without any other changes.
> >
> > Yes. That's exactly the proposal.
>
> I think we should go ahead with this approach but also divide
> bpf_prog_aux into two as you suggested. I will send a follow-up set for
> that.

find_from_stack_cb shouldn't be returning subprogs IMO, I think what
was meant by Alexei was to use the first found subprog to jump to its
main prog.

I think this will also make stream related logic work in cases where
we only have subprog of the program, and not the main prog (e.g. timer
callbacks, etc.) in the stack trace, which was probably an oversight
on my part. It would be nice to test this, let me know if you can fold
it in your set / send as a follow up, otherwise I will.

Additionally, I feel the extra pointer is unnecessary. Instead, the
logic to jump to the main prog from the subprog can be (if I didn't
miss anything):

prog->aux->func ? prog->aux->func[0]->aux ? prog-aux

When prog->aux->func is not set, that means there are no subprogs. I
would simply wrap this logic in bpf_main_prog_aux or something.

>
> Thanks,
> Puranjay

