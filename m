Return-Path: <bpf+bounces-1637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE0A71F85B
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 04:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A8428199D
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 02:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F3115AA;
	Fri,  2 Jun 2023 02:27:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAC11363
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 02:27:00 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24B518D
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 19:26:58 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351Nt4ho016162
	for <bpf@vger.kernel.org>; Thu, 1 Jun 2023 19:26:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=UQU9wiJb0Ih5CzkMPhP3koVPPJKeT1ByxWjFlhKEBDQ=;
 b=I/aoPS/6kuP8gt7/l1p/kTtMjhTCauIZFaRhd90YGrclz6rUIh7lgK8/6nXNYbLWNGtV
 DjSdq9NrzwjOoNDygywdWpvAnOYS+taAcMPmuSuGSk7lr5SY4hoSssAM+68Ba2L4MRXp
 3052kngH+CHN57+J2s5w1QYq3MevzZv19sQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qxxb5mffj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 19:26:58 -0700
Received: from twshared29819.07.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 19:26:57 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id E324D1EF7C8D5; Thu,  1 Jun 2023 19:26:54 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 5/9] [DONOTAPPLY] bpf: Allow KF_DESTRUCTIVE-flagged kfuncs to be called under spinlock
Date: Thu, 1 Jun 2023 19:26:43 -0700
Message-ID: <20230602022647.1571784-6-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602022647.1571784-1-davemarchevsky@fb.com>
References: <20230602022647.1571784-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: DRiWprJKdkoMnKj6zDblRwonuacI6aaR
X-Proofpoint-ORIG-GUID: DRiWprJKdkoMnKj6zDblRwonuacI6aaR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 48c3e2bbcc4a..1bf0e6411feb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -330,6 +330,11 @@ struct bpf_kfunc_call_arg_meta {
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
@@ -10313,6 +10318,21 @@ static bool is_rbtree_lock_required_kfunc(u32 bt=
f_id)
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
@@ -16218,7 +16238,7 @@ static int do_check(struct bpf_verifier_env *env)
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


