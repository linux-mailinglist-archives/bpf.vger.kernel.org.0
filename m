Return-Path: <bpf+bounces-52469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB70CA431EB
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 01:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C338188F38C
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 00:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7612F1853;
	Tue, 25 Feb 2025 00:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfBzX809"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEA7D299
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 00:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740443921; cv=none; b=rBvibcW22ZemYec4pZ4yaYP6DhkkiGag1/TdfeTlbUhC0l0ya0pDGODxM2yR8KjrikeVli4aiOzChAQuvR0BAASEuAuMRBpOAHQZh0zd385HW9XbNuZxI4Q/wgVT0JcjCec1nqUQopHsKKOiNWbz81IKl+f+4AWQ+MEiqE0R1K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740443921; c=relaxed/simple;
	bh=K+STWoHaEhFX55c/9hKIaKXCsAqYVKRgocjEBwBbFA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADXD7w7PuTXHZNOMWoygLlrEj64IA/ksHcE2PvY7swqjklZ98obHrtdlRFBERvaWRBdyKRqUQ/IJ4TOzGqPRyB5uNXhlooOuuZD8e1J7Wt2g4KQnl12mhrPQJMo/tes/OmiJpXfl3VaMs2OF4oQplN2NTDLbvw1oGfirDL1z928=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfBzX809; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fc042c9290so7801165a91.0
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 16:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740443918; x=1741048718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3Y2oSjYZWwr/bek+yvdDGNvwx7n5G2rKnXktmZObZQ=;
        b=XfBzX809f4VT0YMT5qxX0WdT5SQehAhenqoPDcuJqNu91UUYaTKjaLh5m4LlDPlZJx
         IjO4UcQ8Q0T+qFJX1n4Nk1SUG0wlDaYjVhwCy+0/EazKJuxE9Vg7uAVd4O7ulrW70+6y
         RSki/JUslpu0yVgzXFfGwC+TjvDFN8qe7VYiU+sZFJos7D7OPCw17yyNjtgCkIdpJ+Ho
         3AwrBrBQoKc+vqdsR54Aiio2CQeiHtqNDCUionWpRwAEKMUfY4n6P/AZXSb5d8oZYrmE
         m9XwB/Z4P2xuPVgMyZyK97DiSBuiXClNWbD0/c2wbPMo/WpTeOgZ48a+Hmvkw08uV8nn
         sqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740443918; x=1741048718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3Y2oSjYZWwr/bek+yvdDGNvwx7n5G2rKnXktmZObZQ=;
        b=DmQZLL2LoRHAOUmQPpjfou3oOGpbO2w5n0pLkHtM8p/ZB+4mVm5EidF8atayeclFem
         K5qOx9GmsWeDnxGz7BuOUWuJLmlAisTA3p4OSVQQprzHpNy7WLEPOSXzLYtbIXT4FOkO
         IxTdemj2yXWVNcZV060xaCPmOZbwqTqHeLovsx4U/75V3qkuQVO7aM3FI9r1gPCxO59H
         0wCIa178+yEwNPbkAXCs2Dadm5LBtsb8f6dscpsz+Z4FcpsVVylwkt/XlttDU0PZ7qfX
         0sgNSzhs2IotCoiRJiZBvLAsoanLulXruYDdhc223xcseHMI58Gs3pJ2gZ9LpViQWee1
         VupA==
X-Gm-Message-State: AOJu0Ywf9OdAXo4nZX69NYT9VRecE1TLnYaDY0AYj7hi7ik8Azz8XhS7
	ulM6uZTRjdSWgNAPuZRlaXLvcYSSP6/nRAl05tctllnL1dnx32XrKcunGRlcqB4rBzPNIZJyR1z
	AObB+etKrfce++pELhDowsw04U6w=
X-Gm-Gg: ASbGnctClcYv1vmIQ+hRaAaVfIJNE+mpFNO+g4mCEXwEpXXZO14ohzCQYUDqf1MjvgK
	AP6TecqEzUkrZTAi1dTIobeGzxF2zHF4L6QOA2Juj1fW+33BQtx7V2pwU9YTZD/Tu1oRI95bYN4
	w458Tpp40vVKVfMkKlZa+Gg9c=
X-Google-Smtp-Source: AGHT+IF1QTZ3A/oQrdXvALD47LIDDPUiwGaEeMBUTYj/ly1cR/TN3Ml42SouQAmEMsWSvccLNAEFYhNsX2sshVnnxeA=
X-Received: by 2002:a17:90b:53ce:b0:2ee:dd9b:e402 with SMTP id
 98e67ed59e1d1-2fce789bbc2mr29075232a91.12.1740443918489; Mon, 24 Feb 2025
 16:38:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221223259.677471-1-mykyta.yatsenko5@gmail.com> <20250221223259.677471-2-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250221223259.677471-2-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Feb 2025 16:38:26 -0800
X-Gm-Features: AWEUYZnqysMAXdNAqM-kERYujup0zBDCyZomzZuYsniminm6CtLEl6TF0Rf-CBg
Message-ID: <CAEf4Bza=-MJc8wAcG6_i9OOQEFs09OaAnEi1v5pFEntmFxTquA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] selftests/bpf: implement setting global
 variables in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 2:33=E2=80=AFPM Mykyta Yatsenko
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
>  tools/testing/selftests/bpf/veristat.c | 290 ++++++++++++++++++++++++-
>  1 file changed, 289 insertions(+), 1 deletion(-)
>

Just a few minor things below, but overall looks great!

> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index 06af5029885b..1e1bc0dfa50a 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -154,6 +154,16 @@ struct filter {
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
> +       bool applied;
> +};
> +
>  static struct env {
>         char **filenames;
>         int filename_cnt;
> @@ -195,6 +205,8 @@ static struct env {
>         int progs_processed;
>         int progs_skipped;
>         int top_src_lines;
> +       struct var_preset *presets;
> +       int npresets;
>  } env;
>
>  static int libbpf_print_fn(enum libbpf_print_level level, const char *fo=
rmat, va_list args)
> @@ -246,12 +258,15 @@ static const struct argp_option opts[] =3D {
>         { "test-reg-invariants", 'r', NULL, 0,
>           "Force BPF verifier failure on register invariant violation (BP=
F_F_TEST_REG_INVARIANTS program flag)" },
>         { "top-src-lines", 'S', "N", 0, "Emit N most frequent source code=
 lines" },
> +       { "set-global-vars", 'G', "GLOBALS", 0, "Set global variables pro=
vided in the expression, for example \"var1 =3D 1\"" },

GLOBAL (singular)

>         {},
>  };
>

[...]

> +static int append_var_preset(struct var_preset **presets, int *cnt, cons=
t char *expr)
> +{
> +       void *tmp;
> +       struct var_preset *cur;
> +       char var[256], val[256];
> +
> +       tmp =3D realloc(*presets, (*cnt + 1) * sizeof(**presets));
> +       if (!tmp)
> +               return -ENOMEM;
> +       *presets =3D tmp;
> +       cur =3D &(*presets)[*cnt];
> +       cur->applied =3D false;
> +
> +       if (sscanf(expr, "%s =3D %s\n", var, val) !=3D 2) {
> +               fprintf(stderr, "Could not parse expression %s\n", expr);
> +               return -EINVAL;
> +       }
> +
> +       if (isalpha(*val)) {

technically enum could be _WHATEVER, underscore is legal character

> +               cur->svalue =3D strdup(val);
> +               cur->type =3D NAME;

total nit, but NAME confused me a bit, as I assumed that the name of
the global variable. It's really just for enums, right? So ENUM or
ENUMERATOR would make sense and be more precise?

> +       } else if (*val =3D=3D '-' || isdigit(*val)) {

instead of doing this detection based on characters, why not try to
parse a number (and I'd use sscanf("%lli") which will handle 1234 and
0x1234 transparently)? And you can use %n to check that all characters
were parsed (i.e., you have exact match)

it's probably fine for starters, but it kind of sucks that 0x1234
isn't supported

> +               long long value;
> +
> +               errno =3D 0;
> +               value =3D strtoll(val, NULL, 0);
> +               if (errno =3D=3D ERANGE) {
> +                       errno =3D 0;
> +                       value =3D strtoull(val, NULL, 0);
> +               }
> +               cur->ivalue =3D value;
> +               cur->type =3D INTEGRAL;
> +               if (errno) {
> +                       fprintf(stderr, "Could not parse integer value %s=
\n", val);
> +                       return -EINVAL;
> +               }
> +       } else {
> +               fprintf(stderr, "Could not parse value %s\n", val);
> +               return -EINVAL;
> +       }
> +       cur->name =3D strdup(var);

check for NULL and error out? (no need for logging message, it's rare
to get ENOMEM)

pw-bot: cr

> +       (*cnt)++;
> +       return 0;
> +}
> +

[...]

> +       /* Check if value fits into the target variable size */
> +       if  (sinfo->size < sizeof(value)) {
> +               bool is_signed =3D is_signed_type(base_type);
> +               __u32 unsigned_bits =3D sinfo->size * 8 - (is_signed ? 1 =
: 0);
> +               long long max_val =3D 1ll << unsigned_bits;
> +
> +               if (value >=3D max_val || value < -max_val) {
> +                       fprintf(stderr,
> +                               "Variable %s value %lld is out of range [=
%lld; %lld]\n",
> +                               btf__name_by_offset(btf, t->name_off), va=
lue,
> +                               is_signed ? -max_val : 0, max_val - 1);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       ptr =3D (void *)bpf_map__initial_value(map, &size);

it already returns void *, no need to cast

> +       if (!ptr || (sinfo->offset + sinfo->size > size))

nit: unnecessary ()

> +               return -EINVAL;
> +
> +       if (__BYTE_ORDER =3D=3D __LITTLE_ENDIAN) {
> +               memcpy(ptr + sinfo->offset, &value, sinfo->size);
> +       } else if (__BYTE_ORDER =3D=3D __BIG_ENDIAN) {

either this if condition is superficial, or we'd need to add another
else with error. let's just

} else { /* __BYTE_ORDER =3D=3D __BIG_ENDIAN */
   memcpy()
}

?

> +               __u8 src_offset =3D sizeof(value) - sinfo->size;
> +
> +               memcpy(ptr + sinfo->offset, (void *)&value + src_offset, =
sinfo->size);
> +       }
> +       return 0;
> +}
> +

[...]

>  static int process_obj(const char *filename)
>  {
>         const char *base_filename =3D basename(strdupa(filename));
> @@ -1341,6 +1612,11 @@ static int process_obj(const char *filename)
>         if (prog_cnt =3D=3D 1) {
>                 prog =3D bpf_object__next_program(obj, NULL);
>                 bpf_program__set_autoload(prog, true);
> +               err =3D set_global_vars(obj, env.presets, env.npresets);
> +               if (err) {
> +                       fprintf(stderr, "Failed to set global variables\n=
");

emit error code to help with debugging in the future? same below

> +                       goto cleanup;
> +               }
>                 process_prog(filename, obj, prog);
>                 goto cleanup;
>         }

[...]

