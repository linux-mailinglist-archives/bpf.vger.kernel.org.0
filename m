Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF1D6C2185
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 20:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCTTcS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 15:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjCTTbz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 15:31:55 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE48B1167F
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:24:38 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KH78js020326
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:24:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=250zDJIaOCI/0NSrmRzvQLYeEZCXgM1J8p6NoY5yvAo=;
 b=aRc72Gw+Bdq/nd/Cog7jGFVku3MrAjAhlT1Llrp0zVGVnGo7pvt7DkYvbwDF4pB3zJ/x
 mODwGYKuAWLUBd+wQAdTXupgWAdarf1gd1GjT7SUQH0xcF5vpzs4EKuBXqgrIoySCrxu
 FTp/hVPDvm9pzRAxxjQyj3aMInBULAZ5vFUxSy7xGQvX+dAVQjkZZSCF/83hLME2QoqN
 SCUwCliP+twezUwxBpmtcfTTET2VxcHbFxsHMVk3H1LWjoMeNNJR3GBCCb8qipMEKg8E
 uD7IhWJKxPDXKY8SyEGNXeUHM+kWzLHJjVxrqgEb3njViB0Uhvu6qTy6FJG3RwJWbK92 GQ== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pdcm739tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:24:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coQ8T8EewyyjolPzTgJ6fcokF0Y3CNiX5dDSPSJbdo7wLPnINA4tImCAhBvFjaM1Mf2ospahlE+FAZSPQYYHrLz2qdd1b1sKju3iN5+Qm8RZHFsezfpjB6KDkZj/6t1JBB7djzF9xqd7TL3bAzIF73Vb3JtGPUoXquLoEJ+3UmmkRx35WUbork1n0zRfr9ulnFjdqBIm1ru7xpvcL0jIMFQPjGh4tm6JPiD6qzfvHFe0/V+h59PFbT8E2vnvS1R5UF3FPXuWqIogYraQtGDT7P4voasK6j5y75hA8AF48oK9JnmCSq9IU8cIu7ANR988JoUz9GNMrLDP2jHCLpr3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=250zDJIaOCI/0NSrmRzvQLYeEZCXgM1J8p6NoY5yvAo=;
 b=KJn2DXIVIDDLqB+aBc+Cd5deWkPhcROSAQ70pCkOQ42IWTxi7Wzq+kh66vLgzLnrXAlHt/R+IxeeAFv0WtxXhGRjyj+bU88TonmqGb+VvZnK2gaEpxUaEvQSFdTjLqQoZAxgjXmCwZDwJWVI+Z30bDeCK/fVW/4cs9P7U+BpSXR2SClkQGJnkqfz4vWSGGwRmFEGhCWpAD3LtV6qHFFxdHDHbdqNWzAa8NViCBBBRg/M9EAw4ChxIIlFiCgKtv+du2PVvm6LOKoZ4ozWHIpf9LT0z8WyLP+WF5hpXGwGfc7fIeZHTO9tMXdQgjN5AizpeDcWz/gFHJkX5lnSUb9rHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 69.171.232.181) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=meta.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject header.from=meta.com;
 dkim=none (message not signed); arc=none
Received: from MW4PR03CA0357.namprd03.prod.outlook.com (2603:10b6:303:dc::32)
 by SA1PR15MB5300.namprd15.prod.outlook.com (2603:10b6:806:23f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 19:24:36 +0000
Received: from MW2NAM12FT111.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::97) by MW4PR03CA0357.outlook.office365.com
 (2603:10b6:303:dc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 19:24:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 69.171.232.181)
 smtp.mailfrom=meta.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=meta.com;
Received-SPF: Fail (protection.outlook.com: domain of meta.com does not
 designate 69.171.232.181 as permitted sender)
 receiver=protection.outlook.com; client-ip=69.171.232.181;
 helo=69-171-232-181.mail-mxout.facebook.com;
Received: from 69-171-232-181.mail-mxout.facebook.com (69.171.232.181) by
 MW2NAM12FT111.mail.protection.outlook.com (10.13.181.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.2 via Frontend Transport; Mon, 20 Mar 2023 19:24:35 +0000
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id DE2BB7D43607; Mon, 20 Mar 2023 12:24:12 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v9 7/8] libbpf: Use .struct_ops.link section to indicate a struct_ops with a link.
Date:   Mon, 20 Mar 2023 12:24:09 -0700
Message-Id: <20230320192410.1624645-8-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320192410.1624645-1-kuifeng@meta.com>
References: <20230320192410.1624645-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM12FT111:EE_|SA1PR15MB5300:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7be8fe17-b916-425b-0f87-08db2978bdd5
X-ETR:  Bypass spam filtering
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8R5Osloe35Fpnndb4G3VbRLhWkX8B7SfQfm5oBPoJX1djhRA2Hg9o8TGVBVWTYMG30aV4QENayF2pDEYSX8JLXHvDcImlxL3dxMqdaExBnH3RMcvGlNdqrBVk6DCU6NBB1CFuG/JYJIbL1ygiaw5Y8NB4PxS8N20QCee/xZ0gCCGpgUoc8/vaXlipR9kLoNF5pKVvyzchvddz6nr0eXO+EZscZKgxwOcUV7UrJGRJKPxWMcFtTVKd8L44GngeNvj8ecHg13+eJ4dW0o0+Ph2LQ9w5uawIDf3IISQsvIBk9rT62MlRpdKqUPh0TcX7ximdfh+KyoV4QoX5fJQ3VsnFAE89CBoZRof8YpQsCMhM5Xl2tFcu0KpJcDoVPr7V6HZw5H9QjjbkSFqdsl9WlsfBvNVqaavii6sIfLWmBPobrwsdF1qbj1+ivUH5bmOBBh3ihrYjQPSN7wUW4QY6Fe7RRTJ954uYkuSSqNVkUL0yH2q+vjbCc8FIz4aKZtC+CVqTJSyIiBXyEIOMC4bWL51jFmlFxxPgS+pzj1V9jsj6a9w3syddVQfnnRXMv9Zc/6nPQEwCINExR6v/eXX/4bo7TLnZZLUfZhZ8o+aY+UUHwqjq/Cp7WBLWVVLMJLaQVZ3D6saC1hmpONpopKPhWc4tq+Dfme/AqdLSdsNmGH1Os80Wg8GjhQwMi7t7D188+tUgdZjv9sJHBdthDE/os05Ff7LXFHLJJ7Cq4LCoXQTnIk=
X-Forefront-Antispam-Report: CIP:69.171.232.181;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:69-171-232-181.mail-mxout.facebook.com;PTR:69-171-232-181.mail-mxout.facebook.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(46966006)(36840700001)(40470700004)(36860700001)(86362001)(36756003)(7596003)(6266002)(7636003)(356005)(82740400003)(4326008)(5660300002)(2906002)(8936002)(1076003)(70206006)(82310400005)(41300700001)(33570700077)(2616005)(40460700003)(186003)(336012)(83380400001)(47076005)(42186006)(316002)(40480700001)(478600001)(6666004)(26005)(107886003)(8676002)(142923001);DIR:OUT;SFP:1501;
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 19:24:35.8541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be8fe17-b916-425b-0f87-08db2978bdd5
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=8ae927fe-1255-47a7-a2af-5f3a069daaa2;Ip=[69.171.232.181];Helo=[69-171-232-181.mail-mxout.facebook.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT111.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5300
X-Proofpoint-GUID: DixOcnAtNt7ynSUO43Yqx_fyxbWxTP8n
X-Proofpoint-ORIG-GUID: DixOcnAtNt7ynSUO43Yqx_fyxbWxTP8n
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

