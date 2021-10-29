Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A55543FDC3
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 16:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhJ2OEM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 10:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhJ2OEK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Oct 2021 10:04:10 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAF3C061714
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 07:01:41 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bq11so21262299lfb.10
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 07:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O8H4DpnoQlOGKwECy0UuyPUX+vRvmWdzMs26Ygl+H9s=;
        b=IwgXh0XjoYB4noHUHseuBxVgLqRzUY23hoTDHw7mABxd8AQIuy7BdN7lUBk45ab1n3
         +bkzn+tFjeSus03XwwJl/1ObDOlp/uonecXStg4kU2Q4T6tgjXsAhjaTSxTX74bzY3Xf
         7bKea78gAsjfIaegkefYetaSb3Kiw1V+aU++E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O8H4DpnoQlOGKwECy0UuyPUX+vRvmWdzMs26Ygl+H9s=;
        b=4xeiCQLbKhJb35ZUuIdmEDjKtw8gtDNxfm13WvuCunsbwArhBZLUXS4Bf1qIhzLYhj
         tp5a9fqVtmfo58lMXh7eHrezfxioxJLqJVc18s3uwFGSr3jarwR+TagSLUZrnZPaFqp9
         8UA0eoXopuMI/0X8/HgLJ0rDPVBF0gO3KdpljiIeybISduYCvAD9qKmwP4TSlHzhFiro
         uTKap4tESwKhiy31C99O/X6+5Ib5wqAFNQFZYzMTtFQZD0dhvjFxpwlwaeTJO/QGrO6V
         Px6oLva72H8D0+0SNuPUK0CmWvjGFmqFzjAI6Qp3g22K27aVKwGajL4aNkNJ83K5p13E
         CJEQ==
X-Gm-Message-State: AOAM532qhz3MRBwzc6RekuQtzadqhrADEgq/wG+Z1ItwVum6Rk9S2h83
        w5KUKXUEdxPmgujZQSAXeaDnfbLmTp6rtXNfVipyCA==
X-Google-Smtp-Source: ABdhPJw3oLnzghf8laA2Lb4TAEf4aOEFM4MgErZZjPC7QzI1aUNXOxXoS+JZqQCuwas4rhGK/irrVinvn15TSm2MqZ8=
X-Received: by 2002:a05:6512:143:: with SMTP id m3mr10554579lfo.620.1635516099814;
 Fri, 29 Oct 2021 07:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211014143436.54470-1-lmb@cloudflare.com> <20211014143436.54470-10-lmb@cloudflare.com>
 <20211020171542.7vn3lsrqmq2h7q2v@ast-mbp.dhcp.thefacebook.com>
 <CACAyw9_z=dya3S00wEjS_sVtFp5PVOX2OU6eDw0JHTQ91dRRHA@mail.gmail.com> <CAADnVQJXmVFj_6O9eEAs_4FfdyZMhTab57v_=syR8RJWrdPLHA@mail.gmail.com>
In-Reply-To: <CAADnVQJXmVFj_6O9eEAs_4FfdyZMhTab57v_=syR8RJWrdPLHA@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 29 Oct 2021 15:01:29 +0100
Message-ID: <CACAyw99sM0F8JpL-fcOqnCg2J99zhk45ASbzvxxgv+0x4ERKoQ@mail.gmail.com>
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

On Wed, 27 Oct 2021 at 19:21, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> >
> > I could reduce this to just the three different variants, it opens us
> > up to another map_get_fd_by_id.
>
> yes, but even with all of them there is still a risk of repeating
> map_get_fd_by_id mistake.
> To make progress maybe let's land the bits that we agree on
> and keep brainstorming on the rest?

Sounds good to me, which parts are good to go from your side? I wanted
to join BPF office hours yesterday to discuss, but I got sidetracked.
I'll join next week instead.

> Or that's too little to be useful for automatic golang conversion?
> If the whole thing is needed then golang converting script
> should probably be part of the series otherwise things will bit rot.

Every little helps I would say. Good point on bit rot, does it make
sense to e.g. not allow new defines by default, etc.? We could hook it
into the Makefile of selftests/bpf or some such?

Lorenz
--
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
