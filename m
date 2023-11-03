Return-Path: <bpf+bounces-14085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8283C7E0889
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 19:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CEC281D87
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 18:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC74C8C6;
	Fri,  3 Nov 2023 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtS6r6T9"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD9823CC
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 18:55:23 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5D2BD
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 11:55:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-991c786369cso372114266b.1
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 11:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699037720; x=1699642520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUcyoPwm1OqlVMPBewOZZXu5LYsjDd6Oved8Qw1nfyQ=;
        b=JtS6r6T9iE93AeNotKJhnktEsK3fW0yPnOvU3VeRgKO426TS8muisXw2FGhBr18QEG
         HkN8IvPMBwmSphvm5utmXTpWcKpKHTw1GP80dyLVSsTkhebI7gWZF2aGGjOXOsVDua/z
         NlxSFUwjgRiBDcn803igNOyDVxr2ZEc/k4E7usQtgLGPCOFbdG4RIr1c3rex91cBcGZ4
         LiXAVFZLG70yR4TnhHHMd5SZBO3gXxDlcReEPW131gczYoIIdqx+Ctt9KvojaABVlNb6
         pbxr4vlm/fViy6OcXecpZ8rPYgMGj3NV/xIA2i+FP3cjP3ebxNl4aZMs69Uqdfs55sYJ
         E58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699037720; x=1699642520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUcyoPwm1OqlVMPBewOZZXu5LYsjDd6Oved8Qw1nfyQ=;
        b=vF9m1wSMzggpfSsiy0MM2m4CZ4N239FzImZnp3LgWmImSYXNgDtIZFVp7F7Ehj7XQ9
         W40llYzZgwJJCs8pZCpbiQR5dZqdxipWPJ7ICpZgUVnLzDqKtpx3pnKROk8UIsHk95rX
         AWlxBkK34r+8Jvq02H+Xc0CqJ1oE6yC083JMeWMP3KcnXlAIAz0bkqHi1uugpNvHlpVR
         WXO2+uJMVbVqBM/JTxcYjTfCFPWzIOQJV1FVnXiSnx76nbU/coZ4FfnMB0k9K/79lsRV
         VKdaEPF6EmLqiIDN/OP/WKsSLDEqWjnbEL4gSoPTFCVmHpGQMtCBckJbX6hbkVCmAL4M
         U6FA==
X-Gm-Message-State: AOJu0YxuzL6OUJyup/v85YOIpeJ1rG6RuBQUbRNW5OjFS4WRQizfcxFZ
	SgQPCTkD7hfMz8x8WNr52G7dnH+ciWdtI9iykTo=
X-Google-Smtp-Source: AGHT+IGmgOVQLM2i4ng1Br1o4ejHXRQTFOJDIRkgrtTxRGdx58KzZtzWpZhL8oQh2jS1P5zFx3Bgs7n814fyl69DhBs=
X-Received: by 2002:a17:906:dac4:b0:9ae:5120:5147 with SMTP id
 xi4-20020a170906dac400b009ae51205147mr8215420ejb.38.1699037719973; Fri, 03
 Nov 2023 11:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103055218.2395034-1-yonghong.song@linux.dev>
 <CAEf4BzZ1ZKEGvcz+fuvZ18bx5E4kkqg0-dTu1DqohZMTMcqR0g@mail.gmail.com> <57a8597c-0739-4b3b-a157-c31d9db55845@linux.dev>
