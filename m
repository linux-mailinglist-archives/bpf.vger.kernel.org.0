Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8952A6DFE59
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 21:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjDLTHG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 15:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDLTHF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 15:07:05 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA14E69
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 12:07:01 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id q5so15751309ybk.7
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 12:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681326421; x=1683918421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWjKbekkP8a3hscvaXgC6k5dNgXGIcnoNZ//JMZZDGU=;
        b=YHM441zyCJlrGXKzDbUc4uJEnWbsWfGR6vFBvOgR02umvX7GVThuLg1bjpPlnykQzT
         a9W5ZskXQyy6OnfAZlHc90yfdY5HIYXuVy8UhmNfrfeEzFdqxTHy1ejIXBSC+jjasjWy
         SzdtXJJSU3ZBVi/KEa/Th6qByEjxiyp5hZKNqHZ2kS+gOg5ehq2+DmzVnIuUD9R1GeQs
         +JynuL26w/9C4PUMDuQ8/LjUTtW36dSRufg43epwyQvXclUPgWzgqE2zfaw0uBBOl6j5
         vbEK0VZ1+aUYrW/+ZzacXBAJboogxyQLqlPCbMNXm+P0xL4dzty5pU2KZLbUXn5qkNa/
         ++iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681326421; x=1683918421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWjKbekkP8a3hscvaXgC6k5dNgXGIcnoNZ//JMZZDGU=;
        b=OPXGFyTN0yde9P8CbKiIaMT4zns4UsY5pwi40669mrvNCjXUZbdRF/2Y+N6i0NhUZO
         s+UVdhFtK9G6167eGDOMAU5IqXo8HN9O4twye8yoZgy7THFU1pchHroQtpM0LixYNIR6
         lFX3qG3r+gYHPe209eNpVH8KS/yuaeNVmo7IIg3TO7fOM90EpDRFf1jYBpiorpd5RzIA
         iPbb9PbMD7do8357y6Pu2LV7n0b9fGEAsIUVP+IO3Ux3AZ06Xr14yxzsqWgQ4UZjdp3C
         sTIA4S9jjdW26Z7pgf1sZdAcCq/6Oy3GPxz3zmOPVs3iv20I2aTh2RSXetuqR2Zhfzyx
         dXSg==
X-Gm-Message-State: AAQBX9f6dXnvracMvaVoF6BYhmIcRTbxc4O+e+jJqe6HPir2mdkVU/Bs
        Af4I9WLVB0SjnM7+RNG0/57O+rVsjZ4QM5OoXk/W
X-Google-Smtp-Source: AKy350ZahLXSXPqw0eLIKIzoET2RDmTKo8zjzMH0pk0vnFMwayVviX/LK4xaW5wuV7kSUNlyoPm+G/H0E2TyoO+kaRM=
X-Received: by 2002:a25:d702:0:b0:b68:7a4a:5258 with SMTP id
 o2-20020a25d702000000b00b687a4a5258mr2441859ybg.3.1681326420746; Wed, 12 Apr
 2023 12:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com> <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
 <6436f837.a70a0220.ada87.d446@mx.google.com>
