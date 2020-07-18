Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B37224D1D
	for <lists+bpf@lfdr.de>; Sat, 18 Jul 2020 18:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGRQqW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Jul 2020 12:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgGRQqW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Jul 2020 12:46:22 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E675C0619D2
        for <bpf@vger.kernel.org>; Sat, 18 Jul 2020 09:46:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id b9so6762768plx.6
        for <bpf@vger.kernel.org>; Sat, 18 Jul 2020 09:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=eYKC7xD1BXJTtPGIfQSAHoHuwUxup8dsR9UzHTh14Bw=;
        b=k3zhHAVqOofU1sAmN5KjAWDv9xPHrapPeYvftccLJgSf13dx+CB3q+MNAQ/tw+U9i6
         aFrwqpY3t/Pe4QQAB2xWfhDchNeysoO6y5/A+do3o47OiMmLgnahXQvFM4WGEBlnaX7J
         hltYMuiQwCicXXo61xuRnH6NEf/yWm6UAspWLmG0B+ZEW1c7Jaz2rAsStfCZExs9syE9
         cpPtLTmQYGtMZYZvLZL4vDl91sdLlrcMGUKC6ApLjVuI5CkUu681yK74gEmdAt5SfHkA
         gjVdq1LD8CAiVgDBMtEs22vxUl3NfHHK7Uud1FuHbe1Y1/ksqQyqIntpXtoYi2sV/UL8
         s88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eYKC7xD1BXJTtPGIfQSAHoHuwUxup8dsR9UzHTh14Bw=;
        b=ACRNTiT1be41MeetFyEUh0kbpNUxIZGVNibkw91smcIqrxf1dbDwP6ccECOZgyLcht
         8iICEIgXLRPyHwe29lF1TISMtnNcG2+IDWpj/Laouq8UcBIbU+Qi3PVzibTTiMgjf8Dy
         d095xPIYBN4UzdoNwIrDcZjgMYY8Eo76Owg3cZejdxxunuAmW7HnCW5uvFrji8Yp6wHH
         dzIbWR0SApVVXU5lTYAUhZcx+3hImRr6znGzLoQajrRkWe3ApDmm/bsTP/Nx98gAe5KB
         UczO1Rx1ZNVqjNHaTfoblPTxnqmBCBmyyVvMfgfXVtlaftQJyk9txAHGn4zkplKz9rLh
         1Grg==
X-Gm-Message-State: AOAM530doIaBShglZ18PigF6YHbgHbIq+/Uc9QUXHtj6Xqjp5sMhP1LK
        SNTcVZAMN8r4z9AvhV9UjXesiGMQg4uSCvMPtUnnVx4fvJQ=
X-Google-Smtp-Source: ABdhPJyrtSAd/dbVpBkfuDQ+T0aAx0tGqdhuZbhHx70ABGEb9LPxSELh4QdlvdG4999bKHabuETY10SenZ63hWgWlrg=
X-Received: by 2002:a17:902:7683:: with SMTP id m3mr12008849pll.182.1595090780646;
 Sat, 18 Jul 2020 09:46:20 -0700 (PDT)
MIME-Version: 1.0
From:   Venkata Sai Reddy Avuluri <avulurivenkatasaireddy@gmail.com>
Date:   Sat, 18 Jul 2020 22:16:08 +0530
Message-ID: <CAJW+K3E-O3-kT_Q3kba_pTmFj7h-LvP01FpTj=4Rv=DX+M3BGA@mail.gmail.com>
Subject: Doubt eBPF
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I am Sai Reddy  an undergrad student in Rajiv Gandhi University of
Knowledge Technologies  in Basar, Telangana, India.

As of now for Summer internship, i am doing in IIT Madras, We are
working on some message filters.

My professor questioned my team "How is BPF happening inside the Kernel?"

More precisely he pointed out that something.. When we said ," When a
kprobe is used, some BPF instruction's are going to happen before
actual syscall instructions happen"..He questioned us back, "Means
it's actually modifying the underlying syscall instrutions...with jump
instructions..is that feasible? and we are actually making an extra
overhead too?"..

We tried to explain as much as possible, using XDP at NIC level..and
many more..But the Professor is asking "This internal modification of
instructions is really useful?"

And one more question I have, "How does a BPF program know a
particular syscall has happened. Is it going to check always, Where
for checking some set of  instructions executed again?".

I hope you will reach me back with answers to the above questions.
Thanks for your time and clarifying my doubts.

Regards,

    Avuluri Venkata Sai Reddy

    B.Tech 3rd Year(CSE),

    RGUKT IIIT BASAR.
