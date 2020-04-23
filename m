Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C420B1B64E2
	for <lists+bpf@lfdr.de>; Thu, 23 Apr 2020 21:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgDWT7K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Apr 2020 15:59:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34050 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726079AbgDWT7K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Apr 2020 15:59:10 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 03NJvMqC013710
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2020 12:59:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=c5pOwkMkVkcScTKEr6nJS0FMGz4XfwztBaBIT+L9cgc=;
 b=k7VDtqeiAPJxHo101OLE/WYp/LacYs827BbN9jGKA4CjbuHV/I7B+o2903gvdPVOEvcY
 aKULZHB30l2JZwKSnieDACefponcQ0CouERcX/3Ujrue5WysUqh5aw4qRhOm3e/SdP1A
 wK5S5RHhggcPevx55pUyh1AbijAjWxAXzLY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 30k6gcm33x-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2020 12:59:08 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 23 Apr 2020 12:59:05 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 710812EC2D30; Thu, 23 Apr 2020 12:58:59 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next] bpf: make verifier log more relevant by default
Date:   Thu, 23 Apr 2020 12:58:50 -0700
Message-ID: <20200423195850.1259827-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_15:2020-04-23,2020-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 spamscore=0 phishscore=0 clxscore=1015 suspectscore=29 impostorscore=0
 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230148
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To make BPF verifier verbose log more releavant and easier to use to debu=
g
verification failures, "pop" parts of log that were successfully verified=
.
This has effect of leaving only verifier logs that correspond to code bra=
nches
that lead to verification failure, which in practice should result in muc=
h
shorter and more relevant verifier log dumps. This behavior is made the
default behavior and can be overriden to do exhaustive logging by specify=
ing
BPF_LOG_LEVEL2 log level.

Using BPF_LOG_LEVEL2 to disable this behavior is not ideal, because in so=
me
cases it's good to have BPF_LOG_LEVEL2 per-instruction register dump
verbosity, but still have only relevant verifier branches logged. But for=
 this
patch, I didn't want to add any new flags. It might be worth-while to jus=
t
rethink how BPF verifier logging is performed and requested and streamlin=
e it
a bit. But this trimming of successfully verified branches seems to be us=
eful
and a good default behavior.

To test this, I modified runqslower slightly to introduce read of
uninitialized stack variable. Log (**truncated in the middle** to save ma=
ny
lines out of this commit message) BEFORE this change:

; int handle__sched_switch(u64 *ctx)
0: (bf) r6 =3D r1
; struct task_struct *prev =3D (struct task_struct *)ctx[1];
1: (79) r1 =3D *(u64 *)(r6 +8)
func 'sched_switch' arg1 has btf_id 151 type STRUCT 'task_struct'
2: (b7) r2 =3D 0
; struct event event =3D {};
3: (7b) *(u64 *)(r10 -24) =3D r2
last_idx 3 first_idx 0
regs=3D4 stack=3D0 before 2: (b7) r2 =3D 0
4: (7b) *(u64 *)(r10 -32) =3D r2
5: (7b) *(u64 *)(r10 -40) =3D r2
6: (7b) *(u64 *)(r10 -48) =3D r2
; if (prev->state =3D=3D TASK_RUNNING)

