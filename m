Return-Path: <bpf+bounces-59314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 165D1AC81FA
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 20:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0C43BBF16
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 18:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C152309B3;
	Thu, 29 May 2025 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ciTT6VCw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B312222D1
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748542365; cv=none; b=QDsxKLYJNPAiEdLb6pmfRRv3ZueccKduxpMZ5EAGwhwRGxJk3MU9oqi3feBCt8Mj16RMCs8pMb4o5if7QL2h7baU1gEzs+HVm5ZUhHMLjvyYyj3S45duO105G/XlAQs/XVLQzHAil8kralCM0Czssjv8JtUskrVqNTthh3c4WkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748542365; c=relaxed/simple;
	bh=2ydsV6ZgSgtYzg9WHj2tNBO+Kkrb8FHOGa7JSsT4cvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwkMReg+m7YFdgrH2336CwI3UBOl0konuJsU5UYPkcZmtkOVC/TphtkXssufyYFQWl11QuUEGT9jnZ9p2KIJmDPduJbL05x7h/7N6L3k095PtKWQfd8brnSCZS3fPJH3/ojZ1jToJPhfP8VBiVR6aQeK1/3PiUD1Ffl/dJcuSpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ciTT6VCw; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3da76aea6d5so12975ab.1
        for <bpf@vger.kernel.org>; Thu, 29 May 2025 11:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748542361; x=1749147161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t61BLF3pwdRbHtqmxIlRuedsGVopWpGqVX7wxu8eCA0=;
        b=ciTT6VCwzNC1efdfyJvIn9HUFACQjEQrxZ2ltnGfE4E7hIYQ1aGjmoQR2Kyzu2tVjl
         kULkOIzdCb/xObo8gch9me+X1LwJnk+4siX+N7BlDL+lKjFnKVekyP+mfXnxYz8D/Fml
         XlDti0aFJZkVGJZEDUME3djjvLJb7z8+yXp8ajTM5wNwq7CyYoKxbg8hwMEj8+jix/Ob
         bge0InXwHkLSVWvPp7jBdYJu9fLbtoYOEqxoBqo1cNlyw50iJMnCXPgQwxhM71oxhkGa
         vw3Jyds++cFS8+oxxiYIAU5U1dGLItMNN5KfrCv8n5rlxGI3NDbw198Hlp5WZzSlgc3b
         wZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748542361; x=1749147161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t61BLF3pwdRbHtqmxIlRuedsGVopWpGqVX7wxu8eCA0=;
        b=PQvbW09m8YwuYV9ne3fz7h5cglrvxKqLZC/EmEV0bkoQw/gRs2x8yAO75V/2N7YFXw
         b5uHTAPLV/4kdvBXV+qHl7Wkp/FOMJOoaGPLeR36bIboPtXBJpvYqGwaWMFjj51E330M
         3Y95Q9d4xh3Yk2SUY8U1pJTwsmogVbuaIvgRuh4DCLfikhSpT4flX7AsRIMg2LTo9B+E
         GUJNB4Gto1tPdkmyCzJHM+snT47D2mUbCGP2zVenq2Oo5U/HiwnXHW44xBcgXyI6rEcA
         F9bZfAjtPCYkSwkUB+aqqnnO7DrgOqu99/UfORpebCQVTucVDPS0ZeRZyY1f1QYIQMoK
         20+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjpDSxAjRYTdouKbcGyjRMmECa6pTUlWZLUTJCBGFX1VY1xkobc4AGQ1MrxfyTD6xksHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdHm4PxIXc/6TF3zDxIvrELxambi+gb8/7iNFw8DSPq+9Ny86F
	bbE/d76rKeS6fzAyFilqHLZaYAi8EEE3VX/EF4652Hi4Qs8KpQm8cnV8KKIys2ZZhXrMEgHuVmF
	PiTtlbX8LIh7hmlCcQyRJwqkR99Ohm12ZBsvTzDGm
X-Gm-Gg: ASbGncvVRHkbs6Im2ZiNBfevc17eHi8pWm1xebGPtC1jCA6aJiye7pi9dN4CIEl/gXm
	WuOR6pIbbxRadmWw8JypbfsKa+6p/GFa3Mv8DS8+BA6cFSKurb2zGIDXNJRCAPlRe7ilb7wNQf2
	WztDLalfB7iItLFo6GXCRmTEtVhXLhoorFg4S0lMhV1M3XgpVfNj7ltmTrs6Mx3KCA8Y/wgKDh
