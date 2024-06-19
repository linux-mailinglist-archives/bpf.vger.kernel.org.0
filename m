Return-Path: <bpf+bounces-32526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AA290F41C
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 18:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E08428386E
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 16:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61CB154444;
	Wed, 19 Jun 2024 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SODf2MPX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB0A15278D
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718814863; cv=none; b=PcbyZKnlWiwvCFZ16GaL5vxcqVkfBUwYJ+YZuYwjZPwcJJhfjzORxiY8ONMPPDiy5NOOFm92A29unkZmcRpVHIQb3j16WgjI58K89sTNfl343bWmV8/uuXpWU5kWlxxvq0Qc4bO1dwtQBLAWqdwe+iK00Pog5KX+oJtiKsnbeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718814863; c=relaxed/simple;
	bh=sWXfe3iROAv5nunMV/T4SIqsE90qqOYqjalWoYIQLNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2jVR3lIz/dMROcXORGR3lsfVLu6akK7x8H2cnp+1ly3ULYYzkivBKNgN0Wkv2lREZ9Rs2z3h0MXjLpDfb5RzYeeFp52fVD0nroOwjncmGaKITjvWzUC7W3Q6X2AztDnF1X3ceOqHfQDRGGXz/TLaYM7gMR20P/IGxUlScbm9TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SODf2MPX; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-63258caaa91so51614047b3.0
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 09:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718814860; x=1719419660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTFDXI3lmE89xsXWjsBu8Z87GpVx8y3WY9kndQ0G3Gg=;
        b=SODf2MPXUD/inhB9ZtlYlD84hfxYzjhXeiikobWzaM1pcA77EfeDJmsH9zNNRBorOA
         D9c0VQUciNOCB76tfq1s13vwYnnZ3f+akptgtsehgEgReJj6k8Ikl6VaaJpFSxZgM5Mg
         Q1wkeg3JatlgRzSUDRAxEVemsSh7IvC7cuRh+ghj/2WyCid2KD9oubusgrm0ulSEzZ7v
         KkGV3xHoVjWtuQsYQd4YcL5CciyIFTwGsKk7Vot+J/cRaSb2rNNxHj2OBc74/k5h4AC4
         jKbakHk1uvegVzJorWizxtmA/st3BoFe4NFgOkBY/dz5ocOTZPYnXaVOn2Jw8EdpCxOD
         IFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718814860; x=1719419660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTFDXI3lmE89xsXWjsBu8Z87GpVx8y3WY9kndQ0G3Gg=;
        b=PAo8jaV1UaTEhIkfY1sL1P71VEx6LwxP6jRSKKJlvNmGNBOg2+EZDQMK/atU8qFv2N
         IeeiTgW0AFR0jnyzgt2DPH4dDKbVEjuq+ydXHpLIZkGdnKd7d1qb8RNx/py9lvB46Px4
         IBHz3muAFohwVE4EDzTZbl5HaUW5IlsvPdf7MRrq69hLloDnTRHvbYVerj75tNf8Cj8/
         //YvvUrO5fwPqNAbPzYpVIZgVV2S5ZgYDDWD0J84NdQiKEaJ4hPmn4iNQSK+6C33veSS
         2S6OOvQU/kF3jzyXpMgWKMDbosUiahElaOpiddfcmIePrIBZ6U+Xby3OkcffNFvyrI7l
         QF4A==
X-Forwarded-Encrypted: i=1; AJvYcCUwQ1ffWdNmEtAh/fOtczweo7ob6UjSUHCKRrJNMRTI5bjYNcdDgH6qVCbxJxxwgZmPIJHWLVpr6ZYhGVZ9njbK4zaA
X-Gm-Message-State: AOJu0YySwe7zjIQBLH0IjPpVZMp61uAVUyKK4uDhQrjU4ZcGklSny0fb
	y+Yyj83YN7mcgh7x6w1G/10vEGswjvHcbdRQ7SGXcKuE8m4RRvwnUcDK2Shwf4X+kGO6gBcUJXl
	iB9Rvownuk2ej/tn6Yi4+GP22pbuO6vCWPL2t
