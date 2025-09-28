Return-Path: <bpf+bounces-69923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21159BA7129
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 15:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C301E1735A9
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 13:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4722A1AC44D;
	Sun, 28 Sep 2025 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXo8TfYB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBC617A2E0
	for <bpf@vger.kernel.org>; Sun, 28 Sep 2025 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759067183; cv=none; b=pfHSE/mJ/h4cgUO4nHi8vNPUUhWk4FmpX+68S2lFiZPh51y29qVn+6K5TxM6s/IJM/v49mOAWZj9uF+g8pC43nk0vaTEjrQTF1XNfdK3yx5BsvnlY0PxuzlAxPJh0P52F66Zs/kBHvgqAPbMC4s776d43CkVrFu3lzDeBTWuGgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759067183; c=relaxed/simple;
	bh=28OqGMjg6pyMtZ11BlF8zp4U9R4njf+aj89QUAMQtYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKFclF9EdRrhDjQCEAqEhGxrDM/omw6A1+3DW1croFTLwfdG1VXXC0j+f87algoDlfKGMA/WbPgpBQ75LeS8HP+Su/U5uvKRyStEGI5gdozesWaJArO0G44WKiOssM5Fe+7UtpwBLajJ8ZaP8/DgqHnCit0+H+2yBjkmuDDOeWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXo8TfYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A399C19421
	for <bpf@vger.kernel.org>; Sun, 28 Sep 2025 13:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759067183;
	bh=28OqGMjg6pyMtZ11BlF8zp4U9R4njf+aj89QUAMQtYM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PXo8TfYBXFjiPP0h9Pbt4JylfIR0feypDnepOZP+YRkOgSCXGgBFQ4JA68/0ZvkXL
	 UfQTxSc+SIMPUA0RU0cWJuXq/LlnY/goPQsa/GsoCgqgGgVEIHwNJSeUlEqju1dWJd
	 qp6BeU+QkfF7vN2JGsOkMUR3f6aR9cwj5epjcmo1pLA9bRvMzrWiI9c7ROvR2d+CyA
	 Mg76acLfH8x3trtY1RH8AgKDT3IFOqyEmGh+n4/6ORWGZ6GeXkjBYHPIlYNEwNr0Y/
	 f/Iv6T6TR7ZIA3i/ijMwnP1goeouy2Mk48yaD+VeY1a3toQwy+RPcQlzIsB1Lew98i
	 UTEM26wq7HwFg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-581b92e680bso4659042e87.0
        for <bpf@vger.kernel.org>; Sun, 28 Sep 2025 06:46:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YwAC3MZH3pqdK8yqegx8ZWtLmmLkYkAyz08erpT3U9mOSXje26P
	LFGvnHPDmwqvMo847H84jAl6O0XN+zScu/BOpNyzt3niKCFpvGVzFaUl43Ju1YaJ+5qLfsi5/6I
	frBZ3XLiwZvAkgvXSFMzCdC4tQ3ByWU0=
X-Google-Smtp-Source: AGHT+IFbA4UO8ItnlnjiOLUK4F0uq6TBTWdTW1H3Lw36bghTQxVWrqsUoTrUfu5uxHSckAiAztftrSPZTxSVGeCAGCw=
X-Received: by 2002:a05:6512:6ca:b0:57c:4428:4f14 with SMTP id
 2adb3069b0e04-58581521767mr1690585e87.24.1759067181601; Sun, 28 Sep 2025
 06:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928003833.138407-1-ebiggers@kernel.org>
In-Reply-To: <20250928003833.138407-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 28 Sep 2025 15:46:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFPhgtjK_C6+jRSb4K6j3tju5ufAoiQ-=fJTHsPreJSNA@mail.gmail.com>
X-Gm-Features: AS18NWAuqv4S-sg6DSQM3gOheZVJ6KaCiFoUnXriJbGM61QYuKpgWUS2w0dB0yk
Message-ID: <CAMj1kXFPhgtjK_C6+jRSb4K6j3tju5ufAoiQ-=fJTHsPreJSNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Don't use AF_ALG for SHA-256
To: Eric Biggers <ebiggers@kernel.org>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Sept 2025 at 02:39, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Reimplement libbpf_sha256() using some basic SHA-256 C code.  This
> eliminates the newly-added dependency on AF_ALG, which is a problematic
> UAPI that is not supported by all kernels.
>
> Make libbpf_sha256() return void, since it can no longer fail.  This
> simplifies some callers.  Also drop the unnecessary 'sha_out_sz'
> parameter.  Finally, also fix the typo in "compute_sha_udpate_offsets".
>
> Tested by uncommenting the included test code and running
> 'make -C tools/bpf/bpftool', which causes the test to be executed.
>
> Fixes: c297fe3e9f99 ("libbpf: Implement SHA256 internal helper")
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>


