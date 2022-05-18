Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2DF52C596
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 23:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243175AbiERVcC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 17:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243173AbiERVcB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 17:32:01 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2159CF68
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 14:32:00 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h85so3738362iof.12
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 14:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=PdXc6TVSuKyClsDyTvsSv3J7apTJ2YzqNGp3pw+ph38=;
        b=qtjyHDUKyvISAYGxLZJKKARZNPdtVirLfvyqyODMTvpUrvvOK16HMgEJXC3ibWeI73
         Qe5L3kwMPE96zBUMqmCJDjQ3wyYxMO/SKz14TUMAV80Kcu3vjD/0ZTLSGIU2eb7l3iD8
         CzXRopAabARLUZw73y1f++MoFGPlmtsaMyKjodQDT7Rz7IuXs0KCmCuokAVrD6CIWhgV
         vGh7pmMigJjUzZCUsw/JjdWNP9GR1n1AbtN83SfCnsgRC+UFxlEGCG2xoRFJvvwoZLU9
         0+woorDqxfB9BNeaBG4rXK8PVs9K3nm2cseBkkgGjwuXvw7+Nh9d7QoNC+VHLgOygVLA
         ygqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PdXc6TVSuKyClsDyTvsSv3J7apTJ2YzqNGp3pw+ph38=;
        b=rQket/swRmC/P5XEX3SQgYMRg0iR/wl/YyX7c+4LKlZa9wZPl/J4yEr7n7cJhzW165
         I256eCuUNgx7ZU9y177jVE97FpyH5ofXyECCjMqTvi4AzKulTohBmgGz8pBjPXGA3zuc
         4qg2B4hN3ptROJRFDV3gNPVAUEutrLSqPtXWvw1PCPi9ZMHREKHKSLQp8ck5ul2a6qCT
         FdSf52OQnRRdH9VK8nYFNRONbO6P8gDNyzsoIAwedWTSnfqVudVq2s2om5dOS3njAgOU
         gJr485QsNrJ9GEN7jWKKPRTLdAID55GdhZjYrf0stBuet6FGA8i2JaicK6lrv0S/3a3X
         2pZQ==
X-Gm-Message-State: AOAM532pgV3l71odJkDq5gFEKtXKbqEHuwjwCZXsut3kR0v7ssf/eIoT
        CMaeNNh3Ta/OKUj+XASPxsjGdkolW7FQzXvhNsBrDme7W0PryQ==
X-Google-Smtp-Source: ABdhPJyuLMKX1Poae4fEBaZPwr3N+y3GIlqFhvoV6GTR23fNq5DGRhMVuDkPalMXjLQr8Cu8BFMV8K7HxO6dGd3kxqU=
X-Received: by 2002:a05:6638:2191:b0:32b:b7af:1228 with SMTP id
 s17-20020a056638219100b0032bb7af1228mr847596jaj.13.1652909520206; Wed, 18 May
 2022 14:32:00 -0700 (PDT)
MIME-Version: 1.0
From:   John Mazzie <john.p.mazzie@gmail.com>
Date:   Wed, 18 May 2022 16:31:49 -0500
Message-ID: <CAPxVHdL-dT2GQh-HEkNjNoTEzA9DRL4W4ZfmUzc1+Bdz89fftQ@mail.gmail.com>
Subject: Tracing NVMe Driver with BPF missing events
To:     bpf@vger.kernel.org, "John Mazzie (jmazzie)" <jmazzie@micron.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

My group at Micron is using BPF and love the tracing capabilities it
provides. We are mainly focused on the storage subsystem and BPF has
been really helpful in understanding how the storage subsystem
interacts with our drives while running applications.

In the process of developing a tool using BPF to trace the nvme
driver, we ran into an issue with some missing events. I wanted to
check to see if this is possibly a bug/limitation that I'm hitting or
if it's expected behavior with heavy tracing. We are trying to trace 2
trace points (nvme_setup_cmd and nvme_complete_rq) around 1M times a
second.
We noticed if we just trace one of the two, we see all the expected
events, but if we trace both at the same time, the nvme_complete_rq
misses events. I am using two different percpu_hash maps to count both
events. One for setup and another for complete. My expectation was
that tracing these events would affect performance, somewhat, but not
miss events. Ultimately the tool would be used to trace nvme latencies
at the driver level by device and process.

My tool was developed using libbpf v0.7, and I've tested on Rocky
Linux 8.5 (Kernel 4.18.0), Ubuntu 20.04 (Kernel 5.4) and Fedora 36
(Kernel 5.17.6) with the same results.

Thanks,
John Mazzie
Principal Storage Solutions Engineer
Micron Technology, Inc.
