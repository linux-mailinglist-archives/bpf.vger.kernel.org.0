Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA5A34B0CB
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 21:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhCZUvX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 16:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhCZUvL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 16:51:11 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD77C0613AA
        for <bpf@vger.kernel.org>; Fri, 26 Mar 2021 13:51:11 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id g38so7112569ybi.12
        for <bpf@vger.kernel.org>; Fri, 26 Mar 2021 13:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IHcDlLyo/IX4PONrz5cM4XXlDkcUzTDxXRMu4cwFUR0=;
        b=Y9ZUEMYhzuIJTDLldYliHaxhqiVSuN/f7Rhf3CdEFsIlHa4XAotFp3eE+nZC8Gynah
         GUCvzTXBOGF3aB9RbXafAIdn5CDMRVv1WVy10RwsYqRARvDZC3yXlrw/32tai+iif0et
         fUUtXiM+XBOsuFAcZz5GcNkrYwO9dvdbdr2FAIWcKr5KmI73uei4x8OGd7AXpv17dwIw
         yIjtsO9UK1IRZjOTyp9nEmAe1f/X3mPPEictz1XLXfAs50/GSvSc1htxJ4LO5GsSDvyt
         w7gbRnJr6WlG8Ml18bl6ZDRbiAPTkgs1SD/tgXg4oJR7hFTbriunBWooRWVIBC6w7kmt
         K2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IHcDlLyo/IX4PONrz5cM4XXlDkcUzTDxXRMu4cwFUR0=;
        b=CLPVQy6Ae19Pr8yoEe0sRRsoO5lVRFpYLovuCCoF5HbRV4KsZQyve7fQi9MPgy1ytK
         FZU3KHPhqKZD0aANyQ33VazKJ6VerZQ6xp+ubx3S1eJz4JCeNFM8wo+WYyY4cJ/KJD+4
         tTY6BtL+svO8sF9NOaDdrvHCIAb3YeIEi5EH5Y1Bct/gFOlVVaKWp9ukLMYfewlig72h
         IDhigIW6b4/nqEYilATnIek9ZIpqFr8EhDwCnFF6GOjOGAGrV1sn4QEJTWuLHYYofQh5
         mRJN9poaVzoNPymUqj+Psjgi0y/aGz/K3bZclMdU5NuFnUoekeTrgzWQgfN66Q6++kw0
         r/Gg==
X-Gm-Message-State: AOAM531fIa4Fyj6E2G2RsJfU0FiXyKK7D7x0Wa8X7j6jLzVGkaGUWj19
        W0n3IBDjPurNK4+xHOq3ec0FKfGW+rDUFksF94SewYV/e4DdWw==
X-Google-Smtp-Source: ABdhPJzUkQ4QK4TIiJ/j6+CvrqhGCnqozEUqxRVBvORusIvvfcVb9e9Mio5IoAz4H4nWNVumdemO+2eknJnxdhAr5sE=
X-Received: by 2002:a25:4982:: with SMTP id w124mr21120883yba.27.1616791870374;
 Fri, 26 Mar 2021 13:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4Bzap6qS9_HQZTHJsM-X2VZso+N5xMwa3HNG9ycMW4WXtQg@mail.gmail.com>
 <20210322180441.1364511-1-rafaeldtinoco@ubuntu.com> <4BB60234-7970-405C-9447-D19CA6564BC2@ubuntu.com>
In-Reply-To: <4BB60234-7970-405C-9447-D19CA6564BC2@ubuntu.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Mar 2021 13:50:59 -0700
Message-ID: <CAEf4BzaimrGXFrfFVHvV53ta7NwDWsN0YHcDiVJELEnbdjmKdg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next][RFC] libbpf: introduce legacy kprobe events support
To:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 22, 2021 at 11:25 AM Rafael David Tinoco
<rafaeldtinoco@ubuntu.com> wrote:
>
> > - This is a RFC (v2).
> > - Please check my reply with inline comments.
>
> Comments bellow=E2=80=A6 (no correct formatting for now):
>
> > ---
> >  src/libbpf.c | 362 ++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 357 insertions(+), 5 deletions(-)
> >
> > diff --git a/src/libbpf.c b/src/libbpf.c
> > index 3b1c79f..e9c6025 100644
> > --- a/src/libbpf.c
> > +++ b/src/libbpf.c
> > @@ -9465,6 +9465,10 @@ struct bpf_link {
> >       char *pin_path;         /* NULL, if not pinned */
> >       int fd;                 /* hook FD, -1 if not applicable */
> >       bool disconnected;
> > +     struct {
> > +             const char *name;
> > +             bool retprobe;
> > +     } legacy;
> >  };
>
> For bpf_link->detach() I needed func_name somewhere.

