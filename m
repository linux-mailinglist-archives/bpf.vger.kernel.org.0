Return-Path: <bpf+bounces-27587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874728AF7B2
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 21:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC991C22092
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 19:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835721428EA;
	Tue, 23 Apr 2024 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="P6bxdV/f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="pCJJXhj+"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFF2142658
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 19:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902367; cv=none; b=kZ6nJd/rKn8VNxdbLO67skw4Jjx2wnrtCscGkKfse3KagsoXcFzlN5/z0K2jx1x8Wb7bdalmDXe2rF4ERHEZwcnVBkSUGU2W4nkNyOrs+1WT/WsKQadxOWqDolta9bLBTSybDu8XbkXmK6UBLbX6qYXmBte6dVr+4TyBzSqFDis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902367; c=relaxed/simple;
	bh=K0GsHctaAH5ERjmwPAwAroi0zekwii3EOty2NJblicU=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=dORBp71ocITrWRsnomAGwdw8lvyuBUNp0ftE1UBx29Ic4Ob0qfuVmXusADQolZpKNAMI1oLNiNxJ8KKRNGCXbOQIIX8rogzv025CfzkHVRVIHxPkFLFkmTwtRl/7/CCvIgdukg/Is8oYB06Xt3bcfDEA57ZxDDFm08Lk+v/iz3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=P6bxdV/f; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=pCJJXhj+; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0E61EC15154A
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 12:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713902359; bh=K0GsHctaAH5ERjmwPAwAroi0zekwii3EOty2NJblicU=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=P6bxdV/f5hPhhz8oZlMjwH8p9XRsakDs8sb0gImiUPoN22mKjbKGGbmMEGuzUgWRu
	 G+Dvip04UOs/9U8L+9/L/KUEaUmzIpn+q8+XYLFf9UHgoON8fBBz+Zs21j3zpEyQlm
	 boT1vlqH5fQDM2XraBdgNLEmy1cXWHK662G/vEkY=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Apr 23 12:59:19 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id CEEFEC151538;
	Tue, 23 Apr 2024 12:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713902358; bh=K0GsHctaAH5ERjmwPAwAroi0zekwii3EOty2NJblicU=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=pCJJXhj+i4NOSBbihMo0mADDSQSaB6jizdp1pB4TocQ2GeQNjgCUkvRN9E6X75Cob
	 fq+P6ayDRihE187VUAVQuzRzx1OzLXSNZgIGnPNA3DMKWV+TCtrsMs3BxeERjF7wi3
	 QSXRFrOf6dNJoJJUNUd/LZ2ll6x/tZDdQv6ukcL8=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id C91B7C151538
 for <bpf@ietfa.amsl.com>; Tue, 23 Apr 2024 12:59:17 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.648
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iUraNB8FdPOM for <bpf@ietfa.amsl.com>;
 Tue, 23 Apr 2024 12:59:12 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com
 [209.85.166.171])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id E0BDDC151520
 for <bpf@ietf.org>; Tue, 23 Apr 2024 12:59:12 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id
 e9e14a558f8ab-36a0f64f5e0so25207575ab.3
 for <bpf@ietf.org>; Tue, 23 Apr 2024 12:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713902352; x=1714507152;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EeIQh3BCmDuM5IuVKvmeXknAspSGb9upq89lP3SNgKQ=;
 b=KBTxJaq8SfM8t4W0UTvd/MkjAXtvMAfN9kgATmU1CTX4BoDs/FZTYNkLVWcPHN6Apu
 71d7lMP16YwV3K8x+1EfoRD2ZMQ1gp9Uf2bh4mxTsGaJ0sfP6yGokYbtcYiAHQdCOrq2
 UmuTE6PU0kAmfueWieTSk7fuvb988ItG4KG9zek33JrpGLVqMf/U0d3bqkLU1nWRVHDv
 kFDrx47ehcR7s8viikVt3apQkZ23BnD6+8Z3KmxhW923vB4Isqjf//ygknVEpb5/QA4W
 F2guUl0+gkGshifbxj0uGSSdJBZ22eCGL93vM1/lZE5lkOSkAPuqAwhS7bYeDVcVk13n
 1+qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJq2hv9I4qxRfCFuuVx3ZJsdVLUnhDDtWFwn7v8WS2mCcuwCNCYcUHpphakVGpvX8O48Wv6REDN9GDMKs=
X-Gm-Message-State: AOJu0Yzk2LnwfDYPGacakG3A5O6jUH4pjZNTQXAE2+DvBeJyDWlne+7I
 f2G1MoO6/3W7fN4vyP9Wvvm/d7IhTlWYAh/jKjDzdOy1QQTs7PQM
X-Google-Smtp-Source: AGHT+IF9CXTMbUnNO8sYHTWQBSBlbgZnR51dfmTHfp9FhdVsrQlMaY7gMJB/N8hnUk405Irfbp9NAA==
X-Received: by 2002:a05:6e02:1fe9:b0:36b:fffc:73bb with SMTP id
 dt9-20020a056e021fe900b0036bfffc73bbmr660654ilb.7.1713902352112; 
 Tue, 23 Apr 2024 12:59:12 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
 by smtp.gmail.com with ESMTPSA id
 ay31-20020a056638411f00b0048571836194sm761127jab.108.2024.04.23.12.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 12:59:11 -0700 (PDT)
