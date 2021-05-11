Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0127137B1AF
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 00:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhEKWmU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 18:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhEKWmU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 18:42:20 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E944FC061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 15:41:12 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id r8so28414495ybb.9
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 15:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M4eCzpbgBRlgXYUOZlNoBSnCdWcGxCrUHE8NPaUJAm4=;
        b=WAG4Vu/CLl/nmjH8Hbt5H5wwM/T1JnxqKP9IQ24vyk3yo8yGSghkcZtJKX0FcC5hZX
         0KsmHWabhYzaoH+7UlaEIKc6gzLvY7TB/aWP7HfbUESgHLTqH9NI275mU+ts1s9YS36d
         tKIK5VYQM9HxosF3Q+giAYPUhVRtRa7nfCN5P4ayhekMXbeP1+TQYSen0kvEJlxLKDTi
         Us23+hIsCHjoTvjzSAMMktIrYzrXAv0WdiGsIvU9mJpvYnquHBfsTBM/isILY0L37Ao3
         3KHQVffaZV7qMrgvmVCWxvkiGjRmoJKdBD3xwjebAPCSN69yWEvmL2yqPMVPd5y3EUM4
         +sUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M4eCzpbgBRlgXYUOZlNoBSnCdWcGxCrUHE8NPaUJAm4=;
        b=liZ+wy5iDFCpKgzDPzF9lKqj80LXWSh0aiW4LzBblX2qvmQfg17qMzAW+I5wZPGsxo
         PQTFonTely1OkpR4D9vh8tddXGVG3I9xvOl1Rg1tvz6u5u4yowAvofN45cm6bXCdP4ZQ
         7wXrJWHBe6BKJhGQUGEBJXD7EoH8mugMDHUF0iD+TX97wOJ/04oMspbChlgwjAjf6EsQ
         KXurMtjRwH14pM8VkzkXG8o1yDXCLT1GJ44p6fXxMwT/vJmVOJ0gkOwa2B8mmeOCzxl3
         TOaCNBZ4tkvEaCSB1RhNOS947FH+Pd2rWiTiTm33xow0XHDbxdcGQOBoPHEjeqw1qsW5
         QkAw==
X-Gm-Message-State: AOAM533aR7AKcEo9sRHI7m1aJGmqCU4Yu73fitXVRS/f2o59ZwATe/3a
        YIG9km2FnlJNz4fBuNaCoOTmRSacHETNdSgx1ZM=
X-Google-Smtp-Source: ABdhPJyFMnJHC1aAYSwFjHz2TfYKVPWJgil9Xa1I9rPJ9+TKwldZ0YPmD2a/2Y8xmY1sPOHkrh3Pc5uNUsg/C1hibv8=
X-Received: by 2002:a25:9942:: with SMTP id n2mr45783983ybo.230.1620772872312;
 Tue, 11 May 2021 15:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com> <20210508034837.64585-7-alexei.starovoitov@gmail.com>
In-Reply-To: <20210508034837.64585-7-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 May 2021 15:41:01 -0700
Message-ID: <CAEf4BzbX7ohrFRModK29i+=8xscc_eFaa=BGs5eMWir-anpD0w@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 06/22] bpf: Make btf_load command to be
 bpfptr_t compatible.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 7, 2021 at 8:48 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Similar to prog_load make btf_load command to be availble to
> bpf_prog_type_syscall program.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/btf.h  | 2 +-
>  kernel/bpf/btf.c     | 8 ++++----
>  kernel/bpf/syscall.c | 7 ++++---
>  3 files changed, 9 insertions(+), 8 deletions(-)
>

[...]
