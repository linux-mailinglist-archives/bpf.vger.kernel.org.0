Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DF3525958
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 03:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376323AbiEMBWt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 21:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351943AbiEMBWp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 21:22:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBDC5E172
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:43 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24D0ZN8w009739
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=fgyAYxmsGBCeGQ/ofQK8xnKhS5gvUza9sIsPeETkAsQ=;
 b=qVJkw6dTnTsEZPaQb0xZ2jiUl5lbjIsGBMCVL6YH0HUhDZhEXVXIq72ike0If4pHmo9D
 Oof1t5iGBd5Xk9evjHHc0wWk1WxuH2A5NTJeStrhgui5VOAXZBxljON4Qk45PioQ0osA
 Ei6L4oRXm3UJGKc96oWqlwDAkHtJbr6CGbw= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g1cwx85wn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQ0l/T76yzP5RStjMV5LmTwHyN9lEYqHeCxdRy3DOfG+WrV2lJnWUyYC/3dCWEX7yqv5PxcpsuIt7NC9aiR9sdFpV4eZE+qLPybhCJDMJNLNo9w7pdxPs5xnscAbK1P+pjHibjanQ2IuLI+C2bPg8UXYEamnkHSJLP66XBc2AJWRjaQ3YiYubLEXkFG6s9JSD9HLPeR7hcHnwWgb4P8n5xFheHBNlf2jzY6tgK4mNfOf9Cg7gNaMk8U5UzXAjTKakuA08BYRh0roakyFLBUMQkaC7++6mxNNsybSA4E8fhoIR/GmgD639krklq5be5ZMXhl9L4CUy8VyV1lTL8jmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgyAYxmsGBCeGQ/ofQK8xnKhS5gvUza9sIsPeETkAsQ=;
 b=LZJfCZe1//DZ6ObgMFUbnpnPI+KCPhnuPDNErFqZ+qhWOxjnLDKACZgg8wsjdxRY5jSkbf2r5F1+HcJW11Ziw1uNOcaqEKqBgody4pJsQnXF7k6gbFMwaUiT/017EXDWISt/WaJkWZlOP8h6F+kypZgSnxFLao26xclBCJR/Gr1yRID8XbMTK7Fte2XWFPfi4K1LqbKPBzJXqBtPXwdKmFLh5l4y5P2oOctP5LlVhXD9kZdgtw17CplncBuzsESDCGN5jonhrG7GTF8nBVexPXniC045wg2z0A3OhbvbQCIc2F0fwSDZTPpupCnaca3kibkC1EUVyjBWSLA0ieO5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by CY4PR15MB1208.namprd15.prod.outlook.com (2603:10b6:903:10a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 01:22:40 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%4]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 01:22:40 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v3 2/5] bpf: implement sleepable uprobes by chaining
 gps
Thread-Topic: [PATCH bpf-next v3 2/5] bpf: implement sleepable uprobes by
 chaining gps
