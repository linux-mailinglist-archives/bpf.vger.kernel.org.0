Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334B66B2D51
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 20:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjCITD4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 14:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCITDz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 14:03:55 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14CF65BB
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 11:03:52 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x3so11030477edb.10
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 11:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678388631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9dOsDLoN3DQopI5fPgilKZ7oS9CzaCTHXkjH04bdHk=;
        b=Ds/O1NYlWc+YPctWJPakYTVbIemXr+zPQkP1vMC/rNgk0mA2vD95plGyaqW9nRxMCF
         cS0/nz5XJ+GC0kV/Q4p/5GDyt+eX21HSbh/MD4gN0jttHbey73+bzHgBA1jRlw20v70m
         vuNeTq1GWe+gluhTKAD2ZrG8iUJeXwcdCcAZK0f6vGM32wbQ2Pgm+/AZasMQX/vgavp7
         xe6R8C6iS4TS7H0phFRREf0klF3CkyDoFfACPjTHJNlV2Xr5e729D6doxuV4nw/UEBTz
         iW7nav3U0V+SeXsL9pivsqJZFQDbhXW+B9xp46xhCwOydKjLHJVOYrw0R7ywJTMRLwax
         hjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678388631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9dOsDLoN3DQopI5fPgilKZ7oS9CzaCTHXkjH04bdHk=;
        b=sFOTTVXuD3uBasMhhpcn22grmk2PL33VzJgnhhQE23zGDHdZc8LhnmI9QSxNnbwoee
         RzAGrdnV9ldG+aesrFRRHz8EgrRbEPXw7syY9sii025i91SQVBZn7tnlNm7y50YzM5XM
         PYusUY2zl+5Pdw5uHf90KxNfEe5V8BHJYW+xGKJsCIOW7ip+ydNX7aFaZh/WF3ufIF2Z
         2fl7a6FQZhvGgs59bVjkL+pvc7vS4zujIEKReII7PEaWNiw4+WqGtcFNce0nycCEsSsG
         CyQhsleGlBdA8uGMu4Vmw8IdpisamMFhEksV0BrkONEcbw6/JTSSyAadu4CPnfaL5nTz
         pZCg==
X-Gm-Message-State: AO0yUKVAZjaNQCKCx5ONHaNYppAZhVWWjENFGt5bmKy35SyUQvYbGAHM
        tvNoQHbPtLJJb7p0nkIBIvq3uDdb5nYY02hvJYs=
X-Google-Smtp-Source: AK7set+n8ut09UPlmIymbeEjcBLOLebp3KXd8eLSZJbMTyiV9yTHFPYDH/tbO6MSC3c1XMEOT++s45qwZ1GaPbotxMA=
X-Received: by 2002:a17:906:48c9:b0:908:5055:9fed with SMTP id
 d9-20020a17090648c900b0090850559fedmr11905050ejt.5.1678388631385; Thu, 09 Mar
 2023 11:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20230309004836.2808610-1-jesussanp@google.com>
 <167832601863.28104.18004021177531379064.git-patchwork-notify@kernel.org>
 <CAK4Nh0gOSHfwb8Yuv_YAhKHH+gTr=rqt+ZnQi1yXQ7qLiqu21w@mail.gmail.com>
 <CAEf4BzbggD36JS4Z1dukPBqpTBapO-ptbfa3Qc8m9j5j-7ue=A@mail.gmail.com>
 <CAK4Nh0hjip7U4_oMYbCn1mx2j4n_y4FT67yMUDMY1ffu6RtOew@mail.gmail.com> <4afc9786-be46-8b7f-3e71-f457d6111c22@iogearbox.net>
In-Reply-To: <4afc9786-be46-8b7f-3e71-f457d6111c22@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 9 Mar 2023 11:03:39 -0800
Message-ID: <CAEf4BzaWYT08cUbHCm-K-Z5mBhuZX32wRJnE_PY9WbeOu3vrjg@mail.gmail.com>
Subject: Re: [PATCH] Revert "libbpf: Poison strlcpy()"
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jesus Sanchez-Palencia <jesussanp@google.com>, andrii@kernel.org,
        bpf@vger.kernel.org, sdf@google.com, rongtao@cestc.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 9, 2023 at 10:50=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 3/9/23 6:31 PM, Jesus Sanchez-Palencia wrote:
> > On Thu, Mar 9, 2023 at 9:27=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >> On Thu, Mar 9, 2023 at 8:06=E2=80=AFAM Jesus Sanchez-Palencia
> >> <jesussanp@google.com> wrote:
> >>> On Wed, Mar 8, 2023 at 5:40=E2=80=AFPM <patchwork-bot+netdevbpf@kerne=
l.org> wrote:
> >>>>
> >>>> Hello:
> >>>>
> >>>> This patch was applied to bpf/bpf-next.git (master)
> >>>> by Andrii Nakryiko <andrii@kernel.org>:
> >>>
> >>> Andrii, are you planning to send this patch to 6.3-rc* since the buil=
d
> >>> is broken there?
> >>> Just double-checking since it was applied to bpf-next.
> >>
> >> I didn't intend to, feel free to do that.
> >
> > Oh I always thought that fixes for the rc-* iterations had to come
> > from the maintainer
> > trees. Should I just send it to lkml directly?
> >
> >> But just curious, why are you building libbpf from kernel sources
> >> instead of Github repo? Is it through perf build?
> >
> > Yes, through the perf build. We build it altogether as part of our kern=
el build.
>
> Ok, just moved over to bpf tree in that case where it will land in -rc's.
>

Thanks, Daniel, for taking care of this!

> Thanks,
> Daniel
