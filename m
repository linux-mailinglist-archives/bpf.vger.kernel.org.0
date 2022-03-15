Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CD74DA514
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 23:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiCOWQd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 18:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240840AbiCOWQc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 18:16:32 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F34D5577B
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:15:19 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FLfkuD009029
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:15:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=/DnVhiE3vtRvuA3Jusro+q582zGMKeebATYn/qcZxSM=;
 b=RlH09Ds4O8ddEqnUo5pYJCtTzk+gE4piT3oVPFjmx9BT50A/TJYWweseYA/R+B+PiPJX
 usKfvLsEPO9TRMaixz+d+fndzUeYnd5GWxdXM73qng6Ia+X7i8kqJWnhik3Sqzhv2HM0
 N4pU8xT1yrijVh8ar/30RdWZwWpsrS1XRMU= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eu2brghmn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:15:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZFB/d/ryOgIEoRzSsfZpKucy77ikUAh2Etc84BYPRPTncGxSWuNSP2RRAgil7oUnV27d+Sy4NDMrVkdCpmJlk7ltjqZ7UOAWuQzyci5K/gjNa/vx7CD6XSFkm7p4ozegShrYp6moOMUKHl9iSXh0qDTkUXbgYXkctVYYAc2mOwtntP55UldCLpEe7wHZ4FnnfpyflLlO9q0NhZHniigXwoJ5RcFruJW+9qB8R9EbLFMpPLWnkwzbS6g3fy45dTVGbQsUcIdfaZ1zF8M26P95oW70m1safw6QjwoJGeczb2eMlnV6e7xXjUvyVRt+fN/xtckC3+9zHBnZc2c1r18cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DnVhiE3vtRvuA3Jusro+q582zGMKeebATYn/qcZxSM=;
 b=U60ieu7AIbr2v0pJOwKCjpHjAW5yLzw11bh7qy+OrxaU2mYA3EDMvST2L6aQzHtpM0blUcjQCzAD2Em6dsACbZ8OVCia82qcQnmN/XrSLU1pa0mSw+zhPyd1hYNwc4p7i8hYaXrsh13T0ZEPkNG6VlVipB63TknsQ9hNcQm0/+V2sYKB17dFSuO0u4I/l4BLy+RWBygHmAIWCyKXnydBigrFg/L6OUANlCmO8bgRPOX8bja++VkG/Gz1BW+Rbs+VCl7Z1ZqzPGhl1xRkZNEYSQT/eYWMVbhY+Hu+48lWIJhsClukV87KcLjuOI4sP160d18w73vgSgDFN8XDUOj8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BYAPR15MB2695.namprd15.prod.outlook.com (2603:10b6:a03:150::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Tue, 15 Mar
 2022 22:15:13 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 22:15:13 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v3 3/5] libbpf: add subskeleton scaffolding
