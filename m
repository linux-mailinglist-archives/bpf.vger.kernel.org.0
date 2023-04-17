Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93ABB6E5529
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 01:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDQX3R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 19:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQX3Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 19:29:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6CB44B2;
        Mon, 17 Apr 2023 16:29:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id c9so29702142ejz.1;
        Mon, 17 Apr 2023 16:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681774152; x=1684366152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJ9Pr+y1x30fyB/Knv/E0vYaM2LLsOB9csqxg1gYQFU=;
        b=fsdWF9gSLklh2Yy5KhADxqdNRRiLpRpTDCHJDQx3hklawMiA/iYpzZ6lNEjF6g44VC
         sPdPivSXfI1FmKu5aDxAzUjjOnpJfdtuD838GiBasKd0C4XYDuNMvqPaDcubKxjXaGTb
         oHKHxeeofXQ3pYnlIY2q+aWmUcDGplKi0JMvxOyeMHjA+XpD/hYPYaW9emE69cg2uQu9
         H7f/MyJAJMiAY53KzAbWOA4sRmKUmSs8SDhmQ6wzXVluIfaSPERLDGjyBKbE3VeL+wrj
         EJg5ZYFOzTknK4dNZl/r8m8fsemJRrEfO7rJvybdljLWh7Umk5456RgbF/xwWB85kBVA
         L44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681774152; x=1684366152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJ9Pr+y1x30fyB/Knv/E0vYaM2LLsOB9csqxg1gYQFU=;
        b=MFD8T0dRnmGGdwqu57vX6bMCkeD9NGeoB7u0jVb+0nmyZAAB7+Y2Py4w/l44HLCGQP
         lBV4yoBivIHCb+slNs3lKIBl4pL0zhDemMi5cVW1n47B1pPjRLIrUiy/eNNr2zHvciqV
         cb/Ul1jh2oxgOk4CDf7T7Yr6PPnxCvWK9OJgaiFW9vYqRnBVofFM8NiQPuj9h80KcGZu
         Om56opIer5vwwDykuAy7WDuq+jKySrvQ7SwjOBGJSmwPuigOBkq5Vg4gk5nzndSMwA6G
         7Sl1BCq05AhuTapVYt5NlLaTNwMgBOEi/BWBvRT/xKA+2inOnou3Feg0j5MikntOwyxp
         eMbw==
X-Gm-Message-State: AAQBX9cVFy4Bgtw2JNvIAHGJsOgzi+hFkkgM+bA3W/UK/RC7oWOW4kJf
        52l/lRIiww20vfzDUpyi17VoE9Q53/36NHSUfKE=
X-Google-Smtp-Source: AKy350btgMgDTyKNUmJaph8NEVzMhpdDsXBpGYUyRQZ1+5oQbEamOapwvgHhcUZaLB69Wvl/UmJmfvxSihGabynfHsc=
X-Received: by 2002:a17:906:860e:b0:94f:646:76ec with SMTP id
 o14-20020a170906860e00b0094f064676ecmr4485581ejx.5.1681774152274; Mon, 17 Apr
 2023 16:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com> <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
 <6436f837.a70a0220.ada87.d446@mx.google.com> <CAHC9VhTF0JX3_zZ1ZRnoOw0ToYj6AsvK6OCiKqQgPvHepH9W3Q@mail.gmail.com>
 <CAEf4BzY9GPr9c2fTUS6ijHURtdNDL4xM6+JAEggEqLuz9sk4Dg@mail.gmail.com>
 <CAHC9VhT8RXG6zEwUdQZH4HE_HkF6B8XebWnUDc-k6AeH2NVe0w@mail.gmail.com>
 <CAEf4BzaRkAtyigmu9fybW0_+TZJJX2i93BXjiNUfazt2dFDFbQ@mail.gmail.com> <CAHC9VhQFJafyW5r9YzG47NjrBcKURj3D0V-u7eN2eb5tBM2pkg@mail.gmail.com>
In-Reply-To: <CAHC9VhQFJafyW5r9YzG47NjrBcKURj3D0V-u7eN2eb5tBM2pkg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 17 Apr 2023 16:29:00 -0700
Message-ID: <CAEf4BzZa26JHa=gBgMm-sqyNy_S71-2Rs_-F6mrRXQF9z9KcmA@mail.gmail.com>
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

