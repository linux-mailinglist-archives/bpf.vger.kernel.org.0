Return-Path: <bpf+bounces-27586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CEF8AF7AF
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 21:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47C1B217CA
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 19:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5CB1422BB;
	Tue, 23 Apr 2024 19:59:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC611411E0
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902354; cv=none; b=DQNX+mOjW7kYATatBc1SbU/hJoCB7Irv00pbg9wF0AE6oL903kHpwXUQB2E5uk1la+/468F6UjwlelMSn73MVvzIoAuwXI67iV1U4T7XrG9iBdGVAmj1BQAQTb80g/Y0P0NEjwoZ2baG+Kys/e8htqCLFHCYIrkHKKWFjYgl1YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902354; c=relaxed/simple;
	bh=PFBCUwILRJjtxFpxfpt+sz9gVZcMQB8c8oc+7TWv1FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHyt+C/UURLNQbx3SFWI+qfq12m0JtV6w7qAecDSvWNuyMLJzG/+KdMMDRTGjOEhK/eio0nLATDAgP9L6L6gcdkQKn/3Cm0HmFeDnO/RomwRwEigIPGAOAL7VoTEAfRCPkkmK952SJZ8fhur0nDquuvhuEsCVqciw+x2hyQEOgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7da1d81d042so259525939f.0
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 12:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713902352; x=1714507152;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeIQh3BCmDuM5IuVKvmeXknAspSGb9upq89lP3SNgKQ=;
        b=qfV5ulVwttKHRb+6sV0lS1H0pNoa9btOkksV+yXES1pHeqo1T/1Db4aFVnjcNJ0rf1
         9Y6trLXk4C8dP4gk9c9kwKp0S713hb43Udose93Hr4yHinNhnujndThOvMpJvZCSlQeE
         MR7H4mJNTYaedpQpsPOyaNPjO17hnZffb3x+DxZQefOXC91mK5jbLul+SJwd/C/EF8aD
         kkCJIXT9C0i01Y89RWrrQId6MZFQNUZQ9sEttPJLChI/J7nQ8bgxoP3dIqbKkabpB58v
         jm0pHbJceu4hhavJOY/49PfCv9lOqN54I3sEeRpqSBTlreUdRTmjI27L3TAwpj1w5KGI
         Ba1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1Vk/mdrql9e/URNkXCksL9ZZhqJ8+We5jU5eW0h18yFDYBIUabtD/Ql/+bjLwBC0cYM6YJ+u6whwHZvcEeoUFFBE9
X-Gm-Message-State: AOJu0YwpeAo7vrzT5KG7Nwx+dDEw9k+oAA1aPpiylyQkVstzPUaMzes8
	MLrFaUNq/l31J88ZGSH1Smt14KQddHpjv4On6aBYeHL94yY7tFcu
X-Google-Smtp-Source: AGHT+IF9CXTMbUnNO8sYHTWQBSBlbgZnR51dfmTHfp9FhdVsrQlMaY7gMJB/N8hnUk405Irfbp9NAA==
X-Received: by 2002:a05:6e02:1fe9:b0:36b:fffc:73bb with SMTP id dt9-20020a056e021fe900b0036bfffc73bbmr660654ilb.7.1713902352112;
        Tue, 23 Apr 2024 12:59:12 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id ay31-20020a056638411f00b0048571836194sm761127jab.108.2024.04.23.12.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 12:59:11 -0700 (PDT)
Date: Tue, 23 Apr 2024 14:59:09 -0500
From: David Vernet <void@manifault.com>
To: dthaler1968@googlemail.com
Cc: 'Watson Ladd' <watsonbladd@gmail.com>,
	'Alan Jowett' <Alan.Jowett@microsoft.com>, bpf@ietf.org,
	bpf@vger.kernel.org
Subject: Re: [Bpf] BPF ISA Security Considerations section
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kIjviTN9lakZEcNj"
Content-Disposition: inline
In-Reply-To: <1b5f01da95a7$f1a684b0$d4f38e10$@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


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