X-Google-Smtp-Source: AGHT+IHu6b6GzxTUmoaKY8FCnkWOQQ5arRuKCg2OzKx7h+qxUq7WqX1BaUl/DWaLG0aZ1MBJukslwKHs4gsEbHoMAg4=
X-Received: by 2002:a05:690c:80f:b0:617:fe2a:a0aa with SMTP id
 00721157ae682-63a8d736f33mr33957447b3.6.1718814860138; Wed, 19 Jun 2024
 09:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhTs8p1nTUXXea2JmF0FCEU6w39gwQRMtwACqM=+EBj1jw@mail.gmail.com>
 <7cf03a6ba8dbf212623aab2dea3dac39482e8695.camel@huaweicloud.com>
 <CAHC9VhSCw6RweTs6whAu4v6t4n7gxUWJtjmzY-UXrdzW0H+YJA@mail.gmail.com> <520d2dc2ff0091335a280a877fa9eb004af14309.camel@huaweicloud.com>
In-Reply-To: <520d2dc2ff0091335a280a877fa9eb004af14309.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 19 Jun 2024 12:34:09 -0400
Message-ID: <CAHC9VhRD1kBwqtkF+_cxCUCeNPp+0PAiNP-rG06me6gRQyYcyg@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] security: digest_cache LSM
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: corbet@lwn.net, jmorris@namei.org, serge@hallyn.com, 
	akpm@linux-foundation.org, shuah@kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, mic@digikod.net, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	linux-integrity@vger.kernel.org, wufan@linux.microsoft.com, 
	pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org, 
	pmatilai@redhat.com, jannh@google.com, dhowells@redhat.com, jikos@kernel.org, 
	mkoutny@suse.com, ppavlu@suse.com, petr.vorel@gmail.com, mzerqung@0pointer.de, 
	kgold@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 11:55=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Wed, 2024-06-19 at 11:49 -0400, Paul Moore wrote:
> > On Wed, Jun 19, 2024 at 3:59=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Tue, 2024-06-18 at 19:20 -0400, Paul Moore wrote:
> > > > On Mon, Apr 15, 2024 at 10:25=E2=80=AFAM Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > >
> > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > >
> > > > > Integrity detection and protection has long been a desirable feat=
ure, to
> > > > > reach a large user base and mitigate the risk of flaws in the sof=
tware
> > > > > and attacks.
> > > > >
> > > > > However, while solutions exist, they struggle to reach the large =
user
> > > > > base, due to requiring higher than desired constraints on perform=
ance,
> > > > > flexibility and configurability, that only security conscious peo=
ple are
> > > > > willing to accept.
> > > > >
> > > > > This is where the new digest_cache LSM comes into play, it offers
> > > > > additional support for new and existing integrity solutions, to m=
ake
> > > > > them faster and easier to deploy.
> > > > >
> > > > > The full documentation with the motivation and the solution detai=
ls can be
> > > > > found in patch 14.
> > > > >
> > > > > The IMA integration patch set will be introduced separately. Also=
 a PoC
> > > > > based on the current version of IPE can be provided.
> > > >
> > > > I'm not sure we want to implement a cache as a LSM.  I'm sure it wo=
uld
> > > > work, but historically LSMs have provided some form of access contr=
ol,
> > > > measurement, or other traditional security service.  A digest cache=
,
> > > > while potentially useful for a variety of security related
> > > > applications, is not a security service by itself, it is simply a f=
ile
> > > > digest storage mechanism.
> > >
> > > Uhm, currently the digest_cache LSM is heavily based on the LSM
> > > infrastructure:
> >
> > I understand that, but as I said previously, I don't believe that we
> > want to support a LSM which exists solely to provide a file digest
> > cache.  LSMs should be based around the idea of some type of access
> > control, security monitoring, etc.
> >
> > Including a file digest cache in IMA, or implementing it as a
> > standalone piece of kernel functionality, are still options.  If you
> > want to pursue this, I would suggest that including the digest cache
> > as part of IMA would be the easier of the two options; if it proves to
> > be generally useful outside of IMA, it can always be abstracted out to
> > a general kernel module/subsystem.
>
> Ok. I thought about IPE and eBPF as potential users. But if you think
> that adding as part of IMA would be easier, I could try to pursue that.

It isn't clear to me how this would interact with IPE and/or eBPF, but
if you believe there is value there I would encourage you to work with
those subsystem maintainers.  If the consensus is that a general file
digest cache is useful then you should pursue the digest cache as a
kernel subsystem, just not a LSM.

--=20
paul-moore.com

