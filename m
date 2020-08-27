Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABAA253D1E
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 07:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgH0FM5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 01:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgH0FM4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Aug 2020 01:12:56 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDA3C061240
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 22:12:55 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k10so2234347lfm.5
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 22:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pzfEqEuxWPsthi6ICODPe0IobDuBQZfGwmKpBrJn6zU=;
        b=J25bfIzlwSkPzC5TdxtsIbMuvKUdLQB/Hl2vcWTL+Bz2OvRHCloIkvdO+BViwCpviO
         7ZLSTT86P/2uLU7Pmse5ejJaulox5t+LLN8I95YBzVSVC4/SgJ2RZV+HhuJTgJ8M4mY0
         7USJEKaXmXRxISVUjGUGNIOEqC8C8dojnYWRI7HtsSPiWsGLUnuwv78QpzcYtJWQJEKc
         U932kqAnvA4VnJDEtyc7bFlxR9DGYkZjM5Yf0XfznTNUl9mNKQyAdDbp3oykXJ5OryL+
         e43RPhRaOoUS9QP2mhCEdLo9Hd76fOAqmqXP9GbIMvwlE0VE6yfqmgCCAosgsLQY+93v
         w8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pzfEqEuxWPsthi6ICODPe0IobDuBQZfGwmKpBrJn6zU=;
        b=jMxe2KiscOuW2rPHQADto9+a0KzQg1BgpvySRxZC1Iet5hRU6nHE0Sq+6nPBvgCjvp
         DucCyFUUcep6GSJhfkpkmv8Oew21ejzjyLOeeURV3stU/JrGtih0T/uesVcgxCU7C9VJ
         9JacjFpj9Ypsc8ssONcHuUdFgoO6LjaDQOVNliPQvKZEWQRq26o5R/sRQ/lm9a44ti62
         OYlhyT7XRekVPMSI73ff+S3UmurK6tPsaRB+HzObF7heDD6QXkdIfQqaEg7R+w4A6A+F
         P6MMjh7y6B8nd6thyiYpjoNOu/4510TtFVYCYyz4Z878XHsQu2uqYE07sgVNq1AasFBX
         +vZQ==
X-Gm-Message-State: AOAM530DG/JmFrj0jgJgD2IPpXyFUzfZGl6U9FHlk2AIFtuvIbLAzXOn
        JQHHa5iMNnKjVjBhthHZfUyPDOZHbRTuF330bI8=
X-Google-Smtp-Source: ABdhPJwijgbDp1s/1Inkh3eOt0B9ZX93PkOOjGDbdScoJTch/mSRO/yby/vE/PG8uYg96GA2Sh/zvHfOAo/OJTlJ6pE=
X-Received: by 2002:a05:6512:3610:: with SMTP id f16mr8902465lfs.8.1598505174327;
 Wed, 26 Aug 2020 22:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200825064608.2017878-1-yhs@fb.com> <20200825064608.2017937-1-yhs@fb.com>
 <20200826015836.2rlfvhoznylkabp6@ast-mbp.dhcp.thefacebook.com>
 <f2056e3c-e300-6fa0-8b8e-fa19ed5580bd@fb.com> <5f46dcd8c0156_50e8208f4@john-XPS-13-9370.notmuch>
In-Reply-To: <5f46dcd8c0156_50e8208f4@john-XPS-13-9370.notmuch>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 26 Aug 2020 22:12:42 -0700
Message-ID: <CAADnVQ+XYd=GzF2P=3RO_Xi6m5zQA2q3JYTWxbh3O=Pfn8zLXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: fix a verifier failure with xor
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Edward Cree <ecree@solarflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 26, 2020 at 3:06 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> It is a hold-out from when we went from having a 32-bit var-off
> and a 64-bit var-off. I'll send a patch its clumsy and not needed
> for sure.

please follow up with such patches.

> The other subtle piece here we should clean up. Its possible
> to have a const in the subreg but a non-const in the wider
> 64-bit reg. In this case we skip marking the 32-bit subreg
> as known and rely on the 64-bit case to handle it. But, we
> may if the 64-bit reg is not const fall through and update
> the 64-bit bounds. Then later we call __update_reg32_bounds()
> and this will use the var_off, previously updated. The
> 32-bit bounds are then updated using this var_off so they
> are correct even if less precise than we might expect. I
> believe xor is correct here as well.

makes sense. I think it's correct now, but I agree that cleaning
this up would be good as well.

> I need to send another patch with a comment for the BTF_ID
> types. I'll add some test cases for this 64-bit non-const and
> subreg const so we don't break it later. I'm on the fence
> if we should tighten the bounds there as well. I'll see if
> it helps readability to do explicit 32-bit const handling
> there. I had it in one of the early series with the 32-bit
> bounds handling, but dropped for what we have now.

Not following. Why is this related to btf_id ?

> LGTM, but I see a couple follow up patches with tests, comments,
> and dropping the duplicate ALU op I'll try to do those Friday, unless
> someone else does them first.

yes. please :)

I've pushed this set to bpf-next in the meantime.
Thanks everyone!
