Return-Path: <bpf+bounces-63307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E34B2B055D9
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 11:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15E53561FB8
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 09:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182BD2D5424;
	Tue, 15 Jul 2025 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+lec57b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9B22D4B65;
	Tue, 15 Jul 2025 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570431; cv=none; b=VX86XnxjNmpR+nBFBYY3gRBN+zVBffIjNTdjY2aUtw8EmUXwHNcdIOI5SloChQZrY4c2M0qYyS1PPXMe1j4Se6cnkOA5aPiMxOcrirT8XCtMeUdzAN9F31WO6eASTLxtS1wdJ7QMwSgLyYzAmsKqMNndqxBhzT3m4RI9ilISd9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570431; c=relaxed/simple;
	bh=vPOxKOj09MCFpIfuHdW2KVUL8ws2hMfRVcON4GqhVCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owTfcfxqdCfaGIxVCRPcK9m87vgD6UnUTk1qPf2YFxPC/6Cr5/BH06oOCVmDlJVDXh0v7XaX+sMNas6hn+TuNn4cRiF8qiBIedOjwn2m2O+weJIVpz1eEdQcqMErBIMuO1y+YirgnCSMgkJWGqHp/QZX5RAe6l5FqG/poxlVFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+lec57b; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e8b67d2acfbso4711011276.2;
        Tue, 15 Jul 2025 02:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752570429; x=1753175229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hjkdd70zZ6BVlwMKCTh+G2kyaZDVk6OEp60Hyz0mtZ0=;
        b=G+lec57bteSIj/vDakJaMmzjM7PbYGilu0w5JdEnhphB0R3tCsa9XbNNqwGWHyLqLL
         ao46rm5LfBTYOlhE5yCJ43VC4Pp1vqJb+YW04f4EhpHHo/6v9m3cUh1sT1Ohad06y2rC
         Dl7GKrenumI3pwoGt/IKYNlrRXaomC69Q+RuCDrFryi2j0XwgN7m5yxXpo78MCPJaG+N
         16UH1uGxO+cnCbX3Ckw8SVpOmvWyoeOQZ0RyevTRl9hJ88RpuNlIWzDfnDrgW8Km+tSZ
         4Ccv9Hk9s4HtzESChbnmEG3n8nmIbq5UCCCuzG7k/BTgaZTai/GyFNfs9Ij34eQZPOIV
         WJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752570429; x=1753175229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hjkdd70zZ6BVlwMKCTh+G2kyaZDVk6OEp60Hyz0mtZ0=;
        b=hW3y5JtN61pZGuSIwKbuGv9RGzyiEzdMvK/VmZ7EVf7OJwSK3801Fy0eqrrUgtNLXm
         1meJtoMui8Vc0//tmKUymlyO8om7HXuH0pdkJO/oVRaokrHIQaO+gnLjRxfw60HTTzLr
         GKkxop2OTjQxaqhFjSlVj+71FgIUoyt9MFN+yovHiGdrIfrlxauFGE45J72EvAy1VRrB
         uT3zUGbQiDsB84+It65HeH7X1GCZMV3Aer/NqPLSbT7+m8nIfqFFmWJQl0nhBMQojYnf
         u4zSbmVGloI3LI3Tu0Hc3w3dAlWcWGAIw0DbF1rorqfePLuhRpiRUsrqFlwIXJcQbIJl
         lgxA==
X-Forwarded-Encrypted: i=1; AJvYcCVA/gKstEq5TuYe2km55kb6IKBG0kMGMk+Lm5yGX01u5edq2ZV2ScOLdy0cNG3cwXhgaxiiUWHg5B81cPtk@vger.kernel.org, AJvYcCWwZng3R7OFQ9qtJYZMYlBUGzNVeiiAMxsCFYR8QZR6q2LnIrcBMGhUQObPprvSeK216b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpTIEanhB33Z/mIfuu3DKISAc1pl+uETqTzonCXLnmX3wsz1vP
	npwTychKvRjSvghBQ7xCHpGWZ0H1+RtQ2P5Yg2PCx23MySh0DhuhnKwA6DQWq+P3cir3m/llF6x
	AwvJKM46rFvUyY4D3999zv3TIn13a+RE=
X-Gm-Gg: ASbGncsvaDxzTCEEUbBVIq8VRl4G6CLwLkTlF4dnwHlp6KRz6oM37Vfs6MwC8TC6kni
	8Z+vn6zLC/Cshg9lU2FJofhiR1Ohx8TbLPqRMm+Wvmd8Ct1te3c6c/rm3Mpc/f2rOdDj4n0iK/W
	K4pJ/LhZAun42Pc7FG5lNO2hg61twNI98GY06a1zyaPhtyNPpWvPWAouvmc0R7sKNdIjpiFNj9p
	ZYakrY=
