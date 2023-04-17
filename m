Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43646E5532
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 01:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjDQXbm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 19:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQXbl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 19:31:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0974F49EA;
        Mon, 17 Apr 2023 16:31:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ud9so68356256ejc.7;
        Mon, 17 Apr 2023 16:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681774296; x=1684366296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDbbvVJOT3XG1VHtU2pOLj3E/PMtopHrtj4dy22dHCw=;
        b=YbSGrjzdlKeqDhxhUmq/7tLQlmDsAnrXFSWekb4fVpiWs1C+Q351yfd6HsSRymymMY
         0EfwneTmIDHD0FvcAYbfsw7Pk+kDrsc7YoI9IWJHpxr3Vsgbuw2Lv2hLMOcOCQ5Go0h0
         44EPWaPOS23yrsLGN9+Cy360r6eQ7NnVb7nzhVkUo4MNyqCerqfIfdkTYNy8jjFedMiL
         DWfHfXrBHUZsw/BOlLdq8HELAc6nosUFQcOxoC7ED+6+kOi9hpYXxt7siF8+fvsKau9G
         D2OfGCZEpbm2YY2m52xoUacqk3EmpgYFzjbky0KNGsRvil8DC0OR93+22cKCaJVCP4zy
         0X6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681774296; x=1684366296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDbbvVJOT3XG1VHtU2pOLj3E/PMtopHrtj4dy22dHCw=;
        b=QrvVtuMw5vTWnuuL+IMMcklgClHfD33OGzhV5jTF/2OXPvdBDO5o9bsbBqVFDrUldX
         xKP6FJR81dD2eLfQaie7Qb+CoO9kQGNq4Bs3B+snOwBxUfcLt0UY47LNYDlOm4W8UiHU
         g3Vqk30r+APR3FkAZXy3NlbdlUdCP9/DdkpB3p77TKuq9mQMGZYok6uQUwhBZjar88p/
         t4CZF9FYefucLV9/eeemSC/f2puJr65eQM0Pb4DMVUNZ2BO7AkwrP0RfvdvaNhIfkPQz
         tpjXhqJC3cKtm/MgDEJ9aN43Mq2TTnBBjNxfJXWS+Rnp4+6LmUL2s+C8bsVKwucx18Yy
         1Vqw==
X-Gm-Message-State: AAQBX9ck9aQVB5/70fZB2Bb+FkOChRcvMXI5fzDpZzG84YCSuPbeYU4n
        rKybbDg6DZQNzAHe1vXKD29CFbXPDte+2ZN4EJY=
X-Google-Smtp-Source: AKy350YFm4/4PlmFl7cC8dCHJyZcrnpLWO4+uvkXtu4O5JIOvfj4mwSHlIOM48A/fgbk4EKwLxhh8GNNfhUae2ue3dg=
X-Received: by 2002:a17:906:860e:b0:94f:646:76ec with SMTP id
 o14-20020a170906860e00b0094f064676ecmr4488012ejx.5.1681774296271; Mon, 17 Apr
 2023 16:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com> <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
 <6436f837.a70a0220.ada87.d446@mx.google.com> <CAHC9VhTF0JX3_zZ1ZRnoOw0ToYj6AsvK6OCiKqQgPvHepH9W3Q@mail.gmail.com>
 <CAEf4BzY9GPr9c2fTUS6ijHURtdNDL4xM6+JAEggEqLuz9sk4Dg@mail.gmail.com>
 <CAHC9VhT8RXG6zEwUdQZH4HE_HkF6B8XebWnUDc-k6AeH2NVe0w@mail.gmail.com>
 <CAEf4BzaRkAtyigmu9fybW0_+TZJJX2i93BXjiNUfazt2dFDFbQ@mail.gmail.com> <5eba6259-f214-becf-ac8f-0981d9fe7bda@schaufler-ca.com>
In-Reply-To: <5eba6259-f214-becf-ac8f-0981d9fe7bda@schaufler-ca.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 17 Apr 2023 16:31:24 -0700
Message-ID: <CAEf4BzZxGe=Da8hMHBAyTiSOUdPH+X1qFhA3q1kHW+=XiqX_XA@mail.gmail.com>
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

