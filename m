Return-Path: <bpf+bounces-73834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83859C3B008
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 13:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0701D1AA5985
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F9932F75F;
	Thu,  6 Nov 2025 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ceQpjsCz"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60D328B5B;
	Thu,  6 Nov 2025 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433188; cv=none; b=bmiHoGZjS6gTofTa8x6j8vRdBEKEcm6wdXq4Vb1xAMJI9NZaPyUtSeHYHgHlnahWLWsZ9uQag7/aCuffRHvuW0dPJX5pMHdFyzEQMvYfafBjCPmJKqPt6guBWBwDHh2V0d5fo5REFG8r5TdBsPylQ2KdgehTYNxA2bKRUDjiK5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433188; c=relaxed/simple;
	bh=rV29mQhi4RV4AOVSgBFP33DB2kE5GYkz9pkxoDP1ARE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBKfmwFcZ0NejJTFrVO2Y8SDWZWpYI8wQN9HhzqXLcaTQxKbXf4sdWXcQe6gclpFGSIIs4pU0KXzH8bxuERKCIglZ/Vb+ZHpny7sHrBkNX6XiVXM3qOhaA8neeGU29XfAsN9GehgvijTpj1k8VNGHeHecAKw3Yel42qx684J4wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ceQpjsCz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A67wn14016669;
	Thu, 6 Nov 2025 12:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=p+6zp8nXYop9UfKDV
	XAS6Igq3wknhi2MEO378jWqoaM=; b=ceQpjsCz1jcG2K6M8XKe1ksi65TlBAptr
	+1gUklwg7i/nSNqarSk+FlOx92OPIEc7cOftZcM7kjqkITkC2Q7HQKS/w0rLtf9m
	qc/dDjUrrwiMEp9GJuThLQZLZa0ZPc4KI5gv5pvpqCoRualT0uJvY0xbTIMC6zvb
	4poxSJQN3GhUbW/4nGKSS4qjCLlRFEOX8Ku5lnR1FiHorHZZ8Gl6mqj3XEfhmVUq
	kcrLzqj8O6WX7cBvNDm+U8jXzaZ5WO1AaSb66uELxnd55zRptr2A7baQ599nTP/L
	Ni8ocCRG/GlVcIRs66JnGJXU2bhkBunTFpq9z26Fkahpl6APrCZnw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vuq45a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 12:46:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6BrbB9018804;
	Thu, 6 Nov 2025 12:46:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5whnnecq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 12:46:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A6Ck28r51184026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Nov 2025 12:46:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE52720043;
	Thu,  6 Nov 2025 12:46:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A5DE20040;
	Thu,  6 Nov 2025 12:46:02 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.27.154])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Nov 2025 12:46:02 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 1/2] scripts/gdb/radix-tree: add lx-radix-tree-command
Date: Thu,  6 Nov 2025 13:43:41 +0100
Message-ID: <20251106124600.86736-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251106124600.86736-1-iii@linux.ibm.com>
References: <20251106124600.86736-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9lnIZaD2quwMBYNfNEM-Wadsq2Q1jRHK
X-Proofpoint-GUID: 9lnIZaD2quwMBYNfNEM-Wadsq2Q1jRHK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX9uLLW6iStQkJ
 061NO6fGr+vdVtyzvp1jRMBfUUqbwWWYa12cuUjvINZBDQBtef1GENz1xOqaKU07hyaQ8pdlFbE
 J169caxmYMkTwrFIFb8SrZ3sz3+aQF83Lnp4QMYunvMypySI7+SPgJI7OpDxw3UkqVXwPRqZXEB
 Im2RI09mjhjArekas82mSTJ36jEmbcxQqBBU81QEhlRIu3Dhl7TZ89mzsZo2I6AFa3mo4YAXZje
 DdLx5V+0RJygvX1zd4gKKslRXVtZV9KoD+ArB6fFGSjaLOV6kYxWOor0UQPXR+9OHpEFLZcf9Om
 faMp80+FPo8xBaF4fKotUnODUHzhKeZGRAGhGJpmXD0zrhdWnC67rBy8jU9NJ4cB4P9c8XkJuEb
 JNJk047B+GrEBBJZgsFe2b0HfvC8Hg==
X-Authority-Analysis: v=2.4 cv=U6qfzOru c=1 sm=1 tr=0 ts=690c9890 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=w8ZYW45Y_G11fWB9lMAA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511010021

Add a function and a command to iterate over radix tree contents.
Duplicate the C implementation in Python, but drop support for tagging.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 scripts/gdb/linux/radixtree.py | 139 +++++++++++++++++++++++++++++++--
 1 file changed, 132 insertions(+), 7 deletions(-)

diff --git a/scripts/gdb/linux/radixtree.py b/scripts/gdb/linux/radixtree.py
index 074543ac763d2..bc2954e45c327 100644
--- a/scripts/gdb/linux/radixtree.py
+++ b/scripts/gdb/linux/radixtree.py
@@ -30,13 +30,16 @@ def entry_to_node(node):
 def node_maxindex(node):
     return (constants.LX_RADIX_TREE_MAP_SIZE << node['shift']) - 1
 
