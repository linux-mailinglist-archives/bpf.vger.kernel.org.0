Return-Path: <bpf+bounces-67483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4342DB444F7
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 20:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E901BC40B6
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBDD3126D1;
	Thu,  4 Sep 2025 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ff1g0SGZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0A0305E2C
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008956; cv=none; b=b2T6ehjWtYI+5X6QRbQHlUd2owmXaaDYrEkCGVS7aWdlBhYubg4QtyJOBqcDfwnwkTP/cEDauH8wCcFDBYTLx0KzbLzo5Sh+BpzBjIM70O25drY/N4tO2a0biT9H8m6jmCFOWnPTRAVcBH4PakGRtRtlrYYJK/b9Z4OpeLU/B+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008956; c=relaxed/simple;
	bh=QdBTqkwD66iPXr5ysiSe439526BpfeJWSP/F4EzejLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFDRwz4AijNOgDecMeAx+/w3pEwylaZJvvr52FrwVjA0KKIqsqUBq0EU0azO9hYhHGkaTNcoqILFyJoqA8m4XQE7LUI9jEGx+X1bBhMmbIcw7bCntn2L5s4DA5MgR2AToBlfzBnrqckdYr+nWUCFEiO2wVsw0Vla/+zm3wfgP64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ff1g0SGZ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32326e20aadso1422234a91.2
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 11:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757008954; x=1757613754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6Yldnz7e44mgHNy1wn0HLyZU4pXhYThOQkjfRzh0JM=;
        b=Ff1g0SGZAb2oIDfzNgXd64YMXIE77XiTasDBEouaPR7+A90Qj4Is6+rMl7+/qdouIR
         M6Ea3fxzuP2/FmVDDbOw6MqXacydeBteUNqdBrkF5RNkl5MRS/olGl7OXkptZPfbdmds
         YwHxQO1Tqy6SMoKsOOfPYhy1XuVOZKLwHNCMbDlN7hX4AyjKYTBd8X1Y+iiaFeSxjUy0
         utxZ3Yba6BhojQZHbkYb5txhYIPR0quGi26GumsXaQcf8+6pnORjCDuk/fw45lUoH5Q5
         bQhnucqhrv9jg/WapxzSFFvA+E1W2gOsmeYG2xjrYnxKl4qVB9XY5EfHfhGXTts6T0iz
         taBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757008954; x=1757613754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6Yldnz7e44mgHNy1wn0HLyZU4pXhYThOQkjfRzh0JM=;
        b=E5aR/FYfGOPWxZ+tbTATDlq6CdRpMfxYOQAuf/PV9eL6kvNWPGJeZ3lPbU3LcpCPVV
         y7/fwJL5mB1x/gRVvI2J6kbVib79DmOdjh3ajp5NoqllwMLwhZZyU7V8rPZ8jCDHvGvr
         JjKFTjmjx94SwHe2Y7BRHvBxiocsTmEjqowIRoDsh9HzbFOF+o1xoUb5eMkIPp42ZjAf
         Th5jqgnU3sOyWQdryxC4drnoeA0MD7cGyfVzHXnWM3PkzBcQ06UAXiScJmts7V0Fn5Mv
         a9+fE/qSjkyHW+eQrU2VRedOTJkNoapKsKv8ieWWd+4ib8CChrDEgKw/YmMJiTJS7Hbb
         39ww==
X-Gm-Message-State: AOJu0YwJ4uDiYAjbNi1SzlW3FBxl87cEjqZ1m/jQ9kIY31F7q1LVZc3b
	lt8nOhRx+7jB2hdWCG9JUilBqEIQp4wvUaTYdo5dYVe+k1+q17kMh20gwOx9iWr8vPvC8MIXcEz
	e3d6PGJTnKiBBklZVFzeFIOASL+rVIB3r0T8e
X-Gm-Gg: ASbGncs3BGWJGFKXogpWs1WWLmlq/oxS9A//avSHR/L4g1+1OPJeIAv6H/1z6urxobn
	s3Ety1qQSzKVt240WiyBBh4+rPvdcN+lugxkLFgSp8M7ujW+6Y7QWlkoGx1KXJCpZP1mv1hRy6k
	iZNDlFauqM41Zfxf+7RTbe1V9HPLxAhEa3lE8lYO+HypXApQXjbDcfEpDhIqevVuYhL2+sqxyeo
	/HTONR31w1Nn63knTnchjMMKjG0XRRAuA==
