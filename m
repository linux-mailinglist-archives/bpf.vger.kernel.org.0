Return-Path: <bpf+bounces-41663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD0A9995B6
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 01:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A9DBB22B66
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 23:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5151E503C;
	Thu, 10 Oct 2024 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="dbJINnDo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFEE63D
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728602657; cv=none; b=tnacU6al0eDKmkI+YxlVCKD7WJnRhFc+QXKGA7oSP68DPDXmBWAbmMAaSNnXXes935tmyV/5X/muPiF7EFT2hfknwQ0I+lWaxePQJv4U6L7T312Plv2BkGzGYihs4bFBzVA1DAkHZr+3LUIPd7UIQlXotvMWBJf2gfaS4/FoMRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728602657; c=relaxed/simple;
	bh=5cSe4myE8z2L+cal84gv1DysvI9xnLoSvwWQVKNorXc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Boyr6PPLAkdgbhCwguSGE4ZC1QzbLv0i0QC+SiU6vvePUlflc6rQIBBDqwZCUhm5xzx7hXFD3cRsi33KnRzAdztfd5OiY9FKkxQBbFHA5ukl7e0q6Kmt9JppjDaSGOmFrTwMQEPrx3rwjixLKZxdiXUdD6FXw6fsmKVhakVPW0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=dbJINnDo; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728602653; x=1728861853;
	bh=YCyrl5cnQ8dMH9AZMYZhC2CD+abZk/CnSzonmfWHIEY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dbJINnDogeD83nI9nQCyr1C5nAwgOEcUaUlcfg+bBWhTNHtIOgGhl5RkarH0cPaQF
	 JYihhPjnID6IscTBGnyl1hX1vXulZfe+0N/PYReoJEHhqJmZgbBbnoSzGE1vQ+CDKF
	 jgm0LcllYMjkH2Hlrn5fjr7nDD12cFu5Oj2aB8GFtezNomBnbWFNLD7iKBhv0w+15h
	 B825QYkl3vbJEZ7qxbdwq9OUkQMFfCVk6o0ssn2BroIN8V8r2O2g8/jplxf6AiOpq5
	 FfpiV0sL7AiAcIGwgyDKtxh2gUQPUsOnFSHCsCFXtC8BI2yqbgX/9c/XssfLqIf0ob
	 5ZwEW/PCwguIA==
Date: Thu, 10 Oct 2024 23:24:10 +0000
To: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, "eddyz87@gmail.com" <eddyz87@gmail.com>, "mykolal@fb.com" <mykolal@fb.com>
Subject: [PATCH] selftests/bpf: check for timeout in perf_link test
Message-ID: <zuRd072x9tumn2iN4wDNs5av0nu5nekMNV4PkR-YwCT10eFFTrUtZBRkLWFbrcCe7guvLStGQlhibo8qWojCO7i2-NGajes5GYIyynexD-w=@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: d4193ac97da1a6f54de763410e304dece97a3896
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Recently perf_link test started unreliably failing on libbpf CI:
  * https://github.com/libbpf/libbpf/actions/runs/11260672407/job/313124054=
73
  * https://github.com/libbpf/libbpf/actions/runs/11260992334/job/313155146=
26
  * https://github.com/libbpf/libbpf/actions/runs/11263162459/job/313204582=
51

Part of the test is running a dummy loop for a while and then checking
for a counter incremented by the test program.

Instead of waiting for an arbitrary number of loop iterations once,
check for the test counter in a loop and use get_time_ns() helper to
enforce a 100ms timeout.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 tools/testing/selftests/bpf/prog_tests/perf_link.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/tes=
ting/selftests/bpf/prog_tests/perf_link.c
index 3a25f1c743a1..c1f13d77c464 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c
@@ -4,8 +4,12 @@
 #include <pthread.h>
 #include <sched.h>
 #include <test_progs.h>
+#include "testing_helpers.h"
 #include "test_perf_link.skel.h"
=20
+#define BURN_TIMEOUT_MS 100
+#define BURN_TIMEOUT_NS BURN_TIMEOUT_MS * 1000000
+
 static void burn_cpu(void)
 {
 =09volatile int j =3D 0;
@@ -63,8 +67,14 @@ void serial_test_perf_link(void)
 =09ASSERT_GT(info.prog_id, 0, "link_prog_id");
=20
 =09/* ensure we get at least one perf_event prog execution */
-=09burn_cpu();
-=09ASSERT_GT(skel->bss->run_cnt, 0, "run_cnt");
+=09__u64 timeout_time_ns =3D get_time_ns() + BURN_TIMEOUT_NS;
+=09while (1) {
+=09=09burn_cpu();
+=09=09if (skel->bss->run_cnt > 0)
+=09=09=09break;
+=09        if (!ASSERT_LT(get_time_ns(), timeout_time_ns, "run_cnt_timeout=
"))
+=09=09=09break;
+=09}
=20
 =09/* perf_event is still active, but we close link and BPF program
 =09 * shouldn't be executed anymore
--=20
2.39.5 (Apple Git-154)