-def lookup(root, index):
+def resolve_root(root):
+    if root.type == radix_tree_root_type.get_type():
+        return root
     if root.type == radix_tree_root_type.get_type().pointer():
-        node = root.dereference()
-    elif root.type != radix_tree_root_type.get_type():
-        raise gdb.GdbError("must be {} not {}"
-                           .format(radix_tree_root_type.get_type(), root.type))
+        return root.dereference()
+    raise gdb.GdbError("must be {} not {}"
+                       .format(radix_tree_root_type.get_type(), root.type))
 
+def lookup(root, index):
+    root = resolve_root(root)
     node = root['xa_head']
     if node == 0:
         return None
@@ -71,14 +74,120 @@ def lookup(root, index):
 
     return node
 
-class LxRadixTree(gdb.Function):
+def descend(parent, index):
+    offset = (index >> int(parent["shift"])) & constants.LX_RADIX_TREE_MAP_MASK
+    return offset, parent["slots"][offset]
+
+def load_root(root):
+    node = root["xa_head"]
+    nodep = node
+
+    if is_internal_node(node):
+        node = entry_to_node(node)
+        maxindex = node_maxindex(node)
+        return int(node["shift"]) + constants.LX_RADIX_TREE_MAP_SHIFT, \
+               nodep, maxindex
+
+    return 0, nodep, 0
+
+class RadixTreeIter:
+    def __init__(self, start):
+        self.index = 0
+        self.next_index = start
+        self.node = None
+
+def xa_mk_internal(v):
+    return (v << 2) | 2
+
+LX_XA_RETRY_ENTRY = xa_mk_internal(256)
+LX_RADIX_TREE_RETRY = LX_XA_RETRY_ENTRY
+
+def next_chunk(root, iter):
+    mask = (1 << (utils.get_ulong_type().sizeof * 8)) - 1
+
+    index = iter.next_index
+    if index == 0 and iter.index != 0:
+        return None
+
+    restart = True
+    while restart:
+        restart = False
+
+        _, child, maxindex = load_root(root)
+        if index > maxindex:
+            return None
+        if not child:
+            return None
+
+        if not is_internal_node(child):
+            iter.index = index
+            iter.next_index = (maxindex + 1) & mask
+            iter.node = None
+            return root["xa_head"].address
+
+        while True:
+            node = entry_to_node(child)
+            offset, child = descend(node, index)
+
+            if not child:
+                while True:
+                    offset += 1
+                    if offset >= constants.LX_RADIX_TREE_MAP_SIZE:
+                        break
+                    slot = node["slots"][offset]
+                    if slot:
+                        break
+                index &= ~node_maxindex(node)
+                index = (index + (offset << int(node["shift"]))) & mask
+                if index == 0:
+                    return None
+                if offset == constants.LX_RADIX_TREE_MAP_SIZE:
+                    restart = True
+                    break
+                child = node["slots"][offset]
+
+            if not child:
+                restart = True
+                break
+            if child == LX_XA_RETRY_ENTRY:
+                break
+            if not node["shift"] or not is_internal_node(child):
+                break
+
+    iter.index = (index & ~node_maxindex(node)) | offset
+    iter.next_index = ((index | node_maxindex(node)) + 1) & mask
+    iter.node = node
+
+    return node["slots"][offset].address
+
+def next_slot(slot, iter):
+    mask = (1 << (utils.get_ulong_type().sizeof * 8)) - 1
+    for _ in range(iter.next_index - iter.index - 1):
+        slot += 1
+        iter.index = (iter.index + 1) & mask
+        if slot.dereference():
+            return slot
+    return None
+
+def for_each_slot(root, start=0):
+    iter = RadixTreeIter(start)
+    slot = None
+    while True:
+        if not slot:
+            slot = next_chunk(root, iter)
+            if not slot:
+                break
+        yield iter.index, slot
+        slot = next_slot(slot, iter)
+
+class LxRadixTreeLookup(gdb.Function):
     """ Lookup and return a node from a RadixTree.
 
 $lx_radix_tree_lookup(root_node [, index]): Return the node at the given index.
 If index is omitted, the root node is dereference and returned."""
 
     def __init__(self):
-        super(LxRadixTree, self).__init__("lx_radix_tree_lookup")
+        super(LxRadixTreeLookup, self).__init__("lx_radix_tree_lookup")
 
     def invoke(self, root, index=0):
         result = lookup(root, index)
@@ -87,4 +196,20 @@ If index is omitted, the root node is dereference and returned."""
 
         return result
 
+class LxRadixTree(gdb.Command):
+    """Show all values stored in a RadixTree."""
+
+    def __init__(self):
+        super(LxRadixTree, self).__init__("lx-radix-tree", gdb.COMMAND_DATA,
+                                          gdb.COMPLETE_NONE)
+
+    def invoke(self, argument, from_tty):
+        args = gdb.string_to_argv(argument)
+        if len(args) != 1:
+            raise gdb.GdbError("Usage: lx-radix-tree ROOT")
+        root = gdb.parse_and_eval(args[0])
+        for index, slot in for_each_slot(root):
+            gdb.write("[{}] = {}\n".format(index, slot.dereference()))
+
 LxRadixTree()
+LxRadixTreeLookup()
-- 
2.51.1


