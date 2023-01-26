Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9555E67C455
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 06:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjAZFe4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 00:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjAZFez (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 00:34:55 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D573E60B
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 21:34:54 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ss4so2234994ejb.11
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 21:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nkc9F8c5eaagFNz9tx8cGhLPdzPBsitLGelbAuE3MA=;
        b=BXLMV1sgf3R9yzhnna5kHHHJZd17mVFWDjhFZYUZGn5tII+YdNE9oz3NQUdaaBp6dq
         8YXR9cwpsVcK7UhYYscVWxfkM4Ony2mlQ3slO+Pt/JOufKOqzgdgUmVE3Uyxqgk+PpHy
         LycX+y+6P3X2znVuqmshQhyXmitkORvHDle2YpqWPIppF/83mN8h1clIVGfnrRUxi1pR
         zmRAmoKsDhl8D0kFQvFWD9kO/MpfdNp8fHD1LrBCeL8O/vVQ21ZrnM+hiyJ2CDtoUqmH
         eLSIPl9Q5kO/8gbIilRwuxP8B+HLqSH7NacWPy1fJQ+ruA2AF5cZbYmt/TwpS4kroYby
         OAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nkc9F8c5eaagFNz9tx8cGhLPdzPBsitLGelbAuE3MA=;
        b=rKKtkhF/VJ6UKSKKdpgTc8vWfMgfIt8GXLtb5IrmEGefnXVr6q/ykFWuP3YS4V0KJs
         YZ6cfqGsuFIXCxTEB5SU4l5fD+znjvudL9w2M9xQ1kPgDJoJNXLhXAIdk2tTE9Y1UISP
         utJdiHksFRmQML277OY1jsW6w6st0zMcLlajgzQqv/Y8AUJI5z0CgF4rllcf79+KIakh
         HN9BIDmIOXy2Ml4ItIMfI9nL0eJsS5nwVzQfYNVvAnSWJyrEXs94F6JavGQUE4Q7Yu5w
         vSAGD/+1hDbICrDV570zHmsDdaa7+2EK5ZlT5ExPi6QgWsbu4t6LPD9ZhiA25rr7ToXt
         9bLw==
X-Gm-Message-State: AFqh2kpFQKvQ+hWsjm9XrxU6Y+lwokzuufvRxv6wN0G72WaI6ZcH/Zrm
        /TjW+SpACjcww9173w0CyjRPUxOhqysctmFoRJQ=
X-Google-Smtp-Source: AMrXdXugXMZDovGnyfLXAHzLpjZs3M95/LhoZZ6fn5HwaXcSqBU4A/yK9uWsZ16/tG8AAyzqqhSgzkyRq8yap/Xr/Fc=
X-Received: by 2002:a17:906:7ac2:b0:86e:429b:6a20 with SMTP id
 k2-20020a1709067ac200b0086e429b6a20mr3881969ejo.247.1674711293031; Wed, 25
 Jan 2023 21:34:53 -0800 (PST)
MIME-Version: 1.0
References: <20230117212731.442859-1-toke@redhat.com> <CAKH8qBuvBomTXqNB+a6n_PbJKSNFazrAxEWsVT-=4XfztuJ7dw@mail.gmail.com>
 <87v8l4byyb.fsf@toke.dk> <CAKH8qBs=nEhhy2Qu7CpyAHx6gOaWR25tRF7aopti5-TSuw66HQ@mail.gmail.com>
 <CAADnVQKy1QzM+wg1BxfYA30QsTaM4M5RRCi+VHN6A7ah2BeZZw@mail.gmail.com>
 <CAKH8qBvZgoOe24MMY+Jn-6guJzGVuJS9zW4v6H+fhgcp7X_9jQ@mail.gmail.com>
 <3500bace-de87-0335-3fe3-6a5c0b4ce6ad@iogearbox.net> <20230119043247.tktxsztjcr3ckbby@MacBook-Pro-6.local>
 <875ycvo1im.fsf@toke.dk>
In-Reply-To: <875ycvo1im.fsf@toke.dk>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 25 Jan 2023 21:34:41 -0800
Message-ID: <CAADnVQ+q3uq6ex7NHZmP=x9rfsLCydE=97=V=cBcbO8yS0eySg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] Documentation/bpf: Add a description of "stable kfuncs"
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 24, 2023 at 5:18 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > The bpf developers adding new kfunc should assume that it's stable and =
proceed
> > to use it in bpf progs and production applications.
>
> "Assume all kfuncs are stable" is fine by me, but that is emphatically
> not what we have been saying thus far, quite the opposite...
>
> > The bpf maintainers will keep this stability promise. They obviously wi=
ll not
> > reap it out of the kernel on the whim, but they will nuke it if this kf=
unc
> > will be in the way of the kernel innovation.
>
> ...and it is contradicted by this last bit. I mean "it's stable, but
> we'll remove it if it's in the way" is not, well, stable.

