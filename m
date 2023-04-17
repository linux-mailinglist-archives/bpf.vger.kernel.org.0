Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583756E552E
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 01:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjDQXbc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 19:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQXbb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 19:31:31 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDCF4206;
        Mon, 17 Apr 2023 16:31:29 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id fw30so15763690ejc.5;
        Mon, 17 Apr 2023 16:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681774288; x=1684366288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvVgtGAf+sC/033TXxwP700jSBTYe0RXnN/7Il9wzhI=;
        b=D/mLL26D3GN/zDaGQ50vj7jKCq+d68RsPrePm0PReEUnjWlBuGEoNWQxJ6Vi9YUoUS
         WE9rIsBRjibiddQ/73sU9SbBdOus/Th8kGI+WlVqwknbAbx39mIwGBJvv+vjK8hCaoo7
         R9+OWqoDJWdbkOpmjhlImMZGD6uXSsVoEA29bsBQOkTXMVmMGE6u3EgRcps3B8FBgrri
         PSxSj8m8AiHoxnPRy59QWu5olYPfjyxF7nIS2HslDCQoQWGwWe1MQ5wGQsY98i/Oq9NT
         CH+u2N+52rCLh/bwW1xvC3Rq+4TJ94xjkOukTsuJLS+EfSyMm7tyj17H0g7PftdRmoqN
         Wozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681774288; x=1684366288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvVgtGAf+sC/033TXxwP700jSBTYe0RXnN/7Il9wzhI=;
        b=axhVerwDRRG+ZZvyP67IJi4UKp/800gUe3SgN4OcrTGcN7UURDc3Z2+uZwWWL9Oxfs
         dfAnKK6jUb/qGYZffB3m7GMdZfxKIQAVuxwiv5rnswSa3F8xie3S7cENYLvKoOssmuRn
         sHPR4EDlSGP6y9a5sUN1WAIGWPpXUUn1G6pWZQ2NeZMMS98KTEAGIYixF1rE+VDAOWd2
         WqgijIOWuVvrmCe9Uib3bHOkq/Q0L3PID96dcSbKKq6QjNm8c/ftoPj/BfVDIylleG5c
         7gvw27gbEgJscg33DjqKaJLvZbUkHxAL3YGMXRW7b559DpcXqNWEnSONXVLBa2S35+Xx
         Ri4w==
X-Gm-Message-State: AAQBX9dstYNWWPwsKYcWV/tEQGeFxsqUrMxGKs0t5ABeOONinIdxX6Yr
        a3LvlFr2LT+tg5DIaRqme3LGyGvEFAo1STdvQOs=
X-Google-Smtp-Source: AKy350bGjsos3pGwcZwfrxScD2c0/z/R+MiNw81YsXxj8lE+T3gES0AM367/QMbTNMizsq91AmRjUaIDv7blQky8Ito=
X-Received: by 2002:a17:906:b817:b0:94a:7c21:6ade with SMTP id
 dv23-20020a170906b81700b0094a7c216ademr3590097ejb.5.1681774287637; Mon, 17
 Apr 2023 16:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com> <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
 <6436f837.a70a0220.ada87.d446@mx.google.com> <CAHC9VhTF0JX3_zZ1ZRnoOw0ToYj6AsvK6OCiKqQgPvHepH9W3Q@mail.gmail.com>
 <CAEf4BzY9GPr9c2fTUS6ijHURtdNDL4xM6+JAEggEqLuz9sk4Dg@mail.gmail.com> <afd17142-9243-8b72-d16a-41165e8deda1@schaufler-ca.com>
In-Reply-To: <afd17142-9243-8b72-d16a-41165e8deda1@schaufler-ca.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 17 Apr 2023 16:31:14 -0700
Message-ID: <CAEf4BzaaFruReHByj_ngz+BiQmKQGeK+1DsAzg1YmVnZxfADug@mail.gmail.com>
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

