Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AE36EA064
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 02:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjDUABS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 20:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjDUABL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 20:01:11 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6AB2728;
        Thu, 20 Apr 2023 17:01:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5068e99960fso1702121a12.1;
        Thu, 20 Apr 2023 17:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682035268; x=1684627268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgqfDCsGm9i3n7SHOyH7IIkmcJRdrmpRODKEBqQlLn0=;
        b=aexlko6CHYivrK4+zvajQ6RHbLERssrKCQ0xLMGQS1A01nX1+JrNYg0bTPYPfrL0KL
         /4zJ6amtg4+3NK7fAlDR9i0Lvcf/jAs6PVfBIfqKei/qLscCWM2RKKcLsg8POnvYO05/
         wSWLKENpC0ou9oRpQwBpP0mKldxWwTYn6pdrN6Un5uSS4gVDYU5k4WANKjQpngaySgAC
         ucQ1giAEVoQjMdmKp4rPeDTazRAjjQzZ453+z3ISuMtsNbAjKH6oNOVYbkqDPBlA/SnG
         RlB/Eg5FgpSO62q8DNnsGdYC0thPuU1lNi0rn1The+QmY1FsqqQp1g2obAuVrHg7GLuz
         aFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682035268; x=1684627268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgqfDCsGm9i3n7SHOyH7IIkmcJRdrmpRODKEBqQlLn0=;
        b=gzTpT/tLK2bRJAgTS+0DNQoirw0L994le31LHXYZFC0qaKX8PARGjLals2L2AO9CBd
         n7UIddyYAWvDVe2et6Gz3+PnQJQ/+P1tz3a6UNPjG4wVZs7BQZabZNsZ6s1+AcQhKykH
         VG5o3g1ImH9dQx8fdtz9oyYF6ZvNqfZMtbrniUNJGPcna1Y7UOFA51PbaoirGBwXEU+Z
         XuGAqWCvzAX89lSe13WbkaFIOIuxCSUumaXrg+6K3iR70dRVHIpqx2MZ6pPCZdk+pHZV
         ZFDOiNx2fdZM6TZohcDqhs25KXRMrlUbzrr/OEQN3Nlr5n6mqVFR/8OPutcRqwOc/UHY
         ksZQ==
X-Gm-Message-State: AAQBX9e5aRQF6i3fBOq66MTwJkyyzuggZPrb3Jh2FMYuT/Jqw+hXVrHm
        Ot1PJlh8MKLuGFr0Zaj6QVzG6mRFm7VTvnU1r4c=
X-Google-Smtp-Source: AKy350YCYK8zky1RKgyztHY9BdnLI0RjrF6zsKAD27K4Eoj22lzB84rX8RDXkuDqAircMq1fPh0jVOVGIYgGmtU2efE=
X-Received: by 2002:aa7:c1d7:0:b0:506:747f:3bf0 with SMTP id
 d23-20020aa7c1d7000000b00506747f3bf0mr3744171edp.8.1682035267677; Thu, 20 Apr
 2023 17:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com> <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
 <6436f837.a70a0220.ada87.d446@mx.google.com> <CAHC9VhTF0JX3_zZ1ZRnoOw0ToYj6AsvK6OCiKqQgPvHepH9W3Q@mail.gmail.com>
 <CAEf4BzY9GPr9c2fTUS6ijHURtdNDL4xM6+JAEggEqLuz9sk4Dg@mail.gmail.com>
 <CAHC9VhT8RXG6zEwUdQZH4HE_HkF6B8XebWnUDc-k6AeH2NVe0w@mail.gmail.com>
 <CAEf4BzaRkAtyigmu9fybW0_+TZJJX2i93BXjiNUfazt2dFDFbQ@mail.gmail.com>
 <CAHC9VhQFJafyW5r9YzG47NjrBcKURj3D0V-u7eN2eb5tBM2pkg@mail.gmail.com>
 <CAEf4BzZa26JHa=gBgMm-sqyNy_S71-2Rs_-F6mrRXQF9z9KcmA@mail.gmail.com> <CAHC9VhRH6Z2r_A7YkDEmW7kiCA8e5j2u270gE48jpQmqS+t75A@mail.gmail.com>
