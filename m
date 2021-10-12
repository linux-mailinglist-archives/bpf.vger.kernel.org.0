Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1C7429B7F
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 04:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhJLC27 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 22:28:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229556AbhJLC26 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Oct 2021 22:28:58 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C1BQuK011917;
        Mon, 11 Oct 2021 22:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Qma1w9qlX4tRHoR0oQJAv6DQ2Tru53qJPPThvRMA3xw=;
 b=b1c/XItR3pNyY55HooIIoaPeil1r5dOgQMrsak8uqDX1ZFoxKtpHMQLDVXmO28eINCjs
 GZgw8fk8ZwQW+MXQrKAYsNn0Z0noOwkYwzA6GANd6CHZV0mdfn5II6Lq2G9ihbUBmtsI
 rnAiNkOBIQOE3GIYUxrA7GGdmCk/g60hN3ZQuGUBDeI2HMUKmWqS5tOy921mxJUt+EvA
 4CoxsiyEfqPQV40q3VazmY4XY7iOLo/sdpUWJQWxZCQNjAR2IWPcpCwfozZ78MnvI7o/
 0WUoCVHdlzCjJmB90ghTAWUmxZaci6H896gcW48TKI5vsbnaQOmtWlDw44+m2nDgQBaM vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn0fth0k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 22:26:46 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19C20EWu023514;
        Mon, 11 Oct 2021 22:26:45 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn0fth0jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 22:26:45 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19C2BKE5009773;
        Tue, 12 Oct 2021 02:26:43 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3bk2q9bd7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 02:26:43 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19C2Qdm158851810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 02:26:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72BCC11C04A;
        Tue, 12 Oct 2021 02:26:39 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0704011C050;
        Tue, 12 Oct 2021 02:26:39 +0000 (GMT)
Received: from vm.lan (unknown [9.145.45.184])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Oct 2021 02:26:38 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH dwarves] btf_encoder: Fix handling of percpu symbols on s390
Date:   Tue, 12 Oct 2021 04:26:37 +0200
Message-Id: <20211012022637.399365-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6gY22-xijIu8TPfK3fRjdXGdnhV8he50
X-Proofpoint-GUID: u50xLHx7a2BCv07KKzDnRi9XKX1N-7pP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-11_11,2021-10-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120006
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

pahole does not generate VARs for percpu symbols on s390. A percpu
symbol definition on a typical x86_64 kernel looks like this:

  [33] .data..percpu     PROGBITS         0000000000000000  01c00000
                                          ^^^^^^^^^^^^^^^^ sh_addr
  LOAD           0x0000000001c00000 0x0000000000000000 0x000000000286f000
                                    ^^^^^^^^^^^^^^^^^^ p_vaddr
 13559: 000000000001ba50     4 OBJECT  LOCAL  DEFAULT   33 cpu_profile_flip
        ^^^^^^^^^^^^^^^^ st_value

Most importantly, .data..percpu's sh_addr is 0, and this is what pahole
is currently assuming. However, on s390 this is different:

   [37] .data..percpu     PROGBITS         00000000019cd000  018ce000
                                           ^^^^^^^^^^^^^^^^ sh_addr
  LOAD           0x000000000136e000 0x000000000146d000 0x000000000146d000
                                    ^^^^^^^^^^^^^^^^^^ p_vaddr
80377: 0000000001ba1440     4 OBJECT  WEAK   DEFAULT   37 cpu_profile_flip
       ^^^^^^^^^^^^^^^^ st_value

Fix by restructuring the code to always use section-relative offsets
for symbols. Change the comment to focus on this invariant.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 btf_encoder.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index c341f95..16e90c3 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -56,7 +56,8 @@ struct btf_encoder {
 			  raw_output,
 			  verbose,
 			  force,
-			  gen_floats;
+			  gen_floats,
+			  is_rel;
 	uint32_t	  array_index_id;
 	struct {
 		struct var_info vars[MAX_PERCPU_VAR_CNT];
@@ -1104,6 +1105,13 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
 	if (encoder->verbose)
 		printf("Found per-CPU symbol '%s' at address 0x%" PRIx64 "\n", sym_name, addr);
 
+	/* Make sure addr is section-relative. For kernel modules (which are
+	 * ET_REL files) this is already the case. For vmlinux (which is an
+	 * ET_EXEC file) we need to subtract the section address.
+	 */
+	if (!encoder->is_rel)
+		addr -= encoder->percpu.base_addr;
+
 	if (encoder->percpu.var_cnt == MAX_PERCPU_VAR_CNT) {
 		fprintf(stderr, "Reached the limit of per-CPU variables: %d\n",
 			MAX_PERCPU_VAR_CNT);
@@ -1195,12 +1203,9 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, struct
 		addr = var->ip.addr;
 		dwarf_name = variable__name(var);
 
-		/* DWARF takes into account .data..percpu section offset
-		 * within its segment, which for vmlinux is 0, but for kernel
-		 * modules is >0. ELF symbols, on the other hand, don't take
-		 * into account these offsets (as they are relative to the
-		 * section start), so to match DWARF and ELF symbols we need
-		 * to negate the section base address here.
+		/* Make sure addr is section-relative. DWARF, unlike ELF,
+		 * always contains virtual symbol addresses, so subtract
+		 * the section address unconditionally.
 		 */
 		if (addr < encoder->percpu.base_addr || addr >= encoder->percpu.base_addr + encoder->percpu.sec_sz)
 			continue;
@@ -1322,6 +1327,8 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			goto out_delete;
 		}
 
+		encoder->is_rel = ehdr.e_type == ET_REL;
+
 		switch (ehdr.e_ident[EI_DATA]) {
 		case ELFDATA2LSB:
 			btf__set_endianness(encoder->btf, BTF_LITTLE_ENDIAN);
-- 
2.31.1

