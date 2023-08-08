Return-Path: <bpf+bounces-7233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAF9773C3C
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 18:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DCE71C2104C
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 16:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BA41BB53;
	Tue,  8 Aug 2023 15:48:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603E813AC7
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 15:48:11 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D48E62;
	Tue,  8 Aug 2023 08:48:07 -0700 (PDT)
X-UUID: e0ad852e35c511ee9cb5633481061a41-20230808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3bTI4ezWT0dRlseV1XH1auN5umDiuiT9sp0ElLkplnk=;
	b=qyrZII5nSYfDgdidaw0URf4ZofwG1EVXxfgB82I25iLr1fGG5VBErD7TvzBhg96A9B5+kb/ogGfTQ4OCbf6AoR+58kbRMDd7K0JiOR/BAjneLgRzr2OohbVyf9EijJM8VpITHX4ggUNOukzOB5mkO2uy5lmhSBaUbapqtcfdldM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:7ff864a1-1a3f-46a3-8abc-b4524e19721c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:95
X-CID-INFO: VERSION:1.1.31,REQID:7ff864a1-1a3f-46a3-8abc-b4524e19721c,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
	:quarantine,TS:95
X-CID-META: VersionHash:0ad78a4,CLOUDID:59b6f042-d291-4e62-b539-43d7d78362ba,B
	ulkID:230808163051S0PE58AX,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
	C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
	TF_CID_SPAM_FSD,TF_CID_SPAM_ULN
X-UUID: e0ad852e35c511ee9cb5633481061a41-20230808
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <kuan-ying.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 996264844; Tue, 08 Aug 2023 16:30:48 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 8 Aug 2023 16:30:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 8 Aug 2023 16:30:47 +0800
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
Subject: [PATCH v2 8/8] scripts/gdb/vmalloc: add vmallocinfo support
Date: Tue, 8 Aug 2023 16:30:18 +0800
Message-ID: <20230808083020.22254-9-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230808083020.22254-1-Kuan-Ying.Lee@mediatek.com>
References: <20230808083020.22254-1-Kuan-Ying.Lee@mediatek.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
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
index 03fa6d2cfe01..e3517d4ab8ec 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -22,6 +22,7 @@
 #include <linux/radix-tree.h>
 #include <linux/slab.h>
 #include <linux/threads.h>
+#include <linux/vmalloc.h>
 
 /* We need to stringify expanded macros so that they can be parsed */
 
@@ -91,6 +92,13 @@ LX_GDBPARSED(RADIX_TREE_MAP_SIZE)
 LX_GDBPARSED(RADIX_TREE_MAP_SHIFT)
 LX_GDBPARSED(RADIX_TREE_MAP_MASK)
 
+/* linux/vmalloc.h */
+LX_VALUE(VM_IOREMAP)
+LX_VALUE(VM_ALLOC)
+LX_VALUE(VM_MAP)
+LX_VALUE(VM_USERMAP)
+LX_VALUE(VM_DMA_COHERENT)
+
 /* linux/page_ext.h */
 if IS_BUILTIN(CONFIG_PAGE_OWNER):
     LX_GDBPARSED(PAGE_EXT_OWNER)
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


