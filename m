Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EE7460191
	for <lists+bpf@lfdr.de>; Sat, 27 Nov 2021 22:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbhK0VHZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Nov 2021 16:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240737AbhK0VFY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Nov 2021 16:05:24 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0DDC061574
        for <bpf@vger.kernel.org>; Sat, 27 Nov 2021 13:02:09 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id i9so18494296qki.3
        for <bpf@vger.kernel.org>; Sat, 27 Nov 2021 13:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fi8OHkQ/+sMVWIC/NCVsa8V5iPQQ1jE7IBnnPg9T1wo=;
        b=d9ay9QGoQavYuUrVgyPKegruibwq3GkVJwMXGODnT7WVF6fqS/dtbDLJDTDSQc9pKZ
         ug5KS6LYLv+GJAfgcks49c45kpDF2Bi8cBN/3WmvQDA7qlAXRD95+/v0vDL4qBuOVChb
         2i2tqejtATATpSTwK2HZdHH9unQxvMy7I2SHySPNFA58cyt04Zrdvz5tCYrO8VCgpKdC
         9F1hnT7TRYDez7IUqzHnKMhLOUjwB2zauz78cACHEQqe5VzHDJMUFj81xXWHzJQ41AQP
         1tYA4aAkhKuH5kBaryy863anPlJVnXhwnxnAAifqTotKHEoVH7IxuyxwOv3lB0d/ewBs
         M8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fi8OHkQ/+sMVWIC/NCVsa8V5iPQQ1jE7IBnnPg9T1wo=;
        b=ENrqZesvFh607ZFjNUGAY2WG0VD54xmfVqhFBu2J5Fo3+p/x4TqqDH4qyXw0BEOAh7
         l1Rh5Vji9ADxR3L2PZJmP+JTo/NEeUCSxnVQjMYBlJwPt7y0pEDmDk4oxCBdeN48ER40
         2X8O6T+4KM0OS4WwqodV3D9p8WMO39luuvmqkrrukPdJYA8oboCvvwM5ZMAjx8OCJbA/
         epFhc8dllfwsPOTNCSbY1wZZGoDGX0afFHzF/KG2V2x5gnheyPA10Dr9IWPkh0QSXQzO
         PI0gnfn9O5v3+mp8d2CBa3RTnkSLt/UM4E2UIFRyDtya6XyZHWYl9ANcAL/k2VVS7SnM
         VSgA==
X-Gm-Message-State: AOAM533cqHA394GC2pv1jvnbz9V1Qb6i7gxNaN2S7swTOmpvL2HqP2mB
        +ROlYST+KIBjUUc5Vo7orvk=
X-Google-Smtp-Source: ABdhPJyBd4HCFDwAyj33VvZO1Unf51hMUXghHDYjkKi5CvJlmVyuBx1QjDJg6Bl6MGR9V7AnB8Mwxw==
X-Received: by 2002:a05:620a:4003:: with SMTP id h3mr22268683qko.555.1638046928974;
        Sat, 27 Nov 2021 13:02:08 -0800 (PST)
Received: from localhost.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id t35sm6163195qtc.83.2021.11.27.13.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 13:02:08 -0800 (PST)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org, grantseltzer@gmail.com
Subject: [PATCH bpf-next] libbpf: Add doc comments in libb.h
Date:   Sat, 27 Nov 2021 16:02:00 -0500
Message-Id: <20211127210200.1104120-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.31.1
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
 tools/lib/bpf/libbpf.h | 45 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 4ec69f224342..acfb207e71d1 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -108,8 +108,26 @@ struct bpf_object_open_opts {
 #define bpf_object_open_opts__last_field btf_custom_path
 
 LIBBPF_API struct bpf_object *bpf_object__open(const char *path);
+
+/**
+ * @brief **bpf_object__open_file()** creates a bpf_object by opening
+ * the BPF object file pointed to by the passed path and loading it
+ * into memory.
+ * @param path BPF object file relative or absolute path
+ * @param opts options for how to load the bpf object
+ * @return pointer to the new bpf_object
+ */
 LIBBPF_API struct bpf_object *
 bpf_object__open_file(const char *path, const struct bpf_object_open_opts *opts);
+
+/**
+ * @brief **bpf_object__open_mem()** creates a bpf_object by reading
+ * the BPF objects raw bytes from an in memory buffer.
+ * @param obj_buf pointer to the buffer containing bpf object bytes
+ * @param obj_buf_sz number of bytes in the buffer
+ * @param opts options for how to load the bpf object
+ * @return pointer to the new bpf_object
+ */
 LIBBPF_API struct bpf_object *
 bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
 		     const struct bpf_object_open_opts *opts);
@@ -344,10 +362,37 @@ struct bpf_uprobe_opts {
 };
 #define bpf_uprobe_opts__last_field retprobe
 
+/**
+ * @brief **bpf_program__attach_uprobe** attaches a BPF program
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
+ * @return Reference to the newly created BPF link
+ */
 LIBBPF_API struct bpf_link *
 bpf_program__attach_uprobe(const struct bpf_program *prog, bool retprobe,
 			   pid_t pid, const char *binary_path,
 			   size_t func_offset);
+
+/**
+ * @brief **bpf_program__attach_uprobe_opts** is just like 
+ * bpf_program__attach_uprobe except with a options struct
+ * for various configurations.
+ * 
+ * @param prog BPF program to attach
+ * @param pid Process ID to attach the uprobe to, -1 for all processes
+ * @param binary_path Path to binary that contains the function symbol
+ * @param func_offset Offset within the binary of the function symbol
+ * @param opts Options for altering program attachment
+ * @return Reference to the newly created BPF link 
+ */
 LIBBPF_API struct bpf_link *
 bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 				const char *binary_path, size_t func_offset,
-- 
2.31.1

