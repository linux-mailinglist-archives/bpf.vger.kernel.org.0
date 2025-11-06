Return-Path: <bpf+bounces-73835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8408C3B0C0
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9250650066D
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE30D330321;
	Thu,  6 Nov 2025 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNq3pZ0w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D039932E756
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433620; cv=none; b=nBWEVj9sj1H7FvUgunPtDCbt+/TwINAgfUByeKOGbR7QFXk+YdSuMQ7MjjK8JCPAJbxFcx8T7whErMf11Uj7S+HT3wvPiUAqWwI0X9l0xiWxYKaGOQbNCI84I/XgznyUkUm+qOgwwUY93IU2f3Zz+DdmsofdrvFMhvaD439x5xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433620; c=relaxed/simple;
	bh=mqcLHuIOKBxEIMBJ9EP2N0puM0OznEHB96+ELPogj1o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Maxom0rl+rwzAkab/qRofx/dixbOOsdImaOouP7HkPwKDVlow9/agwHy9lYGlyUcn2e8y5A0KR7TsIEnV0cjtj5yFBrGOjIuk0oPF9Yp5Vd7IfEvOTJznSzEytc5c09I9mZRgVouAVU7HVXjtdTOs6fO7zGdZkZUe5l2lvTh9CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNq3pZ0w; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47721743fd0so4385185e9.2
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 04:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433616; x=1763038416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RK/kn9Jj54ERS05YbdoYWf7TWVDvEMNPzpPqyUsPGzs=;
        b=hNq3pZ0wJ1inhTGZzWquoWfyGl0W9XVnBj8J6tayc5vKrF5qSppW1UbWQYXjo/cosy
         KNjh+4yo2W74UJMrboL7n31VTKN4J00hhATlV4zi627GTSpcY1WvXuH3L6gvHJRasIgL
         NdLtRA+7FPffvdBwxBqY2vFDieAootqQneS5I9ibFbp7x7SiSDgiapvsbaJhW2AqGXK7
         cgvOdnZIn6gdH19cK0GvxZOv6BdtnPY1mq7LiyOXIIHZImyryi5803uSE7DH36KXh+y0
         I9kGvx5c1y+5vso+uQpMVDkRsYjB6tQnlDzXkh1HAo7Gb3OhjzC55wBZ4ZF0hY+SojlM
         HtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433616; x=1763038416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RK/kn9Jj54ERS05YbdoYWf7TWVDvEMNPzpPqyUsPGzs=;
        b=Qbe78S24yQS190z61dryRlPs0eSenotw+Smu8B30VlmDsJRmg9CKa/Pt+de05svrSL
         shyNhS32eefg5/PoMk4gzjsnGXQEGfICVz1AlgO2dD+E0VAO1Tv34XjcelC3IWgVDjS0
         Ofn2b38qX7OXpXqDq5Pdm3UTjKhXVHWe8bqW87aZ9YI3cT+AKeFkNKowT6csQH9wxnaL
         NQf7g0yDmbdSzda6euKadaDmyit2USMf22Lz+T9h+O0mCIsk1gmee/Ip4tk0WkLI0/5D
         frqZlDQF78A3pXie/CKQo4Rki0vcOidn7pFgk0X2Y+I9/GgAx/zXjyYZYBcFbQDkWRO2
         oMFw==
X-Gm-Message-State: AOJu0YxUPC16YaJZKT3FD9GQcxqRRYUpebKlqb1pQFqiWdUBPkzJ2PWe
	TtZmldl/IsExt2TDZNnIV1Drbpc9DM+RzOt6VgaS7RGo0vHmKeLyvLVw+L6/
