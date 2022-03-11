Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0CA4D565E
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 01:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344198AbiCKAM4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 19:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiCKAMz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 19:12:55 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FDF1A06D7
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:11:52 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AJFwk1005490
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:11:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=fPwxHVSre8zRhCs0df+qmLsOpY9rf2ryG6PlD4V2gJk=;
 b=Yl2GSCcZc2Ysv4tFjXNMZxVtbeecmOwUU1P3JxeUIKb4FII8n7NsqFJj3ChpxbnpwW6s
 qCYLNeDgUcky4z4Wo+3fhTgA8vR6Qn8u0JqSH1nxPY/Rrj56uFJd85mCqzrf+ZOt5baA
 oTsGUSwgFPG2PTvNMHd9cEp+lygJHhPgjvk= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eqqb5sykk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:11:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQMk7YFLq+40cq0lK8e/l5zObop0m8Aad+D8LUFODNGl6xJk0IpEPLBQEimId4xHIG/yqQlfImRWiLu2PHZhUaLzpYZTJXDYePunbPwSooYh76O1MyDT5N88pg1E8koA+Z8nDBBCxBHXe0v30BT20Opi7vzuG/M1cC3004BFiJiJpyRaEa9kR+4wMqamOGJ1AvBbT1GV38VIgY5bZ6MLzmWr7IHkD4h6MmdgKdjV6IJelQFra0ywAi3TFlT8GuK1JZG/J7t1NJZ28nDpPCtQOCjV6EEejahYS9bfhZ8msdczMrI7389rm/siPmBWbpZlJqbp33BjbyzGPI9XMW9fZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPwxHVSre8zRhCs0df+qmLsOpY9rf2ryG6PlD4V2gJk=;
 b=L7AjWj9tGM9fkqLCboJBUvhzPA21NscTKAtHfi+HWB9Z8u7kW5pwXx6SnNCjKNXc9m8uTAK90c9102L7kkSvrU2UpgltKLpyfuuB9ftJk1h1f65G5CfHdEAiGfFluduTlmUFJ/oOJxsAPAcBvAHNCPX/nNnvtu/JRlOoacJCNxvvaRRROm+VZF0WBYVqms0Y1fDmjhlUwIPjm/p/3jvsAo3cBU1pAh2BYDuGaFcdT35Xwacj48REYLHe7gEI09K0lU7zHJYIgJVg7UA7Vs1nsNx1iJcwVdrJoTaMl6s804nDAF1b/jawrbwfV6HAwSZwaKhsiXbvn+XotW+u98m7Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BN6PR15MB1170.namprd15.prod.outlook.com (2603:10b6:404:e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 00:11:48 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 00:11:48 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v2 0/5] Subskeleton support for BPF libraries
