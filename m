Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C3932B360
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352453AbhCCDvL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381284AbhCBUwc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 15:52:32 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B170C061788;
        Tue,  2 Mar 2021 12:51:42 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l22so3364324wme.1;
        Tue, 02 Mar 2021 12:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kIc2w7mujz9voVpN9IahMRlS32F3lOVKY+UoybD2UvI=;
        b=eIAjkt4jHEWC8FH4kXMbpC7gl9BJawjb04aSeyj4ImQ8n3/6Os4Bri9R7+JG0t6uIr
         q+zlATJwN9dbY1Wg5R3o8llP8cfaTu2Y89wOG028zy6jug9p+Z4KAezDAjfjRl0EnvBk
         oIqp/4gTVQ7oiDLs/szViB6FAf5hWaxY2FeAptgjNoVoFoYbMEvX17T41d3ut2/qh8g8
         RskyQtSculplpZOc1ytNHrxG44WF4FZDjBKrHiv26ZQ//TaLUOXM86QALcugbZzocTdV
         9kC8C5msx0Rz/m2tzvFEEsvxiVMliGfwUzPh33LVVO3W/NIWQeAWDdB00NiBCVFizEtZ
         BgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kIc2w7mujz9voVpN9IahMRlS32F3lOVKY+UoybD2UvI=;
        b=Pez7EN0h02sChFXRCt9AK57niuUWoTzEXGgvx9j0+u4hcru78UD5XDS5zvo4qdUH+f
         dBg3InLam9ohcW9GAOkacapCQyBxqn+bx+TVtSSdB35TL1doFDIuN6wFRHND3plz48/J
         ZxrslF7wNwx3XDRy8sGimYcdC9yKXRm72bPj4jia+8ZKUMs1ev9EVg2oOPx570VGO4J2
         4rBpeu136liPq/Gx3MKzGnZ7EK0FSxsDrTkcb2X2qy9kwbh78eeNo/7Peb3nkQh7UR5P
         GqsJIcaE/1d21fVhscXFBLA2/kDqp5405iaMNYbboZ6P6M/aCwwyiS+Ueieq9wefmsCD
         pBjw==
X-Gm-Message-State: AOAM533BNkeu6hNO6wnFuLqAqt5f4zgmorKihDbI8WO6Tc2+sSLgpDMD
        nMnZkVOwNnPick3NBAFHyPKlPZlC3eytJn+t+mc=
X-Google-Smtp-Source: ABdhPJwhCovvtZEQ/NjASG5VlLZs1XjkrAW5mZ8zj5yVbNcjcMEboTKboyYECTgE4/Yd0mDNhi7dQgW/VwHVQfL5Xkg=
X-Received: by 2002:a1c:7714:: with SMTP id t20mr2751077wmi.107.1614718301146;
 Tue, 02 Mar 2021 12:51:41 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
 <20210302195758.GQ2696@paulmck-ThinkPad-P72> <CAJ+HfNj-_P=LpkrUjxcOR73ffMXwsJ+o+zMTfmkiuH2zZ5XCLQ@mail.gmail.com>
 <20210302204157.GR2696@paulmck-ThinkPad-P72>
In-Reply-To: <20210302204157.GR2696@paulmck-ThinkPad-P72>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Tue, 2 Mar 2021 21:51:29 +0100
Message-ID: <CAJ+HfNhdgMTyfbeMsTsbhB_Pk6LW+2oB8=T0qWLgmM2q9_nkvQ@mail.gmail.com>
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

On Tue, 2 Mar 2021 at 21:41, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Mar 02, 2021 at 09:24:04PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
> > On Tue, 2 Mar 2021 at 20:57, Paul E. McKenney <paulmck@kernel.org> wrot=
e:
> > >
> > > On Tue, Mar 02, 2021 at 07:46:27PM +0100, Bj=C3=B6rn T=C3=B6pel wrote=
:
> >
> > [...]
> >
> > >
> > > Before digging in too deeply, does the following simplification
> > > still capture your intent?
> > >
> >
> > Thanks for having a look, Paul!
> >
> > > P0(int *prod, int *cons, int *data)
> > > {
> > >     int p;
> > >     int cond =3D 0;
> > >
> > >     p =3D READ_ONCE(*prod);
> > >     if (p =3D=3D READ_ONCE(*cons))
> > >             cond =3D 1;
> >
> > With this, yes!
> >
> > >     if (cond) {
> > >         smp_mb();
> > >         WRITE_ONCE(*data, 1);
> > >         smp_wmb();
> > >         WRITE_ONCE(*prod, p ^ 1);
> > >     }
> > > }
> > >
> > > P1(int *prod, int *cons, int *data)
> > > {
> > >     int c;
> > >     int d =3D -1;
> > >     int cond =3D 0;
> > >
> > >     c =3D READ_ONCE(*cons);
> > >     if (READ_ONCE(*prod) =3D=3D c)
> > >             cond =3D 1;
> >
> > Hmm, this would not be the correct state transition.
> >
> > c=3D=3D1 && p=3D=3D1 would set cond to 1, right?
> >
> > I would agree with:
> >   c =3D READ_ONCE(*cons);
> >   if (READ_ONCE(*prod) !=3D c)
>
> Right you are!
>
> With that, it looks to me like LKMM is OK with removing the smp_mb().
> My guess is that the issue is that LKMM confines the effect of control
> dependencies to a single "if" statement, hence my reworking of your
> original.
>

Interesting!

I tried the acquire/release version:

P0(int *prod, int *cons, int *data)
{
    int p;
    int cond =3D 0;

    p =3D READ_ONCE(*prod);
    if (p =3D=3D READ_ONCE(*cons)) {
        WRITE_ONCE(*data, 1);
        smp_store_release(prod, p ^ 1);
    }
}

P1(int *prod, int *cons, int *data)
{
    int c;
    int d =3D -1;

    c =3D READ_ONCE(*cons);
    if (smp_load_acquire(prod) !=3D c) {
        d =3D READ_ONCE(*data);
        smp_store_release(cons, c ^ 1);
    }
}

and as with the previous example, restructuring the if-statement makes
"if (p =3D=3D READ_ONCE(*cons)) {" sufficient, instead of "if (p =3D=3D
smp_load_acquire(cons)) {".

Yay!


Bj=C3=B6rn


>                                                         Thanx, Paul
>
> > >
> > >     if (cond =3D=3D 1) {
> > >         smp_rmb();
> > >         d =3D READ_ONCE(*data);
> > >         smp_mb();
> > >         WRITE_ONCE(*cons, c ^ 1);
> > >     }
> > > }
> > >
> > >                                                         Thanx, Paul
> > >
> >
> > [...]
> >
> > Bj=C3=B6rn
