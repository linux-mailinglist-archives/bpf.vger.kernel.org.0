Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F82D567581
	for <lists+bpf@lfdr.de>; Tue,  5 Jul 2022 19:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiGERXD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Jul 2022 13:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiGERXC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jul 2022 13:23:02 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFA31FCEF
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 10:23:01 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id l144so10544507ybl.5
        for <bpf@vger.kernel.org>; Tue, 05 Jul 2022 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=ZwzSWKe8aJcF2q7NRCCrMkrvQ9eS4Q9joDzntgIKPec=;
        b=R9VJiD5uo9HVCFX+jskFEOyD14DtM/M5ON9buw+/Z0h4Sph7mwJngqilfPFqJ43OJ9
         TSqm3LBNoVtyaIFxr55F1Erg/UfgkRK9ZrgUSJoobI0dL69qpEp4OU9ag8JTCGxkYBF3
         gMsuhCQGXlhN2P0dQ/r9Zhy/OUSicsXX1NPykejAKhuFyAysZ9Ac0+/ltLhEJyIDLBVu
         +8IWO3rtskH8Ad6HrDs8P9mYpE6Er/IKzNOQzKAyUR53IMRLu8XSRxOlfbaSk15Uppmo
         /R5lgt4CLUuceVc5R5MJB5GhCycwE3YfTZPCCY1mXJTDE+CfYREhdYPXqy5BFJtmk2zT
         eOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=ZwzSWKe8aJcF2q7NRCCrMkrvQ9eS4Q9joDzntgIKPec=;
        b=Jq8de4aTTYAvdYuGrNVNTZTe48XPqIJgf6P4iJ61IPIa7Px4OzJ5nNt6AiooIv938Q
         KapFU2saPrLAUixV/Ohd4Ws6Owdeb3hrxB0XZOYJenVAhTTIyJI2rofyTrE6Jpcgnbin
         6WgnK1uxgeQfJvC6YaXt8g1ZXrwvM4b2oOP/vuvjYQYFHNHPlBcI/kEATzIMapVW/6gJ
         NTpX1cbHMVaj4Q5Y83dkbUUZZs1FU9pl3QjF6qGCGAvyJ+liKSHnw56zbQqplmGAtJyl
         xO4LSdS0wiPhvoOFCrEdnieflGeeUbARRfmtHi67EQia+NS3NnPRpNk7q1KTiTA5juBU
         Kblg==
X-Gm-Message-State: AJIora+gE4j2ktmwr5frRjE4PwndykDyD0+usk5XcdPdxfPvlqwI/Vqy
        9yratzuF7/vSdMa3Thu+yJ9jBGuVjzFT3CUGxdE=
X-Google-Smtp-Source: AGRyM1uqGzJYmmz1nJRaIbPxeqgIJVr0L0VcdTwdOTLw86axaZf1gkNFX6APR1nRPdTsqne7X+tZjdEqtz53LX50yA8=
X-Received: by 2002:a25:e211:0:b0:669:9cf9:bac7 with SMTP id
 h17-20020a25e211000000b006699cf9bac7mr36258805ybe.407.1657041780422; Tue, 05
 Jul 2022 10:23:00 -0700 (PDT)
MIME-Version: 1.0
Sender: anderson.thereza24@gmail.com
Received: by 2002:a25:9803:0:0:0:0:0 with HTTP; Tue, 5 Jul 2022 10:22:59 -0700 (PDT)
From:   "Doris.David" <mrs.doris.david02@gmail.com>
Date:   Tue, 5 Jul 2022 10:23:00 -0700
X-Google-Sender-Auth: q8ujqAfJlg18D-L4nDSEdHkhpXw
Message-ID: <CANzgL_yghrphs726M_zXyMxjvSkKw=wH5d+g_7npGwY3yiCzYw@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [anderson.thereza24[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrs.doris.david02[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
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
Mrs.Doris David, a widow suffering from a long time illness. I have
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
execute this project, and I will give you more information on how
thunder will be transferred to your bank account. I am waiting for
your reply.

May God Bless you,
Mrs.Doris David,
