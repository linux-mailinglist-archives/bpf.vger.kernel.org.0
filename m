Return-Path: <bpf+bounces-62691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0E5AFCECF
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 17:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD31F1BC21A4
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 15:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C511BF37;
	Tue,  8 Jul 2025 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ABg3qPP/"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513062E0B57;
	Tue,  8 Jul 2025 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987744; cv=none; b=ftmfFrbC2/fvkWLdAeE7cmenISwwaJtf/7TnqU1qZd7nMuqm7yi4SZJ/5Rdy9X29hcub3eE1z5CtbL1lXhhxZ5LnzakqeNk+FD+T+Bj9TlvLrFwJDyIDnZuM1hi73R8lpaD0xXE1oeb2FlJe6GfNfnAbIJpQrxBl9b2Iy5nskRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987744; c=relaxed/simple;
	bh=9ht0OSvPzFWv+BYZ8n8tq53+ZpRWm2Yb6qkI4xXLx/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NKt7T8UlkdM3vzmTROqGH7c8LXvGfZ+QbVySFEfqc4OHmWrweN6pOzZ1TBA2Kk/pTL+BS6xwzjsSZNGyOdquVybYXDG3nvf7tFT1eB7PhKvjonNv5X7sz0vD4ft7AJISJf/1gDJIABhtrvqcYYeAQnPO/fG1zeM3tInKKM2kO9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ABg3qPP/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 23CEA201B1AB;
	Tue,  8 Jul 2025 08:15:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 23CEA201B1AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751987741;
	bh=w+bUPwy8Z39T6qIQ560o/LXxUxHkSyS44CRv7NlyhcA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ABg3qPP/LBY3h1U8j759V4ER8a+meJ0bhnIAmEpkYIYZpwf3a5bN1jwEDOuy0/eJg
	 GVbJvFFrdsyZyLxa7w5TDAqeH8mINvm2lS43YXpurJ9MmnZIqThbQ68HO6IhEDoMCw
	 49CukEN7KF5Kk4pQQGOs5TTkAUa8ol8m2HsBqM8c=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com, kys@microsoft.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Subject: Re: [PATCH 00/12] Signed BPF programs
In-Reply-To: <20250606232914.317094-1-kpsingh@kernel.org>
References: <20250606232914.317094-1-kpsingh@kernel.org>
Date: Tue, 08 Jul 2025 08:15:39 -0700
Message-ID: <87ldoy1zok.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

KP Singh <kpsingh@kernel.org> writes:

> BPF Signing has gone over multiple discussions in various conferences with the
> kernel and BPF community and the following patch series is a culmination
> of the current of discussion on signed BPF programs. Once signing is
> implemented, the next focus would be to implement the right security policies
> for all BPF use-cases (dynamically generated bpf programs, simple non CO-RE
> programs).
>
> Signing also paves the way for allowing unrivileged users to
> load vetted BPF programs and helps in adhering to the principle of least
> privlege by avoiding unnecessary elevation of privileges to CAP_BPF and
> CAP_SYS_ADMIN (ofcourse, with the appropriate security policy active).
>
> A early version of this design was proposed in [1]:
>
> # General Idea: Trusted Hash Chain
>
> The key idea of the design is to use a signing algorithm that allows
> us to integrity-protect a number of future payloads, including their
> order, by creating a chain of trust.
>
> Consider that Alice needs to send messages M_1, M_2, ..., M_n to Bob.
> We define blocks of data such that:
>
>     B_n = M_n || H(termination_marker)
>
> (Each block contains its corresponding message and the hash of the
> *next* block in the chain.)
>
>     B_{n-1} = M_{n-1} || H(B_n)
>     B_{n-2} = M_{n-2} || H(B_{n-1})
>
>   ...
>
>     B_2 = M_2 || H(B_3)
>     B_1 = M_1 || H(B_2)
>
> Alice does the following (e.g., on a build system where all payloads
> are available):
>
>   * Assembles the blocks B_1, B_2, ..., B_n.
>   * Calculates H(B_1) and signs it, yielding Sig(H(B_1)).
>
> Alice sends the following to Bob:
>
>     M_1, H(B_2), Sig(H(B_1))
>
> Bob receives this payload and does the following:
>
>     * Reconstructs B_1 as B_1' using the received M_1 and H(B_2)
> (i.e., B_1' = M_1 || H(B_2)).
>     * Recomputes H(B_1') and verifies the signature against the
> received Sig(H(B_1)).
>     * If the signature verifies, it establishes the integrity of M_1
> and H(B_2) (and transitively, the integrity of the entire chain). Bob
> now stores the verified H(B_2) until it receives the next message.
>     * When Bob receives M_2 (and H(B_3) if n > 2), it reconstructs
> B_2' (e.g., B_2' = M_2 || H(B_3), or if n=2, B_2' = M_2 ||
> H(termination_marker)). Bob then computes H(B_2') and compares it
> against the stored H(B_2) that was verified in the previous step.
>
> This process continues until the last block is received and verified.
>
> Now, applying this to the BPF signing use-case, we simplify to two messages:
>
>     M_1 = I_loader (the instructions of the loader program)
>     M_2 = M_metadata (the metadata for the loader program, passed in a
> map, which includes the programs to be loaded and other context)
>
> For this specific BPF case, we will directly sign a composite of the
> first message and the hash of the second. Let H_meta = H(M_metadata).
> The block to be signed is effectively:
>
>     B_signed = I_loader || H_meta
>
> The signature generated is Sig(B_signed).
>
> The process then follows a similar pattern to the Alice and Bob model,
> where the kernel (Bob) verifies I_loader and H_meta using the
> signature. Then, the trusted I_loader is responsible for verifying
> M_metadata against the trusted H_meta.
>
>>From an implementation standpoint:
>
> # Build
>
> bpftool (or some other tool in a trusted build environment) knows
> about the metadata (M_metadata) and the loader program (I_loader). It
> first calculates H_meta = H(M_metadata). Then it constructs the object
> to be signed and computes the signature:
>
>     Sig(I_loader || H_meta)
>
> # Loader
>
> The loader program and the metadata are a hermetic representation of the source
> of the eBPF program, its maps and context. The loader program is generated by
> libbpf as a part of a standard API i.e. bpf_object__gen_loader.
>
> ## Supply chain
>
> While users can use light skeletons as a convenient method to use signing
> support, they can directly use the loader program generation using libbpf
> (bpf_object__gen_loader) into their own trusted toolchains.
>
> libbpf, which has access to the program's instruction buffer is a key part of
> the TCB of the build environment
>
> An advanced threat model that does not intend to depend on libbpf (or any provenant
> userspace BPF libraries) due to supply chain risks despite it being developed
> in the kernel source and by the kernel community will require reimplmenting a
> lot of the core BPF userspace support (like instruction relocation, map handling).
>
> Such an advanced user would also need to integrate the generation of the loader
> into their toolchain.
>
> Given that many use-cases (e.g. Cilium) generate trusted BPF programs,
> trusted loaders are an inevitability and a requirement for signing support, a
> entrusting loader programs will be a fundamental requirement for an security
> policy.
>
> The initial instructions of the loader program verify the SHA256 hash
> of the metadata (M_metadata) that will be passed in a map. These instructions
> effectively embed the precomputed H_meta as immediate values.
>
>     ld_imm64 r1, const_ptr_to_map // insn[0].src_reg == BPF_PSEUDO_MAP_IDX
>     r2 = *(u64 *)(r1 + 0);
>     ld_imm64 r3, sha256_of_map_part1 // precomputed by bpf_object__gen_load/libbpf (H_meta_1)
>     if r2 != r3 goto out;
>
>     r2 = *(u64 *)(r1 + 8);
>     ld_imm64 r3, sha256_of_map_part2 // precomputed by bpf_object__gen_load/libbpf (H_meta_2)
>     if r2 != r3 goto out;
>
>     r2 = *(u64 *)(r1 + 16);
>     ld_imm64 r3, sha256_of_map_part3 // precomputed by bpf_object__gen_load/libbpf (H_meta_3)
>     if r2 != r3 goto out;
>
>     r2 = *(u64 *)(r1 + 24);
>     ld_imm64 r3, sha256_of_map_part4 // precomputed by bpf_object__gen_load/libbpf (H_meta_4)
>     if r2 != r3 goto out;
>     ...
>
> This implicitly makes the payload equivalent to the signed block (B_signed)
>
>     I_loader || H_meta
>
> bpftool then generates the signature of this I_loader payload (which
> now contains the expected H_meta) using a key and an identity:
>
> This signature is stored in bpf_attr, which is extended as follows for
> the BPF_PROG_LOAD command:
>
>     __aligned_u64 signature;
>     __u32 signature_size;
>     __u32 keyring_id;
>
> The reasons for a simpler UAPI is that it's more future proof (e.g.) with more
> stable instruction buffers, loader programs being directly into the compilers.
> A simple API also allows simple programs e.g. for networking that don't need
> loader programs to directly use signing.
>
> # Extending OBJ_GET_INFO_BY_FD for hashes
>
> OBJ_GET_INFO_BY_FD is used to get information about BPF objects (maps, programs, links) and
> returning the hash of the map is a natural extension of the UAPI as it can be
> helpful for debugging, fingerprinting etc.
>
> Currently, it's only implemented for BPF_MAP_TYPE_ARRAY. It can be trivially
> extended for BPF programs to return the complete SHA256 along with the tag.
>
> The SHA is stored in struct bpf_map for exclusive and frozen maps
>
>     struct bpf_map {
>     +   u64 sha[4];
>         const struct bpf_map_ops *ops;
>         struct bpf_map *inner_map_meta;
>     };
>
> ## Exclusive BPF maps
>
> Exclusivity ensures that the map can only be used by a future BPF
> program whose SHA256 hash matches sha256_of_future_prog.
>
> First, bpf_prog_calc_tag() is updated to compute the SHA256 instead of
> SHA1, and this hash is stored in struct bpf_prog_aux:
>
>     @@ -1588,6 +1588,7 @@ struct bpf_prog_aux {
>          int cgroup_atype; /* enum cgroup_bpf_attach_type */
>          struct bpf_map *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
>          char name[BPF_OBJ_NAME_LEN];
>     +    u64 sha[4];
>          u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
>          // ...
>     };
>
> An exclusive is created by passing an excl_prog_hash
> (and excl_prog_hash_size) in the BPF_MAP_CREATE command.
> When a BPF program is subsequently loaded and it attempts to use this map,
> the kernel will compare the program's own SHA256 hash against the one
> registered with the map, if matching, it will be added to prog->used_maps[].
>
> The program load will fail if the hashes do not match or if the map is
> already in use by another (non-matching) exclusive program.
>
> Exclusive maps ensure that no other BPF programs and compromise the intergity of
> the map post the signature verification.
>
> NOTE: Exclusive maps cannot be added as inner maps.
>
> # Light Skeleton Sequence (Userspace Example)
>
> 	err = map_fd = skel_map_create(BPF_MAP_TYPE_ARRAY, "__loader.map",
> 				       opts->excl_prog_hash,
> 				       opts->excl_prog_hash_sz, 4,
> 				       opts->data_sz, 1);
> 	err = skel_map_update_elem(map_fd, &key, opts->data, 0);
>
> 	err = skel_map_freeze(map_fd);
>
> 	// Kernel computes the hash of the map.
> 	err = skel_obj_get_info_by_fd(map_fd);
>
> 	memset(&attr, 0, prog_load_attr_sz);
> 	attr.prog_type = BPF_PROG_TYPE_SYSCALL;
> 	attr.insns = (long) opts->insns;
> 	attr.insn_cnt = opts->insns_sz / sizeof(struct bpf_insn);
> 	attr.signature = (long) opts->signature;
> 	attr.signature_size = opts->signature_sz;
> 	attr.keyring_id = opts->keyring_id;
> 	attr.license = (long) "Dual BSD/GPL";
>
> The kernel will:
>
>     * Compute the hash of the provided I_loader bytecode.
>     * Verify the signature against this computed hash.
>     * Check if the metadata map (now exclusive) is intended for this
>       program's hash.
>
> The signature check happens in BPF_PROG_LOAD before the security_bpf_prog
> LSM hook.
>
> This ensures that the loaded loader program (I_loader), including the
> embedded expected hash of the metadata (H_meta), is trusted.
> Since the loader program is now trusted, it can be entrusted to verify
> the actual metadata (M_metadata) read from the (now exclusive and
> frozen) map against the embedded (and trusted) H_meta. There is no
> Time-of-Check-Time-of-Use (TOCTOU) vulnerability here because:
>
>     * The signature covers the I_loader and its embedded H_meta.
>     * The metadata map M_metadata is frozen before the loader program is loaded
>       and associated with it.
>     * The map is made exclusive to the specific (signed and verified)
>       loader program.
>
> [1] https://lore.kernel.org/bpf/CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com/#t
>

Can we expect to see a v2 of this patchset sometime soon? We are
planning on submitting follow-up patchsets that build on this effort.

-blaise


>
> KP Singh (12):
>   bpf: Implement an internal helper for SHA256 hashing
>   bpf: Update the bpf_prog_calc_tag to use SHA256
>   bpf: Implement exclusive map creation
>   libbpf: Implement SHA256 internal helper
>   libbpf: Support exclusive map creation
>   selftests/bpf: Add tests for exclusive maps
>   bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD
>   bpf: Implement signature verification for BPF programs
>   libbpf: Update light skeleton for signing
>   libbpf: Embed and verify the metadata hash in the loader
>   bpftool: Add support for signing BPF programs
>   selftests/bpf: Enable signature verification for all lskel tests
>
>  include/linux/bpf.h                           |  22 +-
>  include/linux/filter.h                        |   6 -
>  include/uapi/linux/bpf.h                      |  15 +-
>  kernel/bpf/arraymap.c                         |  17 ++
>  kernel/bpf/core.c                             |  88 ++++----
>  kernel/bpf/hashtab.c                          |  15 +-
>  kernel/bpf/syscall.c                          | 112 +++++++++-
>  kernel/bpf/verifier.c                         |   7 +
>  kernel/trace/bpf_trace.c                      |   6 +-
>  .../bpf/bpftool/Documentation/bpftool-gen.rst |  12 +
>  .../bpftool/Documentation/bpftool-prog.rst    |  12 +
>  tools/bpf/bpftool/Makefile                    |   6 +-
>  tools/bpf/bpftool/cgroup.c                    |   5 +-
>  tools/bpf/bpftool/gen.c                       |  58 ++++-
>  tools/bpf/bpftool/main.c                      |  21 +-
>  tools/bpf/bpftool/main.h                      |  11 +
>  tools/bpf/bpftool/prog.c                      |  25 +++
>  tools/bpf/bpftool/sign.c                      | 211 ++++++++++++++++++
>  tools/include/uapi/linux/bpf.h                |  15 +-
>  tools/lib/bpf/bpf.c                           |   6 +-
>  tools/lib/bpf/bpf.h                           |   4 +-
>  tools/lib/bpf/bpf_gen_internal.h              |   2 +
>  tools/lib/bpf/gen_loader.c                    |  52 +++++
>  tools/lib/bpf/libbpf.c                        | 125 ++++++++++-
>  tools/lib/bpf/libbpf.h                        |  16 +-
>  tools/lib/bpf/libbpf.map                      |   5 +
>  tools/lib/bpf/libbpf_internal.h               |   9 +
>  tools/lib/bpf/libbpf_version.h                |   2 +-
>  tools/lib/bpf/skel_internal.h                 |  57 ++++-
>  tools/testing/selftests/bpf/.gitignore        |   1 +
>  tools/testing/selftests/bpf/Makefile          |  13 +-
>  .../selftests/bpf/prog_tests/map_excl.c       | 130 +++++++++++
>  tools/testing/selftests/bpf/progs/map_excl.c  |  65 ++++++
>  tools/testing/selftests/bpf/test_progs.c      |  13 ++
>  34 files changed, 1079 insertions(+), 85 deletions(-)
>  create mode 100644 tools/bpf/bpftool/sign.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/map_excl.c
>  create mode 100644 tools/testing/selftests/bpf/progs/map_excl.c
>
> -- 
> 2.43.0

