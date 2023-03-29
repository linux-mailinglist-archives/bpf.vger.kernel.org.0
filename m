Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631F76CD06E
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 05:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjC2DDG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 23:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjC2DDF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 23:03:05 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973DD1FCA;
        Tue, 28 Mar 2023 20:03:03 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id a5so13944954qto.6;
        Tue, 28 Mar 2023 20:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680058983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1jEYEzARIQDDzJYYG5cVoU/NSXO4XYbIyeilY6reS8=;
        b=FLTb1S1nPTzt734vK7eDRQSsLxjMFpPZhYOb5TgkJNyhmJGW2bbn4rZ/A3vwxFJdT/
         jx91qNYihSfc7uzDGzqLAZ1m5N5aMJyL6kwVoxtuNZv9AXVBAAoDk7mabZBj0/8/KgdY
         9qwMe6TS9aqzK9neYlmrmP32UY7lSg1ReiNWty0fjrD88rE2Br7PupufkQdPq6417d9/
         BUzx+9G7tQPDNKYcQyh+Zvwg5KiwY+Yks2Iv4mYZNMQ8VIgmdHbDr38DMH5XFi5mXk4c
         J+w2vMJ3eOnhvXpAdPXL8U+5+o4+UFkW0DANeljN7TlPj7vFiYzOpS+gZ5HF0us0fxkb
         NmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680058983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1jEYEzARIQDDzJYYG5cVoU/NSXO4XYbIyeilY6reS8=;
        b=w56xcSRjhe/VrcB0TrQ2ucHBLnr7e1dKjrWFrO+5Ao9EZDKAIJIQc7HrouO/SE+JXs
         JFvFQlhK3KoFm9BENR9MGueBNdgcHetfaEl28YPZWD8EVGQNvE5zruL1dP8wBPpYdj6r
         H68o7d3TtZDKSmdBBRBjuAZW/D/1LyZIKRQu2rXZDXYc6IRHLlIrxAqLadBXr/rjMcEe
         +QUwYN8lpvQ1IDNNcFcvR3hsbCBTzdCtBtnGdR8d7wB0apHvZXP5uXTLUys4yozseNIZ
         Scl9VIJ/Cl8OH0kiYv3sfR1n3jbEhfpGeCTFhllaHvblGlJBkoQ3d+TWfognGmIohLFl
         7DQg==
X-Gm-Message-State: AO0yUKURBwwBitAcMS+Q2YIfa7YkYbJFv12Nb7viQ7jJ53qEixpEyafh
        dLf0JZBV/FP97CKGuOcpbvgd1OuMUn819ELKjxBUj2H8L3KGSRXk
X-Google-Smtp-Source: AKy350bmjXK/aIoLb//Qz7+Eu/5lXdqWBZUkFRL4PU+vzti2K7pH8erSLKearuG9YUl+ukRugXAe13mDO+hhNH+8uLE=
X-Received: by 2002:a05:622a:199a:b0:3db:c138:ae87 with SMTP id
 u26-20020a05622a199a00b003dbc138ae87mr7109032qtc.6.1680058982708; Tue, 28 Mar
 2023 20:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230326092208.13613-1-laoar.shao@gmail.com> <ZCHSOxto9DlEzVy9@google.com>
 <CALOAHbBJEXdR4Myk1zrgFDf9UJYu2-3tbjz0ETNvK3WamD5sFg@mail.gmail.com> <ZCMgpRtT6ywmtALi@google.com>
In-Reply-To: <ZCMgpRtT6ywmtALi@google.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 29 Mar 2023 11:02:26 +0800
Message-ID: <CALOAHbCc843AGvVftCumnNgM87NzqAYpPcPEj0i+aQ5QEOUW7Q@mail.gmail.com>
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

