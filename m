Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3876C2209
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 20:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCTT5P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 15:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjCTT5O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 15:57:14 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93811222D9
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:57:10 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KH7Yl9004136
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:57:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=uRY8LMt1y5hIyig+tWUlb7KPDIEtTerR8dDtW0YeL3s=;
 b=MGEEPvmROlDZykhscEOrLZu9Z6EN0C2ToOp7eOBntOenAD4C8UmvwQQqVdhO3TezhJ9K
 8qnuWt1KrFxpGpOcda7PyqeUHK745i3v/Dk1EhRiYzXyLWZuMwxx/dtAL7b79hclp/Jt
 G4hQS28OYepSTKbexl4l4/7mKiEYuEwALEjNrTFMTM4DxiXtECnh3NX7c9pi2Ilp/HMn
 Vx9ml3v7X7IHPIQJ5FqXAwWHxzh5Kuln56op3VoJYHBnZLE8DKXYTkurqJfcjELNzt4I
 VzAYWAmMg6olCAuH1xHwG8o2i0KVew3P3Xv+C8dY7LDnFSvILlb9r/tzBGMAEth+zuO3 UQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pdb4vbjh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:57:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8lh58+0+AyvVIO979LIXrFd1VHtYdqGoagyHGTHdW3xj0VBgpChg4BgW9aqe0HU5Cg4Po+uf5HU6qlPzy0JwnVVhKuKNVCYr5GKb6Zm9ibtcGno26dHS1TsSv3Yh3X/2G5rri7i4zoh4/r3Ma+hCCV4TSn6nfAGWi8elCMKXk4ux6pdY6f3XKiAmJHeQMCDfStpZOkz/1Q9mMH0+A912gR2Qc7JXvowvoim2+OCI6u/5gHoUiMuzyM1mhABtKLA/3BOA3its/wUFHR5mpqI8resCeQlqSMjnJIOWjBsSbPA+R2yMPfOjxkm5InLaL6XKvvysL2KAs+u1gLd3P36Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRY8LMt1y5hIyig+tWUlb7KPDIEtTerR8dDtW0YeL3s=;
 b=G3JTjG3bp8x0L+azWxnd/CSjwMIEavEaBv94t1/TCPguieEPuiCtH75Jzj1cSTWVHeYIKrC9iWdEXuz0c98381RynI1OmidKXJ0dr5dbIjPt2buBkaDBz8KkCpa5ZhaFcnUYz7tOavDTHAr8OD95VFD+juW1vuezUclf56iTq5m4WhbOTbLyfgVpGsHqdEBuCQP69n3jg/8H/HmJXG4ytPbgJ3tYHpfVktVmoLqIoYt0ZH7pVhDfYW9Kk1xQfgU8acRutGyTczyU7gWQQss2FPGsdHT+hl3yb77wGz2X1XNw22R1qTb5pnEqkP1kob7v+k+FTV1ovuyApslv8bWpFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 69.171.232.181) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=meta.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject header.from=meta.com;
 dkim=none (message not signed); arc=none
Received: from MW4PR03CA0197.namprd03.prod.outlook.com (2603:10b6:303:b8::22)
 by MW3PR15MB3849.namprd15.prod.outlook.com (2603:10b6:303:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 19:57:07 +0000
Received: from MW2NAM12FT075.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::f9) by MW4PR03CA0197.outlook.office365.com
 (2603:10b6:303:b8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 19:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 69.171.232.181)
 smtp.mailfrom=meta.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=meta.com;
Received-SPF: Fail (protection.outlook.com: domain of meta.com does not
 designate 69.171.232.181 as permitted sender)
 receiver=protection.outlook.com; client-ip=69.171.232.181;
 helo=69-171-232-181.mail-mxout.facebook.com;
