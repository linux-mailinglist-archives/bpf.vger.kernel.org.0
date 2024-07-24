Return-Path: <bpf+bounces-35458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9E393AA83
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 03:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D60281B3E
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 01:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD0A8F47;
	Wed, 24 Jul 2024 01:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpAhEJ2E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30474C9A;
	Wed, 24 Jul 2024 01:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721783874; cv=none; b=QS0ntqcplScMAbzXdf01lXU8o6cD46WpnBIu/65Brxq/tBiqpOKbsGzvRCdmrtKIl5WWZwuCRqY3zV8Xtc5gMxZUcQpAtmFziuh+qUD9Kw/FgFrj3iLIbsdSC+KpLfGwl4bdBwnL+gBRufzyUDrN7zHt6blwro5f/D2woeZHzOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721783874; c=relaxed/simple;
	bh=KkecNZKY3nbMCSSkETEzc/mfnZaV7kZfSSY4gRjGJRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1LcztLkmhY23pMAsMc6l0UaTl4Dsn03mxvy4J9RDXzRx+rt4DooUHl0+So9H3lqu5hwipRb0c1/uym1lDdppumJI5Mu3Do/GnH4Nwzv50AVsDASKgjJuKSzEEEMaYaoJA68TRnN4WeZfH2BjzcXYX7uSRdqVL69Jlee+/rDZLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpAhEJ2E; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266b1f1b21so45932005e9.1;
        Tue, 23 Jul 2024 18:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721783871; x=1722388671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rpc/2SwkiTZTr0tB2COZXlj9ID1K7BEkSuF6F5pqIeU=;
        b=MpAhEJ2EKPqPplis5PuUfb5x05eTQUTy3ORtPhj7SkC8z0jpy3NWHLMclbKHDzZOB8
         M0ejq/22FdJLrkJGzPCvs9AqAU2lvb0deYyWjgMnL+RKY3zgIAA3zZQvddE70YbxS0zt
         5DKHKDnU0f+tZrQQmR8kQfxiMbLCiOcytZkVp3nrfXVlzkNhtIX/yoxHtJR//U6Dh7eR
         e9Gr6v4VWuNeP+WTY1W6gLu8exUPGz86YeQeREUw6GsXzs+1lmrnpe9p7DltAMinT+PR
         7485hcafXm7WWCpQWd1WhypiNH8CYl3KddNXGNqb9txPfrJx6SSvDA11pspRs09SqvQC
         WX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721783871; x=1722388671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rpc/2SwkiTZTr0tB2COZXlj9ID1K7BEkSuF6F5pqIeU=;
        b=kW7KkgUJWUQfMpZVjHZ/C980/c+R/Fl0XvTLVzOu5Qs2ZvkRajeCy/yJ896F/xsFAb
         FL+UMI0cHJQ5U7I1Ky46xgQwNbn4nfnrk8prAAxO3td0IbUC/bd0lsTHg+mNWfyOJNUX
         FRdhAx9RnZsv8/PWn+Ud6hoZs8GoID9MFJGMCBHBgOvtHc2LSIJmksqJ3TGlXh7QUPuH
         vs4AbQHp8HK83DKkHouZHq9ofdbnSWN8noOf37n0VRd68oA8VqlhA9Ka62xmaIwYZfPF
         xMeY09GNHzOVo0UdkacaDri3ULWh1CSX3QMNxGOv5cy0UA3ZvgfEWNbU6Uzkrp3zByYK
         bpzw==
X-Forwarded-Encrypted: i=1; AJvYcCWNir4Bt3UrU16JbOC+j7DWSeWvBUGDmxYZUCZIjzktAZtpCFLfgwQ4/kBsYCDe5Y4X96SQTqxe3SKSKPqvakJ7E2Up7C6hQZEOs/nEuvVyusr67/9jqmDO8jejtoZ+RpxkUnRbLWEdUTIIgegXjM8T6kaKCSFYTq05HMZxbfHKuWbA
X-Gm-Message-State: AOJu0YzOy0PC+Li7H2SOa3VFxWesUs+IgIse5ZS5isRPMvtuK1MiwaeI
	3qB23FsFHG8KAkJ3/6RpNN8XqxyphDZFi3+xrLp/RMCOInTiKN6AgQBZDvTIRhi+67OXpb4jXBS
	yZ3gSInKVbbJSG0rsr8hHI+QtoHA=
