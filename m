Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6DF53F1EE
	for <lists+bpf@lfdr.de>; Tue,  7 Jun 2022 00:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiFFWCQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 6 Jun 2022 18:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiFFWCP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jun 2022 18:02:15 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111105FC8
        for <bpf@vger.kernel.org>; Mon,  6 Jun 2022 15:02:13 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256Lq5hW012870
        for <bpf@vger.kernel.org>; Mon, 6 Jun 2022 15:02:13 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gg4wxbatg-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 06 Jun 2022 15:02:13 -0700
Received: from twshared3657.05.prn5.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 6 Jun 2022 15:02:10 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A8B0C1AED15B2; Mon,  6 Jun 2022 15:01:45 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Riham Selim <rihams@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] libbpf: fix uprobe symbol file offset calculation logic
Date:   Mon, 6 Jun 2022 15:01:43 -0700
Message-ID: <20220606220143.3796908-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gdPDWS6Ul5zrMcghMhZ-TwfSm6pa2JMN
X-Proofpoint-GUID: gdPDWS6Ul5zrMcghMhZ-TwfSm6pa2JMN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_07,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix libbpf's bpf_program__attach_uprobe() logic of determining
function's *file offset* (which is what kernel is actually expecting)
when attaching uprobe/uretprobe by function name. Previously calculation
was determining virtual address offset relative to base load address,
which (offset) is not always the same as file offset (though very
frequently it is which is why this went unnoticed for a while).

Cc: Riham Selim <rihams@fb.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Fixes: 433966e3ae04 ("libbpf: Support function name-based attach uprobes")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 63 +++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 41 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b03165687936..6c4555d0ea07 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11143,43 +11143,6 @@ static int perf_event_uprobe_open_legacy(const char *probe_name, bool retprobe,
 	return pfd;
 }
 
-/* uprobes deal in relative offsets; subtract the base address associated with
- * the mapped binary.  See Documentation/trace/uprobetracer.rst for more
- * details.
- */
-static long elf_find_relative_offset(const char *filename, Elf *elf, long addr)
-{
-	size_t n;
-	int i;
-
-	if (elf_getphdrnum(elf, &n)) {
-		pr_warn("elf: failed to find program headers for '%s': %s\n", filename,
-			elf_errmsg(-1));
-		return -ENOENT;
-	}
-
-	for (i = 0; i < n; i++) {
-		int seg_start, seg_end, seg_offset;
-		GElf_Phdr phdr;
-
-		if (!gelf_getphdr(elf, i, &phdr)) {
-			pr_warn("elf: failed to get program header %d from '%s': %s\n", i, filename,
-				elf_errmsg(-1));
-			return -ENOENT;
-		}
-		if (phdr.p_type != PT_LOAD || !(phdr.p_flags & PF_X))
-			continue;
-
-		seg_start = phdr.p_vaddr;
-		seg_end = seg_start + phdr.p_memsz;
-		seg_offset = phdr.p_offset;
-		if (addr >= seg_start && addr < seg_end)
-			return addr - seg_start + seg_offset;
-	}
-	pr_warn("elf: failed to find prog header containing 0x%lx in '%s'\n", addr, filename);
-	return -ENOENT;
-}
-
 /* Return next ELF section of sh_type after scn, or first of that type if scn is NULL. */
 static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn *scn)
 {
@@ -11266,6 +11229,8 @@ static long elf_find_func_offset(const char *binary_path, const char *name)
 		for (idx = 0; idx < nr_syms; idx++) {
 			int curr_bind;
 			GElf_Sym sym;
+			Elf_Scn *sym_scn;
+			GElf_Shdr sym_sh;
 
 			if (!gelf_getsym(symbols, idx, &sym))
 				continue;
@@ -11303,12 +11268,28 @@ static long elf_find_func_offset(const char *binary_path, const char *name)
 					continue;
 				}
 			}
-			ret = sym.st_value;
+
+			/* Transform symbol's virtual address (absolute for
+			 * binaries and relative for shared libs) into file
+			 * offset, which is what kernel is expecting for
+			 * uprobe/uretprobe attachment.
+			 * See Documentation/trace/uprobetracer.rst for more
+			 * details.
+			 * This is done by looking up symbol's containing
+			 * section's header and using it's virtual address
+			 * (sh_addr) and corresponding file offset (sh_offset)
+			 * to transform sym.st_value (virtual address) into
+			 * desired final file offset.
+			 */
+			sym_scn = elf_getscn(elf, sym.st_shndx);
+			if (!sym_scn)
+				continue;
+			if (!gelf_getshdr(sym_scn, &sym_sh))
+				continue;
+
+			ret = sym.st_value - sym_sh.sh_addr + sym_sh.sh_offset;
 			last_bind = curr_bind;
 		}
-		/* For binaries that are not shared libraries, we need relative offset */
-		if (ret > 0 && !is_shared_lib)
-			ret = elf_find_relative_offset(binary_path, elf, ret);
 		if (ret > 0)
 			break;
 	}
-- 
2.30.2

