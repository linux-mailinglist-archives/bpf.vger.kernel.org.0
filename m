Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A662A6E0667
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 07:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjDMFTH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 01:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjDMFSl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 01:18:41 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C37A27A;
        Wed, 12 Apr 2023 22:16:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id z9so7363953ejx.11;
        Wed, 12 Apr 2023 22:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681362994; x=1683954994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbWdWvaSNh5X4uca4r9X91EjVBEPIYbiZdiOvdhbY80=;
        b=RNcH7mgjtNTCNtun22/6lJT6qa7ik83C5VoaYzKFC/JbT7FduTo0z/ofUEm5Wb/Qng
         1xvn272skAKKoS4krVJVnQYhKAtAzQz0l+jHkkcjYA6F/kh8QT82PNMt0faxUE/K5uAL
         uJzx+CaSQpxudnFwmz3SQbZRpbeKUtTjMHqbd1n9s7+hv8GOmroiBlDy8jZ4EKMx2Yex
         xV1LAdfDybYsPlQB2bZz6pcuequ1GC8wIewcUnFMfQE5HWhPD8Q7fPtbh8cPGyWTbi+e
         uEcl6famesIxAw8903v/f8q6Z3RukTUogWj15cNpb4sywKQKWAvrhu9AgVieR5cR/8Mn
         qgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681362994; x=1683954994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbWdWvaSNh5X4uca4r9X91EjVBEPIYbiZdiOvdhbY80=;
        b=f1ZHu4lxTCqzCVtmUnl9H2AxIr5Tfaxzq0yNeZVXH/ywULjyhP5V3OQMMgWMjlYwnw
         BTG0wTfLu0I3oVj86qwVN8od5xwqbZ+x1T937eBBjIfGzOrX70+vcStNezZZvhkGy4np
         Q5Oz8/6njm/w7qAtF1xUTXwNnoeDQ/HYtrHQ9mnqV563yKWMNxr3K2cwwDPMAo495fUl
         8Hjpi8lLAWDZ70digC0FUTrc0bmSlD9XgLtfYxxgnTA2zIE7ytGV1TG1RrxqB8WEK70T
         9ZSwBfjKQyWarHjyfHeOiLqyUBAqS0twNuK2CcM6KYtC6s4dzbul3aqNM0Nsg8l7rjdg
         6mpA==
X-Gm-Message-State: AAQBX9dU19do9Ed4T18rf32dFUMXUIAPdSp+uxCwvRVyFNYJuFSaxAEi
        1VBSTKi4qHhlRjK1n2FFbysk9AssVg7WDBBC450=
X-Google-Smtp-Source: AKy350Y2U9JRo4xEhv7EPNqvVOZVKEPXHW5/4O1QJ9WjNwKLMGrsCvgv0H/JKn5BGyobL36wqocttdPNjID0XGGvpio=
X-Received: by 2002:a17:906:8403:b0:931:fb3c:f88d with SMTP id
 n3-20020a170906840300b00931fb3cf88dmr662507ejx.5.1681362994170; Wed, 12 Apr
 2023 22:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com> <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
 <6436f837.a70a0220.ada87.d446@mx.google.com> <CAHC9VhTF0JX3_zZ1ZRnoOw0ToYj6AsvK6OCiKqQgPvHepH9W3Q@mail.gmail.com>
 <CAEf4BzY9GPr9c2fTUS6ijHURtdNDL4xM6+JAEggEqLuz9sk4Dg@mail.gmail.com> <CAHC9VhT8RXG6zEwUdQZH4HE_HkF6B8XebWnUDc-k6AeH2NVe0w@mail.gmail.com>
In-Reply-To: <CAHC9VhT8RXG6zEwUdQZH4HE_HkF6B8XebWnUDc-k6AeH2NVe0w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 Apr 2023 22:16:22 -0700
Message-ID: <CAEf4BzaRkAtyigmu9fybW0_+TZJJX2i93BXjiNUfazt2dFDFbQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 7:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Apr 12, 2023 at 9:43=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Wed, Apr 12, 2023 at 12:07=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > On Wed, Apr 12, 2023 at 2:28=E2=80=AFPM Kees Cook <keescook@chromium.=
org> wrote:
> > > > On Wed, Apr 12, 2023 at 02:06:23PM -0400, Paul Moore wrote:
> > > > > On Wed, Apr 12, 2023 at 1:47=E2=80=AFPM Kees Cook <keescook@chrom=
ium.org> wrote:
> > > > > > On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
> > > > > > > On Wed, Apr 12, 2023 at 12:33=E2=80=AFAM Andrii Nakryiko <and=
rii@kernel.org> wrote:
>
> ...
>
> > > > > > For example, in many places we have things like:
> > > > > >
> > > > > >         if (!some_check(...) && !capable(...))
> > > > > >                 return -EPERM;
> > > > > >
> > > > > > I would expect this is a similar logic. An operation can succee=
d if the
> > > > > > access control requirement is met. The mismatch we have through=
-out the
> > > > > > kernel is that capability checks aren't strictly done by LSM ho=
oks. And
> > > > > > this series conceptually, I think, doesn't violate that -- it's=
 changing
