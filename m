Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B395454BE2F
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 01:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiFNXKw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jun 2022 19:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239660AbiFNXKv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jun 2022 19:10:51 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9543352E55
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 16:10:47 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EMd1rW002772
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 16:10:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GMdUAw8wuRykvY/1Ylxh/osEmvf28cBu/w57NOBRb3U=;
 b=PmzP1iAhB+zSznDvQmP/SyE76apOyHWT9rcoBB2t2RgXjEujPwoec74N3/UqU+q+mU3X
 Mqqbzwp5T1xFH0oQPR8urwb1rbuOopsozMLHlT1C6DAFXmnAE+gQhHXkObkv+O7uuNkA
 Ui90oyO6y3/t1+xuNKhV1sQfHUQ5lB8jmnQ= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gp8aw1uet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 16:10:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVzhhyHykRk2QYyGf+maUPIvAS/yPyJKMqDH3J4DbZdkK1SqM2XawH9OYxNKMV3nI8ZWg8JGGhfCpD/9aMGg7fKU8Wyx78b96IHYrqzZM/Vvv3hD/QzFhv8613HcdGHEr4xcqAKQWbriIdofvd1ip6yTBsBMxSB5eX7iMDakWNcT96J9g+ifFFxdwPGiCG7EAgMoaLRE1BzIO+4nuJXCAbfZxGJqsApfRt4i3sLlxw+/84P9f9oKZLyO58F/nPwL1Upd0OVxHmPJNnMOJaw+tql724Yf/all6XhVWC8zEr53b8YQhRWTM+5N74W88XKUarMXRjcbJSsg/VXluxf5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMdUAw8wuRykvY/1Ylxh/osEmvf28cBu/w57NOBRb3U=;
 b=hUOfbDLEtiCXao04pCFuqt0usk1Nw//5rn95+dSGSLsq6ciNpUs5O0xVsrYDYTxCShii/BX5S5Cj9FE2Yir7tBW9NL8kg2//SPVq/t4wf9KNIOzlpAHdYQnj9Pvh2eE0IDo2JT5kDtZ7Qdtl7Z9NFlHY0FDE76+CSYfdnEe0vsA1aJV7hT2OtSN6cPnuAg75yvuPjPYqwizolT5ozgh0f1I4N/fHx7BRMU5T54tWHlQ2us1tB/J5oy3SgZzk35wqA+u3YHodRc5v7FBRLQnezKYgQ44sWpB8TfYkl9hCMNCxswTM0U/d3wVLHGFAMqvIfRRtYsUVFnfre7V4tf0CcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MW5PR15MB5220.namprd15.prod.outlook.com (2603:10b6:303:1a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 23:10:43 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::8910:e73d:9868:600b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::8910:e73d:9868:600b%9]) with mapi id 15.20.5332.016; Tue, 14 Jun 2022
 23:10:42 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v4 1/5] bpf: move bpf_prog to bpf.h
