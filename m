Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDFE525957
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 03:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376297AbiEMBWq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 21:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359866AbiEMBWn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 21:22:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32375468A
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:41 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CNMMKP023307
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=M9Q/n+Ot9L1GEPwpFHfJyKZAmawudyNltWLxg/yWo7M=;
 b=iUCZNgOTWz30tPudgtPmT36udOaQBs7JLvx9L2sBfy6UKMJLKUTng14jH+rn7Ea4M6uF
 DemI21dKVqEJPNroTV5Z9/bODusn6iwss0eOTFJk+6Hbfm1/qFuzB8TIKwxhfA2eDab/
 baSKRSSkz7GZydvELivlbRMCeN70HSqaCWw= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g17vytvss-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXKotopHq3UH7/XYFrPsVhoiTUtv/Zem4EhmSBsTnJfH0jKATdgYnIstdXlc6hQ+wSRJOQIsBxYmyyi1F54yZsK2owNkBAMYnC8mldo+iWFjNVbs/RnDJnYhuWCFCQ0CwuT3TGW4nODi2A5flYlO2PMSum/pWm0ZDB7Pq00mp27Fuz/nrB1vLXIVKzdfNKqPu2yp+HWJEVe8eCvtUhWIHHEUFXLgF84boQGsycaqt8BOePK9LQrAVlbha5hJULmQhI+/iROGsMDEFI2oQ8GBLNJMhAlFO42I6r/Uk2iVUB97dDcNP59EjURMvBhA0RPmMI0GxRhSJ16OnGTGFIXLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9Q/n+Ot9L1GEPwpFHfJyKZAmawudyNltWLxg/yWo7M=;
 b=ngcONoFOeh0gxEnefeOjzqKEp2+ImWgGZ/I+glK2c2+8YMNXMf5AvaJGpHGNGteLJEkAhlVbLHpnFmgpDr98r9jvoMy2rBuvNZmij1+hDml/I22TvJu5wkobbEB5U4+gKr6rhLqkEvkEMhZUlt7FkuZ+x/eRSeAxVrs7G8Nj7XGJwg/p1yxfJ0I9r8YksVLxVhRHmNNdV53SvQ3uI+ujOMFxxMwVxTJb7TxObIWBPtHFmKh4buUH9NI3eOgMaH/gwfcRQb1uYhTqzwPHErAQ0HxO6+LJaL6pjhMu9KcE1LtnXHHVVudksjjhdM9ziuJN1CslDciss/uun94wbmVzUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM5PR15MB1610.namprd15.prod.outlook.com (2603:10b6:3:127::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 01:22:38 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%4]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 01:22:38 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v3 1/5] bpf: move bpf_prog to bpf.h
