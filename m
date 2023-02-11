Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4E4692EF6
	for <lists+bpf@lfdr.de>; Sat, 11 Feb 2023 08:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBKHJA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Feb 2023 02:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBKHI7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Feb 2023 02:08:59 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E4232CF6
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 23:08:58 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id x40so11672135lfu.12
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 23:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gG2bwUXIP61zGd1tmGDPnIS3wZmxKRhgu2x3mZQdWR8=;
        b=HIJaNLDxrEQJn/Mqr29kpolx4DCKIqK6OyB8qYnkh3GHbNSegVbE1oVY1P3UIHSe+y
         uthXqPiPs4/AGeZV3h2hHlHAezAm14ODnU1H5a0O2uAuxT9YxcpQu/f+6bUaaG6yO4Fd
         /fLqecGrWNmjB/RgEJn6YVV9ycf/ZIN2xAoGSKcXNm+rfUzHfiPgiD5RgQSOdMjRVgFz
         nZYOf9S2NTtMWM7Sb3IDdtvm7Y7x++EQHrFauBsIJdajIjxL20xhc6TXr9Q9MIfD0L2s
         ZyUFOElgn9YGNVKDAxmakBdukPnvTEzVC1iSKHL4IVM8S1hEMZlr5O6jmeNAKBOrjYRI
         GpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gG2bwUXIP61zGd1tmGDPnIS3wZmxKRhgu2x3mZQdWR8=;
        b=TDrNi0R/l/j8MoDJlRkYj7nyNwKKoBivc7iHUZkJ5+pSy6PAMD5uDtqI1BGreJKRKD
         n11dQrPlkekxotCX7pDxj2lHyxFB7U83vXo8WP//DCPDO+RGG94aa0Rrne59kIi/wdHW
         4lFWUCEbohceYeH+ZNGimHutmSM4R03X1eGc8UNO+mhc3jlkKREh92YDaGvv4wpzQlDp
         o2fPe9eiybR0s+V1o1jM5ttY1GA7/tWXBTeyl9bwm19BcX6t/r9Q9U6uNXgykhArF6qe
         xYkgqCKhWHxc1M98Ix/QqoCeJv82zlSEwUSEUWktVb/BoQBT3QBNQmJuy09OZuoP69Sx
         qa2g==
X-Gm-Message-State: AO0yUKUKxJzTU0oHEKEMABYWVS5YRVsUyUNdjdzju0CPux5RwPx6QTau
        ymDzxTcH2Zw4xrrdcidsDq49u/vstAbNMOQmI34=
X-Google-Smtp-Source: AK7set+7Uhk+oieBYYlXpJFntdCBB4LOp2KtrZ7AbtNB0jrXPjfdjHnnumsIfynDMXTj+9lJTS/jZttpNM+FzYO8mTg=
X-Received: by 2002:ac2:4a64:0:b0:4d8:580b:2f23 with SMTP id
 q4-20020ac24a64000000b004d8580b2f23mr2945961lfp.132.1676099337012; Fri, 10
 Feb 2023 23:08:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:651c:1a29:0:0:0:0 with HTTP; Fri, 10 Feb 2023 23:08:56
 -0800 (PST)
Reply-To: loubes1212@gmail.com
From:   Mrs Louisa Besson <78055889a@gmail.com>
Date:   Sat, 11 Feb 2023 07:08:56 +0000
Message-ID: <CAEMAy4FirZ7MmM0pStzJMYEcMs1eKT6roQ2c5hOZ5=BQs_TFfw@mail.gmail.com>
Subject: Best regards,
To:     loubes1212@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello my friend,

How are you doing today, I am Mrs Louisa from France, I am writing to
you from my sick bed. I urgently need someone I can trust with a
donation for charity. I will contact you with more details about the
donation immediately I read from you, have a great day ahead.

Best regards,
Mrs Louisa Besson
