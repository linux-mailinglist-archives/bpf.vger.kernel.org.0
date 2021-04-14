Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302ED35FE61
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 01:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbhDNXXr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 19:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbhDNXXq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 19:23:46 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97A4C061574
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 16:23:24 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id z1so24023451ybf.6
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 16:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WeJE9QP4TitrZPUYXJUVQTjNVSpD3TWdhmaRClWOMyQ=;
        b=R+cp2cSGd5Ro7WbQJMrt+xWMsl9jN+8yRkEIuWcARwjMnnWb12m6Qb1MIvf8Z11riG
         ixUei9wuoOmWDPlN/6U+kdHvrlUEhLnlzz9q6I4bZdVH0dPLUHxm1NePYAwXjeW+t45h
         kAjlKXP5SeAeBbI7++tjzcWa/Gu80CosPpGLcUpSix0K8Yt5Jd5NVVWSlY3TtKbVU9zn
         dk2npZkjCGGc+lC5BTM7y7Vetx1nMBqe3z6DBndsC4pmgzVfyCmO1Kpb/foCvgaIoEbU
         sjJ/KNzMyAvfPQc31XTKTWKQS3sqoF0Yo6P8aLmpa8IEQFPX2P8AdfwO90QLaOWLNktQ
         eK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WeJE9QP4TitrZPUYXJUVQTjNVSpD3TWdhmaRClWOMyQ=;
        b=kpp+wn2V6uCaIOQ6g3wBDPb/isqq4RV7Ors3vGrVip/bubNJ8/sSiBX136bTCwKzdi
         PTfQsqGzetuIYAUNeun8yuFewrKjh5LIvTUuDOE5zUbIPh9yvCzSDz9QJOFnEQirBxcD
         5sAjHSt7mh38Fz6I0GchwxUhWztYw4Uy1Qg73H10ssIfs9YpryCMoidvz7iWh+YIFeil
         WvlOEGrv2IQOIR+umplvcqnCgoM4hYm+by9vynW77yv+G0nqXBvlYkqgVdDdnmM3yu/n
         MaEyMyugPxW2XKtTsKIgLlmKTHZI6nsH2RmilgAxQts5B1HvkqLwam7StBMFAAtvok74
         jchQ==
X-Gm-Message-State: AOAM530auqF+coKc2zm6kTHe/yv3Iu1SD56bmVg7TyuGOW+KOaszSsSl
        +ncxirAQgfisfsynPgoh62LLsrpoLKsTBe50djGLrYT7
X-Google-Smtp-Source: ABdhPJz6JGMhw6FsU1gCKh5GteLzkwcHAGCwI2fXJ+huOeGk/7+FYn6aDL7uDIyzSTohjAmZWbML7AIeqPTuVJiSFEM=
X-Received: by 2002:a25:becd:: with SMTP id k13mr476049ybm.459.1618442603948;
 Wed, 14 Apr 2021 16:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4Bzap6qS9_HQZTHJsM-X2VZso+N5xMwa3HNG9ycMW4WXtQg@mail.gmail.com>
 <20210322180441.1364511-1-rafaeldtinoco@ubuntu.com> <4BB60234-7970-405C-9447-D19CA6564BC2@ubuntu.com>
 <CAEf4BzaimrGXFrfFVHvV53ta7NwDWsN0YHcDiVJELEnbdjmKdg@mail.gmail.com>
 <045DF0ED-10A2-4D9F-AA01-5CE7E3E95193@ubuntu.com> <CAEf4BzbPdH+pV9NpCW+piROOfCme=erGQOHs8XcA_e=pYcV2=g@mail.gmail.com>
 <4F445042-0ECC-4654-B334-E2364B5B9B8D@ubuntu.com>
