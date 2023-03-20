Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD626C217E
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 20:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCTTcI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 15:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjCTTbk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 15:31:40 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3145C32539
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:24:28 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KH7ivv027045
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:24:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=+vvs/l+gkw85c6C8w//C3e34B5mEhSjVJPXVhKGKCeI=;
 b=lsm343ZNBLZPNbhzYP92uEBQ0ay/3R684NF8KKJRCdU/G623cjrHlIof4jyPwQ6nqess
 cCVddU6JjcW/KNE/b+uSYZV18IlTjLSY/gYis3EWqVndKR3dtRvhDK4FAKeZHjc1updn
 XewJ+Q6vv8CXshLCd3PwTXgw7He4k8NzgtHpB6Nu0G0DyTGXcBXosenDcNSQr+FMui76
 +4EqjYIPjg5LRwbN7PaHFkxla9jycPys8pH0z46YpT9d11b+/owXsuaMFxzPGCJeKGux
 z/0aXH78zwgSko7ClprFdcD1Y8Mq1rRX2TksZQMa9dXm6EH4Rkndre/nXQfz1pWowtwF 5A== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pdb20bduq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:24:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIomO1RZ9syTmPXHgzVjcroJnEDfMQ6AZcovUv8M1IiAfFLxjMTHx7nXEDklMgC4nw5vE+3eZMNZoBilOm0jJ16QYsxuLVDmeOK62JfYnBE9UNmhrWYJ9sxj1N6G8OkK/LS8u863yDjBGAich7aN6ssRDYOy2NLjfT6p2JCSynJtpoTEeDon+NZWXceekWDfK5VNocPI/Tw09/omDy+4wwG9ChO6+TyveJUCWLp6jXTfb/WBcy72df6xZKzUKWIRG0DIkg93URnEO068uqeHkV7XznqeOB17Xvtbc7Hhshp7apMYklOl02NW7kNkZl9nshdYNkBoHDnjWEcjNIdODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vvs/l+gkw85c6C8w//C3e34B5mEhSjVJPXVhKGKCeI=;
 b=X4KVSLy4d8MjeCAnTLey3WKLWn1umIDc78375eA13AMV1GWx4e6lXxRd73Xm9h6quBkIpRTevAf2A+t1ddRaSi/CyzTYgl7p2PWe+bCuRZhl+fRvR9C2YkN40COIHJPf7Fppl6GwYDGgMOmdCzWV1QNfDea1jDJMx9GW3fsFEk3C/X9yBEjP6pLXZyQ/uhwYb9ld1M2fnpK2Gg+JCp6VsMvIViPW3MiHfnfjOZl0k+4W+YTSp/BiECx7xonPFRnah7aRl2t8H3ngRC7xXtH48O0tB4VR5rk+MS7UGzohyKwh4Wr2IjlsgxMtmQtQrJhVbt0XzTWI1ijuYAWXRH2J3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 69.171.232.181) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=meta.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject header.from=meta.com;
 dkim=none (message not signed); arc=none
Received: from DS7PR06CA0031.namprd06.prod.outlook.com (2603:10b6:8:54::11) by
 CH3PR15MB5769.namprd15.prod.outlook.com (2603:10b6:610:126::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 19:24:25 +0000
Received: from DM6NAM12FT111.eop-nam12.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::e8) by DS7PR06CA0031.outlook.office365.com
 (2603:10b6:8:54::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 19:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 69.171.232.181)
 smtp.mailfrom=meta.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=meta.com;
Received-SPF: Fail (protection.outlook.com: domain of meta.com does not
 designate 69.171.232.181 as permitted sender)
 receiver=protection.outlook.com; client-ip=69.171.232.181;
 helo=69-171-232-181.mail-mxout.facebook.com;
