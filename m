Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9D5D8FA7C
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2019 07:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfHPFvT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Aug 2019 01:51:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:2018 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbfHPFvS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Aug 2019 01:51:18 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7G5m6HD003409
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2019 22:51:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=IZrHqa4QuLJMtr4+C7bcLZLe9SprRxgFU1axuwRa3Jg=;
 b=dcYjkEb27xCNCr3yInUDfrTJsepTzLkdDRkxQ4lTXC7CaEG1wpSpjitCrtIz791IpP4U
 VKf43wsP74h+aWARnutqmHxJD3qsAve+9F6ONN4miHN3C0/iTx0CbEWAs8XJoQ270yBr
 0kYjYmZRhBpfSMaDADRRoV5LaGrVd10ol9A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2udk6q8nf3-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2019 22:51:17 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 15 Aug 2019 22:48:45 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 097288617BC; Thu, 15 Aug 2019 22:46:00 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Michal Rostecki <mrostecki@opensuse.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] libbpf: relicense bpf_helpers.h and bpf_endian.h
Date:   Thu, 15 Aug 2019 22:45:43 -0700
Message-ID: <20190816054543.2215626-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160063
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_helpers.h and bpf_endian.h contain useful macros and BPF helper
definitions essential to almost every BPF program. Which makes them
useful not just for selftests. To be able to expose them as part of
libbpf, though, we need them to be dual-licensed as LGPL-2.1 OR
BSD-2-Clause. This patch updates licensing of those two files.

Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Hechao Li <hechaol@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Acked-by: Andrey Ignatov <rdna@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Lawrence Brakmo <brakmo@fb.com>
Acked-by: Adam Barth <arb@fb.com>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Josef Bacik <jbacik@fb.com>
Acked-by: Joe Stringer <joe@wand.net.nz>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Acked-by: David Ahern <dsahern@gmail.com>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Lorenz Bauer <lmb@cloudflare.com>
Acked-by: Adrian Ratiu <adrian.ratiu@collabora.com>
Acked-by: Nikita V. Shirokov <tehnerd@tehnerd.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Acked-by: Petar Penkov <ppenkov@google.com>
Acked-by: Teng Qin <palmtenor@gmail.com>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Michal Rostecki <mrostecki@opensuse.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Sargun Dhillon <sargun@sargun.me>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/bpf_endian.h  | 2 +-
 tools/testing/selftests/bpf/bpf_helpers.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_endian.h b/tools/testing/selftests/bpf/bpf_endian.h
index 05f036df8a4c..ff3593b0ae03 100644
--- a/tools/testing/selftests/bpf/bpf_endian.h
+++ b/tools/testing/selftests/bpf/bpf_endian.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
 #ifndef __BPF_ENDIAN__
 #define __BPF_ENDIAN__
 
diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
index 8b503ea142f0..6c4930bc6e2e 100644
--- a/tools/testing/selftests/bpf/bpf_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_helpers.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
 #ifndef __BPF_HELPERS_H
 #define __BPF_HELPERS_H
 
-- 
2.17.1

