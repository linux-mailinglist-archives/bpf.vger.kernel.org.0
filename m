Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C896A73B4
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 19:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjCASnl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 13:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCASnj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 13:43:39 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299BE41B4D
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 10:43:39 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 132so8295160pgh.13
        for <bpf@vger.kernel.org>; Wed, 01 Mar 2023 10:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677696218;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iPgVE50p3+NYCad7Rk9Fjmd1AgYT/z0FCbV4LlBTxfI=;
        b=e4DyHug9pVPX/31vYh2PwYbNEeWG/kGVPbui4vUAVKjjyl6WqVNm31HKlE9XaUHCl+
         N2qj7cjjY4Gz/3mUi8Ue3LNhjc5qC3nJgjvyVYUlowEkfxVioAz8VZsoCyLkBCeJ6Fqf
         M2PlbL7+uYi1BfSXFjGd0SNsuaF6rBZqk3GcUS0oN5Fbn3dybN3ws0Bl1L6TkUD+6OdX
         cQTYy1SjAD/2NVkYQu7UY6OhBr/k0sRvY0Kkgs7RTVhs8grVTw/yD4amxhUmXRRmqy//
         qSzIXdKz4D6nZfkCL4m1EVym4tQSJvGuJ8gUbFyvyFLJcacNzsmVNeGJqXuzrCxWDNFW
         2cKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677696218;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPgVE50p3+NYCad7Rk9Fjmd1AgYT/z0FCbV4LlBTxfI=;
        b=15oDwgmY6mK92PePpNhy5LIpmTUuQ0Tbe7G65An02DnySMeJ0fcSQWCGocdO34Mcak
         bjuke2kiGUPTDzlh84m3Jbor8RMcU4CjktsIigOeVDDvLjR2AGIVvoJHNL5I3cmw0Rmy
         FwyAA0ave+POaqqjsmYZ+reYwqOQlVU5+/ywM7WluGokQfd6UC3ksp4i88BOtJDaI+qO
         shMa3dAClnYXC+UnN4OnDtGhUymJcCX620N5M+aHUbH6zieFzQ70ybCcjq8yJ0DV1Jch
         SuMoA1jwjAys10GXMxTL1kRU+DfOuqM89kyowhajx8lalaKR9x5iNPEQUxxoGe42R19D
         wJQA==
X-Gm-Message-State: AO0yUKVIN9N51TnuCqUFGGlXMobykOcSFLc5TPHvinhf+zD7M8VX9+im
        tIhL8clcgGh/FCI+S5+g1oxjddSTgg4utp1Dg1Y=
X-Google-Smtp-Source: AK7set+e5lMSlMz1tnwBezaXkDL5I+QDS91H1fDlV3tmDK67q9hdam5jbzAjfE3FIqjh43cZlGosYu0YJ9lFtDVDipk=
X-Received: by 2002:a62:cd49:0:b0:590:3182:9341 with SMTP id
 o70-20020a62cd49000000b0059031829341mr2826261pfg.0.1677696218638; Wed, 01 Mar
 2023 10:43:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:ef71:b0:441:8573:ddf9 with HTTP; Wed, 1 Mar 2023
 10:43:38 -0800 (PST)
Reply-To: sackrobert@yandex.com
From:   Robert Sack <robertsack305@gmail.com>
Date:   Wed, 1 Mar 2023 19:43:38 +0100
Message-ID: <CAOjp-y=FBBVqzQs4H3G+kCChEFRrwa0sL86Ua3XiRGUETF=jOw@mail.gmail.com>
Subject: INVESTMENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:542 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [robertsack305[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [robertsack305[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dear Partner,

My Name is Mr.Robert Sack from  the United Kingdom.
It is my resolve to contact you for an investment proposal.
I have a client who owns a pool of funds worth Eight Million,Five
Hundred Thousand British Pounds(=C2=A38.5m)
and wants to invest in any viable and profitable business that has
good returns on investment(ROI)
such as Manufacturing, Agriculture, Real Estate,
Hoteling,Education,Trading and others, in an effort to expand his
business empire globally.

If you choose to partner with my client,please indicate.

Thank you in anticipation as I look forward to reading your reply.

Mr. Robert Sack
International Financial Consultant
