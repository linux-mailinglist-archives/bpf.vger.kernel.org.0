Return-Path: <bpf+bounces-66-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64BA6F79FD
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 02:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3133A1C21426
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AC9139C;
	Fri,  5 May 2023 00:10:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA6A1108
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 00:10:07 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FFB12EBA
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 17:10:04 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 344JKZgJ013476
	for <bpf@vger.kernel.org>; Thu, 4 May 2023 17:10:03 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3qccq04mav-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 04 May 2023 17:10:03 -0700
Received: from twshared35445.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 17:09:36 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id C68713002FB81; Thu,  4 May 2023 17:09:32 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 08/10] bpf: support precision propagation in the presence of subprogs
Date: Thu, 4 May 2023 17:09:06 -0700
Message-ID: <20230505000908.1265044-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505000908.1265044-1-andrii@kernel.org>
References: <20230505000908.1265044-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mK1eMhVY_kgh6asi9nv9rXhRWVsKYNm1
X-Proofpoint-GUID: mK1eMhVY_kgh6asi9nv9rXhRWVsKYNm1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support precision backtracking in the presence of subprogram frames i=
n
jump history.

This means supporting a few different kinds of subprogram invocation
situations, all requiring a slightly different handling in precision
backtracking handling logic:
  - static subprogram calls;
  - global subprogram calls;
  - callback-calling helpers/kfuncs.

For each of those we need to handle a few precision propagation cases:
  - what to do with precision of subprog returns (r0);
  - what to do with precision of input arguments;
  - for all of them callee-saved registers in caller function should be
    propagated ignoring subprog/callback part of jump history.

N.B. Async callback-calling helpers (currently only
bpf_timer_set_callback()) are transparent to all this because they set
a separate async callback environment and thus callback's history is not
shared with main program's history. So as far as all the changes in this
commit goes, such helper is just a regular helper.

Let's look at all these situation in more details. Let's start with
static subprogram being called, using an exxerpt of a simple main
program and its static subprog, indenting subprog's frame slightly to
make everything clear.

frame 0				frame 1			precision set
=3D=3D=3D=3D=3D=3D=3D				=3D=3D=3D=3D=3D=3D=3D			=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

 9: r6 =3D 456;
10: r1 =3D 123;						fr0: r6
11: call pc+10;						fr0: r1, r6
				22: r0 =3D r1;		fr0: r6;     fr1: r1
				23: exit		fr0: r6;     fr1: r0
12: r1 =3D <map_pointer>					fr0: r0, r6
13: r1 +=3D r0;						fr0: r0, r6
14: r1 +=3D r6;						fr0: r6
15: exit

As can be seen above main function is passing 123 as single argument to
an identity (`return x;`) subprog. Returned value is used to adjust map
pointer offset, which forces r0 to be marked as precise. Then
instruction #14 does the same for callee-saved r6, which will have to be
backtracked all the way to instruction #9. For brevity, precision sets
for instruction #13 and #14 are combined in the diagram above.

First, for subprog calls, r0 returned from subprog (in frame 0) has to
go into subprog's frame 1, and should be cleared from frame 0. So we go
back into subprog's frame knowing we need to mark r0 precise. We then
see that insn #22 sets r0 from r1, so now we care about marking r1
precise.  When we pop up from subprog's frame back into caller at
insn #11 we keep r1, as it's an argument-passing register, so we eventual=
ly
find `10: r1 =3D 123;` and satify precision propagation chain for insn #1=
3.

This example demonstrates two sets of rules:
  - r0 returned after subprog call has to be moved into subprog's r0 set;
  - *static* subprog arguments (r1-r5) are moved back to caller precision=
 set.

Let's look at what happens with callee-saved precision propagation. Insn =
#14
mark r6 as precise. When we get into subprog's frame, we keep r6 in
frame 0's precision set *only*. Subprog itself has its own set of
independent r6-r10 registers and is not affected. When we eventually
made our way out of subprog frame we keep r6 in precision set until we
reach `9: r6 =3D 456;`, satisfying propagation. r6-r10 propagation is
perhaps the simplest aspect, it always stays in its original frame.

