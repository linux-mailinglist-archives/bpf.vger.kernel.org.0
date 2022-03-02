Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60874C9B65
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 03:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236789AbiCBCtk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 21:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiCBCtj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 21:49:39 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87E5AA034
        for <bpf@vger.kernel.org>; Tue,  1 Mar 2022 18:48:57 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 2221cmCh017818
        for <bpf@vger.kernel.org>; Tue, 1 Mar 2022 18:48:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=QTXK9CEGhkKY5dXe8uJ0KKxvAZc4A3LXaGiCZuV+a0s=;
 b=qbhm8v4RdvN+c9lGcR5q9OGtdZn5wl/D0lGKKPZEJeMeB02cnJQPEa2Eavk5R7eC+b9z
 zo7xlGb74bxTkxiKZFqixP8yC7vYpLIavzexAcH5P4+dH9ijHEFnmbjpvnfjIEYS+gen
 vCkh/K0u/iDOTiQxc92f+XgHbbVy7THxGZU= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by m0089730.ppops.net (PPS) with ESMTPS id 3ehn5wmt5a-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Mar 2022 18:48:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvY/kRqLlll6o2V//sFlmtSUPz75QyAQyXkVJ4txo4mDHGZdU7RiUt5kF/hw5oUrIHQk4VDH+16dwcECUkZEtzsnj8v7q7yuB1zy/agM42+hsD/d7ZyLpsY15ZtLnWUn7+7DkSnaOp6eItx2vIa+vB6QFAeLbnGIsTCzvuXT8UULXGLDiVV93rLSDZryiFKwzVpUokCzE2zbPA/FLBejHVXhHSyUORzO3hpIctzibWtBT2F9vBZZQisGUFYisEXFbt1iZOSEzktsftg5eJiAXBgBmWUig+yAEUA2vDXyQoLEkZ3e9tSCLWp+lwQTH/Luh5IHpPucnfKZM8/6NpYokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTXK9CEGhkKY5dXe8uJ0KKxvAZc4A3LXaGiCZuV+a0s=;
 b=JXASZcGFqWZvq++/hud7OVsLNrDzr+/L6Hq1QyM02eT360x8wFlCXxrwEAUuWBThsqj6mkzDN25vXSLV6V91/IGKjItD4G2012OHX5zfjRdAIeHEzkGsBu1kCZF07tEQqCv3Aoe7fdqiifd+1xg4kYcxxW/W0afp4+pvEJOGfH/vzOBYuZBPMUiMM/ogVhK1q641UbaKHkKc6bFy+GrNzf3SlH7/2YnKemGzCR3O1DzX+gaoj3RTL24ZOIil26Zk4KHIYO3dfWx0VHp5S9c9SyxmTI47iC8BDQ6uIc/Kmfg+B1NSmJ/rclXFhzQj0amqqLRgUbQRizXQYLhKNwSPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MW4PR15MB4441.namprd15.prod.outlook.com (2603:10b6:303:102::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 02:48:52 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%5]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 02:48:52 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next 1/4] libbpf: expose map elf section name
