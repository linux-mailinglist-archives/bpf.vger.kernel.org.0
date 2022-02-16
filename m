Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE804B7B9E
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 01:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbiBPAM3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 19:12:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiBPAM3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 19:12:29 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51CD70332
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 16:12:17 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21FMa4We017236
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 16:12:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=6Ad+GLc7gSKvP56xs8cM2qJ7UbA392GuSCMer4cV73E=;
 b=FCdhfJId/j1nmluICa6qx5dazIUuGLJEWz/igr/2gPDbA+LSkmn6myFl/0iQ2BtIIuCe
 lOmSmPEMpXK6+wbAkZRoTVIB3IuTob2tlk8HqLhVnpZpRE+fGoBGRE8mfLfT0ei5BN4t
 QPlmdambp7A+Tw3C++tPyNimpkOwKkCySsw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e8n3u0hme-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 16:12:16 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 16:12:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vb2AIXys7ZMDWacB2NKf3X6XRkDyqBnbwUYDAOVwOiIsSsCpJ9NVDHQ2IDgUE7htn8IjZkehvbPgMW0T2QaZ+iqSOQyQ/ts4etV+Mz5plKWj2FV//XOKFPnvlsBhFDNLDQNBHEnvLYI0dvST0l7ivN4NOQewiyG1ge0ROlIgRxwa4u6Zw5n284eMGX8qr8Ph3nIFvDg62A0Ta2GsQtgaiWAkCaUu87tyzsluLPGgwm4cZIh9dc2gqPnCFEyr+Ew9SgsNEhqo9JOtQd8HoFOr3TFC6vivRm8KMHeuLEgKzjr9TMfDBDFhD2KlweBPRVSsYQ/yUcxOwVO9utifePoXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMA4DBkiLgWqbn8xZLHuvAVEgBSyGTbhWp3U6HGlFiI=;
 b=DF+A0o6iBNJvnTMnHtG4oTRnq+LJz7aHfHXonlfy0bGYsHuq/qLHfk+XuL9ANiwkiF9RKJaQCO70fS2RaV5TriIXako7cZ4k4kAhl9uGaXm4T4lg9jIKmMQL3V3Q7QWKPg9m3Ya1q1AscfvalDQYlK8NIUfi08byS8qWEzDixK6W3caUrNWrqRxDLkCRVWN3AsrTyG5UCLWZF0UTy44Mw0D5zhxs6Ll2xOXaxUjaHw9Kn3VdD4CrUqX6PeTMHzPZp3sPNj47W8NdMFlc4eksWOOj3j+gJiFdH2DkEvkOIaS+WVZE3fNabKCy0hvqMjgaFF4RYkAMqybYgZBmpM+AJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BL0PR1501MB2033.namprd15.prod.outlook.com (2603:10b6:207:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Wed, 16 Feb
 2022 00:12:13 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7867:90d0:bcaa:2ea7]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7867:90d0:bcaa:2ea7%5]) with mapi id 15.20.4975.012; Wed, 16 Feb 2022
 00:12:13 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v3 1/1] bpftool: bpf skeletons assert type sizes
