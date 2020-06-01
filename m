Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DA51EA5A9
	for <lists+bpf@lfdr.de>; Mon,  1 Jun 2020 16:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgFAORa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jun 2020 10:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgFAOR3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jun 2020 10:17:29 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1F9C03E96B
        for <bpf@vger.kernel.org>; Mon,  1 Jun 2020 07:17:28 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id s192so33159vkh.3
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2020 07:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UAQJNjh7sRf2Cf1Bk6ynLbxvnhlbNeQeUkOKz5rocIs=;
        b=VJ3ZHeXUmfRCC3QuaYz7p8MlILG5MWfbRpSJQIYb1h/cuLCjL9dP+mGPn1+p+gwNgz
         9kke34L3xYaxZxZ7D+344rt2MyRG+OcBYlhmHYZhzypdLEheWOEpvV7ghDSn7nmPIdmV
         ZunkPhgtHZq/pQqpPtZRrBLwDf66x08tPnMrkl2uf9o1jR+2BiJM2CUzs4vCAhOcYwZm
         iyDrmgA1OUDhhLjV+yT1lo1bDzN4WzK7zf9OVMqp9JRLYkO9rt9CM1QpBiloaPUspAJl
         5mWG7FCyxmB10i6CeCtpAkh9cbw1O4+yTZ+0ahuKFgJbg/Bpd5ZakJsDxYlRrLfFgf6r
         OogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UAQJNjh7sRf2Cf1Bk6ynLbxvnhlbNeQeUkOKz5rocIs=;
        b=miVtstMK4JeVt9dYHthR270KDMDRXORiAesi96GiAhQ8AX/kBUo54BN0We+iIRHN6y
         EREarJCuV6KkdMvhNoVLQNXtwTrwd1nKm7C81CiNIHuujOUKjG0vYcI+CmWSq7qU7e7C
         P+VJ+ntagr1ITgkwO7TIWxwoU1cs6yyH3FOZVytfDulbXCMP3DahYDwExmupAnzPGhkA
         iy6HPum4gss743KsGKsWiOg251+tN0+2VSB26t+M1ny20iXXLooUbApeXzXis7cwqV2D
         yo1q5YC0HQQHC+Ah+lfXx1qhsRxwOAw65fj32cpk27lX51bGJ1bfneiDwtuC7niIrl8v
         5Pcg==
X-Gm-Message-State: AOAM5326U3hNVMt6+Zzrc2Oyl3gsvmpaHdFC+0MTsDMZ1kUcPJ1iHJtm
        QWnyiOOdx1hs3Ucj4WQr7b+HbdBjSqvcRzISz74=
X-Google-Smtp-Source: ABdhPJzdMPBreuQ8g7Q5N6YHc7aKBqireqh4fEqWaMpIFB6nqeweCbV1gu6t7/Zr0PNi+V8AmaWICuVNiHNeHIMORnY=
X-Received: by 2002:a1f:1b8d:: with SMTP id b135mr14051808vkb.46.1591021047533;
 Mon, 01 Jun 2020 07:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <8f6b8979fb64bedf5cb406ba29146c5fa2539267.1576575253.git.ethercflow@gmail.com>
 <cover.1576629200.git.ethercflow@gmail.com> <7464919bd9c15f2496ca29dceb6a4048b3199774.1576629200.git.ethercflow@gmail.com>
 <51564b9e-35f0-3c73-1701-8e351f2482d7@iogearbox.net> <CABtjQmbh080cFr9e_V_vutb1fErRcCvw-bNNYeJHOcah-adFCA@mail.gmail.com>
 <20200116085943.GA270346@krava> <CAJN39ogSo=bEEydp7s34AjtDVwXxw7_hQFrARWE4NXQwRZxSxw@mail.gmail.com>
 <c27d3cc2-f846-8aa9-10fd-c2940e7605d1@iogearbox.net> <20200212152149.GA195172@krava>
In-Reply-To: <20200212152149.GA195172@krava>
From:   Wenbo Zhang <ethercflow@gmail.com>
Date:   Mon, 1 Jun 2020 22:17:16 +0800
Message-ID: <CABtjQmaDg_kzuDrANQi8rWhZWGarP8OkiZtzi+XWvC-T9Jmz+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v14 1/2] bpf: add new helper get_fd_path for
 mapping a file descriptor to a pathname
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jiri Olsa <jolsa@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Brendan Gregg <bgregg@netflix.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

I find https://patchwork.ozlabs.org/project/netdev/patch/7464919bd9c15f2496=
ca29dceb6a4048b3199774.1576629200.git.ethercflow@gmail.com/
this PR's current state is Awaiting Upstream. I don't know much about
this state. I want to ask if this PR will be merged.

Thank you
Wenbo

Jiri Olsa <jolsa@redhat.com> =E4=BA=8E2020=E5=B9=B42=E6=9C=8812=E6=97=A5=E5=
=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Feb 11, 2020 at 01:01:16AM +0100, Daniel Borkmann wrote:
> > On 2/10/20 5:43 AM, Brendan Gregg wrote:
> > > On Thu, Jan 16, 2020 at 12:59 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > On Fri, Dec 20, 2019 at 11:35:08AM +0800, Wenbo Zhang wrote:
> > > > > > [ Wenbo, please keep also Al (added here) in the loop since he =
was providing
> > > > > >     feedback on prior submissions as well wrt vfs bits. ]
> > > > >
> > > > > Get it, thank you!
> > > >
> > > > hi,
> > > > is this stuck on review? I'd like to see this merged ;-)
> > >
> > > Is this still waiting on someone? I'm writing some docs on analyzing
> > > file systems via syscall tracing and this will be a big improvement.
> >
> > It was waiting on final review/ACK from vfs folks, but given that didn'=
t
> > happen so far :/, this series should get rebased for proceeding with me=
rge.
> >
>
> Al Viro, any chance you could check on the latest version?
>
> thanks,
> jirka
>
