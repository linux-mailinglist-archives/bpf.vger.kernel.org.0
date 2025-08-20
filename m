Return-Path: <bpf+bounces-66113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E365EB2E791
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 23:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0013D1BC242C
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 21:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C6C334386;
	Wed, 20 Aug 2025 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhzLrNMU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC2F32A3C2
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 21:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755725685; cv=none; b=IIevMl44JwQLy9ZuttxhJUDEhV4yYm4nHbEwZVDaXhYHRSbqFJNQWFm79KaLmaUG2iR4Amj5Lutv/MlYdko5qBYPN+zEhFdXuXPpqpfx7zdsz/A1AU4ZTfNFN8d1oaj1OlRmwsvp5bOpx9stR7P1llmlwlew2v2ZxKbjefuxrDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755725685; c=relaxed/simple;
	bh=FG6Z222r7gQMKf2fpQAcdoaGRxghO+YiymhNNwJSm60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jswn9ZuKu7Bb5pn/kSkpC9N2BSfDkY0eAjb4Sa/JDXizE9zS9p09Qj1sIzfBFJqhNW0ZYQjx6D5NSTvPphi5lzZElTUxTj5exX/VZHJRY6dz6O8sVz8frS4FW/UbgVwLFhADlOAvOe9X43/IAiDsURuOcp96NU1n29uKZuQ7vHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhzLrNMU; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b476cfc2670so188283a12.3
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 14:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755725683; x=1756330483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXSyX9lPOwdCIa1GRoouP0j5lqhNFxH5u1WuPDJpx5I=;
        b=nhzLrNMUtSQPQ2iFjBzs/OpEACJ1RJZtV0YX+SqzSsnN54aKOMtVo5W4cwEW4rWzR+
         sfVb5g7KoGF6kHHAeXoOOfIHjAkU/ptSUoncEfYlNO+h1Y3wWEhmIiOd7KRw3C/v0i5H
         GNZqvclPCBpt4tZ5a1HTv3RfYvwxyQYGfNmEbyZkjn1JLivqy2Qj9/FSvgT/rU1tP08x
         9dBmWw0VZGaDgZ+69OuKDpzmFWr4k7xatsxYcJUdHuJrrju63IPXbK/8HBKk4MrzCGlh
         NWQ4Bz+eOxTCI3Q6cZI3TR+pv2TZgZlx2yMmfE9sWpa7caIdnd8IpVifDuZrndzF2x28
         sIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755725683; x=1756330483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXSyX9lPOwdCIa1GRoouP0j5lqhNFxH5u1WuPDJpx5I=;
        b=nVluH0OjWAJdhlnIbCq0TR+I1CffquhWHXcGZNBR7xe5ogmmOv908pCtXwt97lLGZ0
         6tCtl00bxILRZR09vxVekVkjK2zt9aOwJBUPQsVndkooSownRDqPY0BZaaLHiQQyQZow
         5id6uPuwzCoZOGA01nexZlulr0KQWIA4ABDFWSXdBhWcbECnbLqW8U6JfNMHE9lNzJAV
         mB4C8qvvf+LJWvKvt6CvFnJKg8AlwZmUKFApfAQFFAP6Up79P8rspvqBUaeaGnOm4lr5
         Gm7hC9szX4VKsx8nvjWgnecFlheUYHDvEb/Y6wqOtgSE2j4b4Qon9QZyLiPsAmIn3rre
         Yjkw==
X-Gm-Message-State: AOJu0YzcbL9tDZJ4culMUOW9QKrJxhSMmJlwbsDqV6L0Kymex//BjRBA
	SGWMSHGmkuWmlvlaC0uo/7xBqH1+UHeSSIrwkEoe5r4EwPYtZi6cBR7mAAR3YBBdYfdQv4TwfAR
	filNG17eOpl2g25pmt3VHyx/3SkKz1f4=
X-Gm-Gg: ASbGncs/n95EesQRl7XCFDfmEFELWrcmx0RZDCBQlkkc51K5nYgWv9v2X5QDJpMdkoQ
	MC7OM7j6ZSAOL6KQpzEuYXt0D3oSgWVy56J9exsBF76tThmX3QiLMSkFO6YFOpNw60evCVB5k9D
	Hj2pe4O54cKYK1JUXvd8B2DPElRdoSiqB7ZPd82LyEcO/UkJ2v46psbIYGzOHpaEjtcF6cLvNqO
	Qgzrim7X8Xlj0WWlHWaeOnhteqN+RUz3A==
X-Google-Smtp-Source: AGHT+IEpyZs6NvQN5czBl4qyUt/n8HJc4dNvCEK5xRCKfnMCQ2t6UQKRtEplwEqKpCd5C99n4GJ3APxp/cqcbnLnbmo=
X-Received: by 2002:a17:90b:3dcf:b0:31e:d9f0:9b92 with SMTP id
 98e67ed59e1d1-324ed11e54cmr446992a91.14.1755725683428; Wed, 20 Aug 2025
 14:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819114340.382238-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250819114340.382238-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Aug 2025 14:34:29 -0700
