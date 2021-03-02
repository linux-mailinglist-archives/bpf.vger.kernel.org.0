Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960AB32B35C
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352479AbhCCDvG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1837072AbhCBUiX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 15:38:23 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB02C06178B;
        Tue,  2 Mar 2021 12:38:08 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o16so4068012wmh.0;
        Tue, 02 Mar 2021 12:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fVORHvbe3xDrZDTWpaGFZMUL2U3hQMYf826QqnYl9l8=;
        b=mVH4lIA/ydhx0e37ftXquLx/LtSpEvJvTGdKUgzqQC3cR00TEeQ/IL4f2DAMaRqbJp
         GpwUL/GLzxeA9vTYYP922fZDkw7wWNrzADMDXtVEURSjppA4WfjG0ujig9FaAsSxKeGe
         71u+7y9F61lFvYSzl8T1m6cmSZd9w3crWgP07aeDTIKQLQsr0eck8BhrDBX00yRMa7vE
         y0aXEK3r1BjL4CJqRjdx+ZumzUjmoG9T8dtGdQJEd3aLHt+NOes0XJQOaHMxZmkXFufl
         FILayTdobcB4YmNEL9Aa9oXkMmkrbJrNv+rjQUTY/0av3ruaLhfv+172xLF1BC+yipid
         NwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fVORHvbe3xDrZDTWpaGFZMUL2U3hQMYf826QqnYl9l8=;
        b=QTjX0MVu6FWCZL4LtIVcarL3y1O5k5W//Zv7RclawMc7JJSkj7Zdkssmj0lwbA64+5
         NfyNcAXJ8wMm8OBL3C0NJM47rrrX/nqsxCMduiIYUj2RjTJHSDfoS0vPWPBJUMM/rxIA
         mZOzqF7aS3HcZ0xax3IG4ODCKBsCtgOmKzTpPuGzfH6x7WesS5rq0A04Jc+4amdR0KCN
         +tehbyU1z5IQHrHd26Kmoi6CdDqO4XnnAOeAidDcNoUbte4WAw0cq7kF10eRCjRJ59QF
         7dke/RkUxo+RyB0pA8l0pTS0Zyci6KKYwme7jaP1e2dA0OrfsVqAmUCuXRL5KBnoDcgn
         XGUg==
X-Gm-Message-State: AOAM532PL/OHH0B4Q1BzQnQEwwsLgzNfWOsj5doYRmNz+batLXZPykCB
        e9ZZWVrM+sjp3kMC+tk0JCtR2qVWPEPqdL4CspU=
X-Google-Smtp-Source: ABdhPJyy5pmikjf79y1/GvNaKd4OnksdSm7C5u8BXo2lPqzmEzL2T7Zb6agEX3ppixMKdKvwBNk1Tdpx6f69uoOSWaM=
X-Received: by 2002:a1c:7312:: with SMTP id d18mr5680637wmb.155.1614717487210;
 Tue, 02 Mar 2021 12:38:07 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
 <20210302195758.GQ2696@paulmck-ThinkPad-P72> <20210302200441.GA3729@paulmck-ThinkPad-P72>
In-Reply-To: <20210302200441.GA3729@paulmck-ThinkPad-P72>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Tue, 2 Mar 2021 21:37:55 +0100
Message-ID: <CAJ+HfNi1Y16ftJb-Ct3gCUvu71GW6VnEcvibvwyY9nxZMu5nfw@mail.gmail.com>
Subject: Re: XDP socket rings, and LKMM litmus tests
To:     paulmck@kernel.org
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2 Mar 2021 at 21:04, Paul E. McKenney <paulmck@kernel.org> wrote:
>

[...]

>
> And if the answer is "yes", how about this one?
>

With the =3D=3D to !=3D change in P1, this is OK!

> P0(int *prod, int *cons, int *data)
> {
>     int p;
>
>     p =3D READ_ONCE(*prod);
>     if (p =3D=3D READ_ONCE(*cons)) {

...and now d=3D=3D1 is not a valid state anymore according to herd. If
think I need some input here! :-D

>         WRITE_ONCE(*data, 1);
>         smp_wmb();
>         WRITE_ONCE(*prod, p ^ 1);
>     }
> }
>
> P1(int *prod, int *cons, int *data)
> {
>     int c;
>     int d =3D -1;
>
>     c =3D READ_ONCE(*cons);
>     if (READ_ONCE(*prod) =3D=3D c) {
>         smp_rmb();
>         d =3D READ_ONCE(*data);
>         smp_mb();
>         WRITE_ONCE(*cons, c ^ 1);
>     }
> }
>

[...]

Bj=C3=B6rn