In-Reply-To: <57a8597c-0739-4b3b-a157-c31d9db55845@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Nov 2023 11:55:08 -0700
Message-ID: <CAEf4BzZgWwLxa-rNajbeN=aUn_8kOGTCnf8Cyf_ZCb+OPaP1-A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] libbpf: bpftool : Emit aligned(8) attr for
 empty struct in btf source dump
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Vadim Fedorenko <vadfed@meta.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 9:53=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 11/3/23 9:21 AM, Andrii Nakryiko wrote:
> > On Thu, Nov 2, 2023 at 10:52=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >> Martin and Vadim reported a verifier failure with bpf_dynptr usage.
> >> The issue is mentioned but Vadim workarounded the issue with source
> >> change ([1]). The below describes what is the issue and why there
> >> is a verification failure.
> >>
> >>    int BPF_PROG(skb_crypto_setup) {
> >>      struct bpf_dynptr algo, key;
> >>      ...
> >>
> >>      bpf_dynptr_from_mem(..., ..., 0, &algo);
> >>      ...
> >>    }
> >>
> >> The bpf program is using vmlinux.h, so we have the following definitio=
n in
> >> vmlinux.h:
> >>    struct bpf_dynptr {
> >>          long: 64;
> >>          long: 64;
> >>    };
> >> Note that in uapi header bpf.h, we have
> >>    struct bpf_dynptr {
> >>          long: 64;
> >>          long: 64;
> >> } __attribute__((aligned(8)));
> >>
> >> So we lost alignment information for struct bpf_dynptr by using vmlinu=
x.h.
> >> Let us take a look at a simple program below:
> >>    $ cat align.c
> >>    typedef unsigned long long __u64;
> >>    struct bpf_dynptr_no_align {
> >>          __u64 :64;
> >>          __u64 :64;
> >>    };
> >>    struct bpf_dynptr_yes_align {
> >>          __u64 :64;
> >>          __u64 :64;
> >>    } __attribute__((aligned(8)));
> >>
> >>    void bar(void *, void *);
> >>    int foo() {
> >>      struct bpf_dynptr_no_align a;
> >>      struct bpf_dynptr_yes_align b;
> >>      bar(&a, &b);
> >>      return 0;
> >>    }
> >>    $ clang --target=3Dbpf -O2 -S -emit-llvm align.c
> >>
> >> Look at the generated IR file align.ll:
> >>    ...
> >>    %a =3D alloca %struct.bpf_dynptr_no_align, align 1
> >>    %b =3D alloca %struct.bpf_dynptr_yes_align, align 8
> >>    ...
> >>
> >> The compiler dictates the alignment for struct bpf_dynptr_no_align is =
1 and
> >> the alignment for struct bpf_dynptr_yes_align is 8. So theoretically c=
ompiler
> >> could allocate variable %a with alignment 1 although in reallity the c=
ompiler
> >> may choose a different alignment by considering other variables.
> >>
> >> In [1], the verification failure happens because variable 'algo' is al=
located
> >> on the stack with alignment 4 (fp-28). But the verifer wants its align=
ment
> >> to be 8.
> >>
> >> To fix the issue, the aligned(8) attribute should be emitted for those
> >> special uapi structs (bpf_dynptr etc.) whose values will be used by
> >> kernel helpers or kfuncs. For example, the following bpf_dynptr type
> >> will be generated in vmlinux.h:
> >>    struct bpf_dynptr {
> >>          long: 64;
> >>          long: 64;
> >> } __attribute__((aligned(8)));
> >>
> >> There are a few ways to do this:
> >>    (1). this patch added an option 'empty_struct_align8' in 'btf_dump_=
opts',
> >>         and bpftool will enable this option so libbpf will emit aligne=
d(8)
> >>         for empty structs. The only drawback is that some other non-bp=
f-uapi
> >>         empty structs may be marked as well but this does not have any=
 real impact.
> >>    (2). Only add aligned(8) if the struct having 'bpf_' prefix. Simila=
r to (1),
> >>         the action is controlled with an option in 'btf_dump_opts'.
> >>
> >> Also, not sure whether adding an option in 'btf_dump_opts' is the best=
 solution
> >> or not. Another possibility is to add an option to btf_dump__dump_type=
() with
> >> a different function name, e.g., btf_dump__dump_type_opts() but it mak=
es the
> >> function is not consistent with btf_dump__emit_type_decl().
> >>
> >> So send this patch as RFC due to above different implementation choice=
s.
> >>
> > Let's do what we do for open-coded iterators, add opaque u64s:
> >
> > /* BPF numbers iterator state */
> > struct bpf_iter_num {
> >          /* opaque iterator state; having __u64 here allows to preserve=
 correct
> >           * alignment requirements in vmlinux.h, generated from BTF
> >           */
> >          __u64 __opaque[1];
> > } __attribute__((aligned(8)));
>
> Good point. Will do. This will need change uapi struct, I think it is oka=
y.
> with __u64, we should not need aligned(8) attribute, but since uapi heade=
r
> already has it like in the above, I can keep it as well.
>

Yes, let's keep aligned(8) as well, it is needed on 32-bit architectures