X-Google-Smtp-Source: AGHT+IH8aiNxxuLd7EK1RsMum43mTDoVrkpE4cNGSFvpbR6HNOCtt24QMPyPWyndD8y1fp8u4F10fxh6U3tA+BID2Ls=
X-Received: by 2002:a05:690c:4809:b0:70e:719e:743 with SMTP id
 00721157ae682-717d5e0ea36mr228089067b3.26.1752570429186; Tue, 15 Jul 2025
 02:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-2-dongml2@chinatelecom.cn> <CAADnVQ+zkS9RMpB70HEtNK1pXuwRZcjgeQjryAY6zfxSQLVV3A@mail.gmail.com>
 <CADxym3ZGco3_V7w8+ZrJwnPd6nx=YKwYASWcUFOFyLe7L5oa_w@mail.gmail.com>
 <CAADnVQJYLSp0X-LiPftaDvU+SnJL84sgGM0M-=uQgq4g8=T=zg@mail.gmail.com> <CADxym3ZaiGYJWd-ME98G_=7q0EZA-sU7G=x=j5kcnNgRJ0893A@mail.gmail.com>
In-Reply-To: <CADxym3ZaiGYJWd-ME98G_=7q0EZA-sU7G=x=j5kcnNgRJ0893A@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 15 Jul 2025 17:06:04 +0800
X-Gm-Features: Ac12FXzZ6NOWp0p46NDBt8M5C-xEWFxQ-O4ywVKjZVPBSfghPghlncvDzCo5T9w
Message-ID: <CADxym3ZYCYgFokxoq0d5jEJ8V73KsJmYQnHtxWc3RO_8X5zC8Q@mail.gmail.com>
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

On Tue, Jul 15, 2025 at 11:13=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> On Tue, Jul 15, 2025 at 10:49=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Jul 14, 2025 at 7:38=E2=80=AFPM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
[......]
> >
> > That doesn't sound right.
> > When everything is always_inline the compiler can inline the callback h=
ashfn.
> > Without always inline do use see ht->p.hashfn in the assembly?
> > If so, the compiler is taking this path:
> >         if (!__builtin_constant_p(params.key_len))
> >                 hash =3D ht->p.hashfn(key, ht->key_len, hash_rnd);
> >
> > which is back to const params.
>
> I think the compiler thinks the bpf_global_caller is complex enough and
> refuses to inline it for me, and a call to __rhashtable_lookup() happens.
> When I add always_inline to __rhashtable_lookup(), the compiler makes
> a call to rht_key_get_hash(), which is annoying. And I'm sure the params.=
key_len
> is const, and the function call is not for the ht->p.hashfn.
>
> >
> > > In fact, I think rhashtable is not good enough in our case, which
> > > has high performance requirements. With rhashtable, the insn count
> > > is 35 to finish the hash lookup. With the hash table here, it needs o=
nly
> > > 17 insn, which means the rhashtable introduces ~5% overhead.
> >
> > I feel you're not using rhashtable correctly.
> > Try disasm of xdp_unreg_mem_model().
> > The inlined lookup is quite small.
>
> Okay, I'll disasm it and have a look. In my case, it does consume 35 insn
> after I disasm it.

You might not believe it when I say this, the rhashtable lookup in my
kernel is not inlined in xdp_unreg_mem_model(), and following is the
disasm:

disassemble xdp_unreg_mem_model
Dump of assembler code for function xdp_unreg_mem_model:
   0xffffffff81e68760 <+0>:     call   0xffffffff8127f9d0 <__fentry__>
   0xffffffff81e68765 <+5>:     push   %rbx
   0xffffffff81e68766 <+6>:     sub    $0x10,%rsp
   [......]

   /* we can see that the function call to __rhashtable_lookup happens
in this line.  */
   0xffffffff81e687ba <+90>:    call   0xffffffff81e686c0 <__rhashtable_loo=
kup>
   0xffffffff81e687bf <+95>:    test   %rax,%rax
   0xffffffff81e687c2 <+98>:    je     0xffffffff81e687cb
<xdp_unreg_mem_model+107>
   [......]

The gcc that I'm using is:
gcc --version
gcc (Debian 12.2.0-14+deb12u1) 12.2.0

I think there may be something wrong with the rhashtable, which needs some
fixing?

