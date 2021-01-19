Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339BF2FBBB3
	for <lists+bpf@lfdr.de>; Tue, 19 Jan 2021 16:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391496AbhASPxU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jan 2021 10:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391424AbhASPwe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jan 2021 10:52:34 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED2EC061573
        for <bpf@vger.kernel.org>; Tue, 19 Jan 2021 07:51:47 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id bx12so8082775edb.8
        for <bpf@vger.kernel.org>; Tue, 19 Jan 2021 07:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gi7NaaMwzxna30S9SCq0ouZ89JSSV2+nlBXJEmHhM/8=;
        b=V0/XJpdL97GpkEviMoNOxzcEE5eBL4nuWZZsBhe3xYlgFKB4fdpGSmy2m0gcmlc0gJ
         8Q/n0DuXoCvklJsWP3ZEtQ59E2HGv1i+xmmiB34AcYNFouIsJB1kEGuqQ2qeO6yrK/1B
         thM7hFuICr2bMMurYeNQoDscVD7JqsA6+r/Gbx9xt3RcbjzaaepcEhkh+vYa/iSo/WQb
         oV/tiL53cLqRhNmN87yCqZIpiv0TW3442zAUB7jiDIc+MbWEmAqp0UOve4TeD1EK3Ewj
         Xx/JlJrnOTPohdDU8wcDc+zuhkIDPfF8nqGkPkDitme3C+2/H73gu5yXjxxzUqhUcWhj
         PYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gi7NaaMwzxna30S9SCq0ouZ89JSSV2+nlBXJEmHhM/8=;
        b=Xkp7i51L+s+7nq1mv9cmaLUrmRvmYryqWGY4OG1rCvZZTtqFETSK+1kxtP235485OY
         oet/Zfm1edOXcq7fH7LPgarQRvvZSM1CAdpUEi2hv77RSotLjl6zgl6MeZOHHWieP0xh
         +6QPJ4hq1W7o7zBSWdymebUdLjC0jM+OnhBdoisk66Xz1O6fEqNL5Fsd2u5bNqoDKg/7
         Uhd/esEZ9kA28gYxp09zSHuY3mZA4bDQgqNJ9t8o0ZXAYbT6Lbia1sny/FM2CNFTUM+9
         wwDNCJwbG1xJH83ICVV4T10/HqLrhqhGiqFtQl4HgCekXxJL1FcWhBgW1XsYAkwCEDep
         GfXw==
X-Gm-Message-State: AOAM533zLOSsBXzGsmWj1wmif20o9UJllFm+eUhvPhA2ukYdc/Q3Hfit
        ykTT88JH6jAcEpmBVDyZ/mggX3KSI5xTG70Enps+4rtAUtc=
X-Google-Smtp-Source: ABdhPJx49Ch1watKfKzuV2UOn+HebPinqtFz8OCKIQlSvZBd4a5pehprgWYXXEsnStCm8p/RQgbjdH1rpvW4djnA6XE=
X-Received: by 2002:a05:6402:2043:: with SMTP id bc3mr3885950edb.28.1611071506268;
 Tue, 19 Jan 2021 07:51:46 -0800 (PST)
MIME-Version: 1.0
From:   Gilad Reti <gilad.reti@gmail.com>
Date:   Tue, 19 Jan 2021 17:51:10 +0200
Message-ID: <CANaYP3ENW8FV=CsKFmvpqCvbwzz5z2dLmBzrsO9QePVPuyaxXQ@mail.gmail.com>
Subject: libbpf ringbuf manager starvation
To:     bpf <bpf@vger.kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, assaf.piltzer@cyberark.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello there,

When playing with the (relatively) new ringbuf api we encountered
something that we believe can be an interesting usecase.
When registering multiple rinbufs to the same ringbuf manager, one of
which is highly active, other ringbufs may starve. Since libbpf
(e)polls on all the managed ringbufs at once and then tries to read
*as many samples as it can* from ready ringbufs, it may get stuck
indefinitely on one of them, not being able to process the other.
We know that the current ringbuf api exposes the epoll_fd so that one
can implement the epoll logic on his own, but this sounds to us like a
not so advanced usecase that may be worth taking care of specifically.
Does allowing to specify a maximum number of samples to consume sounds
like a reasonable addition to the ringbuf api?

Thanks
