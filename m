Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3493E544523
	for <lists+bpf@lfdr.de>; Thu,  9 Jun 2022 09:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiFIHxy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jun 2022 03:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiFIHxw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jun 2022 03:53:52 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80FFF0
        for <bpf@vger.kernel.org>; Thu,  9 Jun 2022 00:53:50 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id r82so40373972ybc.13
        for <bpf@vger.kernel.org>; Thu, 09 Jun 2022 00:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0XYuJwlWcPhF5wKwZj6AX0M1ehVlcZ8wjqHIDg46ZGY=;
        b=nypacSP4qioBoDwoUOZWYWCy/zSH8uox6tcVb38tdwjrTGzmnrNKjfeOZLLfoE2bWM
         u5o0RuYYJCB8QJBA8aCQ+Q0ydFj5xEtRAKT/IEomcUstThCwoB9dWHi2hOrjinTSLK83
         tD60CBzQkF1QfrT33w2NfMEyCzhXbWKHwt7dv8a8h5qG3baGn7J2AHHXybT5fIeyg9m5
         pWz4/qLkXDnzriV1feTdFJG/Zc6n9ivdZ1cGb+AsApY9v2MvwB6d1j4sn8HI3xkx08kQ
         r1/tNE8BqmQ2e2RV0ZJ7BHPKYFe0mabVM7XrUFtm++zusiRwgZeppFJMSpeCDqbhhoae
         MY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=0XYuJwlWcPhF5wKwZj6AX0M1ehVlcZ8wjqHIDg46ZGY=;
        b=m3yJaNdbNkMG2RgqtX+xqOT3Q8ddUJmYHgSrbKjz+gZe/DW7vYhoclJvahYPspD8Gu
         m0Jk31loY4RnzOSAnyJRniBjCRyaXU4UAdYxIsoAKbHTxXaG5bpKxDh0dRnLh8u5h3fd
         z42IsvVMUf7VWoa3chu+wnFRuu5w4Wo2nO9eUjsG/dscyG3U1qgHRn+QvP24WnQc7vRQ
         v7AMP0LCEgx9+w80Rm6PPthwwUUz0M96adF4evMBxkaHGqJuIftOjh7x1+2EMrnkl/Sa
         VnQqB6qhAbFJV0r5BYgr+vDrtk20TdqzGzraX/WsLF11KnR2XfS1rv4/U7J9+kAyKNmj
         mgcQ==
X-Gm-Message-State: AOAM5304bNASkCBJsbJgxTXEbtnCfJdPcgnT89Zr0Xtk2z7T4/uvs/dS
        NEBebiCCHhgBvQ3lqbMnEmrYv+YUT6ab2zZazJQ=
X-Google-Smtp-Source: ABdhPJxcNEhPC7AeL9kaBqgCD24zfkjg2SQp/qCyj2QdxEpNS6YCUWIXSJROjitWpRK5IOVjFhBGEdjFtgEAOhw8Xno=
X-Received: by 2002:a25:2003:0:b0:663:e799:4ab5 with SMTP id
 g3-20020a252003000000b00663e7994ab5mr10204240ybg.403.1654761229477; Thu, 09
 Jun 2022 00:53:49 -0700 (PDT)
MIME-Version: 1.0
Sender: irenembogo22@gmail.com
Received: by 2002:a05:7000:1f9d:0:0:0:0 with HTTP; Thu, 9 Jun 2022 00:53:49
 -0700 (PDT)
From:   Dina Mckenna <dinamckenna1894@gmail.com>
Date:   Thu, 9 Jun 2022 07:53:49 +0000
X-Google-Sender-Auth: j8gis2Kl3HtP1hbwGJhUycZy-L0
Message-ID: <CALjO3ZGnx5O8SzbXpAfaa-oihBLOHUD6hhqyUxee4VNz21=ZUQ@mail.gmail.com>
Subject: Please need your urgent assistance,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.2 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_80,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b33 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.9256]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [irenembogo22[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dinamckenna1894[at]gmail.com]
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
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello my dear,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you.. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Dina Howley. Mckenna, a widow. I am
suffering from a long time brain tumor, It has defiled all forms of
medical treatment, and right now I have about a few months to leave,
according to medical experts. The situation has gotten complicated
recently with my inability to hear proper, am communicating with you
with the help of the chief nurse herein the hospital, from all
indication my conditions is really deteriorating and it is quite
obvious that, according to my doctors they have advised me that I may
not live too long, Because this illness has gotten to a very bad
stage. I plead that you will not expose or betray this trust and
confidence that I am about to repose on you for the mutual benefit of
the orphans and the less privilege. I have some funds I inherited from
my late husband, the sum of ($ 11,000,000.00, Eleven Million Dollars).
Having known my condition, I decided to donate this fund to you
believing that you will utilize it the way i am going to instruct
herein. I need you to assist me and reclaim this money and use it for
Charity works therein your country  for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of God
and the effort that the house of God is maintained. I do not want a
situation where this money will be used in an ungodly manner. That's
why I'm taking this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die.. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for.

I'm waiting for your immediate reply.

May God Bless you,
Mrs. Dina Howley. Mckenna.
