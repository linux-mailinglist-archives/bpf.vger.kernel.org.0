Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842F86E10B0
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 17:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjDMPMA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 11:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjDMPL7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 11:11:59 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF95AF29
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 08:11:42 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id y16so634123ybb.2
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 08:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681398701; x=1683990701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfnvIvr58VX0S2k2YZ2WDLYoPBSUQXcjimV8CYYLANg=;
        b=KNwXJj6cr2penqQ8cCWynNR0EdzxheKrM1eRiM0bO+hW6xyl99BgSnUzysQFb6Mcu0
         3V29WGcuw/srbGIRIv6+c0IYp08DIksxu1FKpoubGz3zIhrqjsTjgiNpenuRItBM88bp
         2/wtzI0LvqrrvJhXfuB13Yvt30EHYTa0vbKHcu8f2v5vBiqZKiC74ARxA9JecU3nNE78
         TnPfAECwmeKp5mffHCK1SXTAQu+rbVd4ouE0gYE7Adxz7RWbU8LvvBONEv+KTftf5jY2
         zGqwKggPtEQA2qICUAdFqZ7cYKA+3qbT5kwTzVjKJvNNdG+pAouayA2I/6t059LyBrVo
         tgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681398701; x=1683990701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfnvIvr58VX0S2k2YZ2WDLYoPBSUQXcjimV8CYYLANg=;
        b=ZahK5hWI4YmCcrY1f+eB4J5uWa8A3Nb/0kQ5CK/6/wvQLVP7HRpYjyAlAenLEePzvb
         SoaUboHU0U3aKApQjVb09TSJLD2mWLFjtG97LNLu8TkMZiKLB4bIbUftg9mWY/OZ+XEM
         GsabkzzVwu/0D7YNANLCG/79GkiTqptbuXZVduoOPWv0qgtFAcm2g4y0iJM1tUFTB385
         y40mJ24kOfIaDV9kNd4eiMtvX9NLQw1M6SQBu+TgZBOfe4t3JHgoeikaZ2CZJgY0GHtM
         SM4yDjLeRvRcBk+mNjbV+nHvxzgefRkMJ+z1eIlG7HTgldk/WQXkcC0gDb60WmzncVkn
         RZIA==
X-Gm-Message-State: AAQBX9eNUtkfXCQawoQikBB3es5oahPf4w7+YhdwYj62bZqC9LrI2AJJ
        aqbYx6x6OKXeGe7/6N6mRFtFy5Q/GzPDSv9YH6fd
X-Google-Smtp-Source: AKy350aMRCPwWBk7EsrH/k3KYo5MKykamxxCYLtDctw/BqJUIUOC/KpU/ZDjjMFrOFfzPitLJpDSrxAAgj1QH41uPtc=
X-Received: by 2002:a25:d7d3:0:b0:b68:7a4a:5258 with SMTP id
 o202-20020a25d7d3000000b00b687a4a5258mr1678857ybg.3.1681398701495; Thu, 13
 Apr 2023 08:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com> <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
 <6436f837.a70a0220.ada87.d446@mx.google.com> <CAHC9VhTF0JX3_zZ1ZRnoOw0ToYj6AsvK6OCiKqQgPvHepH9W3Q@mail.gmail.com>
 <CAEf4BzY9GPr9c2fTUS6ijHURtdNDL4xM6+JAEggEqLuz9sk4Dg@mail.gmail.com>
 <CAHC9VhT8RXG6zEwUdQZH4HE_HkF6B8XebWnUDc-k6AeH2NVe0w@mail.gmail.com> <CAEf4BzaRkAtyigmu9fybW0_+TZJJX2i93BXjiNUfazt2dFDFbQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaRkAtyigmu9fybW0_+TZJJX2i93BXjiNUfazt2dFDFbQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Apr 2023 11:11:30 -0400