X-Google-Smtp-Source: AGHT+IE1p8SYnFemf/ahm5JuxxJUxzE9SLEq3wj7Z7xOhgjs3RiJESYJBsTxv3qUiDCU+XyCNGRoYqfkHiWK0vdGyxM=
X-Received: by 2002:a17:90b:388d:b0:32b:623d:ee91 with SMTP id
 98e67ed59e1d1-32b623defe9mr8068842a91.27.1757008953734; Thu, 04 Sep 2025
 11:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902233502.776885-1-mykyta.yatsenko5@gmail.com>
 <CAEf4BzZA-1HjhtKAz_4=N4DOsCuQZOrqCwJhDqVwH6fJPiiUKQ@mail.gmail.com> <542230e1-429b-4f8e-a4d9-60cb3d91aba9@gmail.com>
In-Reply-To: <542230e1-429b-4f8e-a4d9-60cb3d91aba9@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Sep 2025 11:02:18 -0700
X-Gm-Features: Ac12FXx4-qgJOyLAEze_s6l8qp0kooTj1acv2TmIq2JtB4SVjUVulXp5oHZ7Kto
Message-ID: <CAEf4BzZPwJ49DDkBbZmy2-vC+E=pqkhOp8AbGCQrfmruyxGxJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] selftests/bpf: add BPF program dump in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 8:57=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
>
> On 9/4/25 01:06, Andrii Nakryiko wrote:
> > On Tue, Sep 2, 2025 at 4:35=E2=80=AFPM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Add the ability to dump BPF program instructions directly from verista=
t.
> >> Previously, inspecting a program required separate bpftool invocations=
:
> >> one to load and another to dump it, which meant running multiple
> >> commands.
> >> During active development, it's common for developers to use veristat
> >> for testing verification. Integrating instruction dumping into verista=
t
> >> reduces the need to switch tools and simplifies the workflow.
> >> By making this information more readily accessible, this change aims
> >> to streamline the BPF development cycle and improve usability for
> >> developers.
> >> This implementation leverages bpftool, by running it directly via pope=
n
> >> to avoid any code duplication and keep veristat simple.
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   tools/testing/selftests/bpf/veristat.c | 69 ++++++++++++++++++++++++=
+-
> >>   1 file changed, 68 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/se=
lftests/bpf/veristat.c
> >> index d532dd82a3a8..e27893863400 100644
> >> --- a/tools/testing/selftests/bpf/veristat.c
> >> +++ b/tools/testing/selftests/bpf/veristat.c
> >> @@ -181,6 +181,12 @@ struct var_preset {
> >>          bool applied;
> >>   };
> >>
> >> +enum dump_mode {
> >> +       DUMP_NONE =3D 0,
> >> +       DUMP_XLATED =3D 1,
> >> +       DUMP_JITED =3D 2,
> >> +};
> >> +
> >>   static struct env {
> >>          char **filenames;
> >>          int filename_cnt;
> >> @@ -227,6 +233,7 @@ static struct env {
> >>          char orig_cgroup[PATH_MAX];
> >>          char stat_cgroup[PATH_MAX];
> >>          int memory_peak_fd;
> >> +       __u32 dump_mode;
> >>   } env;
> >>
> >>   static int libbpf_print_fn(enum libbpf_print_level level, const char=
 *format, va_list args)
> >> @@ -271,6 +278,7 @@ const char argp_program_doc[] =3D
> >>   enum {
> >>          OPT_LOG_FIXED =3D 1000,
> >>          OPT_LOG_SIZE =3D 1001,
> >> +       OPT_DUMP =3D 1002,
> >>   };
> >>
> >>   static const struct argp_option opts[] =3D {
> >> @@ -295,6 +303,7 @@ static const struct argp_option opts[] =3D {
> >>            "Force BPF verifier failure on register invariant violation=
 (BPF_F_TEST_REG_INVARIANTS program flag)" },
> >>          { "top-src-lines", 'S', "N", 0, "Emit N most frequent source =
code lines" },
> >>          { "set-global-vars", 'G', "GLOBAL", 0, "Set global variables =
provided in the expression, for example \"var1 =3D 1\"" },
> >> +       { "dump", OPT_DUMP, "DUMP_MODE", OPTION_ARG_OPTIONAL, "Print B=
PF program dump (xlated, jited)" },
> >>          {},
> >>   };
> >>
> >> @@ -427,6 +436,16 @@ static error_t parse_arg(int key, char *arg, stru=
ct argp_state *state)
> >>                          return err;
> >>                  }
> >>                  break;
> >> +       case OPT_DUMP:
> >> +               if (!arg || strcasecmp(arg, "xlated") =3D=3D 0) {
> >> +                       env.dump_mode |=3D DUMP_XLATED;
> >> +               } else if (strcasecmp(arg, "jited") =3D=3D 0) {
> >> +                       env.dump_mode |=3D DUMP_JITED;
> >> +               } else {
> >> +                       fprintf(stderr, "Unrecognized dump mode '%s'\n=
", arg);
> >> +                       return -EINVAL;
> >> +               }
> >> +               break;
> >>          default:
> >>                  return ARGP_ERR_UNKNOWN;
> >>          }
> >> @@ -1554,6 +1573,49 @@ static int parse_rvalue(const char *val, struct=
 rvalue *rvalue)
> >>          return 0;
> >>   }
> >>
> >> +static void dump(__u32 prog_id, enum dump_mode mode, const char *file=
_name, const char *prog_name)
> >> +{
> >> +       char command[64], buf[4096];
> >> +       ssize_t len, wrote, off;
> >> +       FILE *fp;
> >> +       int status;
> >> +
> >> +       status =3D system("which bpftool > /dev/null 2>&1");
> >> +       if (status !=3D 0) {
> >> +               fprintf(stderr, "bpftool is not available, can't print=
 program dump\n");
> >> +               return;
> >> +       }
> >> +       snprintf(command, sizeof(command), "bpftool prog dump %s id %u=
",
> >> +                mode =3D=3D DUMP_JITED ? "jited" : "xlated", prog_id)=
;
> >> +       fp =3D popen(command, "r");
> >> +       if (!fp) {
> >> +               fprintf(stderr, "Can't run bpftool\n");
> > maybe "bpftool failed with error: %d\n" and pass errno?
> >
> >> +               return;
> >> +       }
> >> +
> >> +       printf("%s/%s DUMP %s:\n", file_name, prog_name, mode =3D=3D D=
UMP_JITED ? "JITED" : "XLATED");
> >> +       fflush(stdout);
> >> +       do {
> >> +               len =3D read(fileno(fp), buf, sizeof(buf));
> >> +               if (len < 0)
> >> +                       goto error;
> >> +
> >> +               for (off =3D 0; off < len;) {
> >> +                       wrote =3D write(STDOUT_FILENO, buf + off, len =
- off);
> >> +                       if (wrote <=3D 0)
> >> +                               goto error;
> >> +                       off +=3D wrote;
> >> +               }
> >> +       } while (len > 0);
> >> +       write(STDOUT_FILENO, "\n", 1);
> > Given we have FILE abstraction, wouldn't it be more natural to use
> > fread()/fwrite()/feof()?
> >
> > this also doesn't handle interrupted syscalls (-EINTR)
> I did that initially, but then removed, is there a relevant scenario
> where veristat handles signals, is it
>   SIGSTOP/SIGCONT ? Otherwise it's going to terminate anyway, isn't it?

there are a bunch of signals that can be sent to veristat (e.g.,
SIGCHLD), that wouldn't kill the process. I guess why not handle that
if that's part of syscall handling protocol?

> >
> > pw-bot: cr
> >
> >> +       goto out;
> >> +error:
> >> +       fprintf(stderr, "Could not write BPF prog dump. Error: %s (err=
no=3D%d)\n", strerror(errno),
> > why so specific, "write", if it could be an error during reading from
> By write I meant "output" or "print" in a sense that we
> can't print dump any further, because there is some error.
> I'll send the next version.
> > bpftool? And note a more or less consistent "Failed to ..." wording,
> > there is not a single "Could not" in veristat.c. So something generic
> > like "Failed to fetch BPF program dump" or something?
> >
> >> +               errno);
> >> +out:
> >> +       pclose(fp);
> >> +}
> >> +
> >>   static int process_prog(const char *filename, struct bpf_object *obj=
, struct bpf_program *prog)
> >>   {
> >>          const char *base_filename =3D basename(strdupa(filename));
> >> @@ -1630,8 +1692,13 @@ static int process_prog(const char *filename, s=
truct bpf_object *obj, struct bpf
> >>
> >>          memset(&info, 0, info_len);
> >>          fd =3D bpf_program__fd(prog);
> >> -       if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =
=3D=3D 0)
> >> +       if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =
=3D=3D 0) {
> >>                  stats->stats[JITED_SIZE] =3D info.jited_prog_len;
> >> +               if (env.dump_mode & DUMP_JITED)
> >> +                       dump(info.id, DUMP_JITED, base_filename, prog_=
name);
> >> +               if (env.dump_mode & DUMP_XLATED)
> >> +                       dump(info.id, DUMP_XLATED, base_filename, prog=
_name);
> >> +       }
> >>
> >>          parse_verif_log(buf, buf_sz, stats);
> >>
> >> --
> >> 2.51.0
> >>
>

