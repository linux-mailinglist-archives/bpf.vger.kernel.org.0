Return-Path: <bpf+bounces-65833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D22DDB29124
	for <lists+bpf@lfdr.de>; Sun, 17 Aug 2025 04:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3A93A8F2B
	for <lists+bpf@lfdr.de>; Sun, 17 Aug 2025 02:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBA31D514E;
	Sun, 17 Aug 2025 02:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnP85nrC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24AD1C5D57
	for <bpf@vger.kernel.org>; Sun, 17 Aug 2025 02:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755397026; cv=none; b=XntUJnhU4GfibyUsWlSl/WtKtQr5jViI+e4RJg1QuShum018fyaClxZKk2WcFRLEttuhQ3SK4wp8ZRPVbKTWrIT1YSXK3MpShSbM4ekA4r/Yx0tnUithW/Ient67y/sYfspaFmpZLrBqFcCasA1q0Di3DB3HrjchIgPCPd6uF6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755397026; c=relaxed/simple;
	bh=52i7F1bnXfJEkUUqJMbfzRsd65VfVFz9joHGMgHl00Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJNeYiOfmc4QIaOOb1lg+BqOrwfcJk77ReE2RjkkSLtQcj8yO8Rfee7fxxvIOJxGf/PTOPIWoSCDM+i3szUKy0vN/2Jyy7r0uV68m0bolYxLdqFPtcqTGfQda248tjXKiPfZVfnNErLh3+q34R621CAojwqoqOp2t29abz6cKkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnP85nrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A47C4CEF0
	for <bpf@vger.kernel.org>; Sun, 17 Aug 2025 02:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755397026;
	bh=52i7F1bnXfJEkUUqJMbfzRsd65VfVFz9joHGMgHl00Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FnP85nrC6LeBVzjkzzmVATYqz+RjHGBiOpGrhE2GxlTugX3kf/C2X/LMtAMC2MtTJ
	 HxvCz5usadAImDvT+Iatgu+H2q39RlOcXf4tOxY03d6pVH8ENc3rrcymZqcGGKd1Cu
	 9LkjQ+if5am47bq3pHAfzVwUCHvnS5/NTVqWTIKkQt4NJRy2sxb/wn/+sqNGDyrsOA
	 Iup+oVIKGraBYHNkwQ/LUoKLH5Q18dG2GO3mTO/kJ1g+68ED5hlzsgF5aRMAM6i7xv
	 I7fMVajs8+gPXQgKKRlC6XPkolDHxXHs4hLn5rktZhWaeGcjfry5wJasx0HJAnwjeu
	 TOsmm4zMCWUig==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b5b1f1cso3654448a12.0
        for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 19:17:06 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz7TWgj+aTafElw/i33BIq1We3BowMDksuOU0e3bdcQG8S0UVA9
	hnc6pChBtf25m2Md15LZt28TROdUwxI2D+0z16d4Cyf9FfSyHXNbHsyLIpm7vNYRdHwVsITO3+m
	J5AfmurltNg0AxGWW9hJJ/nGjYreYitZizc7vUe3G
X-Google-Smtp-Source: AGHT+IFEgR1HNzc8tg5v/olB9davaU2TpLww9OR3VsJ+UYfROnA5nMsOnkwBMoRsb+bgnsg+Y0/8Yz81lE0O09/qL+0=
X-Received: by 2002:a17:907:3e9f:b0:af2:9a9d:2857 with SMTP id
 a640c23a62f3a-afcdc03ba66mr702387366b.3.1755397024614; Sat, 16 Aug 2025
 19:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813205526.2992911-1-kpsingh@kernel.org> <20250813205526.2992911-12-kpsingh@kernel.org>
 <87bjohonio.fsf@microsoft.com>
