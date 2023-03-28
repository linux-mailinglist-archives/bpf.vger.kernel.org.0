Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BBA6CC08D
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 15:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjC1NWm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 09:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1NWl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 09:22:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669458A62
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 06:22:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x3so49581204edb.10
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 06:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680009757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nC3HFc7O66RVW94stcQT4FvsFYZFxFbieU9BLuLfDsU=;
        b=k9CSItU1Ci3q/QLLhWHexcWmhUTwu7Lc7ibjyXlERllLcT8KH+EujmdScLJvThHD3i
         RBLXc6WsUaGLTUPTCAAAhl+oslCwH7fMocHeQ6xXlOHak+eX4xTmjGLKaZ+yyFPuPk3W
         ghmsl510uFToxOCYYdaC4d7UbsmTTdimhRElsSywp6Vb0bZjc/nf45hSoR/EdHgx85Qj
         m7JmmCY1fWY0/09Icq4BKbA0QQCqqZhxRGx3OcOoDvp2+LGC9PxoYSxTMCV/Y/27QBP9
         XEQGcuLqGaIcMmi9nhWIWt3y5cFdgRWZet9Ztfv2Ky7E1Oo1gqCVbPNH/wJ2QkQLvmL3
         BrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680009757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nC3HFc7O66RVW94stcQT4FvsFYZFxFbieU9BLuLfDsU=;
        b=nrVBqOo0JdT+blnYGjfsM34R7fnA8IpEvn/ES6kVS9S8lGiC2BXnYEKM/XIFyDLiub
         9zRQjr8PaIsuJa7s8afLuk73CEsKslQvuUO2LxbMiRtgk/kC2zgHnQYxoM0urIS3JvKt
         BhPCHZnLAWUHuVuBsCdBRhhxCp9+2ukUQNnAd2yF6zFz5BtICFrMD9dwYD/q2XXbhLWE
         9liApzXcRC9snhGqmP6QmkAapwiFvM888dH+xRefcRpLWzw6aGuI9vcRdUy+u2IjXxO9
         wI10Tl0savOy4s+5jhlx5KS+NisG+ZkOTqiMpAmT0LCHbLOnwkPjqQCxgRIFPkofSL1v
         wr4Q==
X-Gm-Message-State: AAQBX9cqBhYobC+/rF7hZ7qCqJH7/4a6B16UHfMkER6DGx05FtJpp6HX
        6/zuhahQzOVFLkif89RdQvJTmHu3DWbp0lPjtq0ZTw==
X-Google-Smtp-Source: AKy350bNCtBCMMRWvhIUcJJp+mJ32pwiGz+/kDum5VLXb3bhhFqZTb08DR+ADx5KqQXnY47Pa7awxA==
X-Received: by 2002:a17:907:2175:b0:920:7a99:dcd4 with SMTP id rl21-20020a170907217500b009207a99dcd4mr16083205ejb.62.1680009757544;
        Tue, 28 Mar 2023 06:22:37 -0700 (PDT)
Received: from localhost.localdomain ([45.35.56.2])
        by smtp.gmail.com with ESMTPSA id h19-20020a1709070b1300b008ec4333fd65sm15240170ejl.188.2023.03.28.06.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:22:37 -0700 (PDT)
From:   Yixin Shen <bobankhshen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, song@kernel.org, yhs@fb.com,
        bobankhshen@gmail.com
Subject: [PATCH 2/2] selftests/bpf: test a BPF CC writing app_limited
Date:   Tue, 28 Mar 2023 13:20:35 +0000
Message-Id: <20230328132035.50839-3-bobankhshen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328132035.50839-1-bobankhshen@gmail.com>
References: <20230328132035.50839-1-bobankhshen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test whether a TCP CC implemented in BPF is allowed to write
app_limited in struct tcp_sock. This is already allowed for
the built-in TCP CC.

Signed-off-by: Yixin Shen <bobankhshen@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 19 +++++
 .../bpf/progs/tcp_ca_write_app_limited.c      | 71 +++++++++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_write_app_limited.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index a53c254c6058..1911ed04d4cf 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -11,6 +11,7 @@
 #include "tcp_ca_update.skel.h"
 #include "bpf_dctcp_release.skel.h"
 #include "tcp_ca_write_sk_pacing.skel.h"
