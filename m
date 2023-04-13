Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB466E04F4
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 04:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjDMC5F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 22:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjDMC5D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 22:57:03 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9C310EC
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 19:56:58 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id v7so12481527ybi.0
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 19:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681354617; x=1683946617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UY08ZCA7g/9tHh3dbd0OItUztJmkMAu+XKTk8WVIyaw=;
        b=OhhE4z210G3lwDapVWViLJDw6gysseeIpltX2OJYqnrp0yFSMIkZgy8cTr3+zlbDN0
         DDmLazDHvqT2ykNSij9wEb0SquPqx+HYnG6OWoYMCvPeAIsZ2GWCEdhbg8G69dmGrQKI
         nHCELzZAORoNIJxt6qJdDdlotqhyDMuW6vVlpiYvFqktv+XtouAnUNkSGD7YjmPz7i29
         eCayemTDQbx/t9YnDu7XCUAOAts67meITY1vbUDeKOyxgN7BsOQ/p7Ife4u5HoipTsyF
         im8XhVE2vudYi/MXWELzIi//t0qS9JzhJeVblI0LTRBvblgO7hZmnteCfzq0KI8dJAB5
         vv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681354617; x=1683946617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UY08ZCA7g/9tHh3dbd0OItUztJmkMAu+XKTk8WVIyaw=;
        b=dDiRShu26h0ygnpmSImmiW6Ckyk+KqXRqxii6TcqMEqAwKDansL/aDWnMqez7qFV+O
         hU0VXRkBosJyVuuf7oUwuP5RIH0pU35JYWZcdx3HqmQkzUetkxLLrtBMmfeCQvWvCpD4
         lKq9hy9SkK0Zkj2Wp8k6v5Zabtaooew09UqiEpJFFEZxyadVqJkgURSARv7kRASshmSV
         wlJwCgpdCG0K0katCaCAzFWLDKFK/aDb66wb7F3jKq15azRN5k2EKHd1BDLLjBlmNkL/
         w4N3gfKUYRaeRNdENnXGYSCxnI61AO9CDEWjPS8IRgATra6Sl+fyDk5gK6aEMFlzS6QO
         Lg2g==
X-Gm-Message-State: AAQBX9fk0KEpUeiLsqcnJwV1wzN0V+ywr48HT8j5EcdTPgCcP1J8ypuJ
        KPC9RfodwvYV2P1O/CBcn6jRcTTIOByNsGDi4ThG
X-Google-Smtp-Source: AKy350Z7OUIqIaNUffyuGb6Z12ilXUtWsSbo31dC1HYFRZEIJSSeSPWg6BbGcTRWaNugmltONTIApF6XBcMcwdCz6bE=
X-Received: by 2002:a25:d7d3:0:b0:b68:7a4a:5258 with SMTP id
 o202-20020a25d7d3000000b00b687a4a5258mr515514ybg.3.1681354617518; Wed, 12 Apr
 2023 19:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com> <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
 <6436f837.a70a0220.ada87.d446@mx.google.com> <CAHC9VhTF0JX3_zZ1ZRnoOw0ToYj6AsvK6OCiKqQgPvHepH9W3Q@mail.gmail.com>
 <CAEf4BzY9GPr9c2fTUS6ijHURtdNDL4xM6+JAEggEqLuz9sk4Dg@mail.gmail.com>
In-Reply-To: <CAEf4BzY9GPr9c2fTUS6ijHURtdNDL4xM6+JAEggEqLuz9sk4Dg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Apr 2023 22:56:46 -0400
Message-ID: <CAHC9VhT8RXG6zEwUdQZH4HE_HkF6B8XebWnUDc-k6AeH2NVe0w@mail.gmail.com>
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

On Wed, Apr 12, 2023 at 9:43=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Wed, Apr 12, 2023 at 12:07=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Wed, Apr 12, 2023 at 2:28=E2=80=AFPM Kees Cook <keescook@chromium.or=
g> wrote:
> > > On Wed, Apr 12, 2023 at 02:06:23PM -0400, Paul Moore wrote:
> > > > On Wed, Apr 12, 2023 at 1:47=E2=80=AFPM Kees Cook <keescook@chromiu=
m.org> wrote:
> > > > > On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
> > > > > > On Wed, Apr 12, 2023 at 12:33=E2=80=AFAM Andrii Nakryiko <andri=
i@kernel.org> wrote:

...

> > > > > For example, in many places we have things like:
> > > > >
> > > > >         if (!some_check(...) && !capable(...))
> > > > >                 return -EPERM;
> > > > >
> > > > > I would expect this is a similar logic. An operation can succeed =
if the
> > > > > access control requirement is met. The mismatch we have through-o=
ut the
> > > > > kernel is that capability checks aren't strictly done by LSM hook=
s. And
> > > > > this series conceptually, I think, doesn't violate that -- it's c=
hanging
> > > > > the logic of the capability checks, not the LSM (i.e. there no LS=
M hooks
> > > > > yet here).
> > > >
> > > > Patch 04/08 creates a new LSM hook, security_bpf_map_create(), whic=
h
> > > > when it returns a positive value "bypasses kernel checks".  The pat=
ch
> > > > isn't based on either Linus' tree or the LSM tree, I'm guessing it =
is
> > > > based on a eBPF tree, so I can't say with 100% certainty that it is
> > > > bypassing a capability check, but the description claims that to be
> > > > the case.
> > > >
> > > > Regardless of how you want to spin this, I'm not supportive of a LS=
M
> > > > hook which allows a LSM to bypass a capability check.  A LSM hook c=
an
> > > > be used to provide additional access control restrictions beyond a
> > > > capability check, but a LSM hook should never be allowed to overrul=
e
> > > > an access denial due to a capability check.
> > > >
> > > > > The reason CAP_BPF was created was because there was nothing else=
 that
> > > > > would be fine-grained enough at the time.
> > > >
> > > > The LSM layer predates CAP_BPF, and one could make a very solid
> > > > argument that one of the reasons LSMs exist is to provide
> > > > supplementary controls due to capability-based access controls bein=
g a
> > > > poor fit for many modern use cases.
> > >
> > > I generally agree with what you say, but we DO have this code pattern=
:
> > >
> > >          if (!some_check(...) && !capable(...))
> > >                  return -EPERM;
> >
> > I think we need to make this more concrete; we don't have a pattern in
> > the upstream kernel where 'some_check(...)' is a LSM hook, right?
> > Simply because there is another kernel access control mechanism which
> > allows a capability check to be skipped doesn't mean I want to allow a
> > LSM hook to be used to skip a capability check.
>
> This work is an attempt to tighten the security of production systems
> by allowing to drop too coarse-grained and permissive capabilities
> (like CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, which inevitable allow more
> than production use cases are meant to be able to do) and then grant
> specific BPF operations on specific BPF programs/maps based on custom
> LSM security policy, which validates application trustworthiness using
> custom production-specific logic.

There are ways to leverage the LSMs to apply finer grained access
control on top of the relatively coarse capabilities that do not
require circumventing those capability controls.  One grants the
capabilities, just as one would do today, and then leverages the
security functionality of a LSM to further restrict specific users,
applications, etc. with a level of granularity beyond that offered by
the capability controls.

--=20
paul-moore.com
