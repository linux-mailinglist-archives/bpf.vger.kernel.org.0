Return-Path: <bpf+bounces-54090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9813DA624F2
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 03:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 485A57ADEF7
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 02:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0A8176AC5;
	Sat, 15 Mar 2025 02:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wz6B4J7J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0D8176ADB
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 02:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742007133; cv=none; b=nY4ZLdQ1jIK/qtWNwVfzMFMNY3iqMyQlOfGD4CwqXVopn2bWr5cAyttuO+FbYpn5Dy/JUJXy12bXco+CDUB+6wKvbB5BTX/E/TeyNW9Y72LC/fAvAwEKaeOKVKVVfcMJP0QjYY2IM5B4SM8HSMLDsJ/hQusU6mzmOrS4C/pbFUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742007133; c=relaxed/simple;
	bh=jhoxjoZ+4lCkPD9g48RLdaRJ6Y7qZGhcnPxWJ2Q9XVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNcCz0Su392VjbZiQpt6r1D78PkkisfbDaEJLs782aiiAFlUWnt6JF7aDiQhkzNTkm0MnVBX+9RV5W4d9u0d/bIMvsHFLSxh6aT7w1jeA/Zx/e/XfBFDA8fN0Hi6+pEIfAEfiq2O1h1wi9Mhz5ffOu3JTSc4RuIdPX4z72xb6e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wz6B4J7J; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-391342fc148so1757242f8f.2
        for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 19:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742007130; x=1742611930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNhPY2U3iuYo92ushxX+O4Txf9DexTmzSKvhqk8mvPs=;
        b=Wz6B4J7JbdpLzURomFoS8tpylc2iQGEAUL2UbDDctcozn1+GNHCLxmqDei2fEKWF1z
         OGfohXvur31HbsbfExV7Cf3vyCa6NXtWXfUJh54+uawjYH7t3kSgmBtKmmkMvnLA1lhh
         h6i0sL6/UCq1L+o9jFrZ6WwLt1qWuEdEUQU1weqJ+IU7JFgWIzu1kydEQjRTsTCD6ktg
         ZuidgyvCsOxDVCdGQupll8WRlAFSWQPyUJZWLcZAQBAtEwXxwsnfWHImq6Qm6Vz14z3P
         VYA+1whuSI2bIwTAjIbPuCNG5wzmeENGlbpgwsRyiAtl9GD4bAG2J3A924jsjeKa4a0c
         sAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742007130; x=1742611930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNhPY2U3iuYo92ushxX+O4Txf9DexTmzSKvhqk8mvPs=;
        b=Mt3G2a0426/oh7rH6XnkB9tNcT5MPr/a95UJJSjxDMbBrSezdH0+5hFtU0sCTtpKtE
         L4D4ZjUD9jqVUmDd+nqcqnZafgqt3+PrRp4Be8Y8Jflo/x+N9e/7m18uUBWdZqyhRqDm
         EWDkj/xg/3aDo9dUqNSbpoFpjEO9WRMgL7/itTBvebLGJLKVFDr/ay5V1U4dEeSVO03T
         b4TST8UW4LUyHT/a4PhGL1BbrHOcekPThj2iPHTWvNhcpw3wXtboThPLWAhQAxb7ndkz
         vLaXHmqKSwaIlsSWyXCCNgVU14sZ7i5tOomSEsrtheOH6NOAPwXoca/fqsx/F2/0Z+LH
         hLFw==
X-Gm-Message-State: AOJu0YxBpCvoREdwyRmilSFqngphvqcm58Et8MlSKw7wI0CbaIXNdMdD
	g8YZ9rHRALhA//gDF4pVB0qvE5iCggsa2kMayP/rU9jBlw47roZeAUqY2SVrSClR/EbLJBXWxSG
	wrJB86oUQwjKBy0r3XRksEf+OceM=
X-Gm-Gg: ASbGncuvSW378qNe/Qtc1WYy5sjLrojyESL1MCj+Oz2KrZRI+6EBwG29iV5GJlV0NXL
	OxE23MslblUKJ9KCY+Diveaso33t91U+qU8BQN82Bz19hHp04YsRe2wV8ZY6bWO09w1NYc1UJ77
	h8ivB1/Ku/B8N6Zgv9UWr4qRcvE6KnqRAXIUNjNRdpgw==
X-Google-Smtp-Source: AGHT+IEbRYV9AQS9UUM34bsCShFB2o837kILyVkaS+87T8qUerBEWQPO1Tv34WWxN62jws8Klf5aZnplAPkueLi8iwY=
X-Received: by 2002:a05:6000:381:b0:391:122c:8ac with SMTP id
 ffacd0b85a97d-3971d802146mr6102058f8f.21.1742007129993; Fri, 14 Mar 2025
 19:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312031344.3735498-1-eddyz87@gmail.com> <3c6ac16b7578406e2ddd9ba889ce955748fe636b.camel@gmail.com>
 <9190c8821684a6c75c524c58c6d54f7d9b2366e3.camel@gmail.com>
In-Reply-To: <9190c8821684a6c75c524c58c6d54f7d9b2366e3.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Mar 2025 19:51:58 -0700
X-Gm-Features: AQ5f1JoMYpUB_sn9eQjqYY9M8FWGRKUirQGLiQ-_iKsniSt41NNVRNNAooSFUvs
Message-ID: <CAADnVQKBdJsDWVCNk2LaEc7ZTPFOEeQrRgoEiio4YWFYsijkcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: states with loop entry have
 incomplete read/precision marks
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 10:41=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Thu, 2025-03-13 at 12:28 -0700, Eduard Zingerman wrote:
>
> [...]
>
> > Which makes me wonder.
> > If read/precision marks for B are not final and some state D outside
> > of the loop becomes equal to B, the read/precision marks for that
> > state would be incomplete as well:
> >
> >         D------.  // as some read/precision marks are missing from C
> >                |  // propagate_liveness() won't copy all necessary
> >     .-> A --.  |  // marks to D.
> >     |   |   |  |
> >     |   v   v  |
> >     '-- B   C  |
> >         ^      |
> >         '------'
> >
> > This makes comparison with 'loop_entry' states contagious,
> > propagating incomplete read/precision mark flag up to the root state.
> > This will have verification performance implications.
> >
> > Alternatively read/precision marks need to be propagated in the state
> > graph until fixed point is reached. Like with DFA analysis.
> >
> > =D0=A0=D0=B5=D1=88=D0=B5=D1=82=D0=BE.
>
> And below is an example that verifier does not catch.

Looks like the whole concept of old-style liveness and precision
is broken with loops.
propagate_liveness() will take marks from old state,
but old is incomplete, so propagating them into cur doesn't
make cur complete either.

> Another possibility is to forgo loop entries altogether and upon
> states_equal(cached, cur, RANGE_WITHIN) mark all registers in the
> `cached` state as read and precise, propagating this info in `cur`.
> I'll try this as well.

Have a gut feel that it won't work.
Currently we have loop_entry->branches is a flag of "completeness".
which doesn't work for loops,
so maybe we need a bool flag for looping states and instead of:
force_exact =3D loop_entry && complete
use
force_exact =3D loop_entry || incomplete

looping state will have "incomplete" flag cleared only when branches =3D=3D=
 0 ?
or maybe never.

The further we get into this the more I think we need to get rid of
existing liveness, precision, and everything path sensitive and
convert it all to data flow analysis.