Received: from 69-171-232-181.mail-mxout.facebook.com (69.171.232.181) by
 MW2NAM12FT075.mail.protection.outlook.com (10.13.181.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.2 via Frontend Transport; Mon, 20 Mar 2023 19:57:07 +0000
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 776F47D4C17E; Mon, 20 Mar 2023 12:56:46 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v9 5/8] bpf: Update the struct_ops of a bpf_link.
Date:   Mon, 20 Mar 2023 12:56:41 -0700
Message-Id: <20230320195644.1953096-6-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320195644.1953096-1-kuifeng@meta.com>
References: <20230320195644.1953096-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM12FT075:EE_|MW3PR15MB3849:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8e416564-2af8-4b38-89fe-08db297d4922
X-ETR:  Bypass spam filtering
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYy35v8P1SqliqCalMoIjPEfKBBf5mnbSXjtYpY3OUUxBym3uCpmY3YpaIzrm0Bups2f5yIfshtSp3db5HNlnaRZoBFtdcrsCfqNkUeRXbpyOX3KMEbT2h0853VUlBNzy76VogniR/dU1iPpur7lAQTo8HKqAm27fi62Hhv1TsT9BgZGJ+/phUz/+Ox7Ra1TLVj6w4dGn5Ue6Zc7+pHcASbdz/AINw7RmGomyIBjl6+eQvH6/HN30P4OZlwdnAYODRHdXQpegAMyLy66zgxwtpaio+Sm+EH64k6KPWC/lVBHfJmuHcJ5kREO/PRarU/u5gijYyzSXYOCDi4qTrN1HMdT2TjeA8Qh355uQOobRK9BmM1+rVWfcuReFFWwXg7fE5HrhGll2QH2CQwOCBsHcTWySDj2x7/RSYxVywOCewnQCcGA+QBDW/qZkEyXgSJqyVEHtJRncloR1nbzyGl9N3CjGvHtfhDqpBIsfbOOf4zDunNbj9ZsqDfT6iLXLDtvzudn7VtUw9lPB9kMbwhtzn1jKfwJnpaTA8Y8DuxNFZsImNVSJV3qq4BRFlYeR49GaG4xbzE3f/GwNQ3S2ETm7u46NPgp6yP7x8VysMawbbL58+8Ox3wOFQxFXScz7NHYV9kOAnCxpVOA/WZIscHjJhc1mtGSwQZx3HJdqiNzXZIqaRiFVE4iq6q3PJXABc3YW9UDL894YvZSV2WqUNX2sg==
X-Forefront-Antispam-Report: CIP:69.171.232.181;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:69-171-232-181.mail-mxout.facebook.com;PTR:69-171-232-181.mail-mxout.facebook.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199018)(46966006)(40470700004)(36840700001)(336012)(2616005)(26005)(1076003)(107886003)(47076005)(6666004)(6266002)(316002)(4326008)(83380400001)(186003)(478600001)(70206006)(42186006)(8676002)(5660300002)(8936002)(15650500001)(2906002)(7596003)(36860700001)(82740400003)(41300700001)(7636003)(356005)(66899018)(82310400005)(33570700077)(86362001)(36756003)(40480700001)(40460700003);DIR:OUT;SFP:1501;
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 19:57:07.5677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e416564-2af8-4b38-89fe-08db297d4922
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=8ae927fe-1255-47a7-a2af-5f3a069daaa2;Ip=[69.171.232.181];Helo=[69-171-232-181.mail-mxout.facebook.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT075.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3849
X-Proofpoint-GUID: 5yJC-R5WAX06yPNqEEpDbMkTJUnGTNI4
X-Proofpoint-ORIG-GUID: 5yJC-R5WAX06yPNqEEpDbMkTJUnGTNI4
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

By improving the BPF_LINK_UPDATE command of bpf(), it should allow you
to conveniently switch between different struct_ops on a single
bpf_link. This would enable smoother transitions from one struct_ops
to another.

The struct_ops maps passing along with BPF_LINK_UPDATE should have the
BPF_F_LINK flag.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/linux/bpf.h            |  3 +++
 include/uapi/linux/bpf.h       | 21 +++++++++++----
 kernel/bpf/bpf_struct_ops.c    | 48 +++++++++++++++++++++++++++++++++-
 kernel/bpf/syscall.c           | 34 ++++++++++++++++++++++++
 net/ipv4/bpf_tcp_ca.c          |  6 +++++
 tools/include/uapi/linux/bpf.h | 21 +++++++++++----
 6 files changed, 122 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2faf01fa3f04..29287a2d8b1b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1476,6 +1476,8 @@ struct bpf_link_ops {
 	void (*show_fdinfo)(const struct bpf_link *link, struct seq_file *seq);
 	int (*fill_link_info)(const struct bpf_link *link,
 			      struct bpf_link_info *info);
+	int (*update_map)(struct bpf_link *link, struct bpf_map *new_map,
+			  struct bpf_map *old_map);
 };
=20
 struct bpf_tramp_link {
@@ -1518,6 +1520,7 @@ struct bpf_struct_ops {
 			   void *kdata, const void *udata);
 	int (*reg)(void *kdata);
 	void (*unreg)(void *kdata);
+	int (*update)(void *kdata, void *old_kdata);
 	int (*validate)(void *kdata);
 	const struct btf_type *type;
 	const struct btf_type *value_type;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 42f40ee083bf..e3d3b5160d26 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1555,12 +1555,23 @@ union bpf_attr {
=20
 	struct { /* struct used by BPF_LINK_UPDATE command */
 		__u32		link_fd;	/* link fd */
-		/* new program fd to update link with */
-		__u32		new_prog_fd;
+		union {
+			/* new program fd to update link with */
+			__u32		new_prog_fd;
+			/* new struct_ops map fd to update link with */
+			__u32           new_map_fd;
+		};
 		__u32		flags;		/* extra flags */
-		/* expected link's program fd; is specified only if
-		 * BPF_F_REPLACE flag is set in flags */
-		__u32		old_prog_fd;
+		union {
+			/* expected link's program fd; is specified only if
+			 * BPF_F_REPLACE flag is set in flags.
+			 */
+			__u32		old_prog_fd;
+			/* expected link's map fd; is specified only
+			 * if BPF_F_REPLACE flag is set.
+			 */
+			__u32           old_map_fd;
+		};
 	} link_update;
=20
 	struct {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 5e77d1d4a7f5..71dd5d5d3ce5 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -65,6 +65,8 @@ struct bpf_struct_ops_link {
 	struct bpf_map __rcu *map;
 };
=20
+static DEFINE_MUTEX(update_mutex);
+
 #define VALUE_PREFIX "bpf_struct_ops_"
 #define VALUE_PREFIX_LEN (sizeof(VALUE_PREFIX) - 1)
=20
@@ -660,7 +662,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union=
 bpf_attr *attr)
 	if (attr->value_size !=3D vt->size)
 		return ERR_PTR(-EINVAL);
=20
-	if (attr->map_flags & BPF_F_LINK && !st_ops->validate)
+	if (attr->map_flags & BPF_F_LINK && (!st_ops->validate || !st_ops->upda=
te))
 		return ERR_PTR(-EOPNOTSUPP);
=20
 	t =3D st_ops->type;
@@ -806,10 +808,54 @@ static int bpf_struct_ops_map_link_fill_link_info(c=
onst struct bpf_link *link,
 	return 0;
 }
=20
+static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct =
bpf_map *new_map,
+					  struct bpf_map *expected_old_map)
+{
+	struct bpf_struct_ops_map *st_map, *old_st_map;
+	struct bpf_map *old_map;
+	struct bpf_struct_ops_link *st_link;
+	int err =3D 0;
+
+	st_link =3D container_of(link, struct bpf_struct_ops_link, link);
+	st_map =3D container_of(new_map, struct bpf_struct_ops_map, map);
+
+	if (!bpf_struct_ops_valid_to_reg(new_map))
+		return -EINVAL;
+
+	mutex_lock(&update_mutex);
+
+	old_map =3D rcu_dereference_protected(st_link->map, lockdep_is_held(&up=
date_mutex));
+	if (expected_old_map && old_map !=3D expected_old_map) {
+		err =3D -EINVAL;
+		goto err_out;
+	}
+
+	old_st_map =3D container_of(old_map, struct bpf_struct_ops_map, map);
+	/* The new and old struct_ops must be the same type. */
+	if (st_map->st_ops !=3D old_st_map->st_ops) {
+		err =3D -EINVAL;
+		goto err_out;
+	}
+
+	err =3D st_map->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.=
data);
+	if (err)
+		goto err_out;
+
+	bpf_map_inc(new_map);
+	rcu_assign_pointer(st_link->map, new_map);
+	bpf_map_put(old_map);
+
+err_out:
+	mutex_unlock(&update_mutex);
+
+	return err;
+}
+
 static const struct bpf_link_ops bpf_struct_ops_map_lops =3D {
 	.dealloc =3D bpf_struct_ops_map_link_dealloc,
 	.show_fdinfo =3D bpf_struct_ops_map_link_show_fdinfo,
 	.fill_link_info =3D bpf_struct_ops_map_link_fill_link_info,
+	.update_map =3D bpf_struct_ops_map_link_update,
 };
=20
 int bpf_struct_ops_link_create(union bpf_attr *attr)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 21f76698875c..b4d758fa5981 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4682,6 +4682,35 @@ static int link_create(union bpf_attr *attr, bpfpt=
r_t uattr)
 	return ret;
 }
