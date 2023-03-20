Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F5F6C220D
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 20:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjCTT52 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 15:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCTT5W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 15:57:22 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B6F22126
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:57:14 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KH7Tir023560
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:57:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=250zDJIaOCI/0NSrmRzvQLYeEZCXgM1J8p6NoY5yvAo=;
 b=fBdW2MgNg8LoxF97kh3Mv087L57IVW2z02gXTYPjuSDk0qb/lKyUAesDo+lWiRCJ+Mwy
 bqAx/d6VnxbvbsAthkktWzMezo5n83cSDvzIxT5aYLDZaDY5u8ug2TXBbG7N9HfOdEaK
 KdAlprHDeAXLHh8QZqyHG+XUF/KTfkG99NmC7zWK2MUXN/i5slfc3cRZOvuYnZam2XK0
 QFuFVRqzQZAU48Duszo70DWWNDcAnmzG4NvP2uhxuWzGRM3YNN40rFnyP9ecLNedL1nr
 UMN/1d6FomM6nL8Vg4ErbjM2XYYh8buUtFm+bqhKEDUt3+TgVrgjJ3B3KtgJTeo/K84D Eg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pd8mrv0up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:57:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGbFXmWv9kDCf+Nj+iCDW+TFML+IFtu7isjtuDAollwR8RoK5WaOmZAuDGdB+YnhprJs9jB51C5GyRXPi7yGAGa9OpeVO2JMaQGKoqHeRrISUYGhvNJrdfVGTp6z6BSpVd+OVjcreOFwkvl891e8jG71Ujn366Jr8strtEcCAwjHVf3INzYUMlRTr8pSkgSIhhjxjSx3dI7PtCUHdJCjyfPKbW6ln3kFPBbPesAVU6X9j1ksNvKxEoG3KVwVct48JvcZ71LVw/M9o8rksPD597rpqZ4hyfzDNXGB1ImP7dqmOhurRCLsJYjrpk+wnZJ8L1rkdeRWb9lwPh5farku5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=250zDJIaOCI/0NSrmRzvQLYeEZCXgM1J8p6NoY5yvAo=;
 b=F5fS0FImP1QZz236R/o+pgX/tEDjO5HFQq9LP2Nl5AnE1X8Ywz3/X1Mfzbfh8jVJD812OOD/6kBWJ3plAdKmHcP8eV/H25JVsZ5i1/Fb/cux+OSN7VBK6vcbFi41+7Vsvq6jph9atfG3JIRqC5XwC3ahC7ro1nRvQERFKFw9QaQpnaLs4UdvN9FabObssFJFihwW7+A7MuR38GOaiIWPnskErtmxP+0gcfz48Ax63mjCI9HPfMiM8478idy8/R6NXe2ltEVAsT7EpOe6QpZA1I9sozXeLeopvXGMqh7oM+TCo2FFHSGPhg+/NockuKy+r5ngBCCLQdHy7zeOlTsejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 69.171.232.181) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=meta.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject header.from=meta.com;
 dkim=none (message not signed); arc=none
Received: from BN0PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:e8::20)
 by IA1PR15MB5394.namprd15.prod.outlook.com (2603:10b6:208:38a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 19:57:10 +0000
Received: from BN8NAM12FT113.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::7d) by BN0PR04CA0045.outlook.office365.com
 (2603:10b6:408:e8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 19:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 69.171.232.181)
 smtp.mailfrom=meta.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=meta.com;
Received-SPF: Fail (protection.outlook.com: domain of meta.com does not
 designate 69.171.232.181 as permitted sender)
 receiver=protection.outlook.com; client-ip=69.171.232.181;
 helo=69-171-232-181.mail-mxout.facebook.com;
