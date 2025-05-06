Return-Path: <bpf+bounces-57583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC43BAAD185
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 01:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D5A4E5D7E
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 23:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158D021CA0A;
	Tue,  6 May 2025 23:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiG7sXnu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E80E4B1E60
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 23:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746573802; cv=none; b=sImm9Ol9bBLqt/kz3k1fhbvuQoFTpbXJKownIbcS2yasJDrCrWlbuvk5BG4lh9PVZHD9W5g8vbUHAZPQhrwTXkFBtmK1U34mTjeHTUc8kiEN50iOlZbRUsJqlW1aV+hB9ZEQx/Uk3qt3I5Qe+KqnUB3DYJeND5s5XxjCs2xf6QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746573802; c=relaxed/simple;
	bh=Jfl2U9Nw1YBRhKN7k7HkzMwarff3nU9z0B1haqTmZTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JjD0dMmB0LzkdQdbXrE/m8P0WrkD5EfiGqZ4vvPyh+3vx2RlBcVOaJj2Y7NXJs/lAtVlaSHh2NnUIs00W8/6m2OOVwSz2RhpnAN+Q1MBvSj8N6/b0suxr8QjYSSFSmz07+QfaJZKNXSW0A9jSs7jD19riRwMbB8C2vG2EWAdbek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiG7sXnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA6BC4CEE4;
	Tue,  6 May 2025 23:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746573801;
	bh=Jfl2U9Nw1YBRhKN7k7HkzMwarff3nU9z0B1haqTmZTk=;
	h=From:To:Cc:Subject:Date:From;
	b=fiG7sXnutV8XKIArv1YNlydp1nO6ppi8+EmF3kB+RiAMymCZVHok2ctDbEp5hBSY5
	 ost1fu8tIcOVDtxXwXhXR51PiVrO2N0CbKCQDb8IwpYBm0eoo0GwIlRAQrNfFxydEh
	 09FznAefiZaiNPf4L9GLEr9ZvnoZgo8LLEk1ilmmTZZXidrG3xrEX950fkUWcy1viV
	 gqePk5den0xf3teURIz1k5rD2EuwLn5JKc+6Qycs7PvMsaof8poCpj0/jxrJ3Kxl0U
	 EKo5MAQHmlaYJ7tR4TD20MucrUpFYxAzIzJK2y0xtxZLS8x99qNhsL9+NO861IU+L3
	 sGhJB2Zom9Cew==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: tj@kernel.org,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next] bpf, docs: document open-coded BPF iterators
Date: Tue,  6 May 2025 16:23:13 -0700
Message-ID: <20250506232313.1752842-1-andrii@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract BPF open-coded iterators documentation spread out across a few
original commit messages ([0], [1]) into a dedicated doc section under
Documentation/bpf/bpf_iterators.rst. Also make explicit expectation that
BPF iterator program type should be accompanied by a corresponding
open-coded BPF iterator implementation, going forward.

  [0] https://lore.kernel.org/all/20230308184121.1165081-3-andrii@kernel.org/
  [1] https://lore.kernel.org/all/20230308184121.1165081-4-andrii@kernel.org/

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 Documentation/bpf/bpf_iterators.rst | 115 +++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/bpf_iterators.rst b/Documentation/bpf/bpf_iterators.rst
index 385cd05aabf5..f3e9c8894c30 100644
--- a/Documentation/bpf/bpf_iterators.rst
+++ b/Documentation/bpf/bpf_iterators.rst
@@ -2,10 +2,119 @@
 BPF Iterators
 =============
 
+--------
+Overview
+--------
+
+BPF supports two separate entities collectively known as "BPF iterators": BPF
+iterator *program type* and *open-coded* BPF iterators. The former is
+a stand-alone BPF program type which, when attached and activated by user,
+will be called once for each entity (task_struct, cgroup, etc) that is being
+iterated. The latter is a set of BPF-side APIs implementing iterator
+functionalirt and available across multiple BPF program types. Open-coded
+iterators provide similar functionality to BPF iterator programs, but gives
+more flexiblity and control to all other BPF program types. BPF iterator
+programs, on the other hand, can be used to implement anonymous or BPF
+FS-mounted special files, whose contents is generated by attached BPF iterator
+program, backed by seq_file functionality. Both are useful depending on
+specific needs.
+
+When adding a new BPF iterator program, it is expected that similar
+functionality will be added as open-coded iterator for maximum flexibility.
+It's also expected that iteration logic and code will be maximally shared and
+reused between two iterator API surfaces.
 
