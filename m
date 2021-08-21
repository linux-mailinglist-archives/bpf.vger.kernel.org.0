Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2553F3C29
	for <lists+bpf@lfdr.de>; Sat, 21 Aug 2021 20:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhHUStQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 21 Aug 2021 14:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhHUStN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 21 Aug 2021 14:49:13 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A37C061575;
        Sat, 21 Aug 2021 11:48:34 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b9so3434942plx.2;
        Sat, 21 Aug 2021 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7aQ8+MWaUwrYV+7bA2BdzDeH1tSNPbIkq3oxgaie3l0=;
        b=qkIG6uOnhfGhm4h2ah9Mfn8r9Ts4Iu9fxNJm42Jda8qsbueVVzxmFZ8KSkUitrVrP9
         92cHv72NkgOLp/H9BM9y+LjMV1qTo3noz3yWgw9uODjLMGXknB5kk7itMB4m2xEMbruM
         t9oC0yahHZMBIN+C/Y4VesTHvzdblYCw7PIbaBw0FP/JUekRfd0zCUQwXzTaKYWsNl2j
         uTsvj8Hq5sUFHf/TKpNfUYe8KN7qkYGtTApPEHE4NHmIcp6bL6DpqO7+aAgOivo2lzxm
         nLDbj2+vb6rJxulu2nv8xOOVmSMaHsHcr9CHP0jjaQc554Ctd5m1ouyaGiKH/aIVMdhm
         1zLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7aQ8+MWaUwrYV+7bA2BdzDeH1tSNPbIkq3oxgaie3l0=;
        b=msDnrZyPA92MN68MVG7EtpfD4j/SuCBp8MMqDklw3mbsaOqyz48FKFwyOtlEbcrvgD
         g7gH47ur1sLIaPMW0yWFx8v3jE3dIYWWdW+vaq/e50VfymJHqGzYV44bJLmOt13rN4c5
         ikqVBj6FM5Wj4KAFS8ksM9jaNeemeQ9xYZ7wXKom5sSJRpVDqBODRXkudNVJGVr+EZhL
         B+eciEx5h6Dg5E+sZrK3zkUXALRKm9GNoS+aa2+27xPhfRsp0PDv7DJaKaS0NcBfMwPD
         YkDY+M5C+bukElpJY78++ndVtRF9vT3GbRpgkSC0neoYijQWG+Q7fF+NWcOabuOlhG2G
         cqHw==
X-Gm-Message-State: AOAM531FvnXnn3sTa4viGiBbbuontvF7NcHBnENHnJUH7BbsIzOsqUIP
        qIRXBmiHV1egZSBSoqeRFrsyo5N0Bfw=
X-Google-Smtp-Source: ABdhPJyKW5oBpTr362SlqTzjB1Z++hwx0rb3NvujMC1hqtKYjVrrE0+i0eC6eLqXVYHaz/nunYOXnA==
X-Received: by 2002:a17:90a:a581:: with SMTP id b1mr10792277pjq.153.1629571713626;
        Sat, 21 Aug 2021 11:48:33 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id m2sm11073994pfo.45.2021.08.21.11.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 11:48:33 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Spencer Baugh <sbaugh@catern.com>,
        Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next RFC v1 2/5] tools: sync bpf.h header
Date:   Sun, 22 Aug 2021 00:18:21 +0530
Message-Id: <20210821184824.2052643-3-memxor@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210821184824.2052643-1-memxor@gmail.com>
References: <20210821184824.2052643-1-memxor@gmail.com>
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
index c4f7892edb2b..d4bf4e4d56b5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -906,6 +906,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_RINGBUF,
 	BPF_MAP_TYPE_INODE_STORAGE,
 	BPF_MAP_TYPE_TASK_STORAGE,
+	BPF_MAP_TYPE_FILE_STORAGE,
 };
 
 /* Note that tracing related programs such as
@@ -4871,6 +4872,42 @@ union bpf_attr {
  * 	Return
  *		Value specified by user at BPF link creation/attachment time
  *		or 0, if it was not specified.
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
@@ -5048,6 +5085,8 @@ union bpf_attr {
 	FN(timer_cancel),		\
 	FN(get_func_ip),		\
 	FN(get_attach_cookie),		\
+	FN(file_storage_get),		\
+	FN(file_storage_delete),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.33.0