Thread-Index: AQHYZmfvguvoJCxIhUOr//cQtqUQ+A==
Date:   Fri, 13 May 2022 01:22:40 +0000
Message-ID: <1b9c462226d2d7b97293e19ed2d578eb573a4544.1652404870.git.delyank@fb.com>
References: <cover.1652404870.git.delyank@fb.com>
In-Reply-To: <cover.1652404870.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4da4ce4-12fb-40d6-8ce8-08da347f1268
x-ms-traffictypediagnostic: CY4PR15MB1208:EE_
x-microsoft-antispam-prvs: <CY4PR15MB1208AE689FE9F1D8F07442E9C1CA9@CY4PR15MB1208.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: clgmKcjp4RXvHWzube+R0cvlpbRE405GfKePevTLIx7WQne5jphm7q9HGJXIYvnT1wZCBrOAo87xmzMDQn86PXYiFp/+wNczXctm78aQ4rU+ylHhbzBnvSYZNx0ohpER6VNe+ms3GEKhXRD/9AC1b294NAmYEJDu6JLwg7bZOu/knxjTFS+9XOjrihswy0DQWWV/grax+9so6Y6b3tDGyEL8Tzl2zW8oakwUfc7Gj48p3yM36QtBnhIsiUlsFT2votbvnVddoRZxbudvjgkHh/I6Dj03idEc4/Pk2uXw0XlwLTAL65M7OmrtrgzREvn04RHf+dsIDha9R9Jv0menKT+c1sBWZG59ycxkvPYenvyIl368n7bJKdTREs6a+vXw8ioMxGIGPyxqv26hkfjeukIc8/4sJ/K/3LtbXxF4eU60Jt/fx/+xSZIk56aYbUUOPRcQ02Xu+fuvjzFnTaKInUyY+3hEMB+VEbAzuY4UGVraRt4rk3uzbubGizLABv21SO4UFBCDAtg3ApY+ap92Ly12g8YE4NMpXkdLA0eDRaVesUjtVQNwttjwFJhaXJ3f+WSRG60lE10EU0tvnS1K7erAW6cxYAiFo2pX24C6cSlTFa2dK9d0MbIkChB2HIyDg5TpvuX+SUCVUti+7rsI+ygE/MdaarVW13XMQjrfa34bIw3Ihs0hJJY/2/RqhwSeH/HQPponO7BEn+lcbKdF6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(122000001)(38070700005)(38100700002)(36756003)(316002)(8676002)(71200400001)(76116006)(186003)(64756008)(66476007)(91956017)(66556008)(5660300002)(66446008)(66946007)(6506007)(83380400001)(8936002)(2616005)(86362001)(6486002)(508600001)(2906002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?a+zuivUplDRAg6/rNlBZYDHRpH8JwJdUHfNFqo6u0LqrmVPxrKiB13ovjb?=
 =?iso-8859-1?Q?88IRltRrwh9EnBgJEgh2ZSBd0b00qwVvVGBBxghInNrED4wrRTxmH+YcKz?=
 =?iso-8859-1?Q?fgwhIl3WhpomxfSIqwXRDP438GGrKLn55pDq2oz8qoeJI4qKnurLZm/T0v?=
 =?iso-8859-1?Q?Yh8hCyft1EzohFaLwZrHSiDBQr2DBYNFSl5VLCsw6as72rldeh0Jh/YoLQ?=
 =?iso-8859-1?Q?6JvjVy+woKx6ymWNavrGnZ1By6azR0KumXoMn/UyRBaBYeI4muf/y2XhlW?=
 =?iso-8859-1?Q?BDX8qssRehvhLCSgTdpvIMvqrQejMUJ/4XY4KTwMd5MxAEjsyaEM+JYazM?=
 =?iso-8859-1?Q?N0CJTSHO31BIsUgXH3keNPSc/7dkx5BVvGYZmVL63yFo/OGhVCdYO1cJ9H?=
 =?iso-8859-1?Q?M7uBfNTIznjAP7zmSzkrJsc7khwcLysCYkVTTjQEhP5IyKnzYbynEcFpbE?=
 =?iso-8859-1?Q?AGK0HjTm8gn3aAgJWIZBS6w75qrv6T7zSx/45YI2993MJGX7DLrvv6izxj?=
 =?iso-8859-1?Q?jqjeA2PfdWqpRz5fYoIAMC232JDP+usKLZ4Ir4ab4CESHeNkIBAnYE6ffJ?=
 =?iso-8859-1?Q?WFZ2DMi+I4OcInlhpr6Hjp0whKRXzF/LzvgGFDCth2G3CKVP1g5oIkqMpP?=
 =?iso-8859-1?Q?5MybARNLNrHaDtW1w0XAHyl+YShL6vzmHiaZHOX9YHUa1ekbFPCPTEOs7i?=
 =?iso-8859-1?Q?AaS+HIAOJu3QC4D2qNmuGc1Xzeb+UBQgPFDbYCm0CCHpX6L2C2yh/af4/B?=
 =?iso-8859-1?Q?UD6TGeeftAur6OZeybi/SSoYEsOY66haY7DqOF5bPS5EPmdPGaitrc0NBd?=
 =?iso-8859-1?Q?lD0c4V6BF7JQq16bTU/xvODzP3LBhhLmGZP4QNJa1LBEJ/iO4INIb+Vbjz?=
 =?iso-8859-1?Q?W7NYFJ/WfgU6ABmnRqrYVBHVKgJyGYDlALxL/fsKfyIcdUtGbkoshpXn3t?=
 =?iso-8859-1?Q?Vd6WrGVx/Fw2msFmTJU5AhsIdCDrqwPda8R7f/nJPDLpzrZhDbyeZ+XqTi?=
 =?iso-8859-1?Q?jXoxi8f7RKNnSV7qe0UlTE4CvP2soFC2yYQIopbhphS9ShHGA1g5kK4kkk?=
 =?iso-8859-1?Q?a2Bxb27sIfgzLRz3NsUHgWWT4VblHfsWT+y6yXyZPTD3Kl1XNLTcCyEcsQ?=
 =?iso-8859-1?Q?gzvgYyWZPonxKwfvgvzPJtvnqY5nJn12TitVMo5z3bR3SWQSFdPpjXvPoM?=
 =?iso-8859-1?Q?cZdhWcKGOSU+jpqU9KgsB+VFHSNwf1+IpFtq0ISqt5edF3QIzdn5pRCTYC?=
 =?iso-8859-1?Q?n4S70fOF6+jeLAR/4s/LVLwjZTL7WZ4iM+lYLXhOSdS+9D/Mtz3TcHcxj/?=
 =?iso-8859-1?Q?23BeKz5bO08slXkYNNeVUxZ5+5ohx1YZW0RkF48h/wt15tvT4bdzzRUYY4?=
 =?iso-8859-1?Q?RZjYWu/E3vIsDu6wDQgJVar/EQQs80D0zcvJryVrDVM4ZSDeuCeZlgtyT/?=
 =?iso-8859-1?Q?3Cp1XZ2BRZi1qrsZEDobZo6ls7t2xj1NVlGwo1zQDGE33LjJtXN7A9XqYP?=
 =?iso-8859-1?Q?Co16KjmTYFDIAUr+X6aeHC0tXRONg7/PVwbzfQ+xOf+8J4NyR5vQ9VKb5u?=
 =?iso-8859-1?Q?4hopKldAFwPXaEl0iTsmCsrVVEcLiDk8EuX2rvUGIEBbx0DaX+O2MHc73M?=
 =?iso-8859-1?Q?+hqCmdyP4uUA6Zk3UfQDNq6nZfenqmqUe59xaCmsasIftKJVDRh+Cw4/b9?=
 =?iso-8859-1?Q?n2PRxM53lywZBJpHpJgPKMqmYbEFh+jSo+SUX2stWMudAMbNa1NiTvN8Gm?=
 =?iso-8859-1?Q?ZWO0kdsjx+kWvZ+HdYw/NFk/Zq07GrqXw4ggfiTfh2ZmaVT8bvu8ZJdxSL?=
 =?iso-8859-1?Q?G/YsGgcy0RqBj4SFszYXt3LanuKkngYwd8CQ3vpf7Q61eOiE+XVZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4da4ce4-12fb-40d6-8ce8-08da347f1268
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 01:22:40.0522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndVhUrV0sonVjtCbRq/nSOXv4Y3Qpyf36kd7hvgpuq8QTaM2ZO6YuI5VGQLCWOUG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1208
X-Proofpoint-GUID: KaAEMelYcQm6DRzXBeaTzaXISO2HwSev
X-Proofpoint-ORIG-GUID: KaAEMelYcQm6DRzXBeaTzaXISO2HwSev
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_19,2022-05-12_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

uprobes work by raising a trap, setting a task flag from within the
interrupt handler, and processing the actual work for the uprobe on the
way back to userspace. As a result, uprobe handlers already execute in a
might_fault/_sleep context. The primary obstacle to sleepable bpf uprobe
programs is therefore on the bpf side.

Namely, the bpf_prog_array attached to the uprobe is protected by normal
rcu. In order for uprobe bpf programs to become sleepable, it has to be
protected by the tasks_trace rcu flavor instead (and kfree() called after
a corresponding grace period).

Therefore, the free path for bpf_prog_array now chains a tasks_trace and
normal grace periods one after the other.

Users who iterate under tasks_trace read section would
be safe, as would users who iterate under normal read sections (from
non-sleepable locations).

The downside is that the tasks_trace latency affects all perf_event-attache=
d
bpf programs (and not just uprobe ones). This is deemed safe given the
possible attach rates for kprobe/uprobe/tp programs.

Separately, non-sleepable programs need access to dynamically sized
rcu-protected maps, so bpf_run_prog_array_sleepables now conditionally take=
s
an rcu read section, in addition to the overarching tasks_trace section.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 include/linux/bpf.h         | 53 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/core.c           | 15 +++++++++++
 kernel/trace/bpf_trace.c    |  4 +--
 kernel/trace/trace_uprobe.c |  5 ++--
 4 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b67893b47da4..77ba90d654e7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -26,6 +26,7 @@
 #include <linux/stddef.h>
 #include <linux/bpfptr.h>
 #include <linux/btf.h>
+#include <linux/rcupdate_trace.h>
=20
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -1360,6 +1361,8 @@ extern struct bpf_empty_prog_array bpf_empty_prog_arr=
ay;
=20
 struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
 void bpf_prog_array_free(struct bpf_prog_array *progs);
+/* Use when traversal over the bpf_prog_array uses tasks_trace rcu */
+void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs);
 int bpf_prog_array_length(struct bpf_prog_array *progs);
 bool bpf_prog_array_is_empty(struct bpf_prog_array *array);
 int bpf_prog_array_copy_to_user(struct bpf_prog_array *progs,
@@ -1451,6 +1454,56 @@ bpf_prog_run_array(const struct bpf_prog_array *arra=
y,
 	return ret;
 }
=20
+/**
+ * Notes on RCU design for bpf_prog_arrays containing sleepable programs:
+ *
+ * We use the tasks_trace rcu flavor read section to protect the bpf_prog_=
array
+ * overall. As a result, we must use the bpf_prog_array_free_sleepable
+ * in order to use the tasks_trace rcu grace period.
+ *
+ * When a non-sleepable program is inside the array, we take the rcu read
+ * section and disable preemption for that program alone, so it can access
+ * rcu-protected dynamically sized maps.
+ */
+static __always_inline u32
+bpf_prog_run_array_sleepable(const struct bpf_prog_array __rcu *array_rcu,
+			     const void *ctx, bpf_prog_run_fn run_prog)
+{
+	const struct bpf_prog_array_item *item;
+	const struct bpf_prog *prog;
+	const struct bpf_prog_array *array;
+	struct bpf_run_ctx *old_run_ctx;
+	struct bpf_trace_run_ctx run_ctx;
+	u32 ret =3D 1;
+
+	might_fault();
+
+	rcu_read_lock_trace();
+	migrate_disable();
+
+	array =3D rcu_dereference_check(array_rcu, rcu_read_lock_trace_held());
+	if (unlikely(!array))
+		goto out;
+	old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
+	item =3D &array->items[0];
+	while ((prog =3D READ_ONCE(item->prog))) {
+		if (!prog->aux->sleepable)
+			rcu_read_lock();
+
+		run_ctx.bpf_cookie =3D item->bpf_cookie;
+		ret &=3D run_prog(prog, ctx);
+		item++;
+
+		if (!prog->aux->sleepable)
+			rcu_read_unlock();
+	}
+	bpf_reset_run_ctx(old_run_ctx);
+out:
+	migrate_enable();
+	rcu_read_unlock_trace();
+	return ret;
+}
+
 #ifdef CONFIG_BPF_SYSCALL
 DECLARE_PER_CPU(int, bpf_prog_active);
 extern struct mutex bpf_stats_enabled_mutex;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 76f68d0a7ae8..9c2175b06b38 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2268,6 +2268,21 @@ void bpf_prog_array_free(struct bpf_prog_array *prog=
s)
 	kfree_rcu(progs, rcu);
 }
