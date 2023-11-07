Return-Path: <bpf+bounces-14382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 714A67E3704
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 09:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B0A1B20AF2
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 08:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D60DDAB;
	Tue,  7 Nov 2023 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Oc2oq6Gd"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125F8CA46
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 08:56:51 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA61FA
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 00:56:50 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A72hIP3031903
	for <bpf@vger.kernel.org>; Tue, 7 Nov 2023 00:56:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=etVqGwDQOkQ5sWNebmeEj6f8PbiRojxM21g7Q47hMu4=;
 b=Oc2oq6GdxAEq4wx+/CFUyGHLTRJEfwMOPWFIsFm0f5Zp8v8fTTsfl4tDE6LXgYgbHMgM
 uOKKPfMReHavtHYF7WMU1g/HrwFhnroKAUnijdnnyPFbidb/Ut/R6lD/p1/oPXN6CwgH
 xNkmXpPSt+tjnq94eEEzRdrfvPOXxwP7EJQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u7cpsst2k-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 07 Nov 2023 00:56:49 -0800
Received: from twshared2493.02.ash8.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 00:56:48 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 7DD3C26E3B709; Tue,  7 Nov 2023 00:56:42 -0800 (PST)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Yonghong Song
	<yonghong.song@linux.dev>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 1/6] bpf: Add KF_RCU flag to bpf_refcount_acquire_impl
Date: Tue, 7 Nov 2023 00:56:34 -0800
Message-ID: <20231107085639.3016113-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107085639.3016113-1-davemarchevsky@fb.com>
References: <20231107085639.3016113-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: r3tGiut-9aI7jn90kNj3_rbIbKkHKJ9f
X-Proofpoint-GUID: r3tGiut-9aI7jn90kNj3_rbIbKkHKJ9f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02

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


