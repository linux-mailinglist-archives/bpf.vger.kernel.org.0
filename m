Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A7B46A890
	for <lists+bpf@lfdr.de>; Mon,  6 Dec 2021 21:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245082AbhLFUlW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 15:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243449AbhLFUlW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 15:41:22 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEF7C061746
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 12:37:53 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id i9so12471479qki.3
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 12:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Fn3+KqFcYSfI7gliuBBHB3PWuOuJplUUxlFA6X1dHQ=;
        b=I8V8TStleDf8hx8vwWUwiJLEz7gf9yIrxa7L3yf7j6hMKWZNnEe/DBsaP1uZsZHYO5
         mJ5Kl83LP3epBPaJFLzZ4h9xd8YSKcMIabhyb1p8F/aZSaTf3e9j61sS/AwH0DWeuR20
         OPqbL+xL12NJJYly5Yiq3ZH9Ni2lytn+1rq0SSOqLQRGXRkrHO8HR5epUN3JFJoq9tgx
         QqgcuolNsuok8teqsWTAf/j9Hs1CiGW4x8viigja4iIPpeGBVdnTMKs6g9+00i8x9oB0
         nphjY59zZ/LRYIRYSsKETyOC/1VNvNIwlPogRsSrI7fIzkuaodS/HIJmENXXekTHIq97
         UTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Fn3+KqFcYSfI7gliuBBHB3PWuOuJplUUxlFA6X1dHQ=;
        b=Mc5m5IeRO1XE0K9FBEZmfsf+7UTRSrjOcTygv97PT0oGcnzlBioPRVESYyWS6P7hcN
         Q5u4DP1nJuUf2JF7yr2IxY8G9Y0an6y7Qc919IM1bOgLQ+JDBsZEAhR9nTOluYvzw3N4
         u6Z0Kr4CqGARCGowAMf1n2CYtXTY0vsNQUmc9J6jj5IMqccVio4NpgEba3h+p1/TFFHT
         QomnzP2wRw0gxe2Z/nIHpyJ42yH/5O2w3h/4rZCvksYEeym1JobBDoqCprO/nNMZym8A
         khjmoYWTsUwBaX+1TZjN0VQ3uS+hmZxoT/nD3TyWbPQffL2GbLGVwrRQJCBha8BmLTaX
         I2Dw==
X-Gm-Message-State: AOAM531hPdaS9SxibijHqZ6iqC8gyKLaErxbF+5Jz/1WByY/WM8HfIx/
        7AJ38XiBZI6S5ERLVoy1Y0o=
X-Google-Smtp-Source: ABdhPJziUBOWLtcQwDas/rN/4UUUcV3sbrQIb2GcIK+gWu5XPnQNejbkgfDyIlyS7x+YkNZBC7B/pA==
X-Received: by 2002:a37:9c50:: with SMTP id f77mr23001932qke.428.1638823072545;
        Mon, 06 Dec 2021 12:37:52 -0800 (PST)
Received: from localhost.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id a17sm6912912qkp.108.2021.12.06.12.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:37:51 -0800 (PST)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org, grantseltzer@gmail.com
Subject: [PATCH bpf-next v2] libbpf: Add doc comments in libbpf.h
Date:   Mon,  6 Dec 2021 15:37:09 -0500
Message-Id: <20211206203709.332530-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Grant Seltzer <grantseltzer@gmail.com>

This adds comments above functions in libbpf.h which document
their uses. These comments are of a format that doxygen and sphinx
can pick up and render. These are rendered by libbpf.readthedocs.org

These doc comments are for:

- bpf_object__open_file()
- bpf_object__open_mem()
- bpf_program__attach_uprobe()
- bpf_program__attach_uprobe_opts()

Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
---
 tools/lib/bpf/libbpf.h | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 4ec69f224342..d2ca6f1d1dc4 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -108,8 +108,30 @@ struct bpf_object_open_opts {
 #define bpf_object_open_opts__last_field btf_custom_path
 
 LIBBPF_API struct bpf_object *bpf_object__open(const char *path);
+
+/**
+ * @brief **bpf_object__open_file()** creates a bpf_object by opening
+ * the BPF ELF object file pointed to by the passed path and loading it
+ * into memory.
+ * @param path BPF object file path
+ * @param opts options for how to load the bpf object, this parameter is
+ * option and can be set to NULL
+ * @return pointer to the new bpf_object; or NULL is returned on error,
+ * error code is stored in errno
+ */
 LIBBPF_API struct bpf_object *
 bpf_object__open_file(const char *path, const struct bpf_object_open_opts *opts);
+
+/**
+ * @brief **bpf_object__open_mem()** creates a bpf_object by reading
+ * the BPF objects raw bytes from a memory buffer containing a valid
+ * BPF ELF object file.
+ * @param obj_buf pointer to the buffer containing ELF file bytes
+ * @param obj_buf_sz number of bytes in the buffer
+ * @param opts options for how to load the bpf object
+ * @return pointer to the new bpf_object; or NULL is returned on error,
+ * error code is stored in errno
+ */
 LIBBPF_API struct bpf_object *
 bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
 		     const struct bpf_object_open_opts *opts);
@@ -344,10 +366,40 @@ struct bpf_uprobe_opts {
 };
 #define bpf_uprobe_opts__last_field retprobe
 
+/**
+ * @brief **bpf_program__attach_uprobe()** attaches a BPF program
+ * to the userspace function which is found by binary path and 
+ * offset. You can optionally specify a particular proccess to attach
+ * to. You can also optionally attach the program to the function 
+ * exit instead of entry. 
+ *
+ * @param prog BPF program to attach
+ * @param retprobe Attach to function exit
+ * @param pid Process ID to attach the uprobe to, -1 for all processes
+ * @param binary_path Path to binary that contains the function symbol
+ * @param func_offset Offset within the binary of the function symbol
+ * @return Reference to the newly created BPF link; or NULL is returned on error,
+ * error code is stored in errno
+ */
 LIBBPF_API struct bpf_link *
 bpf_program__attach_uprobe(const struct bpf_program *prog, bool retprobe,
 			   pid_t pid, const char *binary_path,
 			   size_t func_offset);
+
+/**
+ * @brief **bpf_program__attach_uprobe_opts()** is just like
+ * bpf_program__attach_uprobe() except with a options struct
+ * for various configurations.
+ * 
+ * @param prog BPF program to attach
+ * @param pid Process ID to attach the uprobe to, 0 for self (own process),
+ * -1 for all processes
+ * @param binary_path Path to binary that contains the function symbol
+ * @param func_offset Offset within the binary of the function symbol
+ * @param opts Options for altering program attachment
+ * @return Reference to the newly created BPF link; or NULL is returned on error,
+ * error code is stored in errno
+ */
 LIBBPF_API struct bpf_link *
 bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 				const char *binary_path, size_t func_offset,
-- 
2.33.1

