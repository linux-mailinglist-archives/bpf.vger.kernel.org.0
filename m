Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18586E2724
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 17:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjDNPj2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 11:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjDNPj1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 11:39:27 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F42B9757;
        Fri, 14 Apr 2023 08:39:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id c9so7726161ejz.1;
        Fri, 14 Apr 2023 08:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681486764; x=1684078764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4oSdeV0O3CfUcQDKAuJnCOQ9a2h59RHFM8f+kqUd9Q=;
        b=WwnOvRafipHE4X3XLxIzut9nMsVupoWMB8MTM4qyJi0hryift5RwHS6XT3AIdl472j
         /NxFcZ1Ez1B7YxuxWRGbuogEjMiUIRaJcadv3CgJ0uPgY9F+7p3TIxYbAJbpVi5ekwen
         yeT05SgUeYLCjB3qqmIXZnmVJv4OJccZE5oQqIexcw3vdxVLO155A6nK3QaGkqdKFkde
         QXPyHJyp8mgIg8fAr804g6q8Z4G/Z+2YIshIIdUP6zl4gYyH2Kp45OhqP1rfZxqRFJLA
         pNyTTE7RgSEjND2eEGar2g/sIzOot3PILTeIef6Ju20xSJRedAEc0Dncpal0b/mP//74
         CBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681486764; x=1684078764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4oSdeV0O3CfUcQDKAuJnCOQ9a2h59RHFM8f+kqUd9Q=;
        b=Yisrz9EA1Bjwp6QOzyHjYrWDSLUiesdhikPyK7NfAOli24UJHnrWnFT3Jh4p+hcLe5
         3JV/JY7DMMIqyRAqF2TQX1hJzdkCVDNkmkMt2O0u/UQD6sPlyY9QpqCYY4hiG4SUOC6W
         jLsdM7flDbWP7Alq0O1a/iIocY4VsJNJ1bW4J3pXunsqNMlOj+cz8R54GXFlrGgZAHRO
         hLSpbepbkpI6IHTgy3gLP4ezPWFezgIukjc368iKkdbLHsFcAVW/wozJsm0j2eu76Rzd
         sIoTSA7PE7N7cCNZbdlXjlRIOPhuqvc6TUdKxeB3SeocYPU2z5IKGZh2wZlgQl+XWhQH
         i5JQ==
X-Gm-Message-State: AAQBX9fnSJXBckMlgDzz2yKKfIrtxuJgocv0GIsm1lXtp7jCdOosgssh
        oFMbGNFZe7yox96c1gTZmVLC7YahBlRJvFwT6zF1pBVr
X-Google-Smtp-Source: AKy350YVcccX9d5h7VcopDSWqR5AIJdw1Z/DbP4Trs+e+O66JfWXHVKJzLJO1CKkIMq3Vaja9/jyup83zlGDEnHhzOI=
X-Received: by 2002:a17:907:968c:b0:94a:87d6:d39a with SMTP id
 hd12-20020a170907968c00b0094a87d6d39amr3399204ejc.3.1681486764205; Fri, 14
 Apr 2023 08:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <ZDWAcN6wfeXzipHz@gofer.mess.org> <CAADnVQJ-zzzTxDj8_7WKW-o3BDsU=DNAnvSEZGNHswbhGA8xhA@mail.gmail.com>
 <ZDe9ND/M4I9ll1xV@gofer.mess.org> <CAADnVQLOmDEQsHX4XfgETXUte9mJ+-qphR_E7dcjXB2PMDaZnA@mail.gmail.com>
 <ZDkx6WAWmwHpBJ6m@gofer.mess.org>
In-Reply-To: <ZDkx6WAWmwHpBJ6m@gofer.mess.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 14 Apr 2023 08:39:13 -0700
Message-ID: <CAADnVQJnw1Jdu+oD5_+ci+RxoaZCDwjgHZQo16bSgmnr2DDCOQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: lirc program type should not require SYS_CAP_ADMIN
To:     Sean Young <sean@mess.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 14, 2023 at 3:58=E2=80=AFAM Sean Young <sean@mess.org> wrote:
>
> On Thu, Apr 13, 2023 at 04:54:21PM -0700, Alexei Starovoitov wrote:
> > On Thu, Apr 13, 2023 at 1:28=E2=80=AFAM Sean Young <sean@mess.org> wrot=
e:
> > >
> > > On Wed, Apr 12, 2023 at 04:14:05PM -0700, Alexei Starovoitov wrote:
> > > > On Tue, Apr 11, 2023 at 8:45=E2=80=AFAM Sean Young <sean@mess.org> =
wrote:
> > > > >
> > > > > Make it possible to load lirc program type with just CAP_BPF.
> > > >
> > > > Is it safe?
> > > > If the user can load with just CAP_BPF the FD to the prog and targe=
t_fd
> > > > will allow attach as well.
> > >
> > > Exactly, that's the $1m question of course.
> > >
> > > I think it's safe from a lirc perspective because you need to be able=
 to
> > > open the /dev/lirc0 device in the first place; if you can open it, yo=
u
> > > alter all sorts of lirc receiving options already. Changing the IR pr=
otocol
> > > decoder is no different in that perspective.
> > >
> > > The other side of course, is it save to load a bpf lirc program as a =
normal
> > > user. I don't see any issue with this; I guess this depends on whethe=
r the
> > > subset of functions in lirc_mode2_func_proto() is safe. I am hoping t=
hat
> > > the expert opinion everyone here can help answer that question.
> >
> > That part is fine under CAP_BPF.
> > I don't know how lirc devices are typically setup.
> > If they need root to open them
> > then why bother relaxing bpf loading part?
>
> I'd like to get a point where /dev/lircN can have the same permissions as
> for example /dev/videoN devices: group read/write, so that local users
> don't have to become root to use them.
>
> Without relaxing the bpf side, this seems like a chicken and egg problem
> (tiktaalik and egg?).
>
> Also - the CAP_NET_ADMIN requirement seems completely arbitrary compared
> to other program types.

Yeah. Agree. Could you respin with all these additional details
explaining the motivation and driver permission model?
