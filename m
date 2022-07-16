Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B8C576F80
	for <lists+bpf@lfdr.de>; Sat, 16 Jul 2022 16:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiGPOuW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 16 Jul 2022 10:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGPOuV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Jul 2022 10:50:21 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6DCF3F
        for <bpf@vger.kernel.org>; Sat, 16 Jul 2022 07:50:20 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10c0d96953fso12763746fac.0
        for <bpf@vger.kernel.org>; Sat, 16 Jul 2022 07:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HJ07Z1i8ZEZRBoTFgQMoHNJKLvLirKmxPIXqAh7xErw=;
        b=Q6SZ/UjC4l3J3XbAGx7Lm4uu23Qp90i66Nz9BjFXBKHz1wuhYWc3Y9IJ9xH43yuWVh
         1tesrVIr8RW6cVjOMuUh6cv7VqbAcPz532vnM4nLCIqH4PY8XyAZFAh+crYX8PAVPyeb
         AYViPvll9Xu8gmJCju+p+W2Dm2graFftcoW4r+kEdpgnOk/QorJRtvaXv/yD+Z012BK8
         sOzgXLQgBpfVgeiJtAhAehG1wP7Cg3ggyg1gLTUIvEfaNObER1ld6ORZwLgAjGW2NsOf
         nzUkfVidGIGcQhAJcByWOjf5wdCadSxOCaq3GuxcgOUYj0ntWXXmb80eKIgtzuRgC9Ob
         MuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=HJ07Z1i8ZEZRBoTFgQMoHNJKLvLirKmxPIXqAh7xErw=;
        b=M+isfaKGJIiCn61ucx0GRLecRGlbhCBsfSlOGUPKmAdo5fzHIVNfbBZuqeY+VCAkY4
         6D3OqCSJDUiEshHXU4OdDxhprCB8ANQenmC1dvqUAvUsWsG9UdcuDA27GfemvW8Zhs2T
         E6PVJbIOis0Dha0bOgmOd0n0VndmAHKRGZVQ6/f/ziBBC3F5fvkvMxukBXIYZmbRR39O
         MvvDcdpoG41nTzS+WEJZmLEw2z/tXiJb600qJcQh9bsCngua4YcReyjLynpXMyFnng5X
         9Ky16y52m1gYOliYrIohol2MASHxiyy8icX/TDxBRyznvKff8yKXc0pnm152LWYztaGU
         G0Hw==
X-Gm-Message-State: AJIora/S9QT2uf9v7LMcLFwzDdvt2MIsCgDLBnHOz23JJJsbIECTr8JY
        PWM48rfdByq4hnxh31SCHToz8C+uGjknPmQfX+E=
X-Google-Smtp-Source: AGRyM1vlgdy1XO9EvBHZQbxS/zIIDmyn3Ekq9VoaB7v14hraeg+k4UTa8okzDi/T/vBrvd2/R4B98hhjXY0ZvcL+1J4=
X-Received: by 2002:a05:6870:40c6:b0:10b:f5d8:756c with SMTP id
 l6-20020a05687040c600b0010bf5d8756cmr12961188oal.16.1657983019301; Sat, 16
 Jul 2022 07:50:19 -0700 (PDT)
MIME-Version: 1.0
Sender: alimahazem00@gmail.com
Received: by 2002:ac9:5f10:0:0:0:0:0 with HTTP; Sat, 16 Jul 2022 07:50:18
 -0700 (PDT)
From:   MRS HANNAH VANDRAD <h.vandrad@gmail.com>
Date:   Sat, 16 Jul 2022 07:50:18 -0700
X-Google-Sender-Auth: nVrlimEOeQEmY7vOIklYSMVuUVY
Message-ID: <CALrB==502x2Sz73iWA5MYEwH6-pOHR_8Q0_FaSOfu4Kquf4d-A@mail.gmail.com>
Subject: Greetings My dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.9 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:2f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [h.vandrad[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [alimahazem00[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Greetings My dear,


   This letter might be a surprise to you, But I believe that you will
be honest to fulfill my final wish. I bring peace and love to you. It
is by the grace of god, I had no choice than to do what is lawful and
right in the sight of God for eternal life and in the sight of man for
witness of god=E2=80=99s mercy and glory upon my life. My dear, I sent this
mail praying it will find you in a good condition, since I myself am in
a very critical health condition in which I sleep every night without
knowing if I may be alive to seethe next day. I am Mrs.Hannah Vandrad,
a widow suffering from a long time illness. I have some funds I
inherited from my late husband, the sum of($11,000,000.00, Eleven
Million Dollars) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my
stroke sickness. Having known my condition, I decided to donate this
fund to a good person that will utilize it the way I am going to
instruct herein. I need a very honest and God fearing person who can
claim this money and use it for Charity works, for orphanages and gives
justice and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be n=
amed
after my late husband if possible and to promote the word of god and
the effort that the house of god is maintained.

 I do not want a situation where this money will be used in an
ungodly manner. That's why I'm taking this decision. I'm not afraid of
death, so I know where I'm going. I accept this decision because I do
not have any child who will inherit this money after I die. Please I
want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how the
fund will be transferred to your bank account. May the grace, peace,
love and the truth in the Word of god be with you and all those that
you love and  care for.

I am waiting for your reply.

May God Bless you,

 Mrs. Hannah Vandrad.