Thread-Topic: [PATCH bpf-next v4 1/5] bpf: move bpf_prog to bpf.h
Thread-Index: AQHYgEP46wQKNvzaCkWGNLX/L1XEsA==
Date:   Tue, 14 Jun 2022 23:10:42 +0000
Message-ID: <3ed7824e3948f22d84583649ccac0ff0d38b6b58.1655248076.git.delyank@fb.com>
References: <cover.1655248075.git.delyank@fb.com>
In-Reply-To: <cover.1655248075.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 193da1b8-9bc9-4792-792a-08da4e5b1afe
x-ms-traffictypediagnostic: MW5PR15MB5220:EE_
x-microsoft-antispam-prvs: <MW5PR15MB5220B9BE8EAB6D027035C53EC1AA9@MW5PR15MB5220.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p4vEF2ETX5UtbxxZTmqe0Y/RdPxDFGqbIdjGnihq20F5jdJD3DrVfGReCvJo/6l100CUve8i0Urt+L5V4ncjaHexZWyyFFrFiOu3AFf34oVd9PfNeCbh6yR7GbHv5D2WaBthEuPjYHeM6LNQIEm+5N+QVrSVxMNmKqJhAVj2uXAtCfDyBu6k3fFPMLxfFA70qVLGnaNurS/Vu1iSHxxw4V9NcOS4SdDEJZjLfCYBn+VbDlrxbEnkbBRuhumikViFSAUqk6YosYX+lUIxP+TZZ5gHsvxDJE1X8PSSB1UrHqeNaRQcibpQoDz1M4cRUSjvCn3WrrJtYk4KmSpsEUuk0O0f75ftWp4tRgxfyCdV4PrS1CYYGlZ9NgVJvuX52c0xJ0TaHjiLrXFIk7qqYaWOYvQIdhiaN3SMfwcYb++/JT89XUJpPhboMeS+TIZzzwoyN3nxJKqzw6IdLtvhXfmfJ1tbPxqhtsXzmF4bLpxLYgeW5Qzfr2Q1WGly/kzrvsy8Vu7lu020GXvvsGnzWzpqH6h5LNmcVqlGx+yzE8dmSOJAj7Vm8OA1pusQJbbZXb1KaF8DtZA+CChui1DfbW3drnnmCcST2GJt7f2Hb1D+Qj6dT3UjkHLXs1d9dIFJEhYhT5ovKgXozCk6YY/5LhLLhjnrFfuJadSTxS1yKiRxPeELH4kSD8oQX7O/lQ5qYx8hg9lpeR+6r63pE1awB+wVDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(186003)(8936002)(5660300002)(122000001)(38100700002)(83380400001)(6506007)(6486002)(36756003)(508600001)(38070700005)(6512007)(71200400001)(66946007)(316002)(66476007)(2616005)(2906002)(64756008)(66446008)(76116006)(8676002)(91956017)(66556008)(86362001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ef/wOsMeJ6BrtU2PUZxlOiC2pnxSyFYxM3k10urEpvPCLwRRbo2oCL1X8H?=
 =?iso-8859-1?Q?dOoiiozYVGWMKblUk1MdvQkosAVZOhTtM/QrOSZRGPnqGjSrpBw4S0AnC9?=
 =?iso-8859-1?Q?ecscBlweKD9PNfeavFILd/76vyY3Jl3fTBTwTTiKpbY3lsfufDFAn1VH50?=
 =?iso-8859-1?Q?tnKvp8T06/K7caefzSCqtgtxzrjQyzd6LfGAA2hv8N1ta6soRz6tPOX5JR?=
 =?iso-8859-1?Q?KWehWm29FNww0Gdv3WhLXq+T50KOEyM9lgA+l9gGLgm4bMkTRHZhyJkRB7?=
 =?iso-8859-1?Q?dvAT3cK57nH/pDsvDm7fWU70Pcl6sl2rk73d0AlwfrvTSh0gX/6pczCS1S?=
 =?iso-8859-1?Q?oWXnVMFaeKhi01GW13JA9yldwiBAxnrtEEMcNLUr2jF2vWjXOQIO0rscs6?=
 =?iso-8859-1?Q?7AHGb5VPW0bfHFct3y7XMk7lSABKKn5Nt6UwludCYijWnoUFNvoLL7rNOh?=
 =?iso-8859-1?Q?1Ju+FLXQRcsCo92KcMXrz7UsJuq2UYDLR6Fe9wNjvst9WCBjKyQkB96XAe?=
 =?iso-8859-1?Q?AFnbNBH93UGDRNWVcSh3oODL6pKx0Vh6/FO4S2BqIMT3RHJ3SzNHKlrhvH?=
 =?iso-8859-1?Q?oxBSGJwgZyppSIWNpMqe1lx8H+6a+9FppW//qtCQ7qaGuKesWRznFVlsGv?=
 =?iso-8859-1?Q?H0s1KB/d7x1UY4TrgI1curLezk5qN6+ZOo76dBH6Lx0a/UACtXzcV9HfA6?=
 =?iso-8859-1?Q?ABn/haklUXrczo6QPXRMnOm/GCilwAXacQe4q2NuHhXZxb/hwmbPIlK58E?=
 =?iso-8859-1?Q?hdOj25Mm2yZwE2D1fHT9BoUq/mM6KV5vsqLkbh/DhKnz3lxMG9lAUFQwgI?=
 =?iso-8859-1?Q?TWpEHsJ1NMgkR2rssWXLQPZQEFqPK5XKS9lT4WAGkGyUYTfBGXBz+fhcwe?=
 =?iso-8859-1?Q?OznOOONycj8x6oWzWBH1ow9iGOXJm/EW8192SBaHc2+pK71H+8Tm6FBTqD?=
 =?iso-8859-1?Q?fBSDDTxbsLcT6wuxyc5f+Tb5oBipqXnDJPqFqjFqjA9MWrNNJpRgEn31Mk?=
 =?iso-8859-1?Q?cB0TmOTq1rWXmhegTcKS5JxleGcMzT0PPhQxfyJFD85jCxeLeHm44AI71w?=
 =?iso-8859-1?Q?rQawYK0H6G2xhUgcneUlvZfuMgll2nEqn6bHGCfao7L4c2HmnQR7ffcJDv?=
 =?iso-8859-1?Q?p3nsb06qjqy3N1czuJ8J1WIo8S1TQUkdAbFk4IrEu0Yk/TF+pNqXKlhbku?=
 =?iso-8859-1?Q?e55FQMLzuCDBRzK0OKsi4LZwM10/8uMRytIO/bA231glJr2oC64rxvv7wm?=
 =?iso-8859-1?Q?UsxZ1Ii54lCHTc4LrggF9EcWA/98UZujGouSawKglHww05fQDxKi/gFwdp?=
 =?iso-8859-1?Q?fsnj4YrICvZbd46tSTtvIWTYhoe+kaMabFQLPA3SbLbNZRzC5elJVG9Bol?=
 =?iso-8859-1?Q?x5l07DtUBd7gcuB7aR3YQTMAkt0ONEdRh/krqKAFIhWIt1L1Ky+5A9Lg+f?=
 =?iso-8859-1?Q?Kb5RAvDx1v1FevNia69xiFZqe35lp3NaA462PvovOvat6GiHd+NgKPmYct?=
 =?iso-8859-1?Q?xGPZivq0lef33GhUe8pJozvtLSvMYiW7EzbrB/mOdOBbpT2DFUdlb/SNYl?=
 =?iso-8859-1?Q?miO10nC0BfA3Tvvu4T/AfmER/wbVcpvGDIEbS5Nmqc+egPQpHd5Nqy9oSC?=
 =?iso-8859-1?Q?xoCrxbSkBOSWE4A6yz/Gqc0brWnwjdRJZLStSqWJ/+Z4XmCeJxo/wgCV7f?=
 =?iso-8859-1?Q?xLjVP+VVGpZi8XaJkD6KZzKeofPjK3rpPabVeznEwWbnPZCVyKqtxkGza+?=
 =?iso-8859-1?Q?VXy8h0f4cMoywPNT6vhR4HnqEitQTjVGZ6m5XD8sb64gfAIsdp8su7R9B5?=
 =?iso-8859-1?Q?LsIYsyt7IOaxEkyQbqDwzv8noDtQXH1TBkfv0GZN8Mleki6PJRLX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 193da1b8-9bc9-4792-792a-08da4e5b1afe
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 23:10:42.7909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6hG/mL60f6L97dO7RRMu1AjmPjiyIost7br9tLKCUtPNGkuG69bOxx58yfu6DWql
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5220
X-Proofpoint-GUID: 07wj0KUjo4ZkBvokf6IWrD5VBr9F81Zp
X-Proofpoint-ORIG-GUID: 07wj0KUjo4ZkBvokf6IWrD5VBr9F81Zp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_10,2022-06-13_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In order to add a version of bpf_prog_run_array which accesses the
bpf_prog->aux member, bpf_prog needs to be more than a forward
declaration inside bpf.h.

Given that filter.h already includes bpf.h, this merely reorders
the type declarations for filter.h users. bpf.h users now have access to
bpf_prog internals.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 include/linux/bpf.h    | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/filter.h | 34 ----------------------------------
 2 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8e6092d0ea95..69106ae46464 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -5,6 +5,7 @@
 #define _LINUX_BPF_H 1
=20
 #include <uapi/linux/bpf.h>
+#include <uapi/linux/filter.h>
=20
 #include <linux/workqueue.h>
 #include <linux/file.h>
@@ -22,6 +23,7 @@
 #include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/percpu-refcount.h>
+#include <linux/stddef.h>
 #include <linux/bpfptr.h>
 #include <linux/btf.h>
=20
@@ -1084,6 +1086,40 @@ struct bpf_prog_aux {
 	};
 };
