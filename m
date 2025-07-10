Return-Path: <bpf+bounces-62915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A26B0012A
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 14:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E9857A22B4
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 12:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D3025C706;
	Thu, 10 Jul 2025 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ENbVXNBq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11732561D9;
	Thu, 10 Jul 2025 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148791; cv=none; b=Gyh0GjSfbox7K4PtewRbunZUI/fMBfBr3hgb5YWEsKTM4NPGtg2UdCYAu+yKFy08o+QQAVz5zDEjJPBLxd94H4r1OvHV/w6UQA1TRG6xiCO+FF6ApvntBkSVFcA3sBjjGDrcVjvMLH4f9o0PGLHwY+zPsozHzzYcW8Qapxjiy80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148791; c=relaxed/simple;
	bh=CEiVl6Sf0Ij4UhIuyDysP3AK6h6ZPg1HZuBP7LcxGVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEp6XxrproY8tEX0/eG6lAP2uolBoJ2p/snGH+7UQK5g3cHPMQ1/38hX8h4UEc8vUCsUIa4hAFFJZxYwQyKTO4lKwdp/SaimjwQVRvcWqBtwKxTcg/nVkcGEGjht3w/HAn0QhnB6QRHfDh30oX0igUABKPvpnzKJj6WWQUPZyjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ENbVXNBq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AA9hUr016141;
	Thu, 10 Jul 2025 11:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=djmygL5OTNoyl4L3v
	lHm9YLEskcOXcpa1fYxkvx8TSo=; b=ENbVXNBqb3bzLi4qY1oZrGvGWFq1EnPDO
	jUOardiVjMcqO4C3NnXltI3oc6DAwHzrLM2LimuLSrBHTRTwGVpqkj7LonjjaTGJ
	sPLJzhfKxBOonNA0G6en4Xr8EVLFPw+Ed+qb5el7F/YbCkf1elCL2aBd4+0gt9dn
	qLl2PRGXmzvkMfahxPVH+duKsZI0CUtoN0RtQvJi58uJsD4h+DF2Ndia6La6Yu5F
	7uQ9NF1ZOzUZb6UTITBcJVJhD/DuYeVsTmpGtc+5CBa6AdJLV0b1SEZ5o8bCtfSq
	rwZ32BYSk98HDn0AW1quGocWh7+VI7avt7h+jQA83GjlCzImfy1ag==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pusscq67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 11:59:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56ABflNi013583;
	Thu, 10 Jul 2025 11:59:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qgkm58xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 11:59:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56ABxTSE60555752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 11:59:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 116C42004D;
	Thu, 10 Jul 2025 11:59:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A4CF20043;
	Thu, 10 Jul 2025 11:59:28 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.154.34])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 11:59:28 +0000 (GMT)
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
Subject: [PATCH 2/2] scripts/gdb/symbols: make BPF debug info available to GDB
Date: Thu, 10 Jul 2025 13:53:20 +0200
Message-ID: <20250710115920.47740-3-iii@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Vaj3PEp9 c=1 sm=1 tr=0 ts=686fab25 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=xCrHHBZJjj97EfHhUX8A:9
X-Proofpoint-GUID: y1Zs3BDPlGHYr3EKRxedaFUWoDOlLRhk
X-Proofpoint-ORIG-GUID: y1Zs3BDPlGHYr3EKRxedaFUWoDOlLRhk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwMSBTYWx0ZWRfXyt3O+M0ZnS0r gvM6i2eFix/axj7o+bRe0IR5HrUHkROXoM/GGV64se3sA1NtHp2j3k2n4jf0RUHEnpgkjPK49nE shR8uCzixsDQAi4jSLiB2sD0vKYtzHnCbLhS+mICjwSxhPlhonlXPwdlOJlFa5JwJaek/ICUEBh
 B+rKG5S/kvXWcMFPIKKNwfHyAFY8kM6pAdE9ZoJOVuE4LMLBFPWLOJk7YKwsL6QwcOeg9WGTMGv iSp0BqSlaUS/ceVe95H7SbmRbyLZ1+GGBxXUAFVNz90rUXuJOffaTUiyBZyCJbQ4LcRZbn4uK5h 3ET1K2Lvp/Bay7d5fAufEa2JFXNAAkrsfkFDXgUmgDyliklec3/uXALMVC5JG0Gh0FKi4X++n9N
 S8zBWkGQmGibQ4bJd5sAXd5YOPEVuGgeUw6SKQhGDyw8eZwV/dMHUQQMVmQBsUzMsDAz3lpa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100101

