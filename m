Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA134DA517
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 23:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345255AbiCOWQj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 18:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240840AbiCOWQi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 18:16:38 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049825C363
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:15:24 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FLfkGb009020
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:15:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=7/J8dZeQiq9zbfTPt+60Vz7E646/fMjCnjeID0YL8mU=;
 b=jVFM4I5S7Dmu5vPYxZy2dSzdP2ikDqzxZ/WRXgVY/XC8Pskbcg2js33rVM+zM8/RRTsz
 XBoKtAZUmt+dYZVWV0qYkJqdDC9EqdJQBc/xXSXw3Efx+LVOZE+uRtr2+7jsVipcxlbq
 8hg90zv1bOLRma1jwEkj9oTdryjDuWmT+fs= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eu2brghn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:15:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m69mpFe2ZPFjvAIcYsK7QQBBugTKBCFx4WtBcyTTPYU8yIpJ00iwmsMqjd16CPrUugcpVknsf2BpnUMEErc36ti6X33Yn2iSmPz7YxQEgY55EjMQgJHlThvDo7QWbBzANGvggTU3W9uMPbQUMWDjYa2NQfAy9HFVMTW7kchsOA3fpcAbAiIxOY7m2hcLOmVnnpUDbljwnCUQFUIoA2eVr6Q1lEOTWomgeTv5sv9LrkDl7KNdeeR7P+YhS1gcdl9CWuhMKLCryR9/h1PdHENE2zfA48FKEKb2MCsn7A83yCBwUIBv16JksWg313XeNi1xA2dfsIkKMU+SJ9UfJDsuJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/J8dZeQiq9zbfTPt+60Vz7E646/fMjCnjeID0YL8mU=;
 b=eoQ33C8Ikl4r/AHmn1oEFLGLM/4WJMx9BYhGY5CuQFDxsm6r8IVgYUNFAI87gm4Hvogl+LHxabzCEZNGYImrVg+301ZfXEgF0FmZFynxsjM2K2xlZ7OePabDV6UHPhug2CJVqUyyp6aTn6JIJHyp070o1ZLMAgos2cTs0dHNYQjwhAG6ERDteMbnIMaHbe8ws5ewAx5FH0doKyVbQdxH/Qd1LpR1a1CrO7Opy+skp/99/6CmQ/M9WuC7ktCDJ9Qq1AoRzPU3PYamSTzeXDkqE+e6fgtOBXxIoO0hyl0Y8T+ahZyDk+GNs4HH7bGP43f8vIP0d/feczmiSB7dj4wmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BYAPR15MB2695.namprd15.prod.outlook.com (2603:10b6:a03:150::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Tue, 15 Mar
 2022 22:15:18 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 22:15:18 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v3 0/5] Subskeleton support for BPF libraries
