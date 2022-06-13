Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1CA549BD4
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 20:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344137AbiFMSkl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 14:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343713AbiFMSkU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 14:40:20 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C19E1706E
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 08:28:54 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id x9so6197655vsg.13
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 08:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=T/blLWTzm3edzIJzh9cdqF/JQAxQkYJjIod4C8ihcVs=;
        b=ML+sAx3WYy5+SV9/ihPVldSU4+5TsvadjyOrtyCuNvLUS+YWioDrqDHjy4Y4vxu8Du
         1A9bVAK0pPdQSKGCjliWCF8QhBI6+/39dHSeRr+oK3fkjpwE23au86HJBqaZsEpGv65/
         7a/zDCU6MtYzL8170+mn9ACUbFcz6rsR+xPKurr5h3lDF3+ms8ImO3vYQqRbqEMGYTLX
         XYiIBihKFicIDyGWYmjySEKyCZUewOzWngXLzOzd91o9g/LupGtxxavq+TYZ8CF+R0ZC
         aNwuLFiM52G9EG7X7PuRXhYt+xsfQuCxQnwOiGm5dsEbimPWP1z4JsUPQxh8rf29YLnT
         aMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=T/blLWTzm3edzIJzh9cdqF/JQAxQkYJjIod4C8ihcVs=;
        b=Dr/pxGTunDgzg95ak63qCzniAFJqSSKPyzh/pUYVWVXWRyG2oy/a+k6xrliQ/z/Vh3
         dLfrtuiq48KjwXmlp9xL/3KSLK7MWkZappGpv+7Wsc8H6DR3094cq3RFUi76FwNWbMw2
         ahhFntJoAxLj/W9hDCN7uQ6qVZdZGpGW4pGsjk8LpxUV2SNCj34SO3EjToQXUIMATVNO
         Z6vnqd6w1qdogtSQIyTnbp6kFKsRaw7ROfMRsfoLm2PU/vz7+sCOJgE16BHoQdYVYobr
         i5sGP5WzkU9b36W4ZnFC5UpHlI/SSmugJ9jY95ZTBskUk7rIO1D6funwFzytWJJ3DklY
         eNlQ==
X-Gm-Message-State: AOAM5304fBCEMziCfxBBUTMzRkQOmZiS8Ga97FPsCYUgvdDQmy1frAAa
        jKPtT2VJJ9r9XIeSbW+/tXyatpiPyj5r5PZxrb7Zfsibo40=
X-Google-Smtp-Source: ABdhPJyhtPumQHFw+I32i44ETKhOBGLSMXo+6xFQZ0lZQe2Bx/Bpjlr68o1aFms/ZeS7C/wBMnsomqJ4HCWH3BhwhVk=
X-Received: by 2002:a05:6102:ec1:b0:34b:feff:2ec7 with SMTP id
 m1-20020a0561020ec100b0034bfeff2ec7mr10346329vst.47.1655134133297; Mon, 13
 Jun 2022 08:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <CANqewP1RFzD9TWgyyZy00ZVQhQr8QjmjUgyaaNK0g0_GJse=KA@mail.gmail.com>
In-Reply-To: <CANqewP1RFzD9TWgyyZy00ZVQhQr8QjmjUgyaaNK0g0_GJse=KA@mail.gmail.com>
From:   Tatsuyuki Ishi <ishitatsuyuki@gmail.com>
Date:   Tue, 14 Jun 2022 00:28:42 +0900
Message-ID: <CANqewP0cDTXVf1ekJTvaetB1DGkEKu56_H8dPjVQqxSvHfPziA@mail.gmail.com>
Subject: [Resend] BPF ringbuf misses notifications due to improper coherence
To:     bpf@vger.kernel.org, andriin@fb.com
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

The BPF ringbuf defaults to a mechanism to deliver epoll notifications
only when the userspace seems to "catch up" to the last written entry.
This is done by comparing the consumer pointer to the head of the last
written entry, and if it's equal, a notification is sent.

During the effort of implementing ringbuf in aya [1] I observed that
the epoll loop will sometimes get stuck, entering the wait state but
never getting the notification it's supposed to get. The
implementation originally mirrored libbpf's logic, especially its use
of acquire and release memory operations. However, it turned out that
the use of causal memory model is not sufficient, and using a seq_cst
store is required to avoid anomalies as outlined below.

The release-acquire ordering permits the following anomaly to happen
(in a simplified model where writing a new entry atomically completes
without going through busy bit):

kernel: write p 2 -> read c X -> write p 3 -> read c 1 (X doesn't matter)
user  : write c 2 -> read p 2

This is because the release-acquire model allows stale reads, and in
the case above the stale reads means that none of the causal effect
can prevent this anomaly from happening. In order to prevent this
anomaly, a total ordering needs to be enforced on producer and
consumer writes. (Interestingly, it doesn't need to be enforced on
reads, however.)

If this is correct, then the fix needed right now is to correct
libbpf's stores to be sequentially consistent. On the kernel side,
however, we have something weird, probably inoptimal, but still
correct. The kernel uses xchg when clearing the BUSY flag [2]. This
doesn't sound like a necessary thing, since making the written event
visible only require release ordering. However, it's this xchg that
provides the other half of total ordering in order to prevent the
anomalies, as it performs a smp_mb, essentially upgrading the prior
store to seq_cst. If the intention was actually that, it would be
really obscure and hard-to-reason way to implement coherency. I'd
appreciate a clarification on this.

[1]: https://github.com/aya-rs/aya/pull/294#issuecomment-1144385687
[2]: https://github.com/torvalds/linux/blob/50fd82b3a9a9335df5d50c7ddcb81c81d358c4fc/kernel/bpf/ringbuf.c#L384