In-Reply-To: <6436f837.a70a0220.ada87.d446@mx.google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Apr 2023 15:06:50 -0400
Message-ID: <CAHC9VhTF0JX3_zZ1ZRnoOw0ToYj6AsvK6OCiKqQgPvHepH9W3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 2:28=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
> On Wed, Apr 12, 2023 at 02:06:23PM -0400, Paul Moore wrote:
> > On Wed, Apr 12, 2023 at 1:47=E2=80=AFPM Kees Cook <keescook@chromium.or=
g> wrote:
> > > On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
> > > > On Wed, Apr 12, 2023 at 12:33=E2=80=AFAM Andrii Nakryiko <andrii@ke=
rnel.org> wrote:
> > > > >
> > > > > Add new LSM hooks, bpf_map_create_security and bpf_btf_load_secur=
ity, which
> > > > > are meant to allow highly-granular LSM-based control over the usa=
ge of BPF
> > > > > subsytem. Specifically, to control the creation of BPF maps and B=
TF data
> > > > > objects, which are fundamental building blocks of any modern BPF =
application.
> > > > >
> > > > > These new hooks are able to override default kernel-side CAP_BPF-=
based (and
> > > > > sometimes CAP_NET_ADMIN-based) permission checks. It is now possi=
ble to
> > > > > implement LSM policies that could granularly enforce more restric=
tions on
> > > > > a per-BPF map basis (beyond checking coarse CAP_BPF/CAP_NET_ADMIN
> > > > > capabilities), but also, importantly, allow to *bypass kernel-sid=
e
> > > > > enforcement* of CAP_BPF/CAP_NET_ADMIN checks for trusted applicat=
ions and use
> > > > > cases.
> > > >
> > > > One of the hallmarks of the LSM has always been that it is
> > > > non-authoritative: it cannot unilaterally grant access, it can only
> > > > restrict what would have been otherwise permitted on a traditional
> > > > Linux system.  Put another way, a LSM should not undermine the Linu=
x
> > > > discretionary access controls, e.g. capabilities.
> > > >
> > > > If there is a problem with the eBPF capability-based access control=
s,
> > > > that problem needs to be addressed in how the core eBPF code
> > > > implements its capability checks, not by modifying the LSM mechanis=
m
> > > > to bypass these checks.
> > >
> > > I think semantics matter here. I wouldn't view this as _bypassing_
> > > capability enforcement: it's just more fine-grained access control.
> > >
> > > For example, in many places we have things like:
> > >
> > >         if (!some_check(...) && !capable(...))
> > >                 return -EPERM;
> > >
> > > I would expect this is a similar logic. An operation can succeed if t=
he
> > > access control requirement is met. The mismatch we have through-out t=
he
> > > kernel is that capability checks aren't strictly done by LSM hooks. A=
nd
> > > this series conceptually, I think, doesn't violate that -- it's chang=
ing
> > > the logic of the capability checks, not the LSM (i.e. there no LSM ho=
oks
> > > yet here).
> >
> > Patch 04/08 creates a new LSM hook, security_bpf_map_create(), which
> > when it returns a positive value "bypasses kernel checks".  The patch
> > isn't based on either Linus' tree or the LSM tree, I'm guessing it is
> > based on a eBPF tree, so I can't say with 100% certainty that it is
> > bypassing a capability check, but the description claims that to be
> > the case.
> >
> > Regardless of how you want to spin this, I'm not supportive of a LSM
> > hook which allows a LSM to bypass a capability check.  A LSM hook can
> > be used to provide additional access control restrictions beyond a
> > capability check, but a LSM hook should never be allowed to overrule
> > an access denial due to a capability check.
> >
> > > The reason CAP_BPF was created was because there was nothing else tha=
t
> > > would be fine-grained enough at the time.
> >
> > The LSM layer predates CAP_BPF, and one could make a very solid
> > argument that one of the reasons LSMs exist is to provide
> > supplementary controls due to capability-based access controls being a
> > poor fit for many modern use cases.
>
> I generally agree with what you say, but we DO have this code pattern:
>
>          if (!some_check(...) && !capable(...))
>                  return -EPERM;

I think we need to make this more concrete; we don't have a pattern in
the upstream kernel where 'some_check(...)' is a LSM hook, right?
Simply because there is another kernel access control mechanism which
allows a capability check to be skipped doesn't mean I want to allow a
LSM hook to be used to skip a capability check.

> It looks to me like this series can be refactored to do the same. I
> wouldn't consider that to be a "bypass", but I would agree the current
> series looks too much like "bypass", and makes reasoning about the
> effect of the LSM hooks too "special". :)

--=20
paul-moore.com
