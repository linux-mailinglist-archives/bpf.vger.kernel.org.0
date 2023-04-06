Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF096D8DF5
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 05:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjDFDWs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 23:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjDFDWo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 23:22:44 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61F293ED;
        Wed,  5 Apr 2023 20:22:38 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g19so36942044qts.9;
        Wed, 05 Apr 2023 20:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680751357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5XC3ufD+Qey01Z2ErPpFvERrSWVVhTft+yj5CoTEmQ=;
        b=JCYDeRwzlodAgahW3ub028888bjpfqFV0nWtKmFA0xOwM90pdsB5XjeJ/J6mcwGW6R
         1KSUneDFUHVh5p+DPb2KV1LzFSo3Cp65KBvUeYzzo5mD17JHV9NV85MudpNoAN+JPWbn
         SRIyihCsSFqHwMJm608Us5iFmuPuxv/YHZpAfOr0lqznC6JuCgHog2prD19wMrMQ7+Jl
         ifPTLFeP4Nvrkpm71icVA+RQvxw2WPIuvTHCf0wtTNFcHOYzc8nVuuGFqUh17WOPI7Ec
         Hky+yWduHkk5S9QoJhRKgaDC9w8r9t9BGusjQhxiC/p98kdKGzeRulvykOXB8w31bEBT
         m6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680751357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5XC3ufD+Qey01Z2ErPpFvERrSWVVhTft+yj5CoTEmQ=;
        b=TunW3xWsH+E9ndVOB+2f+Fnz/TfzoGS7UNGgY6Jvh4hzxnf/I7ekG3Ov7V06NEs/+M
         cAWqtqpF0hchkm43CS8oFMdAjhRFza2p/fXRDBDeCRinN3aVzwdCXlIsjsGXnNn+FOlU
         bEGwyzZmwf6WZ7YHI3d7BmLv7hWCy5UlBub2KBFJsSnsI8rrFAUy5HY5YZkb6RwaWc4i
         VXZwu4n5JSKVYF82KC5PvopGqcBk7x4gfBeybCwUXQWebRGGanc7sPMm1fDeu23oLk77
         dty4NYyc6PcRpk0WOFZL1ayR/+0/bX49tTl9um8PVf8cl/0IOjWWlgn00+uo1zuMGtoX
         Bb+w==
X-Gm-Message-State: AAQBX9cpOo3PDQtg/noabxmBDt0Gp3Zm24/aire8s2kboOpQxLBfaUgh
        s145Xw+IPm3XAPB6vVd5AXszDK4hmfjbxdRMiWI=
X-Google-Smtp-Source: AKy350apODNUvFl5sd7P4hCOZsg+D+cBfXJSmY7zBhM53Yk0HzF27LnuIXES1FZDWWRVhzg+OAp5lxKxEtYMmZlVdKQ=
X-Received: by 2002:a05:622a:1815:b0:3df:4392:1aff with SMTP id
 t21-20020a05622a181500b003df43921affmr2103282qtc.6.1680751357446; Wed, 05 Apr
 2023 20:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230326092208.13613-1-laoar.shao@gmail.com> <CAPhsuW43EiH0tVKU8s+JwV_V6EBETTDyXsAmMzAftpVtcgLHag@mail.gmail.com>
 <CALOAHbCqCb3xmSpNe1Qvm75GBY4ZEGrAOHfVJvpZV5t=akTTgQ@mail.gmail.com>
 <20230402233740.haxb7lgfavcoe27f@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbBj-+xY5jGLynUrg1GfSftZ+LT5DkADKz_+8+tL2kWMSw@mail.gmail.com>
 <20230403225017.onl5pbp7h2ugclbk@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbDQROKrWe732Qv1CsZwr6nMJN-2y77JW3EuT53D8At+Ow@mail.gmail.com>
 <20230406020656.7v5ongxyon5fr4s7@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbCEsucGRB+n5hTnPm-HssmB91HD4PFVRhdO=CZnJXfR6A@mail.gmail.com> <CAADnVQ+1VEBHTM5Rm-gx8-bg=tfv=4x+aONhF0bAmBFZG3W8Qg@mail.gmail.com>
