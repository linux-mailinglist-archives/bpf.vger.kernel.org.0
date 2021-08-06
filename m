Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D503E31C3
	for <lists+bpf@lfdr.de>; Sat,  7 Aug 2021 00:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbhHFWaM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Aug 2021 18:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbhHFWaM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Aug 2021 18:30:12 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DFAC0613CF
        for <bpf@vger.kernel.org>; Fri,  6 Aug 2021 15:29:55 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id k65so17731125yba.13
        for <bpf@vger.kernel.org>; Fri, 06 Aug 2021 15:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXIqQ8pd8KTgQIWks+X7A2OO9SgAIursbtsjZ5Uhr50=;
        b=Ky2hBzjb1GDQNTsrR0/MN6has4RzeHLDH8d78Ar4W/pW9RVyJxh0wmjKgDbXr5FSvO
         SY1IzcNffof4cz78NxT7MhOVefKBMX3ge+YmrRYHvI60fV5Zaj6XxvxlTjDcY3TQFzwk
         lblzvrm8+/bGkZU7h3y5wRfgvLAtvFGSrUpyRmuWnAyuEjnnMejx/iio8+74CAgjBe5p
         wDKcFjS28LoiMS4xVtBxBr3rjx0SfP2wCEw8mHt/hqvPhK8hdLL/N6E+sDgmx4TP6J7O
         Zkeaf79hDAIyQhc1iMAVlF2fxl9Pel6jo1zsMXBK2POUc00uMkxvwhtewRtnrx+iYmRK
         ybqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXIqQ8pd8KTgQIWks+X7A2OO9SgAIursbtsjZ5Uhr50=;
        b=AbFqn2Td8IWL29OuUoRm3z5rmczaBdrVXOClHU+RMl5yBCC7Zl/Szs4TM4Kjp4bgRO
         1Q00lcVjHH3BBXRZG3LwNmv+Cofc3YISaubE9XHq/TBUhAbg3ig/oZsfFWP3jdaU+Qce
         7TVHpG3T9Ax4ruGvsildTHXf2p4VVNyVvJ6QK5t1ERweou7WLD7PEjGCPy4eLHWn0Uke
         G2zKae9ruGJoWzuKM1laWc1P7yxn5cjgNAckNXxmxalvKjbzmR8nbJRW+BUYsfUwdmQ5
         svAYlJ70GlAzRyV7JiVEyQw/xfURWRHD/uBVwcB7RASt5pegvfk2BftfqlZ+za9cJulK
         +1xQ==
X-Gm-Message-State: AOAM531jqQXK4xRcSw+YnRqPk470TSt/Pm6J/7L4Mz6Zj2XwYwsxxCWA
        opv94AnG9zcQAuqvix7sx2JJw/mAFitjUmJPbjA=
X-Google-Smtp-Source: ABdhPJxOTnkzh4y9wvH2Mq/da+U5bOxyBKSY3YCkJpR9gJaya9HDnNRM50rJc7GihXyytA/RX9nYQl/oWqtGip3Cmzg=
X-Received: by 2002:a25:2901:: with SMTP id p1mr15757967ybp.459.1628288994484;
 Fri, 06 Aug 2021 15:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210730053413.1090371-1-andrii@kernel.org> <20210801051123.3822498-1-rafaeldtinoco@gmail.com>
In-Reply-To: <20210801051123.3822498-1-rafaeldtinoco@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 6 Aug 2021 15:29:43 -0700
Message-ID: <CAEf4BzYPNsgMMU9Xi-Ya53-264MYrQNWWQNAyDJqNEgawk+V-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] libbpf: introduce legacy kprobe events support
To:     Rafael David Tinoco <rafaeldtinoco@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jul 31, 2021 at 10:11 PM Rafael David Tinoco
<rafaeldtinoco@gmail.com> wrote:
>
> Allow kprobe tracepoint events creation through legacy interface, as the
> kprobe dynamic PMUs support, used by default, was only created in v4.17.
>
> After commit "bpf: implement minimal BPF perf link", it was allowed that
> some extra - to the link - information is accessed through container_of
> struct bpf_link. This allows the tracing perf event legacy name, and
> information whether it is a retprobe, to be saved outside bpf_link
> structure, which would not be optimal.
>
> This enables CO.RE support for older kernels.

