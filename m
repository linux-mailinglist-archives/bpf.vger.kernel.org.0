Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BBB22A9C2
	for <lists+bpf@lfdr.de>; Thu, 23 Jul 2020 09:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgGWHlK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 03:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgGWHlK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 03:41:10 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9846C0619DC
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 00:41:09 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t18so3568440ilh.2
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 00:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rg3lLepsix9FpODFM0aDlgzIKbl3+YakQy4HFJAnoP4=;
        b=A0vixeT4031ma8PwN0WUe9n3UyLS1RmRN1KFZgBqzhYnIRr/BRo0jkVUpVQmaL6M7V
         N9XZsrAWadKLDflixLZWNl3cuFKRLPKyDHUycm930CqYlMDgtaUJDpQMhuC05YaYtE96
         IDhN3sIJj1RSm+zMisnOEQxy3oarPNEPM59nI9oChMo99971T2pRwb5QA3sC7aXvc02d
         QElJ5t1vrsGmxt6NCZD6/C9hJFtV8X9h1gb/DOuqtJQr60eiWLVol2tTLzju+Gk2CFZF
         VkfpwiUqfb2rFOsrDYuC3Pw4JEf7NQCOOX31cOjKXB5oPiAEJISLUueC8/BB0PcJDwLL
         0TZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rg3lLepsix9FpODFM0aDlgzIKbl3+YakQy4HFJAnoP4=;
        b=ISn+RTItA+Fp017VkS52dGV5biuh+JQsgcdKvfm/KRj7Kaudk/bwsHHEuAKdHwPsfy
         KJ2m/BValmtsgRm3acqWcjUPRvGShzVLbiD9yOhEc8HTmBkbAfdpq5VR7pOlrrH3SlmK
         Ar3JEN1z5MeAymH5qz/OU5rfE3d+6sgjDssuYI6hM7N3OTmKib4jbrpVpFys9KX2qvFv
         YDvoWtu73bjkj412AZqw+TpV7tgKOOa+E7cKuuI+mOqbdhtB8/v8FkUQ9mPvwFiGa4kD
         s6fXJSdqkdCUnRkfpIhUyHzWwBnmnFeNfmASQrCrt3+RllPl3pFvNuaffMw4e7k5gDQE
         2Gcw==
X-Gm-Message-State: AOAM531QlS4PXLazRKjGuSknK2oqGU8hRq5NHBU/eYwYLDeNXP89N3Yj
        b8+MN0VT/detZI1LcxjlKEmWXazi3UltfQ==
X-Google-Smtp-Source: ABdhPJwlljGiwBelGPotvNe+wSk+R6OW5EkdUprHq3AgO/hb4sX6Md68pWPfo/8YwvbfvAjL3ZP+mA==
X-Received: by 2002:a92:d186:: with SMTP id z6mr3958865ilz.227.1595490069008;
        Thu, 23 Jul 2020 00:41:09 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id c9sm1035552ilm.57.2020.07.23.00.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 00:41:08 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH v5 bpf-next 5/5] Documentation/bpf: Document CGROUP_STORAGE map type
Date:   Thu, 23 Jul 2020 02:40:58 -0500
Message-Id: <2ac90af2504384ff33ab8184c288f236378173fb.1595489786.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595489786.git.zhuyifei@google.com>
References: <cover.1595489786.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

The machanics and usage are not very straightforward. Given the
changes it's better to document how it works and how to use it,
rather than having to rely on the examples and implementation to
infer what is going on.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 Documentation/bpf/index.rst              |  9 +++
 Documentation/bpf/map_cgroup_storage.rst | 97 ++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 Documentation/bpf/map_cgroup_storage.rst

diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index 38b4db8be7a2..26f4bb3107fc 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -48,6 +48,15 @@ Program types
    bpf_lsm
 
 
+Map types
+=========
+
+.. toctree::
+   :maxdepth: 1
+
+   map_cgroup_storage
+
+
 Testing and debugging BPF
 =========================
 