[ ... instruction dump from insn #7 through #50 are cut out ... ]

51: (b7) r2 =3D 16
52: (85) call bpf_get_current_comm#16
last_idx 52 first_idx 42
regs=3D4 stack=3D0 before 51: (b7) r2 =3D 16
; bpf_perf_event_output(ctx, &events, BPF_F_CURRENT_CPU,
53: (bf) r1 =3D r6
54: (18) r2 =3D 0xffff8881f3868800
56: (18) r3 =3D 0xffffffff
58: (bf) r4 =3D r7
59: (b7) r5 =3D 32
60: (85) call bpf_perf_event_output#25
last_idx 60 first_idx 53
regs=3D20 stack=3D0 before 59: (b7) r5 =3D 32
61: (bf) r2 =3D r10
; event.pid =3D pid;
62: (07) r2 +=3D -16
; bpf_map_delete_elem(&start, &pid);
63: (18) r1 =3D 0xffff8881f3868000
65: (85) call bpf_map_delete_elem#3
; }
66: (b7) r0 =3D 0
67: (95) exit

from 44 to 66: safe

from 34 to 66: safe

from 11 to 28: R1_w=3Dinv0 R2_w=3Dinv0 R6_w=3Dctx(id=3D0,off=3D0,imm=3D0)=
 R10=3Dfp0 fp-8=3Dmmmm???? fp-24_w=3D00000000 fp-32_w=3D00000000 fp-40_w=3D=
00000000 fp-48_w=3D00000000
; bpf_map_update_elem(&start, &pid, &ts, 0);
28: (bf) r2 =3D r10
;
29: (07) r2 +=3D -16
; tsp =3D bpf_map_lookup_elem(&start, &pid);
30: (18) r1 =3D 0xffff8881f3868000
32: (85) call bpf_map_lookup_elem#1
invalid indirect read from stack off -16+0 size 4
processed 65 insns (limit 1000000) max_states_per_insn 1 total_states 5 p=
eak_states 5 mark_read 4

Notice how there is a successful code path from instruction 0 through 67,=
 few
successfully verified jumps (44->66, 34->66), and only after that 11->28 =
jump
plus error on instruction #32.

AFTER this change (full verifier log, **no truncation**):

; int handle__sched_switch(u64 *ctx)
0: (bf) r6 =3D r1
; struct task_struct *prev =3D (struct task_struct *)ctx[1];
1: (79) r1 =3D *(u64 *)(r6 +8)
func 'sched_switch' arg1 has btf_id 151 type STRUCT 'task_struct'
2: (b7) r2 =3D 0
; struct event event =3D {};
3: (7b) *(u64 *)(r10 -24) =3D r2
last_idx 3 first_idx 0
regs=3D4 stack=3D0 before 2: (b7) r2 =3D 0
4: (7b) *(u64 *)(r10 -32) =3D r2
5: (7b) *(u64 *)(r10 -40) =3D r2
6: (7b) *(u64 *)(r10 -48) =3D r2
; if (prev->state =3D=3D TASK_RUNNING)
7: (79) r2 =3D *(u64 *)(r1 +16)
; if (prev->state =3D=3D TASK_RUNNING)
8: (55) if r2 !=3D 0x0 goto pc+19
 R1_w=3Dptr_task_struct(id=3D0,off=3D0,imm=3D0) R2_w=3Dinv0 R6_w=3Dctx(id=
=3D0,off=3D0,imm=3D0) R10=3Dfp0 fp-24_w=3D00000000 fp-32_w=3D00000000 fp-=
40_w=3D00000000 fp-48_w=3D00000000
; trace_enqueue(prev->tgid, prev->pid);
9: (61) r1 =3D *(u32 *)(r1 +1184)
10: (63) *(u32 *)(r10 -4) =3D r1
; if (!pid || (targ_pid && targ_pid !=3D pid))
11: (15) if r1 =3D=3D 0x0 goto pc+16

from 11 to 28: R1_w=3Dinv0 R2_w=3Dinv0 R6_w=3Dctx(id=3D0,off=3D0,imm=3D0)=
 R10=3Dfp0 fp-8=3Dmmmm???? fp-24_w=3D00000000 fp-32_w=3D00000000 fp-40_w=3D=
00000000 fp-48_w=3D00000000
; bpf_map_update_elem(&start, &pid, &ts, 0);
28: (bf) r2 =3D r10
;
29: (07) r2 +=3D -16
; tsp =3D bpf_map_lookup_elem(&start, &pid);
30: (18) r1 =3D 0xffff8881db3ce800
32: (85) call bpf_map_lookup_elem#1
invalid indirect read from stack off -16+0 size 4
processed 65 insns (limit 1000000) max_states_per_insn 1 total_states 5 p=
eak_states 5 mark_read 4

Notice how in this case, there are 0-11 instructions + jump from 11 to
28 is recorded + 28-32 instructions with error on insn #32.

test_verifier test runner was updated to specify BPF_LOG_LEVEL2 for
VERBOSE_ACCEPT expected result due to potentially "incomplete" success ve=
rbose
log at BPF_LOG_LEVEL1.

On success, verbose log will only have a summary of number of processed
instructions, etc, but no branch tracing log. Having just a last succesfu=
l
branch tracing seemed weird and confusing. Having small and clean summary=
 log
in success case seems quite logical and nice, though.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 kernel/bpf/verifier.c                       | 29 ++++++++++++++++++---
 tools/testing/selftests/bpf/test_verifier.c |  7 ++++-
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 38cfcf701eeb..2a98d9fb2eef 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -168,6 +168,8 @@ struct bpf_verifier_stack_elem {
 	int insn_idx;
 	int prev_insn_idx;
 	struct bpf_verifier_stack_elem *next;
+	/* length of verifier log at the time this state was pushed on stack */
+	u32 log_pos;
 };
=20
 #define BPF_COMPLEXITY_LIMIT_JMP_SEQ	8192
@@ -283,6 +285,18 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log,=
 const char *fmt,
 		log->ubuf =3D NULL;
 }
