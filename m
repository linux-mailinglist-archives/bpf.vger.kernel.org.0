Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F605479A8
	for <lists+bpf@lfdr.de>; Sun, 12 Jun 2022 11:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbiFLJrP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Jun 2022 05:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiFLJrO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Jun 2022 05:47:14 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0B6B32
        for <bpf@vger.kernel.org>; Sun, 12 Jun 2022 02:47:13 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id r3so5520943ybr.6
        for <bpf@vger.kernel.org>; Sun, 12 Jun 2022 02:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=nqybdXDlqhWCIjF5VGtbumzYH2PqIH9LUW8rH6PqlQU=;
        b=nxLwX4R9MPPd6mabp9gZpzzN7ShU7MU2Xq7IkFd6kb30TFPAd+/3wXZc7AdkZ2ogpH
         AuxA5Me95e2CkA+SkmbScYmV8jzJyed8j45AtKyonNPtb3V7yXgxx8kofISwv8Dw+E3E
         BTy7RyPsoc5/rWbSoGMuMx0v35PnldveaUbLylauNB7nONDcznKrnVigr3EAylWOvHOr
         N/EK9ZlsG6AmGv4rrixZ1T5ADRKQERY0Lpx0I/yGRVpFr4l/VZVdTXAsYLB1HniLCbxE
         VDx+El7iB0eqmoOJmc8GgF+4Ml1MF8aJUj+58A5koUq+lfT2OzltFYxlbIIav4GLS0Yd
         +nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=nqybdXDlqhWCIjF5VGtbumzYH2PqIH9LUW8rH6PqlQU=;
        b=kL/os18DKug1TrY95pk74wgs8+QC9+HjuKgjMwJc6bP8kVZnngyph0LryOifJde6aT
         uiZnKwm4dt0kfcFs3F/4vJfkqQo5Iz5N6XD8S0oA7vjTn0MNOzKQJ6gN+5xPCwUfy8P/
         sO2ZTfH6EpdBN2i7clH+alLczNju8onzDgVysuAeX8b1Yx1LMvxuBEvi1lvxKUJpEpcN
         DAyCHX2qIE0SAUC2sKXYfR0ZRfErpXSdy6wMvedbOujbnP+Wd+Us7w5COf9ksxW9TY4i
         GrMWBGHLked2S6bfevRYMwQeUAQYerK5mOhxqS9o/dHZbPUOT3WatPaQuLNJd7u5+wYy
         rX8A==
X-Gm-Message-State: AOAM53353cDPEKkCNDhGl4HW7BcW5JKhtgZaqOwnh0tAgl2TMNZd8LDf
        1aXuyT8+4TO/NMk1f0USYANPTS2+otCI+XqyJKc=
X-Google-Smtp-Source: ABdhPJz5EHkyHPyRPkc4FFqCa9lqyQ6dWS/t/8sUBEZI6eObutUd0eiDNLAt0j8yeuYOrfGMlEjOZVuzP5ahKTGOeBk=
X-Received: by 2002:a25:9744:0:b0:664:af39:4219 with SMTP id
 h4-20020a259744000000b00664af394219mr2696095ybo.252.1655027232870; Sun, 12
 Jun 2022 02:47:12 -0700 (PDT)
MIME-Version: 1.0
Sender: drfranksaxxxx2@gmail.com
Received: by 2002:a05:7108:6822:0:0:0:0 with HTTP; Sun, 12 Jun 2022 02:47:12
 -0700 (PDT)
From:   MRS HANNAH VANDRAD <h.vandrad@gmail.com>
Date:   Sun, 12 Jun 2022 02:47:12 -0700
X-Google-Sender-Auth: 8VMDVm3bgB-mJVb9145mtxrlK1k
Message-ID: <CAGnkwZ44Ei5Rq5atzJQkW=Gpc1a534Bvd9VKhYMg_rQrPQmZqw@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.1 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2e listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7458]
        *  1.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [drfranksaxxxx2[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [h.vandrad[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night  without knowing if I may be alive to see the next day. I am
Mrs. Hannah Vandrad, a widow suffering from a long time illness. I have
some funds I  inherited from my late husband, the sum of
($11,000,000.00) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very honest God.

fearing a person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained. I do not want a situation where this money will be used in
an ungodly manner. That's why I' making this decision. I'm not afraid
of death so I know where I'm going. I accept this decision because I
do not have any child who will inherit this money after I die. Please
I want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how the
fund will be transferred to your bank account. I am waiting for your reply,

May God Bless you,

Mrs. Hannah Vandrad,