> > > > > > the logic of the capability checks, not the LSM (i.e. there no =
LSM hooks
> > > > > > yet here).
> > > > >
> > > > > Patch 04/08 creates a new LSM hook, security_bpf_map_create(), wh=
ich
> > > > > when it returns a positive value "bypasses kernel checks".  The p=
atch
> > > > > isn't based on either Linus' tree or the LSM tree, I'm guessing i=
t is
> > > > > based on a eBPF tree, so I can't say with 100% certainty that it =
is
> > > > > bypassing a capability check, but the description claims that to =
be
> > > > > the case.
> > > > >
> > > > > Regardless of how you want to spin this, I'm not supportive of a =
LSM
> > > > > hook which allows a LSM to bypass a capability check.  A LSM hook=
 can
> > > > > be used to provide additional access control restrictions beyond =
a
> > > > > capability check, but a LSM hook should never be allowed to overr=
ule
> > > > > an access denial due to a capability check.
> > > > >
> > > > > > The reason CAP_BPF was created was because there was nothing el=
se that
> > > > > > would be fine-grained enough at the time.
> > > > >
> > > > > The LSM layer predates CAP_BPF, and one could make a very solid
> > > > > argument that one of the reasons LSMs exist is to provide
> > > > > supplementary controls due to capability-based access controls be=
ing a
> > > > > poor fit for many modern use cases.
> > > >
> > > > I generally agree with what you say, but we DO have this code patte=
rn:
> > > >
> > > >          if (!some_check(...) && !capable(...))
> > > >                  return -EPERM;
> > >
> > > I think we need to make this more concrete; we don't have a pattern i=
n
> > > the upstream kernel where 'some_check(...)' is a LSM hook, right?
> > > Simply because there is another kernel access control mechanism which
> > > allows a capability check to be skipped doesn't mean I want to allow =
a
> > > LSM hook to be used to skip a capability check.
> >
> > This work is an attempt to tighten the security of production systems
> > by allowing to drop too coarse-grained and permissive capabilities
> > (like CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, which inevitable allow more
> > than production use cases are meant to be able to do) and then grant
> > specific BPF operations on specific BPF programs/maps based on custom
> > LSM security policy, which validates application trustworthiness using
> > custom production-specific logic.
>
> There are ways to leverage the LSMs to apply finer grained access
> control on top of the relatively coarse capabilities that do not
> require circumventing those capability controls.  One grants the
> capabilities, just as one would do today, and then leverages the
> security functionality of a LSM to further restrict specific users,
> applications, etc. with a level of granularity beyond that offered by
> the capability controls.

Please help me understand something. What you and Casey are proposing,
when taken to the logical extreme, is to grant to all processes root
permissions and then use LSM to restrict specific actions, do I
understand correctly? This strikes me as a less secure and more
error-prone way of doing things. If there is some problem with
installing LSM policy, it could go unnoticed for a really long time,
while the system would be way more vulnerable. Why do you prefer such
an approach instead of going with no extra permissions by default, but
allowing custom LSM policy to grant few exceptions for known and
trusted use cases?

By the way, even the above proposal of yours doesn't work for
production use cases when user namespaces are involved, as far as I
understand. We cannot grant CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN for
containers running inside user namespaces, as CAP_BPF in non-init
namespace is not enough for bpf() syscall to allow loading BPF maps or
BPF program (bpf() doesn't do ns_capable(), it's only using
capable()). What solution would you suggest for such production
setups?

Also, in previous email you said:

> Simply because there is another kernel access control mechanism which
> allows a capability check to be skipped doesn't mean I want to allow a
> LSM hook to be used to skip a capability check.

I understand your stated position, but can you please help me
understand the reasoning behind it? What would be wrong with some LSM
hooks granting effective capabilities? How would that change anything
about LSM design? As far as I can see, I'm not doing anything crazy
with my LSM hook implementation. It's reusing the standard
call_int_hook() mechanism very straightforwardly with a default result
of 0. And then just interprets 0, <0, and >0 results accordingly. Is
that abusing the LSM mechanism itself somehow?

Does the above also mean that you'd be fine if we just don't plug into
the LSM subsystem at all and instead come up with some ad-hoc solution
to allow effectively the same policies? This sounds detrimental both
to LSM and BPF subsystems, so I hope we can talk this through before
finalizing decisions.

Lastly, you mentioned before:

> > > I think we need to make this more concrete; we don't have a pattern i=
n
> > > the upstream kernel where 'some_check(...)' is a LSM hook, right?

Unfortunately I don't have enough familiarity with all LSM hooks, so I
can't confirm or disprove the above statement. But earlier someone
brought to my attention the case of security_vm_enough_memory_mm(),
which seems to be granting effectively CAP_SYS_ADMIN for the purposes
of memory accounting. Am I missing something subtle there or does it
grant effective caps indeed?




>
> --
> paul-moore.com
