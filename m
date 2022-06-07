Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B97540279
	for <lists+bpf@lfdr.de>; Tue,  7 Jun 2022 17:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245305AbiFGPcI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jun 2022 11:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344113AbiFGPcE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jun 2022 11:32:04 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F48F552A
        for <bpf@vger.kernel.org>; Tue,  7 Jun 2022 08:31:58 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id h18so12544853qvj.11
        for <bpf@vger.kernel.org>; Tue, 07 Jun 2022 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=94FE0xqKYNBQJ8bbUNfhKNNPOc38KM25jE5hqWXLeJ4=;
        b=a8KOCWzwr7u/J5DbCHyiLH/0MvqWySvwhAWR7YfHcf1tZ2ilnl7Tx54KTrUtPR7yFx
         YcfHopKVp/fZ9XIknrPEwJAeGaUQ5toGdQbkkFSj6KoztIOAP2e7sG+nVHA5+zu5dOux
         Hkiu9pJzeuzZ9TsYi3/VXOnWmPFjXgvJAfnqI+wWyvnxgSr5MVhdC1bR79rShg3u/pfq
         d+dJT3Rj9BnDNV6zQlHXihvDSoJ2qPPbldazeJsDrB62Fdmsb6J4jWyHPzB8QvbH+jfU
         t1FKoiZKndz+BhexI7MpvfHmM93UD/tXqf94vxcQizw5+nlBKF6LwzsTQTSVkru1+Sv9
         d2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=94FE0xqKYNBQJ8bbUNfhKNNPOc38KM25jE5hqWXLeJ4=;
        b=vYKfHrarnZD5JgBPCwU5pfnLD6nmLdvCcvRJ8ewt3kLiuR2F45IhLLn7MlJKWM2r45
         1m7/3fQzcTlTmBoWxU6/uKrwuBsB9ngphvMJ9/oVxMNH42qQo2ydX0bPy1CLxEpXjg05
         oYxN+d0NFo/mqMIcoDYNcdlzctMLuD0hGq8M6PsdWNP+HaE/Kq2QJ5PgucIfEu51yy27
         qcDcsHU1v3m7YNa/wYBcgr+612M+ffURRbGAgtBYgRVOVH1bY65hpFSUPJKBNJRogu0q
         FSoimnVxOzb1u4PeJGbihUuEe5Bhr64cdXwCLNmN/qqLXrxRYQ0bfxnyfB9sMSPHgOcN
         DV8w==
X-Gm-Message-State: AOAM532fQccMYOpMzBuZvNY4j0UCZk9UTIx+GlIE1dMyjXY+Yp3BAQ7S
        8UmttXqHjYT8JY7k/ln8Z25sdBZbwp41npNk78Q=
X-Google-Smtp-Source: ABdhPJzE6dbe3+4biG5opCOtfqSQV783b910wrIDxa9AYtr1mPq19771ZWFS0zaoj1lKk62qv4wf2untroDQrdvRN8g=
X-Received: by 2002:ad4:5d69:0:b0:466:1be0:88db with SMTP id
 fn9-20020ad45d69000000b004661be088dbmr23440934qvb.41.1654615917516; Tue, 07
 Jun 2022 08:31:57 -0700 (PDT)
MIME-Version: 1.0
Sender: 1joypeters@gmail.com
Received: by 2002:ac8:5f4d:0:0:0:0:0 with HTTP; Tue, 7 Jun 2022 08:31:57 -0700 (PDT)
From:   Dina Mckenna <dinamckenna1894@gmail.com>
Date:   Tue, 7 Jun 2022 15:31:57 +0000
X-Google-Sender-Auth: rtTs9QwyOb_0RgyT8fuoGyFU67s
Message-ID: <CA+F+MbYMyzRtO++C7o89ybC0GXKGn9_9=BOKP6MTEuswHpdJUg@mail.gmail.com>
Subject: Please need your urgent assistance,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.5 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f32 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6637]
        * -0.0 SPF_PASS SPF: sender matches SPF record
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
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello my dear.,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you.. It is by the grace of God, I
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
love and care for..

I'm waiting for your immediate reply..

May God Bless you.,
Mrs. Dina Howley Mckenna..