On Thu, Apr 13, 2023 at 8:11=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Apr 13, 2023 at 1:16=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Wed, Apr 12, 2023 at 7:56=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Wed, Apr 12, 2023 at 9:43=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > > On Wed, Apr 12, 2023 at 12:07=E2=80=AFPM Paul Moore <paul@paul-moor=
e.com> wrote:
> > > > > On Wed, Apr 12, 2023 at 2:28=E2=80=AFPM Kees Cook <keescook@chrom=
ium.org> wrote:
> > > > > > On Wed, Apr 12, 2023 at 02:06:23PM -0400, Paul Moore wrote:
> > > > > > > On Wed, Apr 12, 2023 at 1:47=E2=80=AFPM Kees Cook <keescook@c=
hromium.org> wrote:
> > > > > > > > On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
> > > > > > > > > On Wed, Apr 12, 2023 at 12:33=E2=80=AFAM Andrii Nakryiko =
<andrii@kernel.org> wrote:
> > >
> > > ...
> > >
> > > > > > > > For example, in many places we have things like:
> > > > > > > >
> > > > > > > >         if (!some_check(...) && !capable(...))
> > > > > > > >                 return -EPERM;
> > > > > > > >
> > > > > > > > I would expect this is a similar logic. An operation can su=
cceed if the
> > > > > > > > access control requirement is met. The mismatch we have thr=
ough-out the
> > > > > > > > kernel is that capability checks aren't strictly done by LS=
M hooks. And
> > > > > > > > this series conceptually, I think, doesn't violate that -- =
it's changing
> > > > > > > > the logic of the capability checks, not the LSM (i.e. there=
 no LSM hooks
> > > > > > > > yet here).
> > > > > > >
> > > > > > > Patch 04/08 creates a new LSM hook, security_bpf_map_create()=
, which
> > > > > > > when it returns a positive value "bypasses kernel checks".  T=
he patch
> > > > > > > isn't based on either Linus' tree or the LSM tree, I'm guessi=
ng it is
> > > > > > > based on a eBPF tree, so I can't say with 100% certainty that=
 it is
> > > > > > > bypassing a capability check, but the description claims that=
 to be
> > > > > > > the case.
> > > > > > >
> > > > > > > Regardless of how you want to spin this, I'm not supportive o=
f a LSM
> > > > > > > hook which allows a LSM to bypass a capability check.  A LSM =
hook can
> > > > > > > be used to provide additional access control restrictions bey=
ond a
> > > > > > > capability check, but a LSM hook should never be allowed to o=
verrule
> > > > > > > an access denial due to a capability check.
> > > > > > >
> > > > > > > > The reason CAP_BPF was created was because there was nothin=
g else that
> > > > > > > > would be fine-grained enough at the time.
> > > > > > >
> > > > > > > The LSM layer predates CAP_BPF, and one could make a very sol=
id
> > > > > > > argument that one of the reasons LSMs exist is to provide
> > > > > > > supplementary controls due to capability-based access control=
s being a
> > > > > > > poor fit for many modern use cases.
> > > > > >
> > > > > > I generally agree with what you say, but we DO have this code p=
attern:
> > > > > >
> > > > > >          if (!some_check(...) && !capable(...))
> > > > > >                  return -EPERM;
> > > > >
> > > > > I think we need to make this more concrete; we don't have a patte=
rn in
> > > > > the upstream kernel where 'some_check(...)' is a LSM hook, right?
> > > > > Simply because there is another kernel access control mechanism w=
hich
> > > > > allows a capability check to be skipped doesn't mean I want to al=
low a
> > > > > LSM hook to be used to skip a capability check.
> > > >
> > > > This work is an attempt to tighten the security of production syste=
ms
> > > > by allowing to drop too coarse-grained and permissive capabilities
> > > > (like CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, which inevitable allow m=
ore
> > > > than production use cases are meant to be able to do) and then gran=
t
> > > > specific BPF operations on specific BPF programs/maps based on cust=
om
> > > > LSM security policy, which validates application trustworthiness us=
ing
> > > > custom production-specific logic.
> > >
> > > There are ways to leverage the LSMs to apply finer grained access
> > > control on top of the relatively coarse capabilities that do not
> > > require circumventing those capability controls.  One grants the
> > > capabilities, just as one would do today, and then leverages the
> > > security functionality of a LSM to further restrict specific users,
> > > applications, etc. with a level of granularity beyond that offered by
> > > the capability controls.
> >
> > Please help me understand something. What you and Casey are proposing,
> > when taken to the logical extreme, is to grant to all processes root
> > permissions and then use LSM to restrict specific actions, do I
> > understand correctly? This strikes me as a less secure and more
> > error-prone way of doing things.
>
> When taken to the "logical extreme" most concepts end up sounding a
> bit absurd, but that was the point, wasn't it?

