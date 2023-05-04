Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F136F646B
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 07:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjEDFeM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 01:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjEDFeL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 01:34:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCBE2122
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 22:34:09 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3440qUPK016990
        for <bpf@vger.kernel.org>; Wed, 3 May 2023 22:34:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=XFFAf5dfjl+Rt3jWqHNrw4NZbYLGA1/35aiH7fT0Mn0=;
 b=LGL6+yVo2Zu6dAIGJRiPcwUWIb0NecK/bAq5ybDKo9EPtnGyHin0aPkU/aX0z0sorLtv
 qhFw7uIz8akefFfr9Q6KunN2Kdj5ZERAjMuhOKyYkZMq6KB0rDgu845rFNjHsJOYCtvK
 2fhgFQHEck9dJ3KoYmWpmBC7cELoAGdpXbI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3qbkgnfnxh-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 22:34:08 -0700
Received: from twshared1349.05.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 3 May 2023 22:34:04 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 614701D7BFC6C; Wed,  3 May 2023 22:33:49 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 4/9] bpf: Allow KF_DESTRUCTIVE-flagged kfuncs to be called under spinlock
Date:   Wed, 3 May 2023 22:33:33 -0700
Message-ID: <20230504053338.1778690-5-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230504053338.1778690-1-davemarchevsky@fb.com>
References: <20230504053338.1778690-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 7J7ELa3wHV6aY8qaOWy5s64NjyIg0TWv
X-Proofpoint-ORIG-GUID: 7J7ELa3wHV6aY8qaOWy5s64NjyIg0TWv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_02,2023-05-03_01,2023-02-09_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In order to prevent deadlock the verifier currently disallows any
function calls under bpf_spin_lock save for a small set of allowlisted
helpers/kfuncs. A BPF program that calls destructive kfuncs might be
trying to cause deadlock, and regardless is understood to be capable of
causing system breakage of similar severity. Per kfuncs.rst:

  The KF_DESTRUCTIVE flag is used to indicate functions calling which is
  destructive to the system. For example such a call can result in system
  rebooting or panicking. Due to this additional restrictions apply to th=
ese
  calls.

Preventing BPF programs from crashing or otherwise blowing up the system
is generally the verifier's goal, but destructive kfuncs might have such
a state be their intended result. Preventing KF_DESTRUCTIVE kfunc calls
under spinlock with the goal of safety is therefore unnecessarily
strict. This patch modifies the "function calls are not allowed while
holding a lock" check to allow calling destructive kfuncs with an
active_lock.

The motivating usecase for this change - unsafe locking of
bpf_spin_locks for easy testing of race conditions - is implemented in
the next two patches in the series.

Note that the removed insn->off check was rejecting any calls to kfuncs
defined in non-vmlinux BTF. In order to get the system in a broken or
otherwise interesting state for inspection, developers might load a
module implementing destructive kfuncs particular to their usecase. The
unsafe_spin_{lock, unlock} kfuncs later in this series are a good
example: there's no clear reason for them to be in vmlinux as they're
specifically for BPF selftests, so they live in bpf_testmod. The check
is removed in favor of a newly-added helper function to enable such
usecases.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 26c072e34834..f96e5b9c790b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -319,6 +319,11 @@ struct bpf_kfunc_call_arg_meta {
 	u64 mem_size;
 };
=20
+static int fetch_kfunc_meta(struct bpf_verifier_env *env,
+			    struct bpf_insn *insn,
+			    struct bpf_kfunc_call_arg_meta *meta,
+			    const char **kfunc_name);
+
 struct btf *btf_vmlinux;
=20
 static DEFINE_MUTEX(bpf_verifier_lock);
@@ -9989,6 +9994,21 @@ static bool is_rbtree_lock_required_kfunc(u32 btf_=
id)
 	return is_bpf_rbtree_api_kfunc(btf_id);
 }
=20
+static bool is_kfunc_callable_in_spinlock(struct bpf_verifier_env *env,
+					  struct bpf_insn *insn)
+{
+	struct bpf_kfunc_call_arg_meta meta;
+
+	/* insn->off is idx into btf fd_array - 0 for vmlinux btf, else nonzero=
 */
+	if (!insn->off && is_bpf_graph_api_kfunc(insn->imm))
+		return true;
+
+	if (fetch_kfunc_meta(env, insn, &meta, NULL))
+		return false;
+
+	return is_kfunc_destructive(&meta);
+}
+
 static bool check_kfunc_is_graph_root_api(struct bpf_verifier_env *env,
 					  enum btf_field_type head_field_type,
 					  u32 kfunc_btf_id)
@@ -15875,7 +15895,7 @@ static int do_check(struct bpf_verifier_env *env)
 					if ((insn->src_reg =3D=3D BPF_REG_0 && insn->imm !=3D BPF_FUNC_spin=
_unlock) ||
 					    (insn->src_reg =3D=3D BPF_PSEUDO_CALL) ||
 					    (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
-					     (insn->off !=3D 0 || !is_bpf_graph_api_kfunc(insn->imm)))) {
+					     !is_kfunc_callable_in_spinlock(env, insn))) {
 						verbose(env, "function calls are not allowed while holding a lock\=
n");
 						return -EINVAL;
 					}
--=20
2.34.1

