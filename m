Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BFD4C9B66
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 03:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbiCBCtm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 21:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiCBCtl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 21:49:41 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA619AA022
        for <bpf@vger.kernel.org>; Tue,  1 Mar 2022 18:48:58 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 2221cmCj017818
        for <bpf@vger.kernel.org>; Tue, 1 Mar 2022 18:48:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=TXsdPEdp73jK+ERklfSew823H05ygELazNLNqjLVWb0=;
 b=b7irk3KhOHYuPCvgu/7V7aZuV8ICpLKs5EAPfHHZnUruGFb4mqRTkAv9XjoK+xhqe2hC
 f1F5OyKVWo71mQIlvSkRB3WFDeoO/xqXW8ZdXdO72TA4fhNb9Pv08hvSFCyI+XIeFc6R
 b1exOQI4OeBitOF77DTYVq5FwpEa3t/5qiI= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by m0089730.ppops.net (PPS) with ESMTPS id 3ehn5wmt5a-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Mar 2022 18:48:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHhWVGLRxiM4DLiHMuQoXp/Q21KcP2/2bVylan1tSI1RjmBWs1QzxyiUbybHLZ8HesDwmaRnBT3vOLhSRsAQt3K3nPEm89qeRvZg3jkiEVZHE2ySF4wm4iTdj9TRQsEbPuxxZyrlEEeWMJXR0rlAGW3xH+KADZSnOV06UvHkEvkkwZunNUYsGE6WlNcENlbiebSzocoUNcXTHgpXdzZBvT5V5XpHOXtBazIFSmEk3XcHb4FUFfR1Eg6QZSmsoYyrRNX4V3HGoV0mwHIUuyZMwpIFgEwofhHKGoYb2hLqSPQ0CLRYMLpiaxYLnyoxg5wp19ivdK7tRdX92n9Ewzuy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXsdPEdp73jK+ERklfSew823H05ygELazNLNqjLVWb0=;
 b=NM9jKk8PkcTkJ76GFvdUrd6FHiJIXr6WQmhK8KZnN9BQYVrPVocXhPwWoeHdWCpvn89om1GrSNT6Ycn9ZBgKM3sbyd/Sbgf77vifoYVDbzzGmUlWSVPuSE7lQZfFnqUoNbxTk3Fs88f5nNy59tY+X2QJ2cUJvIbJuaIv9X/P2jcw2Y8A+ZV32TsscVqNC9Ckmxkt5GXdtin9OcJtooZncEHa2akted09uqTFNtZosZelBqFIbWh8559PljAco047SVtew9L33XIIqgtZ/3Rco04J417D4nD5d6zulsG/P6j54xUAJ+P4ZAb44fWlVqYTdwavrkdBotZCr7NSr9P2FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MW4PR15MB4441.namprd15.prod.outlook.com (2603:10b6:303:102::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 02:48:54 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%5]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 02:48:54 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next 2/4] bpftool: add support for subskeletons
