Return-Path: <bpf+bounces-50587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2616AA29E34
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 02:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D327A16DD
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 01:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1421CD3F;
	Thu,  6 Feb 2025 01:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK8dZLuX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CCA38DE0
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 01:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738804034; cv=none; b=J4eLVqHH54MO3IKMkqDpuit2mbexsEAmqj13JkkBd2Cn7w4D3VAzfwdNBMBl+ISJHOtkPLiTW0RP15V/TSIYZ/r4BL98SUSPGwru0w0z3D246IErjy7dB7tRnhXHw0CqsImp9fPvKim8pGRAwMfiVyMXqXJvI13QPjCn9cJGqhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738804034; c=relaxed/simple;
	bh=ld3OKEAetAtSs23DmL4XsAen03gYvkdRWwPi8isizmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqB+vxiAONSwSRvKw4uEmyZHZHRgncjHbpXVzeei/5j1G9zP/JMna3/LeIJLGKVlGkuxJbykRyV9U1H933AOahhdWNTfV7AZYkG6qZX+D5m1Hg3HI4IQDZAvXpFeZoCJGxb+J7pdf65ZGIQd5zsWCvbBQuIxt7NkH48Lvxy/MGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK8dZLuX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-219f8263ae0so8503335ad.0
        for <bpf@vger.kernel.org>; Wed, 05 Feb 2025 17:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738804031; x=1739408831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sav4fLXnjFIKEtCChFsEGDxJMHM86/qHX4hbypssX6g=;
        b=kK8dZLuXX+TQswMOZ4jY9xFzkrf5zBqMpu40QkTabgSfqPzyYwsg91vcLJXBMYabJl
         9W32SP5WMaJJ0PnKMR/Knyljhk9FfMw5xHmnaxZ6ZFB9SGKBNlDl1NLedPf8U0qUZsgH
         zcwUm7+eRbhLsWLxtHXDr8XXVxXcKBjsgWMs7GjoL6ohDAzG/pWlKQJwHh7u37CuR+La
         mvVg9M4C0sFxfznpoTPzHGYTtBFF7mM1aTg3IxquU4cOyBgqr7osyMryesuokT3Xj/mb
         8RSAXOyWiXtM7djguxMAEfwbrW22C0XI4lYVOhkKkOVENE9uOF0uHwS0AV84fCRNM3mF
         U/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738804031; x=1739408831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sav4fLXnjFIKEtCChFsEGDxJMHM86/qHX4hbypssX6g=;
        b=umUplBjpqD12+pF+6xKgeMhn7O9maexZhTJsNgCE5zzwQEtfIPMg6QwdMyAm6gTfH7
         6puO/z/0XEs2DJHFfWUd736u1XCeIFMNfr006rwnCtyG+uGtehqWmMswHuaib9cZnoEm
         M5mkusljlPB8RsncKvtkC5mptkAUMgbA4hIy8hG95NuRa/zw/eBTUSi/jpQVrkGWqubm
         j66mpvk2X/hXicy+b8miB5pThejud69du4TBAEYvLGxT0C/NZezVCSjrl4k8WIXITM5J
         pSIY2pVBuFKqu+41l/17ncfRVy+PHxe+XOGU4fvNL0zK0T6Gi8mSaDh8rAv4787+Q8i3
         cnVw==
X-Gm-Message-State: AOJu0YwQOp4/7lP1p/amVWPV5wBC1No6beuCrK5I6SkRds83P11w9LKJ
	XaA1ANxB7cLu6qI/s4sywsQTTXDlBIJ/0oYZJ99XorpUY2ubjQKpwYv0BEdnH8JFStmaCMQu5Za
	ZoxPfEfhFmdWhvrBCaqi7oGKirro=
X-Gm-Gg: ASbGncvwu0bsMq/AaZGvnyiReXu5AhNjRHFffRtbXsgher+unJp0ygS+hRTR1M+Kl8O
	GFX7H3wO6hsq5SByx7xODueFQ2nj9fEq41FHYoddG9W6svZumAWQj1Ob7G30aecIYkqJTDPJwe1
	jWjYdZwK9GKQv4
