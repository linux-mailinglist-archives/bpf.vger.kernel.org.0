Return-Path: <bpf+bounces-54219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D32C9A65B1C
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 18:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111403BBAB7
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DF11B042C;
	Mon, 17 Mar 2025 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Os5gS6D5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0B01A3BD8
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233250; cv=none; b=mZMM7d+Trrze4YaF81Sf4kl0qS+Fmj6G8nqMI4VH0CizzZflcleqNAjVtcQihKCh+zlSJOM8wAmeK55aK5mjZ9ABL3rULyPyhIWALoMsSwm3kEBJoPzwza1O8bwoeqLBHj2voMhg9WFtUw29Q6+I9tTYyXI9v/vT9kKnoDJoUdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233250; c=relaxed/simple;
	bh=Ji2Ba0mEo0uL66GGJzlIxVFVlfmIEBnN7jfk/Bak/vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdBMwT/Qf0rZngqYutaPB8EkKMEfdjgiPDRhxpkg0dtpAjwSb4PcPxvWczAh3mq07krAwxyKxq6ZDxHq89JAX2awhA+jOS0ieVHVIS5IySOPavLDlKId0JE/Jl88QSUPtFDh6lIB1PqG7jtmYZXGq+x5ETdtpvKwhFytRpWBlAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Os5gS6D5; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso902391966b.3
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 10:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742233246; x=1742838046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RK2WJxGMiM1UEfiQkWDkn8HQwhzaM2gGVNmTxMRnlUA=;
        b=Os5gS6D5xEdpFtfwwo4+7SxFH6Q3XDCnYKgFhSeezjRWm84ZZ58siISLTzeFKvL9Xx
         DzErvrj2KQJEhM/Zea17i71hCXe3UNMNb9NIgOvk/Nlrjysiq8326Jt/Yvj1iDcz/jfz
         aqpChAXIfsJj7d/gQJmIEyNuocd+jLOlMt9NqrBZd0YEqU4Z08AVfAcaLx79URmXRPEx
         DPVmopIrr/LMEfDk2bc+P0SCiXBHaSljpgEq6aIrHMuUJYSpKcO3Oa4pqhGQVwDle34Q
         /tDpFvcQpR/COvVINz0izBGcivD+mmscgjyEay5LJ/7BtwZjwsxvI3Zmhzn06Cg0RgII
         f6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233246; x=1742838046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RK2WJxGMiM1UEfiQkWDkn8HQwhzaM2gGVNmTxMRnlUA=;
        b=e43uucpomq6igaacYZotzScmGTnOW71UZ8PnN0TadGKc+9GC2nu+DAVznH5PaLGQep
         ReOIkfqNMPH7dlmMr9cHXdfzORfHqdKh9BLokWgcfDbkWG+ZFYW4JNIM3wHM3vGXLkMM
         zW9v2HALLUZ8GOGDRSA0FdgswnUILnTGmFYJ/PYo1DBQwOkXF/pBY4BnUeXxnXQ2Zcho
         UdHKW1/qqGFBU0fsADRduG91eFGhr+413eG9lfWOyOOsS8O3AeiLwgL2cxJ97NJir/vh
         lXPcbnCq8IZpTLF9jtvoywaiwbiHfU76XRN1hW5Lsz/65QDY/aoxZLK3a7rG08mNId5d
         CkDg==
X-Gm-Message-State: AOJu0YxBUFbo8mIyiBWtpxMDkSaE25f6h1QZ1SFtbaadpfIMYPKknnR6
	clmiKAJ0TwBo4BxqWUCTXURjvrvLhhmCJHpJI+PZPXaKhxunhx0+KBnR3g==
X-Gm-Gg: ASbGncvhRf2SETtBm0LQFIvIxyB5cC1t9bOXgHM7C8D4lJqec6w97zmOf63g4n1hWwm
	YPJ9SeO/ydrAMyQDrz4FUkSL5a5xh9L33N6F+xu8SHMTfDhIR6F0UuQVU8oK71yltcQHpMphUhE
	VUGxouCUT8D0NDkMERsyue7dKiPlCpOuZSKgjK7xw7Y/CwZrOGvDa+dPpq4u2Q4vwQ2KXr3yeA2
	7rdjRpnX3jg1nlrpYIbd0hMfH0FFRfq563fRa1FX1eyy262mPQbXC87CQDhrTUvGGY+DrJYqqwI
	5pKG4LbDaPmMfXdLY+PQ/36rqvTGNTR43sfn8VY3nr9GffkhvKFukc1HuA==
X-Google-Smtp-Source: AGHT+IEkEBLHYanb3HO2QMhPboI9L8kl/SL6pJUIfRN6ZGRdOZHnbXlNDHOSp4EFLbkZAk3T5A+vTQ==
X-Received: by 2002:a17:907:bb4c:b0:ac3:3e40:e183 with SMTP id a640c23a62f3a-ac38d366f4cmr62538466b.3.1742233246306;
        Mon, 17 Mar 2025 10:40:46 -0700 (PDT)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::4:812])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9cadsm693917166b.48.2025.03.17.10.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:40:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 1/4] bpf: BPF token support for BPF_BTF_GET_FD_BY_ID
Date: Mon, 17 Mar 2025 17:40:36 +0000
Message-ID: <20250317174039.161275-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317174039.161275-1-mykyta.yatsenko5@gmail.com>
References: <20250317174039.161275-1-mykyta.yatsenko5@gmail.com>
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
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/syscall.c           | 23 +++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h |  1 +
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index bb37897c0393..661de2444965 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1652,6 +1652,7 @@ union bpf_attr {
 		};
 		__u32		next_id;
 		__u32		open_flags;
+		__s32		fd_by_id_token_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6a8f20ee2851..419f82c78203 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5120,15 +5120,34 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
 	return btf_new_fd(attr, uattr, uattr_size);
 }
 
-#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_id
+#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD fd_by_id_token_fd
 
 static int bpf_btf_get_fd_by_id(const union bpf_attr *attr)
 {
+	struct bpf_token *token = NULL;
+
 	if (CHECK_ATTR(BPF_BTF_GET_FD_BY_ID))
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (attr->open_flags & ~BPF_F_TOKEN_FD)
+		return -EINVAL;
+
+	if (attr->open_flags & BPF_F_TOKEN_FD) {
+		token = bpf_token_get_from_fd(attr->fd_by_id_token_fd);
+		if (IS_ERR(token))
+			return PTR_ERR(token);
+		if (!bpf_token_allow_cmd(token, BPF_BTF_GET_FD_BY_ID)) {
+			bpf_token_put(token);
+			token = NULL;
+		}
+	}
+
+	if (!bpf_token_capable(token, CAP_SYS_ADMIN)) {
+		bpf_token_put(token);
 		return -EPERM;
+	}
+
+	bpf_token_put(token);
 
 	return btf_get_fd_by_id(attr->btf_id);
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index bb37897c0393..661de2444965 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1652,6 +1652,7 @@ union bpf_attr {
 		};
 		__u32		next_id;
 		__u32		open_flags;
+		__s32		fd_by_id_token_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
-- 
2.48.1