That's pretty much all we have to do to support precision propagation
across *static subprog* invocation.

Let's look at what happens when we have global subprog invocation.

frame 0				frame 1			precision set
=3D=3D=3D=3D=3D=3D=3D				=3D=3D=3D=3D=3D=3D=3D			=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

 9: r6 =3D 456;
10: r1 =3D 123;						fr0: r6
11: call pc+10; # global subprog			fr0: r6
12: r1 =3D <map_pointer>					fr0: r0, r6
13: r1 +=3D r0;						fr0: r0, r6
14: r1 +=3D r6;						fr0: r6;
15: exit

Starting from insn #13, r0 has to be precise. We backtrack all the way
to insn #11 (call pc+10) and see that subprog is global, so was already
validated in isolation. As opposed to static subprog, global subprog
always returns unknown scalar r0, so that satisfies precision
propagation and we drop r0 from precision set. We are done for insns #13.

Now for insn #14. r6 is in precision set, we backtrack to `call pc+10;`.
Here we need to recognize that this is effectively both exit and entry
to global subprog, which means we stay in caller's frame. So we carry on
with r6 still in precision set, until we satisfy it at insn #9. The only
hard part with global subprogs is just knowing when it's a global func.

Lastly, callback-calling helpers and kfuncs do simulate subprog calls,
so jump history will have subprog instructions in between caller
program's instructions, but the rules of propagating r0 and r1-r5
differ, because we don't actually directly call callback. We actually
call helper/kfunc, which at runtime will call subprog, so the only
difference between normal helper/kfunc handling is that we need to make
sure to skip callback simulatinog part of jump history.
Let's look at an example to make this clearer.

frame 0				frame 1			precision set
=3D=3D=3D=3D=3D=3D=3D				=3D=3D=3D=3D=3D=3D=3D			=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

 8: r6 =3D 456;
 9: r1 =3D 123;						fr0: r6
10: r2 =3D &callback;					fr0: r6
11: call bpf_loop;					fr0: r6
				22: r0 =3D r1;		fr0: r6      fr1:
				23: exit		fr0: r6      fr1:
12: r1 =3D <map_pointer>					fr0: r0, r6
13: r1 +=3D r0;						fr0: r0, r6
14: r1 +=3D r6;						fr0: r6;
15: exit

Again, insn #13 forces r0 to be precise. As soon as we get to `23: exit`
we see that this isn't actually a static subprog call (it's `call
bpf_loop;` helper call instead). So we clear r0 from precision set.

For callee-saved register, there is no difference: it stays in frame 0's
precision set, we go through insn #22 and #23, ignoring them until we
get back to caller frame 0, eventually satisfying precision backtrack
logic at insn #8 (`r6 =3D 456;`).

Assuming callback needed to set r0 as precise at insn #23, we'd
backtrack to insn #22, switching from r0 to r1, and then at the point
when we pop back to frame 0 at insn #11, we'll clear r1-r5 from
precision set, as we don't really do a subprog call directly, so there
is no input argument precision propagation.

That's pretty much it. With these changes, it seems like the only still
unsupported situation for precision backpropagation is the case when
program is accessing stack through registers other than r10. This is
still left as unsupported (though rare) case for now.

As for results. For selftests, few positive changes for bigger programs,
cls_redirect in dynptr variant benefitting the most:

[vmuser@archvm bpf]$ ./veristat -C ~/subprog-precise-before-results.csv ~=
/subprog-precise-after-results.csv -f @veristat.cfg -e file,prog,insns -f=
 'insns_diff!=3D0'
File                                      Program        Insns (A)  Insns=
 (B)  Insns     (DIFF)
----------------------------------------  -------------  ---------  -----=
----  ----------------
pyperf600_bpf_loop.bpf.linked1.o          on_event            2060       =
2002      -58 (-2.82%)
test_cls_redirect_dynptr.bpf.linked1.o    cls_redirect       15660       =
2914  -12746 (-81.39%)
test_cls_redirect_subprogs.bpf.linked1.o  cls_redirect       61620      5=
9088    -2532 (-4.11%)
xdp_synproxy_kern.bpf.linked1.o           syncookie_tc      109980      8=
6278  -23702 (-21.55%)
xdp_synproxy_kern.bpf.linked1.o           syncookie_xdp      97716      8=
5147  -12569 (-12.86%)

