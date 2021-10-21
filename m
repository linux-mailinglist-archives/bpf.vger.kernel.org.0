Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB74A43671F
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 17:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhJUQCM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 12:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhJUQBn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 12:01:43 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEBCC061224
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 08:59:12 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 204so682117ljf.9
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 08:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ELW42ptjxbIrNBLbgLdDMft0T9DqGMzj6NFwEw1t3L4=;
        b=dtzrKX1av1V0q4EvbEsh8Opz9bLfX3tTyclYw+hidYdVUhffpX30Zaz3ZLhwmE/VIb
         1AZUE8z/QYhIHPO9lFxFHiW9aldTJKh0aN8lFRSnXS22mK+ekWA4LR9lpoYu3Tn+lqjq
         qIITabu/u/AQN5+rA/Ifglrjas7yyiJS3BG4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ELW42ptjxbIrNBLbgLdDMft0T9DqGMzj6NFwEw1t3L4=;
        b=jEB5sSM5S1WLZ0niRaHdnVK7YblDLRgGePoraF+5wzMaZQDsp0LF80WobZLMxLr5Gi
         hv5+ctdimt1ko+M0tKN50v9P+9FKpr9KKpmO8GZgeX50HMaDl0Jf3OF2LmF0JbBzHUtm
         koSQDyTHMaoAf/nONrTMnRqE0diGvRWcyRFk94MiFu+RgXHuTDvt64sPksD3dBbkn+HC
         cMrZeCzINDpm0tehquztVPejpUH7AMDnAV/kUAdvT9zFkIuk2AUdz286C0ORzXRYmnxQ
         E46z7qrvuiuwx0PsURghOGNUTgf902ZP5Z70MtX2T4uFE7uAeuuyu9rkW/XyyGJ6prqm
         CsYw==
X-Gm-Message-State: AOAM533O7gXScIzjHcLvhSaSwEiO1NeqKtTPUgB9uZt/E4VGEoyfya+1
        Pq6K+D8i3cUbKn0az2BFskgAmkQNb2SGsY2vCCc1wQ==
X-Google-Smtp-Source: ABdhPJy6ZRs2drY2cdB/ofPUPZQRGklPpKdly5AToaWwxKg97na7t03kFHCUZEvgU2kHhfgJtYCpxfWiEB/zBI/3QFY=
X-Received: by 2002:a2e:9b09:: with SMTP id u9mr6921399lji.111.1634831951311;
 Thu, 21 Oct 2021 08:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211014143436.54470-1-lmb@cloudflare.com> <20211014143436.54470-10-lmb@cloudflare.com>
 <20211020171542.7vn3lsrqmq2h7q2v@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211020171542.7vn3lsrqmq2h7q2v@ast-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 21 Oct 2021 16:59:00 +0100
Message-ID: <CACAyw9_z=dya3S00wEjS_sVtFp5PVOX2OU6eDw0JHTQ91dRRHA@mail.gmail.com>
Subject: Re: [RFC 7/9] bpf: split get_id and fd_by_id in bpf_attr
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 20 Oct 2021 at 18:15, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> > +     struct { /* used by BPF_PROG_GET_FD_BY_ID command */
> > +             __u32 id;
> > +     } prog_get_fd_by_id;
> > +
> > +     struct { /* used by BPF_MAP_GET_FD_BY_ID command */
> > +             __u32 id;
> > +             __u32 ingnored;
> > +             __u32 open_flags;
> > +     } map_get_fd_by_id;
> > +

> > +     struct { /* used by BPF_PROG_GET_NEXT_ID command */
> > +             __u32 start_id;
> > +             __u32 next_id;
> > +     } prog_get_next_id;
> > +

> This one looks like churn though.

Yes, but it's still better than what we have now. There are three
distinct syscall signatures that a user needs to understand, which is
impossible right now without looking at the source. map_get_fd_by_id
is arguably dodgy with one field completely ignored. Having one struct
for each bpf_cmd makes code generation easier as well.

I could reduce this to just the three different variants, it opens us
up to another map_get_fd_by_id.

Lorenz
-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
