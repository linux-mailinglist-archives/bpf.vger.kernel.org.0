Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECCF57C22C
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 04:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiGUCQ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 22:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiGUCQz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 22:16:55 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4CDB77482;
        Wed, 20 Jul 2022 19:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6+kso
        QkLExV2bd0Cnv7ry+o19UtcornIgTbSBFvBIys=; b=f92h29BEjq1JTcrsx3EBm
        DdruE3MxYSPo4laVAiv/h6HiOANLHeVqtHFlixNimIhSoI3UIbpNbaROnSyRKhTP
        9Bz0LAXCdVjHvCwN20YpdxqTgqg5BLgIj7pgdyDgUAFeVO7zojglBqjDP50vamzi
        3C4ByAD9V8Bfc6Hoo28R3U=
Received: from localhost.localdomain (unknown [223.104.68.243])
        by smtp11 (Coremail) with SMTP id D8CowAB3fyNJsthi_fmVAA--.64S2;
        Thu, 21 Jul 2022 09:56:32 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     corbet@lwn.net
Cc:     bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, william.gray@linaro.org,
        dhowells@redhat.com, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-cachefs@redhat.com, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH v2] docs: Fix typo in comment
Date:   Thu, 21 Jul 2022 09:56:05 +0800
Message-Id: <20220721015605.20651-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowAB3fyNJsthi_fmVAA--.64S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xry8uw1rur4DXr47XF43ZFb_yoW7urW3pa
        saqryIg3WkZas7ur1xJ342qFyxZaykWa1UGF4kKr10van8JwnYvF17K3Z8A3W5GryxAFW7
        XrWSvryUZw4jya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEApnhUUUUU=
X-Originating-IP: [223.104.68.243]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBAxtFZGB0LnLBDAAAs8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix typo in the comment

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
v2: Add all .rst changes in Documents into 1 single patch
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst    | 2 +-
 Documentation/bpf/map_cgroup_storage.rst          | 4 ++--
 Documentation/core-api/cpu_hotplug.rst            | 2 +-
 Documentation/driver-api/isa.rst                  | 2 +-
 Documentation/filesystems/caching/backend-api.rst | 2 +-
 Documentation/locking/seqlock.rst                 | 2 +-
 Documentation/sphinx/cdomain.py                   | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 8419019b6a88..6726f439958c 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -200,7 +200,7 @@ prb
 
 A pointer to the printk ringbuffer (struct printk_ringbuffer). This
 may be pointing to the static boot ringbuffer or the dynamically
-allocated ringbuffer, depending on when the the core dump occurred.
+allocated ringbuffer, depending on when the core dump occurred.
 Used by user-space tools to read the active kernel log buffer.
 
 printk_rb_static
diff --git a/Documentation/bpf/map_cgroup_storage.rst b/Documentation/bpf/map_cgroup_storage.rst
index cab9543017bf..8e5fe532c07e 100644
--- a/Documentation/bpf/map_cgroup_storage.rst
+++ b/Documentation/bpf/map_cgroup_storage.rst
@@ -31,7 +31,7 @@ The map uses key of type of either ``__u64 cgroup_inode_id`` or
     };
 
 ``cgroup_inode_id`` is the inode id of the cgroup directory.
-``attach_type`` is the the program's attach type.
+``attach_type`` is the program's attach type.
 
 Linux 5.9 added support for type ``__u64 cgroup_inode_id`` as the key type.
 When this key type is used, then all attach types of the particular cgroup and
@@ -155,7 +155,7 @@ However, the BPF program can still only associate with one map of each type
 ``BPF_MAP_TYPE_CGROUP_STORAGE`` or more than one
 ``BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE``.
 
-In all versions, userspace may use the the attach parameters of cgroup and
+In all versions, userspace may use the attach parameters of cgroup and
 attach type pair in ``struct bpf_cgroup_storage_key`` as the key to the BPF map
 APIs to read or update the storage for a given attachment. For Linux 5.9
 attach type shared storages, only the first value in the struct, cgroup inode
diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index c6f4ba2fb32d..f75778d37488 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -560,7 +560,7 @@ available:
   * cpuhp_state_remove_instance(state, node)
   * cpuhp_state_remove_instance_nocalls(state, node)
 
-The arguments are the same as for the the cpuhp_state_add_instance*()
+The arguments are the same as for the cpuhp_state_add_instance*()
 variants above.
 
 The functions differ in the way how the installed callbacks are treated:
diff --git a/Documentation/driver-api/isa.rst b/Documentation/driver-api/isa.rst
index def4a7b690b5..3df1b1696524 100644
--- a/Documentation/driver-api/isa.rst
+++ b/Documentation/driver-api/isa.rst
@@ -100,7 +100,7 @@ I believe platform_data is available for this, but if rather not, moving
 the isa_driver pointer to the private struct isa_dev is ofcourse fine as
 well.
 
-Then, if the the driver did not provide a .match, it matches. If it did,
+Then, if the driver did not provide a .match, it matches. If it did,
 the driver match() method is called to determine a match.
 
 If it did **not** match, dev->platform_data is reset to indicate this to
diff --git a/Documentation/filesystems/caching/backend-api.rst b/Documentation/filesystems/caching/backend-api.rst
index d7507becf674..3a199fc50828 100644
--- a/Documentation/filesystems/caching/backend-api.rst
+++ b/Documentation/filesystems/caching/backend-api.rst
@@ -122,7 +122,7 @@ volumes, calling::
 to tell fscache that a volume has been withdrawn.  This waits for all
 outstanding accesses on the volume to complete before returning.
 
-When the the cache is completely withdrawn, fscache should be notified by
+When the cache is completely withdrawn, fscache should be notified by
 calling::
 
 	void fscache_relinquish_cache(struct fscache_cache *cache);
diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqlock.rst
index 64405e5da63e..bfda1a5fecad 100644
--- a/Documentation/locking/seqlock.rst
+++ b/Documentation/locking/seqlock.rst
@@ -39,7 +39,7 @@ as the writer can invalidate a pointer that the reader is following.
 Sequence counters (``seqcount_t``)
 ==================================
 
-This is the the raw counting mechanism, which does not protect against
+This is the raw counting mechanism, which does not protect against
 multiple writers.  Write side critical sections must thus be serialized
 by an external lock.
 
diff --git a/Documentation/sphinx/cdomain.py b/Documentation/sphinx/cdomain.py
index ca8ac9e59ded..a7d1866e72ff 100644
--- a/Documentation/sphinx/cdomain.py
+++ b/Documentation/sphinx/cdomain.py
@@ -151,7 +151,7 @@ class CObject(Base_CObject):
     def handle_func_like_macro(self, sig, signode):
         u"""Handles signatures of function-like macros.
 
-        If the objtype is 'function' and the the signature ``sig`` is a
+        If the objtype is 'function' and the signature ``sig`` is a
         function-like macro, the name of the macro is returned. Otherwise
         ``False`` is returned.  """
 
-- 
2.25.1

