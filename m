Return-Path: <bpf+bounces-38420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42441964BB5
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 18:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6E6282D77
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 16:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA571B5813;
	Thu, 29 Aug 2024 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKJwOoto"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCED1B4C3E;
	Thu, 29 Aug 2024 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948856; cv=none; b=RD6IXPkht3OIYnXnDeCOz0SGXCWDs/8ZZ4Fk3nEnf86BMsk0npJFQqS6QI0b2xPOUOVJMj04D8I3skumOTwLiEGEkyeULLeXg8Zvov16XcTzVNbWNqWw+e5GOM8wgHUqfZMPj9iJmo6M4YHDdbhJHGDn8vfiaVUZb62QS+9z+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948856; c=relaxed/simple;
	bh=eLvYXE2yz/fAvs+3ie/busr97f6erakb9dNF3yzzH0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYaGnZHO3RW9zaLBu2m2ZloHjrvU2bBhjF1LD77gYnCL4HPiDAOHiaM9lj4mZXidE9ymXaoqxlxIG6vD+HYzZRz4DC3axkyThGRoc3k4lbZRJV+jD6DHBj2T6W7n2atkmoS0+YuJ30P2Q+ryA/8IxBlFENKx60PhiY/XXj9RF4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKJwOoto; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428e1915e18so7446775e9.1;
        Thu, 29 Aug 2024 09:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724948853; x=1725553653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcGXTdRd6WPKGiWNucLgLmix94On78py4jzzAZMzxTU=;
        b=CKJwOotoBEhkK8A2m4brwan5YnKa3kEKxip8Y9JExFS3jIx1KrdBN4x2FA4jznEcx9
         Bc++zYP+WLNGrT4kN/sVRNtOOl1U3I9xeSvNmBl23wj0SYJo+Unk7xWLQTICoiHj2hEd
         xQ395WdoYsq+vUHprGNie8RyBTKBZ1XTEeoE1vlzsaMigBaOJ1QKthmql7Yz4LMFRqRb
         HaUr7RM/puksWOf8RaTdyGRYqhibtg2fOb1RHft8TbE9lqJNWQQbQ40sx7oTKu8vaJWg
         AQaD6EbDIvIC2VI5/bNTZ9LwNKaAO70l2oRWIY20fOUI9ECUqMlHM3o1amoDcmlW+syE
         yoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724948853; x=1725553653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcGXTdRd6WPKGiWNucLgLmix94On78py4jzzAZMzxTU=;
        b=pGmj8j/E+BGoSHg3D/Cy/AaSQ121DxjeFk6fyCMCbBC/AE6ZJa3KLBd+lIfd2CJ+vq
         6JuP2Tos4su4hpvyQ7Mg9rbqspvRRhY2vqwimXQglTAkAntnMeaXVazhyinYkKHUsNdz
         RMIkXXBEwEi+9Bt4UfvMPO1GmWgRsSfRGNcQg3ookpLTzK/cD/Rgj0urcXXZRtEpx76t
         ItLasRiMd95eInlrSl2uENymGcksz1L93iv2KZFJu/utsmoT8UcZaD0dXdfATv6fd/ub
         VVLboGScCBmKaqKu6yYWAw0GSYqg441XfG5dzgPmJP8l6SewM1csyNCxiBwbdqrOk1Md
         hKTw==
X-Forwarded-Encrypted: i=1; AJvYcCV5uAcSY8ArAImftkKcqjr1xr+RoURNKOpqocf+cbbwLPSRv0wbKYDHVb0LcG8nbpXDnUg=@vger.kernel.org, AJvYcCVIq+box7z3tdNqRbb0b+mBBW3syBTZkyUcL7vAJtYs0f49u6nMFn6Gp8l3OXx1EEKCs+wij2R2+j2GvuKc@vger.kernel.org, AJvYcCXBs6BKxPErdmF6B+XjWlgUXkZpERpkXDaeL03KFDtjy9jjoOEexbeupijNbqO00n4+3jargggv@vger.kernel.org
X-Gm-Message-State: AOJu0YxOXfWPQU9+9nBOpGRSLZ/K2E8eOjdn0wRxypsPCD+d0/Zc71YN
	Kve660b5hTQ48iQAvmMQDfbs94rrbuphlfrzDT0nm7kalUEG/H7/OGEW2KU3/tSuDSM6iRQ5Y6E
	dQEifJ7ENyajAT36aemCjvS7hSuE=
X-Google-Smtp-Source: AGHT+IHs/WnNtIXb4q/iUBMt25HPdsxvozE/0N9Tj7fQbmDtFbEHALZdaQH6XWo8cNzvQHXSdUV93ADVuFcVF56fPRQ=
X-Received: by 2002:a05:600c:3b87:b0:428:abd:1df1 with SMTP id
 5b1f17b1804b1-42bb02ee46cmr30849495e9.9.1724948853022; Thu, 29 Aug 2024
 09:27:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821093016.2533-1-Tze-nan.Wu@mediatek.com>
 <CAADnVQLLN9hbQ8FQnX_uWFAVBd7L9HhsQpQymLOmB-dHFR4VRw@mail.gmail.com>
 <3a7864f69b8c1d45a3fe8cda1b1e7a7c85ac9aee.camel@mediatek.com>
 <49d74e2c74e0e1786b976c0b12cb1cdd680c5f58.camel@mediatek.com>
 <CAADnVQLvbMRvCg2disV+_AR-154BwRpeB8Zg_8YpO=7gzL=Trg@mail.gmail.com>
 <Zsk_lGsZBBqbesqS@mini-arch> <2efb1f4751fa47380d51ce538253983974a4947c.camel@mediatek.com>
