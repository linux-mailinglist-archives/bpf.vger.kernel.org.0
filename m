Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AB31AB1A2
	for <lists+bpf@lfdr.de>; Wed, 15 Apr 2020 21:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406811AbgDOT2g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Apr 2020 15:28:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52536 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407079AbgDOT2N (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Apr 2020 15:28:13 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 03FJSCPr007595
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2020 12:28:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=aV4IlLZ1Pn8nevkUO0Q4IsIL0wp9STZRdrqXvAfOdJ8=;
 b=of/yvrXYTpKuqJP3ebedSsVB0hbHNaiyEw8YUFTCNT90n9smXOZkGPNDEhzJCxaMwIoS
 F/Wa40lW5QQAfkM5KSS6OY21hG3/AAABUaYBxZ3E2FuhSiBQcWocHxRSWVYhhs3o6EHt
 W4jhZCDx1ddY5R8olgl4v7H90ApxQaKO2do= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 30dn7fymmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2020 12:28:12 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 15 Apr 2020 12:27:42 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id C34BA3700AFE; Wed, 15 Apr 2020 12:27:40 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     Andrii Nakryiko <andriin@fb.com>, <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [RFC PATCH bpf-next v2 01/17] net: refactor net assignment for seq_net_private structure
Date:   Wed, 15 Apr 2020 12:27:40 -0700
Message-ID: <20200415192740.4082720-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200415192740.4082659-1-yhs@fb.com>
References: <20200415192740.4082659-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_07:2020-04-14,2020-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0 adultscore=0
 impostorscore=0 mlxlogscore=902 priorityscore=1501 bulkscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004150144
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Refactor assignment of "net" in seq_net_private structure
in proc_net.c to a helper function. The helper later will
be used by bpfdump.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 fs/proc/proc_net.c           | 5 ++---
 include/linux/seq_file_net.h | 8 ++++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index 4888c5224442..aee07c19cf8b 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -75,9 +75,8 @@ static int seq_open_net(struct inode *inode, struct fil=
e *file)
 		put_net(net);
 		return -ENOMEM;
 	}
-#ifdef CONFIG_NET_NS
-	p->net =3D net;
-#endif
+
+	set_seq_net_private(p, net);
 	return 0;
 }
=20
diff --git a/include/linux/seq_file_net.h b/include/linux/seq_file_net.h
index 0fdbe1ddd8d1..0ec4a18b9aca 100644
--- a/include/linux/seq_file_net.h
+++ b/include/linux/seq_file_net.h
@@ -35,4 +35,12 @@ static inline struct net *seq_file_single_net(struct s=
eq_file *seq)
 #endif
 }
=20
+static inline void set_seq_net_private(struct seq_net_private *p,
+				       struct net *net)
+{
+#ifdef CONFIG_NET_NS
+	p->net =3D net;
+#endif
+}
+
 #endif
--=20
2.24.1

