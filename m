Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF583F8924
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 15:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhHZNkN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 09:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242681AbhHZNkM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Aug 2021 09:40:12 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FA0C061757;
        Thu, 26 Aug 2021 06:39:25 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id y23so3093523pgi.7;
        Thu, 26 Aug 2021 06:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=82KgKpA2lWn6zjISDB4GufwUEb2dZemp3TeO+W97Fmc=;
        b=Tufg5CE8YgLQdvXDjDUDTvLqEQi8YoAlv5MvTXFJS6XCmmw7ir7hHrrECytQ1WOFZT
         jN6vWTglRkMYZqnwacvazRKd8HN7XhESXK/Ak+fQer4Yemzh1Pv3qcQZCgClhUxK+2MA
         nl8yUCBodzIxwVTfNlLpiU53MWCBu0+92dSBRy3vEo/fEMEOUuEoHAXOTviX+Wy+OTW2
         wijtUvJ924MFPPWOYOvk+o+HrN9+2VTVZX/UzpAtJdXdyH1QAE84fmJEFMW/kjhazRe0
         Ezn3wu/5yJlnksdiGoLiQSUImktfb/+7UUTxvj4KrlQRjULQB3MOgBoQVJZRWuPEboVf
         GW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=82KgKpA2lWn6zjISDB4GufwUEb2dZemp3TeO+W97Fmc=;
        b=MlBE8Gd6yM8AxhszVIqpXNuc3agbSmbQbb6OB8wPJ72ZchymfENM93o2Z6akgBqBrL
         xtbvlbxADl79/UTooS2G0ohOvujkUExA9T4spfHfXjhOy2/CqQcw8DUDCFgZKeAZcxVi
         llm/uQ5fVYXJeyVRg93PAbj2sQ4fi/HNd6iMAVKomUojs/FUb1qN0x8xGEIwD6SKu4k4
         uYWUKZstHQevoP5NBDKHkN54NXX5Qp1JXg+fuVCQsqI6lFlCPbKl1IHmTkzr7ocwaprI
         L+e2DPr1r82qp8ZO0elcvg8uiOEyB719wRq8A8SQ4TbRR2hq+yh54OnjcytcUDMW3w/1
         wB0A==
X-Gm-Message-State: AOAM5311oxaNiXxf7TGi9SCnJuUOshN02PrRCJlvs5SvIu3lHgWzK9JC
        Bi2TapdvipKRwdNHcrV3dPn4Fp85aBE=
X-Google-Smtp-Source: ABdhPJxtNYOo6EKV9EaIyVIBGeaq8jBThG32zqind1yB4vfUstxpJjKv5zcOw9lLMBuKwOC7EWSHvg==
X-Received: by 2002:a62:6341:0:b0:3ef:bf9d:22b6 with SMTP id x62-20020a626341000000b003efbf9d22b6mr3694821pfb.77.1629985164402;
        Thu, 26 Aug 2021 06:39:24 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id 143sm3073040pfx.1.2021.08.26.06.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 06:39:24 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Spencer Baugh <sbaugh@catern.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next v2 2/5] tools: sync bpf.h header
Date:   Thu, 26 Aug 2021 19:09:10 +0530
Message-Id: <20210826133913.627361-3-memxor@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210826133913.627361-1-memxor@gmail.com>
References: <20210826133913.627361-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update the bpf.h UAPI header with changes made from file local storage
additions.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/include/uapi/linux/bpf.h | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 791f31dd0abe..62aa1ff2dcfb 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -906,6 +906,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_RINGBUF,
 	BPF_MAP_TYPE_INODE_STORAGE,
 	BPF_MAP_TYPE_TASK_STORAGE,
+	BPF_MAP_TYPE_FILE_STORAGE,
 };
 
 /* Note that tracing related programs such as
@@ -4877,6 +4878,42 @@ union bpf_attr {
  *		Get the struct pt_regs associated with **task**.
  *	Return
  *		A pointer to struct pt_regs.
+ *
+ * void *bpf_file_storage_get(struct bpf_map *map, void *file, void *value, u64 flags)
+ *	Description
+ *		Get a bpf_local_storage from a *file*.
+ *
+ *		Logically, it could be thought of as getting the value from
+ *		a *map* with *file* as the **key**.  From this
+ *		perspective,  the usage is not much different from
+ *		**bpf_map_lookup_elem**\ (*map*, **&**\ *file*) except this
+ *		helper enforces the key must be an file and the map must also
+ *		be a **BPF_MAP_TYPE_FILE_STORAGE**.
+ *
+ *		Underneath, the value is stored locally at *file* instead of
+ *		the *map*.  The *map* is used as the bpf-local-storage
+ *		"type". The bpf-local-storage "type" (i.e. the *map*) is
+ *		searched against all bpf_local_storage residing at *file*.
+ *
+ *		An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
+ *		used such that a new bpf_local_storage will be
+ *		created if one does not exist.  *value* can be used
+ *		together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
+ *		the initial value of a bpf_local_storage.  If *value* is
+ *		**NULL**, the new bpf_local_storage will be zero initialized.
+ *	Return
+ *		A bpf_local_storage pointer is returned on success.
+ *
+ *		**NULL** if not found or there was an error in adding
+ *		a new bpf_local_storage.
+ *
+ * int bpf_file_storage_delete(struct bpf_map *map, void *file)
+ *	Description
+ *		Delete a bpf_local_storage from a *file*.
+ *	Return
+ *		0 on success.
+ *
+ *		**-ENOENT** if the bpf_local_storage cannot be found.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5055,6 +5092,8 @@ union bpf_attr {
 	FN(get_func_ip),		\
 	FN(get_attach_cookie),		\
 	FN(task_pt_regs),		\
+	FN(file_storage_get),		\
+	FN(file_storage_delete),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.33.0

