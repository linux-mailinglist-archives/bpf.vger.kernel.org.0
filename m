Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04956D107E
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 23:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjC3VFm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 17:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjC3VFl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 17:05:41 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3295AD51E
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 14:05:40 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i5so81952368eda.0
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 14:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680210338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRM7i+zuBG70GjHM4+VVi/mvC+BB62bOQ1P0caN6Rkk=;
        b=EljU7tgr+ROXV7EYyXXcRiuTzBdPQSijQQauGW6VSvndigUihEPa1UDK8gXMVFDzke
         moOgA1M4ATCy6pQQLvu/WfNMG2yaOEQvqlH/zr1R7+Hc4KPblB9ImQsSGWXkLZOaeiVA
         MFxPXTwgFG92vfPHtaM/ECXD38wJZSo3So5BBwA9ltJdwO6APqlOIOb7S7/uh0/DXWUk
         hOgDvz/nWkDie7GmHdy3Rt+hHOS3reIkGl3Y496EEKpFnY44DzpVIX66rAgQEKa0LvDE
         JrVjZrmPzXp85ZoRRPQrw+B+5EeeWfELaGgEe+jelODlgAoWWI4l++r6LSXhwM8viT2E
         Ji8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680210338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRM7i+zuBG70GjHM4+VVi/mvC+BB62bOQ1P0caN6Rkk=;
        b=ZtWRgq53BK4ZwxJQ3w4+a/8eB6ZNconOqcXEL+OcuF/5EF/Dy5/y9zMjPWdbENDmTC
         7hA2dKH2ui28/L+PxGYJJmsjFabGklquhDUoxaj5B+6SWWsrlOM6qGYIEw9eT31F8nQN
         NsK+0IfaHfnfIneX0gpvNdKGaGJ1RNLyDfbSL9kLAoLKtBV+Hh3rM6COuWbn4JIM0q70
         j4vjV8xrMc0ldSU9q/vX/dp4syV54sMzopMX9CkaVQ4tXBN1URghFqR3Nzjp2YApUgjo
         kRmd+Lc9OtuCNIuTCyv8G/RIAS4HZdr7th52tZqVD4i6vWyGn9jI3+/pUrvMNYjdukTo
         mBrg==
X-Gm-Message-State: AAQBX9eiRAQEbzoYWoThJ0Bogghi1m3jLv5bNUNoNSOz35QjNfsdak7s
        d2UlMo80Ni4MWkpnxj8dWs5ph7egD5jhQaAwqzg=
X-Google-Smtp-Source: AKy350YQo6QQFc7KoBm7QjlVEc7DNv7ulikaWUW/sAzkyIUODI63reEnOGJom2rWv+bHe4GilmQEhXY0burNa1LUbWE=
X-Received: by 2002:a17:907:8688:b0:931:c1a:b526 with SMTP id
 qa8-20020a170907868800b009310c1ab526mr12631200ejc.5.1680210338481; Thu, 30
 Mar 2023 14:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230328235610.3159943-1-andrii@kernel.org> <20230328235610.3159943-5-andrii@kernel.org>
 <CAN+4W8h4QwvVcKkfTGOKAug2wnbZi5t5GyXXK0VWoobrNo1jpA@mail.gmail.com>
In-Reply-To: <CAN+4W8h4QwvVcKkfTGOKAug2wnbZi5t5GyXXK0VWoobrNo1jpA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 30 Mar 2023 14:05:26 -0700
Message-ID: <CAEf4BzbH7tB+zaK=DJtpR+SXqhNqwYMwiru9xpuAhGpaaFrJsg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/6] libbpf: don't enforce verifier log levels
 on libbpf side
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        timo@incline.eu, robin.goegge@isovalent.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 30, 2023 at 10:13=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> w=
rote:
>
> On Wed, Mar 29, 2023 at 12:56=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> > This basically prevents any forward compatibility. And we either way
> > just return -EINVAL, which would otherwise be returned from bpf()
> > syscall anyways.
>
> In your cover letter you make the argument that applications can opt
> out of the behaviour, but I think shows that this isn't entirely true.
> Apps linking old libbpf won't be able to fix their breakage without
> updating libbpf. This is especially annoying when you have to support
> multiple old versions where doing this isn't straightforward.
>

Ok, technically, you are correct. If you somehow managed to get a
bleeding edge kernel, but outdated libbpf, you won't be able to
specify log_level =3D 8. This is not the only place where too old libbpf
would limit you from using bleeding edge kernel features, though, and
we have to live with that (though try our best to avoid such
dependencies, of course).

But in practice you get the freshest libbpf way before your kernel
becomes the freshest one, so I don't think this is a big deal in
practice.

> Take this as another plea to make this opt in and instead work
> together to make this a default on the lib side. :)

Please, help me understand the arguments against making rotating mode
a default, now that we return -ENOSPC on truncation. In which scenario
this difference matters?

1. If there is no truncation and the user provides a big enough buffer
(which my second patch set makes it even easier to do for libraries),
there is no difference, they get identical log contents and behavior.

2. If there was truncation, in both cases we get -ENOSPC. The contents
will differ. In one case we get the beginning of a long log with no
details about what actually caused the failure (useless in pretty much
any circumstances) versus you get the last N bytes of log, all the way
to actual error and some history leading towards it. Which is what we
used to debug and understand verification issues.

What is the situation where the beginning of the log is preferable? I
had exactly one case where I actually wanted the beginning of the log,
that was when I was debugging some bug in the verifier when
implementing open-coded iterators. This bug was happening early and
causing an infinite loop, so I wanted to see the first few pages of
the output to catch how it all started. But that was a development bug
of a tricky feature, definitely not something we expect for end users
to deal with. And it was literally *once* that I needed this.

Why are we fighting to preserve this much less useful behavior as a
default, if there is no reduction of functionality for end-users?
Library writers have full access to union bpf_attr and can opt-out
easily (though again, why?). Normal end users will never have to ask
for BPF_LOG_FIXED behavior. Maybe some advanced tool-building users
will want BPF_LOG_FIXED (like veristat, for example), but then it's in
their best interest to have fresh enough libbpf anyways.

So instead of "I want X over Y", let's discuss "*why* X is better than Y"?

> Apps linking old libbpf won't be able to fix their breakage without
> updating libbpf. This is especially annoying when you have to support

What sort of breakage would be there to fix?

Also keep in mind that not all use cases use BPF library's high-level
code that does all this fancy log buf manipulations. There are
legitimate cases where tools/applications want direct access to
log_buf, so needing to do extra feature detection to get rotating mode
(but falling back without failing to fixed mode on the old kernel) is
just an unnecessary nuisance.
