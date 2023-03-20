Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238E76C2206
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 20:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjCTT5L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 15:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCTT5K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 15:57:10 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2701522DDE
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:57:07 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KH743f008139
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:57:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=yCIuXsuNrCBmzuSiAZsGrmHGqerpaTnqPUs3YtArSl4=;
 b=nUEW8yC46wXAC7qTuQRkaFXlEPGTTmExGAIFQbq1LVdbp/bcorVrZZpdUT9fB+lD+t68
 48M+PA/FtNMeJNwSmqlJE4BFBVrSLDRQE6kwh8JaDYFJK7vX2n7SweT0eyIUazhb82r8
 PwKuJSMD8NogNBrNxw+Ucnuj4ELg55CeCmY7SDl4h+kh5RB3P61fq9S0QyHJZUVQ1wvq
 frEIEKKW9gfLY7HYZVvpLzk9lBCYdOWwDppkUlOmAseAral18MMr4b4+sF13+3rkWsYo
 sAwtquQ5rCxoYaAT19/1arXVEnawSoo6RklaV/b48ITwcO3nEbY2MNccCULPxYGWdM0e +w== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pdae1kuxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:57:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYgbVCvc3ceKipVPC7n9elBqk/36TOeGneerGrfXolfID2n4N/OOsscnoPsjpxdGg1CrTlkYBW8QII9w82Kw+QA6cQT4p6EyyJ3GgtuI4hq98KU7ryjGV1Ush79MYwKK3A2WY1rH7VWQ/jLgmHZqUaSavhJNvd+4QPKqosPldZcO8iluhfXXjNOTFS9pBtZGOK/Sn0iAOZB2dip6OEbpwWb/hG+Qhezf/EIsAHuknH91lizlge1s6t0rRIBh/ww1YKDn2ftB69G3/8kGW1X6QfZ1Twn56RZ961Vd/3hN0jlioKG0uh5TrQCuEtG7nvSA7QaYdszHiw5IHUs01oQ85g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCIuXsuNrCBmzuSiAZsGrmHGqerpaTnqPUs3YtArSl4=;
 b=nwVKjjPzVI2VY9Wv6NI+SzV5TPIyOWdGvu/JxD5NASbCf0gcjOrTNXRWzwUa0o9og5ZAVhNs+PcCUvf5w7wJcqEGSzMu+xpHoJrTsEPyS/kFe80eGNBs3HSis3987FlVKaecGTqgp2grZcSvH7AHKTjcvuyjd0mEjpMRXNyUy4RFNiCDMJdAGRmz1pOMuL1iTQqtIoj0n3DN2FYCAcdeQL9T1D995hmf3dmB7ng47vIcsMVJGKOOqTN9erg2kXUYdKRj2RugI7idWcAS1VS4X6yhQH4ak1vWy6TLNHYHY2hRCmMCtwIN/ljCEEjmCIHfnkZBNPY4ato6C1fCRRrzNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 69.171.232.181) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=meta.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject header.from=meta.com;
 dkim=none (message not signed); arc=none
Received: from DS7PR03CA0176.namprd03.prod.outlook.com (2603:10b6:5:3b2::31)
 by BY1PR15MB5957.namprd15.prod.outlook.com (2603:10b6:a03:52b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 19:57:04 +0000
Received: from DM6NAM12FT079.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::40) by DS7PR03CA0176.outlook.office365.com
 (2603:10b6:5:3b2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 19:57:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 69.171.232.181)
 smtp.mailfrom=meta.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=meta.com;
Received-SPF: Fail (protection.outlook.com: domain of meta.com does not
 designate 69.171.232.181 as permitted sender)
 receiver=protection.outlook.com; client-ip=69.171.232.181;
 helo=69-171-232-181.mail-mxout.facebook.com;