=20
+struct bpf_prog {
+	u16			pages;		/* Number of allocated pages */
+	u16			jited:1,	/* Is our filter JIT'ed? */
+				jit_requested:1,/* archs need to JIT the prog */
+				gpl_compatible:1, /* Is filter GPL compatible? */
+				cb_access:1,	/* Is control block accessed? */
+				dst_needed:1,	/* Do we need dst entry? */
+				blinding_requested:1, /* needs constant blinding */
+				blinded:1,	/* Was blinded */
+				is_func:1,	/* program is a bpf function */
+				kprobe_override:1, /* Do we override a kprobe? */
+				has_callchain_buf:1, /* callchain buffer allocated? */
+				enforce_expected_attach_type:1, /* Enforce expected_attach_type checki=
ng at attach time */
+				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() *=
/
+				call_get_func_ip:1, /* Do we call get_func_ip() */
+				tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
+	enum bpf_prog_type	type;		/* Type of BPF program */
+	enum bpf_attach_type	expected_attach_type; /* For some prog types */
+	u32			len;		/* Number of filter blocks */
+	u32			jited_len;	/* Size of jited insns in bytes */
+	u8			tag[BPF_TAG_SIZE];
+	struct bpf_prog_stats __percpu *stats;
+	int __percpu		*active;
+	unsigned int		(*bpf_func)(const void *ctx,
+					    const struct bpf_insn *insn);
+	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
+	struct sock_fprog_kern	*orig_prog;	/* Original BPF program */
+	/* Instructions for interpreter */
+	union {
+		DECLARE_FLEX_ARRAY(struct sock_filter, insns);
+		DECLARE_FLEX_ARRAY(struct bpf_insn, insnsi);
+	};
+};
+
 struct bpf_array_aux {
 	/* Programs with direct jumps into programs part of this array. */
 	struct list_head poke_progs;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index ed0c0ff42ad5..d0cbb31b1b4d 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -559,40 +559,6 @@ struct bpf_prog_stats {
 	struct u64_stats_sync syncp;
 } __aligned(2 * sizeof(u64));
=20
-struct bpf_prog {
-	u16			pages;		/* Number of allocated pages */
-	u16			jited:1,	/* Is our filter JIT'ed? */
-				jit_requested:1,/* archs need to JIT the prog */
-				gpl_compatible:1, /* Is filter GPL compatible? */
-				cb_access:1,	/* Is control block accessed? */
-				dst_needed:1,	/* Do we need dst entry? */
-				blinding_requested:1, /* needs constant blinding */
-				blinded:1,	/* Was blinded */
-				is_func:1,	/* program is a bpf function */
-				kprobe_override:1, /* Do we override a kprobe? */
-				has_callchain_buf:1, /* callchain buffer allocated? */
-				enforce_expected_attach_type:1, /* Enforce expected_attach_type checki=
ng at attach time */
-				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() *=
/
-				call_get_func_ip:1, /* Do we call get_func_ip() */
-				tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
-	enum bpf_prog_type	type;		/* Type of BPF program */
-	enum bpf_attach_type	expected_attach_type; /* For some prog types */
-	u32			len;		/* Number of filter blocks */
-	u32			jited_len;	/* Size of jited insns in bytes */
-	u8			tag[BPF_TAG_SIZE];
-	struct bpf_prog_stats __percpu *stats;
-	int __percpu		*active;
-	unsigned int		(*bpf_func)(const void *ctx,
-					    const struct bpf_insn *insn);
-	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
-	struct sock_fprog_kern	*orig_prog;	/* Original BPF program */
-	/* Instructions for interpreter */
-	union {
-		DECLARE_FLEX_ARRAY(struct sock_filter, insns);
-		DECLARE_FLEX_ARRAY(struct bpf_insn, insnsi);
-	};
-};
-
 struct sk_filter {
 	refcount_t	refcnt;
 	struct rcu_head	rcu;
--=20
2.36.1
