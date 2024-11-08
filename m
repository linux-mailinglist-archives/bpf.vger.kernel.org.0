Return-Path: <bpf+bounces-44313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D169B9C1413
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 03:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F010F1C22362
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 02:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0626D528;
	Fri,  8 Nov 2024 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JjF+UHKC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63B6224EA
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731033008; cv=none; b=WS5HAAsS6T3JbL3Xmyfa/n3H/FM/zb1f5+8intNdcHD3l5TwDuSb+K7sepumiyjB/ijKjlxFPL5a+U5+sZcdQHgNtrCMtNZb2ipH/ZwN8rve7WmJtyDYMn9GLGo+jcT0iW1XV/Dk5TYVzUhfBFDFIyNDKLIhZwLoEB0RDq4gs3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731033008; c=relaxed/simple;
	bh=mGVNbtyST2k5vsgdUgYMlxBzzeZYuzW1cOGkhDAowOk=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=jitR1T++x/0zHnnJCO9KnWFu3z8Uk2LZeHDpx69PSycOGLs3SGu+N7rKU37rAH2Z/5vKIJdEAv9FjXyWmpUOBkutnVcgNeIRC/i6jQ2e8wLyM60dGnhTsL+t1TQAiH6+xoSFcrXFL6viq8jmc8K4n4SFK/RBKV4AkVfSrnEb85M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JjF+UHKC; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so1297658b3a.2
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 18:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1731033006; x=1731637806; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xhz/+s7HYtJld+Ohgk7s3Y+hFW8YWP51r5v5/v6WmiQ=;
        b=JjF+UHKCaXjxmjp3CDg0603bOmILjWWuJcQ5df/nUEo1CO/ryfseq352rsGzYzv1Zs
         9IOzjRsJTwwIlRaivdYnJp5egX/0p9f5tJw7Ooa5XMGa9GVGxDksSGWPD11ik1A1faO6
         Q+kpAlzDA2brQIUQ8nl9lu7yi280ucDR01JqhLEJKcriP73a3xTKJq3j3SSdq6C1eND3
         9Ja216JveJkyO/i5GdP81fg8lcuiYDx+EkbWDYu3X7cTBSZ6IP+7wNCqC9YdoVLYq0GF
         hWEP75Pze57eyiNc+TTsXekfsGgOpUE37hSSJuoMhAUnFXLAFwo6E31sv0CQ3vvoeVMa
         fyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731033006; x=1731637806;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xhz/+s7HYtJld+Ohgk7s3Y+hFW8YWP51r5v5/v6WmiQ=;
        b=mnOPcrz75kSBxsdahghitgyUJjomWj5jYcwm14/ikQdYtUDv4yp2vNVVsnjCMX+u/+
         IeBNm4IA/0MCS7rUz3m0ZyMouIIMAKitJ5rE3eaJM2XQdVrghWftdYW0l0CGcNVMK+OR
         Xr9MTBbOv0YQ1aLsjOq1G1XPqAxHg3+LMrkuqV/gpAjbRCBqv9+Dv+qzPtJHsIKD1kC/
         5HbnI3LmdW+IUsc07abZ5kOjW51kVUxGZ5NCL9pbT2SnChMWJzlRs7/F+FLaEzmf88zn
         n5GsoUsDVG5AP1I3NaCPokwiujcU5FY/wDr46tO9tvTEvtG5/GpjxA+oEtCIBCvoW72w
         q4Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXWhlWOIYeb+VX95eF6FhEu2WDsmBtJm87kMNqd6QTOE9GgPbF0Ik1EZLJSHXGakcaZH4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWBWKTTGARMsADxARZaFM2v6LdJS+kTlqhXVtvHDc/4IvGMdBZ
	VpIailMIO1nooVenzSYHE4PG9z4Oxw8l0mMywETxPNjqWOnLvHll
X-Google-Smtp-Source: AGHT+IFw4wElaScxFYGSH2hirpJZsTiiw+Xs+JS9M8pPlhrIJkzu8dJhCGqFCu3QGdFMyevCmsbIVA==
X-Received: by 2002:a05:6a21:7881:b0:1d9:2408:aa4c with SMTP id adf61e73a8af0-1dc2299e40bmr1403146637.23.1731033005719;
        Thu, 07 Nov 2024 18:30:05 -0800 (PST)
