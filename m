Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347B66C2183
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 20:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjCTTcR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 15:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjCTTby (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 15:31:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48C0EFB3
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:24:37 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KH7dja021668
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:24:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=1FqxCMUrgUat4OB/sYZfAflSMoMxq5LRpdm3BCF4Mrw=;
 b=mNC6qU+iIJ7VO09/FUrgl5G4iMGCQS6qLQKA5B46Ks4fmWb8vvNPVzvqcsWI5a2bbQpd
 8M5I2gNEif3WV4PJEidnKOIJg7EIFA/DU7DCitVC3K78DGrPtHMZVY68YhIXRkUOsdJC
 wo2Q0LAMSOrHxSdEg02Ud6ZoWuz/sTpvh/iy22blDRXJsLr+x7WWd5g8VBfJ6698HOF8
 UHuus8D27h724K01dz9gccHX+lDUmLjPzmvIYKkLQJVz77yQRpDI4wX1twZdqBU10jwj
 gM91R6fv7C9lBuZtIlOH+yxlpo9BrKtX27tiG6cK2NUy2aOGsHmNeG6o9ENsjeg5GuVi cQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3peq8hax9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:24:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SD52q6hF28CySimmzNuxhybv7pzM/hyXFoZOOOqkGbqmUPl9d2vVhBtw0j4xCLa8vTOUQH6z7q4IeGmcf6z+5YdwRZwca7Fi6UrlE83PZZpRjVdXYWq/h2jsgOhJfF5GAfsgwv51WfvVw3sLbXewn+3PbAVsYd4Kx62Qu2xT19gvE1JyOU9ztrZ7ktdOUlBJxnOS+jELJFfDifPQsnvjEahA9uenXehhD+tgYb+8kW6uxoAVp19bLZ1S5uy+BPLv/cMG8kHaIs+/bdaF8PiC0DDYO0SFgn2dLp/TdJ+ghcxi5GUbpbSMY936Op9c1bJVAzSWwJjN7tb6nQRVHEVniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FqxCMUrgUat4OB/sYZfAflSMoMxq5LRpdm3BCF4Mrw=;
 b=jvv8UknjiiQfzj2yGsc7xbIcMW97y/vzbVPhdzTX+aKLOih3ne4OFamt226pqM1x2awN+TT9yXoBDT2GU5ORMdqLkGB0U5xMjmQ5LBArRd4P3/856M2mNNUl3ppWpvU/AYr118v/12jLWWaJL2rb+5/SVR4ywof5p+mB8Tdimm+nLFeHY3Oog/VLYToJhMGJDjd87G8houDWStOKe0AtZVzRhtzdo+w25TQRVuUhqAAJlYl1q/AnBTUzyuT5xaTKM8UP2VVdIYMnTWXutNG2hcvX7TAjryh6a+Cn1TKzDGUkGPkIoX6IwuMmnrF3NMHbZi9NgjCu82k5zOV9eP8WDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 69.171.232.181) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=meta.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject header.from=meta.com;
 dkim=none (message not signed); arc=none
Received: from DS7PR03CA0014.namprd03.prod.outlook.com (2603:10b6:5:3b8::19)
 by PH0PR15MB4181.namprd15.prod.outlook.com (2603:10b6:510:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 19:24:35 +0000
Received: from DM6NAM12FT026.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::11) by DS7PR03CA0014.outlook.office365.com
 (2603:10b6:5:3b8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 19:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 69.171.232.181)
 smtp.mailfrom=meta.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=meta.com;
Received-SPF: Fail (protection.outlook.com: domain of meta.com does not
 designate 69.171.232.181 as permitted sender)
 receiver=protection.outlook.com; client-ip=69.171.232.181;
 helo=69-171-232-181.mail-mxout.facebook.com;
