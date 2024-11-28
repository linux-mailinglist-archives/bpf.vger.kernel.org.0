Return-Path: <bpf+bounces-45783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFA89DB0B1
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC00A16653E
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 01:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E18A847B;
	Thu, 28 Nov 2024 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="CTQB3Df1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5831D1D554
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 01:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757053; cv=none; b=SrvVbo4Rqly++sK79fvVCxx8BPzoTVmMvQWOilzAEIeewZ0JTRCPoDBGffB2gqByS5IhZsqcv1B3+BvBkicCV8bWBeGEzPqrt/wkC8d/vqltJIRG8jHEdgQWRnK1rkiBDWVKEQEvHUmcTvFm7Zw4V6q95g18rl1zmnd01yuCY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757053; c=relaxed/simple;
	bh=dO2YZ8OYmhphHDYIkaJCfyrcz9tICWdHXLsJtC1ZJrY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mzm8D117dMQhf/rihW2w8u6Xu3T/1m8bv33OkSHMYV4dvGxO40KRmGZfsUO1k+z6tGkCqmRlV4onPpK4jQaVbNWA3cr/izRAnNLD4bHOTIbf1jVbf8Y00kMvnxDx7WJ0LP9EHPmc2T1gHy04k7jXD32kw0CRuUd9Rltgl3irX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=CTQB3Df1; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732757044; x=1733016244;
	bh=CMZ1ZPLUnv4ROtiqVMNhWDS4Nshz4Ma3iXrac27YodA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=CTQB3Df14e8XP4NMxLnDFgMRm4UJy66+m5KYufT5v7KCGnJ9kIX5XFipC+FAdS4Yg
	 HrDhj8iAZyB1a5XDDlPmIkiJCclslmGo9jNCFI6t83CUYTlG/JN3vPv5dUbo0+xRYC
	 rAsgwQw0eEeZkjTJskqwoWHXavBUd+uJqICYjT0o6fiLCIT9afgOVRfIl6f1vVeN89
	 NA/T9mcdTzEXZ3V7dRTY0LYZ/omUiiIvwKa58r/eEoTfp6omTYjCrTiBpIpKdEs8vV
	 m90EZ3RnxoMVoeLH3N5IuwCIGSJEZvMfJd5RUa8YlvUAFDampjlSBhh/hJGqfQtREs
	 qEQxdhCaKcptg==
Date: Thu, 28 Nov 2024 01:24:01 +0000
To: dwarves@vger.kernel.org, acme@kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com
Subject: [RFC PATCH 4/9] dwarf_loader: introduce pre_load_module hook to conf_load
Message-ID: <20241128012341.4081072-5-ihor.solodrai@pm.me>
In-Reply-To: <20241128012341.4081072-1-ihor.solodrai@pm.me>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: daced52fd4c9b7ee6ff90adabdc0a094151f4ffa
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
---
 dwarf_loader.c | 14 +++++++-------
 dwarves.h      | 11 +++++++++--
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 598fde4..5d55649 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3796,13 +3796,6 @@ static int cus__load_module(struct cus *cus, struct =
conf_load *conf,
 =09return DWARF_CB_OK;
 }
=20
-struct process_dwflmod_parms {
-=09struct cus=09 *cus;
-=09struct conf_load *conf;
-=09const char=09 *filename;
-=09uint32_t=09 nr_dwarf_sections_found;
-};
-
 static int cus__process_dwflmod(Dwfl_Module *dwflmod,
 =09=09=09=09void **userdata __maybe_unused,
 =09=09=09=09const char *name __maybe_unused,
@@ -3826,11 +3819,18 @@ static int cus__process_dwflmod(Dwfl_Module *dwflmo=
d,
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
 =09=09=09=09       parms->filename);
 =09}
+
 =09/*
 =09 * XXX We will fall back to try finding other debugging
 =09 * formats (CTF), so no point in telling this to the user
diff --git a/dwarves.h b/dwarves.h
index 1cb0d62..1a0bd4b 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -37,6 +37,7 @@
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(=
arr))
=20
 struct cu;
+struct cus;
=20
 enum load_steal_kind {
 =09LSK__KEEPIT,
@@ -59,6 +60,13 @@ typedef uint32_t type_id_t;
 struct btf;
 struct conf_fprintf;
=20
+struct process_dwflmod_parms {
+=09struct cus=09 *cus;
+=09struct conf_load *conf;
+=09const char=09 *filename;
+=09uint32_t=09 nr_dwarf_sections_found;
+};
+
 /** struct conf_load - load configuration
  * @thread_exit - called at the end of a thread, 1st user: BTF encoder ded=
up
  * @extra_dbg_info - keep original debugging format extra info
@@ -107,6 +115,7 @@ struct conf_load {
 =09struct conf_fprintf=09*conf_fprintf;
 =09int=09=09=09(*threads_prepare)(struct conf_load *conf, int nr_threads, =
void **thr_data);
 =09int=09=09=09(*threads_collect)(struct conf_load *conf, int nr_threads, =
void **thr_data, int error);
+=09int=09=09=09(*pre_load_module)(Dwfl_Module *mod, Elf *elf);
 };
=20
 /** struct conf_fprintf - hints to the __fprintf routines
@@ -168,8 +177,6 @@ struct conf_fprintf {
 =09uint8_t    skip_emitting_modifier:1;
 };
=20
-struct cus;
-
 struct cus *cus__new(void);
 void cus__delete(struct cus *cus);
=20
--=20
2.47.0



