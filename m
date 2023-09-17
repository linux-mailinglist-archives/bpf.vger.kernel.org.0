Return-Path: <bpf+bounces-10236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8EA7A3DDE
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 23:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1752812A2
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 21:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8528F4EC;
	Sun, 17 Sep 2023 21:37:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9E6FC1
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 21:37:47 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D355E114
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 14:37:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ad8d47ef2fso475444866b.1
        for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 14:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694986663; x=1695591463; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m/r2jvFL/PZxJ4CCjrN81Ok4M5F+6FvJOnXR1zy8NXo=;
        b=AFtZc1M4Lx94nghWVqSuddsgEYf+0o3IZ2OPk6rxQV1PUSwvlEfT2O2zQ636sIW2p1
         OpiWcL+2Jp33rxaPzP6T/E/OXZwIlp36/zma23z6sIlRXrGqaY8AOWY4aZpTo6ICM1F7
         q/gWqa1ulh5p2J/l4imh8Luky7PWFFkoIBOzV2e1uRzqxnMckhTLFBjnCTWCBDytzh3q
         9uFM3+51XthGJAxdLh3JZuyjEbxzcnQbpV2NfaVuqwiGj7CeOF1jTVMOJ35PSncU4wOn
         7POsd98divdly4yiXeoEjvwIM1YkDOdQADhljEpx5GVFPnPU+P5gTZpXwyOzP/7JdAp/
         tYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694986663; x=1695591463;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m/r2jvFL/PZxJ4CCjrN81Ok4M5F+6FvJOnXR1zy8NXo=;
        b=qctg2pOkFDH/RJEn9k/Tg34RvinvymwJ2Yn1dB4uUAR2cINMp31GaF0b3qaG7wKnYT
         wWrC1ku4+xVzrOGJowOAzmgU3xg0M60/p0zB4xIrInjjWd6XIlGdS78hMvjP9WyyaZWK
         6M4pKKStwNCGwtZ8SZpZo77hs0P791bzxW9NhQcn2rdM5e6G/r5kwmApddy/pxtZopgy
         soB9gpf81Uzl+DmLCGhvgjx0oqAlhhOrRw7EsVIU4GFBFRYWhDXUbIF1BLMY6jC8JCsi
         q9rx4iIbOHNf27d2R6m2iiH+73c6IBlw2dcJ31yHP5sUKVNcSlByTxZlo5wG+YgVMNAt
         ZfZA==
X-Gm-Message-State: AOJu0YybB0yEnXl84lXxSstf9KekeDs1Obwx9O1/hDygIpnRd6fT84LD
	gOC1ioluJA7awogLALO4e4ewV7IY458=
X-Google-Smtp-Source: AGHT+IGtR4Lblea3KGH/OO48A5KKVdq6XigX0avZxr411iRExFxQHKtvrHVRk+PWkjSFeQrpDE/OLw==
X-Received: by 2002:a17:906:51d0:b0:9a1:abae:8d30 with SMTP id v16-20020a17090651d000b009a1abae8d30mr6314101ejk.47.1694986662971;
        Sun, 17 Sep 2023 14:37:42 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id kg11-20020a17090776eb00b00993004239a4sm5408488ejc.215.2023.09.17.14.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 14:37:42 -0700 (PDT)
Message-ID: <dff1cfec20d1711cb023be38dfe886bac8aac5f6.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Andrew Werner <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei
 Matei <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne
 Koong <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>
Date: Mon, 18 Sep 2023 00:37:41 +0300
In-Reply-To: <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com>
References:
	  <CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
	 <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
	 <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-07-07 at 11:08 -0700, Andrii Nakryiko wrote:
> On Fri, Jul 7, 2023 at 9:44=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >=20
> > On Fri, Jul 7, 2023 at 7:04=E2=80=AFAM Andrew Werner <awerner32@gmail.c=
om> wrote:
> > >=20
> > > When it comes to fixing the problem, I don't quite know where to star=
t.
> > > Perhaps these iteration callbacks ought to be treated more like globa=
l functions
> > > -- you can't always make assumptions about the state of the data in t=
he context
> > > pointer. Treating the context pointer as totally opaque seems bad fro=
m
> > > a usability
> > > perspective. Maybe there's a way to attempt to verify the function
> > > body of the function
> > > by treating all or part of the context as read-only, and then if that
> > > fails, go back and
> > > assume nothing about that part of the context structure. What is the
> > > right way to
> > > think about plugging this hole?
> >=20
> > 'treat as global' might be a way to fix it, but it will likely break
> > some setups, since people passing pointers in a context and current
> > global func verification doesn't support that.
>=20
> yeah, the intended use case is to return something from callbacks
> through context pointer. So it will definitely break real uses.
>=20
> > I think the simplest fix would be to disallow writes into any pointers
> > within a ctx. Writes to scalars should still be allowed.
>=20
> It might be a partial mitigation, but even with SCALARs there could be
> problems due to assumed SCALAR range, which will be invalid if
> callback is never called or called many times.
>=20
> > Much more complex fix would be to verify callbacks as
> > process_iter_next_call(). See giant comment next to it.
>=20
> yep, that seems like the right way forward. We need to simulate 0, 1,
> 2, .... executions of callbacks until we validate and exhaust all
> possible context modification permutations, just like open-coded
> iterators do it
>=20
> > But since we need a fix for stable I'd try the simple approach first.
> > Could you try to implement that?

Hi All,

This issue seems stalled, so I took a look over the weekend.
I have a work in progress fix, please let me know if you don't agree
with direction I'm taking or if I'm stepping on anyone's toes.

After some analysis I decided to go with Alexei's suggestion and
implement something similar to iterators for selected set of helper
functions that accept "looping" callbacks, such as:
- bpf_loop
- bpf_for_each_map_elem
- bpf_user_ringbuf_drain
- bpf_timer_set_callback (?)

The sketch of the fix looks as follows:
- extend struct bpf_func_state with callback iterator state information:
  - active/non-active flag
  - depth
  - r1-r5 state at the entry to callback;
- extend __check_func_call() to setup callback iterator state when
  call to suitable helper function is processed;
- extend BPF_EXIT processing (prepare_func_exit()) to queue new
  callback visit upon return from iterating callback
  (similar to process_iter_next_call());
- extend is_state_visited() to account for callback iterator hits in a
  way similar to regular iterators;
- extend backtrack_insn() to correctly react to jumps from callback
  exit to callback entry.
 =20
I have a patch (at the end of this email) that correctly recognizes
the bpf_loop example in this thread as unsafe. However this patch has
a few deficiencies:

- verif_scale_strobemeta_bpf_loop selftest is not passing, because
  read_map_var function invoked from the callback continuously
  increments 'payload' pointer used in subsequent iterations.
 =20
  In order to handle such code I need to add an upper bound tracking
  for iteration depth (when such bound could be deduced).

- loop detection is broken for simple callback as below:

  static int loop_callback_infinite(__u32 idx, __u64 *data)
  {
      for (;;)
          (*ctx)++;
      return 0;
  }
 =20
  To handle such code I need to change is_state_visited() to do
  callback iterator loop/hit detection on exit from callback
  (returns are not prune points at the moment), currently it is done
  on entry.

- the callback as bellow currently causes state explosion:

  static int precise1_callback(__u32 idx, struct precise1_ctx *ctx)
  {
      if (idx =3D=3D 0)
          ctx->a =3D 1;
      if (idx =3D=3D 1 && ctx->a =3D=3D 1)
          ctx->b =3D 1;
      return 0;
  }
 =20
  I'm not sure yet what to do about this, there are several possibilities:
  - tweak the order in which states are visited (need to think about it);
  - check states in bpf_verifier_env::head (not explored yet) for
    equivalence and avoid enqueuing duplicate states.
   =20
I'll proceed addressing the issues above on Monday.

Thanks,
Eduard

---

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a3236651ec64..5589f55e42ba 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -70,6 +70,17 @@ enum bpf_iter_state {
 	BPF_ITER_STATE_DRAINED,
 };
