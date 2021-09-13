Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37384097A3
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 17:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245163AbhIMPmY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 11:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242449AbhIMPmU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Sep 2021 11:42:20 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F247EC025243
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 08:03:44 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id l9so8712857vsb.8
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 08:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yFrXwE1QgNweyFQEjFRyquhl24AehQMld6/MpS9y62g=;
        b=FdzA5lte+TIsp/Ag9FVg03qd9Sumqt/lQ7z4Gv4ZTd4n1eFPPOkg2b8sH+yN3/xE0D
         LQzhs+8UD0mkChZCIF0OOw3WItrv6BDjHf0keHpxJYfYUmbcFDBLDcv1zh285DouNxEE
         Z746TkJInwnyUt/P+xS1ewSTpoVEiJpDuSKYzUBfUEmdGKKDjs1NHwUBBXhvpzP470bw
         mYd/dTBXvuiAmBV0rAvOU4wCVzqCVupgED2cx7B+imyBJ88mIzK3Zrbw53KsmW1dolhH
         WfS3UkoL9s4MsueoLvAeE54pVqDDQoXstyKBfIZuT6+J0P98rlF0rYS/5Hk2u2Kp4+xT
         xS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yFrXwE1QgNweyFQEjFRyquhl24AehQMld6/MpS9y62g=;
        b=czo7FVM2pWoWkn+aiPWWcjd8Lysm2mObkdu0rQYODLwbN56qGl8LUN7/zIykmIfRk2
         I3PHKknjZ+rTwqrc8xiZqtMEZPChtJCVXe0i8ZH/Kgo+G7w7WgLcxNfyQtGk18njd9cV
         gj6J4WnFSWGoXfChMUTgy+x0+RQZ7CxDrkN3FvQeWUTXpsUanHJAW63MWsI3Y/V8gs/1
         M8ie+VmtdVoIvaXlV2rr9adV39PfTRG94WuFn39hocqiI2F8F3pr3AguuGCjFaYdHrfT
         d6Dm7c4+KTUzX9u7/7jnW0gSuR0RpQrNQABM9tvIMLbGexl6buPQo3/mOelIOQuMVh1W
         QTYQ==
X-Gm-Message-State: AOAM533gkCto9htPIHWTqvzC6znFbDu08I+IA75I+lfd5CoUzGC5LEJ8
        ktrtHuVb5SrLNxSYbMS7R3BjQjry+wsUyfV+kK+McCF4CQ==
X-Google-Smtp-Source: ABdhPJyijC37xSD741ip8Y+m/OZviOPJPNQYqmaSvDUWzf37kj1MtYO/uuu3lFKerYVms/NqRXvqqaL47C7eCi23VUY=
X-Received: by 2002:a05:6102:1d4:: with SMTP id s20mr1697537vsq.3.1631545424093;
 Mon, 13 Sep 2021 08:03:44 -0700 (PDT)
MIME-Version: 1.0
From:   Tal Lossos <tallossos@gmail.com>
Date:   Mon, 13 Sep 2021 18:03:33 +0300
Message-ID: <CAO15rP=00cCXkyV83JQq0xwgcFviKn0y92ggtos52qHZO01dhg@mail.gmail.com>
Subject: bpf: bpf helper with locks
To:     bpf <bpf@vger.kernel.org>
Cc:     yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello!
I was planning on writing a bpf helper that calls a kernel function
which has locks in it.
While researching about it I've encountered this mail:
https://lists.linuxfoundation.org/pipermail/iovisor-dev/2017-October/001137.html
Is this still relevant? If not, do I need to do something special in
order to implement it? or can I implement it just like any other bpf
helper.

Thanks.