On Thu, Apr 13, 2023 at 9:54=E2=80=AFAM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 4/12/2023 10:16 PM, Andrii Nakryiko wrote:
> > On Wed, Apr 12, 2023 at 7:56=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >> On Wed, Apr 12, 2023 at 9:43=E2=80=AFPM Andrii Nakryiko
> >> <andrii.nakryiko@gmail.com> wrote:
> >>> On Wed, Apr 12, 2023 at 12:07=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> >>>> On Wed, Apr 12, 2023 at 2:28=E2=80=AFPM Kees Cook <keescook@chromium=
.org> wrote:
> >>>>> On Wed, Apr 12, 2023 at 02:06:23PM -0400, Paul Moore wrote:
> >>>>>> On Wed, Apr 12, 2023 at 1:47=E2=80=AFPM Kees Cook <keescook@chromi=
um.org> wrote:
> >>>>>>> On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
> >>>>>>>> On Wed, Apr 12, 2023 at 12:33=E2=80=AFAM Andrii Nakryiko <andrii=
@kernel.org> wrote:
> >> ...
> >>
> >>>>>>> For example, in many places we have things like:
> >>>>>>>
> >>>>>>>         if (!some_check(...) && !capable(...))
> >>>>>>>                 return -EPERM;
> >>>>>>>
> >>>>>>> I would expect this is a similar logic. An operation can succeed =
if the
> >>>>>>> access control requirement is met. The mismatch we have through-o=
ut the
> >>>>>>> kernel is that capability checks aren't strictly done by LSM hook=
s. And
> >>>>>>> this series conceptually, I think, doesn't violate that -- it's c=
hanging
> >>>>>>> the logic of the capability checks, not the LSM (i.e. there no LS=
M hooks
> >>>>>>> yet here).
> >>>>>> Patch 04/08 creates a new LSM hook, security_bpf_map_create(), whi=
ch
> >>>>>> when it returns a positive value "bypasses kernel checks".  The pa=
tch
> >>>>>> isn't based on either Linus' tree or the LSM tree, I'm guessing it=
 is
> >>>>>> based on a eBPF tree, so I can't say with 100% certainty that it i=
s
> >>>>>> bypassing a capability check, but the description claims that to b=
e
> >>>>>> the case.
> >>>>>>
> >>>>>> Regardless of how you want to spin this, I'm not supportive of a L=
SM
> >>>>>> hook which allows a LSM to bypass a capability check.  A LSM hook =
can
> >>>>>> be used to provide additional access control restrictions beyond a
> >>>>>> capability check, but a LSM hook should never be allowed to overru=
le
> >>>>>> an access denial due to a capability check.
> >>>>>>
> >>>>>>> The reason CAP_BPF was created was because there was nothing else=
 that
> >>>>>>> would be fine-grained enough at the time.
> >>>>>> The LSM layer predates CAP_BPF, and one could make a very solid
> >>>>>> argument that one of the reasons LSMs exist is to provide
> >>>>>> supplementary controls due to capability-based access controls bei=
ng a
> >>>>>> poor fit for many modern use cases.
> >>>>> I generally agree with what you say, but we DO have this code patte=
rn:
> >>>>>
> >>>>>          if (!some_check(...) && !capable(...))
> >>>>>                  return -EPERM;
> >>>> I think we need to make this more concrete; we don't have a pattern =
in
> >>>> the upstream kernel where 'some_check(...)' is a LSM hook, right?
> >>>> Simply because there is another kernel access control mechanism whic=
h
> >>>> allows a capability check to be skipped doesn't mean I want to allow=
 a
> >>>> LSM hook to be used to skip a capability check.
> >>> This work is an attempt to tighten the security of production systems
> >>> by allowing to drop too coarse-grained and permissive capabilities
> >>> (like CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, which inevitable allow mor=
e
> >>> than production use cases are meant to be able to do) and then grant
> >>> specific BPF operations on specific BPF programs/maps based on custom
> >>> LSM security policy, which validates application trustworthiness usin=
g
> >>> custom production-specific logic.
> >> There are ways to leverage the LSMs to apply finer grained access
> >> control on top of the relatively coarse capabilities that do not
> >> require circumventing those capability controls.  One grants the
> >> capabilities, just as one would do today, and then leverages the
> >> security functionality of a LSM to further restrict specific users,
> >> applications, etc. with a level of granularity beyond that offered by
> >> the capability controls.
> > Please help me understand something. What you and Casey are proposing,
> > when taken to the logical extreme, is to grant to all processes root
> > permissions and then use LSM to restrict specific actions, do I
> > understand correctly?
>
> No. You grant a process the capabilities it needs (CAP_BPF, CAP_WHATEVER)
> and only those capabilities. If you want additional restrictions you incl=
ude
> an LSM that implements those restrictions. If you want finer control over
> the operations controlled by CAP_BPF you include an LSM that implements
> those controls.
>

See previous replies. We can't grant CAP_BPF, even if we wanted to, if
the process is in a user namespace.

> >  This strikes me as a less secure and more
> > error-prone way of doing things. If there is some problem with
> > installing LSM policy,
>
> LSMs are not required to have loadable or dynamic policies. That's
> up to the developer.
>

