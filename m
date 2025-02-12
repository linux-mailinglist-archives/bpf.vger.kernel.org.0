Return-Path: <bpf+bounces-51270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48327A32A41
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A071670D5
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ECE253340;
	Wed, 12 Feb 2025 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NokHx3LO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCDB250BF1;
	Wed, 12 Feb 2025 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374771; cv=none; b=uvNhCMrvVxm3ori2Vi6GcU3vFPzjOgu2MSvBQ0PQApFMe7y21RC1oJEU/Y0+QH5dvlPf/hT5jlr02gjvWhkL0lBDFrtl9xTSv/IeXZJS5+TB8xxCF+JiwamPlG/i1TXmVgZTQlvaU4TVuacpNrdDuQKeFt0KslxuWXRTxRmTFn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374771; c=relaxed/simple;
	bh=YsiNlyiHQ9d6W2tDHYhJHKwP2PsIzM6e+uSXKvMPjI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Crv+idxDbFS2G9GCMqtGd4KW9SY0y1Q0dxy2pl4WPMJy/WD9dOJWNvD/qnOD7+bw2nELQcYrMH9k+LOpSgp8I4lGO1ih3Vc6KkG3Xr95mx1MgJXfdrAzHdgx5+i4Ci7T3WcAemPjn5mkvQFJmn3E46aI9jHL+8BotGHAaQ8dozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NokHx3LO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f7f03d856so76074625ad.1;
        Wed, 12 Feb 2025 07:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739374769; x=1739979569; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j+dEqt7IhqX28nFJ8Lafm8We0lyyX8DlOy63dc5352Q=;
        b=NokHx3LOdNyItHuN9Ew3hYR4BJS7j179RjkKM1cspeSaDLqJkL5TX2kHo4r7I6Sj0d
         zXvUXS6JRu31WjmDJ89F2x65KM5D7IBLfKVeyRtRRa6j9AD16wCe/IEw34JmQxukGNo0
         GjAHcPYCBGPh3QyehcaIxBl5N++8nwagy1JBh7peZ6wn4T7+/FmcX2nP4nZIHyJ3lbd/
         i2Q0/Ww3xqhgmhvwEwejTskEso1Sct+CGYkWAlNh1x0DRZ998BdFAG/XLUxSIQyuJ+nF
         eI881qgZCg9MwmZc+RL2AWOMGccpoIoDw1Ed3Q6rau7Nxy+nJPkmxeTdl2bASajLGstT
         y0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374769; x=1739979569;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+dEqt7IhqX28nFJ8Lafm8We0lyyX8DlOy63dc5352Q=;
        b=PFFqUKK8xb8GnM1/8thYSj8ZPR8T5RPLC/IQSTmfYe3SoglctObKjRoifHxO+mu/Tj
         viUUG3tvHQsBfQib3AzIe5PEHaZjRp+n+fCyUwvFobm/CPHgJLBE5MGR4GtyuiCdOfuI
         nTdiI+wf8ggZgGvFaikSUAaq4I5FUUV49TmxMxl5f+CeXS38ymSQAElMgUkyN8wK5Jah
         WW5RZlikviUtTF92U7eBdFTkbIHEUycF6oB69JKeUi35BcDxRYrAfqFjXgVeRs8UZb0f
         8EpVaotXXU7rS9FWZu52QP5+Vo0dX38Zv7bNXVBtkkl8Vam2f/vK47Q2Cc/YP/icVTpn
         y3HA==
X-Forwarded-Encrypted: i=1; AJvYcCWHnrUfAiMYy8w2Y6nJCfrmlbFFR90eKZIxM4Rc7IssIdcrs9zkDbM2afil07zkzJ8dK8vbCnJlocGIrMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy5JXkxUMxl3yplWU/TfluXbR+5Z0F5LqJT21MJMArXL+2e52w
	bvIM/RH+2UUiHcxHBFxTAsBvAKNsl2BQ6HCW7ODfRovYg9U76ywn
X-Gm-Gg: ASbGncvOakWiGMWXVyQc5SiDiF9OpELIbDTFVQ0eGahnPug30G1NAghKF2Lmr7SPK5G
	SL1P8quI6jpkzRfS6dUHkWA9mK67fBCbcQTB3BG0RNXrSVg45Zpq67uxgfql5RHSbdtgRDpgv15
	EgkbquXfsZBnyIttzmdUE5Yt18kQeeOJZqnPGkRb5evHE7nFe8Lv2hJLtZLTNniZnxlmWWHQgv5
	D8NNrkqbMI+m312cSoOPLkBuKO9rduPUMSyKCKRL1xjblEc+cJh05cuiO2hYQ814qclLa6mPrNf
	+X6xGNO1lxEIm1rP
X-Google-Smtp-Source: AGHT+IElq7kXyojR4GC522Tyxzjjv4dQ8RQv2qyhsakoUWW3qm1eodmykMDfQJavWjrVa1PKWFpIMQ==
X-Received: by 2002:a05:6a20:9145:b0:1e0:ae58:2945 with SMTP id adf61e73a8af0-1ee5c822982mr7347641637.31.1739374769091;
        Wed, 12 Feb 2025 07:39:29 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad540da6b6dsm7750843a12.39.2025.02.12.07.39.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2025 07:39:28 -0800 (PST)
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
	chen.dylane@gmail.com,
	Tao Chen <dylane.chen@didiglobal.com>
Subject: [PATCH bpf-next v7 4/4] selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests
Date: Wed, 12 Feb 2025 23:39:12 +0800
Message-Id: <20250212153912.24116-5-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250212153912.24116-1-chen.dylane@gmail.com>
References: <20250212153912.24116-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Add selftests for prog_kfunc feature probing.

 ./test_progs -t libbpf_probe_kfuncs
 #153     libbpf_probe_kfuncs:OK
 Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Cc: Tao Chen <dylane.chen@didiglobal.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
index 4ed46ed58a7b..d8f5475a94ce 100644
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
+		/* find target module BTF */
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
+	if (!ASSERT_GE(fd, 0, "module BTF fd"))
+		goto cleanup;
+
+	/* prog BPF_PROG_TYPE_SYSCALL supports kfunc bpf_kfunc_call_test1 in bpf_testmod */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, kfunc_id, fd, NULL);
+	if (!ASSERT_EQ(ret, 1, "kfunc in module BTF support"))
+		goto cleanup_fd;
+
+	/* prog BPF_PROG_TYPE_KPROBE does not support kfunc bpf_kfunc_call_test1
+	 * in bpf_testmod
+	 */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, kfunc_id, fd, NULL);
+	if (!ASSERT_EQ(ret, 0, "kfunc in module BTF not support"))
+		goto cleanup_fd;
+
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, -1, fd, NULL);
+	if (!ASSERT_EQ(ret, 0, "invalid kfunc id in module BTF"))
+		goto cleanup_fd;
+
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, kfunc_id, 100, NULL);
+	ASSERT_EQ(ret, 0, "invalid BTF fd in module BTF");
+
+cleanup_fd:
+	close(fd);
+cleanup:
+	btf__free(vmlinux_btf);
+	btf__free(module_btf);
+}
-- 
2.43.0


