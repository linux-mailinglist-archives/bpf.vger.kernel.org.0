Return-Path: <bpf+bounces-14078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBA27E064E
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 17:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0F21C210CE
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 16:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542BE1C6B6;
	Fri,  3 Nov 2023 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnNcUh4c"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C422D14002
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 16:22:12 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94BC1BF
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 09:22:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso355179566b.2
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 09:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699028527; x=1699633327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mri5cWD7S/wDmVHAkBMdvKHhOufV/cqyVWw1TzxtywU=;
        b=KnNcUh4cgVpHVKtlBtdPPLe5uOKwzZQ8WKgCecxqQ+YPYaA77TVnHiEp5KYGzbwDSn
         9HRlSOSRVBU98c5BltvlRWHwxRkzEAfgwaVWPqHVV2hQ9t80cTMjr2JC55MWxHhg/mxA
         eYSgEGwB9TK/gdtd7wE/JgU7JBJDlrZvkEV6LtoPu8LipHOoDbirtHAb4oRSJf9DOAEZ
         /Fl327dh4ICJ0NeIukBZ2xrLNABSWGgsZoPRqt+Y7GM0NyPRHRN5Bqu+L30o/qRSMPFd
         giVJiiFOUieIBy8Xd9TE4NqZmURh0sO0tnOcr9VgEzXpAn46nOtWEWQ6BcFUpo+SzNqS
         MJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699028527; x=1699633327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mri5cWD7S/wDmVHAkBMdvKHhOufV/cqyVWw1TzxtywU=;
        b=YitwXCUQaLpYR4pYPK3Zahf6+ILJV4lq9gkbTOc/b5TJrgG9x/ut2UzpC68ptYykcx
         +MUpsT6nk8y9e72VScWIHVjs0pbGqzqhS00gIYHOTjTyu/3MwzmQwDUDs7eOQ9Kmcho0
         Rzbi2mb7dBEAN5GLfiRDHmrVtTE2QIlUOzzSD7YAtF6ylw2Qj/la8AKADp8zsASWDLmR
         bXzhqDXfGcLtrPjm2aqL5JvbBKjuDi7PdhVBd6osE3D7EMEyqoqN0/n1fKoqH+lYBZ+d
         I4sCaj3/+aFOFe7xin47LI7yuZJLUxx8/DKtWrXbjjTfnKhUvqPNSimi83Z5raVIb7h8
         P8CQ==
X-Gm-Message-State: AOJu0YyrvJ7jwrVT0V0H0AzR96SfRVKDG6NKthFxj9oSLc8eh1T9aICb
	PXjak8KhZxhnHH8eoHJDXISKzUYnVegiTa+foz4=
X-Google-Smtp-Source: AGHT+IH478OLMau9JhA42UMn4mIM09qHojB+84WP3fqP0TYmwyR48KVvJyefZE3QnBJelm9MneYdRS52ec/6OsG+NOs=
X-Received: by 2002:a17:907:3da1:b0:9b7:37de:6009 with SMTP id
 he33-20020a1709073da100b009b737de6009mr7661799ejc.3.1699028526955; Fri, 03
 Nov 2023 09:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103055218.2395034-1-yonghong.song@linux.dev>
In-Reply-To: <20231103055218.2395034-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Nov 2023 09:21:55 -0700
Message-ID: <CAEf4BzZ1ZKEGvcz+fuvZ18bx5E4kkqg0-dTu1DqohZMTMcqR0g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] libbpf: bpftool : Emit aligned(8) attr for
 empty struct in btf source dump
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Vadim Fedorenko <vadfed@meta.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 10:52=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Martin and Vadim reported a verifier failure with bpf_dynptr usage.
> The issue is mentioned but Vadim workarounded the issue with source
> change ([1]). The below describes what is the issue and why there
> is a verification failure.
>
>   int BPF_PROG(skb_crypto_setup) {
>     struct bpf_dynptr algo, key;
>     ...
>
>     bpf_dynptr_from_mem(..., ..., 0, &algo);
>     ...
>   }
>
> The bpf program is using vmlinux.h, so we have the following definition i=
n
> vmlinux.h:
>   struct bpf_dynptr {
>         long: 64;
>         long: 64;
>   };
> Note that in uapi header bpf.h, we have
>   struct bpf_dynptr {
>         long: 64;
>         long: 64;
> } __attribute__((aligned(8)));
>
> So we lost alignment information for struct bpf_dynptr by using vmlinux.h=
.
> Let us take a look at a simple program below:
>   $ cat align.c
>   typedef unsigned long long __u64;
>   struct bpf_dynptr_no_align {
>         __u64 :64;
>         __u64 :64;
>   };
>   struct bpf_dynptr_yes_align {
>         __u64 :64;
>         __u64 :64;
>   } __attribute__((aligned(8)));
>
>   void bar(void *, void *);
>   int foo() {
>     struct bpf_dynptr_no_align a;
>     struct bpf_dynptr_yes_align b;
>     bar(&a, &b);
>     return 0;
>   }
>   $ clang --target=3Dbpf -O2 -S -emit-llvm align.c
>
> Look at the generated IR file align.ll:
>   ...
>   %a =3D alloca %struct.bpf_dynptr_no_align, align 1
>   %b =3D alloca %struct.bpf_dynptr_yes_align, align 8
>   ...
>
> The compiler dictates the alignment for struct bpf_dynptr_no_align is 1 a=
nd
> the alignment for struct bpf_dynptr_yes_align is 8. So theoretically comp=
iler
> could allocate variable %a with alignment 1 although in reallity the comp=
iler
> may choose a different alignment by considering other variables.
>
> In [1], the verification failure happens because variable 'algo' is alloc=
ated
> on the stack with alignment 4 (fp-28). But the verifer wants its alignmen=
t
> to be 8.
>
> To fix the issue, the aligned(8) attribute should be emitted for those
> special uapi structs (bpf_dynptr etc.) whose values will be used by
> kernel helpers or kfuncs. For example, the following bpf_dynptr type
> will be generated in vmlinux.h:
>   struct bpf_dynptr {
>         long: 64;
>         long: 64;
> } __attribute__((aligned(8)));
>
> There are a few ways to do this:
>   (1). this patch added an option 'empty_struct_align8' in 'btf_dump_opts=
',
>        and bpftool will enable this option so libbpf will emit aligned(8)
>        for empty structs. The only drawback is that some other non-bpf-ua=
pi
>        empty structs may be marked as well but this does not have any rea=
l impact.
>   (2). Only add aligned(8) if the struct having 'bpf_' prefix. Similar to=
 (1),
