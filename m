Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319AF2028F8
	for <lists+bpf@lfdr.de>; Sun, 21 Jun 2020 07:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgFUFzj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Jun 2020 01:55:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58572 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729274AbgFUFzj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 21 Jun 2020 01:55:39 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05L5tc8R021532
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 22:55:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=z7spgnSOmuscC2mGy1XIVWhqozMpxXywcMyrApiOdZk=;
 b=f08RyygT5Bq0uPRkvraDdd12qWwzDNSJBi9snHA9Cbmos4krJ8EzCGjfj5Di08d2o4+W
 cnttlkDKBv1sgx6RbhKdiwYFbP2v8qt5JY4b4V3jSh3nyjdzcOhTpaMFLOAEa15PRdxp
 6cTI1Na+WSOu66X74hmGIzxbOE4UEcUQ0Lc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31sdskax7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 22:55:38 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 20 Jun 2020 22:55:06 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id F29AB37052DE; Sat, 20 Jun 2020 22:55:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 04/15] bpf: allow tracing programs to use bpf_jiffies64() helper
Date:   Sat, 20 Jun 2020 22:55:03 -0700
Message-ID: <20200621055503.2629719-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200621055459.2629116-1-yhs@fb.com>
References: <20200621055459.2629116-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-20_16:2020-06-19,2020-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 cotscore=-2147483648
 mlxlogscore=600 clxscore=1015 impostorscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=13 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006210048
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

/proc/net/tcp{4,6} uses jiffies for various computations.
Let us add bpf_jiffies64() helper to tracing program
so bpf_iter and other programs can use it.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/trace/bpf_trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index dbee30e2ad91..afaec7e082d9 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1135,6 +1135,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 		return &bpf_ringbuf_discard_proto;
 	case BPF_FUNC_ringbuf_query:
 		return &bpf_ringbuf_query_proto;
+	case BPF_FUNC_jiffies64:
+		return &bpf_jiffies64_proto;
 	default:
 		return NULL;
 	}
--=20
2.24.1

