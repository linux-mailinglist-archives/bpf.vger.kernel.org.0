Return-Path: <bpf+bounces-44378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4419C9C252B
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 19:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0A91C2227E
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 18:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D5A1A9B4C;
	Fri,  8 Nov 2024 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lnKNa55K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C1719259B
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731092035; cv=none; b=C1e6tfOm7nJTdCdBsW4noEX3x51C6YJ3YQl+HnBObt3/FjnNFkRb9mPQ4Aobl7KeS9vjGkEdOPzGb+8QgD1P5YlZJYfBGcJ/SqOB+YT3w1IMTz6tyJF5GkjpNJe0rz6xONxHrYaMEMDdP+YFk4fkf0t5y8M4H/tmCMpclw2hAeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731092035; c=relaxed/simple;
	bh=C1qfXDBbz73toITU0058NUmGoALhiTU/4UgMmjcZYwU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=QhSuthPKavxKRISEO0uv+HcpiAUtVVRDGVqlmEBmmY1WY58wFgqQQoYUn0fc4EhXPCfUI0EB8HFoQMK0lD8snPKWxPwEgAuaT9YGTPDILu/k8vB1wNi5TMPqX3PsyllOXV+RvWWIWMU6iQdR9Wq5bUQWbt0qwyZeqpFrAjUJxbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lnKNa55K; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ed9c16f687so1720158a12.0
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2024 10:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1731092033; x=1731696833; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hoVx3IzbvzgGPPMK+ztcJErqY3DDxw1a4kxx2dSZOIs=;
        b=lnKNa55KjkagmUTCBV4bLkdT97i4T5DWjZOGH7Ezpu8R7GMCBoCqNRHAQoXl8ImSOW
         lvL7AjcoUB+hfxu9THM9WQvy33Q55uLcNrjLreOkxNnM1SlEBT4tXeyBn3JzGL+NT5/Y
         n53h45l4YgUyfIodp2I/Vu04IZHpLkVpN7zjHf+OamcP4PLOV/HCwQj6KB/Ize5oOEfz
         M+teHVnCNnVQWChhndhgZ9bWp4bDJmNH27lpjjCQpN7NHDmY9zApEsFkcYcGBV16tm7c
         9w18eCCHsX10BtADiTmnTcq/8q7RkJ10IwUfhJW3zRUNX5ffYRDKCXNuVHOkxpwTAQR3
         STYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731092033; x=1731696833;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hoVx3IzbvzgGPPMK+ztcJErqY3DDxw1a4kxx2dSZOIs=;
        b=eAiI4OcKZpVsb+W4v+/FHt3wLMPzvrkGt31jqofG+Grr5ZCJ0vW0nZsf5yOHV9VcAs
         5PPznhmpJQvDXnAJdJu/qEYloWH5EHhL7uxBnzXpYYEyiexj8XOESuka4YYKYwe/kJrC
         JkzWDeWjab+m2l/gCgilZhDizZEYWD5Y1A7gLxbR590ZSMQY8jftctD9fC89Thno87P2
         Wi4Iq8nSi4oxTntrnU1ihAvvPy1jrUqf0OKdmrmMKH8altO6o5iadV9x92lo3RK8xc9e
         zvSJx/Zkj10EorCD0IN1EGMuW3LCV+zFdfvyx721YHflHsKZJw3aeupThrkQUMsnTHIk
         pOxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhJi3kM/d3o+uHOrOko6GjV7Qtomk6qXL1Xa4nZGWqFrMUrz92XwA4pBgGef4Hura+H2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMe0c/BPUzXlor6q4RRaFzRN4hLvN/Z50eS7EyeJzpf+qN+naA
	/O6vXAKIjsj0zZumOJ+GVMVSUeP4kgRv1qZRAIbNkRO5LVq6ifOk
