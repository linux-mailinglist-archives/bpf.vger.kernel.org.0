Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE20D3577C0
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 00:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhDGWds (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Apr 2021 18:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhDGWdr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Apr 2021 18:33:47 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53EAC061760
        for <bpf@vger.kernel.org>; Wed,  7 Apr 2021 15:33:37 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id o10so429076ybb.10
        for <bpf@vger.kernel.org>; Wed, 07 Apr 2021 15:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QJ1G2EgIrFWfkx/xn41m0GKnCDwd1K5B3IOA7oVaqqE=;
        b=L/4Ty+IJBcbseOIE/5xJ8R5H1Dfc3bi1R1h5wdvx8eDpNjK2smOWHIU7+hBGGvlzdX
         voBDsDHrxh9YoWQbMcK0zuXw3ReA1c+ygM3cdVHg0hHZ2hZAMZitSTETXrC+9rqV7z1L
         kJex0Ndi+xJnltWeFKkP696OD4FW7xiF1g4w5+W5DZwT1XGGevfecnxOctiSGfw7UtHe
         STYCdA14SXkV2AOhnUVg7jQ6SCAYAdeIgcWcbCDRz1XjoC4cCVC/djAnyRhgH2NXCa/w
         RAEDihVPfsUhb1T1pZdqX+i3y6ErIU5V+0g91FsXUHek9VHdyyQGDk3kU+xcK3VwJo83
         qkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QJ1G2EgIrFWfkx/xn41m0GKnCDwd1K5B3IOA7oVaqqE=;
        b=VkaQeV5bUv7y2ao1LXOyI4IK8WiU8cm7sp9QQeBn4MIrDI/SC3QkHmW7bijGC3LjXZ
         E/o5XRtBwbQEGiPIwTB1o9Dy0Cm5Z0HuS5bFC6I5FTFFHxiNueeEMhz6CG3RfsU3wm3O
         yXDrW3JfGj335NzObU0fKALM3m6/PMIs8nfKelLBhNCSw+S1p8Rd0fjB2E0RGxV5k7tM
         QmK++L9xy9oaqss4tQ8n2QZ4lx6g9q2GsDzLRHub4iJPb4wqB+/URWgo636uB+Uj4hYX
         kDK9yqY3GGK8oekCVEJ7u1M9nho4FgZFe3S736Kev3iUOfTG9w8nlVGaQgc1IWCzrhjW
         urVw==
X-Gm-Message-State: AOAM531PPkWOMBNESAgkO16ZK20kUB5IZm2irT0BNw0jzN+T+no9+0Tq
        +JBKOuOCZiM4pqgI4P3LOCwEdtvtZnXK6dptM7AxC1zq
X-Google-Smtp-Source: ABdhPJwBjvHDdKu0adFdqhQnWEy1tKYxC0Xzc5q8pO4Pxpzud8VnBnzKmuE2Xtjsdxn4m5xl/4ihakBL3GlCBJb/rp4=
X-Received: by 2002:a25:9942:: with SMTP id n2mr7552049ybo.230.1617834817020;
 Wed, 07 Apr 2021 15:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4Bzap6qS9_HQZTHJsM-X2VZso+N5xMwa3HNG9ycMW4WXtQg@mail.gmail.com>
 <20210322180441.1364511-1-rafaeldtinoco@ubuntu.com> <4BB60234-7970-405C-9447-D19CA6564BC2@ubuntu.com>
 <CAEf4BzaimrGXFrfFVHvV53ta7NwDWsN0YHcDiVJELEnbdjmKdg@mail.gmail.com> <045DF0ED-10A2-4D9F-AA01-5CE7E3E95193@ubuntu.com>
In-Reply-To: <045DF0ED-10A2-4D9F-AA01-5CE7E3E95193@ubuntu.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Apr 2021 15:33:22 -0700
Message-ID: <CAEf4BzbPdH+pV9NpCW+piROOfCme=erGQOHs8XcA_e=pYcV2=g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next][RFC] libbpf: introduce legacy kprobe events support
To:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Cc:     LKML BPF <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 6, 2021 at 9:49 PM Rafael David Tinoco
<rafaeldtinoco@ubuntu.com> wrote:
>
> Sorry taking so long for replying on this=E2=80=A6 have been working in:
> https://github.com/rafaeldtinoco/conntracker/tree/main/ebpf
> as a consumer for the work being proposed by this patch.
>
> Current working version at:
> https://github.com/rafaeldtinoco/conntracker/blob/main/ebpf/patches/libbp=
f-introduce-legacy-kprobe-events-support.patch
> About to be changed with suggestions from this thread.
>
> >>> --- a/src/libbpf.c
> >>> +++ b/src/libbpf.c
> >>> @@ -9465,6 +9465,10 @@ struct bpf_link {
> >>>       char *pin_path;         /* NULL, if not pinned */
> >>>       int fd;                 /* hook FD, -1 if not applicable */
> >>>       bool disconnected;
> >>> +     struct {
> >>> +             const char *name;
> >>> +             bool retprobe;
> >>> +     } legacy;
> >>>  };
> >>
> >> For bpf_link->detach() I needed func_name somewhere.
> >
> > Right, though it's not func_name that you need, but "event_name".
>
> Yep.
>
> > Let's add link ([0]) to poke_kprobe_events somewhere, and probably
> > event have example full syntax of all the commands:
> >
> >  p[:[GRP/]EVENT] [MOD:]SYM[+offs]|MEMADDR [FETCHARGS]  : Set a probe
> >  r[MAXACTIVE][:[GRP/]EVENT] [MOD:]SYM[+0] [FETCHARGS]  : Set a return p=
robe
> >  p:[GRP/]EVENT] [MOD:]SYM[+0]%return [FETCHARGS]       : Set a return p=
robe
> >  -:[GRP/]EVENT                                         : Clear a probe
> >
> >   [0] https://www.kernel.org/doc/html/latest/trace/kprobetrace.html
>
> Add [0] as a comment you say (as a reference) ? Or you mean to alter
> the way I=E2=80=99m writing to kprobe_events file in a more complete way =
?

