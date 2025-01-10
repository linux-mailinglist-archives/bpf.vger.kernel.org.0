Return-Path: <bpf+bounces-48513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5671AA0855A
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 03:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB0C18884CA
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 02:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC46519DF6A;
	Fri, 10 Jan 2025 02:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="mwkIATfQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35F2BA33;
	Fri, 10 Jan 2025 02:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476310; cv=none; b=PrT9nR0BXsgEkH5SEFAWqioTcSiHq1mO/IIu/Iz0NzHceE9Lvrqv7TYXR6cAVFa/HGZwXWtdIjfjCxG2o+kbJoOwW4fCmLl9bLadSAnb3DVJtnFBEXhUFtnIhIcfm/uwm0p30JRMFHxi2C2Z7q9M684stWh0koBAQtUBuBjyWHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476310; c=relaxed/simple;
	bh=+hSL6KuUXW+zHSHiG32KgBafzWEYINIePMcEYF/FrqI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SZWaorLvmyxKa7wAaapFLl+0Wifh2fud6q/8uMb9JR5URrqIlv0WgyfphAVep2NSrGFAKI/WCY44bgK7n30+WU2SZXx5KdacSyI8NZSVuoNFn/MSOg8jgpyTAP8z3CIjMqLA36cEKomW6ZVQb9c4uRtOJh2NzgFfn8gH+3eBz9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=mwkIATfQ; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736476306; x=1736735506;
	bh=+hSL6KuUXW+zHSHiG32KgBafzWEYINIePMcEYF/FrqI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=mwkIATfQXv98bUGLuUxiuNPOfAfoNSigQau1lgp+mhgbArEAzbr6+OgmOMOf0HdPb
	 XwAqf1WFJcPnLlgOuF/f/D1dnTSGQGulDNHW6d/MMKU7Z7uTb0GJAmh0hZGiGF+tDN
	 dEPAS77DNWqnicOtrXC3iY4fkfOAcMk9krcqAaaHblo9yGVZteqiTxWvYKdfKROUqF
	 RkYNJrt/XjX8/RU+H5FAh6oaEEkows4hbcDb9h4GtmtsP56REtvXrWCzfluw6AJygM
	 J8wGHDsLU+x5TmviayA+WnAZrRj9MexSWj7wUOKXzxH0v4SIy4vhat+Uih8I08V40p
	 hZuE2WGug7zUg==
Date: Fri, 10 Jan 2025 02:31:41 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, olsajiri@gmail.com
Subject: [PATCH dwarves] btf_encoder: always initialize func_state to 0
Message-ID: <20250110023138.659519-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 5d3500962bc25d2be20edd0309a476285d2b9c13
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

BPF CI caught a segfault on aarch64 and s390x [1] after recent merges
into the master branch.

The segfault happened at free(func_state->annots) in
btf_encoder__delete_saved_funcs().

func_state->annots arrived there uninitialized because after patch [2]
in some cases func_state may be allocated with a realloc, but was not
zeroed out.

Fix this bug by always memset-ing a func_state to zero in
btf_encoder__alloc_func_state().

[1] https://github.com/kernel-patches/bpf/actions/runs/12700574327
[2] https://lore.kernel.org/dwarves/20250109185950.653110-11-ihor.solodrai@=
pm.me/
---
 btf_encoder.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 78efd70..511c1ea 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1083,7 +1083,7 @@ static bool funcs__match(struct btf_encoder_func_stat=
e *s1,
=20
 static struct btf_encoder_func_state *btf_encoder__alloc_func_state(struct=
 btf_encoder *encoder)
 {
-=09struct btf_encoder_func_state *tmp;
+=09struct btf_encoder_func_state *state, *tmp;
=20
 =09if (encoder->func_states.cnt >=3D encoder->func_states.cap) {
=20
@@ -1100,7 +1100,10 @@ static struct btf_encoder_func_state *btf_encoder__a=
lloc_func_state(struct btf_e
 =09=09encoder->func_states.array =3D tmp;
 =09}
=20
-=09return &encoder->func_states.array[encoder->func_states.cnt++];
+=09state =3D &encoder->func_states.array[encoder->func_states.cnt++];
+=09memset(state, 0, sizeof(*state));
+
+=09return state;
 }
=20
 static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct =
function *fn, struct elf_function *func)
--=20
2.47.1



