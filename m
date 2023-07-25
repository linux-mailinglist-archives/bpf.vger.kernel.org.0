Return-Path: <bpf+bounces-5811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8FD760F62
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 11:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6CF281869
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E171115AC2;
	Tue, 25 Jul 2023 09:36:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8B714A91
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 09:36:25 +0000 (UTC)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8F21BF9;
	Tue, 25 Jul 2023 02:35:58 -0700 (PDT)
X-UUID: a1ab4eda2ace11eeb20a276fd37b9834-20230725
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zBOKlXR9UJkQg3cVyddpTc3TB9/Vh3QFP5WBjAxlAXs=;
	b=fPlH0fl/qK/fGTOx9MFJrjJiZlR3A0t9YsNDioJvnwp2GO4ZN7QyG5mRwfiuppgStkWVWsu2OL76dJ8x4MWckLGGX9I16baPksfg/73E58elmbBeZeYyoDodYnuyT7sed4sV1NQeRes80jiMrcce7ai/ILCtacwjnsZ1lmgInXk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:f41919c1-4205-4049-b1c0-f0eb2bb054ab,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7562a7,CLOUDID:7fd1c3b3-a467-4aa9-9e04-f584452e3794,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a1ab4eda2ace11eeb20a276fd37b9834-20230725
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <kuan-ying.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 930015652; Tue, 25 Jul 2023 17:35:45 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 25 Jul 2023 17:35:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 25 Jul 2023 17:35:44 +0800
From: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <chinwen.chang@mediatek.com>, <qun-wei.lin@mediatek.com>,
	<linux-mm@kvack.org>, <linux-modules@vger.kernel.org>,
	<casper.li@mediatek.com>, <akpm@linux-foundation.org>,
	<linux-arm-kernel@lists.infradead.org>, Kuan-Ying Lee
	<Kuan-Ying.Lee@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <bpf@vger.kernel.org>
Subject: [PATCH 8/8] scripts/gdb/vmalloc: add vmallocinfo support
Date: Tue, 25 Jul 2023 17:34:58 +0800
Message-ID: <20230725093458.30064-9-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230725093458.30064-1-Kuan-Ying.Lee@mediatek.com>
References: <20230725093458.30064-1-Kuan-Ying.Lee@mediatek.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This GDB script shows the vmallocinfo for user to
analyze the vmalloc memory usage.

Example output:
0xffff800008000000-0xffff800008009000      36864 <start_kernel+372> pages=8 vmalloc
0xffff800008009000-0xffff80000800b000       8192 <gicv2m_init_one+400> phys=0x8020000 ioremap
0xffff80000800b000-0xffff80000800d000       8192 <bpf_prog_alloc_no_stats+72> pages=1 vmalloc
0xffff80000800d000-0xffff80000800f000       8192 <bpf_jit_alloc_exec+16> pages=1 vmalloc
0xffff800008010000-0xffff80000ad30000   47316992 <paging_init+452> phys=0x40210000 vmap
0xffff80000ad30000-0xffff80000c1c0000   21561344 <paging_init+556> phys=0x42f30000 vmap
0xffff80000c1c0000-0xffff80000c370000    1769472 <paging_init+592> phys=0x443c0000 vmap
0xffff80000c370000-0xffff80000de90000   28442624 <paging_init+692> phys=0x44570000 vmap
0xffff80000de90000-0xffff80000f4c1000   23269376 <paging_init+788> phys=0x46090000 vmap
0xffff80000f4c1000-0xffff80000f4c3000       8192 <gen_pool_add_owner+112> pages=1 vmalloc
0xffff80000f4c3000-0xffff80000f4c5000       8192 <gen_pool_add_owner+112> pages=1 vmalloc
0xffff80000f4c5000-0xffff80000f4c7000       8192 <gen_pool_add_owner+112> pages=1 vmalloc

Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 scripts/gdb/linux/constants.py.in |  8 +++++
 scripts/gdb/linux/vmalloc.py      | 56 +++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py        |  1 +
 3 files changed, 65 insertions(+)
 create mode 100644 scripts/gdb/linux/vmalloc.py

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index fa23f4e3546a..3cf3c0b9eaea 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -22,6 +22,7 @@
 #include <linux/radix-tree.h>
 #include <linux/slab.h>
 #include <linux/threads.h>
