Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FC540A587
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 06:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhINEpb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 00:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbhINEpa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 00:45:30 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA27C061574
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 21:44:13 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id s11so25238262yba.11
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 21:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zBRF/Q4UDq6qWGJVQ4xEPIl6+1XBDtPb0u0nGf78xvs=;
        b=hZeRKbrgBjhfm++JECuu5RJCEz3mO35CZSDfphz+wdJODpTKXRIGfqGlat9pDOYHZ0
         w54kDKSS82D4ubiZhO6Hu2FxL/58jL9LH+E7b5VGx7QViPezb52txqQjHjOiebpEYea3
         +8/q9ih4009slBUFOCOqbHdHLuEh6S7LuESR8ZPpSxQygHxO4m6ciK0pma9FuVScN9Ge
         31PtKwXt3wQOxIj1GOemavmc6V1XUgR0rMuv6wTINzsjvU087epZTKiaepA+lB4IDUdu
         PcG9Qs4DVqtPamTdE9TGak+9Hv0PraH2wTpUrigzI/Ff1+OVIm28Gs/R2L/KUNcst6kS
         cAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBRF/Q4UDq6qWGJVQ4xEPIl6+1XBDtPb0u0nGf78xvs=;
        b=Kd438fQ5MsCK0SDbidhgPh0x0ktI80hYh188xOJJRPwT3cYAm4Lg2Lz85GJoshfPjp
         02Bod+JLrjbB+mmshTzH2hhiPqpnItui+CPyr69NnMev0ZyPqj3EyoBBEBlUPgLa/ALM
         nu49RRkextVk+auAHRuCuVhw84iJS0vvSKwyhaV3b+95/F+p4kglR4WH1bOOqmzM8wtp
         CJFAE4Wb71ftdUrOw9hf9TzKoIOEldYkngAx5q2MlKvq6YQFS57KQ4zJw/qd+IOGCocB
         h7Oo5AodQe9jV7nl2B4JnTZkdC4RM7g4C7/vPZbnQDevjT5XNJwq0BRQEb8HLWOpa+43
         6v4g==
X-Gm-Message-State: AOAM530aGQbkcWq+es9CyK5PXdPiiZTO7kCG7YAy/ogXqXGv6jw8x72G
        DPvhJUjmWDXJoJVg/wyQfA3wdy1ZGim7CPl1fFI4rCKcTJ8=
X-Google-Smtp-Source: ABdhPJxsWs+kP1zE6kOVcKwyrfbo79PeZisB1SX83xtPXLaMZP+o+IJhDsC4eVAzLrsvK+u2cdnDp/rLJv4VQRtcdj4=
X-Received: by 2002:a25:bbc4:: with SMTP id c4mr20916082ybk.114.1631594652815;
 Mon, 13 Sep 2021 21:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzYPNsgMMU9Xi-Ya53-264MYrQNWWQNAyDJqNEgawk+V-g@mail.gmail.com>
 <20210912064844.3181742-1-rafaeldtinoco@gmail.com>
In-Reply-To: <20210912064844.3181742-1-rafaeldtinoco@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Sep 2021 21:44:01 -0700
Message-ID: <CAEf4BzYpyuw4Bw5+Avx_qmNyrRqgXKRH+MJQ91CPLv9ftBhLhg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] libbpf: introduce legacy kprobe events support
To:     Rafael David Tinoco <rafaeldtinoco@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Sep 11, 2021 at 11:48 PM Rafael David Tinoco
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
> This enables CO-RE support for older kernels.
>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Rafael David Tinoco <rafaeldtinoco@gmail.com>
> ---

I've adjusted the commit message a bit (this has nothing to do with
CO-RE per se, so I dropped that, for example). Also see my comments
below, I've applied all that to your patch while applying, please
check them out.

