Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246EC32B35B
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352545AbhCCDvF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350729AbhCBUZj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 15:25:39 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE2BC061788;
        Tue,  2 Mar 2021 12:24:17 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d15so6021567wrv.5;
        Tue, 02 Mar 2021 12:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6T3fGD+86/8fYUQZQLE14YUohAPbWb01LybRdaeaGkI=;
        b=QiO5JRff59hxNMm+ostLWqwaISk3Hg89pQpkhWn803Os0dD+R7ON+nBo3q/3zoX5Fr
         jdtWKbgDAzIbOBh3/5KVMTX0KvAciD8m5vid+oj0ZSdYYHz0lfr5ZyC8DwHYvL5gq78z
         XEZ6sN+zURqLnflikkTWNoKwBbSOFnLxdX9apH2KxoQL84sMq18xZIFahCJOkFRmjPD/
         WCmJzzXGbVQNJJzdY02pDMs5pWeMeygZGOlXizJ3OkT9k7aD38c1o9kKEtJrbuvGpfta
         JQGjox3OJ4ToxDDE5c+W9XPEvxKRa1lNlwYfNjVG7/FjhD9o5mOK+i+CNEtzcMOHb2/Q
         PDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6T3fGD+86/8fYUQZQLE14YUohAPbWb01LybRdaeaGkI=;
        b=oViqaiGIQouQsRlQ2vOelzeVDrqfYblo5Y3eHVohMoPkj6HgAtr+23Vv9I2HoISZzQ
         l2+y9LEunpJzkz9K1Kd+amn2YpzbpTxgjrnzkxf5rgWsD7L+d1Bs2MibbnOpGG2kzejt
         rE5T176GsX6tZjO6nUgUwmsPu+S7lWMyYO/C/AIJ+6o/NdS/PYQaMTNZ3/CmP4f1ni61
         0vgiYLbuGamLyvkZ0zu1mX2tCGYYbKytlI/8inexvolpgRv2kWKPzp/+ZdhEU6bI3f1H
         Ic2jGaLDO4mxy03UXIYSH0skgbcDfDsv1e//a1SVL4TOzAHyUVu+TwDWwh6whTOPn/E3
         QiDA==
X-Gm-Message-State: AOAM533XQrWx8hYP3FjMx3mnFpEeGx/BovV4y8YQ8CZlRqfS76pbOe0b
        6AzOm3SAxZqKTN2TGzMh3i8O0oHMsyeNbREquzw=
X-Google-Smtp-Source: ABdhPJyaxWBvb6OJ+IkFKFOq/kLbbCFFfOmZI9SG21yQGo5iV8ox5Rhb1Slnq4/HltrHp4A4ljfge08S0iDzfJkAxXY=
X-Received: by 2002:a5d:4141:: with SMTP id c1mr24661300wrq.248.1614716656517;
 Tue, 02 Mar 2021 12:24:16 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
 <20210302195758.GQ2696@paulmck-ThinkPad-P72>
In-Reply-To: <20210302195758.GQ2696@paulmck-ThinkPad-P72>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Tue, 2 Mar 2021 21:24:04 +0100
Message-ID: <CAJ+HfNj-_P=LpkrUjxcOR73ffMXwsJ+o+zMTfmkiuH2zZ5XCLQ@mail.gmail.com>
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

On Tue, 2 Mar 2021 at 20:57, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Mar 02, 2021 at 07:46:27PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:

[...]

>
> Before digging in too deeply, does the following simplification
> still capture your intent?
>

Thanks for having a look, Paul!

> P0(int *prod, int *cons, int *data)
> {
>     int p;
>     int cond =3D 0;
>
>     p =3D READ_ONCE(*prod);
>     if (p =3D=3D READ_ONCE(*cons))
>             cond =3D 1;

With this, yes!

>     if (cond) {
>         smp_mb();
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
>     int cond =3D 0;
>
>     c =3D READ_ONCE(*cons);
>     if (READ_ONCE(*prod) =3D=3D c)
>             cond =3D 1;

Hmm, this would not be the correct state transition.

c=3D=3D1 && p=3D=3D1 would set cond to 1, right?

I would agree with:
  c =3D READ_ONCE(*cons);
  if (READ_ONCE(*prod) !=3D c)


>
>     if (cond =3D=3D 1) {
>         smp_rmb();
>         d =3D READ_ONCE(*data);
>         smp_mb();
>         WRITE_ONCE(*cons, c ^ 1);
>     }
> }
>
>                                                         Thanx, Paul
>

[...]

Bj=C3=B6rn