In-Reply-To: <CAHC9VhRH6Z2r_A7YkDEmW7kiCA8e5j2u270gE48jpQmqS+t75A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 20 Apr 2023 17:00:55 -0700
Message-ID: <CAEf4BzaBt0W3sWh_L4RRXEFYdBotzVEnQdqC7BO+PNWtD7eSUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
To:     Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 18, 2023 at 7:21=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Apr 17, 2023 at 7:29=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Thu, Apr 13, 2023 at 8:11=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Thu, Apr 13, 2023 at 1:16=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > > On Wed, Apr 12, 2023 at 7:56=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > > > On Wed, Apr 12, 2023 at 9:43=E2=80=AFPM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > On Wed, Apr 12, 2023 at 12:07=E2=80=AFPM Paul Moore <paul@paul-=
moore.com> wrote:
> > > > > > > On Wed, Apr 12, 2023 at 2:28=E2=80=AFPM Kees Cook <keescook@c=
hromium.org> wrote:
> > > > > > > > On Wed, Apr 12, 2023 at 02:06:23PM -0400, Paul Moore wrote:
> > > > > > > > > On Wed, Apr 12, 2023 at 1:47=E2=80=AFPM Kees Cook <keesco=
ok@chromium.org> wrote:
> > > > > > > > > > On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wr=
ote:
> > > > > > > > > > > On Wed, Apr 12, 2023 at 12:33=E2=80=AFAM Andrii Nakry=
iko <andrii@kernel.org> wrote:
> > > > >
> > > > > ...
> > > > >
> > > > > > > > > > For example, in many places we have things like:
> > > > > > > > > >
> > > > > > > > > >         if (!some_check(...) && !capable(...))
> > > > > > > > > >                 return -EPERM;
> > > > > > > > > >
> > > > > > > > > > I would expect this is a similar logic. An operation ca=
n succeed if the
> > > > > > > > > > access control requirement is met. The mismatch we have=
 through-out the
> > > > > > > > > > kernel is that capability checks aren't strictly done b=
y LSM hooks. And
> > > > > > > > > > this series conceptually, I think, doesn't violate that=
 -- it's changing
> > > > > > > > > > the logic of the capability checks, not the LSM (i.e. t=
here no LSM hooks
> > > > > > > > > > yet here).
> > > > > > > > >
> > > > > > > > > Patch 04/08 creates a new LSM hook, security_bpf_map_crea=
te(), which
> > > > > > > > > when it returns a positive value "bypasses kernel checks"=
.  The patch
> > > > > > > > > isn't based on either Linus' tree or the LSM tree, I'm gu=
essing it is
> > > > > > > > > based on a eBPF tree, so I can't say with 100% certainty =
that it is
> > > > > > > > > bypassing a capability check, but the description claims =
that to be
> > > > > > > > > the case.
> > > > > > > > >
> > > > > > > > > Regardless of how you want to spin this, I'm not supporti=
ve of a LSM
> > > > > > > > > hook which allows a LSM to bypass a capability check.  A =
LSM hook can
> > > > > > > > > be used to provide additional access control restrictions=
 beyond a
> > > > > > > > > capability check, but a LSM hook should never be allowed =
to overrule
> > > > > > > > > an access denial due to a capability check.
> > > > > > > > >
> > > > > > > > > > The reason CAP_BPF was created was because there was no=
thing else that
> > > > > > > > > > would be fine-grained enough at the time.
> > > > > > > > >
> > > > > > > > > The LSM layer predates CAP_BPF, and one could make a very=
 solid
