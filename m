Return-Path: <bpf+bounces-53390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD38A50BE9
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 20:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6161887534
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 19:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976F9254B08;
	Wed,  5 Mar 2025 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGYqaOxU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721E9253B57
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204196; cv=none; b=Zc8P04+15XwGjGN9xj2zW2Z+HBxEl14FhD7hatUsM+qvM8daRqy5YfE1xw8WY0PllTmEujLf0diY2r7+TzBldgKpG6RT6vlCGGmjhJtpopyzvtFh/11wMujFiXfaQ3AAOo7JXhNlnJrK13OSndAe1QUdc8w5PlS2m92FOeUfti0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204196; c=relaxed/simple;
	bh=0aQpqSPAWSvw/fnjFxU5Fimtcm1PgbgdFs9AhfBppoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2V5iz4WZWLhUnfeAFbum+4vGIXoC9XfHgz3hmAUpLf+3v573KdRbrCVk8pjXqvBm0ZVKtGlG0S6mEF+okMo+7jwt6k9ybXbJ7eRHwIYl+d7MtYlQLsk+MswSlDGaMSbrIVSKvPovMuQRhnj9kfV6mhZTjHQi6ny/p9Pkwlh02o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGYqaOxU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so890560a12.0
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 11:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741204192; x=1741808992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXCC/BiZJf0MIv5eM7fL+xOBQ5STiWqcOMTzsS+3enc=;
        b=FGYqaOxUxCyAjyZFH4NKqiPvDw4YrSKiPzPQyJ2lb0aSbhuZn8GbuB5YaUSiFNH9gy
         IPf8XM6bB2yXopPAGi9L1nbFu4Gp+GDd/c+wP3fVWc9S8s1RhndoqIp1HTznohC92wW0
         3PBrLqXd2eciM6tLfp1taj8KNTCxxGSuDnOHpVEpXuD4KEZuVI8jIYQ9USO1vhi9sPAn
         XdEdqN7sh/c5tP+AEVTmmOvxLozhf4wwMvBWU/WShAPISyobffPYQ/B/dwgk8bQW7/Eo
         1h84Ks1Pz7BQM7KP06ytyvpx7FkS4Bi8yzpQOZm4AxQ1C2u9kIYGWQQaWAXqkuVU34yf
         FkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741204192; x=1741808992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXCC/BiZJf0MIv5eM7fL+xOBQ5STiWqcOMTzsS+3enc=;
        b=jDt6qTGwvWaitslDjfPSf+8dDVsF2AV2vfzO0r0n9qXBEC4V/HriMTVacVWCbH4jjO
         KlyXvuf/GjD7Yc/lgpJBPxKNoyxz6aYcqL2w6098+LYFnQ1E1wf/E9EAYPyzTuwFfK+c
         cnEX/mQzDaN/FQJTYhT0x1goTdv3AS1WU81jx1phpxSu8Grazq0dMI1+cFRgV3HkYMY2
         v+f/HHufAe/NoyYstRi+zVHbwoR3CsqDqaDHk+C93ZX9upbm+PHeWh72vkxnlSJ9HkPx
         rpMAENZU0OYRA9za8nvuXtd9Biy4jGumfwEN20Tp/tb+OObE8bIhFKvFz9Ad3KSbatp6
         NGhQ==
X-Gm-Message-State: AOJu0YyN1GXZAZ+rTCmU1em7llUBR4XieW4zpLnew5q6GmRunOGxRkMC
	wJa+CYJuuiEnTfNGms2vxm/Sgq1o5bosto5k/HLgrh8jHAwod2Dg6xz+Eg==
X-Gm-Gg: ASbGncuVYppQxoIaGmW5OgSsKOfYVxfpMfdh0b/KzXWJPY0dZWxC13j37cz8nAE+6uV
	gBRz0l7kXIZGtVew/5nDrqz+uxMK+G1m+JxsUHFw4OMkG6xX2c9A2f8ZxMVCGFYasdJkfX2uCOF
	2XZdiJyIaeaAw05UZg4WMV5qnJkj+xvY7SB/KCOGMciw/lE5I8FcCd3xo5xg6qADCsM4GVOnK3p
	UA940ns1tDGUuPJ7m/mJHUJdZQXYz8T95kiezW4pnfwP8hkV5Dr0WFJVGE/TszpRX3hNtX5aqCw
	OmQOQXaTrfjq5sLDmxjhge+sOgGQjGGqxj1fII9wgb/zRKPBhT0S7b1NNXc=
X-Google-Smtp-Source: AGHT+IGzWaDHioGDd6L+Jjm/648EuV8vxMceRkRQP4ekQklq4YMX46o9k23KUbxKZxTH9UrbKSSxjQ==
X-Received: by 2002:a17:906:f584:b0:ac0:3d5c:4fc6 with SMTP id a640c23a62f3a-ac20da51dadmr437124166b.27.1741204192184;
        Wed, 05 Mar 2025 11:49:52 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::6:4624])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1daea1cd2sm481584066b.181.2025.03.05.11.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:49:51 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 1/4] bpf: BPF token support for BPF_BTF_GET_FD_BY_ID
Date: Wed,  5 Mar 2025 19:49:39 +0000
Message-ID: <20250305194942.123191-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305194942.123191-1-mykyta.yatsenko5@gmail.com>
References: <20250305194942.123191-1-mykyta.yatsenko5@gmail.com>
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
 include/uapi/linux/bpf.h                                 | 1 +
 kernel/bpf/syscall.c                                     | 9 +++++++--
 tools/include/uapi/linux/bpf.h                           | 1 +
 .../selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c  | 3 +--
 4 files changed, 10 insertions(+), 4 deletions(-)

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
index 57a438706215..6975d391bb05 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5137,14 +5137,19 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
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
+	if (attr->open_flags & BPF_F_TOKEN_FD)
+		token = bpf_token_get_from_fd(attr->token_fd);
+
+	if (!bpf_token_capable(token, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	return btf_get_fd_by_id(attr->btf_id);
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


