Return-Path: <bpf+bounces-9696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF1D79C170
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 03:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24FF7281762
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 01:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2023E17EA;
	Tue, 12 Sep 2023 01:11:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA4217C8
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 01:11:20 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371979AF51
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 17:58:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52eed139ec2so4888433a12.2
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 17:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694480212; x=1695085012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62Tv26+GzZO2QOffDbc9TVLFHEBItRH7qqMDHFtHY4A=;
        b=JFMNZdhHCD/72iqcygwY7cEj2SB8u2H3aQu4I5B6A/Qpr19jxJfkq2Y6ZCDUUo5bNg
         nfl+y1HM61NMG7QuE/ZnPjLvA09dbkJdIIjd6gbKBkzJ+tiqFW7fl7La8dAhYvyem/K9
         E8zxyj+PxRns5+TTsu3j1pLgLStXypyoWq0Bx8q+AuN/cMS4qOOwp4S9IHgYcwGghD+0
         vUJaYS5DbVIaXeD0L2AQWNdaF/E+3m0zJZSOBzWUqNwt+9mUPoES1plraW8hMpBFZhaP
         IRCvuS2Ug4/Y6QT+R8AYiI+6/QDG8q6b9RZCpeGweq+pRb22gfZ7Yn44g8F8VtzNhni9
         DmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694480212; x=1695085012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62Tv26+GzZO2QOffDbc9TVLFHEBItRH7qqMDHFtHY4A=;
        b=nMAp2iJ1jSGFt3HUScKUuyeN9PGDO7F5BzQtVPPM2Ne4RvGoLXbPnm3XGSXnORptfy
         wsD1x+4yfZ8fUdPbZOeW8jIkfBz/RmiRxHn3wwKek//Fvc7LG528E2enpRuKF0bB1odT
         GF4Pb98mEHRb6jDzEmDeFsbuz1n3GpdgKh7g1uGkhCgtyH3QmASf0GMNsHbNAYo2NyJ2
         K4WrcJZrJv6cUQlBPmAbsyDv7roY3eWoq+HXyUwezSD3IoRclpyWKkBUfqNPaBzfXtGg
         bRQnARYNVWMS5knv/s+zr0aB0KifCIjEqRvuU41veM+twU5maWkwDYKQbXhlZZxldPQo
         WNmg==
X-Gm-Message-State: AOJu0YxdAczFezTGt1Rprn7L7YeRdnk4Dreiqfk8ToxjeYX6kz292UH6
	fprVaP4EqUMUR3qg2hajicn3O9PJ75+Fzw==
X-Google-Smtp-Source: AGHT+IFaTejynSwqYgBfG2Zyr7NVRDNewlCXJu5V6M8qPJbFoZj5kOaPPayQMOJ7+SPfBaKfi0IRsw==
X-Received: by 2002:a17:907:2cca:b0:9a1:bf00:ae52 with SMTP id hg10-20020a1709072cca00b009a1bf00ae52mr8565305ejc.62.1694480212047;
        Mon, 11 Sep 2023 17:56:52 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id gt33-20020a1709072da100b009ad854daea6sm272153ejc.132.2023.09.11.17.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 17:56:51 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	sdf@google.com,
	kuba@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Offloaded prog after non-offloaded should not cause BUG
Date: Tue, 12 Sep 2023 03:55:38 +0300
Message-ID: <20230912005539.2248244-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912005539.2248244-1-eddyz87@gmail.com>
References: <20230912005539.2248244-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Check what happens if non-offloaded dev bound BPF
program is followed by offloaded dev bound program.
Test case adapated from syzbot report [1].

[1] https://lore.kernel.org/bpf/000000000000d97f3c060479c4f8@google.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/prog_tests/xdp_dev_bound_only.c       | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c b/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c
new file mode 100644
index 000000000000..5ee4c16d2e21
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <net/if.h>
+#include <test_progs.h>
+#include <network_helpers.h>
+
+#define LOCAL_NETNS "xdp_dev_bound_only_netns"
+
+int load_dummy_prog(char *name, __u32 ifindex, __u32 flags)
+{
+	struct bpf_insn insns[] = { BPF_MOV64_IMM(BPF_REG_0, 0), BPF_EXIT_INSN() };
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+
+	opts.prog_flags = flags;
+	opts.prog_ifindex = ifindex;
+	return bpf_prog_load(BPF_PROG_TYPE_XDP, name, "GPL", insns, ARRAY_SIZE(insns), &opts);
+}
+
+/* A test case for bpf_offload_netdev->offload handling bug:
+ * - create a veth device (does not support offload);
+ * - create a device bound XDP program with BPF_F_XDP_DEV_BOUND_ONLY flag
+ *   (such programs are not offloaded);
+ * - create a device bound XDP program without flags (such programs are offloaded).
+ * This might lead to 'BUG: kernel NULL pointer dereference'.
+ */
+void test_xdp_dev_bound_only_offdev(void)
+{
+	struct nstoken *tok = NULL;
+	__u32 ifindex;
+	int fd1 = -1;
+	int fd2 = -1;
+
+	SYS(out, "ip netns add " LOCAL_NETNS);
+	tok = open_netns(LOCAL_NETNS);
+	SYS(out, "ip link add eth42 type veth");
+	ifindex = if_nametoindex("eth42");
+	if (!ASSERT_NEQ(ifindex, 0, "if_nametoindex")) {
+		perror("if_nametoindex");
+		goto out;
+	}
+	fd1 = load_dummy_prog("dummy1", ifindex, BPF_F_XDP_DEV_BOUND_ONLY);
+	if (!ASSERT_GE(fd1, 0, "load_dummy_prog #1")) {
+		perror("load_dummy_prog #1");
+		goto out;
+	}
+	/* Program with ifindex is considered offloaded, however veth
+	 * does not support offload => error should be reported.
+	 */
+	fd2 = load_dummy_prog("dummy2", ifindex, 0);
+	ASSERT_EQ(fd2, -EINVAL, "load_dummy_prog #2 (offloaded)");
+
+out:
+	close(fd1);
+	close(fd2);
+	SYS_NOFAIL("ip link delete eth42");
+	SYS_NOFAIL("ip netns del " LOCAL_NETNS);
+	if (tok)
+		close_netns(tok);
+}
-- 
2.41.0


