Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37603570CF8
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 23:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiGKVsU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 17:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiGKVsS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 17:48:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CC283F31
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 14:48:18 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BLWf00027654
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 14:48:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qkojWeophnMvlPvkwgKFanYBFdjmz4fIHp1c5hfNn1w=;
 b=joosZSQ9MRfTcxOg6l0E6s4s9lNZcCNmSgA8uVvBRJcToCojyXHTiPXKCVNwKrpZbOev
 DYNqiODswVdnUvsvXub4zFpvJ3ST3PrGQ1Kh54OTPvGQFYmCSfFrM8BRgjYdcnY91dqD
 dcwNXqJCGJJ6tb4yuyrbSNNHXJm1v7NvLVY= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h76srm60k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 14:48:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtEqtruojK56l62l0xhmwg/ibBjV50AGyH9DcDwMSt/kbg1mwCKpSTKkl4m9HXSCXt+/pp2496EKG+ZAa1MrVDBFBB/8OTyY1N8mdKZlqORqkNOjQxDGq8Dl5luRa2L+4XucM4hlfoJjfbWO1pQ4h5JY3KOKYvldl4bS0nLlOUFyhbKUhFpFXCsUMvXxkWNvNAJfvWBpOK5WRncnyWwyD/qlQE5+xgNk5BajTpENSBYhszlqS/X2sn8t/ja97Y/lDshtBqoOv9wVWimHlTIbo+4LZ3iPQn0x/s/qX1yPoWfztH2RKPI1MAmtF4ZPi9gztiuSTnfMk5VaWSi5n+edIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkojWeophnMvlPvkwgKFanYBFdjmz4fIHp1c5hfNn1w=;
 b=bDw+MDnVJWNJ7/VbcGjlcIsHX3nzE/Uq8VsBxO7BQLjfR+n184xNgHKRUQs/gsgfCgABBvOPVWXKDrGx2OgLwLxQ0fzI7WmNLvHt9x9xlzRJDZuKYyTnY5+OF1Ehz4MjdZf/+wVn1fVTL3CcSKtF5a9GKTvzYxgadWMPC7TL6hl4IvUzwbR9BwQwAhiILkfxFNmU9QkvGwqvoVCNMJ7rPd5y6bMoHsarR8pcj1+sEFsN13H7IBwAo8mWSP1YJfftIvTjyMA+kPcut6bqhNjYss6MDbeYHl0FvWQsQYNLRmUvg4oSUb8cA6q7GmRGvjb5oCms0t/GcBZW9qgVGqIaHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MN2PR15MB3375.namprd15.prod.outlook.com (2603:10b6:208:39::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 21:48:14 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::ac52:e8fa:831f:237e]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::ac52:e8fa:831f:237e%9]) with mapi id 15.20.5395.020; Mon, 11 Jul 2022
 21:48:14 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH RFC bpf-next 3/3] selftests: delayed_work tests
