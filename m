Return-Path: <bpf+bounces-60215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04A1AD4108
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 19:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A816179CC5
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 17:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBA5244694;
	Tue, 10 Jun 2025 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZ7zYmxq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4931C1E379B
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749577399; cv=none; b=q9wBbcfucylNUX1nUPUphKoaLOrMIfXH52GoOFZ+nDbm+zOD2LluRH4OX9Z8GS4uH8yPtcd633Bl0zdLZO5yIUuOQs8fX1wocwvbq3AMt1FWbdt2gL+UIdcJuHoECDeqiuCL/6XwB69qV1a/l/j0LRnkS+zLsy0ec1AOT4I/zfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749577399; c=relaxed/simple;
	bh=mMBqRL9VCir5NCEnC1kvsiavLwO9DkpsxfgkjxjlReA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVbN7K8TnPNcXf3VHr8ovOElVQD24E+xEo4yZ8+UnGDdtwGM3Gd7s6BTMr7N7RlvgFIFhOTtA4s22+Nvb7ht70ouF0gYz3VcPcuXVgS5iOsv5e4brPXhppP3tMwHGKWycAJv8FxQGN/HnuZ8KcWZwBvfSG1+2p3E9ofhTBddtLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZ7zYmxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9294C4AF09
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 17:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749577398;
	bh=mMBqRL9VCir5NCEnC1kvsiavLwO9DkpsxfgkjxjlReA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bZ7zYmxqlkreAocEItdFQjm5/o11VZ+aI2i3lgFBAYztex95rn/5PU1CT8KUj6ZS0
	 kJu+09jzuuyZCXImHT0t4d4dSX9+T5pvSOB+D/IOal0Fcs492NDz59WqYAnJi+ClF9
	 wP68clreuTOe1gOCEAL+jbrAtyxUDfd3nCmGLVu4WWLcd/ZFsDyoAa6WJhaHmAoPt6
	 I8Wjsma1ljyK3npz1UPm0oyUXfxcQuubXJo6O0JaWjoXbAW04g0AL+xzVPLMeo752a
	 cOqlLary4t1f+TWx5a7kdZXNz6xAX5W3amqVeL8vISl25TnWyc1rzwLs6g6IqJeFhp
	 L/bvQvtXwyyGA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad93ff9f714so1032005066b.2
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 10:43:18 -0700 (PDT)
X-Gm-Message-State: AOJu0YwFRY9dJSYjVwqbSlAcKEcBblDHlUOFwDc2GxVbguOavxX8NPMJ
	igzzR/BQWXdTR7NrQ2KPz+xvNPyAyL5RMqr9z3fQKChyr721JZ7l/lYeTYP0bfQ3/68PTQD9Eol
	UQFJvwn/ZPKeHxR57K756uEm9b6MbHDlrhfJUHHJy
X-Google-Smtp-Source: AGHT+IHAogHNEFJOGrw6RQ2L7n3pJ2WyDzjsvdZeSRdzPn0L/CBmNtnALj2/gps/6hfO05AgGsXYsUfcsJUPNu5khD8=
X-Received: by 2002:a17:907:d716:b0:ad5:8412:1c9 with SMTP id
 a640c23a62f3a-ade89875898mr29370466b.59.1749577397344; Tue, 10 Jun 2025
 10:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-11-kpsingh@kernel.org>
 <87qzzrleuw.fsf@microsoft.com>
