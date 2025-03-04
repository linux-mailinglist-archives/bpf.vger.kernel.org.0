Return-Path: <bpf+bounces-53241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33148A4EF48
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 22:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FBF73AA4EE
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 21:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2DE202F8D;
	Tue,  4 Mar 2025 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvU7Rpm/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2898B2780FD
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122912; cv=none; b=HcBHwQmW0kXlREBPejcBxWj/TXjTjUPcs1QBIgi1F0K4Ve8VqT8FQKXNxa9LEi5qNMRGy6veNNQ7zY8Rq2AYr6w0s4NhxXXl9r9hOIlFESjrteBp12FTonIyZv2XUOQIBKpJLtOKJki6u9LtltydrbitS6Xc/ukv9q3h/DrLtrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122912; c=relaxed/simple;
	bh=d2Fyhu6Pc8Ik4orVYIzGuBcJXOI29XYPBGaFVNOF1DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjIt5NpKU4PDoKWLECMiKw8MUspc24DuRrHFNSmm3KFeeBTsiiaIVO1CiwtgaY9fuXC39UyLANazmU0vDmcGwzcvQwT7h+ukPv+ayxoM1s58d4ugZmEpn/8X536b0Rkl0YZnMzIUx+ClL759Oy/OVPOXVRA46OxCjcrAbEp+R3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvU7Rpm/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e51e3274f1so6809076a12.0
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 13:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741122908; x=1741727708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugg3o7/X+1DbH4quhJHJqvvIhh3oQhh/cMzqBkork24=;
        b=LvU7Rpm/Cbie9yY+s7sjC/pv3xtL6MG8/b2V6SoGhmj/naRl/s4JvHUsSPZ6ML30xt
         C8c055Xr78UznZCCOyHnyeREtqgtkNMKtedCc1bGGV0wrTOkBeH9m67hHtOc3fzAWVaV
         Zf1Uq/v2EJXI76BVf30SrfPKeXwQRb3guyqIgBNqjtimsV4zLuFXCY63rrlldq0GMdAJ
         +2+stnKDhec1uNWsAYuMtNVPhXqpD2mrSwk1je2uHlSCwIMBDuIgXRzEc7xe/KejMXnw
         owm0Ot04mMRtPVr3kgSopHSBmMZ3B/u5cVDN8Y54OashH+rxXVN281CLuRQy30GgBSO9
         qMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741122908; x=1741727708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugg3o7/X+1DbH4quhJHJqvvIhh3oQhh/cMzqBkork24=;
        b=dKzZJQzTnuyx/mluw0oHOtithm6CzOC23ZJ4soIcL0MUgIGMs/VTvZJK1q9M/lVKXu
         NWBsYtAQ//lDxnACCiySLLRZxfdiYYrLi0Yht7KECb8kEXz59w5aW+gnfKdMpIN6Li10
         K/XDGTtcLvsYX0mbAM/noCgDtrpuKeAphWuXw9RLh5gClONpAUHrz6vFSU5JfebcHa4w
         bAnYHZHEMt8U9LuKq/N8Lc5b26osTxzyUw9ZnIhIiCGA+AI3cwPaPy9/p39JDXKISKm6
         JGesMPzdloVEh41uljWhOAj1PNpw5obvN2cMdNVcLWLbocTZDgHML9nnnbcO2J50xO3O
         cr2Q==
X-Gm-Message-State: AOJu0YwFj0FHfrBjxzmM8ZbCuptVEWLqk+g8YIxNYDEtaLuoWRBo2QkK
	FXpolf9xkiACQV2qA/6vOpm3YaWTayU4mUMtXAkT9JznVCJOYLI0DAHwmg==
X-Gm-Gg: ASbGnctCIDh8Ao5buXXVZXdX/h9wR/It4C4ZoBsYOXt3OWZ6GSH97YLp35iOc4r4vyJ
	DJTYpAQ2XkjPdDhy1Vyv5XZahh6ljZOtdj2dYUN9NAHuCFX4T6Rrnjvclq0VdPAk6strLKR6sVi
	/zPHnXoB2TTPh604LUV1QGAhTKfqUNKeK/RlyTFqOaMiSmJZJ+Mz7uc8dSRfbTdzdUVhDxCA6kx
	/rXFeccvU+juxi/+RJ41PuPIR5AihU+7j7Td6ZSPJ0tVHPebsp5uuBCx5UfCQKMZZesQugsytRG
	gwbTxEE6Yvu0ewewVL85LQ7jAR3gJ/Jy6B8ftc9n7hWn33hpqdYCe5k+jtI=
X-Google-Smtp-Source: AGHT+IFoOXBLpTvCBgh9HKzFBV6SFUVLMDANmyHhJu9oad4PKdGxejwJhOw3gmL8fGgYT1ugSfP3hQ==
X-Received: by 2002:a05:6402:3596:b0:5e0:7509:4543 with SMTP id 4fb4d7f45d1cf-5e59f48a5c3mr465130a12.32.1741122907765;
        Tue, 04 Mar 2025 13:15:07 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::6:8902])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4ae60sm8582112a12.10.2025.03.04.13.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 13:15:06 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 1/3] bpf: BPF token support for BPF_BTF_GET_FD_BY_ID
Date: Tue,  4 Mar 2025 21:14:58 +0000
Message-ID: <20250304211500.213073-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304211500.213073-1-mykyta.yatsenko5@gmail.com>
References: <20250304211500.213073-1-mykyta.yatsenko5@gmail.com>
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
 include/uapi/linux/bpf.h |  1 +
 kernel/bpf/syscall.c     | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

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
index 57a438706215..487054cb4704 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4750,6 +4750,9 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 
 	info.verified_insns = prog->aux->verified_insns;
 
+	if (prog->aux->btf)
+		info.btf_id = btf_obj_id(prog->aux->btf);
+
 	if (!bpf_capable()) {
 		info.jited_prog_len = 0;
 		info.xlated_prog_len = 0;
@@ -4895,8 +4898,6 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 		}
 	}
 
-	if (prog->aux->btf)
-		info.btf_id = btf_obj_id(prog->aux->btf);
 	info.attach_btf_id = prog->aux->attach_btf_id;
 	if (attach_btf)
 		info.attach_btf_obj_id = btf_obj_id(attach_btf);
@@ -5137,14 +5138,17 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
 	return btf_new_fd(attr, uattr, uattr_size);
 }
 
-#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_id
+#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD token_fd
 
 static int bpf_btf_get_fd_by_id(const union bpf_attr *attr)
 {
+	struct bpf_token *token;
+
 	if (CHECK_ATTR(BPF_BTF_GET_FD_BY_ID))
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
+	token = attr->token_fd ? bpf_token_get_from_fd(attr->token_fd) : NULL;
+	if (!bpf_token_capable(token, CAP_BPF))
 		return -EPERM;
 
 	return btf_get_fd_by_id(attr->btf_id);
-- 
2.48.1


