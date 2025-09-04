Return-Path: <bpf+bounces-67368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E18BB42DE2
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 02:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00FF74E3509
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 00:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DD65661;
	Thu,  4 Sep 2025 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEO873Fo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5D7AD24
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 00:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944424; cv=none; b=idjIrgizXIPUzZ64YMW2I9iFaHi3Xdko4TGuzFmCAHm++Sul8GImycpNEW8+tzKg2XzQdq1LyshwfaJI0Js9G/Jyee6iCkdKWWcOd7+hZZ2ZRvOtgymf6swmXKTvDW0PaJcvnxgPb8vDDlFTX/UW+xZ7G340bPECUI4czeyQX38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944424; c=relaxed/simple;
	bh=DWsrNZxUTsvGD210Z6bFOa/JN9+vWMiC4MrVg3jslm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uz5Av+X++/340/zRc6Xq27pUnJp3gKrEpIzMqqHvr5FgwaVzX/l1OhWCcezDCj/QB9CluR7Kg1KdxOamhdvpypgNNDfprIgB1mxRr6pS3Du2RsdgZoQ7Psnofyl67wmJWE4CqvyjoVs/5uhBoinpMrkIaB7A1Og1nGD+S8sS/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEO873Fo; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7725de6b57dso574298b3a.0
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 17:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756944421; x=1757549221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWtqBxK82Mn6R9HXUecgxJDy8NEEHabIA8RqN/iwbDw=;
        b=YEO873Foq8OcFfzRK85E2qgUozEjZ1pDLcrZo55U4P5J6GWSzSLj/YEKrkna+vipim
         yH2I6dMhTlTWCMSMLcMj/pJthuXHui5KSRp9rZ9TsmMnGgDrODpWX0oPO+ME5siZ00PC
         T5w+mbWnjNq4Ttwx5xuFlYbVVTPb1NtMcN7v3oq/t7n+/wc1OEnh0Vb65RrwCiHKhK3Q
         OOgROBAkJ9iB5vEaBAmY2/uO52zn9ImNEI/QPsvVNUlUR4l/DEnmGNfwci98xHPJkphW
         QC3R8Qi6OlnBj706grK25GV8e5qRlmEdLkOFasEFbmPKpNbexFj/WQo/2AgFY/pDZjDD
         /WiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756944421; x=1757549221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWtqBxK82Mn6R9HXUecgxJDy8NEEHabIA8RqN/iwbDw=;
        b=wlO+IxaRed0nf1IXqBhK5sN2wIiw7f46HAy99ob+dfWt72Cebng9P1oeeWLvBg/w/X
         feGVhLfhNw33oF3UslwaTL100zMlFddzSsd1hkZFyqRtZ9mVcIxKPTPfliheqz2aH3ob
         IXjwq9cGLpNWtpTHChSj3l2ZQCQCKLWJTXdvzXINdh/eIBPKT1yvRn1vlSKoAParBh0V
         jKIMvcngLnkUwYWopsFGEon540fs2gFcNK6QP2FW9IdvSdoVq8ZO4U0+avOirD736wGh
         tDn8GZsSlh8JQHeAbDe55sA4Jk44+f2T1XtXnEwvfDMl96ElCa4MI2ZXEpRbpwML12OU
         SLVg==
X-Gm-Message-State: AOJu0YzaIUg2y4dDfc5U82Dyr9BaxKQtJpOg3Ifc/1EWCBvtxmcbcuTu
	Zbae8jJi9BEgaETy1p9eEdUVttorhQlUcZWC8Y/tlGQ3hRXZspAk+Hay4zJcp71UnZxgkSKZvjd
	GIQ17SgpbKz5+6GTkA2Qc4tV1gJHBxVU=
X-Gm-Gg: ASbGnctIAIv82iwfPiLJTDG1tRot7I+bPjE+WGAhdXiOVowLrNBi/bDUrEEi0SuOoBx
	HKK4EvAkOQkERmnyhuQPrhlqXb4y9ZoWocjRSlcieTd0+FsOAn4skqijTtwtAEfUZm7bFO+rDjq
	BR8t1QAynRUTO8u5iKYHHP1dxMaw0GvM7+Jdhk/vptyfJT6rfz+0Mm74I3/xMNK77FgaK/P1Jzh
	c6V6KLa6DhYwepHcuqXcSUZon6xgQS3Wg==
X-Google-Smtp-Source: AGHT+IEOe5/sde7WsiDLyIx7NizXf4zLZ3m1N9ncj8P3cZGMcdl67JiUyLpWA3/XnthWotcqsRrpS+4eacSjF7d0tws=
X-Received: by 2002:a05:6a21:3384:b0:243:b018:f8a5 with SMTP id
 adf61e73a8af0-243d6dc8a7emr24458887637.6.1756944420571; Wed, 03 Sep 2025
 17:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902233502.776885-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250902233502.776885-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Sep 2025 17:06:46 -0700
