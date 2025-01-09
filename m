Return-Path: <bpf+bounces-48433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 732F9A07FFE
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 19:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 593C07A0647
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 18:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCE01F12FB;
	Thu,  9 Jan 2025 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="mnukIzX0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE8C13B2B8;
	Thu,  9 Jan 2025 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447952; cv=none; b=CJKlOobyG4Hwk66qZHoGe46SscD1qTKwkyeOQpcciK1iTzIOwhxu+DP2YVoNyialEwFQAecEGo3xB+ALZmQ1fWTSHCvwTeGDD2tSusVAft3Z4AyeZxI/Ht4grtLmwziI40iRHMXTsy3iEZS5DmTPNkyPTpHXKGOmeoYEPD0WYjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447952; c=relaxed/simple;
	bh=Uqguwk6vRTLLu0UvlALj7dGIMZqrlLLKeZF+pZojY88=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKBEKtRw2SPHttljjUSgrNVC2ssMfYdv2Fgej4dlQlAcv+sRBzTHvuE1ZrVwFlIcF5YP3EBP7iAmxAyb3KXz0sDAwxDfaAQG30rS5vfWurKoKSTWYNfoDyPpvhjzBeYmaVmYnn8xAXPhkHwTlFO+Az3VMwhAfc1rEhVEePIYlco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=mnukIzX0; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736447942; x=1736707142;
	bh=jdFbmQfhoi87Zmc4TZfB0tjtp2G/whz+Y+rKJCOL0iw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=mnukIzX0TSc5CvCJ/n2C/KXforWzucIbPHXr9dQuibM8eiNZ4ccfVqWmYuNp+LxHd
	 7b6XRYb8DvHaWV6MJ5O2t68dYDHj5/VPgGka4rxpgC4kcEuwRo+5Q6TJMCDzdjYAX9
	 Mw4YCThlwVdzeOj6/lq7ebHH2+y7wdW5XZ87T26Ow1sXex+M+xrVi6Vjd+yTwJnDqf
	 5oCr9opgD+SC21ZB1dhBmFBpBoFbsROscdGrLggZW0zmJvOrG7dgtaYoJzAu5Ikbup
	 iKHgjxrS27HyDTckZxusaQd2g+8uoo82S3WHhAry6ItZC3sQ39wWnBrEhLEtv8+BQs
	 cqJuH2bElKRtw==
Date: Thu, 09 Jan 2025 18:38:57 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, olsajiri@gmail.com
Subject: Re: [PATCH dwarves v4 00/10] pahole: faster reproducible BTF encoding
Message-ID: <0gG5e2QvD6I6CuApCVn4O0ph5_k_fnKodGP2wGhm6oxiLKh5A_v1mTeezCjU_oEwQxUwRMN9yycf5xbLfIviTlAg-qm6dxHK-PkgVTFDLQ8=@pm.me>
In-Reply-To: <Z4AWJBNsGJvBU7ZY@x1>
References: <20250107190855.2312210-1-ihor.solodrai@pm.me> <Z4AWJBNsGJvBU7ZY@x1>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: e1ecc08df1ea92fe1008dc88ff19307cc62b00f4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, January 9th, 2025 at 10:32 AM, Arnaldo Carvalho de Melo <acme@=
kernel.org> wrote:

>=20
>=20
> On Tue, Jan 07, 2025 at 07:08:59PM +0000, Ihor Solodrai wrote:
>=20
> > This is v4 of the series aiming to speed up parallel reproducible BTF
> > encoding. This version mostly addresses feedback from Jiri Olsa on v3.
>=20
>=20
> b4 is having trouble with this series, I'm trying to cherry pick
> things...

Sorry, I think I messed up some patches with manual changes before submitti=
ng.
I'll resend a clean series in a bit.

Thanks.

