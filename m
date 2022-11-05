Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB0061D892
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 08:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiKEHt0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Nov 2022 03:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiKEHtZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Nov 2022 03:49:25 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399F31DA53
        for <bpf@vger.kernel.org>; Sat,  5 Nov 2022 00:49:24 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id r13so2022891vkf.2
        for <bpf@vger.kernel.org>; Sat, 05 Nov 2022 00:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZG8cIx9Y1BKJUhtSgZp3e6tg3iJPTdPEtjTepvCQQo=;
        b=iGzhQBc7RGoAkpGLmwbCXQvs9zkbxkI0c8gNbIdEsgRCmLXlzNuaJeKa4zET+VoJlc
         t7LCeQCb45awZZWBb3JvGIc3HmniO0wj7BdkxoRp/+0QS1ITtdBTLo1UJhl23pcod2YA
         WRO2oK2sczX5SroDLh1YvUwT8icRmrCwEGh580Oz1qlU83fvMPD7dZL3G3ZLZSIXxaYQ
         zweXxvwAl/Tk4NwvNL7SzNe5y+f8LrUFkLygCzC4mTSgrzEs51ACOD7d2w3yMU9c2RpE
         DMMgIoD7QwPFF22hzaj/gRT4VKE6G0oephWK6WibNIPVbOrnJ//KeVUX1YnI20A+KWUi
         ak9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZG8cIx9Y1BKJUhtSgZp3e6tg3iJPTdPEtjTepvCQQo=;
        b=eBCXn4z+xZ0yiGBb4R/4EGD2yHNK16wGBAU4yBaKXsmHh3JnZptxlIJKw49r9DA17H
         5aoyVcJn/iE9ULITHFMXDjUIgt/ajZ3Lpso4x3qkogDYCH8tKjrbNS39SsKNrmIlwBHv
         kGfBW0xQLq816CRG1wn4TZmdCEqr+OpmMK76HppW3PqSgRTa/iX9Dvz23MS71mn0/cB+
         BnycGOvsHHsosWKmAdBlt8HUqE9u3JVe2ldPuVoCKFpmVsCMfJgqi/W257kIFk70QUhv
         KIzw8B6oNfgZejuFes9bXT27GZm3t39ZLtEcleqNTpp+CmYubjpL7vrztvbE2UnoB9xB
         rXnQ==
X-Gm-Message-State: ACrzQf1oX+PPS4JhzZ5tEh3Oji+TJJmNxk6QjgbfKbnDAUQtooV2Cu7q
        GCs3zUyXvm+x4GisWzbjby2jkOXqCvhsEga3fKU=
X-Google-Smtp-Source: AMsMyM6Ls00biauAmUrfmgpzoOnFGgAeUp9nGbh9X32YzgX9WoQgDnch9s4H1qaJXSDtCJq0jr1GrmfNwWop/zQG0/4=
X-Received: by 2002:a1f:c8c2:0:b0:3b8:a40f:cc with SMTP id y185-20020a1fc8c2000000b003b8a40f00ccmr3088997vkf.22.1667634563218;
 Sat, 05 Nov 2022 00:49:23 -0700 (PDT)
MIME-Version: 1.0
Sender: brunellelaurence69@gmail.com
Received: by 2002:ab0:698e:0:0:0:0:0 with HTTP; Sat, 5 Nov 2022 00:49:22 -0700 (PDT)
From:   Hannah Wilson <hannahdavidwilson393@gmail.com>
Date:   Sat, 5 Nov 2022 07:49:22 +0000
X-Google-Sender-Auth: LVeRmNK78oIdhkLJaupqccPW0DE
Message-ID: <CAA4znVi9GSH1ao9C3viG_CdNwMHSKG5YPOWnp8924spaVjWpKw@mail.gmail.com>
Subject: Dear Friend,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a31 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hannahdavidwilson393[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [brunellelaurence69[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Dear Friend,

It is my pleasure to communicate with you, I know that this message
will be a surprise to you my name is Mrs.Hannah Wilson David, I am
diagnosed with ovarian cancer which my doctor have confirmed that I
have only some weeks to live so I have decided you handover the sum
of($12,000.000 Million Dollars) through I decided handover the money
in my account to you for help of the orphanage homes and the needy
once

Please   kindly reply me here as soon as possible to enable me give
you more information but before handing over my bank to you please
assure me that you will only take 40%  of the money and share the rest
to the poor orphanage home and the needy once, thank you am waiting to
hear from you

Mrs,Hannah Wilson David.
