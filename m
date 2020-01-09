Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 085CC13507F
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2020 01:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgAIAfC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jan 2020 19:35:02 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32266 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726930AbgAIAfC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Jan 2020 19:35:02 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0090V5hm026013
        for <bpf@vger.kernel.org>; Wed, 8 Jan 2020 16:35:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=M9EHpNrDr1lJ5Uo6eiTBlsMHkWM+vmH+MrEGGeU1TME=;
 b=UKw5Cw8D7YmBi/QLL/VHTdkjtr6JWEMu3z+VBDrDmmDEMHt+P42z1M/8M9ny+S2LrF84
 lzMfEalkTgwYInUT3NwDtqtAKo7sArYOcmVJ0FIIecehQSRrUMfcqQ565rFUcWmadQp0
 HhZzV1Nbr6autPoSzuPpmWzVTO97hD5bh5g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xdrj8gbat-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2020 16:35:01 -0800
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 8 Jan 2020 16:35:00 -0800
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 3B7122942576; Wed,  8 Jan 2020 16:34:59 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v4 03/11] bpf: Add enum support to btf_ctx_access()
Date:   Wed, 8 Jan 2020 16:34:59 -0800
Message-ID: <20200109003459.3855366-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109003453.3854769-1-kafai@fb.com>
References: <20200109003453.3854769-1-kafai@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_07:2020-01-08,2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=13
 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=844 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090003
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It allows bpf prog (e.g. tracing) to attach
to a kernel function that takes enum argument.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 497ecf62d79d..6a5ccb748a72 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3677,7 +3677,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	/* skip modifiers */
 	while (btf_type_is_modifier(t))
 		t = btf_type_by_id(btf, t->type);
-	if (btf_type_is_int(t))
+	if (btf_type_is_int(t) || btf_type_is_enum(t))
 		/* accessing a scalar */
 		return true;
 	if (!btf_type_is_ptr(t)) {
-- 
2.17.1