nit: it's CO-RE (or Compile Once - Run Everywhere), let's keep
consistent spelling.

>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Rafael David Tinoco <rafaeldtinoco@gmail.com>
> ---

Looks good overall, modulo various nits and skipped error handling.
Please wait for bpf_perf_link changes to get applied and submit the
next revision based on it. Thanks!


>  tools/lib/bpf/libbpf.c | 127 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 125 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e1b7b2b6618c..40037340a3e7 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8985,9 +8985,55 @@ int bpf_link__unpin(struct bpf_link *link)
>         return 0;
>  }
>
> +static int poke_kprobe_events(bool add, const char *name, bool retprobe, uint64_t offset) {

'{' should be on separate line

Please use scripts/checkpatch.pl on your changes, there are a bunch of
stylistic problems in your code, which you would have caught yourself
if you ran this script.

> +       int fd, ret = 0;
> +       pid_t p = getpid();
> +       char cmd[192] = {}, probename[128] = {}, probefunc[128] = {};
> +       const char *file = "/sys/kernel/debug/tracing/kprobe_events";
> +
> +       if (retprobe)
> +               snprintf(probename, sizeof(probename), "kretprobes/%s_libbpf_%u", name, p);
> +       else
> +               snprintf(probename, sizeof(probename), "kprobes/%s_libbpf_%u", name, p);
> +
> +       if (offset)
> +               snprintf(probefunc, sizeof(probefunc), "%s+%lu", name, offset);
> +
> +       if (add) {
> +               snprintf(cmd, sizeof(cmd), "%c:%s %s",
> +                        retprobe ? 'r' : 'p',
> +                        probename,
> +                        offset ? probefunc : name);
> +       } else {
> +               snprintf(cmd, sizeof(cmd), "-:%s", probename);
> +       }
> +
> +       fd = open(file, O_WRONLY | O_APPEND, 0);
> +       if (!fd)
> +               return -errno;
> +       ret = write(fd, cmd, strlen(cmd));
> +       if (ret < 0)
> +               ret = -errno;
> +       close(fd);
> +
> +       return ret;
> +}
> +
> +static inline int add_kprobe_event_legacy(const char *name, bool retprobe, uint64_t offset)
> +{
> +       return poke_kprobe_events(true, name, retprobe, offset);
> +}
> +
> +static inline int remove_kprobe_event_legacy(const char *name, bool retprobe)
> +{
> +       return poke_kprobe_events(false, name, retprobe, 0);
> +}
> +
>  struct bpf_link_perf {
>         struct bpf_link link;
>         int perf_event_fd;
> +       char *legacy_name;

My initial reaction was to have a still different struct specifically
for legacy kprobe (e.g., struct bpf_link_kprobe_legacy or something
like that). But we'll need to do similar changes to uprobes as well,
so now I think it's ok to have this as an optional extra field on
perf_event-based link. If that causes problems we can always change
that later.

To make it clearer, can you name it "legacy_probe_name" and leave a
short comment mentioning that this is used to remember original
identifier we used to create legacy kprobe?

> +       bool is_retprobe;
>  };
>
>  static int bpf_link_perf_detach(struct bpf_link *link)
> @@ -9002,6 +9048,10 @@ static int bpf_link_perf_detach(struct bpf_link *link)
>                 close(perf_link->perf_event_fd);
>         close(link->fd);
>
> +       /* legacy kprobe needs to be removed after perf event fd closure */
> +       if (perf_link->legacy_name)
> +               remove_kprobe_event_legacy(perf_link->legacy_name, perf_link->is_retprobe);

check and propagate error?

