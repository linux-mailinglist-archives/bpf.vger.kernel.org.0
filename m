Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AC63590BB
	for <lists+bpf@lfdr.de>; Fri,  9 Apr 2021 01:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhDHX7g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 19:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDHX7g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Apr 2021 19:59:36 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54177C061760
        for <bpf@vger.kernel.org>; Thu,  8 Apr 2021 16:59:24 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id j26so4067106iog.13
        for <bpf@vger.kernel.org>; Thu, 08 Apr 2021 16:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=FMfBE4/fHobovef8Ze9zpXa6gaLKbb1Xjt1mfu54AY8=;
        b=X4ICIesv+4UhV5r7tSVSFRaYEzOfn71Zszpmd5pZTdsAAuhf/bGviYBeykSI2kKSUp
         o+WQBuCwFViAFpY9QwuJF/TDEqwGMglfCL9cpBPZOG1XT68vl9Pj/XPWLpo34Xp1Gg+d
         CIZJAcQJRMEfBLOVsO1LdCGiyavgVJEHq6xxvuYNOX2iMvAaGooCp/aTFtFCdHuSlax5
         pC/Aq/DmrM6j049OVHSOE8dX+NREtTV6/5mT+w1b8/a03CxsoMYoPXxiG53Sf4bj8QjC
         gXVth7FlrHdHEZxheSmsCKcEAfe8Rim0o0ipZGGwht++iHBuO4kSxhYeeaeXWlfNWQpX
         srRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=FMfBE4/fHobovef8Ze9zpXa6gaLKbb1Xjt1mfu54AY8=;
        b=Yh7Lcqe3e4JApMKiBw+9vVaEZo1GipeGcw2QMgjMonxq7AwKy3C1nrloedxt1o70Ca
         9xGIwfXp4ha3QH7hxbwKuiIcC2Td8FrsJglGQgHrttiSxujr9yvuW54fGrPrZudDlZlF
         BXCL4uQCg6ws9xe7gqnPHxao9lhsRDJUe3GqutWU4onTZXjHns/etDUYHo96PbyscENQ
         xyB2Li9EztaVeOMUnqizrxyh86wBF9ZrFhfpV9olm0ALyjuGRoQQEbww2EPTBt4ca4Ry
         Msm9OZMaOa48xRiF2Nh/7CCfvqQhzHyDNOxpI/rGV61SNQ+MrP1qffxAoC+etnIKqsZ1
         RWkg==
X-Gm-Message-State: AOAM530zBqPW3SyyzZ5rlH8ANxpUoUCwXGWn9x8XUI6ZBB8Gpa5PGeyw
        dwaDimfQPIQr8ywoBk7QfxlYYvjZua4=
X-Google-Smtp-Source: ABdhPJwA03NmRG63YVY92nABJUz2aiT/vyejEj/aFbDiD0U7FHUVp3FUJgfyJXi5tdPoy/OOONhVUA==
X-Received: by 2002:a05:6602:2b0a:: with SMTP id p10mr7436539iov.129.1617926363627;
        Thu, 08 Apr 2021 16:59:23 -0700 (PDT)
Received: from localhost ([172.242.244.146])
        by smtp.gmail.com with ESMTPSA id h8sm415054ila.52.2021.04.08.16.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 16:59:23 -0700 (PDT)
Date:   Thu, 08 Apr 2021 16:59:16 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Cc:     LKML BPF <bpf@vger.kernel.org>
Message-ID: <606f98d48115_c8b9208f9@john-XPS-13-9370.notmuch>
In-Reply-To: <CAEf4BzbPdH+pV9NpCW+piROOfCme=erGQOHs8XcA_e=pYcV2=g@mail.gmail.com>
References: <CAEf4Bzap6qS9_HQZTHJsM-X2VZso+N5xMwa3HNG9ycMW4WXtQg@mail.gmail.com>
 <20210322180441.1364511-1-rafaeldtinoco@ubuntu.com>
 <4BB60234-7970-405C-9447-D19CA6564BC2@ubuntu.com>
 <CAEf4BzaimrGXFrfFVHvV53ta7NwDWsN0YHcDiVJELEnbdjmKdg@mail.gmail.com>
 <045DF0ED-10A2-4D9F-AA01-5CE7E3E95193@ubuntu.com>
 <CAEf4BzbPdH+pV9NpCW+piROOfCme=erGQOHs8XcA_e=pYcV2=g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next][RFC] libbpf: introduce legacy kprobe events
 support
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> On Tue, Apr 6, 2021 at 9:49 PM Rafael David Tinoco
> <rafaeldtinoco@ubuntu.com> wrote:
> >
> > Sorry taking so long for replying on this=E2=80=A6 have been working =
in:
> > https://github.com/rafaeldtinoco/conntracker/tree/main/ebpf
> > as a consumer for the work being proposed by this patch.
> >
> > Current working version at:
> > https://github.com/rafaeldtinoco/conntracker/blob/main/ebpf/patches/l=
ibbpf-introduce-legacy-kprobe-events-support.patch
> > About to be changed with suggestions from this thread.
> >

Just catching up on this thread now.

> > > don't get why you need this function either...
> >
> > Because of /sys/kernel/debug/tracing/events/kprobes/%s/enable. I=E2=80=
=99m
> > toggling it to OFF before removing the kprobe in kprobe_events, like
> > showed above.
> =

