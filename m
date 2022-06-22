Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80ED655540D
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 21:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376570AbiFVTMx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 15:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376841AbiFVTMv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 15:12:51 -0400
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8BD1929A
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 12:12:50 -0700 (PDT)
Received: from SPMA-01.tubit.win.tu-berlin.de (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 1823A7E0787_2B369B1B;
        Wed, 22 Jun 2022 19:12:49 +0000 (GMT)
Received: from mail.tu-berlin.de (mail.tu-berlin.de [141.23.12.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "exchange.tu-berlin.de", Issuer "DFN-Verein Global Issuing CA" (verified OK))
        by SPMA-01.tubit.win.tu-berlin.de (Sophos Email Appliance) with ESMTPS id B49D37E4EDC_2B369B0F;
        Wed, 22 Jun 2022 19:12:48 +0000 (GMT)
Received: from jt.fritz.box (77.191.241.175) by ex-04.svc.tu-berlin.de
 (10.150.18.8) with Microsoft SMTP Server id 15.2.986.22; Wed, 22 Jun 2022
 21:12:48 +0200
From:   =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>
Subject: [PATCH bpf-next v4 4/5] selftests/bpf: Test an incomplete BPF CC
Date:   Wed, 22 Jun 2022 21:12:26 +0200
Message-ID: <20220622191227.898118-5-jthinz@mailbox.tu-berlin.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220622191227.898118-1-jthinz@mailbox.tu-berlin.de>
References: <20220622191227.898118-1-jthinz@mailbox.tu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-SASI-RCODE: 200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=campus.tu-berlin.de; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim-tub; bh=DRKFjajiICT42H8iL6340+PPnrZXcfkxpwNrX4o2WMw=; b=H+//2koVoA9P7Q5tmSXMtSSMbH0OCBt9SmLBXWfn8dNrlnmorSjnVTlxREilXdI0DqxyoxKf4eAuYq4/ASYq4X5DyvicRNYprJVwonKtPhlLIZLS3lwcqB8Or6OTbmV4EivL26+LglHgTZVJEbY0nO+6o+cci8KhHR6N0dQXo/A=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test whether a TCP CC implemented in BPF providing neither cong_avoid()
nor cong_control() is correctly rejected. This check solely depends on
tcp_register_congestion_control() now, which is invoked during
bpf_map__attach_struct_ops().

Signed-off-by: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 22 ++++++++++++
 .../bpf/progs/tcp_ca_incompl_cong_ops.c       | 35 +++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_incompl_cong_ops.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index e79f3f5a9d33..194d07310531 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -10,6 +10,7 @@
 #include "bpf_tcp_nogpl.skel.h"
 #include "bpf_dctcp_release.skel.h"
 #include "tcp_ca_write_sk_pacing.skel.h"
+#include "tcp_ca_incompl_cong_ops.skel.h"
 
 #ifndef ENOTSUPP
 #define ENOTSUPP 524
@@ -339,6 +340,25 @@ static void test_write_sk_pacing(void)
 	tcp_ca_write_sk_pacing__destroy(skel);
 }
 
+static void test_incompl_cong_ops(void)
+{
+	struct tcp_ca_incompl_cong_ops *skel;
+	struct bpf_link *link;
+
+	skel = tcp_ca_incompl_cong_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	/* That cong_avoid() and cong_control() are missing is only reported at
+	 * this point:
+	 */
+	link = bpf_map__attach_struct_ops(skel->maps.incompl_cong_ops);
+	ASSERT_ERR_PTR(link, "attach_struct_ops");
+
+	bpf_link__destroy(link);
+	tcp_ca_incompl_cong_ops__destroy(skel);
+}
+
 void test_bpf_tcp_ca(void)
 {
 	if (test__start_subtest("dctcp"))
@@ -353,4 +373,6 @@ void test_bpf_tcp_ca(void)
 		test_rel_setsockopt();
 	if (test__start_subtest("write_sk_pacing"))
 		test_write_sk_pacing();
+	if (test__start_subtest("incompl_cong_ops"))
+		test_incompl_cong_ops();
 }
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_incompl_cong_ops.c b/tools/testing/selftests/bpf/progs/tcp_ca_incompl_cong_ops.c
new file mode 100644
index 000000000000..7bb872fb22dd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_incompl_cong_ops.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+static inline struct tcp_sock *tcp_sk(const struct sock *sk)
+{
+	return (struct tcp_sock *)sk;
+}
+
+SEC("struct_ops/incompl_cong_ops_ssthresh")
+__u32 BPF_PROG(incompl_cong_ops_ssthresh, struct sock *sk)
+{
+	return tcp_sk(sk)->snd_ssthresh;
+}
+
+SEC("struct_ops/incompl_cong_ops_undo_cwnd")
+__u32 BPF_PROG(incompl_cong_ops_undo_cwnd, struct sock *sk)
+{
+	return tcp_sk(sk)->snd_cwnd;
+}
+
+SEC(".struct_ops")
+struct tcp_congestion_ops incompl_cong_ops = {
+	/* Intentionally leaving out any of the required cong_avoid() and
+	 * cong_control() here.
+	 */
+	.ssthresh = (void *)incompl_cong_ops_ssthresh,
+	.undo_cwnd = (void *)incompl_cong_ops_undo_cwnd,
+	.name = "bpf_incompl_ops",
+};
-- 
2.30.2

