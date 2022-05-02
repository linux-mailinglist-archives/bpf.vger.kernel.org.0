Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C56517A7C
	for <lists+bpf@lfdr.de>; Tue,  3 May 2022 01:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiEBXNQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 May 2022 19:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiEBXNO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 May 2022 19:13:14 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097A92ED7E
        for <bpf@vger.kernel.org>; Mon,  2 May 2022 16:09:42 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242LsdoI001183
        for <bpf@vger.kernel.org>; Mon, 2 May 2022 16:09:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=/bQJZdrw6shcur37B7xG/iyZg9wSsyZ1GsCDoVWhVlw=;
 b=oS56sxmpWpsehBjfDsi4n7FNuIrRCCoSl081jbgq2aGRn8V4VtIFTs5g7v70n/zMKey2
 Wtzw1Sl++PKRqsCvrKnQJG845s9vq48K1V7Hm/k2hrPRlx4qoVcU7HepN3JbgCx8tkPN
 zxC0QfnTtzw11ghF2pb4Uqa5yYMktNhKAIw= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fs2mxchjh-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 02 May 2022 16:09:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uz2hqRdrjHXMlWkMmJmBv9gMGiDKHnWtph/6xBtS30RaTzRbFMJL37t5vaSxFlijLhvtJSip0dLlWl+eGNmhS1oPEFNQJUNPBGjIaYVNh1+DbYizDUrDr6K+buhzIT9ejvnV6X3nqk0BQBGt+tSWjUssFqb2QYzXLau40SC75Acce3J9srD/oWv8FHcNlWZwH6HLeebM3i8jGS8gGlA0sm/i7qs0/ZGCao+Hy9xYGgRo9faZNNig2Dnov6/iIgKPPl0xGk/JvmtAoBd8bZlV+cTWcrvIZgtCPuJ8QSoX1WrFvGzX5AlRepwxAAqijbD8cngj3mz/vpOfphRDiNo3AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bQJZdrw6shcur37B7xG/iyZg9wSsyZ1GsCDoVWhVlw=;
 b=caWXDTeTVIgiJBny/3MHQoeVIjMIftsAksu+cZuL6PsJUCKtQsIALeSIbeWtH4X7QZ6hnoXH66RBUj3PHkQT5T6deHrGdm05S0iONLERDxRx7AtyKAXvd2PKd6tuq+2w1dD/FVCAF2lxgwvwLGwt4UxgaFAIw56+/StPxaFXR+v/tY4ctkARqnfUFIr16HQmVnPsREJB1F9EN7OO6oPKuNDSlWiSaKYJ3qsxpxNgRGMURfSx9h1ZHpA2eCuEktWBbYmcJ7LBDKBWaKi00GDHmehspmfBxrIv/mbw+rRcZVWzotK1/BtxTHtqcvIl3RpqHnoQMsXHpx0e1zsIJR++QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BYAPR15MB3141.namprd15.prod.outlook.com (2603:10b6:a03:f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Mon, 2 May
 2022 23:09:38 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%5]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 23:09:38 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v2 1/5] bpf: move bpf_prog to bpf.h
