Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7A64B0346
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 03:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiBJCWs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 21:22:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiBJCWr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 21:22:47 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4628822BC7
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 18:22:49 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 219NYHi5029395
        for <bpf@vger.kernel.org>; Wed, 9 Feb 2022 16:36:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=hTwRg7irlzBwnuu6oczWfaLxt3YkTybNqeR7ha9yFXQ=;
 b=C+VHB9yxRccOxTvt+QcQGjJFB1LuH88B2wcA+gLPEi276YJLFtHlwuBCZCwmOFqfM+/U
 9iwLRHry8MfmEjQUy79INuCBOMER05wbaJc2mLNIpClsTo1vJO3AvnEVFt9XZDeOkeeW
 6H0FJ4jCSijGtTuZeg0IeR7ZAtHxAwlF0Ew= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e4e8nvnfh-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 16:36:57 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Feb 2022 16:36:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUHsT+dossyHYYAMquWQNRVFuGLPVytKzelFQfUIl78ABpC0hPwhcumpC+7nor1fBKlI6p3oIPBuZQuP8yUC5SaxL4Jn+VRXyXsqZVuhwNOh/yWFGaFxNvn6pUgRg18WmZ0KrzzEQsTKCJrnTwOsnBvOLYDszYc4NTKEqtCxT6LMxGuBblVVtG2KVBeY7NcdcOVjSB/OSy215rfAPdT/qKwvod79QkMGZwlHzsnN1O5hdJPOuJXZ79KM510nKyJ8nuMkHZAWhzUQBmc74l2INsI6Sum/jBSbMJOTHnN2clsJW2cut+h7N0X+JmyUnS31r6n3rYwgKvdW+AtojWT+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTwRg7irlzBwnuu6oczWfaLxt3YkTybNqeR7ha9yFXQ=;
 b=XXzK1c1z+9ski4RGMpZNoZSyFRg+1/H/Xzk9cAzIGhFOLEFREQVdMafqgmbI9X4vZ0gBsEZCS2Nmd/dWBLcpFbG59FgtFhydbNkl7Zm35HBz7Vui1SB+VKg6vvrAOSX2t6LNtseHv2RPEPbfYYEZPqAidMZ3E/5aNu32jJfBNkWmNRDNJwF3YSAG8hjQNvaQ9zHkKq78/o0TMqPRcWdLTFe7zK976uZhDdAL8/2LwI0uJffPW+FB+LFYirB3mV2AwUem17J1BhD56dn3x9j27pLpZzJi9Bbid7c/osJkcgJAFAcrju4j+usmQ/d/4pmpZdsULWbv3RKLLoXyR1JomA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by CY4PR15MB1590.namprd15.prod.outlook.com (2603:10b6:903:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 00:36:55 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::f1fc:6c73:10d4:1098]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::f1fc:6c73:10d4:1098%6]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 00:36:55 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v1 1/3] libbpf: btf_dump can produce explicitly sized
 ints
Thread-Topic: [PATCH bpf-next v1 1/3] libbpf: btf_dump can produce explicitly
 sized ints