Received: from 69-171-232-181.mail-mxout.facebook.com (69.171.232.181) by
 DM6NAM12FT026.mail.protection.outlook.com (10.13.179.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 19:24:35 +0000
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id CDE087D43605; Mon, 20 Mar 2023 12:24:12 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v9 6/8] libbpf: Update a bpf_link with another struct_ops.
Date:   Mon, 20 Mar 2023 12:24:08 -0700
Message-Id: <20230320192410.1624645-7-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320192410.1624645-1-kuifeng@meta.com>
References: <20230320192410.1624645-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT026:EE_|PH0PR15MB4181:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 15380b66-3a80-444c-de0c-08db2978bd9a
X-ETR:  Bypass spam filtering
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyyNDNi1j3+QabZaZxEzHdNcdC5BIpyrK/DbF6ey2zeFAYMOfwZRWMebL1yL1l8WfcLE2Xt089jmQSC2L0FRyZcLvoiv0i6zFK2EFHTO0Sqvc1EnekZBtZdm7iAGwI6OHhffdsTluKrie1J8XL2tLgsP8LWQefioqHtNJ3S7I2V5KHdMdQLW2ZxscQOCq+yihZlP3IYQt9YPz9SRI3vou8n/iWOOtBWpRpS+JivCuCateVMd0HIPCyh0BqzaVTAmo9OvesDMpBS3pH7gGBAmYfdYu2ktD8lHuGzjKAyQgHRje7mZ7q5N96bf7vR6s9SXatSTnSBt0TAP+0dMEXrW4Q+RmS8CaYf1CMccIAKQ/GR8Nr7ZOLJFlbtZ0AF0yRYz2Qy7jQy/DNxzxpkv3d1awchrkuYwpmE1nnQ7YwH329mWAdN2EOh/XMP5v93m18u4QiqPzGgo3OvKtx8dbmqYws+Q7umCG/4rjxqWNYGRokDuebGU3Cy4L+1VMjbjZ63ocAk2flhTS44K2BI+JWL5eDwxRr7du62xqMTvZoTxm4SUQIQIdz5mp70lwwZnTw452riLLk+v+T1uacldo18he8I2OHJVkJSPgtwCtNi6NbNcKjnrQEbvG0I83wBoGXM6+apiN4DeU6HdMTwri9Z84k5P75sLcyetKIcIFX1BaPceefMXDzDiMUTdhmrT1Y9A4BtSYhYpgXToX+gCHTQBJw==
X-Forefront-Antispam-Report: CIP:69.171.232.181;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:69-171-232-181.mail-mxout.facebook.com;PTR:69-171-232-181.mail-mxout.facebook.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199018)(36840700001)(46966006)(40470700004)(8936002)(5660300002)(36860700001)(82310400005)(356005)(33570700077)(40480700001)(86362001)(40460700003)(15650500001)(82740400003)(7596003)(2906002)(36756003)(7636003)(47076005)(4326008)(336012)(478600001)(83380400001)(6666004)(107886003)(6266002)(41300700001)(2616005)(186003)(1076003)(26005)(42186006)(316002)(8676002)(70206006);DIR:OUT;SFP:1501;
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 19:24:35.5821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15380b66-3a80-444c-de0c-08db2978bd9a
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=8ae927fe-1255-47a7-a2af-5f3a069daaa2;Ip=[69.171.232.181];Helo=[69-171-232-181.mail-mxout.facebook.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT026.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4181
X-Proofpoint-GUID: TQcum_RckEPURSNrCG0R88KVwWM72s6A
X-Proofpoint-ORIG-GUID: TQcum_RckEPURSNrCG0R88KVwWM72s6A
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

Introduce bpf_link__update_map(), which allows to atomically update
underlying struct_ops implementation for given struct_ops BPF link

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 tools/lib/bpf/libbpf.c   | 40 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  1 +
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 42 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 56a60ab2ca8f..f84d68c049e3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11639,6 +11639,11 @@ struct bpf_link *bpf_map__attach_struct_ops(cons=
t struct bpf_map *map)
=20
 	/* kern_vdata should be prepared during the loading phase. */
 	err =3D bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0)=
;
+	/* It can be EBUSY if the map has been used to create or
+	 * update a link before.  We don't allow updating the value of
+	 * a struct_ops once it is set.  That ensures that the value
+	 * never changed.  So, it is safe to skip EBUSY.
+	 */
 	if (err && err !=3D -EBUSY) {
 		free(link);
 		return libbpf_err_ptr(err);
@@ -11665,6 +11670,41 @@ struct bpf_link *bpf_map__attach_struct_ops(cons=
t struct bpf_map *map)
 	return &link->link;
 }
=20
+/*
+ * Swap the back struct_ops of a link with a new struct_ops map.
+ */
+int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *ma=
p)
+{
+	struct bpf_link_struct_ops *st_ops_link;
+	__u32 zero =3D 0;
+	int err;
+
+	if (!bpf_map__is_struct_ops(map) || map->fd < 0)
+		return -EINVAL;
+
+	st_ops_link =3D container_of(link, struct bpf_link_struct_ops, link);
+	/* Ensure the type of a link is correct */
+	if (st_ops_link->map_fd < 0)
+		return -EINVAL;
+
+	err =3D bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0)=
;
+	/* It can be EBUSY if the map has been used to create or
+	 * update a link before.  We don't allow updating the value of
+	 * a struct_ops once it is set.  That ensures that the value
+	 * never changed.  So, it is safe to skip EBUSY.
+	 */
+	if (err && err !=3D -EBUSY)
+		return err;
+
+	err =3D bpf_link_update(link->fd, map->fd, NULL);
+	if (err < 0)
+		return err;
+
+	st_ops_link->map_fd =3D map->fd;
+
+	return 0;
+}
+
 typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct perf_ev=
ent_header *hdr,
 							  void *private_data);
=20
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index db4992a036f8..1615e55e2e79 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -719,6 +719,7 @@ bpf_program__attach_freplace(const struct bpf_program=
 *prog,
 struct bpf_map;
=20
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_=
map *map);
+LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct =
bpf_map *map);
=20
 struct bpf_iter_attach_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 50dde1f6521e..a5aa3a383d69 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -386,6 +386,7 @@ LIBBPF_1.1.0 {
 LIBBPF_1.2.0 {
 	global:
 		bpf_btf_get_info_by_fd;
+		bpf_link__update_map;
 		bpf_link_get_info_by_fd;
 		bpf_map_get_info_by_fd;
 		bpf_prog_get_info_by_fd;
--=20
2.34.1