Message-ID: <CAHC9VhQFJafyW5r9YzG47NjrBcKURj3D0V-u7eN2eb5tBM2pkg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 13, 2023 at 1:16=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Wed, Apr 12, 2023 at 7:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Wed, Apr 12, 2023 at 9:43=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Wed, Apr 12, 2023 at 12:07=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > > On Wed, Apr 12, 2023 at 2:28=E2=80=AFPM Kees Cook <keescook@chromiu=
m.org> wrote:
> > > > > On Wed, Apr 12, 2023 at 02:06:23PM -0400, Paul Moore wrote:
> > > > > > On Wed, Apr 12, 2023 at 1:47=E2=80=AFPM Kees Cook <keescook@chr=
omium.org> wrote:
> > > > > > > On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
> > > > > > > > On Wed, Apr 12, 2023 at 12:33=E2=80=AFAM Andrii Nakryiko <a=
ndrii@kernel.org> wrote:
> >
> > ...
> >
> > > > > > > For example, in many places we have things like:
> > > > > > >
> > > > > > >         if (!some_check(...) && !capable(...))
> > > > > > >                 return -EPERM;
> > > > > > >
> > > > > > > I would expect this is a similar logic. An operation can succ=
eed if the
> > > > > > > access control requirement is met. The mismatch we have throu=
gh-out the
> > > > > > > kernel is that capability checks aren't strictly done by LSM =
hooks. And
> > > > > > > this series conceptually, I think, doesn't violate that -- it=
's changing
> > > > > > > the logic of the capability checks, not the LSM (i.e. there n=
o LSM hooks
> > > > > > > yet here).
> > > > > >
> > > > > > Patch 04/08 creates a new LSM hook, security_bpf_map_create(), =
which
> > > > > > when it returns a positive value "bypasses kernel checks".  The=
 patch
> > > > > > isn't based on either Linus' tree or the LSM tree, I'm guessing=
 it is
> > > > > > based on a eBPF tree, so I can't say with 100% certainty that i=
t is
> > > > > > bypassing a capability check, but the description claims that t=
o be
> > > > > > the case.
> > > > > >
> > > > > > Regardless of how you want to spin this, I'm not supportive of =
a LSM
> > > > > > hook which allows a LSM to bypass a capability check.  A LSM ho=
ok can
> > > > > > be used to provide additional access control restrictions beyon=
d a
> > > > > > capability check, but a LSM hook should never be allowed to ove=
rrule
> > > > > > an access denial due to a capability check.
> > > > > >
> > > > > > > The reason CAP_BPF was created was because there was nothing =
else that
> > > > > > > would be fine-grained enough at the time.
> > > > > >
> > > > > > The LSM layer predates CAP_BPF, and one could make a very solid
> > > > > > argument that one of the reasons LSMs exist is to provide
> > > > > > supplementary controls due to capability-based access controls =
being a
> > > > > > poor fit for many modern use cases.
> > > > >
> > > > > I generally agree with what you say, but we DO have this code pat=
tern:
> > > > >
> > > > >          if (!some_check(...) && !capable(...))
> > > > >                  return -EPERM;
> > > >
> > > > I think we need to make this more concrete; we don't have a pattern=
 in
> > > > the upstream kernel where 'some_check(...)' is a LSM hook, right?
> > > > Simply because there is another kernel access control mechanism whi=
ch
> > > > allows a capability check to be skipped doesn't mean I want to allo=
w a
> > > > LSM hook to be used to skip a capability check.
> > >
> > > This work is an attempt to tighten the security of production systems
> > > by allowing to drop too coarse-grained and permissive capabilities
> > > (like CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, which inevitable allow mor=
e
> > > than production use cases are meant to be able to do) and then grant
> > > specific BPF operations on specific BPF programs/maps based on custom
> > > LSM security policy, which validates application trustworthiness usin=
g
> > > custom production-specific logic.
> >
> > There are ways to leverage the LSMs to apply finer grained access
> > control on top of the relatively coarse capabilities that do not
> > require circumventing those capability controls.  One grants the
> > capabilities, just as one would do today, and then leverages the
> > security functionality of a LSM to further restrict specific users,
> > applications, etc. with a level of granularity beyond that offered by
> > the capability controls.
>
> Please help me understand something. What you and Casey are proposing,
> when taken to the logical extreme, is to grant to all processes root
> permissions and then use LSM to restrict specific actions, do I
> understand correctly? This strikes me as a less secure and more
> error-prone way of doing things.

When taken to the "logical extreme" most concepts end up sounding a
bit absurd, but that was the point, wasn't it?

Here is a fun story which seems relevant ... in the early days of
SELinux, one of the community devs setup up a system with a SELinux
policy which restricted all privileged operations from the root user,
put the system on a publicly accessible network, posted the root
password for all to see, and invited the public to login to the system
and attempt to exercise root privilege (it's been well over 10 years
at this point so the details are a bit fuzzy).  Granted, there were
some hiccups in the beginning, mostly due to the crude state of policy
development/analysis at the time, but after a few policy revisions the
system held up quite well.

On the more practical side of things, there are several use cases
which require, by way of legal or contractual requirements, that full
root/admin privileges are decomposed into separate roles: security
admin, audit admin, backup admin, etc.  These users satisfy these
requirements by using LSMs, such as SELinux, to restrict the
administrative capabilities based on the SELinux user/role/domain.

