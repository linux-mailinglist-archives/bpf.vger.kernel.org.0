Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7FB37CE3
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 20:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfFFS7Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 14:59:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59536 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727947AbfFFS7Q (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jun 2019 14:59:16 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56ImXUp006416
        for <bpf@vger.kernel.org>; Thu, 6 Jun 2019 11:59:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=bYqo/eKrf3Ocv2LivjDpADlZygx+fChjmeNZSWE8V/Y=;
 b=V/UdCPxNihvBEPMt56NRxdzPLBD9jMDWjKtcp8VLxCvBwyeQTU8l6nxBT9e2z7oVjv0v
 865pXeUDpCL3mB5TJ4LJptONdUgoNwUjqnKvdKL0HCR4TjdFxU51LvOey4n/JNPwlVLj
 2ml3IXysA1l9X/9UgaWMHgcBwRfQRJ7zQ9o= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sy1quhngn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2019 11:59:15 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Jun 2019 11:59:14 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 821D412D781C4; Thu,  6 Jun 2019 11:59:12 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] bpf: allow CGROUP_SKB programs to use bpf_get_current_cgroup_id() helper
Date:   Thu, 6 Jun 2019 11:59:11 -0700
Message-ID: <20190606185911.4089151-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060127
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently bpf_get_current_cgroup_id() is not supported for
CGROUP_SKB programs. An attempt to load such a program generates an
error like this:
    libbpf:
    0: (b7) r6 = 0
    ...
    8: (63) *(u32 *)(r10 -28) = r6
    9: (85) call bpf_get_current_cgroup_id#80
    unknown func bpf_get_current_cgroup_id#80

There are no particular reasons for denying it,
and we have some use cases where it might be useful.

So let's add it to the list of allowed helpers.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 net/core/filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 55bfc941d17a..19724bb1860d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5919,6 +5919,10 @@ cg_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_get_proto;
 	case BPF_FUNC_sk_storage_delete:
 		return &bpf_sk_storage_delete_proto;
+#ifdef CONFIG_CGROUPS
+	case BPF_FUNC_get_current_cgroup_id:
+		return &bpf_get_current_cgroup_id_proto;
+#endif
 #ifdef CONFIG_INET
 	case BPF_FUNC_tcp_sock:
 		return &bpf_tcp_sock_proto;
-- 
2.20.1