Cilium progress don't really regress. They don't use subprogs and are
mostly unaffected, but some other fixes and improvements could have
changed something. This doesn't appear to be the case:

[vmuser@archvm bpf]$ ./veristat -C ~/subprog-precise-before-results-ciliu=
m.csv ~/subprog-precise-after-results-cilium.csv -e file,prog,insns -f 'i=
nsns_diff!=3D0'
File           Program                         Insns (A)  Insns (B)  Insn=
s (DIFF)
-------------  ------------------------------  ---------  ---------  ----=
--------
bpf_host.o     tail_nodeport_nat_ingress_ipv6       4983       5003  +20 =
(+0.40%)
bpf_lxc.o      tail_nodeport_nat_ingress_ipv6       4983       5003  +20 =
(+0.40%)
bpf_overlay.o  tail_nodeport_nat_ingress_ipv6       4983       5003  +20 =
(+0.40%)
bpf_xdp.o      tail_handle_nat_fwd_ipv6            12475      12504  +29 =
(+0.23%)
bpf_xdp.o      tail_nodeport_nat_ingress_ipv6       6363       6371   +8 =
(+0.13%)

Looking at (somewhat anonymized) Meta production programs, we see mostly
insignificant variation in number of instructions, with one program
(syar_bind6_protect6) benefitting the most at -17%.

[vmuser@archvm bpf]$ ./veristat -C ~/subprog-precise-before-results-fbcod=
e.csv ~/subprog-precise-after-results-fbcode.csv -e prog,insns -f 'insns_=
diff!=3D0'
Program                   Insns (A)  Insns (B)  Insns     (DIFF)
------------------------  ---------  ---------  ----------------
on_request_context_event        597        585      -12 (-2.01%)
read_async_py_stack           43789      43657     -132 (-0.30%)
read_sync_py_stack            35041      37599    +2558 (+7.30%)
rrm_usdt                        946        940       -6 (-0.63%)
sysarmor_inet6_bind           28863      28249     -614 (-2.13%)
sysarmor_inet_bind            28845      28240     -605 (-2.10%)
syar_bind4_protect4          154145     147640    -6505 (-4.22%)
syar_bind6_protect6          165242     137088  -28154 (-17.04%)
syar_task_exit_setgid         21289      19720    -1569 (-7.37%)
syar_task_exit_setuid         21290      19721    -1569 (-7.37%)
do_uprobe                     19967      19413     -554 (-2.77%)
tw_twfw_ingress              215877     204833   -11044 (-5.12%)
tw_twfw_tc_in                215877     204833   -11044 (-5.12%)

But checking duration (wall clock) differences, that is the actual time t=
aken
by verifier to validate programs, we see a sometimes dramatic improvement=
s, all
the way to about 16x improvements:

[vmuser@archvm bpf]$ ./veristat -C ~/subprog-precise-before-results-meta.=
csv ~/subprog-precise-after-results-meta.csv -e prog,duration -s duration=
_diff^ | head -n20
Program                                   Duration (us) (A)  Duration (us=
) (B)  Duration (us) (DIFF)
----------------------------------------  -----------------  ------------=
-----  --------------------
tw_twfw_ingress                                     4488374             2=
72836    -4215538 (-93.92%)
tw_twfw_tc_in                                       4339111             2=
68175    -4070936 (-93.82%)
tw_twfw_egress                                      3521816             2=
70751    -3251065 (-92.31%)
tw_twfw_tc_eg                                       3472878             2=
84294    -3188584 (-91.81%)
balancer_ingress                                     343119             2=
91391      -51728 (-15.08%)
syar_bind6_protect6                                   78992              =
64782      -14210 (-17.99%)
ttls_tc_ingress                                       11739              =
 8176       -3563 (-30.35%)
