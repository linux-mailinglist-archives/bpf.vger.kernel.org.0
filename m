Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1DDF12D67F
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2019 07:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbfLaGUo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Dec 2019 01:20:44 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19426 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbfLaGUo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Dec 2019 01:20:44 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBV6FNC3007365
        for <bpf@vger.kernel.org>; Mon, 30 Dec 2019 22:20:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=4r3I8GHHISo2RTI+iI1vocY3r47RMyQriKH4z1y15eU=;
 b=ObGCKWzO+RNXV4p6djL+OPRpuylyZLJgQTtUGtiwggxGWBDocQwz8LD59kBxB6cWNaZM
 IslxHpKVNQGHKq8FhQbOCNqR2JHO1j27mMMcU0breG1qcsM6PvbNxTQiA52FTcj8foDu
 3odD9RdnVS2t45TEACM0PjumM7xf/HFnVJ4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2x65rq9fsu-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 30 Dec 2019 22:20:43 -0800
Received: from intmgw005.05.ash5.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 30 Dec 2019 22:20:40 -0800
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 8A044294410B; Mon, 30 Dec 2019 22:20:39 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v3 01/11] bpf: Save PTR_TO_BTF_ID register state when spilling to stack
Date:   Mon, 30 Dec 2019 22:20:39 -0800
Message-ID: <20191231062039.280835-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191231062037.280596-1-kafai@fb.com>
References: <20191231062037.280596-1-kafai@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-30_08:2019-12-27,2019-12-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=652 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=13
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912310050
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch makes the verifier save the PTR_TO_BTF_ID register state when
spilling to the stack.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4983940cbdca..da1a10c43fcd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1915,6 +1915,7 @@ static bool is_spillable_regtype(enum bpf_reg_type type)
 	case PTR_TO_TCP_SOCK:
 	case PTR_TO_TCP_SOCK_OR_NULL:
 	case PTR_TO_XDP_SOCK:
+	case PTR_TO_BTF_ID:
 		return true;
 	default:
 		return false;
-- 
2.17.1

