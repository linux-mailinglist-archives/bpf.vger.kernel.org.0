Return-Path: <bpf+bounces-63519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A04FEB081FB
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90E64A81F2
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 01:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DD719D880;
	Thu, 17 Jul 2025 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LomFmmdV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74782E36E2;
	Thu, 17 Jul 2025 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752714001; cv=none; b=Iken4+L8157HsAgcq75LEmPlm2osU49W5DAOUmL0fJohwxDNECIdPfv33kfY1Cg9o4fENXntl+Bi0PiaRmEUFGD7+Ssn4/OUWl8XDub/QWG5M8kue5c1+6A+TRwBmP3+Lnp9zNIxCSvGcumltmENKKV0SqO4sVwccNlnEEgJNz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752714001; c=relaxed/simple;
	bh=kaKiA8MRNCWa3wuLWzsfVMtnO70zx2SGqWj1iBtKs08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xs40v14LM+iDwHVYuA8SPRiOw5lrh2hnmcaRFvInFoifU32zH0qPZXlLo8WSxc5YHeNm+Q1KMj8LuJKxki7qlKiOuA5wOyxyEUNSEzKx/489fi74KdtER3LamgKQjB5sc5Ym38fnHzhoUKv8gxUwTHAszxJs8B8eCWvBTQ6eGJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LomFmmdV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4561a4a8bf2so3797305e9.1;
        Wed, 16 Jul 2025 17:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752713998; x=1753318798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaKiA8MRNCWa3wuLWzsfVMtnO70zx2SGqWj1iBtKs08=;
        b=LomFmmdVvKJb7zhAow5ZA58n6VPQJ4sPwFBJqznUBe6GTBqQLVtGTqAZHSYiW51NcV
         XUuwpLXu5Rzp8drGEdhTWgrcjekNt6ReiPNOBVKIrHKxeh061G0ENtiQqarzMvJFw8pd
         z90TovpIME5u0ZbYYOLZDkhUesi0Z45+aLe2dtHqsfitiLUEB9cGGZU69IhJM8M+ns4n
         kq55HJvUJ/6E9/jtNCwH9ukZv6Dxc8IATs6/M+Nr2vWbMrqm2475D+aoET0e5NWJtAEm
         w5dZwEhZoMUT0JB+yXdse4NSi+R5aImcsrXAejNrvv8EFACzB9zGtzW3RH+ca3zYgGTr
         hJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752713998; x=1753318798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaKiA8MRNCWa3wuLWzsfVMtnO70zx2SGqWj1iBtKs08=;
        b=ckgDwqbwPO32buc81KryLVtCNwqZOVfU98TiHm4PNnfyX3NnjIxshpzjL8X09j3AeZ
         ZrWivW9iC04/ZfZEDHX73gEcPLA9sGb27zJMAYdQKWbFvzg/spER3hmuv3q44xCC+4Wn
         5xmp6ed8AR4PngSugO55poFBXRY2i80qX7dwwoW4IjruIiA4OrBiDF2YjXe4+1Avrrqr
         mwS6yqvI+xmkox4JqXwRVdEYgWSUME/PwcxF80KuaKT8Z59QwHcR0b1d4kR0JIZ0KGK2
         dJBG4eRAkzvfPnmB32PStRdbd9p71nerqHsVGz+c0KgYlZwSKSe8yHAKRqsU5/48J5rL
         ILLg==
X-Forwarded-Encrypted: i=1; AJvYcCVSW4cwkNbYBRqpfmLZs64FXOjCOPxZXuQ7HghedL+OecfAbjH3sos2AMC91jThXn/fiGZsyHeUgifd3ADs@vger.kernel.org, AJvYcCVWnvW/uKUnZBrW0omRmLcyayuxpvWCUO3dFz9YXbbLPCIs0IHZ+1rdybF3yauhEmM1MWM=@vger.kernel.org, AJvYcCX6+vAWDoxM9FVNaRCgOSeMVcfbvrVIYpjoQ/RmjYDooStqHjBDuoZClpCJ3mjydHWEyE0MV6yv@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5AL00Rnwa7Xc7jqDGuhdHDw8gSHeWmJW55W0Mo+Rb6MISViGB
	Ck/2C+v8mMFxFgyycIGe7z4WLCEApQ0eXqZOzPl09E2aWfsvnaXnH4wIcvHSbJEkpaq+8FKOCqa
	22VBb7G5gocxRr4wWYXdx3PGz/rZvnBhqNfoc
