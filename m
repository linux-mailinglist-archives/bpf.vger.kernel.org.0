Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5011934DC19
	for <lists+bpf@lfdr.de>; Tue, 30 Mar 2021 00:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhC2WxG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Mar 2021 18:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhC2Wwi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Mar 2021 18:52:38 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659B9C061762
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 15:52:38 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id da16so11943087qvb.2
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 15:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q+pONZ+c5gzLHZlc8vklxdpHbUYpIrWC8EjxE4Qzlnc=;
        b=i2KpWGdI/+ml8LNXX0aSU7N82qqTntdTDZjcHo8J2MMruG576SgALMQkjAX6KOXceW
         IrOVZ+cozFtEm6yTSStYwgQWftf2uFZcl/rgv2EGbcV3zTZxg/iLBHymUt/sQAx1kMYu
         viD7uqt2Mp4iqZsQWvx6T6WiIZHhpe6YkpdeUIPXwRZWKTcZU36ciArP6/nQp96X0QRX
         lhSB7s6xq/ddvkbqhYHYvvAE3bkN9L5MQ6BUhWL7Q9Ys0eUDQObZlFK1jHsbRlJRcgcv
         7F9SysQBjk9MQ9/LDhz/vAMJTZItQ/ppdSVI14TrjXvtGM9v8QyzL/Kz6Evt5CWBdB20
         cVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q+pONZ+c5gzLHZlc8vklxdpHbUYpIrWC8EjxE4Qzlnc=;
        b=m9gFqZMG+QeBeXG0657zBHRnRmmI4i27/aR8xIn3t1SN7FWJ8Nr6hiNA6R5yIbDqAk
         0NQuoj0eiHixDB14hCdTvudacD64cSkFW8Dn2xwvF6bHdcyEoyv/YfDiV/WjrcmxpBfZ
         vpqL/aPsvVUksUgMhEU1EjKbOkoNjQP0QRp8NPSndrwkNvBu5cgvfwpiL5blsOXz6jsq
         1DEbTL3VU7/8H7i6uMHy8LQaE+16165PJ8PVp9LQaDzH32YCusYkOWJVpoxlGeWp1+e4
         JwNq9ZjO/dbR+GNGhkOowhwGpBhg0pRlEId3BbQZGBW3Ql3kjka6bBXPRmYhDuDJTsBI
         g/oQ==
X-Gm-Message-State: AOAM530E643gXJ1zgVI46FYpoNH0+Rld/akPZATo1h3K5gP2j5sFblZL
        kweprDtjEHc4OVbdFwFM7Hzi8pZDk9H9NgcsVyM=
X-Google-Smtp-Source: ABdhPJz7NMMYH+EO7jPPhn+82vEbQx/l4SdUF0/BAZVldxnLPfgrSAWzVrLnKVkVhoFUEptinOdh+noYxp2C71l/FFY=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:c959:2751:3fb4:47b1])
 (user=ndesaulniers job=sendgmr) by 2002:ad4:4431:: with SMTP id
 e17mr27689931qvt.37.1617058357412; Mon, 29 Mar 2021 15:52:37 -0700 (PDT)
Date:   Mon, 29 Mar 2021 15:52:35 -0700
In-Reply-To: <20210328064121.2062927-1-yhs@fb.com>
Message-Id: <20210329225235.1845295-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210328064121.2062927-1-yhs@fb.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: Re: [PATCH kbuild] kbuild: add -grecord-gcc-switches to clang build
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     yhs@fb.com
Cc:     arnaldo.melo@gmail.com, ast@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com, linux-kbuild@vger.kernel.org,
        masahiroy@kernel.org, michal.lkml@markovi.net,
        clang-built-linux@googlegroups.com, sedat.dilek@gmail.com,
        morbo@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

(replying to https://lore.kernel.org/bpf/20210328064121.2062927-1-yhs@fb.com/)

Thanks for the patch!

> +# gcc emits compilation flags in dwarf DW_AT_producer by default
> +# while clang needs explicit flag. Add this flag explicitly.
> +ifdef CONFIG_CC_IS_CLANG
> +DEBUG_CFLAGS	+= -grecord-gcc-switches
> +endif
> +

This adds ~5MB/1% to vmlinux of an x86_64 defconfig built with clang. Do we
want to add additional guards for CONFIG_DEBUG_INFO_BTF, so that we don't have
to pay that cost if that config is not set?
