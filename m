Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDF9570CF7
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 23:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiGKVsT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 17:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGKVsS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 17:48:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B7E65578
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 14:48:16 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BLWf9p028436
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 14:48:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=2sSI9PbTTGAMT8nuUBd2BMAx9yVlMUjfUy8sF4c9ZTc=;
 b=anUNZRoTn9HmV3T8HYHYq/NukFAX9qGh2a3E7Z6M3X4MT+lhgwxSHTH071asjXNFbgyD
 Vf+ghdnq94fWVx3pg1LMiWj1/MT86lOP5/U4Zaq8yc7Nzn1nvvUKzJP9o+swyWc62pjM
 i4/+qJeIfq+wmz1uTyKWnX9c6WcYuRFoZrE= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h79043syk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 14:48:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoU5jN0ZEUDO9lbF/0Fqd5gEM1pQ58AYyYd9yLzi9ptTOxofLi0daUeOSEq+IdJeCrh1bQGO0RvKaaB3y1dyhOjue3+I9HMC/N2gO2agfkouP//H3fTKAO0nbcGd3adrobHVGREsNDHcvxiO4oub40Yuj3NVmAUfrj2xcprYQ7Pw7+f9egJpf7SL8VFCIrhkZS42tl+odejk0lyK5Hy5QR+QOnEgS97+yL+AT6eAky4UsPiGD7n8VkgvgQJpuRqjIeSz5pL0fAScnKJY6GiUHnKfoamGnFo+6a4M46B5aNIi3m1MVNwWLCciyapw4A+ripiIrIU2yh9TnCMS+aafsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sSI9PbTTGAMT8nuUBd2BMAx9yVlMUjfUy8sF4c9ZTc=;
 b=loUgvgvg6an03MmvjOoXWgE9ngv7PPzf5uJCRxbnf1KxlD906kPW+lOGJqSXdD3uAoNBuQWAJM/EqsbUQ+yYU7DLgw9d7m7PvvFgSS1kGNF8o60ZbAMqKO1guFVtE0CCE3VvCWMxINJRzk2u8FXerwQCIkyD/PHhzHO+TN6JUtLwzosBvclKleijNUYf3PVyWImoSNCzKCrVyZKP18PuMeX6Z2wUUT1CCVG/9RTaKSJ/0ONcXbe5cJvRAX2pX09mty5egry0t2rJN2Dq7LvNoBELIvQFFRE+ILfuNk8kXA4hjoASj+qheY79uWXSYNufMiclhQ85dkenelXgxR/4lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM6PR15MB2522.namprd15.prod.outlook.com (2603:10b6:5:1a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 21:48:12 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::ac52:e8fa:831f:237e]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::ac52:e8fa:831f:237e%9]) with mapi id 15.20.5395.020; Mon, 11 Jul 2022
 21:48:12 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH RFC bpf-next 2/3] bpf: add delayed_work mechanism
