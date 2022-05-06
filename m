Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FA851E0B7
	for <lists+bpf@lfdr.de>; Fri,  6 May 2022 23:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351915AbiEFVKb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 May 2022 17:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358746AbiEFVK3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 May 2022 17:10:29 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F306EC7C
        for <bpf@vger.kernel.org>; Fri,  6 May 2022 14:06:45 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id i17so8574665pla.10
        for <bpf@vger.kernel.org>; Fri, 06 May 2022 14:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=leHUF3KZyHRhUc4HKjRwHu/M/8wJvb0Ad8V3mhjQm7agjlcXsMB+6Dr3zNAjJKqrq/
         Y5i6jUFKrJATj4D4Kn888Mi9mwjaEysOS8rH6qMe1IsaWXUKbJE/jCMRNsFPkSvwrHaj
         bOjfEZLsTaTHeF1yOB7BarSQ7LjbYEAYJ4eph4tVVdGe8syRHBEl9i+hnw5AxF47qKlb
         tcKRt/BY4wZ2psiegot6KbwsS/0Wwa4TY5TkWqCy0ZImlrkjPTmPiE1a36p7QZJCZlcA
         7jRtfG8AA24DSCF7F/DXG7RoCyBWZkatgWhLkDyvoJWboRaWBK6CLZobr7mCzPEvV2z6
         uf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=kzCzPN0vk0bIykHi1b77zurYZvZ2+ZuQUIIjATm1ReFcmyjhgaJsYnk7305hsruQ+L
         UOyduT/RznB93iERkoZJRskjXrnc3VkykeEC8wMkjZcMm2oqb72wUt9diy6rL+zjRXvi
         r1X1zI79UEy4FgTFzq88zTXelwa3Qd7xL4X5YM+BqPoHL03wxLZgTucLrxXlMDcrur+t
         G1wi8tSQtS61PGQFsp/yxCSU/6s8CvHHJ7PQJwrb9RrOQtLgWWD1MK7SPtotXtqtlp6p
         G7GtYpQSZyTP+w4Jd0Iq2HplelOCKp2Pjs8JuZ3kZMWPUTSRC+aD9rEF+UW6Y+bmiLiW
         /Fiw==
X-Gm-Message-State: AOAM531SC0Lvh40bU8iesUHb/ywJYccXMVDIMQ9juqf6eqXsykLtFzqI
        qh527WDjRIm58qbT5JXJCKvcUjbUVX0j6qb2tA==
X-Google-Smtp-Source: ABdhPJzBPOUWqvriO7qDq6E1Rkv1QbPkM3POPYa/AMoboO9ThbsG/8QM4zKgtp//HhBI+3TCHc/tbJ6ywzbiSzMiH4s=
X-Received: by 2002:a17:903:32c6:b0:15e:c1cc:2400 with SMTP id
 i6-20020a17090332c600b0015ec1cc2400mr5582747plr.153.1651871205349; Fri, 06
 May 2022 14:06:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:9906:0:b0:4ba:807b:b8f3 with HTTP; Fri, 6 May 2022
 14:06:44 -0700 (PDT)
Reply-To: warren001buffett@gmail.com
In-Reply-To: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
References: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
From:   Warren Buffett <guidayema@gmail.com>
Date:   Fri, 6 May 2022 21:06:44 +0000
Message-ID: <CAD_xG_rYPv6OTzOSZX5aE=r=Ev_h6mVa3Q-g0bJbTQck_j7aZg@mail.gmail.com>
Subject: Fwd: My name is Warren Buffett, an American businessman.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:643 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4987]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [guidayema[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

My name is Warren Buffett, an American businessman and investor I have
something important to discuss with you.

Mr. Warren Buffett
warren001buffett@gmail.com
Chief Executive Officer: Berkshire Hathaway
aphy/Warren-Edward-Buffett
