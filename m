Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A0464F825
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 09:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiLQILT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 03:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQILR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 03:11:17 -0500
X-Greylist: delayed 3858 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 17 Dec 2022 00:11:13 PST
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25DBDF7C;
        Sat, 17 Dec 2022 00:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1671264670;
        bh=naNiKvNXpCoUO0USiB5TwbTaY+PW0EgRbU7/KgXZOL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=tWfBsS8d7/SIco0ZD1OZye+lBmPRzJ0iXmXSWdnGndH9uA14l4fTAnZ92MJKc/qle
         7yiiuIN0w3BgQMNOEZdWaAkItqXzGQ0h4Fn0/q1z7D5dSmdV7nEp+UUwKJ8Ddly0nq
         A+AAFuNn9MQW/ZhILosDJ1CkPtMlCR++Cf4gGvX8=
Received: from rtoax.. ([111.199.188.149])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 2C787682; Sat, 17 Dec 2022 16:11:07 +0800
X-QQ-mid: xmsmtpt1671264667t3vo99l5d
Message-ID: <tencent_6B46BD116F0C168438B3982F0F546C5F6709@qq.com>
X-QQ-XMAILINFO: NT9b64/RmY6Na/fKunJfLosD5cNmePXp6k7JoG9Fpb0v+c07YtObCru/Yoehrp
         XNUBHK2Gdgeng8s4lGAfHJsIVJZugrm8apK/2rpmO4/qrUw8iAX06bcLhEw0G0Q+/oakRHk7htiZ
         Gn5p3lZjBfAds33fWh4F4BC+aMKkBu/FLPmwH2q50AJeAC+zH/MCyh/l5/U7aJGIQkgUIgevtYmh
         yMcUkV8W7VJgOgExV662F2Btl6x+KMQ/Y0oUda8z+Rl0zL6RCvwEpZE4D7Fz7jGy7etNFtxj6dU0
         M2mykjNYmq3yA4uQ6wZSLqya9el6fM1aKgnr0nBsSk8/n9tFfkZl0HyL1vB7J7I0ABJqOm6Jeos9
         gil6IkH2/DlTOzie/sxZo0XWcSYtI5/YX1ensgazJoNQmgxqkKQuWhv0XJ/fdjVojmmvOzUAyo6p
         TC2/ikw7PS87Mm2PlfI/YkhxagYfYIewBCY/rZHGuWg6bSt7YAQ3BQaWTTjpmGD8QjqHtmQEUHvY
         UQpeXrvp68bL4Ll4Vj/FMo/fgXbKnM4nRa8Oe4TJX+z/NlOf+3EtL0+q9RjS+1NsguVwbhXMgdaq
         kKay5teT+gj+NLY1L3w96E7hb5MmJ6dB+Q8qIte+0evD1yvMBhVK31RZwEy1NCbkHxvG6GSxG4Cq
         EcrQ+T77PuQbWPZkJwefeIboftHt/IrVJY9OSvmNGHN/bTDsmN/8L5RlBUkk6mD0CP+6xZjUU6+7
         pGrTn6DUj9nqyPVdTas1hhVTFSK5onOCp0iJx2vm2CjNn3TD/FhEEeuGnukUwypgXKurSisxyIxf
         RhnpOwTzZVlwa1NkiKAP30QtxZl9moG+upJ5lm0C2Af+gk9POLA9AdXLNGeImLXxvqoWyFZu9aLq
         n3jXRhO7f7CoK5/jKEtLMBbA+NsnQNUQoCkrlJnzo1E8npU487HLoEpE3KVCcvJSAN5kar1e2uVD
         KrpZx9oKwPVyqH9LyY0+3OinHUnpmlBqk7VH0x9qczVEJEo9WBXrI5hlWgu9HwaMogila7bkZau/
         UZMuikiw==
From:   Rong Tao <rtoax@foxmail.com>
To:     masahiroy@kernel.org
Cc:     bpf@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu, rongtao@cestc.cn,
        rtoax@foxmail.com
Subject: Re: Re: [PATCH] kbuild: Fix compilation error
Date:   Sat, 17 Dec 2022 16:11:07 +0800
X-OQ-MSGID: <20221217081107.27031-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <CAK7LNASM6KsrXHXLykaQ=rJ3YZ5OA+7im4=g=3Ob3EPt97n_HQ@mail.gmail.com>
References: <CAK7LNASM6KsrXHXLykaQ=rJ3YZ5OA+7im4=g=3Ob3EPt97n_HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yes, It's happen in the mainline kernel.

I pulled the latest code and habitually compiled samples/bpf, 

$ git remote get-url origin 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
$ make -C samples/bpf

and the compilation error occurred. I applied this patch and can
fix this compilation error.