> > > > > > > > > argument that one of the reasons LSMs exist is to provide
> > > > > > > > > supplementary controls due to capability-based access con=
trols being a
> > > > > > > > > poor fit for many modern use cases.
> > > > > > > >
> > > > > > > > I generally agree with what you say, but we DO have this co=
de pattern:
> > > > > > > >
> > > > > > > >          if (!some_check(...) && !capable(...))
> > > > > > > >                  return -EPERM;
> > > > > > >
> > > > > > > I think we need to make this more concrete; we don't have a p=
attern in
> > > > > > > the upstream kernel where 'some_check(...)' is a LSM hook, ri=
ght?
> > > > > > > Simply because there is another kernel access control mechani=
sm which
> > > > > > > allows a capability check to be skipped doesn't mean I want t=
o allow a
> > > > > > > LSM hook to be used to skip a capability check.
> > > > > >
> > > > > > This work is an attempt to tighten the security of production s=
ystems
> > > > > > by allowing to drop too coarse-grained and permissive capabilit=
ies
> > > > > > (like CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, which inevitable all=
ow more
> > > > > > than production use cases are meant to be able to do) and then =
grant
> > > > > > specific BPF operations on specific BPF programs/maps based on =
custom
> > > > > > LSM security policy, which validates application trustworthines=
s using
> > > > > > custom production-specific logic.
> > > > >
> > > > > There are ways to leverage the LSMs to apply finer grained access
> > > > > control on top of the relatively coarse capabilities that do not
> > > > > require circumventing those capability controls.  One grants the
> > > > > capabilities, just as one would do today, and then leverages the
> > > > > security functionality of a LSM to further restrict specific user=
s,
> > > > > applications, etc. with a level of granularity beyond that offere=
d by
> > > > > the capability controls.
> > > >
> > > > Please help me understand something. What you and Casey are proposi=
ng,
> > > > when taken to the logical extreme, is to grant to all processes roo=
t
> > > > permissions and then use LSM to restrict specific actions, do I
> > > > understand correctly? This strikes me as a less secure and more
> > > > error-prone way of doing things.
> > >
> > > When taken to the "logical extreme" most concepts end up sounding a
> > > bit absurd, but that was the point, wasn't it?
> >
> > Wasn't my intent to make it sound absurd, sorry. The way I see it, for
> > the sake of example, let's say CAP_BPF allows 20 different operations
> > (each with its own security_xxx hook). And let's say in production I
> > want to only allow 3 of them. Sure, technically it should be possible
> > to deny access at 17 hooks and let it through in just those 3. But if
> > someone adds 21st and I forget to add 21st restriction, that would be
> > bad (but very probably with such approach).
>
> Welcome to the challenges of maintaining access controls within the
> Linux Kernel, LSM or otherwise.  As we all know, the Linux Kernel
> moves forward at a staggering pace sometimes, and it is not uncommon
> for new features/subsystems to be added without consulting all of the
> different folks who worry about access controls.  In many cases it can
> be a simple misunderstanding, but in some cases it's a willful
> rejection of a particular form of access control, the LSM being a
> prime example.  Thankfully in almost all of those cases we have been
> moderately successful in retrofitting the necessary access controls,
> sometimes they are not as good/capable/granular/etc. as we would like
> because of design limitations, but such is life.
>
> I say this not because I believe this is a valid argument for
> authoritative LSM hooks, I say this simply to acknowledge that this
> *is* a problem.
>

Ack, thanks.

> > So my point is that for situations like this, dropping CAP_BPF, but
> > allowing only 3 hooks to proceed seems a safer approach, because if we
> > add 21st hook, it will safely be denied without CAP_BPF *by default*.
> > That's what I tried to point out.
>
> I believe I understand your point, I just disagree with you on
> accepting authoritative LSM hooks in the upstream Linux Kernel; I
> believe it would be a *big* mistake to move away from the restrictive
> LSM hook philosophy at this point in time.

Ok, understood. While unfortunate, I'll stop pushing for authoritative LSMs=
.

>
> > But even if we ignore this "safe by default when a new hook is added"
> > behavior, when taking user namespaces into account, the restrictive
> > LSM approach just doesn't seem to work at all for something like
> > CAP_BPF. CAP_BPF cannot be "namespaced", just like, say, CAP_SYS_TIME,
> > because we cannot ensure that a given BPF program won't access kernel
> > state "belonging" to another process (as one example).
>
> Once again, the root of this problem lies in the capabilities and/or
> namespace mechanisms, not the LSM; if you want to fix this properly
> you should be looking at how eBPF leverages capabilities for access
> control.  Changing the very core behavior of the LSM layer in order to
> work around an issue with another access control mechanism is a
> non-starter.  I can't say this enough.

Alright. I now do have an alternative approach in mind that will only
use restrictive LSMs and will still allow BPF usage within user
namespaces.

>
> > Now, thanks to Jonathan, I get that there was a heated discussion 20
> > years ago about authoritative vs restrictive LSMs. But if I read a
> > summary at that time ([0]), authoritative hooks were not out of the
> > question *in principle*. Surely, "walk before we can run" makes sense,
> > but it's been a while ago.
>
> ... and once again, the restrictive approach has proven to work
> reasonably well over the past ~20 years, why would we abandon that
> simply to work around a problem with a different access control
> mechanism.  Don't break the LSM layer to fix something else.

There was no breakage introduced, let's call things by their proper
names. Surely, new hooks were authoritative, but they don't really
break anything, right? I understand that they go against your
restrictive-only LSM philosophy, but it's not a breakage in any proper
sense of that word. All existing hooks continue to work. New hooks
would work properly as well. It's not a breakage. I'm not saying this
to try to convince you, but let's not misrepresent what I tried to do
in this patch set.

