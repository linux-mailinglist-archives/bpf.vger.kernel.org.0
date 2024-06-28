Return-Path: <bpf+bounces-33335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7390091B9D0
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 10:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060371F21BE4
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 08:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45FB149C7C;
	Fri, 28 Jun 2024 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FbIB3nQe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FE6147C85
	for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719563228; cv=none; b=MOsh7d202gpkC3a1F9yAWBlCEfwZx3G7LYXN6kITOcJKJtz7UdQNjmH2gQxyWU1Si/dkYI53zBK9YZJpcVyEvcycaaeWks4S2HvU2Mcm61HQ2mtNi8lgt0xszevMOvVNyuuAMpBGCm1Enyjlyo9+z+1R8NEbXxAJUAvqjiHLgGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719563228; c=relaxed/simple;
	bh=60O4pF2ktmzwl9yqlR+RMLDCXxPmWAJg64oXpg+Am7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEg18Nq1L53P2nhc0RZ6FsY6JbaT0A/p0u2WHHPDXVvlOi1Ef/gdqkIV4IKHUArUFEvByZ7L30K6yP45BE2XM8h/cvHL+WUzXlp6SmqjcA0kHi3fByxioipUGiZdW+cWwSub3OPfhZVlEkT/HyMG+juw1tzNLt/cBmWyBrkj2gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FbIB3nQe; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so2982071fa.3
        for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 01:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719563224; x=1720168024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5qYaRZysRXoo7OQhtl2GPeICUkIuMlZZoKasijjjL4=;
        b=FbIB3nQeGTNSbHBGBPijHEZ9PcAvASlNyeC4XaIrs4u86XLbIQyUl2B4UrLYepeaON
         MzK4xdiWbSggK4PCHYa3B5NiZIpq9jrcKAKVemQhDpG6dhF7BDbEH6absu0xpQ7wiD2S
         WwDNYMoTks7saes5SUDpYQSr6KkW+O83byHaQvm4ml6pFW2jDvko/lSUs2V1vFfQ1UBN
         nfYwWl5zhDHXh2kVFLGdVNGm0NBTO//ubJzOkfTD1Bui9zVy93lAYjcYnkDVBGMmq1Ff
         7MjDa8lZKlDkr+tb0eYKnTzyU0qOwfxQZ8GSEHmOkhaJWBY/T3V20YOvwWKU1NG/vGHy
         Ekvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719563224; x=1720168024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5qYaRZysRXoo7OQhtl2GPeICUkIuMlZZoKasijjjL4=;
        b=JEsrOlX++fPQnCe3+fVxwsvBlZXBbgC3E4NlW9/G6fp4GBJCDNJpZdT13Xx3MZtbSJ
         jXD89as66PbLDdhHXiNpqY7bQhJ7dpQlCQJWyVHxg2VhRn97WRSnk2Y4jJbdeonzC79X
         f8cDn0djf/aepX8vYZI4HXrTeHrIzmVgowAGe3zLJ4v1/i7jET5SD86jPqeD/dhsexmM
         9mCrNcHdlVSVs80GtzDH1Imeh4yz9fGx5lF9KqoY1r3UaDL45ZlQJGrUzuC3LFuxRdKg
         lQjGpU9R9Lcb6Np/7ifkaxeNtYFGXwi9SvCR2x9F1cH2yh5OMrMDATX70lCIEgxFY6kj
         5taw==
X-Gm-Message-State: AOJu0Yxb2f7+a1lKa8uHMDArcEAvDe9FhnhDusrUkNXj+p6fjMB2HJPH
	MwmRIDR3HjlsgX8cgId2BsKPy+p/4J9E29oiJBcS06Evdeegxqu2R+ItIRhD9Ek=
X-Google-Smtp-Source: AGHT+IGIWW+TPnCUUWhBpgMGxDFFCXSzmqUrlFo7ofRk5ZoRJWO8iUQoxOK1U3pdy/QEjRIuCgV8gg==
X-Received: by 2002:a2e:3218:0:b0:2ec:5685:f06b with SMTP id 38308e7fff4ca-2ec579837bamr98229811fa.27.1719563223473;
        Fri, 28 Jun 2024 01:27:03 -0700 (PDT)
