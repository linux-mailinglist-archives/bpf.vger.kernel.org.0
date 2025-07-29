Return-Path: <bpf+bounces-64643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E53CB15278
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 20:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084B0165F1C
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD07299944;
	Tue, 29 Jul 2025 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfKinHl3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E0022AE7F;
	Tue, 29 Jul 2025 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753812395; cv=none; b=KqkxVuQG9efsmb5lpt2o4RVCy8vlfnaWABXjRqnQFUUgnsEvjBlx1jcLYSNCc1dk0gttR7DLFh9zYuFysMm2musDxdXPQjZOShtjkoLHATaztPkvzfvVr7e9wvjA+gLoYJavytCbIgTGQdcndNurCMDIIuaPbET2zM3TUhzXGwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753812395; c=relaxed/simple;
	bh=kvHAgJ2aCQdErSUqwChBzFJr4EGAmr+NIMNoyqKTjDc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gIQdSYrhjIxkhmA413m0wPyxO3pxO18i8zF9+R9VbCip7Gmd2A2ICV8rJ/2Ey2EhPvvGJvZFBManzjThTsqV5ZRi3fq1ZH60UsiWsM2C9PEh70K4YwizER1NXWpmzELJjOH1MoBLV2R1SBZd2ApshUt3KHV1JIeIoY+XGZUTRwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfKinHl3; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b3bdab4bf19so60712a12.2;
        Tue, 29 Jul 2025 11:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753812392; x=1754417192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zbBH+T/vV0YGp/r6q+sIjtu3yS1dk6yMb+V1owzTjy8=;
        b=HfKinHl34JNwsUkml9booqUMah/7dTM+NiVUJ5w5tSNDjpZY10yrTdRD8rjOM6lEbr
         toZCHDs3yd02L2IBDLEZInuFAaKsqq2CbbXxAp0stfoi6fCcdXGvfbB7U2sUd0Xr2zeK
         chGVyN0wd5bXQ57b0AW5/kYWeJEvJ7isfP3HCrsHNWnsQDwig28pwb6fQs7+sXC2A0H4
         nbz0gF6aOPr6cbItRl/Gjujgrx5zvCX9Vgz5leYvCW0LBPcvukQZKq+kfzH2nqpcq4I+
         Q44IDsQFFo+sfqSx7Dbp95INPnletwWJqizZk9kkJ21XB3X+Wp1tIuHnIVK5vE/1GxPt
         xuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753812392; x=1754417192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbBH+T/vV0YGp/r6q+sIjtu3yS1dk6yMb+V1owzTjy8=;
        b=AsVowgiIb8a9gmhhwZD0weYbP6n86VAXoXL4gPHJKs5qLrZuTJsuRxdLBgp4SCdvIp
         v5kJoSDg3naDS+CctoQxapuZgvGiC0KkvbRN+rLhC75Sn6PDR8U1PDBkzQghntgmWLFX
         I+St4pvMmyKU/e3y4Yn6zNdA/cFnLT0ikBndW3eW47o2VwiyM8X0Fd2Z4mcmAyLjhY//
         FXfS0EfOAtZDII22LrYCZI6KQjio+ypyOZDHAQHyvN7ZolicD/QFWC06b/ikC0RK7+8q
         AIt5dY+8xhLHRmAjEl9CQrURFtu4AWf2uO3PTq9vL36vYdi/Vjnd7m11ah4TITEBYxCF
         ZkBA==
X-Forwarded-Encrypted: i=1; AJvYcCUre/Kyc1lKK8FNb5SNPMF//W5lL6UCJiydWsraEa7KEu86Xk1l22EaucEw+4QDk4stxkp9Ork9ecFLqzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvAJGk/uBWakXFudjQxh6S2+QGqn1J4pNUOwzBANznG6aiAAVO
	OX+K/A7sPR1HW2O9Ut4OIzf8itLozD5GSVr+iqrQrdscVdx+9feP8WlG
X-Gm-Gg: ASbGncsWUhtuQmkdQumX7zEbVVjL6KGP2ZTakELd0V6Elayp0d0deAKwqIDqJIo/5mc
	5dTXRZ5QXdIp64uL2JKhIw7LZyQ/vl3hXYrDklrgquwexcyJ387Hv87lvDFAPN+QRX+KsNU+iD7
	LEIhhwirT6dLp2tUFd5G+9MN8R7VMZhpOjMsNGeLrxI/JeTMvXmO57KT/MFqg3odSboEsmVlNBX
	2+L2tTxbfQEaUnqjcPJ19FJO8UMhA+x1SRUIhQyogWeqDuv/OPPmre26RyF7Q6esqmSUhhBDX+P
	0xgnHhkG8/CpjsHy14iNJrfFF+qpLi5fgpPuvIERm3J+zszn6XMoR2VCETSavv00lhYzNvhQJ6V
	X67Xmi/mZ9ObxdSGmIq/ChPmJV05sZ5mi70UfjlPzqKYxqUwDqaS4