Thread-Topic: [PATCH bpf-next 2/4] bpftool: add support for subskeletons
Thread-Index: AQHYLeAOCjyNx/p0zkqw4nvA3AAv2w==
Date:   Wed, 2 Mar 2022 02:48:53 +0000
Message-ID: <a679538775e08c6f7686c2aec201589b47eda483.1646188795.git.delyank@fb.com>
References: <cover.1646188795.git.delyank@fb.com>
In-Reply-To: <cover.1646188795.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3081ff61-6d0b-4795-64cf-08d9fbf73097
x-ms-traffictypediagnostic: MW4PR15MB4441:EE_
x-microsoft-antispam-prvs: <MW4PR15MB4441C610D162CB6C63548C22C1039@MW4PR15MB4441.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KRDkcncfk7StxbfhycZLXTrGXGBeyTVhpjd6WJXo3bnvU8DJBOjgkV+W2wdgkn4NWzDstzBisUENThQh6UQ9h1RDStHG6nXw+XSnzZJoZnQI05yjzyoJ5IKada17Y3ptZj/tBhHfi3w1/YEOmivefzqxBq1JgyxxPH1DAQyED/+HQVQrhdbVRWabtcZ6EoXCin5gAOyKFjgS/L4xGUSgz3bLfK5VPN4iIYVNMbb6jvJHkF/36okmAhMULX57JSy1RWjRqYL2COGoRZlBLmpvHJyNLZFI3Itq/W9r5UkNerZlnPn8X2Nn6wmcwzrWAcTGn2XnQbKa6BU5/8APOE9Bl37Bid6WPQ3eTF0gQ1Ywsd/Fd9l8BOPJ+8BMUimab0oD4cQfedQsCDwj9p9QVMFsQl4+BWTTkTSLEM9GCxcxjrkEGCJRIB2GyYDwRfNNliEEJMUf1nnlUNfikWjF1r+Xy67YmcFcSLqJRaSdxVr+fjqgGFQ+2ZjB7yH4tpV067FeUKrZLSJHFkWtKNzbfEsApO4DZbrY7e1a2WjDJ6dsqXtAt6ajOp3pLma7zEJ9OdY2tGO8wWW4GUpvje3872+9ZP15//Ogcatj8QGuQylaD04naY0xjVp47wBxLv9uSja6VRpl+R1tiNSy2UIsxIkF7swKfwA38AJt+WPtQDe/tYxQ7Yrn2H8kBAXsUtb46Vqs27r4mHHgJmC5kHAuXQ7Fvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38100700002)(83380400001)(110136005)(122000001)(86362001)(6512007)(6506007)(66476007)(186003)(38070700005)(91956017)(36756003)(2616005)(66946007)(76116006)(66446008)(66556008)(64756008)(2906002)(8936002)(30864003)(5660300002)(71200400001)(508600001)(8676002)(6486002)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?w8cBusk8Rso5UP1JbzhQ47M/8q9u29ris64x+fHdbGIxxKiHQypUMVN+uj?=
 =?iso-8859-1?Q?TtWzIYJUq/8J9iYajCD2JlnXhu7CYx9G0JPdVXTuZTO02ZqRM51Li8HL3A?=
 =?iso-8859-1?Q?USFdANlsCh0OdWtueA/04vuU3h/oYr8egNOCdIMj6V2V744spK8DtOVUyh?=
 =?iso-8859-1?Q?Y3IRrEIroVpNH9uGDKzwxkz6bd7mAe/mMh9JLr0UzoJ/RI6VZ2wlg0tzBh?=
 =?iso-8859-1?Q?JdYvxCb6vSLkcyQdsuIqQw2KP2lDwAqax6do5PO1IRVViwy1weLx6AN888?=
 =?iso-8859-1?Q?AcJbYG8GvNSxCSmFdFKaShppewBlxqyscLPWRvqzhVJ9ocbc8a8tliyOTA?=
 =?iso-8859-1?Q?WeVmGVQMliLOSBCJoZcHL43O3kbYZaoQiXEcMM+eGdyTQDPFrK8yDjKYe1?=
 =?iso-8859-1?Q?82zIrgsJf0dqc7a9yfA9rL6Fonsgpn3ZmV13s+WliH4PKJldCWknidaAuy?=
 =?iso-8859-1?Q?RLFfoz4QyMVJS5mG6TuGNg6V57NT0NpY2K0LjSAnhH6ZWoJFygwBODmmgN?=
 =?iso-8859-1?Q?Xm3Rkhp3Up+6Ny0PmTRZ71KP9/QCYxoEfzciJQkGdhz6j0FZDfd68ccF+2?=
 =?iso-8859-1?Q?jfa2Fb6PIM+LvRX9lrrYWKxPwRgPFls8I608PqKp+BCkqBg49PPuYaIXrT?=
 =?iso-8859-1?Q?WnRoP5s8p4I52O1czDNvgi28SvbVQ6flyobJSan38Ifc/UPiRDpiYxsHuI?=
 =?iso-8859-1?Q?SZRyuTfZaREWZdOeCvg2cOwvzh3shSI+EmuQOPGrGavvv9bcJwFNJq9ufM?=
 =?iso-8859-1?Q?7QAqPl61t+46QOm+ZJ7uhXC+ZP09dGwv6RD0j7TWH59ARhwHe6fMQ/kip2?=
 =?iso-8859-1?Q?ONq6I3hzDv28Znh3uNSszwzjKlK+0g1FpGzrMXfFnDu1XEluv9E93L1A0a?=
 =?iso-8859-1?Q?Y6VgHyGe3m7DiE5jVysfyP+a3VzDm1suw3vL+yTgaMgu0C1u7kOZ5cF267?=
 =?iso-8859-1?Q?mnTgkUi+K2ada+OLGgXFih3mJLM7pswHCMttkXJfMEwv4qlnyRcjrrMkHp?=
 =?iso-8859-1?Q?F3SsvrSJP5FRmdLFP2+jL3z4vTM2N5gz+2IRnLo5vVhgKax4JXtRG4uMB8?=
 =?iso-8859-1?Q?SZkz+NXDeyfsq31Wlf64SP4WDV+bLBjlx7beUX972S9RMUvH0MjuD+Npe0?=
 =?iso-8859-1?Q?ut5Fkzi6YKn8gTKvYLe1wQCVHEaOVTJtfIBePbQH+eFUiBepovNasNIcl7?=
 =?iso-8859-1?Q?08bZCG7uASl+fpxp0aJmrX1XegmaBzJBo8vI8qlt7C4NwdKzp7L5IDsDzY?=
 =?iso-8859-1?Q?Jt0EYFq0iKf2dPfKdcwHSsSxL1Qhcb5YCmWEEjG/TvsWLaW1RUKlfQYjR8?=
 =?iso-8859-1?Q?ZVckv18qDdhqZsdXnxQHPe0gIoxL/1ZXu2YzgA0QX33XUQ30SlTfqnhtmV?=
 =?iso-8859-1?Q?gIE9s3P26nb4Ur1XOODK7KhFS4ij9Jb3W+ME2/EZz3nVsTVcsphOMDLK5c?=
 =?iso-8859-1?Q?OqmjSlBcKGITIBLWjdCmEqJfAli5lSrjA8wQODGazedyWyd+VW0o1O1q+b?=
 =?iso-8859-1?Q?UR4MLhHkwAuOAMYz1sLx920+wqQ5nxBVI+ZLnceIz0AVIiQ23odry4XSl9?=
 =?iso-8859-1?Q?mjsk8kNqBcwMp+U83cmihOP2KKhOLy/hxufKvyPW3+wFRM9ur+eDRkoz4U?=
 =?iso-8859-1?Q?ooND0opyCmfpFY/MbrPjXzkHEul8lGghfKHO6pfSzizsuxz8Hyl/8QQQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3081ff61-6d0b-4795-64cf-08d9fbf73097
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 02:48:53.9561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JRdILaFzXG7Th2OMIirM25BXSKe6mjoSw7JrL8iB21FmSe7Yi5XNui6eDUDn7CDT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4441
X-Proofpoint-GUID: BPorzhRkqrfeH3TR34TTx8-RWnqmrvFH
X-Proofpoint-ORIG-GUID: BPorzhRkqrfeH3TR34TTx8-RWnqmrvFH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_01,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0
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

