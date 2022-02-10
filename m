Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1163A4B0201
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 02:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiBJBWr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 20:22:47 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiBJBWl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 20:22:41 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F58E1EC47
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 17:22:43 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 219NYHi3029395
        for <bpf@vger.kernel.org>; Wed, 9 Feb 2022 16:36:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=R4upJ/IquiANQLCltuWGGy6R+6bn4TGeOOM0s2ESvlI=;
 b=S3bEXS0YIC0gtKu8HGdQvnaMH2BcbotPSZSEnvTBNTKWiTBVxhOfSNb+pRE89OtGonfZ
 EnyprmrHv45cIN3J+SyTMXscRVb5w2zxkrHSjxzfjOjJub9sih3hhcrvEQdNQiTS5eJG
 0Oq/A45YslDhHliA/IJTZVCsEKRkKKe4dcQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e4e8nvnfh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 16:36:56 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Feb 2022 16:36:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvbck3W3OrA1JbEzws4ujK9LBmRfsv+/FkQoyKclDGIN5lOdgnV405grqHBmXwc1XjcBvInv37hg24VlRJBLc5u9N91Ju5K4TWxUPaWQhUbXQdKmFA3BxCtqbsYqd6ijoSuk3yxZezvdcL2WYRFzul3F5cOKD2By4vzV5EjejMsoTCCZuICSaVlC+Yj1vp0bkpCf44i7CmEKUqIhjgLtf22r1id1ZjlyT1XI4OrMYALlUqSRPhrvOv+D/281QR8OO86Hn3/Ou6OgdgLeD6Ce2T0q6pgSxLJxwsH7ncxn2fXhkwEZuNHuJur3g5q/b7dLJ6c4xsxYOcXI1FJll5RZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7khCYI7ljTUwy2g6JN04oaknrH1FRqkmEHyG8PhDaks=;
 b=eULv4WZ3AxmwLv8nGEJus2jj4dVc30BwQiaF8STmhoVQPt2L8hAajRVgGCbMloQGrv0al/m7h1RYho5heSWYnpyg9gojI82elcgWco1dGFthjyJOniArBwps1o4n7W7s5+/qNJ0KIwB/Kqduq7xw8R3iDJuldmEsgNGtNaf/91WQrG2abYNR4oJRZqkU4P8Q+mfcyCjLph/fzB0Zu/LCsjjfDV9UvCGC7x61XZM+0IumdFGVBBav2pZgZWFKKnSxniNveRlWcDKOSceVQCMhEt+khvkzGyCAnnGWY2ZvynwDi6oRrQ9LagRHKJixO4CObByWG9+Jd7wynFL3wBoiYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by CY4PR15MB1590.namprd15.prod.outlook.com (2603:10b6:903:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 00:36:54 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::f1fc:6c73:10d4:1098]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::f1fc:6c73:10d4:1098%6]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 00:36:54 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v1 2/3] bpftool: skeleton uses explicitly sized ints
Thread-Topic: [PATCH bpf-next v1 2/3] bpftool: skeleton uses explicitly sized
 ints