Right, though it's not func_name that you need, but "event_name".
Let's add link ([0]) to poke_kprobe_events somewhere, and probably
event have example full syntax of all the commands:

 p[:[GRP/]EVENT] [MOD:]SYM[+offs]|MEMADDR [FETCHARGS]  : Set a probe
 r[MAXACTIVE][:[GRP/]EVENT] [MOD:]SYM[+0] [FETCHARGS]  : Set a return probe
 p:[GRP/]EVENT] [MOD:]SYM[+0]%return [FETCHARGS]       : Set a return probe
 -:[GRP/]EVENT                                         : Clear a probe

  [0] https://www.kernel.org/doc/html/latest/trace/kprobetrace.html


Now, you should not extend bpf_link itself. Create bpf_link_kprobe,
that will have those two extra fields. Put struct bpf_link as a first
field of bpf_link_kprobe. We used to have bpf_link_fd, you can try to
find it in Git history to see how it was done.

And another problem -- you should allocate memory for this event_name,
not rely on the user to keep that memory for you.


>
> >
> > +static inline int remove_kprobe_event_legacy(const char*, bool);
> > +
> >  static int bpf_link__detach_perf_event(struct bpf_link *link)
> >  {
> >       int err;
> > @@ -9605,8 +9612,25 @@ static int bpf_link__detach_perf_event(struct
> > bpf_link *link)
> >       err =3D ioctl(link->fd, PERF_EVENT_IOC_DISABLE, 0);
> >       if (err)
> >               err =3D -errno;
> > -
> >       close(link->fd);
> > +
> > +     return err;
> > +}
> > +
> > +static int bpf_link__detach_perf_event_legacy(struct bpf_link *link)
> > +{
> > +     int err;
> > +
> > +     err =3D bpf_link__detach_perf_event(link);
> > +     if (err)
> > +             err =3D -errno; // improve this
> > +
> > +     /*
> > +     err =3D remove_kprobe_event_legacy(link->legacy.name,
> > link->legacy.retprobe);
> > +     if (err)
> > +             err =3D -errno;
> > +      */
> > +
> >       return err;
> >  }
>
> Unfortunately I can=E2=80=99t remove kprobe event name from kprobe_events=
,
> even if I unload it (0 >> enabled) before. It won=E2=80=99t work until th=
e
> object is fully unloaded. This is why previous version using
> bpf_program__set_priv() used to work. I=E2=80=99m showing this bellow=E2=
=80=A6
>
> Check the last lines of this to understand better.
>
> >
> > @@ -9655,6 +9679,48 @@ struct bpf_link
> > *bpf_program__attach_perf_event(struct bpf_program *prog,
> >       return link;
> >  }
> >
> > +struct bpf_link *bpf_program__attach_perf_event_legacy(struct
> > bpf_program *prog,
> > +                                                    int pfd)
> > +{
> > +     char errmsg[STRERR_BUFSIZE];
> > +     struct bpf_link *link;
> > +     int prog_fd, err;
> > +
> > +     if (pfd < 0) {
> > +             pr_warn("prog '%s': invalid perf event FD %d\n", prog->na=
me, pfd);
> > +             return ERR_PTR(-EINVAL);
> > +     }
> > +     prog_fd =3D bpf_program__fd(prog);
> > +     if (prog_fd < 0) {
> > +             pr_warn("prog '%s': can't attach BPF program w/o FD (did
> > you load it?)\n", prog->name);
> > +             return ERR_PTR(-EINVAL);
> > +     }
> > +
> > +     link =3D calloc(1, sizeof(*link));
> > +     if (!link)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     link->detach =3D &bpf_link__detach_perf_event_legacy;
>
> I created another function for all existing ones using _legacy at the end=
.
> This one in particular could have a callback function as argument that wo=
uld
> be passed to link->detach().. this way I could avoid having 2 functions
> alike.
>
> > +     link->fd =3D pfd;
> > +
> > +     if (ioctl(pfd, PERF_EVENT_IOC_SET_BPF, prog_fd) < 0) {
> > +             err =3D -errno;
> > +             free(link);
> > +             pr_warn("prog '%s': failed to attach to pfd %d: %s\n",
> > prog->name, pfd, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> > +             if (err =3D=3D -EPROTO)
> > +                     pr_warn("prog '%s': try add PERF_SAMPLE_CALLCHAIN
> > to or remove exclude_callchain_[kernel|user] from pfd %d\n", prog->name=
,
> > pfd);
> > +             return ERR_PTR(err);
> > +     }
> > +     if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
> > +             err =3D -errno;
> > +             free(link);
> > +             pr_warn("prog '%s': failed to enable pfd %d: %s\n",
> > prog->name, pfd, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> > +             return ERR_PTR(err);
> > +     }
> > +
> > +     return link;
> > +}
> > +
> >  /*
> >   * this function is expected to parse integer in the range of [0, 2^31=
-1] from
> >   * given file using scanf format string fmt. If actual parsed value is
> > @@ -9685,34 +9751,242 @@ static int parse_uint_from_file(const char
> > *file, const char *fmt)
> >       return ret;
> >  }
> >
> > +static int write_uint_to_file(const char *file, unsigned int val)
> > +{
> > +     char buf[STRERR_BUFSIZE];
> > +     int err;
> > +     FILE *f;
> > +
> > +     f =3D fopen(file, "w");
> > +     if (!f) {
> > +             err =3D -errno;
> > +             pr_debug("failed to open '%s': %s\n", file,
> > +                      libbpf_strerror_r(err, buf, sizeof(buf)));
> > +             return err;
> > +     }
> > +     err =3D fprintf(f, "%u", val);
> > +     if (err !=3D 1) {
> > +             err =3D -errno;
> > +             pr_debug("failed to write '%u' to '%s': %s\n", val, file,
> > +                     libbpf_strerror_r(err, buf, sizeof(buf)));
> > +             fclose(f);
> > +             return err;
> > +     }
> > +     fclose(f);
> > +     return 0;
> > +}
> > +
> > +#define KPROBE_PERF_TYPE     "/sys/bus/event_source/devices/kprobe/typ=
e"
> > +#define UPROBE_PERF_TYPE     "/sys/bus/event_source/devices/uprobe/typ=
e"
> > +#define KPROBERET_FORMAT
> > "/sys/bus/event_source/devices/kprobe/format/retprobe"
> > +#define UPROBERET_FORMAT
> > "/sys/bus/event_source/devices/uprobe/format/retprobe"
> > +/* legacy kprobe events related files */
> > +#define KPROBE_EVENTS                "/sys/kernel/debug/tracing/kprobe=
_events"
> > +#define KPROBE_LEG_TOGGLE    "/sys/kernel/debug/kprobes/enabled"

Not LEG, please, LEGACY

> > +#define KPROBE_LEG_ALL_TOGGLE
> > "/sys/kernel/debug/tracing/events/kprobes/enable";
> > +#define KPROBE_SINGLE_TOGGLE
> > "/sys/kernel/debug/tracing/events/kprobes/%s/enable";
> > +#define KPROBE_EVENT_ID      "/sys/kernel/debug/tracing/events/kprobes=
/%s/id";
> > +
>
> This made the life easier: to understand which files were related to what

Ok, sure, just not legs, please :)

