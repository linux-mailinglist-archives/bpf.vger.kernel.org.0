Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2520B4B5F05
	for <lists+bpf@lfdr.de>; Tue, 15 Feb 2022 01:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiBOA05 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 19:26:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiBOA04 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 19:26:56 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DC4B23B0
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 16:26:48 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21EKsVpV005712
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 16:26:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=mUG5eWoLRRI4shMB8BXl7tlfAEz2r2mK3MpwzT9Z96Q=;
 b=oWleQvNPs4jEsY8MbAdv2V3nCDh3yoiVy+yS7NiRNuqZr+iqQKVPHdkcrWNcF4HxUF07
 lAX+KLajBaA2jbd8qm0lYdQ1h2TbiCL5b1wD2gJdi4es8B/7Ppwfhx8BQRiWUDu9jqLs
 C13YHet/CQqHEe3i/hKyJdxmgi7wqaQDbrs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e7rwa4b2a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 16:26:47 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 16:26:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKAcUAyTncLlXrQyUnRuCxly67PWI80JA9gAueX3nehak8jgz+7ia9X+CmIkotlmGbYHK6GfDGld8Xp93tgUk+D10gkP7uISqnmYUpIsgHPQEQ8E9VPi51CI6n2m3W79D1yHH0yJ3y580/s7uNrjKmFM0DhlgFe/V6lC/bgYRwj20pTUyYrZw2wNp2uP+dQZLHD/O7uRkPBsUgMpBZgDUtGnSd96YKirk1onpKE2G8g+beklN/z7GlkWv49jViBC0gi2viAU6t05Xww8GFUJ1oiEVJClKyQNNcOzKZBVAq4nLcCmFqeC61fXrtk5ItwMHZs5oKSZk//Q8ywUrdAc5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUG5eWoLRRI4shMB8BXl7tlfAEz2r2mK3MpwzT9Z96Q=;
 b=ebnEHv/7iHovtDFFAuR8x8jhRpt5KOoDxwH5W6mjysWow4Kn7UHZOpdwfdQ09alKJOu+k8xlg9oZ5PUVlS5kuZDXTNW9a5J5yU6IeC7cmrKw5t86YmZAEtA3ebRwl2iKQQNVziVAmAA5VTVLh4MtBbEt48spEe8NHgUuJCrH95m2d8dVUMHK+P2OJ8WBx0WL9kNa8Uav6QDJpN3WF5t0lHGpMti5kFWuDV8cUclAzIIGTY/CA0yPChNgJ3iTQCCdFwe3ckujmWD580/00/wWcZDCLmChPDsbCd7HG7lheRT5ZjCkBGGkWwxb9urOwutUzcg2FsO/0CyM1c5Ircg3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by SA1PR15MB4934.namprd15.prod.outlook.com (2603:10b6:806:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 00:26:39 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7867:90d0:bcaa:2ea7]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7867:90d0:bcaa:2ea7%5]) with mapi id 15.20.4975.012; Tue, 15 Feb 2022
 00:26:39 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v2 1/1] bpftool: bpf skeletons assert type sizes
