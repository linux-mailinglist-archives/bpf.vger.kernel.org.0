Return-Path: <bpf+bounces-36938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F93394F77C
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 21:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52381F21ABD
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2A6190470;
	Mon, 12 Aug 2024 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmfaMXn6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F8D18E02B
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723490958; cv=none; b=JhaqdL9YBEYWbiK+bk16GBLQhwIOnbvMS71sQq8KNOwVEHzk95YNVn3l51kwpI4oFVwBjlgZvLr3lqbZaj/mFKwU3n2P1l+PEdLiacLadclZj+0on6vDGyEbSAC1ss2KIgreoHGommc1jsc2AcaNxoci+RFFlQNTUUErr7lxTrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723490958; c=relaxed/simple;
	bh=REInXjLN8uT5pWbQ3a+yPQq1d1jdBkN+Kn6ugEOHPo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sh2SskOzz8Phw1n6Z5iVMdmyt6OOyoAe3CyZfGNO1dgiPb/+9gR4RTw6Kw8q5SR5TeV3I2zvJVoaDntRopytZhSCjLuIWldv4OcDNUfmCsqc2WVsXd9SwcLlbGJ+Dz1QcJKX9GI/s8J65J6+fUO52X+zXoWZyTpx31Mdm8JWig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmfaMXn6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso36217145e9.1
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 12:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723490955; x=1724095755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOc2UDZFHQE8hIL+HSi8YusMM0pyts/bs6F6i/AK9rA=;
        b=PmfaMXn6uySU9seJwwUaB9CgeVkAUYl9r6PphEVd/kVartC0MXeC/Z2U6aQWNVYW9K
         6NFSeTx4Njo0ku+JAGd+tQCIiVfBdf0cwjoXq9f11Upi1ACjsQ0AlnmJI11f33xpYkQe
         6baGzjBPZvYvhZyJe8HbaWuc7zlW36oDIuP8CsPKJnUSIIbWn59AVzkOaOQxCLecTLpF
         aFOqqdTyk3aUNDmqGdTKQERolYSEJgmqPWUt4R+jrkQ+mfO7FoS5bqU1eS2QXF2uGPoz
         nQU48cqaLFehImvlWJOd1Z06BGnT0vXKTgxUrbFNfE3kJGIK/6YxeCSM+IU+0PKRVDCz
         gHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723490955; x=1724095755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOc2UDZFHQE8hIL+HSi8YusMM0pyts/bs6F6i/AK9rA=;
        b=NQYkq41i+3eT/KuMnESy72t7IwaO0I3JDj61Hh+Blfm+mCk/d+9tWN425IY+xHV7Ie
         9nZRS314jQnzeyDVYtm/5+0ohAUyEgKltJDS00ekG5uOfm7TmWD3WT6l6JMiuZXJGtTW
         vDxzMpmHTsN0/c0k3+uqS707I7tRQG+Ix5sN7QG79mRdQg4OabRj4B87jJ5xEpOsDdCT
         MWdV8QbZvWj1L9VkmlgfDaXouhyoM+wwdGrLqDmEur13UbKpDep0rOjWHJ/YGtTJLYL1
         OaB8XGIE3D3cmyelQpGatKOOaztI8sZqRA22PRgoWalMwexLJuapP6Aw6OBTq7fCP04y
         oq6w==
X-Forwarded-Encrypted: i=1; AJvYcCX4s7Dqu/CVG5rd7WsIqjoOmVORPZmSYqXfwVzSKqHT20yFxfOlYDWWT5AhLwaCWWs2hZFuS9SanWoF6MVpDS+nyvlt
X-Gm-Message-State: AOJu0YxKT3wrTSxEFITu8nfFIPUgT6B3I7C1qq2K8dQL1lh7rxm6Gatw
	k13bVgVvA4wJYcLDTRNLdun0mfhBWu+qZcaU7laP/ddpjVbBAPsAfcS0hjji5Eiqcz70CPbweC+
	ULfU8+PU8o4WPQITLJTWYolxkepBKkS3V
