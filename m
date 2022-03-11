Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44FA4D5660
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 01:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344735AbiCKAM6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 19:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238512AbiCKAM5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 19:12:57 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206B21A06D7
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:11:56 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AI5B1N000813
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:11:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qBzUd5D1bYuKr6S4R6PfSO79bIEALCPUMt6fmhJXXdg=;
 b=YeovT7E/hefoKG75a21QgbSEWk/A/2khZM8V8hQY6bD1EG6RymrgjuxYQ0htSr0mdo0U
 OCPYfgSuirpwgAx4f+sRTlaEyxGH8SRW1inpZZpzJHmAkibowbyVfbWnsWXtaWC+rS2l
 GRbmGRi5lgSFvnqZPzzbf7ED+1mn4+66/NU= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eqex2dxp2-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:11:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keL/uS8ZL7wHZ8QrYFPdWumq/dTKmnxTe/+KCqrlIqw6zuFKAGyCixmd/lKS/FlkuOPfwwyXcnVp1NjUQYAdWipKFcJNpwdILkWxMT3g30r2bSq7dN8s5dDD25k77CSusx0H7DKRGXtEr2pex5xE13Snxbb3xNc9yLk23aQxPPFKGYlwAXBN/iwU/Albi2fhF/6HJKIZAl27rg33lvl8SsYLZxAX461Oa3/Dzz+ppipz+I6fSCIGsbRIZzvsfHNqrRAqCjrQePjpJgQ9DZxd78wKdcBqjqfT37ZZCygpTeAAPQnw3F3ClVvI+whn/PLUS7QUMnCyL0YBZiNpLnMpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBzUd5D1bYuKr6S4R6PfSO79bIEALCPUMt6fmhJXXdg=;
 b=Y9v3Ao3H60ppiQ+idAYhrpNixiuWZdd08/g7tdU5im4Rz7WuOk3t5garDgULz0uU4APo7+2hFLIblGfiKYJAecuF3tE8TrQISjCQRGz16C0aPg1lWTqFp6tcp7ELlRmy1LeCsLXJXqh2dSGFfe8pIO0XcvzIgB0TU1W7A/1dsHBvl8wgPG/sRs/8CH0x6K6PqYCPVObiOaGPJhHitv4I+jnU57h0MPAo7D7U7WhDtxBJFS5PYSsXh3xtubyF7kG7WQ6iti6NtBCvSIZ/r0xQ88YZyNIudKOm9EfPHrnoPWh8Qao/khi0Mrw+yzuCTATl0yoeCq3XKT+qRx1JsNe0tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM5PR1501MB2070.namprd15.prod.outlook.com (2603:10b6:4:a9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 00:11:53 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 00:11:53 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v2 3/5] libbpf: add subskeleton scaffolding