X-Gm-Features: Ac12FXymH7A6QlOISB4k3Y_sOSNSZmeUc2khJu3lRxVE_Kb6Zciu1wp4SYuNn58
Message-ID: <CAEf4Bzbwnwj125ogm5u8pY6GNrR0EWLVH9J-diC49aZp3xi9RQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: add BPF program dump in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 4:43=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> This patch adds support for dumping BPF program instructions directly
> from veristat.
> While it is already possible to inspect BPF program dump using bpftool,
> it requires multiple commands. During active development, it's common

not just that, veristat will load and unload program very fast, so you
don't have sufficient time to find prog ID and dump it. So it's not
realistically possible today, unless you artificially make veristat
pause.

> for developers to use veristat for testing verification. Integrating
> instruction dumping into veristat reduces the need to switch tools and
> simplifies the workflow.
> By making this information more readily accessible, this change aims
> to streamline the BPF development cycle and improve usability for
> developers.
> This implementation leverages bpftool, by running it directly via popen
> to avoid any code duplication and keep veristat simple.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 34 +++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index d532dd82a3a8..a4ecbc12953e 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -181,6 +181,12 @@ struct var_preset {
>         bool applied;
>  };
>
> +enum dump_mode {
> +       NO_DUMP =3D 0,
> +       XLATED,
> +       JITED,
> +};

nit: DUMP_NONE, DUMP_XLATED, DUMP_JITED ?


and to think about it, why not support dumping both XLATED and
JITED?... Make this a set of bits?

> +
>  static struct env {
>         char **filenames;
>         int filename_cnt;
> @@ -227,6 +233,7 @@ static struct env {
>         char orig_cgroup[PATH_MAX];
>         char stat_cgroup[PATH_MAX];
>         int memory_peak_fd;
> +       enum dump_mode dump_mode;
>  } env;
>
>  static int libbpf_print_fn(enum libbpf_print_level level, const char *fo=
rmat, va_list args)
> @@ -295,6 +302,7 @@ static const struct argp_option opts[] =3D {
>           "Force BPF verifier failure on register invariant violation (BP=
F_F_TEST_REG_INVARIANTS program flag)" },
>         { "top-src-lines", 'S', "N", 0, "Emit N most frequent source code=
 lines" },
>         { "set-global-vars", 'G', "GLOBAL", 0, "Set global variables prov=
ided in the expression, for example \"var1 =3D 1\"" },
> +       { "dump", 'p', "DUMP_MODE", 0, "Print BPF program dump (xlated, j=
ited)" },

"dump" and "p" don't have an obvious connection... let's just have
long-form --dump=3Dxlated for now (and I'd default to --dump meaning
--dump=3Dxlated to save typing for common case)?

>         {},
>  };
>
> @@ -427,6 +435,16 @@ static error_t parse_arg(int key, char *arg, struct =
argp_state *state)
>                         return err;
>                 }
>                 break;
> +       case 'p':
> +               if (strcmp(arg, "jited") =3D=3D 0) {
> +                       env.dump_mode =3D JITED;
> +               } else if (strcmp(arg, "xlated") =3D=3D 0) {

nit: make case-insensitive?

> +                       env.dump_mode =3D XLATED;
> +               } else {
> +                       fprintf(stderr, "Unrecognized dump mode '%s'\n", =
arg);
> +                       return -EINVAL;
> +               }
> +               break;
>         default:
>                 return ARGP_ERR_UNKNOWN;
>         }
> @@ -1554,6 +1572,17 @@ static int parse_rvalue(const char *val, struct rv=
alue *rvalue)
>         return 0;
>  }
>
> +static void dump(__u32 prog_id, const char *prog_name)
> +{
> +       char command[64];
> +
> +       snprintf(command, sizeof(command), "bpftool prog dump %s id %u",
> +                env.dump_mode =3D=3D JITED ? "jited" : "xlated", prog_id=
);
> +       printf("Prog's '%s' dump:\n", prog_name);

let's make it a bit more apparent and follow PROCESSING styling:

<file>/<program> DUMP (XLATED|JITED):
...

> +       system(command);

Quick googling didn't answer this question, but with system() we make
assumption that system()'s stdout/stderr always goes into veristat's
stdout/stderr. It might be always true, but why rely on this if we can
just popen()? popen() also would allow us to do any processing we
might want to do (unlikely, but it's good to have an option, IMO).

Let's go with popen(), it's not much of a complication.

pw-bot: cr

> +       printf("\n");
> +}
> +
>  static int process_prog(const char *filename, struct bpf_object *obj, st=
ruct bpf_program *prog)
>  {
>         const char *base_filename =3D basename(strdupa(filename));
> @@ -1630,8 +1659,11 @@ static int process_prog(const char *filename, stru=
ct bpf_object *obj, struct bpf
>
>         memset(&info, 0, info_len);
>         fd =3D bpf_program__fd(prog);
> -       if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=
=3D 0)
> +       if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=
=3D 0) {
>                 stats->stats[JITED_SIZE] =3D info.jited_prog_len;
> +               if (env.dump_mode !=3D NO_DUMP)
> +                       dump(info.id, prog_name);
> +       }
>
>         parse_verif_log(buf, buf_sz, stats);
>
> --
> 2.50.1
>