X-Google-Smtp-Source: AGHT+IEJNzgS4D6XSuxlhvumNgnxU7Rx5rhzo/5zBwcEpyKpy5W+exuYFBh03DQbSyZj1mey6frm0w==
X-Received: by 2002:a05:6a21:2e81:b0:1db:e1b0:b679 with SMTP id adf61e73a8af0-1dc229cc1ccmr3685278637.18.1731092032962;
        Fri, 08 Nov 2024 10:53:52 -0800 (PST)
Received: from ArmidaleLaptop (64-119-15-60.fiber.ric.network. [64.119.15.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7e09sm4099264b3a.50.2024.11.08.10.53.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2024 10:53:52 -0800 (PST)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: "Dave Thaler" <dthaler1968@gmail.com>
To: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>,
	"'Dave Thaler'" <dthaler1968@googlemail.com>
Cc: "'Yonghong Song'" <yonghong.song@linux.dev>,
	<bpf@ietf.org>,
	"'bpf'" <bpf@vger.kernel.org>,
	"'Alexei Starovoitov'" <ast@kernel.org>,
	"'Andrii Nakryiko'" <andrii@kernel.org>,
	"'Daniel Borkmann'" <daniel@iogearbox.net>,
	"'Martin KaFai Lau'" <martin.lau@kernel.org>
References: <20240927033904.2702474-1-yonghong.song@linux.dev> <CAADnVQJZLRnT3J31CLB85by=SmC2UY1pmUZX0kkyePtVdTdy9A@mail.gmail.com> <e93729b5-199f-4809-84f5-7efdf7c8aaf3@linux.dev> <181301db143b$ba6fd9c0$2f4f8d40$@gmail.com> <CAADnVQKDwZ0+Fjiz21AFAbOgEonVojvpojU1ZyQDu8V4Jm0DYQ@mail.gmail.com> <000c01db3186$1dd30930$59791b90$@gmail.com> <CAADnVQKHHvrJjAMuXC5-wQHfMfxoSXnOBnqrZ5PC7p3C8ut3rQ@mail.gmail.com>
In-Reply-To: <CAADnVQKHHvrJjAMuXC5-wQHfMfxoSXnOBnqrZ5PC7p3C8ut3rQ@mail.gmail.com>
Subject: RE: [PATCH bpf-next] docs/bpf: Document some special sdiv/smod operations
Date: Fri, 8 Nov 2024 10:53:50 -0800
Message-ID: <09ee01db320f$8d37bc60$a7a73520$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKzqMffW8FFfWCd3ulEKsb+gfc3egGOkjXjAfqQ6mkCtID1/gMZ/eqXAhACfxMDWut5qbCGtxtg
Content-Language: en-us

> -----Original Message-----
> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Sent: Friday, November 8, 2024 10:38 AM
> To: Dave Thaler <dthaler1968@googlemail.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>; bpf@ietf.org; bpf
> <bpf@vger.kernel.org>; Alexei Starovoitov <ast@kernel.org>; Andrii =
Nakryiko
> <andrii@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>; Martin =
KaFai Lau
> <martin.lau@kernel.org>
> Subject: Re: [PATCH bpf-next] docs/bpf: Document some special =
sdiv/smod
> operations
>=20
> On Thu, Nov 7, 2024 at 6:30=E2=80=AFPM Dave Thaler =
<dthaler1968@googlemail.com>
> wrote:
> >
> >
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > On Tue, Oct 1, 2024 at 12:54=E2=80=AFPM Dave Thaler
> > > <dthaler1968@googlemail.com>
> > > wrote:
> > [...]
> > > > I'm adding bpf@ietf.org to the To line since all changes in the
> > > > standardization directory should include that mailing list.
> > > >
> > > > The WG should discuss whether any changes should be done via a =
new
> > > > RFC that obsoletes the first one, or as RFCs that Update and =
just
> > > > describe deltas (additions, etc.).
> > > >
> > > > There are precedents both ways and I don't have a strong
> > > > preference, but I have a weak preference for delta-based ones
> > > > since they're shorter and are less likely to re-open discussion =
on
> > > > previously resolved issues, thus often saving the WG time.
> > >
> > > Delta-based additions make sense to me.
> > >
> > > > Also FYI to Linux kernel folks:
> > > > With WG and AD approval, it's also possible (but not ideal) to
> > > > take changes at AUTH48.  That'd be up to the chairs and AD to
> > > > decide though, and normally that's just for purely editorial
> > > > clarifications, e.g., to confusion called out by the RFC editor =
pass.
> > >
> > > Also agree. We should keep AUTH going its course as-is.
> > > All ISA additions can be in the future delta RFC.
> > >
> > > As far as file logistics... my preference is to keep
> > > Documentation/bpf/standardization/instruction-set.rst
> > > up to date.
> > > Right now it's effectively frozen while awaiting changes (if any) =
necessary for
> AUTH.
> > > After official RFC is issued we can start landing patches into
> > > instruction-set.rst and git diff 04efaebd72d1..whatever_future_sha
> > > instruction-set.rst will automatically generate the future delta =
RFC.
> > > Once RFC number is issued we can add a git tag for the particular
> > > sha that was the base for RFC as a documentation step and to =
simplify future 'git
> diff'.
> >
> > My concern is that index.rst says:
> > > This directory contains documents that are being iterated on as =
part
> > > of the BPF standardization effort with the IETF. See the `IETF BPF
> > > Working Group`_ page for the working group charter, documents, and =
more.
> >
> > So having a document that is NOT part of the IETF BPF Working Group
> > would seem out of place and, in my view, better located up a level =
(outside
> standardization).
>=20
> It's a part of bpf wg. It's not a new document.

RFC 9669 is immutable.  Any additions require a new document, in
IETF terminology, since would result in a new RFC number.

> > Here=E2=80=99s some examples of delta-based RFCs which explain the =
gap and
> > provide the addition or clarification, and formally Update (not
> > replace/obsolete) the original
> > RFC:
> > * https://www.rfc-editor.org/rfc/rfc6585.html: Additional HTTP =
Status
> > Codes
> > * https://www.rfc-editor.org/rfc/rfc6840.html: Clarifications and =
Implementation
> Notes
> >    for DNS Security (DNSSEC)
> > * https://www.rfc-editor.org/rfc/rfc9295.html: Clarifications for =
Ed25519, Ed448,
> >    X25519, and X448 Algorithm Identifiers
> > * https://www.rfc-editor.org/rfc/rfc5756.html: Updates for =
RSAES-OAEP and
> >    RSASSA-PSS Algorithm Parameters
> >
> > Having a full document too is valuable but unless the IETF BPF WG
> > decides to take on a -bis document, I'd suggest keeping it out of =
the
> "standardization"
> > (say up 1 level) to avoid confusion, and just have one or more
> > delta-based rst files in the standardization directory.
>=20
> This patch is effectively a fix to the standard.

Two of the examples I provided above fit into that category.
Two are examples of adding new codepoints.

> It's a standard git development process when fixes are applied to the =
existing
> document.
> Forking the whole doc into a different file just to apply fixes makes =
no sense to me.

Welcome to the IETF and immutable RFCs =F0=9F=98=8A

> The formal delta-s for IETF can be created out of git.

Not in the IETF per se, since a new document needs new boilerplate, with
a new abstract, introduction, etc.  At most, part of the document could =
be created
out of git, but I'm not convinced that git diffs alone (as opposed to =
some English
prose too for each, as in the examples I cited) make for good content in =
an IETF document.

> We only need to tag the current version and then git diff =
rfc9669_tag..HEAD will give
> us that delta.
> That will satisfy IETF process and won't mess up normal git style =
kernel
> development.

I am not convinced it is sufficient.  Can you point to any precedents in =
the IETF for
such an approach?  I can't offhand... See the RFC 5756 reference above =
for what
I mean by English prose for each diff.

> btw do we still need to do any minor edit/fixes to instruction-set.rst =
before tagging it
> as RFC9669 ?

Yes, we need to backport the formatting/nits from the RFC editor pass.

Dave


