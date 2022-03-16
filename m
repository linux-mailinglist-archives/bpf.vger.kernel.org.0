Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779014DBB2B
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 00:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245373AbiCPXix (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 19:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242323AbiCPXiv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 19:38:51 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D3815A3B
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 16:37:36 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22GHCing016635
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 16:37:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xzoVU7G7IGg02eXOnMEZ9PBVMXI9tA0oRtdHkXpgMfc=;
 b=rMvUqlqyEnUXJ0sQZ/GlLRe+CB4QJ1lUMjVa4ZQV4rEV63KVEgcX5P9Fcj/Ivr5zA/zI
 gjiOZa3x+1NrLYLUCOPithxJ4bck+vssEI9p2kLuKf700208/Via227VBI7zPtvYqg3E
 /cSsKRe2gSdHZxJCMSmIlz9SggnTIjkac7k= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eue4bnkqc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 16:37:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYbC7e41bjZs9wdp2rR78Zpn2ObO5CJJPGvaI19/0o/yFtlHx9qCjb1yAWfVRnpudGOpDon6p/o/1NBld2YgSk1m2ZqxJQxkr6t/7hxQnopR611bZJ0i/U5unS53OrEqflE8bo2nlRzZNmQ4xavzFA4TAw2YJD8QyWOah6zExiatj8wwEjePw+5TJtfqclwOqIH/HDVbEDi63idUFGkmVwLR1e0KOK7WCyziUWdjjhKuhj23nUuufe/uYXQXXLeiORNgYqFIgukNXNUeFDJ4yOievOgnz7qASXLkgedB6pag6sUsEZjrcPctk3FdWiM2uLmCvkFwgL6e/ajbsbyjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzoVU7G7IGg02eXOnMEZ9PBVMXI9tA0oRtdHkXpgMfc=;
 b=beP3leLUB+EcoU0jY5eiBhztI1ZRh3qM+ITqgNNki3c0UwCOVDYMKUaqvjfQymkL5/kxfw6BlB2T8XjRiPIAWcbtEv2huIMEeMAtTfHSb678KUf0uNW13OC479QkzGvv8CfdHE75Z+BqnJLTX1i/6ehPd70sz89WV2FsHF6CnoMQsVF5QxYKQedWAaMBouXr4P/Wddw/loWjwSY80weOO+GIEBQQRXmsYD6Dlgo5HQ8zd1YVMM62hH2ChDtNQJfNx3e32/G10H4w3zgKvLNXoUWc9D91JPfhIzRuymlNAqMf5HWFqW1J7cgwHqi+PtEiD7OvKHaKlCsL5FEHoNBasw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM5PR1501MB2182.namprd15.prod.outlook.com (2603:10b6:4:a4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 23:37:33 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 23:37:33 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v4 3/5] libbpf: add subskeleton scaffolding
Thread-Topic: [PATCH bpf-next v4 3/5] libbpf: add subskeleton scaffolding
Thread-Index: AQHYOY7Pp/IiWQAJVky8ckDrRBsvpA==
Date:   Wed, 16 Mar 2022 23:37:33 +0000
Message-ID: <6942a46fbe20e7ebf970affcca307ba616985b15.1647473511.git.delyank@fb.com>
References: <cover.1647473511.git.delyank@fb.com>
In-Reply-To: <cover.1647473511.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f5c78b1-3d9d-40b9-bc56-08da07a5f1da
x-ms-traffictypediagnostic: DM5PR1501MB2182:EE_
x-microsoft-antispam-prvs: <DM5PR1501MB2182884E93E19B70DD344C3FC1119@DM5PR1501MB2182.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LrH9EE9omNjxSqNicU5lYtDW6FK+Ka/m4/OScxeqy/kjNbPYvbEcmKTgEX7xGlqU7Jf1PU3btLtK+aMgQsG9rrtiAOd8wgGmXnfc7b+19ZCdp2AKs6yUCG6o7Yka3EhQMP3tUQk+55e5DLwqepWUbStUPMxBYbwkFvh84fNDmdMF0vgtNWIT/SQ9VbHQ0ymmQ/AJD/Jau4MSXlgXH7zeMMf1eT3bYvy0daJzsLFo0C2d9KZdsrHaPe9WJhYcalC/d+hPuGtBSoHsby84SwY8UHJCtYtF5vMQWsf5jPmZlCDNJfXLnX2jJt9SGZdB528QkBqHPMQDcyoR7yoqpZ8fyjW+x6AlTS45QObHMeyaWVv7ky/cKbUpSlina5StO/C4RNmmCH28/q+8+R+3g3Fdw0K3XXIlAODH+HQxJBh+aNLgFBqqUM8y16u230818KkUGstIgTzdC1br8DLy99XK9w6QSxFrCCUg1v5YQlQphSZAEG7C7DAM8xtfqrW37s52ZDDXUzKlCZyDSE0z7/bcuxd4QaH5RXuCoxd1ZqQxFyh1u7YunWbO7bKUzyYJAyHD0W3NflWA/2w1rHTKVLCX9HBjT4wSBn9CgC+N32/hnMnvAUiGH85stg9khC+gAifrlC/7jXeZSKgUVUdD06HasB4pGQ5vemXeOna/mExVT7nU/TmegQaHJQXkLpmf8e37U3GKyv4PxYASzwKdm+gwdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2616005)(5660300002)(110136005)(316002)(38070700005)(6486002)(71200400001)(508600001)(64756008)(8676002)(6512007)(122000001)(6506007)(66476007)(66446008)(86362001)(76116006)(66946007)(66556008)(91956017)(38100700002)(36756003)(186003)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Isn+GcvCwYbGG4EzEJawoIjIOosMezYAgzeVeIySeWFiDKHPEG6HGCIpzl?=
 =?iso-8859-1?Q?Nu5Ow3e8j+rSQkys69jzTonWib+MDEepo0PxrW0ouXQSMV6jkvPQ2bMPhx?=
 =?iso-8859-1?Q?bReQycwbjjCGPD59QUNCMI0/1JKKZWCfzLMRwMpsRCb6oxK8H/kZKlJrEc?=
 =?iso-8859-1?Q?FvseLU99f3iE/oq8mbLbgdJeFVKpoTACsjC1Th5acBRDcWL3GsSjUR8W2E?=
 =?iso-8859-1?Q?ooqBwk2P1R1DkIJquAWwooUWI8MNajcFV8OVyOm7vMYVOIOgjMkQBL8/TK?=
 =?iso-8859-1?Q?llpNYONj3dSddwPfYl4VEIalF4GTVn7QvCAnQvxktQhIICzqAW2MFCtkm5?=
 =?iso-8859-1?Q?YdSSS4E6EZ25+L+wNbI49oK96zErZepvJErUC1ruI7l7s5bf2fTWqXGu+R?=
 =?iso-8859-1?Q?Me+XQG/pzZxtqQIcIGCmHEWlF3CnM3hnV4A9fzf23jLa0Vm8kMVy90guO8?=
 =?iso-8859-1?Q?BPvvZoASIdWqn/h5jnoBA3r5wnA2ovQjN1FcIWE7Qac4DMKQKOwIdcVj+I?=
 =?iso-8859-1?Q?OKmxQmUrKGi1nzqEhz1QOqInOD0l07fNnegSlYe1xt9JASLgtoyRciqxXd?=
 =?iso-8859-1?Q?0TxUHmBvO0Kqb/btswRtL65P8VtRr1o3yczzq62dbppjwWQgaxoQQpL40v?=
 =?iso-8859-1?Q?iCpvO0jwE+spzvobJyB4q4jquqcjJP6Npu3MbSOk+ljr/bpQfyn6X4sAT4?=
 =?iso-8859-1?Q?VkOvPVSwC7wHCQPpy3LnAYXE0pr2EIzxEJsjTNSrvnXXDPQJhFkvg+8i0Q?=
 =?iso-8859-1?Q?/ugsrRqMSiaEOsCtgFln72J6RXZeO9QC3Rd1pYi3csw9xZvBtMqUGqQRXj?=
 =?iso-8859-1?Q?Dk04iGDF96DD2csPCpjrGV0bodrsc/FUNwO7aXR7YdsQQB9Yu4fmFxT0F0?=
 =?iso-8859-1?Q?ACo5t4GtI/qqemNjoIFogsGG34aRtQ9B4m+XtU/c6DbQmwexNFAnGqPLrw?=
 =?iso-8859-1?Q?98R+h1NwxsWUBd+V8A89gJgcvUVRBBvHXP2vE5pj3SdlC76CEVM0xwdK4N?=
 =?iso-8859-1?Q?6u7Yo2jW00OSpmZI9GSCLasnqmPhEVW4AUCkzh3qjT2Mb+ZHh1VgwcH4ZU?=
 =?iso-8859-1?Q?5b+BVue5IUtmQVGuw1t0O1WHyIB52tiIwD4LnmWcJ05INpfcwNwoELU2S2?=
 =?iso-8859-1?Q?9+10N8bUlygTXA/MdzArJ5Ol6OZHzyihLeO2hPHK+j5aGPTwO/V37g7y5J?=
 =?iso-8859-1?Q?4QCcJqy7SsNwt2iFru3QjiYQeKG4V7ZkAkph33VwFUOYN7Vn/Gqm/SESnd?=
 =?iso-8859-1?Q?c6k0Nr06tfyT2gfH2V4i4MQzd/5koVshh6j8wC0uT2OqXZnv9IqpjzX3NY?=
 =?iso-8859-1?Q?ECFNpJ4oW6210YjPsJgv8onJfYjFjRptNbx2kNjSEYoMMf6AD1zPOW2T9e?=
 =?iso-8859-1?Q?840hJ5Qkk67Y8XrAIW09vnLdcG5dzeca1lotM9VELqRDZcrC7SQkcKfKy6?=
 =?iso-8859-1?Q?jGjCxJAl3o8aq0AncETFOw0/aXdurbj2sYRbhcQhhiSaJ/cflvOYh2Zb5Z?=
 =?iso-8859-1?Q?VwBWEpHDvCY7ytYopvJFyelplQBDJQ3mo4JS54liDnZZiHLI68SDNK0r27?=
 =?iso-8859-1?Q?d36KdOE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5c78b1-3d9d-40b9-bc56-08da07a5f1da
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 23:37:33.4207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ultrXc2bo9e3meKIXC+b81YlaYqWt7R1k0B7VTSsFYfR1k1gKRdc5UecyvdsFiv1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB2182
X-Proofpoint-GUID: lBoiVCMGoKZh_YDDm_CTwNCTqpHhoUTs
X-Proofpoint-ORIG-GUID: lBoiVCMGoKZh_YDDm_CTwNCTqpHhoUTs
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

