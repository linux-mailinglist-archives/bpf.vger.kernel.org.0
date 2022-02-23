Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB534C1B51
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 20:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240733AbiBWTDw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 14:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiBWTDw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 14:03:52 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2D76561
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 11:03:22 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id u20so32857614lff.2
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 11:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vjM3Pbqrio4T3Waj8Ohr9l+5+xoDP9wf0i6swmkzpN0=;
        b=HnYlUc9BfHK13oTCte8XwsxKZJwj7s4kQY/vDqSkBVR2PPGKiHhecnJ7EARVN9Cl37
         RsgQLJf6IDOPcQ6GuQFhPIgJqGu0C1PQvlSBo7EbxsT4FmacHShgoXwqxMQNld/JmhT3
         OOPZH/Gg33L5bljzCzCMNam8vjtpHjKU5FOe+D1xuuiFDMFgrTMy+o4Hs02HcT2/hpHx
         v+W2b6DZLRRyeary8B9ohZdz9wjNOiB0rWo9EGZbcSbFkmwOtUyxsaXfv4wZJch41tmH
         XAPa64h01js/5emvDBuEn1ReCunv8/Xjy0akDiFmWjTwHaIqOeacPK4vqL64GWniQndz
         M+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vjM3Pbqrio4T3Waj8Ohr9l+5+xoDP9wf0i6swmkzpN0=;
        b=XIBUfKEu8xa1QRfVuB7sksJVfpVaeFqdueI0WXERMW0cVNKAnjZRe5L1QYLOZ2wksR
         w+qfqbyNT3hla5qOo/twXCWMxYvdaJ9mNORvnSkTgQ30CmW9jRO+i/6aRKWqpbP09SqG
         2NH3dXPbIa0Uh9i630T4bKriWHygoHrDwSg2FIbB7m1kSQA47Lwg2J+9LzeC/1GIovFo
         cqeeDaCSor8wtetQQGz98MZSxhCyJlk0udUfjX9qzrqWH7n0418ui7o1El5jlGfhpLOM
         qBjpMX2s2h99QunYg69NZ12jFzynrllwy2fctUeLf3tC8UNvOymTJcze9PqtctD/5uwf
         mkLw==
X-Gm-Message-State: AOAM5332AXPl11vjlKla+HT/SGSDkfZL30liMFWUMSLTg93KxBGS3ldH
        k/TLG7Ealo5Rf4BKVe6uDXKTM+mdLTLNgOiXWqg=
X-Google-Smtp-Source: ABdhPJyzlg8jFoqsZu7nJHFYh9o8K+WT3qLsd1jHEthaPNfPgHAzSIkF/ZfOrJQ4QjFEYlo36YuLe47Rux8Y38BrTSI=
X-Received: by 2002:a19:ad0a:0:b0:443:dc0d:b3ca with SMTP id
 t10-20020a19ad0a000000b00443dc0db3camr719065lfc.239.1645643000517; Wed, 23
 Feb 2022 11:03:20 -0800 (PST)
MIME-Version: 1.0
References: <20220223000544.3524440-1-fallentree@fb.com> <CAPhsuW5yLP=q2vh_ogdnq93MTuFeKRi5pM70no_BbpS5Y_cx9g@mail.gmail.com>
In-Reply-To: <CAPhsuW5yLP=q2vh_ogdnq93MTuFeKRi5pM70no_BbpS5Y_cx9g@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Wed, 23 Feb 2022 11:02:54 -0800
Message-ID: <CAJygYd2oyxHxopCM6vdt9BOUTph2eZjhzLuVU7qdo+7MULfJVA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: workaround stdout issue in VM
 launched by vmtest.sh
To:     Song Liu <song@kernel.org>
Cc:     Yucong Sun <fallentree@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Could you please provide more information about the issue?

Still trying to get to the root cause of this issue, I've found that
after https://github.com/kernel-patches/bpf/commit/cb80ddc67152e72f28ff6ea8517acdf875d7381d
, the init process would lose stdout on startup .

ls -lah /proc/1/fd/0 /proc/1/fd/1 /proc/1/fd/2 /proc/1/fd/6 /proc/1/fd/7
lrwx------1 root root 64 Feb 23 17:20 /proc/1/fd/0 -> /dev/null
lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/1 -> /dev/null
lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/2 -> /dev/console
lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/6 -> /dev/console
lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/7 -> /dev/console

and same command on the good commit
ls -lah /proc/1/fd/0 /proc/1/fd/1 /proc/1/fd/2
lrwx------ 1 root root 64 Feb 23 17:23 /proc/1/fd/0 -> /dev/console
lrwx------ 1 root root 64 Feb 23 17:23 /proc/1/fd/1 -> /dev/console
lrwx------ 1 root root 64 Feb 23 17:23 /proc/1/fd/2 -> /dev/console

This patch is merely a workaround until we find and fix the real issue.

Cheers.