Wasn't my intent to make it sound absurd, sorry. The way I see it, for
the sake of example, let's say CAP_BPF allows 20 different operations
(each with its own security_xxx hook). And let's say in production I
want to only allow 3 of them. Sure, technically it should be possible
to deny access at 17 hooks and let it through in just those 3. But if
someone adds 21st and I forget to add 21st restriction, that would be
bad (but very probably with such approach).

So my point is that for situations like this, dropping CAP_BPF, but
allowing only 3 hooks to proceed seems a safer approach, because if we
add 21st hook, it will safely be denied without CAP_BPF *by default*.
That's what I tried to point out.

But even if we ignore this "safe by default when a new hook is added"
behavior, when taking user namespaces into account, the restrictive
LSM approach just doesn't seem to work at all for something like
CAP_BPF. CAP_BPF cannot be "namespaced", just like, say, CAP_SYS_TIME,
because we cannot ensure that a given BPF program won't access kernel
state "belonging" to another process (as one example).

Now, thanks to Jonathan, I get that there was a heated discussion 20
years ago about authoritative vs restrictive LSMs. But if I read a
summary at that time ([0]), authoritative hooks were not out of the
question *in principle*. Surely, "walk before we can run" makes sense,
but it's been a while ago.

  [0] https://lwn.net/2001/1108/a/no-auth-hooks.php3


>
> Here is a fun story which seems relevant ... in the early days of
> SELinux, one of the community devs setup up a system with a SELinux
> policy which restricted all privileged operations from the root user,
> put the system on a publicly accessible network, posted the root
> password for all to see, and invited the public to login to the system
> and attempt to exercise root privilege (it's been well over 10 years
> at this point so the details are a bit fuzzy).  Granted, there were
> some hiccups in the beginning, mostly due to the crude state of policy
> development/analysis at the time, but after a few policy revisions the
> system held up quite well.

Honest question out of curiosity: was the intent to demonstrate that
with LSM one can completely restrict root? Or that root was actually
allowed to do something useful? Because I can see how rejecting
everything would be rather simple, but actually pretty useless in
practice. Restricting only part of the power of the root, while still
allowing it to do something useful in production seems like a much
harder (but way more valuable) endeavor. Not saying it's impossible,
but see my example about missing 21st new CAP_BPF functionality.

>
> On the more practical side of things, there are several use cases
> which require, by way of legal or contractual requirements, that full
> root/admin privileges are decomposed into separate roles: security
> admin, audit admin, backup admin, etc.  These users satisfy these
> requirements by using LSMs, such as SELinux, to restrict the
> administrative capabilities based on the SELinux user/role/domain.
>
> > By the way, even the above proposal of yours doesn't work for
> > production use cases when user namespaces are involved, as far as I
> > understand. We cannot grant CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN for
> > containers running inside user namespaces, as CAP_BPF in non-init
> > namespace is not enough for bpf() syscall to allow loading BPF maps or
> > BPF program ...
>
> Once again, the LSM has always intended to be a restrictive mechanism,
> not a privilege granting mechanism.  If an operation is not possible

Not according to [0] above:

  > It is our belief that these changes do not belong in the initial versio=
n of
  > LSM (especially given our limited charter and original goals), and shou=
ld
  > be proposed as incremental refinements after LSM has been initially
  > accepted.
  > ...
  > It is our belief that the current LSM
  > will provide a meaningful improvement in the security infrastructure of=
 the
  > Linux kernel, and that there is plenty of room for future expansion of =
LSM
  > in subsequent phases.

I don't see "always intended to be a restrictive mechanism" there.

> without the LSM layer enabled, it should not be possible with the LSM
> layer enabled.  The LSM is not a mechanism to circumvent other access
> control mechanisms in the kernel.

I understand, but it's not like we are proposing to go and bypass all
kinds of random kernel security mechanisms. These are targeted hooks,
developed by the BPF community for the BPF subsystem to allow trusted
unprivileged production use cases. Yes, we currently rely on checking
CAP_BPF to grant more dangerous/advanced features, but it's because we
can't just allow any unprivileged process to do this. But what we
really want is to answer the question "can we trust this process to
use this advanced functionality", and if there is no specific LSM
policy that cares one way (allow) or the other (disallow), fallback to
CAP_BPF enforcement.