-----------
-Motivation
-----------
+------------------------
+Open-coded BPF Iterators
+------------------------
+
+Open-coded BPF iterators are implemented as tightly-coupled trios of kfuncs
+(constructor, next element fetch, destructor) and iterator-specific type
+describing on-the-stack iterator state, which is guaranteed by the BPF
+verifier to not be tampered with outside of the corresponding
+constructor/destructor/next APIs.
+
+Each kind of open-coded BPF iterator has its own associated struct
+bpf_iter_<type>, where <type> denotes a specific type of iterator. struct
+bpf_iter_<type> state is supposed to live on BPF program stack, so there will
+be no way to change its size later on without breaking backwards
+compatibility, so choose wisely! But given this struct is specific to a given
+<type> of iterator, this allows a lot of flexibility: simple iterators could
+be fine with just one stack slot (8 bytes), like numbers iterator is, while
+some other more complicated iterators might need way more to keep their
+iterator state. Either way, such design allows to avoid runtime memory
+allocations, which otherwise would be necessary if we fixed on-the-stack size
+and it turned out to be too small for a given iterator implementation.
+
+All kfuncs (constructor, next, destructor) have to be named consistenly as
+bpf_iter_<type>_{new,next,destroy}(), respectively. <type> represents iterator
+type, and iterator state should be represented as a matching
+`struct bpf_iter_<type>` state type. Also, all iter kfuncs should have
+a pointer to this `struct bpf_iter_<type>` as the very first argument.
+
+Additionally:
+  - Constructor, i.e., `bpf_iter_<type>_new()`, can have arbitrary extra
+  number of arguments. Return type is not enforced either.
+  - Next method, i.e., `bpf_iter_<type>_next()`, has to return a pointer
+  type and should have exactly one argument: `struct bpf_iter_<type> *`
+  (const/volatile/restrict and typedefs are ignored).
+  - Destructor, i.e., `bpf_iter_<type>_destroy()`, should return void and
+  should have exactly one argument, similar to the next method.
+  - `struct bpf_iter_<type>` size is enforced to be positive and
+  a multiple of 8 bytes (to fit stack slots correctly).
+
+Such strictness and consistency allows to build generic helpers abstracting
+important, but boilerplate, details to be able to use open-coded iterators
+effectively and ergonomically (see libbpf's bpf_for_each() macro). This is
+enforced at kfunc registration point by the kernel.
+
+Constructor/next/destructor implementation contract is as follows:
+  - constructor, `bpf_iter_<type>_new()`, always initializes iterator state on
+    the stack. If any of the input arguments are invalid, constructor should
+    make sure to still initialize it such that subsequent next() calls will
+    return NULL. I.e., on error, *return error and construct empty iterator*.
+    Constructor kfunc is marked with KF_ITER_NEW flag.
+
+  - next method, `bpf_iter_<type>_next()`, accepts pointer to iterator state
+    and produces an element. Next method should always return a pointer. The
+    contract between BPF verifier is that next method *guarantees* that it
+    will eventually return NULL when elements are exhausted. Once NULL is
+    returned, subsequent next calls *should keep returning NULL*. Next method
+    is marked with KF_ITER_NEXT (and should also have KF_RET_NULL as
+    NULL-returning kfunc, of course).
+
+  - destructor, `bpf_iter_<type>_destroy()`, is always called once. Even if
+    constructor failed or next returned nothing.  Destructor frees up any
+    resources and marks stack space used by `struct bpf_iter_<type>` as usable
+    for something else. Destructor is marked with KF_ITER_DESTROY flag.
+
+Any open-coded BPF iterator implementation has to implement at least these
+three methods. It is enforced that for any given type of iterator only
+applicable constructor/destructor/next are callable. I.e., verifier ensures
+you can't pass number iterator state into, say, cgroup iterator's next method.
+
+From a 10,000-feet BPF verification point of view, next methods are the points
+of forking a verification state, which are conceptually similar to what
+verifier is doing when validating conditional jumps. Verifier is branching out
+`call bpf_iter_<type>_next` instruction and simulates two outcomes: NULL
+(iteration is done) and non-NULL (new element is returned). NULL is simulated
+first and is supposed to reach exit without looping. After that non-NULL case
+is validated and it either reaches exit (for trivial examples with no real
+loop), or reaches another `call bpf_iter_<type>_next` instruction with the
+state equivalent to already (partially) validated one. State equivalency at
+that point means we technically are going to be looping forever without
+"breaking out" out of established "state envelope" (i.e., subsequent
+iterations don't add any new knowledge or constraints to the verifier state,
+so running 1, 2, 10, or a million of them doesn't matter). But taking into
+account the contract stating that iterator next method *has to* return NULL
+eventually, we can conclude that loop body is safe and will eventually
+terminate. Given we validated logic outside of the loop (NULL case), and
+concluded that loop body is safe (though potentially looping many times),
+verifier can claim safety of the overall program logic.
+
+------------------------
+BPF Iterators Motivation
+------------------------
 
 There are a few existing ways to dump kernel data into user space. The most
 popular one is the ``/proc`` system. For example, ``cat /proc/net/tcp6`` dumps
-- 
2.47.1


