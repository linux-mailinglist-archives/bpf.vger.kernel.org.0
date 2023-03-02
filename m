Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF09B6A8D4E
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCBXu5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Mar 2023 18:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCBXuz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:50:55 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E324D38E86
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:50:51 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322L13bj009298
        for <bpf@vger.kernel.org>; Thu, 2 Mar 2023 15:50:51 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p2tfhd0k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 15:50:50 -0800
Received: from twshared38955.16.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Mar 2023 15:50:49 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 25E46291B7F21; Thu,  2 Mar 2023 15:50:45 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 13/17] bpf: add support for open-coded iterator loops
Date:   Thu, 2 Mar 2023 15:50:11 -0800
Message-ID: <20230302235015.2044271-14-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230302235015.2044271-1-andrii@kernel.org>
References: <20230302235015.2044271-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: IlNDsC1hB6b1H7qB9e8_6n3h3AyZJ-Iu
X-Proofpoint-ORIG-GUID: IlNDsC1hB6b1H7qB9e8_6n3h3AyZJ-Iu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
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

First, we add new fixed-size opaque struct bpf_iter (24-byte long) to
contain runtime state of any possible iterator. struct bpf_iter state is
supposed to be on BPF program's stack, so there will be no way to change
its size later on. 24 bytes are chosen as a compromise between using too
much stack and providing too little pre-allocated space for future
iterator types. Numbers iterator in the next patch needs only 8, and
thus fits perfectly and won't require any runtime memory allocation. But
if some other iterator implementation would require more than 24 bytes
to represent iterator runtime state, we'd have to perform runtime
allocation for extra state, which leads to performance hit and general
unreliability (especially in restricted environments of NMI or IRQ).
3 words were chosen to at least accommodate 1 pointer to "collection"
(e.g., bpf_map), 1 pointer to "current/next element", and still leaving
1 word for extra parameters and flags. As such it should hopefully make
a lot of other iterator implementations much simpler and reliable.

The way BPF verifier logic is implemented, there are no artificial
restrictions on a number of active iterators, it should work correctly
using multiple at the same time. This also means you can have multiple
nested iteration loops.  struct bpf_iter reference can be safely passed
to subprograms as well.

General flow is easiest to demonstrate with a simple example using
number iterator implemented in next patch. Here's the simplest possible
loop:

  struct bpf_iter it;
  int *v;

  bpf_iter_num_new(&it, 2, 5);
  while ((v = bpf_iter_num_next(&it))) {
      bpf_printk("X = %d", *v);
  }
  bpf_iter_num_destroy(&it);

Above snippet should output "X = 2", "X = 3", "X = 4". Note that 5 is
exclusive and is not returned.

In the above example, we see a trio of function:
  - constructor, bpf_iter_num_new(), which initializes iterator state
  (struct bpf_iter it) on the stack. If any on the input arguments are
  invalid, constructor should make sure to still initialize it such that
  subsequent bpf_iter_num_next() calls will return NULL. I.e., on error,
  return error and construct empty iterator.
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
  frees up any resources and marks stack space used by struct bpf_iter
  as usable for something else.

Any other iterator implementation will have to implement at least these
three methods. It is enforced that for any given type of iterator only
applicable constructor/destructor/next are callable. I.e., verifier
ensures you can't pass number iterator into, say, cgroup iterator's next
method.

It is important to keep naming consistent to be able to create generic
helpers/macros to help with bpf_iter usability. E.g., one of the follow
up patches adds generic bpf_for_each() macro to bpf_misc.h in selftests,
which allows to utilize iterator "trio" nicely without having to code
the above somewhat tedious loop explicitly every time.

**So it is expected that new iterator implementations will follow
bpf_iter_<kind>_{new,next,destroy}() naming.**

