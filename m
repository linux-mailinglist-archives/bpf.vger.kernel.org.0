Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDF43CF0D9
	for <lists+bpf@lfdr.de>; Tue, 20 Jul 2021 02:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbhGSX6Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Jul 2021 19:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378444AbhGSXhQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Jul 2021 19:37:16 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB5BC08EBB4
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 17:10:59 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p22so30434184yba.7
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 17:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f1LYlveBFicZVaUr3iwPelkh8/Tvyo0xDy3WLV4VFjo=;
        b=hUTYDAFLIToK0AwXh12zl66SyppQ46A0nJ6YnE5agpBZw2aTeBPInt6TwfiyvTBEQ3
         aqXjMDVgBo86u/IUdtATjp4VUVDDkEhJ7N3xSjSFaOu4vHUQALUXbk2BqcfyX0CJNKah
         aRzGVxv5MKBlucsxMHH9iqDLwG1YQ/sutBIa9NAWObQ8mCR+5ldaepmMlD7HZiBRfKoc
         n12/98FmzIdhNtC+p7/d97UNcyJIN+zpymTWLx8/9eNxAQdLMZTc4OM4AXyiEScnD2/u
         dxHnakKrxSd3JngV9+wmXbSiMVEm+ENiuzqKJV1NkKaXr8O7Ox9wLg1Ao89wwutm0eop
         fLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1LYlveBFicZVaUr3iwPelkh8/Tvyo0xDy3WLV4VFjo=;
        b=Co3CW8BU7bPxrSlZtS1Wn+44YakMxgTac/GT/0YG0/8m0T1NyS2IiVAUwFMhgU9T44
         TOL1c4KGFdPcUJ1sgctZHqzYxCJwMMj7sdd172V7bd+O9vSDCOmqzECFXZE1Z9A81J6t
         fW6YSUt00UrOcFdgK98eHADaqB2HtMTfWCd8Le0DQ0zOq03XU09b+Do8vhx33W8HuKvK
         THA65k2iypT/MAL2dm+SbmRYLhP8Ct9yuKTq5xxd4vRNV3wiXMcQHBiXBhCpKyLxn3Ve
         kmKq8NvyNk4S7h5C3lFH7P954ZYOxBWGuh/1UgrY/6L8T4S4onskAy44ORS1q9Ci9WBt
         gyZw==
X-Gm-Message-State: AOAM533ZUxawBEMoETItJkV1GX9qsI4yGDx6fAEnEVmVvGVz88bdkF+Q
        VROK8OK/rGm6fwBrNiSciIshQtoLxOj2fNTf54k=
X-Google-Smtp-Source: ABdhPJxoP7BRlWrlzYtic0NVj5MHg3JLqabgAklvBUU9yg2c9KcRIs7BzYh1Ntd2gzdaBgMKWkw5Q3yX3vzkVtpnbt0=
X-Received: by 2002:a25:d349:: with SMTP id e70mr35013467ybf.510.1626739858699;
 Mon, 19 Jul 2021 17:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzYQcD8vrTkXSgwBVGhRKvSWM6KyNc07QthK+=60+vUf8w@mail.gmail.com>
 <20210625044459.1249282-1-rafaeldtinoco@gmail.com> <CAEf4BzYz4BJp8beyoKD03ao4PuvuDg+QpMszeJSGrqPC==JoGw@mail.gmail.com>
 <701c5dea-2db9-4df8-888b-9e10c854afc3@www.fastmail.com>
