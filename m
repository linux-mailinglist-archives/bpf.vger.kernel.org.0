Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22626CF935
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 04:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjC3ClP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 22:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC3ClP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 22:41:15 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13624EEA;
        Wed, 29 Mar 2023 19:41:13 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id u15so5394488qkk.4;
        Wed, 29 Mar 2023 19:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680144073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjVEPR8S7zAiPNAGe/r/OgVw0mDvg4fjJ36tKoBnhqw=;
        b=QrIiQz1enoLwWuraNVFVJI1EyTJpmDbLfOv40d6y2eCZXHhrrrAZUIczz4VwFBTZBx
         jNp8oijNzfo1oGojOGTxwxmtmTWvdNsIxLu729QVM5nI/PxWFnU3F3W2RpUkOrPtGJVB
         /dMpTqZxSplVpIxFxfhBcD/OXW/pEJmx79ZUHb+bsygYrgNyyTYtIvs/Km6bW+D/aoKJ
         u7MXvi1cWsHoo/CG33TT7LSBgiuz4m8LHFatjE6gWjpOHvgOIdRJtszicL7ki5E+ilSA
         KQ51VZh0cwwtCig+f1SkKRDvLyhabsNsho4SwJScMQOIR++R0gR/ZRZTQj18/p20kelz
         0FjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680144073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjVEPR8S7zAiPNAGe/r/OgVw0mDvg4fjJ36tKoBnhqw=;
        b=vmlL5sR5Ls+4KFWlEwiKr7LL3BIrfC5X8VdknTl73vnYEqN5qnxyxwB1mBDg1bTjEs
         VJ/5/jt+LWWI11ysj3Bj7+XrZMCI1EJsMtwlHCc5ks8w0ToufC/yX0hr/XQVRc70QGdA
         HooRFiqsYPZnrcqwx3OfJlssZ2oXGOyfFsUCHpbLb6FgXVKtsYkatEk4moyL6pkHEXj7
         6ki32dOI8FDl7CdCsUtIbdmH22eE7ktYl6FXmK6aUqkWwJxJJsElxK6UePC7kw3X9TY4
         Pm7LqkeSGNC9X7/gbSXQB6qEAbSbo2rBHCcP+mcqRVg4wmeZEGsi3ztO4NC6T8Ied8+X
         UBfg==
X-Gm-Message-State: AO0yUKXhhFqReFtzoblL5K9+frouxEzvxMxpcxNF7GPfwvgoMQeMAbyB
        BHDT2Ptreneqp+TIi3t2Z/ie6oQR+FZ8JCkEs9M=
X-Google-Smtp-Source: AK7set/RRBEgfFD0gRoHgtaM0TVhEXP1TLtW6qS70DzHix2akQ8jm2afakXxYBr7jZxeVK/n1qUxMyYbUtTySqj1lv4=
X-Received: by 2002:a05:620a:31a7:b0:745:90a0:613e with SMTP id
 bi39-20020a05620a31a700b0074590a0613emr4961945qkb.14.1680144072999; Wed, 29
 Mar 2023 19:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230326092208.13613-1-laoar.shao@gmail.com> <ZCHSOxto9DlEzVy9@google.com>
 <CALOAHbBJEXdR4Myk1zrgFDf9UJYu2-3tbjz0ETNvK3WamD5sFg@mail.gmail.com>
 <ZCMgpRtT6ywmtALi@google.com> <CALOAHbCc843AGvVftCumnNgM87NzqAYpPcPEj0i+aQ5QEOUW7Q@mail.gmail.com>
 <CAKH8qBuRS5mp5akkT-sQHHdnnjWZYKehppgO5D1vE5rhYPuo8Q@mail.gmail.com>
In-Reply-To: <CAKH8qBuRS5mp5akkT-sQHHdnnjWZYKehppgO5D1vE5rhYPuo8Q@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 30 Mar 2023 10:40:37 +0800
Message-ID: <CALOAHbDpv6AEOJQBP+unNHTOkuNtZFhp5OnOy7xWnsZWFqGGGg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
To:     Stanislav Fomichev <sdf@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Mar 30, 2023 at 4:50=E2=80=AFAM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On Tue, Mar 28, 2023 at 8:03=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Wed, Mar 29, 2023 at 1:15=E2=80=AFAM Stanislav Fomichev <sdf@google.=
com> wrote:
> > >
> > > On 03/28, Yafang Shao wrote:
> > > > On Tue, Mar 28, 2023 at 1:28=E2=80=AFAM Stanislav Fomichev <sdf@goo=
gle.com> wrote:
> > > > >
> > > > > On 03/26, Yafang Shao wrote:
> > > > > > Currently only CAP_SYS_ADMIN can iterate BPF object IDs and con=
vert
> > > > IDs
> > > > > > to FDs, that's intended for BPF's security model[1]. Not only d=
oes it
> > > > > > prevent non-privilidged users from getting other users' bpf pro=
gram,
> > > > but
> > > > > > also it prevents the user from iterating his own bpf objects.
> > > > >
> > > > > > In container environment, some users want to run bpf programs i=
n their
> > > > > > containers. These users can run their bpf programs under CAP_BP=
F and
> > > > > > some other specific CAPs, but they can't inspect their bpf prog=
rams
> > > > in a
> > > > > > generic way. For example, the bpftool can't be used as it requi=
res
> > > > > > CAP_SYS_ADMIN. That is very inconvenient.
> > > > >
> > > > > > Without CAP_SYS_ADMIN, the only way to get the information of a=
 bpf
