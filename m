Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0A06EA063
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 02:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjDUABK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 20:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDUABJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 20:01:09 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B1B26A0;
        Thu, 20 Apr 2023 17:01:07 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-506b2a08877so1709480a12.2;
        Thu, 20 Apr 2023 17:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682035265; x=1684627265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfEZoO0GOWoBCtPsiVXSXsrFzTmhy+3EsqLGApHVL5c=;
        b=Hcmcp1+VLq2y4rcfr5AwKV3hoorZj9VqeowKHZb71a7mTsYB6i7BASMATNrdob/mWI
         jBAlKi6glWHwyBgs79ROsgM8ga7oKmM4krD2bAVXuKuBCPWPb6J6VkgckZTdPWHtK5D+
         I2C0j10n2OqGphYTWOwpJsW/+KH50vLhJjkz5gfP+zbn3ZCYnYyUeow7r2Bmw6l4b40G
         vfer4y5BqK6pE0gQa06QydXTMum4Ecuit62b6UWLUsS9bDQ9SZSx2anFShrHvnJ3eBeT
         5RgZAHO6cnSC+/UEwPE5/Z/t6/rkPRK4KUtiki6NyAfji04YV1196fMWXlwqeTxJBzb6
         g+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682035265; x=1684627265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfEZoO0GOWoBCtPsiVXSXsrFzTmhy+3EsqLGApHVL5c=;
        b=i34GSc1TJvmnsV0SSQMXvMubpmRY/hjrFNREyFxNGL1Q4ffMtBhkhfD7feDdR6Fvqa
         CheFV4fL/aKOiZPxycQson6D8HOBnzp34lpe5eb+diGbEDcCvdAYRicI0QA7uBRBSB/W
         25X9rj8BOEUXr2PKLGaHEraSQ0kd1QKjQN0uXnOOnoB6pViwoFS+YDLdxh2o8IEFsmWP
         BRVpFD8KPUh+wk1YCWpEc8OrcZ2PNnfzYdFFbQ6w45thls31Kj+Ov2kuU+AkpuB5pldt
         oB2ZItlzhiSVklC3CddjvPyg7N71q/YBDD6sAJcXu1cBE/LO3pN5nwZ089AXnrVVuA7N
         Hyng==
X-Gm-Message-State: AAQBX9cif9bTBSLPNB+YjCvRpbjUM3AnIHzGGAZ8yOHDZIKHGadyUMMh
        ZDbAQdqADiyR9zLNSfN70XWL9iGg7B6/Js4JGKE=
X-Google-Smtp-Source: AKy350YgZYc2beqFI7OpUYvUI+QQpKTgvBFe1DKiwlksJSopzD72GI0PAVjSqZySZZ30JyF+RzVsGVgWC7aT23TnRVg=
X-Received: by 2002:aa7:dd46:0:b0:504:a2e5:d951 with SMTP id
 o6-20020aa7dd46000000b00504a2e5d951mr3573494edw.13.1682035265203; Thu, 20 Apr
 2023 17:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com> <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
 <6436f837.a70a0220.ada87.d446@mx.google.com> <CAHC9VhTF0JX3_zZ1ZRnoOw0ToYj6AsvK6OCiKqQgPvHepH9W3Q@mail.gmail.com>
 <CAEf4BzY9GPr9c2fTUS6ijHURtdNDL4xM6+JAEggEqLuz9sk4Dg@mail.gmail.com>
 <CAHC9VhT8RXG6zEwUdQZH4HE_HkF6B8XebWnUDc-k6AeH2NVe0w@mail.gmail.com>
 <CAEf4BzaRkAtyigmu9fybW0_+TZJJX2i93BXjiNUfazt2dFDFbQ@mail.gmail.com>
 <CAHC9VhQFJafyW5r9YzG47NjrBcKURj3D0V-u7eN2eb5tBM2pkg@mail.gmail.com>
 <CAEf4BzZa26JHa=gBgMm-sqyNy_S71-2Rs_-F6mrRXQF9z9KcmA@mail.gmail.com> <ad70ee53-c774-6b50-33fc-d4568a3b5559@schaufler-ca.com>
