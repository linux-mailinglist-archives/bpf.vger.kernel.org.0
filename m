Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A2753177C
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 22:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiEWTYm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 15:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiEWTYA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 15:24:00 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E239169E3D
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 12:02:36 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2fee010f509so158604907b3.11
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 12:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=uMK4uhL7bbIrweYoyqO5hSjV8mXVqG8AbtrOT/hIh/w=;
        b=KHTHEr/aPJ5wqagHZFZY8XqCH551tBT3HzRWKU1iL+rpaeB6Yebm5gdVFvEDFI4A2X
         FtCTYDIbfdksDwrFeOv27pfhki4qLLAIeQSDkzOU67BH3oxReUrjk5AGbCBDqiiOeeRn
         FJP7eJ68tZFLOdLpgR+QLjalfhZpcjR//6JkIOkFG09IgtPY6ePWxP63qdFFsmCVZIwe
         tBfmHpVBsnP+rni+FtAjmUSK19BtF/Z4j7ExLmdFRU0obbQikyyeRH6RybxQDbvG0rjP
         PZUB3pIx0E7UQjEaCdgbQ5+d+CkpyBU4YQc0QM/0lrisuFJshWGTGzhK2JINcPiuIa46
         vEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=uMK4uhL7bbIrweYoyqO5hSjV8mXVqG8AbtrOT/hIh/w=;
        b=vam1bm1puymlEjt3De4GpJ2v0jj9AZF175Cq7glMgrmXWVh4KArt1OJRtWHNZn0zU3
         R3EMAPHIj4ccrm5jH3rJxahPRwZvmNc3FhlDLAY4pwl7ZNq5SVpEA7vFJwfYpjygyydJ
         LxAdlJE6y4YmL5CDffnn+7tAUbtzGMblHgdSXzcx4mcQmjMzdIkCJ/lzDQjpWS0YGf3D
         BxQsxk/owLLcs1QNo4GlXbePZclM61tzRAf7zEMQ7qrASevwsL3FoKZIe8DVTUX0JBhE
         ta1r6TL5wgTdrEr3R/cL58cppN6/dgKazvxsneEGpHsBxzowyOpMKvj10c+4Mc4frB3s
         gEKg==
X-Gm-Message-State: AOAM531/Pj5QTFLAnvj7voCBcVrt+UwJBkW7L5aEanBKAdrKz6XWyYhH
        Burnl472KgfjoDYvvBjJNlZc6mav8nSBHxVrijc=
X-Google-Smtp-Source: ABdhPJzasVNPZeIP9fc+JQGVGGrSzGZ6e4QmgxYjmlTYdW73b1JbyX2sSqovXMUGurfu7kS4B0RntRYfnejaQQG6Rq8=
X-Received: by 2002:a05:690c:28e:b0:2ff:1437:9b46 with SMTP id
 bf14-20020a05690c028e00b002ff14379b46mr24293079ywb.376.1653332555646; Mon, 23
 May 2022 12:02:35 -0700 (PDT)
MIME-Version: 1.0
Sender: ifeanyiomaka1@gmail.com
Received: by 2002:a05:7010:2590:b0:2d2:29b8:55 with HTTP; Mon, 23 May 2022
 12:02:35 -0700 (PDT)
From:   Dina Mckenna <dinamckenna1894@gmail.com>
Date:   Tue, 24 May 2022 07:02:35 +1200
X-Google-Sender-Auth: CVYKaeeecw82gqrHuNUpHHjzEn8
Message-ID: <CAO-KV1-sa-DrxJscvYO3fyOquqGbttXJbzPxb5K9m4vHn52+gg@mail.gmail.com>
Subject: Calvary greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.0 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_80,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1132 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8137]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ifeanyiomaka1[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ifeanyiomaka1[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello My Dear.,

Please do not feel disturbed for contacting =C2=A0you in this regards, It
was based on the critical health condition I found myself. =C2=A0My names
are Mrs. Dina Mckenna Howley. A widow and am suffering from brain
tumor disease and this illness has gotten to a very bad stage, I
 married my husband for Ten years without any child. =C2=A0My husband died
after a brief illness that lasted for few  days.
Since the death of my husband, I decided not to remarry again, When my
late husband was alive he deposited the sum of =C2=A0($ 11,000,000.00,
Eleven Million Dollars) with the Bank. Presently this money is still
in bank. And My  Doctor told me that I don't have much time to live
because my illness has gotten to a very bad stage, Having known my
condition I  decided to entrust over the deposited fund under your
custody to take care of the less-privileged ones therein your country
or position,
which i believe that you will utilize this money the way I am going to
instruct herein..

However all I need and required from you is your sincerity and ability
to carry out the transaction successfully and fulfill my final wish in
implementing the charitable project as it requires absolute trust and
devotion without any failure and I will be glad to see that the bank
finally release and transfer the fund into your bank account in your
country even before I die here in the hospital, because my present
health condition is very critical at the moment everything needs to be
process rapidly as soon as possible.
It will be my pleasure to compensate you as my Investment
Manager/Partner with 35 % percent of the total fund for your effort in
 handling the transaction, 5 % percent for any expenses or processing
charges fee that will involve during this process while 60% of the
fund will be Invested into the charity project there in your country
for the mutual benefit of the orphans and the less privileges ones.
Meanwhile I am waiting for your prompt respond, if only you are
interested for further details of the transaction and execution of
this  humanitarian project for the glory and honor of God the merciful
compassionate.
May God bless you and your family.
Regards,
Mrs. Dina Mckenna Howley..
written from Hospital..
