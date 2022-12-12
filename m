Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458BC64A58C
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 18:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiLLRHm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 12:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiLLRHj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 12:07:39 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1C5BA9;
        Mon, 12 Dec 2022 09:07:38 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m19so13804798edj.8;
        Mon, 12 Dec 2022 09:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=psD3YLyCZjcYOQSRda/Wzy3cfaWkoGXg3yfR5HnyZlU=;
        b=GG0ecsu3NkSEPBlpXL3y/2dvE8SxGBIMsMDwxMRotRyXQ0mGD2Eyk1hoyI2BuYVaS8
         9RZeFf3Nt/RySOlPku2E9MbEzMruDbfosFbilPnOxDMQSw7x5UG0W2Run4wJRdpmyofM
         5JJYOoeezBRE0KESUjS7ExwA97MDofhlc+GQCeLzMjpe6En8R5EN7EEsUseUM5B3/5kO
         w+yRrtruGfpSbADomAqp8zlTLEuUlfGhrg8fPul1TRaT3cqREzF2KFHQpv06hMPDK9df
         dWbaRgrKUPSQsZfwGgrvhLC1ERYYRkO82IR7bTSVDdCTDKOtb81CuvFjZrV9tBajrV/v
         EdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psD3YLyCZjcYOQSRda/Wzy3cfaWkoGXg3yfR5HnyZlU=;
        b=vz0Vdti1KLflN26o5kAAyfXub3zPmOtMRWKEZmbmaNXu9XVyod5NwHjW+SZBdMey9U
         /PqI8jmuDgpiGwma3TAoF45gzOd0s/Ykyn6uoDVK+RNDL9hQszsGDwpBftJxbUOwSlJe
         JX5lX52h1FIC+jwkmaGvWIMGpZ9kP8scUZBPHxPhKIxChSzYSJrlYuEekF4BNah5ie1K
         eG+EJes2wtNlAT9/DVwnB31H1zrK0HLdjqaVd0Cxj09vpKz/le1kTJa04VrBylcVt5Yd
         gFlYVsKg2rX/mbfDUcINswJpn9Y4mtYZ+bdGBYWfdg4Phh2BvJGSLmcp15mbYpNyZC4u
         hXQQ==
X-Gm-Message-State: ANoB5pnhvJemClcKvgS6vQ1mWCdoMF8oL5I7Tr6qXO253lfFFCsDugla
        mpw5fkI4K2U6HpLFxAn02dB0MHtOyky/SB4YXuld39vI
X-Google-Smtp-Source: AA0mqf6Xaid5ZmvTcskXpzYGc+gIRzp7/WRUmWe2TbFfxyi+v3Q+kNCF2GiPsJsKC7Xgyy6USfDUPqScGV8BZrIoCro=
X-Received: by 2002:a05:6402:e9f:b0:46f:efbb:91d9 with SMTP id
 h31-20020a0564020e9f00b0046fefbb91d9mr374811eda.94.1670864857266; Mon, 12 Dec
 2022 09:07:37 -0800 (PST)
MIME-Version: 1.0
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <21be7356-8710-408a-94e3-1a0d3f5f842e@www.fastmail.com> <CAEf4BzawXPiXY3mNabi0ggyTS9wtg6mh8x97=fYGhuGj4=2hnw@mail.gmail.com>
 <a9367491-5ac3-385b-d0d6-820772ebd395@huaweicloud.com> <CAEf4BzZJDRNyafMEjy-1RX9cUmpcvZzYd9YBf9Q3uv_vVsiLCw@mail.gmail.com>
 <5abb0b0090fd0bce77dca0a6b9036de121b65cf5.camel@huaweicloud.com> <20f55084c341093d18d2bc462e49123c7f03cc8e.camel@huaweicloud.com>
In-Reply-To: <20f55084c341093d18d2bc462e49123c7f03cc8e.camel@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 12 Dec 2022 09:07:26 -0800
Message-ID: <CAADnVQLU+c+gsZ=V6myG0-GhU3EzZgqjzTPvqvYmCDBjqMoF+Q@mail.gmail.com>
Subject: Re: Closing the BPF map permission loophole
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 8:11 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Mon, 2022-11-07 at 13:11 +0100, Roberto Sassu wrote:
>
> [...]
>
> > > > > P.S. We can extend this to BPF-side BPF_F_RDONLY_PROG |
> > > > > BPF_F_WRONLY_PROG as well, it's just that we'll need to define how
> > > > > user will control that. E.g., FS read-only permission, does it
> > > > > restrict both user-space and BPF-view, or just user-space view? We can
> > > > > certainly extend file_flags to allow users to get BPF-side read-only
> > > > > and user-space-side read-write BPF map FD, for example. Obviously, BPF
> > > > > verifier would need to know about struct bpf_map_view when accepting
> > > > > BPF map FD in ldimm64 and such.
> > > >
> > > > I guess, this patch could be used:
> > > >
> > > > https://lore.kernel.org/bpf/20220926154430.1552800-3-roberto.sassu@huaweicloud.com/
> > > >
> > > > When passing a fd to an eBPF program, the permissions of the user space
> > > > side cannot exceed those defined from eBPF program side.
> > >
> > > Don't know, maybe. But I can see how BPF-side can be declared r/w for
> > > BPF programs, while user-space should be restricted to read-only. I'm
> > > a bit hesitant to artificially couple both together.
> >
> > Ok. At least what I would do is to forbid write, if you provide a read-
> > only fd.
>
> Ok, we didn't do too much progress for a while. I would like to resume
> the discussion.
>
> Can we start from the first point Lorenz mentioned? Given a read-only
> map fd, it is not possible to write to the map. Can we make sure that
> this properly work?
>
> In my opinion, to achieve this particular goal, the map view
> abstraction Andrii suggested, should not be necessary.

What do you 'not necessary' ?
afair the map view abstraction is only one that actually addresses
all the issues.