X-Google-Smtp-Source: AGHT+IFOxXgNp9Va7YbjPZ2/YE+7+FTtmjid0G/+eVNqUuyY0OP65Esir2u+4V9ROh3ZWs16CI3IkXlDrAZVNvk5lyQ=
X-Received: by 2002:a05:6e02:12e7:b0:3dc:7e01:6f6a with SMTP id
 e9e14a558f8ab-3dd9a733adbmr212235ab.26.1748542360363; Thu, 29 May 2025
 11:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com> <20250521222725.3895192-4-blakejones@google.com>
In-Reply-To: <20250521222725.3895192-4-blakejones@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 May 2025 11:12:28 -0700
X-Gm-Features: AX0GCFs5NHiQ9pC1u_KblYSRHFkP21CoKtGP1NYtUB2Y_bNAnjGOYhiC4ZSsCjQ
Message-ID: <CAP-5=fWZG-N8ZzRh6h1qRuEgFbxTCyEwGu1sZZy+YmnSeGgSSw@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf: collect BPF metadata from new programs, and
 display the new event
To: Blake Jones <blakejones@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	James Clark <james.clark@linaro.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 3:27=E2=80=AFPM Blake Jones <blakejones@google.com>=
 wrote:
>
> This collects metadata for any BPF programs that were loaded during a
> "perf record" run, and emits it at the end of the run. It also adds suppo=
rt
> for displaying the new PERF_RECORD_BPF_METADATA type.
>
> Here's some example "perf script -D" output for the new event type. The
> ": unhandled!" message is from tool.c, analogous to other behavior there.
> I've elided some rows with all NUL characters for brevity, and I wrapped
> one of the >75-column lines to fit in the commit guidelines.
>
> 0x50fc8@perf.data [0x260]: event: 84
> .
> . ... raw event: size 608 bytes
> .  0000:  54 00 00 00 00 00 60 02 62 70 66 5f 70 72 6f 67  T.....`.bpf_pr=
og
> .  0010:  5f 31 65 30 61 32 65 33 36 36 65 35 36 66 31 61  _1e0a2e366e56f=
1a
> .  0020:  32 5f 70 65 72 66 5f 73 61 6d 70 6c 65 5f 66 69  2_perf_sample_=
fi
> .  0030:  6c 74 65 72 00 00 00 00 00 00 00 00 00 00 00 00  lter..........=
..
> .  0040:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
> [...]
> .  0110:  74 65 73 74 5f 76 61 6c 75 65 00 00 00 00 00 00  test_value....=
..
> .  0120:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
> [...]
> .  0150:  34 32 00 00 00 00 00 00 00 00 00 00 00 00 00 00  42............=
..
> .  0160:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
> [...]
>
> 0 0x50fc8 [0x260]: PERF_RECORD_BPF_METADATA \
>       prog bpf_prog_1e0a2e366e56f1a2_perf_sample_filter
>   entry 0:           test_value =3D 42
> : unhandled!
>
> Signed-off-by: Blake Jones <blakejones@google.com>
> ---
>  tools/perf/builtin-inject.c                  |  1 +
>  tools/perf/builtin-record.c                  |  8 +++
>  tools/perf/builtin-script.c                  | 15 ++++-
>  tools/perf/tests/shell/test_bpf_metadata.sh  | 67 ++++++++++++++++++++
>  tools/perf/util/bpf-event.c                  | 46 ++++++++++++++
>  tools/perf/util/bpf-event.h                  |  1 +
>  tools/perf/util/bpf_skel/sample_filter.bpf.c |  4 ++
>  tools/perf/util/env.c                        | 19 +++++-
>  tools/perf/util/env.h                        |  4 ++
>  tools/perf/util/event.c                      | 21 ++++++
>  tools/perf/util/event.h                      |  1 +
>  tools/perf/util/header.c                     |  1 +
>  tools/perf/util/session.c                    |  4 ++
>  tools/perf/util/synthetic-events.h           |  2 +
>  tools/perf/util/tool.c                       | 14 ++++
>  tools/perf/util/tool.h                       |  3 +-
>  16 files changed, 207 insertions(+), 4 deletions(-)
>  create mode 100644 tools/perf/tests/shell/test_bpf_metadata.sh
>
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 11e49cafa3af..b15eac0716f7 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2530,6 +2530,7 @@ int cmd_inject(int argc, const char **argv)
>         inject.tool.finished_init       =3D perf_event__repipe_op2_synth;
>         inject.tool.compressed          =3D perf_event__repipe_op4_synth;
>         inject.tool.auxtrace            =3D perf_event__repipe_auxtrace;
> +       inject.tool.bpf_metadata        =3D perf_event__repipe_op2_synth;
>         inject.tool.dont_split_sample_group =3D true;
>         inject.session =3D __perf_session__new(&data, &inject.tool,
>                                              /*trace_event_repipe=3D*/inj=
ect.output.is_pipe);
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 136c0172799a..067e203f57c2 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2161,6 +2161,12 @@ static int record__synthesize(struct record *rec, =
bool tail)
>         return err;
>  }
>
> +static void record__synthesize_final_bpf_metadata(struct record *rec)
> +{
> +       perf_event__synthesize_final_bpf_metadata(rec->session,
> +                                                 process_synthesized_eve=
nt);
> +}
> +
>  static int record__process_signal_event(union perf_event *event __maybe_=
unused, void *data)
>  {
>         struct record *rec =3D data;
> @@ -2806,6 +2812,8 @@ static int __cmd_record(struct record *rec, int arg=
c, const char **argv)
>         trigger_off(&auxtrace_snapshot_trigger);
>         trigger_off(&switch_output_trigger);
>
> +       record__synthesize_final_bpf_metadata(rec);
> +
>         if (opts->auxtrace_snapshot_on_exit)
>                 record__auxtrace_snapshot_exit(rec);
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 6c3bf74dd78c..4001e621b6cb 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -38,6 +38,7 @@
>  #include "print_insn.h"
>  #include "archinsn.h"
>  #include <linux/bitmap.h>
> +#include <linux/compiler.h>
>  #include <linux/kernel.h>
>  #include <linux/stringify.h>
>  #include <linux/time64.h>
> @@ -50,6 +51,7 @@
>  #include <errno.h>
>  #include <inttypes.h>
>  #include <signal.h>
> +#include <stdio.h>
>  #include <sys/param.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> @@ -2755,6 +2757,14 @@ process_bpf_events(const struct perf_tool *tool __=
maybe_unused,
>                            sample->tid);
>  }
>
> +static int
> +process_bpf_metadata_event(struct perf_session *session __maybe_unused,
> +                          union perf_event *event)
> +{
> +       perf_event__fprintf(event, NULL, stdout);
> +       return 0;
> +}
> +
>  static int process_text_poke_events(const struct perf_tool *tool,
>                                     union perf_event *event,
>                                     struct perf_sample *sample,
> @@ -2877,8 +2887,9 @@ static int __cmd_script(struct perf_script *script)
>                 script->tool.finished_round =3D process_finished_round_ev=
ent;
>         }
>         if (script->show_bpf_events) {
> -               script->tool.ksymbol =3D process_bpf_events;
> -               script->tool.bpf     =3D process_bpf_events;
> +               script->tool.ksymbol      =3D process_bpf_events;
> +               script->tool.bpf          =3D process_bpf_events;
> +               script->tool.bpf_metadata =3D process_bpf_metadata_event;
>         }
>         if (script->show_text_poke_events) {
>                 script->tool.ksymbol   =3D process_bpf_events;
> diff --git a/tools/perf/tests/shell/test_bpf_metadata.sh b/tools/perf/tes=
ts/shell/test_bpf_metadata.sh
> new file mode 100644
> index 000000000000..ede31d5a3c36
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_bpf_metadata.sh
> @@ -0,0 +1,67 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# BPF metadata collection test.
> +
> +set -e
> +
> +err=3D0
> +perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +
> +cleanup() {
> +       rm -f "${perfdata}"
> +       rm -f "${perfdata}".old
> +       trap - EXIT TERM INT
> +}
> +
> +trap_cleanup() {
> +       cleanup
> +       exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
> +
> +test_bpf_metadata() {
> +       echo "Checking BPF metadata collection"
> +
> +       # This is a basic invocation of perf record
> +       # that invokes the perf_sample_filter BPF program.
> +       if ! perf record -e task-clock --filter 'ip > 0' \
> +                        -o "${perfdata}" sleep 1 2> /dev/null
> +       then
> +               echo "Basic BPF metadata test [Failed record]"
> +               err=3D1
> +               return
> +       fi
> +
> +       # The perf_sample_filter BPF program has the following variable i=
n it:
> +       #
> +       #   volatile const int bpf_metadata_test_value SEC(".rodata") =3D=
 42;
> +       #
> +       # This invocation looks for a PERF_RECORD_BPF_METADATA event,
> +       # and checks that its content includes something for the above va=
riable.
> +       if ! perf script --show-bpf-events -i "${perfdata}" | awk '
> +               /PERF_RECORD_BPF_METADATA.*perf_sample_filter/ {
> +                       header =3D 1;
> +               }
> +               /^ *entry/ {
> +                       if (header) { header =3D 0; entry =3D 1; }
> +               }
> +               $0 !~ /^ *entry/ {
> +                       entry =3D 0;
> +               }
> +               /test_value/ {
> +                       if (entry) print $NF;
> +               }
> +       ' | grep 42 > /dev/null
> +       then
> +               echo "Basic BPF metadata test [Failed invalid output]"
> +               err=3D1
> +               return
> +       fi
> +       echo "Basic BPF metadata test [Success]"
> +}
> +
> +test_bpf_metadata
> +
> +cleanup
> +exit $err
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 36d5676f025e..019832ec4802 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -450,6 +450,49 @@ static int synthesize_perf_record_bpf_metadata(const=
 struct bpf_metadata *metada
>         return err;
>  }
>
> +struct bpf_metadata_final_ctx {
> +       const struct perf_tool *tool;
> +       perf_event__handler_t process;
> +       struct machine *machine;
> +};
> +
> +static void synthesize_final_bpf_metadata_cb(struct bpf_prog_info_node *=
node,
> +                                            void *data)
> +{
> +       struct bpf_metadata_final_ctx *ctx =3D (struct bpf_metadata_final=
_ctx *)data;
> +       struct bpf_metadata *metadata =3D node->metadata;
> +       int err;
> +
> +       if (metadata =3D=3D NULL)
> +               return;
> +       err =3D synthesize_perf_record_bpf_metadata(metadata, ctx->tool,
> +                                                 ctx->process, ctx->mach=
ine);
> +       if (err !=3D 0) {
> +               const char *prog_name =3D metadata->prog_names[0];
> +
> +               if (prog_name !=3D NULL)
> +                       pr_warning("Couldn't synthesize final BPF metadat=
a for %s.\n", prog_name);
> +               else
> +                       pr_warning("Couldn't synthesize final BPF metadat=
a.\n");
> +       }
> +       bpf_metadata_free(metadata);
> +       node->metadata =3D NULL;
> +}
> +
> +void perf_event__synthesize_final_bpf_metadata(struct perf_session *sess=
ion,
> +                                              perf_event__handler_t proc=
ess)
> +{
> +       struct perf_env *env =3D &session->header.env;
> +       struct bpf_metadata_final_ctx ctx =3D {
> +               .tool =3D session->tool,
> +               .process =3D process,
> +               .machine =3D &session->machines.host,
> +       };
> +
> +       perf_env__iterate_bpf_prog_info(env, synthesize_final_bpf_metadat=
a_cb,
> +                                       &ctx);
> +}
> +
>  /*
>   * Synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for one bpf
>   * program. One PERF_RECORD_BPF_EVENT is generated for the program. And
> @@ -590,6 +633,7 @@ static int perf_event__synthesize_one_bpf_prog(struct=
 perf_session *session,
>                 }
>
>                 info_node->info_linear =3D info_linear;
> +               info_node->metadata =3D NULL;
>                 if (!perf_env__insert_bpf_prog_info(env, info_node)) {
>                         free(info_linear);
>                         free(info_node);
> @@ -781,6 +825,7 @@ static void perf_env__add_bpf_info(struct perf_env *e=
nv, u32 id)
>         arrays |=3D 1UL << PERF_BPIL_JITED_INSNS;
>         arrays |=3D 1UL << PERF_BPIL_LINE_INFO;
>         arrays |=3D 1UL << PERF_BPIL_JITED_LINE_INFO;
> +       arrays |=3D 1UL << PERF_BPIL_MAP_IDS;
>
>         info_linear =3D get_bpf_prog_info_linear(fd, arrays);
>         if (IS_ERR_OR_NULL(info_linear)) {
> @@ -793,6 +838,7 @@ static void perf_env__add_bpf_info(struct perf_env *e=
nv, u32 id)
>         info_node =3D malloc(sizeof(struct bpf_prog_info_node));
>         if (info_node) {
>                 info_node->info_linear =3D info_linear;
> +               info_node->metadata =3D bpf_metadata_create(&info_linear-=
>info);
>                 if (!perf_env__insert_bpf_prog_info(env, info_node)) {
>                         free(info_linear);
>                         free(info_node);
> diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
> index 007f0b4d21cb..49a42c15bcc6 100644
> --- a/tools/perf/util/bpf-event.h
> +++ b/tools/perf/util/bpf-event.h
> @@ -26,6 +26,7 @@ struct bpf_metadata {
>
>  struct bpf_prog_info_node {
>         struct perf_bpil                *info_linear;
> +       struct bpf_metadata             *metadata;
>         struct rb_node                  rb_node;
>  };
>
> diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/ut=
il/bpf_skel/sample_filter.bpf.c
> index b195e6efeb8b..b0265f000325 100644
> --- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
> +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> @@ -43,6 +43,10 @@ struct lost_count {
>         __uint(max_entries, 1);
>  } dropped SEC(".maps");
>
> +// This is used by tests/shell/record_bpf_metadata.sh
> +// to verify that BPF metadata generation works.
> +const int bpf_metadata_test_value SEC(".rodata") =3D 42;

This is a bit random. For the non-BPF C code we have a build generated
PERF-VERSION-FILE that contains something like `#define PERF_VERSION
"6.15.rc7.ge450e74276d2"`. I wonder having something like (the section
is almost certainly wrong):
```
volatile const char * const bpf_metadata_perf_version
__attribute__((section(\".rodata\"), used, weak)) =3D PERF_VERSION;
```
with a build change something like:
```
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d4c7031b01a7..f825d9195d77 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1250,9 +1250,9 @@ else
       $(Q)cp "$(VMLINUX_H)" $@
endif

-$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF)
$(SKEL_OUT)/vmlinux.h | $(SKEL_TMP_OUT)
+$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF)
$(OUTPUT)PERF-VERSION-FILE $(SKEL_OUT)/vml
inux.h | $(SKEL_TMP_OUT)
       $(QUIET_CLANG)$(CLANG) -g -O2 --target=3Dbpf $(CLANG_OPTIONS)
$(BPF_INCLUDE) $(TOOLS_UAPI_INCL
UDE) \
-         -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
+         -include $(OUTPUT)PERF-VERSION-FILE -c $(filter
util/bpf_skel/%.bpf.c,$^) -o $@

$(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
       $(QUIET_GENSKEL)$(BPFTOOL) gen skeleton $< > $@

```
would be more useful/meaningful. Perhaps the build could inject the
variable to avoid duplicating it all the BPF skeletons.

nit: I wonder for testing it would be interesting to have 0 and >1
metadata values tested too. We may want to have test programs
explicitly for that, in tools/perf/tests.

Thanks,
Ian


> +
>  volatile const int use_idx_hash;
>
>  void *bpf_cast_to_kern_ctx(void *) __ksym;
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 36411749e007..05a4f2657d72 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -3,8 +3,10 @@
>  #include "debug.h"
>  #include "env.h"
>  #include "util/header.h"
> -#include "linux/compiler.h"
> +#include "util/rwsem.h"
> +#include <linux/compiler.h>
>  #include <linux/ctype.h>
> +#include <linux/rbtree.h>
>  #include <linux/string.h>
>  #include <linux/zalloc.h>
>  #include "cgroup.h"
> @@ -89,6 +91,20 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_inf=
o(struct perf_env *env,
>         return node;
>  }
>
> +void perf_env__iterate_bpf_prog_info(struct perf_env *env,
> +                                    void (*cb)(struct bpf_prog_info_node=
 *node,
> +                                               void *data),
> +                                    void *data)
> +{
> +       struct rb_node *first;
> +
> +       down_read(&env->bpf_progs.lock);
> +       first =3D rb_first(&env->bpf_progs.infos);
> +       for (struct rb_node *node =3D first; node !=3D NULL; node =3D rb_=
next(node))
> +               (*cb)(rb_entry(node, struct bpf_prog_info_node, rb_node),=
 data);
> +       up_read(&env->bpf_progs.lock);
> +}
> +
>  bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_nod=
e)
>  {
>         bool ret;
> @@ -174,6 +190,7 @@ static void perf_env__purge_bpf(struct perf_env *env)
>                 next =3D rb_next(&node->rb_node);
>                 rb_erase(&node->rb_node, root);
>                 zfree(&node->info_linear);
> +               bpf_metadata_free(node->metadata);
>                 free(node);
>         }
>
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index d90e343cf1fa..6819cb9b99ff 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -180,6 +180,10 @@ bool perf_env__insert_bpf_prog_info(struct perf_env =
*env,
>                                     struct bpf_prog_info_node *info_node)=
;
>  struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env =
*env,
>                                                         __u32 prog_id);
> +void perf_env__iterate_bpf_prog_info(struct perf_env *env,
> +                                    void (*cb)(struct bpf_prog_info_node=
 *node,
> +                                               void *data),
> +                                    void *data);
>  bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_nod=
e);
>  bool __perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_n=
ode);
>  struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 80c9ea682413..e81c2d87d76a 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -1,9 +1,12 @@
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <inttypes.h>
> +#include <linux/compiler.h>
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <perf/cpumap.h>
> +#include <perf/event.h>
> +#include <stdio.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <unistd.h>
> @@ -78,6 +81,7 @@ static const char *perf_event__names[] =3D {
>         [PERF_RECORD_COMPRESSED]                =3D "COMPRESSED",
>         [PERF_RECORD_FINISHED_INIT]             =3D "FINISHED_INIT",
>         [PERF_RECORD_COMPRESSED2]               =3D "COMPRESSED2",
> +       [PERF_RECORD_BPF_METADATA]              =3D "BPF_METADATA",
>  };
>
>  const char *perf_event__name(unsigned int id)
> @@ -504,6 +508,20 @@ size_t perf_event__fprintf_bpf(union perf_event *eve=
nt, FILE *fp)
>                        event->bpf.type, event->bpf.flags, event->bpf.id);
>  }
>
> +size_t perf_event__fprintf_bpf_metadata(union perf_event *event, FILE *f=
p)
> +{
> +       struct perf_record_bpf_metadata *metadata =3D &event->bpf_metadat=
a;
> +       size_t ret;
> +
> +       ret =3D fprintf(fp, " prog %s\n", metadata->prog_name);
> +       for (__u32 i =3D 0; i < metadata->nr_entries; i++) {
> +               ret +=3D fprintf(fp, "  entry %d: %20s =3D %s\n", i,
> +                              metadata->entries[i].key,
> +                              metadata->entries[i].value);
> +       }
> +       return ret;
> +}
> +
>  static int text_poke_printer(enum binary_printer_ops op, unsigned int va=
l,
>                              void *extra, FILE *fp)
>  {
> @@ -601,6 +619,9 @@ size_t perf_event__fprintf(union perf_event *event, s=
truct machine *machine, FIL
>         case PERF_RECORD_AUX_OUTPUT_HW_ID:
>                 ret +=3D perf_event__fprintf_aux_output_hw_id(event, fp);
>                 break;
> +       case PERF_RECORD_BPF_METADATA:
> +               ret +=3D perf_event__fprintf_bpf_metadata(event, fp);
> +               break;
>         default:
>                 ret +=3D fprintf(fp, "\n");
>         }
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index 664bf39567ce..67ad4a2014bc 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -370,6 +370,7 @@ size_t perf_event__fprintf_namespaces(union perf_even=
t *event, FILE *fp);
>  size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
> +size_t perf_event__fprintf_bpf_metadata(union perf_event *event, FILE *f=
p);
>  size_t perf_event__fprintf_text_poke(union perf_event *event, struct mac=
hine *machine,FILE *fp);
>  size_t perf_event__fprintf(union perf_event *event, struct machine *mach=
ine, FILE *fp);
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index e3cdc3b7b4ab..7c477e2a93b3 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3161,6 +3161,7 @@ static int process_bpf_prog_info(struct feat_fd *ff=
, void *data __maybe_unused)
>                 /* after reading from file, translate offset to address *=
/
>                 bpil_offs_to_addr(info_linear);
>                 info_node->info_linear =3D info_linear;
> +               info_node->metadata =3D NULL;
>                 if (!__perf_env__insert_bpf_prog_info(env, info_node)) {
>                         free(info_linear);
>                         free(info_node);
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index a320672c264e..38075059086c 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -12,6 +12,7 @@
>  #include <sys/types.h>
>  #include <sys/mman.h>
>  #include <perf/cpumap.h>
> +#include <perf/event.h>
>
>  #include "map_symbol.h"
>  #include "branch.h"
> @@ -1491,6 +1492,9 @@ static s64 perf_session__process_user_event(struct =
perf_session *session,
>         case PERF_RECORD_FINISHED_INIT:
>                 err =3D tool->finished_init(session, event);
>                 break;
> +       case PERF_RECORD_BPF_METADATA:
> +               err =3D tool->bpf_metadata(session, event);
> +               break;
>         default:
>                 err =3D -EINVAL;
>                 break;
> diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthet=
ic-events.h
> index b9c936b5cfeb..ee29615d68e5 100644
> --- a/tools/perf/util/synthetic-events.h
> +++ b/tools/perf/util/synthetic-events.h
> @@ -92,6 +92,8 @@ int perf_event__synthesize_threads(const struct perf_to=
ol *tool, perf_event__han
>  int perf_event__synthesize_tracing_data(const struct perf_tool *tool, in=
t fd, struct evlist *evlist, perf_event__handler_t process);
>  int perf_event__synth_time_conv(const struct perf_event_mmap_page *pc, c=
onst struct perf_tool *tool, perf_event__handler_t process, struct machine =
*machine);
>  pid_t perf_event__synthesize_comm(const struct perf_tool *tool, union pe=
rf_event *event, pid_t pid, perf_event__handler_t process, struct machine *=
machine);
> +void perf_event__synthesize_final_bpf_metadata(struct perf_session *sess=
ion,
> +                                              perf_event__handler_t proc=
ess);
>
>  int perf_tool__process_synth_event(const struct perf_tool *tool, union p=
erf_event *event, struct machine *machine, perf_event__handler_t process);
>
> diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
> index 37bd8ac63b01..204ec03071bc 100644
> --- a/tools/perf/util/tool.c
> +++ b/tools/perf/util/tool.c
> @@ -1,12 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "data.h"
>  #include "debug.h"
> +#include "event.h"
>  #include "header.h"
>  #include "session.h"
>  #include "stat.h"
>  #include "tool.h"
>  #include "tsc.h"
> +#include <linux/compiler.h>
>  #include <sys/mman.h>
> +#include <stddef.h>
>  #include <unistd.h>
>
>  #ifdef HAVE_ZSTD_SUPPORT
> @@ -237,6 +240,16 @@ static int perf_session__process_compressed_event_st=
ub(struct perf_session *sess
>         return 0;
>  }
>
> +static int perf_event__process_bpf_metadata_stub(struct perf_session *pe=
rf_session __maybe_unused,
> +                                                union perf_event *event)
> +{
> +       if (dump_trace)
> +               perf_event__fprintf_bpf_metadata(event, stdout);
> +
> +       dump_printf(": unhandled!\n");
> +       return 0;
> +}
> +
>  void perf_tool__init(struct perf_tool *tool, bool ordered_events)
>  {
>         tool->ordered_events =3D ordered_events;
> @@ -293,6 +306,7 @@ void perf_tool__init(struct perf_tool *tool, bool ord=
ered_events)
>         tool->compressed =3D perf_session__process_compressed_event_stub;
>  #endif
>         tool->finished_init =3D process_event_op2_stub;
> +       tool->bpf_metadata =3D perf_event__process_bpf_metadata_stub;
>  }
>
>  bool perf_tool__compressed_is_stub(const struct perf_tool *tool)
> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> index db1c7642b0d1..18b76ff0f26a 100644
> --- a/tools/perf/util/tool.h
> +++ b/tools/perf/util/tool.h
> @@ -77,7 +77,8 @@ struct perf_tool {
>                         stat,
>                         stat_round,
>                         feature,
> -                       finished_init;
> +                       finished_init,
> +                       bpf_metadata;
>         event_op4       compressed;
>         event_op3       auxtrace;
>         bool            ordered_events;
> --
> 2.49.0.1143.g0be31eac6b-goog
>

