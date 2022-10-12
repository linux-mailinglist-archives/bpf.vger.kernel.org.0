Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0A45FC867
	for <lists+bpf@lfdr.de>; Wed, 12 Oct 2022 17:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiJLP12 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Oct 2022 11:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJLP1Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Oct 2022 11:27:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528D7CA8AC;
        Wed, 12 Oct 2022 08:27:22 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so1414310wma.3;
        Wed, 12 Oct 2022 08:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eXbdwxuXO2jas/BkmyyUbohhX5QuO9Xol9GSEbTSBOs=;
        b=nZlVpl/i3yi/M4/sqFWz8ub+mET6pDR/EJjmkdGb35YrrqhJ0lzoU1vY5DX3FvkD1Q
         W0dd/RC+Hnpqd4bxuzf/zOeHgTI8gX+A0H4rbGROWIpC1XqDjVkKiW9SFk3+G1B8G+dO
         5Cc9/9B2yk6iB+WQQfLxqruyIzEUIISWqg+CrNLtdOVAjX4NYdtJ/Pagvm+vpVUj8m6N
         VJuqfcmU/rBbRN3coXPYcW23bV1EbD8sqpmny9e3EPbhzum/HR1kjPe/f5VD3gxOKY5G
         F/zDpEmxjY2gmr9kcjGJIrFTo4TG5m/ias7szFeeT7B2w8/wQs4AB9g6TiuBq3SJd1nq
         GTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXbdwxuXO2jas/BkmyyUbohhX5QuO9Xol9GSEbTSBOs=;
        b=TNBqk6UUBQdVD3x4XMwF33zSGKcSLlYslgCYbHXNpmD658xrcCKKVZFyA34sxPGQWn
         NQ1Mwuynd7iW1JLDrE1DwL4+UV3OJCRwX+p5hd+rYQq8w9euRJh4wJ6HPVMhudRtUjJ0
         1DztHDmIr3j1kufvW6LZSHj2pUcE1JzdRrXml9SaZe5r3yv/qavXx9q+TZM8z5l4BRqd
         EMjop5gp4XkzWM4IprZ74u1p5PScbQvixVPK3EUHxSun63jpKxhK07PMhjf2zqwbo8AL
         6+0D2ORpKBZ6plLNOp9it05k+Ra0RQsjITyPl4htbMB7lpZQqUzK3B07wFhyqiHtxhPW
         lO+w==
X-Gm-Message-State: ACrzQf3nv3T8iPDKM0cxd7+Vz2qe/j5vsRKc/5jHqQR4UBtu/NZYUKBY
        UIY3DZRA2ybi/ke4u9xjxxot1RpOPp8vlw==
X-Google-Smtp-Source: AMsMyM6J0jE9TIFoTejOfZe/r09GluQPq+ChFm+mD6Y61Bhbyi7OiaeYm7BP+xUmXGqHT1bvHH35JA==
X-Received: by 2002:a7b:c4c1:0:b0:3bf:e351:4ba with SMTP id g1-20020a7bc4c1000000b003bfe35104bamr3220978wmk.152.1665588440109;
        Wed, 12 Oct 2022 08:27:20 -0700 (PDT)
Received: from imac.redhat.com ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm2160882wmq.4.2022.10.12.08.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 08:27:19 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v1] bpf, docs: Reformat BPF maps page to be more readable
Date:   Wed, 12 Oct 2022 16:27:15 +0100
Message-Id: <20221012152715.25073-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a more complete introduction, with links to man pages.
Move toctree of map types above usage notes.
Format usage notes to improve readability.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/bpf/maps.rst | 101 ++++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 36 deletions(-)

diff --git a/Documentation/bpf/maps.rst b/Documentation/bpf/maps.rst
index f41619e312ac..4906ff0f8382 100644
--- a/Documentation/bpf/maps.rst
+++ b/Documentation/bpf/maps.rst
@@ -1,52 +1,81 @@
 
-=========
-eBPF maps
+========
+BPF maps
+========
+
+BPF 'maps' provide generic storage of different types for sharing data between
+kernel and user space. There are several storage types available, including
+hash, array, bloom filter and radix-tree. Several of the map types exist to
+support specific BPF helpers that perform actions based on the map contents. The
+maps are accessed from BPF programs via BPF helpers which are documented in the
+`man-pages`_ for `bpf-helpers(7)`_.
+
+BPF maps are accessed from user space via the ``bpf`` syscall, which provides
+commands to create maps, lookup elements, update elements and delete
+elements. More details of the BPF syscall are available in
+:doc:`/userspace-api/ebpf/syscall` and in the `man-pages`_ for `bpf(2)`_.
+
+Map Types
 =========
 