So it's not bypassing kernel checks, but rather augmenting them with
more flexible and customizable mechanisms, while still falling back to
CAP_BPF if the user didn't install any custom LSM policy.

>
> > Also, in previous email you said:
> >
> > > Simply because there is another kernel access control mechanism which
> > > allows a capability check to be skipped doesn't mean I want to allow =
a
> > > LSM hook to be used to skip a capability check.
> >
> > I understand your stated position, but can you please help me
> > understand the reasoning behind it?
>
> Keeping the LSM as a restrictive access control mechanism helps ensure
> some level of sanity and consistency across different Linux
> installations.  If a certain operation requires CAP_SYS_ADMIN on one
> Linux system, it should require CAP_SYS_ADMIN on another Linux system.
> Granted, a LSM running on one system might impose additional
> constraints on that operation, but the CAP_SYS_ADMIN requirement still
> applies.
>
> There is also an issue of safety in knowing that enabling a LSM will
> not degrade the access controls on a system by potentially granting
> operations that were previously denied.
>
> > Does the above also mean that you'd be fine if we just don't plug into
> > the LSM subsystem at all and instead come up with some ad-hoc solution
> > to allow effectively the same policies? This sounds detrimental both
> > to LSM and BPF subsystems, so I hope we can talk this through before
> > finalizing decisions.
>
> Based on your patches and our discussion, it seems to me that the
> problem you are trying to resolve is related more to the
> capability-based access controls in the eBPF, and possibly other
> kernel subsystems, and not any LSM-based restrictions.  I'm happy to
> work with you on a solution involving the LSM, but please understand
> that I'm not going to support a solution which changes a core
> philosophy of the LSM layer.

Great, I'd really appreciate help and suggestions on how to solve the
following problem.

We have a BPF subsystem that allows loading BPF programs. Those BPF
programs cannot be contained within a particular namespace just by its
system-wide tracing nature (it can safely read kernel and user memory
and we can't restrict whether that memory belongs to a particular
namespace), so it's like CAP_SYS_TIME, just with much broader API
surface.

The other piece of a puzzle is user namespaces. We do want to run
applications inside user namespaces, but allow them to use BPF
programs. As far as I can tell, there is no way to grant real CAP_BPF
that will be recognized by capable(CAP_BPF) (not ns_capable, see above
about system-wide nature of BPF). If there is, please help me
understand how. All my local experiments failed, and looking at
cap_capable() implementation it is not intended to even check the
initial namespace's capability if the process is running in the user
namespace.


So, given that a) we can't make CAP_BPF namespace-aware and b) we
can't grant real CAP_BPF to processes in user namespace, how could we
allow user namespaced applications to do useful work with BPF?

>
> > Lastly, you mentioned before:
> >
> > > > > I think we need to make this more concrete; we don't have a patte=
rn in
> > > > > the upstream kernel where 'some_check(...)' is a LSM hook, right?
> >
> > Unfortunately I don't have enough familiarity with all LSM hooks, so I
> > can't confirm or disprove the above statement. But earlier someone
> > brought to my attention the case of security_vm_enough_memory_mm(),
> > which seems to be granting effectively CAP_SYS_ADMIN for the purposes
> > of memory accounting. Am I missing something subtle there or does it
> > grant effective caps indeed?
>
> Some of the comments around that hook can be misleading, but if you
> look at the actual code it starts to make more sense.
>

[...]

>
> I do agree that the security_vm_enough_memory() hook is structured a
> bit differently than most of the other LSM hooks, but it still
> operates with the same philosophy: a LSM should only be allowed to
> restrict access, a LSM should never be allowed to grant access that
> would otherwise be denied by the traditional Linux access controls.
>
> Hopefully that explanation makes sense, but if things are still a bit
> fuzzy I would encourage you to go look at the code, I'm sure it will
> make sense once you spend a few minutes figuring out how it works.
>

Yep, thanks a lot, it's way more clear after grokking relevant pieces
of LSM the code you pointed out and LSM infrastructure in general.
"capabilities" LSM is non-negotiable, so it effectively always
restricts a small subset of hooks, including vm_enough_memory and
capable.

Still, the problem still stands. How do we marry BPF and user
namespaces? I'd really appreciate suggestions. Thank you!


> [1] There is a long and sorta bizarre history with the capability LSM,
> but just understand it is a bit "special" in many ways, and those
> "special" behaviors are intentional.
>
> --
> paul-moore.com
