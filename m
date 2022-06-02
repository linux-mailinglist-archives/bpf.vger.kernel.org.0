Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE97753B35B
	for <lists+bpf@lfdr.de>; Thu,  2 Jun 2022 08:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiFBGIC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jun 2022 02:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiFBGIB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jun 2022 02:08:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E817C14387B
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 23:07:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id me5so7410980ejb.2
        for <bpf@vger.kernel.org>; Wed, 01 Jun 2022 23:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=o2gvj92MMCJDCXwiQ2IaKQl/GSOzCsdEUW5hfj1w4mY=;
        b=VUDW6yt3gYLZz3rkDDqgvSdu/8NehlMW2/VoHPyjDF92u7iblIfxurd6KLacjaloVB
         wk8G3yb1itamTxxXzq/sgQgP+a10UgXMb9AHFqH+1VZJMAY1ne62WMT+bLRqtIP+9Mpx
         sX29mLO/lA6zPOjq2Jaj89PfN/B28wXc636wyMxMSEaMoHDfVgPsZ47vpLM/Hzvm/dk+
         pd8ndGXnxxv1VjBwS+eioaMR1yAsHZbu+Bw8pcR6E4FRjLtAqM3DH7nCcX5xPbnQefW1
         lw58NqsPGsSJf6oFkyoM0/XwtVRkJFUtZtAngy6ZwcHdCZN7cQYnpuRaeWKmZQjqzqYT
         Plpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=o2gvj92MMCJDCXwiQ2IaKQl/GSOzCsdEUW5hfj1w4mY=;
        b=yPaBPdn9Kl3ngWOV30UVd9gkFOhQN1JBkQ7WwpPgE4w7wh5F3y5VP/3zll7KtYEBGq
         AnLNA8yBmdFMWjsXi8uilVdYl0kcE1A4tRm2h/TiZL18lRhIT+m1uNYHqCAHhK7TlG4v
         P849v46z5SMdn2UOjhwRTZnhaB71QFtZykD/P+CdXdbstIJ9aE7fviXFtkBkm1HIlY3+
         wmm+w59vB0fq7gfhe4ytbexljvABLswzttfeHLiq7dWEclIrq1kzyG+kgk22aoHj7j73
         bpoYx4LLJt30zRo4gb1jc9PsIFeaCRBtp3YLhiv/QS2rz30qlU8TSV2MONbHi3SKjrVh
         b+FQ==
X-Gm-Message-State: AOAM532a1Mx2OG66breTNzne9OxeK51EqoSvD+EFxs9plZxB3IKgGzqH
        b+YxEJTYdFq1wQAIwF6ZRgwWyrDjJ7MMDNa7xj4=
X-Google-Smtp-Source: ABdhPJy7z/0mtK/YzQsrmaWUfQQtQB1siLeiYgfmgTYoSeBhFQmb3fveo5KVKKjfLWFyf1i7XJXIXfXy8eQ+XoCjqTk=
X-Received: by 2002:a17:907:2d2a:b0:6ff:11ed:7140 with SMTP id
 gs42-20020a1709072d2a00b006ff11ed7140mr2741033ejc.85.1654150078387; Wed, 01
 Jun 2022 23:07:58 -0700 (PDT)
MIME-Version: 1.0
Sender: djmacdon5@gmail.com
Received: by 2002:a54:3347:0:0:0:0:0 with HTTP; Wed, 1 Jun 2022 23:07:57 -0700 (PDT)
From:   Dina Mckenna <dinamckenna1894@gmail.com>
Date:   Wed, 1 Jun 2022 18:07:57 -1200
X-Google-Sender-Auth: Y-at3Px75sA1BCAFvEBjgxSsK2M
Message-ID: <CAKGPEqjRLG0ekH1M4Oo_Y0z5MGKicH34z9jGKSjZEt_dwttxfQ@mail.gmail.com>
Subject: Please need your urgent assistance,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.8 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_80,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:632 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.9087]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [djmacdon5[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [djmacdon5[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello my dear,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Dina Howley Mckenna, a widow. I am
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
Mrs. Dina Howley Mckenna.
