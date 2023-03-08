Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D10E6AFDA6
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 04:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCHDye convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 7 Mar 2023 22:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCHDyd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 22:54:33 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D3197490
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 19:54:29 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3281EJXn019093
        for <bpf@vger.kernel.org>; Tue, 7 Mar 2023 19:54:28 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p6ffw14ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 19:54:28 -0800
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Mar 2023 19:54:27 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id EC609298A5530; Tue,  7 Mar 2023 19:54:23 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 bpf-next 3/8] bpf: add support for open-coded iterator loops
Date:   Tue, 7 Mar 2023 19:54:11 -0800
Message-ID: <20230308035416.2591326-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308035416.2591326-1-andrii@kernel.org>
References: <20230308035416.2591326-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: FfJqWsHmOtX-gtRsIqf-4_uJ6M-DWTkz
X-Proofpoint-ORIG-GUID: FfJqWsHmOtX-gtRsIqf-4_uJ6M-DWTkz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_18,2023-03-07_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Teach verifier about the concept of open-coded (or inline) iterators.

This patch adds generic iterator loop verification logic, new STACK_ITER
stack slot type to contain iterator state, and necessary kfunc plumbing
for iterator's constructor, destructor and next "methods". Next patch
implements first specific version of iterator (number iterator for
implementing for loop). Such split allows to have more focused commits
for verifier logic and separate commit that we could point later to what
it takes to add new kind of iterator.

Each kind of iterators has its own associated struct bpf_iter_<type>,
where <type> specifies a specific type of iterator. struct
bpf_iter_<type> state is supposed to be on BPF program's stack, so there
will be no way to change its size later on without breaking backwards
compatibility, so choose wisely! But given it's specific to a given
<type> of iterator, this allows a lot of flexibility: simple iterators
could be fine with just one stack slot (8 bytes), like numbers iterator
in the next patch. While some other more complicated iterators would
need way more to keep their iterator state. Either way, such design
allows to avoid runtime memory allocations, which otherwise would be
necessary if fixed on-the-stack size turns out too small.

The way BPF verifier logic is implemented, there are no artificial
restrictions on a number of active iterators, it should work correctly
using multiple at the same time. This also means you can have multiple
nested iteration loops. struct bpf_iter_<type> reference can be safely
passed to subprograms as well.

General flow is easiest to demonstrate with a simple example using
number iterator implemented in next patch. Here's the simplest possible
loop:

  struct bpf_iter_num it;
  int *v;

  bpf_iter_num_new(&it, 2, 5);
  while ((v = bpf_iter_num_next(&it))) {
      bpf_printk("X = %d", *v);
  }
  bpf_iter_num_destroy(&it);

Above snippet should output "X = 2", "X = 3", "X = 4". Note that 5 is
exclusive and is not returned. This matches similar APIs (e.g., slices
in Go or Rust) that implement a range of elements, where end index is
non-inclusive.

In the above example, we see a trio of function:
  - constructor, bpf_iter_num_new(), which initializes iterator state
  (struct bpf_iter_num it) on the stack. If any on the input arguments
  are invalid, constructor should make sure to still initialize it such
  that subsequent bpf_iter_num_next() calls will return NULL. I.e., on
  error, return error and construct empty iterator.
  - next method, bpf_iter_num_next(), which accepts pointer to iterator
  state and produces an element. Next method should always return
  a pointer. The contract between BPF verifier is that next method will
  always eventually return NULL when elements are exhausted. One NULL is
  returned, subsequent next calls should keep returning NULL. In the
  case of numbers iterator, bpf_iter_num_next() returns a pointer to int
  (where current integer value itself is stored inside iterator state),
  which can be dereferenced after according NULL check.
  - once done with the iterator, it's mandated that user cleans up its
  state with destructor, bpf_iter_num_destroy() in this case. Destructor
  frees up any resources and marks stack space used by struct
  bpf_iter_num as usable for something else.

Any other iterator implementation will have to implement at least these
three methods. It is enforced that for any given type of iterator only
applicable constructor/destructor/next are callable. I.e., verifier
ensures you can't pass number iterator state into, say, cgroup
iterator's next method.

It is important to keep naming consistent to be able to create generic
helpers/macros to help with bpf_iter usability. E.g., one of the follow
up patches adds generic bpf_for_each() macro to bpf_misc.h in selftests,
which allows to utilize iterator "trio" nicely without having to code
the above somewhat tedious loop explicitly every time. This is enforced
at kfunc registration point by one of the previous patches in this series.

At the implementation level, iterator state tracking for verification
purposes is very similar to dynptr. We add STACK_ITER stack slot type,
reserve necessary number of slots, depending on sizeof(struct
bpf_iter_<type>), and keep track of necessary extra state in the "main"
slot, which is marked with non-zero ref_obj_id.  Other slots are also
marked as STACK_ITER, but have zero ref_obj_id.  This is simpler than
having a separate "is_first_slot" flag.

