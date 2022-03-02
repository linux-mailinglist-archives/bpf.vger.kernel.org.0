Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5324C4C9B62
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 03:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiCBCti (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 21:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiCBCth (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 21:49:37 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244A3AA022
        for <bpf@vger.kernel.org>; Tue,  1 Mar 2022 18:48:54 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 2221cmCb017818
        for <bpf@vger.kernel.org>; Tue, 1 Mar 2022 18:48:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cblz7JdFHO3bxo/XRXNtepK+Ev/JKha2UBcmTxGDITQ=;
 b=qi0XmovuIpZ17AYzofsYFJ7nnNd3imj85JF18iWdicxWJaloPX3Sm4sR1/UJffpwc4SL
 UdK406ii6NKRXuFpDNsICe+r79Wj8l3Csbt2G1KkvkHfJFzSOd9ad0ez4hXyOFmrb9v9
 eAARybTlGp3Gzzt229hx7+yyR080cj/tOpw= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by m0089730.ppops.net (PPS) with ESMTPS id 3ehn5wmt5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Mar 2022 18:48:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwZxmP39zM5XsRSnri3p8cFsNz8e1+p8XGVDKFHs7HprDfWaz39vFZReaRj94yXkRNJl37QJwbKwy1JuoVry6GtZHhOI3JnFmIkG0fN4BEozZyV1hU5A7xERpT0PY53t4fUvHcMqphIkdHssTOc6ANAi6EJIYc3zvGwuKZjCCoMlGy1spd7Eq7lar3VAY4ofpZ8lINnLLsKAE6KReanKAgtzCJE0mtnKrKEPeZtPk8y74BKhiXAhJpfifSwuwWQvQ1XB/ZanpKyUnBHpvmU1ZVZFgrRVNpuFtrxK+dhQKvobSDVS3OhQ1cWoeTpQXRDcf2AqtdubtwUHY5sqlHJ8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cblz7JdFHO3bxo/XRXNtepK+Ev/JKha2UBcmTxGDITQ=;
 b=hgj+TS3DdcjeXyPR1SQbeIbs9dycMkWo7OvRi1eQasMJH81zcB3Y81302udEhM9J9KJjlTqAqn1FdAJfgKBYoCj0qH/g5IHqW6GTmpyIfOb0ZjwYpB9AHeH6fAtL6q08ERj7+3mAnTpc5/ySK52qrjZZdaBrjWZQFMeWCcPbK0eSNh49x8DMTIo0PbBhff33cIJBwb9/SdnqAttzgTLlwMhByX76GBDfJvvTYaW/ag7103KcTmoGpDbLepgaxKFrB2eatw6DDaq5dIT2u9QoECv1AbSMBop9zMLK9wmQZnLf87QeO+L1yyDFGLvvHPzJ1t4q6DgCxzHqrDJnGQlDRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MW4PR15MB4441.namprd15.prod.outlook.com (2603:10b6:303:102::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 02:48:47 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%5]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 02:48:46 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next 3/4] libbpf: add subskeleton scaffolding
Thread-Topic: [PATCH bpf-next 3/4] libbpf: add subskeleton scaffolding
Thread-Index: AQHYLeAJ25nB2g/kyUKDt/jLzXCj8Q==
Date:   Wed, 2 Mar 2022 02:48:46 +0000
Message-ID: <13cba9e1c39e999e7bfb14f1f986b76d13e150b3.1646188795.git.delyank@fb.com>
References: <cover.1646188795.git.delyank@fb.com>
In-Reply-To: <cover.1646188795.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a489585-677b-4f10-1cc5-08d9fbf72c55
x-ms-traffictypediagnostic: MW4PR15MB4441:EE_
x-microsoft-antispam-prvs: <MW4PR15MB4441D8E9B90CDCC2ACB75E0BC1039@MW4PR15MB4441.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Gv9K73u8Nb1SoDU2QgOLM/YXBwuqHyMdtTjVR9F5ZX0lYXT/rtLg0+cgjBNG1d9xnuM04OvvjrMcSs0olrr/fCSZEcze2VvhWK6da4QgVlFx616d7nr4feCe5PgVfu9l4Rgi72K3HfYoUjc5JRl8xvtXzr4X9P+xJBoucHLnYnncdHWMvKqH6mU6ynfLUwdkgV852Yd0721eXSL5D2PN7CnbOWj8UdP7t0nse+EVav9XNNj36MNBw3ZNv4j6orQn7Xg5Hlox3jFR4gI2gNgJo47wJkNZUC/B2obEfKD6qX/Yw8uUR4Mr2SJr8x6HvmT6vs5flYdKraXL4q4lOqZZA4LkC7hp1/B/ApZ/TKs/UaS5J7nxV6RvAsQuuUtP2zLxDm81h6XOEpwXbRzpJMrikan1tZPoeKc23Z5BXWhYaqWHl1s34RkdethFQ9lxm4vq1uKgPCOe8e178jdmPqQMyE6CFJ+VIeGMk6DzVvHP3imRpT413mIo6a6jEPBNIX2nnqRaHrsceJZHw+oeoI0Q8/DnBQTzmPoebm2FvyZvMln+H4YIr3uFPL3Dh4xyHvd7RnXJLND5fR95YNcKcfT8GrHdswju+3I4YvyOcynL/ZQ1opG0Ueo5IikH7OPeCI72lmu1kzveXOYyHL5VCSjUk6QRdObQIHn0gIif+5U9S8CoDN03XYkAExX/rBidZVwhVKx8gmqOXmGYrAHY0wdJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38100700002)(110136005)(122000001)(86362001)(6512007)(6506007)(66476007)(186003)(38070700005)(91956017)(36756003)(2616005)(66946007)(76116006)(66446008)(66556008)(64756008)(2906002)(8936002)(5660300002)(71200400001)(508600001)(8676002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gAV7LIGgFaMV2zIVYjw7eK88foa6cmnN1nWsaKjCxy1Rh5BSbU9mhL4aEr?=
 =?iso-8859-1?Q?/YDJmWa+ywQ7G4Dd581Fg8ftnLfqvCSHJ554R6MpL3DCViiScESdFLoOWO?=
 =?iso-8859-1?Q?7kVI2vgqSmyj+Q5drRPlJfi6oZxUQ1U9Uj9fGZ/KcV96al8rDi8wOFFRC/?=
 =?iso-8859-1?Q?1Pxjc/+EJqikkG8Xbws4yR3vCZer9RMU4QnXaZIZt5wI2GN01rDn8zvB5b?=
 =?iso-8859-1?Q?l9URZsE8GOgQ6GJPbh67pg0wUFEfI41vLJAmDFSxxIv0vLokQu9rHnMdTe?=
 =?iso-8859-1?Q?M5E8lsHfDAyymQwvZZC+WqjM8/iS6WiKcQe3rBcGZltN79GWhvKksMttHP?=
 =?iso-8859-1?Q?+ebj8NuxFc3Zpf0Kmjw1tBq90FJdFnqUdnBf1I4Qxt/DjjQ7UEpXnOnfij?=
 =?iso-8859-1?Q?BjrZS5DGNIuIGvkUXKXKiVvsLlHMxfzUUYuv0cS2jyhfirvdIaQu+VB/oM?=
 =?iso-8859-1?Q?uyvx1Z3XSi5mhbfnNT4zqd2lyrFCrpCDJN+mFHsncc6dys66TK7S0oynoN?=
 =?iso-8859-1?Q?FeCsYvKeP3+7e+1HtFjOC66LTbs4RKed6qq+dSyHL20ASJpugQ12r7Tsgv?=
 =?iso-8859-1?Q?koDOuIsKW3cfXqYt3LEnC6yrSOSC0NXe//b2v9i0Gb1vcwvAwXCJQiPt3N?=
 =?iso-8859-1?Q?DmaZWRD/f51PesDaAwZsZvjt1704t9ALsRCGc8v4sNu/nYet8JlUoVKnzv?=
 =?iso-8859-1?Q?o0bJ1zZs8dCOkueVJZAIhulaWy8MwMYFbuXAof2CYU7EKcf6/3lpAMu13v?=
 =?iso-8859-1?Q?hp7hFxGbgMLpnSE8BH3ikouK/0wPZK7tQeP4RjQcUZo0kaTTFle62ETsku?=
 =?iso-8859-1?Q?jaQfAFwC4Qnr1bic8GcLqlpd+8vRFB+BAMV+jFGuzgBtmEONnZqwa3U5IC?=
 =?iso-8859-1?Q?UHKBuF9eGrlRb2sEvS73L4pBIcUgi/DbNw5KQoZzLeZBwNgmbqTi6wTfpJ?=
 =?iso-8859-1?Q?HecTxQJI7/smn7mdEYam+QFsdqA54h8re0yjDqtJU+y+IN1aPPZbrQceTo?=
 =?iso-8859-1?Q?cdTIvmQblisbjaW6+UIV8ZP1OEsa+vG1aYn6koIT0v1+hj3WktwhKVFAIC?=
 =?iso-8859-1?Q?fL4SaT+zWk4H1WIPMqDRD8SMqPyKyLdrS3vWgwBBuHVr9A871v55xQqpM1?=
 =?iso-8859-1?Q?A3Myncw9oDNMIxpMnawPJWSOWC2SzKUmSJizexa+Zi2yg+TngL9iM7Nd5f?=
 =?iso-8859-1?Q?Fgj1UZVD++6KescNUYar0HjXNBB3s6yizQE9CS4B5I3ccsXEddXrsLHr/Y?=
 =?iso-8859-1?Q?z9T/ZTV4v5SG4mNqhThlJpNeUsJV4o39bdsi9PLghU/fzcLc22Bbg/VJ6b?=
 =?iso-8859-1?Q?ork2UssJ4ZTKvhGHRKdNEyexkIe+FWxiibryXJYjcBZIxh7AD+FR9gQ7Mz?=
 =?iso-8859-1?Q?0ibF26psPRWSZR28Kj/CT1TrKkmsc0qOqsrcmIOT/2YMNbpM4P2JmMBBnZ?=
 =?iso-8859-1?Q?cFVVd7jLUt6oF4P6/idsD0uF9O0yeNXw+EXCLJFiMdnyvOD7BiqYMZjiKY?=
 =?iso-8859-1?Q?He/Z7QY9LRjqDTL1XXDyHzPzC4gPqno0YU/truuNlyjt7qD8gKJcuw1UeG?=
 =?iso-8859-1?Q?tYovPqKfygUV49MDCoafcuiAKgPwa+egNV7I4OH245mrXmM2Q4C8pseG8S?=
 =?iso-8859-1?Q?bOAwUxgR8TD1X1S8GEqImEGkTYMsf42i3OO93Dgll0NxrQhd/rU2eeuA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a489585-677b-4f10-1cc5-08d9fbf72c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 02:48:46.7968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EMp+b7Dfh+ilEr6ebkQMDZuSdAEtV7fUuxgGHxCQ6Nd8YPMdAcOL/eKVSFHeOrVM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4441
X-Proofpoint-GUID: wNgBfzJ1_VTQZsfNKmQLj8uP3vwuecnB
X-Proofpoint-ORIG-GUID: wNgBfzJ1_VTQZsfNKmQLj8uP3vwuecnB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_01,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 mlxlogscore=394 phishscore=0 adultscore=0
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

In symmetry with bpf_object__open_skeleton(),
bpf_object__open_subskeleton() performs the actual walking and linking
of symbols described by bpf_sym_skeleton objects.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/lib/bpf/libbpf.c   | 76 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 21 +++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 99 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d20ae8f225ee..e6c27f4b9dea 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11748,6 +11748,82 @@ int bpf_object__open_skeleton(struct bpf_object_sk=
eleton *s,
 	return 0;
 }
=20
+int bpf_object__open_subskeleton(struct bpf_object_subskeleton *s)
+{
+	int i, len, map_type_id, sym_idx;
+	const char *var_name;
+	struct bpf_map *map;
+	struct btf *btf;
+	const struct btf_type *map_type, *var_type;
+	const struct bpf_sym_skeleton *sym;
+	struct btf_var_secinfo *var;
+	struct bpf_map *last_map =3D NULL;
+	const struct btf_type *last_map_type =3D NULL;
+
+	if (!s->obj)
+		return libbpf_err(-EINVAL);
+
+	btf =3D bpf_object__btf(s->obj);
+	if (!btf)
+		return libbpf_err(errno);
+
+	for (sym_idx =3D 0; sym_idx < s->sym_cnt; sym_idx++) {
+		sym =3D &s->syms[sym_idx];
+		if (last_map && (strcmp(sym->section, bpf_map__section_name(last_map)) =
=3D=3D 0)) {
+			map =3D last_map;
+			map_type =3D last_map_type;
+		} else {
+			map =3D bpf_object__find_map_by_name(s->obj, sym->section);
+			if (!map) {
+				pr_warn("Could not find map for section %1$s, symbol %2$s",
+					sym->section, s->syms[i].name);
+				return libbpf_err(-EINVAL);
+			}
+			map_type_id =3D btf__find_by_name_kind(btf, sym->section, BTF_KIND_DATA=
SEC);
+			if (map_type_id < 0) {
+				pr_warn("Could not find map type in btf for section %1$s (due to symbo=
l %2$s)",
+					sym->section, sym->name);
+				return libbpf_err(-EINVAL);
+			}
+			map_type =3D btf__type_by_id(btf, map_type_id);
+		}
+
+		/* We have a section and a corresponding type, now find the
+		 * symbol in the loaded map. This is clearly quadratic in the
+		 * number of symbols in the section, but that's easy to optimize
+		 * once the need arises.
+		 */
+
+		len =3D btf_vlen(map_type);
+		for (i =3D 0, var =3D btf_var_secinfos(map_type); i < len; i++, var++) {
+			var_type =3D btf__type_by_id(btf, var->type);
+			if (!var_type) {
+				pr_warn("Could not find var type for item %1$d in section %2$s",
+					i, sym->section);
+				return libbpf_err(-EINVAL);
+			}
+			var_name =3D btf__name_by_offset(btf, var_type->name_off);
+			if (strcmp(var_name, sym->name) =3D=3D 0) {
+				*sym->addr =3D (char *) map->mmaped + var->offset;
+				break;
+			}
+		}
+
+		last_map =3D map;
+		last_map_type =3D map_type;
+	}
+	return 0;
+}
+
+void bpf_object__destroy_subskeleton(struct bpf_object_subskeleton *s)
+{
+	if (!s)
+		return;
+	if (s->syms)
+		free(s->syms);
+	free(s);
+}
+
 int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
 {
 	int i, err;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 7b66794f1c0a..915d59c31ad5 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1291,6 +1291,27 @@ LIBBPF_API int bpf_object__attach_skeleton(struct bp=
f_object_skeleton *s);
 LIBBPF_API void bpf_object__detach_skeleton(struct bpf_object_skeleton *s)=
;
 LIBBPF_API void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s=
);
=20
+struct bpf_sym_skeleton {
+	const char *name;
+	const char *section;
+	void **addr;
+};
+
+struct bpf_object_subskeleton {
+	size_t sz; /* size of this struct, for forward/backward compatibility */
+
+	const struct bpf_object *obj;
+
+	int sym_cnt;
+	int sym_skel_sz;
+	struct bpf_sym_skeleton *syms;
+};
+
+LIBBPF_API int
+bpf_object__open_subskeleton(struct bpf_object_subskeleton *s);
+LIBBPF_API void
+bpf_object__destroy_subskeleton(struct bpf_object_subskeleton *s);
+
 struct gen_loader_opts {
 	size_t sz; /* size of this struct, for forward/backward compatiblity */
 	const char *data;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 5c85d297d955..81a1d0259866 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -443,4 +443,6 @@ LIBBPF_0.7.0 {
 LIBBPF_0.8.0 {
 	global:
     bpf_map__section_name;
+    bpf_object__open_subskeleton;
+    bpf_object__destroy_subskeleton;
 } LIBBPF_0.7.0;
--=20
2.34.1