diff --git a/Documentation/bpf/map_cgroup_storage.rst b/Documentation/bpf/map_cgroup_storage.rst
new file mode 100644
index 000000000000..ed6256974508
--- /dev/null
+++ b/Documentation/bpf/map_cgroup_storage.rst
@@ -0,0 +1,97 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2020 Google LLC.
+
+===========================
+BPF_MAP_TYPE_CGROUP_STORAGE
+===========================
+
+The ``BPF_MAP_TYPE_CGROUP_STORAGE`` map type represents a local fix-sized
+storage. It is only available with ``CONFIG_CGROUP_BPF``, and to programs that
+attach to cgroups; the programs are made available by the same config. The
+storage is identified by the cgroup the program is attached to.
+
+This document describes the usage and semantics of the
+``BPF_MAP_TYPE_CGROUP_STORAGE`` map type. Some of its behaviors was changed in
+Linux 5.9 and this document will describe the differences.
+
+Usage
+=====
+
+The map uses key of type of either ``__u64`` or
+``struct bpf_cgroup_storage_key``, declared in ``linux/bpf.h``::
+
+    struct bpf_cgroup_storage_key {
+            __u64 cgroup_inode_id;
+            __u32 attach_type;
+    };
+
+``cgroup_inode_id`` is the inode id of the cgroup directory.
+``attach_type`` is the the program's attach type.
+
+Since Linux 5.9, if the type is ``__u64``, then all attach types of the
+particular cgroup and map will share the same storage. If the type is
+``struct bpf_cgroup_storage_key``, then programs of different attach types
+be isolated and see different storages.
+
+To access the storage in a program, use ``bpf_get_local_storage``::
+
+    void *bpf_get_local_storage(void *map, u64 flags)
+
+``flags`` is reserved for future use and must be 0.
+
+There is no implicit synchronization. Storages of ``BPF_MAP_TYPE_CGROUP_STORAGE``
+can be accessed by multiple programs across different CPUs, and user should
+take care of synchronization by themselves.
+
+Example usage::
+
+    #include <linux/bpf.h>
+
+    struct {
+            __uint(type, BPF_MAP_TYPE_CGROUP_STORAGE);
+            __type(key, struct bpf_cgroup_storage_key);
+            __type(value, __u32);
+    } cgroup_storage SEC(".maps");
+
+    int program(struct __sk_buff *skb)
+    {
+            __u32 *ptr = bpf_get_local_storage(&cgroup_storage, 0);
+            __sync_fetch_and_add(ptr, 1);
+
+            return 0;
+    }
+
+Semantics
+=========
+
+``BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE`` is a variant of this map type. This
+per-CPU variant will have different memory regions for each CPU for each
+storage. The non-per-CPU will have the same memory region for each storage.
+
+Prior to Linux 5.9, the lifetime of a storage is precisely per-attachment, and
+for a single ``CGROUP_STORAGE`` map, there can be at most one program loaded
+that uses the map. A program may be attached to multiple cgroups or have
+multiple attach types, and each attach creates a fresh zeroed storage. The
+storage is freed upon detach.
+
+Since Linux 5.9, storage can be shared by multiple programs. When a program is
+attached to a cgroup, the kernel would create a new storage only if the map
+does not already contain an entry for the cgroup and attach type pair, or else
+the old storage is reused for the new attachment. If the map is attach type
+shared, then attach type is simply ignored during comparison. Storage is freed
+only when either the map or the cgroup attached to is being freed. Detaching
+will not directly free the storage, but it may cause the reference to the map
+to reach zero and indirectly freeing all storage in the map.
+
+In all versions, userspace may use the the attach parameters of cgroup and
+attach type pair in ``struct bpf_cgroup_storage_key`` as the key to the BPF map
+APIs to read or update the storage for a given attachment. For Linux 5.9
+attach type shared storages, only the first value in the struct, cgroup inode
+id, is used during comparison, so userspace may just specify a ``__u64``
+directly.
+
+The storage is bound at attach time. Even if the program is attached to parent
+and triggers in child, the storage still belongs to the parent.
+
+Userspace cannot create a new entry in the map or delete an existing entry.
+Program test runs always use a temporary storage.
-- 
2.27.0

