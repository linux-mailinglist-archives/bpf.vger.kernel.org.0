Return-Path: <bpf+bounces-48003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A7AA0315F
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 21:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C8116495E
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 20:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155341DF26F;
	Mon,  6 Jan 2025 20:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="gDbU5YkM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020FA1CEADF
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736195246; cv=none; b=BT+8tAWYFpXOIwVGtVOfvoajZmXjKJGFK5s4iah2n8VrWZTokganZjARJeUwnDj7Pa1tP28JNaqW2COsWwzqUSlb7vYWSAwqe3oaEE4FKi6VKDewjwleyszLVq3HkR0sGYakaRiWuqoLB0+gA200Nw9lfsbUiyuo/+cCbB8UvgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736195246; c=relaxed/simple;
	bh=OyB8SsTRo50wz8in/n23HryNqaxVrzRPp5j5ytnoMSQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=c9gbuococLr8V/0zx3oq9KmA1NR/7meN1tLl8GK78/ElhT1Ny+wrI4pin8fu9qHhDmphsv0AQiZsaNUYJ8iKmmwWCCs7ovBpP3Q2ciMyebmsEdbc27+mV6AZSnvt1J3DYxb5XI4wx9E/O5poCceNuMiciaWJ+f6EiCBWyOeuyts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=gDbU5YkM; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736195242; x=1736454442;
	bh=OyB8SsTRo50wz8in/n23HryNqaxVrzRPp5j5ytnoMSQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=gDbU5YkM9LJfHFGN4BLLR1tHyz3wbgWrIAPqhE76d52L5HhTArIN9+OCwtKoLo43O
	 Q3d3L1zGC/ib9QUEcv/UmJIJSCBlFWVRY4orx9zuFOuXi3Ob8ZglSw4Hy/KV85t0Sc
	 kcMJOGE7JdfjREun99hpDdFJNvzoROIKxA9kx7sT5cX5lOXTYAxZPmdaiR8tPLzdBl
	 iK7ksiSfVVyB6Pl+o7T7TnBmlNrwdIoCjh5kQTlFtcPDtwJqhbrtkoO5D8CrUbOkqc
	 ra0ZKPenwXt4AQ0XFc7xAlErPnBlUv6DSe785BdTSd3+MhgV4bR/qtEiwgqGTB1Ad3
	 Y+cm0MqiQKlGA==
Date: Mon, 06 Jan 2025 20:27:18 +0000
To: bpf@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, jose.marchesi@oracle.com
Subject: [PATCH bpf-next] selftests/bpf: add -std=gnu17 to GCC BPF build rule
Message-ID: <20250106202715.1232864-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: aba6cd6ace910c6c0e8ee7ceee8bb9b4381ccf00
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Latest versions of GCC BPF use C23 standard by default. This causes
compilation errors in vmlinux.h due to bool types declarations.

Pass -std=3Dgnu17 when building selftests BPF objects with GCC.

For more details see the discussion at [1].

[1] https://lore.kernel.org/bpf/EYcXjcKDCJY7Yb0GGtAAb7nLKPEvrgWdvWpuNzXm2qi=
6rYMZDixKv5KwfVVMBq17V55xyC-A1wIjrqG3aw-Imqudo9q9X7D7nLU2gWgbN0w=3D@pm.me/

CC: Jose E. Marchesi <jose.marchesi@oracle.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index d5be2f94deef..d81bb4773cb7 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -479,9 +479,10 @@ define CLANG_CPUV4_BPF_BUILD_RULE
 =09$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=3Dv4 -o $2
 endef
 # Build BPF object using GCC
+GCC_BPF_CFLAGS +=3D -std=3Dgnu17 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attri=
butes
 define GCC_BPF_BUILD_RULE
 =09$(call msg,GCC-BPF,$4,$2)
-=09$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c=
 $1 -o $2
+=09$(Q)$(BPF_GCC) $3 -O2 $(GCC_BPF_CFLAGS) -c $1 -o $2
 endef
=20
 SKEL_BLACKLIST :=3D btf__% test_pinning_invalid.c test_sk_assign.c
--=20
2.47.1



