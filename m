Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A10513A71
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 18:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbiD1Q5T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 12:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiD1Q5S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 12:57:18 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DBE9D04F
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 09:54:03 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SG7bkd026710
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 09:54:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=4zW1P/WA9Uq+rWw89+ehVR/8ZdHNU3/hpyQx5RYl5Mg=;
 b=it3KouGCvD4gxxSaLCxtx6PR3y19PZd5rx4Fq1fdqoe0r16oPVNvTTxdXTYg4QZbI5Mj
 REooXBJ2XJAPQmac494ZeMb+MkAPeucJ6y+xhvBdJv4EUYWvXM/HH9mvPyLUNj/wRTgQ
 6iHg7EBJF11UFLYK/MEAhSjLq9Yx8QNxHXU= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fqm5r40r4-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 09:54:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mk8SPILwv/9hDyXLg/fPl/e6wdoEVl57+bNBU/+6BE6eiX+o+MQgj0/mabky+PplMv+S8KiDUaeHbMyPlJ6VABD1HKb+eBV9LRgbMe8lQsSfMmGbg1ezoxK7PpOYbBW6g/L5XZsjesKF217Se0pFCgWKeCKY5Rg+5oYXZDv01cIlsHX6BT5m8jCwRGSJrc8RfhApZjRU1d+eEO/B5Qf1sf6pTuLx+hcu8G9Ybg3fkdxgjLgmog19OC3tPrRc4ROLeU3daAGc7g4+hxsAue5efKsQR4qRqbUKRR6JgkHZy1vWnUtZQK2Q29xlwf1YsophZGpnWDyPyMIqE/tbE5kqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zW1P/WA9Uq+rWw89+ehVR/8ZdHNU3/hpyQx5RYl5Mg=;
 b=ejNuN+lwBf6oqJTHCMmZ6TnyFE4LrKnLWcS+5vAQv/3fHZ/x1JxpsGi4Hp4EG2oc24b0tK4cAR96QyoqSFuRkUIro5aRy0EH9wRh0/Uo7bolyWuBEdTQKaxOo3YI9L6POQtA4qet8+peUr+/AMD+JjWX6kkheaKuQT4UU1YsZug6XVelrN134QeS/Xt5DO2D+aLYl4TcXEPxVGFZ1E4pUCQHxOAV3ewdtitvok0x1fcJYKLNz6gQbxYR9r2KkQTpI3Q9Gal/nNHe1+tu566iutbNxQLOXwfw9soVD6EW5MEL7Bzkk+flDhUqdbf5HTQhlbHT/3n3xmAaTfYxb9nz9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by SJ0PR15MB4615.namprd15.prod.outlook.com (2603:10b6:a03:37c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 16:53:59 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%4]) with mapi id 15.20.5186.020; Thu, 28 Apr 2022
 16:53:59 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next 1/5] bpf: move bpf_prog to bpf.h
