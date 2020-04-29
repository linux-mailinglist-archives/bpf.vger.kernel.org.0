Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250C91BD1B6
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 03:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgD2B0I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 21:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726181AbgD2B0H (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Apr 2020 21:26:07 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B38C03C1AC
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2020 18:26:07 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n143so443700qkn.8
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2020 18:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMvvjeMwFuGeW5e1qmnM2HHkm8XA5BfOCtWQq+g+GI8=;
        b=cU+NWLgGX7zzV4rDtTmtWv2Ak2xR7bhznQWMMMF6tPflt27sSO0f8mDLVn/YxA/XTL
         fsoJWt69yDgZqKSShu4q+ng1USPGXbw4wm/XKiUmjYkk6Kn/Lgb0qzEjY3UA7hy6RlnT
         XcUY8lB/ZRQwz8VlxjLYbtp5/PmperHCIIiuA4XRWfauwzHhHBTc4BHr3aDG97obsnlL
         KIzoBrRX3djxJerXPLuE0I9oc2KWQI3vrb6oC6tSkQylpo3GmWL0QdogttBNxujaOblw
         fcZptoqGDQtoQfsYupYERnvuIGoQJyNfTbMniQ6yULsY5tSnfeI8uJBu3UJsyBFWhPJg
         ykyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMvvjeMwFuGeW5e1qmnM2HHkm8XA5BfOCtWQq+g+GI8=;
        b=GsgUfq5adLvngfRkQQbKPN2gjNGVCeiUNW3VoCVqreVpWaJDEryREHPSish53iKSyK
         28/irpr0K3j49YJHzrNInym69VIF21HtwDSPmfj1/qlmU9qhHdLJLOdZ52Y5djyfqFkv
         H7hiNlnh7xAZqwrxOJaMRngsxW57pzE3YF1z3slV1777Aoyi6LBCPQoza4FLbND4qf1V
         emNQke+vU2vNTDfDR2ZDMc3QvtHG0heieaNLY00/UtIIkQaEjrhSxuaqInwQ76ydBcxB
         Mxp/fDu7wOSMA8pfZOQuIHS3qlBp4dG17gyj1/Hbbyq2H3PXpehmJELt317WdgLMroHq
         JmiA==
X-Gm-Message-State: AGi0PuYZrg9gj9yB3ttI+2v97Fw4r/MOCewM/h3rAEaxRlEXl6G3k40a
        W9QShUctn9n7FULC5+YGN022fQvqCKzWqdDw4dfHRr98
X-Google-Smtp-Source: APiQypIlpG2aIKAK7SPr+1yJLaPzK17sEcKk+3jQf2uLb/CeY7kBJZPwUEu9T1oJ9fwNJgDOZajBVirsfgY5U1UN8G4=
X-Received: by 2002:ae9:eb8c:: with SMTP id b134mr30911878qkg.39.1588123566840;
 Tue, 28 Apr 2020 18:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200428173742.2988395-1-vkabatov@redhat.com> <CAEf4Bzbp44pnj-yNP61enxh8-ZvFn56fSF4uDHLz0ZcY-H2yAA@mail.gmail.com>
 <8e07a2db-a258-f1b3-d1f4-74f131cbcb6d@iogearbox.net> <CAEf4BzactULF+w-0yWt83T1thv3G+KoQ9ciqZF+PrnGBATc2Sw@mail.gmail.com>
In-Reply-To: <CAEf4BzactULF+w-0yWt83T1thv3G+KoQ9ciqZF+PrnGBATc2Sw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 28 Apr 2020 18:25:56 -0700
Message-ID: <CAEf4BzYrXZs1vX6_XzEu2WZgRsgAdRoh-zrWx5A=rtuW+Fnq1Q@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: Copy runqslower to OUTPUT directory
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Veronika Kabatova <vkabatov@redhat.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 28, 2020 at 5:15 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Apr 28, 2020 at 12:40 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >
> > On 4/28/20 8:57 PM, Andrii Nakryiko wrote:
> > > On Tue, Apr 28, 2020 at 10:38 AM Veronika Kabatova <vkabatov@redhat.com> wrote:
> > >>
> > >> $(OUTPUT)/runqslower makefile target doesn't actually create runqslower
> > >> binary in the $(OUTPUT) directory. As lib.mk expects all
> > >> TEST_GEN_PROGS_EXTENDED (which runqslower is a part of) to be present in
> > >> the OUTPUT directory, this results in an error when running e.g. `make
> > >> install`:
> > >>
> > >> rsync: link_stat "tools/testing/selftests/bpf/runqslower" failed: No
> > >>         such file or directory (2)
> > >>
> > >> Copy the binary into the OUTPUT directory after building it to fix the
> > >> error.
> > >>
> > >> Fixes: 3a0d3092a4ed ("selftests/bpf: Build runqslower from selftests")
> > >> Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
> > >> ---
> > >
> > > Acked-by: Andrii Nakryiko <andriin@fb.com>
> >
> > Applied, thanks!
>
> Veronika,
>
> This change leaves runqslower laying around in selftests/bpf directory
> and available to be committed into git. Can you please follow up with
> adding runqslower to .gitignore? Thanks!

Never mind anymore, sent fix as part of ASAN fixes patch set.
