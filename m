Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6737A27964C
	for <lists+bpf@lfdr.de>; Sat, 26 Sep 2020 04:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgIZCrv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Sep 2020 22:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZCru (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Sep 2020 22:47:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA3EC0613CE
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 19:47:50 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t14so4051379pgl.10
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 19:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ucCrs5q3YePq0e3RQFFqaDEnUbOvguoKcGVoYbrWhf0=;
        b=aBg5JtNuxhs1Na7XMPn1DSPQq603igvsgaynA6UcbPZvBw/4AvTXEQr7ToAyohBtYU
         1qywQPXmZvtzK+dspR55IISgIuOS4Qq1fGL6qQmGhIKS8cV9U8IeoWPalK4VmbcpnYhK
         d5N36N9yFdvmOhQOEp0RTQHYdrcGuea0EShsQW3m+eOvKS4BWPaJGtgvlgCMggJM/8OE
         xwb74dcvYPDRC2+7MODHZF5Coha8XBxos+gDPo3lhfMhV2lhrSOxZLxpkQ4Ej+9E9jwd
         qtYLkWKpppquHWm/diJRZ6v0Cvsp8tIw6y2pl7dH7P/xMblDpKRC/Q9+ojnC3VumpPxJ
         X/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ucCrs5q3YePq0e3RQFFqaDEnUbOvguoKcGVoYbrWhf0=;
        b=Is2EJJxkT4vEfbxiKXL8+S62/bOouYjQASqGQWRgniIouyN3SpvcbluZOoI+aZD/F0
         uPEbw1or41lCgfGfVKLhebzXOQcgPJ1P/0t1MDrc9ivgMZzmXkKLZONVQvGbEMezZiCm
         fS44fkArXpabziIWKoEhyWep2p61gxu3NoBEWVuBJoDSGe8jLbbuwVBzDwaj2T0BNB19
         KxJ88DjraQVevYTGDQbTLFTJRYFmCegfZ1IlYRq0cIRHndsmtEBRk6RMooaLNKRcsI0+
         JpaMVgGgYyEcIs7hDrhpUBkkREwiP+AP4sKJq2LnOd8aoGjlx2OY5CIvT3/VThRA/e9Y
         iGmQ==
X-Gm-Message-State: AOAM531pkk27Od2gFj5dJYeg7cWIbRImhHSwsrwF6PHUx1lK0ZHr/mMG
        HhCIHDJ+sitlLWdg3x6MVLMJLQ==
X-Google-Smtp-Source: ABdhPJw6Q5+j8w+qr2BwQrS/6gRAyo8VRGMWToikVfUxPfTvOfnUfQPtFglZAZPSPS1aAtHVS919dw==
X-Received: by 2002:a63:e444:: with SMTP id i4mr1408075pgk.304.1601088470228;
        Fri, 25 Sep 2020 19:47:50 -0700 (PDT)
Received: from localhost.localdomain (c-67-180-165-146.hsd1.ca.comcast.net. [67.180.165.146])
        by smtp.gmail.com with ESMTPSA id 64sm3884252pfz.204.2020.09.25.19.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 19:47:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 seccomp 3/6] seccomp/cache: Add "emulator" to check if filter is arg-dependent
Date:   Fri, 25 Sep 2020 19:47:47 -0700
Message-Id: <05109FF5-65C9-491E-9D9D-2FECE4F8B2B0@amacapital.net>
References: <CABqSeASR0bQ7Y302SkZ639NM=roSVRmd3ROGm0YDEFCTxxd63w@mail.gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
In-Reply-To: <CABqSeASR0bQ7Y302SkZ639NM=roSVRmd3ROGm0YDEFCTxxd63w@mail.gmail.com>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
X-Mailer: iPhone Mail (18A373)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Sep 25, 2020, at 6:23 PM, YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>=20
> =EF=BB=BFOn Fri, Sep 25, 2020 at 4:07 PM Andy Lutomirski <luto@amacapital.=
net> wrote:
>> We'd need at least three states per syscall: unknown, always-allow,
>> and need-to-run-filter.
>>=20
>> The downsides are less determinism and a bit of an uglier
>> implementation.  The upside is that we don't need to loop over all
>> syscalls at load -- instead the time that each operation takes is
>> independent of the total number of syscalls on the system.  And we can
>> entirely avoid, say, evaluating the x32 case until the task tries an
>> x32 syscall.
>=20
> I was really afraid of multiple tasks writing to the bitmaps at once,
> hence I used bitmap-per-task. Now I think about it, if this stays
> lockless, the worst thing that can happen is that a write undo a bit
> set by another task. In this case, if the "known" bit is cleared then
> the worst would be the emulation is run many times. But if the "always
> allow" is cleared but not "known" bit then we have an issue: the
> syscall will always be executed in BPF.
>=20

If you interleave the bits, then you can read and write them atomically =E2=80=
=94 both bits for any given syscall will be in the same word.

> Is it worth holding a spinlock here?
>=20
> Though I'll try to get the benchmark numbers for the emulator later tonigh=
t.
>=20
> YiFei Zhu
