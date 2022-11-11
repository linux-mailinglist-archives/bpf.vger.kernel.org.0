Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FA2625AE5
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 14:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbiKKNFU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 08:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbiKKNFT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 08:05:19 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F8711A01
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 05:05:17 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id u7so3315869qvn.13
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 05:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRKsKZ9roUo1o+EwBFKVkcWERvQzgvnAIChK76QnCDw=;
        b=ZczGiqcR2q56u6TE1nq51NO1YD77ewbaEYgt7z57Z1h0Kqo4udtade1R8fPBgzX/mt
         fssjwCFyn8tF2jEtN6ftAtcuY2/iRqmpJoaTRwTdpR4Zy9/XY9Y8qO/7FJr9Q9kK9z2S
         4WjTLqNF7ChJCl5qLIYryQWw5wtFAkcQYdoJRBH8Y1yOiwQvmI4+3yC4X6cfHhwe1x1W
         VWxTqmTpEKYeGkmTW3WiLH4F0P5qymwe3qmVhpGb1NnsZ3SmL7mtU0YYGXtpFVOW4iV7
         4Xh1jf9xpe1PUlAtUcEt4JS3285Gi+/ZROJZBkoexooCFNXOmtZXa9etCfH6folmE72N
         1H5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRKsKZ9roUo1o+EwBFKVkcWERvQzgvnAIChK76QnCDw=;
        b=kNyaJzzTK6BeBmZlEDfKfme68YJajjjIkrm2fNQFitWgx2PNgXJxUAUzQ8jRw26raW
         our3d1eFYCNyLJeSX3oq0txYwf1PcHsO5L+GzLXUjj5GLRSrv9UYgu7TSIZS/DLKnqll
         SSeF0fdNPwQaYr+tMm2uZ193u9xhwMtk3eM2tNRpwv/ib70/U2YK1SVfubZAkWc51CaV
         /ZO+Id3Yg5hN5a8NYcjc6ZzLvhrzDo+Pq1ug3kl9MNTfE/dyAtKgjaYsOw16RFkDwByR
         taeUcLqyb0Vad7orQ7lBtqDcYLX0gg8qh96ib990E2sIXBgrI/f9Z5R168bvoOE7QT6Z
         kiPw==
X-Gm-Message-State: ANoB5plaC+nXroZJ4kLokLBepPjaLd3bjq5V+Aedop+882hZkTTXxho1
        4fNNbdLVWo5eBTBudrQ1uvc1IQYwF8nd2BsOp6A=
X-Google-Smtp-Source: AA0mqf4UCoO9ZomGyDCCaMYLbJzuWcQcg20hOomUGeulmucDU3O20Idr+r+p2mXnYEdmD9ma/8jrRMGVlhjEDPsJoxw=
X-Received: by 2002:a05:6214:2e84:b0:4bb:717e:1462 with SMTP id
 oc4-20020a0562142e8400b004bb717e1462mr1692210qvb.49.1668171915875; Fri, 11
 Nov 2022 05:05:15 -0800 (PST)
MIME-Version: 1.0
Sender: elisabethj451@gmail.com
Received: by 2002:a05:620a:44cd:0:0:0:0 with HTTP; Fri, 11 Nov 2022 05:05:15
 -0800 (PST)
From:   Doris David <mrs.doris.david02@gmail.com>
Date:   Fri, 11 Nov 2022 05:05:15 -0800
X-Google-Sender-Auth: 7ChK3zN6P-QkBZAxiZtIxc-F2n4
Message-ID: <CAP7Jaw6d_Uai-T6FBfgfUykSpb=L5brBtPmkEcKto9G-9u3w6Q@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f2d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [elisabethj451[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [elisabethj451[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
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
mrs.doris david,a widow suffering from a long time illness. I have
some funds I  inherited from my late husband, the sum of
($11,000,000,00) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness Having known my condition, I decided to donate this fund to a
good person that will utilize it the way I am going to instruct
herein. I need a very Honest God.

fearing a person who can claim this money and use it for Charity works
for orphanages, widows and also build schools for less privileges that
will be named after my late husband if possible and to promote the
word of God and the effort that the house of God is
maintained. I do not want a situation where this money will be used in
an ungodly manner. That's why I'making this decision. I'm not afraid
of death so I know where I'm going. I accept this decision because I
do not have any child who will inherit this money after I die Please I
want your sincere and urgent answer to know if you will be able to
execute this project and I will give you more information on how
thunder will be transferred to your bank account. I am waiting for
your reply.

May God Bless you,
mrs.doris david,
