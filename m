Return-Path: <bpf+bounces-46925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA59E9F1930
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586FC188736C
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69ED1A256C;
	Fri, 13 Dec 2024 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="NHKNelZ9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054D31990D3;
	Fri, 13 Dec 2024 22:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734129425; cv=none; b=Mbu+9LHAEcUbiBC/URErsahixwD7aXviEc6148yJIeN8R5Gh0o6qx29v+hDqcw5zVWT5XR54830yX87KWht4sI2219kefiThtVl7yCRnzlwtUn6Da4Y7/6d4h0ffAWEqoM/5ozGdCqF0BdIQpLNb3FSz2HXDW9h6IKmnPvh+XM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734129425; c=relaxed/simple;
	bh=A2a4Ldvpll5bCWtdKfOG8YY8YVuUxVCp2YNfhbyD/go=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddMowZoaomb3WlIvgNv+KRCM3fnvq4BhjjtWzNDbIzbL1Mcn5hhPwFxYmLKa+S7z+5cQyXVGiCfErIKSFlvKg0YuPZO3lJBQcvPY0951WEvc+pnO/ouY8It552byNypWjGjJh949+VRK28pfPbcNwsvDTLZJskFFY+vRSV4HMAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=NHKNelZ9; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734129422; x=1734388622;
	bh=mYamh3KEopaOW6Zl4U77Z5DPeZtYrRhP282/+JVgN4A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=NHKNelZ9P9p5YmGN10RNGfVzmtPtIw26Nfm7ysOXPIC+AMMbG5QwLazCcAV65CCNs
	 ZQspPYSZiN3UK44BZq9imN+0jXOrHz1K7Khg5oNkt0zgGUivEeGea9L5uSk0YuA2Zg
	 HXFKt9hfEB5i5bPKPBiUFyYGZ9sZe1OctlTff7+AlVdJB3RzWx87XE5Ic2qbbeXhnA
	 LzTnGBT/RnLEM9YaujTTI9tiUI0/NEd5ehkD8DmT1+wmjNT7Abx1F8LYSxW1Lz8TN2
	 hcT5b3VtwtUb0kJyVJVf9Obbgk0AOstd6n1Z516ZBxhWRm4nljCirPgbdBntQleWCb
	 dsi/nvyIxEOkw==
Date: Fri, 13 Dec 2024 22:36:57 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: [PATCH dwarves v2 03/10] dwarf_loader: introduce pre_load_module hook to conf_load
Message-ID: <20241213223641.564002-4-ihor.solodrai@pm.me>
In-Reply-To: <20241213223641.564002-1-ihor.solodrai@pm.me>
References: <20241213223641.564002-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: d8193fac4a1ded6a149528db7e1892ad3e30154a
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add a function pointer to conf_load, which is called immediately after
Elf is extracted from Dwfl_Module in cus__proces_dwflmod.

This is a preparation for making elf_functions table shared between
encoders. Shared table can be built as soon as the relevant Elf is
available.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

Link: https://lore.kernel.org/dwarves/20241128012341.4081072-5-ihor.solodra=
i@pm.me/
---
 dwarf_loader.c | 6 ++++++
 dwarves.h      | 1 +
 2 files changed, 7 insertions(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 598fde4..bd65c56 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3826,6 +3826,12 @@ static int cus__process_dwflmod(Dwfl_Module *dwflmod=
,
 =09Dwarf *dw =3D dwfl_module_getdwarf(dwflmod, &dwbias);
=20
 =09int err =3D DWARF_CB_OK;
+=09if (parms->conf->pre_load_module) {
+=09=09err =3D parms->conf->pre_load_module(dwflmod, elf);
+=09=09if (err)
+=09=09=09return DWARF_CB_ABORT;
+=09}
+
 =09if (dw !=3D NULL) {
 =09=09++parms->nr_dwarf_sections_found;
 =09=09err =3D cus__load_module(cus, parms->conf, dwflmod, dw, elf,
diff --git a/dwarves.h b/dwarves.h
index 1cb0d62..d516d52 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -107,6 +107,7 @@ struct conf_load {
 =09struct conf_fprintf=09*conf_fprintf;
 =09int=09=09=09(*threads_prepare)(struct conf_load *conf, int nr_threads, =
void **thr_data);
 =09int=09=09=09(*threads_collect)(struct conf_load *conf, int nr_threads, =
void **thr_data, int error);
+=09int=09=09=09(*pre_load_module)(Dwfl_Module *mod, Elf *elf);
 };
=20
 /** struct conf_fprintf - hints to the __fprintf routines
--=20
2.47.1