>
> > > Here is a fun story which seems relevant ... in the early days of
> > > SELinux, one of the community devs setup up a system with a SELinux
> > > policy which restricted all privileged operations from the root user,
> > > put the system on a publicly accessible network, posted the root
> > > password for all to see, and invited the public to login to the syste=
m
> > > and attempt to exercise root privilege (it's been well over 10 years
> > > at this point so the details are a bit fuzzy).  Granted, there were
> > > some hiccups in the beginning, mostly due to the crude state of polic=
y
> > > development/analysis at the time, but after a few policy revisions th=
e
> > > system held up quite well.
> >
> > Honest question out of curiosity: was the intent to demonstrate that
> > with LSM one can completely restrict root? Or that root was actually
> > allowed to do something useful?
>
> The intent was to show that it is possible to restrict
> capability-based access controls with the LSM layer; it was the best
> example of the "logical extreme" carried out in the real world that I
> could think of when writing my response.
>
> > > On the more practical side of things, there are several use cases
> > > which require, by way of legal or contractual requirements, that full
> > > root/admin privileges are decomposed into separate roles: security
> > > admin, audit admin, backup admin, etc.  These users satisfy these
> > > requirements by using LSMs, such as SELinux, to restrict the
> > > administrative capabilities based on the SELinux user/role/domain.
> > >
> > > > By the way, even the above proposal of yours doesn't work for
> > > > production use cases when user namespaces are involved, as far as I
> > > > understand. We cannot grant CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN for
> > > > containers running inside user namespaces, as CAP_BPF in non-init
> > > > namespace is not enough for bpf() syscall to allow loading BPF maps=
 or
> > > > BPF program ...
> > >
> > > Once again, the LSM has always intended to be a restrictive mechanism=
,
> > > not a privilege granting mechanism.  If an operation is not possible
> >
> > Not according to [0] above:
>
> When one considers what has been present in Linus' tree, then yes.
> The idea of authoritative LSM hooks has been rejected for ~20 years
> and I've seen nothing in this thread to make me believe that we should
> change that now, and for this use case.

Ack.

>
> > > Based on your patches and our discussion, it seems to me that the
> > > problem you are trying to resolve is related more to the
> > > capability-based access controls in the eBPF, and possibly other
> > > kernel subsystems, and not any LSM-based restrictions.  I'm happy to
> > > work with you on a solution involving the LSM, but please understand
> > > that I'm not going to support a solution which changes a core
> > > philosophy of the LSM layer.
> >
> > Great, I'd really appreciate help and suggestions on how to solve the
> > following problem.
> >
> > We have a BPF subsystem that allows loading BPF programs. Those BPF
> > programs cannot be contained within a particular namespace just by its
> > system-wide tracing nature (it can safely read kernel and user memory
> > and we can't restrict whether that memory belongs to a particular
> > namespace), so it's like CAP_SYS_TIME, just with much broader API
> > surface.
> >
> > The other piece of a puzzle is user namespaces. We do want to run
> > applications inside user namespaces, but allow them to use BPF
> > programs. As far as I can tell, there is no way to grant real CAP_BPF
> > that will be recognized by capable(CAP_BPF) (not ns_capable, see above
> > about system-wide nature of BPF). If there is, please help me
> > understand how. All my local experiments failed, and looking at
> > cap_capable() implementation it is not intended to even check the
> > initial namespace's capability if the process is running in the user
> > namespace.
> >
> > So, given that a) we can't make CAP_BPF namespace-aware and b) we
> > can't grant real CAP_BPF to processes in user namespace, how could we
> > allow user namespaced applications to do useful work with BPF?
>
> I would start by talking with the user namespace folks.  I may be
> misunderstanding the problem as you've described it, but it seems like
> the core issue is how capabilities, specifically CAP_BPF, are handled
> in user namespaces.  To be honest, I'm not sure how much luck you'll
> have there, but you stand a better chance in changing how capabilities
> are handled across user namespaces than you do in getting an
> authoritative LSM hook merged.
>

You made it very clear, yes.

> Regardless, my offer still stands, if you have a solution which sticks
> to a restrictive LSM model, I'm happy to work with you further to sort
> out the details and try to make that work.  I don't have any great
> ideas there at the moment, but there are plenty of smart people on
> this mailing list and others who might have something clever in mind.

I do have a solution in mind. Stay tuned.

>
> --
> paul-moore.com