In-Reply-To: <87qzzrleuw.fsf@microsoft.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 10 Jun 2025 19:43:04 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6M7kA7Se4=AXWNVF1UyeHK3t+3Y_8Ap1L9pkUTbqys9Q@mail.gmail.com>
X-Gm-Features: AX0GCFsFJnB73MR5TmdHFH-OTfLIdDJ4Vm2YbnsrEBVQFPjpNypmsuUMKBFL9V0
Message-ID: <CACYkzJ6M7kA7Se4=AXWNVF1UyeHK3t+3Y_8Ap1L9pkUTbqys9Q@mail.gmail.com>
Subject: Re: [PATCH 10/12] libbpf: Embed and verify the metadata hash in the loader
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, kys@microsoft.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 6:51=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> KP Singh <kpsingh@kernel.org> writes:
>
> > To fulfill the BPF signing contract, represented as Sig(I_loader ||
> > H_meta), the generated trusted loader program must verify the integrity
> > of the metadata. This signature cryptographically binds the loader's
> > instructions (I_loader) to a hash of the metadata (H_meta).
> >
> > The verification process is embedded directly into the loader program.
> > Upon execution, the loader loads the runtime hash from struct bpf_map
> > i.e. BPF_PSEUDO_MAP_IDX and compares this runtime hash against an
> > expected hash value that has been hardcoded directly by
> > bpf_obj__gen_loader.
> >
> > The load from bpf_map can be improved by calling
> > BPF_OBJ_GET_INFO_BY_FD from the kernel context after BPF_OBJ_GET_INFO_B=
Y_FD
> > has been updated for being called from the kernel context.
> >
> > The following instructions are generated:
> >
> >     ld_imm64 r1, const_ptr_to_map // insn[0].src_reg =3D=3D BPF_PSEUDO_=
MAP_IDX
> >     r2 =3D *(u64 *)(r1 + 0);
> >     ld_imm64 r3, sha256_of_map_part1 // constant precomputed by
> > bpftool (part of H_meta)
> >     if r2 !=3D r3 goto out;
> >
> >     r2 =3D *(u64 *)(r1 + 8);
> >     ld_imm64 r3, sha256_of_map_part2 // (part of H_meta)
> >     if r2 !=3D r3 goto out;
> >
> >     r2 =3D *(u64 *)(r1 + 16);
> >     ld_imm64 r3, sha256_of_map_part3 // (part of H_meta)
> >     if r2 !=3D r3 goto out;
> >
> >     r2 =3D *(u64 *)(r1 + 24);
> >     ld_imm64 r3, sha256_of_map_part4 // (part of H_meta)
> >     if r2 !=3D r3 goto out;
> >     ...
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  tools/lib/bpf/bpf_gen_internal.h |  2 ++
> >  tools/lib/bpf/gen_loader.c       | 52 ++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf.h           |  3 +-
> >  3 files changed, 56 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_i=
nternal.h
> > index 6ff963a491d9..49af4260b8e6 100644
> > --- a/tools/lib/bpf/bpf_gen_internal.h
> > +++ b/tools/lib/bpf/bpf_gen_internal.h
> > @@ -4,6 +4,7 @@
> >  #define __BPF_GEN_INTERNAL_H
> >
> >  #include "bpf.h"
> > +#include "libbpf_internal.h"
> >
> >  struct ksym_relo_desc {
> >       const char *name;
> > @@ -50,6 +51,7 @@ struct bpf_gen {
> >       __u32 nr_ksyms;
> >       int fd_array;
> >       int nr_fd_array;
> > +     int hash_insn_offset[SHA256_DWORD_SIZE];
> >  };
> >
> >  void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, i=
nt nr_maps);
> > diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> > index 113ae4abd345..3d672c09e948 100644
> > --- a/tools/lib/bpf/gen_loader.c
> > +++ b/tools/lib/bpf/gen_loader.c
> > @@ -110,6 +110,7 @@ static void emit2(struct bpf_gen *gen, struct bpf_i=
nsn insn1, struct bpf_insn in
> >
> >  static int add_data(struct bpf_gen *gen, const void *data, __u32 size)=
;
> >  static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off);
> > +static void bpf_gen__signature_match(struct bpf_gen *gen);
> >
> >  void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, i=
nt nr_maps)
> >  {
> > @@ -152,6 +153,8 @@ void bpf_gen__init(struct bpf_gen *gen, int log_lev=
el, int nr_progs, int nr_maps
> >       /* R7 contains the error code from sys_bpf. Copy it into R0 and e=
xit. */
> >       emit(gen, BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
> >       emit(gen, BPF_EXIT_INSN());
> > +     if (gen->opts->gen_hash)
> > +             bpf_gen__signature_match(gen);
> >  }
> >
> >  static int add_data(struct bpf_gen *gen, const void *data, __u32 size)
> > @@ -368,6 +371,25 @@ static void emit_sys_close_blob(struct bpf_gen *ge=
n, int blob_off)
> >       __emit_sys_close(gen);
> >  }
> >
> > +static int compute_sha_udpate_offsets(struct bpf_gen *gen)
> > +{
> > +     __u64 sha[SHA256_DWORD_SIZE];
> > +     int i, err;
> > +
> > +     err =3D libbpf_sha256(gen->data_start, gen->data_cur - gen->data_=
start, sha);
> > +     if (err < 0) {
> > +             pr_warn("sha256 computation of the metadata failed");
> > +             return err;
> > +     }
> > +     for (i =3D 0; i < SHA256_DWORD_SIZE; i++) {
> > +             struct bpf_insn *insn =3D
> > +                     (struct bpf_insn *)(gen->insn_start + gen->hash_i=
nsn_offset[i]);
> > +             insn[0].imm =3D (__u32)sha[i];
> > +             insn[1].imm =3D sha[i] >> 32;
> > +     }
> > +     return 0;
> > +}
> > +
> >  int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
> >  {
> >       int i;
> > @@ -394,6 +416,12 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_pr=
ogs, int nr_maps)
> >                             blob_fd_array_off(gen, i));
> >       emit(gen, BPF_MOV64_IMM(BPF_REG_0, 0));
> >       emit(gen, BPF_EXIT_INSN());
> > +     if (gen->opts->gen_hash) {
> > +             gen->error =3D compute_sha_udpate_offsets(gen);
> > +             if (gen->error)
> > +                     return gen->error;
> > +     }
> > +
> >       pr_debug("gen: finish %s\n", errstr(gen->error));
> >       if (!gen->error) {
> >               struct gen_loader_opts *opts =3D gen->opts;
> > @@ -557,6 +585,30 @@ void bpf_gen__map_create(struct bpf_gen *gen,
> >               emit_sys_close_stack(gen, stack_off(inner_map_fd));
> >  }
> >
> > +static void bpf_gen__signature_match(struct bpf_gen *gen)
> > +{
> > +     __s64 off =3D -(gen->insn_cur - gen->insn_start - gen->cleanup_la=
bel) / 8 - 1;
> > +     int i;
> > +
> > +     for (i =3D 0; i < SHA256_DWORD_SIZE; i++) {
> > +             emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MA=
P_IDX,
> > +                                              0, 0, 0, 0));
> > +             emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, i * s=
izeof(__u64)));
> > +             gen->hash_insn_offset[i] =3D gen->insn_cur - gen->insn_st=
art;
> > +             emit2(gen,
> > +                   BPF_LD_IMM64_RAW_FULL(BPF_REG_3, 0, 0, 0, 0, 0));
> > +
> > +             if (is_simm16(off)) {
> > +                     emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
> > +                     emit(gen,
> > +                          BPF_JMP_REG(BPF_JNE, BPF_REG_2, BPF_REG_3, o=
ff));
> > +             } else {
> > +                     gen->error =3D -ERANGE;
> > +                     emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, -1));
> > +             }
> > +     }
> > +}
> > +
>
> The above code gets generated per-program and exists out-of-tree in a
> very unreadable format in it's final form. I have general objections to
> being forced to "trust" out-of-tree code, when it's demostrably trivial