X-Google-Smtp-Source: AGHT+IFO43nkh8HgnHTFy0diIa+1uLL6DE7I9v6yWCCoMu3aoqVXkCyUc9UKj6ZySIcUBzXPQ0GM8A==
X-Received: by 2002:a17:90a:d607:b0:31c:c434:dec8 with SMTP id 98e67ed59e1d1-31f5de4b8eamr610957a91.20.1753812391778;
        Tue, 29 Jul 2025 11:06:31 -0700 (PDT)
Received: from ast-mac.thefacebook.com ([2620:10d:c090:500::7:669b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f328b9dfcsm2188922a91.16.2025.07.29.11.06.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Jul 2025 11:06:31 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	linux-kernel@vger.kernel.org,
	brauner@kernel.org
Subject: [GIT PULL] BPF changes for 6.17
Date: Tue, 29 Jul 2025 11:06:26 -0700
Message-Id: <20250729180626.35057-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 7abc678e308467ab60ffb8c31f4638a47ee3518c:

  Merge tag 'pmdomain-v6.16-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm (2025-07-18 12:02:17 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.17

for you to fetch changes up to cd7c97f4584a93578f87ea6ff427f74e9a943cdf:

  Merge branch 'bpf-show-precise-rejected-function-when-attaching-to-__noreturn-and-deny-list-functions' (2025-07-28 19:39:30 -0700)

----------------------------------------------------------------
There are conflicts, since Christian rebased what should have been
a stable branch:
https://lore.kernel.org/all/20250623-rebel-verlust-8fcd4cdd9122@brauner/
and sent a pull request for 'vfs-6.17-rc1.bpf' instead:
https://lore.kernel.org/all/20250725-vfs-bpf-a1ee4bf91435@brauner/
I explicitly warned against rebasing it:
https://lore.kernel.org/all/CAADnVQ+iqMi2HEj_iH7hsx+XJAsqaMWqSDe4tzcGAnehFWA9Sw@mail.gmail.com/
since bpf/bpf-next trees are not rebased unlike vfs branches.

The 'vfs-6.17.bpf' branch was created on June 23 in vfs.git and merged into
bpf-next on June 26:
      Merge branch 'vfs-6.17.bpf' of https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs

There were conflicts back then that were resolved during the merge of
vfs-6.17.bpf into bpf-next:
https://lore.kernel.org/all/CAADnVQ+pPt7Zt8gS0aW75WGrwjmcUcn3s37Ahd9bnLyzOfB=3g@mail.gmail.com/
Then more fixes to selftests/bpf/*cgroup_xattr* were applied on top.
Due to unnecessary rebase these conflicts have to be resolved again.

Please apply all new hunks from this pull request to resolve conflicts in:
	both modified:   kernel/bpf/helpers.c
	both added:      tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c
	both added:      tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c

Other than that the changes are:

- Remove usermode driver (UMD) framework (Thomas Weißschuh)

- Introduce Strongly Connected Component (SCC) in the verifier to
  detect loops and refine register liveness (Eduard Zingerman)

- Allow 'void *' cast using bpf_rdonly_cast() and corresponding
  '__arg_untrusted' for global function parameters (Eduard Zingerman)

- Improve precision for BPF_ADD and BPF_SUB operations in the verifier
  (Harishankar Vishwanathan)

- Teach the verifier that constant pointer to a map cannot be NULL
  (Ihor Solodrai)

- Introduce BPF streams for error reporting of various conditions
  detected by BPF runtime (Kumar Kartikeya Dwivedi)

- Teach the verifier to insert runtime speculation barrier (lfence on x86)
  to mitigate speculative execution instead of rejecting the programs
  (Luis Gerhorst)

- Various improvements for 'veristat' (Mykyta Yatsenko)

- For CONFIG_DEBUG_KERNEL config warn on internal verifier
  errors to improve bug detection by syzbot (Paul Chaignon)

- Support BPF private stack on arm64 (Puranjay Mohan)

- Introduce bpf_cgroup_read_xattr() kfunc to read xattr of cgroup's node
  (Song Liu)

- Introduce kfuncs for read-only string opreations (Viktor Malik)

- Implement show_fdinfo() for bpf_links (Tao Chen)

- Reduce verifier's stack consumption (Yonghong Song)

- Implement mprog API for cgroup-bpf programs (Yonghong Song)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Al Viro (1):
      bpf: Get rid of redundant 3rd argument of prepare_seq_file()

Alexei Starovoitov (22):
      Merge branch 'selftests-bpf-fix-a-few-test-failures-with-arm64-64kb-page'
      Merge branch 'bpf-mitigate-spectre-v1-using-barriers'
      Merge branch 'bpf-propagate-read-precision-marks-over-state-graph-backedges'
      Merge branch 'bpf-fix-a-few-test-failures-with-64k-page-size'
      Merge branch 'bpf-verifier-improve-precision-of-bpf_add-and-bpf_sub'
      Merge branch 'range-tracking-for-bpf_neg'
      Merge branch 'bpf-allow-void-cast-using-bpf_rdonly_cast'
      Merge branch 'bpf-add-kfuncs-for-read-only-string-operations'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf after rc3
      Merge branch 'vfs-6.17.bpf' of https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
      Merge branch 's390-bpf-describe-the-frame-using-a-struct-instead-of-constants'
      Merge branch 'bpf-standard-streams'
      Merge branch 'bpf-reduce-verifier-stack-frame-size'
      Merge branch 'bpf-additional-use-cases-for-untrusted-ptr_to_mem'
      Merge branch 'bpf-streams-fixes'
      Merge branch 'bpf-fix-and-test-aux-usage-after-do_check_insn'
      Merge branch 'bpf-arena-add-kfunc-for-reserving-arena-memory'
      Merge branch 'bpf-arm64-relax-constraint-in-bpf-jit-compiler'
      Merge branch 'a-tool-to-verify-the-bpf-memory-model'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf after rc6
      Merge branch 'bpf-improve-64bits-bounds-refinement'
      Merge branch 'bpf-show-precise-rejected-function-when-attaching-to-__noreturn-and-deny-list-functions'

Alexis Lothoré (eBPF Foundation) (2):
      bpf, arm64: remove structs on stack constraint
      selftests/bpf: enable tracing_struct tests for arm64

Andrii Nakryiko (7):
      Merge branch 'bpf-implement-mprog-api-on-top-of-existing-cgroup-progs'
      Merge branch 'bpf-make-reg_not_null-true-for-const_ptr_to_map'
      Merge branch 'veristat-memory-accounting-for-bpf-programs'
      Merge branch 'support-array-presets-in-veristat'
      Merge branch 'bpf-add-bpf_dynptr_memset-kfunc'
      Merge branch 'move-attach_type-into-bpf_link'
      libbpf: start v1.7 dev cycle

Anton Protopopov (1):
      bpf: add btf_type_is_i{32,64} helpers

Blake Jones (2):
      libbpf: Add support for printing BTF character arrays as strings
      Tests for the ".emit_strings" functionality in the BTF dumper.

Christian Brauner (2):
      kernfs: remove iattr_mutex
      Merge patch series "Introduce bpf_cgroup_read_xattr"

Colin Ian King (1):
      selftests/bpf: Fix spelling mistake "subtration" -> "subtraction"

Eduard Zingerman (34):
      Revert "bpf: use common instruction history across all states"
      bpf: compute SCCs in program control flow graph
      bpf: frame_insn_idx() utility function
      bpf: starting_state parameter for __mark_chain_precision()
      bpf: set 'changed' status if propagate_precision() did any updates
      bpf: set 'changed' status if propagate_liveness() did any updates
      bpf: move REG_LIVE_DONE check to clean_live_states()
      bpf: propagate read/precision marks over state graph backedges
      bpf: remove {update,get}_loop_entry functions
      bpf: include backedges in peak_states stat
      selftests/bpf: tests with a loop state missing read/precision mark
      bpf: Include verifier memory allocations in memcg statistics
      veristat: Memory accounting for bpf programs
      bpf: handle jset (if a & b ...) as a jump in CFG computation
      selftests/bpf: verify jset handling in CFG computation
      selftests/bpf: More precise cpu_mitigations state detection
      selftests/bpf: include limits.h needed for PATH_MAX directly
      bpf: add bpf_features enum
      bpf: allow void* cast using bpf_rdonly_cast()
      selftests/bpf: check operations on untrusted ro pointers to mem
      bpf: guard BTF_ID_FLAGS(bpf_cgroup_read_xattr) with CONFIG_BPF_LSM
      selftests/bpf: bpf_rdonly_cast u{8,16,32,64} access tests
      bpf: avoid jump misprediction for PTR_TO_MEM | PTR_UNTRUSTED
      selftests/bpf: null checks for rdonly_untrusted_mem should be preserved
      bpf: make makr_btf_ld_reg return error for unexpected reg types
      bpf: rdonly_untrusted_mem for btf id walk pointer leafs
      selftests/bpf: ptr_to_btf_id struct walk ending with primitive pointer
      bpf: attribute __arg_untrusted for global function parameters
      libbpf: __arg_untrusted in bpf_helpers.h
      selftests/bpf: test cases for __arg_untrusted
      bpf: support for void/primitive __arg_untrusted global func params
      selftests/bpf: tests for __arg_untrusted void * global func params
      selftests/bpf: Remove enum64 case from __arg_untrusted test suite
      libbpf: Verify that arena map exists when adding arena relocations

Emil Tsalapatis (2):
      bpf/arena: add bpf_arena_reserve_pages kfunc
      selftests/bpf: add selftests for bpf_arena_reserve_pages

Eslam Khafagy (2):
      Documentation: Fix spelling mistake.
      bpf, doc: Improve wording of docs

Feng Yang (1):
      bpf: Clean up individual BTF_ID code

Fushuai Wang (1):
      selftests/bpf: fix signedness bug in redir_partial()

Harishankar Vishwanathan (2):
      bpf, verifier: Improve precision for BPF_ADD and BPF_SUB
      selftests/bpf: Add testcases for BPF_ADD and BPF_SUB

Ihor Solodrai (5):
      bpf: Make reg_not_null() true for CONST_PTR_TO_MAP
      selftests/bpf: Add cmp_map_pointer_with_const test
      selftests/bpf: Add test cases with CONST_PTR_TO_MAP null checks
      bpf: Add bpf_dynptr_memset() kfunc
      selftests/bpf: Add test cases for bpf_dynptr_memset()

Ilya Leoshkevich (3):
      s390/bpf: Centralize frame offset calculations
      s390/bpf: Describe the frame using a struct instead of constants
      bpf: Update iterators.lskel-big-endian.h

James Bottomley (1):
      bpf: Fix key serial argument of bpf_lookup_user_key()

Jiawei Zhao (1):
      libbpf: Correct some typos and syntax issues in usdt doc

KaFai Wan (4):
      bpf: Show precise rejected function when attaching fexit/fmod_ret to __noreturn functions
      bpf: Add log for attaching tracing programs to functions in deny list
      selftests/bpf: Add selftest for attaching tracing programs to functions in deny list
      selftests/bpf: Migrate fexit_noreturns case into tracing_failure test suite

Kumar Kartikeya Dwivedi (14):
      bpf: Refactor bprintf buffer support
      bpf: Introduce BPF standard streams
      bpf: Add function to extract program source info
      bpf: Ensure RCU lock is held around bpf_prog_ksym_find
      bpf: Add function to find program from stack trace
      bpf: Add dump_stack() analogue to print to BPF stderr
      bpf: Report may_goto timeout to BPF stderr
      bpf: Report rqspinlock deadlocks/timeout to BPF stderr
      libbpf: Add bpf_stream_printk() macro
      libbpf: Introduce bpf_prog_stream_read() API
      bpftool: Add support for dumping streams
      selftests/bpf: Add tests for prog streams
      bpf: Fix bounds for bpf_prog_get_file_line linfo loop
      bpf: Fix improper int-to-ptr cast in dump_stack_cb

Luis Gerhorst (15):
      bpf: Clarify sanitize_check_bounds()
      bpf: Move insn if/else into do_check_insn()
      bpf: Return -EFAULT on misconfigurations
      bpf: Return -EFAULT on internal errors
      bpf, arm64, powerpc: Add bpf_jit_bypass_spec_v1/v4()
      bpf, arm64, powerpc: Change nospec to include v1 barrier
      bpf: Rename sanitize_stack_spill to nospec_result
      bpf: Fall back to nospec for Spectre v1
      selftests/bpf: Add test for Spectre v1 mitigation
      bpf: Fix state use-after-free on push_stack() err
      bpf: Remove redundant free_verifier_state()/pop_stack()
      powerpc/bpf: Fix warning for unused ori31_emitted
      selftests/bpf: Support ppc64el in vmtest
      bpf: Fix aux usage after do_check_insn()
      selftests/bpf: Add Spectre v4 tests

Martin KaFai Lau (1):
      Merge branch 'selftests-bpf-fix-a-few-dynptr-test-failures-with-64k-page-size'

Matteo Croce (2):
      selftests/bpf: Don't call fsopen() as privileged user
      libbpf: Fix warning in calloc() usage

Menglong Dong (1):
      bpf: Make update_prog_stats() always_inline

Mykyta Yatsenko (7):
      selftests/bpf: Fix unintentional switch case fall through
      selftests/bpf: Separate var preset parsing in veristat
      selftests/bpf: Support array presets in veristat
      selftests/bpf: Test array presets in veristat
      selftests/bpf: improve error messages in veristat
      selftests/bpf: Enable dynptr/test_probe_read_user_str_dynptr
      selftests/bpf: Allow veristat compile standalone

Paul Chaignon (13):
      bpf: Warn on internal verifier errors
      selftests/bpf: Negative test case for ref_obj_id in args
      bpf: Avoid warning on multiple referenced args in call
      bpf: Avoid warning on unexpected map for tail call
      selftests/bpf: Negative test case for tail call map
      bpf: Forget ranges when refining tnum after JSET
      selftests/bpf: Range analysis test case for JSET
      bpf: Simplify bounds refinement from s32
      bpf: Improve bounds when s64 crosses sign boundary
      selftests/bpf: Update reg_bound range refinement logic
      selftests/bpf: Test cross-sign 64bits range refinement
      selftests/bpf: Test invariants on JSLT crossing sign
      bpf: Add third round of bounds deduction

Puranjay Mohan (5):
      selftests/bpf: fix implementation of smp_mb()
      bpf, arm64: Fix fp initialization for exception boundary
      bpf: Move bpf_jit_get_prog_name() to core.c
      bpf, arm64: JIT support for private stack
      selftests/bpf: Enable private stack tests for arm64

Rong Tao (1):
      selftests/bpf: rbtree: Fix incorrect global variable usage

Ruslan Semchenko (1):
      tools/bpf_jit_disasm: Fix potential negative tpath index in get_exec_path()

Saket Kumar Bhaskar (1):
      selftests/bpf: Set CONFIG_PACKET=y for selftests

Slava Imameev (2):
      bpftool: Use appropriate permissions for map access
      selftests/bpf: Add test for bpftool access to read-only protected maps

Song Liu (8):
      bpf: Initialize used but uninit variable in propagate_liveness()
      bpf/veristat: Fix veristat for map type BPF_MAP_TYPE_CGRP_STORAGE
      bpf: Introduce bpf_cgroup_read_xattr to read xattr of cgroup's node
      bpf: Mark cgroup_subsys_state->cgroup RCU safe
      selftests/bpf: Add tests for bpf_cgroup_read_xattr
      bpf: Add range tracking for BPF_NEG
      selftests/bpf: Add tests for BPF_NEG range tracking logic
      selftests/bpf: Fix cgroup_xattr/read_cgroupfs_xattr

Suchit Karunakaran (1):
      bpf: Fix various typos in verifier.c comments

Tao Chen (22):
      bpf: Add cookie to raw_tp bpf_link_info
      selftests/bpf: Add cookies check for raw_tp fill_link_info test
      bpftool: Display cookie for raw_tp link probe
      bpf: Add show_fdinfo for perf_event
      bpf: Add cookie to tracing bpf_link_info
      selftests/bpf: Add cookies check for tracing fill_link_info test
      bpftool: Display cookie for tracing link probe
      bpf: Add cookie in fdinfo for tracing
      bpf: Add cookie in fdinfo for raw_tp
      bpf: Show precise link_type for {uprobe,kprobe}_multi fdinfo
      bpf: Add show_fdinfo for uprobe_multi
      bpf: Add show_fdinfo for kprobe_multi
      bpf: Clean code with bpf_copy_to_user()
      bpf: Add attach_type field to bpf_link
      bpf: Remove attach_type in bpf_cgroup_link
      bpf: Remove attach_type in sockmap_link
      bpf: Remove location field in tcx_link
      bpf: Remove attach_type in bpf_netns_link
      bpf: Remove attach_type in bpf_tracing_link
      netkit: Remove location field in netkit_link
      bpf: Add struct bpf_token_info
      bpf/selftests: Add selftests for token info

Thomas Weißschuh (2):
      bpf/preload: Don't select USERMODE_DRIVER
      umd: Remove usermode driver framework

Tobias Klauser (1):
      bpf: adjust path to trace_output sample eBPF program

Viktor Malik (5):
      uaccess: Define pagefault lock guard
      bpf: Add kfuncs for read-only string operations
      selftests/bpf: Allow macros in __retval
      selftests/bpf: Add tests for string kfuncs
      bpf: Fix string kfuncs names in doc comments

Yonghong Song (24):
      selftests/bpf: Reduce test_xdp_adjust_frags_tail_grow logs
      selftests/bpf: Fix bpf_mod_race test failure with arm64 64KB page size
      selftests/bpf: Fix ringbuf/ringbuf_write test failure with arm64 64KB page size
      selftests/bpf: Fix a user_ringbuf failure with arm64 64KB page size
      cgroup: Add bpf prog revisions to struct cgroup_bpf
      bpf: Implement mprog API on top of existing cgroup progs
      libbpf: Support link-based cgroup attach with options
      selftests/bpf: Move some tc_helpers.h functions to test_progs.h
      selftests/bpf: Add two selftests for mprog API based cgroup progs
      selftests/bpf: Fix cgroup_mprog_ordering failure due to uninitialized variable
      docs/bpf: Default cpu version changed from v1 to v3 in llvm 20
      bpf: Fix an issue in bpf_prog_test_run_xdp when page size greater than 4K
      selftests/bpf: Fix two net related test failures with 64K page size
      selftests/bpf: Fix xdp_do_redirect failure with 64KB page size
      selftests/bpf: Fix RELEASE build failure with gcc14
      selftests/bpf: Fix usdt multispec failure with arm64/clang20 selftest build
      bpf: Simplify assignment to struct bpf_insn pointer in do_misc_fixups()
      bpf: Reduce stack frame size by using env->insn_buf for bpf insns
      bpf: Avoid putting struct bpf_scc_callchain variables on the stack
      selftests/bpf: Fix build error due to certain uninitialized variables
      bpf: Use ERR_CAST instead of ERR_PTR(PTR_ERR(...))
      selftests/bpf: Increase xdp data size for arm64 64K page size
      selftests/bpf: Fix test dynptr/test_dynptr_copy_xdp failure
      selftests/bpf: Fix test dynptr/test_dynptr_memset_xdp_chunks failure

Yuan Chen (2):
      bpftool: Fix JSON writer resource leak in version command
      bpftool: Fix memory leak in dump_xx_nlmsg on realloc failure

 Documentation/bpf/bpf_devel_QA.rst                 |    7 +-
 .../bpf/standardization/instruction-set.rst        |    6 +-
 arch/arm64/net/bpf_jit.h                           |    5 +
 arch/arm64/net/bpf_jit_comp.c                      |  167 +-
 arch/powerpc/net/bpf_jit_comp64.c                  |   79 +-
 arch/s390/net/bpf_jit.h                            |   55 -
 arch/s390/net/bpf_jit_comp.c                       |  113 +-
 arch/x86/net/bpf_jit_comp.c                        |   10 +-
 drivers/net/netkit.c                               |   10 +-
 fs/bpf_fs_kfuncs.c                                 |   34 +
 fs/kernfs/inode.c                                  |   74 +-
 include/linux/bpf-cgroup-defs.h                    |    1 +
 include/linux/bpf-cgroup.h                         |    1 -
 include/linux/bpf.h                                |  125 +-
 include/linux/bpf_verifier.h                       |   81 +-
 include/linux/btf.h                                |    3 +
 include/linux/filter.h                             |    4 +-
 include/linux/tnum.h                               |    2 +
 include/linux/uaccess.h                            |    2 +
 include/linux/usermode_driver.h                    |   19 -
 include/net/tcx.h                                  |    1 -
 include/uapi/linux/bpf.h                           |   45 +-
 kernel/Makefile                                    |    1 -
 kernel/bpf/Makefile                                |    2 +-
 kernel/bpf/arena.c                                 |   43 +
 kernel/bpf/arraymap.c                              |   11 +-
 kernel/bpf/bpf_iter.c                              |   14 +-
 kernel/bpf/bpf_local_storage.c                     |    8 +-
 kernel/bpf/bpf_struct_ops.c                        |    5 +-
 kernel/bpf/btf.c                                   |  116 +-
 kernel/bpf/cgroup.c                                |  195 +-
 kernel/bpf/core.c                                  |  151 +-
 kernel/bpf/helpers.c                               |  470 +++-
 kernel/bpf/link_iter.c                             |    3 +-
 kernel/bpf/local_storage.c                         |    9 +-
 kernel/bpf/net_namespace.c                         |   10 +-
 kernel/bpf/preload/Kconfig                         |    5 -
 .../preload/iterators/iterators.lskel-big-endian.h |  492 ++--
 kernel/bpf/prog_iter.c                             |    3 +-
 kernel/bpf/rqspinlock.c                            |   23 +
 kernel/bpf/stream.c                                |  526 +++++
 kernel/bpf/syscall.c                               |  289 ++-
 kernel/bpf/tcx.c                                   |   16 +-
 kernel/bpf/tnum.c                                  |    5 +
 kernel/bpf/token.c                                 |   25 +-
 kernel/bpf/trampoline.c                            |   51 +-
 kernel/bpf/verifier.c                              | 2350 +++++++++++++-------
 kernel/cgroup/cgroup.c                             |    5 +
 kernel/kallsyms.c                                  |    3 +-
 kernel/trace/bpf_trace.c                           |   90 +-
 kernel/usermode_driver.c                           |  191 --
 net/bpf/bpf_dummy_struct_ops.c                     |    3 +-
 net/bpf/test_run.c                                 |    2 +-
 net/core/dev.c                                     |    3 +-
 net/core/sock_map.c                                |   13 +-
 net/ipv6/route.c                                   |    3 +-
 net/netfilter/nf_bpf_link.c                        |    3 +-
 net/netlink/af_netlink.c                           |    3 +-
 net/sched/bpf_qdisc.c                              |    9 +-
 tools/bpf/bpf_jit_disasm.c                         |    2 +
 tools/bpf/bpftool/Documentation/bpftool-prog.rst   |    7 +
 tools/bpf/bpftool/bash-completion/bpftool          |   16 +-
 tools/bpf/bpftool/btf.c                            |    8 +-
 tools/bpf/bpftool/common.c                         |   59 +-
 tools/bpf/bpftool/iter.c                           |    2 +-
 tools/bpf/bpftool/link.c                           |    8 +-
 tools/bpf/bpftool/main.c                           |    6 +-
 tools/bpf/bpftool/main.h                           |   13 +-
 tools/bpf/bpftool/map.c                            |   56 +-
 tools/bpf/bpftool/map_perf_ring.c                  |    3 +-
 tools/bpf/bpftool/net.c                            |   15 +-
 tools/bpf/bpftool/prog.c                           |   53 +-
 tools/include/uapi/linux/bpf.h                     |   45 +-
 tools/lib/bpf/bpf.c                                |   64 +
 tools/lib/bpf/bpf.h                                |   26 +
 tools/lib/bpf/bpf_helpers.h                        |   17 +
 tools/lib/bpf/btf.h                                |    3 +-
 tools/lib/bpf/btf_dump.c                           |   55 +-
 tools/lib/bpf/libbpf.c                             |   35 +-
 tools/lib/bpf/libbpf.h                             |   15 +
 tools/lib/bpf/libbpf.map                           |    5 +
 tools/lib/bpf/libbpf_version.h                     |    2 +-
 tools/lib/bpf/usdt.c                               |   10 +-
 tools/testing/selftests/bpf/DENYLIST               |    1 -
 tools/testing/selftests/bpf/DENYLIST.aarch64       |    1 -
 tools/testing/selftests/bpf/Makefile               |    6 +
 tools/testing/selftests/bpf/bpf_arena_common.h     |    3 +
 tools/testing/selftests/bpf/bpf_atomic.h           |    2 +-
 tools/testing/selftests/bpf/bpf_experimental.h     |    3 +
 tools/testing/selftests/bpf/bpf_kfuncs.h           |    2 +-
 tools/testing/selftests/bpf/cgroup_helpers.c       |   21 +
 tools/testing/selftests/bpf/cgroup_helpers.h       |    4 +
 tools/testing/selftests/bpf/config                 |    1 +
 tools/testing/selftests/bpf/config.ppc64el         |   93 +
 .../selftests/bpf/prog_tests/bloom_filter_map.c    |    2 +-
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |   50 +-
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c  |    2 +-
 .../selftests/bpf/prog_tests/bpf_mod_race.c        |    2 +-
 tools/testing/selftests/bpf/prog_tests/btf_dump.c  |  118 +
 .../selftests/bpf/prog_tests/cgroup_mprog_opts.c   |  617 +++++
 .../bpf/prog_tests/cgroup_mprog_ordering.c         |   77 +
 .../selftests/bpf/prog_tests/cgroup_xattr.c        |   72 +
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |   18 +-
 tools/testing/selftests/bpf/prog_tests/fd_array.c  |    2 +-
 .../selftests/bpf/prog_tests/fexit_noreturns.c     |    9 -
 .../testing/selftests/bpf/prog_tests/linked_list.c |    2 +-
 tools/testing/selftests/bpf/prog_tests/log_buf.c   |    4 +
 .../bpf/prog_tests/mem_rdonly_untrusted.c          |    9 +
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  |   14 +
 tools/testing/selftests/bpf/prog_tests/ringbuf.c   |    4 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c      |    2 +
 tools/testing/selftests/bpf/prog_tests/stream.c    |  141 ++
 .../selftests/bpf/prog_tests/string_kfuncs.c       |   65 +
 tools/testing/selftests/bpf/prog_tests/tailcalls.c |    2 +-
 .../testing/selftests/bpf/prog_tests/tc_helpers.h  |   28 -
 .../selftests/bpf/prog_tests/test_veristat.c       |  127 +-
 tools/testing/selftests/bpf/prog_tests/token.c     |   85 +-
 .../selftests/bpf/prog_tests/tracing_failure.c     |   52 +
 .../selftests/bpf/prog_tests/uprobe_syscall.c      |    2 +-
 tools/testing/selftests/bpf/prog_tests/usdt.c      |   14 +-
 .../selftests/bpf/prog_tests/user_ringbuf.c        |   10 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |    2 +
 .../selftests/bpf/prog_tests/verify_pkcs7_sig.c    |    2 +-
 .../selftests/bpf/prog_tests/xdp_adjust_tail.c     |  114 +-
 .../selftests/bpf/prog_tests/xdp_do_redirect.c     |   13 +-
 .../selftests/bpf/progs/bpf_iter_map_elem.c        |   22 +
 tools/testing/selftests/bpf/progs/bpf_misc.h       |   22 +-
 tools/testing/selftests/bpf/progs/cgroup_mprog.c   |   30 +
 .../selftests/bpf/progs/cgroup_read_xattr.c        |  158 ++
 .../selftests/bpf/progs/compute_live_registers.c   |   16 +
 tools/testing/selftests/bpf/progs/dynptr_success.c |  174 +-
 .../testing/selftests/bpf/progs/fexit_noreturns.c  |   15 -
 tools/testing/selftests/bpf/progs/iters.c          |  277 +++
 .../selftests/bpf/progs/mem_rdonly_untrusted.c     |  229 ++
 tools/testing/selftests/bpf/progs/rbtree.c         |   14 +-
 tools/testing/selftests/bpf/progs/rcu_read_lock.c  |    5 +-
 .../selftests/bpf/progs/read_cgroupfs_xattr.c      |   60 +
 .../testing/selftests/bpf/progs/security_bpf_map.c |   69 +
 .../testing/selftests/bpf/progs/set_global_vars.c  |   56 +-
 tools/testing/selftests/bpf/progs/stream.c         |   79 +
 tools/testing/selftests/bpf/progs/stream_fail.c    |   33 +
 .../selftests/bpf/progs/string_kfuncs_failure1.c   |   87 +
 .../selftests/bpf/progs/string_kfuncs_failure2.c   |   23 +
 .../selftests/bpf/progs/string_kfuncs_success.c    |   37 +
 .../selftests/bpf/progs/struct_ops_private_stack.c |    2 +-
 .../bpf/progs/struct_ops_private_stack_fail.c      |    2 +-
 .../bpf/progs/struct_ops_private_stack_recur.c     |    2 +-
 .../testing/selftests/bpf/progs/test_lookup_key.c  |    4 +-
 .../selftests/bpf/progs/test_ringbuf_write.c       |    4 +-
 .../selftests/bpf/progs/test_sig_in_xattr.c        |    2 +-
 .../selftests/bpf/progs/test_sockmap_change_tail.c |    9 +-
 .../selftests/bpf/progs/test_tc_change_tail.c      |   14 +-
 .../selftests/bpf/progs/test_verify_pkcs7_sig.c    |    2 +-
 .../bpf/progs/test_xdp_adjust_tail_grow.c          |    8 +-
 .../testing/selftests/bpf/progs/tracing_failure.c  |   12 +
 tools/testing/selftests/bpf/progs/verifier_and.c   |    8 +-
 tools/testing/selftests/bpf/progs/verifier_arena.c |  106 +
 .../selftests/bpf/progs/verifier_arena_large.c     |   98 +
 .../testing/selftests/bpf/progs/verifier_bounds.c  |  360 ++-
 .../bpf/progs/verifier_bounds_deduction.c          |   11 +-
 .../selftests/bpf/progs/verifier_div_overflow.c    |    4 +-
 .../selftests/bpf/progs/verifier_global_ptr_args.c |  128 ++
 .../selftests/bpf/progs/verifier_map_in_map.c      |  118 +
 tools/testing/selftests/bpf/progs/verifier_movsx.c |   16 +-
 .../selftests/bpf/progs/verifier_precision.c       |   70 +
 .../selftests/bpf/progs/verifier_private_stack.c   |   89 +-
 .../selftests/bpf/progs/verifier_ref_tracking.c    |    2 +-
 .../selftests/bpf/progs/verifier_tailcall.c        |   31 +
 .../testing/selftests/bpf/progs/verifier_unpriv.c  |  233 +-
 .../selftests/bpf/progs/verifier_value_ptr_arith.c |   38 +-
 tools/testing/selftests/bpf/test_bpftool_map.sh    |  398 ++++
 tools/testing/selftests/bpf/test_loader.c          |   30 +-
 tools/testing/selftests/bpf/test_maps.c            |    4 +-
 tools/testing/selftests/bpf/test_progs.h           |   28 +
 tools/testing/selftests/bpf/unpriv_helpers.c       |   94 +-
 tools/testing/selftests/bpf/verifier/calls.c       |   24 +
 tools/testing/selftests/bpf/verifier/dead_code.c   |    3 +-
 tools/testing/selftests/bpf/verifier/jmp32.c       |   33 +-
 tools/testing/selftests/bpf/verifier/jset.c        |   10 +-
 tools/testing/selftests/bpf/veristat.c             |  610 ++++-
 tools/testing/selftests/bpf/vmtest.sh              |    9 +
 181 files changed, 10118 insertions(+), 2222 deletions(-)
 delete mode 100644 arch/s390/net/bpf_jit.h
 delete mode 100644 include/linux/usermode_driver.h
 create mode 100644 kernel/bpf/stream.c
 delete mode 100644 kernel/usermode_driver.c
 delete mode 100644 tools/testing/selftests/bpf/DENYLIST.aarch64
 create mode 100644 tools/testing/selftests/bpf/config.ppc64el
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_mprog_ordering.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mem_rdonly_untrusted.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stream.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_map_elem.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_mprog.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
 delete mode 100644 tools/testing/selftests/bpf/progs/fexit_noreturns.c
 create mode 100644 tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
 create mode 100644 tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/security_bpf_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_success.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_tailcall.c
 create mode 100755 tools/testing/selftests/bpf/test_bpftool_map.sh

