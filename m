Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BD9439743
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 15:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhJYNPD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 09:15:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233438AbhJYNPC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 09:15:02 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PCM4Pu028581;
        Mon, 25 Oct 2021 13:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HllcITfaRJQKbKx6ObOq8j1K/aQGCSROYiW8jjvg1e0=;
 b=f+mloGPvLehf+OHhdgAlOL075PlrvE1ZDGfJu5bn4AU1Igz/adroX3hhJb6uFZjv4Fs7
 jHCODiAT37GE51SUHhmv9+xTLYjuLxLI9Jvt1iQth7gYuijfou+DEsDLthhZRC2CupPR
 xpJUsHtolaOxCdzGHGjWUbgA+d2+Z+C020FGSx+m7qxDwP1xHJ9Fh+AxUp1GuLT6B3qY
 gX/k/+VB/2Q9KmY2uly0l4rafTRZIJe7ThStftkM7N/J5151B4etgWbaJvhtCgzhf6FG
 gWX3WKf32AtrxQwbdPMuLd8XzCmGdvwssrl1TsD/XEm7JVn6GLTgxfTwVAnOWBefsums nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bwt0tweug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 13:12:27 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19PCtwfR008337;
        Mon, 25 Oct 2021 13:12:26 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bwt0twetr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 13:12:26 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19PD8nKq023711;
        Mon, 25 Oct 2021 13:12:24 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3bv9njf1vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 13:12:24 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19PDCHEn4850254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Oct 2021 13:12:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CC50A406E;
        Mon, 25 Oct 2021 13:12:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC0D9A4055;
        Mon, 25 Oct 2021 13:12:16 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Oct 2021 13:12:16 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 1/5] libbpf: Use __BYTE_ORDER__
Date:   Mon, 25 Oct 2021 15:12:10 +0200
Message-Id: <20211025131214.731972-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025131214.731972-1-iii@linux.ibm.com>
References: <20211025131214.731972-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2f9VwxtospVBQz3loIcNxY5cTl4pglou
X-Proofpoint-GUID: TEg-49OeM2Zmzdg231rAtIJHYmN9gKis
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_05,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110250081
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

__BYTE_ORDER is supposed to be defined by a libc, and __BYTE_ORDER__ -
by a compiler. bpf_core_read.h checks __BYTE_ORDER == __LITTLE_ENDIAN,
which is true if neither are defined, leading to incorrect behavior on
big-endian hosts if libc headers are not included, which is often the
case.

Instead of changing just this particular location, replace all
occurrences of __BYTE_ORDER with __BYTE_ORDER__ in libbpf code for
consistency.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf_core_read.h |  2 +-
 tools/lib/bpf/btf.c           |  4 ++--
 tools/lib/bpf/btf_dump.c      |  8 ++++----
 tools/lib/bpf/libbpf.c        |  4 ++--
 tools/lib/bpf/linker.c        | 12 ++++++------
 tools/lib/bpf/relo_core.c     |  2 +-
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index 09ebe3db5f2f..e4aa9996a550 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -40,7 +40,7 @@ enum bpf_enum_value_kind {
 #define __CORE_RELO(src, field, info)					      \
 	__builtin_preserve_field_info((src)->field, BPF_FIELD_##info)
 
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #define __CORE_BITFIELD_PROBE_READ(dst, src, fld)			      \
 	bpf_probe_read_kernel(						      \
 			(void *)dst,				      \
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