This is not out of tree. It's very much within the kernel tree.

> to perform this check in-kernel, without impeding any of the other
> stated use cases. There is no possible audit log nor LSM hook for these
> operations. There is no way to know that this check was ever performed.
>
> Further, this check ends up happeing in an entirely different syscall,
> the LSM layer and the end user may both see invalid programs successfully
> being loaded into the kernel, that may fail mysteriously later.
>
> Also, this patch seems to rely on hacking into struct internals and
> magic binary layouts.

These magical binary layouts are BPF programs, as I mentioned, if you
don't like this you (i.e an advanced user like Microsoft) can
implement your own trusted loader in whatever format you like. We are
not forcing you.

If you really want to do it in the kernel, you can do it out of tree
and maintain these patches (that's what "out of tree" actually means),
this is not a direction the BPF maintainers are interested in as it
does not meet the broader community's use-cases. We don=E2=80=99t want an
unnecessary extension to the UAPI when some BPF programs do have
stable instructions already (e.g. network) and some that can
potentially have someday.

RE The struct internals will be replaced by calling BPF_OBJ_GET_INFO
directly from the loader program as I mentioned in the commit.=E2=80=9D


- KP


>
> -blaise
>
> >  void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *at=
tach_name,
> >                                  enum bpf_attach_type type)
> >  {
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index b6ee9870523a..084372fa54f4 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -1803,9 +1803,10 @@ struct gen_loader_opts {
> >       const char *insns;
> >       __u32 data_sz;
> >       __u32 insns_sz;
> > +     bool gen_hash;
> >  };
> >
> > -#define gen_loader_opts__last_field insns_sz
> > +#define gen_loader_opts__last_field gen_hash
> >  LIBBPF_API int bpf_object__gen_loader(struct bpf_object *obj,
> >                                     struct gen_loader_opts *opts);
> >
> > --
> > 2.43.0