In-Reply-To: <4F445042-0ECC-4654-B334-E2364B5B9B8D@ubuntu.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 14 Apr 2021 16:23:13 -0700
Message-ID: <CAEf4BzYQcD8vrTkXSgwBVGhRKvSWM6KyNc07QthK+=60+vUf8w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next][RFC] libbpf: introduce legacy kprobe events support
To:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Cc:     LKML BPF <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 7:30 AM Rafael David Tinoco
<rafaeldtinoco@ubuntu.com> wrote:
>
> >
> >>> So I don't get at all why you have these toggles, especially
> >>> ALL_TOGGLE? You shouldn't try to determine the state of another probe=
.
> >>> You always know whether you want to enable or disable your specific
> >>> toggle. I'm very confused by all this.
> >>
> >> Yes, this was a confusing thing indeed and to be honest it proved to
> >> be very buggy when testing with conntracker. What I=E2=80=99ll do (or =
I=E2=80=99m
> >> doing) is to toggle ON to needed files before the probe is added:
> >>
> >> static inline int add_kprobe_event_legacy(const char* func_name, bool
> >> retprobe)
> >> {
> >>        int ret =3D 0;
> >>
> >>        ret |=3D poke_kprobe_events(true, func_name, retprobe);
> >>        ret |=3D toggle_kprobe_event_legacy_all(true);
> >>        ret |=3D toggle_single_kprobe_event_legacy(true, func_name, ret=
probe);
> >>
> >>        return ret;
> >> }
> >>
> >> 1) /sys/kernel/debug/tracing/kprobe_events =3D> 1
> >> 2) /sys/kernel/debug/tracing/events/kprobes/enable =3D> 1
> >> 3) /sys/kernel/debug/tracing/events/kprobes/%s/enable =3D> 1
> >
> > Ok, hold on. I don't think we should use those /enable files,
> > actually. Double-checking what BCC does ([0]) and my local demo app I
> > wrote a while ago, we use perf_event_open() to activate kprobe, once
> > it is created, and that's all that is necessary.
> >
> >  [0] https://github.com/iovisor/bcc/blob/master/src/cc/libbpf.c#L1046
>
> No, they are not needed. Those are enabling ftrace kprobe feature:
>
> trace_events.c:
>     event_create_dir()
>         trace_create_file("enable") ->
>             ftrace_enable_fops():
>             .write =3D event_enable_write() -> ftrace_event_enable_disabl=
e()
>
> And kprobe perf events works fine without playing with them as long as:
> /sys/kernel/debug/tracing/kprobe_events is always 1 (should we enable
> it by default or consider it is enabled and don=E2=80=99t change its valu=
e ?).

I think considering it enabled is the right call, given that's what BCC doe=
s.

>
> >>
> >> Because of /sys/kernel/debug/tracing/events/kprobes/%s/enable. I=E2=80=
=99m
> >> toggling it to OFF before removing the kprobe in kprobe_events, like
> >> showed above.
> >
> > Alright, see above about enable files, it doesn't seem necessary,
> > actually. You use poke_kprobe_events() to add or remove kprobe to the
> > kernel. That gives you event_name and its id (from
> > /sys/kernel/debug/tracing/events/kprobes/%s/id). You then use that id
> > to create perf_event and activate BPF program:
>
> Yes, with a small reservation I just found out: function names might
> change because of GCC optimisations.. In my case I found out that:
>
> # cat /proc/kallsyms | grep udp_send_skb
> ffffffff8f9e0090 t udp_send_skb.isra.48
>
> udp_send_skb probe was not always working because the function name
> was changed. Then I saw BCC had this issue back in 2018 and is
> fixing it now:
>
> https://github.com/iovisor/bcc/issues/1754
> https://github.com/iovisor/bcc/pull/2930
>
> So I thought I could do the same: check if function name is the same
> in /proc/kallsyms or if it has changed and use the changed name if
> needed (to add to kprobe_events).
>
> Will include that logic and remove the =E2=80=98enables=E2=80=99.

No, please stop adding arbitrary additions. Function renames, .isra
optimizations, etc - that's all concerns of higher level, this API
should not try to be smart. It should try to attach to exactly the
kprobe specified.

