Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFCD4DBB28
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 00:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244861AbiCPXiu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 19:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242323AbiCPXit (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 19:38:49 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B204167DD
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 16:37:33 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22GHCdMN028583
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 16:37:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=6HESL43UVRRfdV82QuAKeFQCqniHjuebegPgDSqkqOI=;
 b=O5fREvpAB3kMoMQz1jEE+7qUM1EoIUPadvwnU55rbIuqyMF4oP6m8M0e95nAoptjCEjP
 w0zDeOIdF74YLScGWN/l5q3QKsKupesBPoX432iUytdKv03Tw0c1OPtd2bbizG17Nr28
 PndH3htbtRnKnzEytk4z8vG5PpsgWPrSjSw= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eucf464d8-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 16:37:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nADK4fU6ciL1TRfoF+XIHtXAXa68wSang8lfH4at82f/bCaKfwlg7JBePZVxZEyr0gMk1fdMtzCGBEpuFeaXVSUq+iPma3/HsVfySDKyRUg3lvmAUqKexw+t4Z0A9vbJWCPDXDs8tG/YdwnSqIaylUjBTrozJSN09+Q073WpdHQlzoccJwclJjItvDWJTEeZyIxFYeiVGrzXSQB+hu3Ysr4f3ea0V3usQKNazmI7y2XvV1cSPe3z+CXV3HgnrUIOLUpqsWhd56IxpxYDMP08akZObkCz8JDhqCyc0gihY7d0/eN98emp6A0XUvQ9WVVinTud8p+8CVMoJnXVqjZ42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HESL43UVRRfdV82QuAKeFQCqniHjuebegPgDSqkqOI=;
 b=mTiaiGYlirDHNdPgBnCP/3hZbEDnwQ6tGhR/8ZAfYayZe9GH5wsqIFW0FY66ho8iSlca5RZ0gZXmWnwYLdq+nmUexxgWJ8eFf8LFrdB6AwN9sBoZlzxikPFys/g4mN43HErMvfvpZIL0xoqRy3ZXYn5GW6suVtmfuSebqaodLisjwx/sYxhQ93xiuGCm4SqZU/7oQueBZ/VIu/fy6IQkMAbZastx/KxH9HMy5vTfH3GP0APMnmchsdqu8CwnASRooJR3cH8eXDsNuEywWjQByW7zgAqu1wyptHTw5vBXl83jjabejJ38eciumuJ9QjQRp9hMwHO5nF9UR/Yzb5QYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM5PR1501MB2182.namprd15.prod.outlook.com (2603:10b6:4:a4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 23:37:30 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 23:37:30 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v4 2/5] libbpf: init btf_{key,value}_type_id on
 internal map open
Thread-Topic: [PATCH bpf-next v4 2/5] libbpf: init btf_{key,value}_type_id on
 internal map open
Thread-Index: AQHYOY7NRLAiqF+13k+lQwuPcMDUPA==
Date:   Wed, 16 Mar 2022 23:37:30 +0000
Message-ID: <78dbe4e457b4a05e098fc6c8f50014b680c86e4e.1647473511.git.delyank@fb.com>
References: <cover.1647473511.git.delyank@fb.com>
In-Reply-To: <cover.1647473511.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98ffe85c-d023-4f80-4542-08da07a5efed
x-ms-traffictypediagnostic: DM5PR1501MB2182:EE_
x-microsoft-antispam-prvs: <DM5PR1501MB21823F0F62453E2B3B2C0F0AC1119@DM5PR1501MB2182.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mufS2b2W5pXuhq4bM3qYub6NpGFYGVtQLcIDV3dGOw0bA/KcZx4eU+T8vGyde5QFGk5BCJymMK8v+Yf741lowo+1Q8RcSdJaSJV8EI7nSaJ5Ut9YC+5IsqwXTcb3rJjnvIoMqhbMqGkMxIejlaESzDTWlWWVNE7EwSEKNA4JtvJcNf9BaIqupuaXHfpTAZnOnZ5JfOg+3k64DPEhUX11BsPU9JI3yiivZsexjrpI6QIax0sJ6x97nB5K8aM2uHDqblu06+aIlCSdInG1dKdUxTHPtCERomFia6xfYyRVTB6a4txdoTLos7yem2L/y+CNoSaEG39w28nwWqhGXTbzXYeUb3Vb1X7bWRVWk+NA/O6ttBWNP8RcKHMb4Z+FQuSi2MHHHrWRaO1ddq9v6ka5ioWcgsT0N/W+MaXjFdJ5VdTxjmc+fsFXU6sm4+dY75usHzbGBepOO8w+YbBnhqo2hYM4MSqrT7qbKiHVOXf7S5lxBkbiiGkCa4rt6fX+xedq3EQlRY+nGCYVLdBrjPnmVGW534hQT4I9o0xv7Mv67d6Ws0U06B/5eiGQiKADUEG1xCyTOfjOLDfuwXCPPmpeXZUbtIVGuajb7GKY1+YYc6HVRnXqH5ZkFv3jtvFdNq/p3n/ltzVulyOPSQegojzqzu2qPfxRAweM4uhBfcBKSAk1v+QSayqB/JxlZ1elmHtkEImkMHFHNwcewA52UBwxWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2616005)(5660300002)(110136005)(316002)(38070700005)(6486002)(71200400001)(508600001)(64756008)(8676002)(6512007)(122000001)(6506007)(66476007)(66446008)(86362001)(76116006)(66946007)(66556008)(91956017)(38100700002)(36756003)(186003)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9Qb1HFwpqf2xwhrKdHSZnToGDvDeIcAZ7bodQEKAZEIGqpOJtUY42q6Pqz?=
 =?iso-8859-1?Q?jg3Z/8HGxOsd1+AMSzHtCZ8Uu/3CJhHcEhSPkVKZkWAxk4kuKOMqpqzSOR?=
 =?iso-8859-1?Q?6zl59uFRJJgs75SAsHC6zufAqDVvyHCv2rU5A/l+1y2jDHABOqYNCPT3i8?=
 =?iso-8859-1?Q?QEGJSYmT6wtLC1jZipEkeD++J7Rm5O8ivjHf908OjcgEGKJdHM3Mb1EUHD?=
 =?iso-8859-1?Q?LMMmMxpgnX1Vw5lKPI1DbVP3ZJ27pewM1QT/wXMGQ56YBRT0u2uLYlldeJ?=
 =?iso-8859-1?Q?sS2IsVxdhIyCSYSAOAVIBAGF1riELunbrn0CuDqiknrwJNb7mcufQqEBI/?=
 =?iso-8859-1?Q?VbP8Rz+OsVHqaO6HY4iYIZ3RqWemzUl2DdCkl2wa/pjlncvPy+R4O9mDM+?=
 =?iso-8859-1?Q?xEDwCa1OOjh3ogDuTCaeAiEEx3n+VuKDl0WS6BsTx8H3rmB9qfH1LUSX78?=
 =?iso-8859-1?Q?12r1EHjPMqlV9nwlFXUQ52pw7sWQrcXEZIIIvNDn0kcVMTZWrUUvLddO8z?=
 =?iso-8859-1?Q?PpJaHQkmAUPxhshWJlJwA38286i2XM/ULwwR2VanOALBEeXFZIlh4sewp0?=
 =?iso-8859-1?Q?UpExdO/Ge39HHD7DX8eMLiw8fjwbY5B4bR6P3xkxsylZgwEK/y1LaqfZXQ?=
 =?iso-8859-1?Q?JOc6JDuTzwTFvrJrvHHvJT/gSRqPZLtXh9yOTXro6GDIJg1n4gu0QzmHXw?=
 =?iso-8859-1?Q?DrHzxBUtjnmQXBt9A0kS9NzuACkGu+pwZzYOO36KsDbM/m+DEyZjRvruA+?=
 =?iso-8859-1?Q?um22XDV4yq2umL/mn7rx3fnuwAbqAIhUswwAUvG1k4K+LclO+EcN579Srs?=
 =?iso-8859-1?Q?LtF2XJk4X7VO7Lwx2YAo/Ds4EwTccaVTh+l99nBIjN/oGHIbOauOBCDljn?=
 =?iso-8859-1?Q?cHPO9Ocbe4G4LpByajxAXms+SmPOTG6qpxa7B1djgMsHc3XHLla9UgeiTF?=
 =?iso-8859-1?Q?DXj6SHUWn9btiP1ocE523aRA8jRGIR2fecy4aAnRFYRSYy15Hz4L4UZVO4?=
 =?iso-8859-1?Q?6DjYpk8Y5k1mdRUBihop5xj8z2ASwYqlbmLS3tZFVy6mda25/MwdMy8ryR?=
 =?iso-8859-1?Q?v2+4t//2m5BbYvaS4ErNrqbwvjrtzffHJ92ZLuP7i3Qx70udylu4twWVhm?=
 =?iso-8859-1?Q?Fe/ixCLBrEURRxX5OKSuCrwb3WkTGpos7BWQ/8DSARh/ouboi2pqd0C967?=
 =?iso-8859-1?Q?DPyAFl4y0Sol1ORunvBoKb34d2hbXwmOIZntgg1MOYoXv1tqJH6c2lX3Ek?=
 =?iso-8859-1?Q?DrNtkO6zJ0dKYDsXqnk4Dsc4d6Z6OQ3ycXoG7fBk7i0hdBOuVnwp7LzJgK?=
 =?iso-8859-1?Q?wMTxDn0SxeN0Zq9UYz6IsncDPrinQZQaj8Bs54ok0odIoajprFLKxjFsPp?=
 =?iso-8859-1?Q?9k6rMf91ausPlFjkmhAaVHHuJSbmNezgNctEiICbCLlKCH8iNEzdzkXFxc?=
 =?iso-8859-1?Q?wUPgGyLs/Kw5HdB/Jzc5uQXW37ijUvwYGssZb9Ofb34tn7bjiHZL5y9jiF?=
 =?iso-8859-1?Q?B7IEb1d0Cp4KPQK/YBn2xVNRG8QxiRf7t47PHCC8KFGTQpl8chOZH/F2AP?=
 =?iso-8859-1?Q?U9/FmTA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ffe85c-d023-4f80-4542-08da07a5efed
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 23:37:30.1555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eR4uU89xZW2QjR6JETnk4pt3OMb4tHNG70nbr6c8TPRcNi73FAMB8a+P+oF9iXfV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB2182
X-Proofpoint-ORIG-GUID: OzJOpmI5bt9gfp4Cg5KCVBy1vSXl62HL
X-Proofpoint-GUID: OzJOpmI5bt9gfp4Cg5KCVBy1vSXl62HL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_09,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For internal and user maps, look up the key and value btf
types on open() and not load(), so that `bpf_map_btf_value_type_id`
is usable in `bpftool gen`.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/lib/bpf/libbpf.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index aa26163e4ca1..5ff680750dcf 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1517,6 +1517,9 @@ static char *internal_map_name(struct bpf_object *obj=
, const char *real_name)
 	return strdup(map_name);
 }