Thread-Topic: [PATCH RFC bpf-next 2/3] bpf: add delayed_work mechanism
Thread-Index: AQHYlW/riXkQtYrFGUiv4fNWBMwwQg==
Date:   Mon, 11 Jul 2022 21:48:12 +0000
Message-ID: <3d3027f5e13a37874b39c6363789bd55b4110be4.1657576063.git.delyank@fb.com>
References: <cover.1657576063.git.delyank@fb.com>
In-Reply-To: <cover.1657576063.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eef3d5f1-080c-4e68-9989-08da63870da3
x-ms-traffictypediagnostic: DM6PR15MB2522:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gc8O2D+6xoTP/FupCsivappFzxbijeIMYfQe1gPQ3kjxjLnWZL45A5QxpXg7QYWYmwNlKZyhw5zHgVtlE2RuNpfK+pBRFH+frmpJZExpNLkN/n0FbhQTaX12YvZ3OEs08elICAwwmMk1tRv+YQk2IaUnkdnpyTtWNMHog4CgLfdZXm0bGmLAKPuu4FPEEDg4ItktFCn7d4Bo+8DhEQdjcFrKIHj9S4wSWVzckR8La/gJbIeMW8qF3Jd4880NQsoYIK8RtAmnS2xGEpWfaKgo1HnNk6U6WVdPIXHjoHAadWFqkMX+4s9NuL0RkRhm5N/G7ppgXk1enkxuHwodZuxH5hKws9+RgfuCmKgS9bHs91K/oYn90UV5XZbDmGF87oiOBB+CWKotyLl+AoLMQmvX8Ilf458nAPcsVKxAHNjRsK/KCLFfPZ4nP+cLjIWSNvTPLLoWSOBz77gXvXi6Wp6JJHXQNKeLrV3YoHM6LWjS8A6b/yJ0KsaPaVP4iNZQFF5kDupgoNu6xmTuAiY4uSIO2egd1zs2XstjQlSS1BDcqDpdgvZ+5nxF85n3bVFPsTf4jsSD6rgdruUoOB+z5UJFXCq6HLrQaH551Ti8iTBFRDuKjEA+b8WC563rfdjA5FYomLyIJvY81ZN4GeHQkxZzfNjJUHm3hcREPtn3WKsapOMcjVl5aX9VjEHobuyNGtNYr6VVQOSRUxLBKHyt3ZBkcVYIdLClbg+hYtZU5VXNG4tb7HWA84GW/jANBaj+D3ybDPU9ctURKM5CdXEmbmnfrwfHJX5YkFOikIC+SQz+Vnbwq83nrT+MVSL5VWSmF15q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(38100700002)(186003)(122000001)(83380400001)(71200400001)(2616005)(36756003)(64756008)(8676002)(66476007)(316002)(110136005)(76116006)(66946007)(66446008)(91956017)(2906002)(6506007)(478600001)(41300700001)(6512007)(6486002)(38070700005)(8936002)(5660300002)(30864003)(66556008)(86362001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LZMf+RtnD7TyPMOInE22yKe7djSgBXoA3zyR3o64rVS5c/8XXWUieELgT/?=
 =?iso-8859-1?Q?qBAB6njDa75ctho+9X3hnpvvCCKYqEVDf4PaAjSNGo9fzR7y+WtxvqZOVZ?=
 =?iso-8859-1?Q?SrrjeEE6I6A35c68+s5+VpZT79VJFwLWX+X0aKKQppa41Q33iBgLk/ecOl?=
 =?iso-8859-1?Q?twhutwms2R0xWYuAiFUHA/wS9b4Qp/81JBBC9XHwVpMPWSzNWNNQDo1ZzZ?=
 =?iso-8859-1?Q?qByqEhsObXdzTQ4chZbcRoOFIPURBZDhiVTNYFoBY95or2Xii5K5mP0uBk?=
 =?iso-8859-1?Q?rNz/sCGnZ8osdC1FwKh24wcK4okqzjLWkrKorn7Azmmet0oOwnHEZcClZE?=
 =?iso-8859-1?Q?0RVE8CMP0n1QvKotQHWMHKA8+impkgT2EFvrZFY6yJQlkAC1ihJ1JEERYj?=
 =?iso-8859-1?Q?InvD2oCjJfZz3pmoJJrhZ6efLKyflmTP2fGIZWKrRwdy+9yYROEBWLVg98?=
 =?iso-8859-1?Q?Dg5806I7DpT/HLSV4Pzd78N02EKMt+/bKLuVzOmEKwMUeOyTsAJcd+6aO9?=
 =?iso-8859-1?Q?AowWjSmmk3x1risr/TVbGBVqcIAf0VSte2sPGZUhrS8caRlA+vDVs9bBjS?=
 =?iso-8859-1?Q?QhvqP1rp/mN9khn5dDJpGWKfWVS945zcsBSC2qm/GkmIarta9TDJFCvBwe?=
 =?iso-8859-1?Q?P1jXupUr7ZOtOLhtEGyRhQhP99ZcCT76gpZJBdRQ6PJcZeb9UEbO6YxOel?=
 =?iso-8859-1?Q?8HXg4GgNxvYdtVIyPX7zPCFw4uGazpQJCy+suOoPrgMMLaVJ1xqqBiNjhY?=
 =?iso-8859-1?Q?Numo7pmwMXiMmpurqNfSAuno1SxKPBO5GxEbR2RzErKjTtKTQCAC7Lyyb9?=
 =?iso-8859-1?Q?TEAJdOvMERSpWnwG69boqaKR+Q1f9MLhPx/daavksHlzOW/YJ0Pf/Sph7e?=
 =?iso-8859-1?Q?/0B42n8NMbl++YBobytvoz4L6TdWHrTB1H9HT243Daqps77ujbVq9xFCjT?=
 =?iso-8859-1?Q?xWF/w5y4eBmFyetp5wGbtuGOHJVnJKm7JLHYobDgcMyRpdAoVG4mcmejas?=
 =?iso-8859-1?Q?00Laboh2t7yuVwUjCdA0o8/AddFStDe6gtHnVVVcRG8dY3mbe7tvx2JFLf?=
 =?iso-8859-1?Q?e8tNjClWEiZxl8ikw3uc4gJz04Yy46ylN6SF8K74MrpuGPhMWNE0q+iz6c?=
 =?iso-8859-1?Q?fnuKGkMt0EqfghSJ3ep3zA1ti2cCa71gB3XITciCud68WZfEuppzi9YokZ?=
 =?iso-8859-1?Q?6XCI1aStIXn9f/50Ei0wuNejQZeWC1ch8s84NIFWf3+8KT32SOGtD+kdxT?=
 =?iso-8859-1?Q?fd51wycuXDTmrJ5+dI2bYy2Uo1DUDLSEgzUiFQJ5bUzhGs8hRuGNw1JMQr?=
 =?iso-8859-1?Q?iRyGM42nx7Ehy+EfmDFFBtDpQPJ49Qgi6UWUK0R5v4ML+pY/1DczZyfCh1?=
 =?iso-8859-1?Q?iqmjqNY5pml/WEoLVsnQdo0TtnYtUhfCym7DpLlOgS5clQbMQtd0R0Wt65?=
 =?iso-8859-1?Q?7thXK5OopKjKV+4hVmzdQ0KDNDTsMeq3jH2gbRTjArFQB4qKy2ZuAXQ2hf?=
 =?iso-8859-1?Q?7Vbqiz2LSSIhCu/e2lQ2Cl1DPemiJhDfFLxBpRLIjt30X3zeTc2Lhr4nCb?=
 =?iso-8859-1?Q?PHT+og5ona21JGF02Qfbyq2FSPbQOla34tRxy1FNLQYXpNRlclbKIqkLtd?=
 =?iso-8859-1?Q?UHOphqFl+v5DUeRmey4DNgLLUoMBEBTKMimV13aFrwpECzlM/stS0WpA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef3d5f1-080c-4e68-9989-08da63870da3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 21:48:12.6594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dHGcmWIplnw5VI15VdgtshNz9kYUtH7yPJPi7/9AX65dpoJpeGYOyuYfcTG3Xiby
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2522
X-Proofpoint-ORIG-GUID: s-N0AK46H1vL3xO8_i1cZHIreCjyDi6Q
X-Proofpoint-GUID: s-N0AK46H1vL3xO8_i1cZHIreCjyDi6Q
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

Add a new helper function that can schedule a callback to execute in a
different context. Initially, only irq_work (i.e. hardirq) is supported.

A key consideration is that we need this to work in an NMI context.
Therefore, we use a queue of pre-allocated llist nodes inside
bpf_delayed_work, which we drain on a per-program basis. To avoid races
on the bpf_delayed_work items, we implement a simple lock scheme based
on cmpxchg ordering.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 include/linux/bpf.h            |  13 ++++
 include/uapi/linux/bpf.h       |  28 ++++++++
 kernel/bpf/core.c              |   8 +++
 kernel/bpf/helpers.c           |  92 ++++++++++++++++++++++++
 kernel/bpf/verifier.c          | 123 ++++++++++++++++++++++++++++++++-
 scripts/bpf_doc.py             |   2 +
 tools/include/uapi/linux/bpf.h |  27 ++++++++
 7 files changed, 292 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ad9d2cfb0411..7325a9a2d10b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -27,6 +27,8 @@
 #include <linux/bpfptr.h>
 #include <linux/btf.h>
 #include <linux/rcupdate_trace.h>
+#include <linux/irq_work.h>
+#include <linux/llist.h>
=20
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -460,6 +462,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
 	ARG_PTR_TO_KPTR,	/* pointer to referenced kptr */
 	ARG_PTR_TO_DYNPTR,      /* pointer to bpf_dynptr. See bpf_type_flag for d=
ynptr type */
+	ARG_PTR_TO_DELAYED_WORK,/* pointer to bpf_delayed_work */
 	__BPF_ARG_TYPE_MAX,
=20
 	/* Extended arg_types. */
@@ -1101,6 +1104,9 @@ struct bpf_prog_aux {
 	u32 linfo_idx;
 	u32 num_exentries;
 	struct exception_table_entry *extable;
+
+	/* initialized at load time if program uses delayed work helpers */
+	struct bpf_delayed_irq_work *irq_work;
 	union {
 		struct work_struct work;
 		struct rcu_head	rcu;
@@ -2526,4 +2532,11 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, vo=
id *data,
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 int bpf_dynptr_check_size(u32 size);
=20
+struct bpf_delayed_irq_work {
+	struct llist_head items;
+	struct irq_work work;
+	struct bpf_prog *prog;
+};
+void bpf_delayed_work_irq_work_cb(struct irq_work *work);
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d68fc4f472f1..dc0587bbbe7c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5325,6 +5325,29 @@ union bpf_attr {
  *		**-EACCES** if the SYN cookie is not valid.
  *
  *		**-EPROTONOSUPPORT** if CONFIG_IPV6 is not builtin.
+ *
+ *
+ * long bpf_delayed_work_submit(struct bpf_delayed_work *work, void *cb, v=
oid *data, int flags)
+ *     Description
+ *             Submits a function to execute in a different context.
+ *
+ *             *work* must be a member in a map value.
+ *
+ *             *cb* function to call
+ *
+ *             *data* context to pass as sole argument to *cb*. Must be pa=
rt of
+ *             a map value or NULL.
+ *
+ *             *flags* must be BPF_DELAYED_WORK_IRQWORK
+ *     Return
+ *             0 when work is successfully submitted.
+ *
+ *             **-EINVAL** if *cb* is NULL
+ *
+ *             **-EOPNOTSUP** if called from an NMI handler on an
+ *             architecture without NMI-safe cmpxchg
+ *
+ *             **-EINVAL** if *work* is already in use
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5535,6 +5558,7 @@ union bpf_attr {
 	FN(tcp_raw_gen_syncookie_ipv6),	\
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
+	FN(delayed_work_submit),        \
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
@@ -6699,6 +6723,10 @@ struct bpf_delayed_work {
 	__u64 :64;
 } __attribute__((aligned(8)));
=20
+enum {
+	BPF_DELAYED_WORK_IRQWORK =3D (1UL << 0),
+};
+
 struct bpf_sysctl {
 	__u32	write;		/* Sysctl is being read (=3D 0) or written (=3D 1).
 				 * Allows 1,2,4-byte read, but no write.
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b5ffebcce6cc..1f5093f9442b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2567,6 +2567,14 @@ static void bpf_prog_free_deferred(struct work_struc=
t *work)
 	int i;
=20
 	aux =3D container_of(work, struct bpf_prog_aux, work);
+
+	/* We have already waited for a qs of the appropriate RCU variety,
+	 * so we can expect no further submissions of work. Just wait for
+	 * the currently scheduled work to finish before releasing anything.
+	 */
+	if (aux->irq_work)
+		irq_work_sync(&aux->irq_work->work);
+
 #ifdef CONFIG_BPF_SYSCALL
 	bpf_free_kfunc_btf_tab(aux->kfunc_btf_tab);
 #endif
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a1c84d256f83..731547d34c35 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -18,6 +18,8 @@
 #include <linux/proc_ns.h>
 #include <linux/security.h>
 #include <linux/btf_ids.h>
+#include <linux/irq_work.h>
+#include <linux/llist.h>
=20
 #include "../../lib/kstrtox.h"
=20
@@ -1575,6 +1577,94 @@ static const struct bpf_func_proto bpf_dynptr_data_p=
roto =3D {
 	.arg3_type	=3D ARG_CONST_ALLOC_SIZE_OR_ZERO,
 };
=20
+struct bpf_delayed_work_kern {
+	struct llist_node item;
+	u64 flags; /* used as a lock field */
+	void (*cb)(void *);
+	void *data;
+} __aligned(8);
+
+#define BPF_DELAYED_WORK_FREE (0)
+#define BPF_DELAYED_WORK_CLAIMED (1)
+#define BPF_DELAYED_WORK_READY (2)
+
+void bpf_delayed_work_irq_work_cb(struct irq_work *work)
+{
+	struct bpf_delayed_irq_work *bpf_irq_work =3D container_of(work, struct b=
pf_delayed_irq_work, work);
+	struct bpf_delayed_work_kern *work_item, *next;
+	struct llist_node *work_list =3D llist_del_all(&bpf_irq_work->items);
+
+	/* Traverse in submission order to preserve ordering semantics */
+	llist_reverse_order(work_list);
+
+	llist_for_each_entry_safe(work_item, next, work_list, item) {
+		WARN_ONCE(work_item->flags !=3D BPF_DELAYED_WORK_READY, "incomplete bpf_=
delayed_work found");
+
+		work_item->cb(work_item->data);
+
+		work_item->cb =3D work_item->data =3D NULL;
+		bpf_prog_put(bpf_irq_work->prog);
+		xchg(&work_item->flags, BPF_DELAYED_WORK_FREE);
+	}
+}
+
+BPF_CALL_5(bpf_delayed_work_submit, struct bpf_delayed_work_kern *, work,
+	   void *, callback_fn, void *, data, int, flags, struct bpf_prog_aux *, =
aux)
+{
+	u64 ret;
+	struct bpf_prog *prog;
+
+	BUILD_BUG_ON(sizeof(struct bpf_delayed_work_kern) > sizeof(struct bpf_del=
ayed_work));
+	BUILD_BUG_ON(__alignof__(struct bpf_delayed_work_kern) !=3D __alignof__(s=
truct bpf_delayed_work));
+	BTF_TYPE_EMIT(struct bpf_delayed_work);
+
+	if (callback_fn =3D=3D NULL)
+		return -EINVAL;
+
+	if (flags !=3D BPF_DELAYED_WORK_IRQWORK)
+		return -EOPNOTSUPP;
+
+	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) && in_nmi())
+		return -EOPNOTSUPP;
+
+	ret =3D cmpxchg(&work->flags, BPF_DELAYED_WORK_FREE, BPF_DELAYED_WORK_CLA=
IMED);
+	if (ret !=3D 0)
+		return -EINVAL;
+
+	work->data =3D data;
+	work->cb =3D callback_fn;
+
+	ret =3D cmpxchg(&work->flags, BPF_DELAYED_WORK_CLAIMED, BPF_DELAYED_WORK_=
READY);
+	if (ret !=3D BPF_DELAYED_WORK_CLAIMED) {
+		WARN_ONCE(ret !=3D BPF_DELAYED_WORK_CLAIMED, "bpf_delayed_work item alte=
red while claimed");
+		return -EINVAL;
+	}
+
+	/* Bump the ref count for every work item submitted by the program. */
+	prog =3D bpf_prog_inc_not_zero(aux->prog);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
+	llist_add(&work->item, &aux->irq_work->items);
+
+	/* It's okay if this prog's irq_work is already submitted,
+	 * it will walk the same list of callbacks anyway.
+	 */
+	(void) irq_work_queue(&aux->irq_work->work);
+
+	return 0;
+}
+
+const struct bpf_func_proto bpf_delayed_work_submit_proto =3D {
+	.func		=3D bpf_delayed_work_submit,
+	.gpl_only	=3D true,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_DELAYED_WORK,
+	.arg2_type	=3D ARG_PTR_TO_FUNC,
+	.arg3_type	=3D ARG_PTR_TO_MAP_VALUE, /* TODO: need ptr_to_map_value_mem *=
/
+	.arg4_type	=3D ARG_ANYTHING,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
@@ -1643,6 +1733,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_dynptr_write_proto;
 	case BPF_FUNC_dynptr_data:
 		return &bpf_dynptr_data_proto;
+	case BPF_FUNC_delayed_work_submit:
+		return &bpf_delayed_work_submit_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9fd311b7a1ff..212cbea5a382 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5490,6 +5490,55 @@ static int process_timer_func(struct bpf_verifier_en=
v *env, int regno,
 	return 0;
 }
=20
+static int process_delayed_work_func(struct bpf_verifier_env *env, int reg=
no,
+			      struct bpf_call_arg_meta *meta)
+{
+	struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[regno];
+	bool is_const =3D tnum_is_const(reg->var_off);
+	struct bpf_map *map =3D reg->map_ptr;
+	u64 val =3D reg->var_off.value;
+
+	if (!is_const) {
+		verbose(env,
+			"R%d doesn't have constant offset. bpf_delayed_work has to be at the co=
nstant offset\n",
+			regno);
+		return -EINVAL;
+	}
+	if (!map->btf) {
+		verbose(env, "map '%s' has to have BTF in order to use bpf_delayed_work\=
n",
+			map->name);
+		return -EINVAL;
+	}
+	if (!map_value_has_delayed_work(map)) {
+		if (map->delayed_work_off =3D=3D -E2BIG)
+			verbose(env,
+				"map '%s' has more than one 'struct bpf_delayed_work'\n",
+				map->name);
+		else if (map->delayed_work_off =3D=3D -ENOENT)
+			verbose(env,
+				"map '%s' doesn't have 'struct bpf_delayed_work'\n",
+				map->name);
+		else
+			verbose(env,
+				"map '%s' is not a struct type or bpf_delayed_work is mangled\n",
+				map->name);
+		return -EINVAL;
+	}
+	if (map->delayed_work_off !=3D val + reg->off) {
+		verbose(env, "off %lld doesn't point to 'struct bpf_delayed_work' that i=
s at %d\n",
+			val + reg->off, map->delayed_work_off);
+		return -EINVAL;
+	}
+	if (meta->map_ptr) {
+		verbose(env, "verifier bug. Two map pointers in a timer helper\n");
+		return -EFAULT;
+	}
+
+	meta->map_uid =3D reg->map_uid;
+	meta->map_ptr =3D map;
+	return 0;
+}
+
 static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 			     struct bpf_call_arg_meta *meta)
 {
@@ -5677,6 +5726,7 @@ static const struct bpf_reg_types stack_ptr_types =3D=
 { .types =3D { PTR_TO_STACK }
 static const struct bpf_reg_types const_str_ptr_types =3D { .types =3D { P=
TR_TO_MAP_VALUE } };
 static const struct bpf_reg_types timer_types =3D { .types =3D { PTR_TO_MA=
P_VALUE } };
 static const struct bpf_reg_types kptr_types =3D { .types =3D { PTR_TO_MAP=
_VALUE } };
+static const struct bpf_reg_types delayed_work_types =3D { .types =3D { PT=
R_TO_MAP_VALUE } };
=20
 static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX=
] =3D {
 	[ARG_PTR_TO_MAP_KEY]		=3D &map_key_value_types,
@@ -5704,6 +5754,7 @@ static const struct bpf_reg_types *compatible_reg_typ=
es[__BPF_ARG_TYPE_MAX] =3D {
 	[ARG_PTR_TO_TIMER]		=3D &timer_types,
 	[ARG_PTR_TO_KPTR]		=3D &kptr_types,
 	[ARG_PTR_TO_DYNPTR]		=3D &stack_ptr_types,
+	[ARG_PTR_TO_DELAYED_WORK]	=3D &delayed_work_types,
 };
=20
 static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
@@ -6018,6 +6069,9 @@ static int check_func_arg(struct bpf_verifier_env *en=
v, u32 arg,
 	} else if (arg_type =3D=3D ARG_PTR_TO_TIMER) {
 		if (process_timer_func(env, regno, meta))
 			return -EACCES;
+	} else if (arg_type =3D=3D ARG_PTR_TO_DELAYED_WORK) {
+		if (process_delayed_work_func(env, regno, meta))
+			return -EACCES;
 	} else if (arg_type =3D=3D ARG_PTR_TO_FUNC) {
 		meta->subprogno =3D reg->subprogno;
 	} else if (base_type(arg_type) =3D=3D ARG_PTR_TO_MEM) {
@@ -6670,7 +6724,8 @@ static int __check_func_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn
=20
 	if (insn->code =3D=3D (BPF_JMP | BPF_CALL) &&
 	    insn->src_reg =3D=3D 0 &&
-	    insn->imm =3D=3D BPF_FUNC_timer_set_callback) {
+	    (insn->imm =3D=3D BPF_FUNC_timer_set_callback ||
+	     insn->imm =3D=3D BPF_FUNC_delayed_work_submit)) {
 		struct bpf_verifier_state *async_cb;
=20
 		/* there is no real recursion here. timer callbacks are async */
@@ -6898,6 +6953,30 @@ static int set_find_vma_callback_state(struct bpf_ve=
rifier_env *env,
 	return 0;
 }
=20
+static int set_delayed_work_callback_state(struct bpf_verifier_env *env,
+					   struct bpf_func_state *caller,
+					   struct bpf_func_state *callee,
+					   int insn_idx)
+{
+	/* bpf_delayed_work_submit(struct bpf_delayed_work *work,
+	 *  void *callback_fn, void *data, u64 flags);
+	 *
+	 * callback_fn(void *callback_ctx);
+	 */
+	callee->regs[BPF_REG_1].type =3D PTR_TO_MAP_VALUE;
+	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
+	callee->regs[BPF_REG_1].map_ptr =3D caller->regs[BPF_REG_3].map_ptr;
+
+	/* unused */
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_2]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+
+	callee->in_callback_fn =3D true;
+	return 0;
+}
+
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 {
 	struct bpf_verifier_state *state =3D env->cur_state;
@@ -7294,6 +7373,11 @@ static int check_helper_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn
 				reg_type_str(env, regs[BPF_REG_1].type));
 			return -EACCES;
 		}
+		break;
+	case BPF_FUNC_delayed_work_submit:
+		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
+					set_delayed_work_callback_state);
+		break;
 	}
=20
 	if (err)
@@ -7468,6 +7552,21 @@ static int check_helper_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn
 	if (func_id =3D=3D BPF_FUNC_get_stackid || func_id =3D=3D BPF_FUNC_get_st=
ack)
 		env->prog->call_get_stack =3D true;
=20
+	if (func_id =3D=3D BPF_FUNC_delayed_work_submit) {
+		struct bpf_delayed_irq_work *irq_work =3D kmalloc(
+			sizeof(struct bpf_delayed_irq_work), GFP_KERNEL);
+		if (!irq_work) {
+			verbose(env, "could not allocate irq_work");
+			return -ENOMEM;
+		}
+
+		init_llist_head(&irq_work->items);
+		irq_work->work =3D IRQ_WORK_INIT_HARD(&bpf_delayed_work_irq_work_cb);
+		irq_work->prog =3D env->prog;
+		env->prog->aux->irq_work =3D irq_work;
+	}
+
+
 	if (func_id =3D=3D BPF_FUNC_get_func_ip) {
 		if (check_get_func_ip(env))
 			return -ENOTSUPP;
@@ -14061,6 +14160,28 @@ static int do_misc_fixups(struct bpf_verifier_env =
*env)
 			goto patch_call_imm;
 		}
=20
+		if (insn->imm =3D=3D BPF_FUNC_delayed_work_submit) {
+			// Add aux as the 5th arg to delayed_work_submit
+			struct bpf_insn ld_addrs[2] =3D {
+				BPF_LD_IMM64(BPF_REG_5, (long)prog->aux),
+			};
+
+			insn_buf[0] =3D ld_addrs[0];
+			insn_buf[1] =3D ld_addrs[1];
+			insn_buf[2] =3D *insn;
+			cnt =3D 3;
+
+			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    +=3D cnt - 1;
+			env->prog =3D prog =3D new_prog;
+			insn      =3D new_prog->insnsi + i + delta;
+			goto patch_call_imm;
+		}
+
+
 		if (insn->imm =3D=3D BPF_FUNC_task_storage_get ||
 		    insn->imm =3D=3D BPF_FUNC_sk_storage_get ||
 		    insn->imm =3D=3D BPF_FUNC_inode_storage_get) {
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index a0ec321469bd..0dd43dc9f388 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -637,6 +637,7 @@ class PrinterHelpers(Printer):
             'struct bpf_dynptr',
             'struct iphdr',
             'struct ipv6hdr',
+            'struct bpf_delayed_work',
     ]
     known_types =3D {
             '...',
@@ -690,6 +691,7 @@ class PrinterHelpers(Printer):
             'struct bpf_dynptr',
             'struct iphdr',
             'struct ipv6hdr',
+            'struct bpf_delayed_work',
     }
     mapped_types =3D {
             'u8': '__u8',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.=
h
index d68fc4f472f1..461417159106 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5325,6 +5325,28 @@ union bpf_attr {
  *		**-EACCES** if the SYN cookie is not valid.
  *
  *		**-EPROTONOSUPPORT** if CONFIG_IPV6 is not builtin.
+ *
+ * long bpf_delayed_work_submit(struct bpf_delayed_work *work, void *cb, v=
oid *data, int flags)
+ *     Description
+ *             Submits a function to execute in a different context.
+ *
+ *             *work* must be a member in a map value.
+ *
+ *             *cb* function to call
+ *
+ *             *data* context to pass as sole argument to *cb*. Must be pa=
rt of
+ *             a map value or NULL.
+ *
+ *             *flags* must be BPF_DELAYED_WORK_IRQWORK
+ *     Return
+ *             0 when work is successfully submitted.
+ *
+ *             **-EINVAL** if *cb* is NULL
+ *
+ *             **-EOPNOTSUP** if called from an NMI handler on an
+ *             architecture without NMI-safe cmpxchg
+ *
+ *             **-EINVAL** if *work* is already in use
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5535,6 +5557,7 @@ union bpf_attr {
 	FN(tcp_raw_gen_syncookie_ipv6),	\
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
+	FN(delayed_work_submit),        \
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
@@ -6699,6 +6722,10 @@ struct bpf_delayed_work {
 	__u64 :64;
 } __attribute__((aligned(8)));
=20
+enum {
+	BPF_DELAYED_WORK_IRQWORK =3D (1UL << 0),
+};
+
 struct bpf_sysctl {
 	__u32	write;		/* Sysctl is being read (=3D 0) or written (=3D 1).
 				 * Allows 1,2,4-byte read, but no write.
--=20
2.36.1
