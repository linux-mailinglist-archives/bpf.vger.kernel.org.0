Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95C06C2207
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 20:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjCTT5O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 15:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCTT5M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 15:57:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272DB24BF3
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:57:08 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KH743g008139
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:57:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=1FqxCMUrgUat4OB/sYZfAflSMoMxq5LRpdm3BCF4Mrw=;
 b=KwuN4FhIhF1zipBw6hT2dumGtezq1iOQ4AxXV5OxrR3Khn7DxjM3+sfoAY+9MK53U12s
 qfL2HLMLAqInDRdfRP1Z9qXl96LBeUyt8jOMuswqEB3riLBgkk6QqZbsq6NfjPPbqFoi
 p4yahyOBrClow4dqH2ARKDGLSbiCTenOl5jWMZ5qedhB+HNFveWO5PXJkCftHQTPmcBs
 IqFNMxUJqGgV9TzsxJLvypEFCeZg0JND2tU764mjG5bPBL9XlnwNKLxoR+69/wf1Md54
 RNBlVdtQv2Qpx6cm+YeEbDTyEsLfjLUdYduZnNlpYkehnb8YCneqKJdP4/66Of7QSYNG 0g== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pdae1kuy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:57:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhlZGyblJ3sAjjPcxq3lMXLUrkW8Mqg6Z1gmVcVw+ckhIBbm0Y+klYeVvTXo0bWN7X8VkYA9yJnOm5ck2IRDu/wpOA8dke8BB27HncL6sp+Bhn8kABOhZRsKLxdJOZokSrOuSsVo5SDso98P6VcLRcKxEJcMxyH5jXWWE35GBEyQgiRLsZSURoda74aUK5mxCPnB8ik57MQNxB0M1UnKO4TJq3iV1pJzQG+wsMfK8uJvpMRWjQbP07SnV6tkfYSMW3tvI32AfJ/KdsxDkzeEF21uRJ+7f79aNeOK4M+/zrP5zKOUvhr5yHkow7fcVwbla0OyRJLhqCHHZjXNrRAFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FqxCMUrgUat4OB/sYZfAflSMoMxq5LRpdm3BCF4Mrw=;
 b=Ne7IDNox6NUvM1Lf/uzENhcbJGaT0Q7F5+hWeJkB6C82omxqL2nae59c2Fl4Bi79VmQ2xZo1TnvjB5Mv/lWs+vInJ0FyBdTF75QuSP1srGT9HKBzf36BqMxCR+y42wBvXCYB4Fi1lMQV24JGTQ9J37P0JpBpTMIaJ4QjExsYSyKob2D6ydB6SKGLNZPwvbD3si9KsxZE/4fwtLVosVV+fgxUAjn+XgFrM/bcKp4wFTtDsXC941m0g7/6KWiS2/wiB0khiN+lkKNF3Kdb4ef3uXY+kklLkf1zuVtrTffM0nLl8+l4qBK2sqkT6piwVWqsgdp8nEGgSJCy4oZsxnwNRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 69.171.232.181) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=meta.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject header.from=meta.com;
 dkim=none (message not signed); arc=none
Received: from BN8PR07CA0035.namprd07.prod.outlook.com (2603:10b6:408:ac::48)
 by MN6PR15MB6050.namprd15.prod.outlook.com (2603:10b6:208:475::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Mon, 20 Mar
 2023 19:57:05 +0000
Received: from BN8NAM12FT063.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::e1) by BN8PR07CA0035.outlook.office365.com
 (2603:10b6:408:ac::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 19:57:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 69.171.232.181)
 smtp.mailfrom=meta.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=meta.com;
Received-SPF: Fail (protection.outlook.com: domain of meta.com does not
 designate 69.171.232.181 as permitted sender)
 receiver=protection.outlook.com; client-ip=69.171.232.181;
 helo=69-171-232-181.mail-mxout.facebook.com;
Received: from 69-171-232-181.mail-mxout.facebook.com (69.171.232.181) by
 BN8NAM12FT063.mail.protection.outlook.com (10.13.182.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.11 via Frontend Transport; Mon, 20 Mar 2023 19:57:05 +0000
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 7D9027D4C180; Mon, 20 Mar 2023 12:56:46 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v9 6/8] libbpf: Update a bpf_link with another struct_ops.
Date:   Mon, 20 Mar 2023 12:56:42 -0700
Message-Id: <20230320195644.1953096-7-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320195644.1953096-1-kuifeng@meta.com>
References: <20230320195644.1953096-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM12FT063:EE_|MN6PR15MB6050:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 84dbc7f4-e3be-445b-49fe-08db297d47dc
X-ETR:  Bypass spam filtering
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wv32a+BQi6crfgIGdRO5pYVzdDJH4IGomnMJ6V5OfHv6tu+A3k8L6xbq7R/krKHS8TdNwzgivV9ntg0NCRYdBFDoOf5EpPI0FGTnCg6GPhTE1COx265/GACf/jEcLnKZUbNZTLmHdrD+rhZsSoSmgDI8+5A0VMdBcSbW7z1Qzl3fsDHlj/iCajDqPk75ca/IGBftAFB384iQQ/wnkJ7ANjDjfo7X+VFJo0zPdRrKMTpqFlDgb64NC4Iwxkt1hUuGPhpsdejP5rbUG3Q7NCkQOEkq84kZqoQYaqqwZJ38nFZ8pXF2GAlRca7lh8zM4WKH1neaQdS4VPLmydbeHdNE7f9GdkTVXLmk7dM4iJVYXKqpROBbE03I1XIFSYpIkzKqnWX3Pl3IjBdwuAREuG7sVg1APFT6tgqGlpi3twzr2wOBry+DpTVf969RZHGHKUaufS6jI15VFgt2J/HxmYj0wL0TNEpg7AU8xJ2HWBo9ufRznH6UDy5ADWdHzCNuX/lAFl1her8WUUSu/VXEEGtX54CfVn2D7D01BOozfdc50rnoeyswr5/IT+BI9ziuyjhcYpKACxzZnMAO78SQbXTrrXJm7BhPxYDIuNx+qjBEVxbFdoLPPl5bf9BLgoFJIFnGsv9SKQAsfSJ28HrlQhzq5WZ/tcB6VVe0l7zUNCv4Ri5J35NIZs9TS8IRwCeNeWj9xZH8MSOiy0ENp+T3RKSrQw==
X-Forefront-Antispam-Report: CIP:69.171.232.181;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:69-171-232-181.mail-mxout.facebook.com;PTR:69-171-232-181.mail-mxout.facebook.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199018)(36840700001)(46966006)(40470700004)(86362001)(33570700077)(40460700003)(82310400005)(40480700001)(36756003)(316002)(42186006)(83380400001)(4326008)(8676002)(478600001)(6266002)(26005)(107886003)(6666004)(2616005)(336012)(1076003)(47076005)(186003)(70206006)(356005)(5660300002)(41300700001)(82740400003)(7636003)(36860700001)(8936002)(2906002)(7596003)(15650500001);DIR:OUT;SFP:1501;
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 19:57:05.5858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84dbc7f4-e3be-445b-49fe-08db297d47dc
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=8ae927fe-1255-47a7-a2af-5f3a069daaa2;Ip=[69.171.232.181];Helo=[69-171-232-181.mail-mxout.facebook.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN8NAM12FT063.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB6050
X-Proofpoint-GUID: xi3wTEE4EqBzwv0_cmO7uyly764XBnTw
X-Proofpoint-ORIG-GUID: xi3wTEE4EqBzwv0_cmO7uyly764XBnTw
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