>
> >
> > And that should be it. It doesn't seem like either BCC or my example
> > (which I'm sure worked last time) does anything with /enable files and
> > I'm sure all that works.
>
> First comment.
>
> >
> > [...]
> >
> >>>>>     return bpf_program__attach_kprobe(prog, retprobe, func_name);
> >>>>> }
> >>>>
> >>>> I=E2=80=99m assuming this is okay based on your saying of detecting =
a feature
> >>>> instead of using the if(x) if(y) approach.
> >>>>
> >>>>> @@ -11280,4 +11629,7 @@ void bpf_object__destroy_skeleton(struct
> >>>>> bpf_object_skeleton *s)
> >>>>>      free(s->maps);
> >>>>>      free(s->progs);(),
> >>>>>      free(s);
> >>>>> +
> >>>>> +     remove_kprobe_event_legacy("ip_set_create", false);
> >>>>> +     remove_kprobe_event_legacy("ip_set_create", true);
> >>>>
> >>>> This is the main issue I wanted to show you before continuing.
> >>>> I cannot remove the kprobe event unless the obj is unloaded.
> >>>> That is why I have this hard coded here, just because I was
> >>>> testing. Any thoughts how to cleanup the kprobes without
> >>>> jeopardising the API too much ?
> >>>
> >>> cannot as in it doesn't work for whatever reason? Or what do you mean=
?
> >>>
> >>> I see that you had bpf_link__detach_perf_event_legacy calling
> >>> remove_kprobe_event_legacy, what didn't work?
> >>>
> >>
> >> I=E2=80=99m sorry for not being very clear here. What happens is that,=
 if I
> >> try to remove the kprobe_event_legacy() BEFORE:
> >>
> >> if (s->progs)
> >>        bpf_object__detach_skeleton(s);
> >> if (s->obj)
> >>        bpf_object__close(*s->obj);
> >>
> >> It fails with generic write error on kprobe_events file. I need to
> >> remove legacy kprobe AFTER object closure. To workaround this on
> >> my project, and to show you this issue, I have come up with:
> >>
> >> void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
> >> {
> >>         int i, j;
> >>         struct probeleft {
> >>                 char *probename;
> >>                 bool retprobe;
> >>         } probesleft[24];
> >>
> >>         for (i =3D 0, j =3D 0; i < s->prog_cnt; i++) {
> >>                 struct bpf_link **link =3D s->progs[i].link;
> >>                 if ((*link)->legacy.name) {
> >>                         memset(&probesleft[j], 0, sizeof(struct probel=
eft));
> >>                         probesleft[j].probename =3D strdup((*link)->le=
gacy.name);
> >>                         probesleft[j].retprobe =3D (*link)->legacy.ret=
probe;
> >>                         j++;
> >>                 }
> >>         }
> >>
> >>         if (s->progs)
> >>                 bpf_object__detach_skeleton(s);
> >>         if (s->obj)
> >>                 bpf_object__close(*s->obj);
> >>         free(s->maps);
> >>         free(s->progs);
> >>         free(s);
> >>
> >>         for (j--; j >=3D 0; j--) {
> >>                 remove_kprobe_event_legacy(probesleft[j].probename, pr=
obesleft[j].retprobe);
> >>                 free(probesleft[j].probename);
> >>         }
> >> }
> >>
> >> Which, of course, is not what I=E2=80=99m suggesting to the lib, but s=
hows
> >> the problem and gives you a better idea on how to solve it not
> >> breaking the API.
> >>
> >
> > bpf_link__destroy() callback should handle that, no? You'll close perf
> > event FD, which will "free up" kprobe and you can do
> > poke_kprobe_events(false /*remove */, ...). Or am I still missing
> > something?
>
> I could only poke_kprobe_events() to remove the kprobe after
> bpf_oject__close(), or I would get an I/O error on kprobe_events.
> Not sure if after map destroy or program exit.

Did you figure out why? What's causing an error?

>
> -rafaeldtinoco
>
