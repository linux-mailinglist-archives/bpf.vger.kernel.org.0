Return-Path: <bpf+bounces-63294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2884CB04E8C
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 05:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD564A1FAF
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 03:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF2B2D0C72;
	Tue, 15 Jul 2025 03:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hT2+6WYZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8883729A5;
	Tue, 15 Jul 2025 03:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752549291; cv=none; b=kXrKAbij371qJkQgwXo0hEUfESoIrB7o64WIM4KqSmGrQZqmpX1n+Ct2NUPxoaZRsqAyIVzo4Ye8skpGsInkTcm5JM1WkL3Ri5WKW5xWgX19UcpBYpz7BR3vTwCDLl3/UNS3wmvwoCeu+wCSL3a067tAWsXbH2oA13EwNoCFUYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752549291; c=relaxed/simple;
	bh=lcTGxdcDdqinOTdLZi7Q6V0/3dBdRGARdsySrhzmHPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V600CQkbuDAmK+l0EpiyXm/tDkEKP/629ZZnyocyVQTuZ2SH0zaiK8zeIGdc/qVY6zi8eApBRD6INDKEqqOQcMbBqcyQSbDQArrMm/K4Z3jkDK8Hl4SO25s1XAmwrzjfjiYbq9rBKd534xrZHlvuJlFkIJ7zO4FnGfFa33VFfbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hT2+6WYZ; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-70f147b5a52so36024257b3.3;
        Mon, 14 Jul 2025 20:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752549288; x=1753154088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xukKaqe9PAfsuqh3akAQri8K5drTtDqGJNjKhDiM5uk=;
        b=hT2+6WYZLoqVdU565EBCfyfAI3m9+qtva8dWadwiXXyjENGitti3LY30XiOUYQei8e
         /e/dCA9FiCyxSP9AeXArT4kywbp6ceAak6OgXn4bnwlyRt8VYfbp8DAJfujXTqLETq1w
         EJw9Ua47PqsPqUsaDLTGiZIKF4WDgKsVN31wZfYzWO7xh0hJHh6VwxSJY3v2YJh9qKzN
         wH/c+cXQxfJ7DrCdvrDkWxorqOB322yTcR8XOZFFFEqGl0iUlqnavSS4HkxuKkxBbVlB
         wZAnWV7KLT78GBIAE2vtSZekH260nEVinvBoteYWyCp7BqTkzl+QRxrGLpe8fGPAjHDL
         poOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752549288; x=1753154088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xukKaqe9PAfsuqh3akAQri8K5drTtDqGJNjKhDiM5uk=;
        b=ZOQyZmVQ1GflnK9wL9yLx0+FgtRjFno59OpWT4FlKOr7u2r3TXXumGAVLaoWtBA45s
         oKajgvnKBEn1Zqin1DbT5RB85M11+NFs/FTMTtpFoWl4dsL7ZMOaGPrmadYhH2SNVVy7
         efi8GlrycRQ8XqgTowqDV88OrrQI24IMEfNg1Vky8nrILuYFZ8XuOW5J6ii/kIEsybiF
         dD4CkWO/vigsO8My/GeNmab2gtqVuIc8k3yoBko6IBQkYGttXxjiDI5BAV7bPZME38U8
         jtOYaSo2+bYjOVgKfNSZLX6YVMG/npn99UGJLByIkMhBu80klPA245/iq6F+apsKK/JD
         Mmww==
X-Forwarded-Encrypted: i=1; AJvYcCXPxit+20ErF/PEd3deBUfBmcHj68QvSV/MjYaT0Vf3ZZWH4qhV7sxFO1Lh9Qu/xgOBPc0=@vger.kernel.org, AJvYcCXzMdKsAZ7yZedCiBYZwpRlmg+6WgkgFEgMyIX9qOMuNC8xK09vJXU5xHgB539MxtxYS5YS5iXhLqYFnefp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+CKr1aAP0v8Rul/at423gPu/+UCqXuA0ByyMnytBNN+/3PX6c
	iNfip3FgfYLPzwlW7IX+RKwHGKuYRxVg6LotZf6lLYTyCxFfD1OcVk3y/pGsGl6u7HLm3TisTW/
	uQsYwZhtJtal25tySL2o9LGf1dkrbaw0=
X-Gm-Gg: ASbGncsuHqO+NKFO9ViOOvQ5KQg3WL0Ff2dykWKewgfOMKiJTT0fhFOMSvkkuM2CEaF
	s2SaAYJ/bcMX9AaoIC21L6t8KefjGJqEboMcOxIy29fJ3EYC1bto0I7dTuOiKk49WOogfmeIe4c
	FnzAzCzVqc9RG9FpL2JrnjBa3yVEM0Kzzi6Yn7ZlojdtOuB+K3LZSdXBovutYek4B+KWxq3ulIe
	Hdp4no=
