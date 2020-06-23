Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABF22049C8
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 08:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbgFWGUk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 02:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730510AbgFWGUk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 02:20:40 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA68C061573
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 23:20:40 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h23so7461150qtr.0
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 23:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=77dIgLqokyJR5uLJs7A2qr5345Przw4e50lni9ODQpI=;
        b=p3f2vKOXzNM5DcnEKLGT3ePnmBp3wWljshaM4Cg78pSR+gNjAWPODug8ZnkRRjjmL5
         FQQNH6uYqLH1amjeh4mEWHRPlLOetOAW74zVF9PfTdspDqVeojIjr1nXd1eA+2NpMGwD
         3zxMAZjD6a5yNSPWAePCotdgN9EQffkpLeYukelGJL7HS+QcREOADu3FwIiEkTapwVvv
         TT5NDQwPvnGYHMgugw7XN232w8zRWAVovo1pl8t5zUm168vIixTu9aYeEeKdRb+XupBg
         OzMAAyI3OhoD7suUg0uZb79iF+vRQJdZ9YtiV8/bo+QWdBNW8WVjbsOVftNp7A76AqvS
         Casg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=77dIgLqokyJR5uLJs7A2qr5345Przw4e50lni9ODQpI=;
        b=tTNR7Kf1LpnjR2tTarUAFfA8dCUDzOMzhlpDCKHCU/W7+tTKqTPUx7LxiTnHdOBUOA
         1/3zUKZzmwlPsVCqT8wOhB882YbBuehy8YtPgaw+mRSZdtKg1wglrJcqMGVu0+DdnekX
         PKVuDzWmnmZ0YsiVOlovdH3NWCtvmtRw8JnoMqiaKKBzR62T6LfzV713Ni1vAbkY12aw
         /8+vBfjQme9WIWJJbLWpVye/1v7TeEMPMQexFW/kJetRWef5crzYzudhbw2m8AF//jVD
         0RTr3fI+MrgqzPgx0CryAYMjuVfZVuVaQTVnPYdODtMwJNSJNU50ty9jgoy12vseNXBV
         zt0g==
X-Gm-Message-State: AOAM531UBW5LiXPgKKRFWLh6G1eQN32lPLTBXgpRrzB754l7MVjPrFqq
        OG9BUADN/wt3USLBP6bTwGRNNDvfq9fDaDffGFqMD0mF
X-Google-Smtp-Source: ABdhPJx9qidJw+o/fO5in+yQGD7L3Tp2IP51NmLt0t+awavo0ROAmmlCUo24Ntl00KLtUNT/YkIvYgT5YQo56982INE=
X-Received: by 2002:ac8:8c6:: with SMTP id y6mr14027785qth.99.1592893239394;
 Mon, 22 Jun 2020 23:20:39 -0700 (PDT)
MIME-Version: 1.0
From:   Yahui Chen <goodluckwillcomesoon@gmail.com>
Date:   Tue, 23 Jun 2020 14:20:27 +0800
Message-ID: <CAPydje97m+hG3_Cqg560uHoq8aKG9eDpTHA1eJC=hLuKtMf_vw@mail.gmail.com>
Subject: Talk about AF_XDP support multithread concurrently receive packet
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I have make an issue for the libbpf in github, issue number 163.

Andrii suggest me sending a mail here. So ,I paste out the content of the issue:

Currently, libbpf do not support concurrently receive pkts using AF_XDP.

For example: I create 4 af_xdp sockets on nic's ring 0. Four sockets
receiving packets concurrently can't work correctly because the API of
cq `xsk_ring_prod__reserve` and `xsk_ring_prod__submit` don't support
concurrence.

So, my question is why libbpf was designed non-concurrent mode, is the
limit of kernel or other reason? I want to change the code to support
concurrent receive pkts, therefore I want to find out whether this is
theoretically supported.

Thx.
