Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04583BF1BE
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 23:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhGGVz2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 17:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbhGGVz1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 17:55:27 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711FEC061574
        for <bpf@vger.kernel.org>; Wed,  7 Jul 2021 14:52:46 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id p22so5528915yba.7
        for <bpf@vger.kernel.org>; Wed, 07 Jul 2021 14:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kBrHJYANQGmpUzPhxcRazZJ1pmUS+9OiLwe4jPbTsdg=;
        b=ZV5hQEvBSNuzXQvZYko2cILpEH7UX6Jb3O1mIPr38fHAhvPAPLPyFTIqslZ/GWWiTo
         Oh5Kr2msZ+eAEUFyQRMtrPyya9Yz6K04NS6t2mkKBUwm9Qc2ROkp6WNQ45x5V+qqHUTf
         hHqwjMhMfoW1yk0DgHHb8CW/pYDdMfeUBWlBAiMawJoTltdsTX26V6G63q13v9Gu6xKe
         5YXbelNiUwceEeZM5FYbX7J9mLG61xjWwh3fwxzXsp3gj8IbQ/BCKXIy5yQaqg4rp/HJ
         XyobCv5bfbjeDJEnftThshH6jbYbcKNn4hWU8gZsY5UXFKbIMbA5B+pQpAPJGrZjAVzs
         ac6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kBrHJYANQGmpUzPhxcRazZJ1pmUS+9OiLwe4jPbTsdg=;
        b=mxnt6iWyExycuApOtDl05IMeVbeFRvjkay9ZmB5F/vYFxUXSKFwaonwTgtt56AOhU5
         6ftMtYXedradPZ3E0wH8tRGS9QbNKmuPDh59msewnaZ8kIcLndOF95h8IW1/2jLdkmkO
         ImYJDKDIPoyXvinP/g5U4rIsmR5U6ChXaLsI71VrXJ5eb3x/c6wcjRRBMXIUGyNhrvnS
         i4pla9HDk9k87FDznoDGpQuqcWwbAejfDJgrpd3EmWjzfO4wczTe5DbxS2t4RC3SRm5L
         sPOprC/xA/5IDtvuEQ085bgKh5p4qInnx3ZFpiItDJuDiSllLxl/FRT2q/sMmxd16g4n
         zDpA==
X-Gm-Message-State: AOAM530N/hSo2pwX5Lx7YIHsoQ80cUS6CpCaIzqy30KsGpE6EPO0URh5
        qvo8NuVw6N3C/4xzlwPF4t940F0LJghx6JuTR3I=
X-Google-Smtp-Source: ABdhPJx1FkwYrCFdNROq301LY2WejIwWheoPdmiL+7E5Aw3NkJb4ARuWs4+xLFnXgYgKXOweSrHuXe9JXeb3pxcuNWM=
X-Received: by 2002:a25:d349:: with SMTP id e70mr34787118ybf.510.1625694765525;
 Wed, 07 Jul 2021 14:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzYQcD8vrTkXSgwBVGhRKvSWM6KyNc07QthK+=60+vUf8w@mail.gmail.com>
 <20210625044459.1249282-1-rafaeldtinoco@gmail.com>
In-Reply-To: <20210625044459.1249282-1-rafaeldtinoco@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Jul 2021 14:52:34 -0700
Message-ID: <CAEf4BzYz4BJp8beyoKD03ao4PuvuDg+QpMszeJSGrqPC==JoGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] libbpf: introduce legacy kprobe events support
To:     Rafael David Tinoco <rafaeldtinoco@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 24, 2021 at 9:45 PM Rafael David Tinoco
<rafaeldtinoco@gmail.com> wrote:
>
> Allow kprobe tracepoint events creation through legacy interface, as the
> kprobe dynamic PMUs support, used by default, was only created in v4.17.
>
> This enables CO.RE support for older kernels.
>
> Signed-off-by: Rafael David Tinoco <rafaeldtinoco@gmail.com>
> ---

Sorry for the delay, I've been out on vacation for the last two weeks.