-'maps' is a generic storage of different types for sharing data between kernel
-and userspace.
+.. toctree::
+   :maxdepth: 1
+   :glob:
 
-The maps are accessed from user space via BPF syscall, which has commands:
+   map_*
 
-- create a map with given type and attributes
-  ``map_fd = bpf(BPF_MAP_CREATE, union bpf_attr *attr, u32 size)``
-  using attr->map_type, attr->key_size, attr->value_size, attr->max_entries
-  returns process-local file descriptor or negative error
+Usage Notes
+===========
 
-- lookup key in a given map
-  ``err = bpf(BPF_MAP_LOOKUP_ELEM, union bpf_attr *attr, u32 size)``
-  using attr->map_fd, attr->key, attr->value
-  returns zero and stores found elem into value or negative error
+.. c:function::
+   int bpf(int command, union bpf_attr *attr, u32 size)
 
-- create or update key/value pair in a given map
-  ``err = bpf(BPF_MAP_UPDATE_ELEM, union bpf_attr *attr, u32 size)``
-  using attr->map_fd, attr->key, attr->value
-  returns zero or negative error
+Use the ``bpf()`` system call to perform the operation specified by
+``command``. The operation takes parameters provided in ``attr``. The ``size``
+argument is the size of the ``union bpf_attr`` in ``attr``.
 
-- find and delete element by key in a given map
-  ``err = bpf(BPF_MAP_DELETE_ELEM, union bpf_attr *attr, u32 size)``
-  using attr->map_fd, attr->key
+**BPF_MAP_CREATE**
 
-- to delete map: close(fd)
-  Exiting process will delete maps automatically
+Create a map with the desired type and attributes in ``attr``:
 
-userspace programs use this syscall to create/access maps that eBPF programs
-are concurrently updating.
+.. code-block:: c
 
-maps can have different types: hash, array, bloom filter, radix-tree, etc.
+    int fd;
+    union bpf_attr attr = {
+            .map_type = BPF_MAP_TYPE_ARRAY;  /* mandatory */
+            .key_size = sizeof(__u32);       /* mandatory */
+            .value_size = sizeof(__u32);     /* mandatory */
+            .max_entries = 256;              /* mandatory */
+            .map_flags = BPF_F_MMAPABLE;
+            .map_name = "example_array";
+    };
 
-The map is defined by:
+    fd = bpf(BPF_MAP_CREATE, &attr, sizeof(attr));
 
-  - type
-  - max number of elements
-  - key size in bytes
-  - value size in bytes
+Returns a process-local file descriptor on success, or negative error in case of
+failure. The map can be deleted by calling ``close(fd)``. Maps held by open
+file descriptors will be deleted automatically when a process exits.
 
-Map Types
-=========
+.. note:: Valid characters for ``map_name`` are ``A-Z``, ``a-z``, ``0-9``,
+   ``'_'`` and ``'.'``.
 
-.. toctree::
-   :maxdepth: 1
-   :glob:
+**BPF_MAP_LOOKUP_ELEM**
+
+Lookup key in a given map using ``attr->map_fd``, ``attr->key``,
+``attr->value``. Returns zero and stores found elem into ``attr->value`` on
+success, or negative error on failure.
+
+**BPF_MAP_UPDATE_ELEM**
+
+Create or update key/value pair in a given map using ``attr->map_fd``, ``attr->key``,
+``attr->value``. Returns zero on success or negative error on failure.
+
+**BPF_MAP_DELETE_ELEM**
+
+Find and delete element by key in a given map using ``attr->map_fd``,
+``attr->key``. Returns zero on success or negative error on failure.
 
-   map_*
\ No newline at end of file
+.. Links:
+.. _man-pages: https://www.kernel.org/doc/man-pages/
+.. _bpf(2): https://man7.org/linux/man-pages/man2/bpf.2.html
+.. _bpf-helpers(7): https://man7.org/linux/man-pages/man7/bpf-helpers.7.html
-- 
2.35.1

