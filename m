Return-Path: <bpf+bounces-6620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE9A76BE84
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 22:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB90281BE9
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 20:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67896263BC;
	Tue,  1 Aug 2023 20:36:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6F84DC94
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 20:36:49 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436B71FFD
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 13:36:48 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371H6cRL024014
	for <bpf@vger.kernel.org>; Tue, 1 Aug 2023 13:36:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=gq3qeW8i/pQqHijuqVBTvf8gSC8BcsZj+hC64FNjS+Y=;
 b=oSYQPGr5rHvACrJIjQ7JwBeSPHGUWETIbYR8g7U4sUan136S9RAe98iu5r31QzpJeYwu
 DeQqc1Hxf5wGzZo5cIJUM1tCmkh3s9Lh17nEIS7OzsAZmpsOcndgutXyG/8sWnTR0dYc
 iquxggYwjBsxNQWAn4d7J9q3+rHdyfjmdeA= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3s6uyyehgw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 13:36:47 -0700
Received: from twshared10970.08.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 13:36:46 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 5BD4322048679; Tue,  1 Aug 2023 13:36:34 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 3/7] bpf: Use bpf_mem_free_rcu when bpf_obj_dropping refcounted nodes
Date: Tue, 1 Aug 2023 13:36:26 -0700
Message-ID: <20230801203630.3581291-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801203630.3581291-1-davemarchevsky@fb.com>
References: <20230801203630.3581291-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tOZwt_hA64arAYFDbod6fmnx_GaHUZ1T
X-Proofpoint-GUID: tOZwt_hA64arAYFDbod6fmnx_GaHUZ1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_19,2023-08-01_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is the final fix for the use-after-free scenario described in
commit 7793fc3babe9 ("bpf: Make bpf_refcount_acquire fallible for
non-owning refs"). That commit, by virtue of changing
bpf_refcount_acquire's refcount_inc to a refcount_inc_not_zero, fixed
the "refcount incr on 0" splat. The not_zero check in
refcount_inc_not_zero, though, still occurs on memory that could have
been free'd and reused, so the commit didn't properly fix the root
cause.

This patch actually fixes the issue by free'ing using the recently-added
bpf_mem_free_rcu, which ensures that the memory is not reused until
RCU Tasks Trace grace period has elapsed. If that has happened then
there are no non-owning references alive that point to the
recently-free'd memory, so it can be safely reused.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/helpers.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 56ce5008aedd..7702f657fa3f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1913,7 +1913,11 @@ void __bpf_obj_drop_impl(void *p, const struct btf=
_record *rec)
=20
 	if (rec)
 		bpf_obj_free_fields(rec, p);
-	bpf_mem_free(&bpf_global_ma, p);
+
+	if (rec && rec->refcount_off >=3D 0)
+		bpf_mem_free_rcu(&bpf_global_ma, p);
+	else
+		bpf_mem_free(&bpf_global_ma, p);
 }
=20
 __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
--=20
2.34.1