=20
+struct bpf_iter {
+	/* BTF container and BTF type ID describing
+	 * struct bpf_iter_<type> of an iterator state
+	 */
+	struct btf *btf;
+	u32 btf_id;
+	/* packing following two fields to fit iter state into 16 bytes */
+	enum bpf_iter_state state:2;
+	int depth:30;
+};
+
 struct bpf_reg_state {
 	/* Ordering of fields matters.  See states_equal() */
 	enum bpf_reg_type type;
@@ -115,16 +126,7 @@ struct bpf_reg_state {
 		} dynptr;
=20
 		/* For bpf_iter stack slots */
-		struct {
-			/* BTF container and BTF type ID describing
-			 * struct bpf_iter_<type> of an iterator state
-			 */
-			struct btf *btf;
-			u32 btf_id;
-			/* packing following two fields to fit iter state into 16 bytes */
-			enum bpf_iter_state state:2;
-			int depth:30;
-		} iter;
+		struct bpf_iter iter;
=20
 		/* Max size from any of the above. */
 		struct {
@@ -300,6 +302,8 @@ struct bpf_func_state {
 	bool in_callback_fn;
 	struct tnum callback_ret_range;
 	bool in_async_callback_fn;
+	struct bpf_iter callback_iter;
+	struct bpf_reg_state callback_entry_state[MAX_BPF_REG];
=20
 	/* The following fields should be last. See copy_func_state() */
 	int acquired_refs;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dbba2b806017..e79a4bec4461 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2357,6 +2357,7 @@ static void init_func_state(struct bpf_verifier_env *=
env,
 	state->callback_ret_range =3D tnum_range(0, 0);
 	init_reg_state(env, state);
 	mark_verifier_state_scratched(env);
+	state->callback_iter.state =3D BPF_ITER_STATE_INVALID;
 }
=20
 /* Similar to push_stack(), but for async callbacks */
@@ -3599,6 +3600,39 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 			}
 		} else if (opcode =3D=3D BPF_EXIT) {
 			bool r0_precise;
+			int subprog;
+
+			/* Jump from 'exit' to start of the same subprogram,
+			 * this happens for callback iteration, e.g.:
+			 *
+			 *   int cb_func(...) {
+			 *   start:
+			 *     ...
+			 *     return 0; // <-- BPF_EXIT processing in do_check()
+			 *               //     adds a state with IP set to 'start'.
+			 *   }
+			 *   bpf_loop(..., cb_func, ...);
+			 *
+			 * Clear r1-r5 as in the callback case above, but do
+			 * not change frame number.
+			 */
+			if (subseq_idx >=3D 0 &&
+			    ((subprog =3D find_subprog(env, subseq_idx)) >=3D 0) &&
+			    idx >=3D subseq_idx &&
+			    (subprog >=3D env->subprog_cnt ||
+			     idx < env->subprog_info[subprog + 1].start)) {
+				if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
+					verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
+					WARN_ONCE(1, "verifier backtracking bug");
+					return -EFAULT;
+				}
+				if (bt_stack_mask(bt) !=3D 0)
+					return -ENOTSUPP;
+				/* clear r1-r5 in callback subprog's mask */
+				for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
+					bt_clear_reg(bt, i);
+				return 0;
+			}
=20
 			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
 				/* if backtracing was looking for registers R1-R5
@@ -8869,13 +8903,17 @@ static int set_callee_state(struct bpf_verifier_env=
 *env,
 			    struct bpf_func_state *caller,
 			    struct bpf_func_state *callee, int insn_idx);
=20
+static int set_loop_callback_state(struct bpf_verifier_env *env,
+				   struct bpf_func_state *caller,
+				   struct bpf_func_state *callee, int insn_idx);
+
 static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn=
 *insn,
 			     int *insn_idx, int subprog,
 			     set_callee_state_fn set_callee_state_cb)
 {
 	struct bpf_verifier_state *state =3D env->cur_state;
 	struct bpf_func_state *caller, *callee;
-	int err;
+	int err, i;
=20
 	if (state->curframe + 1 >=3D MAX_CALL_FRAMES) {
 		verbose(env, "the call stack of %d frames is too deep\n",
@@ -8972,7 +9010,6 @@ static int __check_func_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn
 			*insn_idx /* callsite */,
 			state->curframe + 1 /* frameno within this callchain */,
 			subprog /* subprog number within this prog */);
-
 	/* Transfer references to the callee */
 	err =3D copy_reference_state(callee, caller);
 	if (err)
@@ -8982,6 +9019,14 @@ static int __check_func_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn
 	if (err)
 		goto err_out;
