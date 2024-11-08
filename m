Return-Path: <bpf+bounces-44374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DADAD9C24F5
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 19:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161381C24E98
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 18:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190B01AA1C7;
	Fri,  8 Nov 2024 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC2PLlO8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B146E1A9B53
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091111; cv=none; b=epOv5hCPhHo5YlyuI6kbXYI7KDTotR5sEQ+tX32Aj8JQLBXi7aV9RZN3pzY4KMuMV6ppugY5Omfni5ek1P/sy5MBltSYrqoIBAGTJT4W3VPsvU/fl6vNd1qlPca5etbzTXUzYAhau/iS2MrxsUhjLPv+m2mFgOESm2Skq1Zx1q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091111; c=relaxed/simple;
	bh=6pUYbvKzNeSo5VmwBUuFNlecEYxPCn+6EbF+goCXeXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Udppyc5AJZgaMdCW1HKTT28zvkTDaYyn3b16UZjDMCPN/L8mRzsJg97NEKSOgmXMhE0V8MBZ+put1PHNWnXi8VKHp6JTzBzJZWVkk49b+qk17KkGf4upVL1c6C4lZN7wqrnWIUMIa0g6VoKpd2uZDLScGm7T34jMNW1/wkzhTlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EC2PLlO8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so22199625e9.1
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2024 10:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731091108; x=1731695908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zIiMHXCn8GO3wjMXnWJoqz2jTfy5Whqa2GXeUkA2KI=;
        b=EC2PLlO8N+rlh8Wm1CVS7afJu6e0X50ieaGJzAuEAPRndZHovB9UBgdrz8/9SrZuEi
         ebC9vMRGn0iZqNmpHwslOhYls+5EynLmm6E6gm61R02M+zIdQJbm7Ur5wWFLfvw9ZV/X
         MBI9eXnA9Ha67knr7a+bgCSBJRmOlWoe/h/NO1dAdQfM3FpsdmJxfv8Z2EQDLX/9L6j9
         1E9gnVqKYJDYG0tVVl5zVUx0rSQq7MldDcbsx9Cq/SsHrFuahkW6+DBYL+IWmOdYznbY
         ma4MTGkOI73nazMAWMBeNVVnmVHQyBS9ZtBnGtG2Yf8+jbUBZah9G1gb/p0QmsARncqI
         vzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731091108; x=1731695908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zIiMHXCn8GO3wjMXnWJoqz2jTfy5Whqa2GXeUkA2KI=;
        b=ie9bmEhAsqMF7kcUFzGXjj5URiWJWegldbwCKvax4nOYA1TxyqxuGnf0/oJBV+UXQc
         seBuUZ3xfafC2WiOogScBNGv74dgp4V4DqCaImpY3naiTnmBQgf63WDGcK0MyPzXI8XR
         ert9fOTEz6R+2g/ediP0Uimar2sY1xa7FlFe03ki5FRUCWMtce9bUSPWF8uV2PIw7GXs
         P8QGi4UmndC8rc2+OCVsLP6PMDPAc3g64UGWvuUn8in2Q+iyFVeUw4lxSBy8mb/nfe6O
         0FURdM4PqudB+C3B7qIMt1SAnADUqKaIfGX9eNZWXnFrjAvkKIlPLHvDLhBgvu0wTCPl
         skFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZDtGzGbknYhGrSCTZMwASqA/XtSDx7NODfWKrrBTMgDxwhYzMYIa6/A2PGIlqrmqQweA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXtZPREUJWv7rnLgr5oB/vH91YCcDozKDcSpEIj2wTTOuGEq0a
	U/13Brh6mJrI0dUjVa+EKeYQAA0Lnc8MmWLZAL4lDx/zFc8WanJQA69B3sCKhgSADSxiCk4+edn
	jSlIje2CZn8+D9tLawDn7VKHhDvM=
X-Google-Smtp-Source: AGHT+IHjoQgBL0kJXlbhWSeGhscglfi3McNpI1x0JYhFBBtvKjRQU6Md1q+N8Vav3koZeSpE6+fU9DAVIgKFeQFloOI=
X-Received: by 2002:a05:600c:1c98:b0:426:6edf:6597 with SMTP id
 5b1f17b1804b1-432b750a358mr33550055e9.19.1731091107756; Fri, 08 Nov 2024
 10:38:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927033904.2702474-1-yonghong.song@linux.dev>
 <CAADnVQJZLRnT3J31CLB85by=SmC2UY1pmUZX0kkyePtVdTdy9A@mail.gmail.com>
 <e93729b5-199f-4809-84f5-7efdf7c8aaf3@linux.dev> <181301db143b$ba6fd9c0$2f4f8d40$@gmail.com>
 <CAADnVQKDwZ0+Fjiz21AFAbOgEonVojvpojU1ZyQDu8V4Jm0DYQ@mail.gmail.com> <000c01db3186$1dd30930$59791b90$@gmail.com>
