Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23036CF4BC
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 22:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjC2UvC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 16:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjC2Uu7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 16:50:59 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D1C4EC7
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 13:50:58 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-17997ccf711so17647843fac.0
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 13:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680123058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKZ8GqIMOOJV+XfNmnVFARmYio/PItz2BJFiPWuDGSY=;
        b=fuwFruqEcX0EYq8qW6g2AP0E1DdtapZohNO+DyP5pc2AtlzNd+22EhRcbUCquzkJ3o
         9ondMX7B4/3ZlXi7I1DArJceyY1jenpceRPefus+ASy+K2c7ia1aRS+3GzdLuDLHet1U
         F6iVGJEG/6ESVX7B6CewSuvp/TU0ln1xflg/CG0u1DtVzsJv4KXpUiAbewa/6jLmFtR7
         93JhXLtQy9slp+aO4ZIZt/xVi4QHSC1FP06khiuaejykUfbuzanPPHtrNpN2clyhn0dA
         2cUOWey18Xu74TMH3p2Lj7rAKAoiMWGv/hVjxs8TKjFO25Ldubc50fMD3E1uNFy/6puf
         xkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680123058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKZ8GqIMOOJV+XfNmnVFARmYio/PItz2BJFiPWuDGSY=;
        b=MDAbKJCPauzSFpo29Kootow8vvDK5cIP0IPfKLmjxQup89gh4Ejxsr1/4dzB9VFvaH
         gT/69Ul5nVHfeKrdLhMlCZhGPVBfmxhS8MaWohHG51ZuEU+e4rv1W/lSNjUa26HRBisY
         CsHEwNasoKxiOqhdmfNmV/U+MjtLLRX8CKdPv0GOpr5ssoMBY8pQmaDMxavFyEue1Zo8
         vkQLpRdp1rGBhBXJ6Zc+pLDptR0PfnGnKMjKSKMmsNo5IAHEuYCF5vaHJlAB/8PhI0OE
         tFQKiprnpnOTOlHvOpsUPZ31D9CNCl+mQjFKMyYNIcPdpm0iu5Wjb8PA6NcFClC/Xj2k
         WreQ==
X-Gm-Message-State: AAQBX9e1bHdEK4kZGvT/QaLKyhgqwAjHWFLYRzc1cTwEUS5A48lPdXn+
        6ezqZu5syoMoWDfmbtDswLTEWeZxX8rtc4rS7PXQBg==
X-Google-Smtp-Source: AKy350Y+kAtx1gY4HjjthjqP/HTIyk6FRS2h6MQd7ks70ztqf/xhYrlb+0Xf4oPw8b2Z8bGuN54EYWb9wk9wLqT0PE8=
X-Received: by 2002:a05:6870:8897:b0:17e:6e31:9aa4 with SMTP id
 m23-20020a056870889700b0017e6e319aa4mr7972519oam.6.1680123057921; Wed, 29 Mar
 2023 13:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230326092208.13613-1-laoar.shao@gmail.com> <ZCHSOxto9DlEzVy9@google.com>
 <CALOAHbBJEXdR4Myk1zrgFDf9UJYu2-3tbjz0ETNvK3WamD5sFg@mail.gmail.com>
 <ZCMgpRtT6ywmtALi@google.com> <CALOAHbCc843AGvVftCumnNgM87NzqAYpPcPEj0i+aQ5QEOUW7Q@mail.gmail.com>
In-Reply-To: <CALOAHbCc843AGvVftCumnNgM87NzqAYpPcPEj0i+aQ5QEOUW7Q@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 29 Mar 2023 13:50:45 -0700
Message-ID: <CAKH8qBuRS5mp5akkT-sQHHdnnjWZYKehppgO5D1vE5rhYPuo8Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 28, 2023 at 8:03=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Wed, Mar 29, 2023 at 1:15=E2=80=AFAM Stanislav Fomichev <sdf@google.co=
m> wrote:
> >
> > On 03/28, Yafang Shao wrote:
> > > On Tue, Mar 28, 2023 at 1:28=E2=80=AFAM Stanislav Fomichev <sdf@googl=
e.com> wrote:
> > > >
> > > > On 03/26, Yafang Shao wrote:
> > > > > Currently only CAP_SYS_ADMIN can iterate BPF object IDs and conve=
rt
> > > IDs
> > > > > to FDs, that's intended for BPF's security model[1]. Not only doe=
s it
> > > > > prevent non-privilidged users from getting other users' bpf progr=
am,
> > > but
> > > > > also it prevents the user from iterating his own bpf objects.
> > > >
> > > > > In container environment, some users want to run bpf programs in =
their
> > > > > containers. These users can run their bpf programs under CAP_BPF =
and
> > > > > some other specific CAPs, but they can't inspect their bpf progra=
ms
> > > in a
> > > > > generic way. For example, the bpftool can't be used as it require=
s
> > > > > CAP_SYS_ADMIN. That is very inconvenient.
> > > >
> > > > > Without CAP_SYS_ADMIN, the only way to get the information of a b=
pf
> > > object
> > > > > which is not created by the process itself is with SCM_RIGHTS, th=
at
> > > > > requires each processes which created bpf object has to implement=
 a