On Wed, Mar 29, 2023 at 1:15=E2=80=AFAM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On 03/28, Yafang Shao wrote:
> > On Tue, Mar 28, 2023 at 1:28=E2=80=AFAM Stanislav Fomichev <sdf@google.=
com> wrote:
> > >
> > > On 03/26, Yafang Shao wrote:
> > > > Currently only CAP_SYS_ADMIN can iterate BPF object IDs and convert
> > IDs
> > > > to FDs, that's intended for BPF's security model[1]. Not only does =
it
> > > > prevent non-privilidged users from getting other users' bpf program=
,
> > but
> > > > also it prevents the user from iterating his own bpf objects.
> > >
> > > > In container environment, some users want to run bpf programs in th=
eir
> > > > containers. These users can run their bpf programs under CAP_BPF an=
d
> > > > some other specific CAPs, but they can't inspect their bpf programs
> > in a
> > > > generic way. For example, the bpftool can't be used as it requires
> > > > CAP_SYS_ADMIN. That is very inconvenient.
> > >
> > > > Without CAP_SYS_ADMIN, the only way to get the information of a bpf
> > object
> > > > which is not created by the process itself is with SCM_RIGHTS, that
> > > > requires each processes which created bpf object has to implement a
> > unix
> > > > domain socket to share the fd of a bpf object between different
> > > > processes, that is really trivial and troublesome.
> > >
> > > > Hence we need a better mechanism to get bpf object info without
> > > > CAP_SYS_ADMIN.
> > >
> > > [..]
> > >
> > > > BPF namespace is introduced in this patchset with an attempt to rem=
ove
> > > > the CAP_SYS_ADMIN requirement. The user can create bpf map, prog an=
d
> > > > link in a specific bpf namespace, then these bpf objects will not b=
e
> > > > visible to the users in a different bpf namespace. But these bpf
> > > > objects are visible to its parent bpf namespace, so the sys admin c=
an
> > > > still iterate and inspect them.
> > >
> > > Does it essentially mean unpriv bpf?
>
> > Right. With CAP_BPF and some other CAPs enabled.
>
> > > Can I, as a non-root, create
> > > a new bpf namespace and start loading/attaching progs?
>
> > No, you can't create a new bpf namespace as a non-root, see also
> > copy_namespaces().
> > In the container environment, new namespaces are always created by
> > containered, which is started by root.
>
> Are you talking about "if (!ns_capable(user_ns, CAP_SYS_ADMIN))" part
> from copy_namespaces? Isn't it trivially bypassed with a new user
> namespace?
>
> IIUC, I can create a new user namespace which gives me CAP_SYS_ADMIN
> in this particular user-ns. Then I can go on and create a new bpf
> namespace (with CAP_BPF) and go wild? I won't see anything from the
> other namespaces, but I'll be able to load/attach bpf programs?
>

I don't think so. If you create a new userspace, and give the process
the CAP_BPF or CAP_SYS_ADMIN in this new user namespace but not the
initial namespace, you can't do that. Because currently only CAP_BPF
or CAP_SYS_ADMIN in the init user namespace can load/attach bpf
programs.

> > > Maybe add a paragraph about now vs whatever you're proposing.
>
> > What I'm proposing in this patchset is to put bpf objects (map, prog,
> > link, and btf) into the bpf namespace. Next step I will put bpffs into
> > the bpf namespace as well.
> > That said, I'm trying to put  all the objects created in bpf into the
> > bpf namespace. Below is a simple paragraph to illustrate it.
>
> > Regarding the unpriv user with CAP_BPF enabled,
> >                                                               Now | Fut=
ure
> > -----------------------------------------------------------------------=
-
> > Iterate his BPF IDs                                | N   |  Y  |
> > Iterate others' BPF IDs                          | N   |  N  |
> > Convert his BPF IDs to FDs                  | N   |  Y  |
> > Convert others' BPF IDs to FDs            | N   |  N  |
> > Get others' object info from pinned file  | Y(*) | N  |
> > -----------------------------------------------------------------------=
-
>
> > (*) It can be improved by,
> >       1). Different containers has different bpffs
> >       2). Setting file permission
> >       That's not perfect, for example, if one single user has two bpf
> > instances, but we don't want them to inspect each other.
>
> I think the question here is what happens to the existing
> capable(CAP_BPF) checks? Do they become ns_capable(CAP_BPF) eventually?
>

They won't become ns_capable(CAP_BPF). If it becomes
ns_capable(CAP_BPF), it will really go wild then.

> And if not, I don't think it integrates well with the user namespaces?
>

IIUC, it is the CAP_BPF which doesn't integrate with the user
namespaces, right?

--=20
Regards
Yafang
