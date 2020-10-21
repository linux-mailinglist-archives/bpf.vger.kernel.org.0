Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A914A295032
	for <lists+bpf@lfdr.de>; Wed, 21 Oct 2020 17:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444168AbgJUPwf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 21 Oct 2020 11:52:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28988 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731691AbgJUPwf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 21 Oct 2020 11:52:35 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 09LFnImo015671
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2020 08:52:34 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 349s0m0uua-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2020 08:52:34 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 21 Oct 2020 08:52:32 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 3F7652EC8329; Wed, 21 Oct 2020 08:52:27 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>, <acme@kernel.org>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH dwarves] btf_encoder: ignore zero-sized ELF symbols
Date:   Wed, 21 Oct 2020 08:52:20 -0700
Message-ID: <20201021155220.1737964-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-21_06:2020-10-20,2020-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 phishscore=0 mlxlogscore=940 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010210116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's legal for ELF symbol to have size 0, if it's size is unknown or
unspecified. Instead of erroring out, just ignore such symbols, as they can't
be a valid per-CPU variable anyways.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 btf_encoder.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 2a6455be4c52..2af1fe447834 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -287,6 +287,10 @@ static int find_all_percpu_vars(struct btf_elf *btfe)
 		if (!addr)
 			continue;
 
+		size = elf_sym__size(&sym);
+		if (!size)
+			continue; /* ignore zero-sized symbols */
+
 		sym_name = elf_sym__name(&sym, btfe->symtab);
 		if (!btf_name_valid(sym_name)) {
 			dump_invalid_symbol("Found symbol of invalid name when encoding btf",
@@ -295,14 +299,6 @@ static int find_all_percpu_vars(struct btf_elf *btfe)
 				continue;
 			return -1;
 		}
-		size = elf_sym__size(&sym);
-		if (!size) {
-			dump_invalid_symbol("Found symbol of zero size when encoding btf",
-					    sym_name, btf_elf__verbose, btf_elf__force);
-			if (btf_elf__force)
-				continue;
-			return -1;
-		}
 
 		if (btf_elf__verbose)
 			printf("Found per-CPU symbol '%s' at address 0x%lx\n", sym_name, addr);
-- 
2.24.1