X-Google-Smtp-Source: AGHT+IHy0gPavcCN7w+YuH/0mLjZRQm5fwtPN9TUK6LYu1xWYik/PO4O2Ozh9BgSdVar1Jki8LWGHqUKAwwdc8vHvaQ=
X-Received: by 2002:a05:600c:5487:b0:427:9dad:8063 with SMTP id
 5b1f17b1804b1-427dc51d315mr64923375e9.12.1721783870879; Tue, 23 Jul 2024
 18:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719110059.797546-1-xukuohai@huaweicloud.com>
 <20240719110059.797546-6-xukuohai@huaweicloud.com> <a5afdfca337a59bfe8f730a59ea40cd48d9a3d6b.camel@gmail.com>
 <wjvdnep2od4kf3f7fiteh73s4gnktcfsii4lbb2ztvudexiyqw@hxqowhgokxf3>
 <0e46dcf652ff0b1168fc82e491c3d20eae18b21d.camel@gmail.com>
 <CAADnVQJ2bE0cAp8DNh1m6VqphNvWLkq8p=gwyPbbcdopaKcCCA@mail.gmail.com>
 <2k3v5ywz5hgwc2istobhath7i76azg5yqvbgfgzfvqvyd72zv5@4g3synjlqha4> <cgarsuloniffcqn5zjjomhmm5xd72t4cdiwavjqnvmgqfuc7dd@2itjdtwcq7gk>
In-Reply-To: <cgarsuloniffcqn5zjjomhmm5xd72t4cdiwavjqnvmgqfuc7dd@2itjdtwcq7gk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Jul 2024 18:17:39 -0700
Message-ID: <CAADnVQLZ+fDDR9cFSD8QZghXP6nEmmPP23YWd5-ysA1sZ9ZsGA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/9] bpf, verifier: improve signed ranges
 inference for BPF_AND
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Yafang Shao <laoar.shao@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, James Morris <jamorris@linux.microsoft.com>, 
	Kees Cook <kees@kernel.org>, Brendan Jackman <jackmanb@google.com>, 
	Florent Revest <revest@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 12:07=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.co=
m> wrote:
>
> On Tue, Jul 23, 2024 at 02:36:18PM GMT, Shung-Hsi Yu wrote:
> [...]
> > > +1
> > > Pls document the logic in the code.
> > > commit log is good, but good chunk of it probably should be copied
> > > as a comment.
> > >
> > > I've applied the rest of the patches and removed 'test 3' selftest.
> > > Pls respin this patch and a test.
> > > More than one test would be nice too.
> >
> > Ack. Will send send another series that:
> >
> > 1. update current patch
> >   - add code comment explanation how signed ranges are deduced in
> >     scalar*_min_max_and()
> >   - revert 229d6db14942 "selftests/bpf: Workaround strict bpf_lsm retur=
n
> >     value check."
> > 2. reintroduce Xu Kuohai's "test 3" into verifier_lsm.c
> > 3. add a few tests for BPF_AND's signed range deduction
> >    - should it be added to verifier_bounds*.c or verifier_and.c?
> >
> >      I think former, because if we later add signed range deduction for
> >      BPF_OR as well...
>
> I was curious whether there would be imminent need for signed range
> deduction for BPF_OR, though looks like there is _not_.
>
> Looking at DAGCombiner::SimplifySelectCC() it does not do the
> bitwise-OR variant of what we've encountered[1,2], that is
>
>     fold (select_cc seteq (and x, y), 0, A, -1) -> (or (sra (shl x)) A)
>
> In other words, transforming the following theoretial C code that
> returns -EACCES when certain bit is unset, and -1 when certain bit is
> set
>
>     if (fmode & FMODE_WRITE)
>         return -1;
>
>     return -EACCESS;
>
> into the following instructions
>
>     r0  <<=3D 62
>     r0 s>>=3D 63 /* set =3D> r0 =3D -1, unset =3D> r0 =3D 0 */
>     r0  |=3D -13 /* set =3D> r0 =3D (-1 | -13) =3D -1, unset =3D> r0 =3D =
(0 | -13) =3D -13 =3D -EACCESS */
>         exit       /* returns either -1 or -EACCESS */
>
> So signed ranged deduction with BPF_OR is probably just a nice-to-have
> for now.

Yeah. Let's not complicate the verifier until really necessary.

But I wonder whether we should override shouldFoldSelectWithSingleBitTest()
in the backend to suppress this optimization.
I guess not, since removal of a branch is a good thing.

