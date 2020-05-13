Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695C61D1B71
	for <lists+bpf@lfdr.de>; Wed, 13 May 2020 18:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbgEMQp3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 12:45:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41419 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732557AbgEMQp2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 12:45:28 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04DGfQiL032562
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 09:45:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=YHnSwwTl7MQb6e9Nndea+sw7/7w1eGDeVO9aSHHW0GI=;
 b=QNlzCG5JfEsNXtoIzgGU/DfQuiR5y+iocPNlO2mgKLyZU9Xw82k4V29JEtdCnq8MICIp
 KQzHBCebPegUBapE2/pev/6hW6G1xbsBN1+IRomm/kv+wpGcJp/Kz6enh6cvNoi9lwDE
 mvRfXmuyX6Gxi6b9iSEpZw1qKeTsifyvb6o= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3100x9wwyc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 09:45:28 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 13 May 2020 09:45:26 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 97DEA37009B0; Wed, 13 May 2020 09:45:25 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf 1/2] bpf: enforce returning 0 for fentry/fexit progs
Date:   Wed, 13 May 2020 09:45:25 -0700
Message-ID: <20200513164525.2500681-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200513164525.2500605-1-yhs@fb.com>
References: <20200513164525.2500605-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_07:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=691 malwarescore=0 clxscore=1015 impostorscore=0
 cotscore=-2147483648 suspectscore=13 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130146
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, tracing/fentry and tracing/fexit prog
return values are not enforced. In trampoline codes,
the fentry/fexit prog return values are ignored.
Let us enforce it to be 0 to avoid confusion and
allows potential future extension.

Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fa1d8245b925..17b8448babfe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7059,6 +7059,13 @@ static int check_return_code(struct bpf_verifier_e=
nv *env)
 			return 0;
 		range =3D tnum_const(0);
 		break;
+	case BPF_PROG_TYPE_TRACING:
+		if (env->prog->expected_attach_type =3D=3D BPF_TRACE_FENTRY ||
+		    env->prog->expected_attach_type =3D=3D BPF_TRACE_FEXIT) {
+			range =3D tnum_const(0);
+			break;
+		}
+		return 0;
 	default:
 		return 0;
 	}
--=20
2.24.1