X-Gm-Gg: ASbGnctZQuQqyl1gB+wBh8kmd5ci7BseNvvsCgWv2J4OFP869uETIwcle4jc2DP1FOf
	DYmDgLWWVg8fFtIW/fhcTX53O2ZxbywIyFSOzdLr61Vc6+wIA+bR0P+OunWXwOSqSERcH/yEdU5
	IZqitAnJmSRcBAWtwNytsc+IFxEOmqoXLkJO1BqQ4FjRVGpXOpXzMcK18NWOqZ5uudzvX7IPP93
	GbFMZOEl1zYvwY0oc3OGxrUcldQqjAvqeWS/bqLsRRI68gbP7UdKS+9rSOEbRkhA8DR4R/ZIql6
	7nsqs3H6FLqmOpkhTXwMM9hqV0fhCEWkRpmmJdawT7R9IT4IyZ/zkUZTN/xyA55dPGYOfLSXfZn
	LQbL7pNvdoTpOTGiHFNa7nxXYrAYjgx9L+5TbRyXjQqtqz/jBDGfpCwdXsT4MUeGTEHu7WCrlpx
	lxU7dhG8NQX9PStsdWpqgWn1YRMVgBiXr1TenNr77TFmL1kQpo35Et0zo=
X-Google-Smtp-Source: AGHT+IFODUjwTwYhvB7R2o/wgb1BzU9SdaSEPiLfW4YDUAY9dxwV7kb9WzNsGMYEwzbzraG3ZaDDLw==
X-Received: by 2002:a05:600c:34d6:b0:477:5ad9:6df6 with SMTP id 5b1f17b1804b1-4775cdf54f4mr61131835e9.20.1762433615617;
        Thu, 06 Nov 2025 04:53:35 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:34 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
X-Google-Original-From: Hao Sun <hao.sun@inf.ethz.ch>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	sunhao.th@gmail.com,
	Hao Sun <hao.sun@inf.ethz.ch>
Subject: [PATCH RFC 00/17] bpf: Introduce proof-based verifier enhancement
Date: Thu,  6 Nov 2025 13:52:38 +0100
Message-Id: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch set (and three follow-up sets) introduces a proof-based, on-demand
refinement mechanism that increases verifier precision while keeping kernel
complexity bounded. The kernel performs lightweight symbolic tracking and state
updates; userspace does the heavy reasoning and returns a proof, which the
kernel checks.

The design is named as BCF: eBPF Certificate Framework.

Motivation
----------

The eBPF verifier can reject safe programs due to imprecise techniques used,
e.g., intervals, that do not track registers relations and over-approximate
on each step. This leads to rejections from loose bounds and infeasible paths.
The dataset[1] shows various concrete false rejections. In practice, they
require non-trivial refactoring and trial-and-error to mitigate, due to the
gap between bytecode errors and high-level code. Cases inside deep loops and
long paths are particularly challenging.

With the increasing adoption of eBPF in various subsystems, a more powerful
verifier is beneficial, to allow more complex extensions to be verified as
well as being transparent to the user.

The goal is to accept more safe programs without turning the verifier into
an SMT solver or significantly increasing kernel complexity: leverage
solver-grade reasoning (500k+ LOC solvers) without trusting it, by
checking compact proofs in a ~5k LOC in-kernel proof checker.

Key design
----------

The patch sets introduce proof-based, on-demand verifier state refinement.
On a blocking check (e.g., potential OOB), the verifier performs on-demand
refinement:

1. Backtrack the target register to identify the relevant path suffix.
2. Symbolically track the suffix to collect precise bitvector/boolean
   expressions for involved registers and the path condition.
3. Derive a refinement condition (SMT) that, if valid, permits the verifier to
   continue (e.g., tighten pointer offset or size bounds, or conclude the path
   is unreachable).
4. Send the condition to userspace. Userspace proves it and returns a proof.
5. The kernel checks the proof and resumes analysis with the refined state.

Only lightweight work is in-kernel: suffix tracking and proof checking. The
NP-hard reasoning remains in userspace. More details can be found in our
research paper[5] (received the best paper award :).

It's highly recomended to play with the system directly: (1) apply all
the patches from our repo[4], (2) download the provided disk image,
and (3) see how the verifier, proof checker, loader, and solver interact
with each other via loading the example programs provided[6].

Here is a running example:

A simplified load log that hits an infeasible branch; refinement proves the path
unreachable and pops it (another example is also available in our paper).