> Alright, see above about enable files, it doesn't seem necessary,
> actually. You use poke_kprobe_events() to add or remove kprobe to the
> kernel. That gives you event_name and its id (from
> /sys/kernel/debug/tracing/events/kprobes/%s/id). You then use that id
> to create perf_event and activate BPF program:
> =

>   struct perf_event_attr attr;
>   struct bpf_link* link;
>   int fd =3D -1, err, id;
>   FILE* f =3D NULL;
> =

>   err =3D poke_kprobe_events(true /*add*/, func_name, is_kretprobe);
>   if (err) {
>     fprintf(stderr, "failed to create kprobe event: %d\n", err);
>     return NULL;
>   }
> =

>   snprintf(
>       fname,
>       sizeof(fname),
>       "/sys/kernel/debug/tracing/events/kprobes/%s/id",
>       func_name);
>   f =3D fopen(fname, "r");
>   if (!f) {
>     fprintf(stderr, "failed to open kprobe id file '%s': %d\n", fname, =
-errno);
>     goto err_out;
>   }
> =

>   if (fscanf(f, "%d\n", &id) !=3D 1) {
>     fprintf(stderr, "failed to read kprobe id from '%s': %d\n", fname, =
-errno);
>     goto err_out;
>   }
> =

>   fclose(f);
>   f =3D NULL;
> =

>   memset(&attr, 0, sizeof(attr));
>   attr.size =3D sizeof(attr);
>   attr.config =3D id;
>   attr.type =3D PERF_TYPE_TRACEPOINT;
>   attr.sample_period =3D 1;
>   attr.wakeup_events =3D 1;
> =

>   fd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_C=
LOEXEC);
>   if (fd < 0) {
>     fprintf(
>         stderr,
>         "failed to create perf event for kprobe ID %d: %d\n",
>         id,
>         -errno);
>     goto err_out;
>   }
> =

>   link =3D bpf_program__attach_perf_event(prog, fd);
> =

> And that should be it. It doesn't seem like either BCC or my example
> (which I'm sure worked last time) does anything with /enable files and
> I'm sure all that works.

FWIW I also have a similar patch on my stack that does this and was
working fine for us. I've got a note here to submit it, but its
been stuck on the todo list.

I'll post it here maybe its helpful,

+static int write_to_kprobe_events(const char *name,
+                                 uint64_t offset, int pid, bool retprobe=
)
+{
+       const char *kprobe_events =3D "/sys/kernel/debug/tracing/kprobe_e=
vents";
+       int fd =3D open(kprobe_events, O_WRONLY | O_APPEND, 0);
+       char buf[PATH_MAX];
+       int err;
+
+       if (fd < 0) {
+               err =3D -errno;
+               pr_warn("Failed open kprobe_events: %s\n", strerror(errno=
));
+               return err;
+       }
+       snprintf(buf, sizeof(buf), "%c:kprobes/%s %s",
+                retprobe ? 'r' : 'p', name, name);
+       err =3D write(fd, buf, strlen(buf));
+       close(fd);
+       if (err < 0) {
+               err =3D -errno;
+               pr_warn("Failed write kprobe_events: %s\n", strerror(errn=
o));
+               return err;
+       }
+       return 0;
+}
+
+/* If we do not have an event_source/../kprobes then we can try to use
+ * kprobe-base event tracing, for details see documentation kprobetrace.=
rst
+ */
+static int perf_event_open_probe_debugfs(bool uprobe, bool retprobe, con=
st char *name,
+                                        uint64_t offset, int pid)
+{
+       const char *kprobes_dir =3D "/sys/kernel/debug/tracing/events/kpr=
obes/";
+       struct perf_event_attr attr =3D {};
+       char errmsg[STRERR_BUFSIZE];
+       char file[PATH_MAX];
+       int pfd, err, id;
+
+       if (uprobe) {
+               return -EOPNOTSUPP;
+       } else {
+               err =3D write_to_kprobe_events(name, offset, pid, retprob=
e);
+               if (err < 0)
+                       return err;
+               err =3D snprintf(file, sizeof(file), "%s/%s/id", kprobes_=
dir, name);
+               if (err < 0)
+                       return -errno;
+               id =3D parse_uint_from_file(file, "%d\n");
+               if (id < 0)
+                       return err;
+               attr.size =3D sizeof(attr);
+               attr.type =3D PERF_TYPE_TRACEPOINT;
+               attr.config =3D id;
+       }
+
+       /* pid filter is meaningful only for uprobes */
+       pfd =3D syscall(__NR_perf_event_open, &attr,
+                     pid < 0 ? -1 : pid /* pid */,
+                     pid =3D=3D -1 ? 0 : -1 /* cpu */,
+                     -1 /* group_fd */, PERF_FLAG_FD_CLOEXEC);
+       if (pfd < 0) {
+               err =3D -errno;
+               pr_warn("%s perf_event_open_probe_debugfs() failed: %s\n"=
,
+                       uprobe ? "uprobe" : "kprobe",
+                       libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+               return err;
+       }
+       return pfd;
+}

> =

> [...]
> =

> > >>>      return bpf_program__attach_kprobe(prog, retprobe, func_name)=
;=