In-Reply-To: <000c01db3186$1dd30930$59791b90$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Nov 2024 10:38:16 -0800
Message-ID: <CAADnVQKHHvrJjAMuXC5-wQHfMfxoSXnOBnqrZ5PC7p3C8ut3rQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] docs/bpf: Document some special sdiv/smod operations
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@ietf.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 6:30=E2=80=AFPM Dave Thaler <dthaler1968@googlemail.=
com> wrote:
>
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > On Tue, Oct 1, 2024 at 12:54=E2=80=AFPM Dave Thaler <dthaler1968@google=
mail.com>
> > wrote:
> [...]
> > > I'm adding bpf@ietf.org to the To line since all changes in the
> > > standardization directory should include that mailing list.
> > >
> > > The WG should discuss whether any changes should be done via a new RF=
C
> > > that obsoletes the first one, or as RFCs that Update and just describ=
e
> > > deltas (additions, etc.).
> > >
> > > There are precedents both ways and I don't have a strong preference,
> > > but I have a weak preference for delta-based ones since they're
> > > shorter and are less likely to re-open discussion on previously
> > > resolved issues, thus often saving the WG time.
> >
> > Delta-based additions make sense to me.
> >
> > > Also FYI to Linux kernel folks:
> > > With WG and AD approval, it's also possible (but not ideal) to take
> > > changes at AUTH48.  That'd be up to the chairs and AD to decide
> > > though, and normally that's just for purely editorial clarifications,
> > > e.g., to confusion called out by the RFC editor pass.
> >
> > Also agree. We should keep AUTH going its course as-is.
> > All ISA additions can be in the future delta RFC.
> >
> > As far as file logistics... my preference is to keep
> > Documentation/bpf/standardization/instruction-set.rst
> > up to date.
> > Right now it's effectively frozen while awaiting changes (if any) neces=
sary for AUTH.
> > After official RFC is issued we can start landing patches into instruct=
ion-set.rst and
> > git diff 04efaebd72d1..whatever_future_sha instruction-set.rst will aut=
omatically
> > generate the future delta RFC.
> > Once RFC number is issued we can add a git tag for the particular sha t=
hat was the
> > base for RFC as a documentation step and to simplify future 'git diff'.
>
> My concern is that index.rst says:
> > This directory contains documents that are being iterated on as part of=
 the BPF
> > standardization effort with the IETF. See the `IETF BPF Working Group`_=
 page
> > for the working group charter, documents, and more.
>
> So having a document that is NOT part of the IETF BPF Working Group would=
 seem
> out of place and, in my view, better located up a level (outside standard=
ization).

It's a part of bpf wg. It's not a new document.

> Here=E2=80=99s some examples of delta-based RFCs which explain the gap an=
d provide
> the addition or clarification, and formally Update (not replace/obsolete)=
 the original
> RFC:
> * https://www.rfc-editor.org/rfc/rfc6585.html: Additional HTTP Status Cod=
es
> * https://www.rfc-editor.org/rfc/rfc6840.html: Clarifications and Impleme=
ntation Notes
>    for DNS Security (DNSSEC)
> * https://www.rfc-editor.org/rfc/rfc9295.html: Clarifications for Ed25519=
, Ed448,
>    X25519, and X448 Algorithm Identifiers
> * https://www.rfc-editor.org/rfc/rfc5756.html: Updates for RSAES-OAEP and
>    RSASSA-PSS Algorithm Parameters
>
> Having a full document too is valuable but unless the IETF BPF WG
> decides to take on a -bis document, I'd suggest keeping it out of the "st=
andardization"
> (say up 1 level) to avoid confusion, and just have one or more delta-base=
d rst files
> in the standardization directory.

This patch is effectively a fix to the standard.
It's a standard git development process when fixes are applied
to the existing document.
Forking the whole doc into a different file just to apply fixes
makes no sense to me.

The formal delta-s for IETF can be created out of git.
We only need to tag the current version and then
git diff rfc9669_tag..HEAD
will give us that delta.
That will satisfy IETF process and won't mess up normal git style
kernel development.

btw do we still need to do any minor edit/fixes to instruction-set.rst
before tagging it as RFC9669 ?

