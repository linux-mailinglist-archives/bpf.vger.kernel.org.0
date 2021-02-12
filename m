Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D044631A5E2
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 21:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhBLUPn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 15:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhBLUPm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 15:15:42 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8271C061756
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 12:15:01 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a9so1218163ejr.2
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 12:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GP+BGOCmcl5vDaPuSGIKIoLlEIFh7CsHpm+wbwTw+H0=;
        b=QSM9syEdv3i3xsyaviKSUXdkvxqfnDH+YS0+o5NiRfsMk0StqDx/jhb2vER1jJ8ihp
         7q20MnkxpSOvy+pRHa7gf90Yw5vgZ+iasnraVaLSgxmeUlSmlJcZhpTBmEtHBBA1UTAG
         2tFJm2w5pxLVYknwGVE69LI/tQA62i3oRy4fiXrfvoef6VJ5yXJ9P1XJvisrN1R7r3G4
         BO4SyY89OHYJTxpAG0D9WWGUQ7kGQqJu+Ri0GVgG31UG2qo8dq5mUa4+VtVg5CTQ9Z94
         mpW0K+2cN7+NH/ba50VbzUJczVY5RnGcDqa5oKC0yxgc/ILXBqxapSNa4zUApoU4v16F
         y2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GP+BGOCmcl5vDaPuSGIKIoLlEIFh7CsHpm+wbwTw+H0=;
        b=XCKoD6EyDDKDmr+9h5vCMM3VVGM/eU5FHYImI1aZsNdAntojqmzw0agLKrSaY21R3C
         pr81KkbRX0I+7NleB94uCgIk6OIo/+my4zOUaHR2VU97yA9ookpzMu77jFeIAgvp1+L6
         7y1Y2HW7F4sU67F6OCAFoOKFq3aD5Dps/iqK0rZkaxAv8pdtB0mz+3DMUK453Q36zHqL
         5tztRLnAQoGsVc3KqTVJ3oGCqH+sTX3N+CAZkkv7YoBj6sBO9iytg0jrC4D9FcWckq6r
         6INQ9e9cbH9IRi8/aNv7ENrcpDfT1ODVNbKadQEdtQ8nBsEiYhFgrQpg42faix3KenZ3
         CKWw==
X-Gm-Message-State: AOAM5304Uy9GEL+mTMlG1lpgea29KTT0oTU2CuhIZq9/JgwJ3yGd5xNH
        ZN6HciiVMEXU2I73ZFpxc/UFVjPu8gUob5tAXsaD
X-Google-Smtp-Source: ABdhPJxmxXHac3rHfZ27/HnXAc8aIrHOb3zswMYO2B74IhPt91f6jDe8jNA021aRjlhMYHk+prF0IV41VbTZO5v0+Js=
X-Received: by 2002:a17:906:4712:: with SMTP id y18mr4650363ejq.529.1613160900237;
 Fri, 12 Feb 2021 12:15:00 -0800 (PST)
MIME-Version: 1.0
References: <20210210232327.1965876-1-morbo@google.com> <20210212080104.2499483-1-morbo@google.com>
 <20210212123721.GE1398414@kernel.org>
In-Reply-To: <20210212123721.GE1398414@kernel.org>
From:   Bill Wendling <morbo@google.com>
Date:   Fri, 12 Feb 2021 12:14:49 -0800
Message-ID: <CAGG=3QXX0Bu_BD6TQXLFLgsnRQceDMmFiiH-_UD9AGt89YU31Q@mail.gmail.com>
Subject: Re: [PATCH v2] dwarf_loader: use a better hashing function
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 12, 2021 at 4:37 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Feb 12, 2021 at 12:01:04AM -0800, Bill Wendling escreveu:
> > This hashing function[1] produces better hash table bucket
> > distributions. The original hashing function always produced zeros in
> > the three least significant bits. The new hashing function gives a
> > modest performance boost:
>
> Some tidbits:
>
> You forgot to CC Andrii and also to add this, which I'm doing now:
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>
> :-)
>
Doh! You're right. Sorry about that. Thanks for catching it!

-bw
