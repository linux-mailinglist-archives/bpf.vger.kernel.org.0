Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D41C6C9A5D
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 05:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjC0D56 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 23:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjC0D55 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 23:57:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E2F1999
        for <bpf@vger.kernel.org>; Sun, 26 Mar 2023 20:57:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cn12so30355554edb.4
        for <bpf@vger.kernel.org>; Sun, 26 Mar 2023 20:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679889475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YouoAYFkhuo6a/hfI9MbXH11taJ/UcN+LJZuETjuLWA=;
        b=cCyP7gpwyeWaKN8ujbOsx4Zr3WhtATJdiqaVwdMt9Sid40ZBiX2TJxTdyfAkKkTxGl
         q003E2g3dHI+gYefjyFA0c/U3hd009btqqHSDEYCkgSO5rLzCnO7LH5C6eqJhZGH72oA
         jQGu04ZuJO5R1Ax7pnBb3GT8x21uUMgVpepBmGV8o5/Qn8Zx/dgyXG68gv2b2pgrc29w
         a2SSu5X4RFUVcnsffgNsuj9oXFn9VLiwpmEMISoFUAU0QoAa3HUvjKsP/TKv2GBCPlgh
         44gCDHO71Dfxx/CGM7OexoWSU3yRX0ZqadFh5+jsM0mXuS9GHWfBXz5no2hC8o9FhU1d
         XWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679889475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YouoAYFkhuo6a/hfI9MbXH11taJ/UcN+LJZuETjuLWA=;
        b=kuP1r5vNAV3DQYMaGaSa3SHs8V4ZzLCVlTvHOWAlh4zOkziJaGhTBFP/1wQUaolV8q
         gqMXqotiIQKswH77dllypK4CySyVC4pPxGC4F9IIw3hiu8BWM1ya4jBzfaM476jTSA8U
         O4V/6qvHqInKKS4frath0+jvxPO3CvjTP0hPc9brWZi6rlnOq/jRvbLVgzWde77+2Utn
         6g4f2V94K56TUDbxBTqgv+6InAGrgHurs+SHug99H6RStDQmUKfKTlFp4uXq3GbrJnKB
         0fuFqMt+VHGln3rFK8MDWnhhkW2XG4RZandFC3sFWHonEPei+muAadfuOyIrbtpP90lv
         j4Fw==
X-Gm-Message-State: AAQBX9eURAfn61ET3h+vQRxpJxACUOBgPQ3LWvys4TsSBkU/9XwH0VxT
        Np7uJ665YA+GWhV8WzaMTxmkRqFjmndwL+QJY3s=
X-Google-Smtp-Source: AKy350b/vHcSQQYnY82h1r3N0/S3xBKsJU19JupwWbhnCbOSlNq+eziluHjYPSltLmnivhzuu5m3PSBpccvXTeT9Ro0=
X-Received: by 2002:a50:d6d6:0:b0:4fb:c8e3:1adb with SMTP id
 l22-20020a50d6d6000000b004fbc8e31adbmr4837215edj.3.1679889473522; Sun, 26 Mar
 2023 20:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230325025524.144043-1-eddyz87@gmail.com> <ZB5pFYZGnwNORSN9@google.com>
 <2ac4f6037719e25e3e8b726def6ece2907d785f0.camel@gmail.com>
 <CAKH8qBv9vYZsMFivzJ9s=i_w-RakGqECfwXBZfWnDigi6oP1EQ@mail.gmail.com>
 <CAADnVQL5O4FaDDOUn0q1urfhquek4dE9nrhWa7mVYwvMhi311A@mail.gmail.com> <CAEf4BzbbgLg3w5ySX8XxBHBR0gzr71XPvJ5s1Tw=A6ScA6Vmwg@mail.gmail.com>
In-Reply-To: <CAEf4BzbbgLg3w5ySX8XxBHBR0gzr71XPvJ5s1Tw=A6ScA6Vmwg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 26 Mar 2023 20:57:42 -0700
Message-ID: <CAADnVQJRDfM=iofPZF2QLPzuxYjBQLMmm1dU25xMcEueEfaNoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/43] First set of verifier/*.c migrated to
 inline assembly
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
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

On Sun, Mar 26, 2023 at 8:16=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Mar 25, 2023 at 6:19=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Mar 25, 2023 at 9:16=E2=80=AFAM Stanislav Fomichev <sdf@google.=
com> wrote:
> > >
> > > >
> > > > It was my understanding from the RFC feedback that this "lighter" w=
ay
> > > > is preferable and we already have some tests written like that.
> > > > Don't have a strong opinion on this topic.
> > >
> > > Ack, I'm obviously losing a bunch of context here :-(
> > > I like coalescing better, but if the original suggestion was to use
> > > this lighter way, I'll keep that in mind while reviewing.
> >
> > I still prefer the clean look of the tests, so I've applied this set.
> >
> > But I'm not going to insist that this is the only style developers
> > should use moving forward.
> > Whoever prefers "" style can use it in the future tests.
>
> Great, because I found out in practice that inability to add comments
> to the manually written asm code is a pretty big limitation.

What do you mean by "inability" ?
The comments can be added. See verifier_and.c
        r0 &=3D 0xFFFF1234;                               \
        /* Upper bits are unknown but AND above masks out 1 zero'ing
lower bits */\
        if w0 < 1 goto l0_%=3D;                           \