Received: from 69-171-232-181.mail-mxout.facebook.com (69.171.232.181) by
 BN8NAM12FT113.mail.protection.outlook.com (10.13.183.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.2 via Frontend Transport; Mon, 20 Mar 2023 19:57:10 +0000
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id A63DF7D4C182; Mon, 20 Mar 2023 12:56:46 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v9 7/8] libbpf: Use .struct_ops.link section to indicate a struct_ops with a link.
Date:   Mon, 20 Mar 2023 12:56:43 -0700
Message-Id: <20230320195644.1953096-8-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320195644.1953096-1-kuifeng@meta.com>
References: <20230320195644.1953096-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM12FT113:EE_|IA1PR15MB5394:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7859305b-e767-4519-9f9c-08db297d4ad4
X-ETR:  Bypass spam filtering
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJufiE4lOeOZH5RCUrUHZAI3KkSB7JrbkP1T1c+fft6IkOkDB2tO9d0JBphjKvqUnY33HSNE6Pz/hHystCAKiLWwZ04FB//W+LqJQSsIKFdNHB2kFz4RY10R6d89R73skBtPG/3/NGzG1hgAOQ5jzySxoxoDTxx1gM7cm87yg2z29q7OjbHjUHKFYK579D5z+5KBGB5B/uwcodXw+jORJqHLAka3VOpl0BjozCEnYPdXR/5Yd2OeGYdQWJCOpHFJ4XJTQR0GoFcSNxT8sjpnesIpMKwx8ycDPHcCNU9pt57mmxmMmdClgI3Bt3+Ebl9El8snGwLDTkLAzYPxgqRAu4JlQXxWOe7y3i8yzi63nG5pqoWn9LRbQNz3IwajRVYG28YEtK6DWirdTFODEU9LDkeB+NON+crC3B6pEMOoGl/eXTKj/ZOmPuxzEqq5z+s0i/PG+YpXyCNB/r+m7AeFpzqsIt0HuAzb8fJY9JcqZgYv9IVZofDyOn3PEOhMptSBi70PE4ivPldnRfHJm/bz5zO7ue9MzTE1pMZK7ZIaYCYzgKNkX2fMjFT0qJ+r1h8jzhbIu7eDonbD1Xz/vrGSrboy/ckDUgh16ZsjmuRsN+JZVI18cMFnBBRoZ9nVVBk4GHWM4rUNlfj02t2A/x53zIuVJEU4h2xKp7nczTt6mdbK7no/rdW5xL+Ly9cjICBaeFos3z0qwYSeI8ML+f92BZynn0fwo5lE0x2+BembXG8=
X-Forefront-Antispam-Report: CIP:69.171.232.181;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:69-171-232-181.mail-mxout.facebook.com;PTR:69-171-232-181.mail-mxout.facebook.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199018)(40470700004)(46966006)(36840700001)(36756003)(8936002)(5660300002)(40480700001)(40460700003)(47076005)(83380400001)(2616005)(36860700001)(336012)(2906002)(478600001)(82310400005)(33570700077)(42186006)(316002)(86362001)(82740400003)(41300700001)(26005)(1076003)(7596003)(70206006)(4326008)(356005)(8676002)(6666004)(107886003)(6266002)(186003)(7636003)(142923001);DIR:OUT;SFP:1501;
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 19:57:10.5687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7859305b-e767-4519-9f9c-08db297d4ad4
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=8ae927fe-1255-47a7-a2af-5f3a069daaa2;Ip=[69.171.232.181];Helo=[69-171-232-181.mail-mxout.facebook.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN8NAM12FT113.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5394
X-Proofpoint-GUID: WlYMLDeuSKP-FOFE7I1_-0c9H6pe4Ut1
X-Proofpoint-ORIG-GUID: WlYMLDeuSKP-FOFE7I1_-0c9H6pe4Ut1
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

Flags a struct_ops is to back a bpf_link by putting it to the
".struct_ops.link" section.  Once it is flagged, the created
struct_ops can be used to create a bpf_link or update a bpf_link that
has been backed by another struct_ops.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 60 +++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f84d68c049e3..d801ab3a46d8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -468,6 +468,7 @@ struct bpf_struct_ops {
 #define KCONFIG_SEC ".kconfig"
 #define KSYMS_SEC ".ksyms"
 #define STRUCT_OPS_SEC ".struct_ops"
+#define STRUCT_OPS_LINK_SEC ".struct_ops.link"
=20
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -597,6 +598,7 @@ struct elf_state {
 	Elf64_Ehdr *ehdr;
 	Elf_Data *symbols;
 	Elf_Data *st_ops_data;
+	Elf_Data *st_ops_link_data;
 	size_t shstrndx; /* section index for section name strings */
 	size_t strtabidx;
 	struct elf_sec_desc *secs;
@@ -606,6 +608,7 @@ struct elf_state {
 	int text_shndx;
 	int symbols_shndx;
 	int st_ops_shndx;
+	int st_ops_link_shndx;
 };
=20
 struct usdt_manager;
@@ -1119,7 +1122,8 @@ static int bpf_object__init_kern_struct_ops_maps(st=
ruct bpf_object *obj)
 	return 0;
 }
=20
-static int bpf_object__init_struct_ops_maps(struct bpf_object *obj)
+static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_=
name,
+				int shndx, Elf_Data *data, __u32 map_flags)
 {
 	const struct btf_type *type, *datasec;
 	const struct btf_var_secinfo *vsi;
@@ -1130,15 +1134,15 @@ static int bpf_object__init_struct_ops_maps(struc=
t bpf_object *obj)
 	struct bpf_map *map;
 	__u32 i;
=20
-	if (obj->efile.st_ops_shndx =3D=3D -1)
+	if (shndx =3D=3D -1)
 		return 0;
=20
 	btf =3D obj->btf;
-	datasec_id =3D btf__find_by_name_kind(btf, STRUCT_OPS_SEC,
+	datasec_id =3D btf__find_by_name_kind(btf, sec_name,
 					    BTF_KIND_DATASEC);
 	if (datasec_id < 0) {
 		pr_warn("struct_ops init: DATASEC %s not found\n",
-			STRUCT_OPS_SEC);
+			sec_name);
 		return -EINVAL;
 	}
=20
@@ -1151,7 +1155,7 @@ static int bpf_object__init_struct_ops_maps(struct =
bpf_object *obj)
 		type_id =3D btf__resolve_type(obj->btf, vsi->type);
 		if (type_id < 0) {
 			pr_warn("struct_ops init: Cannot resolve var type_id %u in DATASEC %s=
\n",
-				vsi->type, STRUCT_OPS_SEC);
+				vsi->type, sec_name);
 			return -EINVAL;
 		}
=20
@@ -1170,7 +1174,7 @@ static int bpf_object__init_struct_ops_maps(struct =
bpf_object *obj)
 		if (IS_ERR(map))
 			return PTR_ERR(map);
=20
-		map->sec_idx =3D obj->efile.st_ops_shndx;
+		map->sec_idx =3D shndx;
 		map->sec_offset =3D vsi->offset;
 		map->name =3D strdup(var_name);
 		if (!map->name)
@@ -1180,6 +1184,7 @@ static int bpf_object__init_struct_ops_maps(struct =
bpf_object *obj)
 		map->def.key_size =3D sizeof(int);
 		map->def.value_size =3D type->size;
 		map->def.max_entries =3D 1;
+		map->def.map_flags =3D map_flags;
=20
 		map->st_ops =3D calloc(1, sizeof(*map->st_ops));
 		if (!map->st_ops)
@@ -1192,14 +1197,14 @@ static int bpf_object__init_struct_ops_maps(struc=
t bpf_object *obj)
 		if (!st_ops->data || !st_ops->progs || !st_ops->kern_func_off)
 			return -ENOMEM;
=20
-		if (vsi->offset + type->size > obj->efile.st_ops_data->d_size) {
+		if (vsi->offset + type->size > data->d_size) {
 			pr_warn("struct_ops init: var %s is beyond the end of DATASEC %s\n",
-				var_name, STRUCT_OPS_SEC);
+				var_name, sec_name);
 			return -EINVAL;
 		}
=20
 		memcpy(st_ops->data,
-		       obj->efile.st_ops_data->d_buf + vsi->offset,
+		       data->d_buf + vsi->offset,
 		       type->size);
 		st_ops->tname =3D tname;
 		st_ops->type =3D type;
@@ -1212,6 +1217,19 @@ static int bpf_object__init_struct_ops_maps(struct=
 bpf_object *obj)
 	return 0;
 }
