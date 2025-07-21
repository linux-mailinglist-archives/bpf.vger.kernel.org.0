Return-Path: <bpf+bounces-63944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE85B0CC5B
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 23:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08FD1AA5542
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 21:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0E723E34C;
	Mon, 21 Jul 2025 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxXL0iZz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA3A2222BB;
	Mon, 21 Jul 2025 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132805; cv=none; b=Ym6dne1o2FE46hHl6S/grJ1YebaqWfaCQpXpeyW/QN5WRt3i5UhH0T7wvE0jDioZGQVMG65mkVtGZuj6eNq/k+XWDGkIPcSUjoN5GSOCBucjrJ/ixXuQQIQPxL9fBz1L3SwoZlWubaKwFfpenAT0cCaIdkz2Qg/L0HfNDMvVNm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132805; c=relaxed/simple;
	bh=DdMZqGsMcsX2j5Fwr65TWS1YgbRCYftmS2bbZClwudk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNHdtV6+OI2nC2BWOmbWJIg7/rY9HOz4EZzrMaWLVkfKrXYPQVR4TcdnjefmhsOWdos4RddcDvgB/2g498mSTlDTYGv5BTiXl9OQPuR8yDX0Y7VgQSj2xKcegyCzXQFgxl5yBVEdFdkwMLzaoPOfrMLx2f7ZBOVIwcAKUKViKeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxXL0iZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CABFC4CEED;
	Mon, 21 Jul 2025 21:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753132805;
	bh=DdMZqGsMcsX2j5Fwr65TWS1YgbRCYftmS2bbZClwudk=;
	h=From:To:Cc:Subject:Date:From;
	b=sxXL0iZzBjLDI3GORBNFaBZR44fWtFMVaAGQbjy35okBCFBE3UhnVuTtbj9sWbXqb
	 gsl40ft0NpOAUypvL0l6skjWDQB42CfKLrGg2NCght/XNOmh66hXkHSBvzT474BQ4g
	 WpRWRwvUL0QMsrSRIZyYCWNvdEPkPyPL64FWc+Fl8Q5qHc7DXaPDBtgasBl5ZAKanM
	 bOqv4QViCT9bSB2/idTZMigoic/XduK1KRwydMhxRC7UWI/Ghkdq4l2Q2k21G8dQy9
	 ZFEsPU7m4b9C8rgHkmGOZPIMaaVjQBQeX+8A1N9wdPMKy31rRddE4B6ciVp/qvdJ2Y
	 52q3Ljnb3nFjg==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: bboscaccy@linux.microsoft.com,
	paul@paul-moore.com,
	kys@microsoft.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Subject: [PATCH v2 00/13] Signed BPF programs
Date: Mon, 21 Jul 2025 23:19:45 +0200
Message-ID: <20250721211958.1881379-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#v1 -> v2

* Addressed feedback on excl maps and their implementation
* fixed s390x and other tests that were failing in the CI.
* using the kernel's sha256 API since it now uses acceleration if available
* simple signing test case, this can be extended to inject a false SHA into
  the loader

BPF Signing has gone over multiple discussions in various conferences with the
kernel and BPF community and the following patch series is a culmination
of the current of discussion and signed BPF programs. Once signing is
implemented, the next focus would be to implement the right security policies
for all BPF use-cases (dynamically generated bpf programs, simple non CO-RE
programs).

Signing also paves the way for allowing unrivileged users to
load vetted BPF programs and helps in adhering to the principle of least
privlege by avoiding unnecessary elevation of privileges to CAP_BPF and
CAP_SYS_ADMIN (ofcourse, with the appropriate security policy active).

A early version of this design was proposed in [1]:

# General Idea: Trusted Hash Chain

The key idea of the design is to use a signing algorithm that allows
us to integrity-protect a number of future payloads, including their
order, by creating a chain of trust.

Consider that Alice needs to send messages M_1, M_2, ..., M_n to Bob.
We define blocks of data such that:

    B_n = M_n || H(termination_marker)