Thread-Topic: [PATCH bpf-next 1/4] libbpf: expose map elf section name
Thread-Index: AQHYLeANyepTcOz9fEOe9yiUzCe+vQ==
Date:   Wed, 2 Mar 2022 02:48:52 +0000
Message-ID: <c298c45f77ba2fc12fb54da5ea73b5a4dfbfe763.1646188795.git.delyank@fb.com>
References: <cover.1646188795.git.delyank@fb.com>
In-Reply-To: <cover.1646188795.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bb1cb98-be90-4aad-dfc9-08d9fbf72f9c
x-ms-traffictypediagnostic: MW4PR15MB4441:EE_
x-microsoft-antispam-prvs: <MW4PR15MB444117AF51E792A4E5857AA8C1039@MW4PR15MB4441.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: swtBpgGMhn3x0FI+dDGdipwaRf3Pbv5QJVjj3SLbITp1XiOtnZTjJxW2J4DazOC0sr+EI9K3ASyDPP25Do4+ETaaUixe5hzsqX9I4Xq2nKf1idX6FpdXNpv1Z35BpDvDCIW2/MM87alrWsTLOm1CBzBrFKE1WIGDOa0mJprEiHmFmb3i3UniGyWEWwoIIX4/moXuKJAAcZmfH2M/Ji2ETUzOfLLdNTLDvmIRsmjcgpsnHbJfAEk70iaZiZud7LfkakgS2HbDwLbT2LbfIsgNQwwOp/fwbygCPLRMJwj/M+PLpBGyI3X/JkNaRe22pPetHC3+rKFBhz2jEg4k7J0o5/gdmC1DpuLHB1VRmsrkgFDGXk8jBTQWLHSbVRE8dFnsc4l7cN9gNDPt0WGE/9pEwhZ8XdGQW8OyFVkMXbR2fqhtG3jQTD0D1l8c0x2SPj4gRAwDzKzL5/hoH0WE5f+hvGHK9a28TAhPgpno4hhF1XGVsrOY39lVx+2lqShie0YCrygMMUkQ2xTRqw+Iw5vY1vwCDL4k2SNZi+to3nC13GYbrssiiR6mQPD3XJ8TDEMyrsH1JibFqSRjQX+5y0kfKVpjNoogY3s1Uo+QNVajlefvuj1NFnkgLMRZNQsjGWhn0NnV3Gu8Tot5kB7X2JRHhWD7LAlqUlkDDQ7YaaR9MfdYpCBc7ydv1WjBBRB6otMcepm8IpZLizBbx9p6gSfftw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38100700002)(83380400001)(110136005)(122000001)(86362001)(6512007)(6506007)(66476007)(186003)(38070700005)(91956017)(36756003)(2616005)(66946007)(76116006)(66446008)(66556008)(64756008)(2906002)(8936002)(5660300002)(71200400001)(508600001)(8676002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d1TP86rD3PwCp1HaIl0IKnGi9Z833NembHKl/TkE/rT8FUo3Msiyty+A5/?=
 =?iso-8859-1?Q?5NDMZ5YtO9BnsdWXp29mHCOM8pGgT1qBZwFKYwXQ23xrYH61pyeC+bXwty?=
 =?iso-8859-1?Q?7nY4Q5uSzT+hNVAnl8gnR3hpWaUmzjEsoDG0kPTcD5iaExiOh/1n40ia4i?=
 =?iso-8859-1?Q?AVy/zkivHTt2aBBGNg662Vi9xezT7GeUBZyZTBMJmbcQrUTphde9xWESH+?=
 =?iso-8859-1?Q?6X/OBUJGnIh8ov4lpFc3ivwMy0KTPCUuCmIEiVB9e9pJ8nyWFBAxqy2WkD?=
 =?iso-8859-1?Q?JNKs4JTXQDhRhpc57qA4BznKMnxEIbaER/BeWtgcEptm6Ua1Lej5Uz/1x6?=
 =?iso-8859-1?Q?2ZN4wqcHqK9D4q/jOh8SzOJrn91Bcr6kq8MbJNrk3YbYVKq7S+n3AflyIx?=
 =?iso-8859-1?Q?Ni5+BsxEmIYyMHEC8KzAKJc1SrvIaQPtOwqBIFCc7UwIyh9t3fUYtMywAh?=
 =?iso-8859-1?Q?8TZ/ENRRjif3KT8mMo83OP/LeIQc+qZxqg/k+g6PhYI31Suwfb7WwAaFyf?=
 =?iso-8859-1?Q?Q3Oib04ZVCLaoscUHD/AQeVXSvteCTvdzqFlpu684b9US4Pqz6eXBt7nmc?=
 =?iso-8859-1?Q?/t9KW7inqg5SeI6sddiI3rJGrNG5GBWnJ11jtaUy9GuE21Lo1cmc5YYSQd?=
 =?iso-8859-1?Q?t7+CE2kJ08OBIV7/scXQkVvvkKEdDvNW9VIm3oRvzLJceI/YZnDVPKsDgX?=
 =?iso-8859-1?Q?UBvwAm5e2PJidWZdRZ4unq5PVclDLfgqAQjYkcJ9YglYIBY5Fb9Tp5bT+M?=
 =?iso-8859-1?Q?g//NhSk9VG8M1iFO3E2XcJo4kQGkRgmoCoVgwppNk71XIYlRO0CVFbkYvP?=
 =?iso-8859-1?Q?HSXptMR3kaQ/wcZWFEj4aXz69rI1UUNvvGInrMRQz+dj9OWfRKEdlLz47N?=
 =?iso-8859-1?Q?sZiAcT1qnzXuDaKs4jtQPWe2OihR061XPMRzOObpQDn0vPi6N3cd+KRT4Q?=
 =?iso-8859-1?Q?y9DMLOq3gy3WjutqzFEcyLZM0eM6/nYsAcq3+ui8qhMxj7lxUV7OjoPREH?=
 =?iso-8859-1?Q?UufEXttwmS+W6uAfw5aUnHgWEbCvGAnM7ZJWZd+QcAX4uYAEH2pOMGkZ08?=
 =?iso-8859-1?Q?xcnSLgDrVtgMl+VWiEJiwfgXlLIh0aYyhdbvyG/jLoEaDsabDoGL4gR6dl?=
 =?iso-8859-1?Q?vb8RToKMwY0k2mih+J/qw+CrOzkAMNaBWmiinCkp3g+CvF1yyYNv/wtxXo?=
 =?iso-8859-1?Q?axLTMIxL5zNFqaogTAomePKgJAE9gvmeBn/qQZW2B+WI/cJbigaH+rGHsP?=
 =?iso-8859-1?Q?4ywqPfGD6sNllfWqVppHaQXgqjrB8GEl0SgiPTaKseo3fsNMqcXyAWgP2P?=
 =?iso-8859-1?Q?OoAn/6fsKl/nlhDyhUlkVQJxZt/uW854g8Ms5FkpEzkyDIqSyupp3lxEki?=
 =?iso-8859-1?Q?EABUpmFcMFKG7dk/f3XG3T+MtNbH9A2CJrvz1+ZlnxA8qxxGQqWdWtAOa3?=
 =?iso-8859-1?Q?b79MPp6ojzku7t5crMNA9ZbHI0Wg6o1CSY3dTu3IRsNjmXFZoSJeY90bk/?=
 =?iso-8859-1?Q?9A6s3w6ORbUbqlbGP/I1WGDYAdRkUdvojSiHNQg1t7X1gtqketjVwL88CM?=
 =?iso-8859-1?Q?HAINzIR3OURnkPttNx2pQWrTfa1QbfvA7zLEdWu15ZS84wWp8Cjsz13ltn?=
 =?iso-8859-1?Q?U8eaW5AUb9fCh4Va8J9Da/egR5sd4ND6TvFZS76nlLe4DzZTuNvlqUBA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb1cb98-be90-4aad-dfc9-08d9fbf72f9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 02:48:52.3002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jv0vAkJtwLW81d9AEHuDVcfrDCRkQbRKlh7jBs2IQBEmlJ7CQJSmAesPX1lI4Pgb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4441
X-Proofpoint-GUID: wALwC8apmKufgpZb0Daob1d-t8Av_rKX
X-Proofpoint-ORIG-GUID: wALwC8apmKufgpZb0Daob1d-t8Av_rKX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_01,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 mlxlogscore=910 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020010
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When generating subskeletons, bpftool needs to know the elf section
name, as that's the stable identifier that will survive into the final
linked bpf_object.

This patch adds bpf_map__section_name in symmetry with
bpf_program__section_name.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/lib/bpf/libbpf.c         | 8 ++++++++
 tools/lib/bpf/libbpf.h         | 2 ++
 tools/lib/bpf/libbpf.map       | 5 +++++
 tools/lib/bpf/libbpf_version.h | 2 +-
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index be6480e260c4..d20ae8f225ee 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9180,6 +9180,14 @@ const char *bpf_map__name(const struct bpf_map *map)
 	return map->name;
 }
