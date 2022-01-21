Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4376496613
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 20:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiAUTze (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 14:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiAUTzc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 14:55:32 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9A7C06173D
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 11:55:32 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id i1so2521861ils.5
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 11:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zt8HcH+qQ66PowPsNzXwwdSayvMzMtM+gkm6RSBQ62E=;
        b=TZuMhThRVsphdkG2KvPG9BLbDCWkJp7Qo+93hp0U8vgvkAyAY9UbitEMumbQH2Cj1e
         QGczOw9klGgjIjw0c+G+sqXMnKkmtd/LGbiTHMZfzfQHtdnvCybbGWqqgtBLp+aUuBIl
         /FbF4slrB73NkxSBatghM5bCgkGO50nAwC5RTq7PpqP5ukNh6frox3Oab0dMEUZA+0Pf
         J/39wJh98wx9J1Q9QKnlfOk/Y46rwfY2rJ8Do/WEC08rUyl443WJ6k7/ysI35dRxlnbt
         wsZI0i4cCtVDV0I+ATuSl53Mz8r/4+ZF9va6Ttdj1ZsodKdlCbf+PQ497MclCggKvXLL
         FI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zt8HcH+qQ66PowPsNzXwwdSayvMzMtM+gkm6RSBQ62E=;
        b=nWu6ooxYqFMBr9dZkwegBrbOyWREIEGgSufppzM+VGqi/qYWYfzeu2OU0ruaH3JlQZ
         Uh7SvFG5XERS1+offwZFmEbxhxu2MZTF4Nt6E7007tHbtAIPTq9x91ZP1MmxBvvn46At
         v7Cqr1u+dRwASArsTuUjW5oQzJ85ir0Yfk+g6g66VBrXz8w56yEGAkvCo4EoSWKEN4Li
         yQhfRphm5QVpZCrxWx3tL46MIwIT4C2Ni4Y/7ddjfBotH4Qw7XuaDvGA0KhGAEvL7ZN7
         0nvpUzSZSIYNgq2JuyS7eIgDyrvPbZzUjjv7JlUdSg8wyScNKtsTgGGM0zXMEs8vB99+
         Cy+A==
X-Gm-Message-State: AOAM530SHiANKuePwMY+3JQfdcyoEivnPrhk9wTLvBdFa2bvwtyc7BNB
        s9Z54HYXX/J5NccNzk0NoDSpic8K0YF/WiU0264DRwzZBoc=
X-Google-Smtp-Source: ABdhPJyYhPaUOGuZ9bCbtrdkOXJRK+8gzBI6gU81yuPEMT4vqGKq6bNX2pms6rOmHt9evqr1jgYXC2ut6DtbWYGfaA8=
X-Received: by 2002:a92:db0b:: with SMTP id b11mr3081558iln.98.1642794931387;
 Fri, 21 Jan 2022 11:55:31 -0800 (PST)
MIME-Version: 1.0
References: <20220113233158.1582743-1-kennyyu@fb.com> <20220121193047.3225019-1-kennyyu@fb.com>
 <20220121193047.3225019-4-kennyyu@fb.com>
In-Reply-To: <20220121193047.3225019-4-kennyyu@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Jan 2022 11:55:19 -0800
Message-ID: <CAEf4BzYKEw4M72Ls9M5sMisfMGGxaP0odc=RY2jOysfxGHS7PA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/3] selftests/bpf: Add test for sleepable bpf
 iterator programs
To:     Kenny Yu <kennyyu@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Gabriele <phoenix1987@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 21, 2022 at 11:31 AM Kenny Yu <kennyyu@fb.com> wrote:
>
> This adds a test for bpf iterator programs to make use of sleepable
> bpf helpers.
>
> Signed-off-by: Kenny Yu <kennyyu@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../selftests/bpf/prog_tests/bpf_iter.c       | 20 +++++++
>  .../selftests/bpf/progs/bpf_iter_task.c       | 54 +++++++++++++++++++
>  2 files changed, 74 insertions(+)
>

[...]
