Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782AB6E03D2
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 03:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjDMBnS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 21:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjDMBnP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 21:43:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFC54202;
        Wed, 12 Apr 2023 18:43:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id f26so27413666ejb.1;
        Wed, 12 Apr 2023 18:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681350192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkivxPE2LhlDcunS+AzzmE3dct0mDEdNoJrScQ6Mvls=;
        b=iAM6fyBgbg5yLl8qguTQJMIdKBppKPZv9PxjteyX/TrqO5FdZ+NybQkFZDZbS9I4xm
         vtV6RP7ROS4iaMoBMlGQUrlvTS/oRiEyC1LzuhNMevrkeXiZf8ciQ5PxYlb2XNzQq4EH
         UIWwEt2Nb6L32fhcaFPbkPca9m8QZ6esFc1sdp3Hn+ApZpefkgslaY6bPrRr/2XktaLR
         XTkZobnZ9c1WG1223WvZ07Tt1mg0AGh97MuFQwCMm5umGuYG9M4RzBnrpnfNfg2lsFRA
         wACzyNvNvi+5BJjwH9LYisYu/4EFhd0QCXgQyLTAGkyLkMddtOzLuDUKyqoHcF9m5CCs
         Znvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681350192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkivxPE2LhlDcunS+AzzmE3dct0mDEdNoJrScQ6Mvls=;
        b=Df4f8pQvFUjeahJmJU1hVCGJmDW/J85lF7t2YU6uwBX8KZ6MxkhgEalWizFsjeBq/0
         qUp9oWv11QjSgGuyKBuUus99BBsDu/KmgBnM94f6DZQFiu0ypEoy/bN7hAjlNwsSURWX
         JqFDha2D+MTJ3HEimBPuEjj3EmUzxWnyHIn6XrkYuBnHFNzKnH1czlVu+Qe3AugYRWPk
         viQips9WoZM0gMXbIPoa0W0sjtuLoG88vvVzlv81tfqN2x0q+Tm3jFTwMrcAEIMxcXio
         XZcS+lKGC5U1rLiKc6xudXvGMSwnSG5Eure5ialGckK3el3WI0Bbnrv1l5i7laBlt0gV
         yAVA==
X-Gm-Message-State: AAQBX9ebaPSlouduyory1DIqObaq0ntrn9hHcfb09LPeL2bfcbSBTn5E
        3WYqlOV6P6rr55roCjEtRVMxGpbyNG/276XSGPo=
X-Google-Smtp-Source: AKy350YsZsHAoGOvyJyUVEIx9pT6liiv8dqrEdYiOD4TaFWOPDPbP7J0ILnS5VygxAGJ6uxjPjoNr9X0qmUbP8JpP30=
X-Received: by 2002:a17:906:52d6:b0:949:8e10:31c1 with SMTP id
 w22-20020a17090652d600b009498e1031c1mr407079ejn.5.1681350192512; Wed, 12 Apr
 2023 18:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com> <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
 <6436f837.a70a0220.ada87.d446@mx.google.com> <CAHC9VhTF0JX3_zZ1ZRnoOw0ToYj6AsvK6OCiKqQgPvHepH9W3Q@mail.gmail.com>
In-Reply-To: <CAHC9VhTF0JX3_zZ1ZRnoOw0ToYj6AsvK6OCiKqQgPvHepH9W3Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 Apr 2023 18:43:00 -0700
Message-ID: <CAEf4BzY9GPr9c2fTUS6ijHURtdNDL4xM6+JAEggEqLuz9sk4Dg@mail.gmail.com>
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

On Wed, Apr 12, 2023 at 12:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Wed, Apr 12, 2023 at 2:28=E2=80=AFPM Kees Cook <keescook@chromium.org>=
 wrote:
> > On Wed, Apr 12, 2023 at 02:06:23PM -0400, Paul Moore wrote:
> > > On Wed, Apr 12, 2023 at 1:47=E2=80=AFPM Kees Cook <keescook@chromium.=
org> wrote:
> > > > On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
> > > > > On Wed, Apr 12, 2023 at 12:33=E2=80=AFAM Andrii Nakryiko <andrii@=
kernel.org> wrote:
> > > > > >
> > > > > > Add new LSM hooks, bpf_map_create_security and bpf_btf_load_sec=
urity, which
> > > > > > are meant to allow highly-granular LSM-based control over the u=
sage of BPF
> > > > > > subsytem. Specifically, to control the creation of BPF maps and=
 BTF data
