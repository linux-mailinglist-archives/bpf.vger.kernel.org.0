Return-Path: <bpf+bounces-63545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 991C4B082C7
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 04:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F86C1885D13
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 02:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50EC1C8633;
	Thu, 17 Jul 2025 02:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF8JTYY2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1BE1799F;
	Thu, 17 Jul 2025 02:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752718452; cv=none; b=ATF3cq8Ydc3VsZDJBseKnfl+rtBCfc2LFTfugLW3bDba0qNhL4GbGg8Q+s4lQjrlphlcw42WFTUbLG3wn2jbNBfepzS2IVxbwg/ajplVbZgEo5rsCYJ9bViZoCku7nvVLpSQK51OqkdWPJs07sz65W9azFKXb62PsXuKbe/kcu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752718452; c=relaxed/simple;
	bh=NNZ6/kasUwk/hZWeuRAfx2RCB4CBwevaseL0TdeUHMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T21cijeTa/AJYJfWXM6FubuA4EmV9konhQIRlLKMcTNWVmuOXXhgvV8XFt866BSeJ96hG6PGfQP8c3t3ZFJ3H/1sDJFmpZlq6YuhFCUKv2LTUZsbG17HzuI15s4C0aQY6YyU1/PCufGylL10bFqEgI4PkG8Q6sxN+BgkZ/WkqZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF8JTYY2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4555f89b236so3815215e9.1;
        Wed, 16 Jul 2025 19:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752718449; x=1753323249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjNilefCSmvk4mMPEA0XCD7CKf2tWX4gBv20NnzP/qk=;
        b=kF8JTYY21oo5YRagIKOupi+RdTYTdLYl/EbttfDBWxnNo/II9JSsY0BhnIMFMD5qc2
         lM4MOhSME7PuayMcRhnyPgLsIkZ45OldIcyP1VUdtf4vQIy0P2Of/rGHMeWbpclf4JMG
         nfX+zc+1/BWA71sWJjpHGlcNuCbKucmGy/eP79murlqZEePlJwkcPdqbUSeTABVaUE+X
         MtwrLOi9wmA8wasQaQE3KDPpNZhQ/FgZI/rkYfR4B+S50XjRXSGTVP7Xrx3CyTwOXKX+
         0CPyyEqWfJbQ7tplLv9iNU5JX63GR+Jl5OjV+P1q9KDXe3wWHcyEMFSggOrrH6JdY+oE
         h84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752718449; x=1753323249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjNilefCSmvk4mMPEA0XCD7CKf2tWX4gBv20NnzP/qk=;
        b=LQc6qH3+4DV5zGriAAAYf8OKKHIh21O8fhsb7Z7B+vjIOX/znV2zUh7T1oDtwJ+ADR
         Yb0Ovoxh4Y58X0mFASHMGymxmfTxiHh2R1Z0D1QXDkpOpPeObkMJDPyxrcXYwzINMF3H
         yT6Zd91+kQxL6Yc6GbW8wEE/yt9rblEMCwtQXaJoCzfK6nHkboiIFLFx/GpktfOhABaE
         MRW2V1+x7BUM6cFC9Vtpxngs8fFDhxhEtPzG0wYgwDL9WadCZDHKFB/ScYn3zMIQEhr1
         PvqcQtbldgXQn12yjBUh1AjqItQmZIoYX8pR0M/V5D+wJGdh0wJeDSxblV6Wn1uFOiZE
         uoFA==
X-Forwarded-Encrypted: i=1; AJvYcCU8fTeP2/85gyblycZ6OBzoS9MhvZ54C+E3CN5Q+dosXG42AUr2KcLuEsoFFJ3Rq71ewsNOZyjH@vger.kernel.org, AJvYcCUHvZuGk3hljD7vHI1zM23UJ7TWNdEKCa2gDjruOKUzOF+RrOySQgYdzugvc4XxgrWYNM4=@vger.kernel.org, AJvYcCUdPmJQsQZ8ImjoCxU95hdTHjNay5G+ch7loRqsPftDmWpqyxK+Yo34tn5W8s7tBxryidk0ZRYxa3B5KVsp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9R8KdLJRkhT1NGawoe1BlMVzlg/vWYH2FyEzGiMH+YNlGUhi4
	nzxkVTWE1hF3rX05qCM7ZyYZgTMXqS4i1oj2B/uDcV46Nlf/4VfqoolRK65AhjxLx3rRNF+7UGx
	pcMecUzVxFc4WAqx6qn+2KWVqxwMq8M4=
X-Gm-Gg: ASbGncscIZMDowvxl7VW6h6Adx3CwEZ2oKrr9WwldHvLDXFvtYUhfAeBpW1kUeVuR/h
	7DhgTf+P68kznNLzY0d2gGq21+Uk0JahTVwtrAfT3+08fTOOnM51oykc+NjEYtZ8NVcIQQEpvI7
	fnU00mqi0Qqtjth9/S58dONT1HZkXwNKfIVHPBdLgq0prE+ABSyPx12qYZPiSY4GReBWI5bLR8E
	CsYSUzpqkSlFtF7MSup7Y/qOlzQz8CCtj8T
