Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D60D2028EC
	for <lists+bpf@lfdr.de>; Sun, 21 Jun 2020 07:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgFUFzK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Jun 2020 01:55:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20762 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729304AbgFUFzK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 21 Jun 2020 01:55:10 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05L5onVg003660
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 22:55:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=qZEHt4RHh7ib2heTqMonlYOEEjS3L/KCT0L9qTv5Ypc=;
 b=ZXxsaXKhzbfnwDIUmoSc4D9Vye2Z90LAjMwZPw2cFD2W8WINPr4CXqWLgBKE71TK6VZR
 EFstWaVIQI48DYMT3WUAF7dHphmMKorz7+K/68OK2MqwpLU+Rz2aNwsHzvM9iC2DOn3G
 NQ/bSda2LUGPAQl4BPPIRWtrC8qXXJ7cqZg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31segatsud-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 22:55:09 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 20 Jun 2020 22:55:07 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id B4FE837052DE; Sat, 20 Jun 2020 22:55:02 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 03/15] bpf: support 'X' in bpf_seq_printf() helper
Date:   Sat, 20 Jun 2020 22:55:02 -0700
Message-ID: <20200621055502.2629649-1-yhs@fb.com>
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
 adultscore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=831 impostorscore=0 clxscore=1015
 spamscore=0 suspectscore=13 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006210047
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

'X' tells kernel to print hex with upper case letters.
/proc/net/tcp{4,6} seq_file show() used this, and
supports it in bpf_seq_printf() helper too.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/trace/bpf_trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e729c9e587a0..dbee30e2ad91 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -681,7 +681,8 @@ BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char=
 *, fmt, u32, fmt_size,
 		}
=20
 		if (fmt[i] !=3D 'i' && fmt[i] !=3D 'd' &&
-		    fmt[i] !=3D 'u' && fmt[i] !=3D 'x') {
+		    fmt[i] !=3D 'u' && fmt[i] !=3D 'x' &&
+		    fmt[i] !=3D 'X') {
 			err =3D -EINVAL;
 			goto out;
 		}
--=20
2.24.1