Thread-Topic: [PATCH bpf-next v2 1/1] bpftool: bpf skeletons assert type sizes
Thread-Index: AQHYIgKzExSr0YhqzU27xgI6sAKxDg==
Date:   Tue, 15 Feb 2022 00:26:39 +0000
Message-ID: <6c673f48d35fd06bc3490b00d4e6527b7e180d59.1644884357.git.delyank@fb.com>
References: <cover.1644884357.git.delyank@fb.com>
In-Reply-To: <cover.1644884357.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6bab463-a275-46de-f868-08d9f019d59d
x-ms-traffictypediagnostic: SA1PR15MB4934:EE_
x-microsoft-antispam-prvs: <SA1PR15MB493469B3D0CCADBBDF43E6EAC1349@SA1PR15MB4934.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6jZxlyytnirBF/pTKgyp6l/6H2yyuEMONPBdhb3XIbwVIexsUoFJo8SzYKz/qs31gm1VppFJ0bZaizZmg0KpfTqIw2bOxMEbs2IYaa8/M6a90cW2eU98+4Hl4zaUJKNTgCDoLTTg+evsNUUqfdaxNMsBHkrROdDbfqJQabdhm0ky75V4oS0M2SueTbVgQCvxEBXvKHQ7WYfcdu0YjlQ4DLABNXTz+r4ZQe6WXVz4YXsqvZ7nYaqRlsZLGk/VyPJXb1Va9rHk7EiAq/bz2gzslEZmpdJN2RghfY329Ssb9YyQUiglCQyoNIYWalwKBLXLtTM/c7rfO2kCcEQ6edbWa2HnzYgpgY3YT1uPFNDb+dXNJ+hmcSe6XxwpbraC/r00OiN1NjGAHCUnMyusZQI8SowbZQ92NxQ+AKGa68c5pAsqdnGvq7LcMuPJlno7XLrgk+wTXEXzu5KkkOj3v7lAd4Sou/p80so+Vhr5cXKiMU1UMXIGKK8AmqSwNdEUsmGaAVUgFNzboXg8I76K3M8rLOL2KriUybVB2Ltc1xO0/4eup2riXxObLnjcIS1wxaWudBqD/7YVrfyXBpNflZYuZ3jGxYWnzSUCKbb/Yop53g+tjLXMrwL53aRfZ9ObYOmYrTWMjYhOgDCq0UAGTB8ZfSK6wQOvYwXECjEqTH8R+KXNn8J/qWHppR5B/hOk1rJp5gdf5TNc5KYdF3HbfYxLTtThB5SGdpWcNH9VJelDJBnhXPmwsNVhZiFPjltn7hcfC5BYHMH1Bh1GKqrn3w86QByY8ZbDJr+1JjEfMqMUkISlRlw6dB1OXoQTJaECixkMEoieTzczu1VMQhDfgwD4BA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(2906002)(316002)(8676002)(110136005)(66946007)(122000001)(91956017)(66556008)(76116006)(64756008)(66476007)(38100700002)(508600001)(2616005)(8936002)(38070700005)(5660300002)(83380400001)(6512007)(966005)(186003)(6486002)(36756003)(86362001)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VT7nid6LEW08ud0dT9VuZstIxoIDba4x9QvRlFkMXkniIvWuyyudwNJheW?=
 =?iso-8859-1?Q?45XUlWcsIBueu0+G5Rbr5hKZsFPCuTezMkCduMH0ZkoWXtE+8QUQrtuLBx?=
 =?iso-8859-1?Q?LyPcH6gM94/9d4pxjf2m6KuJ+QyTMDZk7Vi3HAi9Stci81uySpNthN8l5g?=
 =?iso-8859-1?Q?oNekrVA/liPLWk67EaKSIlzH7PgGi1ZcRTwWF4R9Q0JpBNdOBsle3qrqhE?=
 =?iso-8859-1?Q?YJCS5AT55kQl8pyjY7n/29K5+tt1MoIRpc4Ss2xG5ugXSJVgwNvTcgDLTx?=
 =?iso-8859-1?Q?+Tb0LaxZc/vtelR7kZxupbCtrHaUkknjfBsRK57llprnj1ebtTE6Sr/9Ao?=
 =?iso-8859-1?Q?9Y3BdmDJLwELJgYlARx5RvsOQzXAABesMUSvj197e829AYC30BUy19mDyU?=
 =?iso-8859-1?Q?QPNeVJH/jo8M1b8+OLaT4qWas+ASsQtWe2WxMp0iTIHvDvE4ZP+J5Y/0tf?=
 =?iso-8859-1?Q?foCxxjIkOJEKW9YyO09aEvABoSChSn+errQI0XEskiAHYsWcLVsSd9tkay?=
 =?iso-8859-1?Q?0AnGwBqVvoqZONZp+QcosgzXJjs5lSXzUCLi1Bj3KHufkc4NIiG3sVEcHe?=
 =?iso-8859-1?Q?yj9xW2PqEs654wpbYkqRp0NwG9L0JPWfdYXtClt/1hp2Uxb6h7yAaED/jY?=
 =?iso-8859-1?Q?66EqCZowRBZUf3GoMsMYSTrPppVnrnV9zTl3ngU/wxxyRnNFwhjsSPoAzp?=
 =?iso-8859-1?Q?Hd9g0sMVJalJEA60KfWGeoC11PJu2jGthVBF6QXWM6Cyfoo7VP74ByxiM9?=
 =?iso-8859-1?Q?DlU54ZxEgHvt6E5tHH1xpqdZiufgrShVfDFdDT6j9pZVAXeNunqp2Nh8/q?=
 =?iso-8859-1?Q?qAsNa2GEMmHp4SuHtlBPQmPYSLiHjR6Hq0+C6+RyDTNwzEpNval4pV5C65?=
 =?iso-8859-1?Q?F0kY2OZuTjQ3EBVaCIhflkExV5ppVxTVDHyB0Wsl3OygV4oWWZ8iLg7Rhl?=
 =?iso-8859-1?Q?MLDZGzew9R0jZLHofIzv40JS4BLS9tV3rBXq7t8RUYc1d37FAhhs+mILBu?=
 =?iso-8859-1?Q?sWn40cEC30zLnmRs+wBZs+wWHs40i/8XOLcYd/EONMMNWbEfrWHYHHWQSE?=
 =?iso-8859-1?Q?ZD5DQHFGwP5Ucxb5iPmN164qy+ZLMhdzMtrDAqIxtTrTxtZTGFyj0U9Ssb?=
 =?iso-8859-1?Q?XJAc0kglRuQ7XoRXjcL9xbmlmVVtYTZgSEW4nIRQNHEAUYfwmB3MlMNA2s?=
 =?iso-8859-1?Q?DLWjPAyPxTlk3w1biBlPsKS+GW/gFXp34c9gJ36h4uiSAeq7PP/2QPxvyG?=
 =?iso-8859-1?Q?67Fj7NjQ8rrJre6ndIxR0ZDbqqGlmIMV934rwARdabLFOFL/EhojMWLhbn?=
 =?iso-8859-1?Q?PzzDSQsGdeP9KePuI2BLLEkhiTPf5YY+ePmN6IjypJxLiKFjkTW0vfkZjg?=
 =?iso-8859-1?Q?kEWmYvmx2WeOaRD/+Z073NcQJjRGIkBSsH32cMPuDIk1GOpqoinkjSsd/q?=
 =?iso-8859-1?Q?KADjqD6CNK2GLDxtym9ZFQ8QU5Gxqo9Px8fGsJsZVJB0okAy/MW6uRGINi?=
 =?iso-8859-1?Q?LVHXel3YRoskrTPLGAEL5VKRFTjciUDww3sDGS9aPdoCQFy7wqB2lRyrMT?=
 =?iso-8859-1?Q?JOIyPOGcacMlmLvaZQmfukrnD1Fc6lvdC8Gy0TRpSukaElCRA7w3sojg5k?=
 =?iso-8859-1?Q?dHzcAQhg+jXWWuDf4/vM9xNDE1Pw0xQ3eKdpzHAtL2IzHXW2T+mn++sg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bab463-a275-46de-f868-08d9f019d59d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 00:26:39.7134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wtWw/t1wTUSORVUVlyyBKTqJgDCRbct2N0zKq+r0HLk8Qx98PnG+y/Db2DCWzqoW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4934
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: UvGkoSPSizvD1OA6qAxut9qs4B03sLUq
X-Proofpoint-ORIG-GUID: UvGkoSPSizvD1OA6qAxut9qs4B03sLUq
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_07,2022-02-14_03,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150000
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
 tools/bpf/bpftool/gen.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 6f2e20be0c62..e7f11899437a 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -205,6 +205,29 @@ static int codegen_datasec_def(struct bpf_object *obj,
 		off =3D sec_var->offset + sec_var->size;
 	}
 	printf("	} *%s;\n", sec_ident);
