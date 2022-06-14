Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C4F54B4B3
	for <lists+bpf@lfdr.de>; Tue, 14 Jun 2022 17:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238080AbiFNPbT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jun 2022 11:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241161AbiFNPbS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jun 2022 11:31:18 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12F339B8C
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 08:31:13 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id n203so4191865vke.7
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 08:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qOb6CpBWEpKZ1+Jps+OohSr73vseQ2npOzb0IAq+X/s=;
        b=c5U/7TkMHKRXH6jJkhw/01tvzVyQ7Cn9YMbxdzG5nXKwidVLmsaatwAqTr9NNpzf3i
         70hm03dfTMUDc64hsd0ElhxllFkQqgRh8WAqk635lh3I/Z5X9ftIIw+mBZGjYWcv3+mN
         mqhj0PosPrVsj+yIx4QTfQ7LEFz9fi/QHn3AeDxyx7i8kMeuVjI5OjQmxRce6xV1qPOe
         TkhgjAKzz3zbu1Pdu5NxZym1/8WoXMUtn5EVgm21ppylzDcYnZFc9qjnfS/kCzmuTcVt
         uUjRuuB9GiW3keiWM6SOnvaZMC/9Cn7/5rzuBZ1z1D9GYqAp/wfGbyW0cYlwU6TxNc2K
         37xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qOb6CpBWEpKZ1+Jps+OohSr73vseQ2npOzb0IAq+X/s=;
        b=N0NFExASRKL82OYFbxFDu6l5RrJXws0/sZ+yWY8AfxP2kI8iVFc3W2BE1re88fE0er
         +MpgCxWm5D+BqO+pG0SgwEXnTxmt6MNbgYUSleq/+u4CQNp1g0Z9VM490GdlDBIuCavD
         h/qms3Qf84rK2/H+GuX2BA+rKgwGMfSvPxr/TnYCIwNCLex8jOss1HmBkGdFEOFgW95J
         mDsAnLJlD9saKw20Nmi0yZvAL6s004D9e0DNkj6Ku91zm1Hyp2eUmS6MTEG4qWQGweFz
         Qypq6T+mUsv0pJCLIBMWe3+n0nrnSWM6ho7xM8IY+R21p3ibJylR5HxTQnUKD9/Dlxpa
         jXnw==
X-Gm-Message-State: AJIora99yRr6a/X6G5/GE7db8pgLjCu23DcQcuZDMSDJ1FmA466961TE
        5DCeo/zrdDtmXY8w2vqSBbQfuw4Vrs+KTTcFWhM=
X-Google-Smtp-Source: AGRyM1sL2yuQGxAfvgsYwZvON2SqbtF8+J+g4FH+6ubzLZSiTz1OD9REbUYLI6orcF4y5lre5cEGjrNnCjSGL0THMv8=
X-Received: by 2002:a05:6122:1801:b0:35d:8ffd:84a0 with SMTP id
 ay1-20020a056122180100b0035d8ffd84a0mr2437930vkb.24.1655220672735; Tue, 14
 Jun 2022 08:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <CANqewP1RFzD9TWgyyZy00ZVQhQr8QjmjUgyaaNK0g0_GJse=KA@mail.gmail.com>
 <CANqewP0cDTXVf1ekJTvaetB1DGkEKu56_H8dPjVQqxSvHfPziA@mail.gmail.com> <CAEf4BzaSc_nMrYr3YvSnwEXhzhiUjkQ=-zOnyyH0jqeH__w9JA@mail.gmail.com>
In-Reply-To: <CAEf4BzaSc_nMrYr3YvSnwEXhzhiUjkQ=-zOnyyH0jqeH__w9JA@mail.gmail.com>
From:   Tatsuyuki Ishi <ishitatsuyuki@gmail.com>
Date:   Wed, 15 Jun 2022 00:31:01 +0900
Message-ID: <CANqewP3BKc+seCaneyc+GJqf62q+aY9qcTwN276OrB0hK4faJA@mail.gmail.com>
Subject: Re: [Resend] BPF ringbuf misses notifications due to improper coherence
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
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

Hi Andrii,
Thanks for looking into this.

> I'd like to get to this in next few days, but meanwhile have you tried
> to benchmark what are the implications of stricter memory ordering
> changes on libbpf side? Do you have example changes you were thinking
> about for libbpf side? I can try benchmarking it on my side as well.

I don't have a benchmark yet. I'll try to prepare a benchmark when I
have time to do so.

The proposed change to libbpf is simply to replace the two
smp_store_release with smp_store_mb. I just realized that the Linux
kernel memory model doesn't have direct mappings to seq_cst loads and
stores though, so this will lead to a redundant barrier on AArch64
etc.

Regards,
Tatsuyuki