In-Reply-To: <ad70ee53-c774-6b50-33fc-d4568a3b5559@schaufler-ca.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 20 Apr 2023 17:00:53 -0700
Message-ID: <CAEf4Bzb4TW+sYSGLFVxsvYsEHM0cXsEA2aVtaiT2QQCuQ+fnDw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>,
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

On Mon, Apr 17, 2023 at 5:48=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 4/17/2023 4:29 PM, Andrii Nakryiko wrote:
> > On Thu, Apr 13, 2023 at 8:11=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> >> On Thu, Apr 13, 2023 at 1:16=E2=80=AFAM Andrii Nakryiko
> >> <andrii.nakryiko@gmail.com> wrote:
> >>> On Wed, Apr 12, 2023 at 7:56=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> >>>> On Wed, Apr 12, 2023 at 9:43=E2=80=AFPM Andrii Nakryiko
> >>>> <andrii.nakryiko@gmail.com> wrote:
> >>>>> On Wed, Apr 12, 2023 at 12:07=E2=80=AFPM Paul Moore <paul@paul-moor=
e.com> wrote:
> >>>>>> On Wed, Apr 12, 2023 at 2:28=E2=80=AFPM Kees Cook <keescook@chromi=
um.org> wrote:
> >>>>>>> On Wed, Apr 12, 2023 at 02:06:23PM -0400, Paul Moore wrote:
> >>>>>>>> On Wed, Apr 12, 2023 at 1:47=E2=80=AFPM Kees Cook <keescook@chro=
mium.org> wrote:
> >>>>>>>>> On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
> >>>>>>>>>> On Wed, Apr 12, 2023 at 12:33=E2=80=AFAM Andrii Nakryiko <andr=
ii@kernel.org> wrote:
> >>>> ...
> >>>>
> >>>>>>>>> For example, in many places we have things like:
> >>>>>>>>>
> >>>>>>>>>         if (!some_check(...) && !capable(...))
> >>>>>>>>>                 return -EPERM;
> >>>>>>>>>
> >>>>>>>>> I would expect this is a similar logic. An operation can succee=
d if the
> >>>>>>>>> access control requirement is met. The mismatch we have through=
-out the
> >>>>>>>>> kernel is that capability checks aren't strictly done by LSM ho=
oks. And
> >>>>>>>>> this series conceptually, I think, doesn't violate that -- it's=
 changing
> >>>>>>>>> the logic of the capability checks, not the LSM (i.e. there no =
LSM hooks
> >>>>>>>>> yet here).
> >>>>>>>> Patch 04/08 creates a new LSM hook, security_bpf_map_create(), w=
hich
> >>>>>>>> when it returns a positive value "bypasses kernel checks".  The =
patch
> >>>>>>>> isn't based on either Linus' tree or the LSM tree, I'm guessing =
it is
> >>>>>>>> based on a eBPF tree, so I can't say with 100% certainty that it=
 is
> >>>>>>>> bypassing a capability check, but the description claims that to=
 be
> >>>>>>>> the case.
> >>>>>>>>
> >>>>>>>> Regardless of how you want to spin this, I'm not supportive of a=
 LSM
> >>>>>>>> hook which allows a LSM to bypass a capability check.  A LSM hoo=
k can
> >>>>>>>> be used to provide additional access control restrictions beyond=
 a
