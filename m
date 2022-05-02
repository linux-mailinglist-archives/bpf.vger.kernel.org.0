Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8AF517A7B
	for <lists+bpf@lfdr.de>; Tue,  3 May 2022 01:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiEBXNP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 May 2022 19:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiEBXNN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 May 2022 19:13:13 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572A62F023
        for <bpf@vger.kernel.org>; Mon,  2 May 2022 16:09:42 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242LsdoH001183
        for <bpf@vger.kernel.org>; Mon, 2 May 2022 16:09:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=TiauhuQgoZUrngSfov53exe9RchItISFGYggMsssLLM=;
 b=QUQ0yNjQ+mb1y++qX8Wc7WNiZz7+xMfrz5q1qo+GrFUcFvgE49b0a6rV0/q9Ish2sNyp
 TvwFxVGnoF1gR3tgXM0ixip+vJihxG7mT1S03Uf6DkYR76Z/GxGVwlATtQWU/qvVkQv0
 PZQtGjOue+R2k3gzvVhTwi5UmsEzosNe86I= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fs2mxchjh-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 02 May 2022 16:09:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rzy8KsUFufdXXe8D+RAr944fzwIbr7qBhDp0+RV8FH8a0QYC4YV4gEtOrTTvOoBIKd3hxrjCOAu6pK9AJZQWyyVPlf1ePAmfN18PeTxq8VUehwgUzhFBKAlEudidONA+sBX7e6qVVJXWHS/oYx4D/NvDOhR1iy1sjvka5U0vTA8+/hnurObWza1mXqNl61J0+5IjsOpEgFa3zJ9z8XNjnJoGvIsfowoZKXeJ24+WwyWnINdGpbtU8lc+5afXp8sYE5kk5YnkoMJjxthMMP1/uaPFytirCS9k5ZTB1aSO/j/d/5QApWzfbGLJz4SLqzVDL69BAOeRH7Pvx90/R3Yg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiauhuQgoZUrngSfov53exe9RchItISFGYggMsssLLM=;
 b=BETzgxdiu/SpH1OT6/KXPRAMSdMfGg1nGwwPn5ksI6hR/hgKUpXDFEaTuwmCo+ngRt07+x8r26JJgGkN+sEqIggN7fOqKz2InbBRbNqTMqo0rvVqpbBZk0JA7DJBqBzDA5nWKKVHN4Ibe5J00gKSoin+YBfViU6a5J7xtXzOeC4j5eX7jRZ5ihxNtn2OavmDZ4CB0HnywuKf9khrl0gk7d2tn40TO8nJqZBRfZFvUtQIVDdJS3seWJb7AfLtZ+WzatywBjYiqVdog92HX0KNHy1cs3fpJ3ZgJu6ABkIXGY0vn2iziHEYZ6nlh9eag0aS9YRECrSDOabGZig7ufVyKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BYAPR15MB3141.namprd15.prod.outlook.com (2603:10b6:a03:f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Mon, 2 May
 2022 23:09:37 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%5]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 23:09:37 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v2 2/5] bpf: implement sleepable uprobes by chaining
 tasks_trace and normal rcu
Thread-Topic: [PATCH bpf-next v2 2/5] bpf: implement sleepable uprobes by
 chaining tasks_trace and normal rcu