Thread-Topic: [PATCH bpf-next v3 3/5] libbpf: add subskeleton scaffolding
Thread-Index: AQHYOLojqAQIwWhdUEimrWTBFQsXiw==
Date:   Tue, 15 Mar 2022 22:15:12 +0000
Message-ID: <efe839eb138d33cb7c6c9971ef79ce12d439753e.1647382072.git.delyank@fb.com>
References: <cover.1647382072.git.delyank@fb.com>
In-Reply-To: <cover.1647382072.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a47d0c7-e480-4f9b-31bc-08da06d14716
x-ms-traffictypediagnostic: BYAPR15MB2695:EE_
x-microsoft-antispam-prvs: <BYAPR15MB26950DF422CFD1D50F30E58AC1109@BYAPR15MB2695.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uPtNibVXDplg1bORNhlrI796YEE79HS+BVs/6igUln4SNl/u6kfOgxvHYbyatOOWHpUo0stwqlUoFe0MyhA9BB4a2BFMEM5OWZKx6JYCTStjThoz6Kh2Sx69G/hSVHHB3Kg1XmYQFBHfAYYPlUHQju8G890mgIiEH2T59AW9usgrfh1DFDka861X+UAkKyawk4pTP2leBGEBG0jxxISKUS4HWAdhh6sqw//jt/nVxOopD3bBKcFLVDSis5ymYeGCRcZUR67pmiOL7dviJ+0V6uaPWgofDEOigqbnjMFQUoHf32x5LhszQpnu/0qNES+DnIUIUGFWOrhuVtNzuzeocIxee/T4ycNuDej6Ix0PkSqJ2bzYEm9ooYqoXdrovl75+zyGVzrEomtrinew9juRMefhdr7Rd5IXemPn00DJwooawnwu/+5VZbKDf81UkBtsebZsozHLjPx27uxCtDAlobO+vn+y76O7b9jqwTY+pyrkovpq0d10rlLhnYfk8by7djDwN3RUK/IXq1Yj7iBx8gtnO9HuhRx4waHbu5mO3sjNcoYF+9OHH0fsp6F5ZBvkYl8KcTZgxUeAc5RIjjaROzocmo6dIv3Hhgzaa6pPz0mDovxIlq7nBG88Z54EQFDIiEMl4oIA53Jrs9Am7ej3U1jcc64wE8KZt60ju/Uw+F48hS4zp4zCFF2LMtPKwaWpx235v/Cmwvj+be5OB0eTIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(66946007)(6512007)(6506007)(2616005)(64756008)(38100700002)(8676002)(76116006)(66556008)(91956017)(122000001)(66476007)(2906002)(186003)(83380400001)(316002)(110136005)(6486002)(38070700005)(71200400001)(508600001)(86362001)(36756003)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wj93ecyLo0F0h15varjfxuuh2Ls4Ke3ktIi61EkOfZezOwkp4YPmzPL/+G?=
 =?iso-8859-1?Q?F0FASRX7/M5Q3M7LMTzC5nsUWMcatuTbDjI7lejsLGK1LdnfdVIJY4kP6V?=
 =?iso-8859-1?Q?tewgZqFliuYf18Kk8CoN4qWd4n67Y+BVCjCxbwhERg5ZG2PSraS/EpSb85?=
 =?iso-8859-1?Q?YkJw59czRELrAYoWaaZRMgxN/BlAELzs0rBqhPJnyZ6glRbBGT/mqkdiQI?=
 =?iso-8859-1?Q?Kq97dEcSs44vXdMVixsMZ1ttqQ/1uUgD4hAOMUooSw3OhlI0IyT2VAazqb?=
 =?iso-8859-1?Q?l46ssrkOHJwAlls14kauWMElbYO4YFtEhKsFR7htnMb+COJdiTNUwv8umm?=
 =?iso-8859-1?Q?3N7VQUbwYj01kB/a5UHmo50qYgatmFWhyowY+EWvuRxI6ifvHFmVFiOlX7?=
 =?iso-8859-1?Q?oUAR9CN+utnIfErauOxDxAjsp9BCfnhvXUNGreClxbf/xi5HovtpVGGe9i?=
 =?iso-8859-1?Q?GlZEev8Ns5mUWadBjaULO9oO7JRdnRObyb9g25qSc0ET8+DeBFjrInB5bU?=
 =?iso-8859-1?Q?Sq6P5qMCQhLXLGGlMU9i0JyvaabNJIT3aMsjGqRpNrigmYdOv9ftDWJUE+?=
 =?iso-8859-1?Q?ZZcaaqiemrHsEGCxEOqtGO7Yl31L4vrvkzj/pATqnbd5sHLJEacKzeKuYv?=
 =?iso-8859-1?Q?cDM4t3g+BX1A0+eBAujoJ0AuYmaCaEVmaNvWu0K+PaCqtjYwlQEYYoQ4NB?=
 =?iso-8859-1?Q?YYvnxw2c1z/uaGFSvE7k2DkShfn6cLf8z0He8lU6lxJmyT27rmlxMEYjxb?=
 =?iso-8859-1?Q?CvlQOTz8wPOJX+okS9tKH5Vv+f3wiuUL9im7ZwZmx0i6ivCQeKDg1Hcj77?=
 =?iso-8859-1?Q?CHkzoB26PnlUd4YW42kkiaCrTUpUqJ3ej+G7RJDUDZAO0wmS0lmVOBv/Uj?=
 =?iso-8859-1?Q?0TZOw+Oqw9vyovN8/+pgIZSbbXPWEJtBko+i4LMiKd8yGHk3VcDaOKsL65?=
 =?iso-8859-1?Q?e/K4F0JpnYg0lzriiRlyzjC+HI7u34qitDSG44sFl1b3AujdiHOc6g4q6L?=
 =?iso-8859-1?Q?XIrz45eNtl7jqVPoZXWGUW5adkIbKcyby/lizeIj5BNOAJPwoPrf93XGxT?=
 =?iso-8859-1?Q?2yBh1P8S/hdUaAIDlnoYMoAFLn+lnDZJT6pG86BaN+CtQ9+QtErfAXad4A?=
 =?iso-8859-1?Q?flYJKujpdFMRvp6rwp5xvQAWDUk5jQhi7lbucbv9R+Sd5eNtyHU8r6zESr?=
 =?iso-8859-1?Q?OF6ForISA8XRj4Hq98fsGyOgF54VxaAWeHgiUtXHSq7bin2zkt1ZmyRS9W?=
 =?iso-8859-1?Q?g7KOmxBQREaoabsNbLw0z8/rjbazXKFdZonefKgTLgjc6fu1Oazd8tXggk?=
 =?iso-8859-1?Q?NTYOailInZ0nzt9jD1Lpwh7tgsr8VC/xyAV0m1T6xHSxjCbqcF0FxSP+BX?=
 =?iso-8859-1?Q?3Xe9LlT3fP898SIB4JQYC7mYHLHk4DoCJoPyqf7oEUW9Rk717blnaiBozF?=
 =?iso-8859-1?Q?SXzwoFnhrV2XSfqdX4q5BHEXYBRROpcKR9UJI5qAXrcNXB6kWJE8rnVEBZ?=
 =?iso-8859-1?Q?CuD4qFFnW8+Tb2uWYsdpNS7Pv8KhnuZUT5UeDBTTS1k4hp8Wpd+wvbb5fL?=
 =?iso-8859-1?Q?1UYYlYQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a47d0c7-e480-4f9b-31bc-08da06d14716
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 22:15:12.1317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LvqAgbEvTgV6iio+05pPsjGX+LJljo7hwzBuNdylWfJr1Fo43XZS5uFdTtGcx6at
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2695
X-Proofpoint-GUID: cTcUTFj4F8oxTnSm1Dwylth2aMRRypYi
X-Proofpoint-ORIG-GUID: cTcUTFj4F8oxTnSm1Dwylth2aMRRypYi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_11,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In symmetry with bpf_object__open_skeleton(),
bpf_object__open_subskeleton() performs the actual walking and linking
of maps, progs, and globals described by bpf_*_skeleton objects.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/lib/bpf/libbpf.c   | 136 +++++++++++++++++++++++++++++++++------
 tools/lib/bpf/libbpf.h   |  29 +++++++++
 tools/lib/bpf/libbpf.map |   2 +
 3 files changed, 146 insertions(+), 21 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e98a8381aad8..dac905171aaf 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11812,6 +11812,49 @@ int libbpf_num_possible_cpus(void)
 	return tmp_cpus;
 }