>  tools/lib/bpf/libbpf.c | 125 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 123 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1e04ce724240..72a22c4d8295 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10007,6 +10007,10 @@ struct bpf_link {
>         char *pin_path;         /* NULL, if not pinned */
>         int fd;                 /* hook FD, -1 if not applicable */
>         bool disconnected;
> +       struct {
> +               char *name;
> +               bool retprobe;
> +       } legacy;

we shouldn't extend common bpf_link with kprobe-specific parts. We
used to have something like this (for other use cases):

struct bpf_link_kprobe {
    struct bpf_link link;
    char *legacy_name;
    bool is_retprobe;
};

And then internally do container_of() to "cast" struct bpf_link to
struct bpf_link_kprobe. External API should still operate on struct
bpf_link everywhere.

>  };
>
>  /* Replace link's underlying BPF program with the new one */
> @@ -10143,6 +10147,47 @@ int bpf_link__unpin(struct bpf_link *link)
>         return 0;
>  }
>
> +static int poke_kprobe_events(bool add, const char *name, bool retprobe)
> +{
> +       int fd, ret = 0;
> +       char probename[32], cmd[160];
> +       const char *file = "/sys/kernel/debug/tracing/kprobe_events";
> +
> +       memset(probename, 0, sizeof(probename));

nit: char probename[32] = {} instead of explicit memset

32 seems pretty small, though, is that kernel restriction? if not,
let's maybe bump it to 128 or so?

> +
> +       if (retprobe)
> +               ret = snprintf(probename, sizeof(probename), "kprobes/%s_ret", name);
> +       else
> +               ret = snprintf(probename, sizeof(probename), "kprobes/%s", name);

BCC seems to be adding _bcc_<pid> prefix, so maybe let's do the same
here with s/bcc/libbpf/?

> +
> +       if (ret <= strlen("kprobes/"))
> +               return -EINVAL;

why would snprintf() fail at all?

> +
> +       if (add)
> +               snprintf(cmd, sizeof(cmd),"%c:%s %s", retprobe ? 'r' : 'p', probename, name);

missing space before "

> +       else
> +               snprintf(cmd, sizeof(cmd), "-:%s", probename);
> +
> +       if (!(fd = open(file, O_WRONLY|O_APPEND, 0)))

let's not do these assignments inside if, we are not trying to save
lines of code here, but it's harder to read

also need spaces around operator |

> +               return -errno;
> +       if ((ret = write(fd, cmd, strlen(cmd))) < 0)
> +               ret = -errno;
> +
> +       close(fd);
> +
> +       return ret;
> +}
> +
> +static inline int add_kprobe_event_legacy(const char* name, bool retprobe)

char *name

> +{
> +       return poke_kprobe_events(true, name, retprobe);
> +}
> +
> +static inline int remove_kprobe_event_legacy(const char* name, bool retprobe)

char *name

> +{
> +       return poke_kprobe_events(false, name, retprobe);
> +}
> +
>  static int bpf_link__detach_perf_event(struct bpf_link *link)
>  {
>         int err;
> @@ -10152,6 +10197,12 @@ static int bpf_link__detach_perf_event(struct bpf_link *link)
>                 err = -errno;
>
>         close(link->fd);
> +
> +       if (link->legacy.name) {
> +               remove_kprobe_event_legacy(link->legacy.name, link->legacy.retprobe);
> +               free(link->legacy.name);
> +       }

instead of this check in bpf_link__detach_perf_event, attach_kprobe
should install its own bpf_link__detach_kprobe_legacy callback

> +
>         return libbpf_err(err);
>  }
>
> @@ -10229,6 +10280,23 @@ static int parse_uint_from_file(const char *file, const char *fmt)
>         return ret;
>  }
>
> +static bool determine_kprobe_legacy(void)
> +{
> +       const char *file = "/sys/bus/event_source/devices/kprobe/type";
> +
> +       return access(file, 0) == 0 ? false : true;
> +}
> +
> +static int determine_kprobe_perf_type_legacy(const char *func_name)
> +{
> +       char file[96];
> +       const char *fname = "/sys/kernel/debug/tracing/events/kprobes/%s/id";
> +
> +       snprintf(file, sizeof(file), fname, func_name);
> +
> +       return parse_uint_from_file(file, "%d\n");
> +}
> +
>  static int determine_kprobe_perf_type(void)
>  {
>         const char *file = "/sys/bus/event_source/devices/kprobe/type";
> @@ -10304,6 +10372,43 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
>         return pfd;
>  }
>
> +static int perf_event_open_probe_legacy(bool uprobe, bool retprobe, const char *name,
> +                                       uint64_t offset, int pid)

