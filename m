Return-Path: <bpf+bounces-73832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F13C3B017
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 13:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F2EC4FF7B8
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB45C32E752;
	Thu,  6 Nov 2025 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hhBsgRTd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BC3D531;
	Thu,  6 Nov 2025 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433187; cv=none; b=ouiZLkaMGhn+RzSfSMEkCsdboFpQ6xnZgQqBrTqvbGb8nOBdGtWTJnjqH2itaXGRa6z8xCtlCQTNA0pwwFtqiLHFpsP9WhY+YPagbgrkJXpD/ZduxE/K3n/JM1nhM9Dud6PHvS4qbhUViJCMNHmRXLlxBcoy2iu+aqktynj3bCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433187; c=relaxed/simple;
	bh=aFbD3zBAV9LR0FkaSnlpo7/D0GzYOTkpCqQlrRFwbPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5b07S+YkmZ6CYWdmhhErlHDmdUDCYyEZA+MKaqlJYcLZB2jf3mrvTZ/w/gzrcBcMaa0IUUqblppP3hdO+IYI1q2R5wRct5zshj13EvCoXbVaFDhW46liGm1qfPL2JtgTRXo1rHhjWWuQBosCqALxyOgRVRgqNTbFM2i2tdUrbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hhBsgRTd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A66ef3q006440;
	Thu, 6 Nov 2025 12:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wPhyyVX3yg6/ZLMKf
	n/5Hzz80sux4OCqGUGgqrNZu9s=; b=hhBsgRTdXr652uEemLt5SKVPF2hYg7o22
	RWvG3V4L+UFfX2o5aLZ3KmONpEWw3QuvSSFCc2V7Crid+PDC1FriDypDYmI0PDpG
	hHFV6MYVGKpdGkA5LX/5uQuC3KbZPMFVXC5Q4z1oCUztFGs/xqqASU42S+vFs7d0
	pIoMFcxHdB8jJwzx/4M4y+Eme78MBlmwnxRG6lupMZRwbX4YL7iKDpZf0kMUYVli
	BF95l/Ejdhxumxxf0i2KyXZUHaFjVDiMyNgLdkE2T9i77fYXpjwYpBWwuLqm+Ps+
	FRECPx1Mieaem4ja8Gvyg4sacIubohEmmTPiWI+tssnx8LDBcvSKQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q974fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 12:46:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6BcoQS019320;
	Thu, 6 Nov 2025 12:46:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5whnnecs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 12:46:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A6Ck3TK46399850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Nov 2025 12:46:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9212D20040;
	Thu,  6 Nov 2025 12:46:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F15B92004B;
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
Subject: [PATCH v2 2/2] scripts/gdb/symbols: make BPF debug info available to GDB
Date: Thu,  6 Nov 2025 13:43:42 +0100
Message-ID: <20251106124600.86736-3-iii@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=StmdKfO0 c=1 sm=1 tr=0 ts=690c9890 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=mZVBiUfv53FztKkDeUYA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: u1UfxgJucRiLK2S_WySJNvZItfn8fkKB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxOCBTYWx0ZWRfX2TEBdXi87/nd
 USwZCYgnLd8Pqxp5FMlMc5du3QizGtCSguJ0h41ufJDhWAoSSwFk7HG8vEx/+NUmIEWT9NfoOsS
 Szi6HWm0VQQsmkHpUrJB1wbAOOAPOD2qwSasmDXy9fOvelfkZKqN/Zbq0Wmg397+weh9I4v37aI
 HosR6EBHFtQtjzE8l5MjPhjLeW4aiIqHkh1Lpw9v68aSoT/suw3U0AEHcC0jF8DqTRpMe+LF9DS
 Wp/3YV91ihzke1OKyCYwPiCkZYgWjOgJ0y71am8aCd682sPQCCJuKaGT9LbfIJmfzXf66T1Ptyl
 apazYoKnKm+/QzI6vZZjztZZ5E8drfC5Z61qGmDP3Ojm+NThYW7lL1SaYLf/Of6MUboYOPmfP7S
 fvr4wUXn+S4K2lUVEse76hqBo70wKg==