In-Reply-To: <87bjohonio.fsf@microsoft.com>
From: KP Singh <kpsingh@kernel.org>
Date: Sun, 17 Aug 2025 04:16:53 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7kTbGEKtPt+HRM53bfgMFeF0P6kZnH6hjxGUy5L-kw6Q@mail.gmail.com>
X-Gm-Features: Ac12FXyA0x_Bo2BglAqEkwQ8t5WM8uLKsS2dI5vSfLVuEzGAaamZOdwjBtjL6oo
Message-ID: <CACYkzJ7kTbGEKtPt+HRM53bfgMFeF0P6kZnH6hjxGUy5L-kw6Q@mail.gmail.com>
Subject: Re: [PATCH v3 11/12] bpftool: Add support for signing BPF programs
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, kys@microsoft.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 6:51=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> KP Singh <kpsingh@kernel.org> writes:
>
> > Two modes of operation being added:
> >
> > Add two modes of operation:
> >
> > * For prog load, allow signing a program immediately before loading. Th=
is
> >   is essential for command-line testing and administration.
> >
> >       bpftool prog load -S -k <private_key> -i <identity_cert> fentry_t=
est.bpf.o
> >
> > * For gen skeleton, embed a pre-generated signature into the C skeleton
> >   file. This supports the use of signed programs in compiled applicatio=
ns.
> >
> >       bpftool gen skeleton -S -k <private_key> -i <identity_cert> fentr=
y_test.bpf.o
> >
> > Generation of the loader program and its metadata map is implemented in
> > libbpf (bpf_obj__gen_loader). bpftool generates a skeleton that loads
> > the program and automates the required steps: freezing the map, creatin=
g
> > an exclusive map, loading, and running. Users can use standard libbpf
> > APIs directly or integrate loader program generation into their own
> > toolchains.
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  .../bpf/bpftool/Documentation/bpftool-gen.rst |  16 +-
> >  .../bpftool/Documentation/bpftool-prog.rst    |  18 +-
> >  tools/bpf/bpftool/Makefile                    |   6 +-
> >  tools/bpf/bpftool/cgroup.c                    |   4 +
> >  tools/bpf/bpftool/gen.c                       |  60 ++++-
> >  tools/bpf/bpftool/main.c                      |  26 ++-
> >  tools/bpf/bpftool/main.h                      |  11 +
> >  tools/bpf/bpftool/prog.c                      |  27 ++-
> >  tools/bpf/bpftool/sign.c                      | 212 ++++++++++++++++++
> >  9 files changed, 367 insertions(+), 13 deletions(-)
> >  create mode 100644 tools/bpf/bpftool/sign.c
> >
> > diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bp=
f/bpftool/Documentation/bpftool-gen.rst
> > index ca860fd97d8d..cef469d758ed 100644
> > --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> > +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> > @@ -16,7 +16,8 @@ SYNOPSIS
> >
> >  **bpftool** [*OPTIONS*] **gen** *COMMAND*
> >
> > -*OPTIONS* :=3D { |COMMON_OPTIONS| | { **-L** | **--use-loader** } }
> > +*OPTIONS* :=3D { |COMMON_OPTIONS| [ { **-L** | **--use-loader** } ]
> > +[ { { **-S** | **--sign** } **-k** <private_key.pem> **-i** <certifica=
te.x509> } ] }}
> >
> >  *COMMAND* :=3D { **object** | **skeleton** | **help** }
> >
> > @@ -186,6 +187,19 @@ OPTIONS
> >      skeleton). A light skeleton contains a loader eBPF program. It doe=
s not use
> >      the majority of the libbpf infrastructure, and does not need libel=
f.
> >
> > +-S, --sign
> > +    For skeletons, generate a signed skeleton. This option must be use=
d with
> > +    **-k** and **-i**. Using this flag implicitly enables **--use-load=
er**.
> > +    See the "Signed Skeletons" section in the description of the
> > +    **gen skeleton** command for more details.
> > +
> > +-k <private_key.pem>
> > +    Path to the private key file in PEM format, required for signing.
> > +
> > +-i <certificate.x509>
> > +    Path to the X.509 certificate file in PEM or DER format, required =
for
> > +    signing.
> > +
> >  EXAMPLES
> >  =3D=3D=3D=3D=3D=3D=3D=3D
> >  **$ cat example1.bpf.c**
> > diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/b=
pf/bpftool/Documentation/bpftool-prog.rst
> > index f69fd92df8d8..55b812761df2 100644
> > --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> > +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> > @@ -16,9 +16,9 @@ SYNOPSIS
> >
> >  **bpftool** [*OPTIONS*] **prog** *COMMAND*
> >
> > -*OPTIONS* :=3D { |COMMON_OPTIONS| |
> > -{ **-f** | **--bpffs** } | { **-m** | **--mapcompat** } | { **-n** | *=
*--nomount** } |
> > -{ **-L** | **--use-loader** } }
> > +*OPTIONS* :=3D { |COMMON_OPTIONS| [ { **-f** | **--bpffs** } ] [ { **-=
m** | **--mapcompat** } ]
> > +[ { **-n** | **--nomount** } ] [ { **-L** | **--use-loader** } ]
> > +[ { { **-S** | **--sign** } **-k** <private_key.pem> **-i** <certifica=
te.x509> } ] }
> >
> >  *COMMANDS* :=3D
> >  { **show** | **list** | **dump xlated** | **dump jited** | **pin** | *=
*load** |
> > @@ -248,6 +248,18 @@ OPTIONS
> >      creating the maps, and loading the programs (see **bpftool prog tr=
acelog**
> >      as a way to dump those messages).
> >
> > +-S, --sign
> > +    Enable signing of the BPF program before loading. This option must=
 be
> > +    used with **-k** and **-i**. Using this flag implicitly enables
> > +    **--use-loader**.
> > +
> > +-k <private_key.pem>
> > +    Path to the private key file in PEM format, required when signing.
> > +
> > +-i <certificate.x509>
> > +    Path to the X.509 certificate file in PEM or DER format, required =
when
> > +    signing.
> > +
> >  EXAMPLES
> >  =3D=3D=3D=3D=3D=3D=3D=3D
> >  **# bpftool prog show**
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index 9e9a5f006cd2..586d1b2595d1 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -130,8 +130,8 @@ include $(FEATURES_DUMP)
> >  endif
> >  endif
> >
> > -LIBS =3D $(LIBBPF) -lelf -lz
> > -LIBS_BOOTSTRAP =3D $(LIBBPF_BOOTSTRAP) -lelf -lz
> > +LIBS =3D $(LIBBPF) -lelf -lz -lcrypto
> > +LIBS_BOOTSTRAP =3D $(LIBBPF_BOOTSTRAP) -lelf -lz -lcrypto
> >
> >  ifeq ($(feature-libelf-zstd),1)
> >  LIBS +=3D -lzstd
> > @@ -194,7 +194,7 @@ endif
> >
> >  BPFTOOL_BOOTSTRAP :=3D $(BOOTSTRAP_OUTPUT)bpftool
> >
> > -BOOTSTRAP_OBJS =3D $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o jso=
n_writer.o gen.o btf.o)
> > +BOOTSTRAP_OBJS =3D $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o jso=
n_writer.o gen.o btf.o sign.o)
> >  $(BOOTSTRAP_OBJS): $(LIBBPF_BOOTSTRAP)
> >
> >  OBJS =3D $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
> > diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> > index 944ebe21a216..ec356deb27c9 100644
> > --- a/tools/bpf/bpftool/cgroup.c
> > +++ b/tools/bpf/bpftool/cgroup.c
> > @@ -2,6 +2,10 @@
> >  // Copyright (C) 2017 Facebook
> >  // Author: Roman Gushchin <guro@fb.com>
> >
> > +#undef GCC_VERSION
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
> >  #define _XOPEN_SOURCE 500
> >  #include <errno.h>
> >  #include <fcntl.h>
> > diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > index 67a60114368f..427468c9e9c2 100644
> > --- a/tools/bpf/bpftool/gen.c
> > +++ b/tools/bpf/bpftool/gen.c
> > @@ -688,10 +688,17 @@ static void codegen_destroy(struct bpf_object *ob=
j, const char *obj_name)
> >  static int gen_trace(struct bpf_object *obj, const char *obj_name, con=
st char *header_guard)
> >  {
> >       DECLARE_LIBBPF_OPTS(gen_loader_opts, opts);
> > +     struct bpf_load_and_run_opts sopts =3D {};
> > +     char sig_buf[MAX_SIG_SIZE];
> > +     __u8 prog_sha[SHA256_DIGEST_LENGTH];
> >       struct bpf_map *map;
> > +
> >       char ident[256];
> >       int err =3D 0;
> >
> > +     if (sign_progs)
> > +             opts.gen_hash =3D true;
> > +
> >       err =3D bpf_object__gen_loader(obj, &opts);
> >       if (err)
> >               return err;
> > @@ -701,6 +708,7 @@ static int gen_trace(struct bpf_object *obj, const =
char *obj_name, const char *h
> >               p_err("failed to load object file");
> >               goto out;
> >       }
> > +
> >       /* If there was no error during load then gen_loader_opts
> >        * are populated with the loader program.
> >        */
> > @@ -780,8 +788,51 @@ static int gen_trace(struct bpf_object *obj, const=
 char *obj_name, const char *h
> >       print_hex(opts.insns, opts.insns_sz);
> >       codegen("\
> >               \n\
> > -             \";                                                      =
   \n\
> > -                                                                      =
   \n\
> > +             \";\n");
> > +
> > +     if (sign_progs) {
> > +             sopts.insns =3D opts.insns;
> > +             sopts.insns_sz =3D opts.insns_sz;
> > +             sopts.excl_prog_hash =3D prog_sha;
> > +             sopts.excl_prog_hash_sz =3D sizeof(prog_sha);
> > +             sopts.signature =3D sig_buf;
> > +             sopts.signature_sz =3D MAX_SIG_SIZE;
> > +             sopts.keyring_id =3D KEY_SPEC_SESSION_KEYRING;
> > +
>
> This still has the session keyring hardcoded.

We can do this for now:

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 427468c9e9c2..694e61f1909e 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -797,7 +797,6 @@ static int gen_trace(struct bpf_object *obj, const
char *obj_name, const char *h
                sopts.excl_prog_hash_sz =3D sizeof(prog_sha);
                sopts.signature =3D sig_buf;
                sopts.signature_sz =3D MAX_SIG_SIZE;
-               sopts.keyring_id =3D KEY_SPEC_SESSION_KEYRING;

                err =3D bpftool_prog_sign(&sopts);
                if (err < 0)
@@ -827,7 +826,7 @@ static int gen_trace(struct bpf_object *obj, const
char *obj_name, const char *h
                        opts.signature_sz =3D sizeof(opts_sig) - 1;
         \n\
                        opts.excl_prog_hash =3D (void *)opts_excl_hash;
         \n\
                        opts.excl_prog_hash_sz =3D
sizeof(opts_excl_hash) - 1;    \n\
-                       opts.keyring_id =3D KEY_SPEC_SESSION_KEYRING;
         \n\
+                       opts.keyring_id =3D skel->keyring_id;
         \n\
                ");
        }

@@ -1406,6 +1405,13 @@ static int do_skeleton(int argc, char **argv)
                printf("\t} links;\n");
        }

+       if (sign_progs) {
+               codegen("\
+               \n\
+                       __s32 keyring_id;                                  =
\n\
+               ");
+       }
+
        if (btf) {
                err =3D codegen_datasecs(obj, obj_name);
                if (err)
diff --git a/tools/testing/selftests/bpf/prog_tests/atomics.c
b/tools/testing/selftests/bpf/prog_tests/atomics.c
index 13e101f370a1..92b5f378bfb8 100644
--- a/tools/testing/selftests/bpf/prog_tests/atomics.c
+++ b/tools/testing/selftests/bpf/prog_tests/atomics.c
@@ -165,11 +165,17 @@ static void test_xchg(struct atomics_lskel *skel)
 void test_atomics(void)
 {
        struct atomics_lskel *skel;
+       int err;

-       skel =3D atomics_lskel__open_and_load();
-       if (!ASSERT_OK_PTR(skel, "atomics skeleton load"))
+       skel =3D atomics_lskel__open();
+       if (!ASSERT_OK_PTR(skel, "atomics skeleton open"))
                return;

+       skel->keyring_id =3D KEY_SPEC_SESSION_KEYRING;
+       err =3D atomics_lskel__load(skel);
+       if (!ASSERT_OK(err, "atomics skeleton load"))
+               goto cleanup;
+
        if (skel->data->skip_tests) {
                printf("%s:SKIP:no ENABLE_ATOMICS_TESTS (missing Clang
BPF atomics support)",
                       __func__);
- KP

>
> > +             err =3D bpftool_prog_sign(&sopts);
> > +             if (err < 0)
> > +                     return err;
> > +
> > +             codegen("\
> > +             \n\
> > +                     static const char opts_sig[] __attribute__((__ali=
gned__(8))) =3D \"\\\n\
> > +             ");
> > +             print_hex((const void *)sig_buf, sopts.signature_sz);
> > +             codegen("\
> > +             \n\
> > +             \";\n");
> > +
> > +             codegen("\
> > +             \n\
> > +                     static const char opts_excl_hash[] __attribute__(=
(__aligned__(8))) =3D \"\\\n\
> > +             ");
> > +             print_hex((const void *)prog_sha, sizeof(prog_sha));
> > +             codegen("\
> > +             \n\
> > +             \";\n");
> > +
> > +             codegen("\
> > +             \n\
> > +                     opts.signature =3D (void *)opts_sig;             =
         \n\
> > +                     opts.signature_sz =3D sizeof(opts_sig) - 1;      =
         \n\
> > +                     opts.excl_prog_hash =3D (void *)opts_excl_hash;  =
         \n\
> > +                     opts.excl_prog_hash_sz =3D sizeof(opts_excl_hash)=
 - 1;    \n\
> > +                     opts.keyring_id =3D KEY_SPEC_SESSION_KEYRING;    =
         \n\
> > +             ");
>
> And here.
>
> > +     }
> > +
> > +     codegen("\
> > +             \n\
> >                       opts.ctx =3D (struct bpf_loader_ctx *)skel;      =
     \n\
> >                       opts.data_sz =3D sizeof(opts_data) - 1;          =
     \n\
> >                       opts.data =3D (void *)opts_data;                 =
     \n\
> > @@ -1240,7 +1291,7 @@ static int do_skeleton(int argc, char **argv)
> >               err =3D -errno;
> >               libbpf_strerror(err, err_buf, sizeof(err_buf));
> >               p_err("failed to open BPF object file: %s", err_buf);
> > -             goto out;
> > +             goto out_obj;
> >       }
> >
> >       bpf_object__for_each_map(map, obj) {
> > @@ -1552,6 +1603,7 @@ static int do_skeleton(int argc, char **argv)
> >       err =3D 0;
> >  out:
> >       bpf_object__close(obj);
> > +out_obj:
> >       if (obj_data)
> >               munmap(obj_data, mmap_sz);
> >       close(fd);
> > @@ -1930,7 +1982,7 @@ static int do_help(int argc, char **argv)
> >               "       %1$s %2$s help\n"
> >               "\n"
> >               "       " HELP_SPEC_OPTIONS " |\n"
> > -             "                    {-L|--use-loader} }\n"
> > +             "                    {-L|--use-loader} | [ {-S|--sign } {=
-k} <private_key.pem> {-i} <certificate.x509> ]}\n"
> >               "",
> >               bin_name, "gen");
> >
> > diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> > index 0f1183b2ed0a..c78eb80b9c94 100644
> > --- a/tools/bpf/bpftool/main.c
> > +++ b/tools/bpf/bpftool/main.c
> > @@ -33,6 +33,9 @@ bool relaxed_maps;
> >  bool use_loader;
> >  struct btf *base_btf;
> >  struct hashmap *refs_table;
> > +bool sign_progs;
> > +const char *private_key_path;
> > +const char *cert_path;
> >
> >  static void __noreturn clean_and_exit(int i)
> >  {
> > @@ -448,6 +451,7 @@ int main(int argc, char **argv)
> >               { "nomount",    no_argument,    NULL,   'n' },
> >               { "debug",      no_argument,    NULL,   'd' },
> >               { "use-loader", no_argument,    NULL,   'L' },
> > +             { "sign",       no_argument,    NULL,   'S' },
> >               { "base-btf",   required_argument, NULL, 'B' },
> >               { 0 }
> >       };
> > @@ -474,7 +478,7 @@ int main(int argc, char **argv)
> >       bin_name =3D "bpftool";
> >
> >       opterr =3D 0;
> > -     while ((opt =3D getopt_long(argc, argv, "VhpjfLmndB:l",
> > +     while ((opt =3D getopt_long(argc, argv, "VhpjfLmndSi:k:B:l",
> >                                 options, NULL)) >=3D 0) {
> >               switch (opt) {
> >               case 'V':
> > @@ -520,6 +524,16 @@ int main(int argc, char **argv)
> >               case 'L':
> >                       use_loader =3D true;
> >                       break;
> > +             case 'S':
> > +                     sign_progs =3D true;
> > +                     use_loader =3D true;
> > +                     break;
> > +             case 'k':
> > +                     private_key_path =3D optarg;
> > +                     break;
> > +             case 'i':
> > +                     cert_path =3D optarg;
> > +                     break;
> >               default:
> >                       p_err("unrecognized option '%s'", argv[optind - 1=
]);
> >                       if (json_output)
> > @@ -534,6 +548,16 @@ int main(int argc, char **argv)
> >       if (argc < 0)
> >               usage();
> >
> > +     if (sign_progs && (private_key_path =3D=3D NULL || cert_path =3D=
=3D NULL)) {
> > +             p_err("-i <identity_x509_cert> and -k <private> key must =
be supplied with -S for signing");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (!sign_progs && (private_key_path !=3D NULL || cert_path !=3D =
NULL)) {
> > +             p_err("-i <identity_x509_cert> and -k <private> also need=
 --sign to be used for sign programs");
> > +             return -EINVAL;
> > +     }
> > +
> >       if (version_requested)
> >               ret =3D do_version(argc, argv);
> >       else
> > diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> > index a2bb0714b3d6..f7f5b39b66c8 100644
> > --- a/tools/bpf/bpftool/main.h
> > +++ b/tools/bpf/bpftool/main.h
> > @@ -6,9 +6,14 @@
> >
> >  /* BFD and kernel.h both define GCC_VERSION, differently */
> >  #undef GCC_VERSION
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
> >  #include <stdbool.h>
> >  #include <stdio.h>
> > +#include <errno.h>
> >  #include <stdlib.h>
> > +#include <bpf/skel_internal.h>
> >  #include <linux/bpf.h>
> >  #include <linux/compiler.h>
> >  #include <linux/kernel.h>
> > @@ -52,6 +57,7 @@ static inline void *u64_to_ptr(__u64 ptr)
> >       })
> >
> >  #define ERR_MAX_LEN  1024
> > +#define MAX_SIG_SIZE 4096
> >
> >  #define BPF_TAG_FMT  "%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx=
"
> >
> > @@ -85,6 +91,9 @@ extern bool relaxed_maps;
> >  extern bool use_loader;
> >  extern struct btf *base_btf;
> >  extern struct hashmap *refs_table;
> > +extern bool sign_progs;
> > +extern const char *private_key_path;
> > +extern const char *cert_path;
> >
> >  void __printf(1, 2) p_err(const char *fmt, ...);
> >  void __printf(1, 2) p_info(const char *fmt, ...);
> > @@ -275,4 +284,6 @@ int pathname_concat(char *buf, int buf_sz, const ch=
ar *path,
> >  /* print netfilter bpf_link info */
> >  void netfilter_dump_plain(const struct bpf_link_info *info);
> >  void netfilter_dump_json(const struct bpf_link_info *info, json_writer=
_t *wtr);
> > +int bpftool_prog_sign(struct bpf_load_and_run_opts *opts);
> > +__u32 register_session_key(const char *key_der_path);
> >  #endif
> > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > index 9722d841abc0..82b8da084504 100644
> > --- a/tools/bpf/bpftool/prog.c
> > +++ b/tools/bpf/bpftool/prog.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/err.h>
> >  #include <linux/perf_event.h>
> >  #include <linux/sizes.h>
> > +#include <linux/keyctl.h>
> >
> >  #include <bpf/bpf.h>
> >  #include <bpf/btf.h>
> > @@ -1930,6 +1931,8 @@ static int try_loader(struct gen_loader_opts *gen=
)
> >  {
> >       struct bpf_load_and_run_opts opts =3D {};
> >       struct bpf_loader_ctx *ctx;
> > +     char sig_buf[MAX_SIG_SIZE];
> > +     __u8 prog_sha[SHA256_DIGEST_LENGTH];
> >       int ctx_sz =3D sizeof(*ctx) + 64 * max(sizeof(struct bpf_map_desc=
),
> >                                            sizeof(struct bpf_prog_desc)=
);
> >       int log_buf_sz =3D (1u << 24) - 1;
> > @@ -1953,6 +1956,24 @@ static int try_loader(struct gen_loader_opts *ge=
n)
> >       opts.insns =3D gen->insns;
> >       opts.insns_sz =3D gen->insns_sz;
> >       fds_before =3D count_open_fds();
> > +
> > +     if (sign_progs) {
> > +             opts.excl_prog_hash =3D prog_sha;
> > +             opts.excl_prog_hash_sz =3D sizeof(prog_sha);
> > +             opts.signature =3D sig_buf;
> > +             opts.signature_sz =3D MAX_SIG_SIZE;
> > +             opts.keyring_id =3D KEY_SPEC_SESSION_KEYRING;
> > +
>
> And here as well.

The "load -S" command loads and signs the program in one go, so this
is purely for debugging and not how one would use signing. Session key
is fine here. What we really want is flexibility when using skeletons.

- KP



>
> > +             err =3D bpftool_prog_sign(&opts);
> > +             if (err < 0)
> > +                     return err;
> > +
> > +             err =3D register_session_key(cert_path);
> > +             if (err < 0) {
> > +                     p_err("failed to add session key");
> > +                     goto out;
> > +             }
> > +     }
> >       err =3D bpf_load_and_run(&opts);
> >       fd_delta =3D count_open_fds() - fds_before;
> >       if (err < 0 || verifier_logs) {
> > @@ -1961,6 +1982,7 @@ static int try_loader(struct gen_loader_opts *gen=
)
> >                       fprintf(stderr, "loader prog leaked %d FDs\n",
> >                               fd_delta);
> >       }
> > +out:
> >       free(log_buf);
> >       return err;
> >  }
> > @@ -1988,6 +2010,9 @@ static int do_loader(int argc, char **argv)
> >               goto err_close_obj;
> >       }
> >
> > +     if (sign_progs)
> > +             gen.gen_hash =3D true;
> > +
> >       err =3D bpf_object__gen_loader(obj, &gen);
> >       if (err)
> >               goto err_close_obj;
> > @@ -2562,7 +2587,7 @@ static int do_help(int argc, char **argv)
> >               "       METRIC :=3D { cycles | instructions | l1d_loads |=
 llc_misses | itlb_misses | dtlb_misses }\n"
> >               "       " HELP_SPEC_OPTIONS " |\n"
> >               "                    {-f|--bpffs} | {-m|--mapcompat} | {-=
n|--nomount} |\n"
> > -             "                    {-L|--use-loader} }\n"
> > +             "                    {-L|--use-loader} | [ {-S|--sign } {=
-k} <private_key.pem> {-i} <certificate.x509> ] \n"
> >               "",
> >               bin_name, argv[-2]);
> >
> > diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
> > new file mode 100644
> > index 000000000000..b29d825bb1d4
> > --- /dev/null
> > +++ b/tools/bpf/bpftool/sign.c
> > @@ -0,0 +1,212 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +/*
> > + * Copyright (C) 2025 Google LLC.
> > + */
> > +
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <stdint.h>
> > +#include <stdbool.h>
> > +#include <string.h>
> > +#include <string.h>
> > +#include <getopt.h>
> > +#include <err.h>
> > +#include <openssl/opensslv.h>
> > +#include <openssl/bio.h>
> > +#include <openssl/evp.h>
> > +#include <openssl/pem.h>
> > +#include <openssl/err.h>
> > +#include <openssl/cms.h>
> > +#include <linux/keyctl.h>
> > +#include <errno.h>
> > +
> > +#include <bpf/skel_internal.h>
> > +
> > +#include "main.h"
> > +
> > +#define OPEN_SSL_ERR_BUF_LEN 256
> > +
> > +static void display_openssl_errors(int l)
> > +{
> > +     char buf[OPEN_SSL_ERR_BUF_LEN];
> > +     const char *file;
> > +     const char *data;
> > +     unsigned long e;
> > +     int flags;
> > +     int line;
> > +
> > +     while ((e =3D ERR_get_error_all(&file, &line, NULL, &data, &flags=
))) {
> > +             ERR_error_string_n(e, buf, sizeof(buf));
> > +             if (data && (flags & ERR_TXT_STRING)) {
> > +                     p_err("OpenSSL %s: %s:%d: %s", buf, file, line, d=
ata);
> > +             } else {
> > +                     p_err("OpenSSL %s: %s:%d", buf, file, line);
> > +             }
> > +     }
> > +}
> > +
> > +#define DISPLAY_OSSL_ERR(cond)                                \
> > +     do {                                             \
> > +             bool __cond =3D (cond);                    \
> > +             if (__cond && ERR_peek_error())          \
> > +                     display_openssl_errors(__LINE__);\
> > +     } while (0)
> > +
> > +static EVP_PKEY *read_private_key(const char *pkey_path)
> > +{
> > +     EVP_PKEY *private_key =3D NULL;
> > +     BIO *b;
> > +
> > +     b =3D BIO_new_file(pkey_path, "rb");
> > +     private_key =3D PEM_read_bio_PrivateKey(b, NULL, NULL, NULL);
> > +     BIO_free(b);
> > +     DISPLAY_OSSL_ERR(!private_key);
> > +     return private_key;
> > +}
> > +
> > +static X509 *read_x509(const char *x509_name)
> > +{
> > +     unsigned char buf[2];
> > +     X509 *x509 =3D NULL;
> > +     BIO *b;
> > +     int n;
> > +
> > +     b =3D BIO_new_file(x509_name, "rb");
> > +     if (!b)
> > +             goto cleanup;
> > +
> > +     /* Look at the first two bytes of the file to determine the encod=
ing */
> > +     n =3D BIO_read(b, buf, 2);
> > +     if (n !=3D 2)
> > +             goto cleanup;
> > +
> > +     if (BIO_reset(b) !=3D 0)
> > +             goto cleanup;
> > +
> > +     if (buf[0] =3D=3D 0x30 && buf[1] >=3D 0x81 && buf[1] <=3D 0x84)
> > +             /* Assume raw DER encoded X.509 */
> > +             x509 =3D d2i_X509_bio(b, NULL);
> > +     else
> > +             /* Assume PEM encoded X.509 */
> > +             x509 =3D PEM_read_bio_X509(b, NULL, NULL, NULL);
> > +
> > +cleanup:
> > +     BIO_free(b);
> > +     DISPLAY_OSSL_ERR(!x509);
> > +     return x509;
> > +}
> > +
> > +__u32 register_session_key(const char *key_der_path)
> > +{
> > +     unsigned char *der_buf =3D NULL;
> > +     X509 *x509 =3D NULL;
> > +     int key_id =3D -1;
> > +     int der_len;
> > +
> > +     if (!key_der_path)
> > +             return key_id;
> > +     x509 =3D read_x509(key_der_path);
> > +     if (!x509)
> > +             goto cleanup;
> > +     der_len =3D i2d_X509(x509, &der_buf);
> > +     if (der_len < 0)
> > +             goto cleanup;
> > +     key_id =3D syscall(__NR_add_key, "asymmetric", key_der_path, der_=
buf,
> > +                          (size_t)der_len, KEY_SPEC_SESSION_KEYRING);
> > +cleanup:
> > +     X509_free(x509);
> > +     OPENSSL_free(der_buf);
> > +     DISPLAY_OSSL_ERR(key_id =3D=3D -1);
> > +     return key_id;
> > +}
> > +
> > +int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
> > +{
> > +     BIO *bd_in =3D NULL, *bd_out =3D NULL;
> > +     EVP_PKEY *private_key =3D NULL;
> > +     CMS_ContentInfo *cms =3D NULL;
> > +     long actual_sig_len =3D 0;
> > +     X509 *x509 =3D NULL;
> > +     int err =3D 0;
> > +
> > +     bd_in =3D BIO_new_mem_buf(opts->insns, opts->insns_sz);
> > +     if (!bd_in) {
> > +             err =3D -ENOMEM;
> > +             goto cleanup;
> > +     }
> > +
> > +     private_key =3D read_private_key(private_key_path);
> > +     if (!private_key) {
> > +             err =3D -EINVAL;
> > +             goto cleanup;
> > +     }
> > +
> > +     x509 =3D read_x509(cert_path);
> > +     if (!x509) {
> > +             err =3D -EINVAL;
> > +             goto cleanup;
> > +     }
> > +
> > +     cms =3D CMS_sign(NULL, NULL, NULL, NULL,
> > +                    CMS_NOCERTS | CMS_PARTIAL | CMS_BINARY | CMS_DETAC=
HED |
> > +                            CMS_STREAM);
> > +     if (!cms) {
> > +             err =3D -EINVAL;
> > +             goto cleanup;
> > +     }
> > +
> > +     if (!CMS_add1_signer(cms, x509, private_key, EVP_sha256(),
> > +                          CMS_NOCERTS | CMS_BINARY | CMS_NOSMIMECAP |
> > +                          CMS_USE_KEYID | CMS_NOATTR)) {
> > +             err =3D -EINVAL;
> > +             goto cleanup;
> > +     }
> > +
> > +     if (CMS_final(cms, bd_in, NULL, CMS_NOCERTS | CMS_BINARY) !=3D 1)=
 {
> > +             err =3D -EIO;
> > +             goto cleanup;
> > +     }
> > +
> > +     EVP_Digest(opts->insns, opts->insns_sz, opts->excl_prog_hash,
> > +                &opts->excl_prog_hash_sz, EVP_sha256(), NULL);
> > +
> > +             bd_out =3D BIO_new(BIO_s_mem());
> > +     if (!bd_out) {
> > +             err =3D -ENOMEM;
> > +             goto cleanup;
> > +     }
> > +
> > +     if (!i2d_CMS_bio_stream(bd_out, cms, NULL, 0)) {
> > +             err =3D -EIO;
> > +             goto cleanup;
> > +     }
> > +
> > +     actual_sig_len =3D BIO_get_mem_data(bd_out, NULL);
> > +     if (actual_sig_len <=3D 0) {
> > +             err =3D -EIO;
> > +             goto cleanup;
> > +     }
> > +
> > +     if ((size_t)actual_sig_len > opts->signature_sz) {
> > +             err =3D -ENOSPC;
> > +             goto cleanup;
> > +     }
> > +
> > +     if (BIO_read(bd_out, opts->signature, actual_sig_len) !=3D actual=
_sig_len) {
> > +             err =3D -EIO;
> > +             goto cleanup;
> > +     }
> > +
> > +     opts->signature_sz =3D actual_sig_len;
> > +cleanup:
> > +     BIO_free(bd_out);
> > +     CMS_ContentInfo_free(cms);
> > +     X509_free(x509);
> > +     EVP_PKEY_free(private_key);
> > +     BIO_free(bd_in);
> > +     DISPLAY_OSSL_ERR(err < 0);
> > +     return err;
> > +}
> > --
> > 2.43.0