Thread-Topic: [PATCH bpf-next v2 0/5] Subskeleton support for BPF libraries
Thread-Index: AQHYNNyZMS+llTJd+kukFENaK3O6yQ==
Date:   Fri, 11 Mar 2022 00:11:48 +0000
Message-ID: <cover.1646957399.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05d03f72-ff50-4d83-56d8-08da02f3bc31
x-ms-traffictypediagnostic: BN6PR15MB1170:EE_
x-microsoft-antispam-prvs: <BN6PR15MB117029B6B01404515BE64F2EC10C9@BN6PR15MB1170.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hWXa2aTs+16S5aelutQwl7vK1ll1Upd0y44ghlf2seenHnfauSDRpctEssgd9cIzDN0w/19SUgJnw/RTav1SSz/0MY+eWfMUwPlp57xHCdhhTQAlfoVGU+Wucf4jRldw1dQxFaw93D2rVMS+0KTM9swCAIVv2giIo8ACTjJGhy/GmxzBnl5grqtImDl+ls/pbhAtxc1y5mgRnWF8UAGIVzy+bQA/IfcBsrZ5RFjon6qaYWcm5scCKky9YXvXSLRfnQJRc7Wr7Jw03ehKWXF7T5jqHtt4A9nVvg/9f5jkHiX7v9UvqHadVTFFXDAYe0O0RZdJDRFgBRb/zMwrZmp3XKnl2AEQ8n4RLvToF9sb+xSJ3/x9yIUgrV1uSCrd07F25yZvD49EIFi7ucmNjdCCIvZm9BcVLBM0Bm52DK0LI3HpZZ8LTyz7ykIHCiaxzB6r1x7lpaBO2QQMA8xv7GcTB+Vdji6+bO30HIWf97jIDl8JV4lvZeb1eCloNkWF5aqOKMDbvpbwgV5TxJXOEssr5+xPVpznfMrn6iiNfUl2EtjlXKWQmw506Gi3sUKqF4u6WzocbxMHLQWIyFs+mpZfQwI74rSAHEn3gGzNhMvfvWrUGqgcHvbwq3HrrrUy243D8AabmIMG/JJyHGHNdBe5uKJTYjbL/Wrel4s5u1JqqZubcEZ434ka/pbasNzpaxHzBvqzdwAxLcdEZdgOjD6YfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66446008)(66476007)(8676002)(91956017)(38070700005)(66946007)(64756008)(76116006)(6506007)(186003)(8936002)(316002)(36756003)(122000001)(38100700002)(71200400001)(508600001)(5660300002)(6486002)(2906002)(6512007)(110136005)(83380400001)(2616005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Zh3YJ3bhDaHqSpIy86xRZnaBXvaGvtFsk1KoljakKmAbWbWX6HCbdSD9kk?=
 =?iso-8859-1?Q?fgMj1hbb9WFtaO2RbDxcMOS2YC5SUx0IYDRPaBjGxeyRZKgCpxsWzACImF?=
 =?iso-8859-1?Q?PF656B3/XolColPiW0b8vQzDVqXOH+7iODx+QkN8+KgaPQwxnyVPj8zLit?=
 =?iso-8859-1?Q?vfVDbw5BXM99nolCvTk6AL0h4YrLzhfXiz4Qp7wH4NENz6OrJUmt3B4DRW?=
 =?iso-8859-1?Q?lZiSVU4PuFHJGS1bhS6xYhJARMIi8bHpthQW9oJeYzB4gHsmpEuQ6jzEsj?=
 =?iso-8859-1?Q?MAtMS681wRC6OQcH4E/ax2Q5DC7FfhlLBNBmCanXYRoYrjpVm5fyuFxS6o?=
 =?iso-8859-1?Q?MC0VQecGCg2JrSLF+0LV7ZG3pXZwn5BypItAvWxEBKM4MpWGzZ6w6as7Ge?=
 =?iso-8859-1?Q?LetxKvdgJ+2fNa8mkJRw/RlMXxHm4x/3N6A/trH0saQBayqvjW8869Hnw1?=
 =?iso-8859-1?Q?ot6K31yHmgpxnX8Pqn2wKYEGAew9qmxOAknnrjoGSpK+ThacnKM3xButs9?=
 =?iso-8859-1?Q?fswie0i31T2RYbDRtc/R8B/goOVABhNJQ470+C8bsRt5szUPcYizkf7Quw?=
 =?iso-8859-1?Q?MBhSOWPBKJgM82Ray0UCEcCI9PwT5ulCvkHrtj4dRJHa/cf90GJoDL54u9?=
 =?iso-8859-1?Q?jD/4QY7cbLtFSN6QKmWbU5dSPoXYlXYpobas7FIk98F5xn6ySb8SVzE3gf?=
 =?iso-8859-1?Q?tA8v3LhfhRjYdqseYrrd7wV9gZC2iCZdfnfJ+IvmmZdnFudHoBBOPDmUPx?=
 =?iso-8859-1?Q?XFfnLTv6VlAX5aceFozCEc7DaG+meXLlasfQoX3GRF+4PqKl9Abrj7FDxn?=
 =?iso-8859-1?Q?Cyy8RmduFhdJO7E+kJ4rT6BGZ3meGleKt17O5Q/RiTO6R9skweZ68WsD1Z?=
 =?iso-8859-1?Q?SahmYDwZsJyjNIo6BVBEGw650CZeCa7Dl34GumvuOUtKWJvUg4bTHegsoa?=
 =?iso-8859-1?Q?Kc3UiRL3K0UoMtxxwPcSqh1dc1FjHvTETilOzUqIUcZ4DXzP1AV1V03E45?=
 =?iso-8859-1?Q?X7GWBn/3NZnykCIQUMhfIK7PCTRgX4G5oi2X1XlDm8qeMvlIjacGEPvQwE?=
 =?iso-8859-1?Q?Lbsu8FrdxDrXLRAnt8T8wvQn7ghC7AqjFHJE3jaMrgmYi0B+u67jpwZqyv?=
 =?iso-8859-1?Q?abLs6/5dIWUVp8WcOOAl3/ItdZxHF8dIMveM7DcTUg8jucvy2DV/BqT1KE?=
 =?iso-8859-1?Q?1Ftc6ZGldplXH+NawPt+bJj0hG2m24E/FK6DsZZFLCYOZplcfXUF5b6z24?=
 =?iso-8859-1?Q?D/VXUjk9NpG8IrQhps0Z4eJLGCP8ZYutH7mvr6oAl1DoJeLBre9VE/ysK6?=
 =?iso-8859-1?Q?QQRttCl96jvUgWKxv+j27dLoEMCRJ0TulD45bg6p14kHMl8v+XS/0ox7vX?=
 =?iso-8859-1?Q?pNBiLFE3vDYj/lhHkljNuPkzzVD6mZoGHytjeya35RFGdRjMmNWAdl73PJ?=
 =?iso-8859-1?Q?4D09xqUqCe+96lyuknK5We0mXefCNv5rDB29gr+YwUUcpuH+ElR0FOD8wv?=
 =?iso-8859-1?Q?fIXeCuggY8YbHxNtvVk+9gATgFv+45/HAg3ljFlMgoQXyJT+gKK8pxWti+?=
 =?iso-8859-1?Q?vnBUcrk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d03f72-ff50-4d83-56d8-08da02f3bc31
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 00:11:48.2911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFS0XGAfGw+AbWvjDDL/4n4IXiw94PR5uDxpxeEdwTQoG54IN6YzgfzL2p364aH8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1170
X-Proofpoint-ORIG-GUID: CWGuIHXkupcEkftBZuCRZP62FehMvJMS
X-Proofpoint-GUID: CWGuIHXkupcEkftBZuCRZP62FehMvJMS
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
  libbpf: add new strict flag for .text subprograms
  libbpf: init btf_{key,value}_type_id on internal map open
  libbpf: add subskeleton scaffolding
  bpftool: add support for subskeletons
  selftests/bpf: test subskeleton functionality

 .../bpf/bpftool/Documentation/bpftool-gen.rst |  25 +
 tools/bpf/bpftool/bash-completion/bpftool     |  14 +-
 tools/bpf/bpftool/gen.c                       | 589 ++++++++++++++++--
 tools/lib/bpf/libbpf.c                        | 151 ++++-
 tools/lib/bpf/libbpf.h                        |  29 +
 tools/lib/bpf/libbpf.map                      |   2 +
 tools/lib/bpf/libbpf_legacy.h                 |   6 +
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |  10 +-
 .../selftests/bpf/prog_tests/subskeleton.c    |  83 +++
 .../selftests/bpf/progs/test_subskeleton.c    |  23 +
 .../bpf/progs/test_subskeleton_lib.c          |  56 ++
 .../bpf/progs/test_subskeleton_lib2.c         |  16 +
 13 files changed, 919 insertions(+), 86 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subskeleton.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib2=
.c

--
2.34.1=
