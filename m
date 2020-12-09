Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CB22D388A
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 03:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgLICAC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 21:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgLICAC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 21:00:02 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B49C0613CF
        for <bpf@vger.kernel.org>; Tue,  8 Dec 2020 17:59:21 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id a1so775844ljq.3
        for <bpf@vger.kernel.org>; Tue, 08 Dec 2020 17:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7aMz42Sz7HR0CodxloTeJL0Wyef938yAqRCUaMHA0E=;
        b=IPGMNhxoVkhUHPEO7igUGddY6liQ8eZyuTxy4f//TX8Vm7/j8T2Gi1DL3p9+cJhBk7
         Kf0x93uJhnoDWQxcUwhUA3kfFdKipjwdB/CMlMpZdmxVS2AD1Pwyt2v4/FJqSYTSQaq6
         vw299eT86uIiTtP2o14lQdh79B/Y9Qz2TaMUz+9MAEIyl2wGKCWRSMMh4FObgQkbe2SQ
         jjyqlLqguGdBGj+vrDNTCKuBy3gx7TYYvIbonRkbgKGakSMO3m6AgFxpA1OFySTJXCGO
         izzEzIQX47fnj3xPiBzy8MaSslYp7vdGsxgxhF9494htuLsNeSkMVM5tjvKiFJ5fbQ9z
         icqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7aMz42Sz7HR0CodxloTeJL0Wyef938yAqRCUaMHA0E=;
        b=IbNKmnHKRf0mNnO75y6T6SyBDelAOiVfRsR32PmyKZYTyRm+8jKjwt9Af6t2k0fuTv
         gt1+QRlbtKzoTEJsAwDbEqDhsHbj2O/LIsPZI6a+Phd5lodKxxRyZx0+bq6nm56BibBH
         c5qeZVPVVEvMlczQ5wCoVST5B/yQ97NxSzdbnP9jE2bq8qqQFp54j5KmIrKM4ed5k6p4
         FhnlR57z5Q3ZVzSj1+/5K6ToyDUzNqmkNbiwCdkmN+JNbigomP1ExNddJSlv2DEgkPxV
         bp+3X119Xa+j2+lG3q2VUlhk12vLTKXeXwn9tg7L9GnpMkxY2rqfvMtFr0pi+YBYU3SN
         Ublg==
X-Gm-Message-State: AOAM533Pxy8/L0k0evRwsfdEhODM8AFSDauU0t4Q0HvEn4+pzy7EMJUK
        hypgsh/rRsS8ibtY++X0TC2FNYmf3XX+N7I2ykc=
X-Google-Smtp-Source: ABdhPJyyDcuTyLHNwZQbC4FoFR/CFbOO82vXXSD5XyyU1uYGmbnjLy9kl9YznDVOckrENBPqLPc/LHAlL5nrxz9Q3jk=
X-Received: by 2002:a2e:9cd8:: with SMTP id g24mr36393ljj.32.1607479160077;
 Tue, 08 Dec 2020 17:59:20 -0800 (PST)
MIME-Version: 1.0
References: <CANaYP3GdNhD56xykv+uS2Y1Mof1vXWkSfdbTPo9bwjGmXxSHEA@mail.gmail.com>
 <919345aa-4746-40a5-be17-faf110619e84@www.fastmail.com>
In-Reply-To: <919345aa-4746-40a5-be17-faf110619e84@www.fastmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 8 Dec 2020 17:59:08 -0800
Message-ID: <CAADnVQJcwihT43rtbMkQNfTQH6xbbZ23jgDz_2Zh0c2TY==vhw@mail.gmail.com>
Subject: Re: Feature proposal - Attaching probes to cgroups
To:     Daniel Xu <dxu@dxuuu.xyz>, Andrii Nakryiko <andrii@kernel.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Gilad Reti <gilad.reti@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 8, 2020 at 12:38 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> On Tue, Dec 8, 2020, at 2:40 AM, Gilad Reti wrote:
> > Hello everyone,
> >
> > Are there any plans on extending the cgroup program types to include
> > more probe types (or possibly allow restricting any probe type to a
> > specific cgroup)?

This kind of feature was requested earlier.
The rough idea was to add a program hook in the cgroup attach path.
So that prog can decide which progs to which cgroups are ok.
It's a bit tautological and not everyone was happy with the idea.
No patches were produced either.
Other ideas of extending existing default/override/multi logic were rejected
as not flexible and not generic enough.

> > For a use case example, this will allow attaching programs to the
> > "docker" cgroup and thus tracing events from containers only (or even
> > enforcing eBPF LSM on docker containers only).
>
> Based on my understanding, this may not be possible. For example, the
> kernel may lose information about cgroups on deferred work. When the
> work is later executed, the cgroup may lose information on work it technically
> initiated.
>
> Daniel
