Return-Path: <bpf+bounces-16503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6AF801DFE
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 18:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8E71C2088E
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 17:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF15D200BE;
	Sat,  2 Dec 2023 17:57:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE59124
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 09:57:24 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3B2EmrTR001879
	for <bpf@vger.kernel.org>; Sat, 2 Dec 2023 09:57:23 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3ur1569rr5-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 02 Dec 2023 09:57:23 -0800
Received: from twshared21997.42.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 2 Dec 2023 09:57:21 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 2124F3C7A80E7; Sat,  2 Dec 2023 09:57:08 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v5 bpf-next 01/11] bpf: rearrange bpf_func_state fields to save a bit of memory
Date: Sat, 2 Dec 2023 09:56:55 -0800
Message-ID: <20231202175705.885270-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202175705.885270-1-andrii@kernel.org>
References: <20231202175705.885270-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2x2SHeqK5SdstEOg7_1wD7Nag7kIXijo
X-Proofpoint-GUID: 2x2SHeqK5SdstEOg7_1wD7Nag7kIXijo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_16,2023-11-30_01,2023-05-22_02

It's a trivial rearrangement saving 8 bytes. We have 4 bytes of padding
at the end which can be filled with another field without increasing
struct bpf_func_state.

copy_func_state() logic remains correct without any further changes.

BEFORE
=3D=3D=3D=3D=3D=3D
struct bpf_func_state {
        struct bpf_reg_state       regs[11];             /*     0  1320 *=
/
        /* --- cacheline 20 boundary (1280 bytes) was 40 bytes ago --- */
        int                        callsite;             /*  1320     4 *=
/
        u32                        frameno;              /*  1324     4 *=
/
        u32                        subprogno;            /*  1328     4 *=
/
        u32                        async_entry_cnt;      /*  1332     4 *=
/
        bool                       in_callback_fn;       /*  1336     1 *=
/

        /* XXX 7 bytes hole, try to pack */

        /* --- cacheline 21 boundary (1344 bytes) --- */
        struct tnum                callback_ret_range;   /*  1344    16 *=
/
        bool                       in_async_callback_fn; /*  1360     1 *=
/
        bool                       in_exception_callback_fn; /*  1361    =
 1 */

        /* XXX 2 bytes hole, try to pack */

        int                        acquired_refs;        /*  1364     4 *=
/
        struct bpf_reference_state * refs;               /*  1368     8 *=
/
        int                        allocated_stack;      /*  1376     4 *=
/

        /* XXX 4 bytes hole, try to pack */

        struct bpf_stack_state *   stack;                /*  1384     8 *=
/

        /* size: 1392, cachelines: 22, members: 13 */
        /* sum members: 1379, holes: 3, sum holes: 13 */
        /* last cacheline: 48 bytes */
};

AFTER
=3D=3D=3D=3D=3D
struct bpf_func_state {
        struct bpf_reg_state       regs[11];             /*     0  1320 *=
/
        /* --- cacheline 20 boundary (1280 bytes) was 40 bytes ago --- */
        int                        callsite;             /*  1320     4 *=
/
        u32                        frameno;              /*  1324     4 *=
/
        u32                        subprogno;            /*  1328     4 *=
/
        u32                        async_entry_cnt;      /*  1332     4 *=
/
        struct tnum                callback_ret_range;   /*  1336    16 *=
/
        /* --- cacheline 21 boundary (1344 bytes) was 8 bytes ago --- */
        bool                       in_callback_fn;       /*  1352     1 *=
/
        bool                       in_async_callback_fn; /*  1353     1 *=
/
        bool                       in_exception_callback_fn; /*  1354    =
 1 */

        /* XXX 1 byte hole, try to pack */

        int                        acquired_refs;        /*  1356     4 *=
/
        struct bpf_reference_state * refs;               /*  1360     8 *=
/
        struct bpf_stack_state *   stack;                /*  1368     8 *=
/
        int                        allocated_stack;      /*  1376     4 *=
/

        /* size: 1384, cachelines: 22, members: 13 */
        /* sum members: 1379, holes: 1, sum holes: 1 */
        /* padding: 4 */
        /* last cacheline: 40 bytes */
};

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d99a636d36a7..0c0e1bccad45 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -297,8 +297,8 @@ struct bpf_func_state {
 	 * void foo(void) { bpf_timer_set_callback(,foo); }
 	 */
 	u32 async_entry_cnt;
-	bool in_callback_fn;
 	struct tnum callback_ret_range;
+	bool in_callback_fn;
 	bool in_async_callback_fn;
 	bool in_exception_callback_fn;
 	/* For callback calling functions that limit number of possible
@@ -316,8 +316,8 @@ struct bpf_func_state {
 	/* The following fields should be last. See copy_func_state() */
 	int acquired_refs;
 	struct bpf_reference_state *refs;
-	int allocated_stack;
 	struct bpf_stack_state *stack;
+	int allocated_stack;
 };
=20
 struct bpf_idx_pair {
--=20
2.34.1