The verifier starts:
```
0: (85) call bpf_get_prandom_u32#7    ; R0=scalar()
1: (bc) w1 = w0                       ; R0=scalar() R1=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
2: (c4) w1 s>>= 31                    ; R1=scalar(smin=0,smax=umax=0xffffffff,smin32=-1,smax32=0,var_off=(0x0; 0xffffffff))
3: (54) w1 &= -134                    ; R1=scalar(smin=0,smax=umax=umax32=0xffffff7a,smax32=0x7fffff7a,var_off=(0x0; 0xffffff7a))
4: (66) if w1 s> 0xffffffff goto pc+2 ; R1=scalar(smin=umin=umin32=0x80000000,smax=umax=umax32=0xffffff7a,smax32=-134,var_off=(0x80000000; 0x7fffff7a))
5: (56) if w1 != 0xffffff78 goto pc+1 ; R1=0xffffff78
6: (bf) r1 = r2
R2 !read_ok            ; ---> start refinement: prove the path unreachable
```

Symbolic tracking (on the suffix):
```
...
1: (bc) w1 = w0                 ; w1 = sym
2: (c4) w1 s>>= 31              ; w1 = (sym s>> 31)
3: (54) w1 &= -134              ; w1 = (sym s>> 31) & -134
4: (66) if w1 s> -1 goto pc+2   ; fallthrough c1: w1 s<= -1
5: (56) if w1 != -136 goto pc+1 ; fallthrough c2: w1 = -136
6: (bf) r1 = r2
```

Here, `sym` refers to a 32-bit bitvector, which represents a vector of
unknown bits (in the same spirit as tnum); however, unlike the verifier,
the symbolic tracking does not perform any "reasoning": it simply
records all the computation as is:
	{src=sym0, dst=sym1} dst op= src {dst = (sym1 op sym0)},
each calculation is captured as a symbolic expression (in comparison,
tnum needs to approximate at every step).

For the suffix, the symbolic track just captures the symbolic expression
for each reg, and for branch conditions, it remembers the condition as
path constraints (the AND of each taken condition).

For the example above, let t = (sym s>> 31) & -134, which is the associated
expr to w1. The condition to refute is:
	 t <= -1 && t == -136
It does not hold (if t s<= -1, then t must be -134), hence the path is
unreachable. This condition is sent to user space for a proof.

In user space, the condition is translated into the following SMT formula:
```
(set-logic QF_BV)
(declare-fun v0 () (_ BitVec 64))
(assert (let ((t20 (bvand (bvashr ((_ extract 31 0) v0) (_ bv31 32)) (_ bv4294967162 32))))
        (and (bvsle t20 (_ bv4294967295 32)) (= t20 (_ bv4294967160 32)))))
(check-sat)
(exit)
```

cvc5 returns `unsat` and a proof:
```
unsat
(
; Proof produced: 715 steps, 17244 bytes
)
```

Now back to the kernel space, the proof checker checks the proof:
```
checking 715 proof steps	; ---> proved received, starting checking:
(#0 POLY_NORM () ...)
(#1 POLY_NORM_EQ (@p0) ...)
(#2 REFL () ...)
(#3 ACI_NORM () ...)
(#4 ABSORB () ...)
(#5 EVALUATE () ...)
...
proof accepted            ; Path proved to be unreachable
```

The verifier pops the path and continues:
```
from 5 to 7: R0=scalar() R1=scalar(...)
; return 0; @ unreachable_arsh.bpf.c:29
7: (b7) r0 = 0                        ; R0=0
8: (95) exit

from 4 to 7: safe
processed 10 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 0
```

The proof check is a linear scan and is highly efficient, e.g., for a 8M
proof, the checker can validate it within 3s.

In summary, the linear time proof check essentially allows the verifier
to achieve various non-trivial refinements, by using the user space SMT
solvers but not trust them.

Kernel/userspace interface and workflow
---------------------------------------

UAPI carries refinement conditions, proofs, and an anon-fd to preserve the
verifier env across proof requests:

- union bpf_attr: `bcf_buf`, `bcf_buf_size`, `bcf_buf_true_size`, `bcf_fd`,
  `bcf_flags` (`BCF_F_PROOF_REQUESTED`, `BCF_F_PROOF_PROVIDED`,
  `BCF_F_PROOF_PATH_UNREACHABLE`).
- Conditions and proofs are represented as `struct bcf_expr` and `struct
  bcf_proof_step`.

The condition and proof are DAG, the associated algorithms walk them.

Workflow:
- Initial verification may request a proof and return `bcf_fd` plus the
  expression arena and condition.
- Userspace (bpftool + cvc5) proves the condition and resubmits with
  `BCF_F_PROOF_PROVIDED` and the proof in `bcf_buf`.
- Resume: the kernel validates the proof and continues from the saved state.

More on the proof checker
-------------------------

A proof checker validates that a sequence of proof rule applications
proves a required goal. Given a goal and a proof (a list of rule
applications), the checker verifies each rule is applied exactly in its
permitted form and that the final conclusion matches the requested goal;
any violation leads to proof rejection. For example, from premises
`A and B`, the AND_ELIM rule may conclude `A` (or `B`) only; otherwise
the checker rejects it.

The checker enforces rule validity and goal consistency, enabling
trustless validation: user space may reason a formula, but the kernel
only accepts results backed by a proof that checks.

The proof checker introduced in this patch set can also be executed in
*user space*, with all dependent kernel routines stubbed with their
user-space counterparts. One can compile and try it with the proofs
in our repo[6], and see the proof checking process.

Proof checker complexity
------------------------

The cost/complexity is mostly the checker itself. The proof checker
as introduced in the previous section is essentially a linear scan of
the given proof. While our patch sets are a bit huge and the checker
contains about 5k lines of code, its complexity is much lower than
the verifier.

Comparisons to the verifier:

The complexity of the verifier is non-linear in the sense that every
time when one wants to extend the verifier, e.g., adding a field to
the verifier_state struct, a lot of factors need to be considered:
(1) the effects of every instruction on this field, (2) its semantics
for state pruning, (3) liveness/precision potentially kick in, etc.

In comparison, the proof checker is a **linear** combination of a fixed
set of proof rules:
    - They are independent of each other:
    - Adding a new rule does not break other rules;
    - Understanding one rule does not require understanding other rules.
The complexity is essentially the sum of the complexity of each rule.

Most rules are relatively straightforward (see boolean rules), while
only a few require a bit more thinking; these essentially include
two classes of rules: rewrite and bitblast.

The overall workflow of the checker is just a while loop that scans
each rule (see apply_rules()), while in comparison, the verifier is
a DFS over the program's CFG.

The proof checker is quite stable: (1) in theory, it only needs
to support two rules, resolution and bitblast, to be complete to
represent any proof; (2) in practice, the checker supports tens
of other rules to reduce proof size; (3) the supported rules are
stable and do not require frequent changes, except for some rewrites.

This makes the checker easier to maintain then the verifier.
Currently supporte 50 rules in total:
	core   : 14
	boolean: 33
	bitvec : 3

Additional benefits
-------------------

Beyond refinement, the checker can validate other non-trivial facts,
one potential use is to validate the precomputed loop fixpoints
(state sets) to simplify the verifier (outlined here; future work).

Current cost of loop analysis: kernel must compute fixpoints at
loop/join points, causing state explosion and complexity when
combined with liveness/precision tracking.

Proof-enabled design: User space provides fixpoint in-states for
loop entries and join points; the kernel validates the provided
fixpoint instead of compute by itself.

Refined verifier algorithm (single pass):
- Userspace input:
  - For each basic block bb, a finite set S_in[bb] describing a fixpoint
    in-state at bb, i.e., the set of states that can be reached from bb.

1. For each bb, take S_in[bb] as incoming states.
2. Analayze the bb once per incoming state to compute S_out for
   each successor (validation phase).
