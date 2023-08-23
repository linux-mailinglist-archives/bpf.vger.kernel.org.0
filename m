Return-Path: <bpf+bounces-8338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1516F784E87
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 04:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55E528121D
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 02:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E2D1851;
	Wed, 23 Aug 2023 02:07:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BCE17D4
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 02:07:11 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0376CF
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 19:07:09 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68a3cae6e1eso2357407b3a.0
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 19:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692756429; x=1693361229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLAcarte/YODlFqjWTjDwVfg/VXs8i7gnRIi0WfhFEs=;
        b=ZrUHUDfT6D5dnoPFa7j3QDcsv4wpYso+Sj4M57Dn8RSw/+JUC41CG5zaArGcrYm8fp
         /Mti4LIHDGLB90F/4Bp7tnhghawCP9pB6fyQUdf2RKEDz9OnDLwnV/hwjUNSwlzSiTuT
         EycLo/WomADaPviyI7F+ueg0gwYvpJbsEUyD6EBmYBO55mlABQ1wa3mbAsHWuaVlMVS0
         f5gS6Ls1/37juLI2lIX0rTBPLFmBhq2KMOHd7pNx7OB8POriGU3LgiDjR8zE+7c7OtDy
         huD6kCX6c26Y7f2WfMo+uXjTw9OJOYGf1QcLwwC5SowNSo471FCRE7Ps93lDlDhVXU8L
         66Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692756429; x=1693361229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLAcarte/YODlFqjWTjDwVfg/VXs8i7gnRIi0WfhFEs=;
        b=awx5jYytz08E6A/nxro+b99xQYIz02HH/tHFCkZFK2GqdjxlAmrXjVAQSfysQM+HNW
         cWTsXyCxCad/6Taza8OdbYHMv4u85Ds2VWaicBemMCZxqg5VSvd4zSZeAAFetBajnpw2
         k4OxJsWBr1k2p1SBJ8djQOFCCzFWM71H7Thmq+wO1sw4GHawyeoRLczXsgDm9eJ+bPKt
         eOd2eCksBcfRjvUNMR8ZUYEMtevgp72E4jUzSeGvgkkd/X5YMGZLLGLDBi3qU5KAUwH6
         uyJuefeUMwDxlhktu1uAqSgKml7O9HtvJ3E/ESD5UAWHWClzCaKOSJ9uC+jpzG8voc9x
         UqbA==
X-Gm-Message-State: AOJu0Yz719g2W68l7WHGdH6foYAP9fEf/z4NirMZ3zGDp+oJpqcI3Lya
	KF+/L4LSuk7+IkWsKXpOb48=
X-Google-Smtp-Source: AGHT+IHRqMjAqqbXy9TmiXB1P4xW8vsOBRvqoKE/8dfilCvjgOWsH5lGJ6h1gp+x+/sUbkRc9eV8Iw==
X-Received: by 2002:a05:6a00:15d4:b0:687:1604:39eb with SMTP id o20-20020a056a0015d400b00687160439ebmr10794370pfu.25.1692756429077;
        Tue, 22 Aug 2023 19:07:09 -0700 (PDT)
Received: from vultr.guest ([149.28.193.116])
        by smtp.gmail.com with ESMTPSA id y15-20020aa7804f000000b0064f7c56d8b7sm8313627pfm.219.2023.08.22.19.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 19:07:08 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Add selftest for allow_ptr_leaks
Date: Wed, 23 Aug 2023 02:07:03 +0000
Message-Id: <20230823020703.3790-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230823020703.3790-1-laoar.shao@gmail.com>
References: <20230823020703.3790-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

