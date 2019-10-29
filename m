Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8EFE7ED9
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2019 04:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfJ2DYb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Oct 2019 23:24:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18174 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730052AbfJ2DYb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 28 Oct 2019 23:24:31 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9T3Ntpb027809
        for <bpf@vger.kernel.org>; Mon, 28 Oct 2019 20:24:30 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vvkyhv64r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 28 Oct 2019 20:24:30 -0700
Received: from 2401:db00:12:909f:face:0:3:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 28 Oct 2019 20:24:29 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 44E35760EFD; Mon, 28 Oct 2019 20:24:26 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] bpf: Enforce 'return 0' in BTF-enabled raw_tp programs
Date:   Mon, 28 Oct 2019 20:24:26 -0700
Message-ID: <20191029032426.1206762-1-ast@kernel.org>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-28_07:2019-10-28,2019-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=1 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910290035
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The return value of raw_tp programs is ignored by __bpf_trace_run()
that calls them. The verifier also allows any value to be returned.
For BTF-enabled raw_tp lets enforce 'return 0', so that return value
can be used for something in the future.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c59778c0fc4d..6b0de04f8b91 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6279,6 +6279,11 @@ static int check_return_code(struct bpf_verifier_env *env)
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 		break;
+	case BPF_PROG_TYPE_RAW_TRACEPOINT:
+		if (!env->prog->aux->attach_btf_id)
+			return 0;
+		range = tnum_const(0);
+		break;
 	default:
 		return 0;
 	}
-- 
2.17.1