Thread-Topic: [PATCH bpf-next 1/5] bpf: move bpf_prog to bpf.h
Thread-Index: AQHYWyCOlNxLOBniyUiRir4MD0vVGw==
Date:   Thu, 28 Apr 2022 16:53:59 +0000
Message-ID: <39268f145f9cec5333ddc301448740d96467c9c9.1651103126.git.delyank@fb.com>
References: <cover.1651103126.git.delyank@fb.com>
In-Reply-To: <cover.1651103126.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 044fdc1c-7c01-425c-ce9a-08da2937b0b2
x-ms-traffictypediagnostic: SJ0PR15MB4615:EE_
x-microsoft-antispam-prvs: <SJ0PR15MB4615D2BD0206835A1D0E28F2C1FD9@SJ0PR15MB4615.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hMtXGalki48mHD2lS9vXNuSVttBOVbZL7TgN/NwmRK+KbTeh2RJJqcoR9hl7Z0+SqDzl6BfR4Jf0dkmZr7O1UgDwK8zUzXl2R1g3flAzlnKSGQzdJdPtx/hkUz/g3Wdb8xqhqh2+YUU3ddO40ZBasryhZJ+GCdPxnv82q2K0GusAWiZivc9udVamORLIm0NQknZ4H/3TXXThtPNUBNWx3+w5GM7ym7pdcM81i5mzb7Tn/QJIL5PuxfsNSiZ/y+AGM7ybblW/fF0gNOVk+EGrxY9C1NRXBbtxaERRSGyJQqVKu5odnXd8Nqqh5VFzfQqYsnEulBrDQ7yT32ZprfaxYs1hZz41twORlpWnifYtsonMwgUfBzCfuLvCo/SK+brfmD58h0K2JrqbFHVlsQhlwsJBX2SEN436zuDm837RxdXDeTIkLuMQVxmUE6OIg13yux8OwnKE82y/kA6nCXNSfA94q/b24vUzhEsI06sWfq2l+nGq6ffFpYIpZXgiQonlONS+7w/5OesS3Iqf3yZ7rf5aSfeaczVaRzimDbYjQY9+ZrJcZvJaZdTlFinj/G4e5Rt/4v8Dt1ICugjWoessG03xCh/sHwLdfDFBvU3r1+rGKjiMtwLNXmAH7IFIeBbU6tlkgo3vORq+xf51oBrgkS9WYOiUnahZ+51HNxdgOFan4ctpgYJWqYpwTY7/Muewn4jiQsf35W0Bru2T3aUB4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(2906002)(36756003)(38070700005)(86362001)(316002)(122000001)(5660300002)(66946007)(8936002)(6506007)(66556008)(76116006)(8676002)(64756008)(66446008)(83380400001)(66476007)(6486002)(71200400001)(186003)(26005)(6512007)(110136005)(2616005)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d+xaOnqKk2kGu2YclseVCGli3H+QHgKPV8TCpsA4JKZ6s8UYvOwrgb4/zc?=
 =?iso-8859-1?Q?8+6xA6qIXvmW7ITvfztEbarm/iTt14zLFxBbeQyx+/xH0LyTy/dE859w4y?=
 =?iso-8859-1?Q?4rUb5gbZvjTenCPFmeLbZ9FzrOnFbj7y7E5l3bya+jdWvhGLX+2gSKWmp7?=
 =?iso-8859-1?Q?VTRHIUDzEZXwG4gEBQLsqz2UXHxsinf7E5P710HF+Jz+xInObiQbnV4G5+?=
 =?iso-8859-1?Q?p6lt//2h1JxZSpCcyhuM75CpAFwIRdrUobZtRb/R9ux0mExD+PHvycr5QZ?=
 =?iso-8859-1?Q?Or+o4sAcLprAh9AEJzLPXcBodz361c63mOboX0tZ1Ufii90H10MR8HpWbG?=
 =?iso-8859-1?Q?Odgpqju+Mz2OzDNPcJ02A+C6aBsgRST8mfG3+pGhht68nsI1shs/PunMvf?=
 =?iso-8859-1?Q?DmCWeV04Xk8A1I5e4IR8vPrIffdB15H1XTEorKehWXl9boer/qLn2eshYg?=
 =?iso-8859-1?Q?dYBl8Po54vpIWzYS2xbrwtXGLRBNq3cWM9olJhXcmxC9+jM1weqxA+D0Eu?=
 =?iso-8859-1?Q?P+0dXF5kVgwelqt0of0wW+gz7htXHmd72xeDjLp0IJHgoQKJrtHyNvVpGV?=
 =?iso-8859-1?Q?yX4zXH8vfNGSoiqq3ExVMJ7cLbcCE1jTZfwq6KdVe6ycVK998h6jrJexDX?=
 =?iso-8859-1?Q?h9ITNweFo2Ug7AyJJud74l49NRtnitJavE7fjwQ0hRCAn+Q8K4BDLDgnNb?=
 =?iso-8859-1?Q?0jiUIuxkFRH9qnmk6cZsZeEFajyoQOFJRe80Ghse6YNIv6qpSaegwRxiz6?=
 =?iso-8859-1?Q?n04AilWXYOduzmTu77wWhvMQaH6FdGHe88UyrAzfnS29oZ1UM2H3tjbmfF?=
 =?iso-8859-1?Q?kkfl5v72stfWmKDUHeDZpbQXIsAMFeSHusEpOnCGHSqg56rLLyUqsTtLrs?=
 =?iso-8859-1?Q?86Nx8sSbpkg26iooTQVxukj94v3aVSRFUXVjq+ympw0fi4jIA5QLMHi+gS?=
 =?iso-8859-1?Q?2/bnxk8+YaByaPjv0VfFZS4T7at8gVT+7uO8i+frWYnR3EPfYlx65AuQ0Y?=
 =?iso-8859-1?Q?bSjL7Zklw58TaXd53wmEwRDMTbiLfEC2yhuqLVD0PeEZZ0a0H3jSyCNCz/?=
 =?iso-8859-1?Q?eOZtvvhnc07YstB3ywPXelY5orJ27mlQGA8ZJcF4u2vrapxQOEobA9aM2T?=
 =?iso-8859-1?Q?pqe6BWgKn/zDCfZ4pWF52tqDGHp6sHDvVFpV6h/fR5gsWq/OAo9U84FTCW?=
 =?iso-8859-1?Q?eIEN0v0cdMk0OuUCeLD4NYU65X2QkLU9exwSYAua6/HD3kK0+fdJkwMc6C?=
 =?iso-8859-1?Q?0QTv+2ZVGO4y9Tx4+hEkjl/S4U/P0btOi0BzTNdCAorl1KGO2jqxuXBaRY?=
 =?iso-8859-1?Q?CSVbrhdSY4SyYnTB8BUJDfjpng5GVS90n4YkbjN6wZPn8K/R3PEGIjfv+I?=
 =?iso-8859-1?Q?zFMzT9ZBQmovkHy5ivBm/lEuuuJgP4jC/oY+aIr2wLPM5Fc1g5KRIRZuvs?=
 =?iso-8859-1?Q?wjdw994ckqmUnB3+fBkuhAyu5/NdxdMx4G/HUuG1cpcpDXg4rM5cZSQfig?=
 =?iso-8859-1?Q?B8UDy7guu1vN+OOO9/A9o+DpJtjgNtLrx/9B8uSM5fx4hw4zOclnmvIy5j?=
 =?iso-8859-1?Q?1jj2FB00GxtOGnebGu9qJkJTR36UyX3PqzFZr9ezmByza3Pyrrsw8kiEBN?=
 =?iso-8859-1?Q?NPLbIx8oWptiolTVd5DIkiFq/Y8jVfCdwgI33Pjd77h8QV4G46g+DT8qsh?=
 =?iso-8859-1?Q?Qk4ytZ/2fausUXZ+E0SHYIOHl0yJmO1X7CFexpHmAs0pgxyyyEYZqpkKeM?=
 =?iso-8859-1?Q?61wC+fivDA7C+XuIrpZ50JVOW6mZYFh4FPY8WFpJE9cHxFarYvViMcvwLo?=
 =?iso-8859-1?Q?HZwPfz4GGQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044fdc1c-7c01-425c-ce9a-08da2937b0b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 16:53:59.0638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WLIct9lGc+DJ2NP3N0gHwZWVrPyBCyDvIfrDUDw2Sl3ro5j2VgQznyymt5+cY1RV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4615
X-Proofpoint-GUID: GUhnEBh6_v86GEaW4Hh_mwPCM_aE7Viw
X-Proofpoint-ORIG-GUID: GUhnEBh6_v86GEaW4Hh_mwPCM_aE7Viw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_02,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 7bf441563ffc..7d7f4806f5fb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -5,6 +5,7 @@
 #define _LINUX_BPF_H 1

 #include <uapi/linux/bpf.h>
+#include <uapi/linux/filter.h>

 #include <linux/workqueue.h>
 #include <linux/file.h>
@@ -22,6 +23,7 @@
 #include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/percpu-refcount.h>
+#include <linux/stddef.h>
 #include <linux/bpfptr.h>

 struct bpf_verifier_env;
@@ -1019,6 +1021,40 @@ struct bpf_prog_aux {
 	};
 };

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
--
2.35.1=
