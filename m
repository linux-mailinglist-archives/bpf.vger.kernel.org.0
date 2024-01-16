Return-Path: <bpf+bounces-19619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302C482F376
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 18:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801E0285C4E
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 17:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1338D1CD03;
	Tue, 16 Jan 2024 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIGeI8s+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8E41CD02
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705427263; cv=none; b=NUXIDonvKX+Qj+L9Hum+nqiz6/bu5/u+m9ZhvKBwsETuhhP4+d/MJTLleQqj32jao543D69uRRmXf1hiqwbQ6+ugeihoBxYJHssLpuA2D5omPS2OrLHooEoU8+dRDFnOiG9TICYipgdgLq9JE6AkPK12UHc2jQlsz5heJQAceOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705427263; c=relaxed/simple;
	bh=SggUyOvYSpKVHE92TMs5jdvwJxLzNZwVVwtQRHqGr7w=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=b5LobcWv1q/Q9XuF+XV9l/D9dFwRhV1GKH4JLHPTr1GopDDK9WRGSrr/gVbnlVftpYIawi6HKIgPvNTQ3xOsbIhU5HUOUPOfP68Ccjej1rzr84TqTKe2iduoareWF1juJz3BqqqZbXbAlJb1zKUpxA8ycOrdWq478N06mgyFGUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIGeI8s+; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3376f71fcbbso7956176f8f.1
        for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 09:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705427260; x=1706032060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUHoa0An69f3aPUHKpT50JkWCCHVFAe8ez5jivUiQfs=;
        b=eIGeI8s+OoIJ9FYgwZKE25eFuDSjlMcdwbEWr/D6XMbDVD1270rkdVLZCgVZ4MUwMz
         WpL6cc5w8UsD0npU6ZU5akDUqnSsIIiT/CNyK3PuhCdgpaeOFjdRLNUHsH0GdnRgQOJy
         IHyS/cgW1ZNpUFcGwHTr1YrzxKN+Z210tVB7KP7WOA9f1GtP9JaMOg1YI8AIZzYJczR9
         OMBUupRtHdVyaX8VYr8PT1U0YMMnqoN9TUVt+HJ0UAhpG3JkC784BMeJjG3naOY6QYmE
         8s/SRv04YB7z86cloG3DXy/5/Bz/VQRh1/5SR/mcxWwg5KbH+22OpRYRqg0zSNvjLvbv
         507A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705427260; x=1706032060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUHoa0An69f3aPUHKpT50JkWCCHVFAe8ez5jivUiQfs=;
        b=Lr5vB74ExLpz/7w29TfzTDawOwcogI0xHo8EppaY9uYS7Rww4GeOSb1rc+66onP50P
         LClhEsftKeXvzA1lK1CPiP4Z+JvOSFOnXUXdZSi84J85rIg/zRplnZlatSAX/v5v9dt0
         HppijmNGDamodu1IBs+MNi6oIpyobFzujz1dM13M9RC8calzJmODewNI3UDFWrpyKid3
         0e/nn7AhvIvXGzJjd0hyI2+6HPEdpeifTurqzBwS5EGZvON5VUKcfQB2eHHlR+HyQLiK
         +RoZudD0xc1JSnEkURe0u0b1YZa4vbsDWfBH9A+qbvsDBp26fFW0i5rGeYL7FitEkwds
         sCCg==
X-Gm-Message-State: AOJu0YwCY4pc5Dr5rEsb7mCG8SY8HL1VvfFMnscrXmAQgXhQ2B2WXwvI
	qeo7049rR+8maCfOIP3kvTctnTBmLLk0axHBXwI=
X-Google-Smtp-Source: AGHT+IGik+MTPtC7+AXBp5l5CcwquTcVaMuO/Wp1eUimcid4kMXH7XiOkwk0nv9UL1LRiD9Mokhgufu54jGxwZhspSg=
X-Received: by 2002:adf:ed0e:0:b0:337:51d3:ba5f with SMTP id
 a14-20020adfed0e000000b0033751d3ba5fmr2947067wro.96.1705427260141; Tue, 16
 Jan 2024 09:47:40 -0800 (PST)
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
In-Reply-To: <95388269687be49d7896a881eda8aa3bb89e40a4.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Jan 2024 09:47:28 -0800
Message-ID: <CAADnVQKGkPaCMyesJ=U469AOS5iJ=vmL20B7Ya7HFp8ouC3C5g@mail.gmail.com>
Subject: Re: asm register constraint. Was: [PATCH v2 bpf-next 2/5] bpf:
 Introduce "volatile compare" macro
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 8:33=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
>
> [0] Updated LLVM
>     https://github.com/eddyz87/llvm-project/tree/bpf-inline-asm-polymorph=
ic-r

1.
// Use sequence 'wX =3D wX' if 32-bits ops are available.
let Predicates =3D [BPFHasALU32] in {

This is unnecessary conservative.
wX =3D wX instructions existed from day one.
The very first commit of the interpreter and the verifier recognized it.
No need to gate it by BPFHasALU32.

2.
case 'w':
if (Size =3D=3D 32 && HasAlu32)

This is probably unnecessary as well.
When bpf programmer specifies 'w' constraint, llvm should probably use it
regardless of alu32 flag.

aarch64 has this comment:
    case 'x':
    case 'w':
      // For now assume that the person knows what they're
      // doing with the modifier.
      return true;

I'm reading it as the constraint is a final decision.
Inline assembly shouldn't change with -mcpu flags.