Thread-Topic: [PATCH RFC bpf-next 3/3] selftests: delayed_work tests
Thread-Index: AQHYlW/squDxaqFKcUiJu7cMWIqu6w==
Date:   Mon, 11 Jul 2022 21:48:14 +0000
Message-ID: <32e573966bf7b4d43be0eb8e23d3d13c948606f6.1657576063.git.delyank@fb.com>
References: <cover.1657576063.git.delyank@fb.com>
In-Reply-To: <cover.1657576063.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a66239d-af04-4f06-8ebb-08da63870e9b
x-ms-traffictypediagnostic: MN2PR15MB3375:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O34KQMxeELAm2CEC/G+YdPzZNz88aDqKVLBwvgSJYWQ9UqN89X0mbNKMiQ9adzowDBIuc8lGJkJwokc1TMM3nVMjZbuxe10w7WmTZl25B2yLGWcsCqYpnY7Et5H8LqMWv5zuy9Y9eG6uIMU9LfPbAUVMayD0+7NG8J9pMQpdFmTyr0C7dQ8Gst5Agy2OHSQh56JTUHA5Co3aHj67yFViOZrABoLgjFinKmdlhN+UiDEAraDLOXruIJNXulSM62jQfoZvitf5YhAd/oMWX4yy8vEg/sm6TmT5vMyLayMkvUBuy+X+Q8AFT5uarwiSXTKGoTjvanBugj1OdchnU3HndUPIcHtSogiOvpaVHqX3MwLs641haNnmgp7WmYEJPzD42juW7X+6B/QrDeN3f1VrWOv+/PqP88Ib0t28V1vozyRuJH7uJztfE8biATVSrm31agO7aK7IZPc76OkQRiR+JPwBYkLgpdOZEl7xX75wErdZ0QFqQZnDLBUCJ8zt83GzZIrECvdE5WqfZoF04lXkH36MWo1d57mn+RkERqppNRCaGry7FZ6meq12VqWOaqWr/FmDjlGVI3RP9fDX5Yviu6GJMgbT5Sza+Moy94Evz6Vi4mmiNHP0B/WB4xRxuwkd5ACL/opMwneFMqNzR66EvpiCSiIjjLip5ldsJ9FxeZTlrU5OKUn7nvtiQ+Tvkf2Og1ZVgnFXojJEYlBIQuQ28dfxZQtd2kcem9qpubCCAxUNA3CpQz+7E7pg60FvrBDQluem13LTy2BeEO506B1Eo8mFzOpq2KXeS2pSHy3V1qGwn0aE1VvCFH2UKSdQAu6s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(38100700002)(2616005)(38070700005)(122000001)(186003)(66476007)(8676002)(66446008)(76116006)(5660300002)(8936002)(66556008)(66946007)(64756008)(2906002)(41300700001)(6512007)(71200400001)(478600001)(110136005)(91956017)(316002)(6506007)(6486002)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wz+c9DBMVKCBH21pfxJFgi9U2EPFgtSne8v6eAKkcdhNZfppvU7ivE61aB?=
 =?iso-8859-1?Q?uw2lFBQ7XY0OzF8UqLv7GYEP0ZZaGYBK9wSCH+3GqcDHyw10kuSVVHrxUt?=
 =?iso-8859-1?Q?TMPW4gPz3ACm7/fnc/aDhe4EfuCSt8xvQ0hONk2Kynfe5HKceqDSVkZpY9?=
 =?iso-8859-1?Q?njSQQ67zzkJpqRe4HzAu8nRayw7tnu4Ij+DhhIQGA3aI1jChAdeFexhZDF?=
 =?iso-8859-1?Q?7qM+ZxeHfkmQT7tmcpXGHv7pyWEiBxgUTJjYz7MalhppIhsM3nAHI63bWS?=
 =?iso-8859-1?Q?C/wmWUKk816dEVPQMWOoj4KoOy8bD9xHjImtXy2HD8N9v17KbjyRfDX4HI?=
 =?iso-8859-1?Q?tvGUXNfqqSHqdfsmxna2EIKHlk6fxEj+Y/JJINlX6kiZ5B3cFGF9u0sL4u?=
 =?iso-8859-1?Q?iiBm7tSiCNYXenLve5EQaheEvRNJTPQ4kfixa7VAGZgr+JShYrro7iil16?=
 =?iso-8859-1?Q?ge1fMok3wSOC0kGLEaQD3n1eSbddB5mFk/isw0LUS5LsWVp8AvqPO61GNi?=
 =?iso-8859-1?Q?+L3phDv9Q1OX71BKxMrizKZtXU012Ev/l4UA/4vj7okUil0PK4/LMf5MND?=
 =?iso-8859-1?Q?s/32Xy3bUaYSqC9zrojnNAWmceqN0RC9GdVNLuJlpRG1V6AetGdCfRXdcM?=
 =?iso-8859-1?Q?pRjI8v1l3uXOvZyy1z5w9uqHtR4DAmaOKaq1hDjiOOmFH/VGnYFLxQPJpN?=
 =?iso-8859-1?Q?IR4gefCK4cruB0kgdrJ2NBSgsaBXMN8q2WGwEDXI+kDbDe03ZHf0++FAPZ?=
 =?iso-8859-1?Q?gjUtDc29/Hm0T/6LlwQuToo/D96L6/jkuQfPGR6L62jPhkvTUgd86a1ezP?=
 =?iso-8859-1?Q?Hl5np/aqMyNqsS4X47+0lpGmWuJxIuT7nPcO62mha3jRhbxq6QLBK0Tu7A?=
 =?iso-8859-1?Q?kwmB3+VkdwMJih+lvqSsziZZpKiUXp1g/QF5TYwA7uNbN1dBqyF/lLdlHM?=
 =?iso-8859-1?Q?3l2pHF0fiFv58rj/XzDgcM1BF5p/QhDK7fvlhjx5fxDbTTz70U9/JJplIL?=
 =?iso-8859-1?Q?snsqpeiBSbiSSDDmBIuXIKym+ig675cfQ2ALjsDeBm5OXOpi+k2IrFKVGz?=
 =?iso-8859-1?Q?dYUPME68tSd4ogRS2QgYI5owPtRAXUSJPQMlq2FRcnR7AXjFe4JYzKqiwS?=
 =?iso-8859-1?Q?7aZjhSxrntB3qqwXjbWnH+ZI/5NInHeBdIWpk1Ch1zSMqz6EHFUbgccXpF?=
 =?iso-8859-1?Q?njtYeBkHWbUOCBlFPA2LMG+82NocviLKiJaX3nIY/TPof2Dn6QTF3RVjO2?=
 =?iso-8859-1?Q?ZQgA500CjFDFIjniNIQyd7nUMweaC0D/waQokWBv1bJyRyga/zETfQGR0A?=
 =?iso-8859-1?Q?sNWOjKx/+W9Fnu9+fVNtOmuQ7yBvF3bL6URTboSXabyQ2OJcA87PVMcCqL?=
 =?iso-8859-1?Q?arU8ceU6JOzkXtgyncqbDe3pSNyWjbg2MsfM3nVpiHy6b/sqmsUMgfOnsi?=
 =?iso-8859-1?Q?Y8CejjeDMTRjsvbVBuOL7RfvqniUZ+i5wCuO79L7G3xo6ivYxPZIoZatUa?=
 =?iso-8859-1?Q?nSvS87lmSSF0/nYqjsjv/r4QjdxXvsrijXkAUYHE0zntMhfmeIPY+NC3X1?=
 =?iso-8859-1?Q?zXSISOn0noo45FZCY1wh1Bvova3C28/gzbhoioCk3mieOq31rrSJXBWOu+?=
 =?iso-8859-1?Q?MYJXHt59ZPTrYKjs35VMHFqNb6zmQZZ/bK8+7jMQvD7cfnnYoWZLUiww?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a66239d-af04-4f06-8ebb-08da63870e9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 21:48:14.2844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jfOwn769GdOVW1GKCt761PsSCyW15bGA8IROuUW8h4Fd2Fmt30hwqoLsHtrkjnNW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3375
