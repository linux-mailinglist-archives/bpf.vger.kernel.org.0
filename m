Return-Path: <bpf+bounces-51088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7562A2FFF7
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 02:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C04164DA1
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 01:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240F61B6CE4;
	Tue, 11 Feb 2025 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED6qC8Ma"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF31A155336
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 01:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739236406; cv=none; b=ACRXH5+c9MDjpNoDcK75tUA6scjBKa7quvEfUT4LtlYEIJGbUm4yZCDYsb/7hiwJUCSg+Mpj5bS0mBZfQnoyQsWi178l9w5NHK9/0mbdU9xp5QzOriY4wbxAkRmYnQAAfnwDEc+cL799cTQupZyQPBrNnhz8Ilimhb1nWQNU6Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739236406; c=relaxed/simple;
	bh=vBYQKGTDVe45+eTA8qGowXtV1yBRo2sKKL+LXV6CBxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nW57jXg/QjvOn0p2dm3XdgSJmtOjBiS20iKEbYDWs+9iEi6I0as/wWoJ9JywBGI3bcVGfE5PZV3Ee0wH0RayGqyKfkJg3pu5uxbW/2N0nvaVPkHbUOKia4GzpM/nVsCg8lMc2b/YNn5JUR9hLPa7u2R9KvUFRpvCTqlr/pLIVFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ED6qC8Ma; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fa7465baceso3154844a91.0
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 17:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739236404; x=1739841204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/4kyFy0V3h03WacXSIZutPcczKKCLp5PGS4mu0fqU8=;
        b=ED6qC8MaHSZ5aASSmEbwChlaINrJmaY/+BwKnUlsLbARjhJkWETveSLdK8cJiYrk5x
         zVVMeygTk5sL9eP44X5us9NKSx/TJE7t7q0zlYI1qLFTsXC4ZS3yP2Ze/r3nqwYTBmgn
         Q4gbgJwETq55cCCPo8UUVQGlvVMEwLPL8M2OR19lwABChV3uFFT/vdIj+UxjQfoi3+Pk
         7UCLmEzaYH8oLm2oeFh1kaK2ZPgHC6Mwkv+W+1NuN9lNwO1dfOo9+saFDpvFiKRHa4oN
         wBHRNi6joXRY+iA7tqNeVuuWzM4J3b1MoG+mtKm12UiGdDHPbeq6Vii4tOENPQZkwEyv
         lCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739236404; x=1739841204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/4kyFy0V3h03WacXSIZutPcczKKCLp5PGS4mu0fqU8=;
        b=LAkEeggfB3N64JYo/Rte1KAVuAsK6Xf/SGM3VkBlGTmw7V1k4vSWmGEENzQJh0uwY0
         3pwzirQHRHMjs9PfAMmXTZGBegUQ6ETRuSwjpUO+jCsROIDoWx4G494Zis/WT2hqHaAq
         p9pMuDs33PI4PbfAu0ljyodkJtNEHeXbAnmaK4WrD2pni82cfZFvNScHVfV9u2fGikDC
         mvpleZF6n7l8smOI1ClHv6sD1kATGeN2xa/kFmolSsW7CYGTMdRY/aAKVBHXrbb4PghI
         u3T33RZID776cGUJqhZimWwKm/8nfa8kET2wWFjiLH0hLiLvNym5MIIlyKgOCkaQCKgd
         YvGQ==
X-Gm-Message-State: AOJu0YyF2XNxF+b2yjpk/801bQ65JC8HxehXTTt+sXuRM60AfK/Xsks/
	PenBqEeXO2vFpRORdIIMgoFG74aB8bwE72ZOH/nMd/UwjK50+67tS2On8D9M3n0j2Ml9SG+jmot
	PEzDDUmVLvjEpbRrLwIIGvy3O3qw=
X-Gm-Gg: ASbGncv/t+v9upl+uSzFQuDbzD/UTSG+mA23FGDUpulT+2lsyfEI6NcyRlI8kdsyYG4
	ypHBh6v67FA3ulPCvhCTdH2mqqJ/pKMq/JkCZBCMGsIdNUDRKMN60h9hxzxxZK5sNAjVB92laGE
	4kUnT64pYevL/f
X-Google-Smtp-Source: AGHT+IG1x2n5rnis0zQ1kr9Vzr9FhvKvhdjOZXVXjCMTI1LgeLarRSumCLN27BrMmiNUV6zJ6STe5rw/yuIZ9oiG4kY=
X-Received: by 2002:a17:90b:2888:b0:2f5:88bb:12f with SMTP id
 98e67ed59e1d1-2fa24177731mr21620845a91.21.1739236403808; Mon, 10 Feb 2025
 17:13:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210135129.719119-1-mykyta.yatsenko5@gmail.com> <20250210135129.719119-2-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250210135129.719119-2-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 10 Feb 2025 17:13:12 -0800
