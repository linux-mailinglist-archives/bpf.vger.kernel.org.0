Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C78436E80
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 01:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhJUXtc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 19:49:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44600 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231441AbhJUXtb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Oct 2021 19:49:31 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LMFrsY037714;
        Thu, 21 Oct 2021 19:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vEpLVFyfVJkKDpUi+Olblv6L43uAY6ROWm2h63U16Og=;
 b=SZ423ykIu67gJ1pGVrVfZWbZg0mNUslYf8FfP8M9ij7Vbn+xPfJEpY855iSw1rQYoCUC
 oKFC6fVqouGgK9iUmDm7HBzErbo9WSe5bPwPGtcHTb6THQXFhvbrorJQsLoRtenBUD5T
 3HWRDc7DkL647oYrlLbbdyxP6TDAz3iE1FP19ZVCjYdhiQ/DB1r26OzHBiCCBkMNecNu
 NfrARfSMfAyj3J2fDSBMe4UleN37hOZVNstRvfpsA1M0lJu1uS1LnWxzhu3HDNNUo1Cx
 o9vVAeLePHtyIOvaqoVswYqvYofJZZl+gEWGz4xxurAYDyEnPeEUraS7AGZsK50m8B29 OA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3buep4c1sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 19:47:00 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19LNigUZ013619;
        Thu, 21 Oct 2021 19:47:00 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3buep4c1sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 19:47:00 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19LNfktY008504;
        Thu, 21 Oct 2021 23:46:58 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3bqpca8cn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 23:46:58 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19LNkt6x3408560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 23:46:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41E895204E;
        Thu, 21 Oct 2021 23:46:55 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id DDDF552052;
        Thu, 21 Oct 2021 23:46:54 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 1/3] bpf: Use __BYTE_ORDER__ everywhere
Date:   Fri, 22 Oct 2021 01:46:51 +0200
Message-Id: <20211021234653.643302-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021234653.643302-1-iii@linux.ibm.com>
References: <20211021234653.643302-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BGZjr1FuUEa3UU_GuVbIbAvxEAZkOE0h
X-Proofpoint-ORIG-GUID: qOTMRPC6_CenlHf5qd-e7Lt0eGlXLFMy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_07,2021-10-21_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 mlxscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210117
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

__BYTE_ORDER is supposed to be defined by a libc, and __BYTE_ORDER__ -
by a compiler. bpf_core_read.h checks __BYTE_ORDER == __LITTLE_ENDIAN,
which is true if neither are defined, leading to incorrect behavior on
big-endian hosts if libc headers are not included, which is often the
case.

Instead of changing just this particular location, replace all
occurrences of __BYTE_ORDER with __BYTE_ORDER__ in bpf code for
consistency.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 samples/seccomp/bpf-helper.h                       |  8 ++++----
 tools/lib/bpf/bpf_core_read.h                      |  2 +-
 tools/lib/bpf/btf.c                                |  4 ++--
 tools/lib/bpf/btf_dump.c                           |  8 ++++----
 tools/lib/bpf/libbpf.c                             |  4 ++--
 tools/lib/bpf/linker.c                             | 12 ++++++------
 tools/lib/bpf/relo_core.c                          |  2 +-
 .../testing/selftests/bpf/prog_tests/btf_endian.c  |  6 +++---
 tools/testing/selftests/bpf/test_sysctl.c          |  4 ++--
 tools/testing/selftests/bpf/verifier/ctx_skb.c     | 14 +++++++-------
 tools/testing/selftests/bpf/verifier/lwt.c         |  2 +-
 .../bpf/verifier/perf_event_sample_period.c        |  6 +++---
 tools/testing/selftests/seccomp/seccomp_bpf.c      |  6 +++---
 13 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/samples/seccomp/bpf-helper.h b/samples/seccomp/bpf-helper.h
index 0cc9816fe8e8..417e48a4c4df 100644
--- a/samples/seccomp/bpf-helper.h
+++ b/samples/seccomp/bpf-helper.h
@@ -62,9 +62,9 @@ void seccomp_bpf_print(struct sock_filter *filter, size_t count);
 #define EXPAND(...) __VA_ARGS__
 
 /* Ensure that we load the logically correct offset. */
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #define LO_ARG(idx) offsetof(struct seccomp_data, args[(idx)])
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 #define LO_ARG(idx) offsetof(struct seccomp_data, args[(idx)]) + sizeof(__u32)
 #else
 #error "Unknown endianness"
