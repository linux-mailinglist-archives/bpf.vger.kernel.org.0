Return-Path: <bpf+bounces-8051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ADF7807E1
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 11:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C3C1C21378
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 09:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9437F18016;
	Fri, 18 Aug 2023 09:02:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A08517FE1;
	Fri, 18 Aug 2023 09:02:02 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B482A3C38;
	Fri, 18 Aug 2023 02:01:39 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bee82fab5aso5431085ad.3;
        Fri, 18 Aug 2023 02:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692349298; x=1692954098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nR7hlSJcI/VDbkyc3cWMIqYJqOI92tz/pqZv4Rktqzo=;
        b=M4LiOPl+7JPgFuJFwukrLow+Vw3SWeqzqerJ+fxrDnR8VvC33r6OqoBIdTD7lFA189
         WAy/n3aB4ogRrvMH1BC1zTzVmvthOjm4n+gFtUkFzhJOuYKucFk95aIvj3pCtNwAAB6G
         zHp4ZzackBry5tAF4iEaqp1XC4sdIHAF/dg2Sr9R1SYdG/hHbqZaRIqN2THxbbYh1IKc
         +IEtWsLZtukZnwfxQfs3OKPqzlf/4yW2deWSIuphvNwvLyr8Zowe/s4WNGx/D2b3Gjtm
         aZGc4JCAbpD6r0VirGtMHtvlU50avCSQcm4SiUwydAUvw7kuBvrkNyYXysgZxy2gXJt2
         TIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692349298; x=1692954098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nR7hlSJcI/VDbkyc3cWMIqYJqOI92tz/pqZv4Rktqzo=;
        b=XXYT1MoMtNbGgpd2H/1KyjA+IREN4oQGwogP9PXv8HyKDJeP2mti5xKT3gy0HjbLCP
         NzSYijcCuYyhNqEtlAjLJsW1kGgOrYJ8IPnIOIGAERifzhnIhqE6B1HZxhk4Wspd3ANX
         ZHQEOxhLQjzVrurGn4M0ECbJF/1ZO8QkGObZ6jY0YGJ7L4hX0+ITNFW8DIMYXkFavnNc
         KhxPpMAefEWV2VmEOMqhF0ewCNIVMo/hHfw6cxpfB0OGjLQN0fqKQZgj2r1HF/2NrO2S
         c74vhy1d3vDixOX6MG5Q1VxUeAzXWMuTUCzTK3PDwlH1XwCidv5Ak1/dYhq44Nm+naE4
         lISg==
X-Gm-Message-State: AOJu0YzUhHY9iHu0b4QEo1/mZ1sm5bhGoi9ZWn0AMd2W1gziEP4H+Egf
	k3HXy5fJSu7F9NOXYx6UGg==
X-Google-Smtp-Source: AGHT+IE7n45xF68sI+mFXv22ohUPodCh5cj1bJF3Yfg0oPyMovpsTuLYkM2cjrvLB2w9f12gscBy7w==
X-Received: by 2002:a17:903:186:b0:1b0:6e16:b92c with SMTP id z6-20020a170903018600b001b06e16b92cmr2002367plg.54.1692349298510;
        Fri, 18 Aug 2023 02:01:38 -0700 (PDT)
Received: from dell-sscc.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b001b89045ff03sm1217130plb.233.2023.08.18.02.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 02:01:38 -0700 (PDT)
From: "Daniel T. Lee" <danieltimlee@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [bpf-next 3/9] samples/bpf: unify bpf program suffix to .bpf with tracing programs
Date: Fri, 18 Aug 2023 18:01:13 +0900
Message-Id: <20230818090119.477441-4-danieltimlee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818090119.477441-1-danieltimlee@gmail.com>
References: <20230818090119.477441-1-danieltimlee@gmail.com>
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