>
> > +static bool determine_kprobe_legacy(void)
> > +{
> > +     struct stat s;
> > +
> > +     return stat(KPROBE_PERF_TYPE, &s) =3D=3D 0 ? false : true;

there is access(file, F_OK) which is nicer to use for checking file existen=
ce

> > +}
> > +
> >  static int determine_kprobe_perf_type(void)
> >  {
> > -     const char *file =3D "/sys/bus/event_source/devices/kprobe/type";
> > +     const char *file =3D KPROBE_PERF_TYPE;

just inline then, what's the point of this variable?

> >
> >       return parse_uint_from_file(file, "%d\n");
> >  }
> >
> >  static int determine_uprobe_perf_type(void)
> >  {
> > -     const char *file =3D "/sys/bus/event_source/devices/uprobe/type";
> > +     const char *file =3D UPROBE_PERF_TYPE;
> >
> >       return parse_uint_from_file(file, "%d\n");
> >  }
> >
> >  static int determine_kprobe_retprobe_bit(void)
> >  {
> > -     const char *file =3D
> > "/sys/bus/event_source/devices/kprobe/format/retprobe";
> > +     const char *file =3D KPROBERET_FORMAT;
> >
> >       return parse_uint_from_file(file, "config:%d\n");
> >  }
> >
> >  static int determine_uprobe_retprobe_bit(void)
> >  {
> > -     const char *file =3D
> > "/sys/bus/event_source/devices/uprobe/format/retprobe";
> > +     const char *file =3D UPROBERET_FORMAT;
> >
> >       return parse_uint_from_file(file, "config:%d\n");
> >  }
> >
> > +static int toggle_kprobe_legacy(bool on)
> > +{
> > +     static int refcount;
> > +     static bool initial, veryfirst;
> > +     const char *file =3D KPROBE_LEG_TOGGLE;
> > +
> > +     if (on) {
> > +             refcount++;
> > +             if (veryfirst)
> > +                     return 0;
> > +             veryfirst =3D true;
> > +             /* initial value for KPROB_LEG_TOGGLE */
> > +             initial =3D (bool) parse_uint_from_file(file, "%d\n");
> > +             return write_uint_to_file(file, 1); /* enable kprobes */
> > +     }
> > +     refcount--;
> > +     printf("DEBUG: kprobe_legacy refcount=3D%d\n", refcount);
> > +     if (refcount =3D=3D 0) {
> > +             /* off ret value back to initial value if last consumer *=
/
> > +             return write_uint_to_file(file, initial);
> > +     }
> > +     return 0;
> > +}
> > +
> > +static int toggle_kprobe_event_legacy_all(bool on)
> > +{
> > +     static int refcount;
> > +     static bool initial, veryfirst;
> > +     const char *file =3D KPROBE_LEG_ALL_TOGGLE;
> > +
> > +     if (on) {
> > +             refcount++;
> > +             if (veryfirst)
> > +                     return 0;
> > +             veryfirst =3D true;
> > +             // initial value for KPROB_LEG_ALL_TOGGLE
> > +             initial =3D (bool) parse_uint_from_file(file, "%d\n");
> > +             return write_uint_to_file(file, 1); // enable kprobes
> > +     }
> > +     refcount--;
> > +     printf("DEBUG: legacy_all refcount=3D%d\n", refcount);
> > +     if (refcount =3D=3D 0) {
> > +             // off ret value back to initial value if last consumer
> > +             return write_uint_to_file(file, initial);
> > +     }
> > +     return 0;
> > +}
>
> Same thing here: 2 functions that could be reduced to one with an
> argument to KPROB_LEG_TOGGLE or KPROB_LEG_ALL_TOGGLE.
>
> I=E2=80=99m using static initial so I can recover the original status of
> the =E2=80=9Cenable=E2=80=9D files after the program is unloaded. Unfortu=
nately
> this is not multi-task friendly as another process would
> step into this logic but I did not want to leave =E2=80=9Cenabled=E2=80=
=9D
> after we unload if it wasn=E2=80=99t before.
>
> I=E2=80=99m saying this because of your idea of having PID as the kprobe
> event names=E2=80=A6 it would have the same problem=E2=80=A6 We could, in=
 theory
> leave all =E2=80=9Cenabled=E2=80=9D files enabled (1) at the end, use PID=
 in the
> kprobe event names and unload only our events=E2=80=A6 but then I would
> leave /sys/kernel/debug/kprobes/enabled enabled even if it was
> not.. because we could be concurrent to other tasks using libbpf.

So I don't get at all why you have these toggles, especially
ALL_TOGGLE? You shouldn't try to determine the state of another probe.
You always know whether you want to enable or disable your specific
toggle. I'm very confused by all this.

>
> > +static int kprobe_event_normalize(char *newname, size_t size, const ch=
ar
> > *name, bool retprobe)
> > +{
> > +     int ret =3D 0;
> > +
> > +     if (IS_ERR(name))
> > +             return -1;
> > +
> > +     if (retprobe)
> > +             ret =3D snprintf(newname, size, "kprobes/%s_ret", name);
> > +     else
> > +             ret =3D snprintf(newname, size, "kprobes/%s", name);
> > +
> > +     if (ret <=3D strlen("kprobes/"))
> > +             ret =3D -errno;
> > +
> > +     return ret;
> > +}
> > +
> > +static int toggle_single_kprobe_event_legacy(bool on, const char *name=
,
> > bool retprobe)

don't get why you need this function either...

> > +{
> > +     char probename[32], f[96];
> > +     const char *file =3D KPROBE_SINGLE_TOGGLE;
> > +     int ret;
> > +
> > +     ret =3D kprobe_event_normalize(probename, sizeof(probename), name=
,
> > retprobe);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     snprintf(f, sizeof(f), file, probename + strlen("kprobes/"));
> > +
> > +     printf("DEBUG: writing %u to %s\n", (unsigned int) on, f);
> > +
> > +     ret =3D write_uint_to_file(f, (unsigned int) on);
> > +
> > +     return ret;
> > +}
> > +
> > +static int poke_kprobe_events(bool add, const char *name, bool retprob=
e)
> > +{
> > +     int fd, ret =3D 0;
> > +     char probename[32], cmd[96];
> > +     const char *file =3D KPROBE_EVENTS;
> > +
> > +     ret =3D kprobe_event_normalize(probename, sizeof(probename), name=
,
> > retprobe);

just have that if/else + snprintf right here, no need to jump through hoops

> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (add)
> > +             snprintf(cmd, sizeof(cmd),"%c:%s %s", retprobe ? 'r' : 'p=
',
> > probename, name);
> > +     else
> > +             snprintf(cmd, sizeof(cmd), "-:%s", probename);
> > +
> > +     printf("DEBUG: %s\n", cmd);
> > +
> > +     fd =3D open(file, O_WRONLY|O_APPEND, 0);
> > +     if (!fd)
> > +             return -errno;
> > +     ret =3D write(fd, cmd, strlen(cmd));
> > +     if (ret < 0)
> > +             ret =3D -errno;
> > +     close(fd);
> > +
> > +     return ret;
> > +}
> > +
> > +static inline int add_kprobe_event_legacy(const char* func_name, bool
> > retprobe)
> > +{
> > +     int ret =3D 0;
> > +
> > +     ret =3D poke_kprobe_events(true, func_name, retprobe);
> > +     if (ret < 0)
> > +             printf("DEBUG: poke_kprobe_events (on) error\n");
> > +
> > +     ret =3D toggle_kprobe_event_legacy_all(true);

why?... why do you need to touch the state of other probes. This will
never work reliable but also should not be required

> > +     if (ret < 0)
> > +             printf("DEBUG: toggle_kprobe_event_legacy_all (on) error\=
n");
> > +
> > +     ret =3D toggle_single_kprobe_event_legacy(true, func_name, retpro=
be);
> > +     if (ret < 0)
> > +             printf("DEBUG: toggle_single_kprobe_event_legacy (on) err=
or\n");
> > +
> > +     return ret;
> > +}
> > +
> > +static inline int remove_kprobe_event_legacy(const char* func_name, bo=
ol
> > retprobe)
> > +{
> > +     int ret =3D 0;
> > +
> > +     ret =3D toggle_kprobe_event_legacy_all(true);
> > +     if (ret < 0)
> > +             printf("DEBUG: toggle_kprobe_event_legacy_all (off) error=
\n");
> > +
> > +     ret =3D toggle_single_kprobe_event_legacy(true, func_name, retpro=
be);
> > +     if (ret < 0)
> > +             printf("DEBUG: toggle_single_kprobe_event_legacy (off) er=
ror\n");
> > +
> > +     ret =3D toggle_single_kprobe_event_legacy(false, func_name, retpr=
obe);
> > +     if (ret < 0)
> > +             printf("DEBUG: toggle_single_kprobe_event_legacy (off) er=
ror\n");
> > +
> > +     ret =3D poke_kprobe_events(false, func_name, retprobe);
> > +     if (ret < 0)
> > +             printf("DEBUG: poke_kprobe_events (off) error\n");
> > +
> > +     return ret;
> > +}
>
> I=E2=80=99m doing a =E2=80=9Cmake sure what has to be enabled to be enabl=
ed=E2=80=9D approach here.
> Please ignore all the DEBUGs, etc, I=E2=80=99ll deal with errors after it=
s good.

again, you haven't explained why. Don't touch probes you haven't created.

>
> > +
> > +static int determine_kprobe_perf_type_legacy(const char *func_name)
> > +{
> > +     char file[96];
> > +     const char *fname =3D KPROBE_EVENT_ID;

again, what's the point of this variable, just inline

and this is a problem with those #defines. I need to now jump back and
forth to see what KPROBE_EVENT_ID is. So unless we have to use them in
multiple places, I'd keep those constants where they were, honestly.

> > +
> > +     snprintf(file, sizeof(file), fname, func_name);
> > +
> > +     return parse_uint_from_file(file, "%d\n");
> > +}
> > +
> >  static int perf_event_open_probe(bool uprobe, bool retprobe, const cha=
r *name,
> >                                uint64_t offset, int pid)
> >  {
> > @@ -9760,6 +10034,51 @@ static int perf_event_open_probe(bool uprobe,
> > bool retprobe, const char *name,
> >       return pfd;
> >  }
> >
> > +static int perf_event_open_probe_legacy(bool uprobe, bool retprobe,
> > const char *name,
> > +                                     uint64_t offset, int pid)
> > +{
> > +     struct perf_event_attr attr =3D {};
> > +     char errmsg[STRERR_BUFSIZE];
> > +     int type, pfd, err;
> > +
> > +     if (uprobe) // legacy uprobe not supported yet
> > +             return -1;
>
> Would that be ok for now ? Until we are sure kprobe legacy interface is
> good ?
>

it's ok, but return -EOPNOTSUPP instead


> > +
> > +     err =3D toggle_kprobe_legacy(true);
> > +     if (err < 0) {
> > +             pr_warn("failed to toggle kprobe legacy support: %s\n",
> > libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> > +             return err;
> > +     }
> > +     err =3D add_kprobe_event_legacy(name, retprobe);
> > +     if (err < 0) {
> > +             pr_warn("failed to add legacy kprobe event: %s\n",
> > libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> > +             return err;
> > +     }
> > +     type =3D determine_kprobe_perf_type_legacy(name);
> > +     if (err < 0) {
> > +             pr_warn("failed to determine legacy kprobe event id: %s\n=
",
> > libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
> > +             return type;
> > +     }
> > +
> > +     attr.size =3D sizeof(attr);
> > +     attr.config =3D type;
> > +     attr.type =3D PERF_TYPE_TRACEPOINT;
> > +
> > +     pfd =3D syscall(__NR_perf_event_open,
> > +                   &attr,
> > +                   pid < 0 ? -1 : pid,
> > +                   pid =3D=3D -1 ? 0 : -1,
> > +                   -1,
> > +                   PERF_FLAG_FD_CLOEXEC);

btw, a question. Is there similar legacy interface to tracepoints? It
would be good to support those as well. Doesn't have to happen at the
same time, but let's just keep it in mind as we implement this.

> > +
> > +     if (pfd < 0) {
> > +             err =3D -errno;
> > +             pr_warn("legacy kprobe perf_event_open() failed: %s\n",
> > libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> > +             return err;
> > +     }
> > +     return pfd;
> > +}
> > +
> >  struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
> >                                           bool retprobe,
> >                                           const char *func_name)
> > @@ -9788,6 +10107,33 @@ struct bpf_link
> > *bpf_program__attach_kprobe(struct bpf_program *prog,
> >       return link;
> >  }
> >
> > +struct bpf_link *bpf_program__attach_kprobe_legacy(struct bpf_program

this is wrong from the API perspective. The goal is to not make users
decide whether they want legacy or non-legacy interfaces. With all
your work there shouldn't be any new APIs.
bpf_program__attach_kprobe() should detect which interface to use and
just use it.

> > *prog,
> > +                                                bool retprobe,
> > +                                                const char *func_name)
> > +{
> > +     char errmsg[STRERR_BUFSIZE];
> > +     struct bpf_link *link;
> > +     int pfd, err;
> > +
> > +     pfd =3D perf_event_open_probe_legacy(false, retprobe, func_name, =
0, -1);
> > +     if (pfd < 0) {
> > +             pr_warn("prog '%s': failed to create %s '%s' legacy perf
> > event: %s\n", prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
> > libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
> > +             return ERR_PTR(pfd);
> > +     }
> > +     link =3D bpf_program__attach_perf_event_legacy(prog, pfd);
> > +     if (IS_ERR(link)) {
> > +             close(pfd);
> > +             err =3D PTR_ERR(link);
> > +             pr_warn("prog '%s': failed to attach to %s '%s': %s\n",
> > prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
> > libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> > +             return link;
> > +     }
> > +     /* needed history for the legacy probe cleanup */
> > +     link->legacy.name =3D func_name;
> > +     link->legacy.retprobe =3D retprobe;
>
> Note I=E2=80=99m not setting those variables inside
> bpf_program__atach_perf_event_legacy(). They=E2=80=99re not available
> there and I did not want to make them to be (through arguments).

as I said above, you shouldn't assume that func_name will still be
allocated by the time you get to detaching kprobe. You should strdup()
or do whatever is necessary to own necessary memory.

>
> > +
> > +     return link;
> > +}
> > +
> >  static struct bpf_link *attach_kprobe(const struct bpf_sec_def *sec,
> >                                     struct bpf_program *prog)
> >  {
> > @@ -9797,6 +10143,9 @@ static struct bpf_link *attach_kprobe(const stru=
ct
> > bpf_sec_def *sec,
> >       func_name =3D prog->sec_name + sec->len;
> >       retprobe =3D strcmp(sec->sec, "kretprobe/") =3D=3D 0;
> >
> > +     if(determine_kprobe_legacy())
> > +             return bpf_program__attach_kprobe_legacy(prog, retprobe, =
func_name);
> > +

the other way around, attach_kprobe should just delegate to
bpf_program__attach_kprobe, but bpf_program__attach_kprobe should be
smart enough

> >       return bpf_program__attach_kprobe(prog, retprobe, func_name);
> >  }
>
> I=E2=80=99m assuming this is okay based on your saying of detecting a fea=
ture
> instead of using the if(x) if(y) approach.
>
> >
> > @@ -11280,4 +11629,7 @@ void bpf_object__destroy_skeleton(struct
> > bpf_object_skeleton *s)
> >       free(s->maps);
> >       free(s->progs);(),
> >       free(s);
> > +
> > +     remove_kprobe_event_legacy("ip_set_create", false);
> > +     remove_kprobe_event_legacy("ip_set_create", true);
>
> This is the main issue I wanted to show you before continuing.
> I cannot remove the kprobe event unless the obj is unloaded.
> That is why I have this hard coded here, just because I was
> testing. Any thoughts how to cleanup the kprobes without
> jeopardising the API too much ?


cannot as in it doesn't work for whatever reason? Or what do you mean?

I see that you had bpf_link__detach_perf_event_legacy calling
remove_kprobe_event_legacy, what didn't work?

You somehow ended up with 3 times more code and I have more questions
now then before. When you say "it doesn't work", please make sure to
explain what exactly doesn't work, what you did, what you expected to
happen/see.

>
> >  }
> > =E2=80=94
> > 2.17.1
>
>