Received: from 69-171-232-181.mail-mxout.facebook.com (69.171.232.181) by
 DM6NAM12FT079.mail.protection.outlook.com (10.13.178.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.11 via Frontend Transport; Mon, 20 Mar 2023 19:57:04 +0000
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 46A7E7D4C175; Mon, 20 Mar 2023 12:56:46 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v9 1/8] bpf: Retire the struct_ops map kvalue->refcnt.
Date:   Mon, 20 Mar 2023 12:56:37 -0700
Message-Id: <20230320195644.1953096-2-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320195644.1953096-1-kuifeng@meta.com>
References: <20230320195644.1953096-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT079:EE_|BY1PR15MB5957:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a2757c9c-35d7-4db1-27b1-08db297d4717
X-ETR:  Bypass spam filtering
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ijWJrVDf7r46NqYc1DVgffHrDExVzJrpTjUlixFVnN5tY3ZVk7u1IliJh1JMI5IMXzsN/U0C3EhSaVZzlt67SqyXaI3SUZrjn2yoOPRInbEmKxWSzAU+96Q3lnZg6AxjNjsKcYi3F+mWeIyOy5UVfCwfWv996RD8//YnKbk9YADSRi0XsT+ttHwqq/Rg5dWFPH1Qs2N95e+qPTOrt2HdIOA7iXXPGUPzL9mhVO9L9WAx98R0oMov/dydFfnudUNzzjeKiYF2K0S06PispP8FP2J81FJOFSA1a/xoCCOwlOk2BDsFv+7wHG5SQOTj2Meo4/+0sK2B+RynoLBHABfep7FpO3AnCZqux7dlDXcMu9o78R9VoiJBWKHDDMcHmlpobTQyhajr+cJv3RMFtdCHounCkuJ5MCdr4pn8IDo70XPbKRQIcyBIwTwcFgAuiEfKUNDD2aF8BrqvlxmtmoW3zl2AwFWEAqcDAY/dD097W8BqV1ZpD+DXWHTrygF6a/b9Q/+S+pI8ILR2HqnhQ2U+Gl48/3zyz7vabwJ7h/yClFgkhiD2fcTPfBDj2Xb3bzHymqmADZGjm6vKpEcdJGjmRhLHx7/l8U6DVONp3jlDOgz/Y3CT+RQTqMF1yvRa6q8yOM2/pGibCJRzkxQcW5VaCJtc1aOXWEBcbR6L/3iICafuOm1sIc+BbF6BIGdJ9+3QgFR6FQf2+MgGuPncttozQ==
X-Forefront-Antispam-Report: CIP:69.171.232.181;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:69-171-232-181.mail-mxout.facebook.com;PTR:69-171-232-181.mail-mxout.facebook.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199018)(46966006)(40470700004)(36840700001)(66899018)(33570700077)(47076005)(2616005)(83380400001)(82310400005)(42186006)(316002)(6666004)(478600001)(26005)(6266002)(107886003)(186003)(5660300002)(1076003)(36860700001)(7636003)(7596003)(356005)(40460700003)(86362001)(336012)(8936002)(70206006)(2906002)(40480700001)(4326008)(82740400003)(41300700001)(36756003)(8676002);DIR:OUT;SFP:1501;
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 19:57:04.2314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2757c9c-35d7-4db1-27b1-08db297d4717
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=8ae927fe-1255-47a7-a2af-5f3a069daaa2;Ip=[69.171.232.181];Helo=[69-171-232-181.mail-mxout.facebook.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT079.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR15MB5957
X-Proofpoint-GUID: JCDIeBYPJBUo-_wydNO6kGFWcZ0Vjdxa
X-Proofpoint-ORIG-GUID: JCDIeBYPJBUo-_wydNO6kGFWcZ0Vjdxa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_16,2023-03-20_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We have replaced kvalue-refcnt with synchronize_rcu() to wait for an
RCU grace period.

Maintenance of kvalue->refcnt was a complicated task, as we had to
simultaneously keep track of two reference counts: one for the
reference count of bpf_map. When the kvalue->refcnt reaches zero, we
also have to reduce the reference count on bpf_map - yet these steps
are not performed in an atomic manner and require us to be vigilant
when managing them. By eliminating kvalue->refcnt, we can make our
maintenance more straightforward as the refcount of bpf_map is now
solely managed!

To prevent the trampoline image of a struct_ops from being released
while it is still in use, we wait for an RCU grace period. The
setsockopt(TCP_CONGESTION, "...") command allows you to change your
socket's congestion control algorithm and can result in releasing the
old struct_ops implementation. It is fine. However, this function is
exposed through bpf_setsockopt(), it may be accessed by BPF programs
as well. To ensure that the trampoline image belonging to struct_op
can be safely called while its method is in use, the trampoline
safeguarde the BPF program with rcu_read_lock(). Doing so prevents any
destruction of the associated images before returning from a
trampoline and requires us to wait for an RCU grace period.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/linux/bpf.h         |  1 +
 kernel/bpf/bpf_struct_ops.c | 73 ++++++++++++++++++++-----------------
 kernel/bpf/syscall.c        |  6 ++-
 3 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3ef98fb92987..3304c84fe021 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1945,6 +1945,7 @@ struct bpf_map *bpf_map_get_with_uref(u32 ufd);
 struct bpf_map *__bpf_map_get(struct fd f);
 void bpf_map_inc(struct bpf_map *map);
 void bpf_map_inc_with_uref(struct bpf_map *map);
+struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref);
 struct bpf_map * __must_check bpf_map_inc_not_zero(struct bpf_map *map);
 void bpf_map_put_with_uref(struct bpf_map *map);
 void bpf_map_put(struct bpf_map *map);
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 38903fb52f98..ca87258b42e9 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -11,6 +11,7 @@
 #include <linux/refcount.h>
 #include <linux/mutex.h>
 #include <linux/btf_ids.h>