> By the way, even the above proposal of yours doesn't work for
> production use cases when user namespaces are involved, as far as I
> understand. We cannot grant CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN for
> containers running inside user namespaces, as CAP_BPF in non-init
> namespace is not enough for bpf() syscall to allow loading BPF maps or
> BPF program ...

Once again, the LSM has always intended to be a restrictive mechanism,
not a privilege granting mechanism.  If an operation is not possible
without the LSM layer enabled, it should not be possible with the LSM
layer enabled.  The LSM is not a mechanism to circumvent other access
control mechanisms in the kernel.

> Also, in previous email you said:
>
> > Simply because there is another kernel access control mechanism which
> > allows a capability check to be skipped doesn't mean I want to allow a
> > LSM hook to be used to skip a capability check.
>
> I understand your stated position, but can you please help me
> understand the reasoning behind it?

Keeping the LSM as a restrictive access control mechanism helps ensure
some level of sanity and consistency across different Linux
installations.  If a certain operation requires CAP_SYS_ADMIN on one
Linux system, it should require CAP_SYS_ADMIN on another Linux system.
Granted, a LSM running on one system might impose additional
constraints on that operation, but the CAP_SYS_ADMIN requirement still
applies.

There is also an issue of safety in knowing that enabling a LSM will
not degrade the access controls on a system by potentially granting
operations that were previously denied.

> Does the above also mean that you'd be fine if we just don't plug into
> the LSM subsystem at all and instead come up with some ad-hoc solution
> to allow effectively the same policies? This sounds detrimental both
> to LSM and BPF subsystems, so I hope we can talk this through before
> finalizing decisions.

Based on your patches and our discussion, it seems to me that the
problem you are trying to resolve is related more to the
capability-based access controls in the eBPF, and possibly other
kernel subsystems, and not any LSM-based restrictions.  I'm happy to
work with you on a solution involving the LSM, but please understand
that I'm not going to support a solution which changes a core
philosophy of the LSM layer.

> Lastly, you mentioned before:
>
> > > > I think we need to make this more concrete; we don't have a pattern=
 in
> > > > the upstream kernel where 'some_check(...)' is a LSM hook, right?
>
> Unfortunately I don't have enough familiarity with all LSM hooks, so I
> can't confirm or disprove the above statement. But earlier someone
> brought to my attention the case of security_vm_enough_memory_mm(),
> which seems to be granting effectively CAP_SYS_ADMIN for the purposes
> of memory accounting. Am I missing something subtle there or does it
> grant effective caps indeed?

Some of the comments around that hook can be misleading, but if you
look at the actual code it starts to make more sense.

First, look at the LSM-disabled case and you'll see that the
security_vm_enough_memory_mm() hook ends up looking like this:

int security_vm_enough_memory_mm(...)
{
  return __vm_enough_memory(mm, pages, cap_vm_enough_memory(mm, pages));
}

... which basically calls into the core capability code to check for
CAP_SYS_ADMIN, passing the result onto __vm_enough_memory.

If we then look at the LSM-enabled case, things are a little more
complicated, but it looks something like this:

int security_vm_enough_memory_mm(...)
{
  int cap_admin =3D 1;

  for_each_lsm_hook(...) {
    rc =3D lsm_hook(...);
    if (rc <=3D 0) {
      cap_admin =3D 0;
      break;
    }
  }

  return __vm_enough_memory(mm, pages, cap_admin);
}

... which as the comment says, "If all of the modules agree that it
should be set it will. If any module thinks it should not be set it
won't.".  However, if we look at which LSMs define vm_enough_memory()
hooks we see just two: the capability LSM, and SELinux.  The
capability LSM[1] just uses cap_vm_enough_memory() so that's
straightforward, and the SELinux hook is selinux_vm_enough_memory(),
which simply checks the loaded SELinux policy to see if the current
task has permission to exercise the CAP_SYS_ADMIN capability.  SELinux
can't grant CAP_SYS_ADMIN beyond what the capability code permits, it
only restricts its use.  Put another way, if the capability code does
not allow CAP_SYS_ADMIN in a call to security_vm_enough_memory() then
CAP_SYS_ADMIN will not be granted regardless of what the other LSMs
may decide.

I do agree that the security_vm_enough_memory() hook is structured a
bit differently than most of the other LSM hooks, but it still
operates with the same philosophy: a LSM should only be allowed to
restrict access, a LSM should never be allowed to grant access that
would otherwise be denied by the traditional Linux access controls.

Hopefully that explanation makes sense, but if things are still a bit
fuzzy I would encourage you to go look at the code, I'm sure it will
make sense once you spend a few minutes figuring out how it works.

[1] There is a long and sorta bizarre history with the capability LSM,
but just understand it is a bit "special" in many ways, and those
"special" behaviors are intentional.

--
paul-moore.com
