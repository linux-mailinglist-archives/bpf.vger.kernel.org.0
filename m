Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2406C50DE93
	for <lists+bpf@lfdr.de>; Mon, 25 Apr 2022 13:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiDYLRF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Apr 2022 07:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiDYLRD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 07:17:03 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B566631237
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 04:13:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id p18so12777018edr.7
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 04:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=K3+UMZtBG3ml5WnJpJEYh1NyDLNqUBh44FrKSy8hHKg=;
        b=aSprv8yx1/VHEmSEAmQlJPo2jYNNEpHhWNdzXW3HTpILY1cl1yqXwIUPMRdYvQhUba
         vxwbLUvU4iOZxxUw59OpIZT+Vj8J649EgfEoQzg/+RwV2kBanySSkIqci5tWbw0Oxwa5
         a0fQMZJxz9BR5pW+8Yab8XlbJWGiZrlaJN05map1pCtYNJ6up1ADdofDkWShirIzjtmk
         Qh6FAUkxqSE4MjoZ8tEK8Mq+of9RCGwUgQwRZus4x440fFHq3ZVHq6OMdLNN8LG2vRa7
         IfL+eQKgYpIvEa2OiW/0gmbhaBzBkB8iF/HsrnZXaViqF+8K+NlKIp+JUb4clGkyHi6u
         nvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=K3+UMZtBG3ml5WnJpJEYh1NyDLNqUBh44FrKSy8hHKg=;
        b=VXWK+Lwm4DHCEcN70QJ3nXYapbuErGou3OOb4JlS+sZ8jn+NSTGPf+KMWqY0hh/O6y
         lK+qAFyO+fCkGUhIYi0Xp7ti42H2Okuq6CA+to/vvMP8+ILB1AMNMwIj1r5kp8TNEvKK
         qSIFiPD+Wi/STHyHxtQB89n+d/Z11YhEAIcv7toH2zQACl38AAM1ntyL4wWgauxnHp8/
         hYcF5UctylYxpKrSzZFYelQvN02Aw8URbXlDxBNPKyRrvI4apgRjvOYVY7kjCXWZhKpU
         PbcqHAU4gXZRAnSzLGNWUX7Sex9f4CDkQHkRAMyDfQ5jh+41WAjZ9U+mMXD4czFlSHJ9
         80qA==
X-Gm-Message-State: AOAM532dNzBcSkI45/HRlsJTK+YKqKjKKWvAqSBP3I9WXGyGgs71Pzoc
        44HaanZQin+CbdV0KIwFSe3NJO+kwLQCpPcfk4M=
X-Google-Smtp-Source: ABdhPJxJkJ3efhDJZRaXXuzeWLBvSs1pgncro3KnXVqQgQmn99rurJeZRY7F8rbsSED0iaYL5R1cipVtK4rokNoWQGY=
X-Received: by 2002:a05:6402:440d:b0:412:9e8a:5e51 with SMTP id
 y13-20020a056402440d00b004129e8a5e51mr18654886eda.362.1650885238028; Mon, 25
 Apr 2022 04:13:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:a6af:0:0:0:0:0 with HTTP; Mon, 25 Apr 2022 04:13:57
 -0700 (PDT)
Reply-To: elizavetapeskova78@gmail.com
From:   Elizaveta Peskova <davidbaldwin378@gmail.com>
Date:   Mon, 25 Apr 2022 12:13:57 +0100
Message-ID: <CAH6Vp6kMv-gwhRARKtBajk0VpXqcYpHNVpZBpP=_d3pNCL0BFQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MILLION_USD,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:531 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [davidbaldwin378[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [elizavetapeskova78[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [davidbaldwin378[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I am Miss Elizaveta Peskova,daughter of Putin's (Russian) Spokesman,
Dmitry Peskov.
I have a ONE HUNDRED AND TWENTY MILLION USD deal.
I am searching for a reliable partner. Please reach me for details if
interested.

Regards.

Elizaveta Peskova.