Thread-Topic: [PATCH bpf-next v3 1/5] bpf: move bpf_prog to bpf.h
Thread-Index: AQHYZmfu2xlqSOScpkSeB2xmTf4Fhw==
Date:   Fri, 13 May 2022 01:22:38 +0000
Message-ID: <529c88e0c8438db4bfd9768ed5d1fee508fabbfb.1652404870.git.delyank@fb.com>
References: <cover.1652404870.git.delyank@fb.com>
In-Reply-To: <cover.1652404870.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b20caa63-70f8-4585-445d-08da347f1188
x-ms-traffictypediagnostic: DM5PR15MB1610:EE_
x-microsoft-antispam-prvs: <DM5PR15MB16108EA5A8C721E146A9C303C1CA9@DM5PR15MB1610.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +9Gi6mP1W7sCsqvE+uNMkBd+8xU4sStfGbs9w5o7h0ARPszehHWNjhPR3as6Kixo7yz18+CJSJbKyykd1KparAaVFNDmOyIgSh/pe9sJlioT85Bmt39pbh14UvyZ77ysis/HhnH34Szcza4uMICfSZawCGcYNDz/xE72RmQiby4en0a2zhLzAW2SwQbVODrojRtZ9uYXOMMlnzepXrpt4H4enNh2OnO5w8M55+cJvz9YMy8IA4/odYsEj/ytSGneDwTYNGgCjiNZLnd3l46kUGogYrFNFzKKahhWFrAfX4M1mSZKXTFuVR2Pc5yIOLkwFgzl+x4U9j7s6f1lNfv8Q3sTm6uIqzDmGQADXWTM8t4pCeXeIIZfGOaqJIwpJgFPxDHpL7EHaQvSDHVlfRSBRu9xNss07pO+wrOWcfxjguPhtnuG4G+SOoTeKOs+L+J4mKy3wAMoFb8reeCwOKy+Ly928Sgvb6KiRY0/Ic6mx9eowt2BOPJvEph+/Tobnoa3KcPHHWSQmuH/d7WRTpnnwaz+eetou6frf1bVy6kIHERkQj9SFvDUcxK99H0b83UxBqz/CTzlzEkh29bt0PuE08bGKPUUhxlQ1ov/euL2l779PwekxW7l5miuuTKBoUM4ftERKcgff6umv9yLKNbzvCdVb8i2vVUcjypMjbz396MhmuBzZ52FAq6K4fKhluMauWH7l9HMq42VUy50IdHKWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(110136005)(2906002)(66446008)(6512007)(5660300002)(38100700002)(38070700005)(8936002)(508600001)(91956017)(2616005)(76116006)(66556008)(66946007)(66476007)(36756003)(186003)(316002)(8676002)(86362001)(71200400001)(6506007)(122000001)(6486002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0eqRivG5h3BFzkmMiJ+fqG9fuMRPyL7zljvom3FJUl1x7kDSn8ekkKRucV?=
 =?iso-8859-1?Q?pPZGXBpKFdP+86W48MBKddDYoz1ryT+RrabpGOTwg++e5ZJ/S0d3m28AzV?=
 =?iso-8859-1?Q?dlnDNaDeCzomgQikINOmDcSDIH5lzu78A9f8rCYlPgzJl5bUGUzPPpDqnp?=
 =?iso-8859-1?Q?xXIGIG37bcNynape7H+NV5xmuiXPRNazOwSK0iQUnHQF7Ft8wJQXAh4BAR?=
 =?iso-8859-1?Q?AlSgvICuuTA7DI8XRN3eFqfp6LVH9EE7nwWY+oItKDwDiLR9Lm+pWsz+mD?=
 =?iso-8859-1?Q?udTmahXfj2ZL9hyhTkWwNIq4E0vRnKcjJCTwz/uALadgCZ2iBxiKN4IT88?=
 =?iso-8859-1?Q?YrpOUe6QiNjy1I/m+PAZtscN1EYC4jYahdJMdUogwEPN01PaJgZExwy569?=
 =?iso-8859-1?Q?i8CtR1i4gIpkfa4jE8HS2EtwL7HX6XZXqWZMCQgE9MyvDNklRyeQyKP6mV?=
 =?iso-8859-1?Q?+h12j0Dnlpxen5xQaflEgEa/SWrfVO8ZAV2zfZ5Z4N9TM03ZMI6Y5IkF2V?=
 =?iso-8859-1?Q?sZKpUN8IZQWEXw8HSQX+pIV1cr+zu/JmNRT8+fI/XUyy1ProzuBaJviy8G?=
 =?iso-8859-1?Q?0S+RFE7698OSEmMMSHYE9+w4DoGa+nQsXlTo1KYOihVVXYiMUQYjad22DF?=
 =?iso-8859-1?Q?LvrQaMyX1j9WfJ8YMdK8ZqphAXE/rnmm6qz9loBxueKVAlnxBxkE2dc141?=
 =?iso-8859-1?Q?XSI9zyyz0RIgqQRmHA/O7Vfa+N3mQENrw/rgoy6oCFK72r9vDYNvmceaov?=
 =?iso-8859-1?Q?64LPws0dWNjYtHjPe9zahF8bRTCB+O+gJcoabPQFjNwfnde+mtJJzo6gzS?=
 =?iso-8859-1?Q?rTlfuz2kPjtE2CLrnHEd/3SJLXX0Hncpxzelggb9Qu4LRYTw795jmHsWw9?=
 =?iso-8859-1?Q?m9z+9q5Dy/+EZ8rH+XC+RnwUBth92MF/BW4EhSmrpEStYT8IoxJag/KXDT?=
 =?iso-8859-1?Q?5++v0RlwIfCDPS5sWsQSwCpUNWNMb326V2kbiEYrP/7A1O80XMDTvEhU9z?=
 =?iso-8859-1?Q?Pk+Xt2W4pgLX+TAk4LX0szJzRrp3Q6BJSkSbtR8wd8ZIo2jSwFUKVH/yiw?=
 =?iso-8859-1?Q?T7vPFiot2hpLofzhSZENgZPZv8Nssh39n8sQGLGUt/VrQPyY6VXI9gOD2m?=
 =?iso-8859-1?Q?bifEfIpBHjfZSO8oOSTwBVpZH84nIhwluLD86AMXsG5ZeIeygQb5jFGTqE?=
 =?iso-8859-1?Q?WKEs7aENZEObgyqqSQtgGpgqRBqAsgu88ByBZsqewHTXzGRq133edhT/2r?=
 =?iso-8859-1?Q?IquvwexrsOZ01bBwSicauj59uSe4hnq75OO068uzJienskZ7fZrjNc3hHc?=
 =?iso-8859-1?Q?LJ7aGPkzjEUYAfYvmGAuz11OuQgWbkA12+nWOOn9Ac2n1g7u9kGmFV+CzC?=
 =?iso-8859-1?Q?BcxM8uiGtmvcKtaP8jj0NnbzyyNbqwpMFFk5JJN4XA0YJtmTtJDjmsiOAN?=
 =?iso-8859-1?Q?yvesd2yjZ+6iXSKT1K8TmhkgEl2YzWd5apx7k35Q6gEOfZ/Lk44pSKPzDX?=
 =?iso-8859-1?Q?cvGu/4TMj0RQ3GnP5x5npxtHsF5jWWVsRRWs6q830O3Vw3fVm3WGEMWrHd?=
 =?iso-8859-1?Q?YgAF+4Zab/l0+Aw9CmMLbjveZzUDyzCnqW/Ck5nTvK8IrVbY9kHXUas8+P?=
 =?iso-8859-1?Q?YLblemkTHrVvJ7gNo44Po4dOw9RlDUWHWhfIN+cg38j17uQN+eTQty5xh4?=
 =?iso-8859-1?Q?dWCafwO8yRDdOqCmL/bJGT9HwumpqRedzzsdbeoVWuIHlr1v/fhGaAtzEV?=
 =?iso-8859-1?Q?J9kdQYrs2b120WpFm22HZGGRhavKGX40UxZmO8M6DuG2GHxCtKeyBlOB3G?=
 =?iso-8859-1?Q?puJ6n6sNnqoRW2crwuM7SkMmFm/NWQq7FxeOegUwZ+kGqUkcyKeX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20caa63-70f8-4585-445d-08da347f1188
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 01:22:38.3950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NsJ5T40SiI5S7YuQVIlmwcyz3tYbRJ75PjtZFGohYa+pdBrs8cHI+ohEC3YZed6C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1610
X-Proofpoint-ORIG-GUID: 3AteVasVSJJcqnqbnw_UAcuMOjLhkAQz
X-Proofpoint-GUID: 3AteVasVSJJcqnqbnw_UAcuMOjLhkAQz
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
index 5061ccd8b2dc..b67893b47da4 100644
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
@@ -1072,6 +1074,40 @@ struct bpf_prog_aux {
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
2.35.3