As a reference.

>
> > Now, you should not extend bpf_link itself. Create bpf_link_kprobe,
> > that will have those two extra fields. Put struct bpf_link as a first
> > field of bpf_link_kprobe. We used to have bpf_link_fd, you can try to
> > find it in Git history to see how it was done.
>
> Will do.
>

[...]

> > So I don't get at all why you have these toggles, especially
> > ALL_TOGGLE? You shouldn't try to determine the state of another probe.
> > You always know whether you want to enable or disable your specific
> > toggle. I'm very confused by all this.
>
> Yes, this was a confusing thing indeed and to be honest it proved to
> be very buggy when testing with conntracker. What I=E2=80=99ll do (or I=
=E2=80=99m
> doing) is to toggle ON to needed files before the probe is added:
>
> static inline int add_kprobe_event_legacy(const char* func_name, bool
> retprobe)
> {
>         int ret =3D 0;
>
>         ret |=3D poke_kprobe_events(true, func_name, retprobe);
>         ret |=3D toggle_kprobe_event_legacy_all(true);
>         ret |=3D toggle_single_kprobe_event_legacy(true, func_name, retpr=
obe);
>
>         return ret;
> }
>
> 1) /sys/kernel/debug/tracing/kprobe_events =3D> 1
> 2) /sys/kernel/debug/tracing/events/kprobes/enable =3D> 1
> 3) /sys/kernel/debug/tracing/events/kprobes/%s/enable =3D> 1

Ok, hold on. I don't think we should use those /enable files,
actually. Double-checking what BCC does ([0]) and my local demo app I
wrote a while ago, we use perf_event_open() to activate kprobe, once
it is created, and that's all that is necessary.

  [0] https://github.com/iovisor/bcc/blob/master/src/cc/libbpf.c#L1046

>
> And toggle off only kprobe_event:
>
> static inline int remove_kprobe_event_legacy(const char* func_name, bool
> retprobe)
> {
>         int ret =3D 0;
>
>         ret |=3D toggle_single_kprobe_event_legacy(false, func_name, retp=
robe);
>         ret |=3D poke_kprobe_events(false, func_name, retprobe);
>
>         return ret;
> }
>
> 1) /sys/kernel/debug/tracing/events/kprobes/%s/enable =3D> 0
>
> This is working good for my tests.
>
> >
> >>> +static int kprobe_event_normalize(char *newname, size_t size, const =
char
> >>> *name, bool retprobe)
> >>> +{
> >>> +     int ret =3D 0;
> >>> +
> >>> +     if (IS_ERR(name))
> >>> +             return -1;
> >>> +
> >>> +     if (retprobe)
> >>> +             ret =3D snprintf(newname, size, "kprobes/%s_ret", name)=
;
> >>> +     else
> >>> +             ret =3D snprintf(newname, size, "kprobes/%s", name);
> >>> +
> >>> +     if (ret <=3D strlen("kprobes/"))
> >>> +             ret =3D -errno;
> >>> +
> >>> +     return ret;
> >>> +}
> >>> +
> >>> +static int toggle_single_kprobe_event_legacy(bool on, const char *na=
me,
> >>> bool retprobe)
> >
> > don't get why you need this function either...
>
> Because of /sys/kernel/debug/tracing/events/kprobes/%s/enable. I=E2=80=99=
m
> toggling it to OFF before removing the kprobe in kprobe_events, like
> showed above.