Subskeletons are headers which require an already loaded program to
operate.

For example, when a BPF library is linked into a larger BPF object file,
the library userspace needs a way to access its own global variables
without requiring knowledge about the larger program at build time.

As a result, subskeletons require a loaded bpf_object to open().
Further, they find their own symbols in the larger program by
walking BTF type data at run time.

At this time, only globals are supported, though non-owning references
to links, programs, and other objects may be added as the needs arise.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/bpf/bpftool/gen.c | 322 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 313 insertions(+), 9 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 145734b4fe41..ea292e09c17b 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -125,14 +125,14 @@ static int codegen_datasec_def(struct bpf_object *obj=
,
 			       struct btf *btf,
 			       struct btf_dump *d,
 			       const struct btf_type *sec,
-			       const char *obj_name)
+			       const char *obj_name,
+			       bool subskel)
 {
 	const char *sec_name =3D btf__name_by_offset(btf, sec->name_off);
 	const struct btf_var_secinfo *sec_var =3D btf_var_secinfos(sec);
 	int i, err, off =3D 0, pad_cnt =3D 0, vlen =3D btf_vlen(sec);
 	char var_ident[256], sec_ident[256];
 	bool strip_mods =3D false;
-
 	if (!get_datasec_ident(sec_name, sec_ident, sizeof(sec_ident)))
 		return 0;
=20
@@ -183,7 +183,7 @@ static int codegen_datasec_def(struct bpf_object *obj,
 			align =3D 4;
=20
 		align_off =3D (off + align - 1) / align * align;
-		if (align_off !=3D need_off) {
+		if (align_off !=3D need_off && !subskel) {
 			printf("\t\tchar __pad%d[%d];\n",
 			       pad_cnt, need_off - off);
 			pad_cnt++;
@@ -197,6 +197,15 @@ static int codegen_datasec_def(struct bpf_object *obj,
 		strncat(var_ident, var_name, sizeof(var_ident) - 1);
 		sanitize_identifier(var_ident);
=20
+		/* to emit a pointer to the type in the map, we need to
+		 * make sure our btf has that pointer type first.
+		 */
+		if (subskel) {
+			var_type_id =3D btf__add_ptr(btf, var_type_id);
+			if (var_type_id < 0)
+				return var_type_id;
+		}
+
 		printf("\t\t");
 		err =3D btf_dump__emit_type_decl(d, var_type_id, &opts);
 		if (err)
@@ -205,7 +214,10 @@ static int codegen_datasec_def(struct bpf_object *obj,
=20
 		off =3D sec_var->offset + sec_var->size;
 	}
-	printf("	} *%s;\n", sec_ident);
+	if (subskel)
+		printf("	} %s;\n", sec_ident);
+	else
+		printf("	} *%s;\n", sec_ident);
 	return 0;
 }
=20
@@ -231,7 +243,7 @@ static const struct btf_type *find_type_for_map(struct =
btf *btf, const char *map
 	return NULL;
 }
=20
-static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
+static int codegen_datasecs(struct bpf_object *obj, const char *obj_name, =
bool subskel)
 {
 	struct btf *btf =3D bpf_object__btf(obj);
 	struct btf_dump *d;
@@ -240,6 +252,13 @@ static int codegen_datasecs(struct bpf_object *obj, co=
nst char *obj_name)
 	char map_ident[256];
 	int err =3D 0;
=20
+	/* When generating a subskeleton, we need to emit _pointers_
+	 * to the types in the maps. Use a new btf object as storage for these
+	 * new types as they're not guaranteed to already exist.
+	 */
+	if (subskel)
+		btf =3D btf__new_empty_split(btf);
+
 	d =3D btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
 	err =3D libbpf_get_error(d);
 	if (err)
@@ -264,11 +283,11 @@ static int codegen_datasecs(struct bpf_object *obj, c=
onst char *obj_name)
 		 * map. It will still be memory-mapped and its contents
 		 * accessible from user-space through BPF skeleton.
 		 */
-		if (!sec) {
+		if (!sec && !subskel) {
 			printf("	struct %s__%s {\n", obj_name, map_ident);
 			printf("	} *%s;\n", map_ident);
-		} else {
-			err =3D codegen_datasec_def(obj, btf, d, sec, obj_name);
+		} else if (sec) {
+			err =3D codegen_datasec_def(obj, btf, d, sec, obj_name, subskel);
 			if (err)
 				goto out;
 		}
@@ -276,6 +295,8 @@ static int codegen_datasecs(struct bpf_object *obj, con=
st char *obj_name)
=20
=20
 out:
+	if (subskel)
+		btf__free(btf);
 	btf_dump__free(d);
 	return err;
 }
@@ -896,7 +917,7 @@ static int do_skeleton(int argc, char **argv)
=20
 	btf =3D bpf_object__btf(obj);
 	if (btf) {
-		err =3D codegen_datasecs(obj, obj_name);
+		err =3D codegen_datasecs(obj, obj_name, false);
 		if (err)
 			goto out;
 	}
@@ -1141,6 +1162,287 @@ static int do_skeleton(int argc, char **argv)
 	return err;
 }
=20
+/* Subskeletons are like skeletons, except they don't own the bpf_object,
+ * associated maps, links, etc. Instead, they know about the existence of
+ * a certain number of datasec fields and are able to find their locations
+ * _at runtime_ from an already loaded bpf_object.
+ *
+ * This allows for library-like BPF objects to have userspace counterparts
+ * with access to their globals without having to know anything about the
+ * final BPF object that the library was linked into.
+ */
+static int do_subskeleton(int argc, char **argv)
+{
+	char header_guard[MAX_OBJ_NAME_LEN + sizeof("__SKEL_H__")];
+	size_t i, len, file_sz, mmap_sz, sym_sz =3D 0, sym_idx =3D 0;
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
+	char obj_name[MAX_OBJ_NAME_LEN] =3D "", *obj_data;
+	struct bpf_object *obj =3D NULL;
+	const char *file, *var_name;
+	char ident[256], var_ident[256];
+	int fd, err =3D -1, map_type_id;
+	const struct bpf_map *map;
+	struct btf *btf;
+	const struct btf_type *map_type, *var_type;
+	const struct btf_var_secinfo *var;
+	struct stat st;
+
+	if (!REQ_ARGS(1)) {
+		usage();
+		return -1;
+	}
+	file =3D GET_ARG();
+
+	while (argc) {
+		if (!REQ_ARGS(2))
+			return -1;
+
+		if (is_prefix(*argv, "name")) {
+			NEXT_ARG();
+
+			if (obj_name[0] !=3D '\0') {
+				p_err("object name already specified");
+				return -1;
+			}
+
+			strncpy(obj_name, *argv, MAX_OBJ_NAME_LEN - 1);
+			obj_name[MAX_OBJ_NAME_LEN - 1] =3D '\0';
+		} else {
+			p_err("unknown arg %s", *argv);
+			return -1;
+		}
+
+		NEXT_ARG();
+	}
+
+	if (argc) {
+		p_err("extra unknown arguments");
+		return -1;
+	}
+
+	if (use_loader) {
+		p_err("cannot use loader for subskeletons");
+		return -1;
+	}
+
+	if (stat(file, &st)) {
+		p_err("failed to stat() %s: %s", file, strerror(errno));
+		return -1;
+	}
+	file_sz =3D st.st_size;
+	mmap_sz =3D roundup(file_sz, sysconf(_SC_PAGE_SIZE));
+	fd =3D open(file, O_RDONLY);
+	if (fd < 0) {
+		p_err("failed to open() %s: %s", file, strerror(errno));
+		return -1;
+	}
+	obj_data =3D mmap(NULL, mmap_sz, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (obj_data =3D=3D MAP_FAILED) {
+		obj_data =3D NULL;
+		p_err("failed to mmap() %s: %s", file, strerror(errno));
+		goto out;
+	}
+	if (obj_name[0] =3D=3D '\0')
+		get_obj_name(obj_name, file);
+	opts.object_name =3D obj_name;
+	if (verifier_logs)
+		/* log_level1 + log_level2 + stats, but not stable UAPI */
+		opts.kernel_log_level =3D 1 + 2 + 4;
+	obj =3D bpf_object__open_mem(obj_data, file_sz, &opts);
+	err =3D libbpf_get_error(obj);
+	if (err) {
+		char err_buf[256];
+
+		libbpf_strerror(err, err_buf, sizeof(err_buf));
+		p_err("failed to open BPF object file: %s", err_buf);
+		obj =3D NULL;
+		goto out;
+	}
+
+	btf =3D bpf_object__btf(obj);
+	err =3D libbpf_get_error(btf);
+	if (err) {
+		err =3D -1;
+		p_err("need btf type information for %s", obj_name);
+		goto out;
+	}
+
+	/* First, count how many symbols we have to link. */
+	bpf_object__for_each_map(map, obj) {
+		if (!bpf_map__is_internal(map))
+			continue;
+
+		if (!(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
+			continue;
+
+		if (!get_map_ident(map, ident, sizeof(ident)))
+			continue;
+
+		map_type_id =3D btf__find_by_name_kind(btf, bpf_map__section_name(map), =
BTF_KIND_DATASEC);
+		if (map_type_id < 0) {
+			err =3D map_type_id;
+			goto out;
+		}
+		map_type =3D btf__type_by_id(btf, map_type_id);
+
+		for (i =3D 0, var =3D btf_var_secinfos(map_type), len =3D btf_vlen(map_t=
ype);
+		     i < len;
+		     i++, var++) {
+			sym_sz++;
+		}
+	}
+
+	get_header_guard(header_guard, obj_name);
+	codegen("\
+	\n\
+	/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */   \n\
+								    \n\
+	/* THIS FILE IS AUTOGENERATED! */			    \n\
+	#ifndef %2$s						    \n\
+	#define %2$s						    \n\
+								    \n\
+	#include <errno.h>					    \n\
+	#include <stdlib.h>					    \n\
+	#include <bpf/libbpf.h>					    \n\
+								    \n\
+	struct %1$s {						    \n\
+		struct bpf_object *obj;				    \n\
+		struct bpf_object_subskeleton *subskel;		    \n\
+	", obj_name, header_guard);
+
+	err =3D codegen_datasecs(obj, obj_name, true);
+	if (err)
+		goto out;
+
+	/* emit code that will allocate enough storage for all symbols */
+	codegen("\
+		\n\
+									    \n\
+		#ifdef __cplusplus					    \n\
+			static inline struct %1$s *open(const struct bpf_object *src);\n\
+			static inline void %1$s::destroy(struct %1$s *skel);\n\
+		#endif /* __cplusplus */				    \n\
+		};							    \n\
+									    \n\
+		static inline void					    \n\
+		%1$s__destroy(struct %1$s *skel)			    \n\
+		{							    \n\
+			if (!skel)					    \n\
+				return;					    \n\
+			if (skel->subskel)				    \n\
+				bpf_object__destroy_subskeleton(skel->subskel);\n\
+			free(skel);					    \n\
+		}							    \n\
+									    \n\
+		static inline struct %1$s *				    \n\
+		%1$s__open(const struct bpf_object *src)		    \n\
+		{							    \n\
+			struct %1$s *obj;				    \n\
+			struct bpf_object_subskeleton *subskel;		    \n\
+			struct bpf_sym_skeleton *syms;			    \n\
+			int err;					    \n\
+									    \n\
+			obj =3D (struct %1$s *)calloc(1, sizeof(*obj));	    \n\
+			if (!obj) {					    \n\
+				errno =3D ENOMEM;				    \n\
+				return NULL;				    \n\
+			}						    \n\
+			subskel =3D (struct bpf_object_subskeleton *)calloc(1, sizeof(*subskel)=
);\n\
+			if (!subskel) {					    \n\
+				errno =3D ENOMEM;				    \n\
+				return NULL;				    \n\
+			}						    \n\
+			subskel->sz =3D sizeof(*subskel);			    \n\
+			subskel->obj =3D src;				    \n\
+			subskel->sym_skel_sz =3D sizeof(struct bpf_sym_skeleton); \n\
+			subskel->sym_cnt =3D %2$d;			    \n\
+			obj->subskel =3D subskel;				    \n\
+									    \n\
+			syms =3D (struct bpf_sym_skeleton *)calloc(%2$d, sizeof(*syms));\n\
+			if (!syms) {					    \n\
+				free(subskel);				    \n\
+				errno =3D ENOMEM;				    \n\
+				return NULL;				    \n\
+			}						    \n\
+			subskel->syms =3D syms;				    \n\
+									    \n\
+		",
+		obj_name, sym_sz
+	);
+
+	/* walk through each symbol and emit the runtime representation
+	 */
+	bpf_object__for_each_map(map, obj) {
+		if (!bpf_map__is_internal(map))
+			continue;
+
+		if (!(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
+			continue;
+
+		if (!get_map_ident(map, ident, sizeof(ident)))
+			continue;
+
+		map_type_id =3D btf__find_by_name_kind(btf, bpf_map__section_name(map), =
BTF_KIND_DATASEC);
+		if (map_type_id < 0) {
+			err =3D map_type_id;
+			goto out;
+		}
+		map_type =3D btf__type_by_id(btf, map_type_id);
+
+		for (i =3D 0, var =3D btf_var_secinfos(map_type), len =3D btf_vlen(map_t=
ype);
+		     i < len;
+		     i++, var++, sym_idx++) {
+			var_type =3D btf__type_by_id(btf, var->type);
+			var_name =3D btf__name_by_offset(btf, var_type->name_off);
+
+			var_ident[0] =3D '\0';
+			strncat(var_ident, var_name, sizeof(var_ident) - 1);
+			sanitize_identifier(var_ident);
+
+			codegen("\
+			\n\
+				syms[%4$d].name =3D \"%1$s\";		    \n\
+				syms[%4$d].section =3D \"%3$s\";		    \n\
+				syms[%4$d].addr =3D (void**) &obj->%2$s.%1$s; \n\
+			", var_ident, ident, bpf_map__section_name(map), sym_idx);
+		}
+	}
+
+	codegen("\
+		\n\
+									    \n\
+			err =3D bpf_object__open_subskeleton(subskel);	    \n\
+			if (err) {					    \n\
+				%1$s__destroy(obj);			    \n\
+				errno =3D err;				    \n\
+				return NULL;				    \n\
+			}						    \n\
+									    \n\
+			return obj;					    \n\
+		}							    \n\
+		",
+		obj_name);
+
+	codegen("\
+		\n\
+									    \n\
+		#ifdef __cplusplus					    \n\
+		struct %1$s *%1$s::open(const struct bpf_object *src) { return %1$s__ope=
n(src); }\n\
+		void %1$s::destroy(struct %1$s *skel) { %1$s__destroy(skel); }\n\
+		#endif /* __cplusplus */				    \n\
+									    \n\
+		#endif /* %2$s */					    \n\
+		",
+		obj_name, header_guard);
+	err =3D 0;
+out:
+	bpf_object__close(obj);
+	if (obj_data)
+		munmap(obj_data, mmap_sz);
+	close(fd);
+	return err;
+}
+
 static int do_object(int argc, char **argv)
 {
 	struct bpf_linker *linker;
@@ -1192,6 +1494,7 @@ static int do_help(int argc, char **argv)
 	fprintf(stderr,
 		"Usage: %1$s %2$s object OUTPUT_FILE INPUT_FILE [INPUT_FILE...]\n"
 		"       %1$s %2$s skeleton FILE [name OBJECT_NAME]\n"
+		"       %1$s %2$s subskeleton FILE [name OBJECT_NAME]\n"
 		"       %1$s %2$s min_core_btf INPUT OUTPUT OBJECT [OBJECT...]\n"
 		"       %1$s %2$s help\n"
 		"\n"
@@ -1788,6 +2091,7 @@ static int do_min_core_btf(int argc, char **argv)
 static const struct cmd cmds[] =3D {
 	{ "object",		do_object },
 	{ "skeleton",		do_skeleton },
+	{ "subskeleton",	do_subskeleton },
 	{ "min_core_btf",	do_min_core_btf},
 	{ "help",		do_help },
 	{ 0 }
--=20
2.34.1
