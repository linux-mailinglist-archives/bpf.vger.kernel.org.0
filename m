Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D291D6CB51F
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 05:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjC1Dt5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 23:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjC1Dt0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 23:49:26 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F9710F;
        Mon, 27 Mar 2023 20:49:24 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id bz27so10765043qtb.1;
        Mon, 27 Mar 2023 20:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679975363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYdPeA+UWexFRE0OoJTlmAdbF4mqSQlbLyQM/knBsw8=;
        b=WVKJYTG7vUfGNZTR4gZ+Fc33B8syBwIgaw/gdeXr2NDscAXo1jYEUnY9hTuGqN+L0N
         0w8qcUzJdgTAbWWo4rbJQFUQRf2sgrGhy53BRLRowp7m8SFX6d4ezzanP5penKfTy3e/
         uYFvaxKCkktmn9sgCkw3jE0fRIgDDEIEJrLhDwMKpfNh6kJQzqzrgRv3coLlVs2tgMyg
         R06tIHHGMa0eqt7mMTviZKZI4s01g3GTfMVyBAA3E3aWGWaifKcTlcq1/7hg/R+Pt0/C
         eSvx/A5QZknloRymoVkOiXiK1rHH+9oCOYs9v8qOzYWT0ilVZm9BRRK9Zq7VafpDzc7O
         TXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679975363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYdPeA+UWexFRE0OoJTlmAdbF4mqSQlbLyQM/knBsw8=;
        b=wbdFpJLJIga5bg01GwDzb6/6RKIv9XYFHGrD69wdYOnXF2xx3qQra8ubuMykcoJXY7
         oTaPnzWXDKTuvoKf4kR86OCN/H9faqis/F7dTMg6UjOaHFEVGZwTQkkMhL89j7/2UBbo
         Fd/oPhqM0dTKdMyvUL9ZJXemFYdUq5Z5H8m2DpQuoKw9bqxrrE8AgBTm/FGNkix/2Ivq
         75ki8ZRv7yRVOZC+1ZwEHc5tdZxxoTNBBMLGQZD/M8GKtXNjUU8uR3OhfAEqDA1I8frR
         rPCWTdgVKNr4UjP/H+Rh8csf6DDEplHasydxRTjNaGqCPRwePCQ3VzlCwbQmj8v8mxmt
         Tvbg==
X-Gm-Message-State: AAQBX9eY4Mm6lwm7wr7gvK4hTfVGsmL7JLEqqLbCFdH+gbr53jIVVXtQ
        P/YExL7okrDdw8WUTgfCZftJhMoKiyPuN5qGyaI=
X-Google-Smtp-Source: AKy350Z8N2H7Lk5QLmiJpPqxdtoiygkMVT4197lBsUC4Nbfrb6+XzoPBPj441J+RcxRrodU7omqH8ze5x6cxc/Bzqw4=
X-Received: by 2002:a05:622a:1998:b0:3e4:ed8e:6dd8 with SMTP id
 u24-20020a05622a199800b003e4ed8e6dd8mr1110161qtc.6.1679975363648; Mon, 27 Mar
 2023 20:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <CALOAHbA-wRARTaKOrwqvf-rZF1BkNNuEGLgaysY7n6bAqmDRqg@mail.gmail.com>
 <877cv17wan.fsf@toke.dk>
In-Reply-To: <877cv17wan.fsf@toke.dk>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 28 Mar 2023 11:48:47 +0800
Message-ID: <CALOAHbAd4NHCa4gaSLejyM6c9RYn+TEG=mX+NVnhBYa7Rp97sg@mail.gmail.com>
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

On Tue, Mar 28, 2023 at 4:51=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@kernel.org> wrote:
>
> Yafang Shao <laoar.shao@gmail.com> writes:
>
> > On Sun, Mar 26, 2023 at 6:49=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@kernel.org> wrote:
> >>
> >> Yafang Shao <laoar.shao@gmail.com> writes:
> >>
> >> > Currently only CAP_SYS_ADMIN can iterate BPF object IDs and convert =
IDs
> >> > to FDs, that's intended for BPF's security model[1]. Not only does i=
t
> >> > prevent non-privilidged users from getting other users' bpf program,=
 but
