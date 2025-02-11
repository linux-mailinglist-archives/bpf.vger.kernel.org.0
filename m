Return-Path: <bpf+bounces-51141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B70A309CE
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 12:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3AC188B897
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 11:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7041D1FCFF0;
	Tue, 11 Feb 2025 11:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtZ1w82h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8419A1C9EAA;
	Tue, 11 Feb 2025 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272759; cv=none; b=MuIacikkVKUNZHJX4PFKSc+ChLRuSg7CRSQQjRMjCTvRtpBFRLytBlF7F6J0ks+6ikJX42gBy7UoZXI3A04SZ+/sO2JxTzYCWSV4+y0lKmpHDHcyDHQ+T7jdvK84VqhM1uFslOFRvkgmM0xxGjazUtxPc3wsp4ELXpgHCNPXg1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272759; c=relaxed/simple;
	bh=E7SZXQq5YlFZ6fUQ6IuGV0KL/zucE+o2sgmwFMcqVpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BcbyaZ7DHs3W57wlPqnWpVlTxlEs63hiE1l+/QBkuRTT8dwp/JFk9otgAkt1qSrbjQB1BKMId8tdRzMxdnob+wb5cxos6qybCWeZGq+T5nndyFJBMK7RAjHGy0m8m5boDpteu9+uSt3MFT0/2ZZMOjh67GG464esbCWNaXBcmkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtZ1w82h; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f7f1e1194so63881275ad.2;
        Tue, 11 Feb 2025 03:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739272757; x=1739877557; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tU3r4r0E6nNNQO3DTHrSmmHGy21FgVrpejWGxdhhNPo=;
        b=YtZ1w82hgN9nJzyO/1fEMBmJ5o+c5/+0Y0JNKbawpigM09Kbl7gksWypT3YU8fdFOK
         RBGbN6nAFbpkrjFxDGyfvK3O1ag/pl5GR9hvgN/QPIkWwLL+g/cYmmns+VjMRgIF9Tn1
         A0gE/WFJaSIKuFGjbikEQuSQaK1jRck37X0Sp8fmrDQ4gXtubtJoedCcGqSgdIufTYNy
         JrXDxhpINYtQGwq+lkOuNxCPfTYxow7v1xQl58ktcl9ryaed6SL+cEj9TmKslzLX65o3
         jDq3dcve2GpSdJTbJaPoqSIoEzOLMy6aiU4jOlLhM5nUmI8pl26FYgaQw66w45kBmyJ6
         JNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739272757; x=1739877557;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tU3r4r0E6nNNQO3DTHrSmmHGy21FgVrpejWGxdhhNPo=;
        b=inhn1Vx5cl3kvPNj04/EOdRn9SDLrRYF4etK6q3DreC1cMXM0SW6h6vMw9dt0GMRxW
         m6NoTGscaW2t74PAjuJCeWw/IyaXVBT7r+WeJHYav+49Lz/GHazag5gMKgGVwFTZi0q5
         7kwPYHDgx+Zjd64TKSjmfrL1/LVUvW9IQ7qrOeUn0LcKNzN31aFvAMGSJJwS4si8ih1I
         BWbl6mufQAAjyJmArEyrKIRrfzXwXuN8pPQeKRmp6fzMYLRJV3TYiE31u+7PbNVSBYb3
         EpGjSjn0uxhkJ7dJ/J3cXu+mm/hfDZ2td6dVzkveOb+NEspZfkxI6AFcDnkT5p7PYjEo
         ih+g==
X-Forwarded-Encrypted: i=1; AJvYcCUVrEWaAm/YAqVruihxhk3lXew/IjKrYNEtE7yAIvY91QGCfDvUpk7aAC4/VQ62mbR35y0yPTMvpXuMMTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza2Mt6G7GM1pismtkE+zP/KBLGFjL4IxL0W8c0/6U7Axhfqai+
	rxNnvJbw5llzu8TEhN130dN/te3UM80YnkbiTU7JG1p5Qjt9kfgF7GiH6Q==
X-Gm-Gg: ASbGncsdyni0lgN5gznoLPFCUtCIKM1EaIQh3Dkv/M81yPRoYo/pFFnm/X9Mq47XDei
	8aPglQAQOGMbUv/vyPLrthM/L4Evuxg5TkhZRjU3EnONE02ngJbjrpn+QpU4jb1M/eZ+K4vuLvR
	a6/LeHPPj2km/EX02ipGWykywKldipl54jqoxJOkkIYfppELyOquUGEWYJFewdZn3y3hEWBAdfR
	cNl2cVA4ULwRxr4TtechtFHdpsuK4puUIB9102ZeB9/jX1QlrsQMf9Fy0u+hj7PaDA0tKKZCaO5
	zWJEuLZCHozSnTcF