> ---
>
> Let me know if there's some way I should wire up the test.  But libbpf
> doesn't seem to have an internal test suite.
>
>  tools/lib/bpf/gen_loader.c      |  20 ++--
>  tools/lib/bpf/libbpf.c          | 169 ++++++++++++++++++++++----------
>  tools/lib/bpf/libbpf_internal.h |   2 +-
>  3 files changed, 124 insertions(+), 67 deletions(-)
>
> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 376eef292d3a8..6945dd99a8469 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -369,11 +369,11 @@ static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off)
>                                          0, 0, 0, blob_off));
>         emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0));
>         __emit_sys_close(gen);
>  }
>
> -static int compute_sha_udpate_offsets(struct bpf_gen *gen);
> +static void compute_sha_update_offsets(struct bpf_gen *gen);
>
>  int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
>  {
>         int i;
>
> @@ -397,15 +397,12 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
>                               sizeof(struct bpf_map_desc) * i +
>                               offsetof(struct bpf_map_desc, map_fd), 4,
>                               blob_fd_array_off(gen, i));
>         emit(gen, BPF_MOV64_IMM(BPF_REG_0, 0));
>         emit(gen, BPF_EXIT_INSN());
> -       if (OPTS_GET(gen->opts, gen_hash, false)) {
> -               gen->error = compute_sha_udpate_offsets(gen);
> -               if (gen->error)
> -                       return gen->error;
> -       }
> +       if (OPTS_GET(gen->opts, gen_hash, false))
> +               compute_sha_update_offsets(gen);
>
>         pr_debug("gen: finish %s\n", errstr(gen->error));
>         if (!gen->error) {
>                 struct gen_loader_opts *opts = gen->opts;
>
> @@ -455,29 +452,24 @@ void bpf_gen__free(struct bpf_gen *gen)
>                 }                                               \
>         }                                                       \
>         _val;                                                   \
>  })
>
> -static int compute_sha_udpate_offsets(struct bpf_gen *gen)
> +static void compute_sha_update_offsets(struct bpf_gen *gen)
>  {
>         __u64 sha[SHA256_DWORD_SIZE];
>         __u64 sha_dw;
> -       int i, err;
> +       int i;
>
> -       err = libbpf_sha256(gen->data_start, gen->data_cur - gen->data_start, sha, SHA256_DIGEST_LENGTH);
> -       if (err < 0) {
> -               pr_warn("sha256 computation of the metadata failed");
> -               return err;
> -       }
> +       libbpf_sha256(gen->data_start, gen->data_cur - gen->data_start, (__u8 *)sha);
>         for (i = 0; i < SHA256_DWORD_SIZE; i++) {
>                 struct bpf_insn *insn =
>                         (struct bpf_insn *)(gen->insn_start + gen->hash_insn_offset[i]);
>                 sha_dw = tgt_endian(sha[i]);
>                 insn[0].imm = (__u32)sha_dw;
>                 insn[1].imm = sha_dw >> 32;
>         }
> -       return 0;
>  }
>
>  void bpf_gen__load_btf(struct bpf_gen *gen, const void *btf_raw_data,
>                        __u32 btf_raw_size)
>  {
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 7edb36aa88e1d..f804c7b3fa8a2 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -33,21 +33,19 @@
>  #include <linux/filter.h>
>  #include <linux/limits.h>
>  #include <linux/perf_event.h>
>  #include <linux/bpf_perf_event.h>
>  #include <linux/ring_buffer.h>
> +#include <linux/unaligned.h>
>  #include <sys/epoll.h>
>  #include <sys/ioctl.h>
>  #include <sys/mman.h>
>  #include <sys/stat.h>
>  #include <sys/types.h>
>  #include <sys/vfs.h>
>  #include <sys/utsname.h>
>  #include <sys/resource.h>
> -#include <sys/socket.h>
> -#include <linux/if_alg.h>
> -#include <linux/socket.h>
>  #include <libelf.h>
>  #include <gelf.h>
>  #include <zlib.h>
>
>  #include "libbpf.h"
> @@ -4489,11 +4487,11 @@ bpf_object__section_to_libbpf_map_type(const struct bpf_object *obj, int shndx)
>  }
>
>  static int bpf_prog_compute_hash(struct bpf_program *prog)
>  {
>         struct bpf_insn *purged;
> -       int i, err;
> +       int i, err = 0;
>
>         purged = calloc(prog->insns_cnt, BPF_INSN_SZ);
>         if (!purged)
>                 return -ENOMEM;
>
> @@ -4517,12 +4515,12 @@ static int bpf_prog_compute_hash(struct bpf_program *prog)
>                         }
>                         purged[i] = prog->insns[i];
>                         purged[i].imm = 0;
>                 }
>         }
> -       err = libbpf_sha256(purged, prog->insns_cnt * sizeof(struct bpf_insn),
> -                           prog->hash, SHA256_DIGEST_LENGTH);
> +       libbpf_sha256(purged, prog->insns_cnt * sizeof(struct bpf_insn),
> +                     prog->hash);
>  out:
>         free(purged);
>         return err;
>  }
>
> @@ -14286,60 +14284,127 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
>         free(s->maps);
>         free(s->progs);
>         free(s);
>  }
>
> -int libbpf_sha256(const void *data, size_t data_sz, void *sha_out, size_t sha_out_sz)
> +static inline __u32 ror32(__u32 v, int bits)
>  {
> -       struct sockaddr_alg sa = {
> -               .salg_family = AF_ALG,
> -               .salg_type   = "hash",
> -               .salg_name   = "sha256"
> -       };
> -       int sock_fd = -1;
> -       int op_fd = -1;
> -       int err = 0;
> +       return (v >> bits) | (v << (32 - bits));
> +}
>
> -       if (sha_out_sz != SHA256_DIGEST_LENGTH) {
> -               pr_warn("sha_out_sz should be exactly 32 bytes for a SHA256 digest");
> -               return -EINVAL;
> -       }
> +#define SHA256_BLOCK_LENGTH 64
> +#define Ch(x, y, z) (((x) & (y)) ^ (~(x) & (z)))
> +#define Maj(x, y, z) (((x) & (y)) ^ ((x) & (z)) ^ ((y) & (z)))
> +#define Sigma_0(x) (ror32((x), 2) ^ ror32((x), 13) ^ ror32((x), 22))
> +#define Sigma_1(x) (ror32((x), 6) ^ ror32((x), 11) ^ ror32((x), 25))
> +#define sigma_0(x) (ror32((x), 7) ^ ror32((x), 18) ^ ((x) >> 3))
> +#define sigma_1(x) (ror32((x), 17) ^ ror32((x), 19) ^ ((x) >> 10))
>
> -       sock_fd = socket(AF_ALG, SOCK_SEQPACKET, 0);
> -       if (sock_fd < 0) {
> -               err = -errno;
> -               pr_warn("failed to create AF_ALG socket for SHA256: %s\n", errstr(err));
> -               return err;
> -       }
> +static const __u32 sha256_K[64] = {
> +       0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1,
> +       0x923f82a4, 0xab1c5ed5, 0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
> +       0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174, 0xe49b69c1, 0xefbe4786,
> +       0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
> +       0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147,
> +       0x06ca6351, 0x14292967, 0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
> +       0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85, 0xa2bfe8a1, 0xa81a664b,
> +       0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
> +       0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a,
> +       0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
> +       0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
> +};
>
> -       if (bind(sock_fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
> -               err = -errno;
> -               pr_warn("failed to bind to AF_ALG socket for SHA256: %s\n", errstr(err));
> -               goto out;
> -       }
> +#define SHA256_ROUND(i, a, b, c, d, e, f, g, h)                                \
> +       {                                                                      \
> +               __u32 tmp = h + Sigma_1(e) + Ch(e, f, g) + sha256_K[i] + w[i]; \
> +               d += tmp;                                                      \
> +               h = tmp + Sigma_0(a) + Maj(a, b, c);                           \
> +       }
> +
> +static void sha256_blocks(__u32 state[8], const __u8 *data, size_t nblocks)
> +{
> +       while (nblocks--) {
> +               __u32 a = state[0];
> +               __u32 b = state[1];
> +               __u32 c = state[2];
> +               __u32 d = state[3];
> +               __u32 e = state[4];
> +               __u32 f = state[5];
> +               __u32 g = state[6];
> +               __u32 h = state[7];
> +               __u32 w[64];
> +               int i;
> +
> +               for (i = 0; i < 16; i++)
> +                       w[i] = get_unaligned_be32(&data[4 * i]);
> +               for (; i < ARRAY_SIZE(w); i++)
> +                       w[i] = sigma_1(w[i - 2]) + w[i - 7] +
> +                              sigma_0(w[i - 15]) + w[i - 16];
> +               for (i = 0; i < ARRAY_SIZE(w); i += 8) {
> +                       SHA256_ROUND(i + 0, a, b, c, d, e, f, g, h);
> +                       SHA256_ROUND(i + 1, h, a, b, c, d, e, f, g);
> +                       SHA256_ROUND(i + 2, g, h, a, b, c, d, e, f);
> +                       SHA256_ROUND(i + 3, f, g, h, a, b, c, d, e);
> +                       SHA256_ROUND(i + 4, e, f, g, h, a, b, c, d);
> +                       SHA256_ROUND(i + 5, d, e, f, g, h, a, b, c);
> +                       SHA256_ROUND(i + 6, c, d, e, f, g, h, a, b);
> +                       SHA256_ROUND(i + 7, b, c, d, e, f, g, h, a);
> +               }
> +               state[0] += a;
> +               state[1] += b;
> +               state[2] += c;
> +               state[3] += d;
> +               state[4] += e;
> +               state[5] += f;
> +               state[6] += g;
> +               state[7] += h;
> +               data += SHA256_BLOCK_LENGTH;
> +       }
> +}
> +
> +void libbpf_sha256(const void *data, size_t len, __u8 out[SHA256_DIGEST_LENGTH])
> +{
> +       __u32 state[8] = { 0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
> +                          0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19 };
> +       const __be64 bitcount = cpu_to_be64((__u64)len * 8);
> +       __u8 final_data[2 * SHA256_BLOCK_LENGTH] = { 0 };
> +       size_t final_len = len % SHA256_BLOCK_LENGTH;
> +       int i;
>
> -       op_fd = accept(sock_fd, NULL, 0);
> -       if (op_fd < 0) {
> -               err = -errno;
> -               pr_warn("failed to accept from AF_ALG socket for SHA256: %s\n", errstr(err));
> -               goto out;
> -       }
> +       sha256_blocks(state, data, len / SHA256_BLOCK_LENGTH);
>
> -       if (write(op_fd, data, data_sz) != data_sz) {
> -               err = -errno;
> -               pr_warn("failed to write data to AF_ALG socket for SHA256: %s\n", errstr(err));
> -               goto out;
> -       }
> +       memcpy(final_data, data + len - final_len, final_len);
> +       final_data[final_len] = 0x80;
> +       final_len = round_up(final_len + 9, SHA256_BLOCK_LENGTH);
> +       memcpy(&final_data[final_len - 8], &bitcount, 8);
>
> -       if (read(op_fd, sha_out, SHA256_DIGEST_LENGTH) != SHA256_DIGEST_LENGTH) {
> -               err = -errno;
> -               pr_warn("failed to read SHA256 from AF_ALG socket: %s\n", errstr(err));
> -               goto out;
> -       }
> +       sha256_blocks(state, final_data, final_len / SHA256_BLOCK_LENGTH);
>
> -out:
> -       if (op_fd >= 0)
> -               close(op_fd);
> -       if (sock_fd >= 0)
> -               close(sock_fd);
> -       return err;
> +       for (i = 0; i < ARRAY_SIZE(state); i++)
> +               put_unaligned_be32(state[i], &out[4 * i]);
> +}
> +
> +#if 0 /* To test libbpf_sha256(), uncomment this.  Requires -lcrypto. */
> +#include <openssl/sha.h>
> +
> +/* Test libbpf_sha256() for all lengths from 0 to 4096 bytes inclusively. */
> +static void __attribute__((constructor)) test_libbpf_sha256(void)
> +{
> +       __u8 data[4096];
> +       __u8 hash1[SHA256_DIGEST_LENGTH];
> +       __u8 hash2[SHA256_DIGEST_LENGTH];
> +       size_t i;
> +
> +       for (i = 0; i < sizeof(data); i++)
> +               data[i] = rand();
> +
> +       for (i = 0; i <= sizeof(data); i++) {
> +               libbpf_sha256(data, i, hash1);
> +               SHA256(data, i, hash2); /* Uses OpenSSL */
> +               if (memcmp(hash1, hash2, sizeof(hash1)) != 0) {
> +                       pr_warn("libbpf_sha256() test failed\n");
> +                       abort();
> +               }
> +       }
> +       pr_info("libbpf_sha256() test passed\n");
>  }
> +#endif
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index 8a055de0d3248..c93797dcaf5bc 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -737,7 +737,7 @@ int elf_resolve_pattern_offsets(const char *binary_path, const char *pattern,
>  int probe_fd(int fd);
>
>  #define SHA256_DIGEST_LENGTH 32
>  #define SHA256_DWORD_SIZE SHA256_DIGEST_LENGTH / sizeof(__u64)
>
> -int libbpf_sha256(const void *data, size_t data_sz, void *sha_out, size_t sha_out_sz);
> +void libbpf_sha256(const void *data, size_t len, __u8 out[SHA256_DIGEST_LENGTH]);
>  #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
>
> base-commit: 0e8e60e86cf3292e747a0fa7cc13127f290323ad
> --
> 2.51.0
>