Alright, see above about enable files, it doesn't seem necessary,
actually. You use poke_kprobe_events() to add or remove kprobe to the
kernel. That gives you event_name and its id (from
/sys/kernel/debug/tracing/events/kprobes/%s/id). You then use that id
to create perf_event and activate BPF program:

  struct perf_event_attr attr;
  struct bpf_link* link;
  int fd =3D -1, err, id;
  FILE* f =3D NULL;

  err =3D poke_kprobe_events(true /*add*/, func_name, is_kretprobe);
  if (err) {
    fprintf(stderr, "failed to create kprobe event: %d\n", err);
    return NULL;
  }

  snprintf(
      fname,
      sizeof(fname),
      "/sys/kernel/debug/tracing/events/kprobes/%s/id",
      func_name);
  f =3D fopen(fname, "r");
  if (!f) {
    fprintf(stderr, "failed to open kprobe id file '%s': %d\n", fname, -err=
no);
    goto err_out;
  }

  if (fscanf(f, "%d\n", &id) !=3D 1) {
    fprintf(stderr, "failed to read kprobe id from '%s': %d\n", fname, -err=
no);
    goto err_out;
  }

  fclose(f);
  f =3D NULL;

  memset(&attr, 0, sizeof(attr));
  attr.size =3D sizeof(attr);
  attr.config =3D id;
  attr.type =3D PERF_TYPE_TRACEPOINT;
  attr.sample_period =3D 1;
  attr.wakeup_events =3D 1;

  fd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEX=
EC);
  if (fd < 0) {
    fprintf(
        stderr,
        "failed to create perf event for kprobe ID %d: %d\n",
        id,
        -errno);
    goto err_out;
  }

  link =3D bpf_program__attach_perf_event(prog, fd);

And that should be it. It doesn't seem like either BCC or my example
(which I'm sure worked last time) does anything with /enable files and
I'm sure all that works.

[...]

> >>>      return bpf_program__attach_kprobe(prog, retprobe, func_name);
> >>>  }
> >>
> >> I=E2=80=99m assuming this is okay based on your saying of detecting a =
feature
> >> instead of using the if(x) if(y) approach.
> >>
> >>> @@ -11280,4 +11629,7 @@ void bpf_object__destroy_skeleton(struct
> >>> bpf_object_skeleton *s)
> >>>       free(s->maps);
> >>>       free(s->progs);(),
> >>>       free(s);
> >>> +
> >>> +     remove_kprobe_event_legacy("ip_set_create", false);
> >>> +     remove_kprobe_event_legacy("ip_set_create", true);
> >>
> >> This is the main issue I wanted to show you before continuing.
> >> I cannot remove the kprobe event unless the obj is unloaded.
> >> That is why I have this hard coded here, just because I was
> >> testing. Any thoughts how to cleanup the kprobes without
> >> jeopardising the API too much ?
> >
> > cannot as in it doesn't work for whatever reason? Or what do you mean?
> >
> > I see that you had bpf_link__detach_perf_event_legacy calling
> > remove_kprobe_event_legacy, what didn't work?
> >
>
> I=E2=80=99m sorry for not being very clear here. What happens is that, if=
 I
> try to remove the kprobe_event_legacy() BEFORE:
>
> if (s->progs)
>         bpf_object__detach_skeleton(s);
> if (s->obj)
>         bpf_object__close(*s->obj);
>
> It fails with generic write error on kprobe_events file. I need to
> remove legacy kprobe AFTER object closure. To workaround this on
> my project, and to show you this issue, I have come up with:
>
> void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
> {
>          int i, j;
>          struct probeleft {
>                  char *probename;
>                  bool retprobe;
>          } probesleft[24];
>
>          for (i =3D 0, j =3D 0; i < s->prog_cnt; i++) {
>                  struct bpf_link **link =3D s->progs[i].link;
>                  if ((*link)->legacy.name) {
>                          memset(&probesleft[j], 0, sizeof(struct probelef=
t));
>                          probesleft[j].probename =3D strdup((*link)->lega=
cy.name);
>                          probesleft[j].retprobe =3D (*link)->legacy.retpr=
obe;
>                          j++;
>                  }
>          }
>
>          if (s->progs)
>                  bpf_object__detach_skeleton(s);
>          if (s->obj)
>                  bpf_object__close(*s->obj);
>          free(s->maps);
>          free(s->progs);
>          free(s);
>
>          for (j--; j >=3D 0; j--) {
>                  remove_kprobe_event_legacy(probesleft[j].probename, prob=
esleft[j].retprobe);
>                  free(probesleft[j].probename);
>          }
> }
>
> Which, of course, is not what I=E2=80=99m suggesting to the lib, but show=
s
> the problem and gives you a better idea on how to solve it not
> breaking the API.
>

bpf_link__destroy() callback should handle that, no? You'll close perf
event FD, which will "free up" kprobe and you can do
poke_kprobe_events(false /*remove */, ...). Or am I still missing
something?

> > You somehow ended up with 3 times more code and I have more questions
> > now then before. When you say "it doesn't work", please make sure to
> > explain what exactly doesn't work, what you did, what you expected to
> > happen/see.
>
> Deal. Thanks a lot for reviewing all this.
>
> -rafaeldtinoco
>