> > > > object
> > > > > > which is not created by the process itself is with SCM_RIGHTS, =
that
> > > > > > requires each processes which created bpf object has to impleme=
nt a
> > > > unix
> > > > > > domain socket to share the fd of a bpf object between different
> > > > > > processes, that is really trivial and troublesome.
> > > > >
> > > > > > Hence we need a better mechanism to get bpf object info without
> > > > > > CAP_SYS_ADMIN.
> > > > >
> > > > > [..]
> > > > >
> > > > > > BPF namespace is introduced in this patchset with an attempt to=
 remove
> > > > > > the CAP_SYS_ADMIN requirement. The user can create bpf map, pro=
g and
> > > > > > link in a specific bpf namespace, then these bpf objects will n=
ot be
> > > > > > visible to the users in a different bpf namespace. But these bp=
f
> > > > > > objects are visible to its parent bpf namespace, so the sys adm=
in can
> > > > > > still iterate and inspect them.
> > > > >
> > > > > Does it essentially mean unpriv bpf?
> > >
> > > > Right. With CAP_BPF and some other CAPs enabled.
> > >
> > > > > Can I, as a non-root, create
> > > > > a new bpf namespace and start loading/attaching progs?
> > >
> > > > No, you can't create a new bpf namespace as a non-root, see also
> > > > copy_namespaces().
> > > > In the container environment, new namespaces are always created by
> > > > containered, which is started by root.
> > >
> > > Are you talking about "if (!ns_capable(user_ns, CAP_SYS_ADMIN))" part
> > > from copy_namespaces? Isn't it trivially bypassed with a new user
> > > namespace?
> > >
> > > IIUC, I can create a new user namespace which gives me CAP_SYS_ADMIN
> > > in this particular user-ns. Then I can go on and create a new bpf
> > > namespace (with CAP_BPF) and go wild? I won't see anything from the
> > > other namespaces, but I'll be able to load/attach bpf programs?
> > >
> >
> > I don't think so. If you create a new userspace, and give the process
> > the CAP_BPF or CAP_SYS_ADMIN in this new user namespace but not the
> > initial namespace, you can't do that. Because currently only CAP_BPF
> > or CAP_SYS_ADMIN in the init user namespace can load/attach bpf
> > programs.
> >
> > > > > Maybe add a paragraph about now vs whatever you're proposing.
> > >
> > > > What I'm proposing in this patchset is to put bpf objects (map, pro=
g,
> > > > link, and btf) into the bpf namespace. Next step I will put bpffs i=
nto
> > > > the bpf namespace as well.
> > > > That said, I'm trying to put  all the objects created in bpf into t=
he
> > > > bpf namespace. Below is a simple paragraph to illustrate it.
> > >
> > > > Regarding the unpriv user with CAP_BPF enabled,
> > > >                                                               Now |=
 Future
> > > > -------------------------------------------------------------------=
-----
> > > > Iterate his BPF IDs                                | N   |  Y  |
> > > > Iterate others' BPF IDs                          | N   |  N  |
> > > > Convert his BPF IDs to FDs                  | N   |  Y  |
> > > > Convert others' BPF IDs to FDs            | N   |  N  |
> > > > Get others' object info from pinned file  | Y(*) | N  |
> > > > -------------------------------------------------------------------=
-----
> > >
> > > > (*) It can be improved by,
> > > >       1). Different containers has different bpffs
> > > >       2). Setting file permission
> > > >       That's not perfect, for example, if one single user has two b=
pf
> > > > instances, but we don't want them to inspect each other.
> > >
> > > I think the question here is what happens to the existing
> > > capable(CAP_BPF) checks? Do they become ns_capable(CAP_BPF) eventuall=
y?
> > >
> >
> > They won't become ns_capable(CAP_BPF). If it becomes
> > ns_capable(CAP_BPF), it will really go wild then.
> >
> > > And if not, I don't think it integrates well with the user namespaces=
?
> > >
> >
> > IIUC, it is the CAP_BPF which doesn't integrate with the user
> > namespaces, right?
>
> Yeah. And it's probably fine if we don't, I just wanted to see some
> explanation on the long-term plan.
> If the purpose is to have a bpf namespace and use it for pure
> isolation purposes, let's state it clearly in the cover letter.

Will add it.

> Otherwise it's not clear whether it's only about isolation or
> potentially allowing CAP_BPF in user namespaces.
> Maybe clone(CLONE_NEWBPF|CLONE_NEWUSER) should return an explicit
> error? (or maybe it already does, haven't looked at the patches)
>

Good suggestion. It should return an error.  I will change it in the
next version.

> One other question I have is: should init bpf namespace see
> everything? Otherwise it might be hard to chase down the namespaces
> that loaded some BPF program...

Right, the init bpf namespace will see everything.

--=20
Regards
Yafang
