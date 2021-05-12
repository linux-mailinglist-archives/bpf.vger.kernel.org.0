Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B8137BE5D
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 15:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhELNlf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 09:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELNle (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 09:41:34 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778C3C06174A
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 06:40:26 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id v5so29612077ljg.12
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 06:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8LIyfshQU/8yQNnJrZxiYbeec8RPvd1zV0izLRjzdEM=;
        b=x6UdDyTdjf0smNcVgVNK04/0pGGLotfOjtei+KBIpEvw8WpqbMegKlbbmX2SJycUDE
         /Z+NQHCnwGfnCCEZNXXJPMnmNCRMlzKIaF0qQHSxyRh+PGBQqHhlK9QvCAq/5S78+7lZ
         Z0JAp4uGYEdT07vHLlX2LFtil5viaFpoP9r7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LIyfshQU/8yQNnJrZxiYbeec8RPvd1zV0izLRjzdEM=;
        b=SvG4Jmh2CiXp40tGcq2fEJudOkLZNvWbAERD7fZpftn87W8BsqRsBnQqaZse9SksG5
         zKrTAJB3XRg4pDAG8rKd0axc2jkow446oLZjIDaHv0+J+JqnI/Mwby9Dep5cPbJI1OSM
         kB25f1DOw7IrpNHsU6wXtOmsBaxVJ72uTGYipNGfoDMKu6WZhKg03vqjeQrh+jfZEu8f
         gBqOdY/uZxW0v1DylG73lbUuK719zttOhL5qPUCCMC1C85ph4fMR13D+9Hpskh82ZX2m
         DLXPNx6UHQvbN0mU83fyNYjqYrrRvIywOTHuPAN+NsTL0PTyAmAdW1rp++Tc27byEJg0
         sw/Q==
X-Gm-Message-State: AOAM532i3vvcds9yDhqS1FBkcmbPmoRFGjyQDAGo3naKMw3xzva35Np5
        ypoj1+zc/5ji1gtuO6RsuIrjtNIwtw/TMCZBC5m/4A==
X-Google-Smtp-Source: ABdhPJxEvZ7tF7fllIIAdJE82qM93y08u9nNpwObsXmV4ToOWKvfujrvvYFVeHRj0WzvNymbue9sPIsj2faUCqSkGHQ=
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr24602570ljg.83.1620826824452;
 Wed, 12 May 2021 06:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzZOmCgmbYDUGA-s5AF6XJFkT1xKinY3Jax3Zm2OLNmguA@mail.gmail.com>
 <20210426223449.5njjmcjpu63chqbb@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzYZX9YJcoragK20cvQvr_tPTWYBQSRh7diKc1KoCtu4Dg@mail.gmail.com>
 <20210427022231.pbgtrdbxpgdx2zrw@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzZOwTp4vQxvCSXaS4-94fz_eZ7Q4n6uQfkAnMQnLRaTbQ@mail.gmail.com>
 <20210428045545.egqvhyulr4ybbad6@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzZo7_r-hsNvJt3w3kyrmmBJj7ghGY8+k4nvKF0KLjma=w@mail.gmail.com>
 <20210504044204.kpt6t5kaomj7oivq@ast-mbp> <CAADnVQ+WV8xZqJfWx8em5Ch8aKA8xcPqR0wT0BdFf9M==W5_FQ@mail.gmail.com>
 <CAEf4BzY2z+oh=N0X26RBLEWw0t9pT7_fN0mWyDqfGcwuK8A-kg@mail.gmail.com> <20210511230505.z3rdnppplk3v3jce@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210511230505.z3rdnppplk3v3jce@ast-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 12 May 2021 14:40:13 +0100
Message-ID: <CACAyw9-pYpZO81W+vzEGv1+DmfapDjzco0QgZakfE7giisay6Q@mail.gmail.com>
Subject: Re: bpf libraries and static variables. Was: [PATCH v2 bpf-next 2/6]
 libbpf: rename static variables during linking
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 12 May 2021 at 00:05, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
>
> > It's a pretty long email already and there are a lot things to unpack,
> > and still more nuances to discuss. So I'll put up BPF static linking +
> > BPF libraries topic for this week's BPF office hours for anyone
> > interested to join the live discussion. It would hopefully allow
> > everyone to get more up to speed and onto the same page on this topic.
> > But still curious WDYT?
>
> Sounds great to me. I hope more folks can join the discussion.

I'll be there, but can only stay for the first half hour. Talk to you then!

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