In-Reply-To: <2efb1f4751fa47380d51ce538253983974a4947c.camel@mediatek.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 29 Aug 2024 09:27:21 -0700
Message-ID: <CAADnVQ+woLxmNNbU--YkVc8kqevBszNbNG3WoOwKQadWvBXF-g@mail.gmail.com>
Subject: Re: [PATCH net v4] bpf, net: Check cgroup_bpf_enabled() only once in do_sock_getsockopt()
To: =?UTF-8?B?VHplLW5hbiBXdSAo5ZCz5r6k5Y2XKQ==?= <Tze-nan.Wu@mediatek.com>
Cc: "sdf@fomichev.me" <sdf@fomichev.me>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kuniyu@amazon.com" <kuniyu@amazon.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "ast@kernel.org" <ast@kernel.org>, 
	=?UTF-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?= <Cheng-Jui.Wang@mediatek.com>, 
	=?UTF-8?B?Q2hlbi1ZYW8gQ2hhbmcgKOW8teemjuiAgCk=?= <Chen-Yao.Chang@mediatek.com>, 
	wsd_upstream <wsd_upstream@mediatek.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	=?UTF-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "song@kernel.org" <song@kernel.org>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"edumazet@google.com" <edumazet@google.com>, =?UTF-8?B?WWFuZ2h1aSBMaSAo5p2O6Ziz6L6JKQ==?= <Yanghui.Li@mediatek.com>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, "haoluo@google.com" <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 5:45=E2=80=AFAM Tze-nan Wu (=E5=90=B3=E6=BE=A4=E5=
=8D=97)
<Tze-nan.Wu@mediatek.com> wrote:
>
> On Fri, 2024-08-23 at 19:04 -0700, Stanislav Fomichev wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On 08/22, Alexei Starovoitov wrote:
> > > On Thu, Aug 22, 2024 at 12:02=E2=80=AFAM Tze-nan Wu (=E5=90=B3=E6=BE=
=A4=E5=8D=97)
> > > <Tze-nan.Wu@mediatek.com> wrote:
> > > >
> > > >
> > > > BTW, If this should be handled in kernel, modification shown
> > below
> > > > could fix the issue without breaking the "static_branch" usage in
> > both
> > > > macros:
> > > >
> > > >
> > > > +++ /include/linux/bpf-cgroup.h:
> > > >     -#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen)
> > > >     +#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen, compat)
> > > >      ({
> > > >             int __ret =3D 0;
> > > >             if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT))
> > > >                 copy_from_sockptr(&__ret, optlen, sizeof(int));
> > > >      +      else
> > > >      +          *compat =3D true;
> > > >             __ret;
> > > >      })
> > > >
> > > >     #define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname,
> > > > optval, optlen, max_optlen, retval)
> > > >      ({
> > > >          int __ret =3D retval;
> > > >     -    if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT) &&
> > > >     -        cgroup_bpf_sock_enabled(sock, CGROUP_GETSOCKOPT))
> > > >     +    if (cgroup_bpf_sock_enabled(sock, CGROUP_GETSOCKOPT))
> > > >              if (!(sock)->sk_prot->bpf_bypass_getsockopt ||
> > > >                ...
> > > >
> > > >   +++ /net/socket.c:
> > > >     int do_sock_getsockopt(struct socket *sock, bool compat, int
> > level,
> > > >      {
> > > >         ...
> > > >         ...
> > > >     +     /* The meaning of `compat` variable could be changed
> > here
> > > >     +      * to indicate if cgroup_bpf_enabled(CGROUP_SOCK_OPS)
> > is
> > > > false.
> > > >     +      */
> > > >         if (!compat)
> > > >     -       max_optlen =3D
> > BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
> > > >     +       max_optlen =3D BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen,
> > > > &compat);
> > >
> > > This is better, but it's still quite a hack. Let's not override it.
> > > We can have another bool, but the question:
> > > do we really need BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN  ?
> > > copy_from_sockptr(&__ret, optlen, sizeof(int));
> > > should be fast enough to do it unconditionally.
> > > What are we saving here?
> > >
> > > Stan ?
> >
> > Agreed, most likely nobody would notice :-)
>
> Sorry for my late reply, just have the mailer fixed.
>
> If it is feasible to make the `copy_from_sockptr` unconditionally,
> should I submit a new patch that resolve the issue by removing
> `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN`? Patch A shown as below.
>
>   +++ /net/socket.c:
>    int do_sock_getsockopt(...)
>    {
>   -     int max_optlen __maybe_unused;
>   +     int max_optlen __maybe_unused =3D 0;
>         const struct proto_ops *ops;
>         int err;
>   ...
>   ...
>         if (!compat) <=3D=3D wonder if we should keep the condition here?
>   -         max_optlen =3D BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
>   +         copy_from_sockptr(&max_optlen, optlen, sizeof(int));

This one.
And delete the macro from bpf-cgroup.h

