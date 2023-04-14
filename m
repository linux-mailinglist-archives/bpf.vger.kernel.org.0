Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1C16E1B91
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 07:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDNFR6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 01:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjDNFR4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 01:17:56 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AF0B4
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 22:17:56 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id m14so267107ybk.4
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 22:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681449475; x=1684041475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFaDsUCTOilRuri/l8EHwJ0PZ3zqOn2It+nizalWSqg=;
        b=U3GX+piPgdnDRiSs1t9vAEqUBKD8qvLvzfREKVN+eMlPX+XI1I/de+vzD3/KmpiF2E
         QtdSH/pw/smebFOckeFk6Dlh0eOnELwsmjN5Es5/QZyoH7ha+yLa5pJ+1vjuJcjfa9L1
         zxjoEU0LLu/pTiw8ShO9ymV0H5dOYxdc8Pvfp9nebvDJGw/bikqTkyHA4/z5oS8/w/ss
         6j3wMeHWM/D7kpFqz1cUdrkxrbQ2a5NH8zyWLPi6Swa2FnvQwFa0undfuQBqhZv41ZuN
         M2yM9U5GO8AAa9LU7NApYk8G9cl079cxyQp1c9NeKufGhrJdiMjWsW/ZgzAIcorgVg11
         JbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681449475; x=1684041475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFaDsUCTOilRuri/l8EHwJ0PZ3zqOn2It+nizalWSqg=;
        b=QKofAiVEd0TsNArKWmW6fknFFfxzSOOMKB5R7BK41CbRBtKj5023gZenKQt7rfgsZb
         EP2tnuHNrzkGrWFUY50TLPDgusYprVcfOcM2SsyY2wLdknBXsLiJYwQMDxa8fZ83pJGJ
         QE07Xe6SuSMWktvpVZew18dBWwKxcBDUGV2b/oRn/RqHsW6prBm7omcxt7x5CdHo4mHP
         QbIs+njFZtNzLSpeufyKQeZJCvc/frRqlQwZZaI9QtCrvZ7war+MLfm6EYN2H54fgGXW
         +bITADoTU/NeuSSAARk0fcG8zdendJLYag3n/4p7NYljJO1+yYZTJ8jgpJowFJMr7sQJ
         OJOg==
X-Gm-Message-State: AAQBX9eYX20dHe9/Be+m1cTEohTRX7jY4wRGNYsPcM/XfctlFBjlftWR
        1R5+dnSbb3JbgM1scc8FGIzrUmrWDUhnMagXAKQ=
X-Google-Smtp-Source: AKy350ZwgbOan8ubr+NYA59pABbD5ZKm6guGizc4wTs+KO//ptS7RbCvfi/nY88PteFJWa0lUXG2r1HsDLcqSOdh+oY=
X-Received: by 2002:a25:dad2:0:b0:b8f:4696:8fa1 with SMTP id
 n201-20020a25dad2000000b00b8f46968fa1mr3077536ybf.10.1681449475230; Thu, 13
 Apr 2023 22:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230409033431.3992432-1-joannelkoong@gmail.com>
 <20230409033431.3992432-4-joannelkoong@gmail.com> <CAEf4BzbHcBLi9ru2rgL59HNGCjYP+zksbjvzmkirYevWu8jM-A@mail.gmail.com>
In-Reply-To: <CAEf4BzbHcBLi9ru2rgL59HNGCjYP+zksbjvzmkirYevWu8jM-A@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 13 Apr 2023 22:17:44 -0700
Message-ID: <CAJnrk1YLUpmXwrS__Rn1WcwiHgpfwEC5H-cUja3wnOKJQYm03w@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/5] bpf: Add bpf_dynptr_get_size and bpf_dynptr_get_offset
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
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

On Wed, Apr 12, 2023 at 2:52=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Apr 8, 2023 at 8:34=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
> >
> > bpf_dynptr_get_size returns the number of useable bytes in a dynptr and
> > bpf_dynptr_get_offset returns the current offset into the dynptr.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/bpf.h      |  2 +-
> >  kernel/bpf/helpers.c     | 24 +++++++++++++++++++++---
> >  kernel/trace/bpf_trace.c |  4 ++--
> >  3 files changed, 24 insertions(+), 6 deletions(-)
> >
>
> [...]
>
> > +__bpf_kfunc __u32 bpf_dynptr_get_size(const struct bpf_dynptr_kern *pt=
r)
> > +{
> > +       if (!ptr->data)
> > +               return -EINVAL;
> > +
> > +       return __bpf_dynptr_get_size(ptr);
> > +}
> > +
> > +__bpf_kfunc __u32 bpf_dynptr_get_offset(const struct bpf_dynptr_kern *=
ptr)
>
> I think get_offset is actually not essential and it's hard to think
> about the case where this is going to be really necessary. Let's keep
> only get_size for now?
>

Sounds good, I will remove this from v2 (i'll try to send v2 out next
week). Thanks for reviewing this patchset!

>
> > +{
> > +       if (!ptr->data)
> > +               return -EINVAL;
> > +
> > +       return ptr->offset;
> > +}
> > +
>
> [...]