X-Gm-Gg: ASbGncsQgh23iRVBVM14lFn+6RO+Q2EVJaue73G9BL1V2VS3QcaXL04XYdTIFqnEnT6
	XQhTOYswGnAtBz9gimEkTgWjxp5vwfMC2JioUnS3U48nNxVg7/KuIHMZax/VNIzgHw1UAtdIwUe
	wNE/v+hltnmgfpzqii5qZNpLfbBwfMP6nUNvyn/UwlBdSMVsALMwA3dj1753IVjaWOuQ6ZSNiR0
	blXFQ1BgUNWWQCpXGWeVQHJw+8bU9A4LQC3+nDQVhFEPGI=
X-Google-Smtp-Source: AGHT+IFCNgk5E3ceQgcpnh7J6MKotd+WLEcT5lR77HmZSey0/9RSoHj/57iwsScI9gfB2mc22+BtTLQYBXvaFXi2Nu0=
X-Received: by 2002:a05:600c:64ce:b0:455:f59e:fd79 with SMTP id
 5b1f17b1804b1-4562e33d64emr46741885e9.11.1752713997693; Wed, 16 Jul 2025
 17:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev> <CAADnVQ+7NhegoZGHkiRyNO8ywks3ssPzQd6ipQzumZsWUHJALg@mail.gmail.com>
 <4737114.cEBGB3zze1@7940hx>
In-Reply-To: <4737114.cEBGB3zze1@7940hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 16 Jul 2025 17:59:45 -0700
X-Gm-Features: Ac12FXwTACRJ1EmkfUyG9feoU05Z3TPhagq0jgGugeWtmgahYJQbU9MgVPv5FeA
Message-ID: <CAADnVQJ47PJXxjqES8BvtWkPq3fj9D0oTF6qqeNNpG66-_MGCg@mail.gmail.com>
Subject: multi-fentry proposal. Was: [PATCH bpf-next v2 02/18] x86,bpf: add
 bpf_global_caller for global trampoline
To: Menglong Dong <menglong.dong@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 6:06=E2=80=AFAM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
> On Wednesday, July 16, 2025 12:35 AM Alexei Starovoitov <alexei.starovoit=
ov@gmail.com> write:
> > On Tue, Jul 15, 2025 at 1:37=E2=80=AFAM Menglong Dong <menglong.dong@li=
nux.dev> wrote:
> > >
> > >
> > > On 7/15/25 10:25, Alexei Starovoitov wrote:
> [......]
> > >
> > > According to my benchmark, it has ~5% overhead to save/restore
> > > *5* variants when compared with *0* variant. The save/restore of regs
> > > is fast, but it still need 12 insn, which can produce ~6% overhead.
> >
> > I think it's an ok trade off, because with one global trampoline
> > we do not need to call rhashtable lookup before entering bpf prog.
> > bpf prog will do it on demand if/when it needs to access arguments.
> > This will compensate for a bit of lost performance due to extra save/re=
store.
>
> I don't understand here :/
>
> The rhashtable lookup is done at the beginning of the global trampoline,
> which is called before we enter bpf prog. The bpf progs is stored in the
> kfunc_md, and we need get them from the hash table.

Ahh. Right.

Looking at the existing bpf trampoline... It has complicated logic
to handle livepatching and tailcalls. Your global trampoline
doesn't, and once that is added it's starting to feel that it will
look just as complex as the current one.
So I think we better repurpose what we have.
Maybe we can rewrite the existing one in C too.

How about the following approach.
I think we discussed something like this in the past
and Jiri tried to implement something like this.
Andrii reminded me recently about it.

