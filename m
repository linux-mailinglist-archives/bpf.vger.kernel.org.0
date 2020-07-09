Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977F821AB02
	for <lists+bpf@lfdr.de>; Fri, 10 Jul 2020 00:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgGIWzP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jul 2020 18:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgGIWzO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jul 2020 18:55:14 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC013C08C5CE
        for <bpf@vger.kernel.org>; Thu,  9 Jul 2020 15:55:14 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id f23so4097825iof.6
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2020 15:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=of9+3qI/MyRMYwvrISkr1vjZMf+9lj7qYnhFd6xNdRY=;
        b=jfDnvR7wHaiyhX5r367wpginjQgQYnzr0DxGaEzdCOwmb8DxG8N+jhDvdj8UJsL8ph
         Qv4mAxgRdl+MSstM8jB5lgnyY/psB5PwDJZdUterzNEIc7kpuSykrgK6eYp0F6EeuNEr
         V/t0W7Sf9vZ3o4xGjj3FzP8JM+HD4eUWAwgTdhc1R3jtSuLKYz5ubML03k8Pf/Vgsfto
         d18DNH6a6KcBgKT825nsqm9T6B9/qJIwvOT5l7qO/MqYzkETJ3jngQUxo4Z99FNRG7xQ
         bSKlrMeMZE8Dc6defADvOfhvLsauYpkq6K+/3mqyVgR2YYs95pGoC27yLDCwx9cS7iS9
         6n5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=of9+3qI/MyRMYwvrISkr1vjZMf+9lj7qYnhFd6xNdRY=;
        b=NkzssQ/49dG8fpAkT4xssfU8oQ9A2CMQj9/g9XSH0s2K41XN4wPqjeVsdg5vmmpQES
         jmUn+gMn8dj1Cc2lJK+Z8rEhajzOs2ln9hLf9eg/NesKipbFWPoOLi6PSXIJrkVsYYfq
         KuSHldPDSZ4HgoboeYpE1NnedKLI5PHat52rns2r4oHJN+BCK9i7mdfbQkXUBhozsvHm
         s/aApzUSQ5n38bXKFaiyR+496E2g1tK7kbmtRcfVvI1LE8px9e+ENdccx0k85FVWxwWd
         l/Tbm/liAFltPn2t4XRG87bjYa+/ZjtfaiZs4aA5xdi0BkNK5FxERj4jp3EFQvzMfyEG
         y/fQ==
X-Gm-Message-State: AOAM533B4cM6ni40Cn7GpwV2NDFr0ryYoA/WDd+4iGRDgCPtIA8NdUsC
        tp7lek0dyYLTgNroOMlkcJRPqT+bLS1Yyg==
X-Google-Smtp-Source: ABdhPJwyG02BjZK6OUX7B0u5MLo5D0NZigR/lFsX1epX9OnJ9qPwiK7Ng6GkgfMKNFdhmiLcz92xlQ==
X-Received: by 2002:a6b:acc7:: with SMTP id v190mr45088969ioe.53.1594335313783;
        Thu, 09 Jul 2020 15:55:13 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id q2sm2552416ilp.82.2020.07.09.15.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 15:55:13 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH v2 bpf-next 5/5] Documentation/bpf: Document CGROUP_STORAGE map type
Date:   Thu,  9 Jul 2020 17:54:51 -0500
Message-Id: <acdbc41fbc921d1b134080c39d041fecf47a5bed.1594333800.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594333800.git.zhuyifei@google.com>
References: <cover.1594333800.git.zhuyifei@google.com>
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
 Documentation/bpf/map_cgroup_storage.rst | 95 ++++++++++++++++++++++++
 2 files changed, 104 insertions(+)
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
index 000000000000..b7210cb3f294
--- /dev/null
+++ b/Documentation/bpf/map_cgroup_storage.rst
@@ -0,0 +1,95 @@
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
+The map uses key of type ``struct bpf_cgroup_storage_key``, declared in
+``linux/bpf.h``::
+
+    struct bpf_cgroup_storage_key {
+            __u64 cgroup_inode_id;
+            __u32 attach_type;
+    };
+
+``cgroup_inode_id`` is the inode id of the cgroup directory.
+``attach_type`` was the the program's attach type prior to Linux 5.9, since 5.9
+it is ignored and kept for backwards compatibility.
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
+            __sync_fetch_and_add(ptr_cg_storage-, 1);
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
+Userspace may use the the attach parameters of cgroup and attach type pair
+in ``struct bpf_cgroup_storage_key`` as the key to the BPF map APIs to read or
+update the storage for a given attachment.
+
+Since Linux 5.9, storage can be shared by multiple programs, and attach type
+is ignored. When a program is attached to a cgroup, the kernel would create a
+new storage only if the map does not already contain an entry for the cgroup,
+or else the old storage is reused for the new attachment. Storage is freed
+only when either the map or the cgroup attached to is being freed. Detaching
+will not directly free the storage, but it may cause the reference to the map
+to reach zero and indirectly freeing all storage in the map.
+
+Userspace may use the the attach parameters of cgroup only in
+``struct bpf_cgroup_storage_key`` as the key to the BPF map APIs to read or
+update the storage for a given attachment. The struct also contains an
+``attach_type`` field; this field is ignored.
+
+In all versions, the storage is bound at attach time. Even if the program is
+attached to parent and triggers in child, the storage still belongs to the
+parent.
+
+Userspace cannot create a new entry in the map or delete an existing entry.
+Program test runs always use a temporary storage.
-- 
2.27.0

