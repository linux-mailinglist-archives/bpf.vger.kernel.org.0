Return-Path: <bpf+bounces-11968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8450A7C606B
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 00:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F062282697
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 22:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EB5125CD;
	Wed, 11 Oct 2023 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E423539E
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 22:37:55 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1441D3
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:37:53 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BLJZXh027991
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:37:53 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tp16221gj-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:37:53 -0700
Received: from twshared68648.02.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 11 Oct 2023 15:37:42 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 9799A399512C8; Wed, 11 Oct 2023 15:37:40 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 5/5] bpf: ensure proper register state printing for cond jumps
Date: Wed, 11 Oct 2023 15:37:28 -0700
Message-ID: <20231011223728.3188086-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011223728.3188086-1-andrii@kernel.org>
References: <20231011223728.3188086-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: S0KIYubBtUJ5yaQibHtCqRnW-WML9hkM
X-Proofpoint-GUID: S0KIYubBtUJ5yaQibHtCqRnW-WML9hkM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_18,2023-10-11_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Verifier emits relevant register state involved in any given instruction
next to it after `;` to the right, if possible. Or, worst case, on the
separate line repeating instruction index.

E.g., a nice and simple case would be:

  2: (d5) if r0 s<=3D 0x0 goto pc+1       ; R0_w=3D0

But if there is some intervening extra output (e.g., precision
backtracking log) involved, we are supposed to see the state after the
precision backtrack log:

  4: (75) if r0 s>=3D 0x0 goto pc+1
  mark_precise: frame0: last_idx 4 first_idx 0 subseq_idx -1
  mark_precise: frame0: regs=3Dr0 stack=3D before 2: (d5) if r0 s<=3D 0x0=
 goto pc+1
  mark_precise: frame0: regs=3Dr0 stack=3D before 1: (b7) r0 =3D 0
  6: R0_w=3D0

First off, note that in `6: R0_w=3D0` instruction index corresponds to th=
e
next instruction, not to the conditional jump instruction itself, which
is wrong and we'll get to that.

But besides that, the above is a happy case that does work today. Yet,
if it so happens that precision backtracking had to traverse some of the
parent states, this `6: R0_w=3D0` state output would be missing.

This is due to a quirk of print_verifier_state() routine, which performs
mark_verifier_state_clean(env) at the end. This marks all registers as
"non-scratched", which means that subsequent logic to print *relevant*
registers (that is, "scratched ones") fails and doesn't see anything
relevant to print and skips the output altogether.

print_verifier_state() is used both to print instruction context, but
also to print an **entire** verifier state indiscriminately, e.g.,
during precision backtracking (and in a few other situations, like
during entering or exiting subprogram).  Which means if we have to print
entire parent state before getting to printing instruction context
state, instruction context is marked as clean and is omitted.

Long story short, this is definitely not intentional. So we fix this
behavior in this patch by teaching print_verifier_state() to clear
scratch state only if it was used to print instruction state, not the
parent/callback state. This is determined by print_all option, so if
it's not set, we don't clear scratch state. This fixes missing
instruction state for these cases.

As for the mismatched instruction index, we fix that by making sure we
call print_insn_state() early inside check_cond_jmp_op() before we
adjusted insn_idx based on jump branch taken logic. And with that we get
desired correct information:

  9: (16) if w4 =3D=3D 0x1 goto pc+9
  mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1
  mark_precise: frame0: parent state regs=3Dr4 stack=3D: R2_w=3D1944 R4_r=
w=3DP1 R10=3Dfp0
  mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx 9
  mark_precise: frame0: regs=3Dr4 stack=3D before 8: (66) if w4 s> 0x3 go=
to pc+5
  mark_precise: frame0: regs=3Dr4 stack=3D before 7: (b7) r4 =3D 1
  9: R4=3D1

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 059f8e930499..fdcae52b76b4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1539,7 +1539,8 @@ static void print_verifier_state(struct bpf_verifie=
r_env *env,
 	if (state->in_async_callback_fn)
 		verbose(env, " async_cb");
 	verbose(env, "\n");
-	mark_verifier_state_clean(env);
+	if (!print_all)
+		mark_verifier_state_clean(env);
 }
=20
 static inline u32 vlog_alignment(u32 pos)
@@ -14408,6 +14409,8 @@ static int check_cond_jmp_op(struct bpf_verifier_=
env *env,
 		    !sanitize_speculative_path(env, insn, *insn_idx + 1,
 					       *insn_idx))
 			return -EFAULT;
+		if (env->log.level & BPF_LOG_LEVEL)
+			print_insn_state(env, this_branch->frame[this_branch->curframe]);
 		*insn_idx +=3D insn->off;
 		return 0;
 	} else if (pred =3D=3D 0) {
@@ -14420,6 +14423,8 @@ static int check_cond_jmp_op(struct bpf_verifier_=
env *env,
 					       *insn_idx + insn->off + 1,
 					       *insn_idx))
 			return -EFAULT;
+		if (env->log.level & BPF_LOG_LEVEL)
+			print_insn_state(env, this_branch->frame[this_branch->curframe]);
 		return 0;
 	}
=20
--=20
2.34.1