Another big distinction is that STACK_ITER is *always refcounted*, which
simplifies implementation without sacrificing usability. So no need for
extra "iter_id", no need to anticipate reuse of STACK_ITER slots for new
constructors, etc. Keeping it simpler here.

As far as verification logic, there are two extensive comments, in
process_iter_next_call() and iter_active_depths_differ(), please refer
to them for details.

But from 10,000-foot point of view, next methods are the points of
forking, which are conceptually similar to what verifier is doing when
validating conditional jump. We branch out at call bpf_iter_<type>_next
instruction and simulate two situations: NULL (iteration is done) and
non-NULL (new element returned). NULL is simulated first and is supposed
to reach exit without looping. After that non-NULL case is validated and
it either reaches exit (for trivial examples with no real loop), or
reaches another call bpf_iter_<type>_next instruction with the state
equivalent to already (partially) validated one. State equivalency at
that point means we technically are going to be looping forever without
"breaking out" out of established "state envelope" (i.e., subsequent
iterations don't add any new knowledge or constraints to verifier state,
so running 1, 2, 10, or a million doesn't matter). But taking into
account the contract stating that iterator next method *has to* return
NULL eventually, we can conclude that loop body is safe and will
eventually terminate. Given we validated logic outside of the loop (NULL
case), and concluded that loop body is safe (though potentially looping
many times), verifier can claim safety of the overall program logic.

The rest of the patch is necessary plumbing for state tracking, marking,
validation, and necessary kfunc infrastructure to allow implementing
iterator constructor, destructor, and next methods.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h |  25 +-
 kernel/bpf/verifier.c        | 592 ++++++++++++++++++++++++++++++++++-
 2 files changed, 608 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e2dc7f064449..d0483aed2580 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -61,6 +61,12 @@ struct bpf_active_lock {
 
 #define ITER_PREFIX "bpf_iter_"
 
+enum bpf_iter_state {
+	BPF_ITER_STATE_INVALID, /* for non-first slot */
+	BPF_ITER_STATE_ACTIVE,
+	BPF_ITER_STATE_DRAINED,
+};
+
 struct bpf_reg_state {
 	/* Ordering of fields matters.  See states_equal() */
 	enum bpf_reg_type type;
@@ -105,6 +111,18 @@ struct bpf_reg_state {
 			bool first_slot;
 		} dynptr;
 
+		/* For bpf_iter stack slots */
+		struct {
+			/* BTF container and BTF type ID describing
+			 * struct bpf_iter_<type> of an iterator state
+			 */
+			struct btf *btf;
+			u32 btf_id;
+			/* packing following two fields to fit iter state into 16 bytes */
+			enum bpf_iter_state state:2;
+			int depth:30;
+		} iter;
+
 		/* Max size from any of the above. */
 		struct {
 			unsigned long raw1;
@@ -143,6 +161,8 @@ struct bpf_reg_state {
 	 * same reference to the socket, to determine proper reference freeing.
 	 * For stack slots that are dynptrs, this is used to track references to
 	 * the dynptr to determine proper reference freeing.
+	 * Similarly to dynptrs, we use ID to track "belonging" of a reference
+	 * to a specific instance of bpf_iter.
 	 */
 	u32 id;
 	/* PTR_TO_SOCKET and PTR_TO_TCP_SOCK could be a ptr returned
@@ -213,11 +233,13 @@ enum bpf_stack_slot_type {
 	 * is stored in bpf_stack_state->spilled_ptr.dynptr.type
 	 */
 	STACK_DYNPTR,
+	STACK_ITER,
 };
 
 #define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
+
 #define BPF_DYNPTR_SIZE		sizeof(struct bpf_dynptr_kern)
-#define BPF_DYNPTR_NR_SLOTS		(BPF_DYNPTR_SIZE / BPF_REG_SIZE)
+#define BPF_DYNPTR_NR_SLOTS	(BPF_DYNPTR_SIZE / BPF_REG_SIZE)
 
 struct bpf_stack_state {
 	struct bpf_reg_state spilled_ptr;
@@ -450,6 +472,7 @@ struct bpf_insn_aux_data {
 	bool sanitize_stack_spill; /* subject to Spectre v4 sanitation */
 	bool zext_dst; /* this insn zero extends dst reg */
 	bool storage_get_func_atomic; /* bpf_*_storage_get() with atomic memory alloc */
+	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
 	u8 alu_state; /* used in combination with alu_limit */
 
 	/* below fields are initialized once */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8d40fba6a1c0..6b9f9513a314 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -302,6 +302,10 @@ struct bpf_kfunc_call_arg_meta {
 		enum bpf_dynptr_type type;
 		u32 id;
 	} initialized_dynptr;
+	struct {
+		u8 spi;
+		u8 frameno;
+	} iter;
 	u64 mem_size;
 };
 
@@ -668,6 +672,7 @@ static char slot_type_char[] = {
 	[STACK_MISC]	= 'm',
 	[STACK_ZERO]	= '0',
 	[STACK_DYNPTR]	= 'd',
+	[STACK_ITER]	= 'i',
 };
 
 static void print_liveness(struct bpf_verifier_env *env,
@@ -742,6 +747,11 @@ static int dynptr_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *re
 	return stack_slot_obj_get_spi(env, reg, "dynptr", BPF_DYNPTR_NR_SLOTS);
 }
 
+static int iter_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int nr_slots)
+{
+	return stack_slot_obj_get_spi(env, reg, "iter", nr_slots);
+}
+
 static const char *kernel_type_name(const struct btf* btf, u32 id)
 {
 	return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
@@ -766,6 +776,30 @@ static const char *dynptr_type_str(enum bpf_dynptr_type type)
 	}
 }
 
+static const char *iter_type_str(const struct btf *btf, u32 btf_id)
+{
+	if (!btf || btf_id == 0)
+		return "<invalid>";
+
+	/* we already validated that type is valid and has conforming name */
+	return kernel_type_name(btf, btf_id) + sizeof(ITER_PREFIX) - 1;
+}
+
+static const char *iter_state_str(enum bpf_iter_state state)
+{
+	switch (state) {
+	case BPF_ITER_STATE_ACTIVE:
+		return "active";
+	case BPF_ITER_STATE_DRAINED:
+		return "drained";
+	case BPF_ITER_STATE_INVALID:
+		return "<invalid>";
+	default:
+		WARN_ONCE(1, "unknown iter state %d\n", state);
+		return "<unknown>";
+	}
+}
+
 static void mark_reg_scratched(struct bpf_verifier_env *env, u32 regno)
 {
 	env->scratched_regs |= 1U << regno;
@@ -1118,6 +1152,156 @@ static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg
 	}
 }
 
+static void __mark_reg_known_zero(struct bpf_reg_state *reg);
+
+static int mark_stack_slots_iter(struct bpf_verifier_env *env,
+				 struct bpf_reg_state *reg, int insn_idx,
+				 struct btf *btf, u32 btf_id, int nr_slots)
+{
+	struct bpf_func_state *state = func(env, reg);
+	int spi, i, j, id;
+
+	spi = iter_get_spi(env, reg, nr_slots);
+	if (spi < 0)
+		return spi;
+
+	id = acquire_reference_state(env, insn_idx);
+	if (id < 0)
+		return id;
+
+	for (i = 0; i < nr_slots; i++) {
+		struct bpf_stack_state *slot = &state->stack[spi - i];
+		struct bpf_reg_state *st = &slot->spilled_ptr;
+
+		__mark_reg_known_zero(st);
+		st->type = PTR_TO_STACK; /* we don't have dedicated reg type */
+		st->live |= REG_LIVE_WRITTEN;
+		st->ref_obj_id = i == 0 ? id : 0;
+		st->iter.btf = btf;
+		st->iter.btf_id = btf_id;
+		st->iter.state = BPF_ITER_STATE_ACTIVE;
+		st->iter.depth = 0;
+
+		for (j = 0; j < BPF_REG_SIZE; j++)
+			slot->slot_type[j] = STACK_ITER;
+
+		mark_stack_slot_scratched(env, spi - i);
+	}
+
+	return 0;
+}
+
+static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
+				   struct bpf_reg_state *reg, int nr_slots)
+{
+	struct bpf_func_state *state = func(env, reg);
+	int spi, i, j;
+
+	spi = iter_get_spi(env, reg, nr_slots);
+	if (spi < 0)
+		return spi;
+
+	for (i = 0; i < nr_slots; i++) {
+		struct bpf_stack_state *slot = &state->stack[spi - i];
+		struct bpf_reg_state *st = &slot->spilled_ptr;
+
+		if (i == 0)
+			WARN_ON_ONCE(release_reference(env, st->ref_obj_id));
+
+		__mark_reg_not_init(env, st);
+
+		/* see unmark_stack_slots_dynptr() for why we need to set REG_LIVE_WRITTEN */
+		st->live |= REG_LIVE_WRITTEN;
+
+		for (j = 0; j < BPF_REG_SIZE; j++)
+			slot->slot_type[j] = STACK_INVALID;
+
+		mark_stack_slot_scratched(env, spi - i);
+	}
+
+	return 0;
+}
+
+static bool is_iter_reg_valid_uninit(struct bpf_verifier_env *env,
+				     struct bpf_reg_state *reg, int nr_slots)
+{
+	struct bpf_func_state *state = func(env, reg);
+	int spi, i, j;
+
+	/* For -ERANGE (i.e. spi not falling into allocated stack slots), we
+	 * will do check_mem_access to check and update stack bounds later, so
+	 * return true for that case.
+	 */
+	spi = iter_get_spi(env, reg, nr_slots);
+	if (spi == -ERANGE)
+		return true;
+	if (spi < 0)
+		return spi;
+
+	for (i = 0; i < nr_slots; i++) {
+		struct bpf_stack_state *slot = &state->stack[spi - i];
+
+		if (slot->slot_type[j] == STACK_ITER)
+			return false;
+	}
+
+	return true;
+}
+
+static bool is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				   struct btf *btf, u32 btf_id, int nr_slots)
+{
+	struct bpf_func_state *state = func(env, reg);
+	int spi, i, j;
+
+	spi = iter_get_spi(env, reg, nr_slots);
+	if (spi < 0)
+		return false;
+
+	for (i = 0; i < nr_slots; i++) {
+		struct bpf_stack_state *slot = &state->stack[spi - i];
+		struct bpf_reg_state *st = &slot->spilled_ptr;
+
+		/* only main (first) slot has ref_obj_id set */
+		if (i == 0 && !st->ref_obj_id)
+			return false;
+		if (i != 0 && st->ref_obj_id)
+			return false;
+		if (st->iter.btf != btf || st->iter.btf_id != btf_id)
+			return false;
+
+		for (j = 0; j < BPF_REG_SIZE; j++)
+			if (slot->slot_type[j] != STACK_ITER)
+				return false;
+	}
+
+	return true;
+}
+
+/* Check if given stack slot is "special":
+ *   - spilled register state (STACK_SPILL);
+ *   - dynptr state (STACK_DYNPTR);
+ *   - iter state (STACK_ITER).
+ */
+static bool is_stack_slot_special(const struct bpf_stack_state *stack)
+{
+	enum bpf_stack_slot_type type = stack->slot_type[BPF_REG_SIZE - 1];
+
+	switch (type) {
+	case STACK_SPILL:
+	case STACK_DYNPTR:
+	case STACK_ITER:
+		return true;
+	case STACK_INVALID:
+	case STACK_MISC:
+	case STACK_ZERO:
+		return false;
+	default:
+		WARN_ONCE(1, "unknown stack slot type %d\n", type);
+		return true;
+	}
+}
+
 /* The reg state of a pointer or a bounded scalar was saved when
  * it was spilled to the stack.
  */
