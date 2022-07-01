Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E3D5630CF
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 11:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiGAJ6q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 05:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbiGAJ6p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 05:58:45 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF64913F43
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 02:58:44 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id i15so3189825ybp.1
        for <bpf@vger.kernel.org>; Fri, 01 Jul 2022 02:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zkRKKkHvNmeWqvRVOQLK4rfH21duyawXjkMEAhn/9YU=;
        b=iH7zfi+XP7pIUZhUau9aJINoHOfYxpsLb/3wWq1V3ymavu45rdSzRw/FgItk8vRLG1
         5Tyf0YGRrD1eNsHJd0eMvsszyXd3Rm+jDKfHCRoctjewnUxj/e8kTAzt83Xu5aEm8WqI
         dmAe5in5k40uBm//jqtGzaaLzmziliUmdB0lSz4MdKJpQtd3n558fPHgkpOCn+m3++kZ
         f0D+9hHzbuYxwXo+OwdxRj3eJOQoFpF7c9n3NKksPY0B2Au64CzMdraF4MWhAMbh+z0V
         0jGiwABTLtE0AtC0PyIavQQ1JLaq0nT2/hKat7JlSovDTEdlBBEr5ErGarPCo3nVq8AK
         0XVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=zkRKKkHvNmeWqvRVOQLK4rfH21duyawXjkMEAhn/9YU=;
        b=jGL440c/YtIEg7jAOcZqv7E6BivmCVxjfqybu7aM60hhCECMdG4f+tEuA1F4TuqQJ6
         N6OKxq7wBO06MA2nVUxFr8WTn3WenUrR7v+bPWg2/21HZrwoe2F4goWvDf3KGiwWdd17
         UcBHdHKrZi670SDuGXGVEh4uhptXr8pAwsAALUKjLbrmQCvvL4CaOXrlfqP3HGaRG3FG
         GBgNT8hniNCXtDpaQGWEZiD8JGDH/Fabve4gtZN5jZB2agST7p9q1rWm5Ips+EcZgV4B
         rU8H1ylnTRjmJ7M+w9GauYKyzkQXOy1afyY8jx/DEW0PI6nD9p/HcOa6eMrzcQE+0FLv
         kmbg==
X-Gm-Message-State: AJIora+FPRuixZqOUx8FRsWFi3DUGtjlBRc0rWQIChXYx2/h6i4P7pho
        Xs11d0VACr5j6jMtDZvUvHSTyjBt2jlT5nTA2dw=
X-Google-Smtp-Source: AGRyM1vCSKD+0Z8GkEtOq6XrCadYXhqoL62ZHkT/R9HWeBXiBiYMNzKhuuB9zAGCX/CZO9CLPMmU/HOOLN6HLNiO7Gw=
X-Received: by 2002:a5b:4c4:0:b0:668:5604:b395 with SMTP id
 u4-20020a5b04c4000000b006685604b395mr14516177ybp.355.1656669524034; Fri, 01
 Jul 2022 02:58:44 -0700 (PDT)
MIME-Version: 1.0
Sender: samsonka22@gmail.com
Received: by 2002:a05:7000:9993:0:0:0:0 with HTTP; Fri, 1 Jul 2022 02:58:43
 -0700 (PDT)
From:   HANAH VANDRAD <h.vandrad@gmail.com>
Date:   Fri, 1 Jul 2022 02:58:43 -0700
X-Google-Sender-Auth: kLQhUPwowyaZihuoeTULEYpoq6c
Message-ID: <CAKY8iZozFUxKu3DfAcg_eqH9PCk-7E95-GJAxUWPHf3okqjhog@mail.gmail.com>
Subject: Greetings dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.3 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b42 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [samsonka22[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [samsonka22[at]gmail.com]
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
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Greetings dear


   This letter might be a surprise to you, But I believe that you will
be honest to fulfill my final wish. I bring peace and love to you. It
is by the grace of god, I had no choice than to do what is lawful and
right in the sight of God for eternal life and in the sight of man for
witness of god's mercy and glory upon my life. My dear, I sent this
mail praying it will find you in a good condition, since I myself am
in a very critical health condition in which I sleep every night
without knowing if I may be alive to see the next day. I am Mrs.Hannah
Vandrad, a widow suffering from a long time illness. I have some funds
I inherited from my late husband, the sum of ($11,000,000.00,)
my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very honest and God fearing person who can claim this
money and use it for Charity works, for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of god
and the effort that the house of god is maintained.

 I do not want a situation where this money will be used in an ungodly
manner. That's why I'm taking this decision. I'm not afraid of death,
so I know where I'm going. I accept this decision because I do not
have any child who will inherit this money after I die. Please I want
your sincere and urgent answer to know if you will be able to execute
this project, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of god be with you and all those that you
love and  care for.

I am waiting for your reply.

May God Bless you,

 Mrs.Hannah Vandrad.
