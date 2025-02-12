Return-Path: <bpf+bounces-51265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E579CA32A01
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C04A47A1464
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 15:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CAA2505AB;
	Wed, 12 Feb 2025 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hy3ARH4x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ACE24C679;
	Wed, 12 Feb 2025 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374116; cv=none; b=qa8uBB7qk2LtOAB6i7qIidKyTKeHN5WFdHEOHK6Rvr6WX2OOtUHZgx6F/n87gtmMsIXqUTnagihmkiqPu7fwercRGvuigIkMtnpfmlIqU6XShCyTMNVbtBJ8WC4bgnc1fif4zV4t7OfphVYhdMzddznrfutTaegpAJH+d/8udBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374116; c=relaxed/simple;
	bh=YsiNlyiHQ9d6W2tDHYhJHKwP2PsIzM6e+uSXKvMPjI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PKzR0P/9EXwsb6cqcg0KUZoJbTC8Ia+g5QCkZYu20RWYkSJEal2J2BHK/bYV5QNwfd8VVYCkW9JYn7V+h9KH5b/RAHnSwT+mLgpszUOdqgWBLwasREPuwl3+A6MwesNQ6qoyGXaO3ER6bOFnXOxiu5ePVBnMGZhdrqQfOFpXO5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hy3ARH4x; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-219f8263ae0so125186735ad.0;
        Wed, 12 Feb 2025 07:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739374114; x=1739978914; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j+dEqt7IhqX28nFJ8Lafm8We0lyyX8DlOy63dc5352Q=;
        b=hy3ARH4xPO2rioGw4YSuI90+zjwCSZTXgKbLjCNgmvon1OoiishBMke5jpwajegzn6
         pfzNZW26s9pgLCKZKp+GU6w0No87G1qfka0yrtJqaHEaLK1Yn9Jl0GOxF+yONDTA4D+w
         d8IRV77ejmA6vCDiLvLBoaiFSjatYHTaNP/RaupkrDWk4U4yoI3KNHdUjTes1wXpc3RF
         ktQQnwC5XPzd2CdeiVToML2Bcy8lNVEKDwiFf1Zaib0zIkAD92/e2t47ppsknrWF49EV
         QJbY/22BDkaJtP2kus/I73fNTpz6h+L8ZluhlLaPJTgichF5awoPOPKmuRHNKLHFPA2S
         9Osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374114; x=1739978914;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+dEqt7IhqX28nFJ8Lafm8We0lyyX8DlOy63dc5352Q=;
        b=rYrsYqmh3fRqtkiyP8QAnudV2zx2dc6wIRpSgcdZh3L7FfMjN1IB2MFEbPdZ3HcZQk
         qvWlLbYEsTHRvkTnO4e+IF3Vw1hOSA0PFJ6sRqazoAc9vo55VUiHj2C7A5p+KiMoC1lR
         gusDzkWzi0usS3QAGGoBvtynSE4nzlLOigVpMi5oH+HdpR2gFNrghDPkMsDsu512Fg0n
         Z65I/WTyHZfKcdI5UsuTLgGDPgGxLksOP02OaH0jB1anqBG8pvJGdvqIoJRPSMwyLty9
         XOdH45jL+cSy+mVcPL18Uo4cXF496zA5LhrWJMCOkfTa9xeukGkP50j8nc9MbSJ6LMT6
         e2QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOTEmBEPlINYgULYwMLPrlMvERCsQRPxZZvtBhk0QOX+gj6obwZkL2D/MoBlg2L8BNp016D7v2ecFCtpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKVVb8ecrqg0ThvQqtvf6TELpKxP5XS2LgxXMk0Eq+VbfWOfdK
	MVwoQoeGqYgNBfdbcM6gjwJoWVbS3fI52gBsSuR3Tfc0MDrZngjR
X-Gm-Gg: ASbGnctEsjXG1Z0nNdkSuyVtxiqoouysjIRKg4yX1MEQcFU191El89gYWqjEoXvU5Gp
	en5xEp02oshAukCBbSxxOiX95oKR7UfNs0MeigvLvjSyQMKL0U784XvhxGLPW6ltBin71jNwAMf
	VPmiBz0mnQ+NyYf36Q0F/JobRz5lffNfO7cZxvWtrODNg081d7vhA2YiUwp3AS9CCBZKfg/WX5x
	L6scLCWlKkYmn6iSrQ7/8UvcJk1Xtc92OOyFkCyojQz2/lqpkicBOoTMiRFKHilOMLV9CMHhNJz
	RfqeN4xE/McM58fA
X-Google-Smtp-Source: AGHT+IFRQAKpLCs4B5ITEvW85jYEiiaO7YsbKMAHs0d1bJXhm//DqA/UV9+RoOaZAMiTNt05J2jr+A==
X-Received: by 2002:a17:902:d512:b0:215:bb50:6a05 with SMTP id d9443c01a7336-220bbab103bmr46847975ad.9.1739374114082;
        Wed, 12 Feb 2025 07:28:34 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36511237sm114878525ad.2.2025.02.12.07.28.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2025 07:28:33 -0800 (PST)
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
Date: Wed, 12 Feb 2025 23:28:16 +0800
Message-Id: <20250212152816.18836-5-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250212152816.18836-1-chen.dylane@gmail.com>
References: <20250212152816.18836-1-chen.dylane@gmail.com>
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


