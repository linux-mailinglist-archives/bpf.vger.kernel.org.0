Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BF06C99E2
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 05:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjC0DIZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 23:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjC0DIY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 23:08:24 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7423A9F;
        Sun, 26 Mar 2023 20:08:22 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id dw4so1194097qkb.10;
        Sun, 26 Mar 2023 20:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679886502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsTML7ShXC2IUudoT+DDAftZerBNUKTNBKixxg2nCsw=;
        b=iF8g8THKpuqoi1JuKLQcYs+vywFBWVq5jZBteT0P6VYHmwiBzasbld8BIVpeGl/tsh
         x+Ece3nNQ3hMDmYLHNDhCQCn/8YP8c7kNC0uoorcrniQTWN67HaPniEBhcQ4lK3eNoCr
         8xLiJqVfHA73zu+H0hiGCjihFGJ+OoR+84oTFmiCEC/lv5UrLwUUpdMZx4tbmkD5kR9f
         ulHxU5PiShpF1QRCoe3PKiIhDxEPLKKgLPS2+87/v1yBYajULwSwchhzz/8HTtJ0jMbL
         iQsrExGfdP5X71SnRhRv1LuCdFPL08gRvyOp+/6a4WZNwYteD7ulq+/jW8LEigLQYRkd
         gOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679886502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsTML7ShXC2IUudoT+DDAftZerBNUKTNBKixxg2nCsw=;
        b=eP6m/7Vyuya4RJn5OKNEoeYwPMxIimB6sPXooSiupzKpi7rVKcqhL36m/yZXvJvWya
         tj0Kt9p9N17719BnLR1R4rqg4tX2ktgLHSwzAJTiqxDqNLDRcigbc5FYE7EnqqziDvUW
         Ry3fLKi0LooxZTK6Pzdh3BOfV86BNclsbe3sX2Ne6sS27reSmUag8TXow8nLayAJp1Xz
         iioJdmwrbMQQPEJAv2RXUy2gZbVX6VKQdj9obLa+3r4/LynAmFoCTMx3/VYVcBhEz3s7
         vsXJyoq4Q4WfbHKY7gsBgMHWs13pBbu1+MKPTt7JtHn0lWnjaXQ6IhjTBu/llh6/RPJ4
         ldXw==
X-Gm-Message-State: AO0yUKUwMvgWEGW14cSgVpr7q+lFAkNKoAfWV8ei5J1bybfzwpt6NFZD
        2L5gOOP++sfB1xwxnmu1FedRMIQ9wkWUDJaWFj0=
X-Google-Smtp-Source: AK7set9mjJdU1PERsGsbJv0bOrCmi/p5Yqimpq/st1L+R89c4qV3gS23Paa4SV/CqDmjnKUCwKZNuvZ9Gd5Xly7jCas=
X-Received: by 2002:a05:620a:85c:b0:745:a78b:b32 with SMTP id
 u28-20020a05620a085c00b00745a78b0b32mr2390573qku.14.1679886501935; Sun, 26
 Mar 2023 20:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230326092208.13613-1-laoar.shao@gmail.com> <87pm8v7pnz.fsf@toke.dk>
In-Reply-To: <87pm8v7pnz.fsf@toke.dk>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 27 Mar 2023 11:07:46 +0800
Message-ID: <CALOAHbA-wRARTaKOrwqvf-rZF1BkNNuEGLgaysY7n6bAqmDRqg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sun, Mar 26, 2023 at 6:49=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@kernel.org> wrote:
>
> Yafang Shao <laoar.shao@gmail.com> writes:
>
> > Currently only CAP_SYS_ADMIN can iterate BPF object IDs and convert IDs
> > to FDs, that's intended for BPF's security model[1]. Not only does it
> > prevent non-privilidged users from getting other users' bpf program, bu=
t
> > also it prevents the user from iterating his own bpf objects.
> >
> > In container environment, some users want to run bpf programs in their
> > containers. These users can run their bpf programs under CAP_BPF and
> > some other specific CAPs, but they can't inspect their bpf programs in =
a
> > generic way. For example, the bpftool can't be used as it requires
> > CAP_SYS_ADMIN. That is very inconvenient.
> >
> > Without CAP_SYS_ADMIN, the only way to get the information of a bpf obj=
ect
> > which is not created by the process itself is with SCM_RIGHTS, that
> > requires each processes which created bpf object has to implement a uni=
x
> > domain socket to share the fd of a bpf object between different
> > processes, that is really trivial and troublesome.
> >
> > Hence we need a better mechanism to get bpf object info without
> > CAP_SYS_ADMIN.
> >
> > BPF namespace is introduced in this patchset with an attempt to remove
> > the CAP_SYS_ADMIN requirement. The user can create bpf map, prog and
> > link in a specific bpf namespace, then these bpf objects will not be
> > visible to the users in a different bpf namespace. But these bpf
> > objects are visible to its parent bpf namespace, so the sys admin can
> > still iterate and inspect them.
> >
> > BPF namespace is similar to PID namespace, and the bpf objects are
> > similar to tasks, so BPF namespace is very easy to understand. These
> > patchset only implements BPF namespace for bpf map, prog and link. In t=
he
> > future we may extend it to other bpf objects like btf, bpffs and etc.
>
> May? I think we should cover all of the existing BPF objects from the
> beginning here, or we may miss important interactions that will
> invalidate the whole idea.

This patchset is intended to address iterating bpf IDs and converting
IDs to FDs.  To be more specific, it covers
BPF_{PROG,MAP,LINK}_GET_NEXT_ID and BPF_{PROG,MAP,LINK}_GET_FD_BY_ID.
It should also include BPF_BTF_GET_NEXT_ID and BPF_BTF_GET_FD_BY_ID,
but I don't implement it because I find we can do more wrt BTF, for
example, if we can expose a small amount of BTFs in the vmlinux to
non-root bpf namespace.
But, yes, I should implement BTF ID in this patchset.

> In particular, I'm a little worried about the
> interaction between namespaces and bpffs; what happens if you're in a
> bpf namespace and you try to read a BPF object from a bpffs that belongs
> to a different namespace? Does the operation fail? Is the object hidden
> entirely? Something else?
>

bpffs is a different topic and it can be implemented in later patchsets.
bpffs has its own specific problem even without the bpf namespace.
1. The user can always get the information of a bpf object through its
corresponding pinned file.
In our practice, different container users have different bpffs, and
we allow the container user to bind-mount its bpffs only, so others'
bpffs are invisible.
To make it better with the bpf namespace, I think we can fail the
operation if the pinned file doesn't belong to its bpf namespace. That
said, we will add pinned bpf files into the bpf namespace in the next
step.

2. The user can always iterate bpf objects through progs.debug and maps.deb=
ug
progs.debug and maps.debug are debugging purposes only. So I think we
can handle it later.

--=20
Regards
Yafang
