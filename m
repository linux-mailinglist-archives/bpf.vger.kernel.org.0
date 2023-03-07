Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87306AFA82
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 00:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjCGXe1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 18:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjCGXd6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 18:33:58 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9864287348
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 15:33:28 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 327M6ssQ025984
        for <bpf@vger.kernel.org>; Tue, 7 Mar 2023 15:33:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=0R/KLU7YDhSms14wWqw7E5qE/bEIiAE9gNt/pDEDVvU=;
 b=WUFo0EHYzxIhVMrMD5uVq+eSXTa2+M3FKc2CO9DlZMmmruaq2EC9rp/1QBv62vp2GB4h
 2ZTtLBEPkXTuF0jLjIUOjCkC63k3yKVz3jZSkGT1CW3YlI8lDYYvPAFCsK0GO8J/H1Wx
 xcPMX2au9Z0SN7PoGGC7RV5CvTJ1U9/UvPzrJ/Bt6qPFUYhRfGBDCiVj1dHrP7dEbo7g
 b1w6E0QsMTbEK1q/o/90xp2/wOyMYoK0L8amZhVrHdoVSIiqDjj7LQTpHq6vCo2WXyEo
 ErIYdMhN1kIt8eP1UXslHQ83Khb/btzi0wputL/u3vjGIa+d3/ufUz7zdQEcrQP4iG7O jQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3p4px6tnhx-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 15:33:28 -0800
Received: from twshared21709.17.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Mar 2023 15:33:25 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 32D066C7C9B9; Tue,  7 Mar 2023 15:33:13 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v4 3/9] net: Update an existing TCP congestion control algorithm.
Date:   Tue, 7 Mar 2023 15:33:01 -0800
Message-ID: <20230307233307.3626875-4-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307233307.3626875-1-kuifeng@meta.com>
References: <20230307233307.3626875-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _KrfoLA6iw4GiJW0kX2pruG_HV8s91Dg
X-Proofpoint-GUID: _KrfoLA6iw4GiJW0kX2pruG_HV8s91Dg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_16,2023-03-07_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This feature lets you immediately transition to another congestion
control algorithm or implementation with the same name.  Once a name
is updated, new connections will apply this new algorithm.

The 'validate' function pointer has been added to bpf_struct_ops as
well, allowing us to validate a struct_ops without having to go
through the registration process.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/linux/bpf.h            |  2 ++
 include/net/tcp.h              |  3 ++
 net/bpf/bpf_dummy_struct_ops.c |  6 ++++
 net/ipv4/bpf_tcp_ca.c          | 14 +++++++--
 net/ipv4/tcp_cong.c            | 57 +++++++++++++++++++++++++++++-----
 5 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 855b27f847eb..047d2c6aba88 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1447,6 +1447,8 @@ struct bpf_struct_ops {
 			   void *kdata, const void *udata);
 	int (*reg)(void *kdata);
 	void (*unreg)(void *kdata);
+	int (*update)(void *kdata, void *old_kdata);
+	int (*validate)(void *kdata);
 	const struct btf_type *type;
 	const struct btf_type *value_type;
 	const char *name;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index db9f828e9d1e..2abb755e6a3a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1117,6 +1117,9 @@ struct tcp_congestion_ops {
=20
 int tcp_register_congestion_control(struct tcp_congestion_ops *type);
 void tcp_unregister_congestion_control(struct tcp_congestion_ops *type);
+int tcp_update_congestion_control(struct tcp_congestion_ops *type,
+				  struct tcp_congestion_ops *old_type);
+int tcp_validate_congestion_control(struct tcp_congestion_ops *ca);
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
index 13fc0c185cd9..e8b27826283e 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -239,8 +239,6 @@ static int bpf_tcp_ca_init_member(const struct btf_ty=
pe *t,
 		if (bpf_obj_name_cpy(tcp_ca->name, utcp_ca->name,
 				     sizeof(tcp_ca->name)) <=3D 0)
 			return -EINVAL;
-		if (tcp_ca_find(utcp_ca->name))
-			return -EEXIST;
 		return 1;
 	}
=20
@@ -266,13 +264,25 @@ static void bpf_tcp_ca_unreg(void *kdata)
 	tcp_unregister_congestion_control(kdata);
 }
=20
+static int bpf_tcp_ca_update(void *kdata, void *old_kdata)
+{
+	return tcp_update_congestion_control(kdata, old_kdata);
+}
+
+static int bpf_tcp_ca_validate(void *kdata)
+{
+	return tcp_validate_congestion_control(kdata);
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
+	.validate =3D bpf_tcp_ca_validate,
 	.name =3D "tcp_congestion_ops",
 };
=20
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index db8b4b488c31..24829390e495 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -75,14 +75,8 @@ struct tcp_congestion_ops *tcp_ca_find_key(u32 key)
 	return NULL;
 }
=20
-/*
- * Attach new congestion control algorithm to the list
- * of available options.
- */
-int tcp_register_congestion_control(struct tcp_congestion_ops *ca)
+int tcp_validate_congestion_control(struct tcp_congestion_ops *ca)
 {
-	int ret =3D 0;
-
 	/* all algorithms must implement these */
 	if (!ca->ssthresh || !ca->undo_cwnd ||
 	    !(ca->cong_avoid || ca->cong_control)) {
@@ -90,6 +84,20 @@ int tcp_register_congestion_control(struct tcp_congest=
ion_ops *ca)
 		return -EINVAL;
 	}
=20
+	return 0;
+}
+
+/* Attach new congestion control algorithm to the list
+ * of available options.
+ */
+int tcp_register_congestion_control(struct tcp_congestion_ops *ca)
+{
+	int ret;
+
+	ret =3D tcp_validate_congestion_control(ca);
+	if (ret)
+		return ret;
+
 	ca->key =3D jhash(ca->name, sizeof(ca->name), strlen(ca->name));
=20
 	spin_lock(&tcp_cong_list_lock);
@@ -130,6 +138,41 @@ void tcp_unregister_congestion_control(struct tcp_co=
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
+	int ret;
+
+	ret =3D tcp_validate_congestion_control(ca);
+	if (ret)
+		return ret;
+
+	ca->key =3D jhash(ca->name, sizeof(ca->name), strlen(ca->name));
+
+	spin_lock(&tcp_cong_list_lock);
+	existing =3D tcp_ca_find_key(old_ca->key);
+	if (ca->key =3D=3D TCP_CA_UNSPEC || !existing || strcmp(existing->name,=
 ca->name)) {
+		pr_notice("%s not registered or non-unique key\n",
+			  ca->name);
+		ret =3D -EINVAL;
+	} else if (existing !=3D old_ca) {
+		pr_notice("invalid old congestion control algorithm to replace\n");
+		ret =3D -EINVAL;
+	} else {
+		list_add_tail_rcu(&ca->list, &tcp_cong_list);
+		list_del_rcu(&existing->list);
+		pr_debug("%s updated\n", ca->name);
+	}
+	spin_unlock(&tcp_cong_list_lock);
+
+	return ret;
+}
+
 u32 tcp_ca_get_key_by_name(struct net *net, const char *name, bool *ecn_=
ca)
 {
 	const struct tcp_congestion_ops *ca;
--=20
2.34.1