Thread-Index: AQHYHhZNW2xoTni6OUuR9sTJr9fafg==
Date:   Thu, 10 Feb 2022 00:36:55 +0000
Message-ID: <c37e39653b133b230dee3b393a07b4def697b61a.1644453291.git.delyank@fb.com>
References: <cover.1644453291.git.delyank@fb.com>
In-Reply-To: <cover.1644453291.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 006ddca7-fa3c-42b7-4ac6-08d9ec2d7063
x-ms-traffictypediagnostic: CY4PR15MB1590:EE_
x-microsoft-antispam-prvs: <CY4PR15MB15900C14832C72F3DE7B787AC12F9@CY4PR15MB1590.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2qjwxMhxowDK4avkDVKmiPyw9V76q2n4WimiM6JfgEixSj/RTt2q25y7eQdLZOrXZN5MiTlFDpOuQH3JpOnKPmsqJX3OyUykzijooqAp3MW+rnpEIES9RameNEpTI6P7ROmzAD+mBcl5Nv2l2ckd0q7jR61uJYVQcYs7GAL4OvsK/QFmp5//xZCmtgcmvSyqesSQ5m/ob+bn/zQuAXDVQCQ9rp6baAFhKMKDMaWSkKbmFL8p0T8xFj4qpUHjtLwQCtC0ljXecXELnapUwD4RO7c0RYsYgzzyCN2OMAtZeL6SwOxzwAp7rQdUOTZ+SNSzJmV/RM3nKo/+edAVWQyQPW3YlizNMZARHocGyU7STrdlqvrHaBs+TT/FlFO6TccEzOPYHhQnBoXTPhXLrh37DiGgtwDqLBZhC2Co5ZQG2nR50XqKZrcGwuGxSeg39y7vUoQFfeKyFSEDNqaK0OxTNKfKwsD9puC8VVC3Xkf/jKrHmYj1uXS2HRC6hx141ewwRyA6t+QfdN8yjUXuZqJN9n8CooGeFweZYhEQNM/5bUDy1WW0MxHyqryA+Dp8f6myhEfrgkFMPPpzm2fmvhGJvckiplS/tO5+MZde0h19uW1rzmeiEjYt1qlk1ZSW5OVeWTjv7BCOzoGqvAW/aQ6hRSJClxB03ZtrpjrZ0TkEMIFNgswPePCKh1hZ2wNNWgm3n/P0MQQuO/gOZyV3Fsw3OA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(316002)(8936002)(5660300002)(110136005)(2906002)(6512007)(6506007)(122000001)(508600001)(26005)(2616005)(186003)(6486002)(86362001)(76116006)(64756008)(66556008)(66476007)(66446008)(66946007)(71200400001)(8676002)(36756003)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?acnSkyNBW0H7uwbdc4G3QaeqCoQFRdlifzmi77XwbZ8AH1PQX4lZ0v7iA/?=
 =?iso-8859-1?Q?t1rLABiG73B581sAdnhv7zvg5TrgajdWM/92TFIzACBkF2hILPlhhSXlgp?=
 =?iso-8859-1?Q?Yo+dj7HhNzkNoorlzIpOKBHLgNBnbOf2HvrYm3trDHt7XhB9Wo8SUIz5m2?=
 =?iso-8859-1?Q?jvtVR0RDCwpEillrXmx6SCL80/fKqkHN+Ht/rPw6AM50yOZXcRvS2ZPYxu?=
 =?iso-8859-1?Q?/WPA3Be/LxAXpU7oTrLRYkBXgEuE4hfwtFcTIhxkoXIRsmvWR6NnCGUNRB?=
 =?iso-8859-1?Q?2PGbOzLE9eeQ3WwA8Evq1XHvjK+8pJbjB5I0/J/Ys65BkAb7CPTB7TwqHT?=
 =?iso-8859-1?Q?o+aaM24zOH6nBI2SjbcOH5pi91yfSK+EmZx4MLRRRz3g0kQLDmD897MrhU?=
 =?iso-8859-1?Q?ntaY0VhCvpukoJd79lgwjycOQ/SwXTq0TMTjbBzR5hLo4tqltqVNyLh1/H?=
 =?iso-8859-1?Q?PuR0FLdhJMXOUOeq76zkPnl965lop/vYEkAYXSMD8ardX5Fgdp+0q8hNpB?=
 =?iso-8859-1?Q?7ncykTWqn1+9/2Dl9aBJjxw3TJvsezXnuV8p+M/aupwXFHtt+9Vk2eH7jj?=
 =?iso-8859-1?Q?rsu4T3D5ZiFxS/73E8U2YCRqqXZzSg/W1TbZfB9lDe4Z2GvrChBY2Z0Vc0?=
 =?iso-8859-1?Q?qJBDccXdXZYsfe6wmv+IckDfx+20JwjqZByAmNl8RVnW8Ay1l65Qq2J8mo?=
 =?iso-8859-1?Q?wSAwp0N3gpEojjB4Af/lod95Qesxec4PJlTtC76h9d6EMIc6ApsNpZyxgU?=
 =?iso-8859-1?Q?McE4cf0nVBbQqvH7XbL8zALnSUAiKUWO32aEuL6/fv1ce/4sZLnQMkFEjG?=
 =?iso-8859-1?Q?A6E4DDUxMMv6Wv/59BhZlXu34se1lxQoai0TvlkDNAl0Npjtmj7EOo/Vhp?=
 =?iso-8859-1?Q?ThcmcROAUE/jWAwYaUns3oNF3AmUDT0Jv+dQ2AOw7Y94i260X8zI4MyEnD?=
 =?iso-8859-1?Q?tC6a4q5521voHoDcHjKUcIsdVGQv+Qj+b3mhGDmqS3Qre+xRL/jCHkn9q7?=
 =?iso-8859-1?Q?5GF5Xftp6CcGesNjBvhQurBLf9DHfPbJd2qhzypkEiw4jVS4ZCDOZXPbdH?=
 =?iso-8859-1?Q?Sw/X9x3wL3yy8KmOs/lbuLNldesQYd5FoCImD6ZycHOhO2BdBqR/VkSrAT?=
 =?iso-8859-1?Q?Q9qcvre9Z6tuFvhqHK0PGW0AC5xxRc4V8HB71Ad8lrv28BNoYuL+n3N0Uc?=
 =?iso-8859-1?Q?M8vUofTLxqCOmqYauumspyY0wrf+nxxu2drBNIBEdDJ5XytXb30bG0YkS6?=
 =?iso-8859-1?Q?EzElL3OMRJWGrtZxOgmNPOl/Z1XiN1snAG815sd0MFQ+1lr9TLf4XXR4cb?=
 =?iso-8859-1?Q?jjU6ai1eA8qJH51QOH1EBesSBr7YkDWAuewokmfK/+b1iuAlBDvvLmSEvZ?=
 =?iso-8859-1?Q?RqGiU5q4COYEBhAn/MN0WPgLQjknaW9WXZ1F+w3Bb/mKtBpcZCLQ9Q+zL3?=
 =?iso-8859-1?Q?O1qbD7ELmmvHDeDEUuaGwYMI8zotGQzeEZJXyoHKSb3LX1zoG9EukNrnos?=
 =?iso-8859-1?Q?dfRdb00h2mX/MZl1ScbhSZcJNcXF4B/6Gjz81cKZvn9a7rVQvm7sSJEnnq?=
 =?iso-8859-1?Q?kEFd0ilbAPseYMznKrMsT3E5cV6NGk3A4kgSiKLNQCJZUPcrRbCNo8diJk?=
 =?iso-8859-1?Q?xt2rDJEr5CaRE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006ddca7-fa3c-42b7-4ac6-08d9ec2d7063
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 00:36:55.1232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5OLnpjXTiSEU576px7bmGGYcPDWtLFgBxMDp+YGmkrp9Fvp+7FniouRGp0T/EdLj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1590
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: hKnmtiOXKbS-_uBgSFGPEYMTFtjGQpN8
X-Proofpoint-ORIG-GUID: hKnmtiOXKbS-_uBgSFGPEYMTFtjGQpN8
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