One can debug BPF programs with QEMU gdbstub by setting a breakpoint
on bpf_prog_kallsyms_add(), waiting for a hit with a matching
aux.name, and then setting a breakpoint on bpf_func. This is tedious,
error-prone, and also lacks line numbers.

Automate this in a way similar to the existing support for modules in
lx-symbols.

Enumerate and monitor changes to both BPF kallsyms and JITed progs. For
each ksym, generate and compile a synthetic .s file containing the
name, code, and size. In addition, if this ksym is also a prog, and not
a trampoline, add line number information.

Ensure that this is a no-op if the kernel is built without BPF support
or if "as" is missing. In theory the "as" dependency may be dropped by
generating the synthetic .o file manually, but this is too much
complexity for too little benefit.

Now one can debug BPF progs out of the box like this:

    (gdb) lx-symbols
    (gdb) b bpf_prog_4e612a6a881a086b_arena_list_add
    Breakpoint 2 (bpf_prog_4e612a6a881a086b_arena_list_add) pending.

    # ./test_progs -t arena_list

    Thread 4 hit Breakpoint 2, bpf_prog_4e612a6a881a086b_arena_list_add ()
        at linux/tools/testing/selftests/bpf/progs/arena_list.c:51
    51              list_head = &global_head;
    (gdb) n
    bpf_prog_4e612a6a881a086b_arena_list_add () at linux/tools/testing/selftests/bpf/progs/arena_list.c:53
    53              for (i = zero; i < cnt && can_loop; i++) {

This also works for subprogs.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 scripts/gdb/linux/bpf.py          | 253 ++++++++++++++++++++++++++++++
 scripts/gdb/linux/constants.py.in |   3 +
 scripts/gdb/linux/symbols.py      |  77 ++++++++-
 3 files changed, 330 insertions(+), 3 deletions(-)
 create mode 100644 scripts/gdb/linux/bpf.py

diff --git a/scripts/gdb/linux/bpf.py b/scripts/gdb/linux/bpf.py
new file mode 100644
index 000000000000..c2ec244cc94b
--- /dev/null
+++ b/scripts/gdb/linux/bpf.py
@@ -0,0 +1,253 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import json
+import subprocess
+import tempfile
+
+import gdb
+
+from linux import constants, lists, radixtree, utils
+
+
+if constants.LX_CONFIG_BPF and constants.LX_CONFIG_BPF_JIT:
+    bpf_ksym_type = utils.CachedType("struct bpf_ksym")
+if constants.LX_CONFIG_BPF_SYSCALL:
+    bpf_prog_type = utils.CachedType("struct bpf_prog")
+
+
+def get_ksym_name(ksym):
+    name = ksym["name"].bytes
+    end = name.find(b"\x00")
+    if end != -1:
+        name = name[:end]
+    return name.decode()
+
+
+def list_ksyms():
+    if not (constants.LX_CONFIG_BPF and constants.LX_CONFIG_BPF_JIT):
+        return []
+    bpf_kallsyms = gdb.parse_and_eval("&bpf_kallsyms")
+    bpf_ksym_ptr_type = bpf_ksym_type.get_type().pointer()
+    return list(lists.list_for_each_entry(bpf_kallsyms,
+                                          bpf_ksym_ptr_type,
+                                          "lnode"))
+
+
+class KsymAddBreakpoint(gdb.Breakpoint):
+    def __init__(self, monitor):
+        super(KsymAddBreakpoint, self).__init__("bpf_ksym_add", internal=True)
+        self.silent = True
+        self.monitor = monitor
+
+    def stop(self):
+        self.monitor.add(gdb.parse_and_eval("ksym"))
+        return False
+
+
+class KsymRemoveBreakpoint(gdb.Breakpoint):
+    def __init__(self, monitor):
+        super(KsymRemoveBreakpoint, self).__init__("bpf_ksym_del",
+                                                   internal=True)
+        self.silent = True
+        self.monitor = monitor
+
+    def stop(self):
+        self.monitor.remove(gdb.parse_and_eval("ksym"))
+        return False
+
+
+class KsymMonitor:
+    def __init__(self, add, remove):
+        self.add = add
+        self.remove = remove
+
+        self.add_bp = KsymAddBreakpoint(self)
+        self.remove_bp = KsymRemoveBreakpoint(self)
+
+        self.notify_initial()
+
+    def notify_initial(self):
+        for ksym in list_ksyms():
+            self.add(ksym)
+
+    def close(self):
+        self.add_bp.delete()
+        self.remove_bp.delete()
+
+
+def list_progs():
+    if not constants.LX_CONFIG_BPF_SYSCALL:
+        return []
+    idr_rt = gdb.parse_and_eval("&prog_idr.idr_rt")
+    bpf_prog_ptr_type = bpf_prog_type.get_type().pointer()
+    progs = []
+    for _, slot in radixtree.for_each_slot(idr_rt):
+        prog = slot.dereference().cast(bpf_prog_ptr_type)
+        progs.append(prog)
+        # Subprogs are not registered in prog_idr, fetch them manually.
+        # func[0] is the current prog.
+        aux = prog["aux"]
+        func = aux["func"]
+        real_func_cnt = int(aux["real_func_cnt"])
+        for i in range(1, real_func_cnt):
+            progs.append(func[i])
+    return progs
+
+
+class ProgAddBreakpoint(gdb.Breakpoint):
+    def __init__(self, monitor):
+        super(ProgAddBreakpoint, self).__init__("bpf_prog_kallsyms_add",
+                                                internal=True)
+        self.silent = True
+        self.monitor = monitor
+
+    def stop(self):
+        self.monitor.add(gdb.parse_and_eval("fp"))
+        return False
+
+
+class ProgRemoveBreakpoint(gdb.Breakpoint):
+    def __init__(self, monitor):
+        super(ProgRemoveBreakpoint, self).__init__("bpf_prog_free_id",
+                                                   internal=True)
+        self.silent = True
+        self.monitor = monitor
+
+    def stop(self):
+        self.monitor.remove(gdb.parse_and_eval("prog"))
+        return False
+
+
+class ProgMonitor:
+    def __init__(self, add, remove):
+        self.add = add
+        self.remove = remove
+
+        self.add_bp = ProgAddBreakpoint(self)
+        self.remove_bp = ProgRemoveBreakpoint(self)
+
+        self.notify_initial()
+
+    def notify_initial(self):
+        for prog in list_progs():
+            self.add(prog)
+
+    def delete(self):
+        self.add_bp.delete()
+        self.remove_bp.delete()
+
+
+def btf_str_by_offset(btf, offset):
+    while offset < btf["start_str_off"]:
+        btf = btf["base_btf"]
+
+    offset -= btf["start_str_off"]
+    if offset < btf["hdr"]["str_len"]:
+        return (btf["strings"] + offset).string()
+
+    return None
+
+
+def bpf_line_info_line_num(line_col):
+    return line_col >> 10
+
+
+def bpf_line_info_line_col(line_col):
+    return line_col & 0x3ff
+
+
+class LInfoIter:
+    def __init__(self, prog):
+        # See bpf_prog_get_file_line() for details.
+        self.pos = 0
+        self.nr_linfo = 0
+
+        if prog is None:
+            return
+
+        self.bpf_func = int(prog["bpf_func"])
+        aux = prog["aux"]
+        self.btf = aux["btf"]
+        linfo_idx = aux["linfo_idx"]
+        self.nr_linfo = int(aux["nr_linfo"]) - linfo_idx
+        if self.nr_linfo == 0:
+            return
+
+        linfo_ptr = aux["linfo"]
+        tpe = linfo_ptr.type.target().array(self.nr_linfo).pointer()
+        self.linfo = (linfo_ptr + linfo_idx).cast(tpe).dereference()
+        jited_linfo_ptr = aux["jited_linfo"]
+        tpe = jited_linfo_ptr.type.target().array(self.nr_linfo).pointer()
+        self.jited_linfo = (jited_linfo_ptr + linfo_idx).cast(tpe).dereference()
+
+        self.filenos = {}
+
+    def get_code_off(self):
+        if self.pos >= self.nr_linfo:
+            return -1
+        return self.jited_linfo[self.pos] - self.bpf_func
+
+    def advance(self):
+        self.pos += 1
+
+    def get_fileno(self):
+        file_name_off = int(self.linfo[self.pos]["file_name_off"])
+        fileno = self.filenos.get(file_name_off)
+        if fileno is not None:
+            return fileno, None
+        file_name = btf_str_by_offset(self.btf, file_name_off)
+        fileno = len(self.filenos) + 1
+        self.filenos[file_name_off] = fileno
+        return fileno, file_name
+
+    def get_line_col(self):
+        line_col = int(self.linfo[self.pos]["line_col"])
+        return bpf_line_info_line_num(line_col), \
+               bpf_line_info_line_col(line_col)
+
+
+def generate_debug_obj(ksym, prog):
+    name = get_ksym_name(ksym)
+    # Avoid read_memory(); it throws bogus gdb.MemoryError in some contexts.
+    start = ksym["start"]
+    code = start.cast(gdb.lookup_type("unsigned char")
+                      .array(int(ksym["end"]) - int(start))
+                      .pointer()).dereference().bytes
+    linfo_iter = LInfoIter(prog)
+
+    result = tempfile.NamedTemporaryFile(suffix=".o", mode="wb")
+    try:
+        with tempfile.NamedTemporaryFile(suffix=".s", mode="w") as src:
+            # ".loc" does not apply to ".byte"s, only to ".insn"s, but since
+            # this needs to work for all architectures, the latter are not an
+            # option. Ask the assembler to apply ".loc"s to labels as well,
+            # and generate dummy labels after each ".loc".
+            src.write(".loc_mark_labels 1\n")
+
+            src.write(".globl {}\n".format(name))
+            src.write(".type {},@function\n".format(name))
+            src.write("{}:\n".format(name))
+            for code_off, code_byte in enumerate(code):
+                if linfo_iter.get_code_off() == code_off:
+                    fileno, file_name = linfo_iter.get_fileno()
+                    if file_name is not None:
+                        src.write(".file {} {}\n".format(
+                            fileno, json.dumps(file_name)))
+                    line, col = linfo_iter.get_line_col()
+                    src.write(".loc {} {} {}\n".format(fileno, line, col))
+                    src.write("0:\n")
+                    linfo_iter.advance()
+                src.write(".byte {}\n".format(code_byte))
+            src.write(".size {},{}\n".format(name, len(code)))
+            src.flush()
+
+            try:
+                subprocess.check_call(["as", "-c", src.name, "-o", result.name])
+            except FileNotFoundError:
+                # "as" is not installed.
+                result.close()
+                return None
+        return result
+    except:
+        result.close()
+        raise
diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index d5e3069f42a7..5e294840b88d 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -163,3 +163,6 @@ LX_CONFIG(CONFIG_PAGE_OWNER)
 LX_CONFIG(CONFIG_SLUB_DEBUG)
 LX_CONFIG(CONFIG_SLAB_FREELIST_HARDENED)
 LX_CONFIG(CONFIG_MMU)
+LX_CONFIG(CONFIG_BPF)
+LX_CONFIG(CONFIG_BPF_JIT)
+LX_CONFIG(CONFIG_BPF_SYSCALL)
diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index 2332bd8eddf1..e69a02551ab7 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -11,13 +11,14 @@
 # This work is licensed under the terms of the GNU GPL version 2.
 #
 
+import atexit
 import gdb
 import os
 import re
 import struct
 
 from itertools import count
-from linux import modules, utils, constants
+from linux import bpf, constants, modules, utils
 
 
 if hasattr(gdb, 'Breakpoint'):
@@ -97,10 +98,17 @@ lx-symbols command."""
     module_files_updated = False
     loaded_modules = []
     breakpoint = None
+    bpf_prog_monitor = None
+    bpf_ksym_monitor = None
+    bpf_progs = {}
+    # The remove-symbol-file command, even when invoked with -a, requires the
+    # respective object file to exist, so keep them around.
+    bpf_debug_objs = {}
 
     def __init__(self):
         super(LxSymbols, self).__init__("lx-symbols", gdb.COMMAND_FILES,
                                         gdb.COMPLETE_FILENAME)
+        atexit.register(self.cleanup_bpf)
 
     def _update_module_files(self):
         self.module_files = []
@@ -173,6 +181,51 @@ lx-symbols command."""
         else:
             gdb.write("no module object found for '{0}'\n".format(module_name))
 
+    def add_bpf_prog(self, prog):
+        if prog["jited"]:
+            self.bpf_progs[int(prog["bpf_func"])] = prog
+
+    def remove_bpf_prog(self, prog):
+        self.bpf_progs.pop(int(prog["bpf_func"]), None)
+
+    def add_bpf_ksym(self, ksym):
+        addr = int(ksym["start"])
+        name = bpf.get_ksym_name(ksym)
+        with utils.pagination_off():
+            gdb.write("loading @{addr}: {name}\n".format(
+                addr=hex(addr), name=name))
+            debug_obj = bpf.generate_debug_obj(ksym, self.bpf_progs.get(addr))
+            if debug_obj is None:
+                return
+            try:
+                cmdline = "add-symbol-file {obj} {addr}".format(
+                    obj=debug_obj.name, addr=hex(addr))
+                gdb.execute(cmdline, to_string=True)
+            except:
+                debug_obj.close()
+                raise
+            self.bpf_debug_objs[addr] = debug_obj
+
+    def remove_bpf_ksym(self, ksym):
+        addr = int(ksym["start"])
+        debug_obj = self.bpf_debug_objs.pop(addr, None)
+        if debug_obj is None:
+            return
+        try:
+            name = bpf.get_ksym_name(ksym)
+            gdb.write("unloading @{addr}: {name}\n".format(
+                addr=hex(addr), name=name))
+            cmdline = "remove-symbol-file {path}".format(path=debug_obj.name)
+            gdb.execute(cmdline, to_string=True)
+        finally:
+            debug_obj.close()
+
+    def cleanup_bpf(self):
+        self.bpf_progs = {}
+        while len(self.bpf_debug_objs) > 0:
+            self.bpf_debug_objs.popitem()[1].close()
+
+
     def load_all_symbols(self):
         gdb.write("loading vmlinux\n")
 
@@ -200,6 +253,12 @@ lx-symbols command."""
         else:
             [self.load_module_symbols(module) for module in module_list]
 
+        self.cleanup_bpf()
+        if self.bpf_prog_monitor is not None:
+            self.bpf_prog_monitor.notify_initial()
+        if self.bpf_ksym_monitor is not None:
+            self.bpf_ksym_monitor.notify_initial()
+
         for saved_state in saved_states:
             saved_state['breakpoint'].enabled = saved_state['enabled']
 
@@ -223,9 +282,21 @@ lx-symbols command."""
                 self.breakpoint = None
             self.breakpoint = LoadModuleBreakpoint(
                 "kernel/module/main.c:do_init_module", self)
+            if self.bpf_prog_monitor is not None:
+                self.bpf_prog_monitor.delete()
+                self.bpf_prog_monitor = None
+            if constants.LX_CONFIG_BPF_SYSCALL:
+                self.bpf_prog_monitor = bpf.ProgMonitor(self.add_bpf_prog,
+                                                        self.remove_bpf_prog)
+            if self.bpf_ksym_monitor is not None:
+                self.bpf_ksym_monitor.delete()
+                self.bpf_ksym_monitor = None
+            if constants.LX_CONFIG_BPF and constants.LX_CONFIG_BPF_JIT:
+                self.bpf_ksym_monitor = bpf.KsymMonitor(self.add_bpf_ksym,
+                                                        self.remove_bpf_ksym)
         else:
-            gdb.write("Note: symbol update on module loading not supported "
-                      "with this gdb version\n")
+            gdb.write("Note: symbol update on module and BPF loading not "
+                      "supported with this gdb version\n")
 
 
 LxSymbols()
-- 
2.50.0


