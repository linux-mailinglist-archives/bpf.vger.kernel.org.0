Return-Path: <bpf+bounces-20129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC03B839B42
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 22:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D76F1F257F7
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 21:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B80B3CF5B;
	Tue, 23 Jan 2024 21:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="SCUCeLku";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="SCUCeLku"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E133B18D
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045998; cv=none; b=tMzruFEYl0Ciiecw5x9+2mAJckXQtX1rUnUQxMIr7gSE2iEEjnYXvx5a+D7CfakGgh4D28Wiv/GUoTov0agbZF/Dk4J6HHLWv6/mL27OweDvzZNl5LaPuP6ynllfmAnDU/5RNb7TWOfgK/k5BBmtklTUVuaNGfuYc/JlYEEjx8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045998; c=relaxed/simple;
	bh=uMKcXnSMRkfI44MtP/lA55ovix//igMx/JqA0qukZtc=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=TwRUXsbXr2ZEm4NCz3RLZm7h5zjuWuyj7ZjBbgMczgEAM9JmfrFiKOGs6dzaIL2IZiYvyVk1O55Lx6z4ut8F7f4lXJ7z8hRedFluOWWM3d9LPyAaieKtx02GIW80pFmfiSTdu4jOL/J+6brZfQG33Xe41H95dgE9ONyz7bWx2ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=SCUCeLku; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=SCUCeLku; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 4392AC14CE31
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 13:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706045996; bh=uMKcXnSMRkfI44MtP/lA55ovix//igMx/JqA0qukZtc=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=SCUCeLku/HONaB/sXHfItWWRl0BYy0j0Uy4IwZtvWTJFwibThuEsXEBt2OLo9g2ck
	 8yc5oKDOQ2z2NeWs9AngLmoJJ/psyBtzMPDRLnA44xxTfA+K14855S70qfvI+aZEKE
	 +eRd/OxtEsJvOyhfOO5PqrBXch388KI5sb6IASdc=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Jan 23 13:39:56 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 15C3FC14F6EF;
	Tue, 23 Jan 2024 13:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706045996; bh=uMKcXnSMRkfI44MtP/lA55ovix//igMx/JqA0qukZtc=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=SCUCeLku/HONaB/sXHfItWWRl0BYy0j0Uy4IwZtvWTJFwibThuEsXEBt2OLo9g2ck
	 8yc5oKDOQ2z2NeWs9AngLmoJJ/psyBtzMPDRLnA44xxTfA+K14855S70qfvI+aZEKE
	 +eRd/OxtEsJvOyhfOO5PqrBXch388KI5sb6IASdc=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id D306FC14F604
 for <bpf@ietfa.amsl.com>; Tue, 23 Jan 2024 13:39:54 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.41
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wjqKE8RFJlAh for <bpf@ietfa.amsl.com>;
 Tue, 23 Jan 2024 13:39:52 -0800 (PST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 7E883C14F5F4
 for <bpf@ietf.org>; Tue, 23 Jan 2024 13:39:52 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-6818b86ec67so38291296d6.0
 for <bpf@ietf.org>; Tue, 23 Jan 2024 13:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706045991; x=1706650791;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H7m7Ww8d39wI3CHdff1mrU0U07u4CcC+sMUOKEwLLRc=;
 b=CA6bI3H+y5CmWP+IIWkNE3fDiXup/WvFxJsnTWHilcMht2ez1MY3hy5Lnt4/O5IFI5
 FY9IHim2wS5VmbI9zZU6MQ5ainQ51pdJRgnFZPyRVJ9zjugVvS0wUtpOAI/6ByWhMmUN
 c6rJ+emFv5aQ5cmK0vHCCTuUbq7LTAdKBWlaOznfGy7HygGZ0xVkI1XPUbfA2zpHZLCB
 SXnCLqDlg2tVLS4CnBYWJ1OumD7b/uwEJgfeSMWMuS/Pqv/cNsvBtJvd43YKPMBs7Mzi
 /s2QZsCVtckmGVxixVQEYVjM+AR/dCB2YYm/AZD7MgFIbcanc0iAbjRXqpeLxJH8sFAO
 dHEg==
X-Gm-Message-State: AOJu0Yyr0NRMl0aEfA3zI65mvs0Ctkn9OazY4+68JbnHDgqb4NSl2wm+
 N4Tz2R7pjCZY7mFJsFU8kL05ode7RmDgLhCzDdVL+Nu9RttwZe/E
X-Google-Smtp-Source: AGHT+IFcuDnuQKZ7LbM7w2rwcuEvoL12+XwKD7R1qUhwRcDCGeX+FAqBaPM4Ht2idmpsJT24yxg6Mw==
X-Received: by 2002:a05:6214:27c9:b0:681:99e3:ea65 with SMTP id
 ge9-20020a05621427c900b0068199e3ea65mr330190qvb.53.1706045991457; 
 Tue, 23 Jan 2024 13:39:51 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 y8-20020ad445a8000000b00685191beaa9sm3825612qvu.3.2024.01.23.13.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 13:39:50 -0800 (PST)
Date: Tue, 23 Jan 2024 15:39:48 -0600
From: David Vernet <void@manifault.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Christoph Hellwig <hch@infradead.org>,
 Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org,
 bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 david.faust@oracle.com
Message-ID: <20240123213948.GA221862@maniforge>
References: <20231214174437.GA2853@maniforge> <ZXvkS4qmRMZqlWhA@infradead.org>
 <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com>
 <09dc01da32a6$99c97e50$cd5c7af0$@gmail.com>
 <CAADnVQ+Kb20aUZdcqSh5eF-_dzpHWcpjAtYpLgg5Fqog=g7hpA@mail.gmail.com>
 <ZYPiq6ijLaMl/QD8@infradead.org>
 <20240105220711.GA1001999@maniforge>
 <ZZwcC7nZiZ+OV1ST@infradead.org>
 <CAADnVQLMo0M675T89gu9v_wSR+GbQmu4ajWjwgWK9aCNkJPsaQ@mail.gmail.com>
 <874jfm68ok.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <874jfm68ok.fsf@oracle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Y4vIImoak57JsyeI9wnEueyT8_o>
Subject: Re: [Bpf] BPF ISA conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============5270381906325162519=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============5270381906325162519==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UcdM0TBuMakHB0GL"
Content-Disposition: inline


--UcdM0TBuMakHB0GL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 12:35:39PM +0100, Jose E. Marchesi wrote:
>=20
> > On Mon, Jan 8, 2024 at 8:00=E2=80=AFAM Christoph Hellwig <hch@infradead=
=2Eorg> wrote:
> >>
> >> On Fri, Jan 05, 2024 at 04:07:11PM -0600, David Vernet wrote:
> >> >
> >> > So how do we want to move forward here? It sounds like we're leaning
> >> > toward's Alexei's proposal of having:
> >> >
> >> > - Base Integer Instruction Set, 32-bit
> >> > - Base Integer Instruction Set, 64-bit
> >> > - Integer Multiplication and Division
> >> > - Atomic Instructions
> >>
> >> As in the 64-bit integer set would be an add-on to the first one which
> >> is the core set?  In that case that's fine with me, but the above
> >> wording is a bit suboptimal.
> >
> > yes.
> > Here is how I was thinking about the grouping:
> > 32-bit set: all 32-bit instructions those with BPF_ALU and BPF_JMP32
> > and load/store.
> >
> > 64-bit set: above plus BPF_ALU64 and BPF_JMP.
> >
> > The idea is to allow for clean 32-bit HW offloads.
> > We can introduce a compiler flag that will only use such instructions
> > and will error when 64-bit math is needed.
> > Details need to be thought through, of course.
> > Right now I'm not sure whether we need to reduce sizeof(void*) to 4
> > in such a case or normal 8 will still work, but from ISA perspective
> > everything is ready. 32-bit subregisters fit well.
> > The compiler work plus additional verifier smartness is needed,
> > but the end result should be very nice.
> > Offload of bpf programs into 32-bit embedded devices will be possible.
>=20
> This is very interesting.
>=20
> Sounds like, on one hand, introducing ilp32 and lp64 C data models for
> BPF:
>=20
> ilp32
>=20
>   int, long, pointers -> 32 bit
>   short -> 16 bit
>   char -> 8 bit
>=20
> lp64
>=20
>   long, pointers -> 64 bit
>   int -> 32 bit
>   short -> 16 bit
>   char -> 8 bit
>=20
> On the other hand, compiler flags -m32 and -m64 could determine what
> instruction groups are generated and what C data model is used:
>=20
> -m32
>=20
>   Use ilp32 data model for C.
>   Use 32-bit instruction set.
>=20
> -m64
>=20
>   Use lp64 data model for C.
>   Use both 32-bit (if/when alu32) and 64-bit instruction sets.

This all seems reasonable to me.

> And perhaps introducing a bit in the ELF flags section identifying a
> 32-bit binary.  Something like EF_BPF_32.
>=20
> Would 64-bit ELF be used also in cases where BPF is offloaded to 32-bit
> devices?

I expect it would be preferable to not use ELF-64 here, but I also don't
think this is necessarily something we need to figure out now. Hopefully
this is all stuff we can iron out once we start to really sink our teeth
into the ABI doc.

--UcdM0TBuMakHB0GL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZbAyJAAKCRBZ5LhpZcTz
ZBNpAP9G/9AKTDgYt3KyV1rGCirSxYUl7wMaYg9CUhEcIMHLJAD/fMQVKNIp7T4p
yU2w2oKx6jwggm5v6BH9D9pYhHvv6Ac=
=Ng4w
-----END PGP SIGNATURE-----

--UcdM0TBuMakHB0GL--


--===============5270381906325162519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============5270381906325162519==--


