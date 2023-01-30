Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF836681AFA
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 21:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbjA3T77 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 14:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237968AbjA3T7o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 14:59:44 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6071F474E1
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 11:59:39 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id j9so11298680qtv.4
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 11:59:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTenlxPvt49C7VnSvKx+w9G2NLdOEJviF5jai/d7q44=;
        b=FeVwegsJCbgKuhm5xw8H6/Ko6EOYbb88Hv0AZx2G8Qxqzegq61joP45NwUH1C2Nl7a
         fb1YWv9flZDJ0eiS14RBkqJmVkc4dasVOWoDMTAI6NRNMUmRwVLUfkIEWh72qGPO5VT2
         vtgb7ogIrj5IBwFVoOeAQAs/yDdTuxQaqYCGwn9lLi1VqnnF0Vl5foyT9djXymZbxsiM
         juFOChMYc9tHM1k0XOVI6RE/Pv7QUJwS+XHybhn/sgg3AkXXPENrKdKpb6szM58bMxaS
         x1zobGAQF2v2yykx1DnGzHvhXs2n3Uwp/FQ8GqFYNb2BMOD253QN1Qk6UIzTR0xPWMoP
         hjJQ==
X-Gm-Message-State: AO0yUKUSXrcYaMe+K5L+IbRyxF+eCax85NamDyrH8Pv2phSm2yDfeicf
        zzFO2VdG6fwbi6dVrFfyYEY=
X-Google-Smtp-Source: AK7set949+SWSpaPHIDr1k/7LXFDjw3m/Jo5tXHun+84vcCcx5WKb3OMu7mHza2IJIz0K4wV9Zq+3g==
X-Received: by 2002:a05:622a:1316:b0:3b8:4adb:c604 with SMTP id v22-20020a05622a131600b003b84adbc604mr14169735qtk.14.1675108777914;
        Mon, 30 Jan 2023 11:59:37 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:64b5])
        by smtp.gmail.com with ESMTPSA id z22-20020ac87cb6000000b003ad373d04b6sm7002057qtv.59.2023.01.30.11.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:59:37 -0800 (PST)
Date:   Mon, 30 Jan 2023 13:59:35 -0600
From:   David Vernet <void@manifault.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
Subject: Re: [PATCH bpf-next v2 1/1] docs/bpf: Add description of register
 liveness tracking algorithm
Message-ID: <Y9ghp6G8KiG6fO2a@maniforge>
References: <20230130182400.630997-1-eddyz87@gmail.com>
 <20230130182400.630997-2-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130182400.630997-2-eddyz87@gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 30, 2023 at 08:24:00PM +0200, Eduard Zingerman wrote:
> This is a followup for [1], adds an overview for the register liveness
> tracking, covers the following points:
> - why register liveness tracking is useful;
> - how register parentage chains are constructed;
> - how liveness marks are applied using the parentage chains.
> 
> [1] https://lore.kernel.org/bpf/CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com/
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

This is great, thanks a lot for writing this up. Left some comments.

> ---
>  Documentation/bpf/verifier.rst | 266 +++++++++++++++++++++++++++++++++
>  1 file changed, 266 insertions(+)
> 
> diff --git a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifier.rst
> index 3afa548ec28c..7269933428e1 100644
> --- a/Documentation/bpf/verifier.rst
> +++ b/Documentation/bpf/verifier.rst
> @@ -316,6 +316,272 @@ Pruning considers not only the registers but also the stack (and any spilled
>  registers it may hold).  They must all be safe for the branch to be pruned.
>  This is implemented in states_equal().
>  
> +Some technical details about state pruning implementation could be found below.
> +
> +Register liveness tracking
> +--------------------------
> +
> +In order to make state pruning effective liveness state is tracked for each

Could you please add a comma after "effective"? Will use shorthand
s/xxx/yyy for future suggestions like this.

> +register and stack slot. The basic idea is to identify which registers or stack
> +slots were used by children of the state to reach the program exit. Registers

IMO the phrasing "used by children of the state" may be a bit confusing.
What do you think about this?

"The basic idea is to track which registers and stack slots are actually
used during subseqeuent execution of the program, until program exit is
reached."

> +that were never used could be removed from the cached state thus making more

s/Registers that were never/Registers and stack slots that were never

> +states equivalent to a cached state. This could be illustrated by the following
> +program::
> +
> +  0: call bpf_get_prandom_u32()
> +  1: r1 = 0
> +  2: if r0 == 0 goto +1
> +  3: r0 = 1
> +  --- checkpoint ---
> +  4: r0 = r1
> +  5: exit
> +
> +Suppose that state cache entry is created at instruction #4 (such entries are
> +also called "checkpoints" in the text below), verifier reaches this instruction
> +in two states:

Can we split these into two sentences? Wdyt about the following:

"Suppose that a state cache entry is created at instruction #4 (such
entries are also called "checkpoints" in the text below). The verifier
could reach the instruction with one of two possible register states:"

> +
> +* r0 = 1, r1 = 0
> +* r0 = 0, r1 = 0
> +
> +However, only the value of register ``r1`` is important to successfully finish
> +verification. The goal of liveness tracking algorithm is to spot this fact and

s/ of liveness tracking/of the liveness tracking

> +figure out that both states are actually equivalent.
> +
> +Data structures
> +~~~~~~~~~~~~~~~
> +
> +Liveness is tracked using the following data structures::
> +
> +  enum bpf_reg_liveness {
> +	REG_LIVE_NONE = 0,
> +	REG_LIVE_READ32 = 0x1,
> +	REG_LIVE_READ64 = 0x2,
> +	REG_LIVE_READ = REG_LIVE_READ32 | REG_LIVE_READ64,
> +	REG_LIVE_WRITTEN = 0x4,
> +	REG_LIVE_DONE = 0x8,
> +  };

FYI, you have the option of using the .. kernel-doc:: directive here, as
in e.g.:

.. kernel-doc:: include/linux/bpf_verifier.h
  :identifiers: bpf_reg_liveness

For enum bpf_reg_liveness and the other types. Doing so would require
you updating the kernel-doc header comment in
include/linux/bpf_verifier.h to reflect the description in [0], i.e.
something like this for enum bpf_reg_liveness:

[0]: https://docs.kernel.org/doc-guide/kernel-doc.html#structure-union-and-enumeration-documentation

/**
 * enum bpf_reg_liveness - Liveness marks, used for registers and spilled-regs
 * @REG_LIVE_NONE: reg hasn't been read or written this branch
 * @REG_LIVE_READ32: reg was read, so we're sensitive to initial value
 * @REG_LIVE_READ64: likewise, but full 64-bit content matters
 * @REG_LIVE_READ: An OR of both 32 and 64 bit read reg states.
 * @REG_LIVE_WRITTEN: reg was written first, screening off later reads
 * @REG_LIVE_DONE: liveness won't be updating this register anymore
 *
 * Read marks propagate upwards until they find a write mark; they record that
 * "one of this state's descendants read this reg" (and therefore the reg is
 * relevant for states_equal() checks).
 * Write marks collect downwards and do not propagate; they record that "the
 * straight-line code that reached this state (from its parent) wrote this reg"
 * (and therefore that reads propagated from this state or its descendants
 * should not propagate to its parent).
 * A state with a write mark can receive read marks; it just won't propagate
 * them to its parent, since the write mark is a property, not of the state,
 * but of the link between it and its parent.  See mark_reg_read() and
 * mark_stack_slot_read() in kernel/bpf/verifier.c.
 */

Not everyone likes how the rendered HTML looks, and I tend to agree that
it looks pretty blocky, but it at least keeps all of this documentation
in one place and avoids going stale. Also, it has the benefit of
automatically creating a link to the ..kernel-doc:: comment anywhere
that "enum bpf_reg_liveness" is written in the Documentation subtree.

> +
> +  struct bpf_reg_state {
> + 	...
> +	struct bpf_reg_state *parent;
> + 	...
> +	enum bpf_reg_liveness live;
> + 	...
> +  };
> +
> +  struct bpf_stack_state {
> +	struct bpf_reg_state spilled_ptr;
> +	...
> +  };
> +
> +  struct bpf_func_state {
> +	struct bpf_reg_state regs[MAX_BPF_REG];
> +        ...
> +	struct bpf_stack_state *stack;
> +  }
> +  
> +  struct bpf_verifier_state {
> +	struct bpf_func_state *frame[MAX_CALL_FRAMES];
> +	struct bpf_verifier_state *parent;
> +        ...
> +  }
> +
> +* ``REG_LIVE_NONE`` is an initial value assigned to ``->live`` fields upon new
> +  verifier state creation;
> +
> +* ``REG_LIVE_WRITTEN`` means that the value of the register (or stack slot) is
> +  defined by some instruction "executed" within verifier state;
> +
> +* ``REG_LIVE_READ{32,64}`` means that the value of the register (or stack slot)
> +  is read by some instruction "executed" within verifier state;
> +
> +* ``REG_LIVE_DONE`` is a marker used by ``clean_verifier_state()`` to avoid
> +  processing same verifier state multiple times and for some sanity checks;
> +
> +* ``->live`` field values are formed by combining ``enum bpf_reg_liveness``
> +  values using bitwise or.
> +
> +Register parentage chains
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +  
> +In order to propagate information between parent and child states register