you are not using offset here, let's pass it into
add_kprobe_event_legacy and use it when attaching as "p:kprobes/%s
%s+123" in poke_kprobe_events? There are separate patches that are
adding ability to attach kprobe at offset, so let's support that
(internally) from the get go for legacy case as well.

also, it's not generic perf_event_open, it's specifically kprobe, so
let's call it with kprobe in the name (e.g., kprobe_open_legacy or
something)

> +{
> +       struct perf_event_attr attr = {};
> +       char errmsg[STRERR_BUFSIZE];
> +       int type, pfd, err;
> +
> +       if (uprobe) // unsupported

please don't use C++ style comments

> +               return -EINVAL;

was about to suggest using -ENOTSUP instead, but we shouldn't even
pass bool uprobe, as it's not yet used in uprobes. We can add it
later, if necessary.

> +
> +       if ((err = add_kprobe_event_legacy(name, retprobe)) < 0) {

same, here and below, let's not do unnecessary assignments inside the if clause

> +               pr_warn("failed to add legacy kprobe event: %s\n",
> +               libbpf_strerror_r(err, errmsg, sizeof(errmsg)));

align with the "failed ..." argument, it looks like independent
statement, not an argument

> +               return err;
> +       }
> +       if ((type = determine_kprobe_perf_type_legacy(name)) < 0) {
> +               pr_warn("failed to determine legacy kprobe event id: %s\n",
> +               libbpf_strerror_r(type, errmsg, sizeof(errmsg)));

same as above

> +               return type;
> +       }
> +       attr.size = sizeof(attr);
> +       attr.config = type;
> +       attr.type = PERF_TYPE_TRACEPOINT;
> +
> +       pfd = syscall(__NR_perf_event_open, &attr,
> +                     pid < 0 ? -1 : pid, /* pid */
> +                     pid == -1 ? 0 : -1, /* cpu */
> +                     -1 /* group_fd */,  PERF_FLAG_FD_CLOEXEC);
> +       if (pfd < 0) {
> +               err = -errno;
> +               pr_warn("legacy kprobe perf_event_open() failed: %s\n",
> +                       libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> +               return err;
> +       }
> +       return pfd;
> +}
> +
>  struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
>                                             bool retprobe,
>                                             const char *func_name)
> @@ -10311,9 +10416,18 @@ struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
>         char errmsg[STRERR_BUFSIZE];
>         struct bpf_link *link;
>         int pfd, err;
> +       bool legacy = false;

no need to initialize it, you unconditionally assign it below

>
> -       pfd = perf_event_open_probe(false /* uprobe */, retprobe, func_name,
> -                                   0 /* offset */, -1 /* pid */);
> +       if (!(legacy = determine_kprobe_legacy()))

another assignment in if

> +               pfd = perf_event_open_probe(false /* uprobe */,
> +                                           retprobe, func_name,
> +                                            0 /* offset */,
> +                                           -1 /* pid */);
> +       else
> +               pfd = perf_event_open_probe_legacy(false /* uprobe */,
> +                                           retprobe, func_name,
> +                                            0 /* offset */,
> +                                           -1 /* pid */);
>         if (pfd < 0) {
>                 pr_warn("prog '%s': failed to create %s '%s' perf event: %s\n",
>                         prog->name, retprobe ? "kretprobe" : "kprobe", func_name,

we can't use bpf_program__attach_perf_event as is now, because we need
to allocate a different struct bpf_link_kprobe. Let's extract the
PERF_EVENT_IOC_SET_BPF and PERF_EVENT_IOC_ENABLE logic into a helper
and use it from both bpf_program__attach_perf_event and
bpf_program__attach_kprobe. It's actually good because we can check
silly errors (like prog_fd < 0) before we create perf_event FD now.

> @@ -10329,6 +10443,13 @@ struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
>                         libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
>                 return libbpf_err_ptr(err);
>         }
> +
> +       if (legacy) {
> +               /* needed history for the legacy probe cleanup */
> +               link->legacy.name = strdup(func_name);
> +               link->legacy.retprobe = retprobe;
> +       }
> +
>         return link;
>  }
>
> --
> 2.27.0
>