+#include "tcp_ca_write_app_limited.skel.h"
 #include "tcp_ca_incompl_cong_ops.skel.h"
 #include "tcp_ca_unsupp_cong_op.skel.h"
 
@@ -346,6 +347,22 @@ static void test_write_sk_pacing(void)
 	tcp_ca_write_sk_pacing__destroy(skel);
 }
 
+static void test_write_app_limited(void)
+{
+	struct tcp_ca_write_app_limited *skel;
+	struct bpf_link *link;
+
+	skel = tcp_ca_write_app_limited__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(skel->maps.write_app_limited);
+	ASSERT_OK_PTR(link, "attach_struct_ops");
+
+	bpf_link__destroy(link);
+	tcp_ca_write_app_limited__destroy(skel);
+}
+
 static void test_incompl_cong_ops(void)
 {
 	struct tcp_ca_incompl_cong_ops *skel;
@@ -545,6 +562,8 @@ void test_bpf_tcp_ca(void)
 		test_rel_setsockopt();
 	if (test__start_subtest("write_sk_pacing"))
 		test_write_sk_pacing();
+	if (test__start_subtest("write_app_limited"))
+		test_write_app_limited();
 	if (test__start_subtest("incompl_cong_ops"))
 		test_incompl_cong_ops();
 	if (test__start_subtest("unsupp_cong_op"))
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_write_app_limited.c b/tools/testing/selftests/bpf/progs/tcp_ca_write_app_limited.c
new file mode 100644
index 000000000000..de5c9b5045a1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_write_app_limited.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define USEC_PER_SEC 1000000UL
+
+#define min(a, b) ((a) < (b) ? (a) : (b))
+
+static inline struct tcp_sock *tcp_sk(const struct sock *sk)
+{
+	return (struct tcp_sock *)sk;
+}
+
+static inline unsigned int tcp_left_out(const struct tcp_sock *tp)
+{
+	return tp->sacked_out + tp->lost_out;
+}
+
+static inline unsigned int tcp_packets_in_flight(const struct tcp_sock *tp)
+{
+	return tp->packets_out - tcp_left_out(tp) + tp->retrans_out;
+}
+
+SEC("struct_ops/write_app_limited_init")
+void BPF_PROG(write_app_limited_init, struct sock *sk)
+{
+#ifdef ENABLE_ATOMICS_TESTS
+	__sync_bool_compare_and_swap(&sk->sk_pacing_status, SK_PACING_NONE,
+				     SK_PACING_NEEDED);
+#else
+	sk->sk_pacing_status = SK_PACING_NEEDED;
+#endif
+}
+
+SEC("struct_ops/write_app_limited_cong_control")
+void BPF_PROG(write_app_limited_cong_control, struct sock *sk,
+	      const struct rate_sample *rs)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	unsigned long rate =
+		((tp->snd_cwnd * tp->mss_cache * USEC_PER_SEC) << 3) /
+		(tp->srtt_us ?: 1U << 3);
+	sk->sk_pacing_rate = min(rate, sk->sk_max_pacing_rate);
+	tp->app_limited = (tp->delivered + tcp_packets_in_flight(tp)) ?: 1;
+}
+
+SEC("struct_ops/write_app_limited_ssthresh")
+__u32 BPF_PROG(write_app_limited_ssthresh, struct sock *sk)
+{
+	return tcp_sk(sk)->snd_ssthresh;
+}
+
+SEC("struct_ops/write_app_limited_undo_cwnd")
+__u32 BPF_PROG(write_app_limited_undo_cwnd, struct sock *sk)
+{
+	return tcp_sk(sk)->snd_cwnd;
+}
+
+SEC(".struct_ops")
+struct tcp_congestion_ops write_app_limited = {
+	.init = (void *)write_app_limited_init,
+	.cong_control = (void *)write_app_limited_cong_control,
+	.ssthresh = (void *)write_app_limited_ssthresh,
+	.undo_cwnd = (void *)write_app_limited_undo_cwnd,
+	.name = "bpf_w_app_limit",
+};
-- 
2.25.1