=20
+	if (set_callee_state_cb =3D=3D set_loop_callback_state) {
+		callee->callback_iter.state =3D BPF_ITER_STATE_ACTIVE;
+		callee->callback_iter.depth =3D 0;
+		for (i =3D BPF_REG_0; i < MAX_BPF_REG; ++i)
+			copy_register_state(&callee->callback_entry_state[i],
+					    &callee->regs[i]);
+	}
+
 	clear_caller_saved_regs(env, caller->regs);
=20
 	/* only increment it after check_reg_arg() finished */
@@ -9256,7 +9301,7 @@ static int prepare_func_exit(struct bpf_verifier_env =
*env, int *insn_idx)
 	struct bpf_verifier_state *state =3D env->cur_state;
 	struct bpf_func_state *caller, *callee;
 	struct bpf_reg_state *r0;
-	int err;
+	int err, i;
=20
 	callee =3D state->frame[state->curframe];
 	r0 =3D &callee->regs[BPF_REG_0];
@@ -9301,6 +9346,25 @@ static int prepare_func_exit(struct bpf_verifier_env=
 *env, int *insn_idx)
 			return err;
 	}
=20
+	if (callee->in_callback_fn && callee->callback_iter.state =3D=3D BPF_ITER=
_STATE_ACTIVE) {
+		struct bpf_verifier_state *queued_st;
+		struct bpf_func_state *queued_callee;
+		struct bpf_iter *queued_iter;
+
+		queued_st =3D push_stack(env, env->subprog_info[callee->subprogno].start=
,
+				       *insn_idx, false);
+		if (!queued_st)
+			return -ENOMEM;
+
+		queued_callee =3D queued_st->frame[callee->frameno];
+		queued_iter =3D &queued_callee->callback_iter;
+		queued_iter->depth++;
+
+		for (i =3D BPF_REG_0; i < MAX_BPF_REG; ++i)
+			copy_register_state(&queued_callee->regs[i],
+					    &queued_callee->callback_entry_state[i]);
+	}
+
 	*insn_idx =3D callee->callsite + 1;
 	if (env->log.level & BPF_LOG_LEVEL) {
 		verbose(env, "returning from callee:\n");
@@ -16112,6 +16176,15 @@ static bool is_iter_next_insn(struct bpf_verifier_=
env *env, int insn_idx)
 	return env->insn_aux_data[insn_idx].is_iter_next;
 }
=20
+static bool is_callback_iter_entry(struct bpf_verifier_env *env, int insn_=
idx)
+{
+	struct bpf_func_state *cur_frame =3D cur_func(env);
+
+	return cur_frame->in_callback_fn &&
+	       env->subprog_info[cur_frame->subprogno].start =3D=3D insn_idx &&
+	       cur_frame->callback_iter.state !=3D BPF_ITER_STATE_INVALID;
+}
+
 /* is_state_visited() handles iter_next() (see process_iter_next_call() fo=
r
  * terminology) calls specially: as opposed to bounded BPF loops, it *expe=
cts*
  * states to match, which otherwise would look like an infinite loop. So w=
hile
@@ -16190,6 +16263,9 @@ static bool iter_active_depths_differ(struct bpf_ve=
rifier_state *old, struct bpf
 			if (cur_slot->iter.depth !=3D slot->iter.depth)
 				return true;
 		}
+		if (state->callback_iter.state =3D=3D BPF_ITER_STATE_ACTIVE &&
+		    state->callback_iter.depth !=3D cur->frame[fr]->callback_iter.depth)
+			return true;
 	}
 	return false;
 }
@@ -16277,6 +16353,12 @@ static int is_state_visited(struct bpf_verifier_en=
v *env, int insn_idx)
 				}
 				goto skip_inf_loop_check;
 			}
+			if (is_callback_iter_entry(env, insn_idx)) {
+				if (states_equal(env, &sl->state, cur) &&
+				    cur_func(env)->callback_iter.state =3D=3D BPF_ITER_STATE_ACTIVE)
+					goto hit;
+				goto skip_inf_loop_check;
+			}
 			/* attempt to detect infinite loop to avoid unnecessary doomed work */
 			if (states_maybe_looping(&sl->state, cur) &&
 			    states_equal(env, &sl->state, cur) &&