X-Gm-Features: Ac12FXybhNkX5BvhmBDrdTNrla0mSVtpSrJ1jAWnXA00Z42FHDj_0dmiyFB02C8
Message-ID: <CAEf4BzZA-1HjhtKAz_4=N4DOsCuQZOrqCwJhDqVwH6fJPiiUKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] selftests/bpf: add BPF program dump in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 4:35=E2=80=AFPM Mykyta Yatsenko
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
>  tools/testing/selftests/bpf/veristat.c | 69 +++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index d532dd82a3a8..e27893863400 100644
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
> @@ -295,6 +303,7 @@ static const struct argp_option opts[] =3D {
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
> @@ -427,6 +436,16 @@ static error_t parse_arg(int key, char *arg, struct =
argp_state *state)
>                         return err;
>                 }
>                 break;
> +       case OPT_DUMP:
> +               if (!arg || strcasecmp(arg, "xlated") =3D=3D 0) {
> +                       env.dump_mode |=3D DUMP_XLATED;
> +               } else if (strcasecmp(arg, "jited") =3D=3D 0) {
> +                       env.dump_mode |=3D DUMP_JITED;
> +               } else {
> +                       fprintf(stderr, "Unrecognized dump mode '%s'\n", =
arg);
> +                       return -EINVAL;
> +               }
> +               break;
>         default:
>                 return ARGP_ERR_UNKNOWN;
>         }
> @@ -1554,6 +1573,49 @@ static int parse_rvalue(const char *val, struct rv=
alue *rvalue)
>         return 0;
>  }
>
> +static void dump(__u32 prog_id, enum dump_mode mode, const char *file_na=
me, const char *prog_name)
> +{
> +       char command[64], buf[4096];
> +       ssize_t len, wrote, off;
> +       FILE *fp;
> +       int status;
> +
> +       status =3D system("which bpftool > /dev/null 2>&1");
> +       if (status !=3D 0) {
> +               fprintf(stderr, "bpftool is not available, can't print pr=
ogram dump\n");
> +               return;
> +       }
> +       snprintf(command, sizeof(command), "bpftool prog dump %s id %u",
> +                mode =3D=3D DUMP_JITED ? "jited" : "xlated", prog_id);
> +       fp =3D popen(command, "r");
> +       if (!fp) {
> +               fprintf(stderr, "Can't run bpftool\n");

maybe "bpftool failed with error: %d\n" and pass errno?

> +               return;
> +       }
> +
> +       printf("%s/%s DUMP %s:\n", file_name, prog_name, mode =3D=3D DUMP=
_JITED ? "JITED" : "XLATED");
> +       fflush(stdout);
> +       do {
> +               len =3D read(fileno(fp), buf, sizeof(buf));
> +               if (len < 0)
> +                       goto error;
> +
> +               for (off =3D 0; off < len;) {
> +                       wrote =3D write(STDOUT_FILENO, buf + off, len - o=
ff);
> +                       if (wrote <=3D 0)
> +                               goto error;
> +                       off +=3D wrote;
> +               }
> +       } while (len > 0);
> +       write(STDOUT_FILENO, "\n", 1);

Given we have FILE abstraction, wouldn't it be more natural to use
fread()/fwrite()/feof()?

this also doesn't handle interrupted syscalls (-EINTR)

pw-bot: cr

> +       goto out;
> +error:
> +       fprintf(stderr, "Could not write BPF prog dump. Error: %s (errno=
=3D%d)\n", strerror(errno),

why so specific, "write", if it could be an error during reading from
bpftool? And note a more or less consistent "Failed to ..." wording,
there is not a single "Could not" in veristat.c. So something generic
like "Failed to fetch BPF program dump" or something?

> +               errno);
> +out:
> +       pclose(fp);
> +}
> +
>  static int process_prog(const char *filename, struct bpf_object *obj, st=
ruct bpf_program *prog)
>  {
>         const char *base_filename =3D basename(strdupa(filename));
> @@ -1630,8 +1692,13 @@ static int process_prog(const char *filename, stru=
ct bpf_object *obj, struct bpf
>
>         memset(&info, 0, info_len);
>         fd =3D bpf_program__fd(prog);
> -       if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=
=3D 0)
> +       if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=
=3D 0) {
>                 stats->stats[JITED_SIZE] =3D info.jited_prog_len;
> +               if (env.dump_mode & DUMP_JITED)
> +                       dump(info.id, DUMP_JITED, base_filename, prog_nam=
e);
> +               if (env.dump_mode & DUMP_XLATED)
> +                       dump(info.id, DUMP_XLATED, base_filename, prog_na=
me);
> +       }
>
>         parse_verif_log(buf, buf_sz, stats);
>
> --
> 2.51.0
>