In-Reply-To: <701c5dea-2db9-4df8-888b-9e10c854afc3@www.fastmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 19 Jul 2021 17:10:47 -0700
Message-ID: <CAEf4BzaVrMcLe-0FowM1upkRfBePnJiksmc3vfKvbAFFUFscoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] libbpf: introduce legacy kprobe events support
To:     Rafael David Tinoco <rafaeldtinoco@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jul 18, 2021 at 6:59 PM Rafael David Tinoco
<rafaeldtinoco@gmail.com> wrote:
>
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -10007,6 +10007,10 @@ struct bpf_link {
> > >         char *pin_path;         /* NULL, if not pinned */
> > >         int fd;                 /* hook FD, -1 if not applicable */
> > >         bool disconnected;
> > > +       struct {
> > > +               char *name;
> > > +               bool retprobe;
> > > +       } legacy;
> >
> > we shouldn't extend common bpf_link with kprobe-specific parts. We
> > used to have something like this (for other use cases):
> >
> > struct bpf_link_kprobe {
> >     struct bpf_link link;
> >     char *legacy_name;
> >     bool is_retprobe;
> > };
>
> would this:
>
> struct bpf_link {
>     int (*detach)(struct bpf_link *link);
>     int (*destroy)(struct bpf_link *link);
>     char *pin_path;
>     int fd;
>     bool disconnected;
> };
>
> struct bpf_link_kprobe {
>     char *legacy_name;
>     bool is_retprobe;
>     struct bpf_link *link;
> };
>
> be ok ?

No.

>
> > And then internally do container_of() to "cast" struct bpf_link to
> > struct bpf_link_kprobe. External API should still operate on struct
> > bpf_link everywhere.
>
> and what about this:
>
> static struct bpf_link*
> bpf_program__attach_kprobe_opts(struct bpf_program *prog,
>                                 const char *func_name,
>                                 struct bpf_program_attach_kprobe_opts *opts)
> {
>         char errmsg[STRERR_BUFSIZE];
>         struct bpf_link_kprobe *kplink;
>         int pfd, err;
>         bool legacy;
>
>         legacy = determine_kprobe_legacy();
>         if (!legacy) {
>                 pfd = perf_event_open_probe(false /* uprobe */,
>                                             opts->retprobe,
>                                             func_name,
>                                             0 /* offset */,
>                                             -1 /* pid */);
>         } else {
>                 pfd = perf_event_open_kprobe_legacy(opts->retprobe,
>                                                     func_name,
>                                                     0 /* offset */,
>                                                     -1 /* pid */);
>         }
>         if (pfd < 0) {
>                 pr_warn("prog '%s': failed to create %s '%s' perf event: %s\n",
>                         prog->name, opts->retprobe ? "kretprobe" : "kprobe", func_name,
>                         libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
>                 return libbpf_err_ptr(pfd);
>         }
>         kplink = calloc(1, sizeof(struct bpf_link_kprobe));
>         if (!kplink)
>                 return libbpf_err_ptr(-ENOMEM);
>         kplink->link = bpf_program__attach_perf_event(prog, pfd);
>         err = libbpf_get_error(link);
>         if (err) {
>                 free(kplink);
>                 close(pfd);
>                 pr_warn("prog '%s': failed to attach to %s '%s': %s\n",
>                         prog->name, opts->retprobe ? "kretprobe" : "kprobe", func_name,
>                         libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
>                 return libbpf_err_ptr(err);
>         }
>         if (legacy) {
>                 kplink->legacy_name = strdup(func_name);
>                 kplink->is_retprobe = opts->retprobe;
>         }
>
>         return kplink->link;
> }
>
> And use this 'kplink->link' pointer as the bpf_link pointer for all kprobe
> functions. For the detachment we would have something like:
>
> static int bpf_link__detach_perf_event(struct bpf_link *link) {
>         struct bpf_link *const *plink;
>         struct bpf_link_kprobe *kplink;
>         int err;
>
>         plink = (struct bpf_link *const *) link;
>         kplink = container_of(plink, struct bpf_link_kprobe, link);

Did you check if this works? Also how that could ever even work for
non-kprobe but perf_event-based cases, like tracepoint? And why are we
even discussing these "alternatives"? What's wrong with the way I
proposed earlier? For container_of() to work you have to do it the way
I described in my previous email with one struct being embedded in
another one.

>         err = ioctl(link->fd, PERF_EVENT_IOC_DISABLE, 0);
>         if (err)
>                 err = -errno;
>         close(link->fd);
>         if (kplink) {
>                 remove_kprobe_event_legacy(kplink->legacy_name, kplink->is_retprobe);
>                 free(kplink->legacy_name);
>                 free(kplink);
>         }
>
>         return libbpf_err(err);
> }
>
> for the bpf_link__detach_perf_event(): This would also clean the container at
> the detachment. (Next comment talks about having this here versus having a
> legacy kprobe detachment callback).
>
> [snip]
>
> > >  static int bpf_link__detach_perf_event(struct bpf_link *link)
> > >  {
> > >         int err;
> > > @@ -10152,6 +10197,12 @@ static int bpf_link__detach_perf_event(struct bpf_link *link)
> > >                 err = -errno;
> > >
> > >         close(link->fd);
> > > +
> > > +       if (link->legacy.name) {
> > > +               remove_kprobe_event_legacy(link->legacy.name, link->legacy.retprobe);
> > > +               free(link->legacy.name);
> > > +       }
> >
> > instead of this check in bpf_link__detach_perf_event, attach_kprobe
> > should install its own bpf_link__detach_kprobe_legacy callback
>
> attach_kprobe_opts() could pass a pointer to link->detach->callback through the
> opts I suppose (or now, the kplink->link->detach->callback). This way the
> default would still be bpf_link__detach_perf_event() but we could create a
> function bpf_link__detach_perf_event_legacy_kprobe() with what was previously
> showed (about kplink freeing). This is not needed with the version showed
> before the [snip] though.
>
> > > +static int perf_event_open_probe_legacy(bool uprobe, bool retprobe, const char *name,
> > > +                                       uint64_t offset, int pid)
> >
> > you are not using offset here, let's pass it into
> > add_kprobe_event_legacy and use it when attaching as "p:kprobes/%s
> > %s+123" in poke_kprobe_events? There are separate patches that are
> > adding ability to attach kprobe at offset, so let's support that
> > (internally) from the get go for legacy case as well.
> >
> > also, it's not generic perf_event_open, it's specifically kprobe, so
> > let's call it with kprobe in the name (e.g., kprobe_open_legacy or
> > something)
>
> I'm calling it now perf_event_open_kprobe_legacy() and it calls:
>
> static inline int add_kprobe_event_legacy(const char *name, bool retprobe, uint64_t offset)
> {
>         return poke_kprobe_events(true, name, retprobe, offset);
> }
>
> and then we set {kprobes/kretprobes}/funcname_pid, also supporting offset:
>
> static int poke_kprobe_events(bool add, const char *name, bool retprobe, uint64_t offset) {
>         int fd, ret = 0;
>         char cmd[192] = {}, probename[128] = {}, probefunc[128] = {};
>         const char *file = "/sys/kernel/debug/tracing/kprobe_events";
>
>         if (retprobe)
>                 ret = snprintf(probename, sizeof(probename), "kretprobes/%s_libbpf_%u", name, getpid());
>         else
>                 ret = snprintf(probename, sizeof(probename), "kprobes/%s_libbpf_%u", name, getpid());
>         if (offset)
>                 ret = snprintf(probefunc, sizeof(probefunc), "%s+%lu", name, offset);
>         if (ret)
>                 return -EINVAL;
>         if (add) {
>                 snprintf(cmd, sizeof(cmd), "%c:%s %s",
>                                  retprobe ? 'r' : 'p',
>                                  probename,
>                          offset ? probefunc : name);
>         } else {
>                 snprintf(cmd, sizeof(cmd), "-:%s", probename);
>         }
>         fd = open(file, O_WRONLY | O_APPEND, 0);
>         if (!fd)
>                 return -errno;
>         ret = write(fd, cmd, strlen(cmd));
>         if (ret)
>                 ret = -errno;
>         close(fd);
>
>         return ret;
> }
>
> [snip]
>
> > > +               pfd = perf_event_open_probe(false /* uprobe */,
> > > +                                           retprobe, func_name,
> > > +                                            0 /* offset */,
> > > +                                           -1 /* pid */);
> > > +       else
> > > +               pfd = perf_event_open_probe_legacy(false /* uprobe */,
> > > +                                           retprobe, func_name,
> > > +                                            0 /* offset */,
> > > +                                           -1 /* pid */);
> > >         if (pfd < 0) {
> > >                 pr_warn("prog '%s': failed to create %s '%s' perf event: %s\n",
> > >                         prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
> >
> > we can't use bpf_program__attach_perf_event as is now, because we need
> > to allocate a different struct bpf_link_kprobe.
>
> We could do the container encapsulation using heap in
> bpf_program_attach_kprobe_opts() or attach_kprobe() like I'm showing here, no ?
>
> ...
>         kplink = calloc(1, sizeof(struct bpf_link_kprobe));
>         if (!kplink)
>                 return libbpf_err_ptr(-ENOMEM);
>         kplink->link = bpf_program__attach_perf_event(prog, pfd);
> ...
>
> and then free all this structure (bpf_link and its encapsulation at the
> detachment, like said previously also). This way we don't have to change
> bpf_program__attach_perf_event() which would continue to serve
> bpf_program__attach_tracepoint() and bpf_program__attach_uprobe() unmodified.
> This way, kprobe would have a container for all cases and uprobe and tracepoint
> could have a container in the future if needed.
>
> > Let's extract the
> > PERF_EVENT_IOC_SET_BPF and PERF_EVENT_IOC_ENABLE logic into a helper
> > and use it from both bpf_program__attach_perf_event and
> > bpf_program__attach_kprobe. It's actually good because we can check
> > silly errors (like prog_fd < 0) before we create perf_event FD now.
>
> Okay, but I'm considering this orthogonal to what you said previously (on
> changing bpf_program__attach_perf_event). UNLESS you really prefer me to do the
> container allocation in bpf_program__attach_perf_event() but then we would have
> to free the container in all detachments (kprobe, tracepoint and uprobe) as it
> couldn't be placed in stack (or it would eventually be lost, no ?).

container will be different for kprobe/uprobe and
tracepoint/perf_event. So allocation has to happen separately from
PERF_EVENT_IOC_SET_BPF and PERF_EVENT_IOC_ENABLE.
