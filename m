Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F796B0354
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 10:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjCHJrK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 04:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjCHJqx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 04:46:53 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9FDB7D9F
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 01:45:59 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p26so9395581wmc.4
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 01:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678268757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ty12+nLrZzZRFPyE/5xCHmQ1gSeqrVNRX0+UN6AcEvs=;
        b=Bo8R0BiS+Y8YaIo1e8mE6z62fZO2YRstGgC+BiU0UtDlAPcABLiBzqS0zpvWr5x73o
         rQTpTCzhp1w4zQaDHomzQBkHY31p4C3jxjoE9xkxBrR9RZmR/tBIRyBPhPiisfLaFfxE
         FNW7s7N4U3BM3m/hPK5f2Vq8dNx0xCVA/L2EEbKJv0DolomSQIk0m1FW0zhFP+stjXRs
         ia/YQVLcN2pINSuFZeuqUEsGLAjomKGvhuIZrIW7jhLl1TW1mS/NgEAQAUcCdp05sIQj
         ukpYpc6MJR6chPKQx6OkD0Fzv18ytjrIOIqviRaYa8g2CWPewdimxqAiWGQxlWHHuk7J
         B9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678268757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ty12+nLrZzZRFPyE/5xCHmQ1gSeqrVNRX0+UN6AcEvs=;
        b=BXE+EeulZm+dOpmIMTS4QCslyHm+1Vuxi0/z6EiRuPLmn1JlvlEw+Johf6mvM76r2h
         DPu1Lq+4AH54ZJeIr+/aHFaLMY7f5Co7US4RCCM5hy+vXvDunBW074EpT4w1AfufNAgd
         h/5xX3oLq1C7y8i8uVA9r8qBBayih7bDEPPZE+XHh3P3dk3SpQqt2m9dWe+iMASlatnw
         dTxTMus1srRXGmAx/lC+yhmZwucQxHRDqOJ2pu73C50ydY8uly0vDbZvMJ+uLseoltIk
         hR5ZZHCctT2HMOjKByPoo0jMidavKKwNIRmGrBua4k5/w+yPRN3prkVQDdryAP1qyWWe
         WJRQ==
X-Gm-Message-State: AO0yUKW52bmxl9/LI7zBNtrTkblPJZzYhdbNJLXDAd6mDQaRZuSroHcZ
        3kKhXQ7/saoraed9NxDQRGJWf4sQVCoIEOz/mzQqwg==
X-Google-Smtp-Source: AK7set+xxY1JtZ4a0+A5Ndip55cSbLE+PPFEk2K9wHakPb4oduun87X7EcgJFx0oOrF9VuSVtYF58yO02J1S9LUH8Ks=
X-Received: by 2002:a7b:c2a2:0:b0:3eb:5a1e:d52c with SMTP id
 c2-20020a7bc2a2000000b003eb5a1ed52cmr3657640wmk.2.1678268757575; Wed, 08 Mar
 2023 01:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20230308021153.99777-1-kerneljasonxing@gmail.com>
In-Reply-To: <20230308021153.99777-1-kerneljasonxing@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 8 Mar 2023 10:45:45 +0100
Message-ID: <CANn89iJXiBvLMK7uC9MHmtt7gWd50oopqBn0dEC_Per=dFbVzg@mail.gmail.com>
Subject: Re: [PATCH v4 net-next] udp: introduce __sk_mem_schedule() usage
To:     Jason Xing <kerneljasonxing@gmail.com>
Cc:     simon.horman@corigine.com, willemdebruijn.kernel@gmail.com,
        davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 8, 2023 at 3:13=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Keep the accounting schema consistent across different protocols
> with __sk_mem_schedule(). Besides, it adjusts a little bit on how
> to calculate forward allocated memory compared to before. After
> applied this patch, we could avoid receive path scheduling extra
> amount of memory.
>
> Link: https://lore.kernel.org/lkml/20230221110344.82818-1-kerneljasonxing=
@gmail.com/
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>