Thread-Topic: [PATCH bpf-next v2 1/5] bpf: move bpf_prog to bpf.h
Thread-Index: AQHYXnmyxbkRSEhIiESP57CBJDNDWA==
Date:   Mon, 2 May 2022 23:09:38 +0000
Message-ID: <616c50d61de26eacd49fbb641d3122a85ca478fc.1651532419.git.delyank@fb.com>
References: <cover.1651532419.git.delyank@fb.com>
In-Reply-To: <cover.1651532419.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 772246e4-fb78-4728-c944-08da2c90d4db
x-ms-traffictypediagnostic: BYAPR15MB3141:EE_
x-microsoft-antispam-prvs: <BYAPR15MB3141DB0F5976932F4DFB9418C1C19@BYAPR15MB3141.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xr0yAaPTa7VSwteiZRb0ntC4Mm8+3tBruPNbEVHGk7V/4dDkSLytKX6Iv038ndq0hY7a8fpj+xx5brAxXqk/RPOfIXkCZLQGBwoMKN7v36cXBPNfJU9h/4+Gi2Ovhq9HC5qJL9ZwN5K9tWJ2+84WfwiHin+HarDfy9qr/UtGuMg4muUL1KBZzjiJAAEWUyVRLIOLcNuPRZJzBHGO4iEmpq1uVS4xy0d8dXoKffWm5ZFS1w63sdU8NnuElbqxpQbxu9yE6ts4QXELRKmJfC2UCGJriBHNCZp7H/wdxYEX9dEjsl51q8SFmbqtn0sZm5mT+eHpMiC3roS9LPe3OVcqin+o3vSAodqVuarHltJb0AC53iHO0xp37XTyMdFLR39zFx8Ra3lXEjkJvPYsrKo/3IQWlCWZAl7ygulaQandsojQEMfYqgQT+AUzzJTvIkxLwL3ac8Q9Gvy1urkAbTGF7WkJpepJ0piFNHTR9O+IcASyM0XKu6zAHMsYIdyxEQ8binRNDT4oQo2kwqbU1FKd0PN6pc4GYjEJHmSp6bBvzOP4dybMcfLTdI5eJTnsR993HQ6qoMdiF4QXTc2l5wYm0rW//My/8VAn8JhYkepPl3rkY7tGMeH3zMidYkFoyocY1FUdDDvCIpJ6ne5ykOBIXRwZkVAoCarQYknEgUSYZScFQKF/rBTT18Dzn3/Gfd5wyToxaNFBBjhki4lKx5zARw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(122000001)(186003)(110136005)(38100700002)(6506007)(38070700005)(5660300002)(316002)(64756008)(76116006)(66946007)(83380400001)(8676002)(66476007)(8936002)(66446008)(66556008)(71200400001)(86362001)(508600001)(2906002)(2616005)(6486002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YCXYObt6xkFlmQv5oeZIlaidXQTuwH9Be3mS4OhPnz8omYx07jS07ZSnwW?=
 =?iso-8859-1?Q?sCdvx3Es05bmm3L24tOcRphf5f03NamD8MiOqSkO99SFDW5DMcYNiRU0jv?=
 =?iso-8859-1?Q?RREWvE7U85Vyf2EddIvJir6wZK9rJx4lHV8sr9uNwEZH5CixtGcVK9FF1J?=
 =?iso-8859-1?Q?O442XQ5+ni6g5WMU98aI5w/ITxxOgROYmXAllnicBR88eIlp5WD6Hts1ZC?=
 =?iso-8859-1?Q?zw9PH15qwRuW947ANfzt4H2laAdld3UNi/zJuo6/fuRiXlzlJXeUSCPHg4?=
 =?iso-8859-1?Q?RfCPG1SUWkH2CTRnNbUZgXEpYqHcGRaRAnN3MQC464hzHkASL1OhL/Df1a?=
 =?iso-8859-1?Q?YuURhI9kxXUUqtQSliBhqIANaduVONnx1fZ/FHDo0IaRDt/yO8Xw/l3BKl?=
 =?iso-8859-1?Q?NOs6Mz8Nag1CBgESmFkRvT8GDyxR/CBHTMNyge390vI49/P6clov7gMyYn?=
 =?iso-8859-1?Q?vQ+kOC767H2YfaT7OJz+w8NIwpB6pcJv/wCsMotMqLihuOoe/Jf8ubBEGL?=
 =?iso-8859-1?Q?/OdbhB7LtRc3GuVJkaDhoVT0pHQUo/fIdgMnEzqefbIWyPl/uafbrg3qSR?=
 =?iso-8859-1?Q?ZbTC4Klek9Fqp7GMPXjuFx4hG+Odp/TKgt7YSewuGwX6KwoWW//MU23cKo?=
 =?iso-8859-1?Q?Yyr4S+4/kQemZ9gf9T5RLQXlYZhuUQs5pwr5rO1YA68qFC+Yitvi8mUeqy?=
 =?iso-8859-1?Q?ruJ7uqPIa0iQO/IqYkMEh7/oH0dGqijfbuc8U6+7BRFqk/wykY6NbnW2kP?=
 =?iso-8859-1?Q?cYyA0i8ryXc11/fKO7yPfDfer8sM0PIYBCRfC6Kn3O1NUwSNwcvqx6awfL?=
 =?iso-8859-1?Q?YQiorQqASnFhskgTgIgqRKm5WRB0ZfhvH8l1YJeBs6G/ddYKS+ao2FDaGa?=
 =?iso-8859-1?Q?HoTuEVs3BbL1BK9OQOtNY/ZDdeVjkIS5cuTej19a/9B411XIx8Pn+E1WRs?=
 =?iso-8859-1?Q?vucZHpJFscAJMYmO30BJMXyjiNUmPECAsSziQKjbrQ+ANbpIH5DZInoq/t?=
 =?iso-8859-1?Q?YKxioH5/T9g5kDkDbuOOqKv3HqQ4O0KMuhE/YXs+OYXQheUt3ULp2IGfNK?=
 =?iso-8859-1?Q?+BejMRGZBBWMHRGyeR/IOiV/Y926jqJSEg8nWMCzRfGbNXJBU48+WKlSpv?=
 =?iso-8859-1?Q?T5AU+H8F7xfbNboBuic/O5sODyTVxViXS6YQFjinAxxeyQH8H8RutdwI3S?=
 =?iso-8859-1?Q?ORsHyYX2eKapi0ZVdrEMlstFzMxrF1kao+V9cG+3WINLnYnrnbxwMUjvKJ?=
 =?iso-8859-1?Q?bmIX7052LZqhmGBOI3WympWVJqVF122kWssyxJAXsl/kXJHjz2wTq59+48?=
 =?iso-8859-1?Q?YnRPZtteSt/Fk2K/o40tv4lehzH0pzwpRiTUrgaVko/5ZTRz3DUiu99HLm?=
 =?iso-8859-1?Q?0DnLJfaoTD4Q5/4zdvPfvLgn2yaOVtEg7Yy4ljuQjcztYoYFvc6LULeKXy?=
 =?iso-8859-1?Q?xfR2iTAa0Ibm6m+ezVno7Twy8Bg4OSJQj2e1fzPJRLVXMdxAuS3PVJJLOO?=
 =?iso-8859-1?Q?C2dWkUO2XmoxtNq9mzH53NHzbZP4tVgbNuQVdE0/G4DlnJt+J8PoFjYd/t?=
 =?iso-8859-1?Q?zjVMPUpfD9Lk3f9NjTj7xiWPhDPluq8YEk2VGQcumLnOP+HROcLGmaKmh9?=
 =?iso-8859-1?Q?ST3FqTcEoFrpcUispj8XyZV1BMC4lgBk+NE3Jf1Z/M/m7/DQC5won9c1Mi?=
 =?iso-8859-1?Q?idvO0aRlAEH9lWz5AUTYQ+r6oOpHFnFVjgNv1dvd9GYPUnjrpvIgnrCntn?=
 =?iso-8859-1?Q?QJaPNwMwPzgQ2xuhCTi1SHcslZ5FZDiIsKrFqRmL6vgR3wzOFGX+alq4RU?=
 =?iso-8859-1?Q?BSO7AEY5YeCSjV6VXQvAo6SVoA/8hyVpMXWywerw8wsST+XhUSG9?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772246e4-fb78-4728-c944-08da2c90d4db
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 23:09:38.2558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AuBN7Rx7No2BypH+tlG0nz7YYRx731ysojIA0ZqwIYQKzaZmMMtFxh0AMgA7A6Uh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3141
X-Proofpoint-GUID: wqsiyyZVfBdfMVLUhCZ7GVV2VIUBNnj6
X-Proofpoint-ORIG-GUID: wqsiyyZVfBdfMVLUhCZ7GVV2VIUBNnj6
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

In order to add a version of bpf_prog_run_array which accesses the
bpf_prog->aux member, we need bpf_prog to be more than a forward
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
index be94833d390a..57ec619cf729 100644
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
@@ -1068,6 +1070,40 @@ struct bpf_prog_aux {
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
2.35.1
