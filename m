Return-Path: <bpf+bounces-62581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A06DAFBF75
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0783165B74
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 00:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA3C1C6FF6;
	Tue,  8 Jul 2025 00:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP8yjCxh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5921824B29
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935780; cv=none; b=KjBYRbJLjA9zsWjnNN2lxVxVzKwmmJWD+p7qc4idTic0D9kMrvr3fKJCtJKlHTxTdMNeOIh9bcuDNj0PKvj/Sa3+5LcHDMejhDnZ0CFSsWbZGZvlN9akkOKZnKttQFU/x1DPliO94uRsnJiqfKBEzY7x6ZWXzPw3ja9iGa2jOoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935780; c=relaxed/simple;
	bh=v03I5Gft9AvBxJTr8g/5PqksEVR9ykzbB/0odkXfStc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgfQgI2D0/MVDaSrmulVucnodJMU2hpt+GDhxEEhrZsiLULAx3HnPPVsFoTuCEmfZXrYUhufr2Il+jjeCbJv0LFp4b7Vz1PaZMPDEaFFtQL8rjrXIHFlNvgzMrbCw/HI8107Y80ylaC7FWMBJ4/hWfWiUETx6rHIjNnZq/SbGz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP8yjCxh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d54214adso26556385e9.3
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 17:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751935778; x=1752540578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyVCE1FCQMp+VOoXKyL5nYjx+mpXEgNEupCO7CAXHA0=;
        b=SP8yjCxhCCnA0i5YH8FiVnztcaEqZbgz03JP0AQk0Pu4KoKhKw7iS8aqGihi65aEoD
         xAzsdbJn3pXwCjl/OCFZ4EbY6OFPK4z4vDuDA6I4HSGbJ3fNL3iEHfvDKjMQPptmaw3j
         i3/ylZMztwkDXBjLmnlPpnF01WneRaqeqEiMREHVbV0tLtGe/aiZ7mXZvA70cqTmOO/q
         qxWU7Dul9vaOGnfnAQzba/q2AxMXtxtjHl4/eqKy2R79NdEaD/TI1dMiqYGYLnxx0M4i
         vn2keAmexk//wFbJOPBwO3+7nu0zbofnED07preBfeXROd7Gk+bupgxccY4VVqC6QJXD
         K7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751935778; x=1752540578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyVCE1FCQMp+VOoXKyL5nYjx+mpXEgNEupCO7CAXHA0=;
        b=fIru0KBFRpaWTtEdSS4hBGDG4zJsTXnuALM7uUHNJ9tYj+hnObpCTxvnaMWpTGFdO3
         PaEBw0bsNkw5b70+hYgtT5LdJGdl8ICWLQmrrZqt7d98hHfF323VFk/XBYTNLbmyBFB5
         kl1f3OSxTotfKxKXyWhulVKL7I87CI+7pvbKbzHIJ+aZyx6NNy3+V7dywDZXAvGuk2LZ
         qrc15mYzk0mO31wAdea7nSlgnHBCo5RV+MqBULtm3tWf9X7uWWE6czvjru8dABclqvgl
         amKgK0lJvmuPxGPWNP1MuT0LCuBcKftJFmbfUNfVWkz5zikD9aQmRQ0T0ysUjq7fd43y
         zZog==
X-Forwarded-Encrypted: i=1; AJvYcCW3+1qaiCyV73VkUj6h00feMaF0PsKLTGlm0ASNIA8TeCt90whGY61qk3ViXbUBzmGQE2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRzQiayzMUEcRXY4hDefXM72Am3RTeLgSoiZNR9oxfNmlHnfde
	7vcnDvPkFg0DDd4sVtMMXgi3gA59WDsnDcyM+WVgYLYCGm26+1+elBOuWk6gZ74xAySHaJCDlhT
	DDxMX1YKe9iNoVMul8EgVpOV632HAIqn0Sw==
X-Gm-Gg: ASbGncse5X5o4KeUP26M7WZ7mUyG9RyYl+ewgdhsrcGrz/57QKlnRy8CaaRQtb5jDoq
	OJlMsgDa1ronPs8Kj1V72yrY9SO5mEa07jdfpweC7P3PMSrk2c0SK66154w/bV9v2MTcFd3m6R1
	Pfl8FQl0MPJ+uY/vf5BbN91dEwfUQqQ+b/Mm8n9P+AEPjAujjKzPg00eaIbHDAltZeBpzA0umPr
	H8XFad9fOM=
X-Google-Smtp-Source: AGHT+IEtTKigfUGrhE8eobmqtko2es4si4MBYudz5eTFqLZHb82WGIoOt4iVMO2WEDAjcIxPLOvvgQ1rw+48fQOqpYM=
X-Received: by 2002:a05:600c:c167:b0:450:d386:1afb with SMTP id
 5b1f17b1804b1-454cd4bb3f8mr7856275e9.9.1751935777613; Mon, 07 Jul 2025
 17:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-9-a.s.protopopov@gmail.com> <CAADnVQKhVyh4WqjUgxYLZwn5VMY6hSMWyLoQPxt4TJG1812DcA@mail.gmail.com>
 <aFLWaNSsV7M2gV98@mail.gmail.com> <e726d778a3cf75e3ceec54f5f43b9d5d66ba5e97.camel@gmail.com>
 <CAADnVQLaBuDYBoQvVtug63MJO+2=oqb9PYap8Jv+U8HB4ETe9Q@mail.gmail.com>
 <88c63c574dfd7d3845ac4e558643ab52e77f81dc.camel@gmail.com>
 <CAADnVQLp=ED2XAVhgO5jgSt6Cptkw6-H19Qr+s63m+jjCDwXRg@mail.gmail.com> <2dd335c0c9152a9941f42a4e70a95846f7d6de49.camel@gmail.com>
In-Reply-To: <2dd335c0c9152a9941f42a4e70a95846f7d6de49.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 7 Jul 2025 17:49:26 -0700
X-Gm-Features: Ac12FXyBZg9d5z3ZbfgsZ91hKJPvfjNaQYWCqsRrphIIRuVqic2JPpcVpOwXw2c
Message-ID: <CAADnVQ+3hutu3Fth3nnVJTAJjQUbOT+G5MPCBRYNtXEiDi1WGA@mail.gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Anton Protopopov <aspsk@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 5:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2025-07-07 at 17:12 -0700, Alexei Starovoitov wrote:
>
> [...]
>
> > > check_cfg(), right, thank you.
> > > But still, this feels like an artificial limitation.
> > > Just because we have a check_cfg() pass as a separate thing we need
> > > this hint.
> >
> > and insn_successors().
> > All of them have to work before the main verifier analysis.
>
> Yeah, I see.
> In theory, it shouldn't be hard to write a reaching definitions
> analysis and make it do an additional pass once a connection between
> gotox and a map is established.  And have this run before main
> verification pass.

Yes. In theory :) But we don't have it today.
Hence I don't understand the pushback to llvm-aid.
If/when such dataflow analysis is available, we can drop llvm-aid.