> >>>>>>>> capability check, but a LSM hook should never be allowed to over=
rule
> >>>>>>>> an access denial due to a capability check.
> >>>>>>>>
> >>>>>>>>> The reason CAP_BPF was created was because there was nothing el=
se that
> >>>>>>>>> would be fine-grained enough at the time.
> >>>>>>>> The LSM layer predates CAP_BPF, and one could make a very solid
> >>>>>>>> argument that one of the reasons LSMs exist is to provide
> >>>>>>>> supplementary controls due to capability-based access controls b=
eing a
> >>>>>>>> poor fit for many modern use cases.
> >>>>>>> I generally agree with what you say, but we DO have this code pat=
tern:
> >>>>>>>
> >>>>>>>          if (!some_check(...) && !capable(...))
> >>>>>>>                  return -EPERM;
> >>>>>> I think we need to make this more concrete; we don't have a patter=
n in
> >>>>>> the upstream kernel where 'some_check(...)' is a LSM hook, right?
> >>>>>> Simply because there is another kernel access control mechanism wh=
ich
> >>>>>> allows a capability check to be skipped doesn't mean I want to all=
ow a
> >>>>>> LSM hook to be used to skip a capability check.
> >>>>> This work is an attempt to tighten the security of production syste=
ms
> >>>>> by allowing to drop too coarse-grained and permissive capabilities
> >>>>> (like CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, which inevitable allow m=
ore
> >>>>> than production use cases are meant to be able to do) and then gran=
t
> >>>>> specific BPF operations on specific BPF programs/maps based on cust=
om
> >>>>> LSM security policy, which validates application trustworthiness us=
ing
> >>>>> custom production-specific logic.
> >>>> There are ways to leverage the LSMs to apply finer grained access
> >>>> control on top of the relatively coarse capabilities that do not
> >>>> require circumventing those capability controls.  One grants the
> >>>> capabilities, just as one would do today, and then leverages the
> >>>> security functionality of a LSM to further restrict specific users,
> >>>> applications, etc. with a level of granularity beyond that offered b=
y
> >>>> the capability controls.
> >>> Please help me understand something. What you and Casey are proposing=
,
> >>> when taken to the logical extreme, is to grant to all processes root
> >>> permissions and then use LSM to restrict specific actions, do I
> >>> understand correctly? This strikes me as a less secure and more
> >>> error-prone way of doing things.
> >> When taken to the "logical extreme" most concepts end up sounding a
> >> bit absurd, but that was the point, wasn't it?
> > Wasn't my intent to make it sound absurd, sorry. The way I see it, for
> > the sake of example, let's say CAP_BPF allows 20 different operations
> > (each with its own security_xxx hook). And let's say in production I
> > want to only allow 3 of them. Sure, technically it should be possible
> > to deny access at 17 hooks and let it through in just those 3. But if
> > someone adds 21st and I forget to add 21st restriction, that would be
> > bad (but very probably with such approach).
>
> That would be a flaw in the implementation of the 21st, not a problem
> with the capabilities or LSM model. For the LSM model to be sufficiently
> flexible it cannot be required to prevent or detect coding errors.
>
> > So my point is that for situations like this, dropping CAP_BPF, but
> > allowing only 3 hooks to proceed seems a safer approach, because if we
> > add 21st hook, it will safely be denied without CAP_BPF *by default*.
> > That's what I tried to point out.
>
> When you're creating security relevant or enforcing mechanisms there has
> too be a level of expectation regarding the care with which they're
> developed. My expectation is that the 21st hook won't go in without
> adequate review.
>

That's not how it works with BPF LSM, but there is no point in arguing
about this. I agree that LSM shouldn't be prevent from adding new
hooks just because of some particular LSM implementation.

> > But even if we ignore this "safe by default when a new hook is added"
> > behavior, when taking user namespaces into account, the restrictive
> > LSM approach just doesn't seem to work at all for something like
> > CAP_BPF. CAP_BPF cannot be "namespaced", just like, say, CAP_SYS_TIME,
> > because we cannot ensure that a given BPF program won't access kernel
> > state "belonging" to another process (as one example).
>
> Time namespaces have been proposed. I would be surprised if there aren't
> people working on BPF namespaces somewhere. There's a difference between
> "can't" and "haven't been".
>

It really is "can't" for BPF, as it allows tracing of kernel internals.

> > Now, thanks to Jonathan, I get that there was a heated discussion 20
> > years ago about authoritative vs restrictive LSMs. But if I read a
> > summary at that time ([0]), authoritative hooks were not out of the
> > question *in principle*. Surely, "walk before we can run" makes sense,
> > but it's been a while ago.
>
> Certainly. The SGI comment was mine, by the way. I wanted authoritative
> hooks for cases like POSIX ACLs and systems without root. While I would
> have liked the decision to go the other way, there's no way I would endor=
se
> a hybrid, where some hooks are restrictive and others authoritative.
>

Yep, saw your comments as well. Can't say I get what would be wrong
with having authoritative hooks together with restrictive ones, but oh
well.


