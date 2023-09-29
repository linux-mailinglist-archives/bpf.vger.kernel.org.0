Return-Path: <bpf+bounces-11130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BA37B3B54
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 22:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7B2FE281DD0
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 20:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C91C8E1;
	Fri, 29 Sep 2023 20:41:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F338F4D
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 20:41:45 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9447C1AA
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 13:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=irCbL+vCeVe6NBjHIdWqQT4c5VVVSc+N91RO33EZAAg=; b=iixIZhVdj8pGlNiMuxDKO41Elu
	mmwmBl5BUbNX2eWp3pKBwURwph52fCwMJ6DUfiblvlwoQE8qFYX+6JGsNi9yJ5GekJWRfv1jrWDuU
	UGf0Yi+wSPlsEBDNKg2mhuao9wcpmeNW3lOe2achSYZYy2He0RKJBGpXow+VbQI88z/8h/4wzkWmm
	EWDBrnCO2TDxD4zDVl4We5IS27NHdtse9pThtRUPgRgsi2FEK89Ib8JsFECEzzStrOQvtH08RhVqn
	BlD2XumgPiu/Exlr0/MLdKB597y+ItYbX9Fa+IThhiaefTSyznO7iLVehvwLoEbCdu/fnKv5IMrOw
	IAFKakVQ==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qmKIt-0009x6-Oz; Fri, 29 Sep 2023 22:41:39 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: martin.lau@kernel.org,
	razor@blackwall.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 2/2] selftest/bpf: Add various selftests for program limits
Date: Fri, 29 Sep 2023 22:41:21 +0200
Message-Id: <20230929204121.20305-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230929204121.20305-1-daniel@iogearbox.net>
References: <20230929204121.20305-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27046/Fri Sep 29 09:41:56 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add various tests to check maximum number of supported programs
being attached:

  # ./vmtest.sh -- ./test_progs -t tc_opts
  [...]
  ./test_progs -t tc_opts
  [    1.185325] bpf_testmod: loading out-of-tree module taints kernel.
  [    1.186826] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  [    1.270123] tsc: Refined TSC clocksource calibration: 3407.988 MHz
  [    1.272428] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fc932722, max_idle_ns: 440795381586 ns
  [    1.276408] clocksource: Switched to clocksource tsc
  #252     tc_opts_after:OK
  #253     tc_opts_append:OK
  #254     tc_opts_basic:OK
  #255     tc_opts_before:OK
  #256     tc_opts_chain_classic:OK
  #257     tc_opts_chain_mixed:OK
  #258     tc_opts_delete_empty:OK
  #259     tc_opts_demixed:OK
  #260     tc_opts_detach:OK
  #261     tc_opts_detach_after:OK
  #262     tc_opts_detach_before:OK
  #263     tc_opts_dev_cleanup:OK
  #264     tc_opts_invalid:OK
  #265     tc_opts_max:OK              <--- (new test)
  #266     tc_opts_mixed:OK
  #267     tc_opts_prepend:OK
  #268     tc_opts_replace:OK
  #269     tc_opts_revision:OK
  Summary: 18/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/tc_opts.c        | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
index 7a2ecd4eca5d..370591f71289 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -2378,3 +2378,87 @@ void serial_test_tc_opts_chain_mixed(void)
 	test_tc_chain_mixed(BPF_TCX_INGRESS);
 	test_tc_chain_mixed(BPF_TCX_EGRESS);
 }
+
+static int generate_dummy_prog(void)
+{
+	const struct bpf_insn prog_insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	const size_t prog_insn_cnt = sizeof(prog_insns) / sizeof(struct bpf_insn);
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+	const size_t log_buf_sz = 256;
+	char *log_buf;
+	int fd = -1;
+
+	log_buf = malloc(log_buf_sz);
+	if (!ASSERT_OK_PTR(log_buf, "log_buf_alloc"))
+		return fd;
+	opts.log_buf = log_buf;
+	opts.log_size = log_buf_sz;
+
+	log_buf[0] = '\0';
+	opts.log_level = 0;
+	fd = bpf_prog_load(BPF_PROG_TYPE_SCHED_CLS, "tcx_prog", "GPL",
+			   prog_insns, prog_insn_cnt, &opts);
+	ASSERT_STREQ(log_buf, "", "log_0");
+	ASSERT_GE(fd, 0, "prog_fd");
+	free(log_buf);
+	return fd;
+}
+
+static void test_tc_opts_max_target(int target, int flags, bool relative)
+{
+	int err, ifindex, i, prog_fd, last_fd = -1;
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	const int max_progs = 63;
+
+	ASSERT_OK(system("ip link add dev tcx_opts1 type veth peer name tcx_opts2"), "add veth");
+	ifindex = if_nametoindex("tcx_opts1");
+	ASSERT_NEQ(ifindex, 0, "non_zero_ifindex");
+
+	assert_mprog_count_ifindex(ifindex, target, 0);
+
+	for (i = 0; i < max_progs; i++) {
+		prog_fd = generate_dummy_prog();
+		if (!ASSERT_GE(prog_fd, 0, "dummy_prog"))
+			goto cleanup;
+		err = bpf_prog_attach_opts(prog_fd, ifindex, target, &opta);
+		if (!ASSERT_EQ(err, 0, "prog_attach"))
+			goto cleanup;
+		assert_mprog_count_ifindex(ifindex, target, i + 1);
+		if (i == max_progs - 1 && relative)
+			last_fd = prog_fd;
+		else
+			close(prog_fd);
+	}
+
+	prog_fd = generate_dummy_prog();
+	if (!ASSERT_GE(prog_fd, 0, "dummy_prog"))
+		goto cleanup;
+	opta.flags = flags;
+	if (last_fd > 0)
+		opta.relative_fd = last_fd;
+	err = bpf_prog_attach_opts(prog_fd, ifindex, target, &opta);
+	ASSERT_EQ(err, -ERANGE, "prog_64_attach");
+	assert_mprog_count_ifindex(ifindex, target, max_progs);
+	close(prog_fd);
+	if (last_fd > 0)
+		close(last_fd);
+cleanup:
+	ASSERT_OK(system("ip link del dev tcx_opts1"), "del veth");
+	ASSERT_EQ(if_nametoindex("tcx_opts1"), 0, "dev1_removed");
+	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
+}
+
+void serial_test_tc_opts_max(void)
+{
+	test_tc_opts_max_target(BPF_TCX_INGRESS, 0, false);
+	test_tc_opts_max_target(BPF_TCX_EGRESS, 0, false);
+
+	test_tc_opts_max_target(BPF_TCX_INGRESS, BPF_F_BEFORE, false);
+	test_tc_opts_max_target(BPF_TCX_EGRESS, BPF_F_BEFORE, true);
+
+	test_tc_opts_max_target(BPF_TCX_INGRESS, BPF_F_AFTER, true);
+	test_tc_opts_max_target(BPF_TCX_EGRESS, BPF_F_AFTER, false);
+}
-- 
2.34.1