Date: Tue, 23 Apr 2024 14:59:09 -0500
From: David Vernet <void@manifault.com>
To: dthaler1968@googlemail.com
Cc: 'Watson Ladd' <watsonbladd@gmail.com>,
 'Alan Jowett' <Alan.Jowett@microsoft.com>, bpf@ietf.org,
 bpf@vger.kernel.org
Message-ID: <20240423195909.GA89547@maniforge>
References: <093301da933d$0d478510$27d68f30$@gmail.com>
 <20240421165134.GA9215@maniforge>
 <109c01da9410$331ae880$9950b980$@gmail.com>
 <149401da94e4$2da0acd0$88e20670$@gmail.com>
 <20240422193451.GA18561@maniforge>
 <160501da94f3$4f8aef40$eea0cdc0$@gmail.com>
 <160f01da94f4$31201c50$936054f0$@gmail.com>
 <CACsn0ck4FW+S6ewkFwAouQ1ObHx-2sYZsEv3qGi7LcsFywfzAg@mail.gmail.com>
 <1b5f01da95a7$f1a684b0$d4f38e10$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1b5f01da95a7$f1a684b0$d4f38e10$@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/dpZHI7p6R-HKYnh3Cd_K7MH-CGU>
Subject: Re: [Bpf] BPF ISA Security Considerations section
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============2887026639993679957=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============2887026639993679957==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kIjviTN9lakZEcNj"
Content-Disposition: inline


--kIjviTN9lakZEcNj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 10:59:09AM -0700, dthaler1968@googlemail.com wrote:
> Thanks Watson and Alan for continued feedback.
>=20
> Watson wrote:
> > But W^X mappings are for JIT (and avoidable by writing, then remapping =
and
> > executing), not interpreters.
>=20
> Removed W^X phrase.
>=20
> > How about we just say "Executing the program requires
> > an interpreter or JIT compiler in the same memory space as the system b=
eing
> > probed or extended.
>=20
> Execution does not require that the interpreter or JIT compiler is in the=
 same
> memory space, even if that is the most common implementation.  (And Alan's
> point also applies here that compilation might or might not be JIT per se=
=2E)
>=20
> Below is the latest strawman after taking the latest feedback into accoun=
t...
>=20
> -Dave
>=20
>=20
> Security Considerations
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> BPF programs could use BPF instructions to do malicious things with memor=
y, CPU, networking,
> or other system resources.  This is not fundamentally different from any =
other type of
> software that may run on a device.  Execution environments should be care=
fully designed
> to only run BPF programs that are trusted and verified, and sandboxing an=
d privilege level
> separation are key strategies for limiting security and abuse impact.  Fo=
r example, BPF
> verifiers are well-known and widely deployed and are responsible for ensu=
ring that BPF programs
> will terminate within a reasonable time, only interact with memory in saf=
e ways, and adhere to
> platform-specified API contracts. This level of verification can often pr=
ovide a stronger level
> of security assurance than for other software and operating system code.
> While the details are out of scope of this document,
> `Linux <https://www.kernel.org/doc/html/latest/bpf/verifier.html>`_ and
> `PREVAIL <https://pldi19.sigplan.org/details/pldi-2019-papers/44/Simple-a=
nd-Precise-Static-Analysis-of-Untrusted-Linux-K                            =
                                                                           =
        Kernel-Extensions>`_ do provide many details.  Future IETF work wil=
l document verifier expectations
> and building blocks for allowing safe execution of untrusted BPF programs.
>=20
> Executing programs using the BPF instruction set also requires either an =
interpreter or a compiler
> to translate them to hardware processor native instructions. In general, =
interpreters are considered a
> source of insecurity (e.g., gadgets susceptible to side-channel attacks d=
ue to speculative execution)
> whenever one is used in the same memory address space as data with confid=
entiality
> concerns.  As such, use of a compiler is recommended instead.  Compilers =
should be audited
> carefully for vulnerabilities to ensure that compilation of a trusted and=
 verified BPF program
> to native processor instructions does not introduce vulnerabilities.
>=20
> Exposing functionality via BPF extends the interface between the componen=
t executing the BPF program and the
> component submitting it. Careful consideration of what functionality is e=
xposed and how
> that impacts the security properties desired is required.

LGTM

--kIjviTN9lakZEcNj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZigTDQAKCRBZ5LhpZcTz
ZCBLAP9GFqJD/OoXGej/fxWM2rjSgZUz+A3+vSanqwdjADtoXAEAxbAkbZnqQZo/
D4cznspBJTL7T2trnVU+9qcOKtnpxA4=
=FyLi
-----END PGP SIGNATURE-----

--kIjviTN9lakZEcNj--


--===============2887026639993679957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============2887026639993679957==--


