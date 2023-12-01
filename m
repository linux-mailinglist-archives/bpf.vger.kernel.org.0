Return-Path: <bpf+bounces-16427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D18C8012D7
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A732822A0
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 18:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF1C5100B;
	Fri,  1 Dec 2023 18:34:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A7D12A
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 10:34:16 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1IBZTH027008
	for <bpf@vger.kernel.org>; Fri, 1 Dec 2023 10:34:15 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uq7jsvgt9-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 10:34:15 -0800
Received: from twshared19681.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 10:34:09 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 05CDC3C6DB41B; Fri,  1 Dec 2023 10:34:01 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v4 bpf-next 01/11] bpf: rearrange bpf_func_state fields to save a bit of memory
Date: Fri, 1 Dec 2023 10:33:49 -0800
Message-ID: <20231201183359.1769668-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201183359.1769668-1-andrii@kernel.org>
References: <20231201183359.1769668-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: D7gYWrg8lsobIRn0VcFkbSa2HaW7yyL7
X-Proofpoint-ORIG-GUID: D7gYWrg8lsobIRn0VcFkbSa2HaW7yyL7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_16,2023-11-30_01,2023-05-22_02

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


