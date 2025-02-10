Return-Path: <bpf+bounces-51048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005E0A2FA85
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 21:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE1C18835AD
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 20:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF32260A5F;
	Mon, 10 Feb 2025 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhVMwDcM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44863260A42;
	Mon, 10 Feb 2025 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219255; cv=none; b=NSlp5irQI4Xo/bRKyjHKo/R8gtPpk//1SwnR4yoRWSs3T81qibcmDaNtpchU/zLDaoSp1utVdn34PMpBty38gG2HriVI0K2eCmo7jueDnvnBoOoJwZr0Z1q32QQMECJgdC8IMcWU6K5z7mK3jeRtGB3CJZll7L317K2BxPxWJPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219255; c=relaxed/simple;
	bh=cL+PKhmX30jHbo2cscQxptMC1LXNOM5ta/EiQGb3AxA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoCkurhwiiUWiERu4IvQntM5QJD1mhEEDJ5te0iJ9k76LiP7Wuvw5vLYmsXpAyLxbRtAzvQT3WNZzeriLCTIB6XQbql/zIKvEnFS4I1HHn5RL8omoEcXJoS8r1BUE8DMxftlIeHjd7HuBgTO/ldZOx8xpSk68pyAARlTYE9NCTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhVMwDcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76950C2BCF6;
	Mon, 10 Feb 2025 20:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739219254;
	bh=cL+PKhmX30jHbo2cscQxptMC1LXNOM5ta/EiQGb3AxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jhVMwDcM9/SfG7eKGrJ0NOuLx75OH78xOzvUpR+PFUGHM8v+dPoeQuEDegreBWCEC
	 ytY3qgn2rLt5QA4dVE1Xiu9e32yq7huQ4DFtL7olXxN6buNmlGeo1bfH5XsSR3+Pww
	 MGbEkDiwKDUIxyT6VwJz5/wjAmC8r6dpHDx1afCb7BDarebp36qgepsjiO+D9xnfR0
	 LJsk1JF2OmG52TgcGkTeN7HcTM2vardQlhBSpFVDy9YMgGsSk/DJYW2pbE+bGsjAWO
	 4ymoWJ3ctbLei7RMhAsVu/lFtCSzoDkXgDhSdNbRINaHNVt0MtEy2Y8dtf3YsCCVu1
	 c5NTpup6CIKBQ==
Date: Mon, 10 Feb 2025 21:27:28 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 James Clark <james.clark@linaro.org>, Johannes Berg
 <johannes@sipsolutions.net>, Mike Leach <mike.leach@linaro.org>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Tony Luck <tony.luck@intel.com>,
 bpf@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-hardening@vger.kernel.org,
 linux-wireless@vger.kernel.org
Subject: Re: [PATCH 00/27] Improve ABI documentation generation
Message-ID: <20250210212728.64667005@foz.lan>
In-Reply-To: <87h651zm7d.fsf@trenco.lwn.net>
References: <cover.1739182025.git.mchehab+huawei@kernel.org>
	<87h651zm7d.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Em Mon, 10 Feb 2025 11:30:46 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>=20
> > Hi Jon/Greg,
> >
> > This series replace get_abi.pl with a Python version.
> >
> > I originally started it due to some issues I noticed when searching for
> > ABI symbols. While I could just go ahead and fix the already existing
> > script, I noticed that the script maintainance didn't have much care ov=
er
> > all those years, probably because it is easier to find Python programme=
rs
> > those days.
> >
> > Also, the code is complex and was not using modules or classes and
> > were using lots of global variables.
> >
> > So, I decided to rewrite it in Python. I started with a manual conversi=
on
> > for each function. Yet, to avoid future maintainership issues, I opted =
to
> > divide the main code on three classes, each on a sepaparate file.
> >
> > Just like the original RFC, I opted to keep the Sphinx kernel-abi module
> > on three different phases:
> >
> > - call get_abi.py as an exec file;
> > - import AbiParser on a minimal integration scenario;
> > - cleanup the code to avoid needing to parse line numbers from the text.
> >
> > This way, if something goes wrong, it would be easier to just revert any
> > offending patches, It also provides a better rationale about what each
> > logical change is doing.
> >
> > The initial patches on this series do some preparation work and
> > cleans some ABI symbol bugs that lack ":" delimiter.
> >
> > I opted to place on this series the Sphinx and Python version updates.
> >
> > I still have ~10 patches here with additional cleanups, from the origin=
al
> > series I sent as RFC but let's get the main changes merged first. =20
>=20
> OK, I have applied this set - it seems to work for me, though it does
> lead to some changes in the organization of
> Documentation/admin-guide/abi.html in the output.

Yes. I moved the files part to separate files, as IMHO this would
make easier for people to navigate.
=20
> It would be nice if, eventually, we could put the README link up at the
> top rather than under "ABI file",

Moving its position is not hard: all we need to do is to change abi.rst
file. See the enclosed patch.

> or even just include its contents
> there directly.


>=20
> Anyway, let's see how this goes :)
>=20
> Thanks,
>=20
> jon

Thanks,
Mauro

=46rom e1b864d1d333d94430420d1d6fc15ea7d8a99b4b Mon Sep 17 00:00:00 2001
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Mon, 10 Feb 2025 21:24:06 +0100
Subject: [PATCH] docs: ABI: move README contents to the top

The ABI documentation looks a little bit better if it starts
with the contents of the README is placed at the beginning.

Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/Documentation/admin-guide/abi-readme-file.rst b/Documentation/=
admin-guide/abi-readme-file.rst
deleted file mode 100644
index 6172e4ccbda2..000000000000
--- a/Documentation/admin-guide/abi-readme-file.rst
+++ /dev/null
@@ -1,6 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-ABI README
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-.. kernel-abi:: README
diff --git a/Documentation/admin-guide/abi.rst b/Documentation/admin-guide/=
abi.rst
index 15a2dcb1388c..2067336353ae 100644
--- a/Documentation/admin-guide/abi.rst
+++ b/Documentation/admin-guide/abi.rst
@@ -4,6 +4,11 @@
 Linux ABI description
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
+ABI README
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+.. kernel-abi:: README
+
 ABI symbols
 -----------
=20
@@ -21,7 +26,6 @@ ABI files
 .. toctree::
    :maxdepth: 2
=20
-   abi-readme-file
    abi-stable-files
    abi-testing-files
    abi-obsolete-files


