Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336374DA516
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 23:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344201AbiCOWQi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 18:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345255AbiCOWQh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 18:16:37 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75835577B
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:15:23 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FLfkcB020039
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:15:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=QFTwaEYO+ibG8uY6y425JEOT7e0XT93C5Ujgt3Rs/8U=;
 b=oBVcTSUc9IVMEj9Rp+344j9yr44H7iVLI/Alpxf/5UQ9bWiZpZ4ccXvG3l4aQSx3SLZy
 C67Hx5Y5Lmrzj4tCUXzmaZ+U8+EjoOBa1+7EYcPpdTFsz5jW2QY4ZwX/EQKzEeGT5zFE
 YgmoHkKzIo5Wu1EQFr4UdsvGrY4lksT92mY= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3et7cycbb2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:15:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5nPitdJJLobbKBXozjXohjYHDhFcq36+HSCu/uoQ9kXiWlFiWlgOXe3mBQgyPO2PJUNK5je/v3VbGSrJF7NcxjYu/vmhzyFFnNxc1ZtRvym87Qka7Hhzqo0Bc3DRYPwOVG/oTViCoJ8a3BEGJwnlwrSYtm6eiuqwZdZkvUF1ZUXTGlzw7uYrxuGFUyFiAcsln1iqK2LPdWLzgVfFOJswQT4GGiAE1jIz3nKQyxoXVOfp73M/DcEQA0CqRrIrFd80xoLYx4nYQep3FTgXBLRXF05u/Lr1DQQQdPCWzyVcG7cVhaNyELpnOeAgLf8IY32hCtvHru53j4H7fGB9daTHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFTwaEYO+ibG8uY6y425JEOT7e0XT93C5Ujgt3Rs/8U=;
 b=g0vABuV/NPyNG6EsFH9J+4Y+lEiheqfRGClvj3B8FtiV8f1DKtCBNRTxwMQeTWQQAybxEbtPfpT00u58J+NujLCBmaWDQxG6D1q5tPqYL4kg9EZiTtojJf8GtmWbyWBse3Ig5nGPTEPVGKStPeb0g8NaUDz68aEPNwRQK4RJs5Huf7HwnjjnFF6quYu8Mq2c8UBI8vxDBa7bYy5kOU9xDAmNmv8ZoLw4GkcsCBjNZscjQ4DyhQH9NiJ4W6frXcXT4zRgU8RNJGs5CW2UE6xBjJ1+gvdb7CoCfFnaYJC597wnie3DOzpoh826ulmVccAGw20tF3NpMwoq7svLaPvXDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BYAPR15MB2695.namprd15.prod.outlook.com (2603:10b6:a03:150::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Tue, 15 Mar
 2022 22:15:17 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 22:15:17 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v3 4/5] bpftool: add support for subskeletons
