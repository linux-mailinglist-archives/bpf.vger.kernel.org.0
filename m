Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E2E6CB022
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 22:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjC0UvU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 16:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjC0UvT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 16:51:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3314ED1;
        Mon, 27 Mar 2023 13:51:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC185B81920;
        Mon, 27 Mar 2023 20:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50781C433EF;
        Mon, 27 Mar 2023 20:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679950275;
        bh=bztaAfyijMRB52sSuT0e9khxxEMPXVX9jN1n+ilSxTI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TvE9dTPBMgdyqjAgEWechzbepM4MABGV9YeXzC9sLIvP08jHNpwZeIbZt/LA4PbHv
         6kGRJNGfXWbklnAXzVh36wFCFKHlJb8x7XkkomnD86aoZj9kafWZVdPJ+IDm78fnaP
         03TU0+L0Xq7YVAqv+DKZbS3+NkndeiewuymHUgzwf2/fcl0OcXl63fZ0ESFdB7O6se
         6D0xkLRyixqfXvScDBjvkVAYe+QCZrWI+3eyJoZA7EYCSp48xMKo3qvKZ4lM2Xpjbl
         YKyfLVBJCOxDP0JcjEs/O2jlpoXfvsfo9KiD+kX3R6ceF7l1nDOuEZR2CF3j5MFPly
         rn+hxVGOzKn7g==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 50560A22736; Mon, 27 Mar 2023 22:51:12 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
In-Reply-To: <CALOAHbA-wRARTaKOrwqvf-rZF1BkNNuEGLgaysY7n6bAqmDRqg@mail.gmail.com>
References: <CALOAHbA-wRARTaKOrwqvf-rZF1BkNNuEGLgaysY7n6bAqmDRqg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 27 Mar 2023 22:51:12 +0200
Message-ID: <877cv17wan.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yafang Shao <laoar.shao@gmail.com> writes:

> On Sun, Mar 26, 2023 at 6:49=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@kernel.org> wrote:
>>
>> Yafang Shao <laoar.shao@gmail.com> writes:
>>
>> > Currently only CAP_SYS_ADMIN can iterate BPF object IDs and convert IDs
>> > to FDs, that's intended for BPF's security model[1]. Not only does it
>> > prevent non-privilidged users from getting other users' bpf program, b=
ut
>> > also it prevents the user from iterating his own bpf objects.
>> >
>> > In container environment, some users want to run bpf programs in their
>> > containers. These users can run their bpf programs under CAP_BPF and
>> > some other specific CAPs, but they can't inspect their bpf programs in=
 a
>> > generic way. For example, the bpftool can't be used as it requires
>> > CAP_SYS_ADMIN. That is very inconvenient.
>> >
>> > Without CAP_SYS_ADMIN, the only way to get the information of a bpf ob=
ject
>> > which is not created by the process itself is with SCM_RIGHTS, that
>> > requires each processes which created bpf object has to implement a un=
ix
>> > domain socket to share the fd of a bpf object between different
>> > processes, that is really trivial and troublesome.
>> >
>> > Hence we need a better mechanism to get bpf object info without
>> > CAP_SYS_ADMIN.
>> >
>> > BPF namespace is introduced in this patchset with an attempt to remove
>> > the CAP_SYS_ADMIN requirement. The user can create bpf map, prog and
>> > link in a specific bpf namespace, then these bpf objects will not be
>> > visible to the users in a different bpf namespace. But these bpf
>> > objects are visible to its parent bpf namespace, so the sys admin can
>> > still iterate and inspect them.
>> >
>> > BPF namespace is similar to PID namespace, and the bpf objects are
>> > similar to tasks, so BPF namespace is very easy to understand. These
>> > patchset only implements BPF namespace for bpf map, prog and link. In =
the
>> > future we may extend it to other bpf objects like btf, bpffs and etc.
>>
>> May? I think we should cover all of the existing BPF objects from the
>> beginning here, or we may miss important interactions that will
>> invalidate the whole idea.
>
> This patchset is intended to address iterating bpf IDs and converting
> IDs to FDs.  To be more specific, it covers
> BPF_{PROG,MAP,LINK}_GET_NEXT_ID and BPF_{PROG,MAP,LINK}_GET_FD_BY_ID.
> It should also include BPF_BTF_GET_NEXT_ID and BPF_BTF_GET_FD_BY_ID,
> but I don't implement it because I find we can do more wrt BTF, for
> example, if we can expose a small amount of BTFs in the vmlinux to
> non-root bpf namespace.
> But, yes, I should implement BTF ID in this patchset.

Right, as you can see by my comment on that patch, not including the btf
id is a tad confusing, so yeah, better include that.

>> In particular, I'm a little worried about the
>> interaction between namespaces and bpffs; what happens if you're in a
>> bpf namespace and you try to read a BPF object from a bpffs that belongs
>> to a different namespace? Does the operation fail? Is the object hidden
>> entirely? Something else?
>>
>
> bpffs is a different topic and it can be implemented in later patchsets.
> bpffs has its own specific problem even without the bpf namespace.
> 1. The user can always get the information of a bpf object through its
> corresponding pinned file.
> In our practice, different container users have different bpffs, and
> we allow the container user to bind-mount its bpffs only, so others'
> bpffs are invisible.
> To make it better with the bpf namespace, I think we can fail the
> operation if the pinned file doesn't belong to its bpf namespace. That
> said, we will add pinned bpf files into the bpf namespace in the next
> step.
>
> 2. The user can always iterate bpf objects through progs.debug and maps.d=
ebug
> progs.debug and maps.debug are debugging purposes only. So I think we
> can handle it later.

Well, I disagree. Working out these issues with bpffs is an important
aspect to get a consistent API, and handwaving it away risks merging
something that will turn out to not be workable further down the line at
which point we can't change it.

-Toke
