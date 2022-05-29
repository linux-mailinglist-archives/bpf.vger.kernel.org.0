Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55328536FDB
	for <lists+bpf@lfdr.de>; Sun, 29 May 2022 08:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiE2Fxs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 May 2022 01:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiE2Fxs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 May 2022 01:53:48 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDE55622C
        for <bpf@vger.kernel.org>; Sat, 28 May 2022 22:53:46 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v25so1770671eda.6
        for <bpf@vger.kernel.org>; Sat, 28 May 2022 22:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=dKcUIpiaOihT4R5jeXs4xTqFm8l6J3OzRyPekvqQPa8=;
        b=MzMx23hlTMa6f9nmganfrgWuWvj0+LSbHBXAz7AQF57CSomHtCJIvKWWXfH20FDIvv
         7O4IZwf6SF1SO0IAR9Uj/mONLpeOVSIveS6J4EL9sqbVhERVjylycfDF9Frsu0ITooYD
         Jb1f6FvKjgISpgb6z+75E6kGE16VGnvz7US+7PCs3yeTGLceMr3mo3JtX0VCBy6SgoJV
         GvZXFUJU0GtaPHurNbUQoeUBxu2gZcb01HE7L3abIiOgt9E1wf50eLUeicdSZuwIl/5M
         CHgqr9v8S5FyBrMM0lTDL1UtljmWFlY7m65e7fjbYpu6ebP0SNUZMhlrOZ5Hy0e9rYt4
         oNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=dKcUIpiaOihT4R5jeXs4xTqFm8l6J3OzRyPekvqQPa8=;
        b=oO4cojZjK0TgY/6Z9WpNa7v5CpCSIfOnRl0RJWhBXJp99vrVxx+j2NMOsOAvU+l5fL
         l0uNJi1GT6O4l9LA4y55He9Eou87Otr15QYaJoO6Gzh6z7NW4uwJTsQbogtK3tsELglM
         RbKWXi92BLQ5yQbz9nSpQRI5F9QPsy09X2vijvLfmyQcZ+rCJrBOrQkPgohyqM8Juc7f
         2pxLVIo+9VI/pKaKDiMFlOg/U0I0dVi/THvO0qq5m1HxAyqs2bZGW5/cAOUt/Whj7KBN
         YEs3IRF9pUv98cggBzWHjIGQsI+ENtPDrAAfuUsL7wLFUduvC5l8K23qtAi0D0x5l3O3
         wXEg==
X-Gm-Message-State: AOAM532Jh2B72ER+wVRPC2nxsX43UJnQMv3r6sBXT0RkQECWqib7E7kI
        v4vt+wGVkmrtP/jSjsEVwn/jfD3+UB6NuvFMuZg=
X-Google-Smtp-Source: ABdhPJzdGWZv4RzjWgGPXWEl6dPGaeptPrq+JjcxP4RK5l8wITn5nAutD/BN6yG4siPANEuehfSvTunFALnRaXGdFDs=
X-Received: by 2002:a05:6402:1941:b0:413:2822:9c8 with SMTP id
 f1-20020a056402194100b00413282209c8mr53495877edz.13.1653803623669; Sat, 28
 May 2022 22:53:43 -0700 (PDT)
MIME-Version: 1.0
Sender: brunellelaurence69@gmail.com
Received: by 2002:a17:906:4fcc:0:0:0:0 with HTTP; Sat, 28 May 2022 22:53:43
 -0700 (PDT)
From:   Aisha Al-Qaddafi <aishaalqaddafi6@gmail.com>
Date:   Sun, 29 May 2022 05:53:43 +0000
X-Google-Sender-Auth: JQVa-_Blx6PkpIlpoIBzeqj5_3I
Message-ID: <CAA4znVho2-pYsbo2R9Ddz-UvGxLcxwkH_NjTB3n89+YRGB2ppw@mail.gmail.com>
Subject: Investment Proposal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.7 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,
        MILLION_USD,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:531 listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [brunellelaurence69[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [brunellelaurence69[at]gmail.com]
        *  1.8 MILLION_USD BODY: Talks about millions of dollars
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.2 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

  Investment Proposal,

With sincerity of purpose I wish to communicate with you seeking your
acceptance towards investing in your country under your Management as
my foreign investor/business partner.
I'm Mrs. Aisha Gaddafi-Al, the only biological Daughter of the late
Libyan President (Late Colonel Muammar Gaddafi) I'm a single Mother
and a widow with three Children, presently residing herein Oman the
Southeastern coast of the Arabian Peninsula in Western Asia. I have
investment funds worth Twenty Seven Million Five Hundred Thousand
United State Dollars ($27.500.000.00 ) which I want to entrust to you
for the investment project in your country.

I am willing to negotiate an investment/business profit sharing ratio
with you based on the future investment earning profits. If you are
willing to handle this project kindly reply urgently to enable me to
provide you more information about the investment funds.


Best Regards

Mrs. Aisha Gaddafi-Al.