Thread-Topic: [PATCH bpf-next v2 3/5] libbpf: add subskeleton scaffolding
Thread-Index: AQHYNNycPbk4imFMsEyC5opEfn7KcA==
Date:   Fri, 11 Mar 2022 00:11:53 +0000
Message-ID: <b7ab6736af3976a8739f0ed75feb4ca58f5e926f.1646957399.git.delyank@fb.com>
References: <cover.1646957399.git.delyank@fb.com>
In-Reply-To: <cover.1646957399.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bcb6b6d-1f4d-49e3-591a-08da02f3bf12
x-ms-traffictypediagnostic: DM5PR1501MB2070:EE_
x-microsoft-antispam-prvs: <DM5PR1501MB20708411343450F3B0C62D52C10C9@DM5PR1501MB2070.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZQiHfZkiOXq+8VxG5Yp6KmrZCjM/6LmTtexEl5LgPZ4xX+HAIzg5oG49bQbNlNddnILGTZj9V0VOTBYnmjctH3e7hVSh+HBjYFKZG+JPziMU02pwE7GBlY6Fb3YxllJHRqO0pzF4xtMHAyhtozVj6Y9/39TgkVrCRtoxInYGeLDIo01cD0kbVa3fP9jDhOoph5kg7LnXa4/0xL2g1AP1xFL1/hE5wq7frHUnW8F0snVzhF67kPHrOGzHSlGe4TTembGX5PpB01xjnatTxlRDCXrSBVwIKq74CIHlvi4OoUvisyTMixpT1glHpvCJkSMjltTZOKCkZoODNRl0wEp9ff/PWfK3iEKRU+UTNXRmJ4NjNZZyK3FiWatQyayrKPuB9bYqCoWxLK6kh0bvA6MwLTpucnVPsLv2yTqBlJGnLZhnQuCajgVoDeilouKmTC2twbi1W0DcOxr7+mcGurJmZEW+qXD9atbkotvSZ5KUABbBHw8lBdcucprUx9dlgxWuQyduCurdUmKDpKhZTK91abFd72ZfmSzxO+FlUxAM3p1pLIsxlMU72r/l7i/+PlQXq6pN3xDCx4Jmsud/VDWDyT8fJHv3AYe6oq4CUMLGVXsj8Kcel4ct5MVEdy2uEiGKwviKXZSo5G72w8PDIldo7YWgHgwATH+j41RchNYVbswSMIsM8+Dhgt17vnA3xqPXch2S12Pu4B1y9jvudLjBrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(38070700005)(91956017)(83380400001)(5660300002)(86362001)(66446008)(64756008)(66476007)(66556008)(8676002)(76116006)(66946007)(8936002)(2616005)(508600001)(110136005)(316002)(36756003)(186003)(38100700002)(6486002)(6512007)(122000001)(71200400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zWzRyrACIfW8p4MbNyvxokRj2ZhMSm3g97O/PHEz1Ll9SmzcHvTFSUCpS2?=
 =?iso-8859-1?Q?mbXm9bXoQGDwu8NgG7mvlYx7u0NLVjjXHPZ1tY25XMy4AnVVY9w+p59MSd?=
 =?iso-8859-1?Q?FxxcAHIz/0Qg863aAVzDMtw9gmWt+LWlHtFg+1hu/91mAhWQAnLeREeh5M?=
 =?iso-8859-1?Q?cHFpBlfql9x7tyjp3o1aE6ixWjDyO+IyM0qAoTq9T0EYQALjW8zAayEhJy?=
 =?iso-8859-1?Q?qc8fCEmzeggDHsGN0CYaJajgacdVwJSQquBxwwSFlB6uHyfD4aP/0KJlBU?=
 =?iso-8859-1?Q?QJU4JYZ25EuucBcoji2obdbrhJkUzZlXqH00ytPkDPuHI8ewuwnH9XP8Bj?=
 =?iso-8859-1?Q?E3FIHQQ/imxSaucHcwXNbQnIazgx97KISoUFAVE3ui9OIsdWNQx/Wb5kS4?=
 =?iso-8859-1?Q?sIYmvjtZdvlwXTdTJKLriy9FC16p2v3abqwOPWkBNwXO7Ch9e+UsuQoDDH?=
 =?iso-8859-1?Q?6OWRSnW6Oor0vFHKnD41QdPWJp8LktXVyAocQesrakI8G2L3wxu2DEn7ib?=
 =?iso-8859-1?Q?RGQUgBs8PpqD1u5Uc/Iguqox2ZqP5Bq7FNv7WqCh56M6T7JJnAeqEGCTDg?=
 =?iso-8859-1?Q?BPg3OW57AapyQcTD5bk6iytj0dqY2i3FAh5dCy5HMQhuQ2rktJiwczhpj6?=
 =?iso-8859-1?Q?W5dGd7CI5Yv/heLi/xMrYCEd8g1g6lUUc1a25byN9uncaNJaeNUj/4Hi3H?=
 =?iso-8859-1?Q?pItswcy8IGDRiC7kuOmlqP6CuwsV3Vt7jlWkrHElBe7InL5qc3A0AQYY3d?=
 =?iso-8859-1?Q?ov0t0giavz3h9rZ1ypvGox2cus+hl+HNlav9FgwVv1NThm8bAOs2X9BMXC?=
 =?iso-8859-1?Q?gzp9sBDopJ6jJB8d6fPailIqSys13/G17//E6PiOcr/rxYO5+IU/PcNUWf?=
 =?iso-8859-1?Q?rVNdVHw/OP5FDTJMcfMdWWTfW2c0MvwoVobfq59/Bwbut5iws4IfyJD59K?=
 =?iso-8859-1?Q?YiQcnnzYGp9KcMKXeDYyCcsBODeQ2vVXkhFdpxEFoVdDh5TnMiWpkJWwln?=
 =?iso-8859-1?Q?P4PgHSjcm5qFyCmOFrfFrd7UqaCoe9Bq9bycfufmZnuflc+NzMKzAlmdAd?=
 =?iso-8859-1?Q?gxeClE6UvjG7ZBBXmwPt9/2O5mqYMiAJ2vWY9BIAg/bBc8qePfLzFHkFaE?=
 =?iso-8859-1?Q?aQoh8GSlP93188z9ooWFYaG9rmt3L0Baoqi1HDLAJAWROHUX3is3JFd2Pm?=
 =?iso-8859-1?Q?dR5LA8du1rT0fKS2IWWQR5qo6ScbGmrzzioQDGAqEpZyjsXzGURCQbISyY?=
 =?iso-8859-1?Q?nMjNVSdTip0mW/6IJ7dyN6spsIx3k85SHzmsPqVLKVU/hyXVQebgneQaZD?=
 =?iso-8859-1?Q?hQiPRs1zp3euA80gfHks1ALq6HlbiMwRMvzWHNg4WX7eUaOVvzZ8Rt/YuK?=
 =?iso-8859-1?Q?UBQaWCTiCkLq/A8vRZRb/4WrOV4IL3OboJNjnHk670rp7EtGKtCW75dNti?=
 =?iso-8859-1?Q?nAHvfLSAMh9LSkIs6MpO3grWiHuuA+SRF5n1vUloYR6F9pa1qHJiSX3LTF?=
 =?iso-8859-1?Q?pBYzTQVa/JMIwbvSIzkFzcKI52dH7y2zX7LsN81Gc+M4znF7nhPWPZcfbi?=
 =?iso-8859-1?Q?QnNZTEk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcb6b6d-1f4d-49e3-591a-08da02f3bf12
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 00:11:53.1055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMwsrYGwrEze/aj/OSGf9vXW/AP2PNrqicKmiqGDv1buSmE80ZiCzpLsaOo9LXDP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB2070
X-Proofpoint-ORIG-GUID: fBVgXLSPj9zOD-opjb1bFq4x-Svv3-Jc
X-Proofpoint-GUID: fBVgXLSPj9zOD-opjb1bFq4x-Svv3-Jc
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

In symmetry with bpf_object__open_skeleton(),
bpf_object__open_subskeleton() performs the actual walking and linking
of maps, progs, and globals described by bpf_*_skeleton objects.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/lib/bpf/libbpf.c   | 136 +++++++++++++++++++++++++++++++++------
 tools/lib/bpf/libbpf.h   |  29 +++++++++
 tools/lib/bpf/libbpf.map |   2 +
 3 files changed, 146 insertions(+), 21 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3fb9c926fe6e..ba7b25b11486 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11810,6 +11810,49 @@ int libbpf_num_possible_cpus(void)
 	return tmp_cpus;
 }
