Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700884327D2
	for <lists+bpf@lfdr.de>; Mon, 18 Oct 2021 21:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbhJRTnQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Oct 2021 15:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhJRTnQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Oct 2021 15:43:16 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E256C06161C
        for <bpf@vger.kernel.org>; Mon, 18 Oct 2021 12:41:04 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x192so2036945lff.12
        for <bpf@vger.kernel.org>; Mon, 18 Oct 2021 12:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rYHsusTbkwFk7JVuDdYhrxYd3Oez/UvdkWTXcYHAjQg=;
        b=puzIN8gggSDMtRiBbPLKaFTvqQy7PZ8lkaBt48DLOPtDNScgLO0caCDFtegsdUQKjh
         Zc/9C9T+HcnA0SgWMfyVRL5Ow0do6yh926ZWvkvrHFCiJIURdHJtffZVyrlXtKUVxPEL
         CFb9eFu99VyaFY/bIua4CuBGKaeQJd9DYeCQ9wzlGimgK1EBifwsZ4CshgBhoOAqjOme
         WyfGuhjDxSnqdzwsVnrYBnFFxr2SP2/Ywj2aWK9DfxgAcTsIbf6faxSP4UQxnwkMqo0N
         95L5ciwCdpwEX0pPghtf7pHBFRZu12Yw7rmn+RDW6wvQrGNPlTd/rQsHYm5aSXcFWhWr
         tvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rYHsusTbkwFk7JVuDdYhrxYd3Oez/UvdkWTXcYHAjQg=;
        b=MzaY6UgaIFjJbmDv1Vp+FLhx4hwDOJDBPR+4U0Z8lm2iaOMIxJSlH6OBgK+AuYpTCa
         1L+iFn58eIoXve1uImacFG1GsElh4BXTQW44q98fQ46dRKOm5cemDN6jJIxJX17bo3bO
         MTP+BF8Q5OeaLlljI1oM/XDqvMrRYZRB412335nmcuz4kUcJma8XY8d75ChLu21g2qaC
         ojr1s411QcCeZsb9bXj9g2SyoHIS/7JlCxo8U4FlNxWz0jHkXfaLeg3DcZQjQsMh8QP3
         VhTXrhB6oOw9+z8tmVwY3CD2jBNWKjShThagT8BqfkrPYHU3KwJG/9MHSzbOLTmxm/zz
         9Nyg==
X-Gm-Message-State: AOAM531kygakBUYwQk4jb/5b1RKcVR7f7oovIPzcxyYm1ROsDn2tmCJs
        2J1sgtWjBUjjfKhtt2N6SuMkjx8aNV3YnfLiqRy+RQ==
X-Google-Smtp-Source: ABdhPJyhMahraNf2vp8DJ4sc/jlu5fnRYt3e62ZjpzrZ9VLuGLfJNm+hpN+x+Ll9+fL0V9xGE9QmZpphGSMSBvkZMUs=
X-Received: by 2002:a05:6512:398f:: with SMTP id j15mr1512665lfu.523.1634586062336;
 Mon, 18 Oct 2021 12:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211018193101.2340261-1-nathan@kernel.org> <CAKwvOdnPotXBRWW4JEEhEYrL1oRv++bQOge8wQCBNbGuA9HYAw@mail.gmail.com>
In-Reply-To: <CAKwvOdnPotXBRWW4JEEhEYrL1oRv++bQOge8wQCBNbGuA9HYAw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 Oct 2021 12:40:51 -0700
Message-ID: <CAKwvOdm5F1LhgyCtJTYYSQMw47FxxE0m+tOnuUgKXwBHEVxS+g@mail.gmail.com>
Subject: Re: [PATCH] nfp: bpf: Fix bitwise vs. logical OR warning
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, oss-drivers@corigine.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 18, 2021 at 12:39 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Oct 18, 2021 at 12:31 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > A new warning in clang points out two places in this driver where
> > boolean expressions are being used with a bitwise OR instead of a
> > logical one:
> >
> > drivers/net/ethernet/netronome/nfp/nfp_asm.c:199:20: error: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
> >         reg->src_lmextn = swreg_lmextn(lreg) | swreg_lmextn(rreg);
> >                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >                                              ||
> > drivers/net/ethernet/netronome/nfp/nfp_asm.c:199:20: note: cast one or both operands to int to silence this warning
> > drivers/net/ethernet/netronome/nfp/nfp_asm.c:280:20: error: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
> >         reg->src_lmextn = swreg_lmextn(lreg) | swreg_lmextn(rreg);
> >                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >                                              ||
> > drivers/net/ethernet/netronome/nfp/nfp_asm.c:280:20: note: cast one or both operands to int to silence this warning
> > 2 errors generated.
> >
> > The motivation for the warning is that logical operations short circuit
> > while bitwise operations do not. In this case, it does not seem like
> > short circuiting is harmful so implement the suggested fix of changing
> > to a logical operation to fix the warning.
>
> I agree. Thanks for the patch.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Perhaps:

Fixes: 995e101ffa71 ("nfp: bpf: encode extended LM pointer operands")

>
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1479
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  drivers/net/ethernet/netronome/nfp/nfp_asm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/netronome/nfp/nfp_asm.c b/drivers/net/ethernet/netronome/nfp/nfp_asm.c
> > index 2643ea5948f4..154399c5453f 100644
> > --- a/drivers/net/ethernet/netronome/nfp/nfp_asm.c
> > +++ b/drivers/net/ethernet/netronome/nfp/nfp_asm.c
> > @@ -196,7 +196,7 @@ int swreg_to_unrestricted(swreg dst, swreg lreg, swreg rreg,
> >         }
> >
> >         reg->dst_lmextn = swreg_lmextn(dst);
> > -       reg->src_lmextn = swreg_lmextn(lreg) | swreg_lmextn(rreg);
> > +       reg->src_lmextn = swreg_lmextn(lreg) || swreg_lmextn(rreg);
> >
> >         return 0;
> >  }
> > @@ -277,7 +277,7 @@ int swreg_to_restricted(swreg dst, swreg lreg, swreg rreg,
> >         }
> >
> >         reg->dst_lmextn = swreg_lmextn(dst);
> > -       reg->src_lmextn = swreg_lmextn(lreg) | swreg_lmextn(rreg);
> > +       reg->src_lmextn = swreg_lmextn(lreg) || swreg_lmextn(rreg);
> >
> >         return 0;
> >  }
> >
> > base-commit: 041c61488236a5a84789083e3d9f0a51139b6edf
> > --
> > 2.33.1.637.gf443b226ca
> >
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
