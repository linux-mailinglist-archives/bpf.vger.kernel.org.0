Return-Path: <bpf+bounces-53700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E20A5899C
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 01:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE1E188BB41
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 00:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65E18F7D;
	Mon, 10 Mar 2025 00:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV4IFhSn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90906FB9
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 00:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741565628; cv=none; b=sBLTQscwAHM/0iW0cq70dbIhULGAiT+ENb3sVKk8Z45vRYYtvo+9YYKk0u0pvb/Kk2+NZS92704HzwAg+omyoGyR/qlcNySymJsXjNjOJGrfZP/aPHqIABxEJLb7iMRIGF5HTRnX76z1jMAszKfaE4u1fzSiB8l4AmXXWOEOOy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741565628; c=relaxed/simple;
	bh=tPfOISyTomxE0PK1qymV2CFghcYkSGVu5uIhSdTYgXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMNSKNjRHvWtVyN70Cro61MHWfmF9bt9sDYauIdNKRkJ/Yt2psVovQ8sN/2PAHWkXyNqDml4Q7FdbwIyZR0yP3xOSDphJIkPExSX35yR1dD+WCDiarKKeUzF26o+H0SfX0f7Tkli4RVzaGfnghKkRxhdz6zkOBMc9XupT14dtwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jV4IFhSn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bc48ff815so20823405e9.0
        for <bpf@vger.kernel.org>; Sun, 09 Mar 2025 17:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741565625; x=1742170425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIcl+Fhy4bXXisU8YWVearNnfy+maQSoiKTaRtHzSYk=;
        b=jV4IFhSnm1ejYeSwmuWIEN3zplfDBk5lM4TavG3xBr1jWglxEf5+5KPYqnj/0Xaba+
         3ConJRZEpPWLWku3Ef4v2uSgEzWqRyyXtCSWPpoiTMzBURot1P67UXxgHCdu9+vSsUQH
         I59YHw4F+i3kh54oEZSoujmGe0tpIlCfZk1/J0MuN5DKIx5Wesgasgzou2UqXGaOHXka
         DsvUQ9C0nKOp4SIjAeSFgaVY/uLu4x2E12KV5UzFy9PFvFb/G+zQ2uwuYaLJCr/EIRUX
         8VDHHrb+EWTQFYUba5ZlxePqI48G5z/943vm+PSusIRdSERCjD6JGZbB30P53d2oVDy5
         ayvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741565625; x=1742170425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIcl+Fhy4bXXisU8YWVearNnfy+maQSoiKTaRtHzSYk=;
        b=D7z1I+TmJKdsPUcBSa08qxc5F3XeP4m2qCsJ2UHvqG5hYpQQQtdgCEOxQDhgKE+Vca
         bKskJqXjp33yIo1AxlwrCJLESsRpKOqGcBSVYONRIj+JLtQPtBnHaOA2P/5e1uqdejKX
         zzdx0FrCWizsTikZYgskgm6voprV6dbSaCQG0pQrVBdPQrGgqG7xZL/3LZUWSL6ocMj2
         JF8YMckeOso275PpHfX/qxCh3mN1m/BclOZCGGss/Vr/06kJEzoqP50P72eahbmt0aGj
         1ISXZLbXx/RssRzy6fQHYjBOocvDK+1dQk41PVIBbfw4YiVYoajKYZ8Xyi7ER1vQ0vJo
         SRbw==
X-Gm-Message-State: AOJu0YxVCV+Guqn60zFbTiQIFSqwQ7rkQjA5xWIxfQqGV6H8CYGyv1g6
	3L292EEPuUqXGCB/wkp33zYvgqU9SQjwPpxkd90WcHl9Ch+1cf+sVuADUA==
X-Gm-Gg: ASbGncvtFe5/FXF+Pd17Xyrv4ou8ttYrSeJ8bCh6dz5uLmNlqqaMgF5ePgMzppqoVUe
	iAlAclpmDiBCrn/QwHxRjZzL9qYmyDGtqQ16conTFcnSwsdtX9xlKxfKpZdfqwq6G2V7+ZL/5b8
	JgRBu/JsFVlnI9vp9xYhf8TictgLuY9ng9Ko4nCSZa7fuUJUqIHpWDfl4llHYUfjs2EbbbfAVmh
	TmApJUyWnQty2nBDBDXXI/EdaPTY+FnQDjN36pYlmpLFdy9nYLLXFiwOk1FxM8ZtaGVft6hFctI
	HAq/NaLri/9GLlDQVk/D+EobR9Dtt/ax5nGvqaHj6zwVyJTdT6/0bNzCe2GIgvOavr6dqrwYK7J
	2BRTbIggFuekHU0yyCqhiJKWv4H1IefkYIupITnv0xBolBzzxIA==
