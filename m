Return-Path: <bpf+bounces-41747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CAA99A7BE
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 17:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47268285177
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 15:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E746194C8F;
	Fri, 11 Oct 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="YZfKJeXM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A4A198857
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660676; cv=none; b=RUemHYbDbFUms8X8uAoqAmANGfVgJtij2s2Cmft5CH+OdzjKFKCQajQ1v4fXrrd/tOBIjHWuwYSOf8qB5weQGkmJmocnXiQtWIz2gCPJlSJQAMbtkMkrOh/nnr2Ifseo7FJUtdFNenX3MQpkvV9FxH1guhqdmAeCS8mcqNUYaVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660676; c=relaxed/simple;
	bh=3r2pcaWaw9rJIV8l2A5MXQasSzCK+8nOmCvKdhGYHbI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=i2tdEON5SW0SB/mUYYasNQEhFnfR1gst0+qIsEDYhohEwn9rqptkc4JWp8PT8UxUatS0bC1fcRgW8nl6BYFx+pz4B2NVYSrGWe2htUh2OP3xdb7pf4fKvu1lJ0tQX/Oi93kW/9fRQt+lusCuKfz/oscLugoYRPMyO25/qqSP8To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=YZfKJeXM; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728660672; x=1728919872;
	bh=kCy9Q0bx6t2zL/dmk6em3rRF+ZXGhn61YEyPAYEjHuk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=YZfKJeXMsKJq6xnin3USUhyJT5gs+pVAsoZG1wmQKEu0CApwaf/0LFmk+24Lg/j3G
	 QRbLLB47HNUg89zIXGmNtWrUfO9jt4Q03fRhrMQgKDZfVOveph7ozYC7PWlNcbBg8J
	 MlkFDSMsRJ3Rxv9Dt+P5AHZgNDzQ2pOMivbL7QJOavmohNxei0zgEtOxE0oGuqUTwW
	 L/XELUIAxWhtXn4x+PFVR6mojXosbzYh+K41qbLd+US07mWZvtXItoEOtGCEE2xYuC
	 yfWZjHOWGG+/OP0L46VG2BrZVqqpsoyIWeagYa7fSF8gHt5ENNEYD1wCXXBD40ljf9
	 mtFmJ7UpMMDJA==
Date: Fri, 11 Oct 2024 15:31:07 +0000
To: bpf@vger.kernel.org, andrii@kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com
Subject: [PATCH v2 bpf-next] selftests/bpf: check for timeout in perf_link test
Message-ID: <20241011153104.249800-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 84ebed1c8886c65295a768c07e42b920429d3a18
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

v1: https://lore.kernel.org/bpf/zuRd072x9tumn2iN4wDNs5av0nu5nekMNV4PkR-YwCT=
10eFFTrUtZBRkLWFbrcCe7guvLStGQlhibo8qWojCO7i2-NGajes5GYIyynexD-w=3D@pm.me/

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 .../testing/selftests/bpf/prog_tests/perf_link.c  | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/tes=
ting/selftests/bpf/prog_tests/perf_link.c
index 3a25f1c743a1..d940ff87fa08 100644
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
@@ -32,6 +36,7 @@ void serial_test_perf_link(void)
 =09int run_cnt_before, run_cnt_after;
 =09struct bpf_link_info info;
 =09__u32 info_len =3D sizeof(info);
+=09__u64 timeout_time_ns;
=20
 =09/* create perf event */
 =09memset(&attr, 0, sizeof(attr));
@@ -63,8 +68,14 @@ void serial_test_perf_link(void)
 =09ASSERT_GT(info.prog_id, 0, "link_prog_id");
=20
 =09/* ensure we get at least one perf_event prog execution */
-=09burn_cpu();
-=09ASSERT_GT(skel->bss->run_cnt, 0, "run_cnt");
+=09timeout_time_ns =3D get_time_ns() + BURN_TIMEOUT_NS;
+=09while (true) {
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
2.43.0