Thread-Topic: [PATCH bpf-next v3 0/5] Subskeleton support for BPF libraries
Thread-Index: AQHYOLonFfgs66j8ZUihBQnmEYSEyg==
Date:   Tue, 15 Mar 2022 22:15:17 +0000
Message-ID: <cover.1647382072.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39e64dff-8b69-450b-c18d-08da06d149ea
x-ms-traffictypediagnostic: BYAPR15MB2695:EE_
x-microsoft-antispam-prvs: <BYAPR15MB26958AF66CC47F60949FB5E4C1109@BYAPR15MB2695.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v/oZgYxISqNNEscN9PtQu3YEv8lZbf/FN2cT85SsCgGcIDbRuMVnk3h5MHyFr8+6FSJDTH/tU6guFBGGbqs1VIB1JZsOwhBcCc8gBJ5qBYw5fBdcqVsboBlRZWdlvvIWSOKiouuSQ+iLK5kqDXW/Zmi3w5Z6Ho+QDMhlYV8hNGaJ1SYVtDAZ17wSH46XBwioG6JU6iJgHq3tgj4sTE9bQ0OHmFsZLHktP+UnfmjmFBYjeA6BtvNV+3L37UHVLR/Gy4PfeYslcvZSoP8oqZODurN+BFtoYeV/SbSnOzah2A26g3oKYoK7dHyNOIS1s8bHYlUVld+C8bnD/TvsSjFaMbYccWfCWfc9lMm3of7SoiFTcoRXwvxxCYMopxjSe4y6fQ2mb9OAS/IIwh9VGk7lr8fdsS1o/jEviq3Glh2eQ8tiDOTC5TxEa7coShw+pp40owR6OBrKPCJHvptMlrrThWLyxz2C+AJGkdTx3G2JrgUP3SfAFPqyuBExvAZPsWZ6FYIRZs1U6OXntcLozZwO8lBpdjU4Kc6XxaIj/Y5KIwwqRkmme7asZgkKgcXPWn11cuj5NVUSGM0TnB1kKWDCYXmDtQamWoKF5CTfX6oRizsHQWiuyq3izL0U/4GFTRwvJHjor6jphTsZH0rqslRCSVScEa45X8OaJ2EukfTeT9jcRJQvvFQUK3lVR1JIca8rEghpS1P0IYZHapPTJVxAUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(66946007)(6512007)(6506007)(2616005)(64756008)(38100700002)(8676002)(76116006)(66556008)(91956017)(122000001)(66476007)(2906002)(186003)(83380400001)(316002)(110136005)(6486002)(38070700005)(71200400001)(508600001)(86362001)(36756003)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D7gbPWg5xjPtY6QMOc90Gmd0tT2Y9dNL25LDG8tABHxrbsYUfSmgYKFi3d?=
 =?iso-8859-1?Q?ci1+w/jSYxBh6ENrbWqMwUSuz2zQOb7XXzYodlmrlzfhynzIh/IgF9G/GT?=
 =?iso-8859-1?Q?GnOETnyZQ+4QFUMtoyr/y6MRW/hqFMrkRK54w+U/wCYUPSxAb9dzBKYFv1?=
 =?iso-8859-1?Q?cSHd1xe7Gg6uBS/WMCr8K9v0WsW5DFV4DJ+y+uXlqt9JgnLnFXi5rKizGL?=
 =?iso-8859-1?Q?o7KY6INzJfFC3F3ttx2iTAidl+uazhQvzJD9Zzx+8x5MsH1nU+l2E7ybXN?=
 =?iso-8859-1?Q?9I3KpyT3YzE/PTXdh0UdYldNaxxpJYv+KMlh4LjBNhQrhEUeMtHwwsz+EU?=
 =?iso-8859-1?Q?NkqFGxWshHi6s1Gv6GZeHIOjH1O4IxDGKARdMgDbuDdmZiYyh3p87vA4Zp?=
 =?iso-8859-1?Q?hjlhDrrM1KuyvSjnJpC0J57cz5O8TDWBSfXnZ2BUjgG28QpJ0eOfZqm6n5?=
 =?iso-8859-1?Q?gi4JNa9unTbDVmsSzPg4hEj5dhIqZwK5zuB3sPE95K8iKmey+j3RT3BRLh?=
 =?iso-8859-1?Q?Kf1hdcGM2T3M7RbV01WyVDHDsHKnhj9X/Rg2vZhRjexMGut5nS9CNyKt2G?=
 =?iso-8859-1?Q?0ukpZzcy+ZlpqiPgM3r10kARuRXFjZcMhfAm3qWO0EUjbDgybEErxfvIH8?=
 =?iso-8859-1?Q?IzhSlZNXR2wr251JCwLab0r8Iy4BOqwxLlMgocFmmBJ6xpwgY5VTKdEGSz?=
 =?iso-8859-1?Q?BB2DngeYg4ghGWJ2AHkLmWKPQROab6GytTetzAsuOJEXlMAPdnWtFklQia?=
 =?iso-8859-1?Q?KBOECKwW3alN9qWIhxI++HcIwlb4JmQxIBe68k+iRXLc5+RL1o7/5ARzoz?=
 =?iso-8859-1?Q?5OzcmZDjPCjKyj2Q2afdrCf76z82jO7i5Xl+WgMUeOVSj4MCjowND56qBU?=
 =?iso-8859-1?Q?HkA1mxWpZ8maGDxC4un4XLKkzLlF4RwIYtm8bYC5XSrVpEJH++aTr4T/oK?=
 =?iso-8859-1?Q?nMquqZKHyY87b+id7RXI83DjqJN8S4XKSMYoHKZcIunAuJlwxMahJZyOVy?=
 =?iso-8859-1?Q?ZFBFbD3YOANybfTvBqDtlZ842ZgDhL+VWf4QDmKRy9ax+Yq0h9bc3YHMnH?=
 =?iso-8859-1?Q?PCGqgrFQ55WDAexYQgBg+wW48ZSJqg6TyMPFa2mPcj1VRfqIATijfOVszI?=
 =?iso-8859-1?Q?/LRwFicwIixhJcHGZbKo1xOkbuDMN8ZCxsIKQIFAYZ0Sa2HT1qZowlOlHB?=
 =?iso-8859-1?Q?wMIxWlrIRZK9VUiUNKpX3y99jG5940h+pa+/prfNJ0CxTXcnWbN0qG9nRI?=
 =?iso-8859-1?Q?nWCsrobFUijyPm7sHWOEDqhH5bVEmd9ALKHar/4GeXY168ohbdQUj97WG9?=
 =?iso-8859-1?Q?Un42xeXWNNYXPQxTB9FjRRbYfiI05sDxEnGIpbfm6PYOpudj7CEPqff42w?=
 =?iso-8859-1?Q?aKYaT8TIqF+BncKoJDbVGPdu1NogkXLEibiw0vOU2W8TF20KUCzVeuGWxB?=
 =?iso-8859-1?Q?RvooSIfPlL23Lcs5eHDx7OKBdwBGwuPmmm6ppGsBDg6Q+QeklfJhAHDC9u?=
 =?iso-8859-1?Q?RSTkOY+LrAZ7rz7RYztGHwzbCXzC159p+X4ekrGWO7uRuGNc7MktphkOIM?=
 =?iso-8859-1?Q?ZWASiiA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e64dff-8b69-450b-c18d-08da06d149ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 22:15:17.7075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +naRajeiJqGG6GNRPjh1MJlcdoEVi7uUAL6ADS5GSvr2KUh+zH34c2M3w3ENah0o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2695
