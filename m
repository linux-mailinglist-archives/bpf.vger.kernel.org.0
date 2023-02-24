Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAB56A1F1C
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 16:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBXP7R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 10:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjBXP7Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 10:59:16 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C08651931
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 07:59:14 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id s1so6128516vsk.5
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 07:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci-edu.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gd69EcZCaUWq2XBOql8CdtpydmZmAMMmEq6g8NUqXt8=;
        b=tGDiDpZtZ3IlXb3hdHUpdMGN6Mc2ceiOUNHQeVQ6wOs1kUEu9JO9BJnNVrFqoKS40H
         5SWk4a13Ax4TMwWcm28c5XTIAZ4cI5rorOw33Gs4JbfQq9Oa4QUEIZP8HC5HtyqvW1iv
         ToyjrmHlDdgs1Kq5pVqeTyp+Mj120KojhqqnFn83RP3jBtjdjKf5Og0erGu5iQ4rmuhQ
         +Yt/wGhcpBGQdcEXFwUFgSuRVGP0EnCi6Xm+qNaG+d9NsbgQDnyN5xeyNaTvvjq1lfvH
         2FimKaHzPi3cG8oywOsh5dwrMmQFLz28+OOPc86Ba3fnR+NLNxZ7VpttdPRyRQay/qKf
         saig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gd69EcZCaUWq2XBOql8CdtpydmZmAMMmEq6g8NUqXt8=;
        b=Y8mSE63NUyjKIf57IQZ4MndJuSBwfPcKi9PmPk64rAsm0VAZ6Usz6HlLSxpYx1X05X
         PUu0Fd/CyqqpEr3RrYWtM/s7JYVH/I6arlKamAIOAvuFFewU2Bv7akHMgCUv04/Owvze
         O8EAvHK+kbI1lg1ZEXs+g7aPxXERDqqq6frO8WxGenLHSJsH5Pb0VOfcVwS6HJ+gNE/L
         tZ/+6lUSinpen/UFFbRnNICJ85qjpW6oEN3J7+6q5WCTNTgWp+9bJyHeOPPaNCXpnV9s
         sNnpTTz3HqQHdKkCBaG+e7cxwLOz8NInTd3hSBbLH3opPL/wO9onvHH7QdI6p0jyzoxd
         6HBw==
X-Gm-Message-State: AO0yUKVpeK92eeqTnZow79biC5OpAaHf6JZd2n/BZazCJAoGF2CalU17
        43xe+OusJF5kFO0TQCZ2/f6uXFUDCEmbP6DQgDIlUq/E09VzPJke
X-Google-Smtp-Source: AK7set/KI+iUwduWO9CjC/25Tn1VECwdWc9hn6tyIYx7PJjaFLuC3ooyBXaLcnwEOpXlC5KI3HZYLILzctcW0ReEpz8=
X-Received: by 2002:a67:e3cb:0:b0:415:5ec3:e507 with SMTP id
 k11-20020a67e3cb000000b004155ec3e507mr2851813vsm.5.1677254353140; Fri, 24 Feb
 2023 07:59:13 -0800 (PST)
MIME-Version: 1.0
References: <CABcoxUayum5oOqFMMqAeWuS8+EzojquSOSyDA3J_2omY=2EeAg@mail.gmail.com>
 <87a614h62a.fsf@cloudflare.com>
In-Reply-To: <87a614h62a.fsf@cloudflare.com>
From:   Hsin-Wei Hung <hsinweih@uci.edu>
Date:   Fri, 24 Feb 2023 09:58:37 -0600
Message-ID: <CABcoxUYiRUBkhzsbvsux8=zjgs7KKWYUobjoKrM+JYpeyfNw8g@mail.gmail.com>
Subject: Re: A potential deadlock in sockhash map
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jakub,

Thanks for following up. Sorry that I did not receive the previous reply.

The latest version I tested is 5.19 (3d7cb6b04c3f) and we can reproduce the
issue with the BPF PoC included. Since we modified Syzkaller, we do not
have a Syzkaller reproducer.

I will follow John's suggestion to test the latest kernel and bpf
tree. I will follow
up if the issue still reproduces.

Thanks,
Hsin-Wei




On Fri, Feb 24, 2023 at 8:51 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>
> Hi,
>
> On Mon, Feb 20, 2023 at 07:39 AM -06, Hsin-Wei Hung wrote:
> > I think my previous report got blocked since it contained HTML
> > subparts so I am sending it again. Our bpf runtime fuzzer (a
> > customized syzkaller) triggered a lockdep warning in the bpf subsystem
> > indicating a potential deadlock. We are able to trigger this bug on
> > v5.15.25 and v5.19. The following code is a BPF PoC, and the lockdep
> > warning is attached at the end.
>
> Not sure if you've seen John's reply to the previous report:
>
> https://urldefense.com/v3/__https://lore.kernel.org/all/63dddcc92fc31_6bb15208e9@john.notmuch/__;!!CzAuKJ42GuquVTTmVmPViYEvSg!PU-LFxMnx4b-GmTXGI0hYjBiq8vkwrFrlf_b0N5uzy8do5kPFiNcuZJbby-19TtOH2rJoY9UwOvzFArd$
>
> Are you also fuzzing any newer kernel versions? Or was v5.19 the latest?
>
> Did syzkaller find a reproducer?
>
> Thanks,
> Jakub
