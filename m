Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F15A43A991
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 03:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbhJZBLR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 21:11:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236030AbhJZBLO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 21:11:14 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PNgTxP021307;
        Tue, 26 Oct 2021 01:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qN0RPFjSxYKWVDQVjkpEBeuWf34iC9MoU7ZpOfc/6Ko=;
 b=NKS9mxIhle3A2IrbHaELE41DH5ODZWQBl1bWLBRgWt/eB/5IZNJzmcxvXnOYCMNujsHU
 6BbbbAJid01XrssyJzoo1azM+6HJLP0SUHnv0Mky/EQ04SDkKSuMF/2Vu/QNf96ePHnT
 HAnPBcENhG1DWkrjiNScp3MiVuRT64PtEDf7PQJfdESfyy2DJ0wE8bO+e/OR+rV3Qq16
 0DYiWUr8r+f+Yiad4PY3D6vZmJcCUxAXKsaIygs4SSG40JLlQWLz1I7U0PbSWrNcVJqN
 YW+cvQiiofbEVDkdecccKTUV9XIkmCKZJiacnYVfmhRu/MHklrYJ1Tv3u5usFoUgdE5Z 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bx5ewtvea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 01:08:39 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19Q0vkGY000927;
        Tue, 26 Oct 2021 01:08:39 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bx5ewtvdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 01:08:38 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19Q12LLK009083;
        Tue, 26 Oct 2021 01:08:37 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3bx4esrt90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 01:08:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19Q18Ygv55116260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 01:08:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBC6C42045;
        Tue, 26 Oct 2021 01:08:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D21742042;
        Tue, 26 Oct 2021 01:08:33 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Oct 2021 01:08:33 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 2/6] libbpf: Use __BYTE_ORDER__
Date:   Tue, 26 Oct 2021 03:08:27 +0200
Message-Id: <20211026010831.748682-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026010831.748682-1-iii@linux.ibm.com>
References: <20211026010831.748682-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MYKkDA2BAkT-Png9oNKoa-h9UWj4vhnD
X-Proofpoint-ORIG-GUID: 683PAVmJYdM4kfoxQ8-AWhSpKX3fQ_24
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_08,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260001
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use the compiler-defined __BYTE_ORDER__ instead of the libc-defined
__BYTE_ORDER for consistency.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/btf.c       |  4 ++--
 tools/lib/bpf/btf_dump.c  |  8 ++++----
 tools/lib/bpf/libbpf.c    |  4 ++--
 tools/lib/bpf/linker.c    | 12 ++++++------
 tools/lib/bpf/relo_core.c |  2 +-
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index ef924fc2c911..0c628c33e23b 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -538,9 +538,9 @@ int btf__set_pointer_size(struct btf *btf, size_t ptr_sz)
 
 static bool is_host_big_endian(void)
 {
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	return false;
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 	return true;
 #else
 # error "Unrecognized __BYTE_ORDER__"
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 8e05ab44c22a..17db62b5002e 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1576,11 +1576,11 @@ static int btf_dump_get_bitfield_value(struct btf_dump *d,
 	/* Bitfield value retrieval is done in two steps; first relevant bytes are
 	 * stored in num, then we left/right shift num to eliminate irrelevant bits.
 	 */
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	for (i = t->size - 1; i >= 0; i--)
 		num = num * 256 + bytes[i];
 	nr_copy_bits = bit_sz + bits_offset;
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 	for (i = 0; i < t->size; i++)
 		num = num * 256 + bytes[i];
 	nr_copy_bits = t->size * 8 - bits_offset;
@@ -1700,10 +1700,10 @@ static int btf_dump_int_data(struct btf_dump *d,
 		/* avoid use of __int128 as some 32-bit platforms do not
 		 * support it.
 		 */
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 		lsi = ints[0];
 		msi = ints[1];
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 		lsi = ints[1];
 		msi = ints[0];
 #else
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 604abe00785f..cd6132c5a416 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1299,10 +1299,10 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 
 static int bpf_object__check_endianness(struct bpf_object *obj)
 {
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	if (obj->efile.ehdr->e_ident[EI_DATA] == ELFDATA2LSB)
 		return 0;
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 	if (obj->efile.ehdr->e_ident[EI_DATA] == ELFDATA2MSB)
 		return 0;
 #else
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 7bf658fbda80..ce0800e61dc7 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -323,12 +323,12 @@ static int init_output_elf(struct bpf_linker *linker, const char *file)
 
 	linker->elf_hdr->e_machine = EM_BPF;
 	linker->elf_hdr->e_type = ET_REL;
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	linker->elf_hdr->e_ident[EI_DATA] = ELFDATA2LSB;
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 	linker->elf_hdr->e_ident[EI_DATA] = ELFDATA2MSB;
 #else
-#error "Unknown __BYTE_ORDER"
+#error "Unknown __BYTE_ORDER__"
 #endif
 
 	/* STRTAB */
@@ -538,12 +538,12 @@ static int linker_load_obj_file(struct bpf_linker *linker, const char *filename,
 				const struct bpf_linker_file_opts *opts,
 				struct src_obj *obj)
 {
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	const int host_endianness = ELFDATA2LSB;
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 	const int host_endianness = ELFDATA2MSB;
 #else
-#error "Unknown __BYTE_ORDER"
+#error "Unknown __BYTE_ORDER__"
 #endif
 	int err = 0;
 	Elf_Scn *scn;
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 4016ed492d0c..b5b8956a1be8 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -662,7 +662,7 @@ static int bpf_core_calc_field_relo(const char *prog_name,
 			*validate = true; /* signedness is never ambiguous */
 		break;
 	case BPF_FIELD_LSHIFT_U64:
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 		*val = 64 - (bit_off + bit_sz - byte_off  * 8);
 #else
 		*val = (8 - byte_sz) * 8 + (bit_off - byte_off * 8);
-- 
2.31.1