Thread-Topic: [PATCH bpf-next v3 4/5] bpftool: add support for subskeletons
Thread-Index: AQHYOLol+WztxSpPs0O0PPej6M9nrA==
Date:   Tue, 15 Mar 2022 22:15:15 +0000
Message-ID: <bf6799b11254c6642318b0728b7452800b29c8e5.1647382072.git.delyank@fb.com>
References: <cover.1647382072.git.delyank@fb.com>
In-Reply-To: <cover.1647382072.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e97796b-38de-4223-ffe1-08da06d1497a
x-ms-traffictypediagnostic: BYAPR15MB2695:EE_
x-microsoft-antispam-prvs: <BYAPR15MB2695E395E9E88D0A604C651DC1109@BYAPR15MB2695.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kiN0M9C8Djuz4RVB1DgDTcSOPM9tpSs0KXaaQj6JAwBnanjEAidei4iYcTnwYdz7YECmUkAyi2coZcxKs6ppy43Ege4ccXuFv9xudtvE5B8WFSb0r03OjPBUmsLGF4NR6Z0ElKf1XcCvTjAJ3UG0/Oeky8dXIGAPspMCYarIrZ0aRtc6GOPkYsTjMb4d8+I86F+chTUf2w3vNFX0WHxdIbMLmZuxjQSFTSJB5t1KbW0FKhuvpZoFtLKeW7XY4pLVqJrSj03XmnHmaTbsWCt6rLKwh9M/5ETbcs3GIESJdaQm+d1SxNXhX1PEn3TBeOT06YSrxyObJd+Ri3Q/UHmD/MD754d1uzxRouESMXbX0ALxCAlrkoEeZtAlgJ1OjZ9Gd0Qa/3hjTjyapGBbwk3wHfhWJA9yHDfAUEat18vsqBGvvpCtS8jcHddljeRVF4pYCNc8RyQFOYd4VG0uUApgGW5HdsE9D/QIu3MOPnWr1zuDLU4WVs1gbUyjE9sxEt+3kEupY2EEXe5HfL7alwNj7VPSP56NciJwRvgCqSwMQgDYhlJw1g8TnyEXwlvJIW/AoMdP24zS9oJHUuDDyQZUSk4L+ZNNUNJg1mPeVaPUUXAd8VI0w/0T9hjdjH0rUw3H9M8B1MPbX4z3MlxO0njoL/4XgyKVULnTxrwW2C8vdjCBD5wSRQASKOXkkYmEakQ42oyhr7QA87+d7zuwSywqMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(66946007)(6512007)(6506007)(2616005)(64756008)(38100700002)(8676002)(76116006)(66556008)(91956017)(122000001)(66476007)(2906002)(186003)(83380400001)(316002)(110136005)(6486002)(38070700005)(71200400001)(508600001)(30864003)(86362001)(36756003)(8936002)(5660300002)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Sc7P2p88kzMB8452V9EaXxgG4np9+5JvBzxdhaKEtkW6XiFGTXNhoHvOen?=
 =?iso-8859-1?Q?kZImDCTEAWYjzLJsSf0JbHDlm7en8UQKisToyLyfMzFZLla9cTl8kayk87?=
 =?iso-8859-1?Q?Iw/lz7P6xUVoGfsisS2Advxyf+9feTgLiXvxrpV9rTkZj1wNOUB9wCx2v2?=
 =?iso-8859-1?Q?/yF2or8HRjnbPDoZaDT6Tlu+YV7zZ/AHmrIvBJPVbcIB2vsLpYD/vcoh7s?=
 =?iso-8859-1?Q?Sfvf2o9X1UPA3gN883D93P/qOQ3Pz4v6bG9wHZYovAncCzZffNgQl61w9D?=
 =?iso-8859-1?Q?pjqLtvorHDt3YKRTnrB7lJPg34O9ETwbNT4F6S7Qh4MUGIw7TpsR3lGnZP?=
 =?iso-8859-1?Q?wPirqHbtVwQVfIHhRYZQFFz2ASEq9uG0ZZrJOX7Kj6HWMSjve41f04n3pU?=
 =?iso-8859-1?Q?jx9Bclgyf7QyUypi5mdqAJpVlujBI0qNn5+Sfq9fWklw1GCUVL6orMHQfp?=
 =?iso-8859-1?Q?pQ8jvFJ/pNPtGGuAcyvj54Ubt5TSeF0vjiJrOU2rBXkEwX8sGKJoosMAyq?=
 =?iso-8859-1?Q?JR1I+FSlgpBg+n0O6U13bqc6PFnLsSkikoVm7I4wDJAshyd6sNi+hhtQCy?=
 =?iso-8859-1?Q?Mhm0llVY/PCvL1YwavBwkCcjVHIHFMJ4nGkKnKYG8MMKIaCXBHXAKcv3aq?=
 =?iso-8859-1?Q?p8Jp4zmxOghFjJVwUPqLjN8ITEgEUuzLkOzpNFM1xadvMedxwZ18GTS9Gl?=
 =?iso-8859-1?Q?0UzwRtn7k16lPzu3X1Qe409vIXx91rY8L3VwAmaE0SfYWybQhaqqCWtcL4?=
 =?iso-8859-1?Q?gHrwuyi5bWTtJ+uqlFOe9F6+KtUy0rTw+CJijjQfW9Trd6QsQSdBBgU7Lo?=
 =?iso-8859-1?Q?DbhCqlUphEkFKMqqLceFrzXYUE2AVYtkGnHcM6/V0iGPwFkxX0DBN8+cZy?=
 =?iso-8859-1?Q?XvG2GkPLb+tVXIxpnS1ZtRgjuh7615hd7MiTvoOB06bH8dqE3gPWGzl3UX?=
 =?iso-8859-1?Q?lu47oLjQdqSqpzGkqIPg/kX9kimVCXTANgwBFT2ZV6OO/JHOK2JtTBCIYQ?=
 =?iso-8859-1?Q?fgAx8bXqhmIZgfb5xDjfROc1c30LsiakNVF59K4yzd4jzHKNOrCClquNxi?=
 =?iso-8859-1?Q?XaBUS+X+yN/tlBHnDvRcKnIUV7AJZ3mudAzbr9Pir65VyaE8gdUnro8iAP?=
 =?iso-8859-1?Q?d/N1wEv0M/IUFq9+DxIitRg0wRm+ki4r8wcmrLuB2N1AY56YglMzS8NSGo?=
 =?iso-8859-1?Q?pB4tlfzHonLL1JAgKiflHl9VaYz8PSKd0DGlabmQaUt0LmVUa4ArBLwOqB?=
 =?iso-8859-1?Q?rtJJpu21xVnU2FnQuhPdyUh8IiCULIOLC3wqesQ+CtGa5GHmA+ElXM+lSV?=
 =?iso-8859-1?Q?MIPew3FpKoa1CuR9wEF9ZkV/TTgA7h50lAxsaptwk1Afcbw709Leq622fX?=
 =?iso-8859-1?Q?z9hsV4QID41TaZ/reAGAcKoiH7UjpDzTWBOKTVH4duaoYDxfkMq2kR19bA?=
 =?iso-8859-1?Q?lgko1agVrKvJNNdQ02gQ1319uzc58rbu6EOWXxkWeVfevg8bpk8pPsrl5W?=
 =?iso-8859-1?Q?iQmYyC/8j6/ajiTrzeJ3W1gl3s3pnpiI2I3ZlI8j5BntpHVqTf/jyMH9kP?=
 =?iso-8859-1?Q?hbqHMfQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e97796b-38de-4223-ffe1-08da06d1497a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 22:15:15.8159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZ6sa1Lb5yzAk6JzEttFf+n3ojMlU7D1/xkupe3DblBsgBFVYeGZwAiMLG5ASulu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2695