kprobe__security_inode_link                           13864              =
11341       -2523 (-18.20%)
read_sync_py_stack                                    21927              =
19442       -2485 (-11.33%)
read_async_py_stack                                   30444              =
28136        -2308 (-7.58%)
syar_task_exit_setuid                                 10256              =
 8440       -1816 (-17.71%)

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 163 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 143 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dabfa137c29e..6c3636acd533 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -240,6 +240,12 @@ static void bpf_map_key_store(struct bpf_insn_aux_da=
ta *aux, u64 state)
 			     (poisoned ? BPF_MAP_KEY_POISON : 0ULL);
 }
=20
+static bool bpf_helper_call(const struct bpf_insn *insn)
+{
+	return insn->code =3D=3D (BPF_JMP | BPF_CALL) &&
+	       insn->src_reg =3D=3D 0;
+}
+
 static bool bpf_pseudo_call(const struct bpf_insn *insn)
 {
 	return insn->code =3D=3D (BPF_JMP | BPF_CALL) &&
@@ -469,6 +475,13 @@ static struct btf_record *reg_btf_record(const struc=
t bpf_reg_state *reg)
 	return rec;
 }
=20
+static bool subprog_is_global(const struct bpf_verifier_env *env, int su=
bprog)
+{
+	struct bpf_func_info_aux *aux =3D env->prog->aux->func_info_aux;
+
+	return aux && aux[subprog].linkage =3D=3D BTF_FUNC_GLOBAL;
+}
+
 static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 {
 	return btf_record_has_field(reg_btf_record(reg), BPF_SPIN_LOCK);
@@ -516,6 +529,8 @@ static bool is_dynptr_ref_function(enum bpf_func_id f=
unc_id)
 	return func_id =3D=3D BPF_FUNC_dynptr_data;
 }
=20
+static bool is_callback_calling_kfunc(u32 btf_id);
+
 static bool is_callback_calling_function(enum bpf_func_id func_id)
 {
 	return func_id =3D=3D BPF_FUNC_for_each_map_elem ||
@@ -525,6 +540,11 @@ static bool is_callback_calling_function(enum bpf_fu=
nc_id func_id)
 	       func_id =3D=3D BPF_FUNC_user_ringbuf_drain;
 }