3. For each edge bb->succ, check inclusion S_out[bb->succ] \in S_in[succ].
   If non-trivial, i.e., the verifier cannot verify, emit a containment
   formula G and request a proof; the check then validates the proof.
4. Accept if all inclusions are validated. This witnesses a state
   fixpoint; no kernel-side iteration is needed.

This potentially enables smaller state sets computed offline, reducing
the number of states required to analyze. The wholse analysis is a linear
scan, no liveness/precision track, and the proof is only basic block-wise.

Correctness and evaluation
--------------------------

We validated the checker and enhanced verifier on benchmarks: programs[1] and
formulas[2] with cvc5 proofs. Proof sizes range from 168 bytes to 8.4 MB; the
largest validate in under ~3 seconds. Sanitizers report no memory errors. With
this enhancement, 403 of 512 previously rejected programs can be verified. The
precision is comparable to symbolic-execution-based approaches, while keeping
kernel complexity low.

Patch set contents (this set)
-----------------------------

This set adds the initial proof checker and the verifier refinement workflow,
and it targets `bpf-next`:

  - Patches 1–2: UAPI expression/proof definitions and checker skeleton.
  - Patch 3: UAPI for condition/proof interaction (`bcf_*` fields and flags).
  - Patch 4: High-level `bcf_refine()` and backtracking logic.
  - Patches 5–13: Symbolic tracking (suffix matching, expr arena, MOV/SEXT,
    scalar/pointer ALU with 32-bit lowering, spill/fill, path constraints) and
    pruning controls for parent states.
  - Patch 14: Refinements: path-unreachable and memory-access bound refinement
    (ptr offset and size tightening, var/var safe-access marking).
  - Patches 15–16: Preserve env, request proof, resume and check proof.
  - Patch 17: Enable BCF for privileged users (`bcf.available`).

References
----------

[1] Benchmark programs: https://github.com/SunHao-0/BCF/tree/main/bcf-progs
[2] Benchmark proofs: https://github.com/SunHao-0/BCF/tree/main/bcf-proofs
[3] Early prototype: https://github.com/SunHao-0/BCF/tree/artifact-evaluation
[4] Current full implementation: https://github.com/SunHao-0/BCF
[5] SOSP paper: https://dl.acm.org/doi/10.1145/3731569.3764796
[6] Proof checker: https://github.com/SunHao-0/BCF/tree/main/bcf-checker

Hao Sun (17):
  bpf: Add BCF expr and proof rule definitions
  bpf: Add bcf_checker top-level workflow
  bpf: Add UAPI fields for BCF proof interaction
  bpf: Add top-level workflow of bcf_refine()
  bpf: Add top-level workflow of bcf_track()
  bpf: Add bcf_match_path() to follow the path suffix
  bpf: Add bcf_expr management and binding
  bpf: Track mov and signed extension
  bpf: Track alu operations in bcf_track()
  bpf: Add bcf_alu() 32bits optimization
  bpf: Track stack spill/fill in bcf_track()
  bpf: Track path constraint
  bpf: Skip state pruning for the parent states
  bpf: Add mem access bound refinement
  bpf: Preserve verifier_env and request BCF
  bpf: Resume verifier env and check proof
  bpf: Enable bcf for priv users

 .clang-format                  |    2 +
 include/linux/bcf_checker.h    |   18 +
 include/linux/bpf.h            |    1 +
 include/linux/bpf_verifier.h   |   34 +
 include/uapi/linux/bcf.h       |  197 +++++
 include/uapi/linux/bpf.h       |   21 +
 kernel/bpf/Makefile            |    2 +-
 kernel/bpf/bcf_checker.c       |  440 ++++++++++
 kernel/bpf/liveness.c          |   15 +
 kernel/bpf/syscall.c           |   27 +-
 kernel/bpf/verifier.c          | 1397 +++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |   21 +
 12 files changed, 2143 insertions(+), 32 deletions(-)
 create mode 100644 include/linux/bcf_checker.h
 create mode 100644 include/uapi/linux/bcf.h
 create mode 100644 kernel/bpf/bcf_checker.c

--
2.34.1


