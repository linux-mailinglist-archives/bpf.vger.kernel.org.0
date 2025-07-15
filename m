Return-Path: <bpf+bounces-63341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA566B0643A
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 18:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6113B1AA6
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D890B26738D;
	Tue, 15 Jul 2025 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfRG7El0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB7B2459F7;
	Tue, 15 Jul 2025 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596568; cv=none; b=Ex6dfTnZQcVxZrky5wUFzefQn1CU1l4P6uDjPuAY0JPHYayhU7FTwCk8yrZ80VhUowgd3GuC2NKk8g4kh1MMFsZchnLTgCj8vsg1x+u4DvqPd6TZyfZTk3bC+BN1U5kZF0Rns/bXlPlZlDfb60wbH0Nf8nyHWPlbZAwBYCsxPhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596568; c=relaxed/simple;
	bh=+1Ze9/yob1HTWm92veCRdhxSc68twAkmewRPTpVbuuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEP1vnLrc8FaPz3fPq6ChunVEJSCVi/ADY9WSxjwUhBH7hlpiukUv+eC+kfTsaZh5bxQ6AFjzW9JT5mW/Vtnah41Xe6zujUjF/vz4OOIHLlggvzyxdSs4NeguGLcyHvZ1quIIGhqlS0k4S9tjlK8DIpYjXuHXlB7rpvYhFXyxDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfRG7El0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso25292105e9.3;
        Tue, 15 Jul 2025 09:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752596564; x=1753201364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCrTzswAv7V3lKbAvZpGB9xmDwHzuSD9IuOtS32OuU4=;
        b=FfRG7El0xxsf3d9KMArZ/cz5ZmnMoomfPjhs6Rw6udzYE2GdmAq3PvcmvsE6o5TMqc
         vJW+t/cTgYHILlljD36RBe/Q4WxLodn+1bO6Epg6XscqUsf9OM4zUYlpZ6klgK5UTv/C
         y7VYL28P0NkfcsoZrebhxUxGgys9A1lMIf05p/BSW0PxdXvW0SahjNvk55lm0CC68SFA
         Df6Re2VigugFPCsPML+0cqj2wag8GgGWJENl5wY1cZmautDZTlbD8g4kP7LOwjkH0AsG
         3faTFmCbYv2eTGkxZFsUOYrXLLDZvWy9gCeVBGCuYajjEqCSCsC7AjnLpwzSJV6P+8+J
         WEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752596564; x=1753201364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCrTzswAv7V3lKbAvZpGB9xmDwHzuSD9IuOtS32OuU4=;
        b=T0bTQcX1kxHMK5oqNKh94kyJFmKUu0Xf/9Wbb442IGWZ7hwBH4qV69BuHEbJYEjtxN
         34U8bB0VgZTDWecEWMXx4NWDjvV/HdvmqE3xExGJv2t5J31hSnx1o3lmTQVHmZztZZGQ
         1prE+XJXoXkJkk8h945JCd1J4gD8QjS1f5ZMrkBL+aalWtyad0jObGPiDE2Oad5dZJew
         oRw9YsrORv55jc3zIaPPmjzCOCAPRU8ws/bWLc0UvJZEiiYrvbuiQS5NYuqi4XApAbxG
         16ScqluHXqF7pqTv6JzGzCWs9ujt+aolygJoTmQy6E9JVIjAH7iF2eHHZg8kabWTYsFp
         yDxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzqSjK42rxTC26S7oqiCldxmC4kpCnEoARRQQ++NosTHz6/UmHsn+ReLITWMeUYUijWR/F34QacSDF8Hfc@vger.kernel.org, AJvYcCXGu9VG33V4fEmqpsGzBVRNjDAGDFxwrOPjJnNo8GmAUm9tfbHFcf8PMAwpFd4cVy2YPnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsZI8/dv2EMmDwmq0YBaa5MVXnZOa+kUzKmHmn5/qNhpvsTMuM
	XM5miY8kAoiC4HwKH1LaIuIJpNOsWIT0VK0SHI4DcIB6xDLZEQcygYsTfx30QUmitrGJ9ZpkFHo
	EUBIr/kFlCMbh7nm0capexue4Oo/ra5A=
X-Gm-Gg: ASbGncvs6TIoaWsYmPUvroYoI9IzX8ZyIGYjs8hfP9q0JWpaw6j9leMxIjoIn9CYUjy
	ADoCHxa4Z0Bw3RRUbI5oPDYsqDGLy7RWy4xCQvGhtDTObOFZpGnHLV4I1r3zMI/tOjI7Z3CTO4d
	W5h8SmjR7q/Sb7lJZj0UY8d21YX1P78JjWxoi0JVjAI5mM2bqdpJJjsiL22kDbXgBX7oM98LWPg
	Ex2Wy4/oVrxgPwMRUG3Yeo=