+#include <linux/vmalloc.h>
 #include <asm/memory.h>
 
 /* We need to stringify expanded macros so that they can be parsed */
@@ -96,6 +97,13 @@ if IS_BUILTIN(CONFIG_ARM64):
     LX_GDBPARSED(VA_BITS_MIN)
     LX_GDBPARSED(MODULES_VSIZE)
 
+/* linux/vmalloc.h */
+LX_VALUE(VM_IOREMAP)
+LX_VALUE(VM_ALLOC)
+LX_VALUE(VM_MAP)
+LX_VALUE(VM_USERMAP)
+LX_VALUE(VM_DMA_COHERENT)
+
 /* linux/page_ext.h */
 LX_GDBPARSED(PAGE_EXT_OWNER)
 LX_GDBPARSED(PAGE_EXT_OWNER_ALLOCATED)
diff --git a/scripts/gdb/linux/vmalloc.py b/scripts/gdb/linux/vmalloc.py
new file mode 100644
index 000000000000..48e4a4fae7bb
--- /dev/null
+++ b/scripts/gdb/linux/vmalloc.py
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2023 MediaTek Inc.
+#
+# Authors:
+#  Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
+#
+
+import gdb
+import re
+from linux import lists, utils, stackdepot, constants, mm
+
+vmap_area_type = utils.CachedType('struct vmap_area')
+vmap_area_ptr_type = vmap_area_type.get_type().pointer()
+
+def is_vmalloc_addr(x):
+    pg_ops = mm.page_ops().ops
+    addr = pg_ops.kasan_reset_tag(x)
+    return addr >= pg_ops.VMALLOC_START and addr < pg_ops.VMALLOC_END
+
+class LxVmallocInfo(gdb.Command):
+    """Show vmallocinfo"""
+
+    def __init__(self):
+        super(LxVmallocInfo, self).__init__("lx-vmallocinfo", gdb.COMMAND_DATA)
+
+    def invoke(self, arg, from_tty):
+        vmap_area_list = gdb.parse_and_eval('vmap_area_list')
+        for vmap_area in lists.list_for_each_entry(vmap_area_list, vmap_area_ptr_type, "list"):
+            if not vmap_area['vm']:
+                gdb.write("0x%x-0x%x %10d vm_map_ram\n" % (vmap_area['va_start'], vmap_area['va_end'],
+                    vmap_area['va_end'] - vmap_area['va_start']))
+                continue
+            v = vmap_area['vm']
+            gdb.write("0x%x-0x%x %10d" % (v['addr'], v['addr'] + v['size'], v['size']))
+            if v['caller']:
+                gdb.write(" %s" % str(v['caller']).split(' ')[-1])
+            if v['nr_pages']:
+                gdb.write(" pages=%d" % v['nr_pages'])
+            if v['phys_addr']:
+                gdb.write(" phys=0x%x" % v['phys_addr'])
+            if v['flags'] & constants.LX_VM_IOREMAP:
+                gdb.write(" ioremap")
+            if v['flags'] & constants.LX_VM_ALLOC:
+                gdb.write(" vmalloc")
+            if v['flags'] & constants.LX_VM_MAP:
+                gdb.write(" vmap")
+            if v['flags'] & constants.LX_VM_USERMAP:
+                gdb.write(" user")
+            if v['flags'] & constants.LX_VM_DMA_COHERENT:
+                gdb.write(" dma-coherent")
+            if is_vmalloc_addr(v['pages']):
+                gdb.write(" vpages")
+            gdb.write("\n")
+
+LxVmallocInfo()
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index 2526364f31fd..fc53cdf286f1 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -48,3 +48,4 @@ else:
     import linux.stackdepot
     import linux.page_owner
     import linux.slab
+    import linux.vmalloc
-- 
2.18.0


