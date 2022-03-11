Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982854D565F
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 01:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbiCKAM5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 19:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238512AbiCKAM4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 19:12:56 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C411A06D7
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:11:55 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AI5B1L000813
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:11:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=KoRasJeQc51+s0yTWQh4tVrM9f6vIxNbliOLO/4tPk8=;
 b=rnekLVgCbg/JxBEZmOD0BPhiwzRJkE2JC7d4F0rgn0ePu6iyrp0X5lB84jpPx1yJk1lH
 qnsBp3ube0u1UmypGSMV2qw0HNEU0tew33VDk6+mWaZwNGHlQk9y86ZAnFI+Kyewl4R5
 iFCABCb03lpZ32pRJn1rrPqVTbj/MbDmI1o= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eqex2dxp2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:11:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipcyMWzxyIAATXIdY2fDHa9wWYo0+0GilQXSsgAVHl80L04Onl0lMo2x4oAWn7sXvarfzYVx846XJlAfIP9Eedp49aY27qSFvXm9EnJJxC1yjE1g+KasbQRFPiWoJCaZAGCVjSw9cMK0fKoKX+ZHbyU5R89Fk1rwTSb8IFUukHJf1kK65LRQl1dE3DMFWa7Wrk+xRYq74R7EqvcSRZYEE2O+Zn4GUuNfd9S8ZzXs3o/jNG2hBs6Ggo4qaQehHS5vI4PUbcH4IDYHSOxmHiXOc4XcKMgs9Jgz0zAzcTU+wZY4fW/sHoCHO76lidW4QKO6SkPWrE1PhshBLbRgW448dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoRasJeQc51+s0yTWQh4tVrM9f6vIxNbliOLO/4tPk8=;
 b=gGEditOU+Kh5veQGrhc0bT17MbwdaO9n/eNUvJ5EHqVTVh/27CPj2zBMep/ouPXLM4FA7jq2tNJ4IrCM5hojas6I3/ZnuRbjkjBWZ7W4/t74fRaxT8tyNX7EMuqsKoh/7wC9QhWweyszTTsHv/0lkB1uLcVXCvvuM2yK0lfJi78nouASZ4Ujsqyu81xV7fIlMyrPXuslOvrVX8wlcC02s7E1JnWy4bAdFTQahs285h6rkQcGom0NjrzHt4/pdtOjv5Iz14VDbAGitalkfVIll4Vg95PJcZZzuRlCquakjgIwosfa7eX8qlpQjsUgY5Hs4lmlUURZBBCx9dUDAI4t1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM5PR1501MB2070.namprd15.prod.outlook.com (2603:10b6:4:a9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 00:11:52 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 00:11:51 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v2 2/5] libbpf: init btf_{key,value}_type_id on
 internal map open
Thread-Topic: [PATCH bpf-next v2 2/5] libbpf: init btf_{key,value}_type_id on
 internal map open
