Return-Path: <bpf+bounces-53617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1519DA5739A
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 22:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A721898D80
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 21:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7182580DD;
	Fri,  7 Mar 2025 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsoLConn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514732580C8
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741382984; cv=none; b=XMKp6UMBlbt9x/Vp3L+8K/N6IAqiUvr9euLO3sfLanmiHIaM0AnGQ95Vs1rN6nbt+nONi660ujiY100fgwJg7W6TTYXyrNFojtHBWlvRFidAJufD8fOU+Yi54s1M9xav2M/JIU3THIikSTr897fxsy7/ZgF9hs8DO1/BjZgr+XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741382984; c=relaxed/simple;
	bh=m69bBntmef+QWK7tm75KeQsSoJJEQlhQu9VlFYmYqXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGiHLVLJPnQOWT7xuNSzTxnX2x7SMhn6SgYzpLRuINvt0nbHWkPVozDbg9/XH62gQgDLtwo65+OySJaP/lL4+fxLylBerh447sBqp0Xn5EpJrrjhGCrTeXvzKa4TbUAMXrd0NNLSlpDcex85uDdd8OOq4szd4SCYlcMYJW+GixI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsoLConn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43bdc607c3fso14299155e9.3
        for <bpf@vger.kernel.org>; Fri, 07 Mar 2025 13:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741382981; x=1741987781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLEeMYLWEX54sdLQmpBkYwR4d1H4+ukfOsB6WXP2s04=;
        b=JsoLConnBxdaymip+7CJW7EvNkXkIP7o1nK3wUAzo6eLuGmITzMeeiiJ+/CB729lNp
         BBgRoeMqTiATWl9oit2zWuK4U94qXWSAHGgBanUZn+bTtieMry9cRQw9k17pEm3qkulM
         8cCo1yB9gTp5WVqj+5Tg31aD6Wurs9lgAqviaDUFQW29eGQRfqC2VLCZnLMcumbuY7g2
         laY8K05/k/3InEMuI0k8VKBzFqLlFaN1KXBJQIYt3BTuEWGaAI6qy326kMfCgek6HhHE
         +Cu0312w1KxrVaieutVwR2ev3JXov6bCVtj75NigB5WpxLBpKxcWIaSjOgJ3nhGDFU2r
         bcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741382981; x=1741987781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLEeMYLWEX54sdLQmpBkYwR4d1H4+ukfOsB6WXP2s04=;
        b=AuJVztLrIAWVAb5cQTHAm2QwFFz3sVmZ6pcI8Xh4KwgIeNVDLalBYi+7x9Me6yUNIt
         tLKaXDbkZNy7jATEFAs7Y3LgHz8efz3uBzsjAm+HClatJG+1EWhJJCKK01tE46kby9Js
         wys4Ze7aVUa7Ji3LwYyZS5Z5daK+1+sYl9IGAm502KUNjVFipCiDvGo89NoqEjbnDYlq
         xa9Sc0sK9LNeF7uRGxYjVMo8WuWx9tSTlPnQS4kMTnUMqB0MDu3PFLsu2hMAtEsWrwI9
         IelWfT8YUDzbcSCA41W2ZRJvzwEvrf/bazl+kPkVpBlf/RoskDKtj80H6eK8Bpji132m
         h5wA==
X-Gm-Message-State: AOJu0Yxt+7dkeh7IIPWk+Y0rv/XLJIMRCKQ0eCoYNwt+qoP43NXO5wax
	pma+DdsFHAmGyxBRkrSNtmcXzUmqevnpCE5mPnlfHtgDuekb7/agKs5wKA==
X-Gm-Gg: ASbGnctxatu7DpFWpeZW3lQ+8ffMKAnBQ3+jRKhUMmhDS/KES4Ugs33GjVSRK6gL9qv
	1ng1a3PPoqkfB/zjF36GsG4lYYCKgEW8jx2gP4J+LXb9t/OusGJ5gy/hZMVpWnfegoVdSar6q+t
	SeGuW+py45lBDaIc9wyksGLRr1fjulQyO6ALxng0ScQq81sbRB6GFk/uw5Q4AFIPN6bqB2UgEGD
	bykFJbb8f81Qt4DGYNSLbRuKBAr4LCvWaiWegT4OKlWOdQ0g70INtxbAdPBPIweHDSqcGrkrbVs
	WjuiItnv9Sr29lzFfmPEqqqqEm2Yt7zrzhtIVaIwitWI42CCuBIaxb9yzkAQsG8DtNOawlFyBdo
	6hYqmNNfa7JucR8rNFyjer/vQBDbGEbepwFeMxx6KS3Y4ClPFow==
X-Google-Smtp-Source: AGHT+IHqABg47sPAjXrov1TwUZ/7iqu3PQYYV8h6S/ESVpqRNfD16KmAGIwZLr3A4i7aP/viaMRMgA==
X-Received: by 2002:a05:600c:4689:b0:439:9595:c8e8 with SMTP id 5b1f17b1804b1-43c5a5d7cfemr40002365e9.0.1741382980248;
        Fri, 07 Mar 2025 13:29:40 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352e29sm92203145e9.32.2025.03.07.13.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 13:29:39 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 1/4] bpf: BPF token support for BPF_BTF_GET_FD_BY_ID
Date: Fri,  7 Mar 2025 21:29:31 +0000
Message-ID: <20250307212934.181996-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307212934.181996-1-mykyta.yatsenko5@gmail.com>
References: <20250307212934.181996-1-mykyta.yatsenko5@gmail.com>
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
 kernel/bpf/syscall.c                          | 20 +++++++++++++++++--
 tools/include/uapi/linux/bpf.h                |  1 +
 .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c |  3 +--
 4 files changed, 21 insertions(+), 4 deletions(-)

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
index 57a438706215..188f7296cf9f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5137,15 +5137,31 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
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
+	if (attr->open_flags & BPF_F_TOKEN_FD) {
+		token = bpf_token_get_from_fd(attr->token_fd);
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


