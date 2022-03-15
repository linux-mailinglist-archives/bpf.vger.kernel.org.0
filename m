Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8F14DA513
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 23:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245650AbiCOWQc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 18:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiCOWQa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 18:16:30 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827EA5574F
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:15:16 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 22FLfqgq019624
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:15:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=VojZKIOiLxwYSZgUwP4QSusRUqVAZXE9L0TPyOFByJ4=;
 b=hmzV89OiquBwoKArOfve2540prSlcxDD0VhcoFqSyCVxXfg9AEDg1mobnlIAkAZ8mwKa
 9c5xuWE8addKB+bqWUFAQqkJ4pCERe4icEn3Drx4gc0lOallBeY6kp2pJMI6F1iWYI6h
 2B9Iq4dv/cG10/elqNW02dL5P+zerUq/muA= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by m0001303.ppops.net (PPS) with ESMTPS id 3etj2ueywh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:15:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfFdC6kg720Kd6FzO/dFUDM1OZnhR5ndUXw7DW1ImPKwKpcWCcZJVerPHeaTSjBlgnY7pa2bhE6HE54MoZ0Y59cqbf5o1uKvblmwcteqZHc4NK45q5uMvkMS7zWex/3jm8bJbYgkijLdz5lEQF0GoJhJaspIl+Ue/69nxzRu8QYDCDaoXa9pDCXFIr2PcBPnExHnuO0T9xpOYzrNBSKVPuJEy7TUzoN9r5XWquvSyT8+Qlnkz4u8iMDvsp3nS9KhR7relM4WcrGMWVxEi2U+zdJlHi373UmBthLj0Odr54UYD8QyjozQrCFc3Q2G9/lnuBKBpud7Jam49+bedqgTLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VojZKIOiLxwYSZgUwP4QSusRUqVAZXE9L0TPyOFByJ4=;
 b=gezOB+uFJvcj+g++6O2EyTpONPLLbrDd4GxOI46iCwLFOX/Xg1cL2Wr/wuk/wvhSGepDX5ksqRU1oBebwMDZumvvTfAi2R816nIxOSGmndLIoEYbcdhzUrNDpjaufKSxTyAD3OweGgIUGi85aiU14qD3iIwwulrd7a9An9HvRq2xKx48rKsBafEc+iFP+37blmt4MOLcY7DxeEANqj7w142KmLI7DgAomIqfViuc51FUY8A7fMYeh7+s8RYeJtE3GWen7Xfor3Tvf/xlYHl2mSlFS63D6vcueaHx+40FWtcfG4GA/fHrqv6UT6pxFm8rbXVIq4MHoiPEKVdgenaJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BYAPR15MB2695.namprd15.prod.outlook.com (2603:10b6:a03:150::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Tue, 15 Mar
 2022 22:15:12 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 22:15:10 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v3 2/5] libbpf: init btf_{key,value}_type_id on
 internal map open
Thread-Topic: [PATCH bpf-next v3 2/5] libbpf: init btf_{key,value}_type_id on
 internal map open
