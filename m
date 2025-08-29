Return-Path: <bpf+bounces-67037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 204E8B3C3E1
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 22:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF15D7A5EB3
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 20:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB1934572B;
	Fri, 29 Aug 2025 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHqw84r+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB64230BDF
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 20:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756500133; cv=none; b=ltH3GEvWcKo0aZUMbQ9FQJOUaFIbfFp5Rc6ITncnfim1k6V2TgZM1CN/xSYaWQWacK3FLwNxNJaSOa4Z3XLlvi3ASrq1EkdA4OAZ7XVs1VzQqJ3hm7NPBFezlz0h1OQBVKJwJIxV8CMrTBytnHtCWJ7IdedMU5AosLueMvKDHF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756500133; c=relaxed/simple;
	bh=6sHlUURYN/rsVgpBc3LrLKrzSI3Zva6iZT2MHkjDWUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UirhV/7VQ44CT+wPEHqqvrzcqQI7/5YDa6tksVFnF+6wjvp1W13B2vkf10uCw7envxaR1Dp8U6JePr4Z3uK7iCL1QWdJAx4cizf7qObKVoTO7pHnLDOvhkHiAcPR5PbCeNlDwohSnexSy5KOWKiD8wrIB5fq0sZed1ag9tQwaDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHqw84r+; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-327e5b65e2cso1009285a91.2
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 13:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756500131; x=1757104931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdECKRoJ/60gjrc6+jHAOBLm7vZXt2z8X4HFix0s9lE=;
        b=DHqw84r+hLZtsN8Ahtjvwft6jY2H2uY1MINK3Nh8kJ2diquJQdLuO47+nqXshwvGua
         yKNvUm3HPmWEMJZvWpDldZgifTANRLqC3Cavx2/T2uh+YdE0H2Gm5gwn3z2oA/5Vx/du
         xd7NWoVqD0ihUcR6e7OY0nk+MDN/tjlapg94qstK2NutT+HTpQ05Kr1bGoNysPYO/DHw
         ZDNI1qKMabu2CHaJaoUoV3mPVdfnHj5jHqHXpWS8wmW5F7kZYQlays05WNHHU1w+Ccs9
         d1X/lSwtdJtKZr2SRAKTjUwfUizaYP2G0AZZ0rVoResSqWQ3VJGqzTWbcvByUgHjrjUS
         jQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756500131; x=1757104931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdECKRoJ/60gjrc6+jHAOBLm7vZXt2z8X4HFix0s9lE=;
        b=NMEsm9qsq8B61I+tid0hn1IQRcUc/kiSFBAhdCW20aNLNDRN/sLVFf7yhQrorY+bm8
         wOUW+NggNT0z9pLsA1xPDfaIb1tZzlSe3WaRLTZ+PtFxUfRvcofNWCOMMrffR27v+AU3
         xLnXu+TA+H5KD3Qf1aJwzdzWjt3QXu3HrvJiBz+5+dT9aNyfRYgpIWcb6B9vMKbC6/NC
         HO6+hRhMVsxS1b6zCyouOPzYmCB0y2zrN+ZE7+GORHv1PTP5ppNEUFjxHtDruldKfSZV
         tMKk52jnAjJCRmDODLb1iKRPOYLPvjFwvSgAb6ZC6yX8uz7yuHzCowAjjDp01LtX8g4h
         mJzw==
X-Gm-Message-State: AOJu0YyP6TTWUpn0nW/BemFx50o8vGKsLy7RdMnzxWtDTAug/QJXPa3l
	W6JMk0CT/7hgFqGHI0914yTriuLujjmqeZh1xJO+92AFOa/kY5AL9R+yBnczDTZBuhvE1b/JzGQ
	LdChZmnrVZgBq+eYVNp1VMsL8ytYSHTyMX4YS
X-Gm-Gg: ASbGncvVnLdbjzRctYuPnMF1Y5xIoijWG96ovWt4P6fyFTBdIIAatgVB6eCERss8P2F
	tAMHorjwg9Zw/dIppkTFStXy74rjSowxakyw77borJllTYtus+oi1C68Zj87T7AE7PfjMhnu3KZ
	h+Lzx7T455TQXiGO4DLoCXNF4+3WkuapGZkIm/SUX6yy4Fv3Qx1MJrSWa4FFha616caHWx9JHKd
	LKG7fcyE5CHB/zsFRsRtsk=