At the implementation level, iterator state tracking for verification
purposes is very similar to dynptr. We add STACK_ITER stack slot type,
reserve 3 slots, keep track of necessary extra state in the "main" slot.
Other slots are marked as STACK_ITER, but having invalid iterator type.
This seems simpler than having a separate "is_first_slot" flag. We
should consider reworking STACK_DYNPTR to follow similar approach.

Another big distinction is that STACK_ITER is *always refcounted*, which
simplifies implementation a bit without sacrificing usability. So no
need for extra "iter_id", no need to anticipate reuse of STACK_ITER
slots for new constructors, etc. Keeping it simpler.

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
equivalent to already (partially) validated. State equivalency at that
point means we technically are going to be looping forever without
"breaking out" out of established "state envelope" (i.e., subsequent
iterations don't add any new knowledge or constraints to verifier state,
so running 1, 2, 10, or a million doesn't matter). But taking into the
account the contract that iterator next method *has to* return NULL
eventually, we can conclude that loop body is safe. Given we validated
logic outside of the loop (NULL case), and concluded that loop body is
safe, though potentially looping many times, verifier can claim safety
of the overall program logic.

The rest of the patch is necessary plumbing for state tracking, marking,
validation, and necessary kfunc infrastructure to allow implementing
iterator constructor, destructor, and next methods.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h            |   7 +
 include/linux/bpf_verifier.h   |  22 +-
 include/uapi/linux/bpf.h       |   6 +
 kernel/bpf/verifier.c          | 621 ++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |   6 +
 5 files changed, 653 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 23ec684e660d..a968282ba324 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -620,6 +620,8 @@ enum bpf_type_flag {
 #define DYNPTR_TYPE_FLAG_MASK	(DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_RINGBUF | DYNPTR_TYPE_SKB \
 				 | DYNPTR_TYPE_XDP)
 
+#define ITER_TYPE_FLAG_MASK	(0)
+
 /* Max number of base types. */
 #define BPF_BASE_TYPE_LIMIT	(1UL << BPF_BASE_TYPE_BITS)
 
@@ -663,6 +665,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
 	ARG_PTR_TO_KPTR,	/* pointer to referenced kptr */
 	ARG_PTR_TO_DYNPTR,      /* pointer to bpf_dynptr. See bpf_type_flag for dynptr type */
+	ARG_PTR_TO_ITER,	/* pointer to bpf_iter. See bpf_type_flag for iter type */
 	__BPF_ARG_TYPE_MAX,
 
 	/* Extended arg_types. */
@@ -1162,6 +1165,10 @@ enum bpf_dynptr_type {
 int bpf_dynptr_check_size(u32 size);
 u32 bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr);
 
+enum bpf_iter_type {
+	BPF_ITER_TYPE_INVALID,
+};
+
 #ifdef CONFIG_BPF_JIT
 int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
 int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b26ff2a8f63b..493a4bb239fe 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -59,6 +59,12 @@ struct bpf_active_lock {
 	u32 id;
 };
 
+enum bpf_iter_state {
+	BPF_ITER_STATE_INVALID, /* for non-first slot */
+	BPF_ITER_STATE_ACTIVE,
+	BPF_ITER_STATE_DRAINED,
+};
+
 struct bpf_reg_state {
 	/* Ordering of fields matters.  See states_equal() */
 	enum bpf_reg_type type;
@@ -103,6 +109,13 @@ struct bpf_reg_state {
 			bool first_slot;
 		} dynptr;
 
+		/* For bpf_iter stack slots */
+		struct {
+			enum bpf_iter_type type;
+			enum bpf_iter_state state;
+			int depth;
+		} iter;
+
 		/* Max size from any of the above. */
 		struct {
 			unsigned long raw1;
@@ -141,6 +154,8 @@ struct bpf_reg_state {
 	 * same reference to the socket, to determine proper reference freeing.
 	 * For stack slots that are dynptrs, this is used to track references to
 	 * the dynptr to determine proper reference freeing.
+	 * Similarly to dynptrs, we use ID to track "belonging" of a reference
+	 * to a specific instance of bpf_iter.
 	 */
 	u32 id;
 	/* PTR_TO_SOCKET and PTR_TO_TCP_SOCK could be a ptr returned
@@ -211,11 +226,16 @@ enum bpf_stack_slot_type {
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
+
+#define BPF_ITER_SIZE		sizeof(struct bpf_iter)
+#define BPF_ITER_NR_SLOTS	(BPF_ITER_SIZE / BPF_REG_SIZE)
 
 struct bpf_stack_state {
 	struct bpf_reg_state spilled_ptr;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c9699304aed2..c4b506193365 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6927,6 +6927,12 @@ struct bpf_dynptr {
 	__u64 :64;
 } __attribute__((aligned(8)));
 
+struct bpf_iter {
+	__u64 :64;
+	__u64 :64;
+	__u64 :64;
+} __attribute__((aligned(8)));
+
 struct bpf_list_head {
 	__u64 :64;
 	__u64 :64;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0ff9dd9170ef..58754929ee33 100644
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
 
+static int iter_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	return stack_slot_obj_get_spi(env, reg, "iter", BPF_ITER_NR_SLOTS);
+}
+
 static const char *kernel_type_name(const struct btf* btf, u32 id)
 {
 	return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
@@ -766,6 +776,32 @@ static const char *dynptr_type_str(enum bpf_dynptr_type type)
 	}
 }
 
+static const char *iter_type_str(enum bpf_iter_type type)
+{
+	switch (type) {
+	case BPF_ITER_TYPE_INVALID:
+		return "<invalid>";
+	default:
+		WARN_ONCE(1, "unknown iter type %d\n", type);
+		return "<unknown>";
+	}
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
@@ -1118,6 +1154,179 @@ static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg
 	}
 }
 
+static enum bpf_dynptr_type arg_to_iter_type(enum bpf_arg_type arg_type)
+{
+	switch (arg_type & ITER_TYPE_FLAG_MASK) {
+	default:
+		return BPF_ITER_TYPE_INVALID;
+	}
+}
+
+static void __mark_reg_known_zero(struct bpf_reg_state *reg);
+
+static int mark_stack_slots_iter(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				 enum bpf_arg_type arg_type, int insn_idx)
+{
+	struct bpf_func_state *state = func(env, reg);
+	enum bpf_iter_type type;
+	int spi, i, j, id;
+
+	spi = iter_get_spi(env, reg);
+	if (spi < 0)
+		return spi;
+
+	type = arg_to_iter_type(arg_type);
+	if (type == BPF_ITER_TYPE_INVALID)
+		return -EINVAL;
+
+	id = acquire_reference_state(env, insn_idx);
+	if (id < 0)
+		return id;
+
+	for (i = 0; i < BPF_ITER_NR_SLOTS; i++) {
+		struct bpf_stack_state *slot = &state->stack[spi - i];
+		struct bpf_reg_state *st = &slot->spilled_ptr;
+
+		__mark_reg_known_zero(st);
+		st->type = PTR_TO_STACK; /* we don't have dedicated reg type */
+		st->live |= REG_LIVE_WRITTEN;
+		st->ref_obj_id = i == 0 ? id : 0;
+		st->iter.type = i == 0 ? type : BPF_ITER_TYPE_INVALID;
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
+static int unmark_stack_slots_iter(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	struct bpf_func_state *state = func(env, reg);
+	int spi, i, j;
+
+	spi = iter_get_spi(env, reg);
+	if (spi < 0)
+		return spi;
+
+	for (i = 0; i < BPF_ITER_NR_SLOTS; i++) {
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
+static bool is_iter_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	struct bpf_func_state *state = func(env, reg);
+	int spi, i, j;
+
+	/* For -ERANGE (i.e. spi not falling into allocated stack slots), we
+	 * will do check_mem_access to check and update stack bounds later, so
+	 * return true for that case.
+	 */
+	spi = iter_get_spi(env, reg);
+	if (spi == -ERANGE)
+		return true;
+	if (spi < 0)
+		return spi;
+
+	for (i = 0; i < BPF_ITER_NR_SLOTS; i++) {
+		struct bpf_stack_state *slot = &state->stack[spi - i];
+
+		if (slot->slot_type[j] == STACK_ITER)
+			return false;
+	}
+
+	return true;
+}
+
+static bool is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	struct bpf_func_state *state = func(env, reg);
+	int spi, i, j;
+
+	spi = iter_get_spi(env, reg);
+	if (spi < 0)
+		return false;
+
+	for (i = 0; i < BPF_ITER_NR_SLOTS; i++) {
+		struct bpf_stack_state *slot = &state->stack[spi - i];
+		struct bpf_reg_state *st = &slot->spilled_ptr;
+
+		/* only first slot contains valid iterator type */
+		if (i == 0 && st->iter.type == BPF_ITER_TYPE_INVALID)
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
+static bool is_iter_type_compatible(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				    enum bpf_arg_type arg_type)
+{
+	struct bpf_func_state *state = func(env, reg);
+	enum bpf_iter_type iter_type;
+	int spi;
+
+	/* ARG_PTR_TO_ITER takes any type of iter */
+	if (arg_type == ARG_PTR_TO_ITER)
+		return true;
+
+	spi = iter_get_spi(env, reg);
+	if (spi < 0)
+		return false;
+
+	iter_type = arg_to_iter_type(arg_type);
+	return state->stack[spi].spilled_ptr.iter.type == iter_type;
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
@@ -1267,6 +1476,16 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 			if (reg->ref_obj_id)
 				verbose(env, "(ref_id=%d)", reg->ref_obj_id);
 			break;
+		case STACK_ITER:
+			i += BPF_ITER_NR_SLOTS - 1;
+			reg = &state->stack[i].spilled_ptr;
+
+			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
+			print_liveness(env, reg->live);
+			verbose(env, "=iter_%s(ref_id=%d,state=%s,depth=%u)",
+				iter_type_str(reg->iter.type), reg->ref_obj_id,
+				iter_state_str(reg->iter.state), reg->iter.depth);
+			break;
 		case STACK_MISC:
 		case STACK_ZERO:
 		default:
@@ -2710,6 +2929,24 @@ static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *
 			     state->stack[spi - 1].spilled_ptr.parent, REG_LIVE_READ64);
 }
 
+static int mark_iter_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int spi)
+{
+	struct bpf_func_state *state = func(env, reg);
+	int err, i;
+
+	for (i = 0; i < BPF_ITER_NR_SLOTS; i++) {
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
@@ -3691,8 +3928,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 
 		/* regular write of data into stack destroys any spilled ptr */
 		state->stack[spi].spilled_ptr.type = NOT_INIT;
-		/* Mark slots as STACK_MISC if they belonged to spilled ptr. */
-		if (is_spilled_reg(&state->stack[spi]))
+		/* Mark slots as STACK_MISC if they belonged to spilled ptr/dynptr/iter. */
+		if (is_stack_slot_special(&state->stack[spi]))
 			for (i = 0; i < BPF_REG_SIZE; i++)
 				scrub_spilled_slot(&state->stack[spi].slot_type[i]);
 
@@ -6407,6 +6644,168 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
 	return err;
 }
 
+static u32 iter_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int spi)
+{
+	struct bpf_func_state *state = func(env, reg);
+
+	return state->stack[spi].spilled_ptr.ref_obj_id;
+}
+
+static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_idx,
+			    enum bpf_arg_type arg_type,
+			    struct bpf_kfunc_call_arg_meta *meta)
+{
+	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	int spi, err, i;
+
+	spi = iter_get_spi(env, reg);
+	if (spi < 0 && spi != -ERANGE)
+		return spi;
+
+	meta->iter.spi = spi;
+	meta->iter.frameno = reg->frameno;
+
+	if (arg_type & MEM_UNINIT) {
+		if (!is_iter_reg_valid_uninit(env, reg)) {
+			verbose(env, "expected uninitialized iter as arg #%d\n", regno);
+			return -EINVAL;
+		}
+
+		/* we write BPF_DW bits (8 bytes) at a time */
+		for (i = 0; i < BPF_ITER_SIZE; i += BPF_REG_SIZE) {
+			err = check_mem_access(env, insn_idx, regno,
+					       i, BPF_DW, BPF_WRITE, -1, false);
+			if (err)
+				return err;
+		}
+
+		err = mark_stack_slots_iter(env, reg, arg_type, insn_idx);
+		if (err)
+			return err;
+	} else {
+		if (!is_iter_reg_valid_init(env, reg)) {
+			verbose(env, "expected an initialized iter as arg #%d\n", regno);
+			return -EINVAL;
+		}
+
+		if (!is_iter_type_compatible(env, reg, arg_type)) {
+			verbose(env, "expected an iter of type %s as arg #%d\n",
+				iter_type_str(arg_to_iter_type(arg_type)), regno);
+			return -EINVAL;
+		}
+
+		err = mark_iter_read(env, reg, spi);
+		if (err)
+			return err;
+
+		meta->ref_obj_id = iter_ref_obj_id(env, reg, spi);
+
+		if (arg_type & OBJ_RELEASE) {
+			err = unmark_stack_slots_iter(env, reg);
+			if (err)
+				return err;
+		}
+	}
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
+	__mark_reg_known_zero(&cur_fr->regs[BPF_REG_0]);
+	cur_fr->regs[BPF_REG_0].type = SCALAR_VALUE;
+
+	return 0;
+}
+
 static bool arg_type_is_mem_size(enum bpf_arg_type type)
 {
 	return type == ARG_CONST_SIZE ||
@@ -6423,6 +6822,11 @@ static bool arg_type_is_dynptr(enum bpf_arg_type type)
 	return base_type(type) == ARG_PTR_TO_DYNPTR;
 }
 
+static bool arg_type_is_iter(enum bpf_arg_type type)
+{
+	return base_type(type) == ARG_PTR_TO_ITER;
+}
+
 static int int_ptr_type_to_size(enum bpf_arg_type type)
 {
 	if (type == ARG_PTR_TO_INT)
@@ -6550,6 +6954,7 @@ static const struct bpf_reg_types dynptr_types = {
 		CONST_PTR_TO_DYNPTR,
 	}
 };
+static const struct bpf_reg_types iter_types = { .types = { PTR_TO_STACK } };
 
 static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_MAP_KEY]		= &mem_types,
@@ -6577,6 +6982,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_TIMER]		= &timer_types,
 	[ARG_PTR_TO_KPTR]		= &kptr_types,
 	[ARG_PTR_TO_DYNPTR]		= &dynptr_types,
+	[ARG_PTR_TO_ITER]		= &iter_types,
 };
 
 static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
