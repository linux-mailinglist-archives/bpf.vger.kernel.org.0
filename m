Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8B4626C15
	for <lists+bpf@lfdr.de>; Sat, 12 Nov 2022 22:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiKLVxi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Nov 2022 16:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbiKLVxg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Nov 2022 16:53:36 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FD125C9
        for <bpf@vger.kernel.org>; Sat, 12 Nov 2022 13:53:33 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id ud5so20049346ejc.4
        for <bpf@vger.kernel.org>; Sat, 12 Nov 2022 13:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOQ2wStLDIWhmzCg/kQjZqe8nkA7gHbgKI7k4Tq3KeA=;
        b=SjVc3rV2nBNl/jBzghV2pl97lPjPedsVyfauCrxQDrIHU+TYzZwudyuzjNGMYBl6vu
         QbLwUZJFeJbQGmxwNC+AC0f0lZE/Ssgn+hx5bqgMd7/lFW3UbpenCO5TRkJ8al+QMJn2
         BH/pTdqnCq0aVkYDcbEBmPT8e7P7tR8ZKU2r/2WDmwwcyexEmpb2Kq9KAZh2sqETPc2E
         +VLoiudSRocF9Qie85GhGsfecjNRoVHd+xuuubSV9+hUpCtTnaCF1Q7vO4pdZfqDZOyF
         G1tAX1LKMEkmAOqrq2kMSmXAMu0w6wCUdCHNBDgQ2Sg+SKqtFXvK53xSxvAIdMevZFcq
         4hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOQ2wStLDIWhmzCg/kQjZqe8nkA7gHbgKI7k4Tq3KeA=;
        b=jmDxYg/73BnvDMrwlHiicLoniXAa/YEWsId7TJQD+sBrEVi+LEzMYVMd3p86PQmsVD
         YTiJZIXdhVGDDGkKgeMAjAjXwDL93XyCKv+PH395uoZFOF145vACt4mX7218L7Lm0yTn
         XvLFC04k7DmrENN/d8lKlIQonANpY5+vFBvncqQ4DxyxA0LyujIC5SAijcbogHaORMgO
         q2+tO1yHEIQF8m/0HSEEzmlTz8ruV13bs4EdR11T4MtjG7UK2H7qmpHDo7i+11MJ6xbZ
         sQpuE+KmTUS78xTHbWNTXwley+3N7aZbxkptexK5YCkU3bbp/SiZAkL4DxHWX5pCsUV8
         0EFQ==
X-Gm-Message-State: ANoB5plo3Y6HjGr7u6Ku7CRTgvXvA/xchThDgZLW/jk3DNPiJxTZpa6Y
        xVL/FBi699oBqW9mEqyTjLT+OOtMi7exHHMIJ0s=
X-Google-Smtp-Source: AA0mqf5MHYrETf9qaRQPOcjVEIfdt4xE3tzNRLWgxlpxbDgen4DmkbKp/QEMKyYU8ZHUCvsUzCzJAqq/t6/qHZok8Ro=
X-Received: by 2002:a17:906:46c4:b0:7ac:db40:7e1 with SMTP id
 k4-20020a17090646c400b007acdb4007e1mr6270854ejs.204.1668290011731; Sat, 12
 Nov 2022 13:53:31 -0800 (PST)
MIME-Version: 1.0
Sender: aishaalqaddafi6@gmail.com
Received: by 2002:a05:7412:b308:b0:89:f933:130c with HTTP; Sat, 12 Nov 2022
 13:53:31 -0800 (PST)
From:   Hannah Wilson <hannahdavid147@gmail.com>
Date:   Sat, 12 Nov 2022 21:53:31 +0000
X-Google-Sender-Auth: HRZkUUEeW64uiB_lWOKA1mrmc7k
Message-ID: <CA+c3Tp4iee6oP_N38gQsZh89nfWG6M+3PWtN5jPJeTU6Bgn3tQ@mail.gmail.com>
Subject: Good Day My beloved,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_MONEY_PERCENT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Good Day My Beloved,

It is my pleasure to communicate with you, I know that this message
will be a surprise to you my name is Mrs. David Hannah Wilson, I am
diagnosed with ovarian cancer which my doctor have confirmed that I
have only some weeks to live so I have decided you handover the sum
of($12,000.000 ,00) through I decided handover the money in my account
to you for help of the orphanage homes and the needy once

Please   kindly reply me here as soon as possible to enable me give
you more information but before handing over my bank to you please
assure me that you will only take 40%  of the money and share the rest
to the poor orphanage home and the needy once, thank you am waiting to
hear from you

Mrs,David Hannah Wilson.
