Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71005AE7A3
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 14:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbiIFMR6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 08:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239955AbiIFMR3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 08:17:29 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FF87C505
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 05:15:26 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id y187so8762147iof.0
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 05:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=cswpG9iwOTUnnU6xyH5R+5rqbDW1PNgJFzkzNTjZd9Y=;
        b=KuS5E3cq0x38gXebrbUbRXvuDu9WF9fXv1Neb+kutD3oH1MHUASqnNEty9tawdChG1
         zyEzqRHr5lG880K5uUxPG1vEbFS2OCwPFTmEtYg0seWYHfp2otnu+TEnlXLV1zzeCFnb
         JpC4+NWbm9+Eq7UNuCSMFfzkaJ9DuLLItvJRpXpeQkBiW46+cpnlD5UU8I7jEjo4p7ie
         BCzuttNcDK1HvHOgLMZZhTGhLpcuxnAShR7Sois1UzPQJ+yLUvplH2oGUyxAqvWVlYjB
         ObK4c3za/5+aOt3oQBLmIWs9bdKiAQD+BTtgyh8KS4iDY60Ln9BybXZd4GBkGcV0XjjB
         VPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cswpG9iwOTUnnU6xyH5R+5rqbDW1PNgJFzkzNTjZd9Y=;
        b=A3GZxvlDfL0+xC8zUiU1dcNkCsU8aWmxsux1zZxMmLeB9i7ynWh/z2gd1t3G5SHd6L
         DjromMZ+uWvkOf1Z5EResLkJdPPclkihmRQaY1+TNBqxAU1jWoDmSeaIRw5SQCFuo1CX
         H5k6dlpqr5NBi92nthhkA2ay6ulm/nYSIp3Y6J4B5KzQMcQALUeDmNeexFmXcFHJ7sZd
         z0J5dkm2sD1JqId2ns8D7yx1EGnqi+WTUhQTkIG0Ur24EzfFoQ7/e3HcTKf0/eoEwMyN
         ZmAWLdh5LaAfFkSpeJ0GgqqIYslTfCCrJGav+MRG17NL4910SlxmAQZg0qhCzbuMLmWz
         ZuPA==
X-Gm-Message-State: ACgBeo1tadQmspBh7bgb04XZyfa2z0sgXtsVn1TALEgwJ59XxuPk0GFv
        carFLy+wNlZl+O0XK+HWVSovoM18e22FgaFUcE0=
X-Google-Smtp-Source: AA6agR67D4yn3sJ2T3Hjhs090PT/AThCWx4lFltdMfgUM0ESrbiXqVAuiI9G9/eDAHLHplQRQaf35F77i4/wjN/I1gk=
X-Received: by 2002:a05:6638:411f:b0:351:bcfc:be28 with SMTP id
 ay31-20020a056638411f00b00351bcfcbe28mr6660713jab.189.1662466457914; Tue, 06
 Sep 2022 05:14:17 -0700 (PDT)
MIME-Version: 1.0
Sender: lovelyvictor827@gmail.com
Received: by 2002:a02:cc2b:0:b0:34e:2662:91e6 with HTTP; Tue, 6 Sep 2022
 05:14:17 -0700 (PDT)
From:   Aisha Gaddafi <aishagaddafi6604@gmail.com>
Date:   Tue, 6 Sep 2022 12:14:17 +0000
X-Google-Sender-Auth: PcT_DbUjg0lwyrJtwl9bSnWyhOY
Message-ID: <CAPjnvb=5WMuaaqqYhHXZhxvMdX00zfCzJDdKW1Ob-NWf6FMN0A@mail.gmail.com>
Subject: Investment proposal,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_99,BAYES_999,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,
        MILLION_USD,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d32 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [lovelyvictor827[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aishagaddafi6604[at]gmail.com]
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Dear Friend,

With due respect to your person and much sincerity of purpose I wish
to write to you today for our mutual benefit in this investment
transaction.
I'm Mrs. Aisha. Al-Gaddafi, presently residing herein Oman the
Southeastern coast of the Arabian Peninsula in Western Asia, I'm a
single Mother and a widow with three Children. I am the only
biological Daughter of the late Libyan President (Late. Colonel.
Muammar Gaddafi.). I have an investment funds worth Twenty Seven
Million Five Hundred Thousand United State Dollars ( $27.500.000.00)
and i need an investment Manager/Partner and because of my Asylum
Status I will authorize you the ownership of the investment funds,
However, I am interested in you for investment project assistance in
your country, may be from there, we can build a business relationship
in the nearest future.

I am willing to negotiate an investment/business profit sharing ratio
with you based on the future investment earning profits. If you are
willing to handle this project kindly reply urgently to enable me to
provide you more information about the investment funds..

Your urgent reply will be appreciated if only you are interested in
this investment project..
Best Regards
Mrs. Aisha Muammar. Al-Gaddafi.
