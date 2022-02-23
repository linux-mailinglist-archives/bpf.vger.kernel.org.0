Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EE84C1E28
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 23:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242724AbiBWWDI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 17:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbiBWWDH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 17:03:07 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FE349276
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 14:02:38 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21NKW1CQ020028
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 14:02:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=pI8nlx5QtjtChjgGTUf5BPseLz9te2oTacTRwXxr2UY=;
 b=IvdkK+/haUdHuhyjPXtdjasxI5GTLcqcHKBK1N5sLWsSww1QA2h8jTY6w2oxoISdNN2n
 iB1qe054mwhEGTEyT5EY7TINz8UQvBGxUtjra8MbbwXJQQAXQ7EwcIUpSRW35z9cRpZC
 Id33EajxLwpX+9vGWYgLQSrBnY3keHWVFT0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ednde3uxy-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 14:02:37 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Feb 2022 14:02:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geadfrdzUrO8T8hitzCTlppvg1uNIUBx6oGS7tBv2zhWzHnyUHnCCLPCWM9H2fZp8NKdP19X1aCRwpoh3JgrU9mP5fx3IbXcOTTKL+695bxpmJ/Uv4NF1C580QvgMmXfz7CgCxraSQT/t9WmULYUC+t2c8jb010hPYN5VwNJE+nsLFg/gZSELN5IZFAMr4UgCthZ4eDAJiiay3X/xSphgJT5GL1nY+5k3Xfqw24iOeRHHfk6/Sk+yUyeRNMENWqRzNHlIRVLGJs/FFtFejGiNsYaysWi9mRWs9Z7wMcQdIg23aRBYT1IEvJEl6NxN4+kKu8aX+dYMDoatVea3sdESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0vXbd2cri8AdPJis61hQNKMwG6zVRwrKpoo8qbyEDE=;
 b=CXaXBvQi3TJYRZV6M4TWXrU9JaxPXJqTHkzkA4ozrX6etCVkISPQe1sye+rw+Qy5GhNAzScs88mLoKfXpZ2j4mBW+G8EQTJ1TOk9L8DNMVCdJr+Mn8BqtSDVAVLshf4WP7WroJITJxad2FoCjtfbea3U8SL/AUBHL7tyx2KkqWMeLi38AHVHgm0EgkSW9QyW0wkNFiemb2P9IZ6H3iqQ+r/E9jswUXOsSawiRLz4uTS9f88J9osWDiNS1208K0fhnyAkjwMgT4WWnam3YqKJ/rJvAEFfW9Rg0mTB1w+oAnn5IiaTyAGKJsLP7NnyG2reNFfiCmQtyIe1iX+1k1FGSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM5PR15MB1129.namprd15.prod.outlook.com (2603:10b6:3:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Wed, 23 Feb
 2022 22:01:58 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7867:90d0:bcaa:2ea7]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7867:90d0:bcaa:2ea7%5]) with mapi id 15.20.4995.026; Wed, 23 Feb 2022
 22:01:58 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v4] bpftool: bpf skeletons assert type sizes
