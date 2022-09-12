Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D6A5B644A
	for <lists+bpf@lfdr.de>; Tue, 13 Sep 2022 01:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiILXoC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 19:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiILXoB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 19:44:01 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008255006B
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 16:44:00 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id n23-20020a17090a091700b00202a51cc78bso7626511pjn.2
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 16:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=M0WCnAmp/iyT01N3m/g2NWIDtkQOu3tR8TQDWRMQ1Qk=;
        b=Apmdot1sF4+TxViTEWp/YSC2o2tXrJVQq1BJLR54gqXe5GPeqsr+nXuxwj6k8AXLO0
         DFhMNPpHOfohDsdSkGbKI1+HDIx4p4QTN4K866+EDXv+FH1+nTKTTKWN44WdbdK4XrNM
         ux88sFAF3aID6C/8Q3n1Oxx1Ndi0ETn4zOd4fbH0lew4xPJxus03PXK+S+JW76E8F3T0
         D4ROcwB3uALVv8R81NjZb7p1LumOl0Aady9RBHGZOaQJyTsBIWw0eGMuf0zvlAZWcW8M
         sYE8JZZEP1AIiwZ4lT2FG8MhRffu4siSBTkwECuJA0JNUZqzaF7ZeqQVl0TazWZd5Djj
         nYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=M0WCnAmp/iyT01N3m/g2NWIDtkQOu3tR8TQDWRMQ1Qk=;
        b=THCs8u4R5A5slcbp0K+xx7ErI6TYd4wbirwdP4OOjTewVeu2+MqAuwMz9MpDvG5L+/
         hnKUAUr7aXvM+BPp98iV5Gli7xE/mrogAKgBVPT8NLtsKeuCZseKv1BCrRnqddmRzjvu
         +wjKLXZJfpbK6CHw2rQuBhe/MmEeKyo6qE13OfrrkM0+GWC7MshucV8//OEE7A4qyuQl
         pR9/1AJ/U80FPlj6ElWqvj3jD2tpalKL3YtHg580mE35sMQ/XkyhgqzQaWz85zIGHAeb
         yFTVQ77FbtTT6Hf42jZ9trIi0TpAoHIosKmJkNem/qaqajkvzfMk7bylMq8v6iKBzzw8
         Dgjw==
X-Gm-Message-State: ACgBeo1H+MDZXbnpK7BvuCp12bTBvkE58OqrekGe3TUe2sP+31eXNewb
        ygTZwTNXkDSVWG5lfJX09Bp2Kocmqx7sNM8BN/o=
X-Google-Smtp-Source: AA6agR4W+2TktNDyq4do5F1ad834C0BzpusRRBLGoihIAhxY3qTLAy93jyUZkar/GS5XH0xDM2Y+kjbU9aWxqT1clw4=
X-Received: by 2002:a17:903:11d0:b0:171:2cbc:3d06 with SMTP id
 q16-20020a17090311d000b001712cbc3d06mr27835031plh.142.1663026240241; Mon, 12
 Sep 2022 16:44:00 -0700 (PDT)
MIME-Version: 1.0
Sender: alimahazem@gmail.com
Received: by 2002:a05:6a10:d188:b0:2de:a7:9cf4 with HTTP; Mon, 12 Sep 2022
 16:43:59 -0700 (PDT)
From:   Doris David <mrs.doris.david02@gmail.com>
Date:   Mon, 12 Sep 2022 16:43:59 -0700
X-Google-Sender-Auth: JE5UUFsD3_OZ_ImjPeURToGt9lk
Message-ID: <CAFfm26vv3AUvQS3udvJzWmRhNjH4Yg7U3t4A94tnVgt6=Zj=9w@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.6 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
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
some funds I  inherited from my late husband, the sum of ($11,000 000
00) my Doctor told me recently that I have serious sickness which is a
cancer problem. What disturbs me most is my stroke sickness. Having
known my condition, I decided to donate this fund to a good person
that will utilize it the way I am going to instruct herein. I need a
very Honest God.

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