+#include <linux/rcupdate_wait.h>
=20
 enum bpf_struct_ops_state {
 	BPF_STRUCT_OPS_STATE_INIT,
@@ -249,6 +250,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map=
 *map, void *key,
 	struct bpf_struct_ops_map *st_map =3D (struct bpf_struct_ops_map *)map;
 	struct bpf_struct_ops_value *uvalue, *kvalue;
 	enum bpf_struct_ops_state state;
+	s64 refcnt;
=20
 	if (unlikely(*(u32 *)key !=3D 0))
 		return -ENOENT;
@@ -267,7 +269,14 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_ma=
p *map, void *key,
 	uvalue =3D value;
 	memcpy(uvalue, st_map->uvalue, map->value_size);
 	uvalue->state =3D state;
-	refcount_set(&uvalue->refcnt, refcount_read(&kvalue->refcnt));
+
+	/* This value offers the user space a general estimate of how
+	 * many sockets are still utilizing this struct_ops for TCP
+	 * congestion control. The number might not be exact, but it
+	 * should sufficiently meet our present goals.
+	 */
+	refcnt =3D atomic64_read(&map->refcnt) - atomic64_read(&map->usercnt);
+	refcount_set(&uvalue->refcnt, max_t(s64, refcnt, 0));
=20
 	return 0;
 }
@@ -491,7 +500,6 @@ static int bpf_struct_ops_map_update_elem(struct bpf_=
map *map, void *key,
 		*(unsigned long *)(udata + moff) =3D prog->aux->id;
 	}
=20
-	refcount_set(&kvalue->refcnt, 1);
 	bpf_map_inc(map);
=20
 	set_memory_rox((long)st_map->image, 1);
