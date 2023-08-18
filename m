Return-Path: <bpf+bounces-8047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8060780751
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 10:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98C61C20A1D
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 08:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BFE17ABC;
	Fri, 18 Aug 2023 08:39:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0289F3D7F
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 08:39:33 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD4B3AA1
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 01:39:32 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bddac1b7bfso4905825ad.0
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 01:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692347972; x=1692952772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYH/QZZv/rTEBSUZcUWDHbrBq1YRNlLBUbR04U1vZX0=;
        b=TZ7VD/uZVw5PYqrsABu3Bl7b6QnKRNlDqPWZWLi6VyzdQATiUj1gbdAZQW/A1sm0Xj
         FKqk2YMttQy2Q9u5F73QXYo2NrmFf/mC5L7E6skkafZNQ6VyLY1KhLLA+yw/FRqSvffK
         DoysFaTHqpnsd3r/UVnlpGlzHsahyOLxxG6Jpa7fy4kRKh2Zs+RNuelyzVtm7qO6DRz7
         iDSwiPEw/3lhwqJCPb80YvzK2nmv+SPUyoDzARRFBmaatXgUJtsvq0k5WzcqciBYnuNF
         vP/ISXIZlYZdXswvunY4xRnjtOeGND5BQLgj3MeJAhcBu2RgzmJMJ+Pl9slFXl6M8wPM
         vZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692347972; x=1692952772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYH/QZZv/rTEBSUZcUWDHbrBq1YRNlLBUbR04U1vZX0=;
        b=ijQjmT4OCu4qCtBGDtgIqjO15tlrn1OLfPe4zWQrSEropjWMSdmdIST+I8Qi8X7AdZ
         ZdSFjCbUrl+d2UBiuREGEfQVjxdTXeazlLhTb/A3u3vP3jq6tFftpWfcfLEhxlwIjoOr
         j2iXoggf/8Tenu6UBputRXqSzHHSlgKuUjGiNwNxZ7x/kDF/qk/lHrJvHPY9CxMl5FcJ
         ejpfhAXbtiKRUjRZHJOaEEVwmwN4IQ5nvun2/FDKIE5d133C9sI/4bIS99HmisxIzepP
         zvAUxFTJq0eFhUIEjZrsFwVil3iJHz3HPIgy55WEtrokDICOjSWjGzelgkCG2swuA3iR
         tmNw==
X-Gm-Message-State: AOJu0YzzmGLFh36KIh0wLQp6+eg0kYHbuXeu/7t++xfmJIauKVyU28US
	+ELHlqmLM49XSakoa14yYmA=
X-Google-Smtp-Source: AGHT+IH8ZluvwizE9+8tJ89Y9DGh9cQCx0gaFoLmh+Vjz/tHds6R1If84ai02suhcs7BTdrhZstFtw==
X-Received: by 2002:a17:902:ab54:b0:1b9:c61c:4c01 with SMTP id ij20-20020a170902ab5400b001b9c61c4c01mr5511706plb.9.1692347971966;
        Fri, 18 Aug 2023 01:39:31 -0700 (PDT)
Received: from vultr.guest ([149.28.193.116])
        by smtp.gmail.com with ESMTPSA id ij27-20020a170902ab5b00b001b53c8659fesm1185209plb.30.2023.08.18.01.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 01:39:31 -0700 (PDT)
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add selftest for allow_ptr_leaks
Date: Fri, 18 Aug 2023 08:39:20 +0000
Message-Id: <20230818083920.3771-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230818083920.3771-1-laoar.shao@gmail.com>
References: <20230818083920.3771-1-laoar.shao@gmail.com>
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
 tools/testing/selftests/bpf/progs/test_tc_bpf.c | 14 ++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

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
index d28ca8d..3e0f218 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_bpf.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_bpf.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/pkt_cls.h>
+#include <linux/ip.h>
+#include <linux/if_ether.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
@@ -10,3 +13,14 @@ int cls(struct __sk_buff *skb)
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
+		return TC_ACT_STOLEN;
+	return TC_ACT_OK;
+}
-- 
1.8.3.1