+
+	/* Walk through the section again to emit size asserts */
+	sec_var =3D btf_var_secinfos(sec);
+	for (i =3D 0; i < vlen; i++, sec_var++) {
+		const struct btf_type *var =3D btf__type_by_id(btf, sec_var->type);
+		const char *var_name =3D btf__name_by_offset(btf, var->name_off);
+		__u32 var_type_id =3D var->type;
+		__s64 var_size =3D btf__resolve_size(btf, var_type_id);
+
+		/* static variables are not exposed through BPF skeleton */
+		if (btf_var(var)->linkage =3D=3D BTF_VAR_STATIC)
+			continue;
+
+		var_ident[0] =3D '\0';
+		strncat(var_ident, var_name, sizeof(var_ident) - 1);
+		sanitize_identifier(var_ident);
+
+		printf("\tBPF_STATIC_ASSERT(");
+		printf("sizeof(((struct %s__%s*)0)->%s) =3D=3D %lld, ",
+		       obj_name, sec_ident, var_ident, var_size);
+		printf("\"unexpected size of field %s\");\n", var_ident);
+	}
+
 	return 0;
 }

@@ -756,6 +779,12 @@ static int do_skeleton(int argc, char **argv)
 									    \n\
 		#include <bpf/skel_internal.h>				    \n\
 									    \n\
+		#ifdef __cplusplus					    \n\
+		#define	BPF_STATIC_ASSERT static_assert			    \n\
+		#else							    \n\
+		#define	BPF_STATIC_ASSERT _Static_assert		    \n\
+		#endif							    \n\
+									    \n\
 		struct %1$s {						    \n\
 			struct bpf_loader_ctx ctx;			    \n\
 		",
@@ -774,6 +803,12 @@ static int do_skeleton(int argc, char **argv)
 		#include <stdlib.h>					    \n\
 		#include <bpf/libbpf.h>					    \n\
 									    \n\
+		#ifdef __cplusplus					    \n\
+		#define	BPF_STATIC_ASSERT static_assert			    \n\
+		#else							    \n\
+		#define	BPF_STATIC_ASSERT _Static_assert		    \n\
+		#endif							    \n\
+									    \n\
 		struct %1$s {						    \n\
 			struct bpf_object_skeleton *skeleton;		    \n\
 			struct bpf_object *obj;				    \n\
--
2.34.1=