Received: from ArmidaleLaptop (64-119-15-60.fiber.ric.network. [64.119.15.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd17e9sm2590748a91.39.2024.11.07.18.30.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2024 18:30:04 -0800 (PST)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: "Dave Thaler" <dthaler1968@gmail.com>
To: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>
Cc: "'Yonghong Song'" <yonghong.song@linux.dev>,
	<bpf@ietf.org>,
	"'bpf'" <bpf@vger.kernel.org>,
	"'Alexei Starovoitov'" <ast@kernel.org>,
	"'Andrii Nakryiko'" <andrii@kernel.org>,
	"'Daniel Borkmann'" <daniel@iogearbox.net>,
	"'Martin KaFai Lau'" <martin.lau@kernel.org>
References: <20240927033904.2702474-1-yonghong.song@linux.dev> <CAADnVQJZLRnT3J31CLB85by=SmC2UY1pmUZX0kkyePtVdTdy9A@mail.gmail.com> <e93729b5-199f-4809-84f5-7efdf7c8aaf3@linux.dev> <181301db143b$ba6fd9c0$2f4f8d40$@gmail.com> <CAADnVQKDwZ0+Fjiz21AFAbOgEonVojvpojU1ZyQDu8V4Jm0DYQ@mail.gmail.com>
In-Reply-To: <CAADnVQKDwZ0+Fjiz21AFAbOgEonVojvpojU1ZyQDu8V4Jm0DYQ@mail.gmail.com>
Subject: RE: [PATCH bpf-next] docs/bpf: Document some special sdiv/smod operations
Date: Thu, 7 Nov 2024 18:30:00 -0800
Message-ID: <000c01db3186$1dd30930$59791b90$@gmail.com>
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
Thread-Index: AQKzqMffW8FFfWCd3ulEKsb+gfc3egGOkjXjAfqQ6mkCtID1/gMZ/eqXsLDVueA=
Content-Language: en-us


Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> On Tue, Oct 1, 2024 at 12:54=E2=80=AFPM Dave Thaler =
<dthaler1968@googlemail.com>
> wrote:
[...]
> > I'm adding bpf@ietf.org to the To line since all changes in the
> > standardization directory should include that mailing list.
> >
> > The WG should discuss whether any changes should be done via a new =
RFC
> > that obsoletes the first one, or as RFCs that Update and just =
describe
> > deltas (additions, etc.).
> >
> > There are precedents both ways and I don't have a strong preference,
> > but I have a weak preference for delta-based ones since they're
> > shorter and are less likely to re-open discussion on previously
> > resolved issues, thus often saving the WG time.
>=20
> Delta-based additions make sense to me.
>=20
> > Also FYI to Linux kernel folks:
> > With WG and AD approval, it's also possible (but not ideal) to take
> > changes at AUTH48.  That'd be up to the chairs and AD to decide
> > though, and normally that's just for purely editorial =
clarifications,
> > e.g., to confusion called out by the RFC editor pass.
>=20
> Also agree. We should keep AUTH going its course as-is.
> All ISA additions can be in the future delta RFC.
>=20
> As far as file logistics... my preference is to keep
> Documentation/bpf/standardization/instruction-set.rst
> up to date.
> Right now it's effectively frozen while awaiting changes (if any) =
necessary for AUTH.
> After official RFC is issued we can start landing patches into =
instruction-set.rst and
> git diff 04efaebd72d1..whatever_future_sha instruction-set.rst will =
automatically
> generate the future delta RFC.
> Once RFC number is issued we can add a git tag for the particular sha =
that was the
> base for RFC as a documentation step and to simplify future 'git =
diff'.

My concern is that index.rst says:
> This directory contains documents that are being iterated on as part =
of the BPF
> standardization effort with the IETF. See the `IETF BPF Working =
Group`_ page
> for the working group charter, documents, and more.

So having a document that is NOT part of the IETF BPF Working Group =
would seem
out of place and, in my view, better located up a level (outside =
standardization).

Here=E2=80=99s some examples of delta-based RFCs which explain the gap =
and provide
the addition or clarification, and formally Update (not =
replace/obsolete) the original
RFC:
* https://www.rfc-editor.org/rfc/rfc6585.html: Additional HTTP Status =
Codes
* https://www.rfc-editor.org/rfc/rfc6840.html: Clarifications and =
Implementation Notes
   for DNS Security (DNSSEC)
* https://www.rfc-editor.org/rfc/rfc9295.html: Clarifications for =
Ed25519, Ed448,
   X25519, and X448 Algorithm Identifiers
* https://www.rfc-editor.org/rfc/rfc5756.html: Updates for RSAES-OAEP =
and=20
   RSASSA-PSS Algorithm Parameters

Having a full document too is valuable but unless the IETF BPF WG
decides to take on a -bis document, I'd suggest keeping it out of the =
"standardization"
(say up 1 level) to avoid confusion, and just have one or more =
delta-based rst files
in the standardization directory.

Dave