X-Proofpoint-GUID: PcceVaHPmmkodMMjwQPDEvYitFzoBwxl
X-Proofpoint-ORIG-GUID: PcceVaHPmmkodMMjwQPDEvYitFzoBwxl
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
runtime by parsing the final object's BTF. This has the interesting effect =
that the same
userspace code can interoperate with the library BPF code *linked into diff=
erent final objects.*

3. Subskeletons allow access to all global variables, programs, and custom =
maps. They also expose
the internal maps *of the final object*. This allows bpf_var_skeleton objec=
ts to contain a bpf_map**
instead of a section name.

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
 tools/bpf/bpftool/gen.c                       | 595 +++++++++++++++---
 tools/lib/bpf/libbpf.c                        | 155 ++++-
 tools/lib/bpf/libbpf.h                        |  29 +
 tools/lib/bpf/libbpf.map                      |   2 +
 tools/lib/bpf/libbpf_legacy.h                 |   4 +-
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |  12 +-
 .../selftests/bpf/prog_tests/subskeleton.c    |  78 +++
 .../selftests/bpf/progs/test_subskeleton.c    |  28 +
 .../bpf/progs/test_subskeleton_lib.c          |  61 ++
 .../bpf/progs/test_subskeleton_lib2.c         |  16 +
 13 files changed, 910 insertions(+), 110 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subskeleton.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib2=
.c

--
2.34.1=