Received: from u94a (39-10-33-14.adsl.fetnet.net. [39.10.33.14])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742ee0e4sm410734173.168.2024.06.28.01.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 01:27:02 -0700 (PDT)
Date: Fri, 28 Jun 2024 16:26:51 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Viktor =?utf-8?B?TWFsw61r?= <vmalik@redhat.com>
Subject: Re: Backporting callback handling fixes to stable 6.1
Message-ID: <pzvp5qx6e2z42pdcqhx52xi72oe3dr5nj2yo4apec27er66626@dauowx7zzv4v>
References: <7k3olfmgvvdjumu6c76nzyynqp5hq252f7u2hqtqo5wbz2ii3x@ksker37jvude>
 <2f6f3bade1dfe64fd9fddfb6ecdcfd86b411894c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f6f3bade1dfe64fd9fddfb6ecdcfd86b411894c.camel@gmail.com>

On Fri, Jun 21, 2024 at 01:27:44AM GMT, Eduard Zingerman wrote:
> On Thu, 2024-06-20 at 13:18 +0800, Shung-Hsi Yu wrote:
> > I'm seeking suggestions for backporting callback handling fixes to the
> > stable/linux-6.1.y (and similar branches), akin to what has been done
> > for 6.6[1].
> 
> I remember that porting to 6.6 was somewhat painful,
> 6.1 would be much worse, probably...

Indeed, my head hurts. While I still don't have detailed understanding
of every change, managed to get an initial working prototype that
correctly rejects the reproducer.

> > Testing with the reproducer from Andrew Werner[2] it seems 6.1 has the
> > same problem where the bpf_probe_read_user() call is only verified with
> > the R1_w=fp-8 state, but not the R1_w=0xDEAD state because the latter
> > was incorrectly pruned. So I believe the callback fixes are need.
> 
> Yes, the main problem with callbacks was that they were verified as if
> called only once. This affects all functions accepting callbacks.

Ah, so my statement that the states are "incorrectly pruned" is not
right, I guess such statement only applies to BPF open-coded iterator
perhaps. Feel free to correct me on this.

