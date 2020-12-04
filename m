Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7562CF381
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 19:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgLDSB4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 13:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgLDSBz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Dec 2020 13:01:55 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85978C0613D1
        for <bpf@vger.kernel.org>; Fri,  4 Dec 2020 10:01:15 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id o71so6224867ybc.2
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 10:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zFhPipVq+wOIS3JSqfrNb9UFkGARTubf+hBXQ19HBaM=;
        b=gDg2ut+wtcW9KGwvsUor6+7rV++DRM2Baw9vWwZ7RurE/8BKLAASB92DiC3kzvcvMt
         wg+OCMZjGvpa9c0Ez71MZ+l1pGZ0twORaWtbLfMviU6yoSV8fOFhSlmTz+v4zFbcvv9K
         YNic28xTGEDjsujBzMGUD2Yeflg3wW7kFxBvQGSCLmVzg1ZlU7O3XJ9+fDMWQRdp75pb
         xoa/LlAfzwdqV2MxrA8WfHagJMhANftZu4PuRlkZPaHkVlbH0pvGDERtSYW2H98NKtyN
         7gK/hdtcCU3VWlD/ceSeyq1SK/09YNqoue51ClXl+WeaepwXHPW5YNDBY5iFqaSk9xgD
         gMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zFhPipVq+wOIS3JSqfrNb9UFkGARTubf+hBXQ19HBaM=;
        b=spT/ApWOuuxx1SBgWwn+c6So5OmRS3aJwWPiZRpBEirYqR03ZTBd0tiyuzmzJf+CIM
         bskr3TDjLZj5b69zAZeXRnbh4noccEHz2xMwbfycPCQaSW2WYqGAI8sWjcuWY0mojin2
         Rk1ddwbIuordWTzq3ZlB2AoAIlHFgdUArxzyfHttnuPKse4A0sCBSsG3HVonLf6XnYhe
         hxkLiZ6H3vRM9ROP3njgmKZKsO32IhoXEaDJUq4qebPuToiXw1Ns2Xe+OZrhH3vUnod1
         oeIb7vyqeFcugrNzuy6OB32Qkqgcg+zCurirsGd7nHkf9scsq43Io85bh1oXrAXyFyXU
         ho5w==
X-Gm-Message-State: AOAM53328GMw3jSLvXj4iW50hOM8YbuxULysPHxhjAVzLhGrdGfI6iyv
        xguXZ4HHd6fefWKWxicXs3lvuiQkibczknJkQQbuAIiJy+vzpQ==
X-Google-Smtp-Source: ABdhPJw+1/cQsfCvBeRiWng68zaH566dg4i81QTUC7mEND1d7+Q345oH8y5/xxdT6s5rSW/+/BpHxa1Za6256NdDYRA=
X-Received: by 2002:a25:6a05:: with SMTP id f5mr3922245ybc.459.1607104874736;
 Fri, 04 Dec 2020 10:01:14 -0800 (PST)
MIME-Version: 1.0
References: <CAO__=G52s_=2E4wF8wDcgc3KwMU0kzmDfBQhDD3+LMZ8M3fZ8w@mail.gmail.com>
 <CAEf4BzbKtAcO81ZvxOJwhpOKauDQ==Y+Bcvy4_QAF3FZyLbMeg@mail.gmail.com> <CAO__=G5ReWaSsHUmkHk53LF8nBQCU_RtVoLdi=AXMDZX1mfu4Q@mail.gmail.com>
In-Reply-To: <CAO__=G5ReWaSsHUmkHk53LF8nBQCU_RtVoLdi=AXMDZX1mfu4Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Dec 2020 10:01:03 -0800
Message-ID: <CAEf4BzaUA9DUdJ5BNSsArrtOqV1UrUw+8eU90UzjpW9O10PJtw@mail.gmail.com>
Subject: Re: Problem with BPF_CORE_READ macro function
To:     David Marcinkovic <david.marcinkovic@sartura.hr>
Cc:     bpf <bpf@vger.kernel.org>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 4, 2020 at 6:23 AM David Marcinkovic
<david.marcinkovic@sartura.hr> wrote:
>
> On Thu, Dec 3, 2020 at 9:35 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Dec 3, 2020 at 4:20 AM David Marcinkovic
> > <david.marcinkovic@sartura.hr> wrote:
> > >
> > > Hello everyone,
> > >
> > > I am trying to run a simple BPF program that hooks onto
> > > `mac80211/drv_sta_state` tracepoint. When I run the program on the ar=
m
> > > 32 bit architecture,
> > > the verifier rejects to load the program and outputs the following er=
ror
> > > message:
> > >
> > > Unrecognized arg#0 type PTR
> > > ; int tp__mac80211_drv_sta_state(struct trace_event_raw_drv_sta_state=
* ctx)
> > > 0: (bf) r3 =3D r1
> > > 1: (85) call unknown#195896080
> > > invalid func unknown#195896080
> > >
> > > This error does not seem to occur on the amd64 architecture. I am
> > > using clang version 10 for both, compiling on amd64 and
> > > cross-compiling for arm32.
> > >
> > >
> > > I have prepared a simple program that hooks onto the
> > > `mac80211/drv_sta_state` tracepoint.
> > > In this example, `BPF_CORE_READ` macro function seems to cause the
> > > verifier to reject to load the program.
> > > I've been using this macro in various different programs and it didn'=
t
> > > cause any problems.
> > > Also, I've been using packed structs and bit fields in other programs
> > > and they also didn't cause any problems.
> > >
> > > I tried to use BPF_CORE_READ_BITFIELD as stated in this patch [0] and
> > > got a similar error.
> > >
> > > Any input is much appreciated,
> > >
> >
> > Can you provide libbpf debug output, especially the section about
> > CO-RE relocations? Could it be that this tracepoint is inside the
> > kernel module?
>
> You're right. The problem is that this tracepoint is inside the kernel mo=
dule.
> I recompiled the kernel with CONFIG_MAC80211 flag set to 'y' and the
> program loads
> successfully.
>

Ok, just as I suspected. With [0] and [1] (and using pahole 1.19+ to
build the kernel and modules), it should work even for modules now.

[0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D395715&st=
ate=3D*
[1] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D380759&st=
ate=3D*

> Thank you very much for your fast reply.
>
> >
> > > Best regards,
> > > David Mar=C4=8Dinkovi=C4=87
> > >
> > >
> > > [0] https://lore.kernel.org/bpf/20201007202946.3684483-1-andrii@kerne=
l.org/T/#ma08db511daa0b5978f16df9f98f4ef644b83fc96
> > >
> > >
> >
> > [...]