> >   [0] https://lwn.net/2001/1108/a/no-auth-hooks.php3
> >
> >
> >> Here is a fun story which seems relevant ... in the early days of
> >> SELinux, one of the community devs setup up a system with a SELinux
> >> policy which restricted all privileged operations from the root user,
> >> put the system on a publicly accessible network, posted the root
> >> password for all to see, and invited the public to login to the system
> >> and attempt to exercise root privilege (it's been well over 10 years
> >> at this point so the details are a bit fuzzy).  Granted, there were
> >> some hiccups in the beginning, mostly due to the crude state of policy
> >> development/analysis at the time, but after a few policy revisions the
> >> system held up quite well.
> > Honest question out of curiosity: was the intent to demonstrate that
> > with LSM one can completely restrict root? Or that root was actually
> > allowed to do something useful? Because I can see how rejecting
> > everything would be rather simple, but actually pretty useless in
> > practice. Restricting only part of the power of the root, while still
> > allowing it to do something useful in production seems like a much
> > harder (but way more valuable) endeavor. Not saying it's impossible,
> > but see my example about missing 21st new CAP_BPF functionality.
>
> Capabilities are sufficient to implement a rootless system. It's been don=
e.
> Someone will point out that CAP_SYS_ADMIN is effectively root, and there'=
s
> some truth to that.
>
> >> On the more practical side of things, there are several use cases
> >> which require, by way of legal or contractual requirements, that full
> >> root/admin privileges are decomposed into separate roles: security
> >> admin, audit admin, backup admin, etc.  These users satisfy these
> >> requirements by using LSMs, such as SELinux, to restrict the
> >> administrative capabilities based on the SELinux user/role/domain.
> >>
> >>> By the way, even the above proposal of yours doesn't work for
> >>> production use cases when user namespaces are involved, as far as I
> >>> understand. We cannot grant CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN for
> >>> containers running inside user namespaces, as CAP_BPF in non-init
> >>> namespace is not enough for bpf() syscall to allow loading BPF maps o=
r
> >>> BPF program ...
> >> Once again, the LSM has always intended to be a restrictive mechanism,
> >> not a privilege granting mechanism.  If an operation is not possible
> > Not according to [0] above:
> >
> >   > It is our belief that these changes do not belong in the initial ve=
rsion of
> >   > LSM (especially given our limited charter and original goals), and =
should
> >   > be proposed as incremental refinements after LSM has been initially
> >   > accepted.
> >   > ...
> >   > It is our belief that the current LSM
> >   > will provide a meaningful improvement in the security infrastructur=
e of the
> >   > Linux kernel, and that there is plenty of room for future expansion=
 of LSM
> >   > in subsequent phases.
> >
> > I don't see "always intended to be a restrictive mechanism" there.
>
> Having been on the other side of the argument, the system that was accept=
ed
> was in fact "always intended to be a restrictive mechanism". The quote ab=
ove
> is a "never say never" statement.
>
> >> without the LSM layer enabled, it should not be possible with the LSM
> >> layer enabled.  The LSM is not a mechanism to circumvent other access
> >> control mechanisms in the kernel.
> > I understand, but it's not like we are proposing to go and bypass all
> > kinds of random kernel security mechanisms. These are targeted hooks,
> > developed by the BPF community for the BPF subsystem to allow trusted
> > unprivileged production use cases. Yes, we currently rely on checking
> > CAP_BPF to grant more dangerous/advanced features, but it's because we
> > can't just allow any unprivileged process to do this. But what we
> > really want is to answer the question "can we trust this process to
> > use this advanced functionality", and if there is no specific LSM
> > policy that cares one way (allow) or the other (disallow), fallback to
> > CAP_BPF enforcement.
> >
> > So it's not bypassing kernel checks, but rather augmenting them with
> > more flexible and customizable mechanisms, while still falling back to
> > CAP_BPF if the user didn't install any custom LSM policy.
>
> That would make CAP_BPF behave differently from all other capabilities.
> Capabilities are hard enough to use correctly as it is. If each capabilit=
y
> defined its own semantics they would be completely unusable.
>
> >>> Also, in previous email you said:
> >>>
> >>>> Simply because there is another kernel access control mechanism whic=
h
> >>>> allows a capability check to be skipped doesn't mean I want to allow=
 a