X-Google-Smtp-Source: AGHT+IG7qcWBIreCgk1dBskqFfxB/PSeNs/NhA2CiS3i01oxXcftRaFwDe8kMJ96PtDdc00HtE3I9FqTYcRCTAKA+aM=
X-Received: by 2002:a05:6000:1447:b0:3b3:1e2e:ee07 with SMTP id
 ffacd0b85a97d-3b60e53fa01mr3918900f8f.56.1752718448513; Wed, 16 Jul 2025
 19:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <4737114.cEBGB3zze1@7940hx> <CAADnVQJ47PJXxjqES8BvtWkPq3fj9D0oTF6qqeNNpG66-_MGCg@mail.gmail.com>
 <3364591.aeNJFYEL58@7940hx>
In-Reply-To: <3364591.aeNJFYEL58@7940hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 16 Jul 2025 19:13:57 -0700
X-Gm-Features: Ac12FXw4JUJq6YBPrSr49kCIUdQy_pin-_FqDdbtJFi1xmncZx1ElJ_QmUaIJ1c
Message-ID: <CAADnVQLpAmZG_1827HS1dDaWBGraxY6UO92=tCX6eM9ZbqEBKQ@mail.gmail.com>
Subject: Re: multi-fentry proposal. Was: [PATCH bpf-next v2 02/18] x86,bpf:
 add bpf_global_caller for global trampoline
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 6:51=E2=80=AFPM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
> On Thursday, July 17, 2025 8:59 AM Alexei Starovoitov <alexei.starovoitov=
@gmail.com> write:
> > On Wed, Jul 16, 2025 at 6:06=E2=80=AFAM Menglong Dong <menglong.dong@li=
nux.dev> wrote:
> > >
> > > On Wednesday, July 16, 2025 12:35 AM Alexei Starovoitov <alexei.staro=
voitov@gmail.com> write:
> > > > On Tue, Jul 15, 2025 at 1:37=E2=80=AFAM Menglong Dong <menglong.don=
g@linux.dev> wrote:
> > > > >
> > > > >
> > > > > On 7/15/25 10:25, Alexei Starovoitov wrote:
> > > [......]
> > > > >
> > > > > According to my benchmark, it has ~5% overhead to save/restore
> > > > > *5* variants when compared with *0* variant. The save/restore of =
regs
> > > > > is fast, but it still need 12 insn, which can produce ~6% overhea=
d.
> > > >
> > > > I think it's an ok trade off, because with one global trampoline
> > > > we do not need to call rhashtable lookup before entering bpf prog.
> > > > bpf prog will do it on demand if/when it needs to access arguments.
> > > > This will compensate for a bit of lost performance due to extra sav=
e/restore.
> > >
> > > I don't understand here :/
> > >
> > > The rhashtable lookup is done at the beginning of the global trampoli=
ne,
> > > which is called before we enter bpf prog. The bpf progs is stored in =
the
> > > kfunc_md, and we need get them from the hash table.
> >
> > Ahh. Right.
> >
> > Looking at the existing bpf trampoline... It has complicated logic
> > to handle livepatching and tailcalls. Your global trampoline
> > doesn't, and once that is added it's starting to feel that it will
> > look just as complex as the current one.
> > So I think we better repurpose what we have.
> > Maybe we can rewrite the existing one in C too.
>
> You are right, the tailcalls is not handled yet. But for the livepatching=
,
> it is already handled, as we always get the origin ip from the stack
> and call it, just like how the bpf trampoline handle the livepatching.
> So no addition handling is needed here.
>
> >
> > How about the following approach.
> > I think we discussed something like this in the past
> > and Jiri tried to implement something like this.
> > Andrii reminded me recently about it.
> >
> > Say, we need to attach prog A to 30k functions.
> > 10k with 2 args, 10k with 3 args, and 10k with 7 args.
> > We can generate 3 _existing_ bpf trampolines for 2,3,7 args
> > with hard coded prog A in there (the cookies would need to be
> > fetched via binary search similar to kprobe-multi).
> > The arch_prepare_bpf_trampoline() supports BPF_TRAMP_F_ORIG_STACK.
> > So one 2-arg trampoline will work to invoke prog A in all 10k 2-arg fun=
ctions.
> > We don't need to match types, but have to compare that btf_func_model-s
> > are the same.
> >
> > Menglong, your global trampoline for 0,1,..6 args works only for x86,
> > because btf_func_model doesn't care about sizes of args,
> > but it's not the correct mental model to use.
> >
> > The above "10k with 2 args" is a simplified example.
> > We will need an arch specific callback is_btf_func_model_equal()
> > that will compare func models in arch specific ways.
> > For x86-64 the number of args is all it needs.
> > For other archs it will compare sizes and flags too.
> > So 30k functions will be sorted into
> > 10k with btf_func_model_1, 10k with btf_func_model_2 and so on.
> > And the corresponding number of equivalent trampolines will be generate=
d.
> >
> > Note there will be no actual BTF types. All args will be untyped and
> > untrusted unlike current fentry.
> > We can go further and sort 30k functions by comparing BTFs
> > instead of btf_func_model-s, but I suspect 30k funcs will be split
> > into several thousands of exact BTFs. At that point multi-fentry
> > benefits are diminishing and we might as well generate 30k unique
> > bpf trampolines for 30k functions and avoid all the complexity.
> > So I would sort by btf_func_model compared by arch specific comparator.
> >
> > Now say prog B needs to be attached to another 30k functions.
> > If all 30k+30k functions are different then it's the same as
> > the previous step.
> > Say, prog A is attached to 10k funcs with btf_func_model_1.
> > If prog B wants to attach to the exact same func set then we
> > just regenerate bpf trampoline with hard coded progs A and B
> > and reattach.
> > If not then we need to split the set into up to 3 sets.
> > Say, prog B wants 5k funcs, but only 1k func are common:
> > (prog_A, 9k func with btf_func_model_1) -> bpf trampoline X
> > (prog_A, prog_B, 1k funcs with btf_func_model_1) -> bpf trampoline Y
> > (prog_B, 4k funcs with btf_func_model_1) -> bpf trampoline Z
> >
> > And so on when prog C needs to be attached.
> > At detach time we can merge sets/trampolines,
> > but for now we can leave it all fragmented.
> > Unlike regular fentry progs the multi-fentry progs are not going to
> > be attached for long time. So we can reduce the detach complexity.
> >
> > The nice part of the algorithm is that coexistence of fentry
> > and multi-fentry is easy.
> > If fentry is already attached to some function we just
> > attach multi-fentry prog to that bpf trampoline.
> > If multi-fentry was attached first and fentry needs to be attached,
> > we create a regular bpf trampoline and add both progs there.
>
> This seems not easy, and it is exactly how I handle the
> coexistence now:
>
>   https://lore.kernel.org/bpf/20250528034712.138701-16-dongml2@chinatelec=
om.cn/
>   https://lore.kernel.org/bpf/20250528034712.138701-17-dongml2@chinatelec=
om.cn/
>   https://lore.kernel.org/bpf/20250528034712.138701-18-dongml2@chinatelec=
om.cn/