@@ -6728,6 +7134,9 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 		if (arg_type_is_dynptr(arg_type) && type == PTR_TO_STACK)
 			return 0;
 
+		if (arg_type_is_iter(arg_type))
+			return 0;
+
 		if ((type_is_ptr_alloc_obj(type) || type_is_non_owning_ref(type)) && reg->off) {
 			if (reg_find_field_offset(reg, reg->off, BPF_GRAPH_NODE_OR_ROOT))
 				return __check_ptr_off_reg(env, reg, regno, true);
@@ -8879,6 +9288,7 @@ static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 
 enum {
 	KF_ARG_DYNPTR_ID,
+	KF_ARG_ITER_ID,
 	KF_ARG_LIST_HEAD_ID,
 	KF_ARG_LIST_NODE_ID,
 	KF_ARG_RB_ROOT_ID,
@@ -8887,6 +9297,7 @@ enum {
 
 BTF_ID_LIST(kf_arg_btf_ids)
 BTF_ID(struct, bpf_dynptr_kern)
+BTF_ID(struct, bpf_iter)
 BTF_ID(struct, bpf_list_head)
 BTF_ID(struct, bpf_list_node)
 BTF_ID(struct, bpf_rb_root)
@@ -8914,6 +9325,11 @@ static bool is_kfunc_arg_dynptr(const struct btf *btf, const struct btf_param *a
 	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_DYNPTR_ID);
 }
 
+static bool is_kfunc_arg_iter(const struct btf *btf, const struct btf_param *arg)
+{
+	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_ITER_ID);
+}
+
 static bool is_kfunc_arg_list_head(const struct btf *btf, const struct btf_param *arg)
 {
 	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_LIST_HEAD_ID);
@@ -9000,6 +9416,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_ALLOC_BTF_ID,  /* Allocated object */
 	KF_ARG_PTR_TO_KPTR,	     /* PTR_TO_KPTR but type specific */
 	KF_ARG_PTR_TO_DYNPTR,
+	KF_ARG_PTR_TO_ITER,
 	KF_ARG_PTR_TO_LIST_HEAD,
 	KF_ARG_PTR_TO_LIST_NODE,
 	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
@@ -9077,6 +9494,11 @@ static bool is_kfunc_bpf_rcu_read_unlock(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->func_id == special_kfunc_list[KF_bpf_rcu_read_unlock];
 }
 
+static bool is_iter_next_kfunc(int btf_id)
+{
+	return false;
+}
+
 static enum kfunc_ptr_arg_type
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		       struct bpf_kfunc_call_arg_meta *meta,
@@ -9121,6 +9543,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_dynptr(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_DYNPTR;
 
+	if (is_kfunc_arg_iter(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_ITER;
+
 	if (is_kfunc_arg_list_head(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_LIST_HEAD;
 
@@ -9749,6 +10174,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_KPTR:
 		case KF_ARG_PTR_TO_DYNPTR:
+		case KF_ARG_PTR_TO_ITER:
 		case KF_ARG_PTR_TO_LIST_HEAD:
 		case KF_ARG_PTR_TO_LIST_NODE:
 		case KF_ARG_PTR_TO_RB_ROOT:
@@ -9845,6 +10271,18 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 
 			break;
 		}
+		case KF_ARG_PTR_TO_ITER:
+		{
+			enum bpf_arg_type iter_arg_type = ARG_PTR_TO_ITER;
+
+			if (is_kfunc_arg_uninit(btf, &args[i]))
+				iter_arg_type |= MEM_UNINIT;
+
+			ret = process_iter_arg(env, regno, insn_idx, iter_arg_type,  meta);
+			if (ret < 0)
+				return ret;
+			break;
+		}
 		case KF_ARG_PTR_TO_LIST_HEAD:
 			if (reg->type != PTR_TO_MAP_VALUE &&
 			    reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
@@ -10315,6 +10753,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			mark_btf_func_reg_size(env, regno, t->size);
 	}
 
+	if (is_iter_next_kfunc(meta.func_id)) {
+		err = process_iter_next_call(env, insn_idx, &meta);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -13427,6 +13871,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 * async state will be pushed for further exploration.
 			 */
 			mark_prune_point(env, t);
+		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL && is_iter_next_kfunc(insn->imm))
+			mark_prune_point(env, t);
 		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
 
 	case BPF_JA:
@@ -14180,6 +14626,8 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 	 * didn't use them
 	 */
 	for (i = 0; i < old->allocated_stack; i++) {
+		struct bpf_reg_state *old_reg, *cur_reg;
+
 		spi = i / BPF_REG_SIZE;
 
 		if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ)) {
@@ -14236,9 +14684,6 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 				return false;
 			break;
 		case STACK_DYNPTR:
-		{
-			const struct bpf_reg_state *old_reg, *cur_reg;
-
 			old_reg = &old->stack[spi].spilled_ptr;
 			cur_reg = &cur->stack[spi].spilled_ptr;
 			if (old_reg->dynptr.type != cur_reg->dynptr.type ||
@@ -14246,7 +14691,14 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
 				return false;
 			break;
-		}
+		case STACK_ITER:
+			old_reg = &old->stack[spi].spilled_ptr;
+			cur_reg = &cur->stack[spi].spilled_ptr;
+			if (old_reg->iter.type != cur_reg->iter.type ||
+			    old_reg->iter.state != cur_reg->iter.state ||
+			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
+				return false;
+			break;
 		case STACK_MISC:
 		case STACK_ZERO:
 		case STACK_INVALID:
@@ -14505,6 +14957,119 @@ static bool states_maybe_looping(struct bpf_verifier_state *old,
 	return true;
 }
 
+static bool is_iter_next_insn(struct bpf_verifier_env *env, int insn_idx, int *reg_idx)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
+	const struct btf_param *args;
+	const struct btf_type *t;
+	const struct btf *btf;
+	int nargs, i;
+
+	if (!bpf_pseudo_kfunc_call(insn))
+		return false;
+	if (!is_iter_next_kfunc(insn->imm))
+		return false;
+
+	btf = find_kfunc_desc_btf(env, insn->off);
+	if (IS_ERR(btf))
+		return false;
+
+	t = btf_type_by_id(btf, insn->imm);	/* FUNC */
+	t = btf_type_by_id(btf, t->type);	/* FUNC_PROTO */
+
+	args = btf_params(t);
+	nargs = btf_vlen(t);
+	for (i = 0; i < nargs; i++) {
+		if (is_kfunc_arg_iter(btf, &args[i])) {
+			*reg_idx = BPF_REG_1 + i;
+			return true;
+		}
+	}
+
+	return false;
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
@@ -14538,6 +15103,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 
 		if (sl->state.branches) {
 			struct bpf_func_state *frame = sl->state.frame[sl->state.curframe];
+			int iter_arg_reg_idx;
 
 			if (frame->in_async_callback_fn &&
 			    frame->async_entry_cnt != cur->frame[cur->curframe]->async_entry_cnt) {
@@ -14552,8 +15118,45 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
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
+			if (is_iter_next_insn(env, insn_idx, &iter_arg_reg_idx)) {
+				if (states_equal(env, &sl->state, cur)) {
+					struct bpf_func_state *cur_frame;
+					struct bpf_reg_state *iter_state, *iter_reg;
+					int spi;
+
+					/* current state is valid due to states_equal(),
+					 * so we can assume valid iter state, no need for extra
+					 * (re-)validations
+					 */
+					cur_frame = cur->frame[cur->curframe];
+					iter_reg = &cur_frame->regs[iter_arg_reg_idx];
+					spi = iter_get_spi(env, iter_reg);
+					if (spi < 0)
+						return spi;
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
@@ -14570,6 +15173,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * This threshold shouldn't be too high either, since states
 			 * at the end of the loop are likely to be useful in pruning.
 			 */
+skip_inf_loop_check:
 			if (!env->test_state_freq &&
 			    env->jmps_processed - env->prev_jmps_processed < 20 &&
 			    env->insn_processed - env->prev_insn_processed < 100)
@@ -14577,6 +15181,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			goto miss;
 		}
 		if (states_equal(env, &sl->state, cur)) {
+hit:
 			sl->hit_cnt++;
 			/* reached equivalent register/stack state,
 			 * prune the search.
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c9699304aed2..c4b506193365 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6927,6 +6927,12 @@ struct bpf_dynptr {
 	__u64 :64;
 } __attribute__((aligned(8)));
 
+struct bpf_iter {
+	__u64 :64;
+	__u64 :64;
+	__u64 :64;
+} __attribute__((aligned(8)));
+
 struct bpf_list_head {
 	__u64 :64;
 	__u64 :64;
-- 
2.30.2