Suggestion:

s/parent and child states register parentage chain/
  parent and child states, a *register parentage chain*

> +parentage chain is established. Each register or stack slot is linked to a
> +corresponding register or stack slot in it's parent state via a ``->parent``

s/it's/its

> +pointer. This link is established upon state creation in function

suggestion: I think you can remove the word 'function'.

> +``is_state_visited()`` and is never changed.
> +
> +The rules for correspondence between registers / stack slots are as follows:
> +
> +* For current stack frame registers and stack slots of the new state are linked
> +  to the registers and stack slots of the parent state with the same indices.

s/For current stack frame registers/For the current stack frame,
registers

> +
> +* For outer stack frames only caller saved registers (r6-r9) and stack slots are
> +  linked to the registers and stack slots of the parent state with the same
> +  indices.

s/For the outer stack frames only/For the outer stack frames, only

> +
> +This could be illustrated by the following diagram (arrows stand for
> +``->parent`` pointers)::
> +
> +      ...                    ; Frame #0, some instructions
> +  --- checkpoint #0 ---
> +  1 : r6 = 42                ; Frame #0
> +  --- checkpoint #1 ---
> +  2 : call foo()             ; Frame #0
> +      ...                    ; Frame #1, instructions from foo()
> +  --- checkpoint #2 ---
> +      ...                    ; Frame #1, instructions from foo()
> +  --- checkpoint #3 ---
> +      exit                   ; Frame #1, return from foo()
> +  3 : r1 = r6                ; Frame #0  <- current state
> +  
> +             +--------------------------+--------------------------+ 
> +             |         Frame #0         |         Frame #1         |
> +  Checkpoint +--------------------------+--------------------------+
> +  #0         | r0-r5 | r6-r9 | fp-8 ... |                           
> +             +--------------------------+                           
> +                ^       ^       ^
> +                |       |       |          
> +  Checkpoint +--------------------------+                           
> +  #1         | r0-r5 | r6-r9 | fp-8 ... |
> +             +--------------------------+
> +                        ^       ^         nil     nil     nil 
> +                        |       |          |       |       |          
> +  Checkpoint +--------------------------+--------------------------+
> +  #2         | r0-r5 | r6-r9 | fp-8 ... | r0-r5 | r6-r9 | fp-8 ... |
> +             +--------------------------+--------------------------+
> +                        ^       ^          ^       ^       ^  
> +                        |       |          |       |       |
> +  Checkpoint +--------------------------+--------------------------+
> +  #3         | r0-r5 | r6-r9 | fp-8 ... | r0-r5 | r6-r9 | fp-8 ... |
> +             +--------------------------+--------------------------+
> +                        ^       ^
> +                        |       |          
> +  Current    +--------------------------+                           
> +  state      | r0-r5 | r6-r9 | fp-8 ... |                           
> +             +--------------------------+
> +                        \           
> +                          r6 read mark is propagated via
> +                          these links all the way up to
> +                          checkpoint #1.

IMO this illustration is kind of confusing as shown, relative to the
descriptions of current / outer above. 'Frame #1' is potentially in a
different function / subprog, correct? So it seems kind of confusing to
see it propagating registers from checkpoint 3 -> checkpoint 2, etc. And
it's propagating r0-r5. Similarly, it looks like 'Current state' isn't
propagating r0-r5. I'm sure I'm misunderstanding something.

> +
> +Liveness marks tracking
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +For each processed instruction verifier propagates information about reads up

s/processed instruction verifier/processed instruction, the verifier

> +the parentage chain and saves information about writes in the current state.
> +The information about reads is propagated by function ``mark_reg_read()`` which
> +could be summarized as follows::
> +
> +  mark_reg_read(struct bpf_reg_state *state):
> +      parent = state->parent
> +      while parent:
> +          if parent->live & REG_LIVE_WRITTEN:
> +              break
> +          if parent->live & REG_LIVE_READ64:
> +              break
> +          parent->live |= REG_LIVE_READ64
> +          state = parent
> +          parent = state->parent
> +
> +Note: details about REG_LIVE_READ32 are omitted.
> +
> +Also note: the read marks are applied to the **parent** state while write marks
> +are applied to the **current** state.
> +
> +Because stack writes could have different sizes ``REG_LIVE_WRITTEN`` marks are
> +applied conservatively: stack slots are marked as written only if write size
> +corresponds to the size of the register, e.g. see function ``save_register_state()``.
> +
> +Consider the following example::
> +
> +  0: (*u64)(r10 - 8) = 0
> +  --- checkpoint #0 ---
> +  1: (*u32)(r10 - 8) = 1
> +  2: r1 = (*u32)(r10 - 8)
> +
> +Because write size at instruction (1) is smaller than register size the write

