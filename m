Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46A458544F
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 19:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbiG2RRi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 13:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238098AbiG2RRh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 13:17:37 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97B581489
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 10:17:36 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id b21so3752100qte.12
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r70+w3al1ROQRPaBuXhJ0H0gDgyn6xF2NDddnTHpRs4=;
        b=LFTPTqnSo04+CdBlyLO7kZ0C8b+w7+bWYN1mbK3ONMZMbJt8dUCb9jeg7gJDfSDkRN
         9qnzuEFFCVHGoT60xc8NeJ1Qy5LJxvNxzFwb8lWVZa8UwpL23X57Qjn6BX4M02aAYbdh
         3G8bYNMSP8iubA6h05BZ5bNhFPKAZGue0J1VzwSNePd1kKvl+nxb3oLsqrXDD6bVKsAl
         IaA+XphwurQgLv9EaG8oJLOCNh07LSZ0TTAJtHnvosmGlSNSuL+ISOZz59IlNRE0Wk13
         Ui/HO9fWb6A7rfzZvlgTKc5FXRsH0m01u5Ct8k0iEFX9dgUVxJET3I728bk8Pm14oHSv
         poVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r70+w3al1ROQRPaBuXhJ0H0gDgyn6xF2NDddnTHpRs4=;
        b=1VIEA0lGlGPgFzw4FpeGpCd0qH1NvQsog+kHaG0ch5luECtM2lGDt5obe1jX1tkdwp
         dgvyEvC6C96y9N2AiiZ86HwDs9bfsg9YtgyljmHCLBUutfHBS4BhZpMjCGgxaYffcm6X
         rAE+hblOAXJUCmvEPaTzJWK5PemIGLJrv8+EW2eHaG7pwQBiZKX9WgrOr9dEQ7JAxC7o
         j5n4ZQL1FscOz2dQnfeT0Ug0xMir8KVdIsomG7nwabjwB1k2rAIEHLczO4O+wJHfBVhA
         gwGJ1aXx0786EZSQZs+YJiisYZJ5/NoP6WWXUd9pGY3rQboFcR5KvZRhAf1flob8ueSk
         y1Yg==
X-Gm-Message-State: AJIora+eyCv2BuvK7eYGm5yme0jGkowfFa4EJMzv3Kwwn7cB2+Rl33Iq
        ZaHhhzV9RhqaXyPzDnwFeb3B0fMPdnxAbkYmbd45Ew==
X-Google-Smtp-Source: AGRyM1t1ywN+fdskFuVcHLCpuuwhji63H8NqBqdnqvimInFkWaZp2IR5kFMd7JR6tttLcj+Q/fP6E4ONlzBjTpGDIUc=
X-Received: by 2002:a05:622a:190c:b0:31e:fc7b:e017 with SMTP id
 w12-20020a05622a190c00b0031efc7be017mr4350291qtc.168.1659115055597; Fri, 29
 Jul 2022 10:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220729054958.2151520-1-zengjx95@gmail.com> <e186cbd5-4c22-8069-717d-35bb8f8e4fff@fb.com>
In-Reply-To: <e186cbd5-4c22-8069-717d-35bb8f8e4fff@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 29 Jul 2022 10:17:24 -0700
Message-ID: <CA+khW7jRNNnRmAWKqSy3=d6v7aNiVeQv-KUvW-7LC187w1kycA@mail.gmail.com>
Subject: Re: [PATCH] bpf/verifier: fix control flow issues in __reg64_bound_u32()
To:     Yonghong Song <yhs@fb.com>
Cc:     Zeng Jingxiang <zengjx95@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org,
        sdf@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 29, 2022 at 10:15 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/28/22 10:49 PM, Zeng Jingxiang wrote:
> > From: Zeng Jingxiang <linuszeng@tencent.com>
> >
> > This greater-than-or-equal-to-zero comparison of an unsigned value
> > is always true. "a >= U32_MIN".
> > 1632  return a >= U32_MIN && a <= U32_MAX;
> >
> > Fixes: b9979db83401 ("bpf: Fix propagation of bounds from 64-bit min/max into 32-bit and var_off.")
> > Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> > ---
> >   kernel/bpf/verifier.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0efbac0fd126..dd67108fb1d7 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -1629,7 +1629,7 @@ static bool __reg64_bound_s32(s64 a)
> >
> >   static bool __reg64_bound_u32(u64 a)
> >   {
> > -     return a >= U32_MIN && a <= U32_MAX;
> > +     return a <= U32_MAX;
> >   }
>
> I cannot find the related link. But IIRC, Alexei commented that
> the code is written this way to express the intention (within
> 32bit bounds) so this patch is unnecessary...
>

Yeah, I agree with Yonghong. I was about to reply.

Jingxiang, you are absolutely correct that a <= U32_MAX is redundant,
but I feel having both sides checked explicitly makes code more
readable.

> >
> >   static void __reg_combine_64_into_32(struct bpf_reg_state *reg)