=20
+static int link_update_map(struct bpf_link *link, union bpf_attr *attr)
+{
+	struct bpf_map *new_map, *old_map =3D NULL;
+	int ret;
+
+	new_map =3D bpf_map_get(attr->link_update.new_map_fd);
+	if (IS_ERR(new_map))
+		return -EINVAL;
+
+	if (attr->link_update.flags & BPF_F_REPLACE) {
+		old_map =3D bpf_map_get(attr->link_update.old_map_fd);
+		if (IS_ERR(old_map)) {
+			ret =3D -EINVAL;
+			goto out_put;
+		}
+	} else if (attr->link_update.old_map_fd) {
+		ret =3D -EINVAL;
+		goto out_put;
+	}
+
+	ret =3D link->ops->update_map(link, new_map, old_map);
+
+	if (old_map)
+		bpf_map_put(old_map);
+out_put:
+	bpf_map_put(new_map);
+	return ret;
+}
+
 #define BPF_LINK_UPDATE_LAST_FIELD link_update.old_prog_fd
=20
 static int link_update(union bpf_attr *attr)
@@ -4702,6 +4731,11 @@ static int link_update(union bpf_attr *attr)
 	if (IS_ERR(link))
 		return PTR_ERR(link);
=20
+	if (link->ops->update_map) {
+		ret =3D link_update_map(link, attr);
+		goto out_put_link;
+	}
+
 	new_prog =3D bpf_prog_get(attr->link_update.new_prog_fd);
 	if (IS_ERR(new_prog)) {
 		ret =3D PTR_ERR(new_prog);
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index bbbd5eb94db2..e8b27826283e 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -264,6 +264,11 @@ static void bpf_tcp_ca_unreg(void *kdata)
 	tcp_unregister_congestion_control(kdata);
 }