=20
+const char *bpf_map__section_name(const struct bpf_map *map)
+{
+	if (!map)
+		return NULL;
+
+	return map->real_name;
+}
+
 enum bpf_map_type bpf_map__type(const struct bpf_map *map)
 {
 	return map->def.type;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index c8d8daad212e..7b66794f1c0a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -741,6 +741,8 @@ LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 8, "use appropria=
te getters or setters ins
 const struct bpf_map_def *bpf_map__def(const struct bpf_map *map);
 /* get map name */
 LIBBPF_API const char *bpf_map__name(const struct bpf_map *map);
+/* get map ELF section name */
+LIBBPF_API const char *bpf_map__section_name(const struct bpf_map *map);
 /* get/set map type */
 LIBBPF_API enum bpf_map_type bpf_map__type(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_type(struct bpf_map *map, enum bpf_map_type ty=
pe);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 47e70c9058d9..5c85d297d955 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -439,3 +439,8 @@ LIBBPF_0.7.0 {
 		libbpf_probe_bpf_prog_type;
 		libbpf_set_memlock_rlim_max;
 } LIBBPF_0.6.0;
+
+LIBBPF_0.8.0 {
+	global:
+    bpf_map__section_name;
+} LIBBPF_0.7.0;
diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.=
h
index 0fefefc3500b..61f2039404b6 100644
--- a/tools/lib/bpf/libbpf_version.h
+++ b/tools/lib/bpf/libbpf_version.h
@@ -4,6 +4,6 @@
 #define __LIBBPF_VERSION_H
=20
 #define LIBBPF_MAJOR_VERSION 0
-#define LIBBPF_MINOR_VERSION 7
+#define LIBBPF_MINOR_VERSION 8
=20
 #endif /* __LIBBPF_VERSION_H */
--=20
2.34.1
