Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 386C41350AD
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2020 01:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgAIAwl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jan 2020 19:52:41 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51824 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726654AbgAIAwl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Jan 2020 19:52:41 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0090pe6D017671
        for <bpf@vger.kernel.org>; Wed, 8 Jan 2020 16:52:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=V7/umriol0bL43X+cEmp7XeQfwdSmHpl4BxkKhK1phU=;
 b=QkY47B6S4MX3i7BasdDu/ITf8ID32TirSreS9cs6v42bLLQXnlMzMKOtFhLF+QZslQEW
 bpOqa2ycQR3+fCrvs6pEY1/2pGqPkLD0UqOXVAayOKqe5mzVI5+0Epk/s05aFXRn0uRF
 6JG//hdOkHaMunqlDdcF+oBPMdRfdtZcj30= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 2xdh772wcs-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2020 16:52:21 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 8 Jan 2020 16:52:13 -0800
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id A8C232942576; Wed,  8 Jan 2020 16:34:54 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v4 01/11] bpf: Save PTR_TO_BTF_ID register state when spilling to stack
Date:   Wed, 8 Jan 2020 16:34:54 -0800
Message-ID: <20200109003454.3854870-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109003453.3854769-1-kafai@fb.com>
References: <20200109003453.3854769-1-kafai@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_07:2020-01-08,2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=13 bulkscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015
 mlxlogscore=670 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001090006
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
index 6f63ae7a370c..d433d70022fd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1916,6 +1916,7 @@ static bool is_spillable_regtype(enum bpf_reg_type type)
 	case PTR_TO_TCP_SOCK:
 	case PTR_TO_TCP_SOCK_OR_NULL:
 	case PTR_TO_XDP_SOCK:
+	case PTR_TO_BTF_ID:
 		return true;
 	default:
 		return false;
-- 
2.17.1