>  tools/lib/bpf/libbpf.c | 141 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 135 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 88d8825fc6f6..780a45e54572 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8987,9 +8987,57 @@ int bpf_link__unpin(struct bpf_link *link)
>         return 0;
>  }
>
> +static int poke_kprobe_events(bool add, const char *name, bool retprobe, uint64_t offset)
> +{
> +       int fd, ret = 0;
> +       pid_t p = getpid();
> +       char cmd[192] = {}, probename[128] = {}, probefunc[128] = {};

cmd and probename don't need initialization, and for probefunc it's
cheaper to just do probefunc[0] = '\0' separately to avoid zeroing out
all 128 characters

> +       const char *file = "/sys/kernel/debug/tracing/kprobe_events";
> +
> +       if (retprobe)
> +               snprintf(probename, sizeof(probename), "kretprobes/%s_libbpf_%u", name, p);
> +       else
> +               snprintf(probename, sizeof(probename), "kprobes/%s_libbpf_%u", name, p);
> +
> +       if (offset)
> +               snprintf(probefunc, sizeof(probefunc), "%s+%lu", name, offset);

(size_t)offset and %zu is necessary to avoid compilation warnings on
some architectures (e.g., mips, I think)

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
> +       /* legacy kprobe support: keep track of probe identifier and type */
> +       char *legacy_probe_name;
> +       bool legacy_is_retprobe;
>  };
>
>  static int bpf_link_perf_detach(struct bpf_link *link)
> @@ -8997,20 +9045,26 @@ static int bpf_link_perf_detach(struct bpf_link *link)
>         struct bpf_link_perf *perf_link = container_of(link, struct bpf_link_perf, link);
>         int err = 0;
>
> -       if (ioctl(perf_link->perf_event_fd, PERF_EVENT_IOC_DISABLE, 0) < 0)
> -               err = -errno;
> +       ioctl(perf_link->perf_event_fd, PERF_EVENT_IOC_DISABLE, 0);

what's the reason for dropping the error check? I kept it, but please
let me know if there is any reason to drop it

>
>         if (perf_link->perf_event_fd != link->fd)
>                 close(perf_link->perf_event_fd);
>         close(link->fd);
>
> -       return libbpf_err(err);
> +       /* legacy kprobe needs to be removed after perf event fd closure */
> +       if (perf_link->legacy_probe_name) {
> +               err = remove_kprobe_event_legacy(perf_link->legacy_probe_name,
> +                                                perf_link->legacy_is_retprobe);
> +       }
> +
> +       return err;
>  }
>
>  static void bpf_link_perf_dealloc(struct bpf_link *link)
>  {
>         struct bpf_link_perf *perf_link = container_of(link, struct bpf_link_perf, link);
>
> +       free(perf_link->legacy_probe_name);
>         free(perf_link);
>  }
>
> @@ -9124,6 +9178,25 @@ static int parse_uint_from_file(const char *file, const char *fmt)
>         return ret;
>  }
>
> +static bool determine_kprobe_legacy(void)
> +{
> +       const char *file = "/sys/bus/event_source/devices/kprobe/type";
> +
> +       return access(file, 0) == 0 ? false : true;

this is almost the same as what determine_kprobe_perf_type() does, so
we can just reuse it

> +}
> +
> +static int determine_kprobe_perf_type_legacy(const char *func_name, bool is_retprobe)
> +{
> +       char file[192];
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
> @@ -9206,6 +9279,41 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
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
> @@ -9215,8 +9323,9 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
>         char errmsg[STRERR_BUFSIZE];
>         struct bpf_link *link;
>         unsigned long offset;
> -       bool retprobe;
> +       bool retprobe, legacy;
>         int pfd, err;
> +       char *legacy_probe = NULL;
>
>         if (!OPTS_VALID(opts, bpf_kprobe_opts))
>                 return libbpf_err_ptr(-EINVAL);
> @@ -9225,8 +9334,21 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
>         offset = OPTS_GET(opts, offset, 0);
>         pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
>
> -       pfd = perf_event_open_probe(false /* uprobe */, retprobe, func_name,
> -                                   offset, -1 /* pid */, 0 /* ref_ctr_off */);
> +       legacy = determine_kprobe_legacy();
> +       if (!legacy) {
> +               pfd = perf_event_open_probe(false /* uprobe */,
> +                                           retprobe, func_name,
> +                                           offset, -1 /* pid */,
> +                                           0 /* ref_ctr_off */);
> +       } else {
> +               legacy_probe = strdup(func_name);
> +               err = libbpf_get_error(legacy_probe);
> +               if (err)
> +                       return libbpf_err_ptr(err);

let's not use libbpf_get_error() to check libc errors. Should be just
if (!legacy_probe)


> +               pfd = perf_event_kprobe_open_legacy(retprobe, func_name,
> +                                                  0 /* offset */,

gotta use the actual offset

> +                                                  -1 /* pid */);
> +       }
>         if (pfd < 0) {
>                 pr_warn("prog '%s': failed to create %s '%s' perf event: %s\n",
>                         prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
> @@ -9242,6 +9364,13 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
>                         libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
>                 return libbpf_err_ptr(err);
>         }
> +       if (legacy) {
> +               struct bpf_link_perf *perf_link = container_of(link, struct bpf_link_perf, link);
> +
> +               perf_link->legacy_probe_name = legacy_probe;
> +               perf_link->legacy_is_retprobe = retprobe;
> +       }
> +
>         return link;
>  }
>
> --
> 2.30.2
>