>=20
> =E2=AC=A2 [acme@toolbox pahole]$ b4 am -ctsl --cc-trailers 20250107190855=
.2312210-1-ihor.solodrai@pm.me
> Grabbing thread from lore.kernel.org/all/20250107190855.2312210-1-ihor.so=
lodrai@pm.me/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 13 messages in the thread
> WARNING: duplicate messages found at index 1
> Subject 1: dwarf_loader: multithreading with a job/worker model
> Subject 2: btf_encoder: simplify function encoding
> 2 is not a reply... assume additional patch
> Assuming new revision: v2 ([PATCH dwarves v4] btf_encoder: switch func_st=
ates from a list to an array)
> Will use the latest revision: v4
> You can pick other revisions using the -vN flag
> Checking attestation on all messages, may take a moment...
> ---
> =E2=9C=97 [PATCH v4] dwarf_loader: multithreading with a job/worker model
> =E2=9C=97 BADSIG: DKIM/pm.me
> + Link: https://lore.kernel.org/r/20250107190855.2312210-9-ihor.solodrai@=
pm.me
> + Signed-off-by: Arnaldo Carvalho de Melo acme@redhat.com
>=20
> =E2=9C=97 [PATCH v4 1/10] btf_encoder: simplify function encoding
> =E2=9C=97 BADSIG: DKIM/pm.me
> + Acked-by: Eduard Zingerman eddyz87@gmail.com (=E2=9C=97 DKIM/gmail.com)
>=20
> + Acked-by: Jiri Olsa jolsa@kernel.org (=E2=9C=97 DKIM/gmail.com)
>=20
> + Link: https://lore.kernel.org/r/20250107190855.2312210-2-ihor.solodrai@=
pm.me
> + Signed-off-by: Arnaldo Carvalho de Melo acme@redhat.com
>=20
> =E2=9C=97 [PATCH v4 3/10] btf_encoder: separate elf function, saved funct=
ion representations
> =E2=9C=97 BADSIG: DKIM/pm.me
> + Link: https://lore.kernel.org/r/20250107190855.2312210-4-ihor.solodrai@=
pm.me
> + Signed-off-by: Arnaldo Carvalho de Melo acme@redhat.com
>=20
> =E2=9C=97 [PATCH v4 4/10] btf_encoder: introduce elf_functions struct typ=
e
> =E2=9C=97 BADSIG: DKIM/pm.me
> + Link: https://lore.kernel.org/r/20250107190855.2312210-5-ihor.solodrai@=
pm.me
> + Signed-off-by: Arnaldo Carvalho de Melo acme@redhat.com
>=20
> =E2=9C=97 [PATCH v4 5/10] btf_encoder: introduce elf_functions_list
> =E2=9C=97 BADSIG: DKIM/pm.me
> + Link: https://lore.kernel.org/r/20250107190855.2312210-6-ihor.solodrai@=
pm.me
> + Signed-off-by: Arnaldo Carvalho de Melo acme@redhat.com
>=20
> =E2=9C=97 [PATCH v4 6/10] btf_encoder: remove skip_encoding_inconsistent_=
proto
> =E2=9C=97 BADSIG: DKIM/pm.me
> + Link: https://lore.kernel.org/r/20250107190855.2312210-7-ihor.solodrai@=
pm.me
> + Signed-off-by: Arnaldo Carvalho de Melo acme@redhat.com
>=20
> =E2=9C=97 [PATCH v4 7/10] dwarf_loader: introduce cu->id
>=20
> =E2=9C=97 BADSIG: DKIM/pm.me
> + Link: https://lore.kernel.org/r/20250107190855.2312210-8-ihor.solodrai@=
pm.me
> + Signed-off-by: Arnaldo Carvalho de Melo acme@redhat.com
>=20
> ERROR: missing [8/10]!
> =E2=9C=97 [PATCH v4 9/10] btf_encoder: clean up global encoders list
> =E2=9C=97 BADSIG: DKIM/pm.me
> + Link: https://lore.kernel.org/r/20250107190855.2312210-10-ihor.solodrai=
@pm.me
> + Signed-off-by: Arnaldo Carvalho de Melo acme@redhat.com
>=20
> ERROR: missing [10/10]!
> ERROR: missing [11/10]!
> ---
> Total patches: 8
> ---
> WARNING: Thread incomplete!
> Cover: ./v4_20250107_ihor_solodrai_pahole_faster_reproducible_btf_encodin=
g.cover
> Link: https://lore.kernel.org/r/20250107190855.2312210-1-ihor.solodrai@pm=
.me
> Base: not specified
> git am ./v4_20250107_ihor_solodrai_pahole_faster_reproducible_btf_encodin=
g.mbx
> =E2=AC=A2 [acme@toolbox pahole]$
>=20
> > A notable adition is a patch 10/10, which changes func_states in
> > btf_encoder from a list to an array.
>=20
>=20
> 

