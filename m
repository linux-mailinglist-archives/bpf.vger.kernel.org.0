Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550DD6DFD37
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 20:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjDLSGj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 14:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLSGg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 14:06:36 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E953CE77
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 11:06:34 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54c0c86a436so353935087b3.6
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681322794; x=1683914794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOpur0z+ZUUUDWNeIp4MQxAonJUSL+1bv5gFocfKWCI=;
        b=PxWnHbD6Ws3W1Gz8QcTv7ijtBMErQWuPurVBvwdlR5YTLZt4Dto7gJJxu/QUEnKriw
         1EnSZWBdOpDL84FhNN0xUmkqwZ2dFJ+qj3Vn5Eo4BZKHkBowACbYxK2pUBjc485b3hrw
         7YC/CDhINtaaFrGNNh9Xrer/a/55WhJyhbv0OrB7DbF310MO6Hgf6oVycO1gAWptPJ+E
         UZijXb7vV/SsFY5bzTRiaag2TmqrhaujlGAC22kaCcDvOZe2kp/FABUVcXxDarh9CFCw
         Ci8l//6nR9RCYDbcubv9Xjh7dQw0M/Scz95Yf24mOIflPBZq4OKDFcUnWCZKy9+hckKY
         KX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681322794; x=1683914794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOpur0z+ZUUUDWNeIp4MQxAonJUSL+1bv5gFocfKWCI=;
        b=aPadG8ntnEYOJ3sDVouQ6bmTw+Yti20diIycVWRe3yVrnG3DZdyVC9u1wDoHt4fk9z
         RUrmXoWsNCRIQNrxSB/cjGLksksI+2V6ZNU6AluE/4zhpgbjEBzHc2b0m5vDoEAk6AMF
         u/7+4C7IH+NetlOXbaT6v3rOf9OZalaVHItceQtFDCrPtSVz4brlfUK6senhfsv6LZH4
         +OgZqvRZRcUTYRMsW4TJSLa7jEQs0hN1NOOpmqrfNbXWWKMUwJFh+NYd/dtaZOfRHONs
         h0WCifJK14wHavg16ab8joOqxtmFHoKr7nVgI2xBMDvNbtEQ1aqVPFPw+bzdzrEtb78P
         LCUg==
X-Gm-Message-State: AAQBX9cxihpDaHTCAcfKVd1SiZtEu5TLoz0u2pu+EHpCurvJz9dn8nea
        iXmaG8CkQUe9/JQq3LxIXiDAtVSNrZMWiPt3uZqo
X-Google-Smtp-Source: AKy350Ybwq+KRN5bFKlKsx/pmdDpoZPyi/qw9onZN+iQFEKvChuLI1f8Exzmju5lj8P+PDvCDwvwr+EWf6eCQju/dJU=
X-Received: by 2002:a81:a789:0:b0:54f:aa4b:100c with SMTP id
 e131-20020a81a789000000b0054faa4b100cmr1178701ywh.8.1681322794078; Wed, 12
 Apr 2023 11:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com>
In-Reply-To: <6436eea2.170a0220.97ead.52a8@mx.google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Apr 2023 14:06:23 -0400
Message-ID: <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
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

On Wed, Apr 12, 2023 at 1:47=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
> On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
> > On Wed, Apr 12, 2023 at 12:33=E2=80=AFAM Andrii Nakryiko <andrii@kernel=
.org> wrote:
> > >
> > > Add new LSM hooks, bpf_map_create_security and bpf_btf_load_security,=
 which
> > > are meant to allow highly-granular LSM-based control over the usage o=
f BPF
> > > subsytem. Specifically, to control the creation of BPF maps and BTF d=
ata
> > > objects, which are fundamental building blocks of any modern BPF appl=
ication.
> > >
> > > These new hooks are able to override default kernel-side CAP_BPF-base=
d (and
> > > sometimes CAP_NET_ADMIN-based) permission checks. It is now possible =
to
> > > implement LSM policies that could granularly enforce more restriction=
s on
> > > a per-BPF map basis (beyond checking coarse CAP_BPF/CAP_NET_ADMIN
> > > capabilities), but also, importantly, allow to *bypass kernel-side
> > > enforcement* of CAP_BPF/CAP_NET_ADMIN checks for trusted applications=
 and use
> > > cases.
> >
> > One of the hallmarks of the LSM has always been that it is
> > non-authoritative: it cannot unilaterally grant access, it can only
> > restrict what would have been otherwise permitted on a traditional
> > Linux system.  Put another way, a LSM should not undermine the Linux
> > discretionary access controls, e.g. capabilities.
> >
> > If there is a problem with the eBPF capability-based access controls,
> > that problem needs to be addressed in how the core eBPF code
> > implements its capability checks, not by modifying the LSM mechanism
> > to bypass these checks.
>
> I think semantics matter here. I wouldn't view this as _bypassing_
> capability enforcement: it's just more fine-grained access control.
>
> For example, in many places we have things like:
>
>         if (!some_check(...) && !capable(...))
>                 return -EPERM;
>
> I would expect this is a similar logic. An operation can succeed if the
> access control requirement is met. The mismatch we have through-out the
> kernel is that capability checks aren't strictly done by LSM hooks. And
> this series conceptually, I think, doesn't violate that -- it's changing
> the logic of the capability checks, not the LSM (i.e. there no LSM hooks
> yet here).

Patch 04/08 creates a new LSM hook, security_bpf_map_create(), which
when it returns a positive value "bypasses kernel checks".  The patch
isn't based on either Linus' tree or the LSM tree, I'm guessing it is
based on a eBPF tree, so I can't say with 100% certainty that it is
bypassing a capability check, but the description claims that to be
the case.

Regardless of how you want to spin this, I'm not supportive of a LSM
hook which allows a LSM to bypass a capability check.  A LSM hook can
be used to provide additional access control restrictions beyond a
capability check, but a LSM hook should never be allowed to overrule
an access denial due to a capability check.

> The reason CAP_BPF was created was because there was nothing else that
> would be fine-grained enough at the time.

The LSM layer predates CAP_BPF, and one could make a very solid
argument that one of the reasons LSMs exist is to provide
supplementary controls due to capability-based access controls being a
poor fit for many modern use cases.

--
paul-moore.com