>        the action is controlled with an option in 'btf_dump_opts'.
>
> Also, not sure whether adding an option in 'btf_dump_opts' is the best so=
lution
> or not. Another possibility is to add an option to btf_dump__dump_type() =
with
> a different function name, e.g., btf_dump__dump_type_opts() but it makes =
the
> function is not consistent with btf_dump__emit_type_decl().
>
> So send this patch as RFC due to above different implementation choices.
>

Let's do what we do for open-coded iterators, add opaque u64s:

/* BPF numbers iterator state */
struct bpf_iter_num {
        /* opaque iterator state; having __u64 here allows to preserve corr=
ect
         * alignment requirements in vmlinux.h, generated from BTF
         */
        __u64 __opaque[1];
} __attribute__((aligned(8)));


I think it's much better than random extra options or having to do
what we do with private() macro everywhere:

#define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)=
))


>   [1] https://lore.kernel.org/bpf/1b100f73-7625-4c1f-3ae5-50ecf84d3ff0@li=
nux.dev/
>
> Cc: Vadim Fedorenko <vadfed@meta.com>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/bpf/bpftool/btf.c  | 5 ++++-
>  tools/lib/bpf/btf.h      | 7 ++++++-
>  tools/lib/bpf/btf_dump.c | 7 ++++++-
>  3 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 91fcb75babe3..c9061d476f7d 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -463,10 +463,13 @@ static void __printf(2, 0) btf_dump_printf(void *ct=
x,
>  static int dump_btf_c(const struct btf *btf,
>                       __u32 *root_type_ids, int root_type_cnt)
>  {
> +       LIBBPF_OPTS(btf_dump_opts, opts,
> +               .empty_struct_align8 =3D true,
> +       );
>         struct btf_dump *d;
>         int err =3D 0, i;
>
> -       d =3D btf_dump__new(btf, btf_dump_printf, NULL, NULL);
> +       d =3D btf_dump__new(btf, btf_dump_printf, NULL, &opts);
>         if (!d)
>                 return -errno;
>
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 8e6880d91c84..af88563fe0ff 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -235,8 +235,13 @@ struct btf_dump;
>
>  struct btf_dump_opts {
>         size_t sz;
> +       /* emit '__attribute__((aligned(8)))' for empty struct, i.e.,
> +        * the struct has no named member.
> +        */
> +       bool empty_struct_align8;
> +       size_t :0;
>  };
> -#define btf_dump_opts__last_field sz
> +#define btf_dump_opts__last_field empty_struct_align8
>
>  typedef void (*btf_dump_printf_fn_t)(void *ctx, const char *fmt, va_list=
 args);
>
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 4d9f30bf7f01..fe386d20a43a 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -83,6 +83,7 @@ struct btf_dump {
>         int ptr_sz;
>         bool strip_mods;
>         bool skip_anon_defs;
> +       bool empty_struct_align8;
>         int last_id;
>
>         /* per-type auxiliary state */
> @@ -167,6 +168,7 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
>         d->printf_fn =3D printf_fn;
>         d->cb_ctx =3D ctx;
>         d->ptr_sz =3D btf__pointer_size(btf) ? : sizeof(void *);
> +       d->empty_struct_align8 =3D OPTS_GET(opts, empty_struct_align8, fa=
lse);
>
>         d->type_names =3D hashmap__new(str_hash_fn, str_equal_fn, NULL);
>         if (IS_ERR(d->type_names)) {
> @@ -808,7 +810,10 @@ static void btf_dump_emit_type(struct btf_dump *d, _=
_u32 id, __u32 cont_id)
>
>                 if (top_level_def) {
>                         btf_dump_emit_struct_def(d, id, t, 0);
> -                       btf_dump_printf(d, ";\n\n");
> +                       if (kind =3D=3D BTF_KIND_UNION || btf_vlen(t) || =
!d->empty_struct_align8)
> +                               btf_dump_printf(d, ";\n\n");
> +                       else
> +                               btf_dump_printf(d, " __attribute__((align=
ed(8)));\n\n");
>                         tstate->emit_state =3D EMITTED;
>                 } else {
>                         tstate->emit_state =3D NOT_EMITTED;
> --
> 2.34.1
>