X-Google-Smtp-Source: AGHT+IG9eUkax4lU4MKbzV9cI0Ex/EAGjUYFHtpFD+JfrAfP7yZaLYNrjkM2mozbCxvKXXMx/BXeqWw+s0odtwO6JgY=
X-Received: by 2002:a05:600c:358a:b0:426:5269:9838 with SMTP id
 5b1f17b1804b1-429d47f43a1mr10870615e9.4.1723490954606; Mon, 12 Aug 2024
 12:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812052106.3980303-1-yonghong.song@linux.dev>
 <ffac004eab4bfe98c5323a62c6e47b25354589bb.camel@gmail.com>
 <CAADnVQ+-om1OWRyUvWoiVg5pKM7cxOCVw4wZqdZM1JTRTg4-5g@mail.gmail.com>
 <d2ca7ec0b51fef86ef8cd71202ee5b6de7dc42cf.camel@gmail.com>
 <CAADnVQJjY9NU7WBxUNqOnLEpm6KhgHL0M_YobQ=2ZjMUHq3_eA@mail.gmail.com> <551847ff89db0df953c455761e746a0d80d3a968.camel@gmail.com>
In-Reply-To: <551847ff89db0df953c455761e746a0d80d3a968.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Aug 2024 12:29:03 -0700
Message-ID: <CAADnVQJ2hFpT7ZxU8O36NB0YOq-ze96KJ0T=K3Wp1-qZU+0jBw@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix a kernel verifier crash in stacksafe()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Daniel Hodges <hodgesd@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 10:57=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Mon, 2024-08-12 at 10:50 -0700, Alexei Starovoitov wrote:
> > On Mon, Aug 12, 2024 at 10:47=E2=80=AFAM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > On Mon, 2024-08-12 at 10:44 -0700, Alexei Starovoitov wrote:
> > >
> > > [...]
> > >
> > > > Should we move the check up instead?
> > > >
> > > > if (i >=3D cur->allocated_stack)
> > > >           return false;
> > > >
> > > > Checking it twice looks odd.
> > >
> > > A few checks before that, namely:
> > >
> > >                 if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_REA=
D)
> > >                     && exact =3D=3D NOT_EXACT) {
> > >                         i +=3D BPF_REG_SIZE - 1;
> > >                         /* explored state didn't use this */
> > >                         continue;
> > >                 }
> > >
> > >                 if (old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=
=3D STACK_INVALID)
> > >                         continue;
> > >
> > >                 if (env->allow_uninit_stack &&
> > >                     old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=
=3D STACK_MISC)
> > >                         continue;
> > >
> > > Should be done regardless cur->allocated_stack.
> >
> > Right, but then let's sink old->slot_type !=3D cur->slot_type down?
>
> It does not seem correct to swap the order for these two checks:
>
>                 if (exact !=3D NOT_EXACT && i < cur->allocated_stack &&
>                     old->stack[spi].slot_type[i % BPF_REG_SIZE] !=3D
>                     cur->stack[spi].slot_type[i % BPF_REG_SIZE])
>                         return false;
>
>                 if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ)
>                     && exact =3D=3D NOT_EXACT) {
>                         i +=3D BPF_REG_SIZE - 1;
>                         /* explored state didn't use this */
>                         continue;
>                 }
>
> if we do, 'slot_type' won't be checked for 'cur' when 'old' register is n=
ot marked live.

I see. This is to compare states in open coded iter loops when liveness
is not propagated yet, right?

Then when comparing for exact states we should probably do:
if (exact !=3D NOT_EXACT &&
    (i >=3D cur->allocated_stack ||
     old->stack[spi].slot_type[i % BPF_REG_SIZE] !=3D
     cur->stack[spi].slot_type[i % BPF_REG_SIZE]))
   return false;

?