(Each block contains its corresponding message and the hash of the
*next* block in the chain.)

    B_{n-1} = M_{n-1} || H(B_n)
    B_{n-2} = M_{n-2} || H(B_{n-1})

  ...

    B_2 = M_2 || H(B_3)
    B_1 = M_1 || H(B_2)

Alice does the following (e.g., on a build system where all payloads
are available):

  * Assembles the blocks B_1, B_2, ..., B_n.
  * Calculates H(B_1) and signs it, yielding Sig(H(B_1)).

Alice sends the following to Bob:

    M_1, H(B_2), Sig(H(B_1))

Bob receives this payload and does the following:

    * Reconstructs B_1 as B_1' using the received M_1 and H(B_2)
(i.e., B_1' = M_1 || H(B_2)).
    * Recomputes H(B_1') and verifies the signature against the
received Sig(H(B_1)).
    * If the signature verifies, it establishes the integrity of M_1
and H(B_2) (and transitively, the integrity of the entire chain). Bob
now stores the verified H(B_2) until it receives the next message.
    * When Bob receives M_2 (and H(B_3) if n > 2), it reconstructs
B_2' (e.g., B_2' = M_2 || H(B_3), or if n=2, B_2' = M_2 ||
H(termination_marker)). Bob then computes H(B_2') and compares it
against the stored H(B_2) that was verified in the previous step.

This process continues until the last block is received and verified.

Now, applying this to the BPF signing use-case, we simplify to two messages:

    M_1 = I_loader (the instructions of the loader program)
    M_2 = M_metadata (the metadata for the loader program, passed in a
map, which includes the programs to be loaded and other context)

For this specific BPF case, we will directly sign a composite of the
first message and the hash of the second. Let H_meta = H(M_metadata).
The block to be signed is effectively:

    B_signed = I_loader || H_meta

The signature generated is Sig(B_signed).

The process then follows a similar pattern to the Alice and Bob model,
where the kernel (Bob) verifies I_loader and H_meta using the
signature. Then, the trusted I_loader is responsible for verifying
M_metadata against the trusted H_meta.

From an implementation standpoint:

# Build

bpftool (or some other tool in a trusted build environment) knows
about the metadata (M_metadata) and the loader program (I_loader). It
first calculates H_meta = H(M_metadata). Then it constructs the object
to be signed and computes the signature:

    Sig(I_loader || H_meta)

# Loader

The loader program and the metadata are a hermetic representation of the source
of the eBPF program, its maps and context. The loader program is generated by
libbpf as a part of a standard API i.e. bpf_object__gen_loader.

## Supply chain

While users can use light skeletons as a convenient method to use signing
support, they can directly use the loader program generation using libbpf
(bpf_object__gen_loader) into their own trusted toolchains.

libbpf, which has access to the program's instruction buffer is a key part of
the TCB of the build environment

An advanced threat model that does not intend to depend on libbpf (or any provenant
userspace BPF libraries) due to supply chain risks despite it being developed
in the kernel source and by the kernel community will require reimplmenting a
lot of the core BPF userspace support (like instruction relocation, map handling).

Such an advanced user would also need to integrate the generation of the loader
into their toolchain.

Given that many use-cases (e.g. Cilium) generate trusted BPF programs,
trusted loaders are an inevitability and a requirement for signing support, a
entrusting loader programs will be a fundamental requirement for an security
policy.

The initial instructions of the loader program verify the SHA256 hash
of the metadata (M_metadata) that will be passed in a map. These instructions
effectively embed the precomputed H_meta as immediate values.

    ld_imm64 r1, const_ptr_to_map // insn[0].src_reg == BPF_PSEUDO_MAP_IDX
    r2 = *(u64 *)(r1 + 0);
    ld_imm64 r3, sha256_of_map_part1 // precomputed by bpf_object__gen_load/libbpf (H_meta_1)
    if r2 != r3 goto out;

    r2 = *(u64 *)(r1 + 8);
    ld_imm64 r3, sha256_of_map_part2 // precomputed by bpf_object__gen_load/libbpf (H_meta_2)
    if r2 != r3 goto out;

    r2 = *(u64 *)(r1 + 16);
    ld_imm64 r3, sha256_of_map_part3 // precomputed by bpf_object__gen_load/libbpf (H_meta_3)
    if r2 != r3 goto out;

    r2 = *(u64 *)(r1 + 24);
    ld_imm64 r3, sha256_of_map_part4 // precomputed by bpf_object__gen_load/libbpf (H_meta_4)
    if r2 != r3 goto out;
    ...

This implicitly makes the payload equivalent to the signed block (B_signed)

    I_loader || H_meta

bpftool then generates the signature of this I_loader payload (which
now contains the expected H_meta) using a key and an identity:

This signature is stored in bpf_attr, which is extended as follows for
the BPF_PROG_LOAD command:

    __aligned_u64 signature;
    __u32 signature_size;
    __u32 keyring_id;

The reasons for a simpler UAPI is that it's more future proof (e.g.) with more
stable instruction buffers, loader programs being directly into the compilers.
A simple API also allows simple programs e.g. for networking that don't need
loader programs to directly use signing.

# Extending OBJ_GET_INFO_BY_FD for hashes

OBJ_GET_INFO_BY_FD is used to get information about BPF objects (maps, programs, links) and
returning the hash of the map is a natural extension of the UAPI as it can be
helpful for debugging, fingerprinting etc.

Currently, it's only implemented for BPF_MAP_TYPE_ARRAY. It can be trivially
extended for BPF programs to return the complete SHA256 along with the tag.

The SHA is stored in struct bpf_map for exclusive and frozen maps

    struct bpf_map {
    +   u64 sha[4];
        const struct bpf_map_ops *ops;
        struct bpf_map *inner_map_meta;
    };

## Exclusive BPF maps

Exclusivity ensures that the map can only be used by a future BPF
program whose SHA256 hash matches sha256_of_future_prog.

First, bpf_prog_calc_tag() is updated to compute the SHA256 instead of
SHA1, and this hash is stored in struct bpf_prog_aux:

    @@ -1588,6 +1588,7 @@ struct bpf_prog_aux {
         int cgroup_atype; /* enum cgroup_bpf_attach_type */
         struct bpf_map *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
         char name[BPF_OBJ_NAME_LEN];
    +    u64 sha[4];
         u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
         // ...
    };

An exclusive is created by passing an excl_prog_hash
(and excl_prog_hash_size) in the BPF_MAP_CREATE command.
When a BPF program is subsequently loaded and it attempts to use this map,
the kernel will compare the program's own SHA256 hash against the one
registered with the map, if matching, it will be added to prog->used_maps[].

The program load will fail if the hashes do not match or if the map is
already in use by another (non-matching) exclusive program.

Exclusive maps ensure that no other BPF programs and compromise the intergity of
the map post the signature verification.

NOTE: Exclusive maps cannot be added as inner maps.

# Light Skeleton Sequence (Userspace Example)

	err = map_fd = skel_map_create(BPF_MAP_TYPE_ARRAY, "__loader.map",
				       opts->excl_prog_hash,
				       opts->excl_prog_hash_sz, 4,
				       opts->data_sz, 1);
	err = skel_map_update_elem(map_fd, &key, opts->data, 0);

	err = skel_map_freeze(map_fd);

	// Kernel computes the hash of the map.
	err = skel_obj_get_info_by_fd(map_fd);

	memset(&attr, 0, prog_load_attr_sz);
	attr.prog_type = BPF_PROG_TYPE_SYSCALL;
	attr.insns = (long) opts->insns;
	attr.insn_cnt = opts->insns_sz / sizeof(struct bpf_insn);
	attr.signature = (long) opts->signature;
	attr.signature_size = opts->signature_sz;
	attr.keyring_id = opts->keyring_id;
	attr.license = (long) "Dual BSD/GPL";

The kernel will:

    * Compute the hash of the provided I_loader bytecode.
    * Verify the signature against this computed hash.
    * Check if the metadata map (now exclusive) is intended for this
      program's hash.

The signature check happens in BPF_PROG_LOAD before the security_bpf_prog
LSM hook.

This ensures that the loaded loader program (I_loader), including the
embedded expected hash of the metadata (H_meta), is trusted.
Since the loader program is now trusted, it can be entrusted to verify
the actual metadata (M_metadata) read from the (now exclusive and
frozen) map against the embedded (and trusted) H_meta. There is no
Time-of-Check-Time-of-Use (TOCTOU) vulnerability here because:

    * The signature covers the I_loader and its embedded H_meta.
    * The metadata map M_metadata is frozen before the loader program is loaded
      and associated with it.
    * The map is made exclusive to the specific (signed and verified)
      loader program.

[1] https://lore.kernel.org/bpf/CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com/#t


KP Singh (13):
  bpf: Update the bpf_prog_calc_tag to use SHA256
  bpf: Implement exclusive map creation
  libbpf: Implement SHA256 internal helper
  libbpf: Support exclusive map creation
  selftests/bpf: Add tests for exclusive maps
  bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD
  bpf: Move the signature kfuncs to helpers.c
  bpf: Implement signature verification for BPF programs
  libbpf: Update light skeleton for signing
  libbpf: Embed and verify the metadata hash in the loader
  bpftool: Add support for signing BPF programs
  selftests/bpf: Enable signature verification for all lskel tests
  selftests/bpf: Add test for signed programs

 crypto/asymmetric_keys/pkcs7_verify.c         |   1 +
 include/linux/bpf.h                           |  42 +++-
 include/linux/filter.h                        |   6 -
 include/linux/verification.h                  |   1 +
 include/uapi/linux/bpf.h                      |  14 ++
 kernel/bpf/Kconfig                            |   2 +-
 kernel/bpf/arraymap.c                         |  13 ++
 kernel/bpf/core.c                             |  50 +----
 kernel/bpf/helpers.c                          | 166 ++++++++++++++
 kernel/bpf/syscall.c                          |  96 +++++++-
 kernel/bpf/verifier.c                         |   6 +
 kernel/trace/bpf_trace.c                      | 183 ---------------
 .../bpf/bpftool/Documentation/bpftool-gen.rst |  12 +
 .../bpftool/Documentation/bpftool-prog.rst    |  12 +
 tools/bpf/bpftool/Makefile                    |   6 +-
 tools/bpf/bpftool/cgroup.c                    |   5 +-
 tools/bpf/bpftool/gen.c                       |  58 ++++-
 tools/bpf/bpftool/main.c                      |  21 +-
 tools/bpf/bpftool/main.h                      |  11 +
 tools/bpf/bpftool/prog.c                      |  25 +++
 tools/bpf/bpftool/sign.c                      | 210 ++++++++++++++++++
 tools/include/uapi/linux/bpf.h                |  14 ++
 tools/lib/bpf/bpf.c                           |   6 +-
 tools/lib/bpf/bpf.h                           |   4 +-
 tools/lib/bpf/bpf_gen_internal.h              |   2 +
 tools/lib/bpf/gen_loader.c                    |  55 +++++
 tools/lib/bpf/libbpf.c                        | 125 +++++++++++
 tools/lib/bpf/libbpf.h                        |  21 +-
 tools/lib/bpf/libbpf.map                      |   2 +
 tools/lib/bpf/libbpf_internal.h               |   4 +
 tools/lib/bpf/skel_internal.h                 |  75 ++++++-
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |  19 +-
 .../selftests/bpf/prog_tests/map_excl.c       |  56 +++++
 .../selftests/bpf/prog_tests/signing.c        |  36 +++
 tools/testing/selftests/bpf/progs/map_excl.c  |  34 +++
 tools/testing/selftests/bpf/progs/signing.c   |  16 ++
 .../selftests/bpf/progs/verifier_map_ptr.c    |   7 +-
 tools/testing/selftests/bpf/test_progs.c      |  13 ++
 .../testing/selftests/bpf/verify_sig_setup.sh |  13 +-
 40 files changed, 1183 insertions(+), 260 deletions(-)
 create mode 100644 tools/bpf/bpftool/sign.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_excl.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/signing.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_excl.c
 create mode 100644 tools/testing/selftests/bpf/progs/signing.c

-- 
2.43.0


