Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D026C36CC
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 17:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCUQSr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 12:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCUQSp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 12:18:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3199B28210
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 09:18:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o12so61840235edb.9
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 09:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679415511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khNIfENbteVGLJJjWu/xPkxZ6uEH+lc1gM8NYo8//Xo=;
        b=W7+WIFG1b1nQ1n54HhAIBQER8/13zvfrmnl9w3VlKtZrQxI9kUCIfLZf0J+DkCIdTJ
         rFJeP592pT1NrQQsR+TwBdMof2S60YjhA4lMyvYRKj0NO91kzgaxoivKSfBEE5OZu741
         HW1NLvBe0Tj232ITgscnAlkIEMa1ALO/JyB27m4Zh1Ot/g9EAhGgKsjiOC40Mm4mK3OS
         ybEAeHkffRtiS2VtB2V/Br33TqVCUQIzzxmXsFhCGj7RLs3PGO6ocGFMGHyKdXq7hFrL
         W3v24Fa0lMjLpHhAADeW+pxe+wv2xdO4chNJqvRI5Fm6bt2z7jrR45Xtkhv01MxvoDCR
         25hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679415511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khNIfENbteVGLJJjWu/xPkxZ6uEH+lc1gM8NYo8//Xo=;
        b=7ijRlGkA2MoUND3I5rtC2NeoSLIfrdqoH5wqxpEmOGFJUaaKIGKQcgdXFVxmhLB7yS
         wZmKh3HeZhKzgjPaEHvzvi4KGpLFdgNSmEInMI1+8Z73RoGMpJbv3m3x/Vo2jUwWkOq1
         0rZeKUz1ora/1htgni2oYadOHAXgO4TNl0dP2OLkd6FRTlLGaU6N48xAB3pGLcWnfyjo
         r+eLlL8WGDIcEzdBfIZ714ETa62vD27bvST7qThCRXL8ZuDJyzYAfNwJM5dID8wVQ/if
         9OpwYJ0+M6M/iXguWhaa2l5rCD+uHuemlDlCFqJ9S2mM1IV41iXN2vztH2s8HgrllOaR
         JDuQ==
X-Gm-Message-State: AO0yUKVoVEY9gja/kjJKVbHguIABx6PbAkPBapaM8rN9nxrgrFDVqe09
        YuNiAF0+mJm3OE7cwrgGDs7ba52ttuakK4PmE0+ZfxNrThBuxZiAHH+rKA==
X-Google-Smtp-Source: AK7set990/WpC1widWi2hq/lTgBYXpz7gY7FxIgo7g1PXk1VUKFBF1lqJy0CdKGcoDeuFbSg2YVOixyVHu5t4mRF/oc=
X-Received: by 2002:a17:906:7f8f:b0:932:4d97:a370 with SMTP id
 f15-20020a1709067f8f00b009324d97a370mr1546941ejr.14.1679415511684; Tue, 21
 Mar 2023 09:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230317220351.2970665-1-andrii@kernel.org> <20230317220351.2970665-4-andrii@kernel.org>
 <bb0b7006-9a22-df8e-f623-d8a9d3069fc1@iogearbox.net> <CAEf4BzYM8Z1gp4x+tRLE2BFFi9idmuRiTSrHB7cGFA94E2hLmw@mail.gmail.com>
 <CAN+4W8j4Xi2zNx-0QgkRDgyzLFCP+-TqX3NzD=_nuJrD44TK0A@mail.gmail.com> <CAEf4BzYR4snO+-ntszFj-2kitAzJVi2j+O4+-KOa38g=0YS7cQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYR4snO+-ntszFj-2kitAzJVi2j+O4+-KOa38g=0YS7cQ@mail.gmail.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 21 Mar 2023 16:18:20 +0000
Message-ID: <CAN+4W8iNoEbQzQVbB_o1W0MWBDV4xCJAq7K3f6psVE-kkCfMqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: switch BPF verifier log to be a
 rotating log by default
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@kernel.org, kernel-team@meta.com,
        timo@incline.eu, alessandro.d@gmail.com,
        Dave Tucker <dave@dtucker.co.uk>,
        =?UTF-8?B?Um9iaW4gR8O2Z2dl?= <robin.goegge@isovalent.com>
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