X-Gm-Features: AWEUYZn0BDPtQWO-zI5cBrstOiJrpULiUX5dLat7eJaXxrkcnfUXXuAnCoezOaI
Message-ID: <CAEf4BzYVWSogUYk8pEPGs0N4eNb5fcXtmFMLkicokmqHPpbZCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: implement setting global
 variables in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 5:51=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> To better verify some complex BPF programs we'd like to preset global
> variables.
> This patch introduces CLI argument `--set-global-vars` or `-G` to
> veristat, that allows presetting values to global variables defined
> in BPF program. For example:
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
> ./veristat wq.bpf.o  -G "a =3D 0" -G "b =3D 1" -G "c =3D 2" -G "d =3D 3"
> ```
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 319 ++++++++++++++++++++++++-
>  1 file changed, 307 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index 06af5029885b..b4521ebb6e6a 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -154,6 +154,15 @@ struct filter {
>         bool abs;
>  };
>
> +struct var_preset {
> +       char *name;
> +       enum { INTEGRAL, NAME } type;
> +       union {
> +               long long ivalue;
> +               char *svalue;
> +       };
> +};
> +
>  static struct env {
>         char **filenames;
>         int filename_cnt;
> @@ -195,6 +204,8 @@ static struct env {
>         int progs_processed;
>         int progs_skipped;
>         int top_src_lines;
> +       struct var_preset *presets;
> +       int npresets;
>  } env;
>
>  static int libbpf_print_fn(enum libbpf_print_level level, const char *fo=
rmat, va_list args)
> @@ -246,12 +257,16 @@ static const struct argp_option opts[] =3D {
>         { "test-reg-invariants", 'r', NULL, 0,
>           "Force BPF verifier failure on register invariant violation (BP=
F_F_TEST_REG_INVARIANTS program flag)" },
>         { "top-src-lines", 'S', "N", 0, "Emit N most frequent source code=
 lines" },
> +       { "set-global-vars", 'G', "GLOBALS", 0, "Set global variables pro=
vided in the expression, for example \"var1 =3D 1\"" },
>         {},
>  };
>
>  static int parse_stats(const char *stats_str, struct stat_specs *specs);
>  static int append_filter(struct filter **filters, int *cnt, const char *=
str);
>  static int append_filter_file(const char *path);
> +static int parse_var_presets(char *expr, struct var_preset **presets, in=
t *capacity, int *size);
> +static int parse_var_presets_from_file(const char *filename, struct var_=
preset **presets,
> +                                      int *capacity, int *size);

nit: append_filter vs append_filter_file would imply this should be
parse_var_presets vs parse_var_presets_file, no?

>
>  static error_t parse_arg(int key, char *arg, struct argp_state *state)
>  {
> @@ -363,6 +378,24 @@ static error_t parse_arg(int key, char *arg, struct =
argp_state *state)
>                         return -ENOMEM;
>                 env.filename_cnt++;
>                 break;
> +       case 'G': {
> +               static int presets_cap;
> +               char *expr =3D strdup(arg);
> +
> +               if (expr[0] =3D=3D '@') {
> +                       if (parse_var_presets_from_file(expr + 1, &env.pr=
esets,
> +                                                       &presets_cap, &en=
v.npresets)) {
> +                               fprintf(stderr, "Could not parse global v=
ariables preset: %s\n",
> +                                       arg);
> +                               argp_usage(state);
> +                       }
> +               } else if (parse_var_presets(expr, &env.presets, &presets=
_cap, &env.npresets)) {
> +                       fprintf(stderr, "Could not parse global variables=
 preset: %s\n", arg);
> +                       argp_usage(state);
> +               }
> +               free(expr);
> +               break;
> +       }

Can you please follow the append_filter pattern here? Consistency is
good. I don't think we want presets_cap and expr here as well. Don't
micro-optimize, it's ok to call realloc() for each entry for
non-performance critical code. Internally libc won't really reallocate
every single time.

>         default:
>                 return ARGP_ERR_UNKNOWN;
>         }
> @@ -1292,6 +1325,273 @@ static int process_prog(const char *filename, str=
uct bpf_object *obj, struct bpf
>         return 0;
>  };
>
> +static int parse_var_presets(char *expr, struct var_preset **presets, in=
t *capacity, int *size)
> +{
> +       char *eq_ptr =3D strchr(expr, '=3D');
> +       char *name_ptr =3D expr;
> +       char *name_end =3D eq_ptr - 1;
> +       char *val_ptr =3D eq_ptr + 1;
> +       long long value;
> +
> +       if (!eq_ptr) {
> +               fprintf(stderr, "No assignment in expression\n");
> +               return -EINVAL;
> +       }
> +
> +       while (isspace(*name_ptr))
> +               ++name_ptr;
> +       while (isspace(*name_end))
> +               --name_end;
> +       while (isspace(*val_ptr))
> +               ++val_ptr;

here's  a pro tip: scanf() is pretty useful and powerful parser for
simple stuff. scanf(" %s =3D %[^\n]\n") will trim spaces around variable
name and equality and will capture the rest of string. Or if you do "
%s =3D %s\n" it will trim spaces and do the right thing as long as we
don't expect whitespace to be valid value (we can start there for now,
because it's true for integers and enums)

> +
> +       if (name_ptr > name_end) {
> +               fprintf(stderr, "Empty variable name in expression %s\n",=
 expr);
> +               return -EINVAL;
> +       }
> +
> +       if (*size >=3D *capacity) {
> +               *capacity =3D max(*capacity * 2, 1);
> +               *presets =3D realloc(*presets, *capacity * sizeof(**prese=
ts));
> +       }
> +

as I mentioned above, don't bother optimizing and keeping track of
capacity, just realloc() every single time, it's fine

> +       if (isalpha(*val_ptr)) {
> +               char *value_end =3D val_ptr + strlen(val_ptr) - 1;
> +
> +               while (isspace(*value_end))
> +                       --value_end;
> +               *(value_end + 1) =3D '\0';
> +
> +               (*presets)[*size].svalue =3D strdup(val_ptr);
> +               (*presets)[*size].type =3D NAME;
> +       } else if (*val_ptr =3D=3D '-' || isdigit(*val_ptr)) {
> +               errno =3D 0;
> +               value =3D strtoll(val_ptr, NULL, 0);
> +               if (errno =3D=3D ERANGE) {
> +                       errno =3D 0;
> +                       value =3D strtoull(val_ptr, NULL, 0);
> +               }
> +               (*presets)[*size].ivalue =3D value;
> +               (*presets)[*size].type =3D INTEGRAL;
> +               if (errno) {
> +                       fprintf(stderr, "Could not parse integer value %s=
\n", val_ptr);
> +                       return -EINVAL;
> +               }
> +       } else {
> +               fprintf(stderr, "Could not parse value %s\n", val_ptr);
> +               return -EINVAL;
> +       }
> +       *(name_end + 1) =3D '\0';
> +       (*presets)[*size].name =3D strdup(name_ptr);
> +       (*size)++;

... maybe let's do something simpler and dumber? Try to parse provided
string as integer, if it succeeds (and consumes entire string) --
great, if not -- assume it's enum or true/false (if you support that)?

btw, see scanf()'s %i modifier, it can parse both hex and dec numbers.
You can just try with '-' and without.

Basically, let's keep it straightforward, even if it's, technically
speaking, suboptimal performance-wise.

> +       return 0;
> +}
> +
> +static int parse_var_presets_from_file(const char *filename, struct var_=
preset **presets,
> +                                      int *capacity, int *size)
> +{
> +       FILE *f;
> +       char line[256];
> +       int err =3D 0;
> +
> +       f =3D fopen(filename, "rt");
> +       if (!f) {
> +               fprintf(stderr, "Could not open file %s\n", filename);
> +               return -EINVAL;
> +       }
> +
> +       while (fgets(line, sizeof(line), f)) {
> +               int err =3D parse_var_presets(line, presets, capacity, si=
ze);
> +
> +               if (err)
> +                       goto cleanup;
> +       }
> +
> +cleanup:
> +       fclose(f);
> +       return err;
> +}

see append_filter_file(), we do similar stuff there, keep it consistent

> +
> +static bool is_signed_type(const struct btf_type *t)
> +{
> +       if (btf_is_int(t))
> +               return btf_int_encoding(t) & BTF_INT_SIGNED;
> +       if (btf_is_enum(t))
> +               return btf_kflag(t);

there is also enum64, use btf_is_any_enum()

> +       return true;
> +}
> +
> +static int enum_value_from_name(const struct btf *btf, const struct btf_=
type *t,
> +                               const char *evalue, long long *retval)
> +{
> +       if (btf_is_enum(t)) {
> +               struct btf_enum *e =3D btf_enum(t);
> +               int i, n =3D btf_vlen(t);
> +
> +               for (i =3D 0; i < n; ++i) {
> +                       const char *cur_name =3D btf__name_by_offset(btf,=
 e[i].name_off);
> +
> +                       if (strcmp(cur_name, evalue) =3D=3D 0) {
> +                               *retval =3D e[i].val;
> +                               return 0;
> +                       }
> +               }
> +       } else if (btf_is_enum64(t)) {
> +               struct btf_enum64 *e =3D btf_enum64(t);
> +               int i, n =3D btf_vlen(t);
> +
> +               for (i =3D 0; i < n; ++i) {
> +                       struct btf_enum64 *cur =3D e + i;
> +                       const char *cur_name =3D btf__name_by_offset(btf,=
 cur->name_off);

you have two conceptually identical loops, but in one you do `cur =3D e
+ i` and in another you do `e[i]` access... why?

> +                       __u64 value =3D  btf_enum64_value(cur);
> +
> +                       if (strcmp(cur_name, evalue) =3D=3D 0) {
> +                               *retval =3D value;
> +                               return 0;
> +                       }
> +               }
> +       }
> +       return -EINVAL;
> +}
> +
> +static bool is_preset_supported(const struct btf_type *t)
> +{
> +       return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
> +}
> +
> +static int set_global_var(struct bpf_object *obj, struct btf *btf, const=
 struct btf_type *t,
> +                         struct bpf_map *map, struct btf_var_secinfo *si=
nfo,
> +                         struct var_preset *preset)
> +{
> +       const struct btf_type *base_type;
> +       void *ptr;
> +       size_t size;
> +
> +       base_type =3D btf__type_by_id(btf, btf__resolve_type(btf, t->type=
));
> +       if (!base_type) {
> +               fprintf(stderr, "Could not resolve type %d\n", t->type);
> +               return -EINVAL;
> +       }
> +       if (!is_preset_supported(base_type)) {
> +               fprintf(stderr, "Setting global variable for btf kind %d =
is not supported\n",
> +                       btf_kind(base_type));
> +               return -EINVAL;
> +       }
> +
> +       if (preset->type =3D=3D NAME && btf_is_any_enum(base_type)) {
> +               /* Convert enum element name into integer */
> +               long long ivalue;
> +
> +               if (enum_value_from_name(btf, base_type, preset->svalue, =
&ivalue) !=3D 0) {
> +                       fprintf(stderr, "Could not find integer value for=
 enum element %s\n",
> +                               preset->svalue);
> +                       return -EINVAL;
> +               }
> +               free(preset->svalue);
> +               preset->ivalue =3D ivalue;
> +               preset->type =3D INTEGRAL;

but for different object file this value can change? You can cache for
the same BTF, but once BTF changes, you'll have to recalculate it (I'd
keep it simple and look it up every single time, for now)

> +       }
> +
> +       /* Check if value fits into the target variable size */
> +       if  (sinfo->size < sizeof(preset->ivalue)) {
> +               bool is_signed =3D is_signed_type(base_type);
> +               __u32 unsigned_bits =3D sinfo->size * 8 - (is_signed ? 1 =
: 0);
> +               long long max_val =3D 1ll << unsigned_bits;

what about u64? 1 << 64 ?

> +
> +               if (preset->ivalue >=3D max_val || preset->ivalue < -max_=
val) {
> +                       fprintf(stderr,
> +                               "Variable %s value %lld is out of range [=
%lld; %lld]\n",
> +                               btf__name_by_offset(btf, t->name_off), pr=
eset->ivalue,
> +                               is_signed ? -max_val : 0, max_val - 1);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       ptr =3D (void *)bpf_map__initial_value(map, &size);
> +       if (!ptr || (sinfo->offset + sinfo->size > size))
> +               return -EINVAL;
> +
> +       if (__BYTE_ORDER =3D=3D __LITTLE_ENDIAN) {
> +               memcpy(ptr + sinfo->offset, &preset->ivalue, sinfo->size)=
;
> +       } else if (__BYTE_ORDER =3D=3D __BIG_ENDIAN) {
> +               __u8 src_offset =3D sizeof(preset->ivalue) - sinfo->size;
> +
> +               memcpy(ptr + sinfo->offset, (void *)&preset->ivalue + src=
_offset, sinfo->size);
> +       }
> +       return 0;
> +}
> +
> +static int set_global_vars(struct bpf_object *obj, struct var_preset *pr=
esets, int npresets)
> +{
> +       struct btf_var_secinfo *sinfo;
> +       const char *sec_name;
> +       const struct btf_type *type;
> +       struct bpf_map *map;
> +       struct btf *btf;
> +       bool *set_var;
> +       int i, j, k, n, cnt, err =3D 0;
> +
> +       if (npresets =3D=3D 0)
> +               return 0;
> +
> +       btf =3D bpf_object__btf(obj);
> +       if (!btf)
> +               return -EINVAL;
> +
> +       set_var =3D calloc(npresets, sizeof(bool));
> +       for (i =3D 0; i < npresets; ++i)
> +               set_var[i] =3D false;

calloc() is zero-initializing, no need to set to false

> +
> +       cnt =3D btf__type_cnt(btf);
> +       for (i  =3D 0; i !=3D cnt; ++i) {

double space

> +               type =3D btf__type_by_id(btf, i);

nit: type -> t, we use that convention when working with BTF types
quite consistently (btw, zero is always VOID, so you can always skip
it with `i =3D 1`)

> +
> +               if (!btf_is_datasec(type))
> +                       continue;
> +
> +               sinfo =3D btf_var_secinfos(type);
> +               sec_name =3D btf__name_by_offset(btf, type->name_off);
> +               map =3D bpf_object__find_map_by_name(obj, sec_name);
> +               if (!map)
> +                       continue;
> +
> +               n =3D btf_vlen(type);
> +               for (j =3D 0; j < n; ++j, ++sinfo) {
> +                       const struct btf_type *var_type =3D btf__type_by_=
id(btf, sinfo->type);
> +                       const char *var_name =3D btf__name_by_offset(btf,=
 var_type->name_off);

it's kind of bad style, IMO, to look something up for
var_type->name_off before you are sure it's what you care about
(btf_is_var()), move assignment to after the if?

> +
> +                       if (!btf_is_var(var_type))
> +                               continue;
> +
> +                       for (k =3D 0; k < npresets; ++k) {
> +                               if (strcmp(var_name, presets[k].name) !=
=3D 0)
> +                                       continue;
> +
> +                               if (set_var[k]) {

maybe just have an extra counter in preset itself, which you can clear
between BPF program loads? Less trouble with extra dynamic memory
allocation

> +                                       fprintf(stderr, "Variable %s is s=
et more than once",
> +                                               var_name);

I'd error out in this case, tbh (it's either user error or static
global variables, which I'm sure is unintentional in 99% of cases)

> +                               }
> +
> +                               err =3D set_global_var(obj, btf, var_type=
, map, sinfo, presets + k);
> +                               if (err)
> +                                       goto out;
> +
> +                               set_var[k] =3D true;
> +                               break;
> +                       }
> +               }
> +       }
> +       for (i =3D 0; i < npresets; ++i) {
> +               if (!set_var[i]) {
> +                       fprintf(stderr, "Global variable preset %s has no=
t been applied\n",
> +                               presets[i].name);
> +               }
> +       }
> +out:
> +       free(set_var);
> +       return err;
> +}
> +
>  static int process_obj(const char *filename)
>  {
>         const char *base_filename =3D basename(strdupa(filename));
> @@ -1299,7 +1599,7 @@ static int process_obj(const char *filename)
>         struct bpf_program *prog, *tprog, *lprog;
>         libbpf_print_fn_t old_libbpf_print_fn;
>         LIBBPF_OPTS(bpf_object_open_opts, opts);
> -       int err =3D 0, prog_cnt =3D 0;
> +       int err =3D 0;
>
>         if (!should_process_file_prog(base_filename, NULL)) {
>                 if (env.verbose)
> @@ -1334,17 +1634,6 @@ static int process_obj(const char *filename)
>
>         env.files_processed++;
>
> -       bpf_object__for_each_program(prog, obj) {
> -               prog_cnt++;
> -       }
> -
> -       if (prog_cnt =3D=3D 1) {
> -               prog =3D bpf_object__next_program(obj, NULL);
> -               bpf_program__set_autoload(prog, true);
> -               process_prog(filename, obj, prog);
> -               goto cleanup;
> -       }
> -

I think this was an optimization to avoid a heavy-weight ELF parsing
twice, why would we want to remove it?..

pw-bot: cr

>         bpf_object__for_each_program(prog, obj) {
>                 const char *prog_name =3D bpf_program__name(prog);
>
> @@ -1355,6 +1644,12 @@ static int process_obj(const char *filename)
>                         goto cleanup;
>                 }
>
> +               err =3D set_global_vars(tobj, env.presets, env.npresets);
> +               if (err) {
> +                       fprintf(stderr, "Failed to set global variables\n=
");
> +                       goto cleanup;
> +               }
> +
>                 lprog =3D NULL;
>                 bpf_object__for_each_program(tprog, tobj) {
>                         const char *tprog_name =3D bpf_program__name(tpro=
g);
> --
> 2.48.1
>