Thread-Index: AQHYHhZN/e7JuZr7akC7vD+AXIiWjA==
Date:   Thu, 10 Feb 2022 00:36:54 +0000
Message-ID: <b904faaff6e8a04809e722d33e062ad47e97c84e.1644453291.git.delyank@fb.com>
References: <cover.1644453291.git.delyank@fb.com>
In-Reply-To: <cover.1644453291.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65ccafdc-641e-4f2a-9f16-08d9ec2d6fd6
x-ms-traffictypediagnostic: CY4PR15MB1590:EE_
x-microsoft-antispam-prvs: <CY4PR15MB1590EF626466CC47BC8779C4C12F9@CY4PR15MB1590.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bz2Kao0FB4pO6u5aNaF+PDuHRoyCIO5ohkwjd8fXopDm2wNntrqMhLZn2IbAFXmLKsklxtHaVuc0qdpB7Ys2/549ZaxBRc2FRG/Um6l/EyG/cGVqCg+eum/eJO60z4ssSHU8MwQFWrYvn+YQnj9kp43wBUoLUleB92nVV7n32Hn2SQIef7ewV4tRHf+RtiHJFIpgxSQ5Ib/jz1HQuAE1Y0RyoRoGY9hOUOxtU/ud+8T743YNWsJo8N1P4XIhWRA9l8olsDM4fTrPRVJ1rySBBD3MFyL5ODbiMwqCC/DNUv07dZnfGHmkKYKSRqV13+AfNf/rOhZeYV+3stMfAtmj30jLr+NqMp6FVQASYyTj+cfIGqSIQ3w2Cu8Fcv6FphXayIL5mbVMGVAfNc+BjcPYWvJyvyvBYS/BMcpjulkuZjQAth1iXgzsQlKIkmSIWm36mf4ZuAvbL2/LJiPjVUkL1djddJDaKJ2ItptZv/yk+TQtTwRWLScYJXL4AmXTmuiru7YUHKUOr3BbJQg9gu2lfZN7pzJROcJLkWftx2xIVy/H6RYpdMCYyTHLszzmbRApHntrtCwSti/jerBIH+I/HVbLxM7YH2V0a6Tt0bhPQ/WKT2w0ffe5DMoMi/yq72LnMMvLhgvxXxvlp3BcSSutZRejyN6FNuE7K0IA8tmSq/ZWMn2AJjTEFlomb62yccpdVLJ4XVtvQSkGU0zqiz1wOqY5viekuvvPzRBSl9rupxEv1oLx/O7TfZdxInyrD2mExtENDDV4ZGzpWxYaMN6LrLjo23ZADHJQw7U+/OFTvrY/eY/FWdki6D4UipGMLxdoPKXGbn6GzcLi2KQkbIcXQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(316002)(8936002)(5660300002)(110136005)(2906002)(6512007)(6506007)(122000001)(508600001)(26005)(2616005)(186003)(966005)(6486002)(86362001)(76116006)(64756008)(66556008)(66476007)(66446008)(66946007)(71200400001)(8676002)(36756003)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eWCnabsD9Odk5SDd/HutxxIWxYTKMWcurTjMBIxGn8DE8Z5556ODDemp78?=
 =?iso-8859-1?Q?e08rg/r+QwcxMCFOXPyzHaYnsuML2Yf9n1S/xARy5UoOfncJfmGZN742Am?=
 =?iso-8859-1?Q?+I2cYXufdFVDuOr2lg3muXd8EeW7aL/+cAt0jsJxe91BRT32yinjYyoTde?=
 =?iso-8859-1?Q?jqqpVpRpaBrroOo96OjRVedrsL/cKoeFo73+e6WJCCfM2IbxL1+w/hhrx8?=
 =?iso-8859-1?Q?TkOTX+Hgh7XR+80OmKRhaf2Kk5Gq8EuR88VpFzMC7A3DkFad/QT53SLfWH?=
 =?iso-8859-1?Q?dfZxeX4uNEK2jcZ+Ce8cFe7Y0zG30g/UohcFPoQXVJMVjXoaI9qvyjUf6K?=
 =?iso-8859-1?Q?uTFOAmmPPF5Ngi7u8GlLRziNj74HiA5vaDW4XsADGORI1Pk24h/IKpVLDf?=
 =?iso-8859-1?Q?eOq3lRL3Kpjk/h6GsgsLQ0TyIK7TvLHAEF1WGicg3zUU+Y5s/CAvwq8NKf?=
 =?iso-8859-1?Q?ep4LyIZhh+byHWnBE0+vVRfe4KhbwPCSaGsHWupSNt0WX1+gWBnnqE8n2A?=
 =?iso-8859-1?Q?GMQ9nhalzDE8UyA5tgskarzwsCkZW4YyUW0lo9LmnJaBVOJooge25qFP2P?=
 =?iso-8859-1?Q?+gtyQFJWqaUNGsoSqaRVFe+9aJvsAbpNVuIC5pi8aLxcTUNPJj/3u96wb5?=
 =?iso-8859-1?Q?/p/gjbtfV61ShUIvIqoNN2B1w2gyuM7+3aAWhXS0D6W7/eRaRDxJSM121e?=
 =?iso-8859-1?Q?AFUHWvJ5yzIyzkbRzyD5jVLBr1acSAWSOuIUm+9EM3moOCcFONbYaPRtl7?=
 =?iso-8859-1?Q?xrNNz3oOPN6Fi7G79NZgX7eC+2l4fEnXV+v1GShKfQDTUxRGWlzoA2+8HC?=
 =?iso-8859-1?Q?yan9J9RppcTgHTExMqIsU+AUhlNai3jMzD1WIwT+o40FfA0Dn4iQ5xmHQJ?=
 =?iso-8859-1?Q?PyEiltDFZy8k3qy5iK89XMHiMi6RFoTMJqEBuzgTjbCm+MbEHwTYsyuuCN?=
 =?iso-8859-1?Q?EvzO11PNEjMpUDH9OjE3H3Cwnt8+B8nBvwmzZA5ePvqvOk4jlETaupt68Z?=
 =?iso-8859-1?Q?n5shpuJJNvUx5N6ntjhQHSJ7QvA2HF7NCbIN3Ux63WyfNLGOTWbpHy1B3h?=
 =?iso-8859-1?Q?tlFRZSO2jt2xFkNAyPyzAMpGpGDegBuZmmQoKXFAciHlm8yiJECx6IVCM5?=
 =?iso-8859-1?Q?AJIYcTHbunXnPvvM2RPy5JQ1y5u821i7BOltikvWvdrlrI2tB6YSkZWsyr?=
 =?iso-8859-1?Q?yZlqVcIHAQuFIU8OaRl6wmHFY4hIAKzDaZT3cDwC7KxYLwHnBC0529q8zz?=
 =?iso-8859-1?Q?6V++tkhujJtb2S/cDtZcv+6wucjWBpq+7Ql4+RlmJpcg4s84bmCKU1lWlD?=
 =?iso-8859-1?Q?S26Mlu4nNEYBDoHlbWf67zIOCh+kZXxpN7G/To1j2RzcA2dU6hYI5BvXlo?=
 =?iso-8859-1?Q?RILkrJTmfpVu/nlaoxas9hv9f+CYFeAw6J6pBsigKlGqMshnnCnpVQjXpC?=
 =?iso-8859-1?Q?T4dXYheGTOSLVzrYT1pAuGnzLURVkmUptjkAi5D+bHJ4TmkTl9nxxUHVuX?=
 =?iso-8859-1?Q?55FSl87RkFdfUZktK+xbu/l8wRkkIwWl+mpMK6vntaGbcisqw/q/J5t/Lu?=
 =?iso-8859-1?Q?RFLgIpUrXYorSHji3cJpZ4C1MScqgHRYDXkiAukLwuEu35sHYH6fqD8gVr?=
 =?iso-8859-1?Q?ksDD4rgkxZiSs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ccafdc-641e-4f2a-9f16-08d9ec2d6fd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 00:36:54.2562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rz4yeClBEvfPm8uVYSU1meZWG/r4ldwHXiP7JIKrAyiyxE9Hiip29v4TgqRF5MYv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1590
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 4Wm11nyt7NoezmuKiSwv7qdx7puD6h7L
X-Proofpoint-ORIG-GUID: 4Wm11nyt7NoezmuKiSwv7qdx7puD6h7L
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_12,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100001
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