hmm. exactly? That's very different.
You're relying on kfunc_md for prog list.
The above proposal doesn't need kfunc_md in the critical path.
All progs are built into the trampolines.

> The most difficult part is that we need a way to replace the the
> multi-fentry with fentry for the function in the ftrace atomically. Of
> course, we can remove the global trampoline first, and then attach
> the bpf trampoline, which will make things much easier. But a
> short suspend will happen for the progs in fentry-multi.

I don't follow.
In the above proposal fentry attach/detach is atomic.
Prepare a new trampoline, single call to ftrace to modify_fentry().

> >
> > The intersect and sorting by btf_func_model is not trivial,
> > but we can hold global trampoline_mutex, so no concerns of races.
> >
> > Example:
> > bpf_link_A is a set of:
> > (prog_A, funcs X,Y with btf_func_model_1)
> > (prog_A, funcs N,M with btf_func_model_2)
> >
> > To attach prog B via bpf_link_B that wants:
> > (prog_B, funcs Y,Z with btf_func_model_1)
> > (prog_B, funcs P,Q with btf_func_model_3)
> >
> > walk all existing links, intersect and split, and update the links.
> > At the end:
> >
> > bpf_link_A:
> > (prog_A, funcs X with btf_func_model_1)
> > (prog_A, prog_B funcs Y with btf_func_model_1)
> > (prog_A, funcs N,M with btf_func_model_2)
> >
> > bpf_link_B:
> > (prog_A, prog_B funcs Y with btf_func_model_1)
> > (prog_B, funcs Z with btf_func_model_1)
> > (prog_B, funcs P,Q with btf_func_model_3)
> >
> > When link is detached: walk its own tuples, remove the prog,
> > if nr_progs =3D=3D 0 -> detach corresponding trampoline,
> > if nr_progs > 0 -> remove prog and regenerate trampoline.
> >
> > If fentry prog C needs to be attached to N it might split bpf_link_A:
> > (prog_A, funcs X with btf_func_model_1)
> > (prog_A, prog_B funcs Y with btf_func_model_1)
> > (prog_A, funcs M with btf_func_model_2)
> > (prog_A, prog_C funcs N with _fentry_)
> >
> > Last time we gave up on it because we discovered that
> > overlap support was too complicated, but I cannot recall now
> > what it was :)
> > Maybe all of the above repeating some old mistakes.
>
> In my impression, this is exactly the solution of Jiri's, and this is
> part of the discussion that I know:
>
>   https://lore.kernel.org/bpf/ZfKY6E8xhSgzYL1I@krava/

Yes. It's similar, but somehow it feels simple enough now.
The algorithms for both detach and attach fit on one page,
and everything is uniform. There are no spaghetty of corner cases.