=20
+static void bpf_vlog_reset(struct bpf_verifier_log *log, u32 new_pos)
+{
+	char zero =3D 0;
+
+	if (!bpf_verifier_log_needed(log))
+		return;
+
+	log->len_used =3D new_pos;
+	if (put_user(zero, log->ubuf + new_pos))
+		log->ubuf =3D NULL;
+}
+
 /* log_level controls verbosity level of eBPF verifier.
  * bpf_verifier_log_write() is used to dump the verification trace to th=
e log,
  * so the user can figure out what's wrong with the program
@@ -846,7 +860,7 @@ static void update_branch_counts(struct bpf_verifier_=
env *env, struct bpf_verifi
 }
=20
 static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
-		     int *insn_idx)
+		     int *insn_idx, bool pop_log)
 {
 	struct bpf_verifier_state *cur =3D env->cur_state;
 	struct bpf_verifier_stack_elem *elem, *head =3D env->head;
@@ -860,6 +874,8 @@ static int pop_stack(struct bpf_verifier_env *env, in=
t *prev_insn_idx,
 		if (err)
 			return err;
 	}
+	if (pop_log)
+		bpf_vlog_reset(&env->log, head->log_pos);
 	if (insn_idx)
 		*insn_idx =3D head->insn_idx;
 	if (prev_insn_idx)
@@ -887,6 +903,7 @@ static struct bpf_verifier_state *push_stack(struct b=
pf_verifier_env *env,
 	elem->insn_idx =3D insn_idx;
 	elem->prev_insn_idx =3D prev_insn_idx;
 	elem->next =3D env->head;
+	elem->log_pos =3D env->log.len_used;
 	env->head =3D elem;
 	env->stack_size++;
 	err =3D copy_verifier_state(&elem->st, cur);
@@ -915,7 +932,7 @@ static struct bpf_verifier_state *push_stack(struct b=
pf_verifier_env *env,
 	free_verifier_state(env->cur_state, true);
 	env->cur_state =3D NULL;
 	/* pop all elements and return */
-	while (!pop_stack(env, NULL, NULL));
+	while (!pop_stack(env, NULL, NULL, false));
 	return NULL;
 }
=20
@@ -8399,6 +8416,7 @@ static bool reg_type_mismatch(enum bpf_reg_type src=
, enum bpf_reg_type prev)
=20
 static int do_check(struct bpf_verifier_env *env)
 {
+	bool pop_log =3D !(env->log.level & BPF_LOG_LEVEL2);
 	struct bpf_verifier_state *state =3D env->cur_state;
 	struct bpf_insn *insns =3D env->prog->insnsi;
 	struct bpf_reg_state *regs;
@@ -8675,7 +8693,7 @@ static int do_check(struct bpf_verifier_env *env)
 process_bpf_exit:
 				update_branch_counts(env, env->cur_state);
 				err =3D pop_stack(env, &prev_insn_idx,
-						&env->insn_idx);
+						&env->insn_idx, pop_log);
 				if (err < 0) {
 					if (err !=3D -ENOENT)
 						return err;
@@ -10198,6 +10216,7 @@ static void sanitize_insn_aux_data(struct bpf_ver=
ifier_env *env)
=20
 static int do_check_common(struct bpf_verifier_env *env, int subprog)
 {
+	bool pop_log =3D !(env->log.level & BPF_LOG_LEVEL2);
 	struct bpf_verifier_state *state;
 	struct bpf_reg_state *regs;
 	int ret, i;
@@ -10260,7 +10279,9 @@ static int do_check_common(struct bpf_verifier_en=
v *env, int subprog)
 		free_verifier_state(env->cur_state, true);
 		env->cur_state =3D NULL;
 	}
-	while (!pop_stack(env, NULL, NULL));
+	while (!pop_stack(env, NULL, NULL, false));
+	if (!ret && pop_log)
+		bpf_vlog_reset(&env->log, 0);
 	free_states(env);
 	if (ret)
 		/* clean aux data in case subprog was rejected */
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/=
selftests/bpf/test_verifier.c
index 87eaa49609a0..ad6939c67c5e 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -943,7 +943,12 @@ static void do_test_single(struct bpf_test *test, bo=
ol unpriv,
 	attr.insns =3D prog;
 	attr.insns_cnt =3D prog_len;
 	attr.license =3D "GPL";
-	attr.log_level =3D verbose || expected_ret =3D=3D VERBOSE_ACCEPT ? 1 : =
4;
+	if (verbose)
+		attr.log_level =3D 1;
+	else if (expected_ret =3D=3D VERBOSE_ACCEPT)
+		attr.log_level =3D 2;
+	else
+		attr.log_level =3D 4;
 	attr.prog_flags =3D pflags;
=20
 	fd_prog =3D bpf_load_program_xattr(&attr, bpf_vlog, sizeof(bpf_vlog));
--=20
2.24.1