As reported in [0] and [1], kernel and userspace can sometimes disagree
on the definition of a typedef (in particular, the size).
This leads to trouble when userspace maps the memory of a bpf program
and reads/writes to it assuming a different memory layout.

This commit now uses the libbpf sized ints logic when emitting the
skeleton. This resolves int types to int32_t-like equivalents and
ensures that typedefs are not just emitted verbatim.

The drive-by selftest changes fix format specifier issues
due to the definitions of [us]64 and (u)int64_t differing in how
many longs they use (long long int vs long int on x86_64).

  [0]: https://github.com/iovisor/bcc/pull/3777
  [1]: Closes: https://github.com/libbpf/libbpf/issues/433

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/bpf/bpftool/gen.c                          |  3 +++
 .../testing/selftests/bpf/prog_tests/skeleton.c  | 16 ++++++++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index eacfc6a2060d..18c3f755ad88 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -146,6 +146,7 @@ static int codegen_datasec_def(struct bpf_object *obj,
 			.field_name =3D var_ident,
 			.indent_level =3D 2,
 			.strip_mods =3D strip_mods,
+			.sizedints =3D true,
 		);
 		int need_off =3D sec_var->offset, align_off, align;
 		__u32 var_type_id =3D var->type;
@@ -751,6 +752,7 @@ static int do_skeleton(int argc, char **argv)
 		#ifndef %2$s						    \n\
 		#define %2$s						    \n\
 									    \n\
+		#include <inttypes.h>					    \n\
 		#include <stdlib.h>					    \n\
 		#include <bpf/bpf.h>					    \n\
 		#include <bpf/skel_internal.h>				    \n\
@@ -770,6 +772,7 @@ static int do_skeleton(int argc, char **argv)
 		#define %2$s						    \n\
 									    \n\
 		#include <errno.h>					    \n\
+		#include <inttypes.h>					    \n\
 		#include <stdlib.h>					    \n\
 		#include <bpf/libbpf.h>					    \n\
 									    \n\