=20
+static int populate_skeleton_maps(const struct bpf_object *obj,
+				  struct bpf_map_skeleton *maps,
+				  size_t map_cnt)
+{
+	int i;
+
+	for (i =3D 0; i < map_cnt; i++) {
+		struct bpf_map **map =3D maps[i].map;
+		const char *name =3D maps[i].name;
+		void **mmaped =3D maps[i].mmaped;
+
+		*map =3D bpf_object__find_map_by_name(obj, name);
+		if (!*map) {
+			pr_warn("failed to find skeleton map '%s'\n", name);
+			return -ESRCH;
+		}
+
+		/* externs shouldn't be pre-setup from user code */
+		if (mmaped && (*map)->libbpf_type !=3D LIBBPF_MAP_KCONFIG)
+			*mmaped =3D (*map)->mmaped;
+	}
+	return 0;
+}
+
+static int populate_skeleton_progs(const struct bpf_object *obj,
+				   struct bpf_prog_skeleton *progs,
+				   size_t prog_cnt)
+{
+	int i;
+
+	for (i =3D 0; i < prog_cnt; i++) {
+		struct bpf_program **prog =3D progs[i].prog;
+		const char *name =3D progs[i].name;
+
+		*prog =3D bpf_object__find_program_by_name(obj, name);
+		if (!*prog) {
+			pr_warn("failed to find skeleton program '%s'\n", name);
+			return -ESRCH;
+		}
+	}
+	return 0;
+}
+
 int bpf_object__open_skeleton(struct bpf_object_skeleton *s,
 			      const struct bpf_object_open_opts *opts)
 {
@@ -11819,7 +11862,7 @@ int bpf_object__open_skeleton(struct bpf_object_ske=
leton *s,
 		.object_name =3D s->name,
 	);
 	struct bpf_object *obj;
-	int i, err;
+	int err;
=20
 	/* Attempt to preserve opts->object_name, unless overriden by user
 	 * explicitly. Overwriting object name for skeletons is discouraged,
@@ -11842,37 +11885,88 @@ int bpf_object__open_skeleton(struct bpf_object_s=
keleton *s,
 	}
=20
 	*s->obj =3D obj;
+	err =3D populate_skeleton_maps(obj, s->maps, s->map_cnt);
+	if (err) {
+		pr_warn("failed to populate skeleton maps for '%s': %d\n", s->name, err)=
;
+		return libbpf_err(err);
+	}
=20
-	for (i =3D 0; i < s->map_cnt; i++) {
-		struct bpf_map **map =3D s->maps[i].map;
-		const char *name =3D s->maps[i].name;
-		void **mmaped =3D s->maps[i].mmaped;
+	err =3D populate_skeleton_progs(obj, s->progs, s->prog_cnt);
+	if (err) {
+		pr_warn("failed to populate skeleton progs for '%s': %d\n", s->name, err=
);
+		return libbpf_err(err);
+	}
=20
-		*map =3D bpf_object__find_map_by_name(obj, name);
-		if (!*map) {
-			pr_warn("failed to find skeleton map '%s'\n", name);
-			return libbpf_err(-ESRCH);
-		}
+	return 0;
+}
=20
-		/* externs shouldn't be pre-setup from user code */
-		if (mmaped && (*map)->libbpf_type !=3D LIBBPF_MAP_KCONFIG)
-			*mmaped =3D (*map)->mmaped;
+int bpf_object__open_subskeleton(struct bpf_object_subskeleton *s)
+{
+	int err, len, var_idx, i;
+	const char *var_name;
+	const struct bpf_map *map;
+	struct btf *btf;
+	__u32 map_type_id;
+	const struct btf_type *map_type, *var_type;
+	const struct bpf_var_skeleton *var_skel;
+	struct btf_var_secinfo *var;
+
+	if (!s->obj)
+		return libbpf_err(-EINVAL);
+
+	btf =3D bpf_object__btf(s->obj);
+	if (!btf)
+		return libbpf_err(-errno);
+
+	err =3D populate_skeleton_maps(s->obj, s->maps, s->map_cnt);
+	if (err) {
+		pr_warn("failed to populate subskeleton maps: %d\n", err);
+		return libbpf_err(err);
 	}
=20
-	for (i =3D 0; i < s->prog_cnt; i++) {
-		struct bpf_program **prog =3D s->progs[i].prog;
-		const char *name =3D s->progs[i].name;
+	err =3D populate_skeleton_progs(s->obj, s->progs, s->prog_cnt);
+	if (err) {
+		pr_warn("failed to populate subskeleton maps: %d\n", err);
+		return libbpf_err(err);
+	}
=20
-		*prog =3D bpf_object__find_program_by_name(obj, name);
-		if (!*prog) {
-			pr_warn("failed to find skeleton program '%s'\n", name);
-			return libbpf_err(-ESRCH);
+	for (var_idx =3D 0; var_idx < s->var_cnt; var_idx++) {
+		var_skel =3D &s->vars[var_idx];
+		map =3D *var_skel->map;
+		map_type_id =3D bpf_map__btf_value_type_id(map);
+		map_type =3D btf__type_by_id(btf, map_type_id);
+
+		if (!btf_is_datasec(map_type)) {
+			pr_warn("Type for map '%1$s' is not a datasec: %2$s",
+				bpf_map__name(map),
+				__btf_kind_str(btf_kind(map_type)));
+			return libbpf_err(-EINVAL);
 		}
-	}
=20
+		len =3D btf_vlen(map_type);
+		var =3D btf_var_secinfos(map_type);
+		for (i =3D 0; i < len; i++, var++) {
+			var_type =3D btf__type_by_id(btf, var->type);
+			var_name =3D btf__name_by_offset(btf, var_type->name_off);
+			if (strcmp(var_name, var_skel->name) =3D=3D 0) {
+				*var_skel->addr =3D map->mmaped + var->offset;
+				break;
+			}
+		}
+	}
 	return 0;
 }
=20
+void bpf_object__destroy_subskeleton(struct bpf_object_subskeleton *s)
+{
+	if (!s)
+		return;
+	free(s->maps);
+	free(s->progs);
+	free(s->vars);
+	free(s);
+}
+
 int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
 {
 	int i, err;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index c1b0c2ef14d8..1bff7647d797 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1289,6 +1289,35 @@ LIBBPF_API int bpf_object__attach_skeleton(struct bp=
f_object_skeleton *s);
 LIBBPF_API void bpf_object__detach_skeleton(struct bpf_object_skeleton *s)=
;
 LIBBPF_API void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s=
);
=20
+struct bpf_var_skeleton {
+	const char *name;
+	struct bpf_map **map;
+	void **addr;
+};
+
+struct bpf_object_subskeleton {
+	size_t sz; /* size of this struct, for forward/backward compatibility */
+
+	const struct bpf_object *obj;
+
+	int map_cnt;
+	int map_skel_sz; /* sizeof(struct bpf_map_skeleton) */
+	struct bpf_map_skeleton *maps;
+
+	int prog_cnt;
+	int prog_skel_sz; /* sizeof(struct bpf_prog_skeleton) */
+	struct bpf_prog_skeleton *progs;
+
+	int var_cnt;
+	int var_skel_sz; /* sizeof(struct bpf_var_skeleton) */
+	struct bpf_var_skeleton *vars;
+};
+
+LIBBPF_API int
+bpf_object__open_subskeleton(struct bpf_object_subskeleton *s);
+LIBBPF_API void
+bpf_object__destroy_subskeleton(struct bpf_object_subskeleton *s);
+
 struct gen_loader_opts {
 	size_t sz; /* size of this struct, for forward/backward compatiblity */
 	const char *data;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index df1b947792c8..087c77e520e1 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -442,6 +442,8 @@ LIBBPF_0.7.0 {
=20
 LIBBPF_0.8.0 {
 	global:
+		bpf_object__destroy_subskeleton;
+		bpf_object__open_subskeleton;
 		libbpf_register_prog_handler;
 		libbpf_unregister_prog_handler;
 } LIBBPF_0.7.0;
--=20
2.34.1