- Without prev commit

  $ tools/testing/selftests/bpf/test_progs --name=tc_bpf
  #232/1   tc_bpf/tc_bpf_root:OK
  test_tc_bpf_non_root:PASS:set_cap_bpf_cap_net_admin 0 nsec
  test_tc_bpf_non_root:PASS:disable_cap_sys_admin 0 nsec
  0: R1=ctx(off=0,imm=0) R10=fp0
  ; if ((long)(iph + 1) > (long)skb->data_end)
  0: (61) r2 = *(u32 *)(r1 +80)         ; R1=ctx(off=0,imm=0) R2_w=pkt_end(off=0,imm=0)
  ; struct iphdr *iph = (void *)(long)skb->data + sizeof(struct ethhdr);
  1: (61) r1 = *(u32 *)(r1 +76)         ; R1_w=pkt(off=0,r=0,imm=0)
  ; if ((long)(iph + 1) > (long)skb->data_end)
  2: (07) r1 += 34                      ; R1_w=pkt(off=34,r=0,imm=0)
  3: (b4) w0 = 1                        ; R0_w=1
  4: (2d) if r1 > r2 goto pc+1
  R2 pointer comparison prohibited
  processed 5 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
  test_tc_bpf_non_root:FAIL:test_tc_bpf__open_and_load unexpected error: -13
  #233/2   tc_bpf_non_root:FAIL

- With prev commit

  $ tools/testing/selftests/bpf/test_progs --name=tc_bpf
  #232/1   tc_bpf/tc_bpf_root:OK
  #232/2   tc_bpf/tc_bpf_non_root:OK
  #232     tc_bpf:OK
  Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/tc_bpf.c | 36 ++++++++++++++++++++++++-
 tools/testing/selftests/bpf/progs/test_tc_bpf.c | 13 +++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_bpf.c b/tools/testing/selftests/bpf/prog_tests/tc_bpf.c
index e873766..48b5553 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_bpf.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 #include <linux/pkt_cls.h>
 
+#include "cap_helpers.h"
 #include "test_tc_bpf.skel.h"
 
 #define LO_IFINDEX 1
@@ -327,7 +328,7 @@ static int test_tc_bpf_api(struct bpf_tc_hook *hook, int fd)
 	return 0;
 }
 
-void test_tc_bpf(void)
+void tc_bpf_root(void)
 {
 	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex = LO_IFINDEX,
 			    .attach_point = BPF_TC_INGRESS);
@@ -393,3 +394,36 @@ void test_tc_bpf(void)
 	}
 	test_tc_bpf__destroy(skel);
 }
+
+void tc_bpf_non_root(void)
+{
+	struct test_tc_bpf *skel = NULL;
+	__u64 caps = 0;
+	int ret;
+
+	/* In case CAP_BPF and CAP_PERFMON is not set */
+	ret = cap_enable_effective(1ULL << CAP_BPF | 1ULL << CAP_NET_ADMIN, &caps);
+	if (!ASSERT_OK(ret, "set_cap_bpf_cap_net_admin"))
+		return;
+	ret = cap_disable_effective(1ULL << CAP_SYS_ADMIN | 1ULL << CAP_PERFMON, NULL);
+	if (!ASSERT_OK(ret, "disable_cap_sys_admin"))
+		goto restore_cap;
+
+	skel = test_tc_bpf__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_tc_bpf__open_and_load"))
+		goto restore_cap;
+
+	test_tc_bpf__destroy(skel);
+
+restore_cap:
+	if (caps)
+		cap_enable_effective(caps, NULL);
+}
+
+void test_tc_bpf(void)
+{
+	if (test__start_subtest("tc_bpf_root"))
+		tc_bpf_root();
+	if (test__start_subtest("tc_bpf_non_root"))
+		tc_bpf_non_root();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_tc_bpf.c b/tools/testing/selftests/bpf/progs/test_tc_bpf.c
index d28ca8d..ef7da41 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_bpf.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_bpf.c
@@ -2,6 +2,8 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include <linux/if_ether.h>
+#include <linux/ip.h>
 
 /* Dummy prog to test TC-BPF API */
 
@@ -10,3 +12,14 @@ int cls(struct __sk_buff *skb)
 {
 	return 0;
 }
+
+/* Prog to verify tc-bpf without cap_sys_admin and cap_perfmon */
+SEC("tcx/ingress")
+int pkt_ptr(struct __sk_buff *skb)
+{
+	struct iphdr *iph = (void *)(long)skb->data + sizeof(struct ethhdr);
+
+	if ((long)(iph + 1) > (long)skb->data_end)
+		return 1;
+	return 0;
+}
-- 
1.8.3.1


