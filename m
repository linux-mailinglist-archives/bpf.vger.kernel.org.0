Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5206D8EE8
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 07:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjDFFol (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 01:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjDFFok (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 01:44:40 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6B1E57;
        Wed,  5 Apr 2023 22:44:36 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id bi39so4519285qkb.13;
        Wed, 05 Apr 2023 22:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680759876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvQwfvj8sW09bm2ffaurY8lazWy/P7dLqyu/bRtP2zc=;
        b=mgnSgnKFVTMlcB79EOAEWpjNaxIo8e65mw+PZO9pM0lD0MhTEtHgIkZQJ0YWscS2oj
         SDvVExAgDJcNhVnm3qMN3x6qFKjv/afkbME/gnQMgNIqxtiKiGRknIEf5bKZK05y+TcT
         +v/JpxYjMhkDypLl4nAnaQC1Ood7E18Nr5hrd94dhAqOidCgd/OzJ0nsNDirZONe5Tam
         Zswy7p2/dR4vK6Nua9gzaaGBONktEqugJGU0x9pbpzVM6mbjiytMw/gLwaiITHfy8sqx
         CpzVgmfB969m68N3Z0vRsWOUN1/LT9M9r16xbslRTDK7JWPCo5G5CI6sv2TqpAC50cWV
         1MXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680759876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvQwfvj8sW09bm2ffaurY8lazWy/P7dLqyu/bRtP2zc=;
        b=7Jxq9M0Kn3BhNm1FDr+C90W+hc3NhpisWW4+3e4Yam9PIBuK8v0BCdPmP6z0oF+WXu
         HVCznMBoJhOlqjd1CGcEnv4/dY1mSRFNpF4NFQxv4YYfPyM27QR8qk6ZYyI5IGqTmckp
         MVvMrAbeJHRszzdCY9hqJH8nek2caOkU7jyXOoRADxYvtPyaMIs0D1a9p6Qd5XVTZe/p
         qFXwtLY9Op7+F48cx2A6gnOA1VG7VVhwhWcNwFLYB/b5tlMO7j3xjwprsC7h5z49bxN0
         cpM2aJT5dzVix8TvyAFWKlhynZQ/4OhwYuA7YkoBWsigkC80kyDtEbeGZ85cxVQFt7gn
         bt4Q==
X-Gm-Message-State: AAQBX9c9gCUohpVKZ5xYPg8CUklOczLHo5OIqpC5tdIO7ro+yKid+7lC
        7qiR86NzauzwQnn28ngyX95oK3WfHpPPQXgdQQg=
X-Google-Smtp-Source: AKy350ZrOAcuqxMYB6Ui3QELE+6Awi7lVWoUPCipMI1l5eHt32Nl7TaBiy6K6CKG1ZnVZE4WffF6/cfWPcvLkZHL+gk=
X-Received: by 2002:a05:620a:2596:b0:746:7857:d28b with SMTP id
 x22-20020a05620a259600b007467857d28bmr1969342qko.14.1680759875932; Wed, 05
 Apr 2023 22:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230326092208.13613-1-laoar.shao@gmail.com> <CAPhsuW43EiH0tVKU8s+JwV_V6EBETTDyXsAmMzAftpVtcgLHag@mail.gmail.com>
 <CALOAHbCqCb3xmSpNe1Qvm75GBY4ZEGrAOHfVJvpZV5t=akTTgQ@mail.gmail.com>
 <20230402233740.haxb7lgfavcoe27f@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbBj-+xY5jGLynUrg1GfSftZ+LT5DkADKz_+8+tL2kWMSw@mail.gmail.com>
 <20230403225017.onl5pbp7h2ugclbk@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbDQROKrWe732Qv1CsZwr6nMJN-2y77JW3EuT53D8At+Ow@mail.gmail.com>
 <20230406020656.7v5ongxyon5fr4s7@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbCEsucGRB+n5hTnPm-HssmB91HD4PFVRhdO=CZnJXfR6A@mail.gmail.com>
 <CAADnVQ+1VEBHTM5Rm-gx8-bg=tfv=4x+aONhF0bAmBFZG3W8Qg@mail.gmail.com>
 <CALOAHbAorooyteDjgs82TtujP4Fwo5hSkh-Z5QhxhV9p7_2mfw@mail.gmail.com> <CAADnVQKr5Y3z9f_Vv49DvRFcN+OF3JaFx_9NgBL58pz+TLq8ig@mail.gmail.com>
In-Reply-To: <CAADnVQKr5Y3z9f_Vv49DvRFcN+OF3JaFx_9NgBL58pz+TLq8ig@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 6 Apr 2023 13:43:59 +0800
Message-ID: <CALOAHbDdtj1Qd0h1jzXKN4R=_webEVW=sqYfhSFXXsYftyvnKw@mail.gmail.com>
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

On Thu, Apr 6, 2023 at 12:24=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Apr 5, 2023 at 8:22=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > On Thu, Apr 6, 2023 at 11:06=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Apr 5, 2023 at 7:55=E2=80=AFPM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > > >
> > > > It seems that I didn't describe the issue clearly.
> > > > The container doesn't have CAP_SYS_ADMIN, but the CAP_SYS_ADMIN is
> > > > required to run bpftool,  so the bpftool running in the container
> > > > can't get the ID of bpf objects or convert IDs to FDs.
> > > > Is there something that I missed ?
> > >
> > > Nothing. This is by design. bpftool needs sudo. That's all.
> > >
> >
> > Hmm, what I'm trying to do is make bpftool run without sudo.
>
> This is not a task that is worth solving.
>

Then the container with CAP_BPF enabled can't even iterate its bpf progs ..=
.

> > > > Some questions,
> > > > - What if the process exits after attaching the bpf prog and the pr=
og
> > > > is not auto-detachable?
> > > >   For example, the reuserport bpf prog is not auto-detachable. Afte=
r
> > > > pins the reuserport bpf prog, a task can attach it through the pinn=
ed
> > > > bpf file, but if the task forgets to detach it and the pinned file =
is
> > > > removed, then it seems there's no way to figure out which task or
> > > > cgroup this prog belongs to...
> > >
> > > you're saying that there is a bpf prog in the kernel without
> > > corresponding user space ?
> >
> > No, it is corresponding to user space. For example, it may be
> > corresponding to a socket fd, or a cgroup fd.
> >
> > > Meaning no user space process has an FD
> > > that points to this prog or FD to a map that this prog is using?
> > > In such a case this is truly kernel bpf prog. It doesn't belong to cg=
roup.
> > >
> >
> > Even if it is kernel bpf prog, it is created by a process. The user
> > needs to know which one created it.
>
> In some situations it's certainly interesting to know which process
> loaded a particular program.
> In many other situations it's irrelevant.
> For example, the process that loaded a prog could have been moved to a
> different cgroup.
> If you want to track the loading you need to install bpf_lsm
> that monitors prog_load hook and collect that info.
> It's not the job of the kernel to do it.
>

Agreed with you that we can add lots of hooks to track every detail of
the operations.
But it is not free. More hooks, more overhead.
If we can change the kernel to make it lightweight, why not...

> > > > - Could you pls. explain in detail how to get comm, pid, or cgroup
> > > > from a pinned bpffs file?
> > >
> > > pinned bpf prog and no user space holds FD to it?
> > > It's not part of any cgroup. Nothing to print.
> >
> > As I explained above, even if it holds nothing, the user needs to know
> > the information from it. For example, if it is expected, which one
> > created it?
>
> See the answer above. The kernel has enough hooks already to provide
> this information to user space. No kernel changes necessary.



--=20
Regards
Yafang
