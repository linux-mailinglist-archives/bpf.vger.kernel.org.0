Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BD339AEF1
	for <lists+bpf@lfdr.de>; Fri,  4 Jun 2021 01:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFDAAo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Jun 2021 20:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDAAo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Jun 2021 20:00:44 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D9DC06174A
        for <bpf@vger.kernel.org>; Thu,  3 Jun 2021 16:58:45 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id m3so9255226lji.12
        for <bpf@vger.kernel.org>; Thu, 03 Jun 2021 16:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2MAeAU7BqvEXHTBb00QbODBucdEhzDTze3EKA/F94sk=;
        b=Ii85B9Z07517xtHJwQnb0YHfoNS8dDCWorXpqTuaOT21XTzGfXGrflaADSb0fetrYW
         WbJzNtBBYDNt3XEItyQetGUB6NnM3hOUkIUnZiK+AsI4Zf6Jrkwnnkz/x47udZsA08qy
         UjFAuLFyWWqjx13c8S+sFHQ0rU3dGk6aKwH01GxlNUM/2D60DuqWiSQV/03CkVP1z8ym
         l03AAcZ+nelBR70dHYOWoGp3CckTVFTr7FgBCk98BVair2f1PQy5N4AJpuxOWmwSRoKx
         INT/81kshGFtj+6zNzMDg5aPLYtdCUV60kjobNbQcVQKQ6RX0jspBLkPXkn+EbAMvCcl
         HWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2MAeAU7BqvEXHTBb00QbODBucdEhzDTze3EKA/F94sk=;
        b=K+0ol89x6GNWrlYlrTYu/lRdSn9xKDqULyzS0nZpiC1B/mhOsak5bDLJ/UIN++t4Wp
         U1OZy3ayRK3ZfxYPoqlCQwlkQmQHCWX8guCHphzwOEcl0ZNKwbVx9QxW4iSiBEsWYhrV
         yOEyOZXpwj6JHTw9a0bNzI8a3TijO7ciQYd+HZc+6ZLtA1t2BiPbsmERuP1skxd+NWOC
         Ggegbw5ozvksOWq7JL6Rlp07fVju2oRvE1qCMmYK+/sTobT3x+hEukxI+VS8uJNcy3qv
         gFFUEdKnCQ/O5WuHxSDQPCvFcy4DchRwiUbpBYcIz94i7i5+M2sOItEZFpmpp67/GYon
         3D3g==
X-Gm-Message-State: AOAM530sRdknfrqUfAV+3TUTswH05x4CE6WsP5LIM7LU0y+stWVKITnj
        h889QPjkmXRTRXFRcJPVO8MhpdIhTwRORr9ApXQ=
X-Google-Smtp-Source: ABdhPJxRryFA2BU7rLjs9oN3bUKN9aKdvBQg4sQU81XEbfv4wa9aK4qw/mgg92B1b8TferF1JjeSMx3nyxtNuC/+e4s=
X-Received: by 2002:a05:651c:28e:: with SMTP id b14mr1288929ljo.486.1622764723419;
 Thu, 03 Jun 2021 16:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <6662597c-13a2-5c6e-df6c-31d18ed34bfd@rub.de> <20210602174127.55ny556mki3uv4tx@kafai-mbp>
 <2d11fecc-4999-73d7-82e7-3a2c9d9826f3@rub.de>
In-Reply-To: <2d11fecc-4999-73d7-82e7-3a2c9d9826f3@rub.de>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 3 Jun 2021 16:58:32 -0700
Message-ID: <CAADnVQ+-pRhmtsJLieJ0WKpZ9m7GXJrunBMVns3zQSZojMYSoA@mail.gmail.com>
Subject: Re: fix u32 printf specifier
To:     Benedict Schlueter <Benedict.Schlueter@rub.de>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        benedict.schlueter@ruhr-uni-bochum.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 2, 2021 at 3:43 PM Benedict Schlueter
<Benedict.Schlueter@rub.de> wrote:
>
> On 02/06/2021 19:41, Martin KaFai Lau wrote:
>
> > On Wed, Jun 02, 2021 at 05:23:19PM +0200, Benedict Schlueter wrote:
> >> Hi,
> >>
> >> I assume its clear what this patch does.
> >>
> >>
> >>  From 9618e4475b812651c3fe481af885757675fc4ae2 Mon Sep 17 00:00:00 2001
> >> From: Benedict Schlueter <benedict.schlueter@rub.de>
> >> Date: Wed, 2 Jun 2021 17:16:13 +0200
> >> Subject: use correct format string specifier for unsigned 32 Bit
> >>   bounds print statements
> >>
> >> Signed-off-by: Benedict Schlueter <benedict.schlueter@rub.de>
> >> ---
> >>   kernel/bpf/verifier.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 1de4b8c6ee42..e107996c7220 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -690,11 +690,11 @@ static void print_verifier_state(struct
> >> bpf_verifier_env *env,
> >>                           (int)(reg->s32_max_value));
> >>                   if (reg->u32_min_value != reg->umin_value &&
> >>                       reg->u32_min_value != U32_MIN)
> >> -                    verbose(env, ",u32_min_value=%d",
> >> +                    verbose(env, ",u32_min_value=%u",
> >>                           (int)(reg->u32_min_value));
> > "%u" and (int) cast don't make sense.
> Yep, changed to unsigned int for consistency with the other cases. Is
> this necessary? Since reg->u32_min_value is already a unsigned 32 bit
> number.
> > It needs a proper commit message to explain why the change is needed
> > and also a Fixes tag.  Please refer to Documentation/bpf/bpf_devel_QA.rst.
>
> Sorry should have read this more carefully before. Everything should be
> included right now.
>
>  From fd076dc5f2bd5ec4e9cb49530e77cf2d3e4f42c2 Mon Sep 17 00:00:00 2001
> From: Benedict Schlueter <benedict.schlueter@rub.de>
> Date: Wed, 2 Jun 2021 21:42:39 +0200
> Subject: [PATCH bpf-next]
>   use correct format string specifier for unsigned 32 bounds

Please resubmit the patch.
See 'Submitting patches' in Documentation/bpf/bpf_devel_QA.rst