On Thu, Apr 13, 2023 at 9:27=E2=80=AFAM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 4/12/2023 6:43 PM, Andrii Nakryiko wrote:
> > On Wed, Apr 12, 2023 at 12:07=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> >> On Wed, Apr 12, 2023 at 2:28=E2=80=AFPM Kees Cook <keescook@chromium.o=
rg> wrote:
> >>> On Wed, Apr 12, 2023 at 02:06:23PM -0400, Paul Moore wrote:
> >>>> On Wed, Apr 12, 2023 at 1:47=E2=80=AFPM Kees Cook <keescook@chromium=
.org> wrote:
> >>>>> On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
> >>>>>> On Wed, Apr 12, 2023 at 12:33=E2=80=AFAM Andrii Nakryiko <andrii@k=
ernel.org> wrote:
> >>>>>>> Add new LSM hooks, bpf_map_create_security and bpf_btf_load_secur=
ity, which
> >>>>>>> are meant to allow highly-granular LSM-based control over the usa=
ge of BPF
> >>>>>>> subsytem. Specifically, to control the creation of BPF maps and B=
TF data
> >>>>>>> objects, which are fundamental building blocks of any modern BPF =
application.
> >>>>>>>
> >>>>>>> These new hooks are able to override default kernel-side CAP_BPF-=
based (and
> >>>>>>> sometimes CAP_NET_ADMIN-based) permission checks. It is now possi=
ble to
> >>>>>>> implement LSM policies that could granularly enforce more restric=
tions on
> >>>>>>> a per-BPF map basis (beyond checking coarse CAP_BPF/CAP_NET_ADMIN
> >>>>>>> capabilities), but also, importantly, allow to *bypass kernel-sid=
e
> >>>>>>> enforcement* of CAP_BPF/CAP_NET_ADMIN checks for trusted applicat=
ions and use
> >>>>>>> cases.
> >>>>>> One of the hallmarks of the LSM has always been that it is
> >>>>>> non-authoritative: it cannot unilaterally grant access, it can onl=
y
> >>>>>> restrict what would have been otherwise permitted on a traditional
> >>>>>> Linux system.  Put another way, a LSM should not undermine the Lin=
ux
> >>>>>> discretionary access controls, e.g. capabilities.
> >>>>>>
> >>>>>> If there is a problem with the eBPF capability-based access contro=
ls,
> >>>>>> that problem needs to be addressed in how the core eBPF code
> >>>>>> implements its capability checks, not by modifying the LSM mechani=
sm
> >>>>>> to bypass these checks.
> >>>>> I think semantics matter here. I wouldn't view this as _bypassing_
> >>>>> capability enforcement: it's just more fine-grained access control.
> > Exactly. One of the motivations for this work was the need to move
> > some production use cases that are only needing extra privileges so
> > that they can use BPF into a more restrictive environment. Granting
> > CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN to all such use cases that need them
> > for BPF usage is too coarse grained. These caps would allow those
> > applications way more than just BPF usage. So the idea here is more
> > finer-grained control of BPF-specific operations, granting *effective*
> > CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN caps dynamically based on custom
> > production logic that would validate the use case.
>
> That's an authoritative model which is in direct conflict with the
> design and implementation of both capabilities and LSM.
>
> >
> > This *is* an attempt to achieve a more secure production approach.
> >
> >>>>> For example, in many places we have things like:
> >>>>>
> >>>>>         if (!some_check(...) && !capable(...))
> >>>>>                 return -EPERM;
> >>>>>
> >>>>> I would expect this is a similar logic. An operation can succeed if=
 the
> >>>>> access control requirement is met. The mismatch we have through-out=
 the
> >>>>> kernel is that capability checks aren't strictly done by LSM hooks.=
 And
