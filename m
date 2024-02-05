Return-Path: <bpf+bounces-21196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BA2849357
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 06:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D696281E2B
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 05:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A7CB66C;
	Mon,  5 Feb 2024 05:29:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED05B665
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 05:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707110970; cv=none; b=jujWnYvD7nnfGvx1aUlhBcXxKRHnKQIdQeJzDbXi7CYb4c8nQkPdTc5t9zjGx2jkZn2rcayTu7AhBLpZLC7vDYwP4325ne4Y+acfEHV2nIFenYErR5P/xLRYkqsQ8S4alBuB0jjY78a9swoMjlXwJxUsHBqN51Zw9hKrt1xGlKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707110970; c=relaxed/simple;
	bh=KllKaCi4f1P98OOfR21Jfg8/4z7FJ0ky1Ew+uTBwm98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r4I69s2G4pUe2iNKOEOdQM/HOpek4SbjLnK8NMF+JVlNrn2o3vwpVRpeoHVWIJyzEOX8WpyQFwTTBvcGpHTVIStG8TKfUaWeCNKRduxFoOk7Yw+F52eJBChgYhV/gDihHeMjU9sgkZzvmbdeIg0X6n60592NAqFMnB36ndyjxlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 6704D2D5D5D8F; Sun,  4 Feb 2024 21:29:14 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix flaky selftest lwt_redirect/lwt_reroute
Date: Sun,  4 Feb 2024 21:29:14 -0800
Message-Id: <20240205052914.1742687-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Recently, when running './test_progs -j', I occasionally hit the
following errors:

  test_lwt_redirect:PASS:pthread_create 0 nsec
  test_lwt_redirect_run:FAIL:netns_create unexpected error: 256 (errno 0)
  #142/2   lwt_redirect/lwt_redirect_normal_nomac:FAIL
  #142     lwt_redirect:FAIL
  test_lwt_reroute:PASS:pthread_create 0 nsec
  test_lwt_reroute_run:FAIL:netns_create unexpected error: 256 (errno 0)
  test_lwt_reroute:PASS:pthread_join 0 nsec
  #143/2   lwt_reroute/lwt_reroute_qdisc_dropped:FAIL
  #143     lwt_reroute:FAIL

The netns_create() definition looks like below:

  #define NETNS "ns_lwt"
  static inline int netns_create(void)
  {
        return system("ip netns add " NETNS);
  }

One possibility is that both lwt_redirect and lwt_reroute create
netns with the same name "ns_lwt" which may cause conflict. I tried
the following example:
  $ sudo ip netns add abc
  $ echo $?
  0
  $ sudo ip netns add abc
  Cannot create namespace file "/var/run/netns/abc": File exists
  $ echo $?
  1
  $

The return code for above netns_create() is 256. The internet search
suggests that the return value for 'ip netns add ns_lwt' is 1, which
matches the above 'sudo ip netns add abc' example.

This patch tried to use different netns names for two tests to avoid
'ip netns add <name>' failure.

I ran './test_progs -j' 10 times and all succeeded with
lwt_redirect/lwt_reroute tests.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/lwt_helpers.h  | 2 --
 tools/testing/selftests/bpf/prog_tests/lwt_redirect.c | 1 +
 tools/testing/selftests/bpf/prog_tests/lwt_reroute.c  | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h b/tools=
/testing/selftests/bpf/prog_tests/lwt_helpers.h
index e9190574e79f..fb1eb8c67361 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
@@ -27,8 +27,6 @@
 			}                                                     \
 	})
=20
-#define NETNS "ns_lwt"
-
 static inline int netns_create(void)
 {
 	return system("ip netns add " NETNS);
diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c b/tool=
s/testing/selftests/bpf/prog_tests/lwt_redirect.c
index b5b9e74b1044..835a1d756c16 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
@@ -54,6 +54,7 @@
 #include <stdbool.h>
 #include <stdlib.h>
=20
+#define NETNS "ns_lwt_redirect"
 #include "lwt_helpers.h"
 #include "test_progs.h"
 #include "network_helpers.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c b/tools=
/testing/selftests/bpf/prog_tests/lwt_reroute.c
index 5610bc76928d..03825d2b45a8 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
@@ -48,6 +48,7 @@
  *  For case 2, force UDP packets to overflow fq limit. As long as kerne=
l
  *  is not crashed, it is considered successful.
  */
+#define NETNS "ns_lwt_reroute"
 #include "lwt_helpers.h"
 #include "network_helpers.h"
 #include <linux/net_tstamp.h>
--=20
2.34.1