X-Google-Smtp-Source: AGHT+IHC796xCh1pVc1iw8mUB+9npjZZXgpPVNTg8iaOxo/lsREeyg57oBSgHXm8p1GaaNkedewx20km3o/atbTJx44=
X-Received: by 2002:a17:90b:55c7:b0:327:ba77:a47 with SMTP id
 98e67ed59e1d1-327ba770aaemr11505174a91.15.1756500131268; Fri, 29 Aug 2025
 13:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829132813.105149-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250829132813.105149-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Aug 2025 13:41:56 -0700
X-Gm-Features: Ac12FXy2M_7QfhhA0gP4C_5W-0LSYERg7hLuW_629dFn1SIwwx5XApBtrd3mFuE
Message-ID: <CAEf4BzZ9uw6FtjVsTh7Vsa-GBvyzji7=JxDrV4cfbfKMnFiqZg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] selftests/bpf: add BPF program dump in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 6:28=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add the ability to dump BPF program instructions directly from veristat.
> Previously, inspecting a program required separate bpftool invocations:
> one to load and another to dump it, which meant running multiple
> commands.
> During active development, it's common for developers to use veristat
> for testing verification. Integrating instruction dumping into veristat
> reduces the need to switch tools and simplifies the workflow.
> By making this information more readily accessible, this change aims
> to streamline the BPF development cycle and improve usability for
> developers.
> This implementation leverages bpftool, by running it directly via popen
> to avoid any code duplication and keep veristat simple.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 75 +++++++++++++++++++++++++-
>  1 file changed, 74 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index d532dd82a3a8..c824f6e72e2f 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -181,6 +181,12 @@ struct var_preset {
>         bool applied;
>  };
>
> +enum dump_mode {
> +       DUMP_NONE =3D 0,
> +       DUMP_XLATED =3D 1,
> +       DUMP_JITED =3D 2,
> +};
> +
>  static struct env {
>         char **filenames;
>         int filename_cnt;
> @@ -227,6 +233,7 @@ static struct env {
>         char orig_cgroup[PATH_MAX];
>         char stat_cgroup[PATH_MAX];
>         int memory_peak_fd;
> +       __u32 dump_mode;
>  } env;
>
>  static int libbpf_print_fn(enum libbpf_print_level level, const char *fo=
rmat, va_list args)
> @@ -271,6 +278,7 @@ const char argp_program_doc[] =3D
>  enum {
>         OPT_LOG_FIXED =3D 1000,
>         OPT_LOG_SIZE =3D 1001,
> +       OPT_DUMP =3D 1002,
>  };
>
>  static const struct argp_option opts[] =3D {
> @@ -295,10 +303,12 @@ static const struct argp_option opts[] =3D {
>           "Force BPF verifier failure on register invariant violation (BP=
F_F_TEST_REG_INVARIANTS program flag)" },
>         { "top-src-lines", 'S', "N", 0, "Emit N most frequent source code=
 lines" },
>         { "set-global-vars", 'G', "GLOBAL", 0, "Set global variables prov=
ided in the expression, for example \"var1 =3D 1\"" },
> +       { "dump", OPT_DUMP, "DUMP_MODE", OPTION_ARG_OPTIONAL, "Print BPF =
program dump (xlated, jited)" },
>         {},
>  };
>
>  static int parse_stats(const char *stats_str, struct stat_specs *specs);
> +static int parse_dump_mode(char *mode_str, __u32 *dump_mode);
>  static int append_filter(struct filter **filters, int *cnt, const char *=
str);
>  static int append_filter_file(const char *path);
>  static int append_var_preset(struct var_preset **presets, int *cnt, cons=
t char *expr);
> @@ -427,6 +437,11 @@ static error_t parse_arg(int key, char *arg, struct =
argp_state *state)
>                         return err;
>                 }
>                 break;
> +       case OPT_DUMP:
> +               err =3D parse_dump_mode(arg, &env.dump_mode);
> +               if (err)
> +                       return err;
> +               break;
>         default:
>                 return ARGP_ERR_UNKNOWN;
>         }
> @@ -956,6 +971,32 @@ static int parse_stats(const char *stats_str, struct=
 stat_specs *specs)
>         return 0;
>  }
>
> +static int parse_dump_mode(char *mode_str, __u32 *dump_mode)
> +{
> +       char *state =3D NULL, *cur;
> +       int cnt =3D 0;
> +
> +       if (!mode_str) {
> +               env.dump_mode =3D DUMP_XLATED;
> +               return 0;
> +       }
> +
> +       for (cur =3D mode_str; *cur; ++cur)
> +               *cur =3D tolower(*cur);
> +
> +       while ((cur =3D strtok_r(cnt++ ? NULL : mode_str, ",", &state))) =
{

there is no need to parse comma-separated list, it is allowed to
specify the same CLI flag multiple times, so we can use that to
accumulate multiple modes:

--dump=3Dxlated --dump=3Djited


this will do the trick, so keep it simple.

And then you don't need to do tolower(), you can just strcasecmp() against =
arg

pw-bot: cr

> +               if (strcmp(cur, "jited") =3D=3D 0) {
> +                       env.dump_mode |=3D DUMP_JITED;
> +               } else if (strcmp(cur, "xlated") =3D=3D 0) {
> +                       env.dump_mode |=3D DUMP_XLATED;
> +               } else {
> +                       fprintf(stderr, "Unrecognized dump mode '%s'\n", =
cur);
> +                       return -EINVAL;
> +               }
> +       }
> +       return 0;
> +}
> +
>  static void free_verif_stats(struct verif_stats *stats, size_t stat_cnt)
>  {
>         int i;
> @@ -1554,6 +1595,35 @@ static int parse_rvalue(const char *val, struct rv=
alue *rvalue)
>         return 0;
>  }
>
> +static void dump(__u32 prog_id, const char *file_name, const char *prog_=
name)
> +{
> +       char command[64], buf[1024];
> +       enum dump_mode modes[2] =3D { DUMP_XLATED, DUMP_JITED };
> +       const char *mode_lower[2] =3D { "xlated", "jited" };
> +       const char *mode_upper[2] =3D { "XLATED", "JITED" };

Instead of this, why don't we just pass desired mode as an argument,
and then just call dump(DUMP_XLATED) if env.dump_mode & DUMP_XLATED,
and similarly for DUMP_JITED. It's not like we'll have tons of
different dump modes, right?

> +       FILE *fp;
> +       int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(modes); ++i) {
> +               if (!(env.dump_mode & modes[i]))
> +                       continue;
> +               snprintf(command, sizeof(command), "bpftool prog dump %s =
id %u",
> +                        mode_lower[i], prog_id);

should we check if bpftool is installed first? I.e., run `which
bpftool` and check if that's successful? And if not, print some
user-friendly warning or error?

> +
> +               fp =3D popen(command, "r");
> +               if (!fp) {
> +                       fprintf(stderr, "Can't run bpftool\n");
> +                       return;
> +               }
> +
> +               printf("%s/%s DUMP %s:\n", file_name, prog_name, mode_upp=
er[i]);
> +               while (fgets(buf, sizeof(buf), fp))
> +                       printf("%s", buf);

nit: is there any advantage to using fgets+printf vs just binary-based
read/write? (and I'd probably make buf page sized)

> +               printf("\n");
> +               pclose(fp);
> +       }
> +}
> +
>  static int process_prog(const char *filename, struct bpf_object *obj, st=
ruct bpf_program *prog)
>  {
>         const char *base_filename =3D basename(strdupa(filename));
> @@ -1630,8 +1700,11 @@ static int process_prog(const char *filename, stru=
ct bpf_object *obj, struct bpf
>
>         memset(&info, 0, info_len);
>         fd =3D bpf_program__fd(prog);
> -       if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=
=3D 0)
> +       if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=
=3D 0) {
>                 stats->stats[JITED_SIZE] =3D info.jited_prog_len;
> +               if (env.dump_mode !=3D DUMP_NONE)
> +                       dump(info.id, base_filename, prog_name);
> +       }
>
>         parse_verif_log(buf, buf_sz, stats);
>
> --
> 2.51.0
>

