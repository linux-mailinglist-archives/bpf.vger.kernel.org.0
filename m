Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313A7483128
	for <lists+bpf@lfdr.de>; Mon,  3 Jan 2022 13:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiACMx1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Jan 2022 07:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiACMxZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Jan 2022 07:53:25 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC88C061761
        for <bpf@vger.kernel.org>; Mon,  3 Jan 2022 04:53:24 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m21so136737549edc.0
        for <bpf@vger.kernel.org>; Mon, 03 Jan 2022 04:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ioJ4Uhc6PcJ1xzRvOkmd3MgKuZ4E6KgfhV/AnhvGCS0=;
        b=OscO9XPJD5JDzCLzixSQumHTDox94LJeSQ0Qcr4qZEi/K8VyC1mKWUKeieM4j6cfX1
         8L4RGiPEol+KZrMfKfkncAidQZLPSTjtkxxe3xeoqbY8DZMOY0cUBCChoKTkWI9Qf8R2
         ecKVFM2EQSHZu80EsBmaP+XsN4QOVRtFJyAY22ZC+ZYXaJ7YkWeOg1Gta40XioBnQ1YD
         r3PKPgpa4rLhDrOVtwhxNX7mx3Biciiz2cCEVXtlWo9kt+WDbpA0jamBZmbasxlGupZJ
         gMm4lIEtUASZCakzi27QRGmfnokzpVFCiv3yhV1plQFXHR4+k1KqukJeQmDYUOKWDidw
         81GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ioJ4Uhc6PcJ1xzRvOkmd3MgKuZ4E6KgfhV/AnhvGCS0=;
        b=5TzOOPyhKpVhXFT5jipUJquW8QW+t5Z9bwRwMr/kOW6rQ+PkkmwNIEQTV8Mw0CnO+q
         PqNG4UR+vAD2iDSTdvzhe49FDjwsEolsTqsHAyrcd6//Dq6KyZLAUAttzQfocW8qnJKM
         7RbJgL/vWpe/XSHX668Ahc5klXFfHhhProvDPWaI5bYpyS4hFLO/ob+arxqt26uGF758
         Mh40lYugaoc/ZHwI1qTeAbvXMONr+Cc9j8jKLdjezztFTYNUN5PGFVM03WG7AWd/HvVj
         Yj2PtxFewC1K/C866w5KIuxZtPM4yiACv6ADindhu4NDT4TKNEV5eFkyI0GielUCFoJh
         w/Lg==
X-Gm-Message-State: AOAM532a9axNFrSyqRaMR3a9zwhyRhA1YjhqnffG9X6D2WTnorxpxHsT
        pPtINUuYyk2DgEedoAkCOB03v0vL7m8o3euiwz6ymJFe
X-Google-Smtp-Source: ABdhPJz5SfPoGOVP0Cp2zi76H2PbXNNjLwjefJ5z3LQ6sXPqJIcBzUzt/ll74vsFA2fSRloTMsmjW3fZWVaBbCckgDw=
X-Received: by 2002:aa7:c941:: with SMTP id h1mr44800824edt.319.1641214403073;
 Mon, 03 Jan 2022 04:53:23 -0800 (PST)
MIME-Version: 1.0
From:   His Shadow <shadowpilot34@gmail.com>
Date:   Mon, 3 Jan 2022 15:53:12 +0300
Message-ID: <CAK7W0xe9VVbyVykzTK8X8ieg4UgRJEtrvEyKgLjBO+iVFV41+A@mail.gmail.com>
Subject: eBPF sockhash datastructure and stream_parser/stream_verdict programs
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Greeetings. Here's the problem. I've written a simple program, that,
when a connection is established, it establishes a connection to a
predetermined target and starts routing traffic between a user
connection and a new connection.
I've tried to use ebpf stream_parser/verdict programs for this,
however there's a problem: when a connection to my program is
established, client sends the data immediately, however there's a
delay, while I establish a connection to the target. So stream_verdict
never gets called, because the data is already in the socket receive
queue(or maybe I'm misunderstanding something). Is there a way around
this? Should I use something else, like skb_msg verdict?
