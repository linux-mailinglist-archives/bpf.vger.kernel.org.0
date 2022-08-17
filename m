Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B48596BD0
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 11:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiHQJKH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 05:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiHQJKE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 05:10:04 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AE23DBF5
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 02:10:03 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z13so6629991ilq.9
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 02:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=NcME6EekOXNHkDawhzsVLzeNc0v+kj0+hSu21QgP2Do=;
        b=Vbi54fMf7QnlpoUxIDNkbBvLxNyxQKmxAJh+xtL4EtghCcjjMCtThEs2Va9vyI5GjP
         9Ffxoew72AmJMUIIP/avtF5OzkV8LlGL1/wRiJPi5t1i1UwkxcKn0HNfmRfnrLGYYaY3
         DH3903P+eaUF1rGj6+Dkxjd1q26FDN9Szk2f8gzYxLOf19iPNsbCOSq/3yRr3LHkOjPP
         vjvnn3ykOZ+S1wRid123gJe14EDkiRKQOIqDXo979y3rvsX1riZEeW+vb1ZZpYgaV7JU
         vZ5sYRacUIYithUdkBsxAWcxcXzosGr8FgpIuoPQVsiashf9n/XDLwbA/auh8tjLHHUa
         r+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NcME6EekOXNHkDawhzsVLzeNc0v+kj0+hSu21QgP2Do=;
        b=qpHHyvyqGfdofKE8KgQy8gLto4MTuvv+i0W0q14NGk1cp+JNCbYzw+Jrwm9oN2nAdq
         JIILU+FG1kKSv1dVVgE5nUE90rgyt+3SFlD9mmxqCmtvV3zNsCp9I8D8IMm771NTUQ8b
         gqzZd2jxIrDqp/IW8U2ET3kubb2nXct/Z6sYc3IjvKtX12lckK7q9Khf1S+dRl0pMleb
         FGlsrrHqzRXoovNDfcK88xTMjMbmnvYcHBgBdsvcOTlCwmQxmT060a5VZibtptsBmgQO
         5mN/cR1U1eENXQfnaDpCGHp3uHnu3uqvGystSzEEUEMKC/QsIX0QHFphUSChbF0lOhit
         t6Tg==
X-Gm-Message-State: ACgBeo2n9V6/pWX767BHoFKf9RXN4K9f46V0GMQw8oX4cM1IM5KCX7gq
        wnbj5UxhHotoMHK45XaJa/BwTS1Z3rO5C20ztgdTmjnW
X-Google-Smtp-Source: AA6agR7Kbw2mUqoaMhzsalzSdl7crgeog9+XF2pGxx5jbFcFgrap210KJV2ALWO9tOal5roefu/JJaVLb/Opg6tPQsA=
X-Received: by 2002:a05:6e02:198c:b0:2e0:ac33:d22 with SMTP id
 g12-20020a056e02198c00b002e0ac330d22mr11168443ilf.219.1660727402831; Wed, 17
 Aug 2022 02:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAP01T74U30+yeBHEgmgzTJ-XYxZ0zj71kqCDJtTH9YQNfTK+Xw@mail.gmail.com>
In-Reply-To: <CAP01T74U30+yeBHEgmgzTJ-XYxZ0zj71kqCDJtTH9YQNfTK+Xw@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 17 Aug 2022 11:09:27 +0200
Message-ID: <CAP01T75wYjDXwywg3o7hEhz0RKq75XTPyBrfswaYmq8s9f3faQ@mail.gmail.com>
Subject: Re: BPF Linked Lists discussion
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org,
        "davemarchevsky@fb.com" <davemarchevsky@fb.com>,
        daniel@iogearbox.net
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

+Cc Daniel (now correct email address, typo'd it in the original mail).