=20
+static int populate_skeleton_maps(const struct bpf_object* obj,
+				  struct bpf_map_skeleton* maps,
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
+			return libbpf_err(-ESRCH);
+		}
+
+		/* externs shouldn't be pre-setup from user code */
+		if (mmaped && (*map)->libbpf_type !=3D LIBBPF_MAP_KCONFIG)
+			*mmaped =3D (*map)->mmaped;
+	}
+	return 0;
+}
+
+static int populate_skeleton_progs(const struct bpf_object* obj,
+				   struct bpf_prog_skeleton* progs,
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
+			return libbpf_err(-ESRCH);
+		}
+	}
+	return 0;
+}
+
 int bpf_object__open_skeleton(struct bpf_object_skeleton *s,
 			      const struct bpf_object_open_opts *opts)
 {
@@ -11817,7 +11860,7 @@ int bpf_object__open_skeleton(struct bpf_object_ske=
leton *s,
 		.object_name =3D s->name,
 	);
 	struct bpf_object *obj;
-	int i, err;
+	int err;
=20
 	/* Attempt to preserve opts->object_name, unless overriden by user
 	 * explicitly. Overwriting object name for skeletons is discouraged,
@@ -11840,37 +11883,88 @@ int bpf_object__open_skeleton(struct bpf_object_s=
keleton *s,
 	}
=20
 	*s->obj =3D obj;
+	err =3D populate_skeleton_maps(obj, s->maps, s->map_cnt);
+	if (err) {
+		pr_warn("failed to populate skeleton maps for '%s': %d\n",
+			s->name, err);
+		return libbpf_err(err);
+	}
=20
-	for (i =3D 0; i < s->map_cnt; i++) {
-		struct bpf_map **map =3D s->maps[i].map;
-		const char *name =3D s->maps[i].name;
-		void **mmaped =3D s->maps[i].mmaped;
+	err =3D populate_skeleton_progs(obj, s->progs, s->prog_cnt);
+	if (err) {
+		pr_warn("failed to populate skeleton progs for '%s': %d\n",
+			s->name, err);
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
+	if (!btf)
+		return -errno;
+
+	err =3D populate_skeleton_maps(s->obj, s->maps, s->map_cnt);
+	if (err) {
+		pr_warn("failed to populate subskeleton maps: %d\n", err);
+		return libbpf_err(err);
 	}
=20
-	for (i =3D 0; i < s->prog_cnt; i++) {
-		struct bpf_program **prog =3D s->progs[i].prog;
-		const char *name =3D s->progs[i].name;
+	err =3D populate_skeleton_progs(s->obj, s->progs, s->prog_cnt);
+	if (err) {
+		pr_warn("failed to populate subskeleton maps: %d\n", err);
+		return libbpf_err(err);
+	}
=20
-		*prog =3D bpf_object__find_program_by_name(obj, name);
-		if (!*prog) {
-			pr_warn("failed to find skeleton program '%s'\n", name);
-			return libbpf_err(-ESRCH);
+	for (var_idx =3D 0; var_idx < s->var_cnt; var_idx++) {
+		var_skel =3D &s->vars[var_idx];
+		map =3D *var_skel->map;
+		map_type_id =3D bpf_map__btf_value_type_id(map);
+		map_type =3D btf__type_by_id(btf, map_type_id);
+
+		len =3D btf_vlen(map_type);
+		var =3D btf_var_secinfos(map_type);
+		for (i =3D 0; i < len; i++, var++) {
+			var_type =3D btf__type_by_id(btf, var->type);
+			if (!var_type) {
+				pr_warn("Could not find var type for item %1$d in section %2$s",
+					i, bpf_map__name(map));
+				return libbpf_err(-EINVAL);
+			}
+			var_name =3D btf__name_by_offset(btf, var_type->name_off);
+			if (strcmp(var_name, var_skel->name) =3D=3D 0) {
+				*var_skel->addr =3D (char *) map->mmaped + var->offset;
+				break;
+			}
 		}
 	}
-
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
index df1b947792c8..d744fbb8612e 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -442,6 +442,8 @@ LIBBPF_0.7.0 {
=20
 LIBBPF_0.8.0 {
 	global:
+		bpf_object__open_subskeleton;
+		bpf_object__destroy_subskeleton;
 		libbpf_register_prog_handler;
 		libbpf_unregister_prog_handler;
 } LIBBPF_0.7.0;
--=20
2.34.1
