Return-Path: <bpf+bounces-4469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B4674B60C
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 19:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD96E281878
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 17:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2440171B1;
	Fri,  7 Jul 2023 17:58:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB34011181
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 17:58:21 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ACE2108;
	Fri,  7 Jul 2023 10:58:19 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso24036655e9.2;
        Fri, 07 Jul 2023 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688752697; x=1691344697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hk068Nxcv+Fpb+4P5bvL3hcI9mjOk06ChPeSbklSE5o=;
        b=izs4M121YqcnTik7wekJ7P14S1RdvCsHRkwmNPsZY9wNO7VJpp5hAGLOB/V/9aaDxt
         n+g0wgkf/Ncyul1W6ji0pPYApoMiI+0e7yyYcweYytI4B1/lTwcL+kzXoULhqzkGq/hg
         0IOh4svdbN5GTJfF7thaihAM4RqHzo3tMMzLBvC4yUOXO5ju7bwoSGQgiLD7A+9ch6dP
         RWrOvpwertuRce1TcSf0VKOrF6/388xKlY+wN9VHLLko2RSuWi13r/aEPwxg3Cy/hKBm
         +oUNwtK5+B7XzhjHCf0KpE3rhpXsauih6WwMamqw5Cx+DabqL1QNWXUuEdIg95IMfeiN
         I8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688752697; x=1691344697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hk068Nxcv+Fpb+4P5bvL3hcI9mjOk06ChPeSbklSE5o=;
        b=YK3U/PO4Lvla6OfyjbKZAXglUhjI2wSNNjoqtFNdU6DxlZLeFHdHBMpvu4/drcwRV5
         welXdGIrOnN6Y3NzgxeJyfOeAaMYpjmFxVYNPDZU1Aecul+kh5fCqRc46TLlsYULUVXi
         Mz4y5DZSLAOF2YN6A90unk0EhvcO+6/Ud+2l94/Z66gYCdAojP/fnkn79WRPEQbfEDI9
         buMV+w0z8+6vBEans+LepwjVh3ZeElgdJudGb6UMGQ0j/9Q++5uzqGqBxB01gbCg26He
         PNYJQMLFMVNqUaDuOL3ldv40k0K7plRhPvAP+xfg0qeiG/riaIYsHjCqrlFjx4OjD6b7
         XUQw==
X-Gm-Message-State: ABy/qLYKl9Dwo43KyxHnRP0Es4LB2FBkcPILRfEmPh7avjTxGwXHbMIA
	FfliUki5KAFjn/pJcr59+FEH3gG63ukDb+mA12fAZeCDwzg=
X-Google-Smtp-Source: APBJJlEcxLHkFQFfwJ93YiRQ8OAl/zmxbgDQ6Z/oJtQODdfCxiUngFKHrvpaQ489C0IIBDajGCI0BIi8/z5dLi5bCjw=
X-Received: by 2002:a7b:c5d4:0:b0:3fa:9e61:19ed with SMTP id
 n20-20020a7bc5d4000000b003fa9e6119edmr4231571wmk.23.1688752697298; Fri, 07
 Jul 2023 10:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629051832.897119-1-andrii@kernel.org> <20230629051832.897119-2-andrii@kernel.org>
 <20230704-hochverdient-lehne-eeb9eeef785e@brauner> <CAHC9VhTDocBCpNjdz1CoWM2DA76GYZmg31338DHePFGq_-ie-g@mail.gmail.com>
 <20230705-zyklen-exorbitant-4d54d2f220ad@brauner> <CAEf4Bza5mUou8nw1zjqFaCPPvfUNq-jpNp+y4DhMhhcXc5HwGg@mail.gmail.com>
 <87a5w9s2at.fsf@toke.dk> <CAEf4Bzaox7Q+ZVfuVnuia-=zPeBMYBG3-HT=bajT0OTMp6SQzg@mail.gmail.com>
 <87lefrhnyk.fsf@toke.dk>
In-Reply-To: <87lefrhnyk.fsf@toke.dk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 7 Jul 2023 10:58:04 -0700
Message-ID: <CAEf4BzZAeSKYOgHq5UTgPp+=z7bm6Fr5=OFC9Efr0aj4uVbaAQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 bpf-next 01/14] bpf: introduce BPF token object
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	lennart@poettering.net, cyphar@cyphar.com, luto@kernel.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 7, 2023 at 6:04=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Thu, Jul 6, 2023 at 4:32=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@redhat.com> wrote:
> >>
> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >>
> >> > Having it as a separate single-purpose FS seems cleaner, because we
> >> > have use cases where we'd have one BPF FS instance created for a
> >> > container by our container manager, and then exposing a few separate
> >> > tokens with different sets of allowed functionality. E.g., one for
> >> > main intended workload, another for some BPF-based observability
> >> > tools, maybe yet another for more heavy-weight tools like bpftrace f=
or
> >> > extra debugging. In the debugging case our container infrastructure
> >> > will be "evacuating" any other workloads on the same host to avoid
> >> > unnecessary consequences. The point is to not disturb
> >> > workload-under-human-debugging as much as possible, so we'd like to
> >> > keep userns intact, which is why mounting extra (more permissive) BP=
F
> >> > token inside already running containers is an important consideratio=
n.
> >>
> >> This example (as well as Yafang's in the sibling subthread) makes it
> >> even more apparent to me that it would be better with a model where th=
e
> >> userspace policy daemon can just make decisions on each call directly,
> >> instead of mucking about with different tokens with different embedded
> >> permissions. Why not go that route (see my other reply for details on
> >> what I mean)?
> >
> > I don't know how you arrived at this conclusion,
>
> Because it makes it apparent that you're basically building a policy
> engine in the kernel with this...

I disagree that this is a policy engine in the kernel. It's a building
block for delegation and enforcement. The policy itself is implemented
in user-space by a privileged process that decides when to issue BPF
tokens and of which configuration. And, optionally and if necessary,
further restricting using BPF LSM in a more fine-grained and dynamic
way.

>
> > but we've debated BPF proxying and separate service at length, there
> > is no point in going on another round here.
>
> You had some objections to explicit proxying via RPC calls; I suggested
> a way of avoiding that by keeping the kernel in the loop, which you have

I thought we settled the seccomp notify proposal?

> not responded to. If you're just going to go ahead with your solution
> over any objections you could just have stated so from the beginning and
> saved us all a lot of time :/

It would also be good to understand that yours is but one of the
opinions. If you read the thread carefully you'll see that other
people have differing opinions. And yours doesn't necessarily have to
be the deciding one.

I appreciate the feedback, but I don't appreciate the expectation that
your feedback is binding in any way.

>
> Can we at least put this thing behind a kconfig option, so we can turn
> it off in distro kernels?

Why can't distro disable this in some more dynamic way, though? With
existing LSM mechanism, sysctl, whatever? I think it would be useful
to let users have control over this and decide for themselves without
having to rebuild a custom kernel.

>
> > Per-call decisions can be achieved nicely by employing BPF LSM in a
> > restrictive manner on top of BPF token (or no token, if you are ok
> > without user namespaces).
>
> Building a deficient security delegation mechanism and saying "you can
> patch things up using an LSM" is a terrible design, though. Also, this

A bunch of people disagree with you.

> still means you have to implement all the policy checks in the kernel
> (just in BPF) which is awkward at best.

"Patch things up using an LSM", if necessary, in a restrictive manner
is what LSM folks prefer. You are also assuming that it's always
necessary, and I'm saying that in lots of practical contexts LSM won't
be even necessary.

>
> -Toke
>