@@ -85,10 +85,10 @@ void seccomp_bpf_print(struct sock_filter *filter, size_t count);
 #elif __BITS_PER_LONG == 64
 
 /* Ensure that we load the logically correct offset. */
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #define ENDIAN(_lo, _hi) _lo, _hi
 #define HI_ARG(idx) offsetof(struct seccomp_data, args[(idx)]) + sizeof(__u32)
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 #define ENDIAN(_lo, _hi) _hi, _lo
 #define HI_ARG(idx) offsetof(struct seccomp_data, args[(idx)])
 #endif
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
index 1f6dea11f600..40a2b2045246 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -527,9 +527,9 @@ int btf__set_pointer_size(struct btf *btf, size_t ptr_sz)
 
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
index e9e5801ece4c..2562b45747d8 100644
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
index 760c7e346603..12f4f06baf84 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1280,10 +1280,10 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 
 static int bpf_object__check_endianness(struct bpf_object *obj)
 {
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	if (obj->efile.ehdr.e_ident[EI_DATA] == ELFDATA2LSB)
 		return 0;
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 	if (obj->efile.ehdr.e_ident[EI_DATA] == ELFDATA2MSB)
 		return 0;
 #else
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 2df880cefdae..ebf4bab93b3d 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -324,12 +324,12 @@ static int init_output_elf(struct bpf_linker *linker, const char *file)
 
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
@@ -539,12 +539,12 @@ static int linker_load_obj_file(struct bpf_linker *linker, const char *filename,
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
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_endian.c b/tools/testing/selftests/bpf/prog_tests/btf_endian.c
index 8ab5d3e358dd..0faec46eeff7 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_endian.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_endian.c
@@ -7,12 +7,12 @@
 #include <bpf/btf.h>
 
 void test_btf_endian() {
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	enum btf_endianness endian = BTF_LITTLE_ENDIAN;
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 	enum btf_endianness endian = BTF_BIG_ENDIAN;
 #else
-#error "Unrecognized __BYTE_ORDER"
+#error "Unrecognized __BYTE_ORDER__"
 #endif
 	enum btf_endianness swap_endian = 1 - endian;
 	struct btf *btf = NULL, *swap_btf = NULL;
diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
index a20a919244c0..a3bb6d399daa 100644
--- a/tools/testing/selftests/bpf/test_sysctl.c
+++ b/tools/testing/selftests/bpf/test_sysctl.c
@@ -124,7 +124,7 @@ static struct sysctl_test tests[] = {
 		.descr = "ctx:write sysctl:write read ok narrow",
 		.insns = {
 			/* u64 w = (u16)write & 1; */
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 			BPF_LDX_MEM(BPF_H, BPF_REG_7, BPF_REG_1,
 				    offsetof(struct bpf_sysctl, write)),
 #else
@@ -184,7 +184,7 @@ static struct sysctl_test tests[] = {
 		.descr = "ctx:file_pos sysctl:read read ok narrow",
 		.insns = {
 			/* If (file_pos == X) */
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 			BPF_LDX_MEM(BPF_B, BPF_REG_7, BPF_REG_1,
 				    offsetof(struct bpf_sysctl, file_pos)),
 #else
diff --git a/tools/testing/selftests/bpf/verifier/ctx_skb.c b/tools/testing/selftests/bpf/verifier/ctx_skb.c
index 9e1a30b94197..83cecfbd6739 100644
--- a/tools/testing/selftests/bpf/verifier/ctx_skb.c
+++ b/tools/testing/selftests/bpf/verifier/ctx_skb.c
@@ -502,7 +502,7 @@
 	"check skb->hash byte load permitted",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, hash)),
 #else
@@ -537,7 +537,7 @@
 	"check skb->hash byte load permitted 3",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, hash) + 3),
 #else
@@ -646,7 +646,7 @@
 	"check skb->hash half load permitted",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, hash)),
 #else
@@ -661,7 +661,7 @@
 	"check skb->hash half load permitted 2",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, hash) + 2),
 #else
@@ -676,7 +676,7 @@
 	"check skb->hash half load not permitted, unaligned 1",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, hash) + 1),
 #else
@@ -693,7 +693,7 @@
 	"check skb->hash half load not permitted, unaligned 3",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, hash) + 3),
 #else
@@ -951,7 +951,7 @@
 	"check skb->data half load not permitted",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, data)),
 #else
diff --git a/tools/testing/selftests/bpf/verifier/lwt.c b/tools/testing/selftests/bpf/verifier/lwt.c
index 2cab6a3966bb..5c8944d0b091 100644
--- a/tools/testing/selftests/bpf/verifier/lwt.c
+++ b/tools/testing/selftests/bpf/verifier/lwt.c
@@ -174,7 +174,7 @@
 	"check skb->tc_classid half load not permitted for lwt prog",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, tc_classid)),
 #else
diff --git a/tools/testing/selftests/bpf/verifier/perf_event_sample_period.c b/tools/testing/selftests/bpf/verifier/perf_event_sample_period.c
index 471c1a5950d8..d8a9b1a1f9a2 100644
--- a/tools/testing/selftests/bpf/verifier/perf_event_sample_period.c
+++ b/tools/testing/selftests/bpf/verifier/perf_event_sample_period.c
@@ -2,7 +2,7 @@
 	"check bpf_perf_event_data->sample_period byte load permitted",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct bpf_perf_event_data, sample_period)),
 #else
@@ -18,7 +18,7 @@
 	"check bpf_perf_event_data->sample_period half load permitted",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct bpf_perf_event_data, sample_period)),
 #else
@@ -34,7 +34,7 @@
 	"check bpf_perf_event_data->sample_period word load permitted",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct bpf_perf_event_data, sample_period)),
 #else
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 1d64891e6492..d425688cf59c 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -276,12 +276,12 @@ int seccomp(unsigned int op, unsigned int flags, void *args)
 }
 #endif
 
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #define syscall_arg(_n) (offsetof(struct seccomp_data, args[_n]))
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 #define syscall_arg(_n) (offsetof(struct seccomp_data, args[_n]) + sizeof(__u32))
 #else
-#error "wut? Unknown __BYTE_ORDER?!"
+#error "wut? Unknown __BYTE_ORDER__?!"
 #endif
 
 #define SIBLING_EXIT_UNKILLED	0xbadbeef
-- 
2.31.1