When emitting type declations, btf_dump can now optionally rename
int types (including typedefs) to standard types with explicit sizes.
Types like pid_t get renamed but types like __u32, char, and _Bool
are left alone to preserve cast semantics in as many pre-existing
programs as possible.

This option is useful when generating data structures on a system where
types may differ due to arch differences or just userspace and bpf program
disagreeing on the definition of a typedef.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/lib/bpf/btf.h      |  4 +-
 tools/lib/bpf/btf_dump.c | 80 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 951ac7475794..dbd41bf93b13 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -347,9 +347,11 @@ struct btf_dump_emit_type_decl_opts {
 	int indent_level;
 	/* strip all the const/volatile/restrict mods */
 	bool strip_mods;
+	/* normalize int fields to (u)?int(16|32|64)_t types */
+	bool sizedints;
 	size_t :0;
 };
-#define btf_dump_emit_type_decl_opts__last_field strip_mods
+#define btf_dump_emit_type_decl_opts__last_field sizedints

 LIBBPF_API int
 btf_dump__emit_type_decl(struct btf_dump *d, __u32 id,
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 07ebe70d3a30..56bafacf1cbd 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -81,6 +81,7 @@ struct btf_dump {
 	void *cb_ctx;
 	int ptr_sz;
 	bool strip_mods;
+	bool sizedints;
 	bool skip_anon_defs;
 	int last_id;

@@ -1130,7 +1131,9 @@ int btf_dump__emit_type_decl(struct btf_dump *d, __u3=
2 id,
 	fname =3D OPTS_GET(opts, field_name, "");
 	lvl =3D OPTS_GET(opts, indent_level, 0);
 	d->strip_mods =3D OPTS_GET(opts, strip_mods, false);
+	d->sizedints =3D OPTS_GET(opts, sizedints, false);
 	btf_dump_emit_type_decl(d, id, fname, lvl);
+	d->sizedints =3D false;
 	d->strip_mods =3D false;
 	return 0;
 }
@@ -1263,6 +1266,34 @@ static void btf_dump_emit_name(const struct btf_dump=
 *d,
 	btf_dump_printf(d, "%s%s", separate ? " " : "", name);
 }

+/* Encode custom heurstics to find char types since BTF_INT_CHAR is never =
set. */
+static bool btf_is_char(const struct btf_dump *d, const struct btf_type *t=
)
+{
+	return btf_is_int(t) &&
+	       t->size =3D=3D 1 &&
+	       strcmp(btf_name_of(d, t->name_off), "char") =3D=3D 0;
+}
+
+static bool btf_is_bool(const struct btf_type *t)
+{
+	return btf_is_int(t) && (btf_int_encoding(t) & BTF_INT_BOOL);
+}
+
+/* returns true if type is of the '__[su](8|16|32|64)' type */
+static bool btf_is_kernel_sizedint(const struct btf_dump *d, const struct =
btf_type *t)
+{
+	const char *name =3D btf_name_of(d, t->name_off);
+
+	return strcmp(name, "__s8") =3D=3D 0 ||
+	       strcmp(name, "__u8") =3D=3D 0 ||
+	       strcmp(name, "__s16") =3D=3D 0 ||
+	       strcmp(name, "__u16") =3D=3D 0 ||
+	       strcmp(name, "__s32") =3D=3D 0 ||
+	       strcmp(name, "__u32") =3D=3D 0 ||
+	       strcmp(name, "__s64") =3D=3D 0 ||
+	       strcmp(name, "__u64") =3D=3D 0;
+}
+
 static void btf_dump_emit_type_chain(struct btf_dump *d,
 				     struct id_stack *decls,
 				     const char *fname, int lvl)
@@ -1277,10 +1308,12 @@ static void btf_dump_emit_type_chain(struct btf_dum=
p *d,
 	 * don't want to prepend space for that last pointer.
 	 */
 	bool last_was_ptr =3D true;
-	const struct btf_type *t;
+	const struct btf_type *t, *rest;
 	const char *name;
 	__u16 kind;
 	__u32 id;
+	__u8 intenc;
+	int restypeid;

 	while (decls->cnt) {
 		id =3D decls->ids[--decls->cnt];
@@ -1295,8 +1328,51 @@ static void btf_dump_emit_type_chain(struct btf_dump=
 *d,
 		t =3D btf__type_by_id(d->btf, id);
 		kind =3D btf_kind(t);

+		/* If we're asked to produce stdint declarations, we need
+		 * to only do that in the following cases:
+		 *  - int types other than char and _Bool
+		 *  - typedefs to int types (including char and _Bool) except
+		 *    kernel types like __s16/__u32/etc.
+		 *
+		 * If a typedef resolves to char or _Bool, we do want to use
+		 * the resolved type instead of the stdint types (i.e. char
+		 * instead of int8_t) because the stdint types are explicitly
+		 * signed/unsigned, which affects pointer casts.
+		 *
+		 * If the typedef is of the __s32 variety, we leave it as-is
+		 * due to incompatibilities in e.g. s64 vs int64_t definitions
+		 * (one is `long long` on x86_64 and the other is not).
+		 *
+		 * Unfortunately, the BTF type info never includes BTF_INT_CHAR,
+		 * so we use a size comparison to avoid chars and
+		 * BTF_INT_BOOL to avoid bools.
+		 */
+		if (d->sizedints && kind =3D=3D BTF_KIND_TYPEDEF &&
+		    !btf_is_kernel_sizedint(d, t)) {
+			restypeid =3D btf__resolve_type(d->btf, id);
+			if (restypeid >=3D 0) {
+				rest =3D btf__type_by_id(d->btf, restypeid);
+				if (rest && btf_is_int(rest)) {
+					t =3D rest;
+					kind =3D btf_kind(rest);
+				}
+			}
+		}
+
 		switch (kind) {
 		case BTF_KIND_INT:
+			btf_dump_emit_mods(d, decls);
+			if (d->sizedints && !btf_is_bool(t) && !btf_is_char(d, t)) {
+				intenc =3D btf_int_encoding(t);
+				btf_dump_printf(d,
+						intenc & BTF_INT_SIGNED ?
+						"int%d_t" : "uint%d_t",
+						t->size * 8);
+			} else {
+				name =3D btf_name_of(d, t->name_off);
+				btf_dump_printf(d, "%s", name);
+			}
+			break;
 		case BTF_KIND_FLOAT:
 			btf_dump_emit_mods(d, decls);
 			name =3D btf_name_of(d, t->name_off);
@@ -1469,7 +1545,9 @@ static void btf_dump_emit_type_cast(struct btf_dump *=
d, __u32 id,

 	d->skip_anon_defs =3D true;
 	d->strip_mods =3D true;
+	d->sizedints =3D true;
 	btf_dump_emit_type_decl(d, id, "", 0);
+	d->sizedints =3D false;
 	d->strip_mods =3D false;
 	d->skip_anon_defs =3D false;

--
2.34.1=
