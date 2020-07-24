Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EE022BD27
	for <lists+bpf@lfdr.de>; Fri, 24 Jul 2020 06:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgGXEsL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jul 2020 00:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXEsL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jul 2020 00:48:11 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D39AC0619D3
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 21:48:11 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d18so8617082ion.0
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 21:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZpOwsy1L5l2IXx+7AwrLr0BShCW6LY8G8KpbbEt9H7o=;
        b=unINLUDC5i/KKe8nEBPsYPw91S2b53+1HqOazMtqE0U5Ka0qsWab5o8h2iPowW2jGY
         jzdJipxKDkZAHGe8TJqdHxyFaOJSKOOmfvP7gm8V0TZnpZCSEDnpnJ7WrUlpPf1AWlUw
         5InBdJu+I1dTqQ5AsKM9RWcdTkMVVdwVzjGA84qAueMr0gdBC51LM3YyoAtt3fjb7rNB
         Ghz3GpmzTxnxYPAvAUxvvGYLdnlDmgPOQ7bZuAZfDj4T/F6iirHabcRmVXlg2PP2cWY/
         qz+KZ1EMxlT01s9L73C6hYxqkG6jpTJHupysRLOBH4d3+7VaM3KqO5DTP91q/rKWZPnT
         b5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZpOwsy1L5l2IXx+7AwrLr0BShCW6LY8G8KpbbEt9H7o=;
        b=D6YYQhkADumGzlKyk+/Am8vTMYBrMMIU03n1f6LmQjJVSpspmV4HLdg3SVDzxPH+yF
         PdJZT7hpIdeGvRL4YSNNHSmOOWH+MijlNE51B679rBuex/YgB7GCVISejXlHvUkWXajz
         OUEPWcZLZUoAFgKe32mZ6Z6fCXC7ZzJKroUUQKG3VF6wiNIazmaTefgYKgb8nj96yCJr
         wy8OXZCpMMKNszu55i8Oe/PHuO6yXNIgV3GcBSvc8FzQ1wruKyk1DiwkHi3KinTNvqKr
         YeCIkn6ex/PcZI2kbNPsqZ6DimJqiXlzQb8ibneoHeZjXRDU2GfeUNSk2v+rhpkDilTJ
         H1aQ==
X-Gm-Message-State: AOAM531naXHjPibulanpAA1DwFpzZWgAs7y1im4th8Lif9OejsTNDNQY
        SsrUj/UZ/m+VRhqshKXpTEiXDjwAYXuY+Q==
X-Google-Smtp-Source: ABdhPJwe6z+0/JPxZgAiptv2+RY+Mzg6zgtBnVZXJPNrmL9WCoSUzVnM3dsewl9AN91Fey1CrMxBWA==
X-Received: by 2002:a05:6602:2f05:: with SMTP id q5mr7662565iow.139.1595566090302;
        Thu, 23 Jul 2020 21:48:10 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id o64sm2686579ilb.12.2020.07.23.21.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 21:48:09 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 5/5] Documentation/bpf: Document CGROUP_STORAGE map type
Date:   Thu, 23 Jul 2020 23:47:45 -0500
Message-Id: <b412edfbb05cb1077c9e2a36a981a54ee23fa8b3.1595565795.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595565795.git.zhuyifei@google.com>
References: <cover.1595565795.git.zhuyifei@google.com>
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
 Documentation/bpf/index.rst              |   9 ++
 Documentation/bpf/map_cgroup_storage.rst | 169 +++++++++++++++++++++++
 2 files changed, 178 insertions(+)
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
index 000000000000..cab9543017bf
--- /dev/null
+++ b/Documentation/bpf/map_cgroup_storage.rst
@@ -0,0 +1,169 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2020 Google LLC.
+
+===========================
+BPF_MAP_TYPE_CGROUP_STORAGE
+===========================
+
+The ``BPF_MAP_TYPE_CGROUP_STORAGE`` map type represents a local fix-sized
+storage. It is only available with ``CONFIG_CGROUP_BPF``, and to programs that
+attach to cgroups; the programs are made available by the same Kconfig. The
+storage is identified by the cgroup the program is attached to.
+
+The map provide a local storage at the cgroup that the BPF program is attached
+to. It provides a faster and simpler access than the general purpose hash
+table, which performs a hash table lookups, and requires user to track live
+cgroups on their own.
+
+This document describes the usage and semantics of the
+``BPF_MAP_TYPE_CGROUP_STORAGE`` map type. Some of its behaviors was changed in
+Linux 5.9 and this document will describe the differences.
+
+Usage
+=====
+
+The map uses key of type of either ``__u64 cgroup_inode_id`` or
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
+Linux 5.9 added support for type ``__u64 cgroup_inode_id`` as the key type.
+When this key type is used, then all attach types of the particular cgroup and
+map will share the same storage. Otherwise, if the type is
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
+take care of synchronization by themselves. The bpf infrastructure provides
+``struct bpf_spin_lock`` to synchronize the storage. See
+``tools/testing/selftests/bpf/progs/test_spin_lock.c``.
+
+Examples
+========
+
+Usage with key type as ``struct bpf_cgroup_storage_key``::
+
+    #include <bpf/bpf.h>
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
+Userspace accessing map declared above::
+
+    #include <linux/bpf.h>
+    #include <linux/libbpf.h>
+
+    __u32 map_lookup(struct bpf_map *map, __u64 cgrp, enum bpf_attach_type type)
+    {
+            struct bpf_cgroup_storage_key = {
+                    .cgroup_inode_id = cgrp,
+                    .attach_type = type,
+            };
+            __u32 value;
+            bpf_map_lookup_elem(bpf_map__fd(map), &key, &value);
+            // error checking omitted
+            return value;
+    }
+
+Alternatively, using just ``__u64 cgroup_inode_id`` as key type::
+
+    #include <bpf/bpf.h>
+
+    struct {
+            __uint(type, BPF_MAP_TYPE_CGROUP_STORAGE);
+            __type(key, __u64);
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
+And userspace::
+
+    #include <linux/bpf.h>
+    #include <linux/libbpf.h>
+
+    __u32 map_lookup(struct bpf_map *map, __u64 cgrp, enum bpf_attach_type type)
+    {
+            __u32 value;
+            bpf_map_lookup_elem(bpf_map__fd(map), &cgrp, &value);
+            // error checking omitted
+            return value;
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
+There is a one-to-one association between the map of each type (per-CPU and
+non-per-CPU) and the BPF program during load verification time. As a result,
+each map can only be used by one BPF program and each BPF program can only use
+one storage map of each type. Because of map can only be used by one BPF
+program, sharing of this cgroup's storage with other BPF programs were
+impossible.
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
+The map is not associated with any BPF program, thus making sharing possible.
+However, the BPF program can still only associate with one map of each type
+(per-CPU and non-per-CPU). A BPF program cannot use more than one
+``BPF_MAP_TYPE_CGROUP_STORAGE`` or more than one
+``BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE``.
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