@@ -1267,6 +1451,19 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 			if (reg->ref_obj_id)
 				verbose(env, "(ref_id=%d)", reg->ref_obj_id);
 			break;
+		case STACK_ITER:
+			/* only main slot has ref_obj_id set; skip others */
+			reg = &state->stack[i].spilled_ptr;
+			if (!reg->ref_obj_id)
+				continue;
+
+			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
+			print_liveness(env, reg->live);
+			verbose(env, "=iter_%s(ref_id=%d,state=%s,depth=%u)",
+				iter_type_str(reg->iter.btf, reg->iter.btf_id),
+				reg->ref_obj_id, iter_state_str(reg->iter.state),
+				reg->iter.depth);
+			break;
 		case STACK_MISC:
 		case STACK_ZERO:
 		default:
@@ -2710,6 +2907,25 @@ static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *
 			     state->stack[spi - 1].spilled_ptr.parent, REG_LIVE_READ64);
 }
 
+static int mark_iter_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+			  int spi, int nr_slots)
+{
+	struct bpf_func_state *state = func(env, reg);
+	int err, i;
+
+	for (i = 0; i < nr_slots; i++) {
+		struct bpf_reg_state *st = &state->stack[spi - i].spilled_ptr;
+
+		err = mark_reg_read(env, st, st->parent, REG_LIVE_READ64);
+		if (err)
+			return err;
+
+		mark_stack_slot_scratched(env, spi - i);
+	}
+
+	return 0;
+}
+
 /* This function is supposed to be used by the following 32-bit optimization
  * code only. It returns TRUE if the source or destination register operates
  * on 64-bit, otherwise return FALSE.
@@ -3691,8 +3907,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 
 		/* regular write of data into stack destroys any spilled ptr */
 		state->stack[spi].spilled_ptr.type = NOT_INIT;