Sure, but having a more dynamic policy is a very attractive feature
and one of the reasons for people to use BPF LSM. So it might not be
required, but it's something that people are using in practice, so if
we can make all this less error-prone, that would be better for
everyone.

> >  it could go unnoticed for a really long time,
> > while the system would be way more vulnerable.
>
> There is no way Paul or I are going to solve the mis-configured system
> problem.
>

Please see my example about (hypothetical) 21st added hook that is
very easy to miss, because the kernel is big and there are tons of
people doing development, and so it's no wonder that users might miss
a new hook they are supposed to restrict.

But again, even with all that said, granting CAP_BPF is impossible for
user namespaced applications.

> >  Why do you prefer such
> > an approach instead of going with no extra permissions by default, but
> > allowing custom LSM policy to grant few exceptions for known and
> > trusted use cases?
>
> Because that's not how capabilities work. Capabilities are independent
> of other controls. If you want to propose a change to how capabilities
> work, you need to propose that to the capability maintainer.
>
> Because that's not how LSMs work. LSMs implement additional restrictions
> to the existing policy. The restrictive vs. authoritative debate was clos=
ed
> long ago. It's a fundamental property of how LSMs work.

There doesn't seem to be anything fundamentally and technically
preventing LSM hooks to say "yep, looks good, no need to fallback to
CAP_BPF checks due to lack of other signal". [0] also outright said
that authoritative hooks can be the next step, but didn't reject it
outright.

  [0] https://lwn.net/2001/1108/a/no-auth-hooks.php3


>
> > By the way, even the above proposal of yours doesn't work for
> > production use cases when user namespaces are involved, as far as I
> > understand. We cannot grant CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN for
> > containers running inside user namespaces, as CAP_BPF in non-init
> > namespace is not enough for bpf() syscall to allow loading BPF maps or
> > BPF program (bpf() doesn't do ns_capable(), it's only using
> > capable()). What solution would you suggest for such production
> > setups?
>
> If user namespaces don't work the way you'd like, you should take that
> up with the namespace maintainers. Or, since this appears to be an issue
> with BPF not being namespace aware, fix BPF's use of capable() and ns_cap=
able().

Can't be fixed on the BPF side, unfortunately. Don't know enough about
namespaces to tell if it's a bug or feature that root CAP_BPF can't be
checked from inside userns. So yep, I should perhaps ask.

>
> > Also, in previous email you said:
> >
> >> Simply because there is another kernel access control mechanism which
> >> allows a capability check to be skipped doesn't mean I want to allow a
> >> LSM hook to be used to skip a capability check.
> > I understand your stated position, but can you please help me
> > understand the reasoning behind it? What would be wrong with some LSM
> > hooks granting effective capabilities?
>
> You keep asking the question and ignoring the answer. See above.
>
> >  How would that change anything
> > about LSM design? As far as I can see, I'm not doing anything crazy
> > with my LSM hook implementation.
>
> You keep asking the question and ignoring the answer. See above.
>
>
> >  It's reusing the standard
> > call_int_hook() mechanism very straightforwardly with a default result
> > of 0. And then just interprets 0, <0, and >0 results accordingly. Is
> > that abusing the LSM mechanism itself somehow?
> >
> > Does the above also mean that you'd be fine if we just don't plug into
> > the LSM subsystem at all and instead come up with some ad-hoc solution
> > to allow effectively the same policies?
>
> No, because you would be breaking the capability system in that case.
>
> There is an example of a feature that does just what you're suggesting.
> POSIX ACLs aren't an LSM because they don't just add restrictions, they
> change the semantics of the file mode bits. Look at that implementation
> before you seriously consider going that route.

Are you referring to posix_acl_permission() and fs/posix_acl.c? I'll
take a look, not familiar. Thanks for the suggestion!

I'd still prefer to avoid building a new access control system just
for BPF, of course. But let me take a look at the code and see what
you are referring to.

>
> >  This sounds detrimental both
> > to LSM and BPF subsystems, so I hope we can talk this through before
> > finalizing decisions.
> >
> > Lastly, you mentioned before:
> >
> >>>> I think we need to make this more concrete; we don't have a pattern =
in
> >>>> the upstream kernel where 'some_check(...)' is a LSM hook, right?
> > Unfortunately I don't have enough familiarity with all LSM hooks, so I
> > can't confirm or disprove the above statement. But earlier someone
> > brought to my attention the case of security_vm_enough_memory_mm(),
> > which seems to be granting effectively CAP_SYS_ADMIN for the purposes
> > of memory accounting. Am I missing something subtle there or does it
> > grant effective caps indeed?
> >
> >
> >
> >
> >> --
> >> paul-moore.com