=20
+static int bpf_tcp_ca_update(void *kdata, void *old_kdata)
+{
+	return tcp_update_congestion_control(kdata, old_kdata);
+}
+
 static int bpf_tcp_ca_validate(void *kdata)
 {
 	return tcp_validate_congestion_control(kdata);
@@ -273,6 +278,7 @@ struct bpf_struct_ops bpf_tcp_congestion_ops =3D {
 	.verifier_ops =3D &bpf_tcp_ca_verifier_ops,
 	.reg =3D bpf_tcp_ca_reg,
 	.unreg =3D bpf_tcp_ca_unreg,
+	.update =3D bpf_tcp_ca_update,
 	.check_member =3D bpf_tcp_ca_check_member,
 	.init_member =3D bpf_tcp_ca_init_member,
 	.init =3D bpf_tcp_ca_init,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 9cf1deaf21f2..d6c5a022ae28 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1555,12 +1555,23 @@ union bpf_attr {
=20
 	struct { /* struct used by BPF_LINK_UPDATE command */
 		__u32		link_fd;	/* link fd */
-		/* new program fd to update link with */
-		__u32		new_prog_fd;
+		union {
+			/* new program fd to update link with */
+			__u32		new_prog_fd;
+			/* new struct_ops map fd to update link with */
+			__u32           new_map_fd;
+		};
 		__u32		flags;		/* extra flags */
-		/* expected link's program fd; is specified only if
-		 * BPF_F_REPLACE flag is set in flags */
-		__u32		old_prog_fd;
+		union {
+			/* expected link's program fd; is specified only if
+			 * BPF_F_REPLACE flag is set in flags.
+			 */
+			__u32		old_prog_fd;
+			/* expected link's map fd; is specified only
+			 * if BPF_F_REPLACE flag is set.
+			 */
+			__u32           old_map_fd;
+		};
 	} link_update;
=20
 	struct {
--=20
2.34.1