X-Google-Smtp-Source: AGHT+IFhOki/rd+yezkWNKwxrO2Edf/DThIs4v+8qzJy3UrvtlKb6441PGHb71zPDlZiAJRtzlnI5g==
X-Received: by 2002:a05:6a00:2916:b0:732:1eb2:7bf3 with SMTP id d2e1a72fcca58-7321eb27dcbmr3005173b3a.21.1739272756735;
        Tue, 11 Feb 2025 03:19:16 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048adb158sm9411906b3a.65.2025.02.11.03.19.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2025 03:19:16 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: [PATCH bpf-next v6 4/4] selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests
Date: Tue, 11 Feb 2025 19:18:59 +0800
Message-Id: <20250211111859.6029-5-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250211111859.6029-1-chen.dylane@gmail.com>
References: <20250211111859.6029-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Add selftests for prog_kfunc feature probing.

 ./test_progs -t libbpf_probe_kfuncs
 #153     libbpf_probe_kfuncs:OK
 Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
index 4ed46ed58a7b..96352fb657e5 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
@@ -126,3 +126,114 @@ void test_libbpf_probe_helpers(void)
 		ASSERT_EQ(res, d->supported, buf);
 	}
 }
+
+static int module_btf_fd(char *module)
+{
+	int fd, err;
+	__u32 id = 0, len;
+	struct bpf_btf_info info;
+	char name[64];
+
+	while (true) {
+		err = bpf_btf_get_next_id(id, &id);
+		if (err)
+			return -1;
+
+		fd = bpf_btf_get_fd_by_id(id);
+		if (fd < 0) {
+			if (errno == ENOENT)
+				continue;
+			return -1;
+		}
+		len = sizeof(info);
+		memset(&info, 0, sizeof(info));
+		info.name = ptr_to_u64(name);
+		info.name_len = sizeof(name);
+		err = bpf_btf_get_info_by_fd(fd, &info, &len);
+		if (err) {
+			close(fd);
+			return -1;
+		}
+		/* find target module btf */
+		if (!strcmp(name, module))
+			break;
+
+		close(fd);
+	}
+
+	return fd;
+}
+
+void test_libbpf_probe_kfuncs(void)
+{
+	int ret, kfunc_id, fd;
+	char *kfunc = "bpf_cpumask_create";
+	struct btf *vmlinux_btf = NULL;
+	struct btf *module_btf = NULL;
+
+	vmlinux_btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
+	if (!ASSERT_OK_PTR(vmlinux_btf, "btf_parse"))
+		return;
+
+	kfunc_id = btf__find_by_name_kind(vmlinux_btf, kfunc, BTF_KIND_FUNC);
+	if (!ASSERT_GT(kfunc_id, 0, kfunc))
+		goto cleanup;
+
+	/* prog BPF_PROG_TYPE_SYSCALL supports kfunc bpf_cpumask_create */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, kfunc_id, -1, NULL);
+	if (!ASSERT_EQ(ret, 1, "kfunc in vmlinux support"))
+		goto cleanup;
+
+	/* prog BPF_PROG_TYPE_KPROBE does not support kfunc bpf_cpumask_create */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, kfunc_id, -1, NULL);
+	if (!ASSERT_EQ(ret, 0, "kfunc in vmlinux not suuport"))
+		goto cleanup;
+
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, -1, -1, NULL);
+	if (!ASSERT_EQ(ret, 0, "invalid kfunc id:-1"))
+		goto cleanup;
+
+	ret = libbpf_probe_bpf_kfunc(100000, kfunc_id, -1, NULL);
+	if (!ASSERT_ERR(ret, "invalid prog type:100000"))
+		goto cleanup;
+
+	if (!env.has_testmod)
+		goto cleanup;
+
+	module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
+	if (!ASSERT_OK_PTR(module_btf, "load module BTF"))
+		goto cleanup;
+
+	kfunc_id = btf__find_by_name(module_btf, "bpf_kfunc_call_test1");
+	if (!ASSERT_GT(kfunc_id, 0, "func not found"))
+		goto cleanup;
+
+	fd = module_btf_fd("bpf_testmod");
+	if (!ASSERT_GE(fd, 0, "module btf fd"))
+		goto cleanup;
+
+	/* prog BPF_PROG_TYPE_SYSCALL supports kfunc bpf_kfunc_call_test1 in bpf_testmod */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, kfunc_id, fd, NULL);
+	if (!ASSERT_EQ(ret, 1, "kfunc in module btf support"))
+		goto cleanup_fd;
+
+	/* prog BPF_PROG_TYPE_KPROBE does not support kfunc bpf_kfunc_call_test1
+	 * in bpf_testmod
+	 */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, kfunc_id, fd, NULL);
+	if (!ASSERT_EQ(ret, 0, "kfunc in module btf not support"))
+		goto cleanup_fd;
+
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, -1, fd, NULL);
+	if (!ASSERT_EQ(ret, 0, "invalid kfunc id in module btf"))
+		goto cleanup_fd;
+
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, kfunc_id, 100, NULL);
+	ASSERT_EQ(ret, 0, "invalid btf fd in module btf");
+
+cleanup_fd:
+	close(fd);
+cleanup:
+	btf__free(vmlinux_btf);
+	btf__free(module_btf);
+}
-- 
2.43.0


