Return-Path: <bpf+bounces-20367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D182683D28F
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 03:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379491F2486E
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 02:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB038468;
	Fri, 26 Jan 2024 02:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4WxQqWz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986121C17
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 02:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706236292; cv=none; b=JUB9NZ9Jd6L4BmNIYTtVIcp0gp9iTk0NhBh4GpEnmoeDiHVn5F4h7t7oRdUXAmRSqMIEgtc6vj3tvjaDct89QvRXN2+rBVlQ4OFznwhWwJaHKEmw3dHP1nPi2ZeKElsnM4tGQWez4GTI3DWT1rh+1AYhNOFwEk+To+6PAMI8jyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706236292; c=relaxed/simple;
	bh=xcw8SLUfJhA72KZ+1EoVlescJDr/1+C4cke9b9OjGyI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YGgieYaXx1F4k2X0EO5Zm45fwImMFzDsQ5QyDeM1oPF16DsTHZJc3eXODO6kvuRy/zXvKkEfyQtSIUkYNpdj8c4JjQg8lb0y2k39ivUiABLMbkTBGBKjFMh17KtQL/TGtqoIuSoOrBBKEFEXwDjUxA7RWFpUQ4W05bwBNmvIdVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4WxQqWz; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-602cab8d7c9so1244067b3.0
        for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 18:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706236289; x=1706841089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AbBMIE5JyWcOYv6mM2GjC2s60/l/x76GhnsLVF42UMQ=;
        b=K4WxQqWz4vMF4L4mfziLyG+nzGPcy/+bdoverKbLJ7lkne2LSJLXph69XwhuoOGuUI
         GzY8UZUW0B1SIlgJkCJT36u1UXyka23wJfIK7qciCDQgr3mDcNifm5l3uSLudFJ91wBs
         fQJ5+YU4Rv5FThHGPXBS+YtqyT2Ale1m8SGCrb4IJF0HpEchRtLYW11LU9IedTaB8vYd
         prwd4U32vgE3g7h8rgjvQEaEJN1BHslJ2/pHoFfziOljRfSmJ92HU6ePDKg9Gmsus0Xi
         krHnAV+CQrzyO5BLKwrtQHkVadZgO5iYbVSCkEAOJRdZOSMkGAt/y67u4QhSMUuq9Pcl
         RePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706236289; x=1706841089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbBMIE5JyWcOYv6mM2GjC2s60/l/x76GhnsLVF42UMQ=;
        b=VwA6jM3YXPUdWQCwjIjpqTJZPSM6OfmCWr7B9cJnR4Otxzp3k2DQMOtXY8MwIvt1c9
         2BgdhgudhEWEvh2s/wCZCiG5j2AU+RBn4YDYIq3KQ5hVtdFy753+Mks9e06tfOyWM8Ib
         QCwvlEKAXvAqzYTbrafBUNozi6TdQvdz+d3sKwIVvvitcrOFCv0oO/ME7CXt/B0XEd3i
         wC5KWvDiUaSOY5R2Xmg40Eva9Rvm4Q1Bz12t8Zp4QjfiexaThDTFZVWLcRNVjHjUeW3P
         kt38OWRc2ogee4gdks2sZXSEFWbbgVnbkzs4qkIoJEQ9wd/IWoAxMysS9LAwdhqny+Em
         xpbg==
X-Gm-Message-State: AOJu0YyoJnua/3fMHIrA1zycCIh0YEXW//Yl/8wP0ZI//jasVDWp0R+z
	VZ97g1uk25bVkzCaCgArBOrBHorATqWO15Px7viQ9lIOwmPuYNpaBVZYiTtE
X-Google-Smtp-Source: AGHT+IEyd/7jwYxH3r5Ll+9TWSuO5yZXQ4CTNd9LM89C50RE5+I4mLZ/fqX+H8fU5Z33JxbqnUMkWA==
X-Received: by 2002:a05:690c:ec5:b0:5ff:5d63:1264 with SMTP id cs5-20020a05690c0ec500b005ff5d631264mr889075ywb.71.1706236288974;
        Thu, 25 Jan 2024 18:31:28 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:7fe3:b664:4bc2:43f4])
        by smtp.gmail.com with ESMTPSA id j131-20020a816e89000000b005ff6c19a15csm70985ywc.98.2024.01.25.18.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 18:31:28 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	syzbot+88f0aafe5f950d7489d7@syzkaller.appspotmail.com,
	syzbot+1336f3d4b10bcda75b89@syzkaller.appspotmail.com
Subject: [PATCH bpf-next v2] bpf: Fix error checks against bpf_get_btf_vmlinux().
Date: Thu, 25 Jan 2024 18:31:13 -0800
Message-Id: <20240126023113.1379504-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Check whether the returned pointer is NULL. Previously, it was assumed that
an error code would be returned if BTF is not available or fails to
parse. However, it actually returns NULL if BTF is disabled.

In the function check_struct_ops_btf_id(), we have stopped using
btf_vmlinux as a backup because attach_btf is never null when attach_btf_id
is set. However, the function test_libbpf_probe_prog_types() in
libbpf_probes.c does not set both attach_btf_obj_fd and attach_btf_id,
resulting in attach_btf being null, and it expects ENOTSUPP as a
result. So, if attach_btf_id is not set, it will return ENOTSUPP.

Changes from v1:

 - Remove an unnecessary NULL check in check_struct_ops_btf_id()

Reported-by: syzbot+88f0aafe5f950d7489d7@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/00000000000040d68a060fc8db8c@google.com/
Reported-by: syzbot+1336f3d4b10bcda75b89@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/00000000000026353b060fc21c07@google.com/
Fixes: fcc2c1fb0651 ("bpf: pass attached BTF to the bpf_struct_ops subsystem")
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 2 ++
 kernel/bpf/verifier.c       | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index defc052e4622..0decd862dfe0 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -669,6 +669,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		btf = bpf_get_btf_vmlinux();
 		if (IS_ERR(btf))
 			return ERR_CAST(btf);
+		if (!btf)
+			return ERR_PTR(-ENOTSUPP);
 	}
 
 	st_ops_desc = bpf_struct_ops_find_value(btf, attr->btf_vmlinux_value_type_id);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fe833e831cb6..c5d68a9d8acc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20298,7 +20298,10 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
-	btf = prog->aux->attach_btf ?: bpf_get_btf_vmlinux();
+	if (!prog->aux->attach_btf_id)
+		return -ENOTSUPP;
+
+	btf = prog->aux->attach_btf;
 	if (btf_is_module(btf)) {
 		/* Make sure st_ops is valid through the lifetime of env */
 		env->attach_btf_mod = btf_try_get_module(btf);
-- 
2.34.1


