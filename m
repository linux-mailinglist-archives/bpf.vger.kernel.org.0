Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA924CE5AE
	for <lists+bpf@lfdr.de>; Sat,  5 Mar 2022 16:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiCEQAf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Mar 2022 11:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiCEQAe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Mar 2022 11:00:34 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C248140C2
        for <bpf@vger.kernel.org>; Sat,  5 Mar 2022 07:59:45 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id x62so5884337vkg.6
        for <bpf@vger.kernel.org>; Sat, 05 Mar 2022 07:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=/yJwP3S4qrZ5ciITEWrd6OJrYVm/Ji8vbDH75vaAWVw=;
        b=IXO2XRcz3HRFuvltF6U/bOCMa/8Q44UGT+MGoRD6NPpAD48llnzeLBsSKtKgDxbQvZ
         7p+geGvYkI8rwcj79NdWtKlAqplpJMIGZe0v1ObeNFJkgjDQMBlpgXTY99PjJNhBVHvH
         mZL08z5LHCuaODlvDz2fR+VE9oXDYZcy/mXs17drGlHYF28OZIuoGz/UcinVXpQAxMzi
         XR/cDjAEGY6CU7entBwCN+dJ39xLzd8+Uu2YNDAlj65GZIhT7YLAzIpD8lhEs9NHEcfe
         xFUvHy2Tl2z9MRJzgoDGXCrnnjNGf9FRXUKl/YBR3C1JgGo281/7pOuoQ/cTYPPaP+WC
         G2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=/yJwP3S4qrZ5ciITEWrd6OJrYVm/Ji8vbDH75vaAWVw=;
        b=sn96EVNKgsExl4vTQd8sYckFELUPrW4n+FQf+QzsRu8rqmbtwrjNOAfyv87PLwZpKu
         wd9PU6VJwM6hP8mjkivTemUZ3GxYvYS7UiWSULO1ixLJlbKkg5ZhvFBPgP+aYhSGpqgu
         XmUlKMKSIublZfxq3VZk9Cfk83Ekg+A/MNfnNcuI8C/SDEs1Us71/TyWD92911Y1clQ1
         0XoUk0NVq12Se1Bj/1wD+S31AfZaiptby9Ut7hjHzwiO8qc8YPslGCk75l/7g0bYXkub
         GCotqwnFZ3Rzt2+9yT/ZvTeSihvdipDtvNKsJEDBGzKLe6K4FiniVDHQwxHATHCjx8hy
         mobA==
X-Gm-Message-State: AOAM532Oo5TN95CjvippHAM0U6RY9KEgQQzDiDZnfFGjq3LU47CHWnOq
        HysLRPsYrGY1Jv2x0jtLSZuJthfbDjPJsln9UoQ=
X-Google-Smtp-Source: ABdhPJzthRX37I7zFzRrl2NhQaQCFoDLhmRqUXcGxykkW7H269Q4Z0zKpPkR3PgwxsV8jWjkiL6CMfjYzLbIN7LLjV0=
X-Received: by 2002:a05:6122:1898:b0:32d:5227:d967 with SMTP id
 bi24-20020a056122189800b0032d5227d967mr1215131vkb.38.1646495984073; Sat, 05
 Mar 2022 07:59:44 -0800 (PST)
MIME-Version: 1.0
Sender: mrs.doris.david22@gmail.com
Received: by 2002:ab0:162d:0:0:0:0:0 with HTTP; Sat, 5 Mar 2022 07:59:43 -0800 (PST)
From:   Anderson Thereza <anderson.thereza24@gmail.com>
Date:   Sat, 5 Mar 2022 07:59:43 -0800
X-Google-Sender-Auth: ULzdYM0sb47trarWE4x8XqxFwu4
Message-ID: <CALSkaMBvsFwcVBUsX+MtmKpr9hNkg9CShm3KCbS0pw0PQg9jYQ@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.4 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a2c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [anderson.thereza24[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrs.doris.david22[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night  without knowing if I may be alive to see the next day. I am
Mrs.Anderson Theresa, a widow suffering from a long time illness. I
have some funds I  inherited from my late husband, the sum of
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
fund will be transferred to your bank account. I am waiting for your
reply.

May God Bless you,
Mrs.Anderson Theresa,