X-Proofpoint-GUID: u1UfxgJucRiLK2S_WySJNvZItfn8fkKB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010018

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

    (gdb) lx-symbols -bpf
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
 scripts/gdb/linux/symbols.py      | 105 +++++++++++--
 3 files changed, 349 insertions(+), 12 deletions(-)
 create mode 100644 scripts/gdb/linux/bpf.py

diff --git a/scripts/gdb/linux/bpf.py b/scripts/gdb/linux/bpf.py
new file mode 100644
index 0000000000000..1870534ef6f9b
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
+    def delete(self):
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
index c3886739a0289..6d475540c6ba6 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -170,3 +170,6 @@ LX_CONFIG(CONFIG_PAGE_OWNER)
 LX_CONFIG(CONFIG_SLUB_DEBUG)
 LX_CONFIG(CONFIG_SLAB_FREELIST_HARDENED)
 LX_CONFIG(CONFIG_MMU)
+LX_CONFIG(CONFIG_BPF)
+LX_CONFIG(CONFIG_BPF_JIT)
+LX_CONFIG(CONFIG_BPF_SYSCALL)
diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index 6edb992216755..d4308b7261838 100644
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
@@ -114,17 +115,27 @@ class LxSymbols(gdb.Command):
 The kernel (vmlinux) is taken from the current working directly. Modules (.ko)
 are scanned recursively, starting in the same directory. Optionally, the module
 search path can be extended by a space separated list of paths passed to the
-lx-symbols command."""
+lx-symbols command.
+
+When the -bpf flag is specified, symbols from the currently loaded BPF programs
+are loaded as well."""
 
     module_paths = []
     module_files = []
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
@@ -197,6 +208,51 @@ lx-symbols command."""
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
 
@@ -224,34 +280,59 @@ lx-symbols command."""
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
 
     def invoke(self, arg, from_tty):
         skip_decompressor()
 
-        self.module_paths = [os.path.abspath(os.path.expanduser(p))
-                             for p in arg.split()]
+        monitor_bpf = False
+        self.module_paths = []
+        for p in arg.split():
+            if p == "-bpf":
+                monitor_bpf = True
+            else:
+                p.append(os.path.abspath(os.path.expanduser(p)))
         self.module_paths.append(os.getcwd())
 
+        if self.breakpoint is not None:
+            self.breakpoint.delete()
+            self.breakpoint = None
+        if self.bpf_prog_monitor is not None:
+            self.bpf_prog_monitor.delete()
+            self.bpf_prog_monitor = None
+        if self.bpf_ksym_monitor is not None:
+            self.bpf_ksym_monitor.delete()
+            self.bpf_ksym_monitor = None
+
         # enforce update
         self.module_files = []
         self.module_files_updated = False
 
         self.load_all_symbols()
 
-        if not modules.has_modules():
+        if not hasattr(gdb, 'Breakpoint'):
+            gdb.write("Note: symbol update on module and BPF loading not "
+                      "supported with this gdb version\n")
             return
 
-        if hasattr(gdb, 'Breakpoint'):
-            if self.breakpoint is not None:
-                self.breakpoint.delete()
-                self.breakpoint = None
+        if modules.has_modules():
             self.breakpoint = LoadModuleBreakpoint(
                 "kernel/module/main.c:do_init_module", self)
-        else:
-            gdb.write("Note: symbol update on module loading not supported "
-                      "with this gdb version\n")
+
+        if monitor_bpf:
+            if constants.LX_CONFIG_BPF_SYSCALL:
+                self.bpf_prog_monitor = bpf.ProgMonitor(self.add_bpf_prog,
+                                                        self.remove_bpf_prog)
+            if constants.LX_CONFIG_BPF and constants.LX_CONFIG_BPF_JIT:
+                self.bpf_ksym_monitor = bpf.KsymMonitor(self.add_bpf_ksym,
+                                                        self.remove_bpf_ksym)
 
 
 LxSymbols()
-- 
2.51.1


