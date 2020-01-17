Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7761403C7
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2020 07:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgAQGIU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jan 2020 01:08:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51666 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726892AbgAQGIT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Jan 2020 01:08:19 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00H61b26007485
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2020 22:08:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=kNd14TxNovgfLwfBRp3kbrtYbPEPePHa8IgWaENGHL0=;
 b=Rr7EB3cOMr3QkZY5YJwhZh2wi4rDYmtWjbItEOEX4afM2kvbgY8vHQloOsv4eWiiQre7
 9p4pDHT5S5iX20m7DcqAYMAlm4hXVHc5D50wyy/oyOctgyJyAwG37vNzoX2hn5/Qcp3A
 +QVh476S1IoEtRSabPFcuYGJB9FUc8DGMlU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xk0sfsb52-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2020 22:08:18 -0800
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 16 Jan 2020 22:08:17 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 2E10C2EC1745; Thu, 16 Jan 2020 22:08:13 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 4/4] bpftool: avoid const discard compilation warning
Date:   Thu, 16 Jan 2020 22:08:01 -0800
Message-ID: <20200117060801.1311525-5-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200117060801.1311525-1-andriin@fb.com>
References: <20200117060801.1311525-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_06:2020-01-16,2020-01-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 adultscore=0 suspectscore=8 spamscore=0 mlxlogscore=570
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001170047
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Avoid compilation warning in bpftool when assigning disassembler_options by
casting explicitly to non-const pointer.

Fixes: 3ddeac6705ab ("tools: bpftool: use 4 context mode for the NFP disasm")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/bpftool/jit_disasm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index bfed711258ce..22ef85b0f86c 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -119,7 +119,7 @@ void disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 	info.arch = bfd_get_arch(bfdf);
 	info.mach = bfd_get_mach(bfdf);
 	if (disassembler_options)
-		info.disassembler_options = disassembler_options;
+		info.disassembler_options = (char *)disassembler_options;
 	info.buffer = image;
 	info.buffer_length = len;
 
-- 
2.17.1

