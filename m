Return-Path: <bpf+bounces-13275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B307D76EE
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 23:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5488C1C20EA6
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 21:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A848341BD;
	Wed, 25 Oct 2023 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BvMaDADX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BF1347BD
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 21:41:31 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6080E137
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:30 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39PLfN7c016371
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=etVqGwDQOkQ5sWNebmeEj6f8PbiRojxM21g7Q47hMu4=;
 b=BvMaDADXt1Hc8NVvr2+rbbwnTikhmH+ls3HVfMnmGjqDHbnpG4TBdRFrFwj44hSYoI+0
 +Z0ePvKFXwx37BBRjqvCbWfZVQV32UeykNOCIOu9XY+ZMR2L+ghukKnuHOBBH/7jZNsz
 U4biYiZQN9e1bRuQjbNV7QC6pdVNAf1eeuY= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3ty54a3674-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:29 -0700
Received: from twshared32169.15.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 14:40:22 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 28C10264D46BD; Wed, 25 Oct 2023 14:40:09 -0700 (PDT)
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
Subject: [PATCH v1 bpf-next 1/6] bpf: Add KF_RCU flag to bpf_refcount_acquire_impl
Date: Wed, 25 Oct 2023 14:40:02 -0700
Message-ID: <20231025214007.2920506-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025214007.2920506-1-davemarchevsky@fb.com>
References: <20231025214007.2920506-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _Fvkea7sIQ3Ir9DmE7EAXBLfFgnh1g2R
X-Proofpoint-GUID: _Fvkea7sIQ3Ir9DmE7EAXBLfFgnh1g2R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_11,2023-10-25_01,2023-05-22_02

Refcounted local kptrs are kptrs to user-defined types with a
bpf_refcount field. Recent commits ([0], [1]) modified the lifetime of
refcounted local kptrs such that the underlying memory is not reused
until RCU grace period has elapsed.

Separately, verification of bpf_refcount_acquire calls currently
succeeds for MAYBE_NULL non-owning reference input, which is a problem
as bpf_refcount_acquire_impl has no handling for this case.

This patch takes advantage of aforementioned lifetime changes to tag
bpf_refcount_acquire_impl kfunc KF_RCU, thereby preventing MAYBE_NULL
input to the kfunc. The KF_RCU flag applies to all kfunc params; it's
fine for it to apply to the void *meta__ign param as that's populated by
the verifier and is tagged __ign regardless.

  [0]: commit 7e26cd12ad1c ("bpf: Use bpf_mem_free_rcu when
       bpf_obj_dropping refcounted nodes") is the actual change to
       allocation behaivor
  [1]: commit 0816b8c6bf7f ("bpf: Consider non-owning refs to refcounted
       nodes RCU protected") modified verifier understanding of
       refcounted local kptrs to match [0]'s changes

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Fixes: 7c50b1cb76ac ("bpf: Add bpf_refcount_acquire kfunc")
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e46ac288a108..6e1874cc9c13 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2515,7 +2515,7 @@ BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | K=
F_RET_NULL)
 BTF_ID_FLAGS(func, bpf_percpu_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_percpu_obj_drop_impl, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_refcount_acquire_impl, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_refcount_acquire_impl, KF_ACQUIRE | KF_RET_NULL |=
 KF_RCU)
 BTF_ID_FLAGS(func, bpf_list_push_front_impl)
 BTF_ID_FLAGS(func, bpf_list_push_back_impl)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
--=20
2.34.1


