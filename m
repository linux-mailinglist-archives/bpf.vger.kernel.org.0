Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADE64DBB27
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 00:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241862AbiCPXio (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 19:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237131AbiCPXin (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 19:38:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E9015A3B
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 16:37:28 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22GHCfHt029189
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 16:37:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=hfZ+7B8+rQME8aGAg2CqRdxuQ+JlW8/OtWtmBF5Lva8=;
 b=Yg0Uc8GZ49BikCPLfGKjXIjD1jutT5g5O/jDyiQefeL8GytW6UeFmYa7nMxwllKbqywG
 XnBTocXJgYbj5gCCfU3B91IpHmj2d584iv7iNJ9nYgx9OQ76YEb6WR+xtgkfr0LuSL+U
 BpyGrkRYe3JzZJKybC6LSb0CPDtsIpZXnUQ= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3et9d0m35c-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 16:37:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CB/NKR5BWSvhn6qokATr5SwPsFtovPzJ24/jxSxoRpzed6FJAvpeweT+1APUNtBsOZh7Jr54zpuA1OmSc2He0kwQhYnVqxqyKE5PWWzbrxzg67tUAo9iFkoJhfCIm5ZRCW4oIp3jwcBIC2Rx8oy3BMk4qdvN5WID7X6LXVKn70xW6JQSuUGBd6Q4E9Y94kEaWG1ww1wlG9VCo8YoGZYUoejJGHSuOtHQ4/89AnAe1X1DWxjxJa7EJaQph79ETfFq8hs7q2m+m6ThVglYD5nby2ga75sMJsvPqL36UYLXD8QIEZD/lNV58/r0xPITgnYc1yqoD5SztPBDFRG6m0lCMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfZ+7B8+rQME8aGAg2CqRdxuQ+JlW8/OtWtmBF5Lva8=;
 b=XSgf49mMIJbWSsNGx6Whrc0WuPgcjKNuD4dcwaXdkOxX93RH1AjTWHZ77PI3hbuYG+/oE/xc76RW25nBzLG2qY236dyK3EvB+Hoh5LuCtX00jbQlvA4e0ckoJ+4tC3bk5xuvnUYSEFo/BTuX1cqLzXGv4L165ylo+MtAcRTtST6OmTqm6jkBucuqtCD3+PXMQMhUfozWQ3IIDKyCrcbgBNcWJh5TvEEwi41xICevNK+qBCQzGF57gyL/BDIjt0OlV8gNN/z//fODv3FUqKOrTPmyYWCOcdMFg8vKJbuwd10FCn55yAsAE21BSoSRor4jVtP4MyKyF9u9xqa4UCRLDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM5PR1501MB2182.namprd15.prod.outlook.com (2603:10b6:4:a4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 23:37:26 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 23:37:26 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v4 0/5] Subskeleton support for BPF libraries
Thread-Topic: [PATCH bpf-next v4 0/5] Subskeleton support for BPF libraries
Thread-Index: AQHYOY7L7euRD8cX1kW99D7F9mQrmA==
Date:   Wed, 16 Mar 2022 23:37:26 +0000
Message-ID: <cover.1647473511.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c41044c-07bf-48b6-4789-08da07a5ed88
x-ms-traffictypediagnostic: DM5PR1501MB2182:EE_
x-microsoft-antispam-prvs: <DM5PR1501MB2182C010CA6671B21ADBB19DC1119@DM5PR1501MB2182.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CsO1ZWivMRT6KxtcCB0sx2qDF9Lwk1fOAlPJryTr0oN9XtjuCos/46kWkuMWIeXgicnp6suG7p/GHvJouEv77ruS8uIrF6Bqbk2JDwS8xQqpzEWUtdmj/88aM9JEt6wUTWHbKVF8T7K8XSBuMxvuwYQ6AvQi3z8UyYoM9s+x/8I3gK7kJw1yWoAiC+BhOhAVNWrqzFUThMqZg2/F73IeE22mspDrlfGS41J515w0Xo4IEz4b/FO9gmjJr8RkY7LDVUInEov/GXK8Pm2t4AOqhXwd76ETQtav5phAIzyit+AXEahzLPFf6/e/CPfDp3Bxnmer5flxPU3pxuBGYurIsXBbKQe/YewzJfx9HVcrrgzFEHe7F1Z6MK+5hNjNJT/SVkWRipoduf/gih/+hPAQAdk1Rz1Blg1sTQ9aRK09cggHwV6JpBtHHd5VDVZ2i6fuXGdONjVsQMTuG0ItmhQAqZ4z3ZfGBZYD3wEPTC3Wc0ZEUpyz1elronmxuZWdWpfK7Vhq9QAz6h1Ux8qtybd7iT4pI0KYfFQrvu/dOomqKejDP/3CnxrEe+GArwdDoSp/1yJX5erqLUMZmkR66GGc7FFXGt4tkM4bpOTxWVoOAPUVWPj+BRC5VzlzES31YRJhJj8eFG4h3R2WLou/HG8UDmgYUlnNlpQxqQQXIwHXJlIfF5wXNne6/XuPdHtOAflqxRzf2R2pvrAWlao+JuoMMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2616005)(5660300002)(110136005)(316002)(38070700005)(6486002)(71200400001)(508600001)(64756008)(8676002)(6512007)(122000001)(6506007)(66476007)(66446008)(86362001)(76116006)(66946007)(66556008)(91956017)(38100700002)(36756003)(186003)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qg9Gn4mPKJVxAdw/uvlsAcDltuu4vafLAv4ttVJcbgefh68qhhKL+WVuzJ?=
 =?iso-8859-1?Q?2pRG5N1VOskXJhrxUg/mWUM0jixtuu+OjW35As+q9xyLW3Jv77mKDJ5Wms?=
 =?iso-8859-1?Q?5J/QqVp875Sr2G9WE/SnA7xl+ou3wcd6Wo0XPOV4y+fAuk7setC4NcMa1k?=
 =?iso-8859-1?Q?/snCL67FwLbQ9/lrxlEIJPnyxs4AHgxi1cDYUqu6KCsjoImgKZimsQ8uqF?=
 =?iso-8859-1?Q?EGlOViS4jiA9ZBDklY2LOl7Uy/SKQcsQ6l56JhreFLvXCsfF/njdZHl1qJ?=
 =?iso-8859-1?Q?ODSngaT2/wFQx77rnBm5ZEcB1noqoIY0Iv5Bdy8gROXCIsBBnSUGiFaL5T?=
 =?iso-8859-1?Q?igCltmip6cCHa72PqbVbinp30Um6LsPKKSYFB1I+QPZBvEKlt3NODufzwg?=
 =?iso-8859-1?Q?ZD5rtXU3rnSesAWGyngIUCFaKdaMeny2IUOs+8UV5UbBkiDuGKNomMqHKd?=
 =?iso-8859-1?Q?qz1adYQDe2i5nNISkkYFceDSiJEZVSMwbahngadOIZGSvjXg6asYNrblQY?=
 =?iso-8859-1?Q?7krYqNrF+kxB0nmH4A2ls6H52zSiTn6B/6k5FU/CUJze+0mAZ5gKT+sAW7?=
 =?iso-8859-1?Q?u7B+TIK/kLxUDuDv8OQASReiXrm6Mr40QkRLVJ0zmvUpYP+Slw/LUO9Rpy?=
 =?iso-8859-1?Q?2QrUutqwbqjdO1VNq7kQlYkOyklbd+Lu0GVjidRbREX+fBJV7488jZmk+3?=
 =?iso-8859-1?Q?yTt0SnsVusPIfsUnzPCcv6cFMSNY9A6DRfufVs5C5+1UEoHzt2cZXIYeru?=
 =?iso-8859-1?Q?9kYS9OUrxHJ4z8workzzv24zGH7tgNOWGkfQeSggH7S6YK7D6MvEeg0epj?=
 =?iso-8859-1?Q?ncIeI4HtCZPT6m9fj2KY2mpQmP6keWfQJ2YR/R9N39Eyj33umg6hnkz/L+?=
 =?iso-8859-1?Q?S/cKbaTuNrRTxWKWdn1l1Qzwdtxv9R2Gp42kFf3oU9xyA5hy4EBXW2pZkD?=
 =?iso-8859-1?Q?V/m/MnLP6m6V6kdpuWy5IdA0F5RFkf1MU24xORwzhhBe+7I6XPreMrgjwt?=
 =?iso-8859-1?Q?p3/Rk/wjyU2CMSbXvZKT7A7K4WQIjKl6kdwtJhKEEDltv1SlsCMyQqn4Lu?=
 =?iso-8859-1?Q?a0so0bR//bYNMxch8q5ty9M+kbT0Ey4ydq0xCm7t2w0VmOZCZIPA1/9WJ3?=
 =?iso-8859-1?Q?Pfc2eBBNTI26kmhcPvI+fWNdl/kW4T2lgMBBfMLImkB55wm5jAD5B1xtYB?=
 =?iso-8859-1?Q?kMt7D3sTmxHE2rCQWhJ7sqqwLKrEVa4fvv72oaCTErO5FcFA+hnXMAeRtH?=
 =?iso-8859-1?Q?AMZb6P/RWmDE20gcf0D2BDszRUeKTEZTUD8shsZP8Dbrua6mVgCe/CjeSL?=
 =?iso-8859-1?Q?QZCMWrCXivGmDXLCO8KFLrqpwFIyqDA8sXyfxCo7aPIifUJFCbhsoDGh0E?=
 =?iso-8859-1?Q?PhAmeef8X84E/wW+8hQQ5CPBB56Gtel8hvL6gm8YZwT4JAj47hK4Vfrwa5?=
 =?iso-8859-1?Q?+Z9oNZR4Gcx2mOV0yPYk7Ejd3R9n9SK0povfA0GUqbopufFsKxn9n7hTtV?=
 =?iso-8859-1?Q?sgbJzTGtkBFCTG5tUZ4Y9irEXcAdoZJ4IYj0ak83nYxptHKENg1H4gd6D0?=
 =?iso-8859-1?Q?SNZNSEM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c41044c-07bf-48b6-4789-08da07a5ed88
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 23:37:26.1538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zFy2WGy4Md9mh7iFCLgNU36EtAKNzrlqJ4/M56xIW01HBK3hCY9ntrDa3Phn6Mhq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB2182
X-Proofpoint-ORIG-GUID: rSYeRhxJGODcUKPF6modVNjz6UW5E5dC
X-Proofpoint-GUID: rSYeRhxJGODcUKPF6modVNjz6UW5E5dC
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

In the quest for ever more modularity, a new need has arisen - the ability =
to
access data associated with a BPF library from a corresponding userspace li=
brary.
The catch is that we don't want the userspace library to know about the str=
ucture of the
final BPF object that the BPF library is linked into.

In pursuit of this modularity, this patch series introduces *subskeletons.*
Subskeletons are similar in use and design to skeletons with a couple of di=
fferences:

1. The generated storage types do not rely on contiguous storage for the li=
brary's
variables because they may be interspersed randomly throughout the final BP=
F object's sections.

2. Subskeletons do not own objects and instead require a loaded bpf_object*=
 to
be passed at runtime in order to be initialized. By extension, symbols are =
resolved at
runtime by parsing the final object's BTF.

3. Subskeletons allow access to all global variables, programs, and custom =
maps. They also expose
the internal maps *of the final object*. This allows bpf_var_skeleton objec=
ts to contain a bpf_map**
instead of a section name.

Changes since v3:
 - Re-add key/value type lookup for legacy user maps (fixing btf test)
 - Minor cleanups (missed sanitize_identifier call, error messages, formatt=
ing)

Changes since v2:
 - Reuse SEC_NAME strict mode flag
 - Init bpf_map->btf_value_type_id on open for internal maps *and* user BTF=
 maps
 - Test custom section names (.data.foo) and overlapping kconfig externs be=
tween the final object and the library
 - Minor review comments in gen.c & libbpf.c

Changes since v1:
 - Introduced new strict mode knob for single-routine-in-.text compatibilit=
y behavior, which
   disproportionately affects library objects. bpftool works in 1.0 mode so=
 subskeleton generation
   doesn't have to worry about this now.
 - Made bpf_map_btf_value_type_id available earlier and used it wherever ap=
plicable.
 - Refactoring in bpftool gen.c per review comments.
 - Subskels now use typeof() for array and func proto globals to avoid the =
need for runtime split btf.
 - Expanded the subskeleton test to include arrays, custom maps, extern map=
s, weak symbols, and kconfigs.
 - selftests/bpf/Makefile now generates a subskel.h for every skel.h it wou=
ld make.

For reference, here is a shortened subskeleton header:

#ifndef __TEST_SUBSKELETON_LIB_SUBSKEL_H__
#define __TEST_SUBSKELETON_LIB_SUBSKEL_H__

struct test_subskeleton_lib {
	struct bpf_object *obj;
	struct bpf_object_subskeleton *subskel;
	struct {
		struct bpf_map *map2;
		struct bpf_map *map1;
		struct bpf_map *data;
		struct bpf_map *rodata;
		struct bpf_map *bss;
		struct bpf_map *kconfig;
	} maps;
	struct {
		struct bpf_program *lib_perf_handler;
	} progs;
	struct test_subskeleton_lib__data {
		int *var6;
		int *var2;
		int *var5;
	} data;
	struct test_subskeleton_lib__rodata {
		int *var1;
	} rodata;
	struct test_subskeleton_lib__bss {
		struct {
			int var3_1;
			__s64 var3_2;
		} *var3;
		int *libout1;
		typeof(int[4]) *var4;
		typeof(int (*)()) *fn_ptr;
	} bss;
	struct test_subskeleton_lib__kconfig {
		_Bool *CONFIG_BPF_SYSCALL;
	} kconfig;

static inline struct test_subskeleton_lib *
test_subskeleton_lib__open(const struct bpf_object *src)
{
	struct test_subskeleton_lib *obj;
	struct bpf_object_subskeleton *s;
	int err;

	...
	s =3D (struct bpf_object_subskeleton *)calloc(1, sizeof(*s));
	...

	s->var_cnt =3D 9;
	...

	s->vars[0].name =3D "var6";
	s->vars[0].map =3D &obj->maps.data;
	s->vars[0].addr =3D (void**) &obj->data.var6;
  ...

	/* maps */
	...

	/* programs */
	s->prog_cnt =3D 1;
	...

	err =3D bpf_object__open_subskeleton(s);
  ...
	return obj;
}
#endif /* __TEST_SUBSKELETON_LIB_SUBSKEL_H__ */

Delyan Kratunov (5):
  libbpf: .text routines are subprograms in strict mode
  libbpf: init btf_{key,value}_type_id on internal map open
  libbpf: add subskeleton scaffolding
  bpftool: add support for subskeletons
  selftests/bpf: test subskeleton functionality

 .../bpf/bpftool/Documentation/bpftool-gen.rst |  25 +
 tools/bpf/bpftool/bash-completion/bpftool     |  14 +-
 tools/bpf/bpftool/gen.c                       | 588 +++++++++++++++---
 tools/lib/bpf/libbpf.c                        | 161 ++++-
 tools/lib/bpf/libbpf.h                        |  29 +
 tools/lib/bpf/libbpf.map                      |   2 +
 tools/lib/bpf/libbpf_legacy.h                 |   4 +
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |  12 +-
 .../selftests/bpf/prog_tests/subskeleton.c    |  78 +++
 .../selftests/bpf/progs/test_subskeleton.c    |  28 +
 .../bpf/progs/test_subskeleton_lib.c          |  61 ++
 .../bpf/progs/test_subskeleton_lib2.c         |  16 +
 13 files changed, 910 insertions(+), 109 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subskeleton.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib2=
.c

--
2.34.1=
