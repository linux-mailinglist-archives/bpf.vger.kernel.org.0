Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AE86DA295
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 22:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239274AbjDFUXL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 16:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239377AbjDFUW5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 16:22:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED6F7290;
        Thu,  6 Apr 2023 13:22:40 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-4fa81d4f49cso1392263a12.1;
        Thu, 06 Apr 2023 13:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680812558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snlKLuOz3GvFzcu92FHHAqKHdZ2tDfaeUa7tXMrZtFc=;
        b=hgCshsZ+gLR2f6zPc1oc0EXLNSI684ud4VxmtxrnT+7pPjryFJ8G18hxRJaZlenH3W
         FIAodBScXNgs7vSQgAGGoBh3LCBs0y2BPSsw0v1z7/BTpsAHh21joC27Udr3T2mX+Yzy
         RA4mTOIZ4UyG4550CGKKqK+cBMGHHDiZkoANBKy8Emcl0YdZxeA0pzZFvVkOzkCef3K1
         1St3RHsUIxn58eYdmcrcVouvfQNgABbS6ENaNjgdVE/pWU46XvoNJj/RhaC0OXYbgOyX
         60Fn2un7qD1QKIZg9jOT+1NRCRI6oGSeZlNRbll/h8+QBBAvwOM1V+2LMo/Ig4rOb+QP
         Iw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680812558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snlKLuOz3GvFzcu92FHHAqKHdZ2tDfaeUa7tXMrZtFc=;
        b=z+QNQfFvxKyWCoj84TCNfHsGtm0ug04zxAZ4Pk0Gkkb/6fxLw2+RbRjW9HuQP3wQSs
         3zZCgAnvdoQsa6H7Q5DUscc1+h3+eusjaEl13dyBDMczO6SzYCdVUtjllAPAJYzx6vEl
         fCcys4jvPpZ/hvNUHEsJwWdZVvz9cgcw5Iu8WtRMDEcdrBnGa4OdgfedIH90UykG5N6u
         coWHtUROZ7MvnEWVIv5w5j3wuIEkefI3nGS6Yx1CklCZSRzoC2/j68vF1AQpIB6l8eIq
         6w1ieA8tOowOFiwsz0kl8ruUl0SDEB0SNiZxp4sexgdPyViOrS/sZKc1m+QLSqUEdUJ0
         5wpg==
X-Gm-Message-State: AAQBX9elzdtKpYUp9IPSsTrzAlyuJDWesq82tjndPnn8D8rfTeOkzU1X
        eOib1R75ILblRpRnAniHWuGKa2yuNBtrmDzBwsI=
X-Google-Smtp-Source: AKy350ZMvva26mgXGF7vrgUHG0waYNtH1LTZTSgnCM5j+8VSD2P0ZPFhTxeq2GsnZzaC4iAEU/PlQ95Yat3VPX4M2ps=
X-Received: by 2002:a50:9f27:0:b0:4c0:71e6:9dc5 with SMTP id
 b36-20020a509f27000000b004c071e69dc5mr412910edf.1.1680812558518; Thu, 06 Apr
 2023 13:22:38 -0700 (PDT)
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
 <CALOAHbAorooyteDjgs82TtujP4Fwo5hSkh-Z5QhxhV9p7_2mfw@mail.gmail.com>
 <CAADnVQKr5Y3z9f_Vv49DvRFcN+OF3JaFx_9NgBL58pz+TLq8ig@mail.gmail.com> <CALOAHbDdtj1Qd0h1jzXKN4R=_webEVW=sqYfhSFXXsYftyvnKw@mail.gmail.com>
In-Reply-To: <CALOAHbDdtj1Qd0h1jzXKN4R=_webEVW=sqYfhSFXXsYftyvnKw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Apr 2023 13:22:26 -0700
Message-ID: <CAEf4Bza_vM8HE5g+4ANW3NAAt8=+cn7Lw+DSkH42gimqzYxPdw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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

