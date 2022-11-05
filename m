Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3141B61DE1B
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 21:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKEU5v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Nov 2022 16:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEU5v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Nov 2022 16:57:51 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591E2E097
        for <bpf@vger.kernel.org>; Sat,  5 Nov 2022 13:57:50 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so11156193pjc.3
        for <bpf@vger.kernel.org>; Sat, 05 Nov 2022 13:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJX7x9ZdzVFgM09zOmFxSvoIk/LeXm8Y4q6c3HLDXfw=;
        b=NLDc9AV/SOrVFSzMDYn/H6uVn/8B/vwC3PZPY26q26Y3TLl8ksRrzpUoNQwGSYqs6V
         4FbUpO3ollM9fOwBnz+hayAhJ6ECyvCDjgA7FAp1XpJyGkZXsUrR2GeTEUtZSBJQAqTU
         r5VI4lSOMHJ2gCth/LdhINCLWx4MQ1uMgbeo28ziwxjKvMRjKZUq7nQhVUdIyGQ9sRHR
         doO7zItSB+RRSKRcnw9yVeQyDQ5Ii7kj29MBZj9arrxrjxOh3Wfi5Lc3XHWBRx0E0RUe
         NKR/9lS9VvmLAGI+73mcALQqHHrQio71X+o9eefpAY69R/ZwyHs501+LzlejJQ3zPmed
         mDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJX7x9ZdzVFgM09zOmFxSvoIk/LeXm8Y4q6c3HLDXfw=;
        b=wbmO6w7X5o9D15LcJJ96jMADpU7ZJmO7hHL/HV95b0237Gdg0AwC53mDLS0sYsdT4s
         QsOQvS4fYBkF9qPBheMqLNyHlIq6+D20FeY6HFVktSopfVctk4ISajoKp08RcXd5+HMc
         0SVwYnzi9BQSyKUBOgDdWOZHmAQ0whoGvsWeJ8Evf6fAPaE5DIxFSMdqtHTz1+H2sKOS
         XYScgDmT/9caATtxrRpNvNV/3ZISo86heCDQH+9MfAGGdRMYc7BA3cKyuqwk/zWMXwAu
         0Ivsb9NyigDLBVG0KGd0WmMr5CNI3en9PJq35BqQVvA7R3RuAmK7SBCELdgL4c3p3/De
         XaiQ==
X-Gm-Message-State: ACrzQf17y95q3zpEZUFAklTSbPJFVTFniF0Yy307fk0XZohPvEJe7K9e
        CsfKDdcUVC9/kF9ofN8LALx4F02t+mFPBMhJC7w=
X-Google-Smtp-Source: AMsMyM5plpi0NmnulRIfLs1oSvyLxfMGC0CqT928onxLEps/iJ3aXUNtbzfGui6YiFdmx9NvLb9sIkh9kYGyhtQOg6A=
X-Received: by 2002:a17:903:41c3:b0:186:dfe6:f25 with SMTP id
 u3-20020a17090341c300b00186dfe60f25mr41375966ple.47.1667681869780; Sat, 05
 Nov 2022 13:57:49 -0700 (PDT)
MIME-Version: 1.0
Sender: bikiengasomaila86@gmail.com
Received: by 2002:a05:7022:4183:b0:46:ec48:49c5 with HTTP; Sat, 5 Nov 2022
 13:57:49 -0700 (PDT)
From:   "Mr, Mohammed Rafai" <mohammed.rafai09@gmail.com>
Date:   Sat, 5 Nov 2022 13:57:49 -0700
X-Google-Sender-Auth: yavTj9OYNsUXsbMQdaCN7vaglDo
Message-ID: <CAG4XyYDVJ8f9M_0JNSowYKSWqynfhnNM_H_RqB2fPy1G0K3y5w@mail.gmail.com>
Subject: GOOD DAY.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.3 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HK_NAME_FM_MR_MRS,
        LOTS_OF_MONEY,MILLION_HUNDRED,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1036 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [bikiengasomaila86[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [bikiengasomaila86[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.3 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Good Day,

Please accept my apologies for writing you a surprise letter.I am Mr,
Mohammed Rafai with an investment bank here in Burkina Faso.I have a
very important business I want to discuss with you.There is a draft
account opened in my firm by a long-time client of our bank.I have the
opportunity of transferring the left over fund ($15.8)Fifteen Million
Eight Hundred Thousand United States of American Dollars of one of my
Bank clients who died at the collapsing of the world trade center at
the United States on September 11th 2001.

I want to invest this funds and introduce you to our bank for this
deal.All I require is your honest co-operation and I guarantee you
that this will be executed under a legitimate arrangement that will
protect us from any breach of the law.I agree that 40% of this money
will be for you as my foreign partner,50% for me while 10% is for
establishing of foundation for the less privileges in your country.If
you are really interested in my proposal further details of the
Transfer will be forwarded unto you as soon as I receive your
willingness mail for a successful transfer.

Yours Sincerely,

Mr, Mohammed Rafai.