>
> >
> >
> > I think it's much better than random extra options or having to do
> > what we do with private() macro everywhere:
> >
> > #define private(name) SEC(".bss." #name) __hidden __attribute__((aligne=
d(8)))
> >
> >
> >>    [1] https://lore.kernel.org/bpf/1b100f73-7625-4c1f-3ae5-50ecf84d3ff=
0@linux.dev/
> >>
> >> Cc: Vadim Fedorenko <vadfed@meta.com>
> >> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   tools/bpf/bpftool/btf.c  | 5 ++++-
> >>   tools/lib/bpf/btf.h      | 7 ++++++-
> >>   tools/lib/bpf/btf_dump.c | 7 ++++++-
> >>   3 files changed, 16 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> >> index 91fcb75babe3..c9061d476f7d 100644
> >> --- a/tools/bpf/bpftool/btf.c
> >> +++ b/tools/bpf/bpftool/btf.c
> >> @@ -463,10 +463,13 @@ static void __printf(2, 0) btf_dump_printf(void =
*ctx,
> >>   static int dump_btf_c(const struct btf *btf,
> >>                        __u32 *root_type_ids, int root_type_cnt)
> >>   {
> >> +       LIBBPF_OPTS(btf_dump_opts, opts,
> >> +               .empty_struct_align8 =3D true,
> >> +       );
> >>          struct btf_dump *d;
> >>          int err =3D 0, i;
> >>
> >> -       d =3D btf_dump__new(btf, btf_dump_printf, NULL, NULL);
> >> +       d =3D btf_dump__new(btf, btf_dump_printf, NULL, &opts);
> >>          if (!d)
> >>                  return -errno;
> >>
> >> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> >> index 8e6880d91c84..af88563fe0ff 100644
> >> --- a/tools/lib/bpf/btf.h
> >> +++ b/tools/lib/bpf/btf.h
> >> @@ -235,8 +235,13 @@ struct btf_dump;
> >>
> >>   struct btf_dump_opts {
> >>          size_t sz;
> >> +       /* emit '__attribute__((aligned(8)))' for empty struct, i.e.,
> >> +        * the struct has no named member.
> >> +        */
> >> +       bool empty_struct_align8;
> >> +       size_t :0;
> >>   };
> >> -#define btf_dump_opts__last_field sz
> >> +#define btf_dump_opts__last_field empty_struct_align8
> >>
> >>   typedef void (*btf_dump_printf_fn_t)(void *ctx, const char *fmt, va_=
list args);
> >>
> >> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> >> index 4d9f30bf7f01..fe386d20a43a 100644
> >> --- a/tools/lib/bpf/btf_dump.c
> >> +++ b/tools/lib/bpf/btf_dump.c
> >> @@ -83,6 +83,7 @@ struct btf_dump {
> >>          int ptr_sz;
> >>          bool strip_mods;
> >>          bool skip_anon_defs;
> >> +       bool empty_struct_align8;
> >>          int last_id;
> >>
> >>          /* per-type auxiliary state */
> >> @@ -167,6 +168,7 @@ struct btf_dump *btf_dump__new(const struct btf *b=
tf,
> >>          d->printf_fn =3D printf_fn;
> >>          d->cb_ctx =3D ctx;
> >>          d->ptr_sz =3D btf__pointer_size(btf) ? : sizeof(void *);
> >> +       d->empty_struct_align8 =3D OPTS_GET(opts, empty_struct_align8,=
 false);
> >>
> >>          d->type_names =3D hashmap__new(str_hash_fn, str_equal_fn, NUL=
L);
> >>          if (IS_ERR(d->type_names)) {
> >> @@ -808,7 +810,10 @@ static void btf_dump_emit_type(struct btf_dump *d=
, __u32 id, __u32 cont_id)
> >>
> >>                  if (top_level_def) {
> >>                          btf_dump_emit_struct_def(d, id, t, 0);
> >> -                       btf_dump_printf(d, ";\n\n");
> >> +                       if (kind =3D=3D BTF_KIND_UNION || btf_vlen(t) =
|| !d->empty_struct_align8)
> >> +                               btf_dump_printf(d, ";\n\n");
> >> +                       else
> >> +                               btf_dump_printf(d, " __attribute__((al=
igned(8)));\n\n");
> >>                          tstate->emit_state =3D EMITTED;
> >>                  } else {
> >>                          tstate->emit_state =3D NOT_EMITTED;
> >> --
> >> 2.34.1
> >>

