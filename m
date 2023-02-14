Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD3D697091
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 23:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjBNWRn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 17:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjBNWRk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 17:17:40 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7C42940F
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:39 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EGtsdt003823
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=f5T8By2TUrPsxXWbHFjJt1n7y6lgBGuS5AvjRAO0cus=;
 b=GLIH4H9Sz5GcPC0XEnQZGsgO2icGbdc5FJgC2GN91TgLka/6N89QxToFUkFWR3tKVhoT
 FztfudD1l+APkjbMT6USrGlDUSA2Va3wCfijWtka/bIORHutpF4VrwmfF+5m/reQ47Zs
 U0rGDeKPnaWsdSYDAjROIH9zAlIkIMy/INhqYVi9DM3ZKk8PBlZ7iWuWLD3qIZKzZ9Ln
 LHmVvemOweWc2LT1Lg92XXNsx3Jg8yDYcNvBGFdhCJhpIJ1oTv/UJO8aCx8Jkk4Pbegv
 ElxLn2reYA1HP3oE+h2WqT8Go8QSDGh8+Fj7BL0StZN+KST6nxIUKSekn2hjIfB+nAim og== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nr5yddgu7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:38 -0800
Received: from twshared26225.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Feb 2023 14:17:36 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 92E6F5143081; Tue, 14 Feb 2023 14:17:20 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next 2/7] net: Update an existing TCP congestion control algorithm.
Date:   Tue, 14 Feb 2023 14:17:13 -0800
Message-ID: <20230214221718.503964-3-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230214221718.503964-1-kuifeng@meta.com>
References: <20230214221718.503964-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ltS-Y-puiKV6IXGRK7u1b9ZT_pVdA6N7
X-Proofpoint-GUID: ltS-Y-puiKV6IXGRK7u1b9ZT_pVdA6N7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This feature lets you immediately transition to another congestion
control algorithm or implementation with the same name.  Once a name
is updated, new connections will apply this new algorithm.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/linux/bpf.h            |  1 +
 include/net/tcp.h              |  2 ++
 net/bpf/bpf_dummy_struct_ops.c |  6 ++++++
 net/ipv4/bpf_tcp_ca.c          |  6 ++++++
 net/ipv4/tcp_cong.c            | 39 ++++++++++++++++++++++++++++++++++
 5 files changed, 54 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 13683584b071..5fe39f56a760 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1450,6 +1450,7 @@ struct bpf_struct_ops {
 			   void *kdata, const void *udata);
 	int (*reg)(void *kdata);
 	void (*unreg)(void *kdata);
+	int (*update)(void *kdata, void *old_kdata);
 	const struct btf_type *type;
 	const struct btf_type *value_type;
 	const char *name;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index db9f828e9d1e..239cc0e2639c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1117,6 +1117,8 @@ struct tcp_congestion_ops {
=20
 int tcp_register_congestion_control(struct tcp_congestion_ops *type);
 void tcp_unregister_congestion_control(struct tcp_congestion_ops *type);
+int tcp_update_congestion_control(struct tcp_congestion_ops *type,
+				  struct tcp_congestion_ops *old_type);
=20
 void tcp_assign_congestion_control(struct sock *sk);
 void tcp_init_congestion_control(struct sock *sk);
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_op=
s.c
index ff4f89a2b02a..158f14e240d0 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -222,12 +222,18 @@ static void bpf_dummy_unreg(void *kdata)
 {
 }
=20
+static int bpf_dummy_update(void *kdata, void *old_kdata)
+{
+	return -EOPNOTSUPP;
+}
+
 struct bpf_struct_ops bpf_bpf_dummy_ops =3D {
 	.verifier_ops =3D &bpf_dummy_verifier_ops,
 	.init =3D bpf_dummy_init,
 	.check_member =3D bpf_dummy_ops_check_member,
 	.init_member =3D bpf_dummy_init_member,
 	.reg =3D bpf_dummy_reg,
+	.update =3D bpf_dummy_update,
 	.unreg =3D bpf_dummy_unreg,
 	.name =3D "bpf_dummy_ops",
 };
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 13fc0c185cd9..66ce5fadfe42 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -266,10 +266,16 @@ static void bpf_tcp_ca_unreg(void *kdata)
 	tcp_unregister_congestion_control(kdata);
 }
=20
+static int bpf_tcp_ca_update(void *kdata, void *old_kdata)
+{
+	return tcp_update_congestion_control(kdata, old_kdata);
+}
+
 struct bpf_struct_ops bpf_tcp_congestion_ops =3D {
 	.verifier_ops =3D &bpf_tcp_ca_verifier_ops,
 	.reg =3D bpf_tcp_ca_reg,
 	.unreg =3D bpf_tcp_ca_unreg,
+	.update =3D bpf_tcp_ca_update,
 	.check_member =3D bpf_tcp_ca_check_member,
 	.init_member =3D bpf_tcp_ca_init_member,
 	.init =3D bpf_tcp_ca_init,
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index db8b4b488c31..22fd7c12360e 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -130,6 +130,45 @@ void tcp_unregister_congestion_control(struct tcp_co=
ngestion_ops *ca)
 }
 EXPORT_SYMBOL_GPL(tcp_unregister_congestion_control);
=20
+/* Replace a registered old ca with a new one.
+ *
+ * The new ca must have the same name as the old one, that has been
+ * registered.
+ */
+int tcp_update_congestion_control(struct tcp_congestion_ops *ca, struct =
tcp_congestion_ops *old_ca)
+{
+	struct tcp_congestion_ops *existing;
+	int ret =3D 0;
+
+	/* all algorithms must implement these */
+	if (!ca->ssthresh || !ca->undo_cwnd ||
+	    !(ca->cong_avoid || ca->cong_control)) {
+		pr_err("%s does not implement required ops\n", old_ca->name);
+		return -EINVAL;
+	}
+
+	ca->key =3D jhash(ca->name, sizeof(ca->name), strlen(ca->name));
+
+	spin_lock(&tcp_cong_list_lock);
+	existing =3D tcp_ca_find_key(ca->key);
+	if (ca->key =3D=3D TCP_CA_UNSPEC || !existing || strcmp(existing->name,=
 ca->name)) {
+		pr_notice("%s not registered or non-unique key\n",
+			  ca->name);
+		ret =3D -EINVAL;
+	} else if (existing !=3D old_ca) {
+		pr_notice("invalid old congestion control algorithm to replace\n");
+		ret =3D -EINVAL;
+	} else {
+		list_del_rcu(&existing->list);
+		list_add_tail_rcu(&ca->list, &tcp_cong_list);
+		pr_debug("%s updated\n", ca->name);
+	}
+	spin_unlock(&tcp_cong_list_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tcp_update_congestion_control);
+
 u32 tcp_ca_get_key_by_name(struct net *net, const char *name, bool *ecn_=
ca)
 {
 	const struct tcp_congestion_ops *ca;
--=20
2.30.2

