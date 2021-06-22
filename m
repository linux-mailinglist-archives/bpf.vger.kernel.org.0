Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C710F3AFFBE
	for <lists+bpf@lfdr.de>; Tue, 22 Jun 2021 10:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhFVJBm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Jun 2021 05:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhFVJBl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Jun 2021 05:01:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC36C061574
        for <bpf@vger.kernel.org>; Tue, 22 Jun 2021 01:59:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j2so34751235lfg.9
        for <bpf@vger.kernel.org>; Tue, 22 Jun 2021 01:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IgEmzdTN4HRdSGSGItritGnREG7UWG/WRpkp7ArUXcE=;
        b=rGxrgaPHp+sQC8l6VapK8a6P5JqjpCZwJMXBj5xpye8EpqoWWkNlfMdkIdX5xHnqdL
         3d7HZpEuLuxfLrsnaxPnbxThAWdjgDSMO7dFAv/gStfhd10R17bNGBDxQGTWDtNGj05s
         ousef4QBfEkd8sZfycBEZooTm6yIngfBBQhY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IgEmzdTN4HRdSGSGItritGnREG7UWG/WRpkp7ArUXcE=;
        b=g1X0MNWke4r7Bwm0lzp8HpJLHOhz4UX47l1SHQk8rqNSvaVseYwy+J/zw/6KTpsBYo
         qASwdTVhL+G54A6mv2QODAU7orHXhjiAWfNbpudy0FNRoVCYOZCqM+Iqhd+9Fjl6zIWL
         tFOIOvpCF3Y5iYsqCLE9PM3X1m9nV0BeZfXaeHWpNu0JOkiQ4nEbh5jmPmQLMSmnD8xr
         48XQNGVDAxHvJdeT2nOavRBh5WPtX3Zguty/eZs1aqtn10JL6sWF2xgmP6o7YvJVnD6s
         /HHUe8OIzk9oWrFld1nJJaUOXhYYUuRqFy1IPf3BkxhnnkZL9DGv0roovQmZUlMKTfl6
         WlaQ==
X-Gm-Message-State: AOAM530PXRNcNC+AKrjmr5hIQa/pUg6tZdYDya1hVoo2yILa9l5d9MWw
        Q3P6ZNveMHhVJLgRDcwDO5q2V8DS5iBdTwtb73vjXA==
X-Google-Smtp-Source: ABdhPJzp+TlD60AbwK4d3/UXVRAhqAIiO3g137IxT9Fo7F+PNWnfzCBea7CtOcT9B5cFOg/d8yatTDuV+UGXrgsRXB4=
X-Received: by 2002:ac2:4db6:: with SMTP id h22mr1985921lfe.171.1624352363827;
 Tue, 22 Jun 2021 01:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210618105526.265003-1-zenczykowski@gmail.com>
 <CACAyw99k4ZhePBcRJzJn37rvGKnPHEgE3z8Y-47iYKQO2nqFpQ@mail.gmail.com>
 <CANP3RGdrpb+KiD+a29zTSU3LKR8Qo6aFdo4QseRvPdNhZ_AOJw@mail.gmail.com>
 <CACAyw9948drqRE=0tC=5OrdX=nOVR3JSPScXrkdAv+kGD_P3ZA@mail.gmail.com> <CAHo-Oozra2ygb4qW6s8rsgZFmdr-gaQuGzREtXuZLwzzESCYNw@mail.gmail.com>
In-Reply-To: <CAHo-Oozra2ygb4qW6s8rsgZFmdr-gaQuGzREtXuZLwzzESCYNw@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 22 Jun 2021 09:59:12 +0100
Message-ID: <CACAyw98B=uCnDY1tTw5STLUgNKvJeksJjaKiGqasJEEVv99GqA@mail.gmail.com>
Subject: Re: [PATCH bpf] Revert "bpf: program: Refuse non-O_RDWR flags in BPF_OBJ_GET"
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BPF Mailing List <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Greg Kroah-Hartman <gregkh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 21 Jun 2021 at 22:37, Maciej =C5=BBenczykowski
<zenczykowski@gmail.com> wrote:
>
> Please revert immediately.  I've got better things to do.  I shouldn't
> have to be thinking about this or arguing about this.
> It already took me significantly more than a day simply to track this
> down (arguably due to miscommunications with Greg, who'd earlier
> actually found this in 5.12, but misunderstood the problem, but
> still...).

You're barking up the wrong tree. I don't object to reverting the
patch, you asked me for context and I gave it to you.

Best
Lorenz

--=20
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