-		/* Mark slots as STACK_MISC if they belonged to spilled ptr. */
-		if (is_spilled_reg(&state->stack[spi]))
+		/* Mark slots as STACK_MISC if they belonged to spilled ptr/dynptr/iter. */
+		if (is_stack_slot_special(&state->stack[spi]))
 			for (i = 0; i < BPF_REG_SIZE; i++)
 				scrub_spilled_slot(&state->stack[spi].slot_type[i]);
 
@@ -6506,6 +6722,201 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
 	return err;
 }
 
+static u32 iter_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int spi)
+{
+	struct bpf_func_state *state = func(env, reg);
+
+	return state->stack[spi].spilled_ptr.ref_obj_id;
+}
+
+static bool is_iter_kfunc(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY);
+}
+
+static bool is_iter_new_kfunc(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_ITER_NEW;
+}
+
+static bool is_iter_next_kfunc(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_ITER_NEXT;
+}
+
+static bool is_iter_destroy_kfunc(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_ITER_DESTROY;
+}
+
+static bool is_kfunc_arg_iter(struct bpf_kfunc_call_arg_meta *meta, int arg)
+{
+	/* btf_check_iter_kfuncs() guarantees that first argument of any iter
+	 * kfunc is iter state pointer
+	 */
+	return arg == 0 && is_iter_kfunc(meta);
+}
+
+static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_idx,
+			    struct bpf_kfunc_call_arg_meta *meta)
+{
+	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	const struct btf_type *t;
+	const struct btf_param *arg;
+	int spi, err, i, nr_slots;
+	u32 btf_id;
+
+	/* btf_check_iter_kfuncs() ensures we don't need to validate anything here */
+	arg = &btf_params(meta->func_proto)[0];
+	t = btf_type_skip_modifiers(meta->btf, arg->type, NULL);	/* PTR */
+	t = btf_type_skip_modifiers(meta->btf, t->type, &btf_id);	/* STRUCT */
+	nr_slots = t->size / BPF_REG_SIZE;
+
+	spi = iter_get_spi(env, reg, nr_slots);
+	if (spi < 0 && spi != -ERANGE)
+		return spi;
+
+	meta->iter.spi = spi;
+	meta->iter.frameno = reg->frameno;
+
+	if (is_iter_new_kfunc(meta)) {
+		/* bpf_iter_<type>_new() expects pointer to uninit iter state */
+		if (!is_iter_reg_valid_uninit(env, reg, nr_slots)) {
+			verbose(env, "expected uninitialized iter_%s as arg #%d\n",
+				iter_type_str(meta->btf, btf_id), regno);
+			return -EINVAL;
+		}
+
+		for (i = 0; i < nr_slots * 8; i += BPF_REG_SIZE) {
+			err = check_mem_access(env, insn_idx, regno,
+					       i, BPF_DW, BPF_WRITE, -1, false);
+			if (err)
+				return err;
+		}
+
+		err = mark_stack_slots_iter(env, reg, insn_idx, meta->btf, btf_id, nr_slots);
+		if (err)
+			return err;
+	} else {
+		/* iter_next() or iter_destroy() expect initialized iter state*/
+		if (!is_iter_reg_valid_init(env, reg, meta->btf, btf_id, nr_slots)) {
+			verbose(env, "expected an initialized iter_%s as arg #%d\n",
+				iter_type_str(meta->btf, btf_id), regno);
+			return -EINVAL;
+		}
+
+		err = mark_iter_read(env, reg, spi, nr_slots);
+		if (err)
+			return err;
+
+		meta->ref_obj_id = iter_ref_obj_id(env, reg, spi);
+
+		if (is_iter_destroy_kfunc(meta)) {
+			err = unmark_stack_slots_iter(env, reg, nr_slots);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+/* process_iter_next_call() is called when verifier gets to iterator's next "method"
+ * (e.g., bpf_iter_num_next() for numbers iterator) call. We'll refer to it as
+ * just "iter_next()" in comments below.
+ *
+ * BPF verifier relies on a crucial contract for any iter_next()
+ * implementation: it should *eventually* return NULL, and once that happens
+ * it should keep returning NULL. That is, once iterator exhausts elements to
+ * iterate, it should never reset or spuriously return new elements.
+ *
+ * With the assumption of such contract, process_iter_next_call() simulates
+ * a fork in verifier state to validate loop logic correctness and safety
+ * without having to simulate infinite amount of iterations.
+ *
+ * In current state, we assume that iter_next() returned NULL and iterator
+ * state went to BPF_ITER_STATE_DRAINED. In such conditions we should not form
+ * an infinite loop and should eventually reach exit.
+ *
+ * Besides that, we also fork current state and enqueue it for later
+ * verification. In a forked state we keep iterator state as
+ * BPF_ITER_STATE_ACTIVE and assume non-null return from iter_next(). We also
+ * bump iteration depth to prevent erroneous infinite loop detection later on
+ * (see iter_active_depths_differ() comment for details). In this state we
+ * assume that we'll eventually loop back to another iter_next() calls (it
+ * could be in exactly same location or some other one, it doesn't matter, we
+ * don't make any unnecessary assumptions about this, everything revolves
+ * around iterator state in a stack slot, not which instruction is calling
+ * iter_next()). When that happens, we either will come to iter_next() with
+ * equivalent state and can conclude that next iteration will proceed in
+ * exactly the same way as we just verified, so it's safe to assume that loop
+ * converges. If not, we'll go on another iteration simulation with
+ * a different input state.
+ *
+ * This way, we will either exhaustively discover all possible input states
+ * that iterator loop can start with and eventually will converge, or we'll
+ * effectively regress into bounded loop simulation logic and either reach
+ * maximum number of instructions if loop is not provably convergent, or there
+ * is some statically known limit on number of iterations (e.g., if there is
+ * an explicit `if n > 100 then break;` statement somewhere in the loop).
+ *
+ * One very subtle but very important aspect is that we *always* simulate NULL
+ * condition first (as current state) before we simulate non-NULL case. This
+ * has to do with intricacies of scalar precision tracking. By simulating
+ * "exit condition" of iter_next() returning NULL first, we make sure all the
+ * relevant precision marks *that will be set **after** we exit iterator loop*
+ * are propagated backwards to common parent state of NULL and non-NULL
+ * branches. Thanks to that, state equivalence checks done later in forked
+ * state, when reaching iter_next() for ACTIVE iterator, can assume that
+ * precision marks are finalized and won't change. Because simulating another
+ * ACTIVE iterator iteration won't change them (because given same input
+ * states we'll end up with exactly same output states which we are currently
+ * comparing; and verification after the loop already propagated back what
+ * needs to be **additionally** tracked as precise). It's subtle, grok
+ * precision tracking for more intuitive understanding.
+ */
+static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
+				  struct bpf_kfunc_call_arg_meta *meta)
+{
+	struct bpf_verifier_state *cur_st = env->cur_state, *queued_st;
+	struct bpf_func_state *cur_fr = cur_st->frame[cur_st->curframe], *queued_fr;
+	struct bpf_reg_state *cur_iter, *queued_iter;
+	int iter_frameno = meta->iter.frameno;
+	int iter_spi = meta->iter.spi;
+
+	BTF_TYPE_EMIT(struct bpf_iter);
+
+	cur_iter = &env->cur_state->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
+
+	if (cur_iter->iter.state != BPF_ITER_STATE_ACTIVE &&
+	    cur_iter->iter.state != BPF_ITER_STATE_DRAINED) {
+		verbose(env, "verifier internal error: unexpected iterator state %d (%s)\n",
+			cur_iter->iter.state, iter_state_str(cur_iter->iter.state));
+		return -EFAULT;
+	}
+
+	if (cur_iter->iter.state == BPF_ITER_STATE_ACTIVE) {
+		/* branch out active iter state */
+		queued_st = push_stack(env, insn_idx + 1, insn_idx, false);
+		if (!queued_st)
+			return -ENOMEM;
+
+		queued_iter = &queued_st->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
+		queued_iter->iter.state = BPF_ITER_STATE_ACTIVE;
+		queued_iter->iter.depth++;
+
+		queued_fr = queued_st->frame[queued_st->curframe];
+		mark_ptr_not_null_reg(&queued_fr->regs[BPF_REG_0]);
+	}
+
+	/* switch to DRAINED state, but keep the depth unchanged */
+	/* mark current iter state as drained and assume returned NULL */
+	cur_iter->iter.state = BPF_ITER_STATE_DRAINED;
+	__mark_reg_const_zero(&cur_fr->regs[BPF_REG_0]);
+
+	return 0;
+}
+
 static bool arg_type_is_mem_size(enum bpf_arg_type type)
 {
 	return type == ARG_CONST_SIZE ||
@@ -9099,6 +9510,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_ALLOC_BTF_ID,  /* Allocated object */
 	KF_ARG_PTR_TO_KPTR,	     /* PTR_TO_KPTR but type specific */
 	KF_ARG_PTR_TO_DYNPTR,
+	KF_ARG_PTR_TO_ITER,
 	KF_ARG_PTR_TO_LIST_HEAD,
 	KF_ARG_PTR_TO_LIST_NODE,
 	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
@@ -9220,6 +9632,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_dynptr(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_DYNPTR;
 
+	if (is_kfunc_arg_iter(meta, argno))
+		return KF_ARG_PTR_TO_ITER;
+
 	if (is_kfunc_arg_list_head(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_LIST_HEAD;
 
@@ -9848,6 +10263,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_KPTR:
 		case KF_ARG_PTR_TO_DYNPTR:
+		case KF_ARG_PTR_TO_ITER:
 		case KF_ARG_PTR_TO_LIST_HEAD:
 		case KF_ARG_PTR_TO_LIST_NODE:
 		case KF_ARG_PTR_TO_RB_ROOT:
@@ -9944,6 +10360,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 
 			break;
 		}
+		case KF_ARG_PTR_TO_ITER:
+			ret = process_iter_arg(env, regno, insn_idx, meta);
+			if (ret < 0)
+				return ret;
+			break;
 		case KF_ARG_PTR_TO_LIST_HEAD:
 			if (reg->type != PTR_TO_MAP_VALUE &&
 			    reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
@@ -10148,6 +10569,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	desc_btf = meta.btf;
 	insn_aux = &env->insn_aux_data[insn_idx];
 
+	insn_aux->is_iter_next = is_iter_next_kfunc(&meta);
+
 	if (is_kfunc_destructive(&meta) && !capable(CAP_SYS_BOOT)) {
 		verbose(env, "destructive kfunc calls require CAP_SYS_BOOT capability\n");
 		return -EACCES;
@@ -10436,6 +10859,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			mark_btf_func_reg_size(env, regno, t->size);
 	}
 
+	if (is_iter_next_kfunc(&meta)) {
+		err = process_iter_next_call(env, insn_idx, &meta);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -13548,6 +13977,13 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 * async state will be pushed for further exploration.
 			 */
 			mark_prune_point(env, t);
+		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
+			struct bpf_kfunc_call_arg_meta meta;
+
+			ret = fetch_kfunc_meta(env, insn, &meta, NULL);
+			if (ret == 0 && is_iter_next_kfunc(&meta))
+				mark_prune_point(env, t);
+		}
 		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
 
 	case BPF_JA:
@@ -14301,6 +14737,8 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 	 * didn't use them
 	 */
 	for (i = 0; i < old->allocated_stack; i++) {
+		struct bpf_reg_state *old_reg, *cur_reg;
+
 		spi = i / BPF_REG_SIZE;
 
 		if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ)) {
@@ -14357,9 +14795,6 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 				return false;
 			break;
 		case STACK_DYNPTR:
-		{
-			const struct bpf_reg_state *old_reg, *cur_reg;
-
 			old_reg = &old->stack[spi].spilled_ptr;
 			cur_reg = &cur->stack[spi].spilled_ptr;
 			if (old_reg->dynptr.type != cur_reg->dynptr.type ||
@@ -14367,7 +14802,22 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
 				return false;
 			break;
-		}
+		case STACK_ITER:
+			old_reg = &old->stack[spi].spilled_ptr;
+			cur_reg = &cur->stack[spi].spilled_ptr;
+			/* iter.depth is not compared between states as it
+			 * doesn't matter for correctness and would otherwise
+			 * prevent convergence; we maintain it only to prevent
+			 * infinite loop check triggering, see
+			 * iter_active_depths_differ()
+			 */
+			if (old_reg->iter.btf != cur_reg->iter.btf ||
+			    old_reg->iter.btf_id != cur_reg->iter.btf_id ||
+			    old_reg->iter.state != cur_reg->iter.state ||
+			    /* ignore {old_reg,cur_reg}->iter.depth, see above */
+			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
+				return false;
+			break;
 		case STACK_MISC:
 		case STACK_ZERO:
 		case STACK_INVALID:
@@ -14626,6 +15076,92 @@ static bool states_maybe_looping(struct bpf_verifier_state *old,
 	return true;
 }
 
+static bool is_iter_next_insn(struct bpf_verifier_env *env, int insn_idx)
+{
+	return env->insn_aux_data[insn_idx].is_iter_next;
+}
+
+/* is_state_visited() handles iter_next() (see process_iter_next_call() for
+ * terminology) calls specially: as opposed to bounded BPF loops, it *expects*
+ * state matching, which otherwise looks like an infinite loop. So while
+ * iter_next() calls are taken care of, we still need to be careful and
+ * prevent erroneous and too eager declaration of "ininite loop", when
+ * iterators are involved.
+ *
+ * Here's a situation in pseudo-BPF assembly form:
+ *
+ *   0: again:                          ; set up iter_next() call args
+ *   1:   r1 = &it                      ; <CHECKPOINT HERE>
+ *   2:   call bpf_iter_num_next        ; this is iter_next() call
+ *   3:   if r0 == 0 goto done
+ *   4:   ... something useful here ...
+ *   5:   goto again                    ; another iteration
+ *   6: done:
+ *   7:   r1 = &it
+ *   8:   call bpf_iter_num_destroy     ; clean up iter state
+ *   9:   exit
+ *
+ * This is a typical loop. Let's assume that we have a prune point at 1:,
+ * before we get to `call bpf_iter_num_next` (e.g., because of that `goto
+ * again`, assuming other heuristics don't get in a way).
+ *
+ * When we first time come to 1:, let's say we have some state X. We proceed
+ * to 2:, fork states, enqueue ACTIVE, validate NULL case successfully, exit.
+ * Now we come back to validate that forked ACTIVE state. We proceed through
+ * 3-5, come to goto, jump to 1:. Let's assume our state didn't change, so we
+ * are converging. But the problem is that we don't know that yet, as this
+ * convergence has to happen at iter_next() call site only. So if nothing is
+ * done, at 1: verifier will use bounded loop logic and declare infinite
+ * looping (and would be *technically* correct, if not for iterator "eventual
+ * sticky NULL" contract, see process_iter_next_call()). But we don't want
+ * that. So what we do in process_iter_next_call() when we go on another
+ * ACTIVE iteration, we bump slot->iter.depth, to mark that it's a different
+ * iteration. So when we detect soon-to-be-declared infinite loop, we also
+ * check if any of *ACTIVE* iterator state's depth differs. If yes, we pretend
+ * we are not looping and wait for next iter_next() call.
+ *
+ * This only applies to ACTIVE state. In DRAINED state we don't expect to
+ * loop, because that would actually mean infinite loop, as DRAINED state is
+ * "sticky", and so we'll keep returning into the same instruction with the
+ * same state (at least in one of possible code paths).
+ *
+ * This approach allows to keep infinite loop heuristic even in the face of
+ * active iterator. E.g., C snippet below will be detected as (and actually is)
+ * looping:
+ *
+ *   struct bpf_iter it;
+ *   int *p, x;
+ *
+ *   bpf_iter_num_new(&it, 0, 10);
+ *   while ((p = bpf_iter_num_next(&t))) {
+ *       x = p;
+ *       while (x--) {} // <<-- infinite loop here
+ *   }
+ *
+ */
+static bool iter_active_depths_differ(struct bpf_verifier_state *old, struct bpf_verifier_state *cur)
+{
+	struct bpf_reg_state *slot, *cur_slot;
+	struct bpf_func_state *state;
+	int i, fr;
+
+	for (fr = old->curframe; fr >= 0; fr--) {
+		state = old->frame[fr];
+		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
+			if (state->stack[i].slot_type[0] != STACK_ITER)
+				continue;
+
+			slot = &state->stack[i].spilled_ptr;
+			if (slot->iter.state != BPF_ITER_STATE_ACTIVE)
+				continue;
+
+			cur_slot = &cur->frame[fr]->stack[i].spilled_ptr;
+			if (cur_slot->iter.depth != slot->iter.depth)
+				return true;
+		}
+	}
+	return false;
+}
 
 static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 {
@@ -14673,8 +15209,46 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				 * Since the verifier still needs to catch infinite loops
 				 * inside async callbacks.
 				 */
-			} else if (states_maybe_looping(&sl->state, cur) &&
-				   states_equal(env, &sl->state, cur)) {
+				goto skip_inf_loop_check;
+			}
+			/* BPF open-coded iterators loop detection is special.
+			 * states_maybe_looping() logic is too simplistic in detecting
+			 * states that *might* be equivalent, because it doesn't know
+			 * about ID remapping, so don't even perform it.
+			 * See process_iter_next_call() and iter_active_depths_differ()
+			 * for overview of the logic. When current and one of parent
+			 * states are detected as equivalent, it's a good thing: we prove
+			 * convergence and can stop simulating further iterations.
+			 * It's safe to assume that iterator loop will finish, taking into
+			 * account iter_next() contract of eventually returning
+			 * sticky NULL result.
+			 */
+			if (is_iter_next_insn(env, insn_idx)) {
+				if (states_equal(env, &sl->state, cur)) {
+					struct bpf_func_state *cur_frame;
+					struct bpf_reg_state *iter_state, *iter_reg;
+					int spi;
+
+					cur_frame = cur->frame[cur->curframe];
+					/* btf_check_iter_kfuncs() enforces that
+					 * iter state pointer is always the first arg
+					 */
+					iter_reg = &cur_frame->regs[BPF_REG_1];
+					/* current state is valid due to states_equal(),
+					 * so we can assume valid iter and reg state,
+					 * no need for extra (re-)validations
+					 */
+					spi = __get_spi(iter_reg->off + iter_reg->var_off.value);
+					iter_state = &func(env, iter_reg)->stack[spi].spilled_ptr;
+					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE)
+						goto hit;
+				}
+				goto skip_inf_loop_check;
+			}
+			/* attempt to detect infinite loop to avoid unnecessary doomed work */
+			if (states_maybe_looping(&sl->state, cur) &&
+			    states_equal(env, &sl->state, cur) &&
+			    !iter_active_depths_differ(&sl->state, cur)) {
 				verbose_linfo(env, insn_idx, "; ");
 				verbose(env, "infinite loop detected at insn %d\n", insn_idx);
 				return -EINVAL;
@@ -14691,6 +15265,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * This threshold shouldn't be too high either, since states
 			 * at the end of the loop are likely to be useful in pruning.
 			 */
+skip_inf_loop_check:
 			if (!env->test_state_freq &&
 			    env->jmps_processed - env->prev_jmps_processed < 20 &&
 			    env->insn_processed - env->prev_insn_processed < 100)
@@ -14698,6 +15273,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			goto miss;
 		}
 		if (states_equal(env, &sl->state, cur)) {
+hit:
 			sl->hit_cnt++;
 			/* reached equivalent register/stack state,
 			 * prune the search.
-- 
2.34.1