X-Google-Smtp-Source: AGHT+IGS3939WK2S9svD4e95V+yATeA39o6A/Xq2vxEW4PyhsyVx77d89yqLW4TtPTWUFp0xFePeIq9MkT5Ujfu/JlQ=
X-Received: by 2002:a05:690c:490b:b0:70d:ff2a:d69a with SMTP id
 00721157ae682-717d5ded79emr244280217b3.27.1752549288191; Mon, 14 Jul 2025
 20:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-2-dongml2@chinatelecom.cn> <CAADnVQ+zkS9RMpB70HEtNK1pXuwRZcjgeQjryAY6zfxSQLVV3A@mail.gmail.com>
 <CADxym3ZGco3_V7w8+ZrJwnPd6nx=YKwYASWcUFOFyLe7L5oa_w@mail.gmail.com> <CAADnVQJYLSp0X-LiPftaDvU+SnJL84sgGM0M-=uQgq4g8=T=zg@mail.gmail.com>
In-Reply-To: <CAADnVQJYLSp0X-LiPftaDvU+SnJL84sgGM0M-=uQgq4g8=T=zg@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 15 Jul 2025 11:13:43 +0800
X-Gm-Features: Ac12FXwB7USSE4a2NmjRZECEfjVt0X7Smn2Ra2jefBEJSC3SXJJxkmErvGDsCEg
Message-ID: <CADxym3ZaiGYJWd-ME98G_=7q0EZA-sU7G=x=j5kcnNgRJ0893A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/18] bpf: add function hash table for tracing-multi
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Menglong Dong <dongml2@chinatelecom.cn>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 10:49=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 14, 2025 at 7:38=E2=80=AFPM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > On Tue, Jul 15, 2025 at 9:55=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Jul 3, 2025 at 5:17=E2=80=AFAM Menglong Dong <menglong8.dong@=
gmail.com> wrote:
> > > >
> > > > We don't use rhashtable here, as the compiler is not clever enough =
and it
> > > > refused to inline the hash lookup for me, which bring in addition o=
verhead
> > > > in the following BPF global trampoline.
> > >
> > > That's not good enough justification.
> > > rhashtable is used in many performance critical components.
> > > You need to figure out what was causing compiler not to inline lookup
> > > in your case.
> > > Did you make sure that params are constant as I suggested earlier?
> > > If 'static inline' wasn't enough, have you tried always_inline ?
> >
> > Yeah, I'm sure all the params are constant. always_inline works, but I =
have
> > to replace the "inline" with "__always_inline" for rhashtable_lookup_fa=
st,
> > rhashtable_lookup, __rhashtable_lookup, rht_key_get_hash, etc. After th=
at,
> > everything will be inlined.
>
> That doesn't sound right.
> When everything is always_inline the compiler can inline the callback has=
hfn.
> Without always inline do use see ht->p.hashfn in the assembly?
> If so, the compiler is taking this path:
>         if (!__builtin_constant_p(params.key_len))
>                 hash =3D ht->p.hashfn(key, ht->key_len, hash_rnd);
>
> which is back to const params.

I think the compiler thinks the bpf_global_caller is complex enough and
refuses to inline it for me, and a call to __rhashtable_lookup() happens.
When I add always_inline to __rhashtable_lookup(), the compiler makes
a call to rht_key_get_hash(), which is annoying. And I'm sure the params.ke=
y_len
is const, and the function call is not for the ht->p.hashfn.

>
> > In fact, I think rhashtable is not good enough in our case, which
> > has high performance requirements. With rhashtable, the insn count
> > is 35 to finish the hash lookup. With the hash table here, it needs onl=
y
> > 17 insn, which means the rhashtable introduces ~5% overhead.
>
> I feel you're not using rhashtable correctly.
> Try disasm of xdp_unreg_mem_model().
> The inlined lookup is quite small.

Okay, I'll disasm it and have a look. In my case, it does consume 35 insn
after I disasm it.

>
> > We need to protect the md the same as how we protect the trampoline ima=
ge,
> > as it is used in the global trampoline from the beginning to the ending=
.
> > The rcu_tasks, rcu_task_trace, percpu_ref is used for that purpose. It'=
s
> > complex, but it is really the same as what we do in bpf_tramp_image_put=
().
> > You wrote that part, and I think you understand me :/
>
> Sounds like you copied it without understanding :(
> bpf trampoline is dynamic. It can go away and all the complexity
> because of that. global trampoline is global.
> It never gets freed. It doesn't need any of bpf trampoline complexity.

Hi, I think you misunderstand something. I'm not protecting the
global trampoline, and it doesn't need to be protected. I'm protecting
the kfunc_md.

In the global trampoline, we will look up the kfunc_md of the current ip
and use it. And it will be used from the beginning to the ending in the
global trampoline, so we need to protect it.

But we can see that the life of the kfunc_md is exactly the same as
the bpf trampoline image. So we can use the same way to protect, which
prevent it from being freed if it is still used in the global trampoline.