X-Proofpoint-GUID: JDr653u41897qKCwzTw65Qm-7d8AQv5N
X-Proofpoint-ORIG-GUID: JDr653u41897qKCwzTw65Qm-7d8AQv5N
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

Subskeletons are headers which require an already loaded program to
operate.

For example, when a BPF library is linked into a larger BPF object file,
the library userspace needs a way to access its own global variables
without requiring knowledge about the larger program at build time.

As a result, subskeletons require a loaded bpf_object to open().
Further, they find their own symbols in the larger program by
walking BTF type data at run time.

At this time, programs, maps, and globals are supported through
non-owning pointers.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 .../bpf/bpftool/Documentation/bpftool-gen.rst |  25 +
 tools/bpf/bpftool/bash-completion/bpftool     |  14 +-
 tools/bpf/bpftool/gen.c                       | 595 +++++++++++++++---
 3 files changed, 549 insertions(+), 85 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bp=
ftool/Documentation/bpftool-gen.rst
index 18d646b571ec..68454ef28f58 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
@@ -25,6 +25,7 @@ GEN COMMANDS
=20
 |	**bpftool** **gen object** *OUTPUT_FILE* *INPUT_FILE* [*INPUT_FILE*...]
 |	**bpftool** **gen skeleton** *FILE* [**name** *OBJECT_NAME*]
+|	**bpftool** **gen subskeleton** *FILE* [**name** *OBJECT_NAME*]
 |	**bpftool** **gen min_core_btf** *INPUT* *OUTPUT* *OBJECT* [*OBJECT*...]
 |	**bpftool** **gen help**
=20
@@ -150,6 +151,30 @@ DESCRIPTION
 		  (non-read-only) data from userspace, with same simplicity
 		  as for BPF side.
=20
+	**bpftool gen subskeleton** *FILE*
+		  Generate BPF subskeleton C header file for a given *FILE*.
+
+		  Subskeletons are similar to skeletons, except they do not own
+		  the corresponding maps, programs, or global variables. They
+		  require that the object file used to generate them is already
+		  loaded into a *bpf_object* by some other means.
+
+		  This functionality is useful when a library is included into a
+		  larger BPF program. A subskeleton for the library would have
+		  access to all objects and globals defined in it, without
+		  having to know about the larger program.
+
+		  Consequently, there are only two functions defined
+		  for subskeletons:
+
+		  - **example__open(bpf_object\*)**
+		    Instantiates a subskeleton from an already opened (but not
+		    necessarily loaded) **bpf_object**.
+
+		  - **example__destroy()**
+		    Frees the storage for the subskeleton but *does not* unload
+		    any BPF programs or maps.
+
 	**bpftool** **gen min_core_btf** *INPUT* *OUTPUT* *OBJECT* [*OBJECT*...]
 		  Generate a minimum BTF file as *OUTPUT*, derived from a given
 		  *INPUT* BTF file, containing all needed BTF types so one, or
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/=
bash-completion/bpftool
index 958e1fd71b5c..5df8d72c5179 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -1003,13 +1003,25 @@ _bpftool()
                             ;;
                     esac
                     ;;
+                subskeleton)
+                    case $prev in
+                        $command)
+                            _filedir
+                            return 0
+                            ;;
+                        *)
+                            _bpftool_once_attr 'name'
+                            return 0
+                            ;;
+                    esac
+                    ;;
                 min_core_btf)
                     _filedir
                     return 0
                     ;;
                 *)
                     [[ $prev =3D=3D $object ]] && \
