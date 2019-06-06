Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 587B237ED7
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 22:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfFFUaV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 16:30:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57118 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727350AbfFFUaR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jun 2019 16:30:17 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56KS6Tl008004
        for <bpf@vger.kernel.org>; Thu, 6 Jun 2019 13:30:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=WaRncLNa5iOBqAfSuQNbHoUAXYAn7sJ/19EdHwQN+UY=;
 b=fJa5lNfPK2c5Ex7hs1h+7cbnuC5aOgPEhlhpDZ5TVRwFSfq/t8aBFFFEuF8RZkaQkys8
 Feog9FTPaJex259RzmCtofa4sYhmIjQHEgNKQI0yqnFzzpKCHVSqj0IXfGY9z47DZwfx
 0zyhSD3RW9Z4z+kalqTX4GKQJ/irq/HamOU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sy5hk161t-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2019 13:30:17 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 6 Jun 2019 13:30:15 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 5F97512D8C6E4; Thu,  6 Jun 2019 13:30:15 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] bpf: allow CGROUP_SKB programs to use bpf_skb_cgroup_id() helper
Date:   Thu, 6 Jun 2019 13:30:12 -0700
Message-ID: <20190606203012.130071-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060138
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently bpf_skb_cgroup_id() is not supported for CGROUP_SKB
programs. An attempt to load such a program generates an error
like this:

    libbpf:
    0: (b7) r6 = 0
    ...
    9: (85) call bpf_skb_cgroup_id#79
    unknown func bpf_skb_cgroup_id#79

There are no particular reasons for denying it, and we have some
use cases where it might be useful.

So let's add it to the list of allowed helpers.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 net/core/filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 55bfc941d17a..f2777dc0b624 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5919,6 +5919,10 @@ cg_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_get_proto;
 	case BPF_FUNC_sk_storage_delete:
 		return &bpf_sk_storage_delete_proto;
+#ifdef CONFIG_SOCK_CGROUP_DATA
+	case BPF_FUNC_skb_cgroup_id:
+		return &bpf_skb_cgroup_id_proto;
+#endif
 #ifdef CONFIG_INET
 	case BPF_FUNC_tcp_sock:
 		return &bpf_tcp_sock_proto;
-- 
2.20.1