X-Google-Smtp-Source: AGHT+IFicrAciwQH6dKySW9OzlbT6tdUk1aQrYBsdzfVYLTE3iE36UKcJO5lL/eLIUkpyM4qPG3pmVWepx+Sdft3IK8=
X-Received: by 2002:a05:6a00:a81:b0:72a:8b90:92e9 with SMTP id
 d2e1a72fcca58-730350df59emr7968486b3a.5.1738804030862; Wed, 05 Feb 2025
 17:07:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203164002.128321-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250203164002.128321-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Feb 2025 17:06:56 -0800
X-Gm-Features: AWEUYZlj7TXVZGubRnNcVszGWZhV-snYkNBrbqbrsdzW3qfl0VJe-II3dcf4HAQ
Message-ID: <CAEf4BzayxsGSj5n3A6HAYgg3QC5xFvNcXrCHgLCqiWMj=0EP6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: implement setting global
 variables in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 8:41=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> To better verify some complex BPF programs we'd like to preset global
> variables.
> This patch introduces CLI argument `--set-global-vars` to veristat, that
> allows presetting values to global variables defined in BPF program. For
> example:
>
> prog.c:
> ```
> enum Enum { ELEMENT1 =3D 0, ELEMENT2 =3D 5 };
> const volatile __s64 a =3D 5;
> const volatile __u8 b =3D 5;
> const volatile enum Enum c =3D ELEMENT2;
> const volatile bool d =3D false;
>
> char arr[4] =3D {0};
>
> SEC("tp_btf/sched_switch")
> int BPF_PROG(...)
> {
>         bpf_printk("%c\n", arr[a]);
>         bpf_printk("%c\n", arr[b]);
>         bpf_printk("%c\n", arr[c]);
>         bpf_printk("%c\n", arr[d]);
>         return 0;
> }
> ```
> By default verification of the program fails:
> ```
> ./veristat prog.bpf.o
> ```
> By presetting global variables, we can make verification pass:
> ```
> ./veristat wq.bpf.o  --set-global-vars "a =3D 0; b =3D 1; c =3D 2; d =3D =
3;"
> ```
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 189 +++++++++++++++++++++++++
>  1 file changed, 189 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index 06af5029885b..65bb8a773d23 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -154,6 +154,11 @@ struct filter {
>         bool abs;
>  };
>
> +struct var_preset {
> +       char *name;
> +       long long value;
> +};
> +
>  static struct env {
>         char **filenames;
>         int filename_cnt;
> @@ -195,6 +200,8 @@ static struct env {
>         int progs_processed;
>         int progs_skipped;
>         int top_src_lines;
> +       struct var_preset *presets;
> +       int npresets;
>  } env;
>
>  static int libbpf_print_fn(enum libbpf_print_level level, const char *fo=
rmat, va_list args)
> @@ -246,12 +253,14 @@ static const struct argp_option opts[] =3D {
>         { "test-reg-invariants", 'r', NULL, 0,
>           "Force BPF verifier failure on register invariant violation (BP=
F_F_TEST_REG_INVARIANTS program flag)" },
>         { "top-src-lines", 'S', "N", 0, "Emit N most frequent source code=
 lines" },
> +       { "set-global-vars", 'g', "GLOBALS", 0, "Set global variables pro=
vided in the expression, for example \"var1 =3D 1; var2 =3D 2\"" },

nit: this is subjective, but I feel like -G instead of -g would be
better here to be more noticeable

but main point from me here would be to avoid parsing multiple values,
it's better to allow repeated -G uses and treat each value as strictly
single variable initialization. So instead of:

./veristat wq.bpf.o  --set-global-vars "a =3D 0; b =3D 1; c =3D 2; d =3D 3;=
"

we'll have:

./veristat wq.bpf.o  -G "a =3D 0" -G "b =3D 1" -G "c =3D 2" -G "d =3D 3"

A touch more verbose for many variables, but not significantly so. On
the other hand, less parsing, and less arbitrary choices of what
separator (;) to use. WDYT?

pw-bot: cr

>         {},
>  };
>
>  static int parse_stats(const char *stats_str, struct stat_specs *specs);
>  static int append_filter(struct filter **filters, int *cnt, const char *=
str);
>  static int append_filter_file(const char *path);
> +static int parse_var_presets(char *expr, struct var_preset *presets, int=
 capacity, int *size);
>
>  static error_t parse_arg(int key, char *arg, struct argp_state *state)
>  {
> @@ -363,6 +372,17 @@ static error_t parse_arg(int key, char *arg, struct =
argp_state *state)
>                         return -ENOMEM;
>                 env.filename_cnt++;
>                 break;
> +       case 'g': {
> +               char *expr =3D strdup(arg);
> +
> +               env.presets =3D calloc(64, sizeof(*env.presets));
> +               if (parse_var_presets(expr, env.presets, 64, &env.npreset=
s)) {
> +                       fprintf(stderr, "Could not parse global variables=
 preset: %s\n", arg);
> +                       argp_usage(state);
> +               }
> +               free(expr);
> +               break;
> +       }
>         default:
>                 return ARGP_ERR_UNKNOWN;
>         }
> @@ -1292,6 +1312,169 @@ static int process_prog(const char *filename, str=
uct bpf_object *obj, struct bpf
>         return 0;
>  };
>
> +static int parse_var_presets(char *expr, struct var_preset *presets, int=
 capacity, int *size)
> +{
> +       char *state;
> +       char *next;
> +       int i =3D 0;
> +
> +       while ((next =3D strtok_r(i ? NULL : expr, ";", &state))) {
> +               char *eq_ptr =3D strchr(next, '=3D');
> +               char *name_ptr =3D next;
> +               char *name_end =3D eq_ptr - 1;
> +               char *val_ptr =3D eq_ptr + 1;
> +
> +               if (!eq_ptr)
> +                       continue;
> +
> +               if (i >=3D capacity) {

why artificially hard-coding maximum capacity? we have malloc()

> +                       fprintf(stderr, "Too many global variable presets=
\n");
> +                       return -EINVAL;
> +               }
> +               while (isspace(*name_ptr))
> +                       ++name_ptr;
> +               while (isspace(*name_end))
> +                       --name_end;
> +
> +               *(name_end + 1) =3D '\0';
> +               presets[i].name =3D strdup(name_ptr);
> +               errno =3D 0;
> +               presets[i].value =3D strtoll(val_ptr, NULL, 10);
> +               if (errno =3D=3D ERANGE) {
> +                       errno =3D 0;
> +                       presets[i].value =3D strtoull(val_ptr, NULL, 10);
> +               }
> +               if (errno) {
> +                       fprintf(stderr, "Could not parse integer value %s=
\n", val_ptr);
> +                       return -EINVAL;
> +               }
> +               ++i;
> +       }
> +       *size =3D i;
> +       return 0;
> +}
> +

it would be nice to be able to specify enums both by name and by value, WDY=
T?

> +static bool is_signed_type(const struct btf_type *type)
> +{
> +       if (btf_is_int(type))
> +               return btf_int_encoding(type) & BTF_INT_SIGNED;

enum can be signed as well, I think (but different way to specify
that, through kflag)

> +       return true;
> +}
> +
> +static const struct btf_type *var_base_type(const struct btf *btf, const=
 struct btf_type *type)
> +{
> +       switch (btf_kind(type)) {
> +       case BTF_KIND_VAR:
> +       case BTF_KIND_TYPE_TAG:
> +       case BTF_KIND_CONST:
> +       case BTF_KIND_VOLATILE:
> +       case BTF_KIND_RESTRICT:
> +       case BTF_KIND_TYPEDEF:
> +       case BTF_KIND_DECL_TAG:
> +               return var_base_type(btf, btf__type_by_id(btf, type->type=
));

why recursion, just do a loop?

and libbpf actually has "btf__resolve_type()", see if you can just use that=
?

> +       }
> +       return type;
> +}
> +

[...]

