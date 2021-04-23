Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582883698DE
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 20:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243410AbhDWSOe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 23 Apr 2021 14:14:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33014 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhDWSOd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 23 Apr 2021 14:14:33 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13NIA9ln016869
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 11:13:56 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 383an287r9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 11:13:56 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 11:13:55 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 68ECD2ED5CB8; Fri, 23 Apr 2021 11:13:52 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH v3 bpf-next 01/18] bpftool: support dumping BTF VAR's "extern" linkage
Date:   Fri, 23 Apr 2021 11:13:31 -0700
Message-ID: <20210423181348.1801389-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423181348.1801389-1-andrii@kernel.org>
References: <20210423181348.1801389-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9YUP-X8RO1HEf1ePHySaW1YtlU-T2XXf
X-Proofpoint-GUID: 9YUP-X8RO1HEf1ePHySaW1YtlU-T2XXf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-23_07:2021-04-23,2021-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=943 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104230120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add dumping of "extern" linkage for BTF VAR kind. Also shorten
"global-allocated" to "global" to be in line with FUNC's "global".

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/btf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 62953bbf68b4..001749a34899 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -71,7 +71,9 @@ static const char *btf_var_linkage_str(__u32 linkage)
 	case BTF_VAR_STATIC:
 		return "static";
 	case BTF_VAR_GLOBAL_ALLOCATED:
-		return "global-alloc";
+		return "global";
+	case BTF_VAR_GLOBAL_EXTERN:
+		return "extern";
 	default:
 		return "(unknown)";
 	}
-- 
2.30.2