Currently, BPF programs typically have a suffix of .bpf.c. However,
some programs still utilize a mixture of _kern.c suffix alongside the
naming convention. In order to achieve consistency in the naming of
these programs, this commit unifies the inconsistency in the naming
convention of BPF kernel programs.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
---
 samples/bpf/Makefile                           | 18 +++++++++---------
 .../{offwaketime_kern.c => offwaketime.bpf.c}  |  0
 samples/bpf/offwaketime_user.c                 |  2 +-
 .../bpf/{spintest_kern.c => spintest.bpf.c}    |  0
 samples/bpf/spintest_user.c                    |  2 +-
 samples/bpf/{tracex1_kern.c => tracex1.bpf.c}  |  0
 samples/bpf/tracex1_user.c                     |  2 +-
 samples/bpf/{tracex3_kern.c => tracex3.bpf.c}  |  0
 samples/bpf/tracex3_user.c                     |  2 +-
 samples/bpf/{tracex4_kern.c => tracex4.bpf.c}  |  0
 samples/bpf/tracex4_user.c                     |  2 +-
 samples/bpf/{tracex5_kern.c => tracex5.bpf.c}  |  0
 samples/bpf/tracex5_user.c                     |  2 +-
 samples/bpf/{tracex6_kern.c => tracex6.bpf.c}  |  0
 samples/bpf/tracex6_user.c                     |  2 +-
 samples/bpf/{tracex7_kern.c => tracex7.bpf.c}  |  0
 samples/bpf/tracex7_user.c                     |  2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)
 rename samples/bpf/{offwaketime_kern.c => offwaketime.bpf.c} (100%)
 rename samples/bpf/{spintest_kern.c => spintest.bpf.c} (100%)
 rename samples/bpf/{tracex1_kern.c => tracex1.bpf.c} (100%)
 rename samples/bpf/{tracex3_kern.c => tracex3.bpf.c} (100%)
 rename samples/bpf/{tracex4_kern.c => tracex4.bpf.c} (100%)
 rename samples/bpf/{tracex5_kern.c => tracex5.bpf.c} (100%)
 rename samples/bpf/{tracex6_kern.c => tracex6.bpf.c} (100%)
 rename samples/bpf/{tracex7_kern.c => tracex7.bpf.c} (100%)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index b32cb8a62335..f90bcd3696bd 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -124,21 +124,21 @@ always-y := $(tprogs-y)
 always-y += sockex1_kern.o
 always-y += sockex2_kern.o
 always-y += sockex3_kern.o
-always-y += tracex1_kern.o
+always-y += tracex1.bpf.o
 always-y += tracex2.bpf.o
-always-y += tracex3_kern.o
-always-y += tracex4_kern.o
-always-y += tracex5_kern.o
-always-y += tracex6_kern.o
-always-y += tracex7_kern.o
+always-y += tracex3.bpf.o
+always-y += tracex4.bpf.o
+always-y += tracex5.bpf.o
+always-y += tracex6.bpf.o
+always-y += tracex7.bpf.o
 always-y += sock_flags.bpf.o
 always-y += test_probe_write_user.bpf.o
 always-y += trace_output.bpf.o
 always-y += tcbpf1_kern.o
 always-y += tc_l2_redirect_kern.o
 always-y += lathist_kern.o
-always-y += offwaketime_kern.o
-always-y += spintest_kern.o
+always-y += offwaketime.bpf.o
+always-y += spintest.bpf.o
 always-y += map_perf_test.bpf.o
 always-y += test_overhead_tp.bpf.o
 always-y += test_overhead_raw_tp.bpf.o
@@ -333,7 +333,7 @@ $(obj)/xdp_redirect_user.o: $(obj)/xdp_redirect.skel.h
 $(obj)/xdp_monitor_user.o: $(obj)/xdp_monitor.skel.h
 $(obj)/xdp_router_ipv4_user.o: $(obj)/xdp_router_ipv4.skel.h
 
-$(obj)/tracex5_kern.o: $(obj)/syscall_nrs.h
+$(obj)/tracex5.bpf.o: $(obj)/syscall_nrs.h
 $(obj)/hbm_out_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
 $(obj)/hbm.o: $(src)/hbm.h
 $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
diff --git a/samples/bpf/offwaketime_kern.c b/samples/bpf/offwaketime.bpf.c
similarity index 100%
rename from samples/bpf/offwaketime_kern.c
rename to samples/bpf/offwaketime.bpf.c
diff --git a/samples/bpf/offwaketime_user.c b/samples/bpf/offwaketime_user.c
index b6eedcb98fb9..5557b5393642 100644
--- a/samples/bpf/offwaketime_user.c
+++ b/samples/bpf/offwaketime_user.c
@@ -105,7 +105,7 @@ int main(int argc, char **argv)
 		return 2;
 	}
 
-	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
+	snprintf(filename, sizeof(filename), "%s.bpf.o", argv[0]);
 	obj = bpf_object__open_file(filename, NULL);
 	if (libbpf_get_error(obj)) {
 		fprintf(stderr, "ERROR: opening BPF object file failed\n");
diff --git a/samples/bpf/spintest_kern.c b/samples/bpf/spintest.bpf.c
similarity index 100%
rename from samples/bpf/spintest_kern.c
rename to samples/bpf/spintest.bpf.c
diff --git a/samples/bpf/spintest_user.c b/samples/bpf/spintest_user.c
index aadac14f748a..8c77600776fb 100644
--- a/samples/bpf/spintest_user.c
+++ b/samples/bpf/spintest_user.c
@@ -23,7 +23,7 @@ int main(int ac, char **argv)
 		return 2;
 	}
 