Thread-Topic: [PATCH bpf-next v3 1/1] bpftool: bpf skeletons assert type sizes
Thread-Index: AQHYIsnYzjFt5jhN5k2eZOgitbEL3w==
Date:   Wed, 16 Feb 2022 00:12:12 +0000
Message-ID: <b73550a69ea8c02fd93c862f9cfe38f7e1813e7a.1644970147.git.delyank@fb.com>
References: <cover.1644970147.git.delyank@fb.com>
In-Reply-To: <cover.1644970147.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dbbfa9a-7c0a-49cc-3867-08d9f0e0fb5c
x-ms-traffictypediagnostic: BL0PR1501MB2033:EE_
x-microsoft-antispam-prvs: <BL0PR1501MB2033C4C719CFAC783D41CC59C1359@BL0PR1501MB2033.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nedlnPTLt5mDgFaj2ayQILgS2aod1DKhGBAqA52TXJwxcF2di7ZEBhibo0bsfHeoi4C/RhVQja/CudUk4R5hFD1iCOjegnf25UX1K90wc1FohGwOhs6wpGn/ZxtsN9RUxsX82uwIymzx/BmxAj7OTTr9VeTRWm6zzJ5mpthkL4uoyA6Nj5k5396HUIB7woIdrJ/WV533cI9/zhI8DGYqFLzdlhPPWf1uT8vXluhSwb70lq1ji31rNFgeonZagev9f+yZA7yhfgqSvY+curLyjpPutPAS3o1nQtM7RTZqk3J0wVB7szzcFzu0JkczloYhHh0BtwffniUOYhAdGh5t8u7hbdpqBmk6iytTY56902Bp/7EYBPud6t/qSU7gSolsiqbiArBQjG0bAng3+/wrATwTtxR4cVkGJkyck6VTMBChNpbs5PGt+T+nXktI/m/FalLvVlltHeP9bEcLyoH4+1MMi4smUefOfiU9T9PSdNGLIhZD+xKKjwhmVQmerqvcNhOoc1GCbFUu9eDrRRO1wIg7Dv+zS/b6IRMcnRZORiAynobrQHX1PvNAY9i5BdEESk4dXUtrZDnOgFMrDoLxGvnc4ov6/SZqgICcfwWuavx76ETtGF+qnuX8kDRfj66DfGWk4Oy/CoqaEbas3zB5iRVfa20Sgn6+kofvZCbbrm9kCxAlMl6Ne232yme7K9TaNn2AEmU5ruoMshCdcQgEPAPskLexhWfYoYJiI3Kj9IEl0/wJIqEirTbEpD+T0Ojy//yqXYU1MriUEhAYbIN8dmp7Ek7b5RVfF/MZKt3+APYrX9X4KPHtYc6PvN/HqsvsyL1yKfpYFYGW+MVHE07U9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(8936002)(2906002)(38070700005)(6486002)(8676002)(91956017)(76116006)(5660300002)(36756003)(86362001)(110136005)(66946007)(64756008)(38100700002)(66556008)(66476007)(186003)(71200400001)(83380400001)(966005)(122000001)(2616005)(66446008)(6506007)(6512007)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nDR4JGcg0dZX0NZM4yG0vgwAsXuRA6Z/Iu2vpa6gNd3IVLN9HsdaLgc7Ko?=
 =?iso-8859-1?Q?D7G0zRGmmZ9n+QfuOHj4H+vAsXJ0U312ro6ubvzj5KDay+hzPqEl72YG++?=
 =?iso-8859-1?Q?OC3n3PjHThNEb0oENEyMat5NzgMUNgzGcGDoxAmvIRrzv5J1Ze8FoKLepM?=
 =?iso-8859-1?Q?RYoBr4Rio8dXKAglrpaUwQc8UYVRt2hX2xn/lwM9XcPEEhYOR6rVan9ZhJ?=
 =?iso-8859-1?Q?xDFORnRlxrb1Tw3TCAZvNIHi8HPFIXDgRvuQEjhZnZoJLApMWv+zl3nNGB?=
 =?iso-8859-1?Q?bnY9FzQ6MOs5GbTPH3WkAexXLzqMhAwDgRiewQg2syppcq+DUJS8pvnNLW?=
 =?iso-8859-1?Q?0RT1k0XDwJjtFvgHe17poLpDZt3GJZwPBT8CM6PQvSKHlfs8V1LZAeg2H6?=
 =?iso-8859-1?Q?rGffZkQuyJZHhB2h0KNDU9MUNtLEzR8kA1emRP+SyI6mdYQogeH7YjwGf9?=
 =?iso-8859-1?Q?GUAuORvrUPnfek6kB/v1RSI1dFhVG1dtds6uu02L1CkJkiuMAbU2Guyteq?=
 =?iso-8859-1?Q?M5Dt5jnE3GDImzHA6JnbwYKSXZuELTzQgBz0Cl6aefIRYHI+7NxqcvMpRW?=
 =?iso-8859-1?Q?R0UZIXQIzq/pm9f7Bc14PzL3Y49M1BOYEtinpXdoA3TvYUr0UnE7QrdyWt?=
 =?iso-8859-1?Q?+rfm54BRfkeKOT0H+2CTIL6qON48hiuFpdK9SZNfxWrKFOuey6s378Yg5A?=
 =?iso-8859-1?Q?c19De3pJTRXUMqsL1hutZqG5Q/qzfiR1z9oSlz9t/lJ07PIsfGyyXcbNxM?=
 =?iso-8859-1?Q?annA42+N50kd2CqnwWh5YxdakhvOIIyN+wN8VUyA2C8gDhqSR5v1m8GN5J?=
 =?iso-8859-1?Q?RNqQ4ITOBCrVXAuIl6CgIwn4Os/UmH5qeIRI0XUM4leHjlGDw4fwW/d3iE?=
 =?iso-8859-1?Q?N1qBqsnQtxWZnzNOXgp1tNjCtLxLDlnPGr+GikNv1nQakBAQf81QtDnwvk?=
 =?iso-8859-1?Q?eZLhQfRGMMgQpETWVEbKcttC6RGdimrUZe0MkiorVoa1wf3lqwfyPrb1jb?=
 =?iso-8859-1?Q?jPx/zfheM2mrL+yywff3tax2WkN+Fns87L4naobsIRyYAmhwUZphDOCWGD?=
 =?iso-8859-1?Q?uBUK4jRSMKo3RNQjXWape9h92YrktvG5K49UjiQiVlfJmWg8P/8bDPxsBQ?=
 =?iso-8859-1?Q?VGxnAVFeT2GiKKKWk8POEA7vCwx0hWxiJQBeUIW7rfBdJZUDLQPITpVWm4?=
 =?iso-8859-1?Q?KlV+hnb9oZx039rF6sJ5yeEtCG7oGlYIaFQjjzJFMms/6bXPD9dckdjFZd?=
 =?iso-8859-1?Q?WKoyoSfegVXuiLMPyQzChH0IQIHSnBu/S6wnvanU7B+X8il4SP4iHeYsxQ?=
 =?iso-8859-1?Q?bNiXO79rN9/zVrbim9OLJD4w7Zq3LrrsGHE0Kv1Fnu5vv3NQeUrkUA9XuT?=
 =?iso-8859-1?Q?bXjR3wfMA+WRMWNMqBPU8bredn5xougxQh6lNVpZSmHSPelOWB/8foqD33?=
 =?iso-8859-1?Q?xVF4cXdggz3YT25St0GJwsj8avnjUH3vpVY/kRwVyCGR6kR/VLhpt/6raa?=
 =?iso-8859-1?Q?qC/CVB1Styaj2zoCHkI5Lglda9rKYe/iF7VXz1cFyAx8/DkbgrG//e0JHK?=
 =?iso-8859-1?Q?nFHI/5OIA9t6ZoMfS09SCLqyT5ibukKjVnQhD++w5P1xKBcS0esq09SEDh?=
 =?iso-8859-1?Q?S8R8lnlXienDDtcGwoTe5NnpKJlnDf/8eFTpw/O6tvJnH7EggDCr9cxQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbbfa9a-7c0a-49cc-3867-08d9f0e0fb5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 00:12:12.9945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Baz4CjN+Z5Xz0WnhaK/izGpqFzsHRfmdTHdayy//NwZQbl0IAqnvJKrtoiom+tLT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2033
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 1r36VLtnIKU8gXK_6eSpTVpAWs0C2CKa
X-Proofpoint-GUID: 1r36VLtnIKU8gXK_6eSpTVpAWs0C2CKa
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_07,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150139
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When emitting type declarations in skeletons, bpftool will now also emit
static assertions on the size of the data/bss/rodata/etc fields. This
ensures that in situations where userspace and kernel types have the same
name but differ in size we do not silently produce incorrect results but
instead break the build.