X-Google-Smtp-Source: AGHT+IHx2ZUOOgqkQI67Fo84LFUqbglcMJhTcJbpGbUx9PvSdInFHSyPshx/TD/vQIm89MXuPseXQQ==
X-Received: by 2002:a05:600c:a47:b0:439:9434:4f3b with SMTP id 5b1f17b1804b1-43ce4ad68a2mr39854175e9.8.1741565624723;
        Sun, 09 Mar 2025 17:13:44 -0700 (PDT)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm13181050f8f.0.2025.03.09.17.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 17:13:44 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	olsajiri@gmail.com,
	yonghong.song@linux.dev
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 1/4] bpf: BPF token support for BPF_BTF_GET_FD_BY_ID
Date: Mon, 10 Mar 2025 00:13:16 +0000
Message-ID: <20250310001319.41393-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310001319.41393-1-mykyta.yatsenko5@gmail.com>
References: <20250310001319.41393-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Currently BPF_BTF_GET_FD_BY_ID requires CAP_SYS_ADMIN, which does not
allow running it from user namespace. This creates a problem when
freplace program running from user namespace needs to query target
program BTF.
This patch relaxes capable check from CAP_SYS_ADMIN to CAP_BPF and adds
support for BPF token that can be passed in attributes to syscall.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/syscall.c                          | 21 ++++++++++++++++---
 tools/include/uapi/linux/bpf.h                |  1 +
 .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c |  3 +--
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index bb37897c0393..73c23daacabf 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1652,6 +1652,7 @@ union bpf_attr {
 		};
 		__u32		next_id;
 		__u32		open_flags;
+		__s32		token_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 57a438706215..eb3a31aefa70 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5137,17 +5137,32 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
 	return btf_new_fd(attr, uattr, uattr_size);
 }
 
-#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_id
+#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD token_fd
 
 static int bpf_btf_get_fd_by_id(const union bpf_attr *attr)
 {
+	struct bpf_token *token = NULL;
+
 	if (CHECK_ATTR(BPF_BTF_GET_FD_BY_ID))
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
+	if (attr->open_flags & BPF_F_TOKEN_FD) {
+		token = bpf_token_get_from_fd(attr->token_fd);
+		if (IS_ERR(token))
+			return PTR_ERR(token);
+		if (!bpf_token_allow_cmd(token, BPF_BTF_GET_FD_BY_ID))
+			goto out;
+	}
+
+	if (!bpf_token_capable(token, CAP_SYS_ADMIN))
+		goto out;
+
+	bpf_token_put(token);
 
 	return btf_get_fd_by_id(attr->btf_id);
+out:
+	bpf_token_put(token);
+	return -EPERM;
 }
 
 static int bpf_task_fd_query_copy(const union bpf_attr *attr,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index bb37897c0393..73c23daacabf 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1652,6 +1652,7 @@ union bpf_attr {
 		};
 		__u32		next_id;
 		__u32		open_flags;
+		__s32		token_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
index a3f238f51d05..976ff38a6d43 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
@@ -75,9 +75,8 @@ void test_libbpf_get_fd_by_id_opts(void)
 	if (!ASSERT_EQ(ret, -EINVAL, "bpf_link_get_fd_by_id_opts"))
 		goto close_prog;
 
-	/* BTF get fd with opts set should not work (no kernel support). */
 	ret = bpf_btf_get_fd_by_id_opts(0, &fd_opts_rdonly);
-	ASSERT_EQ(ret, -EINVAL, "bpf_btf_get_fd_by_id_opts");
+	ASSERT_EQ(ret, -ENOENT, "bpf_btf_get_fd_by_id_opts");
 
 close_prog:
 	if (fd >= 0)
-- 
2.48.1