s/write size/the write size

also

s/than register size the/than register size, the

> +mark will not be added to fp-8 slot when (1) is verified, thus the fp-8 read at
> +instruction (2) would propagate read mark for fp-8 up to checkpoint #0.

s/is verified, thus/is verifier. Thus

also

s/would propagate read mark/would propagate the read mark

In general, this sentence explains mechanically why the write won't
propagate (the write size is smaller than the register size), but I
think it would be useful to explain why sizeof(write) < sizeof(reg)
implies that it won't be propagated.

> +
> +Once ``BPF_EXIT`` instruction is reached function ``update_branch_counts()`` is

s/Once ``BPF_EXIT``/Once the ``BPF_EXIT``

also

s/is reached function/is reached,

> +called to update the ``->branches`` counter for each verifier state in a chain
> +of parent verifier states. When ``->branches`` counter reaches zero the verifier

s/When ``->branches`` counter reaches zero/
  When the ``branches`` counter reaches zero,

> +state becomes a valid entry in a set of cached verifier states.
> +
> +Each entry of the verifier states cache is post-processed by a function
> +``clean_live_states()``. This function marks all registers and stack slots
> +without ``REG_LIVE_READ{32,64}`` marks as ``NOT_INIT`` or ``STACK_INVALID``.
> +Registers/stack slots marked in this way are ignored in function ``stacksafe()``
> +called from ``states_equal()`` when state cache entry is considered for

s/when state cache entry/when a state cache entry

> +equivalence with a current state.
> +
> +Now it is possible to explain how the example from the beginning of the section
> +works::
> +
> +  0: call bpf_get_prandom_u32()
> +  1: r1 = 0
> +  2: if r0 == 0 goto +1
> +  3: r0 = 1
> +  --- checkpoint[0] ---
> +  4: r0 = r1
> +  5: exit
> +
> +* At instruction #2 branching point is reached and state ``{ r0 == 0, r1 == 0, pc == 4 }``
> +  is pushed to states processing queue (pc stands for program counter).
> +  
> +* At instruction #4:
> +  
> +  * ``checkpoint[0]`` states cache entry is created: ``{ r0 == 1, r1 == 0, pc == 4 }``;
> +  * ``checkpoint[0].r0`` is marked as written;
> +  * ``checkpoint[0].r1`` is marked as read;
> +
> +* At instruction #5 exit is reached and ``checkpoint[0]`` can now be processed
> +  by ``clean_live_states()``, after this processing ``checkpoint[0].r0`` has a

s/by ``clean_live_states()``, after/by ``clean_live_states()``. After

> +  read mark and all other registers and stack slots are marked as ``NOT_INIT``
> +  or ``STACK_INVALID``
> +  
> +* The state ``{ r0 == 0, r1 == 0, pc == 4 }`` is popped from the states queue
> +  and is compared against a cached state ``{ r1 == 0, pc == 4 }``, the states
> +  are considered equivalent.
> +
> +Read marks propagation for cache hits
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Another important point is handling of read marks when a previously verified

s/is handling of/is the handling of

> +state is found in the states cache. All read marks present on registers and
> +stack slots of the cached state must be propagated over the parentage chain of
> +the current state. Function ``propagate_liveness()`` handles this case.

Suggestion: Consider expanding the sentence to include why it's
necessary to propagate like this. You explain below after the diagram,
but it might be helpful to clarify here so the reader has some context
when reading over the diagram.

> +
> +For example, consider the following state parentage chain (S is a
> +starting state, A-E are derived states, -> arrows show which state is
> +derived from which)::
> +
> +                      r1 read
> +               <-------------                    A[r1] == 0
> +                    +---+                        C[r1] == 0
> +      S ---> A ---> | B | ---> exit              E[r1] == 1
> +      |             |   |
> +      ` ---> C ---> | D |
> +      |             +---+
> +      ` ---> E        
> +                      ^
> +             ^        |___   suppose all these
> +             |             states are at insn #Y
> +      suppose all these
> +    states are at insn #X
> +
> +* Chain of states ``S -> A -> B -> exit`` is verified first.
> +
> +* While ``B -> exit`` is verified, register ``r1`` is read and this read mark is
> +  propagated up to state ``A``.
> +
> +* When chain of states ``C -> D`` is verified the state ``D`` turns out to be
> +  equivalent to state ``B``.
> +
> +* The read mark for ``r1`` has to be propagated to state ``C``, otherwise state
> +  ``C`` might get mistakenly marked as equivalent to state ``E`` even though
> +  values for register ``r1`` differ between ``C`` and ``E``.
> +
>  Understanding eBPF verifier messages
>  ====================================
>  
> -- 
> 2.39.0
> 