> >>>>> this series conceptually, I think, doesn't violate that -- it's cha=
nging
> >>>>> the logic of the capability checks, not the LSM (i.e. there no LSM =
hooks
> >>>>> yet here).
> >>>> Patch 04/08 creates a new LSM hook, security_bpf_map_create(), which
> >>>> when it returns a positive value "bypasses kernel checks".  The patc=
h
> >>>> isn't based on either Linus' tree or the LSM tree, I'm guessing it i=
s
> >>>> based on a eBPF tree, so I can't say with 100% certainty that it is
> >>>> bypassing a capability check, but the description claims that to be
> >>>> the case.
> >>>>
> >>>> Regardless of how you want to spin this, I'm not supportive of a LSM
> >>>> hook which allows a LSM to bypass a capability check.  A LSM hook ca=
n
> >>>> be used to provide additional access control restrictions beyond a
> >>>> capability check, but a LSM hook should never be allowed to overrule
> >>>> an access denial due to a capability check.
> >>>>
> >>>>> The reason CAP_BPF was created was because there was nothing else t=
hat
> >>>>> would be fine-grained enough at the time.
> >>>> The LSM layer predates CAP_BPF, and one could make a very solid
> >>>> argument that one of the reasons LSMs exist is to provide
> >>>> supplementary controls due to capability-based access controls being=
 a
> >>>> poor fit for many modern use cases.
> >>> I generally agree with what you say, but we DO have this code pattern=
:
> >>>
> >>>          if (!some_check(...) && !capable(...))
> >>>                  return -EPERM;
> >> I think we need to make this more concrete; we don't have a pattern in
> >> the upstream kernel where 'some_check(...)' is a LSM hook, right?
> >> Simply because there is another kernel access control mechanism which
> >> allows a capability check to be skipped doesn't mean I want to allow a
> >> LSM hook to be used to skip a capability check.
> > This work is an attempt to tighten the security of production systems
> > by allowing to drop too coarse-grained and permissive capabilities
> > (like CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, which inevitable allow more
> > than production use cases are meant to be able to do)
>
> The BPF developers are in complete control of what CAP_BPF controls.
> You can easily address the granularity issue by adding addition restricti=
ons
> on processes that have CAP_BPF. That is the intended use of LSM.
> The whole point of having multiple capabilities is so that you can
> grant just those that are required by the system security policy, and
> do so safely. That leads to differences of opinion regarding the definiti=
on
> of the system security policy. BPF chose to set itself up as an element
> of security policy (you need CAP_BPF) rather than define elements such th=
at
> existing capabilities (CAP_FOWNER, CAP_KILL, CAP_MAC_OVERRIDE, ...) would
> control.

Please see my reply to Paul, where I explain CAP_BPF's system-wide
nature and problem with user namespaces. I don't think the problem is
in the granularity of CAP_BPF, it's more of a "non-namespaceable"
nature of the BPF subsystem in general.

>
> >  and then grant
> > specific BPF operations on specific BPF programs/maps based on custom
> > LSM security policy,
>
> This is backwards. The correct implementation is to require CAP_BPF and
> further restrict BPF operations based on a custom LSM security policy.
> That's how LSM is designed.

Please see my reply to Paul, we can't grant real CAP_BPF for
applications in user namespace (unless there is some trick that I
don't know, so please do point it out). Let's converge the discussion
in that email thread branch to not discuss the same topic multiple
times.


>
> >  which validates application trustworthiness using
> > custom production-specific logic.
> >
> > Isn't this goal in line with LSMs mission to enhance system security?
>
> We're not arguing the goal, we're discussing the implementation.
>
> >>> It looks to me like this series can be refactored to do the same. I
> >>> wouldn't consider that to be a "bypass", but I would agree the curren=
t
> >>> series looks too much like "bypass", and makes reasoning about the
> >>> effect of the LSM hooks too "special". :)
> > Sorry, I didn't realize that the current code layout is making things
> > more confusing. I'll address feedback to make the intent a bit
> > clearer.
> >
> >> --
> >> paul-moore.com