=20
+static void __bpf_prog_array_free_sleepable_cb(struct rcu_head *rcu)
+{
+	struct bpf_prog_array *progs;
+
+	progs =3D container_of(rcu, struct bpf_prog_array, rcu);
+	kfree_rcu(progs, rcu);
+}
+
+void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs)
+{
+	if (!progs || progs =3D=3D &bpf_empty_prog_array.hdr)
+		return;
+	call_rcu_tasks_trace(&progs->rcu, __bpf_prog_array_free_sleepable_cb);
+}
+
 int bpf_prog_array_length(struct bpf_prog_array *array)
 {
 	struct bpf_prog_array_item *item;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 7141ca8a1c2d..f74c53dba64e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1934,7 +1934,7 @@ int perf_event_attach_bpf_prog(struct perf_event *eve=
nt,
 	event->prog =3D prog;
 	event->bpf_cookie =3D bpf_cookie;
 	rcu_assign_pointer(event->tp_event->prog_array, new_array);
-	bpf_prog_array_free(old_array);
+	bpf_prog_array_free_sleepable(old_array);
=20
 unlock:
 	mutex_unlock(&bpf_event_mutex);
@@ -1960,7 +1960,7 @@ void perf_event_detach_bpf_prog(struct perf_event *ev=
ent)
 		bpf_prog_array_delete_safe(old_array, event->prog);
 	} else {
 		rcu_assign_pointer(event->tp_event->prog_array, new_array);
-		bpf_prog_array_free(old_array);
+		bpf_prog_array_free_sleepable(old_array);
 	}
=20
 	bpf_prog_put(event->prog);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 9711589273cd..0282c119b1b2 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -16,6 +16,7 @@
 #include <linux/namei.h>
 #include <linux/string.h>
 #include <linux/rculist.h>
+#include <linux/filter.h>
=20
 #include "trace_dynevent.h"
 #include "trace_probe.h"
@@ -1346,9 +1347,7 @@ static void __uprobe_perf_func(struct trace_uprobe *t=
u,
 	if (bpf_prog_array_valid(call)) {
 		u32 ret;
=20
-		preempt_disable();
-		ret =3D trace_call_bpf(call, regs);
-		preempt_enable();
+		ret =3D bpf_prog_run_array_sleepable(call->prog_array, regs, bpf_prog_ru=
n);
 		if (!ret)
 			return;
 	}
--=20
2.35.3