=20
+static int bpf_object_init_struct_ops(struct bpf_object *obj)
+{
+	int err;
+
+	err =3D init_struct_ops_maps(obj, STRUCT_OPS_SEC, obj->efile.st_ops_shn=
dx,
+				   obj->efile.st_ops_data, 0);
+	err =3D err ?: init_struct_ops_maps(obj, STRUCT_OPS_LINK_SEC,
+					  obj->efile.st_ops_link_shndx,
+					  obj->efile.st_ops_link_data,
+					  BPF_F_LINK);
+	return err;
+}
+
 static struct bpf_object *bpf_object__new(const char *path,
 					  const void *obj_buf,
 					  size_t obj_buf_sz,
@@ -1248,6 +1266,7 @@ static struct bpf_object *bpf_object__new(const cha=
r *path,
 	obj->efile.obj_buf_sz =3D obj_buf_sz;
 	obj->efile.btf_maps_shndx =3D -1;
 	obj->efile.st_ops_shndx =3D -1;
+	obj->efile.st_ops_link_shndx =3D -1;
 	obj->kconfig_map_idx =3D -1;
=20
 	obj->kern_version =3D get_kernel_version();
@@ -1265,6 +1284,7 @@ static void bpf_object__elf_finish(struct bpf_objec=
t *obj)
 	obj->efile.elf =3D NULL;
 	obj->efile.symbols =3D NULL;
 	obj->efile.st_ops_data =3D NULL;
+	obj->efile.st_ops_link_data =3D NULL;
=20
 	zfree(&obj->efile.secs);
 	obj->efile.sec_cnt =3D 0;
@@ -2619,7 +2639,7 @@ static int bpf_object__init_maps(struct bpf_object =
*obj,
 	err =3D bpf_object__init_user_btf_maps(obj, strict, pin_root_path);
 	err =3D err ?: bpf_object__init_global_data_maps(obj);
 	err =3D err ?: bpf_object__init_kconfig_map(obj);
-	err =3D err ?: bpf_object__init_struct_ops_maps(obj);
+	err =3D err ?: bpf_object_init_struct_ops(obj);
=20
 	return err;
 }
@@ -2753,12 +2773,13 @@ static bool libbpf_needs_btf(const struct bpf_obj=
ect *obj)
 {
 	return obj->efile.btf_maps_shndx >=3D 0 ||
 	       obj->efile.st_ops_shndx >=3D 0 ||
+	       obj->efile.st_ops_link_shndx >=3D 0 ||
 	       obj->nr_extern > 0;
 }
=20
 static bool kernel_needs_btf(const struct bpf_object *obj)
 {
-	return obj->efile.st_ops_shndx >=3D 0;
+	return obj->efile.st_ops_shndx >=3D 0 || obj->efile.st_ops_link_shndx >=
=3D 0;
 }
=20
 static int bpf_object__init_btf(struct bpf_object *obj,
@@ -3451,6 +3472,9 @@ static int bpf_object__elf_collect(struct bpf_objec=
t *obj)
 			} else if (strcmp(name, STRUCT_OPS_SEC) =3D=3D 0) {
 				obj->efile.st_ops_data =3D data;
 				obj->efile.st_ops_shndx =3D idx;
+			} else if (strcmp(name, STRUCT_OPS_LINK_SEC) =3D=3D 0) {
+				obj->efile.st_ops_link_data =3D data;
+				obj->efile.st_ops_link_shndx =3D idx;
 			} else {
 				pr_info("elf: skipping unrecognized data section(%d) %s\n",
 					idx, name);
@@ -3465,6 +3489,7 @@ static int bpf_object__elf_collect(struct bpf_objec=
t *obj)
 			/* Only do relo for section with exec instructions */
 			if (!section_have_execinstr(obj, targ_sec_idx) &&
 			    strcmp(name, ".rel" STRUCT_OPS_SEC) &&
+			    strcmp(name, ".rel" STRUCT_OPS_LINK_SEC) &&
 			    strcmp(name, ".rel" MAPS_ELF_SEC)) {
 				pr_info("elf: skipping relo section(%d) %s for section(%d) %s\n",
 					idx, name, targ_sec_idx,
@@ -6611,7 +6636,7 @@ static int bpf_object__collect_relos(struct bpf_obj=
ect *obj)
 			return -LIBBPF_ERRNO__INTERNAL;
 		}
=20
-		if (idx =3D=3D obj->efile.st_ops_shndx)
+		if (idx =3D=3D obj->efile.st_ops_shndx || idx =3D=3D obj->efile.st_ops=
_link_shndx)
 			err =3D bpf_object__collect_st_ops_relos(obj, shdr, data);
 		else if (idx =3D=3D obj->efile.btf_maps_shndx)
 			err =3D bpf_object__collect_map_relos(obj, shdr, data);
@@ -8850,6 +8875,7 @@ const char *libbpf_bpf_prog_type_str(enum bpf_prog_=
type t)
 }
=20
 static struct bpf_map *find_struct_ops_map_by_offset(struct bpf_object *=
obj,
+						     int sec_idx,
 						     size_t offset)
 {
 	struct bpf_map *map;
@@ -8859,7 +8885,8 @@ static struct bpf_map *find_struct_ops_map_by_offse=
t(struct bpf_object *obj,
 		map =3D &obj->maps[i];
 		if (!bpf_map__is_struct_ops(map))
 			continue;
-		if (map->sec_offset <=3D offset &&
+		if (map->sec_idx =3D=3D sec_idx &&
+		    map->sec_offset <=3D offset &&
 		    offset - map->sec_offset < map->def.value_size)
 			return map;
 	}
@@ -8901,7 +8928,7 @@ static int bpf_object__collect_st_ops_relos(struct =
bpf_object *obj,
 		}
=20
 		name =3D elf_sym_str(obj, sym->st_name) ?: "<?>";
-		map =3D find_struct_ops_map_by_offset(obj, rel->r_offset);
+		map =3D find_struct_ops_map_by_offset(obj, shdr->sh_info, rel->r_offse=
t);
 		if (!map) {
 			pr_warn("struct_ops reloc: cannot find map at rel->r_offset %zu\n",
 				(size_t)rel->r_offset);
@@ -8968,8 +8995,9 @@ static int bpf_object__collect_st_ops_relos(struct =
bpf_object *obj,
 		}
=20
 		/* struct_ops BPF prog can be re-used between multiple
-		 * .struct_ops as long as it's the same struct_ops struct
-		 * definition and the same function pointer field
+		 * .struct_ops & .struct_ops.link as long as it's the
+		 * same struct_ops struct definition and the same
+		 * function pointer field
 		 */
 		if (prog->attach_btf_id !=3D st_ops->type_id ||
 		    prog->expected_attach_type !=3D member_idx) {
--=20
2.34.1