> >> > also it prevents the user from iterating his own bpf objects.
> >> >
> >> > In container environment, some users want to run bpf programs in the=
ir
> >> > containers. These users can run their bpf programs under CAP_BPF and
> >> > some other specific CAPs, but they can't inspect their bpf programs =
in a
> >> > generic way. For example, the bpftool can't be used as it requires
> >> > CAP_SYS_ADMIN. That is very inconvenient.
> >> >
> >> > Without CAP_SYS_ADMIN, the only way to get the information of a bpf =
object
> >> > which is not created by the process itself is with SCM_RIGHTS, that
> >> > requires each processes which created bpf object has to implement a =
unix
> >> > domain socket to share the fd of a bpf object between different
> >> > processes, that is really trivial and troublesome.
> >> >
> >> > Hence we need a better mechanism to get bpf object info without
> >> > CAP_SYS_ADMIN.
> >> >
> >> > BPF namespace is introduced in this patchset with an attempt to remo=
ve
> >> > the CAP_SYS_ADMIN requirement. The user can create bpf map, prog and
> >> > link in a specific bpf namespace, then these bpf objects will not be
> >> > visible to the users in a different bpf namespace. But these bpf
> >> > objects are visible to its parent bpf namespace, so the sys admin ca=
n
> >> > still iterate and inspect them.
> >> >
> >> > BPF namespace is similar to PID namespace, and the bpf objects are
> >> > similar to tasks, so BPF namespace is very easy to understand. These
> >> > patchset only implements BPF namespace for bpf map, prog and link. I=
n the
> >> > future we may extend it to other bpf objects like btf, bpffs and etc=
.
> >>
> >> May? I think we should cover all of the existing BPF objects from the
> >> beginning here, or we may miss important interactions that will
> >> invalidate the whole idea.
> >
> > This patchset is intended to address iterating bpf IDs and converting
> > IDs to FDs.  To be more specific, it covers
> > BPF_{PROG,MAP,LINK}_GET_NEXT_ID and BPF_{PROG,MAP,LINK}_GET_FD_BY_ID.
> > It should also include BPF_BTF_GET_NEXT_ID and BPF_BTF_GET_FD_BY_ID,
> > but I don't implement it because I find we can do more wrt BTF, for
> > example, if we can expose a small amount of BTFs in the vmlinux to
> > non-root bpf namespace.
> > But, yes, I should implement BTF ID in this patchset.
>
> Right, as you can see by my comment on that patch, not including the btf
> id is a tad confusing, so yeah, better include that.
>
> >> In particular, I'm a little worried about the
> >> interaction between namespaces and bpffs; what happens if you're in a
> >> bpf namespace and you try to read a BPF object from a bpffs that belon=
gs
> >> to a different namespace? Does the operation fail? Is the object hidde=
n
> >> entirely? Something else?
> >>
> >
> > bpffs is a different topic and it can be implemented in later patchsets=
.
> > bpffs has its own specific problem even without the bpf namespace.
> > 1. The user can always get the information of a bpf object through its
> > corresponding pinned file.
> > In our practice, different container users have different bpffs, and
> > we allow the container user to bind-mount its bpffs only, so others'
> > bpffs are invisible.
> > To make it better with the bpf namespace, I think we can fail the
> > operation if the pinned file doesn't belong to its bpf namespace. That
> > said, we will add pinned bpf files into the bpf namespace in the next
> > step.
> >
> > 2. The user can always iterate bpf objects through progs.debug and maps=
.debug
> > progs.debug and maps.debug are debugging purposes only. So I think we
> > can handle it later.
>
> Well, I disagree. Working out these issues with bpffs is an important
> aspect to get a consistent API, and handwaving it away risks merging
> something that will turn out to not be workable further down the line at
> which point we can't change it.
>

Sure, I will include bpffs in the next version.

--=20
Regards
Yafang
