Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602592F3D8C
	for <lists+bpf@lfdr.de>; Wed, 13 Jan 2021 01:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbhALVmU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 16:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437141AbhALVhc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 16:37:32 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C95CC06179F;
        Tue, 12 Jan 2021 13:36:52 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id n4so7254337iow.12;
        Tue, 12 Jan 2021 13:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=//9wmAe5hjhXgDXmV0ehQ+2oLUsZoz/EaOcTrmY2gvU=;
        b=pcfdxpiYPbTUd7zoF2kkzcBx/UuO9nmAF6f03LJM7mrkMpU4rIpO+BZSFevhRaCfur
         oeVEQKQwkZCH5TOPP/VK2bjw98vzfiVhl6b4egZda+yddxCgw5wxM//Y+Oa+vlEjBaMg
         g/1LF3KJwZ3n/gxG43MCAL5IMFFoielTMBMP3+psoC4Wpkb7ucPGhC54cjMUMsofJeht
         NsLSApOKO+U3+DgSMvyiHyfHCslMDOWv//pPCzPMNfIAjlthAASIizwnCDGK0Em3/miP
         SL9NizSwA7NJdJ5QgEVoPNiAidLtYpxzV0A/IWq6Vt2ma/aJVRo86qsWTS29SF+SGsOj
         zT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=//9wmAe5hjhXgDXmV0ehQ+2oLUsZoz/EaOcTrmY2gvU=;
        b=Ue24EEZLzbCt4NsQZ4HPTizELvBdEWGyxm2bXQOi7G4M3MZfaVut4LNckAEal7TEXZ
         mqbZQe9gN1sTeb4yLuU8qjyvlBwLyty/dzchJWjgXJwgJqBuPf9Vmda09ZN2adDFNczL
         qXdA3c4UjvtwJuDQjvZgU2/E4sxInNwjSbOTIxHU3FhQGHnK6E+BEFe2Okusn9VkBlym
         PY6JXIiosDRsbiwgbPGJN0bjzQbnQ9Xtb50QCB0El2hoKYMynyKiqbLA0p5d+477uqnA
         XoZiZvAwt4Hd9V+uzEigMv8vRhVNs0ADSjUq3tReMhi1Jz40/ZhaOLwZKmSqtmDMUncS
         QUMg==
X-Gm-Message-State: AOAM530/GdZM0g7YnUCZ6u42eMTjWZVtN/Pe0aZPrkkZr30gt7WDhi7I
        rzNH3wONNFfF8MrgyXyQRrnmN3egjEYlFAZiu44=
X-Google-Smtp-Source: ABdhPJzDkV9k36iPJVYoKGfBufews67nedQUdLpb+tG8eMwULCsIntR/Tx0F9JMkEhe8+mO1qiNKdOxR00jukDOIYYw=
X-Received: by 2002:a92:9e57:: with SMTP id q84mr1148874ili.112.1610487411649;
 Tue, 12 Jan 2021 13:36:51 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUVuk5PVY4_HoCoY2ymd27UjuDi6kcAmFb_3=dqkvOA_Qw@mail.gmail.com>
 <fa019010-9d7c-206c-d2c6-0893381f5913@fb.com> <CA+icZUVm6ZZveqVoS83SVXe1nqkqZVRjLO+SK1_nXHKkgh4yPQ@mail.gmail.com>
 <CAEf4BzaEA5aWeCCvHp7ASo9TdfotcBtqNGexirEynHDSo7ufgg@mail.gmail.com>
 <CA+icZUVrF_LCVhELbNLA7=FzEZK4=jk3QLD9XT2w5bQNo=nnOA@mail.gmail.com>
 <20210111223144.GA1250730@krava> <ed779f29-18b9-218f-a937-878328a769fe@redhat.com>
 <20210112104622.GA1283572@krava> <20210112131012.GA1286331@krava>
 <CA+icZUXNEFyW-fKH_hNLd+s7PB3z=o+xe=B=ud7eA5T3SW6QFg@mail.gmail.com>
 <20210112162156.GA1291051@krava> <CA+icZUU8MFFJMqFRAN7ekRzupPrS6WS5xGChUaFcjq2hfqW_wg@mail.gmail.com>
In-Reply-To: <CA+icZUU8MFFJMqFRAN7ekRzupPrS6WS5xGChUaFcjq2hfqW_wg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 12 Jan 2021 22:36:40 +0100
Message-ID: <CA+icZUV8ZASGp2pCy12fSjnYun5+DyR4D+OdNwz_+fjGU64KZg@mail.gmail.com>
Subject: Re: Check pahole availibity and BPF support of toolchain before
 starting a Linux kernel build
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Tom Stellard <tstellar@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 12, 2021 at 9:47 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:

> En plus, I tried pahole with Jirka "Convulted" Olsa (JCO) fix by passing...
>    PAHOLE=/opt/pahole/bin/pahole
> ...to my make line.
>

Grrr, my selfmade pahole misses that patch.

How can I re-invoke make ... with new really fixed pahole version?

Fallen into a (pa)hole,
- Sedat -

P.S.: Download Jiri's patch

link="https://lore.kernel.org/bpf/20210112194724.GB1291051@krava/T/#t"
b4 -d am $link

- EOT -