> > > unix
> > > > > domain socket to share the fd of a bpf object between different
> > > > > processes, that is really trivial and troublesome.
> > > >
> > > > > Hence we need a better mechanism to get bpf object info without
> > > > > CAP_SYS_ADMIN.
> > > >
> > > > [..]
> > > >
> > > > > BPF namespace is introduced in this patchset with an attempt to r=
emove
> > > > > the CAP_SYS_ADMIN requirement. The user can create bpf map, prog =
and
> > > > > link in a specific bpf namespace, then these bpf objects will not=
 be
> > > > > visible to the users in a different bpf namespace. But these bpf
> > > > > objects are visible to its parent bpf namespace, so the sys admin=
 can
> > > > > still iterate and inspect them.
> > > >
> > > > Does it essentially mean unpriv bpf?
> >
> > > Right. With CAP_BPF and some other CAPs enabled.
> >
> > > > Can I, as a non-root, create
> > > > a new bpf namespace and start loading/attaching progs?
> >
> > > No, you can't create a new bpf namespace as a non-root, see also
> > > copy_namespaces().
> > > In the container environment, new namespaces are always created by
> > > containered, which is started by root.
> >
> > Are you talking about "if (!ns_capable(user_ns, CAP_SYS_ADMIN))" part
> > from copy_namespaces? Isn't it trivially bypassed with a new user
> > namespace?
> >
> > IIUC, I can create a new user namespace which gives me CAP_SYS_ADMIN
> > in this particular user-ns. Then I can go on and create a new bpf
> > namespace (with CAP_BPF) and go wild? I won't see anything from the
> > other namespaces, but I'll be able to load/attach bpf programs?
> >
>
> I don't think so. If you create a new userspace, and give the process
> the CAP_BPF or CAP_SYS_ADMIN in this new user namespace but not the
> initial namespace, you can't do that. Because currently only CAP_BPF
> or CAP_SYS_ADMIN in the init user namespace can load/attach bpf
> programs.
>
> > > > Maybe add a paragraph about now vs whatever you're proposing.
> >
> > > What I'm proposing in this patchset is to put bpf objects (map, prog,
> > > link, and btf) into the bpf namespace. Next step I will put bpffs int=
o
> > > the bpf namespace as well.
> > > That said, I'm trying to put  all the objects created in bpf into the
> > > bpf namespace. Below is a simple paragraph to illustrate it.
> >
> > > Regarding the unpriv user with CAP_BPF enabled,
> > >                                                               Now | F=
uture
> > > ---------------------------------------------------------------------=
---
> > > Iterate his BPF IDs                                | N   |  Y  |
> > > Iterate others' BPF IDs                          | N   |  N  |
> > > Convert his BPF IDs to FDs                  | N   |  Y  |
> > > Convert others' BPF IDs to FDs            | N   |  N  |
> > > Get others' object info from pinned file  | Y(*) | N  |
> > > ---------------------------------------------------------------------=
---
> >
> > > (*) It can be improved by,
> > >       1). Different containers has different bpffs
> > >       2). Setting file permission
> > >       That's not perfect, for example, if one single user has two bpf
> > > instances, but we don't want them to inspect each other.
> >
> > I think the question here is what happens to the existing
> > capable(CAP_BPF) checks? Do they become ns_capable(CAP_BPF) eventually?
> >
>
> They won't become ns_capable(CAP_BPF). If it becomes
> ns_capable(CAP_BPF), it will really go wild then.
>
> > And if not, I don't think it integrates well with the user namespaces?
> >
>
> IIUC, it is the CAP_BPF which doesn't integrate with the user
> namespaces, right?

Yeah. And it's probably fine if we don't, I just wanted to see some
explanation on the long-term plan.
If the purpose is to have a bpf namespace and use it for pure
isolation purposes, let's state it clearly in the cover letter.
Otherwise it's not clear whether it's only about isolation or
potentially allowing CAP_BPF in user namespaces.
Maybe clone(CLONE_NEWBPF|CLONE_NEWUSER) should return an explicit
error? (or maybe it already does, haven't looked at the patches)

One other question I have is: should init bpf namespace see
everything? Otherwise it might be hard to chase down the namespaces
that loaded some BPF program...




> --
> Regards
> Yafang