@@ -536,8 +544,7 @@ static int bpf_struct_ops_map_delete_elem(struct bpf_=
map *map, void *key)
 	switch (prev_state) {
 	case BPF_STRUCT_OPS_STATE_INUSE:
 		st_map->st_ops->unreg(&st_map->kvalue.data);
-		if (refcount_dec_and_test(&st_map->kvalue.refcnt))
-			bpf_map_put(map);
+		bpf_map_put(map);
 		return 0;
 	case BPF_STRUCT_OPS_STATE_TOBEFREE:
 		return -EINPROGRESS;
@@ -570,7 +577,7 @@ static void bpf_struct_ops_map_seq_show_elem(struct b=
pf_map *map, void *key,
 	kfree(value);
 }
=20
-static void bpf_struct_ops_map_free(struct bpf_map *map)
+static void __bpf_struct_ops_map_free(struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map =3D (struct bpf_struct_ops_map *)map;
=20
@@ -582,6 +589,24 @@ static void bpf_struct_ops_map_free(struct bpf_map *=
map)
 	bpf_map_area_free(st_map);
 }
=20
+static void bpf_struct_ops_map_free(struct bpf_map *map)
+{
+	/* The struct_ops's function may switch to another struct_ops.
+	 *
+	 * For example, bpf_tcp_cc_x->init() may switch to
+	 * another tcp_cc_y by calling
+	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
+	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
+	 * and its refcount may reach 0 which then free its
+	 * trampoline image while tcp_cc_x is still running.
+	 *
+	 * Thus, a rcu grace period is needed here.
+	 */
+	synchronize_rcu_mult(call_rcu, call_rcu_tasks);
+
+	__bpf_struct_ops_map_free(map);
+}
+
 static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)
 {
 	if (attr->key_size !=3D sizeof(unsigned int) || attr->max_entries !=3D =
1 ||
@@ -630,7 +655,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union=
 bpf_attr *attr)
 				   NUMA_NO_NODE);
 	st_map->image =3D bpf_jit_alloc_exec(PAGE_SIZE);
 	if (!st_map->uvalue || !st_map->links || !st_map->image) {
-		bpf_struct_ops_map_free(map);
+		__bpf_struct_ops_map_free(map);
 		return ERR_PTR(-ENOMEM);
 	}
=20
@@ -676,41 +701,23 @@ const struct bpf_map_ops bpf_struct_ops_map_ops =3D=
 {
 bool bpf_struct_ops_get(const void *kdata)
 {
 	struct bpf_struct_ops_value *kvalue;
+	struct bpf_struct_ops_map *st_map;
+	struct bpf_map *map;
=20
 	kvalue =3D container_of(kdata, struct bpf_struct_ops_value, data);
+	st_map =3D container_of(kvalue, struct bpf_struct_ops_map, kvalue);
=20
-	return refcount_inc_not_zero(&kvalue->refcnt);
-}
-
-static void bpf_struct_ops_put_rcu(struct rcu_head *head)
-{
-	struct bpf_struct_ops_map *st_map;
-
-	st_map =3D container_of(head, struct bpf_struct_ops_map, rcu);
-	bpf_map_put(&st_map->map);
+	map =3D __bpf_map_inc_not_zero(&st_map->map, false);
+	return !IS_ERR(map);
 }
=20
 void bpf_struct_ops_put(const void *kdata)
 {
 	struct bpf_struct_ops_value *kvalue;
+	struct bpf_struct_ops_map *st_map;
=20
 	kvalue =3D container_of(kdata, struct bpf_struct_ops_value, data);
-	if (refcount_dec_and_test(&kvalue->refcnt)) {
-		struct bpf_struct_ops_map *st_map;
-
-		st_map =3D container_of(kvalue, struct bpf_struct_ops_map,
-				      kvalue);
-		/* The struct_ops's function may switch to another struct_ops.
-		 *
-		 * For example, bpf_tcp_cc_x->init() may switch to
-		 * another tcp_cc_y by calling
-		 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
-		 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
-		 * and its map->refcnt may reach 0 which then free its
-		 * trampoline image while tcp_cc_x is still running.
-		 *
-		 * Thus, a rcu grace period is needed here.
-		 */
-		call_rcu(&st_map->rcu, bpf_struct_ops_put_rcu);
-	}
+	st_map =3D container_of(kvalue, struct bpf_struct_ops_map, kvalue);
+
+	bpf_map_put(&st_map->map);
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 099e9068bcdd..cff0348a2871 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1303,8 +1303,10 @@ struct bpf_map *bpf_map_get_with_uref(u32 ufd)
 	return map;
 }
=20
-/* map_idr_lock should have been held */
-static struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool =
uref)
+/* map_idr_lock should have been held or the map should have been
+ * protected by rcu read lock.
+ */
+struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref)
 {
 	int refold;
=20
--=20
2.34.1