In-Reply-To: <CAADnVQ+1VEBHTM5Rm-gx8-bg=tfv=4x+aONhF0bAmBFZG3W8Qg@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 6 Apr 2023 11:22:01 +0800
Message-ID: <CALOAHbAorooyteDjgs82TtujP4Fwo5hSkh-Z5QhxhV9p7_2mfw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 6, 2023 at 11:06=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Apr 5, 2023 at 7:55=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > It seems that I didn't describe the issue clearly.
> > The container doesn't have CAP_SYS_ADMIN, but the CAP_SYS_ADMIN is
> > required to run bpftool,  so the bpftool running in the container
> > can't get the ID of bpf objects or convert IDs to FDs.
> > Is there something that I missed ?
>
> Nothing. This is by design. bpftool needs sudo. That's all.
>

Hmm, what I'm trying to do is make bpftool run without sudo.

>
> >
> > > > --- a/kernel/bpf/syscall.c
> > > > +++ b/kernel/bpf/syscall.c
> > > > @@ -3705,9 +3705,6 @@ static int bpf_obj_get_next_id(const union bp=
f_attr *attr,
> > > >         if (CHECK_ATTR(BPF_OBJ_GET_NEXT_ID) || next_id >=3D INT_MAX=
)
> > > >                 return -EINVAL;
> > > >
> > > > -       if (!capable(CAP_SYS_ADMIN))
> > > > -               return -EPERM;
> > > > -
> > > >         next_id++;
> > > >         spin_lock_bh(lock);
> > > >         if (!idr_get_next(idr, &next_id))
> > > >
> > > > Because the container doesn't have CAP_SYS_ADMIN enabled, while the=
y
> > > > only have CAP_BPF and other required CAPs.
> > > >
> > > > Another possible solution is that we run an agent in the host, and =
the
> > > > user in the container who wants to get the bpf objects info in his
> > > > container should send a request to this agent via unix domain socke=
t.
> > > > That is what we are doing now in our production environment.  That
> > > > said, each container has to run a client to get the bpf object fd.
> > >
> > > None of such hacks are necessary. People that debug bpf setups with b=
pftool
> > > can always sudo.
> > >
> > > > There are some downsides,
> > > > -  It can't handle pinned bpf programs
> > > >    For pinned programs, the user can get them from the pinned files
> > > > directly, so he can use bpftool in his case, only with some
> > > > complaints.
> > > > -  If the user attached the bpf prog, and then removed the pinned
> > > > file, but didn't detach it.
> > > >    That happened. But this error case can't be handled.
> > > > - There may be other corner cases that it can't fit.
> > > >
> > > > There's a solution to improve it, but we also need to change the
> > > > kernel. That is, we can use the wasted space btf->name.
> > > >
> > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > index b7e5a55..59d73a3 100644
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -5542,6 +5542,8 @@ static struct btf *btf_parse(bpfptr_t btf_dat=
a,
> > > > u32 btf_data_size,
> > > >                 err =3D -ENOMEM;
> > > >                 goto errout;
> > > >         }
> > > > +       snprintf(btf->name, sizeof(btf->name), "%s-%d-%d", current-=
>comm,
> > > > +                        current->pid, cgroup_id(task_cgroup(p, cpu=
_cgrp_id)));
> > >
> > > Unnecessary.
> > > comm, pid, cgroup can be printed by bpftool without changing the kern=
el.
> >
> > Some questions,
> > - What if the process exits after attaching the bpf prog and the prog
> > is not auto-detachable?
> >   For example, the reuserport bpf prog is not auto-detachable. After
> > pins the reuserport bpf prog, a task can attach it through the pinned
> > bpf file, but if the task forgets to detach it and the pinned file is
> > removed, then it seems there's no way to figure out which task or
> > cgroup this prog belongs to...
>
> you're saying that there is a bpf prog in the kernel without
> corresponding user space ?

No, it is corresponding to user space. For example, it may be
corresponding to a socket fd, or a cgroup fd.

> Meaning no user space process has an FD
> that points to this prog or FD to a map that this prog is using?
> In such a case this is truly kernel bpf prog. It doesn't belong to cgroup=
.
>

Even if it is kernel bpf prog, it is created by a process. The user
needs to know which one created it.

> > - Could you pls. explain in detail how to get comm, pid, or cgroup
> > from a pinned bpffs file?
>
> pinned bpf prog and no user space holds FD to it?
> It's not part of any cgroup. Nothing to print.

As I explained above, even if it holds nothing, the user needs to know
the information from it. For example, if it is expected, which one
created it?

--=20
Regards
Yafang