Thread-Index: AQHYNNybmf6YAzvNikeVlKvsicc/SA==
Date:   Fri, 11 Mar 2022 00:11:51 +0000
Message-ID: <6d868b6effca2549681a9e42ccbdd71aac6287e8.1646957399.git.delyank@fb.com>
References: <cover.1646957399.git.delyank@fb.com>
In-Reply-To: <cover.1646957399.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f58a83a-3915-4916-8c28-08da02f3be28
x-ms-traffictypediagnostic: DM5PR1501MB2070:EE_
x-microsoft-antispam-prvs: <DM5PR1501MB207012B4CA4DE7A0BD83B888C10C9@DM5PR1501MB2070.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LbZ6jOuQ/ImLRyJqNSUGZw7uK7si9aK0Umd9RechckzfGa6jmP+xXudZY34OGHjIxdV6pi+Jh1BERE5HFA+elO7Jb6aMhuZZ5VYViHJfklI3zNRJsBSPGi5JyYtz4hbvQFQeVDXFO90riIgr8nrDcMe/Y/UOOa4kLPPnMe1BFL1F1CoSw2PU2S5WfppVcTTKAOIO2+cxGV5YD2dlZBRa5bAXWosjcAjv1U/8UOsx+TqgaLJm1qCobpoDDdnDChvfmxozXW0qrdM8WmfmiHLZPWs0gDt5ThUnjdvRtZQvC5oDsp17pMbsWmIm1mubN0Y70M4Gnm9GxC8x3MdIegepqacXO94jBpsydcaDRtvncw1LjdpWPE2FM4Oce2dRN9lCOil7HLQOlzRlHByp1C82FNzCZd3UTdQHVF0W3aJh1dgKNSQgJPygPhTWjlQ+1KYoWzjtYHzDk3eXQ/hpUYeDByZzYkOqLuVUN3xHZG9g/VZMDCB/KNg64wN5O221Xf2ldH/4S/geMXKSyjmHQs1p1NB0q7wbGdtxwpepoF8oh0P4C6MDNiZtjt/Z/vWI9dXiEsFdab2LmH7ZXP9gh3JoUF7onJ/XZbxF+tcBUjFWUb3XFM8G0Z7Qx3kWbqAe/XzDiT4wEgJXqQCpxUWs7zxsK4QcqBwS9NTbDYGQ5FKgoRm7G07q1pvvMSdusGS7T7IcKjX8fPpWf/l3RVOA6Ij+2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(38070700005)(91956017)(83380400001)(5660300002)(86362001)(66446008)(64756008)(66476007)(66556008)(8676002)(76116006)(66946007)(8936002)(2616005)(508600001)(110136005)(316002)(36756003)(186003)(38100700002)(6486002)(6512007)(122000001)(71200400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?w8cO3MRvInWGUaTZSmmw5fQego0NTLNCkUdWdU9K3Ra1/4Ho514LbcaOp4?=
 =?iso-8859-1?Q?opROvzphCvHlxwz01MStZ6bIT+dXGpDmp4thzQNuws+mWHYP4Nv5SuZM0Q?=
 =?iso-8859-1?Q?35mTE0WNdFcux4MBpUGWzlf5I0zi3ePll3qGd/RmHPGuexLi/xmR/tzak5?=
 =?iso-8859-1?Q?fAlrZzVghwcWTz5LziuH12H6sKT2lZ3dGYN/hX1HfAxun6l4sBnFkFze9g?=
 =?iso-8859-1?Q?CmYCTPLcAeOr5M5q3wgyR9pr7/+MJtAMHgzLcBwlAYXJYzH36ZoG3eMQYP?=
 =?iso-8859-1?Q?44aHqHVbqwQG/49HENvMln4JL/RBedsSKdAFJyFhqi99AChlV0fwCSBUgX?=
 =?iso-8859-1?Q?B1cpaUy4uPZpmvRRzzDOzcZZuzfXqBEEeY00xmkaB3tx8xgCMjM60/EYHY?=
 =?iso-8859-1?Q?QTtzva538jUdajJ7SugU9DqXduQoh4wxZxtFkUHHoZuF3J4h7m/fbM9FTI?=
 =?iso-8859-1?Q?y7HNcAg2wYx2FxNGptlxEEEqU6ZPjBdFi2w9KbnZfl7wbkgpdVO6P/l7Cm?=
 =?iso-8859-1?Q?g0Obxv76YbXPlOsATI5a3TusZEMKl1HWe8IYZ7AxqWyCUfrXh6Va2wooo2?=
 =?iso-8859-1?Q?IkHEcgoKtUKLtsec/qAXO0GOzthnkg61Quc4U9Tzd1eISd/NeTekY8kR9V?=
 =?iso-8859-1?Q?SS21iE9V0pgmRfBP/E08G9k12wOGAknyAPYucRZbA9rhXacMmmSuNABqB4?=
 =?iso-8859-1?Q?T6m24jY9D5I5f/6vIYIFuooMSOmumImjNy4HO3i/l1Ies4X9v5a1sqBbGb?=
 =?iso-8859-1?Q?pb2vDNvNonPkVSUOe96YTsy3IvcU6E7Bwv3lJHYJGf0Zx47RxRAy9q7ayR?=
 =?iso-8859-1?Q?e0IDWbMlg5R+AgnVu8EPLGrSrE6u92rLpa9wBZ08l6/8B97vjPlJItX5K8?=
 =?iso-8859-1?Q?JchoU5440qCztkV2WXuvqVwhJTy+GBxg3hWvIpSvzhj9AL7fXtPdgVaOuq?=
 =?iso-8859-1?Q?Si1ovPhlbpKUr0rvdzdOx/PgDySZNfGKkws5LHTmJeinejCMapKrbxfkK2?=
 =?iso-8859-1?Q?FWEE4vqGFPSRQWJNf8yPOUp7fcM25AThCd7mUgEmhlFHkfmj+tGltGNNj5?=
 =?iso-8859-1?Q?IeiSFYdR7LTHv3denh63Rhb155CvGgy9YWnSHBu/bsN13aDUnI4zeWH87q?=
 =?iso-8859-1?Q?dxmJnKMCCmuogymouHWKlu3pJjQDhBPk7IlaApwNcNDH00C4C26sqImlai?=
 =?iso-8859-1?Q?3fVmJHmVVGMrP4XWjmo3y5zmpq8AqNqFCzr2bJ3PISTlnVCsKXOSE5vg08?=
 =?iso-8859-1?Q?lWXHFt2VTheZZp0q6vXozZ3j9luKmL2XDWioK8LbGf8SRImi5HyGzVp6J4?=
 =?iso-8859-1?Q?XaRgjEjbYPTevpjXwzkq97TQYNA6bmCPtpu7BNNjAzTHjPI1ZrXUTZj18X?=
 =?iso-8859-1?Q?Lao+uhP/arHwfyXATBNKFekyb3OmTojDoFfvnyjWZL9CLx5E91xAypCSKG?=
 =?iso-8859-1?Q?PMsmPpGi4GbxyyPFtQLKiA93t3xOWgrOkPRa1kbzD4UfS0unWJWvQXwfXa?=
 =?iso-8859-1?Q?mzfDhcpRRSH1a02tO7/sUYsPfgcL/abrVLaouPelwUjJPbxtbf7348DYw1?=
 =?iso-8859-1?Q?lFwVFzU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f58a83a-3915-4916-8c28-08da02f3be28
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 00:11:51.5733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K131ka128OZAr2YsCyJ/hENLyqrkTAa7gk7qXrDG0OTVTTdhBdpbRcCYLsko5qvj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB2070
X-Proofpoint-ORIG-GUID: 81jvI3oiplc9P8AFLH_3xV1uTSkCSBPq
X-Proofpoint-GUID: 81jvI3oiplc9P8AFLH_3xV1uTSkCSBPq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_09,2022-03-09_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For internal maps, look up the key and value btf types on
open() and not load(), so that `bpf_map_btf_value_type_id`
is usable in `bpftool gen`.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/lib/bpf/libbpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b6f11ce0d6bc..3fb9c926fe6e 100644
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
@@ -1564,6 +1567,11 @@ bpf_object__init_internal_map(struct bpf_object *obj=
, enum libbpf_map_type type,
 		return err;
 	}
=20
+	err =3D bpf_map_find_btf_info(obj, map);
+	/* intentionally ignoring err, failures are fine because of
+	 * maps like .rodata.str1.1
+	 */
+
 	if (data)
 		memcpy(map->mmaped, data, data_sz);
=20
--=20
2.34.1