Thread-Topic: [PATCH bpf-next v4] bpftool: bpf skeletons assert type sizes
Thread-Index: AQHYKQD62h5hzZs8Fkumt7R2s8aoNg==
Date:   Wed, 23 Feb 2022 22:01:58 +0000
Message-ID: <f562455d7b3cf338e59a7976f4690ec5a0057f7f.camel@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38504ad7-b8c0-41a1-bc61-08d9f7181cb1
x-ms-traffictypediagnostic: DM5PR15MB1129:EE_
x-microsoft-antispam-prvs: <DM5PR15MB11298DEFD7469BB7851D24CEC13C9@DM5PR15MB1129.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1n5jvz2QoSjfzlVLGCjN5VMWvaRpNYD/lFYirDo5CYrx+PtEw0+jbekQWbENGuDTZ+PfkqtbZS+ZTNxumGFtjPKoL/Iji+jalHSSTcr+RgnCVXjBVhOkCxet8/7KXaU7APDh4KMemkWOpmPu5CKMIIuDETOsTx7tmp6yOUIfb37FXrbnWz6E4NbSUYX1t0uPC1+etZLsZkp+/6sS149ADYZAyyzocPSNCuRn0QSdOfLQ+yMrpT2lf7Z0aaj5KRIgwW7qxiBoE3tf/a8Ka/xqyPBSvEaTCaWEuimHiYFp5C0HRYe7w9Tsl2BfVsFt+gLsAkUsrDWtphrmDRu10dmHDrf+x8qfqoEv1L2ng+SyQBZGzaxWxM78HOXPheNgdz7eCZITSbeYGsGuJbsF+MhmHKtZeKApkFgEgu1udY5aim2oFrLFQIANr8LqaFmwUQ081PrZRhGC1JRdFW4XB5GQDUOg/nLETKSmZQNtC0GqDZZVQy6mNrfeZgXb3vp2nSkQIKgJ+07uDfMOSznO26o3ca5gyxDnbkZqgzjdPS5iGqhGlEwV+KAajensRQnXSFaYQr5e+FJT7mWEsnGZgFmCb/MkvZ5Kd1SExHB13s/i2fOraHX84NoCHZ/4JP7BKw9QPbh2eiRmORvEdjOjB6PxIl6cB4+iZ9dHnOdssDC6kcHLJf7TVgs3sieMOsEE0feJGye1z54T/0Yadc/gXZwlUb0SkPYiikSxBCXgEBtzUz6FQRNUcY7s4EclFOEuFIFCMkhUIAc1Lxt7/aDJ+tjkUucF50sh6kjgQAMpq92USuvGPZ9ryXcA3lAl3gVK6a25tXx8LHxVpLGmWaqYeKbcgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(38070700005)(86362001)(8676002)(186003)(91956017)(36756003)(966005)(6486002)(2616005)(2906002)(71200400001)(6512007)(508600001)(6506007)(83380400001)(66446008)(66556008)(38100700002)(5660300002)(76116006)(66946007)(66476007)(122000001)(64756008)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GNIrI56pzZRKNVy7jqn6mmz7Mtoe2AhLlB0pRzJijOYizS2bDXzH1uImLK?=
 =?iso-8859-1?Q?dAnGu6D0tYCmwo30tyPAyHA4Ia9+K7sdqFPfOSZv/ZizTmxSttwwi+X5OH?=
 =?iso-8859-1?Q?R3buWj9YXZHskgwDTaYBOP1F4aMxDBgnSfMqXb45zWe+wSSjylQ6KIeKdg?=
 =?iso-8859-1?Q?pFVU6Yf+qZkHEFP5k7Fi6mFGyLnByNrUCcb92q8wKdLXR72wCOpfkepqSt?=
 =?iso-8859-1?Q?eZlmpQEPwwgRGfy+tbbnvR+U1aLU8Un4TBm/8qbi2Zn18Jb8EW+ChNV3AQ?=
 =?iso-8859-1?Q?niKNtN4C9ty2P1IK40c1y6J5jfSw06Q/PIiXx3EizZhFj+9gIaVNHu9Ca+?=
 =?iso-8859-1?Q?1HlVgeY07eP/q7xK63Xi2QWzHMRwiHzExduYTrt8lUNz0b4hWgRKkLrbW/?=
 =?iso-8859-1?Q?5/rmMVOzJ15PI1/O0eEhXJafK2yRD3fme1dqQuRzBq6RDWMhk+pW1VSW3W?=
 =?iso-8859-1?Q?KcUnLcfZvYsx8p6sU/01Em+rRsVa/OXqbTREefevhErwNUqvq8aZcD+nGn?=
 =?iso-8859-1?Q?c21pX49EPzjgCEo4j4JWoKMlfY4TFRn3hyaCiu1g4wU3BJwIVrlOCSZNNp?=
 =?iso-8859-1?Q?2obzgjYo1ND/1wfLaBGyPRjzfRQkbzPhNhJnF3ckfyA5eGaWttiNMkwUkk?=
 =?iso-8859-1?Q?yI1IdhI8HRZn0jxsUNB94IwLe+HDIknuCc0unR07Kif6UOIKBTYG2i/zs2?=
 =?iso-8859-1?Q?lApxx+v5QN+JfKCoXPIxnO2RrXJApI9SB+CxX/M7Lx61ShFLE1py2NaFYm?=
 =?iso-8859-1?Q?LiBazH0xoxLNTt0SO7FveqhxxEaL6ZDofg4HbofTibb4+jvk6dxdGGvrjo?=
 =?iso-8859-1?Q?gt6GQmMezYK5CUQxVcV4ET/ixKtFEDbCC+p3WwgippLzFXoax0Ygl6gU4t?=
 =?iso-8859-1?Q?IR7FJbn6np/7RkdFv077hdoHVEEG0EwZDUgbPjb2rJ9Qd1ZMfWicab0IO1?=
 =?iso-8859-1?Q?ev/fahMVWAsl5pWktmz9Re8RjIpEw7QP3y2iqrF7pe0OgOiBS48/CptRv2?=
 =?iso-8859-1?Q?0ASgOjGWFs+7g/GffMtgRABXCx6MQT169FGqEVv4pZbOzGSDGRY6Rr/SHt?=
 =?iso-8859-1?Q?w63PcchXfb8mvFprf0VgL/A68n+kCftfIthqtFTSocakbqEClmhFp05pPr?=
 =?iso-8859-1?Q?G2Ei3Ps1VD5slzicEIGdw+XTfptX9QVhl4PO8q+CMOpGzsL7ml5I+kDiFp?=
 =?iso-8859-1?Q?KP/JLtbCMicJ6X3x2AoMdiikuE5gJ5HEbcAEAF6M35v+V0aIASHB95VGqB?=
 =?iso-8859-1?Q?bRX5z9SH+fCuOD6WyAmVQ2UHK+Eho5/eQSsiXk+kZAXbBy2nDnYsCIfOMl?=
 =?iso-8859-1?Q?cIvgfb7IauIVoyx9aKJEIVNtHCh5L9CHmVUkrFfMa9v2F93bBJMP8op7WM?=
 =?iso-8859-1?Q?czVfHtPevIOb5qHhEGix5DdzhuVrJVWiq/sAx7ullz+PVZ6yw4os6fjNuX?=
 =?iso-8859-1?Q?9IonQOMXyBoFo71kLjNwd4tq26lMroWXeDCy1RXc7MCDFNH+iYjldAf6L0?=
 =?iso-8859-1?Q?Ep8t1VZzaHDCXgGuwMWH0u09JGQIpumqmbsfzSL+B81dQ300uRjqL7V24M?=
 =?iso-8859-1?Q?Ks9hZCHh+f9N93vJVOIVEjQ/iRn9iCjg/nk2+++lAIC6Cm1UNcF26qkC0+?=
 =?iso-8859-1?Q?AqHH+EGMRAtD4l3nYcDt7BPMwPAPPnV1yOcEfmRoj06w18LeAxwgbtlg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38504ad7-b8c0-41a1-bc61-08d9f7181cb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 22:01:58.1384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhn5XvGdPN5/MCwevDGhPl5s7cVNploZXhMTqQGb923H/c9mt9/E7V8Ezb3Ps4DI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1129
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: MyJlSziSvBDo3uuDnGyuhuF0zCRMmJWs
X-Proofpoint-ORIG-GUID: MyJlSziSvBDo3uuDnGyuhuF0zCRMmJWs
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_09,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230123
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Acked-by: Hengqi Chen <hengqi.chen@gmail.com>
Tested-by: Hengqi Chen <hengqi.chen@gmail.com>
---
v3 -> v4:
 - rebase
 - style fixes

