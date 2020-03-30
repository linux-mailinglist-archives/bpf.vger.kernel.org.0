Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD091982D3
	for <lists+bpf@lfdr.de>; Mon, 30 Mar 2020 19:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgC3Ryj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Mar 2020 13:54:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33765 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbgC3Ryi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Mar 2020 13:54:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so22842878wrd.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2020 10:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utW+7YJkRuGqH8XK7nqVWH149nVP6e/z3NiTESoZJ6I=;
        b=FUM/Log5Gw5uixyZLFfSJCSdgQdC9uA76xrChs16wy5iNS75Rmzu4dn06dHbbaqEit
         ghRrrro2jkjKhoIsDZgxiwceZIGwOOz9ZhOJQ8t7wUcny1DlafqxQZ7bfiYypLtBEBZj
         9WolA73ts7cOv3ZaPB3DCzcc25CpUytxEw5pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utW+7YJkRuGqH8XK7nqVWH149nVP6e/z3NiTESoZJ6I=;
        b=Y1hKauwzxhX14r/1WTnHgblSklG1h14FxgmbR/vAB46qQ3eKqsmIkjog+fvM8Ucecd
         JfZtR+gmWGEZsLqFvD3N5OX1zMkD74BibYmVEOUS12k1olowwI8wAw5JBlq3RficQuFd
         fbFOJzoxZWf987Mfa2UEkL6xdlg8a5ktnS2TOviFpppnmnUoxJecxJvOeV7jsCM+G6A7
         atCxacMDD7YO6OM/L/+TTIJVyZaa3p+vMuZ6T2H/08CTEdwtgCGgR3Am3Eok7Bzqs7Oc
         fkK6xvvg9jhgIeC2MNdFdlRs/3uh0XTTLUpxO1nf6oci+bb+bgaq6fg1SZSfkKOac1Gi
         LUbw==
X-Gm-Message-State: ANhLgQ1btKWcqxn+sx2GOU0Iqy1cBlsEFHq45pN1QgolWuJnj4pzItcN
        n1GessDEInn6EDwDiBax/0Kvb0Fuu6p1HJZ1PjxUG03E
X-Google-Smtp-Source: ADFU+vsUn9IsKe0gSvckJlw0u4Px0D/tzS/kNZ/jnXIKvDX6ef/ApzKlvKspnJvAglkMak8cC2//FXu1A1VOWCpgq60=
X-Received: by 2002:a5d:4847:: with SMTP id n7mr16829913wrs.182.1585590876589;
 Mon, 30 Mar 2020 10:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200330204307.669bbb4d@canb.auug.org.au> <86f7031a-57c6-5d50-2788-ae0e06a7c138@infradead.org>
 <d5b4bd95-7ef9-58cb-1955-900e6edb2467@iogearbox.net>
In-Reply-To: <d5b4bd95-7ef9-58cb-1955-900e6edb2467@iogearbox.net>
From:   KP Singh <kpsingh@chromium.org>
Date:   Mon, 30 Mar 2020 19:54:25 +0200
Message-ID: <CACYkzJ72Uy9mnenO04OJaKH=Bk4ZENKJb9yw6i+EhJUa+ygngQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Mar 30 (bpf)
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks for adding me Daniel, taking a look.

- KP

On Mon, Mar 30, 2020 at 7:25 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> [Cc KP, ptal]
>
> On 3/30/20 7:15 PM, Randy Dunlap wrote:
> > On 3/30/20 2:43 AM, Stephen Rothwell wrote:
> >> Hi all,
> >>
> >> The merge window has opened, so please do not add any material for the
> >> next release into your linux-next included trees/branches until after
> >> the merge window closes.
> >>
> >> Changes since 20200327:
> >
> > (note: linux-next is based on linux 5.6-rc7)
> >
> >
> > on i386:
> >
> > ld: kernel/bpf/bpf_lsm.o:(.rodata+0x0): undefined reference to `bpf_tracing_func_proto'
> >
> >
> > Full randconfig file is attached.
> >
>