In symmetry with bpf_object__open_skeleton(),
bpf_object__open_subskeleton() performs the actual walking and linking
of maps, progs, and globals described by bpf_*_skeleton objects.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/lib/bpf/libbpf.c   | 139 +++++++++++++++++++++++++++++++++------
 tools/lib/bpf/libbpf.h   |  29 ++++++++
 tools/lib/bpf/libbpf.map |   2 +
 3 files changed, 149 insertions(+), 21 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5ff680750dcf..d678b0d1d8dd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11815,6 +11815,49 @@ int libbpf_num_possible_cpus(void)
 	return tmp_cpus;
 }
=20
+static int populate_skeleton_maps(const struct bpf_object *obj,
+				  struct bpf_map_skeleton *maps,
+				  size_t map_cnt)
+{
+	int i;
+
+	for (i =3D 0; i < map_cnt; i++) {
+		struct bpf_map **map =3D maps[i].map;
+		const char *name =3D maps[i].name;
+		void **mmaped =3D maps[i].mmaped;
+
+		*map =3D bpf_object__find_map_by_name(obj, name);
+		if (!*map) {
+			pr_warn("failed to find skeleton map '%s'\n", name);
+			return -ESRCH;
+		}
+
+		/* externs shouldn't be pre-setup from user code */
+		if (mmaped && (*map)->libbpf_type !=3D LIBBPF_MAP_KCONFIG)
+			*mmaped =3D (*map)->mmaped;
+	}
+	return 0;
+}
+
+static int populate_skeleton_progs(const struct bpf_object *obj,
+				   struct bpf_prog_skeleton *progs,
+				   size_t prog_cnt)
+{
+	int i;
+
+	for (i =3D 0; i < prog_cnt; i++) {
+		struct bpf_program **prog =3D progs[i].prog;
+		const char *name =3D progs[i].name;
+
+		*prog =3D bpf_object__find_program_by_name(obj, name);
+		if (!*prog) {
+			pr_warn("failed to find skeleton program '%s'\n", name);
+			return -ESRCH;
+		}
+	}
+	return 0;
+}
+
 int bpf_object__open_skeleton(struct bpf_object_skeleton *s,
 			      const struct bpf_object_open_opts *opts)
 {
@@ -11822,7 +11865,7 @@ int bpf_object__open_skeleton(struct bpf_object_ske=
leton *s,
 		.object_name =3D s->name,
 	);
 	struct bpf_object *obj;
-	int i, err;
+	int err;
=20
 	/* Attempt to preserve opts->object_name, unless overriden by user
 	 * explicitly. Overwriting object name for skeletons is discouraged,
@@ -11845,37 +11888,91 @@ int bpf_object__open_skeleton(struct bpf_object_s=
keleton *s,
 	}
=20
 	*s->obj =3D obj;
+	err =3D populate_skeleton_maps(obj, s->maps, s->map_cnt);
+	if (err) {
+		pr_warn("failed to populate skeleton maps for '%s': %d\n", s->name, err)=
;
+		return libbpf_err(err);
+	}
=20
-	for (i =3D 0; i < s->map_cnt; i++) {
-		struct bpf_map **map =3D s->maps[i].map;
-		const char *name =3D s->maps[i].name;
-		void **mmaped =3D s->maps[i].mmaped;
+	err =3D populate_skeleton_progs(obj, s->progs, s->prog_cnt);
+	if (err) {
+		pr_warn("failed to populate skeleton progs for '%s': %d\n", s->name, err=
);
+		return libbpf_err(err);
+	}
=20
-		*map =3D bpf_object__find_map_by_name(obj, name);
-		if (!*map) {
-			pr_warn("failed to find skeleton map '%s'\n", name);
-			return libbpf_err(-ESRCH);
-		}
+	return 0;
+}
=20
-		/* externs shouldn't be pre-setup from user code */
-		if (mmaped && (*map)->libbpf_type !=3D LIBBPF_MAP_KCONFIG)
-			*mmaped =3D (*map)->mmaped;
+int bpf_object__open_subskeleton(struct bpf_object_subskeleton *s)
+{
+	int err, len, var_idx, i;
+	const char *var_name;
+	const struct bpf_map *map;
+	struct btf *btf;
+	__u32 map_type_id;
+	const struct btf_type *map_type, *var_type;
+	const struct bpf_var_skeleton *var_skel;
+	struct btf_var_secinfo *var;
+
+	if (!s->obj)
+		return libbpf_err(-EINVAL);
+
+	btf =3D bpf_object__btf(s->obj);
+	if (!btf) {
+		pr_warn("subskeletons require BTF at runtime (object %s)\n",
+		        bpf_object__name(s->obj));
+		return libbpf_err(-errno);
 	}
=20
-	for (i =3D 0; i < s->prog_cnt; i++) {
-		struct bpf_program **prog =3D s->progs[i].prog;
-		const char *name =3D s->progs[i].name;
+	err =3D populate_skeleton_maps(s->obj, s->maps, s->map_cnt);
+	if (err) {
+		pr_warn("failed to populate subskeleton maps: %d\n", err);
+		return libbpf_err(err);
+	}
=20
-		*prog =3D bpf_object__find_program_by_name(obj, name);
-		if (!*prog) {
-			pr_warn("failed to find skeleton program '%s'\n", name);
-			return libbpf_err(-ESRCH);
-		}
+	err =3D populate_skeleton_progs(s->obj, s->progs, s->prog_cnt);
+	if (err) {
+		pr_warn("failed to populate subskeleton maps: %d\n", err);
+		return libbpf_err(err);
 	}
=20
+	for (var_idx =3D 0; var_idx < s->var_cnt; var_idx++) {
+		var_skel =3D &s->vars[var_idx];
+		map =3D *var_skel->map;
+		map_type_id =3D bpf_map__btf_value_type_id(map);
+		map_type =3D btf__type_by_id(btf, map_type_id);
+
+		if (!btf_is_datasec(map_type)) {
+			pr_warn("type for map '%1$s' is not a datasec: %2$s",
+				bpf_map__name(map),
+				__btf_kind_str(btf_kind(map_type)));
+			return libbpf_err(-EINVAL);
+		}
+
+		len =3D btf_vlen(map_type);
+		var =3D btf_var_secinfos(map_type);
+		for (i =3D 0; i < len; i++, var++) {
+			var_type =3D btf__type_by_id(btf, var->type);
+			var_name =3D btf__name_by_offset(btf, var_type->name_off);
+			if (strcmp(var_name, var_skel->name) =3D=3D 0) {
+				*var_skel->addr =3D map->mmaped + var->offset;
+				break;
+			}
+		}
+	}
 	return 0;
 }
=20
+void bpf_object__destroy_subskeleton(struct bpf_object_subskeleton *s)
+{
+	if (!s)
+		return;
+	free(s->maps);
+	free(s->progs);
+	free(s->vars);
+	free(s);
+}
+
 int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
 {
 	int i, err;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index c1b0c2ef14d8..1bff7647d797 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1289,6 +1289,35 @@ LIBBPF_API int bpf_object__attach_skeleton(struct bp=
f_object_skeleton *s);
 LIBBPF_API void bpf_object__detach_skeleton(struct bpf_object_skeleton *s)=
;
 LIBBPF_API void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s=
);
=20
+struct bpf_var_skeleton {
+	const char *name;
+	struct bpf_map **map;
+	void **addr;
+};
+
+struct bpf_object_subskeleton {
+	size_t sz; /* size of this struct, for forward/backward compatibility */
+
+	const struct bpf_object *obj;
+
+	int map_cnt;
+	int map_skel_sz; /* sizeof(struct bpf_map_skeleton) */
+	struct bpf_map_skeleton *maps;
+
+	int prog_cnt;
+	int prog_skel_sz; /* sizeof(struct bpf_prog_skeleton) */
+	struct bpf_prog_skeleton *progs;
+
+	int var_cnt;
+	int var_skel_sz; /* sizeof(struct bpf_var_skeleton) */
+	struct bpf_var_skeleton *vars;
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
index df1b947792c8..087c77e520e1 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -442,6 +442,8 @@ LIBBPF_0.7.0 {
=20
 LIBBPF_0.8.0 {
 	global:
+		bpf_object__destroy_subskeleton;
+		bpf_object__open_subskeleton;
 		libbpf_register_prog_handler;
 		libbpf_unregister_prog_handler;
 } LIBBPF_0.7.0;
--=20
2.34.1
