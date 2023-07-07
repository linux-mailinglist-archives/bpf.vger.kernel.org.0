Return-Path: <bpf+bounces-4501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA01174BA42
	for <lists+bpf@lfdr.de>; Sat,  8 Jul 2023 01:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68262281993
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 23:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F1A17FFC;
	Fri,  7 Jul 2023 23:58:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC312F28
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 23:58:58 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A31128;
	Fri,  7 Jul 2023 16:58:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so27225775e9.0;
        Fri, 07 Jul 2023 16:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688774333; x=1691366333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lL1VuC57IJy1hxAXmMxzTHGKTa5t0RTLgsiQ2uX+fYM=;
        b=D3vZff5oCKQWJ50L1qgKOY68cXS5Ad32xpk5pMZ4WU9n4JqCacx1m0TUmoy6Cw5g2a
         JJtSImQT9JpzbjZscLZgdwgGWAZX4zNgeA7hRtMttIojY8We3KrNI2Ev4MniBOp0Ghsu
         iaMSMlLZaatFXAEfosdIyCBxECz/Q2jWPSw731F8R4lnhrAUJmGEsFvWwYxt7cyra7Cc
         TrvwgddPdF3lzB2IhW44N/xIhre8yqD0lVOocSVtTfNXVMcyZk9Y6cWg4r9r3HVAyYdb
         n3r7rAwZe7Or3oRKL8HwMQuqQW3SdsJ6WFTlVVROekXTHZb4VwdV5uTkL1GRUyhXzn7V
         jqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688774333; x=1691366333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lL1VuC57IJy1hxAXmMxzTHGKTa5t0RTLgsiQ2uX+fYM=;
        b=BMdsH+tKv1t86bpkeIl/axiS/QvZDeHVB1RwnqmZZr0KQE3RAD0v9GaLNYXKUB2Ezh
         szFd86YEim0gxdz7zUD/xYVg1et8o6DGkDL8lRwYWax758B2dKPuykeyFEYZ+YCC0jje
         vxjaoPTOar6Q33AhNMXvXBfrJK4ZOOCwwgS+3q4edBPu7X3wWieaEMAN3UJUpxSeilH0
         vCCtxwMhRwN1x8sz8tKbKxxQ+5bzHI0GwpvpE1+6fTx6aMflHs731GnH+etUpVTccb6B
         wNKS9mXJx8XFxB60VtXpTfMXpnl7VVx3PFX9O4GQ69fGG8AbJNQX5yICaiVYClHFG5Ws
         Ufrw==
X-Gm-Message-State: ABy/qLZhkVYwrJT5x5+C+rrwz1qB59L9mRlffAXMzzL+74z76cYPDDGz
	w6OOgrRvkL/zEGb5S3V4zM6lXOq3jF/EuBcrYv4=
X-Google-Smtp-Source: APBJJlFNcITenBcKPXBL/t2XzQpgvHa9Q0OZVm0Wbe2chWSkPTHIc5uCflVi0Ln8yvzAOZ0knHzblwijDSZy5ZSp19Q=
X-Received: by 2002:a1c:4c08:0:b0:3fa:a6ce:54ad with SMTP id
 z8-20020a1c4c08000000b003faa6ce54admr5087077wmf.6.1688774333040; Fri, 07 Jul
 2023 16:58:53 -0700 (PDT)
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
 <87lefrhnyk.fsf@toke.dk> <CAEf4BzZAeSKYOgHq5UTgPp+=z7bm6Fr5=OFC9Efr0aj4uVbaAQ@mail.gmail.com>
 <87pm53fklx.fsf@toke.dk>
In-Reply-To: <87pm53fklx.fsf@toke.dk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 7 Jul 2023 16:58:40 -0700
Message-ID: <CAEf4BzYd-vKGQ4GoCVGSPjroV4D1yHODTaRO-RwLZtUdYnkoZg@mail.gmail.com>
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

On Fri, Jul 7, 2023 at 3:00=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Fri, Jul 7, 2023 at 6:04=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@redhat.com> wrote:
> >>
> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >>
> >> > On Thu, Jul 6, 2023 at 4:32=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgen=
sen <toke@redhat.com> wrote:
> >> >>
> >> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >> >>
> >> >> > Having it as a separate single-purpose FS seems cleaner, because =
we
> >> >> > have use cases where we'd have one BPF FS instance created for a
> >> >> > container by our container manager, and then exposing a few separ=
ate
> >> >> > tokens with different sets of allowed functionality. E.g., one fo=
r
> >> >> > main intended workload, another for some BPF-based observability
> >> >> > tools, maybe yet another for more heavy-weight tools like bpftrac=
e for
> >> >> > extra debugging. In the debugging case our container infrastructu=
re
> >> >> > will be "evacuating" any other workloads on the same host to avoi=
d
> >> >> > unnecessary consequences. The point is to not disturb
> >> >> > workload-under-human-debugging as much as possible, so we'd like =
to
> >> >> > keep userns intact, which is why mounting extra (more permissive)=
 BPF
