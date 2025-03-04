Return-Path: <bpf+bounces-53144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFCFA4D060
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 01:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21F91887B29
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 00:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6338C7083A;
	Tue,  4 Mar 2025 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6asW5bj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373B83A8D2;
	Tue,  4 Mar 2025 00:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741049159; cv=none; b=UWDbvqdjufnCbZKE/jIpo5drGy1eSp+5FTFCqnkQIkBCzLYqJnnfDx+Vw7vhDsaVI8JJ37dNciUGpXMwEuQKvm9iJfPtGFM27uWEgyf83Mzlc6CUS8Y7Cp+e75CQTFDDm3vkJNRtpmFOz9Lcpspt8DB4kMQipTG85GCRdKviJP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741049159; c=relaxed/simple;
	bh=vkzjz3ctK7/+9gjakz/Igs+oV7SZ+OPIeCbCepzr7Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dy7mjk5QTMV/G/yWSPXDB+MCj9u0TzRxrHn2U6Zfs4B2AoMhFrHqoWEKmUaO7Tgfy/lXF/c/Z86J/IXMoMx2nDc9D4hJKGJbPOkTrcJJK3sNvismZuRcYWkcYyQjhVyrkNIX/6XAHZRv5kphvnUngVflTmL/X/zT47wnXfJUGn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6asW5bj; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f403edb4eso2920490f8f.3;
        Mon, 03 Mar 2025 16:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741049156; x=1741653956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfEqBGvtNzR0G45Bk+6Z+AfzCK4ABkw8MT0g5a3BjEk=;
        b=f6asW5bjXxCgrL2CoriCkYm9/idCIEgTgOnudUzX3ZzTbCB2ONiT1XbM8di0fKNvam
         jpCLqW8oGuOz0M9BBTGFQhleCRwsT98rePl2GucgYgevYp0QkWM5vMYP4EXjd7PvKaPm
         nRNPR/I0AD/rx8r1tiOR9kFeEcoJ1GA79T3EMCRq2eSL9/3/mo1A2YxxGQMZp+nA4JDp
         vVEr1dSoiLpjaE9Jcpcou6klIaUf8HeDy1zeO/ZHESid64p4QwXixQcr+Brx9IJVl+MF
         d3ZFwm+CIVM28H4ysaPA2XIV8wVp+6Wfnsuky/HBp2ssrQl9NebZVzNcRN5hyMkUg63S
         b/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741049156; x=1741653956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfEqBGvtNzR0G45Bk+6Z+AfzCK4ABkw8MT0g5a3BjEk=;
        b=YgnxaEOJtQJSSSJ4wCEGHVWd1NPxbCaiZ1efAO/bfs0YKWIaJS7ruVbszESHzZBNbY
         LXyoGWqar0OL3TwYhVsnrHHXX7KvxckLmzLme3i0KhFPu9+mY5O3dfo4H2+PeGGn/qgc
         MKTFeCNogxaMFgF2RaI/YjLGNi5b3u2fmyQPncJ5zmodUBMKXyR/Fu59tWB1IIb5pB2G
         ujc7ftHEaHpYEfromsHHjZdJHMMzcZoN8sB4SVOtVivULQU/9a7UnZmPnqqUC12JX9kO
         L/sRvTOVhKJGaiNmS/OuiduzgAl8Ucq7rTOh9OkQ4zGNmdiJIaE3sYYtuS26QMbxrGi7
         3JXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxmodph5Mh2FDf08GZyxroLQmbtosuGz/FeWtighT8gmG1uSYQ7b5GSYfgdaxeYO5n5MZP2lP3pjk+zRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEs3uw07APWWSRNhq3zocJH5lbJ7sUS9tB4IXk+sYWDOb8fWzR
	T02iJbA6qM1xs4yTakJpt5lbhQWmn9bXVmL5xV6SsuHJP9EqNqZEaWzr+v++PFZHpKsDEvd4MOz
	Bzb2TVEBI3OA0IlRQXmT+ncmu8Bc=
X-Gm-Gg: ASbGncsm+cfBj1YKVeJMGKiAXowXK5lmarY8znqo7TLurVd2UszsTa0Z8f3OHht3sKB
	+iHi8KPo0fxiOjHfD/CD/bhZDoQCNliMxBwy8LK8ERUr6g9YCJ5Va6TkKekYMiXiGOZXI8PfJEL
	iqvvmID24xn5W3oetQOKRMqu7sQbwunETtTyHxy6vFKQ==
X-Google-Smtp-Source: AGHT+IEeCQOoKVLy4aSX1gkhOY/8NCtlxOej7jcHLIrdLW4wuHtUOO9CoIgsFDaGt9gEKcs42bRRcl7/VDvF1Nuu3vQ=
X-Received: by 2002:a05:6000:2112:b0:38f:6149:9235 with SMTP id
 ffacd0b85a97d-390ec7cba70mr13100812f8f.16.1741049156403; Mon, 03 Mar 2025
 16:45:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741046028.git.yepeilin@google.com> <b0042990da762f5f6082cb6028c0af6b2b228c54.1741046028.git.yepeilin@google.com>
 <CAADnVQKX+PoSUqPBB2+eZrR7wdq-8EVaMxy_Wur7g8wyy3Dcmg@mail.gmail.com> <Z8ZL1L69z8XWm8vl@google.com>
In-Reply-To: <Z8ZL1L69z8XWm8vl@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 3 Mar 2025 16:45:45 -0800
X-Gm-Features: AQ5f1JqY-QHGbRkFB0PZC5Se3XKsPl7QHq1ktYT5k72ZsvNzYpgqlyxSmJn0sLk
Message-ID: <CAADnVQKB-9q6fxcVPbd7Ee+QBH=_ySv2EyULkgFhv_n2i07L1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/6] bpf: Introduce load-acquire and
 store-release instructions
To: Peilin Ye <yepeilin@google.com>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, bpf@ietf.org, 
	Alexei Starovoitov <ast@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, David Vernet <void@manifault.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 4:39=E2=80=AFPM Peilin Ye <yepeilin@google.com> wrot=
e:
>
> Hi Alexei,
>
> On Mon, Mar 03, 2025 at 04:24:12PM -0800, Alexei Starovoitov wrote:
> > >         switch (insn->imm) {
> > > @@ -7780,6 +7813,24 @@ static int check_atomic(struct bpf_verifier_en=
v *env, struct bpf_insn *insn)
> > >         case BPF_XCHG:
> > >         case BPF_CMPXCHG:
> > >                 return check_atomic_rmw(env, insn);
> > > +       case BPF_LOAD_ACQ:
> > > +#ifndef CONFIG_64BIT
> > > +               if (BPF_SIZE(insn->code) =3D=3D BPF_DW) {
> > > +                       verbose(env,
> > > +                               "64-bit load-acquires are only suppor=
ted on 64-bit arches\n");
> > > +                       return -EOPNOTSUPP;
> > > +               }
> > > +#endif
> >
> > Your earlier proposal of:
> > if (BPF_SIZE(insn->code) =3D=3D BPF_DW && BITS_PER_LONG !=3D 64) {
> >
> > was cleaner.
> > Why did you pick ifndef ?
>
> Likely overthinking, but I wanted to avoid this check at all for 64-bit
> arches, so it's just a little bit faster.  Should I change it back to
> checking BITS_PER_LONG ?

In general #ifdef in .c is the last resort.
We avoid it when possible.
In core.c we probably cannot, but here we can.
So yes. please respin.
I bet the compiler will produce the exact same code.