-                        COMPREPLY=3D( $( compgen -W 'object skeleton help =
min_core_btf' -- "$cur" ) )
+                        COMPREPLY=3D( $( compgen -W 'object skeleton subsk=
eleton help min_core_btf' -- "$cur" ) )
                     ;;
             esac
             ;;
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 145734b4fe41..309fbc33e89f 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -64,11 +64,11 @@ static void get_obj_name(char *name, const char *file)
 	sanitize_identifier(name);
 }
=20
-static void get_header_guard(char *guard, const char *obj_name)
+static void get_header_guard(char *guard, const char *obj_name, const char=
 *suffix)
 {
 	int i;
=20
-	sprintf(guard, "__%s_SKEL_H__", obj_name);
+	sprintf(guard, "__%s_%s__", obj_name, suffix);
 	for (i =3D 0; guard[i]; i++)
 		guard[i] =3D toupper(guard[i]);
 }
@@ -231,6 +231,17 @@ static const struct btf_type *find_type_for_map(struct=
 btf *btf, const char *map
 	return NULL;
 }
=20
+static bool bpf_map__is_internal_mmappable(const struct bpf_map *map, char=
 *buf, size_t sz)
+{
+	if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPA=
BLE))
+		return false;
+
+	if (!get_map_ident(map, buf, sz))
+		return false;
+
+	return true;
+}
+
 static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
 {
 	struct btf *btf =3D bpf_object__btf(obj);
@@ -247,12 +258,7 @@ static int codegen_datasecs(struct bpf_object *obj, co=
nst char *obj_name)
=20
 	bpf_object__for_each_map(map, obj) {
 		/* only generate definitions for memory-mapped internal maps */
-		if (!bpf_map__is_internal(map))
-			continue;
-		if (!(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
-			continue;
-
-		if (!get_map_ident(map, map_ident, sizeof(map_ident)))
+		if (!bpf_map__is_internal_mmappable(map, map_ident, sizeof(map_ident)))
 			continue;
=20
 		sec =3D find_type_for_map(btf, map_ident);
@@ -280,6 +286,96 @@ static int codegen_datasecs(struct bpf_object *obj, co=
nst char *obj_name)
 	return err;
 }
=20
+static bool btf_is_ptr_to_func_proto(const struct btf *btf,
+				     const struct btf_type *v)
+{
+	return btf_is_ptr(v) && btf_is_func_proto(btf__type_by_id(btf, v->type));
+}
+
+static int codegen_subskel_datasecs(struct bpf_object *obj, const char *ob=
j_name)
+{
+	struct btf *btf =3D bpf_object__btf(obj);
+	struct btf_dump *d;
+	struct bpf_map *map;
+	const struct btf_type *sec, *var;
+	const struct btf_var_secinfo *sec_var;
+	int i, err =3D 0, vlen;
+	char map_ident[256], sec_ident[256];
+	bool strip_mods =3D false, needs_typeof =3D false;
+	const char *sec_name, *var_name;
+	__u32 var_type_id;
+
+	d =3D btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
+	if (!d)
+		return -errno;
+
+	bpf_object__for_each_map(map, obj) {
+		/* only generate definitions for memory-mapped internal maps */
+		if (!bpf_map__is_internal_mmappable(map, map_ident, sizeof(map_ident)))
+			continue;
+
+		sec =3D find_type_for_map(btf, map_ident);
+		if (!sec)
+			continue;
+
+		sec_name =3D btf__name_by_offset(btf, sec->name_off);
+		if (!get_datasec_ident(sec_name, sec_ident, sizeof(sec_ident)))
+			continue;
+
+		strip_mods =3D strcmp(sec_name, ".kconfig") !=3D 0;
+		printf("	struct %s__%s {\n", obj_name, sec_ident);
+
+		sec_var =3D btf_var_secinfos(sec);
+		vlen =3D btf_vlen(sec);
+		for (i =3D 0; i < vlen; i++, sec_var++) {
+			DECLARE_LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts,
+				.indent_level =3D 2,
+				.strip_mods =3D strip_mods,
+				/* we'll print the name separately */
+				.field_name =3D "",
+			);
+
+			var =3D btf__type_by_id(btf, sec_var->type);
+			var_name =3D btf__name_by_offset(btf, var->name_off);
+			var_type_id =3D var->type;
+
+			/* static variables are not exposed through BPF skeleton */
+			if (btf_var(var)->linkage =3D=3D BTF_VAR_STATIC)
+				continue;
+
+			/* The datasec member has KIND_VAR but we want the
+			 * underlying type of the variable (e.g. KIND_INT).
+			 */
+			var =3D skip_mods_and_typedefs(btf, var->type, NULL);
+
+			printf("\t\t");
+			/* Func and array members require special handling.
+			 * Instead of producing `typename *var`, they produce
+			 * `typeof(typename) *var`. This allows us to keep a
+			 * similar syntax where the identifier is just prefixed
+			 * by *, allowing us to ignore C declaration minutae.
+			 */
+			needs_typeof =3D btf_is_array(var) || btf_is_ptr_to_func_proto(btf, var=
);
+			if (needs_typeof)
+				printf("typeof(");
+
+			err =3D btf_dump__emit_type_decl(d, var_type_id, &opts);
+			if (err)
+				goto out;
+
+			if (needs_typeof)
+				printf(")");
+
+			printf(" *%s;\n", var_name);
+		}
+		printf("	} %s;\n", sec_ident);
+	}
+
+out:
+	btf_dump__free(d);
+	return err;
+}
+
 static void codegen(const char *template, ...)
 {
 	const char *src, *end;
@@ -389,11 +485,7 @@ static void codegen_asserts(struct bpf_object *obj, co=
nst char *obj_name)
 		", obj_name);
=20
 	bpf_object__for_each_map(map, obj) {
-		if (!bpf_map__is_internal(map))
-			continue;
-		if (!(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
-			continue;
-		if (!get_map_ident(map, map_ident, sizeof(map_ident)))
+		if (!bpf_map__is_internal_mmappable(map, map_ident, sizeof(map_ident)))
 			continue;
=20
 		sec =3D find_type_for_map(btf, map_ident);
@@ -608,11 +700,7 @@ static int gen_trace(struct bpf_object *obj, const cha=
r *obj_name, const char *h
 		const void *mmap_data =3D NULL;
 		size_t mmap_size =3D 0;
=20
-		if (!get_map_ident(map, ident, sizeof(ident)))
-			continue;
-
-		if (!bpf_map__is_internal(map) ||
-		    !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
+		if (!bpf_map__is_internal_mmappable(map, ident, sizeof(ident)))
 			continue;
=20
 		codegen("\
@@ -671,11 +759,7 @@ static int gen_trace(struct bpf_object *obj, const cha=
r *obj_name, const char *h
 	bpf_object__for_each_map(map, obj) {
 		const char *mmap_flags;
=20
-		if (!get_map_ident(map, ident, sizeof(ident)))
-			continue;
-
-		if (!bpf_map__is_internal(map) ||
-		    !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
+		if (!bpf_map__is_internal_mmappable(map, ident, sizeof(ident)))
 			continue;
=20
 		if (bpf_map__map_flags(map) & BPF_F_RDONLY_PROG)
@@ -727,10 +811,96 @@ static int gen_trace(struct bpf_object *obj, const ch=
ar *obj_name, const char *h
 	return err;
 }
=20
+static void
+codegen_maps_skeleton(struct bpf_object *obj, size_t map_cnt, bool mmaped)
+{
+	struct bpf_map *map;
+	char ident[256];
+	size_t i;
+
+	if (!map_cnt)
+		return;
+
+	codegen("\
+		\n\
+									\n\
+			/* maps */				    \n\
+			s->map_cnt =3D %zu;			    \n\
+			s->map_skel_sz =3D sizeof(*s->maps);	    \n\
+			s->maps =3D (struct bpf_map_skeleton *)calloc(s->map_cnt, s->map_skel_s=
z);\n\
+			if (!s->maps)				    \n\
+				goto err;			    \n\
+		",
+		map_cnt
+	);
+	i =3D 0;
+	bpf_object__for_each_map(map, obj) {
+		if (!get_map_ident(map, ident, sizeof(ident)))
+			continue;
+
+		codegen("\
+			\n\
+									\n\
+				s->maps[%zu].name =3D \"%s\";	    \n\
+				s->maps[%zu].map =3D &obj->maps.%s;   \n\
+			",
+			i, bpf_map__name(map), i, ident);
+		/* memory-mapped internal maps */
+		if (mmaped && bpf_map__is_internal(map) &&
+			(bpf_map__map_flags(map) & BPF_F_MMAPABLE)) {
+			printf("\ts->maps[%zu].mmaped =3D (void **)&obj->%s;\n",
+				i, ident);
+		}
+		i++;
+	}
+}
+
+static void
+codegen_progs_skeleton(struct bpf_object *obj, size_t prog_cnt, bool popul=
ate_links)
+{
+	struct bpf_program *prog;
+	int i;
+
+	if (!prog_cnt)
+		return;
+
+	codegen("\
+		\n\
+									\n\
+			/* programs */				    \n\
+			s->prog_cnt =3D %zu;			    \n\
+			s->prog_skel_sz =3D sizeof(*s->progs);	    \n\
+			s->progs =3D (struct bpf_prog_skeleton *)calloc(s->prog_cnt, s->prog_sk=
el_sz);\n\
+			if (!s->progs)				    \n\
+				goto err;			    \n\
+		",
+		prog_cnt
+	);
+	i =3D 0;
+	bpf_object__for_each_program(prog, obj) {
+		codegen("\
+			\n\
+									\n\
+				s->progs[%1$zu].name =3D \"%2$s\";    \n\
+				s->progs[%1$zu].prog =3D &obj->progs.%2$s;\n\
+			",
+			i, bpf_program__name(prog));
+
+		if (populate_links) {
+			codegen("\
+				\n\
+					s->progs[%1$zu].link =3D &obj->links.%2$s;\n\
+				",
+				i, bpf_program__name(prog));
+		}
+		i++;
+	}
+}
+
 static int do_skeleton(int argc, char **argv)
 {
 	char header_guard[MAX_OBJ_NAME_LEN + sizeof("__SKEL_H__")];
-	size_t i, map_cnt =3D 0, prog_cnt =3D 0, file_sz, mmap_sz;
+	size_t map_cnt =3D 0, prog_cnt =3D 0, file_sz, mmap_sz;
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
 	char obj_name[MAX_OBJ_NAME_LEN] =3D "", *obj_data;
 	struct bpf_object *obj =3D NULL;
@@ -821,7 +991,7 @@ static int do_skeleton(int argc, char **argv)
 		prog_cnt++;
 	}
=20
-	get_header_guard(header_guard, obj_name);
+	get_header_guard(header_guard, obj_name, "SKEL_H");
 	if (use_loader) {
 		codegen("\
 		\n\
@@ -1024,66 +1194,10 @@ static int do_skeleton(int argc, char **argv)
 		",
 		obj_name
 	);
-	if (map_cnt) {
-		codegen("\
-			\n\
-									    \n\
-				/* maps */				    \n\
-				s->map_cnt =3D %zu;			    \n\
-				s->map_skel_sz =3D sizeof(*s->maps);	    \n\
-				s->maps =3D (struct bpf_map_skeleton *)calloc(s->map_cnt, s->map_skel_=
sz);\n\
-				if (!s->maps)				    \n\
-					goto err;			    \n\
-			",
-			map_cnt
-		);
-		i =3D 0;
-		bpf_object__for_each_map(map, obj) {
-			if (!get_map_ident(map, ident, sizeof(ident)))
-				continue;
=20
-			codegen("\
-				\n\
-									    \n\
-					s->maps[%zu].name =3D \"%s\";	    \n\
-					s->maps[%zu].map =3D &obj->maps.%s;   \n\
-				",
-				i, bpf_map__name(map), i, ident);
-			/* memory-mapped internal maps */
-			if (bpf_map__is_internal(map) &&
-			    (bpf_map__map_flags(map) & BPF_F_MMAPABLE)) {
-				printf("\ts->maps[%zu].mmaped =3D (void **)&obj->%s;\n",
-				       i, ident);
-			}
-			i++;
-		}
-	}
-	if (prog_cnt) {
-		codegen("\
-			\n\
-									    \n\
-				/* programs */				    \n\
-				s->prog_cnt =3D %zu;			    \n\
-				s->prog_skel_sz =3D sizeof(*s->progs);	    \n\
-				s->progs =3D (struct bpf_prog_skeleton *)calloc(s->prog_cnt, s->prog_s=
kel_sz);\n\
-				if (!s->progs)				    \n\
-					goto err;			    \n\
-			",
-			prog_cnt
-		);
-		i =3D 0;
-		bpf_object__for_each_program(prog, obj) {
-			codegen("\
-				\n\
-									    \n\
-					s->progs[%1$zu].name =3D \"%2$s\";    \n\
-					s->progs[%1$zu].prog =3D &obj->progs.%2$s;\n\
-					s->progs[%1$zu].link =3D &obj->links.%2$s;\n\
-				",
-				i, bpf_program__name(prog));
-			i++;
-		}
-	}
+	codegen_maps_skeleton(obj, map_cnt, true /*mmaped*/);
+	codegen_progs_skeleton(obj, prog_cnt, true /*populate_links*/);
+
 	codegen("\
 		\n\
 									    \n\
@@ -1141,6 +1255,317 @@ static int do_skeleton(int argc, char **argv)
 	return err;
 }
=20
+/* Subskeletons are like skeletons, except they don't own the bpf_object,
+ * associated maps, links, etc. Instead, they know about the existence of
+ * variables, maps, programs and are able to find their locations
+ * _at runtime_ from an already loaded bpf_object.
+ *
+ * This allows for library-like BPF objects to have userspace counterparts
+ * with access to their own items without having to know anything about th=
e
+ * final BPF object that the library was linked into.
+ */
+static int do_subskeleton(int argc, char **argv)
+{
+	char header_guard[MAX_OBJ_NAME_LEN + sizeof("__SUBSKEL_H__")];
+	size_t i, len, file_sz, map_cnt =3D 0, prog_cnt =3D 0, mmap_sz, var_cnt =
=3D 0, var_idx =3D 0;
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
+	char obj_name[MAX_OBJ_NAME_LEN] =3D "", *obj_data;
+	struct bpf_object *obj =3D NULL;
+	const char *file, *var_name;
+	char ident[256], var_ident[256];
+	int fd, err =3D -1, map_type_id;
+	const struct bpf_map *map;
+	struct bpf_program *prog;
+	struct btf *btf;
+	const struct btf_type *map_type, *var_type;
+	const struct btf_var_secinfo *var;
+	struct stat st;
+
+	if (!REQ_ARGS(1)) {
+		usage();
+		return -1;
+	}
+	file =3D GET_ARG();
+
+	while (argc) {
+		if (!REQ_ARGS(2))
+			return -1;
+
+		if (is_prefix(*argv, "name")) {
+			NEXT_ARG();
+
+			if (obj_name[0] !=3D '\0') {
+				p_err("object name already specified");
+				return -1;
+			}
+
+			strncpy(obj_name, *argv, MAX_OBJ_NAME_LEN - 1);
+			obj_name[MAX_OBJ_NAME_LEN - 1] =3D '\0';
+		} else {
+			p_err("unknown arg %s", *argv);
+			return -1;
+		}
+
+		NEXT_ARG();
+	}
+
+	if (argc) {
+		p_err("extra unknown arguments");
+		return -1;
+	}
+
+	if (use_loader) {
+		p_err("cannot use loader for subskeletons");
+		return -1;
+	}
+
+	if (stat(file, &st)) {
+		p_err("failed to stat() %s: %s", file, strerror(errno));
+		return -1;
+	}
+	file_sz =3D st.st_size;
+	mmap_sz =3D roundup(file_sz, sysconf(_SC_PAGE_SIZE));
+	fd =3D open(file, O_RDONLY);
+	if (fd < 0) {
+		p_err("failed to open() %s: %s", file, strerror(errno));
+		return -1;
+	}
+	obj_data =3D mmap(NULL, mmap_sz, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (obj_data =3D=3D MAP_FAILED) {
+		obj_data =3D NULL;
+		p_err("failed to mmap() %s: %s", file, strerror(errno));
+		goto out;
+	}
+	if (obj_name[0] =3D=3D '\0')
+		get_obj_name(obj_name, file);
+
+	/* The empty object name allows us to use bpf_map__name and produce
+	 * ELF section names out of it. (".data" instead of "obj.data")
+	 */
+	opts.object_name =3D "";
+	obj =3D bpf_object__open_mem(obj_data, file_sz, &opts);
+	if (!obj) {
+		char err_buf[256];
+
+		libbpf_strerror(errno, err_buf, sizeof(err_buf));
+		p_err("failed to open BPF object file: %s", err_buf);
+		obj =3D NULL;
+		goto out;
+	}
+
+	btf =3D bpf_object__btf(obj);
+	if (!btf) {
+		err =3D -1;
+		p_err("need btf type information for %s", obj_name);
+		goto out;
+	}
+
+	bpf_object__for_each_program(prog, obj) {
+		prog_cnt++;
+	}
+
+	/* First, count how many variables we have to find.
+	 * We need this in advance so the subskel can allocate the right
+	 * amount of storage.
+	 */
+	bpf_object__for_each_map(map, obj) {
+		if (!get_map_ident(map, ident, sizeof(ident)))
+			continue;
+
+		/* Also count all maps that have a name */
+		map_cnt++;
+
+		if (!bpf_map__is_internal(map))
+			continue;
+		if (!(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
+			continue;
+
+		map_type_id =3D bpf_map__btf_value_type_id(map);
+		if (map_type_id < 0) {
+			err =3D map_type_id;
+			goto out;
+		}
+		map_type =3D btf__type_by_id(btf, map_type_id);
+
+		var =3D btf_var_secinfos(map_type);
+		len =3D btf_vlen(map_type);
+		for (i =3D 0; i < len; i++, var++) {
+			var_type =3D btf__type_by_id(btf, var->type);
+
+			if (btf_var(var_type)->linkage =3D=3D BTF_VAR_STATIC)
+				continue;
+
+			var_cnt++;
+		}
+	}
+
+	get_header_guard(header_guard, obj_name, "SUBSKEL_H");
+	codegen("\
+	\n\
+	/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */   \n\
+								    \n\
+	/* THIS FILE IS AUTOGENERATED! */			    \n\
+	#ifndef %2$s						    \n\
+	#define %2$s						    \n\
+								    \n\
+	#include <errno.h>					    \n\
+	#include <stdlib.h>					    \n\
+	#include <bpf/libbpf.h>					    \n\
+								    \n\
+	struct %1$s {						    \n\
+		struct bpf_object *obj;				    \n\
+		struct bpf_object_subskeleton *subskel;		    \n\
+	", obj_name, header_guard);
+
+	if (map_cnt) {
+		printf("\tstruct {\n");
+		bpf_object__for_each_map(map, obj) {
+			if (!get_map_ident(map, ident, sizeof(ident)))
+				continue;
+			printf("\t\tstruct bpf_map *%s;\n", ident);
+		}
+		printf("\t} maps;\n");
+	}
+
+	if (prog_cnt) {
+		printf("\tstruct {\n");
+		bpf_object__for_each_program(prog, obj) {
+			printf("\t\tstruct bpf_program *%s;\n",
+				bpf_program__name(prog));
+		}
+		printf("\t} progs;\n");
+	}
+
+	err =3D codegen_subskel_datasecs(obj, obj_name);
+	if (err)
+		goto out;
+
+	/* emit code that will allocate enough storage for all symbols */
+	codegen("\
+		\n\
+									    \n\
+		#ifdef __cplusplus					    \n\
+			static inline struct %1$s *open(const struct bpf_object *src);\n\
+			static inline void destroy(struct %1$s *skel);\n\
+		#endif /* __cplusplus */				    \n\
+		};							    \n\
+									    \n\
+		static inline void					    \n\
+		%1$s__destroy(struct %1$s *skel)			    \n\
+		{							    \n\
+			if (!skel)					    \n\
+				return;					    \n\
+			if (skel->subskel)				    \n\
+				bpf_object__destroy_subskeleton(skel->subskel);\n\
+			free(skel);					    \n\
+		}							    \n\
+									    \n\
+		static inline struct %1$s *				    \n\
+		%1$s__open(const struct bpf_object *src)		    \n\
+		{							    \n\
+			struct %1$s *obj;				    \n\
+			struct bpf_object_subskeleton *s;		    \n\
+			int err;					    \n\
+									    \n\
+			obj =3D (struct %1$s *)calloc(1, sizeof(*obj));	    \n\
+			if (!obj) {					    \n\
+				errno =3D ENOMEM;				    \n\
+				goto err;				    \n\
+			}						    \n\
+			s =3D (struct bpf_object_subskeleton *)calloc(1, sizeof(*s));\n\
+			if (!s) {					    \n\
+				errno =3D ENOMEM;				    \n\
+				goto err;				    \n\
+			}						    \n\
+			s->sz =3D sizeof(*s);				    \n\
+			s->obj =3D src;					    \n\
+			s->var_skel_sz =3D sizeof(*s->vars);		    \n\
+			obj->subskel =3D s;				    \n\
+									    \n\
+			/* vars */					    \n\
+			s->var_cnt =3D %2$d;				    \n\
+			s->vars =3D (struct bpf_var_skeleton *)calloc(%2$d, sizeof(*s->vars));\=
n\
+			if (!s->vars) {					    \n\
+				errno =3D ENOMEM;				    \n\
+				goto err;				    \n\
+			}						    \n\
+									    \n\
+		",
+		obj_name, var_cnt
+	);
+
+	/* walk through each symbol and emit the runtime representation */
+	bpf_object__for_each_map(map, obj) {
+		if (!bpf_map__is_internal_mmappable(map, ident, sizeof(ident)))
+			continue;
+
+		map_type_id =3D bpf_map__btf_value_type_id(map);
+		if (map_type_id < 0)
+			/* skip over internal maps with no type*/
+			continue;
+
+		map_type =3D btf__type_by_id(btf, map_type_id);
+		var =3D btf_var_secinfos(map_type);
+		len =3D btf_vlen(map_type);
+		for (i =3D 0; i < len; i++, var++) {
+			var_type =3D btf__type_by_id(btf, var->type);
+			var_name =3D btf__name_by_offset(btf, var_type->name_off);
+
+			if (btf_var(var_type)->linkage =3D=3D BTF_VAR_STATIC)
+				continue;
+
+			var_ident[0] =3D '\0';
+			strncat(var_ident, var_name, sizeof(var_ident) - 1);
+			sanitize_identifier(var_ident);
+
+			/* Note that we use the dot prefix in .data as the
+			 * field access operator i.e. maps%s becomes maps.data
+			 */
+			codegen("\
+			\n\
+				s->vars[%4$d].name =3D \"%1$s\";		    \n\
+				s->vars[%4$d].map =3D &obj->maps.%3$s;	    \n\
+				s->vars[%4$d].addr =3D (void**) &obj->%2$s.%1$s;\n\
+			", var_ident, ident, ident, var_idx);
+
+			var_idx++;
+		}
+	}
+
+	codegen_maps_skeleton(obj, map_cnt, false /*mmaped*/);
+	codegen_progs_skeleton(obj, prog_cnt, false /*links*/);
+
+	codegen("\
+		\n\
+									    \n\
+			err =3D bpf_object__open_subskeleton(s);		    \n\
+			if (err)					    \n\
+				goto err;				    \n\
+									    \n\
+			return obj;					    \n\
+		err:							    \n\
+			%1$s__destroy(obj);				    \n\
+			errno =3D -err;					    \n\
+			return NULL;					    \n\
+		}							    \n\
+									    \n\
+		#ifdef __cplusplus					    \n\
+		struct %1$s *%1$s::open(const struct bpf_object *src) { return %1$s__ope=
n(src); }\n\
+		void %1$s::destroy(struct %1$s *skel) { %1$s__destroy(skel); }\n\
+		#endif /* __cplusplus */				    \n\
+									    \n\
+		#endif /* %2$s */					    \n\
+		",
+		obj_name, header_guard);
+	err =3D 0;
+out:
+	bpf_object__close(obj);
+	if (obj_data)
+		munmap(obj_data, mmap_sz);
+	close(fd);
+	return err;
+}
+
 static int do_object(int argc, char **argv)
 {
 	struct bpf_linker *linker;
@@ -1192,6 +1617,7 @@ static int do_help(int argc, char **argv)
 	fprintf(stderr,
 		"Usage: %1$s %2$s object OUTPUT_FILE INPUT_FILE [INPUT_FILE...]\n"
 		"       %1$s %2$s skeleton FILE [name OBJECT_NAME]\n"
+		"       %1$s %2$s subskeleton FILE [name OBJECT_NAME]\n"
 		"       %1$s %2$s min_core_btf INPUT OUTPUT OBJECT [OBJECT...]\n"
 		"       %1$s %2$s help\n"
 		"\n"
@@ -1788,6 +2214,7 @@ static int do_min_core_btf(int argc, char **argv)
 static const struct cmd cmds[] =3D {
 	{ "object",		do_object },
 	{ "skeleton",		do_skeleton },
+	{ "subskeleton",	do_subskeleton },
 	{ "min_core_btf",	do_min_core_btf},
 	{ "help",		do_help },
 	{ 0 }
--=20
2.34.1