=20
+static bool is_async_callback_calling_function(enum bpf_func_id func_id)
+{
+	return func_id =3D=3D BPF_FUNC_timer_set_callback;
+}
+
 static bool is_storage_get_function(enum bpf_func_id func_id)
 {
 	return func_id =3D=3D BPF_FUNC_sk_storage_get ||
@@ -3366,8 +3386,13 @@ static void fmt_stack_mask(char *buf, ssize_t buf_=
sz, u64 stack_mask)
 /* For given verifier state backtrack_insn() is called from the last ins=
n to
  * the first insn. Its purpose is to compute a bitmask of registers and
  * stack slots that needs precision in the parent verifier state.
+ *
+ * @idx is an index of the instruction we are currently processing;
+ * @subseq_idx is an index of the subsequent instruction that:
+ *   - *would be* executed next, if jump history is viewed in forward or=
der;
+ *   - *was* processed previously during backtracking.
  */
-static int backtrack_insn(struct bpf_verifier_env *env, int idx,
+static int backtrack_insn(struct bpf_verifier_env *env, int idx, int sub=
seq_idx,
 			  struct backtrack_state *bt)
 {
 	const struct bpf_insn_cbs cbs =3D {
@@ -3381,7 +3406,7 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx,
 	u8 mode =3D BPF_MODE(insn->code);
 	u32 dreg =3D insn->dst_reg;
 	u32 sreg =3D insn->src_reg;
-	u32 spi;
+	u32 spi, i;
=20
 	if (insn->code =3D=3D 0)
 		return 0;
@@ -3473,14 +3498,86 @@ static int backtrack_insn(struct bpf_verifier_env=
 *env, int idx,
 		if (class =3D=3D BPF_STX)
 			bt_set_reg(bt, sreg);
 	} else if (class =3D=3D BPF_JMP || class =3D=3D BPF_JMP32) {
-		if (opcode =3D=3D BPF_CALL) {
-			if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
-				return -ENOTSUPP;
-			/* BPF helpers that invoke callback subprogs are
-			 * equivalent to BPF_PSEUDO_CALL above
+		if (bpf_pseudo_call(insn)) {
+			int subprog_insn_idx, subprog;
+
+			subprog_insn_idx =3D idx + insn->imm + 1;
+			subprog =3D find_subprog(env, subprog_insn_idx);
+			if (subprog < 0)
+				return -EFAULT;
+
+			if (subprog_is_global(env, subprog)) {
+				/* check that jump history doesn't have any
+				 * extra instructions from subprog; the next
+				 * instruction after call to global subprog
+				 * should be literally next instruction in
+				 * caller program
+				 */
+				WARN_ONCE(idx + 1 !=3D subseq_idx, "verifier backtracking bug");
+				/* r1-r5 are invalidated after subprog call,
+				 * so for global func call it shouldn't be set
+				 * anymore
+				 */
+				if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
+					verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
+					WARN_ONCE(1, "verifier backtracking bug");
+					return -EFAULT;
+				}
+				/* global subprog always sets R0 */
+				bt_clear_reg(bt, BPF_REG_0);
+				return 0;
+			} else {
+				/* static subprog call instruction, which
+				 * means that we are exiting current subprog,
+				 * so only r1-r5 could be still requested as
+				 * precise, r0 and r6-r10 or any stack slot in
+				 * the current frame should be zero by now
+				 */
+				if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
+					verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
+					WARN_ONCE(1, "verifier backtracking bug");
+					return -EFAULT;
+				}
+				/* we don't track register spills perfectly,
+				 * so fallback to force-precise instead of failing */
+				if (bt_stack_mask(bt) !=3D 0)
+					return -ENOTSUPP;
+				/* propagate r1-r5 to the caller */
+				for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++) {
+					if (bt_is_reg_set(bt, i)) {
+						bt_clear_reg(bt, i);
+						bt_set_frame_reg(bt, bt->frame - 1, i);
+					}
+				}
+				if (bt_subprog_exit(bt))
+					return -EFAULT;
+				return 0;
+			}
+		} else if ((bpf_helper_call(insn) &&
+			    is_callback_calling_function(insn->imm) &&
+			    !is_async_callback_calling_function(insn->imm)) ||
+			   (bpf_pseudo_kfunc_call(insn) && is_callback_calling_kfunc(insn->im=
m))) {
+			/* callback-calling helper or kfunc call, which means
+			 * we are exiting from subprog, but unlike the subprog
+			 * call handling above, we shouldn't propagate
+			 * precision of r1-r5 (if any requested), as they are
+			 * not actually arguments passed directly to callback
+			 * subprogs
 			 */
-			if (insn->src_reg =3D=3D 0 && is_callback_calling_function(insn->imm)=
)
+			if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
+				verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
+				WARN_ONCE(1, "verifier backtracking bug");
+				return -EFAULT;
+			}
+			if (bt_stack_mask(bt) !=3D 0)
 				return -ENOTSUPP;
+			/* clear r1-r5 in callback subprog's mask */
+			for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
+				bt_clear_reg(bt, i);
+			if (bt_subprog_exit(bt))
+				return -EFAULT;
+			return 0;
+		} else if (opcode =3D=3D BPF_CALL) {
 			/* kfunc with imm=3D=3D0 is invalid and fixup_kfunc_call will
 			 * catch this error later. Make backtracking conservative
 			 * with ENOTSUPP.
@@ -3498,7 +3595,39 @@ static int backtrack_insn(struct bpf_verifier_env =
*env, int idx,
 				return -EFAULT;
 			}
 		} else if (opcode =3D=3D BPF_EXIT) {
-			return -ENOTSUPP;
+			bool r0_precise;
+
+			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
+				/* if backtracing was looking for registers R1-R5
+				 * they should have been found already.
+				 */
+				verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
+				WARN_ONCE(1, "verifier backtracking bug");
+				return -EFAULT;
+			}
+
+			/* BPF_EXIT in subprog or callback always returns
+			 * right after the call instruction, so by checking
+			 * whether the instruction at subseq_idx-1 is subprog
+			 * call or not we can distinguish actual exit from
+			 * *subprog* from exit from *callback*. In the former
+			 * case, we need to propagate r0 precision, if
+			 * necessary. In the former we never do that.
+			 */
+			r0_precise =3D subseq_idx - 1 >=3D 0 &&
+				     bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]) &&
+				     bt_is_reg_set(bt, BPF_REG_0);
+
+			bt_clear_reg(bt, BPF_REG_0);
+			if (bt_subprog_enter(bt))
+				return -EFAULT;
+
+			if (r0_precise)
+				bt_set_reg(bt, BPF_REG_0);
+			/* r6-r9 and stack slots will stay set in caller frame
+			 * bitmasks until we return back from callee(s)
+			 */
+			return 0;
 		} else if (BPF_SRC(insn->code) =3D=3D BPF_X) {
 			if (!bt_is_reg_set(bt, dreg) && !bt_is_reg_set(bt, sreg))
 				return 0;
@@ -3751,7 +3880,7 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno)
 	struct bpf_func_state *func;
 	struct bpf_reg_state *reg;
 	bool skip_first =3D true;