=20
+static int
+bpf_map_find_btf_info(struct bpf_object *obj, struct bpf_map *map);
+
 static int
 bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type=
 type,
 			      const char *real_name, int sec_idx, void *data, size_t data_sz)
@@ -1564,6 +1567,9 @@ bpf_object__init_internal_map(struct bpf_object *obj,=
 enum libbpf_map_type type,
 		return err;
 	}
=20
+	/* failures are fine because of maps like .rodata.str1.1 */
+	(void) bpf_map_find_btf_info(obj, map);
+
 	if (data)
 		memcpy(map->mmaped, data, data_sz);
=20
@@ -2046,6 +2052,9 @@ static int bpf_object__init_user_maps(struct bpf_obje=
ct *obj, bool strict)
 			}
 			memcpy(&map->def, def, sizeof(struct bpf_map_def));
 		}
+
+		/* btf info may not exist but fill it in if it does exist */
+		(void) bpf_map_find_btf_info(obj, map);
 	}
 	return 0;
 }
@@ -2534,6 +2543,10 @@ static int bpf_object__init_user_btf_map(struct bpf_=
object *obj,
 		fill_map_from_def(map->inner_map, &inner_def);
 	}
=20
+	err =3D bpf_map_find_btf_info(obj, map);
+	if (err)
+		return err;
+
 	return 0;
 }
=20
@@ -4873,7 +4886,7 @@ static int bpf_object__create_map(struct bpf_object *=
obj, struct bpf_map *map, b
 	if (bpf_map__is_struct_ops(map))
 		create_attr.btf_vmlinux_value_type_id =3D map->btf_vmlinux_value_type_id=
;
=20
-	if (obj->btf && btf__fd(obj->btf) >=3D 0 && !bpf_map_find_btf_info(obj, m=
ap)) {
+	if (obj->btf && btf__fd(obj->btf) >=3D 0) {
 		create_attr.btf_fd =3D btf__fd(obj->btf);
 		create_attr.btf_key_type_id =3D map->btf_key_type_id;
 		create_attr.btf_value_type_id =3D map->btf_value_type_id;
--=20
2.34.1
