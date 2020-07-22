Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2A022912C
	for <lists+bpf@lfdr.de>; Wed, 22 Jul 2020 08:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbgGVGqX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jul 2020 02:46:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10770 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729873AbgGVGqW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Jul 2020 02:46:22 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06M6kK0l030704
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 23:46:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=dVSUSeG7jGowPOMuvGmVxqCOBRq56+WzQUqb0O6jRxY=;
 b=ZcbgvE8RKncL9N6UKZxxEjIkrzCY9r7UC5BqbKYhyz3QCMwY0T0iZM+288UotWl/JFas
 hLM8u+Rl2qX8MNzXnYo6IS2I8IPsdDYs3OPsIDW2I0IGYTvhYv2isQ1SEy4jJTzjK5Nz
 wpOHdMHoqc+A9DrjVh0ItiHqEhNXVSH9PUc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32cgx3d74j-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 23:46:21 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 21 Jul 2020 23:46:15 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 9E2352EC494E; Tue, 21 Jul 2020 23:46:06 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <dsahern@gmail.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        kernel test robot <lkp@intel.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 bpf-next 1/9] bpf: make bpf_link API available indepently of CONFIG_BPF_SYSCALL
Date:   Tue, 21 Jul 2020 23:45:54 -0700
Message-ID: <20200722064603.3350758-2-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200722064603.3350758-1-andriin@fb.com>
References: <20200722064603.3350758-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_03:2020-07-22,2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 mlxlogscore=741 lowpriorityscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=8
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007220050
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similarly to bpf_prog, make bpf_link and related generic API available
unconditionally to make it easier to have bpf_link support in various par=
ts of
the kernel. Stub out init/prime/settle/cleanup and inc/put APIs.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 include/linux/bpf.h | 81 ++++++++++++++++++++++++++++++---------------
 1 file changed, 55 insertions(+), 26 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bae557ff2da8..33bb21b1dfe5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -761,6 +761,32 @@ struct bpf_array_aux {
 	struct work_struct work;
 };
=20
+struct bpf_link {
+	atomic64_t refcnt;
+	u32 id;
+	enum bpf_link_type type;
+	const struct bpf_link_ops *ops;
+	struct bpf_prog *prog;
+	struct work_struct work;
+};
+
+struct bpf_link_ops {
+	void (*release)(struct bpf_link *link);
+	void (*dealloc)(struct bpf_link *link);
+	int (*update_prog)(struct bpf_link *link, struct bpf_prog *new_prog,
+			   struct bpf_prog *old_prog);
+	void (*show_fdinfo)(const struct bpf_link *link, struct seq_file *seq);
+	int (*fill_link_info)(const struct bpf_link *link,
+			      struct bpf_link_info *info);
+};
+
+struct bpf_link_primer {
+	struct bpf_link *link;
+	struct file *file;
+	int fd;
+	u32 id;
+};
+
 struct bpf_struct_ops_value;
 struct btf_type;
 struct btf_member;
@@ -1143,32 +1169,6 @@ static inline bool bpf_bypass_spec_v4(void)
 int bpf_map_new_fd(struct bpf_map *map, int flags);
 int bpf_prog_new_fd(struct bpf_prog *prog);
=20
-struct bpf_link {
-	atomic64_t refcnt;
-	u32 id;
-	enum bpf_link_type type;
-	const struct bpf_link_ops *ops;
-	struct bpf_prog *prog;
-	struct work_struct work;
-};
-
-struct bpf_link_primer {
-	struct bpf_link *link;
-	struct file *file;
-	int fd;
-	u32 id;
-};
-
-struct bpf_link_ops {
-	void (*release)(struct bpf_link *link);
-	void (*dealloc)(struct bpf_link *link);
-	int (*update_prog)(struct bpf_link *link, struct bpf_prog *new_prog,
-			   struct bpf_prog *old_prog);
-	void (*show_fdinfo)(const struct bpf_link *link, struct seq_file *seq);
-	int (*fill_link_info)(const struct bpf_link *link,
-			      struct bpf_link_info *info);
-};
-
 void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
 		   const struct bpf_link_ops *ops, struct bpf_prog *prog);
 int bpf_link_prime(struct bpf_link *link, struct bpf_link_primer *primer=
);
@@ -1370,6 +1370,35 @@ static inline void __bpf_prog_uncharge(struct user=
_struct *user, u32 pages)
 {
 }
=20
+static inline void bpf_link_init(struct bpf_link *link, enum bpf_link_ty=
pe type,
+				 const struct bpf_link_ops *ops,
+				 struct bpf_prog *prog)
+{
+}
+
+static inline int bpf_link_prime(struct bpf_link *link,
+				 struct bpf_link_primer *primer)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int bpf_link_settle(struct bpf_link_primer *primer)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void bpf_link_cleanup(struct bpf_link_primer *primer)
+{
+}
+
+static inline void bpf_link_inc(struct bpf_link *link)
+{
+}
+
+static inline void bpf_link_put(struct bpf_link *link)
+{
+}
+
 static inline int bpf_obj_get_user(const char __user *pathname, int flag=
s)
 {
 	return -EOPNOTSUPP;
--=20
2.24.1