Thread-Index: AQHYXnmxxCe8fRcUS0a8mA9+CnJfNg==
Date:   Mon, 2 May 2022 23:09:37 +0000
Message-ID: <588dd77e9e7424e0abc0e0e624524ef8a2c7b847.1651532419.git.delyank@fb.com>
References: <cover.1651532419.git.delyank@fb.com>
In-Reply-To: <cover.1651532419.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba10f5cd-7629-4daa-d5fb-08da2c90d45f
x-ms-traffictypediagnostic: BYAPR15MB3141:EE_
x-microsoft-antispam-prvs: <BYAPR15MB3141F6FBD4F45C4AC7107C96C1C19@BYAPR15MB3141.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WB+xWpf5BMDhitSYRmKLPowtySsnH31Dn1gUhUZ3jpYTjPgSmUthGuPvibS9vxPnUS9PNFnJChyj4QdReNazLyE/LDrwfaH6OcgD/1GSFIOHdXu5+iyU9QYwxdbsJVolqAJaTwOMyz20h9DwCM34ms6f/oEzY6f1W8F/9FuESmPsVCFWdmFOjpwOPCrVN6i4FMVKcssMJgmsONzeLm5y3Dz6KdBq9OKH0WJeamorDOh6Bfplg1USZ77y3eOtKtVKJY2gQx2uNh+Eoi2ImadsyguAFNvQpBl8B5Fa5J9OEU09rNb4DtRPEWTcMdDjJTVRlHVhtsFPvKi4Wvn1wLw7yPiod0vZ0tqGqTnXvwksCmQhwRo9FJ7CDIKSxSwfTF7KmM4KFz7raNLPygF1sDoos9YI+VRkqvDQWvkmbWX2pYMrKzYZWoGclrmdfmJ9lQE+1yF1OZ4sJ9OXfkdF3tFgMyFBnvJNfxo5Qof8FQ5Dfd4A2ItzCu1kGAsvByJ3E0W7s7bQ1NcgO8cNVGJu/u0onUKFUyc4nr3dSWKi39RL/tSr25wlYsuIPSPN97DDyOEVewYW7D+6IGbo1RWzfh+FomOBquTm8Vw95Dicn7MsAGiaUgeHxW3t3BFP35IGE373EKYXFdvVynQFZ7cXkTpeR1Hu8zptyhyZpLhRYatDEmtMqRL7ZtLhMuiRNKmPbJV26ivDuNNd950CVWNGiEkxig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(122000001)(186003)(110136005)(38100700002)(6506007)(38070700005)(5660300002)(316002)(64756008)(76116006)(66946007)(83380400001)(8676002)(66476007)(8936002)(66446008)(66556008)(71200400001)(86362001)(508600001)(2906002)(2616005)(6486002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xxRHFVC1EY2eeUkfGdHQrKSMcqHAQWynZEZZbg17r9Rcmq0hyj9aOCwLAw?=
 =?iso-8859-1?Q?KLOdEl6wGyLhsu8tp48Yjq2qbs2XVwg44rWWfyTTaoMVB+jaDk4bsG7727?=
 =?iso-8859-1?Q?aY4AofwkKyidUtbrccX1CMnknym60s1paA6JSTabDdp5VvV3Fg0n+n9xOQ?=
 =?iso-8859-1?Q?dy5Pg7Oi7rBleb9IbLIx6n1ER4ltvXBhBMQEn4oc7Zj6KMh1dcSJdvZdvj?=
 =?iso-8859-1?Q?B7AriEqq+XfSFlDRlA0mk1HvwCXnv3EI//PXdCi9pJHvWgixaXNiMmZP4l?=
 =?iso-8859-1?Q?pPZfA5KEl5yhNlYiR3NZbYCC3LoI2CDQn/FdDTOV+DLz05W4sk0qFpOkt8?=
 =?iso-8859-1?Q?Xjt6TBpQQ9OE6F8IK8X1D3NohJeoFSC77PK0FemyNfFeEUXC0A8VMs5y5F?=
 =?iso-8859-1?Q?eQ/ENnY6+K1QF2CXe23u8wD5qa2RNxhV5GQKCLKmUpmb97UpBF8rRgfmkg?=
 =?iso-8859-1?Q?xDg6WSVvJ27CV0fGX6H3WThCJKWjz/oBDvhcjvi00u0e0s/5FVMHYjQ6gB?=
 =?iso-8859-1?Q?c2wjNh1RxTtvSHGYBqHEnpLLEbOfkCo5XwXqzWtyxovl3LWvdZsfk/22tY?=
 =?iso-8859-1?Q?tmR9JZQ0l8NJqo7Wj4xAs6EuI1tqcb2ODSn+I3OFDJ97QK6aVT1bg6AaBc?=
 =?iso-8859-1?Q?Gx9GpyIEYM+7KdMSF4zYd8Z1ptVDa0V3p7rLatLizx4HItPcoq5BNbwHYG?=
 =?iso-8859-1?Q?usUkMXqe8SNv8EzAoB3S9QtLOqLj1/ynSO++Ljypb4wWjWrn/vEKE/73bo?=
 =?iso-8859-1?Q?it12a+HNv5XOhpColPf3RbY2RNb0aJkfr6s8PI74PieeBQ2tthHj6jDV4k?=
 =?iso-8859-1?Q?oZp52HKyxyZJNZZRjNTSOaMjq2yRZShyCxU38taO8upinHDITrVKIIN0g4?=
 =?iso-8859-1?Q?p7BkfuF7Lb0xhqPtoMb3/HLbobtGqPyBA2YxlKUvRll/sujBrvtiPU891U?=
 =?iso-8859-1?Q?OnmQHDd+gBlFRUnAK2ZWLyi8Cm2yoPmm37Cd4UMh/qjzzTyx/4+RpGtAxk?=
 =?iso-8859-1?Q?+BhKzi0nPzD5o/pIruog0r4a8xGVAy+CgUDK7z8l4qsbxQv7lESl83nbh2?=
 =?iso-8859-1?Q?fyPKRY+U6Sl0tlrhFv99BVy15dql1w687OVUeICEWi8TcwKeGX5Q3gsR8D?=
 =?iso-8859-1?Q?riCzqnRGHfU6bgB2J0lc/19H9D0oMycrbp15NAcn9Ev6Wf2Bkfyh2KTF4k?=
 =?iso-8859-1?Q?z0ptAN1MajI1HwR74Q4INeHqHU+tW4y6DwdDda1g8xVeDXTvTcsjbaTO0K?=
 =?iso-8859-1?Q?FILS4j+3wRoQkFzzAgpfjRzebRXrQKFZJZ/YfS3BVuahStZ3A9+mUmYiln?=
 =?iso-8859-1?Q?K0GHUvijUAybD9PMhU2xlhc0Cc6cW/12HUeWrucuf2RN870Y4bemccgyYq?=
 =?iso-8859-1?Q?TFt8qadXqNHdkbUz68EdOTxxXqEQway6Ld5zgFYqhMbPPAWqHCjXIpi3bX?=
 =?iso-8859-1?Q?wpZhpG5/U8pP8tUJVehrJf0jKi9q7QpYg9+bVbZnCioLvGFOc21NWLhF4L?=
 =?iso-8859-1?Q?t1PU4Z3kMqvIuPSKwYYQvwNmaXTJnSicLDrauvR/Sob7IM4Xwy+WlMWPIL?=
 =?iso-8859-1?Q?7XNuKF1M5pJD/rk3B8XthYf2qAN9ILT8W3alFUrOrPwCoDC3unxJFLVTA3?=
 =?iso-8859-1?Q?DwLLRI3dgx3AjIhm2fPUKEltElFLO6AJwUEfSJPM6IFTvxmJS3BHiyL99g?=
 =?iso-8859-1?Q?thx18L9zi5L5zv3oCul5QIipjkwtoXBCZx/VhWFqRPC3gn2nQ5slyeKqF4?=
 =?iso-8859-1?Q?8nLO7K50UGhOgwMLv+sHiRE8+R0esNsorMdC/8rSaFxkBG1pCDoItJtsGQ?=
 =?iso-8859-1?Q?YjJdtXrBmlVc/PBU35zwQ2Ea6uZbQFxM9WbCDFX48mImz5bEAZpc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba10f5cd-7629-4daa-d5fb-08da2c90d45f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 23:09:37.3483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1A72QtRVQspLX+aYC04nEP5pjGZFhtoCTYRaSUToAR4ag8cA9/VkOOlUZiEmTb5s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3141
X-Proofpoint-GUID: jjfHr_S5zoJR0peNXnt1Cd_5oPt5O3qj
X-Proofpoint-ORIG-GUID: jjfHr_S5zoJR0peNXnt1Cd_5oPt5O3qj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_08,2022-05-02_03,2022-02-23_01
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
user context. The primary obstacle to sleepable bpf uprobe programs is
therefore on the bpf side.

Namely, the bpf_prog_array attached to the uprobe is protected by normal
rcu and runs with disabled preemption. In order for uprobe bpf programs
to become actually sleepable, we need it to be protected by the tasks_trace
rcu flavor instead (and kfree() called after a corresponding grace period).

Based on Alexei's proposal, we change the free path for bpf_prog_array to
chain a tasks_trace and normal grace periods one after the other.

Users who iterate under tasks_trace read section would
be safe, as would users who iterate under normal read sections (from
non-sleepable locations). The downside is that we take the tasks_trace late=
ncy
for all perf_event-attached bpf programs (and not just uprobe ones)
but this is deemed safe given the possible attach rates for
kprobe/uprobe/tp programs.

Separately, non-sleepable programs need access to dynamically sized
rcu-protected maps, so we conditionally disable preemption and take an rcu
read section around them, in addition to the overarching tasks_trace sectio=
n.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 include/linux/bpf.h          | 57 ++++++++++++++++++++++++++++++++++++
 include/linux/trace_events.h |  1 +
 kernel/bpf/core.c            | 15 ++++++++++
 kernel/trace/bpf_trace.c     | 27 +++++++++++++++--
 kernel/trace/trace_uprobe.c  |  4 +--
 5 files changed, 99 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 57ec619cf729..592886115011 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -26,6 +26,7 @@
 #include <linux/stddef.h>
 #include <linux/bpfptr.h>
 #include <linux/btf.h>
+#include <linux/rcupdate_trace.h>

 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -1343,6 +1344,8 @@ extern struct bpf_empty_prog_array bpf_empty_prog_arr=
ay;

 struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
 void bpf_prog_array_free(struct bpf_prog_array *progs);
+/* Use when traversal over the bpf_prog_array uses tasks_trace rcu */
+void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs);
 int bpf_prog_array_length(struct bpf_prog_array *progs);
 bool bpf_prog_array_is_empty(struct bpf_prog_array *array);
 int bpf_prog_array_copy_to_user(struct bpf_prog_array *progs,
@@ -1428,6 +1431,60 @@ bpf_prog_run_array(const struct bpf_prog_array *arra=
y,
 	return ret;
 }

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
+	migrate_disable();
+	rcu_read_lock_trace();
+
+	array =3D rcu_dereference_check(array_rcu, rcu_read_lock_trace_held());
+	if (unlikely(!array))
+		goto out;
+	old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
+	item =3D &array->items[0];
+	while ((prog =3D READ_ONCE(item->prog))) {
+		if (!prog->aux->sleepable) {
+			preempt_disable();
+			rcu_read_lock();
+		}
+
+		run_ctx.bpf_cookie =3D item->bpf_cookie;
+		ret &=3D run_prog(prog, ctx);
+		item++;
+
+		if (!prog->aux->sleepable) {
+			rcu_read_unlock();
+			preempt_enable();
+		}
+	}
+	bpf_reset_run_ctx(old_run_ctx);
+out:
+	rcu_read_unlock_trace();
+	migrate_enable();
+	return ret;
+}
+
 #ifdef CONFIG_BPF_SYSCALL
 DECLARE_PER_CPU(int, bpf_prog_active);
 extern struct mutex bpf_stats_enabled_mutex;
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index e6e95a9f07a5..d45889f1210d 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -736,6 +736,7 @@ trace_trigger_soft_disabled(struct trace_event_file *fi=
le)

 #ifdef CONFIG_BPF_EVENTS
 unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx);
