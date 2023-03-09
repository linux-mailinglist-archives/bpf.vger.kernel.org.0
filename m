Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF8E6B1B10
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 07:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCIGC7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 01:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCIGC6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 01:02:58 -0500
Received: from out-19.mta0.migadu.com (out-19.mta0.migadu.com [91.218.175.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BE81FE3
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 22:02:54 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678341772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Y6+Qv25+n+6WiSt0BQxdC2cSrf6/ckkPlUxW2MZug8g=;
        b=sPKwjiWdOtlOD2LOGWsDpAO9KvUJWXTG7Yj/PZQxNSqmmXzsSCr1G0Sl4g7hIvlEX+IHC4
        SUEvTjZEUnD9XhdOrBZKdbVVFEUySAf5dZI8Bi8n2le3Bjzmt96rj6d0D3U0p50YBkNmSC
        89P7mQNIlOsAJoVbXVwLvSDVpEjsolk=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH v2 bpf-next] selftests/bpf: Fix flaky fib_lookup test
Date:   Wed,  8 Mar 2023 22:02:44 -0800
Message-Id: <20230309060244.3242491-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

There is a report that fib_lookup test is flaky when running in parallel.
A symptom of slowness or delay. An example:

Testing IPv6 stale neigh
set_lookup_params:PASS:inet_pton(IPV6_IFACE_ADDR) 0 nsec
test_fib_lookup:PASS:bpf_prog_test_run_opts 0 nsec
test_fib_lookup:FAIL:fib_lookup_ret unexpected fib_lookup_ret: actual 0 != expected 7
test_fib_lookup:FAIL:dmac not match unexpected dmac not match: actual 1 != expected 0
dmac expected 11:11:11:11:11:11 actual 00:00:00:00:00:00

[ Note that the "fib_lookup_ret unexpected fib_lookup_ret actual 0 ..."
  is reversed in terms of expected and actual value. Fixing in this
  patch also. ]

One possibility is the testing stale neigh entry was marked dead by the
gc (in neigh_periodic_work). The default gc_stale_time sysctl is 60s.
This patch increases it to 15 mins.

It also:
- fixes the reversed arg (actual vs expected) in one of the
  ASSERT_EQ test
- removes the nodad command arg when adding v4 neigh entry which
  currently has a warning.

Fixes: 168de0233586 ("selftests/bpf: Add bpf_fib_lookup test")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
v2: Fix a typo in commit message. s/5/15/ mins.
    Fix assert message.

 tools/testing/selftests/bpf/prog_tests/fib_lookup.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
index 429393caf612..a1e712105811 100644
--- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
@@ -54,11 +54,19 @@ static int setup_netns(void)
 	SYS(fail, "ip link add veth1 type veth peer name veth2");
 	SYS(fail, "ip link set dev veth1 up");
 
+	err = write_sysctl("/proc/sys/net/ipv4/neigh/veth1/gc_stale_time", "900");
+	if (!ASSERT_OK(err, "write_sysctl(net.ipv4.neigh.veth1.gc_stale_time)"))
+		goto fail;
+
+	err = write_sysctl("/proc/sys/net/ipv6/neigh/veth1/gc_stale_time", "900");
+	if (!ASSERT_OK(err, "write_sysctl(net.ipv6.neigh.veth1.gc_stale_time)"))
+		goto fail;
+
 	SYS(fail, "ip addr add %s/64 dev veth1 nodad", IPV6_IFACE_ADDR);
 	SYS(fail, "ip neigh add %s dev veth1 nud failed", IPV6_NUD_FAILED_ADDR);
 	SYS(fail, "ip neigh add %s dev veth1 lladdr %s nud stale", IPV6_NUD_STALE_ADDR, DMAC);
 
-	SYS(fail, "ip addr add %s/24 dev veth1 nodad", IPV4_IFACE_ADDR);
+	SYS(fail, "ip addr add %s/24 dev veth1", IPV4_IFACE_ADDR);
 	SYS(fail, "ip neigh add %s dev veth1 nud failed", IPV4_NUD_FAILED_ADDR);
 	SYS(fail, "ip neigh add %s dev veth1 lladdr %s nud stale", IPV4_NUD_STALE_ADDR, DMAC);
 
@@ -158,7 +166,7 @@ void test_fib_lookup(void)
 		if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
 			continue;
 
-		ASSERT_EQ(tests[i].expected_ret, skel->bss->fib_lookup_ret,
+		ASSERT_EQ(skel->bss->fib_lookup_ret, tests[i].expected_ret,
 			  "fib_lookup_ret");
 
 		ret = memcmp(tests[i].dmac, fib_params->dmac, sizeof(tests[i].dmac));
-- 
2.34.1