v2 -> v3:
 - group all static asserts in one function at the end of the file
 - only use macros in C++ mode

v1 -> v2:
 - drop the stdint approach in favor of static asserts right after the stru=
cts

 tools/bpf/bpftool/gen.c | 133 +++++++++++++++++++++++++++++++++-------
 1 file changed, 111 insertions(+), 22 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index f8c1413523a3..a42545bcb12d 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -209,15 +209,38 @@ static int codegen_datasec_def(struct bpf_object *obj,
 	return 0;
 }

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

 	d =3D btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
 	err =3D libbpf_get_error(d);
@@ -234,23 +257,7 @@ static int codegen_datasecs(struct bpf_object *obj, co=
nst char *obj_name)
 		if (!get_map_ident(map, map_ident, sizeof(map_ident)))
 			continue;

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

 		/* In some cases (e.g., sections like .rodata.cst16 containing
 		 * compiler allocated string constants only) there will be
@@ -363,6 +370,78 @@ static size_t bpf_map_mmap_sz(const struct bpf_map *ma=
p)
 	return map_sz;
 }

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
+			printf("\t_Static_assert(sizeof(s->%1$s->%2$s) =3D=3D %3$lld, \"unexpec=
ted size of '%2$s'\");\n",
+			       map_ident, var_ident, var_size);
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
@@ -641,6 +720,8 @@ static int gen_trace(struct bpf_object *obj, const char=
 *obj_name, const char *h
 		}							    \n\
 		", obj_name);

+	codegen_asserts(obj, obj_name);
+
 	codegen("\
 		\n\
 									    \n\
@@ -1046,9 +1127,17 @@ static int do_skeleton(int argc, char **argv)
 		const void *%1$s::elf_bytes(size_t *sz) { return %1$s__elf_bytes(sz); } =
\n\
 		#endif /* __cplusplus */				    \n\
 									    \n\
-		#endif /* %2$s */					    \n\
 		",
-		obj_name, header_guard);
+		obj_name);
+
+	codegen_asserts(obj, obj_name);
+
+	codegen("\
+		\n\
+									    \n\
+		#endif /* %1$s */					    \n\
+		",
+		header_guard);
 	err =3D 0;
 out:
 	bpf_object__close(obj);
--
2.34.1=
