Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38339567D00
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 06:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiGFEQm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 00:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiGFEQl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 00:16:41 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201181F2CD
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 21:16:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u15so478520ejx.9
        for <bpf@vger.kernel.org>; Tue, 05 Jul 2022 21:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j2CNyCIU5yme4GGXCgTLOI0l2q+FMIMk4Hk6zq9SaXw=;
        b=BZrapYSDq+uJbzIjK6a4nzrgG/TieXXtHmcWwPykdVqGAwGSFN7RvwJgHBZOiEkoVS
         fCiIhvr6U6jyBRWNL60TJABKXPE3cGd+1p3uBirOx6oTN3yVIx0PU7MukQbpi2m4OPum
         H6TRT/m++oXYq8aPaU/+nYgbCxvWFr63ta2TN8rxOFDUaP3dAkfxio4dv7Y8rrCHt5Ca
         no6HHTSVry+smHspy5xrb/v527Zj917wj0cm1oWqPOiA7Whx34e5jceVbKfgwbzRDmQo
         TyV+/rh+2VBrUlxqVmkZE5HhpJVxPEmgP095r+vCs5LO2jF1lhP6rYwrQaBGyh3KrRsm
         9g7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j2CNyCIU5yme4GGXCgTLOI0l2q+FMIMk4Hk6zq9SaXw=;
        b=XgoM2m5+//Do8eu+NvPl3uclaT3dFGbv1qJaDNJxCRh5h+6vx+n3SfXnRHJzMdtw5M
         opGGbFZ7UfX4eYoclaCAA8DP0Yfnw+eWLgUnNh6JUy+9zoHooYBM1heqHoEuILCbYVrG
         tAMEswJp2Kc1/6mZImGZ58MDonihJp1AUH01OpRGmjLGbrMqsqlkFusU7j7HIjETzBO7
         F0vOxqFPuENOWcJ5RR9N+fluu1XUKdcCxc/mPMc9nd1H2yAqcOgsd//xj6ICqt04pxYK
         25InHNOJsDnhhRZAW7Woxtxqi0yHvzrBikucYVZBgZU/74cUWF3uvkFU5cX+iYRS/VQC
         nfuA==
X-Gm-Message-State: AJIora8sX+jnCGnPKv6pC7xmraxeT7hRnYsKK9BxZtkbMeimwJ1BgB48
        DqCVDn+hd3j2o061HDkiWt+YV9uWPCVZPZ2ZKAw=
X-Google-Smtp-Source: AGRyM1tUzZtLJ2VqPzhWzC85Y7FMhi4+o8swVN7ll7WPBh1DDW5z2k3xr5WaASXZ9bXpUw+0x2hVN8NgqX1O1BpZGvQ=
X-Received: by 2002:a17:906:6a11:b0:726:97b8:51e9 with SMTP id
 qw17-20020a1709066a1100b0072697b851e9mr38122639ejc.115.1657080998622; Tue, 05
 Jul 2022 21:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220628160127.607834-1-deso@posteo.net> <20220705210700.fpyw4msqy7tkiuub@muellerd-fedora-MJ0AC3F3>
In-Reply-To: <20220705210700.fpyw4msqy7tkiuub@muellerd-fedora-MJ0AC3F3>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 5 Jul 2022 21:16:27 -0700
Message-ID: <CAEf4Bzb=2QnL_oUYTLZ9T_poDGcQ0_WB_ZJs8LQNuC3Dp0Qfng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 00/10] Introduce type match support
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>
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

On Tue, Jul 5, 2022 at 2:07 PM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> On Tue, Jun 28, 2022 at 04:01:17PM +0000, Daniel M=C3=BCller wrote:
> > This patch set proposes the addition of a new way for performing type q=
ueries to
> > BPF. It introduces the "type matches" relation, similar to what is alre=
ady
> > present with "type exists" (in the form of bpf_core_type_exists).
> >
> > "type exists" performs fairly superficial checking, mostly concerned wi=
th
> > whether a type exists in the kernel and is of the same kind (enum/struc=
t/...).
> > Notably, compatibility checks for members of composite types is lacking=
.
> >
> > The newly introduced "type matches" (bpf_core_type_matches) fills this =
gap in
> > that it performs stricter checks: compatibility of members and existenc=
e of
> > similarly named enum variants is checked as well. E.g., given these def=
initions:
> >
> >       struct task_struct___og { int pid; int tgid; };
> >
> >       struct task_struct___foo { int foo; }
> >
> > 'task_struct___og' would "match" the kernel type 'task_struct', because=
 the
> > members match up, while 'task_struct___foo' would not match, because th=
e
> > kernel's 'task_struct' has no member named 'foo'.
> >
> > More precisely, the "type match" relation is defined as follows (copied=
 from
> > source):
> > - modifiers and typedefs are stripped (and, hence, effectively ignored)
> > - generally speaking types need to be of same kind (struct vs. struct, =
union
> >   vs. union, etc.)
> >   - exceptions are struct/union behind a pointer which could also match=
 a
> >     forward declaration of a struct or union, respectively, and enum vs=
.
> >     enum64 (see below)
> > Then, depending on type:
> > - integers:
> >   - match if size and signedness match
> > - arrays & pointers:
> >   - target types are recursively matched
> > - structs & unions:
> >   - local members need to exist in target with the same name
> >   - for each member we recursively check match unless it is already beh=
ind a
> >     pointer, in which case we only check matching names and compatible =
kind
> > - enums:
> >   - local variants have to have a match in target by symbolic name (but=
 not
> >     numeric value)
> >   - size has to match (but enum may match enum64 and vice versa)
> > - function pointers:
> >   - number and position of arguments in local type has to match target
> >   - for each argument and the return value we recursively check match
> >
> > Enabling this feature requires a new relocation to be made known to the
> > compiler. This is being taken care of for LLVM as part of
> > https://reviews.llvm.org/D126838.
>
> To give an update here, LLVM changes have been merged and, to the best of=
 my
> knowledge, are being used by BPF CI (tests that failed earlier are now pa=
ssing).
>

I did a few small changes and combined patches 4-6 together (because
they add the same functionality to both libbpf and kernel
simultaneously, there were compilation warnings about non-static
functions not having a proper prototype defined). But I've split out
the bpf_core_type_matches() macro in bpf_core_read.h into a separate
patch. I also dropped patch #3 as it wasn't needed anymore.

Please see comments I left for two further follow ups.

> Thanks,
> Daniel
>
> [...]
