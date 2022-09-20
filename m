Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C55E5BEB2B
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 18:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiITQg3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 12:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiITQg2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 12:36:28 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D6152E7A
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 09:36:27 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id g185so1705188vkb.13
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 09:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=dQ4iP81+oQaSsmV5GZL5oFAi+00oM3JUBDEqklqpocs=;
        b=kftph8m1puuuj2McDOER3GAJcPdKd4V9vtsnxZ8auLWPzc5rKsaYNXxAUBCijqcTe7
         eQS82p6AlCRP9AeHB9oV8CIs5vdFjVR7DkQZasWr9q0Bc4mXtc2dSOPT4+5T8o7vHN3d
         iim07tSh/S0KJpMBHuZBQ8rDMsgcaBP+qqvOHBHa5X5p4YoIgfwuvZaWIeoeVQ3vZrPv
         eNmQk8VODJ6h4brJlOOLWx+Msuz5UQH4DSkjFNKFTm3423zVLhB3mZga+PqXHZ1AP7xQ
         AbGQABI1c5j1zji6zIVDsW7DNblgDlhheL5jQuu16ui6RFcz9hs3Zd2JCm9TD7MqSNzK
         6Ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=dQ4iP81+oQaSsmV5GZL5oFAi+00oM3JUBDEqklqpocs=;
        b=iE6+MhgMHt6OFzkl/hEc95i6u0k4cdjE/QlyuXc0q8MPpp8WeiKijdRnyKoxAwfbbf
         aqIqdrpyiDDSzEGfWvXIKUM9iGw5rdI86+4NoC+aUDWwEcrK3y5wo+HXWPBIwhXAVH0L
         8AuKnspYNt3jeMWY8p3w+UCNf2cB2aM1RCaC4t2fAQjafWHil3yC7Wy5pZnO3zKVgD74
         2GRR5a7oh5IdJGHN/nguWmfVNumEtsho8r9FWMiHWhX+JtYRZjaIYhyqFLATbDoZiG84
         SV2HGZRSOe7p/dGqfhre1wpt3CJMkzuepkuarX3ZY41hiBnuKqLOgTUnjgU/9qB+atIg
         B5lw==
X-Gm-Message-State: ACrzQf0mYTtxUoHQJJrAley9v4NVnox2FXzElxtT4+HbYcKHibndEOdm
        fGDavYmNClvOEixMTRwRwUXYrN2MC/QLxr0nctod7Iv1g3IivQ==
X-Google-Smtp-Source: AMsMyM6eAuqh4KE02wB3DPrDYImGBOOPt//D2w68qi5I7dLucqUGH6aqfawWMuRRG0r3DIyXWMy3SUxbjsBrMASCI4k=
X-Received: by 2002:ac5:c297:0:b0:3a2:4e1d:584f with SMTP id
 h23-20020ac5c297000000b003a24e1d584fmr8679268vkk.23.1663691785977; Tue, 20
 Sep 2022 09:36:25 -0700 (PDT)
MIME-Version: 1.0
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Tue, 20 Sep 2022 09:36:15 -0700
Message-ID: <CAK3+h2ykSR=CXBDZs-_9JjBTim=2E4QHAzvkP=WR5Ke3EFd6Ow@mail.gmail.com>
Subject: LLVM 15.00 github repo build panic to run test_core_reloc_kernel.c
To:     bpf <bpf@vger.kernel.org>
Cc:     Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yonghong,

In case you missed the report :), I ran into LLVM Clang 15.00 panic
when run bpf selftest, I reported in
https://github.com/llvm/llvm-project/issues/57598

Thanks!