> > The main difference from 6.6 is that 6.1 does not have BPF open-coded
> > iterator, but AFAICT it does not mean "exact states comparison for
> > iterator convergence checks" patch-set[3] can be dropped. This is
> > because exact-state comparison from commit 2793a8b015f7 ("bpf: exact
> > states comparison for iterator convergence checks") and loop-identifying
> > algorithm in commit 2a0992829ea3 ("bpf: correct loop detection for
> > iterators convergence") are critical for the fix; but it should be fine
> > to ignore all changes to process_iter_*().
> 
> That is correct, that is the main mechanics of the fix.
> 
> > The "verify callbacks as if they are called unknown number of
> > times" patch-set[4] name already suggest that it is needed, so no doubts
> > there (again, dropping iterator-related changes).
> 
> Right.
> 
> I looked at the patches migrated for 6.6 vs current state of 6.1,
> some thoughts below.

Thanks for looking into this. I picked up quite a handful of commits
along the way (totaling to 39 patches at the moment), many of which you
have mentioned below. The current work can be found on

	https://github.com/shunghsiyu/linux/commits/stable/linux-6.1.y-callback-fixes-w-subprog-precision-v0

Here's a overview of the commits I've picked up. (Note: mostly ignored
selftests for now, will work on backporting them later)


stricter register ID checking in regsafe()[1]
---------------------------------------------
Pulled for regsafe()-related changes (mainly idmap), note entirely sure
if it necessary to fix the issue, but makes backporting the next
patch-set much easier.

1.  7c884339bbff "bpf: regsafe() must not skip check_ids()"
2.  cb578c1c9cf6 "selftests/bpf: test cases for regsafe() bug skipping check_id()"
3.  5dd9cdbc9dec "bpf: states_equal() must build idmap for all function frames"
4.  7d0579433087 "selftests/bpf: verify states_equal() maintains idmap across all frames"
5.  4ea2bb158bec "bpf: use check_ids() for active_lock comparison"
	- commit d0d78c1df9b1 ("bpf: Allow locking bpf_spin_lock global
	  variables") does not exist yet we have active_spin_lock instead of
	  active_lock.id in bpf_verifier_state, and no active_lock.ptr
6.  2026f2062df8 "selftests/bpf: Add pruning test case for bpf_spin_lock"
7.  efd6286ff74a "selftests/bpf: test case for relaxed prunning of active_lock.id"


BPF verifier state equivalence checks improvements[2]
-----------------------------------------------------
Pulled for state equivalent checks change (mainly regsafe()-related, as
well as adding regs_exact()) needed by commit 2793a8b015f7 ("bpf: exact
states comparison for iterator convergence checks").

1.  e8f55fcf7779 "bpf: teach refsafe() to take into account ID remapping"
2.  a73bf9f2d969 "bpf: reorganize struct bpf_reg_state fields"
3.  7f4ce97cd5ed "bpf: generalize MAYBE_NULL vs non-MAYBE_NULL rule"
4.  910f69996674 "bpf: reject non-exact register type matches in regsafe()"
5.  4a95c85c9948 "bpf: perform byte-by-byte comparison only when necessary in regsafe()"
6.  4633a0068258 "bpf: fix regs_exact() logic in regsafe() to remap IDs correctly"


4b5ce570dbef "bpf: ensure state checkpointing at iter_next() call sites"[3]
---------------------------------------------------------------------------
standalone patch for getting mark_force_checkpoint() helper that force
creation of check points, it is used later in backport of commit
2793a8b015f7 ("bpf: exact states comparison for iterator convergence
checks") and ab5cfac139ab ("bpf: verify callbacks as if they are called
unknown number of times").

However the hunk that uses mark_force_checkpoint() in this commit is
dropped because commit 06accc8779c1d ("bpf: add support for open-coded
iterator loops") is not in stable 6.1.


Improve verifier u32 scalar equality checking" series[5]
--------------------------------------------------------
Unrelated patch-set that was pulled for context to make backporting of
commit 1ffc85d9298e "bpf: Verify scalar ids mapping in regsafe() using
check_ids()" easier within check_alu_op().

1. 3be49f79555e bpf: Improve verifier u32 scalar equality checking
2. 49859de997c3 selftests/bpf: Add a selftest for checking subreg equality
   - dropped for now


Add precision propagation for subprogs and callbacks[4]
-------------------------------------------------------
Pulled for 407958a0e980 "bpf: encapsulate precision backtracking
bookkeeping" and fde2a3882bd0 "bpf: support precision propagation in the
presence of subprogs". While the former is just refactoring (which is
used by a lot of subsequent backports), latter is a new feature which I
tried to avoid backport at first.

However I wasn't sure whether there will be problem without fde2a3882bd0
"bpf: support precision propagation in the presence of subprogs" that
propagates precision marks from callback back to caller, so I picked it
up anyway. Plus with it backported, stable aligns with upstream better,
thus makes commit ab5cfac139ab ("bpf: verify callbacks as if they are
called unknown number of times") easier to backport.

1.  5956f3011604 "veristat: add -t flag for adding BPF_F_TEST_STATE_FREQ program flag"
    - fails to apply, ignoring for now
2.  e0bf462276b6 "bpf: mark relevant stack slots scratched for register read instructions"
3.  407958a0e980 "bpf: encapsulate precision backtracking bookkeeping"
4.  d9439c21a9e4 "bpf: improve precision backtrack logging"
5.  1ef22b6865a7 "bpf: maintain bitmasks across all active frames in __mark_chain_precision"
6.  f655badf2a8f "bpf: fix propagate_precision() logic for inner frames"
7.  c50c0b57a515 "bpf: fix mark_all_scalars_precise use in mark_chain_precision"
8.  fde2a3882bd0 "bpf: support precision propagation in the presence of subprogs"
9.  3ef3d2177b1a "selftests/bpf: add precision propagation tests in the presence of subprogs"
    - dropped for now
10. c91ab90cea7a "selftests/bpf: revert iter test subprog precision workaround"
    - dropped for now


d84b1a6708ee "bpf: fix calculation of subseq_idx during precision backtracking"[6]
----------------------------------------------------------------------------------
Initially I missed this fix, which lead to backtracking bug when
running the reproducer in

  check_helper_call()
    update_loop_inline_state()
	  loop_flag_is_zero()
	    mark_chain_precision()
          __mark_chain_precision()
            backtrack_insn()
              !!(bt_reg_mask(bt) & BPF_REGMASK_ARGS) == true

Where the verifier log shows

  from 29 to 11: R1=100 R2=func(off=0,imm=0) R3=fp-16 R4=0 R10=fp0 fp-8=00000000 fp-16=57005
  ; bpf_loop(100, loop_callback, &context, 0);
  11: (85) call bpf_loop#181
  mark_precise: frame0: last_idx 11 first_idx 11
  mark_precise: frame0: parent state regs=r4 stack=:  R1_r=100 R2_r=func(off=0,imm=0) R3_r=fp-16 R4_r=P0 R10=fp0 fp-8=00000000 fp-16=57005
  mark_precise: frame0: last_idx 29 first_idx 28
  mark_precise: frame0: regs=r4 stack= before 29: (95) exit
  BUG regs 10
  mark_precise: frame0: last_idx 11 first_idx 11
  mark_precise: frame0: parent state regs=r1 stack=:  R1_r=P100 R2_r=func(off=0,imm=0) R3_r=fp-16 R4_r=P0 R10=fp0 fp-8=00000000 fp-16=57005
  mark_precise: frame0: last_idx 29 first_idx 28
  mark_precise: frame0: regs=r1 stack= before 29: (95) exit
  BUG regs 2


verify scalar ids mapping in regsafe()[7]
-----------------------------------------
Pulled for regsafe()-related changes, and also struct bpf_idset change
to make backporting commits easier.

1.  904e6ddf4133 "bpf: use scalar ids in mark_chain_precision()"
2.  dec020280373 "selftests/bpf: check if mark_chain_precision() follows scalar ids"
    - dropped for now
3.  1ffc85d9298e "bpf: verify scalar ids mapping in regsafe() using check_ids()"
4.  18b89265572b "selftests/bpf: verify that check_ids() is used for scalars in regsafe()"
    - dropped for now


exact states comparison for iterator convergence checks[8]
----------------------------------------------------------
Backport from the existing 6.6 backports[9].

> 1.  3c4e420cb653 ("bpf: move explored_state() closer to the beginning of verifier.c ")
>     - should apply as-is;
> 2.  4c97259abc9b ("bpf: extract same_callsites() as utility function ")
>     - should apply as-is;

  both applicable

> 3.  2793a8b015f7 ("bpf: exact states comparison for iterator convergence checks ")

  dropped tools/testing/selftests/bpf/progs/iters_task_vma.c change for
  now

>     - needs regs_exact() introduced/modified in:
>       - 4a95c85c9948 ("bpf: perform byte-by-byte comparison only when necessary in regsafe()")
>       - 4633a0068258 ("bpf: fix regs_exact() logic in regsafe() to remap IDs correctly")
>       - 1ffc85d9298e ("bpf: Verify scalar ids mapping in regsafe() using check_ids()")

  all picked up

>     - changes to process_iter_next_call() are not needed;

  dropped as suggested

>     - changes to regsafe() seem applicable;
>     - changes to stacksafe() seem applicable;

  while applicable, without d6fefa1105dac "bpf: Fix state pruning for
  STACK_DYNPTR stack slots" stacksafe() doesn't check the slot type. I
  didn't pick it up because the current patch-set is already quite large
  and it is arguably a different issue, but it would be better to have
  it as well.

>     - changes to func_states_equal():
>       - seem applicable, but there is a commit that removes
>         memset for idmap_scratch from func_states_equal(),
>         it is not necessary for this particular fix,
>         but is a safety fix in itself:
>         1ffc85d9298e ("bpf: Verify scalar ids mapping in regsafe() using check_ids()")

  picked up

>     - changes to is_state_visited():
>       - ignore iterator related changes, just add a new parameter for
>         states_equal() where necessary;
>       - change to visited states eviction heuristic is probably needed
>         (the hunk with "if (sl->miss_cnt > sl->hit_cnt * n + n)");

  included

>       - don't miss the hunk with "cur->dfs_depth = new->dfs_depth + 1;";

  included as well

> 4.  389ede06c297 ("selftests/bpf: tests with delayed read/precision makrs in loop body ")
>     [didn't look at this]
  dropped for now
> 5.  2a0992829ea3 ("bpf: correct loop detection for iterators convergence ")
>     - looks like it could be applied with minimal changes;

  indeed, only need to drop the changes under
  "if (is_iter_next_insn(...))" within is_state_visited()

> 6.  64870feebecb ("selftests/bpf: test if state loops are detected in a tricky case ")
>     [didn't look at this]
  dropped for now
> 7.  b4d8239534fd ("bpf: print full verifier states on infinite loop detection ")
>     [didn't look at this]
  applicable with just minor context difference
> 8.  977bc146d4eb ("selftests/bpf: track tcp payload offset as scalar in xdp_synproxy ")
>     [didn't look at this]
  picked but not tested yet
> 9.  87eb0152bcc1 ("selftests/bpf: track string payload offset as scalar in strobemeta ")
>     [didn't look at this]
  picked but not tested yet


verify callbacks as if they are called unknown number of times[10]
------------------------------------------------------------------
Again, backport from the existing 6.6 backports[9].

> 10. 683b96f9606a ("bpf: extract __check_reg_arg() utility function ")
>     A small refactoring, shouldn't be hard to port.
> 11. 58124a98cb8e ("bpf: extract setup_func_entry() utility function ")
>     A small refactoring, shouldn't be hard to port.

  both applicable

> 12. ab5cfac139ab ("bpf: verify callbacks as if they are called unknown number of times ")

  dropped all selftest changes for now.

>     - backtrack_insn() lacks Andrii's refactoring that introduces 'struct backtrack_state',
>       technically it shouldn't be hard to repeat patch logic w/o that refactoring,
>       but this would lead to further divergence with upstream;

  agree, without 407958a0e980 "bpf: encapsulate precision backtracking
  bookkeeping" it really gets quite painful to backport this and other
  previous patches, so ended up getting the while patch-set[4]

>     - backtrack_insn() lacks subseq_idx parameter;

  parameter is added with fde2a3882bd0 "bpf: support precision
  propagation in the presence of subprogs" from [4] backported

>     - __check_func_call() seems similar enough, so shouldn't be a big problem;

  is_callback_calling_kfunc()/is_sync_callback_calling_kfunc() does not
  exists because commit 5d92ddc3de1b ("bpf: Add callback validation to
  kfunc verifier logic") is not present, so instead of 

	if (bpf_pseudo_kfunc_call(insn) &&
	    !is_sync_callback_calling_kfunc(insn->imm))
		verbose(env, "verifier bug: kfunc %s#%d not marked as callback-calling\n",
			func_id_name(insn->imm), insn->imm);

  I used

	if (bpf_pseudo_kfunc_call(insn)) {
		verbose(env, "verifier bug: kfunc %s#%d with callback is not supported\n",
			func_id_name(insn->imm), insn->imm);

>     - prepare_func_exit() similar enough;
>     - check_helper_call() similar enough;

  both applicable

>     - check_kfunc_call() it looks like kfunc KF_bpf_rbtree_add_impl
>       (the only kfunc that calls a callback) is not in the kernel yet,
>       so changes to check_kfunc_call are not necessary;

  changes dropped as suggested

>     - visit_insn() similar enough;

  applicable

>     - is_state_visited() needs a 'skip_inf_loop_check' label,
>       but otherwise seems applicable;

  several changes to deal with commit 06accc8779c1d ("bpf: add support for
  open-coded iterator loops") not present in stable 6.1:
  - context difference because there no "if (is_iter_next_insn(env,
	insn_idx))" block
  - dropped !iter_active_depths_differ() check in infinite-loop detection
  - added skip_inf_loop_check label along with the hit label, borrowed
	from commit 06accc8779c1d ("bpf: add support for open-coded iterator
	loops")

> 13. 958465e217db ("selftests/bpf: tests for iterating callbacks ")
>     - tools/testing/selftests/bpf/prog_tests/verifier.c is not in 6.1,
>       so adding a custom progs/*.c driver program would be necessary;

  indeed, will try to backport prog_tests/verifier.c next, dropping for
  now

> 14. cafe2c21508a ("bpf: widening for callback iterators ")

  dropped all selftest changes for now.

>     - technically, this is not necessary from safety point of view,
>       but exact states comparison is very restrictive,
>       so porting this is probably a good idea;
>     - shouldn't be hard to port if widen_imprecise_scalars() and co
>       are already ported;
  
  quite easy to backport, picked up as suggested

> 15. 9f3330aa644d ("selftests/bpf: test widening for iterating callbacks ")
>     [didn't look at this]
  dropped for now
> 16. bb124da69c47 ("bpf: keep track of max number of bpf_loop callback iterations ")
>     - this is more "nice to have" patch, it fallbacks to enumeration
>       of every iteration step for bpf_loop, if exact match/widening
>       logic does not converge;
>     - shouldn't be hard to port;

  picked up as suggested

>     - note also the following bug fix for this commit:
>       https://lore.kernel.org/bpf/20240222154121.6991-1-eddyz87@gmail.com/

  also picked up

> 17. 57e2a52deeb1 ("selftests/bpf: check if max number of bpf_loop iterations is tracked ")
>     [didn't look at this]
  dropped for now


With all the above applied, the verifier no correctly rejected the
reproducer.

  from 16 to 20: frame1: R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R2=fp-16 R10=fp0 cb
  20: frame1: R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R2=fp-16 R10=fp0 cb
  ; if (bpf_probe_read_user(ctx->buf, 8, (void*)(0xBADC0FFEE))) {
  20: (79) r1 = *(u64 *)(r2 +0)         ; frame1: R1_w=57005 R2=fp-16 cb
  ; if (bpf_probe_read_user(ctx->buf, 8, (void*)(0xBADC0FFEE))) {
  21: (b7) r2 = 8                       ; frame1: R2_w=8 cb
  22: (18) r3 = 0xbadc0ffee             ; frame1: R3_w=50159747054 cb
  24: (85) call bpf_probe_read_user#112
  R1 type=scalar expected=fp, pkt, pkt_meta, map_key, map_value, mem, alloc_mem, buf

> Also note the following patch from Alexei, relaxing exact states
> comparison a bit:
> https://lore.kernel.org/bpf/20240306031929.42666-3-alexei.starovoitov@gmail.com/
> 
> Hope this helps.

It helped greatly :)

> Sounds like a lot of work.
> Feel free to ask any questions about the patch-sets.

Next I'll try to get the selftests backported and make sure they passes,
and very likely will need your help if there's failure. Will post a
follow-up on that.

Thanks,
Shung-Hsi

1: https://lore.kernel.org/r/20221209135733.28851-1-eddyz87@gmail.com/
2: https://lore.kernel.org/r/20221223054921.958283-1-andrii@kernel.org/
3: https://lore.kernel.org/r/20230310060149.625887-1-andrii@kernel.org/
4: https://lore.kernel.org/r/20230505043317.3629845-1-andrii@kernel.org/
5: https://lore.kernel.org/r/20230417222134.359714-1-yhs@fb.com/
6: https://lore.kernel.org/r/20230515180710.1535018-1-andrii@kernel.org/
7: https://lore.kernel.org/r/20230613153824.3324830-1-eddyz87@gmail.com/
8: https://lore.kernel.org/r/20231024000917.12153-1-eddyz87@gmail.com/
9: https://lore.kernel.org/stable/20240125001554.25287-1-eddyz87@gmail.com/
10: https://lore.kernel.org/r/20231121020701.26440-1-eddyz87@gmail.com/