> >>>> LSM hook to be used to skip a capability check.
> >>> I understand your stated position, but can you please help me
> >>> understand the reasoning behind it?
> >> Keeping the LSM as a restrictive access control mechanism helps ensure
> >> some level of sanity and consistency across different Linux
> >> installations.  If a certain operation requires CAP_SYS_ADMIN on one
> >> Linux system, it should require CAP_SYS_ADMIN on another Linux system.
> >> Granted, a LSM running on one system might impose additional
> >> constraints on that operation, but the CAP_SYS_ADMIN requirement still
> >> applies.
> >>
> >> There is also an issue of safety in knowing that enabling a LSM will
> >> not degrade the access controls on a system by potentially granting
> >> operations that were previously denied.
> >>
> >>> Does the above also mean that you'd be fine if we just don't plug int=
o
> >>> the LSM subsystem at all and instead come up with some ad-hoc solutio=
n
> >>> to allow effectively the same policies? This sounds detrimental both
> >>> to LSM and BPF subsystems, so I hope we can talk this through before
> >>> finalizing decisions.
> >> Based on your patches and our discussion, it seems to me that the
> >> problem you are trying to resolve is related more to the
> >> capability-based access controls in the eBPF, and possibly other
> >> kernel subsystems, and not any LSM-based restrictions.  I'm happy to
> >> work with you on a solution involving the LSM, but please understand
> >> that I'm not going to support a solution which changes a core
> >> philosophy of the LSM layer.
> > Great, I'd really appreciate help and suggestions on how to solve the
> > following problem.
> >
> > We have a BPF subsystem that allows loading BPF programs. Those BPF
> > programs cannot be contained within a particular namespace just by its
> > system-wide tracing nature (it can safely read kernel and user memory
> > and we can't restrict whether that memory belongs to a particular
> > namespace), so it's like CAP_SYS_TIME, just with much broader API
> > surface.
>
> This doesn't sound like a problem, it sounds like BPF is explicitly
> designed to prevent interference by namespaces. But in some cases you
> now want to limit it by namespaces.
>
> It appears that the desired uses of BPF are no longer compatible with
> its original security model. That's unfortunate, and likely to require
> a significant change to the implementation of BPF.
>

I have some new ideas, so hopefully not as significant. While I still
think that authoritative LSM hooks would be great, I'll stop arguing.
I'll get back with a different proposal that would allow BPF usage
within user namespaces. We still will want LSM hooks for fine-grained
control, but I think we'll be able to make them restrictive-only.

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
> >
> > So, given that a) we can't make CAP_BPF namespace-aware and b) we
> > can't grant real CAP_BPF to processes in user namespace, how could we
> > allow user namespaced applications to do useful work with BPF?
> >
> >>> Lastly, you mentioned before:
> >>>
> >>>>>> I think we need to make this more concrete; we don't have a patter=
n in
> >>>>>> the upstream kernel where 'some_check(...)' is a LSM hook, right?
> >>> Unfortunately I don't have enough familiarity with all LSM hooks, so =
I
> >>> can't confirm or disprove the above statement. But earlier someone
> >>> brought to my attention the case of security_vm_enough_memory_mm(),
> >>> which seems to be granting effectively CAP_SYS_ADMIN for the purposes
> >>> of memory accounting. Am I missing something subtle there or does it
> >>> grant effective caps indeed?
> >> Some of the comments around that hook can be misleading, but if you
> >> look at the actual code it starts to make more sense.
> >>
> > [...]
> >
> >> I do agree that the security_vm_enough_memory() hook is structured a
> >> bit differently than most of the other LSM hooks, but it still
> >> operates with the same philosophy: a LSM should only be allowed to
> >> restrict access, a LSM should never be allowed to grant access that
> >> would otherwise be denied by the traditional Linux access controls.
> >>
> >> Hopefully that explanation makes sense, but if things are still a bit
> >> fuzzy I would encourage you to go look at the code, I'm sure it will
> >> make sense once you spend a few minutes figuring out how it works.
> >>
> > Yep, thanks a lot, it's way more clear after grokking relevant pieces
> > of LSM the code you pointed out and LSM infrastructure in general.
> > "capabilities" LSM is non-negotiable, so it effectively always
> > restricts a small subset of hooks, including vm_enough_memory and
> > capable.
> >
> > Still, the problem still stands. How do we marry BPF and user
> > namespaces? I'd really appreciate suggestions. Thank you!
> >
> >
> >> [1] There is a long and sorta bizarre history with the capability LSM,
> >> but just understand it is a bit "special" in many ways, and those
> >> "special" behaviors are intentional.
> >>
> >> --
> >> paul-moore.com