Say, we need to attach prog A to 30k functions.
10k with 2 args, 10k with 3 args, and 10k with 7 args.
We can generate 3 _existing_ bpf trampolines for 2,3,7 args
with hard coded prog A in there (the cookies would need to be
fetched via binary search similar to kprobe-multi).
The arch_prepare_bpf_trampoline() supports BPF_TRAMP_F_ORIG_STACK.
So one 2-arg trampoline will work to invoke prog A in all 10k 2-arg functio=
ns.
We don't need to match types, but have to compare that btf_func_model-s
are the same.

Menglong, your global trampoline for 0,1,..6 args works only for x86,
because btf_func_model doesn't care about sizes of args,
but it's not the correct mental model to use.

The above "10k with 2 args" is a simplified example.
We will need an arch specific callback is_btf_func_model_equal()
that will compare func models in arch specific ways.
For x86-64 the number of args is all it needs.
For other archs it will compare sizes and flags too.
So 30k functions will be sorted into
10k with btf_func_model_1, 10k with btf_func_model_2 and so on.
And the corresponding number of equivalent trampolines will be generated.

Note there will be no actual BTF types. All args will be untyped and
untrusted unlike current fentry.
We can go further and sort 30k functions by comparing BTFs
instead of btf_func_model-s, but I suspect 30k funcs will be split
into several thousands of exact BTFs. At that point multi-fentry
benefits are diminishing and we might as well generate 30k unique
bpf trampolines for 30k functions and avoid all the complexity.
So I would sort by btf_func_model compared by arch specific comparator.

Now say prog B needs to be attached to another 30k functions.
If all 30k+30k functions are different then it's the same as
the previous step.
Say, prog A is attached to 10k funcs with btf_func_model_1.
If prog B wants to attach to the exact same func set then we
just regenerate bpf trampoline with hard coded progs A and B
and reattach.
If not then we need to split the set into up to 3 sets.
Say, prog B wants 5k funcs, but only 1k func are common:
(prog_A, 9k func with btf_func_model_1) -> bpf trampoline X
(prog_A, prog_B, 1k funcs with btf_func_model_1) -> bpf trampoline Y
(prog_B, 4k funcs with btf_func_model_1) -> bpf trampoline Z

And so on when prog C needs to be attached.
At detach time we can merge sets/trampolines,
but for now we can leave it all fragmented.
Unlike regular fentry progs the multi-fentry progs are not going to
be attached for long time. So we can reduce the detach complexity.

The nice part of the algorithm is that coexistence of fentry
and multi-fentry is easy.
If fentry is already attached to some function we just
attach multi-fentry prog to that bpf trampoline.
If multi-fentry was attached first and fentry needs to be attached,
we create a regular bpf trampoline and add both progs there.

The intersect and sorting by btf_func_model is not trivial,
but we can hold global trampoline_mutex, so no concerns of races.

Example:
bpf_link_A is a set of:
(prog_A, funcs X,Y with btf_func_model_1)
(prog_A, funcs N,M with btf_func_model_2)

To attach prog B via bpf_link_B that wants:
(prog_B, funcs Y,Z with btf_func_model_1)
(prog_B, funcs P,Q with btf_func_model_3)

walk all existing links, intersect and split, and update the links.
At the end:

bpf_link_A:
(prog_A, funcs X with btf_func_model_1)
(prog_A, prog_B funcs Y with btf_func_model_1)
(prog_A, funcs N,M with btf_func_model_2)

bpf_link_B:
(prog_A, prog_B funcs Y with btf_func_model_1)
(prog_B, funcs Z with btf_func_model_1)
(prog_B, funcs P,Q with btf_func_model_3)

When link is detached: walk its own tuples, remove the prog,
if nr_progs =3D=3D 0 -> detach corresponding trampoline,
if nr_progs > 0 -> remove prog and regenerate trampoline.

If fentry prog C needs to be attached to N it might split bpf_link_A:
(prog_A, funcs X with btf_func_model_1)
(prog_A, prog_B funcs Y with btf_func_model_1)
(prog_A, funcs M with btf_func_model_2)
(prog_A, prog_C funcs N with _fentry_)

Last time we gave up on it because we discovered that
overlap support was too complicated, but I cannot recall now
what it was :)
Maybe all of the above repeating some old mistakes.

Jiri,
How does the above proposal look to you?

