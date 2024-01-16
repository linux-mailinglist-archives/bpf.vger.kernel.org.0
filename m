Return-Path: <bpf+bounces-19624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E1282F571
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 20:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127C32866F9
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 19:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B3E1D532;
	Tue, 16 Jan 2024 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQQBI1ub"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D231D52C
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433672; cv=none; b=cnYO9wcFNrRkT0zDXcCa4Niunv7Xso/nJNBNnUIaLjhpVDt+R1NlgBSmZ9RQFfOkTPoE6IW4KbuHCSMY9wewMBZg8Val5i9WdcibQF2Y7JM5rSMtysj1ketkEmDNnmHlHS7JJyZBHyUx8GPMnWOi0yxgceQJwRRE0eyx/ofswVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433672; c=relaxed/simple;
	bh=kUZdgSqxUZqvEmczldDOsaXEtXQ1oIqrh3E9ayEspz4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=UIIH1OkjetjzzTM/joqQwJ268MDyNmrnwDt0z62TY5PnMdxHoO0fjK14RroGujg1dleuSj3QwGuMJfLCe0xnrV4o4uYC8gdBQzbo4ozxnGqqKzEztT5hzG5P/aPaRrEoZf0MkIGNURgtQcZ6AYj9vP/+03QnJBtI1uvIvKkxRYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQQBI1ub; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-337b38d6568so1114159f8f.1
        for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 11:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705433669; x=1706038469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbUUcAvVc8EbJA8t9vi8tHHGUE1/U27Sxuq6TsC5h4w=;
        b=dQQBI1ubkjbD3D5gKdjRkkDeizw8FL6ce3Dr1ho0lpNO7B7oHXJcRD/njgCFlEomzS
         XI2meMqSBJR3klyl4ztxJQug3LcieRjrRxTGJC/U7D7e5YzRwHJUj3N6+x09/bq3cd4g
         LEEgEjxRz7dt4ECXhYhxepeEzaIhh4HcX1QhilNbYvVTDNZD43tw0PP/7+RYJv7TnQi8
         x1nCQ4NQWNGfFiBZfisFbHV7zEP5ivIv15k0jEHo2n/nHQCV1qYyhKCGDyVw6hk4TGTx
         kWwrEKGjPtQ5DoGNOsNZggZULJJ8AcL7Jw+k5bjme5xRqnCOBVxOtaaRUJ5PEZ20edDd
         pTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705433669; x=1706038469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbUUcAvVc8EbJA8t9vi8tHHGUE1/U27Sxuq6TsC5h4w=;
        b=NFi8ZJEdTMA97Abj9Ei6oAOJ8gmpKl+rS95S45r1WHWrbbQYWZnU0J+W3c0A5O15e7
         HsfsDjuWTty7W9SuuJXvEkwU+d4ERQMc+VfqIus1X2RQpah2YXOeFd+PrPxWPU9z+70h
         9BqtaRSmuiq2cHUJt7n0b2aBMSxI2IczZwIOaFc/Wn2Yf06vl2GTf0M21WPC7sCquLFt
         M/kJni55HwWLeyyahCY9gZAyESPkh9TXQEcdIiz9vl5QoIdvT1oLytKDerRdbKIkU/wk
         VySQRRGvQHujCtea3UZYaqf/ETPkYENTOhB09IkJXJNScMRIZou69Ue5BK0f6mFdew7y
         36nw==
X-Gm-Message-State: AOJu0YyB4BpNKX6HJ6/UoVA28XSx55kKvuhdo/0hyQbuC8+cO8gMsd4c
	gid2fjBc1zlQvKrUd3XegMXVgzfChCc3emLbtuc=
X-Google-Smtp-Source: AGHT+IEZq9W+wvzYYu5N/Tx2WeqtEGsbOXqf9/S2eMubPiadHsOfxTCl6HOmrJCS+DxXx5QuP3ECcara2I+Cn7cR5Uc=
X-Received: by 2002:a5d:420a:0:b0:337:bf93:ffa5 with SMTP id
 n10-20020a5d420a000000b00337bf93ffa5mr451968wrq.101.1705433668728; Tue, 16
 Jan 2024 11:34:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
 <20231221033854.38397-3-alexei.starovoitov@gmail.com> <CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
 <CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
 <CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
 <44a9223b6638673487850eb9d70cc01ef58e9d93.camel@gmail.com>
 <CAADnVQLmXxn9RrniktuW80XO14oyOmgJ_NboBBC_-CU4O=-v9g@mail.gmail.com>
 <87h6jm6atm.fsf@oracle.com> <87mste4sjv.fsf@oracle.com> <878r4vra87.fsf@oracle.com>
 <95388269687be49d7896a881eda8aa3bb89e40a4.camel@gmail.com>
 <CAADnVQKGkPaCMyesJ=U469AOS5iJ=vmL20B7Ya7HFp8ouC3C5g@mail.gmail.com> <48a7a7db-978d-4e8c-8378-2851975a1ddb@linux.dev>
In-Reply-To: <48a7a7db-978d-4e8c-8378-2851975a1ddb@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Jan 2024 11:34:13 -0800
Message-ID: <CAADnVQJTaDrXsn=EXSmEvRX6Zs-kAGtHmMxfS6S__NPD73yoeg@mail.gmail.com>
Subject: Re: asm register constraint. Was: [PATCH v2 bpf-next 2/5] bpf:
 Introduce "volatile compare" macro
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 11:07=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
> On 1/16/24 9:47 AM, Alexei Starovoitov wrote:
> > On Mon, Jan 15, 2024 at 8:33=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> >>
> >> [0] Updated LLVM
> >>      https://github.com/eddyz87/llvm-project/tree/bpf-inline-asm-polym=
orphic-r
> > 1.
> > // Use sequence 'wX =3D wX' if 32-bits ops are available.
> > let Predicates =3D [BPFHasALU32] in {
> >
> > This is unnecessary conservative.
> > wX =3D wX instructions existed from day one.
> > The very first commit of the interpreter and the verifier recognized it=
.
> > No need to gate it by BPFHasALU32.
>
> Actually this is not true from llvm perspective.
> wX =3D wX is available in bpf ISA from day one, but
> wX register is only introduced in llvm in 2017
> and at the same time alu32 is added to facilitate
> its usage.

Not quite. At that time we added general support in the verifier
for the majority of alu32 insns. The insns worked in the interpreter
earlier, but the verifier didn't handle them.
While wX=3DwX was supported by the verifier from the start.
So this particular single insn shouldn't be part of alu32 flag
It didn't need to be back in 2017 and doesn't need to be now.

