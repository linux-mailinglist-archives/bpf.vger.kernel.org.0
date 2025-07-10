Return-Path: <bpf+bounces-62914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1D3B00118
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 14:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF22E5C23D8
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 12:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334132D9797;
	Thu, 10 Jul 2025 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hSxYnC2I"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2376D258CCB;
	Thu, 10 Jul 2025 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148790; cv=none; b=AkeKqkE3SY76+icqLp4XPU2l3bkF2a3SYPMcDwItU7rrAnmzZd2L2PVrnnzb+3fA1ni64rgzbTgGMyfSPQonNnwXQjV8FLBjpaMmydtjS31Mcz0exF9s9yurf/LtyvcmaG17lAaJjXr/QP7ef6M81dZJ6/6avE9KJtFISHZOenY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148790; c=relaxed/simple;
	bh=HygZCDxM2zeQJTGOGX/OGLwqWpEBrXrljJjgH3AvafA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFW+Ws6A45wZf/BPKnlJ1xi61dZ4Z6RcFsT3Dy8W/k1tcB/LKeUHPh5e/Yx9DJJNyzxqVshZYXDIc9C7G3AnXmUg5FkgIs4RWdhhMaJwlzjEgltlsIPOFbg19vXUlM4L94QgItkfw9JmgOxesqVFur+FU3ZvQ75eZH5oT4UIxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hSxYnC2I; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A87G2j003799;
	Thu, 10 Jul 2025 11:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BlCLisSp+PRyi/ShQ
	z6fSFKLv2M1a/tji3Kf2bETgmU=; b=hSxYnC2IW1oXvaV2FjB9q2FbQgvpih48E
	wMWlWNQ9QC2/nAVvTvDyYXr0XxsENJROBX1wblDX9JtVOewk6Y8MHzkNdFU4XwSD
	J1LQTaUfirDPUP4Jti+qEJO1QfVW6vG4gEKJ68b5ccFUuguAIJdL/aafcAlExK5T
	GOVjKHwx7wUyVehzmquTTP0W3gY9vcigTuU1SiTo1hs697gPMNrwJ4h2ynjSCwSh
	srC3RSg6foHwsKw0M+9qe21lNHdjWniINeuDNduH9wDgcgpb38g/kaTMa0SF5C46
	gOOcPMxLy2zjTVeNXsbIeCuk0LeWanAp2v+MOECOcPQwU1A+f/YJA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pusscq66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 11:59:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56AAcdFq002847;
	Thu, 10 Jul 2025 11:59:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmnch1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 11:59:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56ABxSIM53084456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 11:59:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 547D32004D;
	Thu, 10 Jul 2025 11:59:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73CB520043;
	Thu, 10 Jul 2025 11:59:27 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.154.34])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 11:59:27 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/2] scripts/gdb/radix-tree: add lx-radix-tree-command
Date: Thu, 10 Jul 2025 13:53:19 +0200
Message-ID: <20250710115920.47740-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710115920.47740-1-iii@linux.ibm.com>
References: <20250710115920.47740-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Vaj3PEp9 c=1 sm=1 tr=0 ts=686fab25 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=w8ZYW45Y_G11fWB9lMAA:9
X-Proofpoint-GUID: r5zPK5sibRcr2bvyNJciI4dAc4R6MTJ7
X-Proofpoint-ORIG-GUID: r5zPK5sibRcr2bvyNJciI4dAc4R6MTJ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwMSBTYWx0ZWRfX9i7iB6Cv5EUu mtPxpD42DBctUyW27n8GipPmQFtmRWjvuse4ni3hPku2rADs7i2HBpBXzPYYFT9hH9zZxKqTa7Z 3ege7fLcKY2GGxirUSDUwdNQ94pcw89j9uIsoAmGo3pZLJiiE68WDmFc7Qv+LyCJU7XoAV0IbUT
 EXvayF8bbOEcWQiahxgUlc2KoRMqM17fXSMavYRP4zrxBHdizOOvxOZlW4Ecmrcv3zhQ9vE55+A 7w3mHw0MX6kW2T1RWdge/xgCOwOwPA9iUgudUUeeMmrxLMFYjbHe5T7MlnpHc7oG3Zgl+CsqJZF G3DEwvSIkCiIo/e7EfdeNl8F5SsIQtgDKMvx+0qsW9PeKCbPfEnOlFFa/HhLGzjsFnMpHwh6kRY
 O9yzk88gBPbOm0An4Po2uzV0M1WzaP/vKcZsdBx5kAvidso/1etDMdxao2aqZsgsQEtUWR9T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100101

Add a function and a command to iterate over radix tree contents.
Duplicate the C implementation in Python, but drop support for tagging.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 scripts/gdb/linux/radixtree.py | 139 +++++++++++++++++++++++++++++++--
 1 file changed, 132 insertions(+), 7 deletions(-)

diff --git a/scripts/gdb/linux/radixtree.py b/scripts/gdb/linux/radixtree.py
index 074543ac763d..bc2954e45c32 100644
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
2.50.0


