Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AE22D6F06
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 05:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395311AbgLKENA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 10 Dec 2020 23:13:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26364 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395297AbgLKEMd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Dec 2020 23:12:33 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BB44srs013346
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 20:11:52 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35brnbk433-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 20:11:52 -0800
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Dec 2020 20:11:51 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 118F62ECB19F; Thu, 10 Dec 2020 20:11:46 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>, <acme@kernel.org>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH dwarves 1/2] btf_encoder: fix BTF variable generation for kernel modules
Date:   Thu, 10 Dec 2020 20:11:37 -0800
Message-ID: <20201211041139.589692-2-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201211041139.589692-1-andrii@kernel.org>
References: <20201211041139.589692-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-11_01:2020-12-09,2020-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 suspectscore=8
 spamscore=0 clxscore=1015 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012110022
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix pahole's logic for determining per-CPU variables. For vmlinux,
btfe->percpu_base_addr is always 0, so it didn't matter at which point to
subtract it to get offset that later was matched against corresponding ELF
symbol.

For kernel module, though, the situation is different. Kernel module's per-CPU
data section has non-zero offset, which is taken into account in all DWARF
variable addresses calculation. For such cases, it's important to subtract
section offset (btfe->percpu_base_addr) before ELF symbol look up is
performed.

This patch also records per-CPU data section size and uses it for early
filtering of non-per-CPU variables by their address.

Fixes: 2e719cca6672 ("btf_encoder: revamp how per-CPU variables are encoded")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 btf_encoder.c | 21 ++++++++++++++++-----
 libbtf.c      |  1 +
 libbtf.h      |  1 +
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index c40f059580da..a7d484765ce2 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -651,7 +651,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		printf("search cu '%s' for percpu global variables.\n", cu->name);
 
 	cu__for_each_variable(cu, core_id, pos) {
-		uint32_t size, type, linkage, offset;
+		uint32_t size, type, linkage;
 		const char *name;
 		uint64_t addr;
 		int id;
@@ -665,12 +665,24 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 
 		/* addr has to be recorded before we follow spec */
 		addr = var->ip.addr;
-		if (var->spec)
-			var = var->spec;
+
+		/* DWARF takes into account .data..percpu section offset
+		 * within its segment, which for vmlinux is 0, but for kernel
+		 * modules is >0. ELF symbols, on the other hand, don't take
+		 * into account these offsets (as they are relative to the
+		 * section start), so to match DWARF and ELF symbols we need
+		 * to negate the section base address here.
+		 */
+		if (addr < btfe->percpu_base_addr || addr >= btfe->percpu_base_addr + btfe->percpu_sec_sz)
+			continue;
+		addr -= btfe->percpu_base_addr;
 
 		if (!percpu_var_exists(addr, &size, &name))
 			continue; /* not a per-CPU variable */
 
+		if (var->spec)
+			var = var->spec;
+
 		if (var->ip.tag.type == 0) {
 			fprintf(stderr, "error: found variable '%s' in CU '%s' that has void type\n",
 				name, cu->name);
@@ -701,8 +713,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		 * add a BTF_VAR_SECINFO in btfe->percpu_secinfo, which will be added into
 		 * btfe->types later when we add BTF_VAR_DATASEC.
 		 */
-		offset = addr - btfe->percpu_base_addr;
-		id = btf_elf__add_var_secinfo(&btfe->percpu_secinfo, id, offset, size);
+		id = btf_elf__add_var_secinfo(&btfe->percpu_secinfo, id, addr, size);
 		if (id < 0) {
 			err = -1;
 			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%lx\n",
diff --git a/libbtf.c b/libbtf.c
index 246762c4b4e1..16e1d451e433 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -170,6 +170,7 @@ try_as_raw_btf:
 	}
 	btfe->percpu_shndx = elf_ndxscn(sec);
 	btfe->percpu_base_addr = shdr.sh_addr;
+	btfe->percpu_sec_sz = shdr.sh_size;
 
 	return btfe;
 
diff --git a/libbtf.h b/libbtf.h
index 71f6cecbea93..191f5862a695 100644
--- a/libbtf.h
+++ b/libbtf.h
@@ -26,6 +26,7 @@ struct btf_elf {
 	bool		  raw_btf; // "/sys/kernel/btf/vmlinux"
 	uint32_t	  percpu_shndx;
 	uint64_t	  percpu_base_addr;
+	uint64_t	  percpu_sec_sz;
 	struct btf	  *btf;
 	struct btf	  *base_btf;
 };
-- 
2.24.1

