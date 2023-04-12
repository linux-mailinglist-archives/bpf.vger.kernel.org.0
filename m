Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB366DFD85
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 20:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjDLS2d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 14:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDLS2b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 14:28:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4E57AAA
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 11:28:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id f2so3936279pjs.3
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681324088; x=1683916088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m7JtYmFpx/ygHcximlOU8CFfq+3h9JNurnLfbM6HXP4=;
        b=ZWodpndThFSJgdbuWa2ZA0M5y5sreUec9CxH/+4m900hQ762OYPwudLH8rXAwhc8bX
         CalI1pFi1Lvp+OH/X4cJmsB9kL8ald2ek0oFApbk0sJ6pkkTIql8Dl8GQZXO3rrCoGgA
         /rt2koySJ3cQyDgncw9aEVuEp7OmhntQk/Axs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681324088; x=1683916088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7JtYmFpx/ygHcximlOU8CFfq+3h9JNurnLfbM6HXP4=;
        b=fOHEedYjvH2Muu1nnKHu3GAsMVZjCQUOdTVX2mU3lXrevFQx4qItkNz7jCH5/PYKlb
         5w1BDD9mPv5DhEK412JtqaRy1iTHDlz3AJYAuJCYeuRPrgYyFR7gGIV6+QgBTQxd9IXm
         yjkS4r2c2fys4gQ5sBzi+Q2e9wCRVpLh3pdozDTTgUpsqzvCCX2Dn0dGNETaSpXhr+rV
         C0Qn68hrbZ5RBToAxsVWlrA8cr6w4kf/KZGuurYAp/0gYNiWmYxtSa4XA2mDUJq1cVA6
         hJ3QrYyYPGEE0A7/abAhqqzQGnJECv5CnkOQqYEcc4L5CNZGSLHlCvqPsM0jGEgmjYe/
         GPrQ==
X-Gm-Message-State: AAQBX9f7CcupfaTOLrupZQFro0q6IeaA2/r941r5ZuHxuAGXs9PO6npU
        KOTC4qSuHhiolf49dxWMOBFc8Oav0dtLqvKttxg=
X-Google-Smtp-Source: AKy350aOdUURQPOYuzd8Y1N+46zpWPQoRnacWjM1GTx1bU3kHX4QKEdCtnGUqmrWrbyVLzcM1J5GLQ==
X-Received: by 2002:a05:6a20:3396:b0:eb:8833:c92f with SMTP id f22-20020a056a20339600b000eb8833c92fmr3860477pzd.5.1681324088386;
        Wed, 12 Apr 2023 11:28:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u3-20020aa78383000000b00637bf1da0b8sm6373986pfm.177.2023.04.12.11.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:28:07 -0700 (PDT)
Message-ID: <6436f837.a70a0220.ada87.d446@mx.google.com>
X-Google-Original-Message-ID: <202304121126.@keescook>
Date:   Wed, 12 Apr 2023 11:28:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
References: <20230412043300.360803-1-andrii@kernel.org>
 <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com>
 <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 02:06:23PM -0400, Paul Moore wrote:
> On Wed, Apr 12, 2023 at 1:47 PM Kees Cook <keescook@chromium.org> wrote:
> > On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
> > > On Wed, Apr 12, 2023 at 12:33 AM Andrii Nakryiko <andrii@kernel.org> wrote:
> > > >
> > > > Add new LSM hooks, bpf_map_create_security and bpf_btf_load_security, which
> > > > are meant to allow highly-granular LSM-based control over the usage of BPF
> > > > subsytem. Specifically, to control the creation of BPF maps and BTF data
> > > > objects, which are fundamental building blocks of any modern BPF application.
> > > >
> > > > These new hooks are able to override default kernel-side CAP_BPF-based (and
> > > > sometimes CAP_NET_ADMIN-based) permission checks. It is now possible to
> > > > implement LSM policies that could granularly enforce more restrictions on
> > > > a per-BPF map basis (beyond checking coarse CAP_BPF/CAP_NET_ADMIN
> > > > capabilities), but also, importantly, allow to *bypass kernel-side
> > > > enforcement* of CAP_BPF/CAP_NET_ADMIN checks for trusted applications and use
> > > > cases.
> > >
> > > One of the hallmarks of the LSM has always been that it is
> > > non-authoritative: it cannot unilaterally grant access, it can only
> > > restrict what would have been otherwise permitted on a traditional
> > > Linux system.  Put another way, a LSM should not undermine the Linux
> > > discretionary access controls, e.g. capabilities.
> > >
> > > If there is a problem with the eBPF capability-based access controls,
> > > that problem needs to be addressed in how the core eBPF code
> > > implements its capability checks, not by modifying the LSM mechanism
> > > to bypass these checks.
> >
> > I think semantics matter here. I wouldn't view this as _bypassing_
> > capability enforcement: it's just more fine-grained access control.
> >
> > For example, in many places we have things like:
> >
> >         if (!some_check(...) && !capable(...))
> >                 return -EPERM;
> >
> > I would expect this is a similar logic. An operation can succeed if the
> > access control requirement is met. The mismatch we have through-out the
> > kernel is that capability checks aren't strictly done by LSM hooks. And
> > this series conceptually, I think, doesn't violate that -- it's changing
> > the logic of the capability checks, not the LSM (i.e. there no LSM hooks
> > yet here).
> 
> Patch 04/08 creates a new LSM hook, security_bpf_map_create(), which
> when it returns a positive value "bypasses kernel checks".  The patch
> isn't based on either Linus' tree or the LSM tree, I'm guessing it is
> based on a eBPF tree, so I can't say with 100% certainty that it is
> bypassing a capability check, but the description claims that to be
> the case.
> 
> Regardless of how you want to spin this, I'm not supportive of a LSM
> hook which allows a LSM to bypass a capability check.  A LSM hook can
> be used to provide additional access control restrictions beyond a
> capability check, but a LSM hook should never be allowed to overrule
> an access denial due to a capability check.
> 
> > The reason CAP_BPF was created was because there was nothing else that
> > would be fine-grained enough at the time.
> 
> The LSM layer predates CAP_BPF, and one could make a very solid
> argument that one of the reasons LSMs exist is to provide
> supplementary controls due to capability-based access controls being a
> poor fit for many modern use cases.

I generally agree with what you say, but we DO have this code pattern:

         if (!some_check(...) && !capable(...))
                 return -EPERM;

It looks to me like this series can be refactored to do the same. I
wouldn't consider that to be a "bypass", but I would agree the current
series looks too much like "bypass", and makes reasoning about the
effect of the LSM hooks too "special". :)

-- 
Kees Cook