On Mon, Mar 20, 2023 at 6:55=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Great feedback. Let me address all of it in one place.
>
> Let's start with right-sizing the buffer. Curiously, with existing
> (fixed) log behavior, verifier doesn't and can't know the full size of
> the buffer it needs, as we stop producing log after -ENOSPC condition
> was detected. log->ubuf is set to NULL, after which
> bpf_verifier_log_needed() will start returning false. So in existing
> "logging mode" it's impossible to support this without major changes.

I think that's fine, as long as we keep the door open to later on
extending the log_buf_max_size to append mode.

> On the other hand, with rotating log, we could determine this very
> easily! We can just maintain max(log->end_pos, last_max_end_pos)
> throughout the verification process (we need max due to log reset: it
> still might need bigger buffer than final log length).

Ah, tricky! Nitty gritty detail: can I get the max required size with
log_level > 0 but log_buf =3D=3D NULL / log_size =3D=3D 0?

> So, to get the full size, we need rotating log behavior.
>
> What if we just make rotating log still return -ENOSPC, and set this
> new "log_buf_max_size" field to actual required full size. That will
> keep existing retry/resize logic intact and would be backwards
> compatible, right?

There is a subtlety here: with this design it's impossible to load a
program with a rotating log and a buffer that is smaller than
log_buf_max_size. A contrived use case: for each program we load we'd
like to get the verifier stats printed as one of the last lines.
Without ENOSPC this can be done by allocating a buffer of 512 bytes or
something.

Tying errno to log buffer size is wrong imo, so it'd be nice if we
could fix the interface going forward.

> As for feature detecting this change. Yes, there is no UAPI change
> (unless we add extra field, of course), but as I implemented it right
> now it's trivial to detect the change in behavior: set small buffer
> (few bytes), try load trivial program. If you get -EINVAL, then we
> have old kernel that enforces >=3D128 bytes for buffer. If you specify a
> bit bigger buffer, you should get -ENOSPC. If you get success, it's
> the new behavior.

I think a better test would actually be to pass the new BPF_LOG flag
and check for EINVAL. Relying on buffer sizes is maybe a bit too
indirect?

> What I'm worried with switching this to opt-in
> (BPF_LOG_TRUNCATE_HEAD), is that for various application that would
> want to use log_level 1/2 for some diagnostics in runtime, *they*
> would need to perform this feature detection just to know that it's
> safe to provide BPF_LOG_TRUNCATE_HEAD.

Can you sketch this out a bit more, what kind of diagnostics do you
have in mind? If the application wants to parse the log it kind of
needs to know anyways? Going back to my "get verifier stats from prog
load" example above, if the rotating log isn't available I need to
either

- skip getting verifier stats
- allocate a possibly large buffer to get at it in append mode

That choice isn't one I can make as a library author.

> So I decided that it's better
> use experience to do opt-out. Just to explain my reasoning, I wanted
> to make users not care about this and just get useful log back.

Ah, this is probably where our disconnect is. In my mind, detecting
and passing BPF_LOG_TRUNCATE_HEAD is definitely the responsibility of
the library, not the users. At least for the happy / common path.
Rough sketch of how PROG_LOAD and log_buf is handled in Go (probably
similar to libbpf?)

    if PROG_LOAD(user supplied log_level) < 0 && user supplied log_level =
=3D=3D 0:
        retry PROG_LOAD(log_level=3D1)

There is some trickery when the user passes a log_level !=3D 0, but most
PROG_LOAD go through this logic. The way I'd go about it is to add
TRUNCATE_HEAD to the retry PROG_LOAD call if the feature exists. As a
result, most failed program loads would get the benefit of this
feature.

If a user explicitly requests a log I assume they know what they are
doing and it's probably best not to mess with it. To play the devil's
advocate, I think that making this behaviour opt out does break
expectations that user space has. See [0] for example which will have
to detect that rotating mode is used and deliberately disable that. We
can of course argue whether parsing the log is a wise thing to do, but
it's good to keep that fact in mind.

> Heh, it actually does automatically as it uses bpf_verifier_log struct
> as well. So all the BPF_PROG_LOAD changes for log apply to BPF_BTF_LOG
> command.

Nice :)

Best
Lorenz

0: https://github.com/cilium/coverbee