Schrodinger's kfuncs :)

> [...]
>
> > bpf developers and users should assume that all kfuncs are stable and u=
se them.
> > When somebody comes to argue that a particular kfunc needs to change
> > the developer who added that kfunc better to be around to argue that th=
e kfunc is
> > perfect the way it is. If developer is gone the maintainers will make a=
 call.
> > It's a self regulating system.
> > kfuncs will be stable if developers/users are around.
> > Yet the maintainers will have a freedom to change if absolutely necessa=
ry.
>
> This assumes users (i.e., BPF program authors) are around during the
> development phase, which they are generally not. Except for the users
> who are also BPF devs, but that's a minority (if not now, hopefully in
> the future). So I really think we need to document some expectations
> here.
>
> For instance, what happens if we change a kfunc, and a user shows up
> during the -rc phase saying it broke their application? Are we going to
> revert that change?

It depends.
Obviously we're not going to change/remove/deprecate kfuncs unless
there is a need to do so.
And when we do we will consider all users.

> > Back to deprecation...
> > I think KF_DEPRECATED is a good idea.
> > When kfunc will be auto emitted into vmlinux.h (or whatever other file)
> > or shipped in libbpf header we can emit
> > __attribute__((deprecated("reason", "replacement")));
> > to that header file (so it's seen during bpf prog build) and
> > start dmesg warn on them in the verifier.
> > Kernel splats do get noticed. The users would have to act quickly.
>
> So how about documenting that bit? Something like:
>
> "We promise that kfuncs will not be removed without going through a
> deprecation phase. The length of the deprecation will be proportional to
> how long that kfunc has existed in the kernel, but will be no shorter
> than XX kernel releases." ?

That's not something we can promise.
Take conntrack kfuncs. If netfilter folks decide to sunset
conntrack tomorrow we won't be standing in their way.

On the other side the dynptr kfuncs are going to stay as-is for
foreseeable future because they don't rely on other kernel
subsystems to do the job.
Both cases may still change if users themselves
(after using it in prod) come back with reasons to change it.

In the past the kernel devs were dictating the helper uapi to
users and users had no option, but to shut up and use what's available.
Now they will be able to use new apis and request changes.
At that point it will be a set of users X vs a set of users Y.
If ten users say that this kfunc sucks while one user
wants to keep it as-is we will introduce another kfunc and
will start deprecating the one that lost the vote.
The deprecation time window will depend on case by case
considering maintenance cost, etc.

> > As far as KF_STABLE... I think it hurts the system in the long run.
> > The developer can argue at one point in time that kfunc has to be KF_ST=
ABLE.
> > The patch will be applied, but the developer is off the hook and can di=
sappear.
> > The maintainers would have to argue on behalf of the developer
> > and keep maintaining it? The maintainers won't have a signal whether
> > kfunc is still useful after initial KF_STABLE patch.
>
> Doing the above wrt deprecation without having an explicit stable tag
> would be OK with me.
>
> > I think it's more important to decide how we document kfuncs and
> > how equivalent of bpf_helper_defs.h can be done.
>
> I agree we (also) need to do this. As well as have some support for
> querying for them from userspace on a running kernel (for CO-RE
> purposes).

Of course. That has been brought up many times.
Just do it. Whoever has time to do it.