X-Google-Smtp-Source: AGHT+IE6Om43yzLlY/Y6NgYAMfVai8nZc1bXzJBj0k9Emy/SRSvBvouDyaDRSkybH9eP0KrxChCRuaN75+7EuYv34bg=
X-Received: by 2002:a5d:64e8:0:b0:3a4:e480:b5df with SMTP id
 ffacd0b85a97d-3b5f2e33b06mr14079026f8f.44.1752596563804; Tue, 15 Jul 2025
 09:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-2-dongml2@chinatelecom.cn> <CAADnVQ+zkS9RMpB70HEtNK1pXuwRZcjgeQjryAY6zfxSQLVV3A@mail.gmail.com>
 <CADxym3ZGco3_V7w8+ZrJwnPd6nx=YKwYASWcUFOFyLe7L5oa_w@mail.gmail.com>
 <CAADnVQJYLSp0X-LiPftaDvU+SnJL84sgGM0M-=uQgq4g8=T=zg@mail.gmail.com>
 <CADxym3ZaiGYJWd-ME98G_=7q0EZA-sU7G=x=j5kcnNgRJ0893A@mail.gmail.com> <CADxym3ZYCYgFokxoq0d5jEJ8V73KsJmYQnHtxWc3RO_8X5zC8Q@mail.gmail.com>
In-Reply-To: <CADxym3ZYCYgFokxoq0d5jEJ8V73KsJmYQnHtxWc3RO_8X5zC8Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 15 Jul 2025 09:22:28 -0700
X-Gm-Features: Ac12FXxTUy_tZQGdA1_55VRUDvqDYnK8VzK9J1u7I7q91jqLAZQUZ85fQJs4htM
Message-ID: <CAADnVQLz7KwQVhpmPQ2X345UvpdHR+rj4NApi2EBO5kXO4_Mqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/18] bpf: add function hash table for tracing-multi
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Menglong Dong <dongml2@chinatelecom.cn>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 2:07=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Tue, Jul 15, 2025 at 11:13=E2=80=AFAM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> >
> > On Tue, Jul 15, 2025 at 10:49=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Jul 14, 2025 at 7:38=E2=80=AFPM Menglong Dong <menglong8.dong=
@gmail.com> wrote:
> [......]
> > >
> > > That doesn't sound right.
> > > When everything is always_inline the compiler can inline the callback=
 hashfn.
> > > Without always inline do use see ht->p.hashfn in the assembly?
> > > If so, the compiler is taking this path:
> > >         if (!__builtin_constant_p(params.key_len))
> > >                 hash =3D ht->p.hashfn(key, ht->key_len, hash_rnd);
> > >
> > > which is back to const params.
> >
> > I think the compiler thinks the bpf_global_caller is complex enough and
> > refuses to inline it for me, and a call to __rhashtable_lookup() happen=
s.
> > When I add always_inline to __rhashtable_lookup(), the compiler makes
> > a call to rht_key_get_hash(), which is annoying. And I'm sure the param=
s.key_len
> > is const, and the function call is not for the ht->p.hashfn.
> >
> > >
> > > > In fact, I think rhashtable is not good enough in our case, which
> > > > has high performance requirements. With rhashtable, the insn count
> > > > is 35 to finish the hash lookup. With the hash table here, it needs=
 only
> > > > 17 insn, which means the rhashtable introduces ~5% overhead.
> > >
> > > I feel you're not using rhashtable correctly.
> > > Try disasm of xdp_unreg_mem_model().
> > > The inlined lookup is quite small.
> >
> > Okay, I'll disasm it and have a look. In my case, it does consume 35 in=
sn
> > after I disasm it.
>
> You might not believe it when I say this, the rhashtable lookup in my
> kernel is not inlined in xdp_unreg_mem_model(), and following is the
> disasm:
>
> disassemble xdp_unreg_mem_model
> Dump of assembler code for function xdp_unreg_mem_model:
>    0xffffffff81e68760 <+0>:     call   0xffffffff8127f9d0 <__fentry__>
>    0xffffffff81e68765 <+5>:     push   %rbx
>    0xffffffff81e68766 <+6>:     sub    $0x10,%rsp
>    [......]
>
>    /* we can see that the function call to __rhashtable_lookup happens
> in this line.  */
>    0xffffffff81e687ba <+90>:    call   0xffffffff81e686c0 <__rhashtable_l=
ookup>
>    0xffffffff81e687bf <+95>:    test   %rax,%rax
>    0xffffffff81e687c2 <+98>:    je     0xffffffff81e687cb
> <xdp_unreg_mem_model+107>
>    [......]
>
> The gcc that I'm using is:
> gcc --version
> gcc (Debian 12.2.0-14+deb12u1) 12.2.0
>
> I think there may be something wrong with the rhashtable, which needs som=
e
> fixing?

Try multiple compilers.
gcc 12 is quite old.
Making software design decisions based on one specific compiler is just wro=
ng.