> +
>         return libbpf_err(err);
>  }
>
> @@ -9009,6 +9059,9 @@ static void bpf_link_perf_dealloc(struct bpf_link *link)
>  {
>         struct bpf_link_perf *perf_link = container_of(link, struct bpf_link_perf, link);
>
> +       if (perf_link->legacy_name)
> +               free(perf_link->legacy_name);

free() handles NULL properly, no need for if

> +
>         free(perf_link);
>  }
>
> @@ -9122,6 +9175,26 @@ static int parse_uint_from_file(const char *file, const char *fmt)
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
> +static int determine_kprobe_perf_type_legacy(const char *func_name, bool is_retprobe)
> +{
> +       char file[192];
> +

extra empty line

> +       const char *fname = "/sys/kernel/debug/tracing/events/%s/%s_libbpf_%d/id";
> +
> +       snprintf(file, sizeof(file), fname,
> +                is_retprobe ? "kretprobes" : "kprobes",
> +                func_name, getpid());
> +
> +       return parse_uint_from_file(file, "%d\n");
> +}
> +
>  static int determine_kprobe_perf_type(void)
>  {
>         const char *file = "/sys/bus/event_source/devices/kprobe/type";
> @@ -9197,6 +9270,41 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
>         return pfd;
>  }
>
> +static int perf_event_kprobe_open_legacy(bool retprobe, const char *name, uint64_t offset, int pid)
> +{
> +       struct perf_event_attr attr = {};
> +       char errmsg[STRERR_BUFSIZE];
> +       int type, pfd, err;
> +
> +       err = add_kprobe_event_legacy(name, retprobe, offset);
> +       if (err < 0) {
> +               pr_warn("failed to add legacy kprobe event: %s\n",
> +                       libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> +               return err;
> +       }
> +       type = determine_kprobe_perf_type_legacy(name, retprobe);
> +       if (type < 0) {
> +               pr_warn("failed to determine legacy kprobe event id: %s\n",
> +                       libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
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
>  struct bpf_link *
>  bpf_program__attach_kprobe_opts(struct bpf_program *prog,
>                                 const char *func_name,
> @@ -9208,6 +9316,7 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
>         unsigned long offset;
>         bool retprobe;
>         int pfd, err;
> +       bool legacy;
>
>         if (!OPTS_VALID(opts, bpf_kprobe_opts))
>                 return libbpf_err_ptr(-EINVAL);
> @@ -9216,8 +9325,16 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
>         offset = OPTS_GET(opts, offset, 0);
>         pe_opts.user_ctx = OPTS_GET(opts, user_ctx, 0);
>
> -       pfd = perf_event_open_probe(false /* uprobe */, retprobe, func_name,
> -                                   offset, -1 /* pid */);
> +       legacy = determine_kprobe_legacy();
> +       if (!legacy) {
> +               pfd = perf_event_open_probe(false /* uprobe */,
> +                                           retprobe, func_name,
> +                                           offset, -1 /* pid */);
> +       } else {
> +               pfd = perf_event_kprobe_open_legacy(retprobe, func_name,
> +                                                   0 /* offset */,
> +                                                  -1 /* pid */);
> +       }
>         if (pfd < 0) {
>                 pr_warn("prog '%s': failed to create %s '%s' perf event: %s\n",
>                         prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
> @@ -9233,6 +9350,12 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
>                         libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
>                 return libbpf_err_ptr(err);
>         }
> +       if (legacy) {
> +               struct bpf_link_perf *perf_link = container_of(link, struct bpf_link_perf, link);

empty line between variable declaration and statements

> +               perf_link->legacy_name = strdup(func_name);

check NULL, could be ENOMEM. Probably easier to allocate this at the
beginning, before we do heavy-lifting of perf_event_open(), clean up
will be simpler.

> +               perf_link->is_retprobe = retprobe;
> +       }
> +
>         return link;
>  }
>
> --
> 2.30.2
>
