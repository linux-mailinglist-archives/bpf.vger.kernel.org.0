Return-Path: <bpf+bounces-50914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E467A2E3F3
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 07:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5983188A5C6
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 06:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015EF1B87F4;
	Mon, 10 Feb 2025 06:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ta+AkYtA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB77A1B87E8;
	Mon, 10 Feb 2025 06:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739167220; cv=none; b=bBjcVdY+8uMu/vWX/jfC0QfHNmua+NYnjkst26O9WGMPzxYDuz/ucr61eGbxXfz3Me+IdN2z6Xt6HG0qAyL8gx+X4hsN/31mEOWyXd98Rh8i+OA1qi2HADN9rl1QJ1wCNuZey1XtXS5H0W7NQ5pMC+aFf/wSfqux99MHNM9Tpjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739167220; c=relaxed/simple;
	bh=PY6XNUzqc+H9K218+W3EFKgLkxo7/WqXTO5hPAkkWCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BVzOclegJJMvk+tFKgAG4F3Il+lGfPIO1VpTILspxcVuBjip3NJbCorj6M27AJMOqGDpozlySmczgtSe/75qmrcI82vF8/2+Wtn1II6iYglWftRAF/EoUevcMW/UIb0AFIsFtOvDrm5iNcS/sQ17MK0MVZwximtQM18vXlbc0hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ta+AkYtA; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fa1a3c88c5so4729074a91.3;
        Sun, 09 Feb 2025 22:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739167216; x=1739772016; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FkJJlpo41q9zCzC63w5CBDZ+n3TrS/5Ia9tIzvwy+5M=;
        b=Ta+AkYtAut5wPrlZUx8DV9/PEmzocWmhJjwYeGhNoW31sNYnhUzEMSOZaRwNMaOqOE
         f4AGmKCALLuVlTAQXF9D7RL1MpnOFhY3G6Jn12J5eRPt8yn4O35UUJTqklU/gwdnQ3hx
         umsIEGEePtTWET1+wqOXyHCA50EoKBot9+ZZYrgroaiFUjvgehPZJCUh9b3jbRF0abnT
         Bv4n6cE1o03pmra83ld6CvYl2xVfUqo/zkULh+4164Lv+0GwLX/LjUHTmV/UrCrOHX7s
         CIbKcqzPntYd17GX8omqMMMj0rmbZwtGGOW23K07rVbt5M3YIeRAefOtshmYOCkph0zB
         N65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739167216; x=1739772016;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkJJlpo41q9zCzC63w5CBDZ+n3TrS/5Ia9tIzvwy+5M=;
        b=bgxZYnoJLutFWbKAAGeWb48wuGLVt4cK1zANFeiNGOHUUnlON4236nuXlVR8YvwLV9
         rWJAcHxPXGiuoP1HLcGZCzhyq1qpPGLQhLyX3h1ZicRE6X86HD82cLGwKz5nvbbnnAoQ
         wSkUoUjnjcAiDgnosGKbTkkInjMhgcv4U/zJpWecsNp8rzOjRKM4r+7EdjsmX6pLyoYX
         AO7/POxEt9fN791vwH0217h3aMgdUw6OaQ6JRVRuozlD4esXhcewGqNwks311AfSoQ/N
         osAUmVYB47C6rRRuldsEQ/O9qEiOTA7tbBGKJfzFT2NqFfmUpozh5yWWdoTNM0PB47l5
         WP4w==
X-Forwarded-Encrypted: i=1; AJvYcCUFmGVOUSvAjMMHG6pnlWrfm9YBaramdC9h3nOJyIDmKmlUFwiFZxLBU50y/HjJfJrILJokdWggiYXVq6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiDuNCCY92nOcdKSGg6GwhJt15b5uu3zPThR8WzgU6Gk395JQo
	I9FiNoIIReb8mdo11XRo5Xij9R8us/HLSis8MM4XplLHiwA3hHIa
X-Gm-Gg: ASbGncvpoaRC1oC7N5LVz2pb6IOu2KyCO5O6VN8aIx9Mk8DgRdyhpxr/sw/6/4yqaSy
	23/3sFb4waN4EUQSTYKLDrnlgcC6O5dACX6OlioipU0yf8X5+HKO8H4Xx9EAS1rywOvUkvl5nVi
	4EVw2wb4feBSHJOtPeglbnzhZWPo2309p5l9iqtmWjrXlBC+LiGiPeKFRgAG9T0QBJvWhGXkcJQ
	JIkH09WALL6zWOn2plkSAWEqOIvXV9YCKH3uh8/PsNbQHezTzmOY0M//OUNziUtRMp+ymillxI2
	Gzg6rkmJJwy2Y415
X-Google-Smtp-Source: AGHT+IE4+JZ3fpF1IFnoB1xhve7M6dOh0jjAAB5tGlX04SYfeL+uhvbmMTgrYqMv8QP4BSxxo1WICQ==
X-Received: by 2002:a17:90b:3ec1:b0:2fa:20f4:d27f with SMTP id 98e67ed59e1d1-2fa2450d1d0mr17252892a91.32.1739167215949;
        Sun, 09 Feb 2025 22:00:15 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa0f71b6dbsm7382479a91.27.2025.02.09.22.00.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Feb 2025 22:00:15 -0800 (PST)
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
Subject: [PATCH bpf-next v5 4/4] selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests
Date: Mon, 10 Feb 2025 13:59:45 +0800
Message-Id: <20250210055945.27192-5-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250210055945.27192-1-chen.dylane@gmail.com>
References: <20250210055945.27192-1-chen.dylane@gmail.com>
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
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
index 4ed46ed58a7b..fc4c9dc2cbed 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
@@ -126,3 +126,121 @@ void test_libbpf_probe_helpers(void)
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
+		if (err && (errno == ENOENT || errno == EPERM))
+			return 0;
+		if (err) {
+			err = -errno;
+			return err;
+		}
+		fd = bpf_btf_get_fd_by_id(id);
+		if (fd < 0) {
+			if (errno == ENOENT)
+				continue;
+			err = -errno;
+			return err;
+		}
+		len = sizeof(info);
+		memset(&info, 0, sizeof(info));
+		info.name = ptr_to_u64(name);
+		info.name_len = sizeof(name);
+		err = bpf_btf_get_info_by_fd(fd, &info, &len);
+		if (err) {
+			err = -errno;
+			goto err_out;
+		}
+		/* find target module btf */
+		if (!strcmp(name, module))
+			break;
+
+		close(fd);
+	}
+
+	return fd;
+err_out:
+	close(fd);
+	return err;
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
+	if (!ASSERT_GT(fd, 0, "module btf fd"))
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


