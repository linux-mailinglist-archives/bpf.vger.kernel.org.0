Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8C96078DA
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 15:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJUNsk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 09:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJUNsj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 09:48:39 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE9725CE34
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 06:48:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m15so6009942edb.13
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 06:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVI76lTSw9pB4RfDaV6XrWKlpZMUCJVseq464Rg1AdA=;
        b=lAeQ5bPA05ko2TOHB8dLHt+PgZJ3XrGp9gA0frO/6L6U5trCElE50j4EoK6KD5qcr/
         me32tl41ey1lL5peIHVls+StbvMLM9Y447vDjfkF3zElvnmFTsB/AWYFVxP6r+PNDS+I
         +K65sfIBv0b5T0iK0t0rqsvS5vxCqxe9z/E6KfpR6kZGqZDro8p3UGzNmdwaaZgLEAUX
         Y5AXBxZg8XJbZAvgvuveS0zi3+cbJ3iYGm1PF2PWU8qlYBpqi768MATX1h/RoUBkm2yl
         HQhXLpyaxBvzre1yLMoE6T1bUacoFcvPcjMevggAFf/yi4Ve6vnaybfjsZy4QraFcMVs
         wE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVI76lTSw9pB4RfDaV6XrWKlpZMUCJVseq464Rg1AdA=;
        b=HCa/dPROjGnvLY3VVm0nHv9FavE+jV0CH8VYpheDqWBPjiOnQPhg2ov1+Y4lQ6xGVb
         QzUSNvdYGgub+XjlcYj0erKrfpvGnZMkoDHZ2QXWj1VXaO1cUzeY9H2MWd3Ke49iuzHk
         s4ETeF+By8Kr++Md+oEeCeVsCsqzdO8JjJ9VCbzJF0HaYWTPGO3wpOmp3LMtF5HGOauq
         Zarl5DTNSnStJP0AqUVQ0Tde0sgdVZdAmcqHN39jvq3o+vHFIHAUC3nbXh01+oFzAt4c
         ZntVKS3q+XAUL+4DIMsgZ0mGY/W1xQn3V05+SC6C230ofjPeDv4X19NhPGYl3Ad5Q32K
         TB7Q==
X-Gm-Message-State: ACrzQf1LEUi0CbhWGM/LWPLi6GuZA6B4SxiCuZz0OB7vLFbupprlMaDd
        x2CCvnztg9Rkr+7lm+xdmupueHL+VKHrgkGdq4Q=
X-Google-Smtp-Source: AMsMyM7rK/jSYXcixLRsgLGlzQgghLY2aIX3BfC6mP/3T75Z90foeb0kXhGj5get7DHmIgEjo36DPQzB+vYEXk82elA=
X-Received: by 2002:a50:baec:0:b0:461:4c59:12bf with SMTP id
 x99-20020a50baec000000b004614c5912bfmr2682296ede.54.1666360115862; Fri, 21
 Oct 2022 06:48:35 -0700 (PDT)
MIME-Version: 1.0
Sender: samco.chambers1988@gmail.com
Received: by 2002:a05:6f02:103:b0:26:8c2a:30e6 with HTTP; Fri, 21 Oct 2022
 06:48:35 -0700 (PDT)
From:   Doris David <mrs.doris.david02@gmail.com>
Date:   Fri, 21 Oct 2022 06:48:35 -0700
X-Google-Sender-Auth: Us0i2yAicy8taZkiBxAa39ltIGI
Message-ID: <CACePhLk2V_F9zGG+tt+ghAdfPE3_3X_PpDBNSi3+=T35LDTSZw@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.7 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:535 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6689]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [samco.chambers1988[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrs.doris.david02[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
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
Mrs.david doris, a widow suffering from a long time illness. I have
some funds I  inherited from my late husband, the sum of
($11,000,000,00) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very Honest God.

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
Mrs.david doris,