This was reported in [1] and as expected the repro in [2] fails to build
on the new size assert after this change.

  [1]: Closes: https://github.com/libbpf/libbpf/issues/433
  [2]: https://github.com/fuweid/iovisor-bcc-pr-3777

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/bpf/bpftool/gen.c | 134 +++++++++++++++++++++++++++++++++-------
 1 file changed, 112 insertions(+), 22 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 6f2e20be0c62..c1440c0d60b5 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -208,15 +208,38 @@ static int codegen_datasec_def(struct bpf_object *obj,
 	return 0;
 }
=20
+static const struct btf_type *find_type_for_map(struct bpf_object *obj,
+						const char *map_ident)
+{
+	struct btf *btf =3D bpf_object__btf(obj);
+	int n =3D btf__type_cnt(btf), i;
+	char sec_ident[256];
+
+	for (i =3D 1; i < n; i++) {
+		const struct btf_type *t =3D btf__type_by_id(btf, i);
+		const char *name;
+
+		if (!btf_is_datasec(t))
+			continue;
+
+		name =3D btf__str_by_offset(btf, t->name_off);
+		if (!get_datasec_ident(name, sec_ident, sizeof(sec_ident)))
+			continue;
+
+		if (strcmp(sec_ident, map_ident) =3D=3D 0)
+			return t;
+	}
+	return NULL;
+}
+
 static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
 {
 	struct btf *btf =3D bpf_object__btf(obj);
-	int n =3D btf__type_cnt(btf);
 	struct btf_dump *d;
 	struct bpf_map *map;
 	const struct btf_type *sec;
-	char sec_ident[256], map_ident[256];
-	int i, err =3D 0;
+	char map_ident[256];
+	int err =3D 0;
=20
 	d =3D btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
 	err =3D libbpf_get_error(d);
@@ -233,23 +256,7 @@ static int codegen_datasecs(struct bpf_object *obj, co=
nst char *obj_name)
 		if (!get_map_ident(map, map_ident, sizeof(map_ident)))
 			continue;
=20
-		sec =3D NULL;
-		for (i =3D 1; i < n; i++) {
-			const struct btf_type *t =3D btf__type_by_id(btf, i);
-			const char *name;
-
-			if (!btf_is_datasec(t))
-				continue;
-
-			name =3D btf__str_by_offset(btf, t->name_off);
-			if (!get_datasec_ident(name, sec_ident, sizeof(sec_ident)))
-				continue;
-
-			if (strcmp(sec_ident, map_ident) =3D=3D 0) {
-				sec =3D t;
-				break;
-			}
-		}
+		sec =3D find_type_for_map(obj, map_ident);
=20
 		/* In some cases (e.g., sections like .rodata.cst16 containing
 		 * compiler allocated string constants only) there will be
@@ -362,6 +369,81 @@ static size_t bpf_map_mmap_sz(const struct bpf_map *ma=
p)
 	return map_sz;
 }
=20
+/* Emit type size asserts for all top-level fields in memory-mapped intern=
al maps.
+ */
+static void codegen_asserts(struct bpf_object *obj, const char *obj_name)
+{
+	struct btf *btf =3D bpf_object__btf(obj);
+	struct bpf_map *map;
+	struct btf_var_secinfo *sec_var;
+	int i, vlen;
+	const struct btf_type *sec;
+	char map_ident[256], var_ident[256];
+
+	codegen("\
+		\n\
+									    \n\
+		#ifdef __cplusplus					    \n\
+		#define _Static_assert static_assert			    \n\
+		#endif							    \n\
+									    \n\
+		__attribute__((unused)) static void			    \n\
+		%1$s__type_asserts(struct %1$s *s)			    \n\
+		{							    \n\
+		", obj_name);
+
+	bpf_object__for_each_map(map, obj) {
+		if (!bpf_map__is_internal(map))
+			continue;
+		if (!(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
+			continue;
+		if (!get_map_ident(map, map_ident, sizeof(map_ident)))
+			continue;
+
+		sec =3D find_type_for_map(obj, map_ident);
+
+		if (!sec) {
+			/* best effort, couldn't find the type for this map */
+			continue;
+		}
+
+		sec_var =3D btf_var_secinfos(sec);
+		vlen =3D  btf_vlen(sec);
+
+		for (i =3D 0; i < vlen; i++, sec_var++) {
+			const struct btf_type *var =3D btf__type_by_id(btf, sec_var->type);
+			const char *var_name =3D btf__name_by_offset(btf, var->name_off);
+			__u32 var_type_id =3D var->type;
+			__s64 var_size =3D btf__resolve_size(btf, var_type_id);
+
+			if (var_size < 0)
+				continue;
+
+			/* static variables are not exposed through BPF skeleton */
+			if (btf_var(var)->linkage =3D=3D BTF_VAR_STATIC)
+				continue;
+
+			var_ident[0] =3D '\0';
+			strncat(var_ident, var_name, sizeof(var_ident) - 1);
+			sanitize_identifier(var_ident);
+
+			printf("\t_Static_assert(");
+			printf("sizeof(s->%1$s->%2$s) =3D=3D %3$lld, ",
+			       map_ident, var_ident, var_size);
+			printf("\"unexpected size of '%1$s'\");\n", var_ident);
+		}
+	}
+	codegen("\
+		\n\
+		}							    \n\
+									    \n\
+		#ifdef __cplusplus					    \n\
+		#undef _Static_assert					    \n\
+		#endif							    \n\
+		");
+}
+
+
 static void codegen_attach_detach(struct bpf_object *obj, const char *obj_=
name)
 {
 	struct bpf_program *prog;
@@ -640,6 +722,8 @@ static int gen_trace(struct bpf_object *obj, const char=
 *obj_name, const char *h
 		}							    \n\
 		", obj_name);
=20
+	codegen_asserts(obj, obj_name);
+
 	codegen("\
 		\n\
 									    \n\
@@ -1024,8 +1108,14 @@ static int do_skeleton(int argc, char **argv)
 		\n\
 		\";							    \n\
 		}							    \n\
-									    \n\
-		#endif /* %s */						    \n\
+		");
+
+	codegen_asserts(obj, obj_name);
+
+	codegen("\
+		\n\
+									\n\
+		#endif /* %s */						\n\
 		",
 		header_guard);
 	err =3D 0;
--=20
2.34.1