+unsigned int uprobe_call_bpf(struct trace_event_call *call, void *ctx);
 int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *=
prog, u64 bpf_cookie);
 void perf_event_detach_bpf_prog(struct perf_event *event);
 int perf_event_query_prog_array(struct perf_event *event, void __user *inf=
o);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 13e9dbeeedf3..9271b708807a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2268,6 +2268,21 @@ void bpf_prog_array_free(struct bpf_prog_array *prog=
s)
 	kfree_rcu(progs, rcu);
 }

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
index f15b826f9899..582a6171e096 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -140,6 +140,29 @@ unsigned int trace_call_bpf(struct trace_event_call *c=
all, void *ctx)
 	return ret;
 }

+unsigned int uprobe_call_bpf(struct trace_event_call *call, void *ctx)
+{
+	unsigned int ret;
+
+	/*
+	 * Instead of moving rcu_read_lock/rcu_dereference/rcu_read_unlock
+	 * to all call sites, we did a bpf_prog_array_valid() there to check
+	 * whether call->prog_array is empty or not, which is
+	 * a heuristic to speed up execution.
+	 *
+	 * If bpf_prog_array_valid() fetched prog_array was
+	 * non-NULL, we go into uprobe_call_bpf() and do the actual
+	 * proper rcu_dereference() under RCU trace lock.
+	 * If it turns out that prog_array is NULL then, we bail out.
+	 * For the opposite, if the bpf_prog_array_valid() fetched pointer
+	 * was NULL, you'll skip the prog_array with the risk of missing
+	 * out of events when it was updated in between this and the
+	 * rcu_dereference() which is accepted risk.
+	 */
+	ret =3D bpf_prog_run_array_sleepable(call->prog_array, ctx, bpf_prog_run)=
;
+	return ret;
+}
+
 #ifdef CONFIG_BPF_KPROBE_OVERRIDE
 BPF_CALL_2(bpf_override_return, struct pt_regs *, regs, unsigned long, rc)
 {
@@ -1915,7 +1938,7 @@ int perf_event_attach_bpf_prog(struct perf_event *eve=
nt,
 	event->prog =3D prog;
 	event->bpf_cookie =3D bpf_cookie;
 	rcu_assign_pointer(event->tp_event->prog_array, new_array);
-	bpf_prog_array_free(old_array);
+	bpf_prog_array_free_sleepable(old_array);

 unlock:
 	mutex_unlock(&bpf_event_mutex);
@@ -1941,7 +1964,7 @@ void perf_event_detach_bpf_prog(struct perf_event *ev=
ent)
 		bpf_prog_array_delete_safe(old_array, event->prog);
 	} else {
 		rcu_assign_pointer(event->tp_event->prog_array, new_array);
-		bpf_prog_array_free(old_array);
+		bpf_prog_array_free_sleepable(old_array);
 	}

 	bpf_prog_put(event->prog);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 9711589273cd..3eb48897d15b 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1346,9 +1346,7 @@ static void __uprobe_perf_func(struct trace_uprobe *t=
u,
 	if (bpf_prog_array_valid(call)) {
 		u32 ret;

-		preempt_disable();
-		ret =3D trace_call_bpf(call, regs);
-		preempt_enable();
+		ret =3D uprobe_call_bpf(call, regs);
 		if (!ret)
 			return;
 	}
--
2.35.1=
