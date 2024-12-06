Return-Path: <bpf+bounces-46320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 022569E78AA
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 20:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6290D167C18
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEC01F3D44;
	Fri,  6 Dec 2024 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKJAfUTE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951191FFC7F
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 19:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512510; cv=none; b=n6+OhyKhzm0aog+X1bU28vwI/RHf2NAuWhJ9ueB75OEDb6GpTebXXSbF8EHvEijbyZpjOP9ltphphe4nLDEyyQ9855pzKebmUEaW2iXyBD2QmEbuO9RDKewKGNjpFxGPTY+HMz7GTQfPfJ7WQfbk617ulUZStbMAOMjCWbxj1As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512510; c=relaxed/simple;
	bh=14nMBdJVCUNb0gGd2MRfT1wSZeyVv2jhnnqQBxm6YcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsAyr41UT1cjume6h6sI6tUUxjk4mQhH0xyeK+65BAohHFgpQHRFuvGhajFUKuEIPQnI39cg1wUvfVG3zH0AkSnuyT+/Rz9QZOxACY9tC+4pgMGi1XY10gCprM+Ay7rvWI0y+MdWD5We89qbBXkj0IZkUEy8w7KUgWAtos6DDdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKJAfUTE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38632b8ae71so222614f8f.0
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 11:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733512507; x=1734117307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14nMBdJVCUNb0gGd2MRfT1wSZeyVv2jhnnqQBxm6YcI=;
        b=ZKJAfUTEU2skYWqq16clQ8XQPkrL0EUwkJhYE1L7LAjY6zEvtWIo97JWsqQfxRn0fe
         WHnWAJtXdJpi+njypuIODbk7kLbR7C+VJgtcwa8SeUFRAdWo3HbeX0lcZ3evoM+5GjVF
         aphwBDFxDIdys8gWYbYmstaiE6mJUDOFkVd6akJyfjqnLSHkp963ePPwWtOPDl8qqVBL
         VlYHY4JRpHV0QjbT5jl4rtzye0h7y1H0c0hqgbDZvpmAxHwIPRzgzUiXPgo2F+0cQmQw
         rQSuSatx9S+k/S/y8eNdTLva885UuOwCXQFuynOQrIWBhrkhVIUqNgs5NkvMSJDhHY/g
         nkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512507; x=1734117307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14nMBdJVCUNb0gGd2MRfT1wSZeyVv2jhnnqQBxm6YcI=;
        b=l9eMFNE7K00yZWrjV0jVnDO0ZC0kVPRh5UZq632d4KuQD1oCx6fPFnyJk+fxfOewvX
         SjT+doaudsXm8XM/uT2oZ0P9Cm8eyh53Kg4Wx67T8/IopcY5YzuTdtmNn4Ly2hAwqeVB
         gTi3IcsFr3HB2ak56Ezn8LJTDsPfJXM6/SFxoTwwJor9D5VeqW/fMxPebMv8xlTXyBgz
         CFpDlFj/6x4ySDvuV6NzpMz/9TGd8S8yZ4Fkt/jweIEaN8vySHuBCw0BlW7dn1/OkMN0
         3ia6ptdeshDdGZHdTXhldQMaua3ubRxNqwvREVzIvklWkuBYrdl4b+teDJ+Ie/BzTR/g
         jv4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPM+HoHEXgWZFH7BIV5+DatXIV7ISF7MzrpZ2/6AEKFNF4EcHB4CUJnD84+a4WTk2ogxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWeOtFjLZkC1Io/V6ltsv5WKbZ78XCUr9gPyUwAR6MFvoA/AEk
	Ci5buE92i8vRZtzHoO9dx5RRNULvO45NRo4vniCAw8obnLHEBwIAtLlN0hhDMlKJxNt6qPq/H5A
	NSSKs5UPm4AjTs6Ik2V6vV7g0Ao4=
X-Gm-Gg: ASbGncsojm42WGGJiPmmv/Kg9Sm6cQ98SrTo3Ztc7YtYANHbzYIx7w34y+bcw1At8CC
	pNwoFJXqmDUcTWYHfLqc9GJpa9i7Vm1zgNj7kTivhkd8kY7k=
X-Google-Smtp-Source: AGHT+IF9/9Ie1l+fIZ3kuAqPZTI6mXLj8PYWGr2R+gB63Suvq5xw4HEJ+JRcZx6mPk8HYu6CEX1Ew02NMIM3tnOoR6g=
X-Received: by 2002:a5d:6c6a:0:b0:385:e176:4420 with SMTP id
 ffacd0b85a97d-3862b33d313mr3421859f8f.10.1733512506710; Fri, 06 Dec 2024
 11:15:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206161053.809580-1-memxor@gmail.com> <20241206161053.809580-3-memxor@gmail.com>
 <CAADnVQ+_XGVsxYji3WYNj1-KhYZwKaFCgQ6aN=yFB3YWpRT78A@mail.gmail.com>
 <CAP01T75PQ3RENtQMD+JkB9DZcsUYp+AH6VJURGO730DkuLUMmA@mail.gmail.com>
 <CAADnVQLrPWQe__jPWN3SPvJkOQc=7LxfesB74XH8Er052_wixA@mail.gmail.com> <CAP01T76fOtcpif8m81KrX7VTCM-tecAcDWHrhH3ipfOmiuHhKA@mail.gmail.com>
In-Reply-To: <CAP01T76fOtcpif8m81KrX7VTCM-tecAcDWHrhH3ipfOmiuHhKA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Dec 2024 11:14:55 -0800
Message-ID: <CAADnVQJhDPtJ_yO6Qxx5ovTTC5R+jFiebTK0WHSUqrJhyj3NFQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: Do not mark NULL-checked raw_tp arg as scalar
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, kkd@meta.com, 
	Manu Bretelle <chantra@meta.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:09=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 6 Dec 2024 at 19:37, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Dec 6, 2024 at 10:11=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > > > I think we need to revert the raw_tp masking hack and
> > > > go with denylist the way Jiri proposed:
> > > > https://lore.kernel.org/bpf/ZrIj9jkXqpKXRuS7@krava/
> >
> > ...
> >
> > > Jiri, do you have the diff around for that attempt? Could you post a
> > > revert of the patches and then the diff you shared?
> >
> > the link above.
>
> The link only has information about one tracepoint, but further down
> the thread Jiri found more examples and the case of IS_ERR.
> https://lore.kernel.org/bpf/Zr3q8ihbe8cUdpfp@krava
> It would probably be good to add all of them? Or did I misunderstand
> and you just add PTR_MAYBE_NULL for the scheduler tracepoint in the
> report?

I mean Jiri's patch fixes one tracepoint, but the same approach
can be used for the rest of tp-s Jiri found in his 2nd link.
IS_ERR can be handled as well as info->reg_type =3D SCALAR;

So revert plus one patch to fix them all.