> > > > > > objects, which are fundamental building blocks of any modern BP=
F application.
> > > > > >
> > > > > > These new hooks are able to override default kernel-side CAP_BP=
F-based (and
> > > > > > sometimes CAP_NET_ADMIN-based) permission checks. It is now pos=
sible to
> > > > > > implement LSM policies that could granularly enforce more restr=
ictions on
> > > > > > a per-BPF map basis (beyond checking coarse CAP_BPF/CAP_NET_ADM=
IN
> > > > > > capabilities), but also, importantly, allow to *bypass kernel-s=
ide
> > > > > > enforcement* of CAP_BPF/CAP_NET_ADMIN checks for trusted applic=
ations and use
> > > > > > cases.
> > > > >
> > > > > One of the hallmarks of the LSM has always been that it is
> > > > > non-authoritative: it cannot unilaterally grant access, it can on=
ly
> > > > > restrict what would have been otherwise permitted on a traditiona=
l
> > > > > Linux system.  Put another way, a LSM should not undermine the Li=
nux
> > > > > discretionary access controls, e.g. capabilities.
> > > > >
> > > > > If there is a problem with the eBPF capability-based access contr=
ols,
> > > > > that problem needs to be addressed in how the core eBPF code
> > > > > implements its capability checks, not by modifying the LSM mechan=
ism
> > > > > to bypass these checks.
> > > >
> > > > I think semantics matter here. I wouldn't view this as _bypassing_
> > > > capability enforcement: it's just more fine-grained access control.

Exactly. One of the motivations for this work was the need to move
some production use cases that are only needing extra privileges so
that they can use BPF into a more restrictive environment. Granting
CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN to all such use cases that need them
for BPF usage is too coarse grained. These caps would allow those
applications way more than just BPF usage. So the idea here is more
finer-grained control of BPF-specific operations, granting *effective*
CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN caps dynamically based on custom
production logic that would validate the use case.

This *is* an attempt to achieve a more secure production approach.

> > > >
> > > > For example, in many places we have things like:
> > > >
> > > >         if (!some_check(...) && !capable(...))
> > > >                 return -EPERM;
> > > >
> > > > I would expect this is a similar logic. An operation can succeed if=
 the
> > > > access control requirement is met. The mismatch we have through-out=
 the
> > > > kernel is that capability checks aren't strictly done by LSM hooks.=
 And
> > > > this series conceptually, I think, doesn't violate that -- it's cha=
nging
> > > > the logic of the capability checks, not the LSM (i.e. there no LSM =
hooks
> > > > yet here).
> > >
> > > Patch 04/08 creates a new LSM hook, security_bpf_map_create(), which
> > > when it returns a positive value "bypasses kernel checks".  The patch
> > > isn't based on either Linus' tree or the LSM tree, I'm guessing it is
> > > based on a eBPF tree, so I can't say with 100% certainty that it is
> > > bypassing a capability check, but the description claims that to be
> > > the case.
> > >
> > > Regardless of how you want to spin this, I'm not supportive of a LSM
> > > hook which allows a LSM to bypass a capability check.  A LSM hook can
> > > be used to provide additional access control restrictions beyond a
> > > capability check, but a LSM hook should never be allowed to overrule
> > > an access denial due to a capability check.
> > >
> > > > The reason CAP_BPF was created was because there was nothing else t=
hat
> > > > would be fine-grained enough at the time.
> > >
> > > The LSM layer predates CAP_BPF, and one could make a very solid
> > > argument that one of the reasons LSMs exist is to provide
> > > supplementary controls due to capability-based access controls being =
a
> > > poor fit for many modern use cases.
> >
> > I generally agree with what you say, but we DO have this code pattern:
> >
> >          if (!some_check(...) && !capable(...))
> >                  return -EPERM;
>
> I think we need to make this more concrete; we don't have a pattern in
> the upstream kernel where 'some_check(...)' is a LSM hook, right?
> Simply because there is another kernel access control mechanism which
> allows a capability check to be skipped doesn't mean I want to allow a
> LSM hook to be used to skip a capability check.

This work is an attempt to tighten the security of production systems
by allowing to drop too coarse-grained and permissive capabilities
(like CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, which inevitable allow more
than production use cases are meant to be able to do) and then grant
specific BPF operations on specific BPF programs/maps based on custom
LSM security policy, which validates application trustworthiness using
custom production-specific logic.

Isn't this goal in line with LSMs mission to enhance system security?

>
> > It looks to me like this series can be refactored to do the same. I
> > wouldn't consider that to be a "bypass", but I would agree the current
> > series looks too much like "bypass", and makes reasoning about the
> > effect of the LSM hooks too "special". :)

Sorry, I didn't realize that the current code layout is making things
more confusing. I'll address feedback to make the intent a bit
clearer.

>
> --
> paul-moore.com