On Wed, Apr 5, 2023 at 10:44=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Thu, Apr 6, 2023 at 12:24=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Apr 5, 2023 at 8:22=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > >
> > > On Thu, Apr 6, 2023 at 11:06=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Wed, Apr 5, 2023 at 7:55=E2=80=AFPM Yafang Shao <laoar.shao@gmai=
l.com> wrote:
> > > > >
> > > > > It seems that I didn't describe the issue clearly.
> > > > > The container doesn't have CAP_SYS_ADMIN, but the CAP_SYS_ADMIN i=
s
> > > > > required to run bpftool,  so the bpftool running in the container
> > > > > can't get the ID of bpf objects or convert IDs to FDs.
> > > > > Is there something that I missed ?
> > > >
> > > > Nothing. This is by design. bpftool needs sudo. That's all.
> > > >
> > >
> > > Hmm, what I'm trying to do is make bpftool run without sudo.
> >
> > This is not a task that is worth solving.
> >
>
> Then the container with CAP_BPF enabled can't even iterate its bpf progs =
...

I'll leave the BPF namespace discussion aside (I agree that it needs
way more thought).

I am a bit surprised that we require CAP_SYS_ADMIN for GET_NEXT_ID
operations. GET_FD_BY_ID is definitely CAP_SYS_ADMIN, as they allow
you to take over someone else's link and stuff like this. But just
iterating IDs seems like a pretty innocent functionality, so maybe we
should remove CAP_SYS_ADMIN for GET_NEXT_ID?

By itself GET_NEXT_ID is relatively useless without capabilities, but
we've been floating the idea of providing GET_INFO_BY_ID (not by FD)
for a while now, and that seems useful in itself, as it would indeed
help tools like bpftool to get *some* information even without
privileges. Whether those GET_INFO_BY_ID operations should return same
full bpf_{prog,map,link,btf}_info or some trimmed down version of them
would be up to discussion, but I think getting some info without
creating an FD seems useful in itself.

Would it be worth discussing and solving this separately from
namespacing issues?

>
> > > > > Some questions,
> > > > > - What if the process exits after attaching the bpf prog and the =
prog
> > > > > is not auto-detachable?
> > > > >   For example, the reuserport bpf prog is not auto-detachable. Af=
ter
> > > > > pins the reuserport bpf prog, a task can attach it through the pi=
nned
> > > > > bpf file, but if the task forgets to detach it and the pinned fil=
e is
> > > > > removed, then it seems there's no way to figure out which task or
> > > > > cgroup this prog belongs to...
> > > >
> > > > you're saying that there is a bpf prog in the kernel without
> > > > corresponding user space ?
> > >
> > > No, it is corresponding to user space. For example, it may be
> > > corresponding to a socket fd, or a cgroup fd.
> > >
> > > > Meaning no user space process has an FD
> > > > that points to this prog or FD to a map that this prog is using?
> > > > In such a case this is truly kernel bpf prog. It doesn't belong to =
cgroup.
> > > >
> > >
> > > Even if it is kernel bpf prog, it is created by a process. The user
> > > needs to know which one created it.
> >
> > In some situations it's certainly interesting to know which process
> > loaded a particular program.
> > In many other situations it's irrelevant.
> > For example, the process that loaded a prog could have been moved to a
> > different cgroup.
> > If you want to track the loading you need to install bpf_lsm
> > that monitors prog_load hook and collect that info.
> > It's not the job of the kernel to do it.
> >
>
> Agreed with you that we can add lots of hooks to track every detail of
> the operations.
> But it is not free. More hooks, more overhead.
> If we can change the kernel to make it lightweight, why not...
>
> > > > > - Could you pls. explain in detail how to get comm, pid, or cgrou=
p
> > > > > from a pinned bpffs file?
> > > >
> > > > pinned bpf prog and no user space holds FD to it?
> > > > It's not part of any cgroup. Nothing to print.
> > >
> > > As I explained above, even if it holds nothing, the user needs to kno=
w
> > > the information from it. For example, if it is expected, which one
> > > created it?
> >
> > See the answer above. The kernel has enough hooks already to provide
> > this information to user space. No kernel changes necessary.
>
>
>
> --
> Regards
> Yafang
