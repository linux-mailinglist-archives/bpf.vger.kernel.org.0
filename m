Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F4E3BF13A
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 23:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhGGVME (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 17:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhGGVME (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 17:12:04 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFA7C061574;
        Wed,  7 Jul 2021 14:09:22 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p22so5360504yba.7;
        Wed, 07 Jul 2021 14:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C6vaHBHLQ86nv6gCW9Andn0w14vFdfobqp0Pc0UDu7g=;
        b=egeJOdiS1vrfomZ+oMB4HS8c1VABojS9QAJiFcnVFyHm42ra3DRf2VougZTtyH/Xmj
         3LkqmIG4NKy+xJ/KK+rYnOE0FgJAXhZoUEW+jsmfMHseahyGFb8cxvbLm7qKGtqw2j8X
         JySzo+/1KPPtVguCY31F55HweunD42armKx1ga3vOy+OohLrxORzpT96NZlJDvY7Ue8O
         Thz0dL55i9tiqeGdqPj3k6zrK1MUXEV1drMFS2jwl6UG57smFZAmywu7+ui8o+iZrL6G
         ZhNsJuriS/croPUYt/wLevj+L+QojzKhjZYCwKyjpy2m4VuYGsJ9ILc3G+Q69HdVwv4o
         AgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C6vaHBHLQ86nv6gCW9Andn0w14vFdfobqp0Pc0UDu7g=;
        b=kQ8mMC0q8UKUjY1LTdZ2GFZPbS4HMsDgDuqAZJU72Kq4ZrsMSIkIU6CpRWtAHd13VF
         5Gp35dNncfGRjjx3awkuri+AAoUN0Li0SJ7RFkS885EwMaxjqVAr+16lrCgadpx1DGv+
         RzWMcw/QckON10otiTfPWV71sAsOMMtreUDfLC32CRPk5Ajshnf7c2MPfJhHorE/pB6w
         2zRQ18wxTI1foGXr5DNUFfemoBANnDWVsrC9+Zm9u8DES/1W7ZOzv/BOHxCyXaQOpddi
         Bjzu2b4oKcvbb7H9ir85GSH4dYqJ6QSjCKUqDVkCoeSjgoVGUdtMOhK7Pc1dY2h/ftm+
         tTGw==
X-Gm-Message-State: AOAM532iw63s9h1fppyDvzGajekMr8opgxFQNpwq2fIEt1hRsfmbC1QN
        BXvDdWytKYe8jBkS9X35YM47b6mW1qqG4XvE8jE=
X-Google-Smtp-Source: ABdhPJzx5nZoNwsuy8mN3LPMlehlZuAO+Qt+w7rxg3eDO0m/j6Ib+Lz+LoVkqsMZ1fmdSQFbGA0Yv/hcOkI9gME+AzI=
X-Received: by 2002:a25:1ec4:: with SMTP id e187mr34222347ybe.425.1625692161956;
 Wed, 07 Jul 2021 14:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210628030409.3459095-1-liwei391@huawei.com>
In-Reply-To: <20210628030409.3459095-1-liwei391@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Jul 2021 14:09:11 -0700
Message-ID: <CAEf4BzYYc2GyvWxKhAe9XY3zTCo2VQRHCo7jN9xU9wKOfoJDLA@mail.gmail.com>
Subject: Re: [PATCH] tools: bpf: Fix error in 'make -C tools/ bpf_install'
To:     Wei Li <liwei391@huawei.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        huawei.libin@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jun 27, 2021 at 8:05 PM Wei Li <liwei391@huawei.com> wrote:
>
> make[2]: *** No rule to make target 'install'.  Stop.
> make[1]: *** [Makefile:122: runqslower_install] Error 2
> make: *** [Makefile:116: bpf_install] Error 2
>
> There is no rule for target 'install' in tools/bpf/runqslower/Makefile,
> and there is no need to install it, so just remove 'runqslower_install'.
>
> Fixes: 9c01546d26d2 ("tools/bpf: Add runqslower tool to tools/bpf")
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---

Applied to bpf tree, thanks.

Technically runqslower could be installed, but it's better to leave
that to libbpf-tools ([0]), which distributes runqslower along other
BPF-based tools.

  [0] https://github.com/iovisor/bcc/tree/master/libbpf-tools

>  tools/bpf/Makefile | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
> index 39bb322707b4..b11cfc86a3d0 100644
> --- a/tools/bpf/Makefile
> +++ b/tools/bpf/Makefile
> @@ -97,7 +97,7 @@ clean: bpftool_clean runqslower_clean resolve_btfids_clean
>         $(Q)$(RM) -- $(OUTPUT)FEATURE-DUMP.bpf
>         $(Q)$(RM) -r -- $(OUTPUT)feature
>
> -install: $(PROGS) bpftool_install runqslower_install
> +install: $(PROGS) bpftool_install
>         $(call QUIET_INSTALL, bpf_jit_disasm)
>         $(Q)$(INSTALL) -m 0755 -d $(DESTDIR)$(prefix)/bin
>         $(Q)$(INSTALL) $(OUTPUT)bpf_jit_disasm $(DESTDIR)$(prefix)/bin/bpf_jit_disasm
> @@ -118,9 +118,6 @@ bpftool_clean:
>  runqslower:
>         $(call descend,runqslower)
>
> -runqslower_install:
> -       $(call descend,runqslower,install)
> -
>  runqslower_clean:
>         $(call descend,runqslower,clean)
>
> @@ -131,5 +128,5 @@ resolve_btfids_clean:
>         $(call descend,resolve_btfids,clean)
>
>  .PHONY: all install clean bpftool bpftool_install bpftool_clean \
> -       runqslower runqslower_install runqslower_clean \
> +       runqslower runqslower_clean \
>         resolve_btfids resolve_btfids_clean
> --
> 2.25.1
>