diff --git a/tools/testing/selftests/bpf/prog_tests/skeleton.c b/tools/test=
ing/selftests/bpf/prog_tests/skeleton.c
index 180afd632f4c..9894e1b39211 100644
--- a/tools/testing/selftests/bpf/prog_tests/skeleton.c
+++ b/tools/testing/selftests/bpf/prog_tests/skeleton.c
@@ -43,13 +43,13 @@ void test_skeleton(void)
 	/* validate values are pre-initialized correctly */
 	CHECK(data->in1 !=3D -1, "in1", "got %d !=3D exp %d\n", data->in1, -1);
 	CHECK(data->out1 !=3D -1, "out1", "got %d !=3D exp %d\n", data->out1, -1);
-	CHECK(data->in2 !=3D -1, "in2", "got %lld !=3D exp %lld\n", data->in2, -1=
LL);
-	CHECK(data->out2 !=3D -1, "out2", "got %lld !=3D exp %lld\n", data->out2,=
 -1LL);
+	CHECK(data->in2 !=3D -1, "in2", "got %"PRId64" !=3D exp %lld\n", data->in=
2, -1LL);
+	CHECK(data->out2 !=3D -1, "out2", "got %"PRId64" !=3D exp %lld\n", data->=
out2, -1LL);

 	CHECK(bss->in3 !=3D 0, "in3", "got %d !=3D exp %d\n", bss->in3, 0);
 	CHECK(bss->out3 !=3D 0, "out3", "got %d !=3D exp %d\n", bss->out3, 0);
-	CHECK(bss->in4 !=3D 0, "in4", "got %lld !=3D exp %lld\n", bss->in4, 0LL);
-	CHECK(bss->out4 !=3D 0, "out4", "got %lld !=3D exp %lld\n", bss->out4, 0L=
L);
+	CHECK(bss->in4 !=3D 0, "in4", "got %"PRId64" !=3D exp %lld\n", bss->in4, =
0LL);
+	CHECK(bss->out4 !=3D 0, "out4", "got %"PRId64" !=3D exp %lld\n", bss->out=
4, 0LL);

 	CHECK(rodata->in.in6 !=3D 0, "in6", "got %d !=3D exp %d\n", rodata->in.in=
6, 0);
 	CHECK(bss->out6 !=3D 0, "out6", "got %d !=3D exp %d\n", bss->out6, 0);
@@ -77,9 +77,9 @@ void test_skeleton(void)

 	/* validate pre-setup values are still there */
 	CHECK(data->in1 !=3D 10, "in1", "got %d !=3D exp %d\n", data->in1, 10);
-	CHECK(data->in2 !=3D 11, "in2", "got %lld !=3D exp %lld\n", data->in2, 11=
LL);
+	CHECK(data->in2 !=3D 11, "in2", "got %"PRId64" !=3D exp %lld\n", data->in=
2, 11LL);
 	CHECK(bss->in3 !=3D 12, "in3", "got %d !=3D exp %d\n", bss->in3, 12);
-	CHECK(bss->in4 !=3D 13, "in4", "got %lld !=3D exp %lld\n", bss->in4, 13LL=
);
+	CHECK(bss->in4 !=3D 13, "in4", "got %"PRId64" !=3D exp %lld\n", bss->in4,=
 13LL);
 	CHECK(rodata->in.in6 !=3D 14, "in6", "got %d !=3D exp %d\n", rodata->in.i=
n6, 14);

 	ASSERT_EQ(rodata_dyn->in_dynarr_sz, 4, "in_dynarr_sz");
@@ -105,9 +105,9 @@ void test_skeleton(void)
 	usleep(1);

 	CHECK(data->out1 !=3D 1, "res1", "got %d !=3D exp %d\n", data->out1, 1);
-	CHECK(data->out2 !=3D 2, "res2", "got %lld !=3D exp %d\n", data->out2, 2);
+	CHECK(data->out2 !=3D 2, "res2", "got %"PRId64" !=3D exp %d\n", data->out=
2, 2);
 	CHECK(bss->out3 !=3D 3, "res3", "got %d !=3D exp %d\n", (int)bss->out3, 3=
);
-	CHECK(bss->out4 !=3D 4, "res4", "got %lld !=3D exp %d\n", bss->out4, 4);
+	CHECK(bss->out4 !=3D 4, "res4", "got %"PRId64" !=3D exp %d\n", bss->out4,=
 4);
 	CHECK(bss->out5.a !=3D 5, "res5", "got %d !=3D exp %d\n", bss->out5.a, 5);
 	CHECK(bss->out5.b !=3D 6, "res6", "got %lld !=3D exp %d\n", bss->out5.b, =
6);
 	CHECK(bss->out6 !=3D 14, "res7", "got %d !=3D exp %d\n", bss->out6, 14);
--
2.34.1=