-	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
+	snprintf(filename, sizeof(filename), "%s.bpf.o", argv[0]);
 	obj = bpf_object__open_file(filename, NULL);
 	if (libbpf_get_error(obj)) {
 		fprintf(stderr, "ERROR: opening BPF object file failed\n");
diff --git a/samples/bpf/tracex1_kern.c b/samples/bpf/tracex1.bpf.c
similarity index 100%
rename from samples/bpf/tracex1_kern.c
rename to samples/bpf/tracex1.bpf.c
diff --git a/samples/bpf/tracex1_user.c b/samples/bpf/tracex1_user.c
index 9d4adb7fd834..8c3d9043a2b6 100644
--- a/samples/bpf/tracex1_user.c
+++ b/samples/bpf/tracex1_user.c
@@ -12,7 +12,7 @@ int main(int ac, char **argv)
 	char filename[256];
 	FILE *f;
 
-	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
+	snprintf(filename, sizeof(filename), "%s.bpf.o", argv[0]);
 	obj = bpf_object__open_file(filename, NULL);
 	if (libbpf_get_error(obj)) {
 		fprintf(stderr, "ERROR: opening BPF object file failed\n");
diff --git a/samples/bpf/tracex3_kern.c b/samples/bpf/tracex3.bpf.c
similarity index 100%
rename from samples/bpf/tracex3_kern.c
rename to samples/bpf/tracex3.bpf.c
diff --git a/samples/bpf/tracex3_user.c b/samples/bpf/tracex3_user.c
index d5eebace31e6..1002eb0323b4 100644
--- a/samples/bpf/tracex3_user.c
+++ b/samples/bpf/tracex3_user.c
@@ -125,7 +125,7 @@ int main(int ac, char **argv)
 		}
 	}
 
-	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
+	snprintf(filename, sizeof(filename), "%s.bpf.o", argv[0]);
 	obj = bpf_object__open_file(filename, NULL);
 	if (libbpf_get_error(obj)) {
 		fprintf(stderr, "ERROR: opening BPF object file failed\n");
diff --git a/samples/bpf/tracex4_kern.c b/samples/bpf/tracex4.bpf.c
similarity index 100%
rename from samples/bpf/tracex4_kern.c
rename to samples/bpf/tracex4.bpf.c
diff --git a/samples/bpf/tracex4_user.c b/samples/bpf/tracex4_user.c
index dee8f0a091ba..a5145ad72cbf 100644
--- a/samples/bpf/tracex4_user.c
+++ b/samples/bpf/tracex4_user.c
@@ -53,7 +53,7 @@ int main(int ac, char **argv)
 	char filename[256];
 	int map_fd, j = 0;
 
-	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
+	snprintf(filename, sizeof(filename), "%s.bpf.o", argv[0]);
 	obj = bpf_object__open_file(filename, NULL);
 	if (libbpf_get_error(obj)) {
 		fprintf(stderr, "ERROR: opening BPF object file failed\n");
diff --git a/samples/bpf/tracex5_kern.c b/samples/bpf/tracex5.bpf.c
similarity index 100%
rename from samples/bpf/tracex5_kern.c
rename to samples/bpf/tracex5.bpf.c
diff --git a/samples/bpf/tracex5_user.c b/samples/bpf/tracex5_user.c
index 9d7d79f0d47d..7e2d8397fb98 100644
--- a/samples/bpf/tracex5_user.c
+++ b/samples/bpf/tracex5_user.c
@@ -42,7 +42,7 @@ int main(int ac, char **argv)
 	char filename[256];
 	FILE *f;
 
-	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
+	snprintf(filename, sizeof(filename), "%s.bpf.o", argv[0]);
 	obj = bpf_object__open_file(filename, NULL);
 	if (libbpf_get_error(obj)) {
 		fprintf(stderr, "ERROR: opening BPF object file failed\n");
diff --git a/samples/bpf/tracex6_kern.c b/samples/bpf/tracex6.bpf.c
similarity index 100%
rename from samples/bpf/tracex6_kern.c
rename to samples/bpf/tracex6.bpf.c
diff --git a/samples/bpf/tracex6_user.c b/samples/bpf/tracex6_user.c
index 8e83bf2a84a4..ae811ac83bc2 100644
--- a/samples/bpf/tracex6_user.c
+++ b/samples/bpf/tracex6_user.c
@@ -180,7 +180,7 @@ int main(int argc, char **argv)
 	char filename[256];
 	int i = 0;
 
-	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
+	snprintf(filename, sizeof(filename), "%s.bpf.o", argv[0]);
 	obj = bpf_object__open_file(filename, NULL);
 	if (libbpf_get_error(obj)) {
 		fprintf(stderr, "ERROR: opening BPF object file failed\n");
diff --git a/samples/bpf/tracex7_kern.c b/samples/bpf/tracex7.bpf.c
similarity index 100%
rename from samples/bpf/tracex7_kern.c
rename to samples/bpf/tracex7.bpf.c
diff --git a/samples/bpf/tracex7_user.c b/samples/bpf/tracex7_user.c
index 8be7ce18d3ba..b10b5e03a226 100644
--- a/samples/bpf/tracex7_user.c
+++ b/samples/bpf/tracex7_user.c
@@ -19,7 +19,7 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
-	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
+	snprintf(filename, sizeof(filename), "%s.bpf.o", argv[0]);
 	obj = bpf_object__open_file(filename, NULL);
 	if (libbpf_get_error(obj)) {
 		fprintf(stderr, "ERROR: opening BPF object file failed\n");
-- 
2.34.1