Received: from 69-171-232-181.mail-mxout.facebook.com (69.171.232.181) by
 DM6NAM12FT111.mail.protection.outlook.com (10.13.179.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.11 via Frontend Transport; Mon, 20 Mar 2023 19:24:25 +0000
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id B77FE7D43601; Mon, 20 Mar 2023 12:24:12 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v9 4/8] libbpf: Create a bpf_link in bpf_map__attach_struct_ops().
Date:   Mon, 20 Mar 2023 12:24:06 -0700
Message-Id: <20230320192410.1624645-5-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320192410.1624645-1-kuifeng@meta.com>
References: <20230320192410.1624645-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT111:EE_|CH3PR15MB5769:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 51b747f1-5cf3-4dfe-f141-08db2978b798
X-ETR:  Bypass spam filtering
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJK3UIB6EeuS5DbnwJ+F3bPFPf/MxZ4gnQau1gZesW3et2oYX34sJrBXW4j51IuBlbP0Lvulrl1KslT33yz4LdoBhxXMORTmSpk/d+slaG/feTDT8QOJ7ZVpQLb7un2zTpa0ffAnfTHaQmB6wf0seXFlJQ9GuMG21VYEKkqoZs+ZyrIqPorPnAYv6OCAMR4iwuyVfxqtoOeIwSznZnfT54FZ+VPrROyP53us4drN3/E1jcvKP2x3jQnST7inICgYYXHyx8lTbhVt1icTMbMlHePEahcDOS9FuhtvWHdhUhi3AkX+gr5EgMY3HuOcy3xt/082zgb022Rbx8AULGlE212MdwAv2+pHei+8gAYTpWEdudcJW1Ff9zBO/G91xhPr9EqaZvQuCkOztQRamV/Fx8EucfCpJYh+qleM31X2nFc7YPQbMAO1u73IT4Rm2ftfu9p6w59ipdQyHTrWg66sqoB3WIknySabaQtQ9ToXZ4SVBDjwzR3F6y3YMSNZmrbS0BB7l+OSkWN0ZtyEQ7fF0GZXnAHf+Xq0K2/zYm/zs0e7Tn3NL9PbapVFGJxBKUHs7MoQsXuW2pg+ki8XUTdFP6VOxfeNQBOb84YW7eCW2fM/nxoDyZkTdEM9khxVn5CbQjzgGWzS3F8QjsgD+lAuE6stNPZ/eIL57BJ8ys2zaSuFCbJa+EShGg5raeUY4hfKbYwk7CIrC9ScLdxpJWri5b6GYxnDBZrwZyzPbOPzHzvi10JxIqwL/YfJC/2Jq7n/
X-Forefront-Antispam-Report: CIP:69.171.232.181;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:69-171-232-181.mail-mxout.facebook.com;PTR:69-171-232-181.mail-mxout.facebook.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199018)(36840700001)(46966006)(40470700004)(33570700077)(478600001)(2616005)(47076005)(83380400001)(82310400005)(42186006)(316002)(1076003)(336012)(186003)(107886003)(6666004)(6266002)(26005)(7636003)(5660300002)(7596003)(36860700001)(356005)(40460700003)(86362001)(2906002)(8936002)(70206006)(4326008)(82740400003)(36756003)(40480700001)(41300700001)(8676002)(101420200003);DIR:OUT;SFP:1501;
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 19:24:25.5031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b747f1-5cf3-4dfe-f141-08db2978b798
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=8ae927fe-1255-47a7-a2af-5f3a069daaa2;Ip=[69.171.232.181];Helo=[69-171-232-181.mail-mxout.facebook.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT111.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5769
X-Proofpoint-ORIG-GUID: q7i-NJdUj5utSWMKBo8XkWM1nHPrtoa4
X-Proofpoint-GUID: q7i-NJdUj5utSWMKBo8XkWM1nHPrtoa4
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

bpf_map__attach_struct_ops() was creating a dummy bpf_link as a
placeholder, but now it is constructing an authentic one by calling
bpf_link_create() if the map has the BPF_F_LINK flag.

You can flag a struct_ops map with BPF_F_LINK by calling
bpf_map__set_map_flags().

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 tools/lib/bpf/libbpf.c | 90 +++++++++++++++++++++++++++++++-----------
 1 file changed, 66 insertions(+), 24 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4c34fbd7b5be..56a60ab2ca8f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -116,6 +116,7 @@ static const char * const attach_type_name[] =3D {
 	[BPF_SK_REUSEPORT_SELECT_OR_MIGRATE]	=3D "sk_reuseport_select_or_migrat=
e",
 	[BPF_PERF_EVENT]		=3D "perf_event",
 	[BPF_TRACE_KPROBE_MULTI]	=3D "trace_kprobe_multi",
+	[BPF_STRUCT_OPS]		=3D "struct_ops",
 };
=20
 static const char * const link_type_name[] =3D {
@@ -7683,6 +7684,37 @@ static int bpf_object__resolve_externs(struct bpf_=
object *obj,
 	return 0;
 }
=20
+static void bpf_map_prepare_vdata(const struct bpf_map *map)
+{
+	struct bpf_struct_ops *st_ops;
+	__u32 i;
+
+	st_ops =3D map->st_ops;
+	for (i =3D 0; i < btf_vlen(st_ops->type); i++) {
+		struct bpf_program *prog =3D st_ops->progs[i];
+		void *kern_data;
+		int prog_fd;
+
+		if (!prog)
+			continue;
+
+		prog_fd =3D bpf_program__fd(prog);
+		kern_data =3D st_ops->kern_vdata + st_ops->kern_func_off[i];
+		*(unsigned long *)kern_data =3D prog_fd;
+	}
+}
+
+static int bpf_object_prepare_struct_ops(struct bpf_object *obj)
+{
+	int i;
+
+	for (i =3D 0; i < obj->nr_maps; i++)
+		if (bpf_map__is_struct_ops(&obj->maps[i]))
+			bpf_map_prepare_vdata(&obj->maps[i]);
+
+	return 0;
+}
+
 static int bpf_object_load(struct bpf_object *obj, int extra_log_level, =
const char *target_btf_path)
 {
 	int err, i;
@@ -7708,6 +7740,7 @@ static int bpf_object_load(struct bpf_object *obj, =
int extra_log_level, const ch
 	err =3D err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : targ=
et_btf_path);
 	err =3D err ? : bpf_object__load_progs(obj, extra_log_level);
 	err =3D err ? : bpf_object_init_prog_arrays(obj);
+	err =3D err ? : bpf_object_prepare_struct_ops(obj);
=20
 	if (obj->gen_loader) {
 		/* reset FDs */
@@ -11572,22 +11605,30 @@ struct bpf_link *bpf_program__attach(const stru=
ct bpf_program *prog)
 	return link;
 }
=20
+struct bpf_link_struct_ops {
+	struct bpf_link link;
+	int map_fd;
+};
+
 static int bpf_link__detach_struct_ops(struct bpf_link *link)
 {
+	struct bpf_link_struct_ops *st_link;
 	__u32 zero =3D 0;
=20
-	if (bpf_map_delete_elem(link->fd, &zero))
-		return -errno;
+	st_link =3D container_of(link, struct bpf_link_struct_ops, link);
=20
-	return 0;
+	if (st_link->map_fd < 0)
+		/* w/o a real link */
+		return bpf_map_delete_elem(link->fd, &zero);
+
+	return close(link->fd);
 }
=20
 struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
 {
-	struct bpf_struct_ops *st_ops;
-	struct bpf_link *link;
-	__u32 i, zero =3D 0;
-	int err;
+	struct bpf_link_struct_ops *link;
+	__u32 zero =3D 0;
+	int err, fd;
=20
 	if (!bpf_map__is_struct_ops(map) || map->fd =3D=3D -1)
 		return libbpf_err_ptr(-EINVAL);
@@ -11596,31 +11637,32 @@ struct bpf_link *bpf_map__attach_struct_ops(con=
st struct bpf_map *map)
 	if (!link)
 		return libbpf_err_ptr(-EINVAL);
=20
-	st_ops =3D map->st_ops;
-	for (i =3D 0; i < btf_vlen(st_ops->type); i++) {
-		struct bpf_program *prog =3D st_ops->progs[i];
-		void *kern_data;
-		int prog_fd;
+	/* kern_vdata should be prepared during the loading phase. */
+	err =3D bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0)=
;
+	if (err && err !=3D -EBUSY) {
+		free(link);
+		return libbpf_err_ptr(err);
+	}
=20
-		if (!prog)
-			continue;
+	link->link.detach =3D bpf_link__detach_struct_ops;
=20
-		prog_fd =3D bpf_program__fd(prog);
-		kern_data =3D st_ops->kern_vdata + st_ops->kern_func_off[i];
-		*(unsigned long *)kern_data =3D prog_fd;
+	if (!(map->def.map_flags & BPF_F_LINK)) {
+		/* w/o a real link */
+		link->link.fd =3D map->fd;
+		link->map_fd =3D -1;
+		return &link->link;
 	}
=20
-	err =3D bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
-	if (err) {
-		err =3D -errno;
+	fd =3D bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, NULL);
+	if (fd < 0) {
 		free(link);
-		return libbpf_err_ptr(err);
+		return libbpf_err_ptr(fd);
 	}
=20
-	link->detach =3D bpf_link__detach_struct_ops;
-	link->fd =3D map->fd;
+	link->link.fd =3D fd;
+	link->map_fd =3D map->fd;
=20
-	return link;
+	return &link->link;
 }
=20
 typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct perf_ev=
ent_header *hdr,
--=20
2.34.1