-	int i, fr, err;
+	int i, prev_i, fr, err;
=20
 	if (!env->bpf_capable)
 		return 0;
@@ -3814,12 +3943,12 @@ static int __mark_chain_precision(struct bpf_veri=
fier_env *env, int regno)
 			return -EFAULT;
 		}
=20
-		for (i =3D last_idx;;) {
+		for (i =3D last_idx, prev_i =3D -1;;) {
 			if (skip_first) {
 				err =3D 0;
 				skip_first =3D false;
 			} else {
-				err =3D backtrack_insn(env, i, bt);
+				err =3D backtrack_insn(env, i, prev_i, bt);
 			}
 			if (err =3D=3D -ENOTSUPP) {
 				mark_all_scalars_precise(env, env->cur_state);
@@ -3836,6 +3965,7 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno)
 				return 0;
 			if (i =3D=3D first_idx)
 				break;
+			prev_i =3D i;
 			i =3D get_prev_insn_idx(st, i, &history);
 			if (i >=3D env->prog->len) {
 				/* This can happen if backtracking reached insn 0
@@ -8416,17 +8546,13 @@ static int set_callee_state(struct bpf_verifier_e=
nv *env,
 			    struct bpf_func_state *caller,
 			    struct bpf_func_state *callee, int insn_idx);
=20
-static bool is_callback_calling_kfunc(u32 btf_id);
-
 static int __check_func_call(struct bpf_verifier_env *env, struct bpf_in=
sn *insn,
 			     int *insn_idx, int subprog,
 			     set_callee_state_fn set_callee_state_cb)
 {
 	struct bpf_verifier_state *state =3D env->cur_state;
-	struct bpf_func_info_aux *func_info_aux;
 	struct bpf_func_state *caller, *callee;
 	int err;
-	bool is_global =3D false;
=20
 	if (state->curframe + 1 >=3D MAX_CALL_FRAMES) {
 		verbose(env, "the call stack of %d frames is too deep\n",
@@ -8441,13 +8567,10 @@ static int __check_func_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
 		return -EFAULT;
 	}
=20
-	func_info_aux =3D env->prog->aux->func_info_aux;
-	if (func_info_aux)
-		is_global =3D func_info_aux[subprog].linkage =3D=3D BTF_FUNC_GLOBAL;
 	err =3D btf_check_subprog_call(env, subprog, caller->regs);
 	if (err =3D=3D -EFAULT)
 		return err;
-	if (is_global) {
+	if (subprog_is_global(env, subprog)) {
 		if (err) {
 			verbose(env, "Caller passes invalid args into func#%d\n",
 				subprog);
--=20
2.34.1