Thread-Index: AQHYOLoir9tCuOllkkm7a6Yf41ZA6w==
Date:   Tue, 15 Mar 2022 22:15:10 +0000
Message-ID: <249e598bc7a9b66397465518654e98a11719ce13.1647382072.git.delyank@fb.com>
References: <cover.1647382072.git.delyank@fb.com>
In-Reply-To: <cover.1647382072.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f6aa1da-9aca-4c97-79e5-08da06d14532
x-ms-traffictypediagnostic: BYAPR15MB2695:EE_
x-microsoft-antispam-prvs: <BYAPR15MB2695C4701E36BB06DA523EC4C1109@BYAPR15MB2695.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sRVlwYHbWRyZJRcIIhktTNJphKuxE48jWwEkYkEm2yqZuUyQNPl9WxH/lwdjfLAzyHfRw3yG9kNtDlcXy7GaCP8wt7v70ONW5pD/iqAikz9ya8kG0Z+ofNJeNFuIr8BNMezoHFMaOYfjMPwLRNGcUl2jqVroXcgtd9jHrWUbPnTAHiwoiV71Gb/SwkH4ZpSaK6wZoSSS7+XobAFbzj00nGZH9YnUoPFK4FeqsClJsEv7wf/XEvByMG2Jlpcar2nV5QmAkQW+bzuX2Iod8/eXYRkkWn28gIPhuVTKsMS1W/9WwrKGPnLKJvzeyEUzxKkeJ7DAVlcDQ8ZwCzU4rFJJsVAXZKZRWB7ZsMp9XG9llfnIWHEsCxsFQliVBfmKz5TN3J1+UtYLYt9SUxD47zunxrq7vrj87Me7VvHVVLdwfo1UFLKdHvYZYO6HWuWS5cObbmHvdBukbpprmQqok8bHipdAQb+BJpmWVTRwYqNTsWS9DgJzEArfoZ1rdh6xClBWWpLnF7Nx06quJF0HQRFypnEbuEy1BWHtvSfIXf/uMsWW0HsvuJ8maTCQEhPEwlaTiOM6ofp/RYSL8E7z1TmjuG42iHglJRZSL68HUJfTtolAm6fZgvRzb+fF8nBKhGlr0Ng5iUA+4mSCL1HmsuHqc9zQ9Xr0/tpg6SpkrMznLXV/ipfx5Lhs4/bOYqbBToqhwvxl8x+69XcaAZuL7Peyhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(66946007)(6512007)(6506007)(2616005)(64756008)(38100700002)(8676002)(76116006)(66556008)(91956017)(122000001)(66476007)(2906002)(186003)(83380400001)(316002)(110136005)(6486002)(38070700005)(71200400001)(508600001)(86362001)(36756003)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BmH8lkVTmYkmNYC2dp9qPcOI+bdeMKnnpWMapRW6KeJiFdFJ8AP58PEVEc?=
 =?iso-8859-1?Q?s47R5xJ81ttTPh0kHg7nSke69K+KL2l4+2SmJ6Wi10OVkakl0R/m+znlTp?=
 =?iso-8859-1?Q?YhqKnVaEuf8umAGUIJeIwlJLRzcEmDAJfrXmolM92NLMC3aeYHD8S8DMVC?=
 =?iso-8859-1?Q?4CJMPGKJTliDu2l+smaDT/BdpLsHDVSM9ExRCHbVBxbmwPkiaugQPdhXrz?=
 =?iso-8859-1?Q?2ItK04cTQFbk8btZpNLUZR743UUHg/eJI6rnMlyjEvxxmc2MQBPMrVBMIH?=
 =?iso-8859-1?Q?CUnq5dV8qhe8ZqW4TukQu5FL7upBKyxft05kFLHJdFd773CMZKOQNeFrM6?=
 =?iso-8859-1?Q?OPOJHT+aRfMNYnRXeF/ACSsv5nvCUlXl+JpEfWs/845picX08Qd89AT1nR?=
 =?iso-8859-1?Q?y92u0X0m2VtJ72u1DuQpI8DhC6rgqtlxr/8bSNGjPzGQl4gRxwi6vzXM/G?=
 =?iso-8859-1?Q?LSF8QN/mr7FkzDI8ldboZF6U+fnjizslHWyzGttH/hIjJJaKnSPSQmMT4r?=
 =?iso-8859-1?Q?nPJ/WrwNcaA1yCy5KyYRJkYz0vbZrkJQPIvG+AuP3u1n1XZNr/y9uoJXLy?=
 =?iso-8859-1?Q?nmeRpOvwKxLX9/FBqfFLqInuRr0mpwrNkXkQzCo8vJoqDc9AKHXdhfU47y?=
 =?iso-8859-1?Q?6t2ItAzGAH5tvMsYR7ALZeREQJdm1ZU2d3uaT0Wpq+qaJm/gTFCXsQ/yHr?=
 =?iso-8859-1?Q?ceoFCYaQmvo7v+Wk0iazTB5kgQ/vDQpDe53qnsOdS873mPBL9rGTeIIQYw?=
 =?iso-8859-1?Q?4tAp1xYYZCnXFHWLj7o1dPvG2dqM3S2YuS6m2gKqnJKoo/1tqTFckSK0vq?=
 =?iso-8859-1?Q?eLpSHDj5S6y/V3LakU/1QD/2/LDvD0eOWIutO1a4TjYkprzYpyS8l1Dp0x?=
 =?iso-8859-1?Q?N4pPRnA9OIsCYcNC+U2r/b9dZU3mHjmIsQTVx/qIYaPhW7U49ObVT01jvZ?=
 =?iso-8859-1?Q?Q0FRqPR7Sk0lbqHKApPivyQDB/LrsBJ3TW3amB/j+BZsRnsQUBorv6YmHt?=
 =?iso-8859-1?Q?CQu17bruQBwA5HgXNlokP+U3JeHxzyszAInc4xIIWQvesBcx/aScFNE7g9?=
 =?iso-8859-1?Q?wqXGyDwo9lLaVumap/f6Iy+DM0WUuqe/OVljf1PNWt77aRu2qRXnQmsZVy?=
 =?iso-8859-1?Q?k2MrgFt3Wcduoj2XOXo2NbVR9tq4APDVJ/5yIA49IbDNxj74J4zuRoTRaO?=
 =?iso-8859-1?Q?6ycr0kD8KXIFNIWIZ1GgwfPZni/ddJ/r4+plmF8SHYbDeFcNYl86Bq4SHY?=
 =?iso-8859-1?Q?qXl0R/rt6Mnh2MyeSLYmZ9q/y49pXLeqjaQV7hFj1YFg9rZ0LZ6TusLirj?=
 =?iso-8859-1?Q?iM17wtqB75fhlN6kvVtaoSS+6ueDnNwdHtcpLA5+iygolg2pNhzEjkUwtq?=
 =?iso-8859-1?Q?XaJ15/lStmdWG3anYG0cDe1UlXU9duRNMSlPQYcHb+6Oo4YSAaUx8fkk7/?=
 =?iso-8859-1?Q?xIzWDImH8F9P032WzZLjX0jdP7wzMi5Ms0l2bMWAx0CZy3Sl/p132vSBZX?=
 =?iso-8859-1?Q?2M/5SDATxBmFBDl5xAeo21Dqm6mwcoDpPJ+cS248jRB97Wy5gAGIE9Z8C9?=
 =?iso-8859-1?Q?/Bd0GUE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6aa1da-9aca-4c97-79e5-08da06d14532
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 22:15:10.3807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DP5JXSppg/MxJ8Da28by0/AsbOIjQkur7CGfy6z+lk5SAX+dOdLxZqa7WM4zV7Ht
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2695
X-Proofpoint-GUID: csqWurzJQhf-zYwNG4m6F0-wRYMkT1ud
X-Proofpoint-ORIG-GUID: csqWurzJQhf-zYwNG4m6F0-wRYMkT1ud
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

For internal and user BTF maps, look up the key and value btf
types on open() and not load(), so that `bpf_map_btf_value_type_id`
is usable in `bpftool gen`.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/lib/bpf/libbpf.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index aa26163e4ca1..e98a8381aad8 100644
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
@@ -2534,6 +2540,10 @@ static int bpf_object__init_user_btf_map(struct bpf_=
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
@@ -4873,7 +4883,7 @@ static int bpf_object__create_map(struct bpf_object *=
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