> >> >> > token inside already running containers is an important considera=
tion.
> >> >>
> >> >> This example (as well as Yafang's in the sibling subthread) makes i=
t
> >> >> even more apparent to me that it would be better with a model where=
 the
> >> >> userspace policy daemon can just make decisions on each call direct=
ly,
> >> >> instead of mucking about with different tokens with different embed=
ded
> >> >> permissions. Why not go that route (see my other reply for details =
on
> >> >> what I mean)?
> >> >
> >> > I don't know how you arrived at this conclusion,
> >>
> >> Because it makes it apparent that you're basically building a policy
> >> engine in the kernel with this...
> >
> > I disagree that this is a policy engine in the kernel. It's a building
> > block for delegation and enforcement. The policy itself is implemented
> > in user-space by a privileged process that decides when to issue BPF
> > tokens and of which configuration. And, optionally and if necessary,
> > further restricting using BPF LSM in a more fine-grained and dynamic
> > way.
>
> Right, and I'm saying that it's too coarse-grained to be a proper

CAP_BPF, CAP_PERFMON, CAP_SYS_ADMIN, CAP_NET_ADMIN are also very
coarse grained. And somehow we get by and make do with them outside of
the user namespace use case.

> building block in its own right. As evidenced by the need for adding an
> LSM on top to do anything fine-grained; a task which is decidedly

There is no *need* to add LSM. For tons of practical use cases you
won't need it. Yes, people will make a decision whether they even have
to bother with more fine grained controls. And if yes, LSM is there to
provide it.

> non-trivial to get right, BTW. Which means that the path of least
> resistance is going to be to just grant a token and not bother with the
> LSM, thus ending up with this being a giant foot gun from a security
> PoV.

If there is no need for LSM, yes, and I think it's totally acceptable.
It will be up to users to decide.

>
> >> > but we've debated BPF proxying and separate service at length, there
> >> > is no point in going on another round here.
> >>
> >> You had some objections to explicit proxying via RPC calls; I suggeste=
d
> >> a way of avoiding that by keeping the kernel in the loop, which you ha=
ve
> >
> > I thought we settled the seccomp notify proposal?
>
> Your objection to that was that it was too much of a hack to read all
> the target process memory (etc) from the policy daemon, which I
> acknowledged and suggested a way of keeping the kernel in the loop so it
> can take responsibility for the gnarly bits while still allowing
> userspace to actually make the decision:
>

Your proposal for some new mechanism for blocking bpf() syscall to let
another user space process make decision and somehow provide all the
necessary data to make this decision without that process needing to
read original process' memory (so presumably kernel will make a copy
of BPF program instructions, BTF contents, all the strings, etc, etc?)
sounded more like a joke and just a contrarian way to provide *any*
alternative, just to disagree with the much simpler and more
straightforward proposal.

I encourage you to spend some time prototyping this new mechanism,
sending RFC and gathering community feedback before using this
handwavy idea as an excuse to block BPF token-like mechanism. I'll be
curious to read the discussion on how it's different from
authoritative LSM, seccomp notify, etc, etc.

> https://lore.kernel.org/r/87v8ezb6x5.fsf@toke.dk
>
> (Last two paragraphs). Maybe that message just got lost somewhere on its
> way to your inbox?
>
> >> not responded to. If you're just going to go ahead with your solution
> >> over any objections you could just have stated so from the beginning a=
nd
> >> saved us all a lot of time :/
> >
> > It would also be good to understand that yours is but one of the
> > opinions. If you read the thread carefully you'll see that other
> > people have differing opinions. And yours doesn't necessarily have to
> > be the deciding one.
> >
> > I appreciate the feedback, but I don't appreciate the expectation that
> > your feedback is binding in any way.
>
> I'm not expecting veto rights, I'm objecting to being ignored. The way

You are not being ignored. We are just disagreeing. There is a
difference. BPF proxying was discussed at length and people who manage
large sets of BPF applications voiced their concerns. Security
concerns you have for BPF token are just as applicable to CAP_BPF and
other caps. BPF token actually allows to drop those very
coarse-grained capabilities in a bunch of circumstances and overall
improve the security. Also note, there were security folks in the
discussion which seem to be fine with the BPF token approach, overall.

You don't like my (and others') answers. That's fine, but please don't
pretend like you are being ignored.

> this development process is *supposed* to work (as far as I'm concerned)
> is that someone proposes a patch series, the community provides
> feedback, and discussion proceeds until there's at least rough consensus
> that the solution we've arrived at is the right way forward.

Rough consensus, not 100% consensus, though?.. There will always be
someone who disagrees.

>
> If you're going to cut that process short and just pick and choose which

Yep, clearly, going into the 3rd month of discussions (starting from
LSF/MM, and I don't even include the authoritative LSM discussions
before that) is cutting this process very short, of course.

> comments are worth addressing and which are not, I can't stop you,
> obviously; but at least do me the favour of being up front about it so I
> can stop wasting my time trying to be constructive.

I wouldn't say that a proposal like "some seccomp-notify-like
mechanism to let another process decide if bpf() syscall should
proceed" with not much effort put into thinking about how it should be
done specifically and whether it's actually a better approach was very
constructive. And it felt self-evident that it's not a good way,
especially after Christian himself said that the seccomp-based
approach is also not a good generic solution. Your proposal was just a
weird bpf()-specific (and not very well specified) twist on the
seccomp notify idea. But as I said above, give it a try, perhaps I'm
mistaken and the BPF community would love the idea and implementation.

>
> Anyhow, I guess this point is moot for this discussion since I'm about
> to leave for vacation for four weeks and won't be able to follow up on
> this. Apologies for the bad timing :/ I'll ping some RH folks and try to
> get them to keep an eye on this while I'm away...

Enjoy your vacation!

>
> >> Can we at least put this thing behind a kconfig option, so we can turn
> >> it off in distro kernels?
> >
> > Why can't distro disable this in some more dynamic way, though? With
> > existing LSM mechanism, sysctl, whatever? I think it would be useful
> > to let users have control over this and decide for themselves without
> > having to rebuild a custom kernel.
>
> A sysctl similar to the existing one for unprivileged BPF would be fine
> as well. If an LSM ends up being the only way to control it, though,
> that will carry so much operational overhead for us to get to a working
> state that it'll most likely be simpler to just patch it out of the
> kernel.

Sounds good, I will add sysctl for the next version.

>
> -Toke
>