X-Proofpoint-ORIG-GUID: fgz5rPoZVT-PYnAd0hET9W_QCJVD2Rfb
X-Proofpoint-GUID: fgz5rPoZVT-PYnAd0hET9W_QCJVD2Rfb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_25,2022-07-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Basic tests, will develop in further iterations.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 .../selftests/bpf/prog_tests/delayed_work.c   | 29 +++++++++
 .../selftests/bpf/progs/delayed_irqwork.c     | 59 +++++++++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/delayed_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/delayed_irqwork.c

diff --git a/tools/testing/selftests/bpf/prog_tests/delayed_work.c b/tools/=
testing/selftests/bpf/prog_tests/delayed_work.c
new file mode 100644
index 000000000000..80ed52c8f34c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/delayed_work.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "delayed_irqwork.skel.h"
+
+void test_delayed_work(void)
+{
+	int err;
+	struct delayed_irqwork *skel;
+
+	skel =3D delayed_irqwork__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	err =3D delayed_irqwork__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	err =3D delayed_irqwork__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	/* trigger tracepoint */
+	usleep(1000000);
+
+cleanup:
+	delayed_irqwork__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/delayed_irqwork.c b/tools/te=
sting/selftests/bpf/progs/delayed_irqwork.c
new file mode 100644
index 000000000000..9fde66616681
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/delayed_irqwork.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+#include "vmlinux.h"
+
+#include "bpf_misc.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+struct map_value_type {
+	struct bpf_delayed_work work;
+	struct {
+		__u32 arg1;
+	} data;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, __u32);
+	__type(value, struct map_value_type);
+} map1 SEC(".maps");
+
+static __noinline int callback(void *args)
+{
+	struct map_value_type *val =3D args;
+
+	bpf_printk("callback: %p, %x", val, val->data.arg1);
+	return 0;
+}
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int delayed_irqwork(void *ctx)
+{
+	int ret;
+	__u32 key =3D 0;
+	struct map_value_type *value =3D (struct map_value_type *) bpf_map_lookup=
_elem(&map1, &key);
+
+	if (!value) {
+		bpf_printk("Could not get map value");
+		return 0;
+	}
+
+	value->data.arg1 =3D 0xcafe;
+	ret =3D bpf_delayed_work_submit(&value->work, callback, value, BPF_DELAYE=
D_WORK_IRQWORK);
+
+	key =3D 1;
+	value =3D (struct map_value_type *) bpf_map_lookup_elem(&map1, &key);
+	if (!value) {
+		bpf_printk("Could not get map value");
+		return 0;
+	}
+	value->data.arg1 =3D 0xbeef;
+	ret =3D bpf_delayed_work_submit(&value->work, callback, value, BPF_DELAYE=
D_WORK_IRQWORK);
+
+	return 0;
+}
--=20
2.36.1
