Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F722AE7AF
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 05:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgKKE6E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Nov 2020 23:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKE6D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Nov 2020 23:58:03 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AC1C0613D1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 20:58:02 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id i186so741329ybc.11
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 20:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUTjmLGub/YCmDfXiFpLm3Do3b5USfA0odfpLyRh1wo=;
        b=UPCYEikMp4W3TvI+rcLoFYCFZowQ1eSshSOFL+VPDBdapSY4MA3r7yJ4iTPSLmwJjs
         BYnmL+8gcnAOFC/gtLEe0Tcl6tlK1xlb8ggNfJF0Bmjc2dnVF8ZqGTSZmYLnR5M/XkSH
         o5tic8teN+WOLaWbel+1SC/YqXu06Ob+sbP88L6koXnjqMC6g9LZMhnE+KgxkJfAbg1z
         ZHkHG/i2DW7mSE2SvloG/LfYZBXBm+h88MgbLNjhqjiXpsgm6UVGnLXkk2ive5XMervN
         RNwZrnc9XJwfLnlAqEPt9ZFIrrfcWxDs+8/mczPXVMCsa7ymjDNb/O6PLzpPZVeX4gMg
         m5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUTjmLGub/YCmDfXiFpLm3Do3b5USfA0odfpLyRh1wo=;
        b=ty2pl9xLRpB+eXWouA1SyCYWnX59zI8WGf8iGeSQORlS9bU+zKyN62IxnxE+owvAR9
         AY7Ogsa0LsvIiSFf9S8mQhpi3lb6nCBdz2TWkkYyWGzA6gEr2RND8deTEske4xJLFTSf
         8MLbirIHXnuyeetIAxnCoF/ehHwkTvf+5SwR8XyC6lx10vJEo7Mxw2z/wf+TZ72h7vmv
         0z3tF9849eyhqNutzxcIE3vkLTTkf1pBABUWpPQnqbOudWbj8AgPKHBd6whLHGSXeAzO
         Awo+Jfyr0Zkpbf11WHtzsGoaxD4kxaHZmDjmmLpPeMLwGy2Kluyxrm0KH9fy4dOk0C1i
         iT/Q==
X-Gm-Message-State: AOAM531nWDu9mzJnWpQjtLr2hkZinKhGCYgTrGVuoxHvEgbYQDBMbZyn
        QId9Jlg7KH9M8dZ7wrqcuij28yenj9yIA8YBwWc=
X-Google-Smtp-Source: ABdhPJyQUBBIlYmgICGjQtFt72kInF2CVO7B/YB/CPy3ehWuLIwyLPvCOtbq5FqVH+mMRUtMmSZkJcJWrTSzNiR3bi8=
X-Received: by 2002:a25:e701:: with SMTP id e1mr6769640ybh.510.1605070681918;
 Tue, 10 Nov 2020 20:58:01 -0800 (PST)
MIME-Version: 1.0
References: <20201110164310.2600671-1-jean-philippe@linaro.org> <20201110164310.2600671-3-jean-philippe@linaro.org>
In-Reply-To: <20201110164310.2600671-3-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 Nov 2020 20:57:51 -0800
Message-ID: <CAEf4BzZSaEzg_v=bT_bLSFLpTxszTz-6j54WB=oHg5Zm5aD_wg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/7] tools/bpftool: Force clean of out-of-tree build
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 10, 2020 at 8:46 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Cleaning a partial build can fail if the output directory for libbpf
> wasn't created:
>
> $ make -C tools/bpf/bpftool O=/tmp/bpf clean
> /bin/sh: line 0: cd: /tmp/bpf/libbpf/: No such file or directory
> tools/scripts/Makefile.include:17: *** output directory "/tmp/bpf/libbpf/" does not exist.  Stop.
> make: *** [Makefile:36: /tmp/bpf/libbpf/libbpf.a-clean] Error 2
>
> As a result make never gets around to clearing the leftover objects. Add
> the libbpf output directory as clean dependency to ensure clean always
> succeeds (similarly to the "descend" macro). The directory is later
> removed by the clean recipe.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  tools/bpf/bpftool/Makefile | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index f60e6ad3a1df..1358c093b812 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -27,11 +27,13 @@ LIBBPF = $(LIBBPF_PATH)libbpf.a
>
>  BPFTOOL_VERSION ?= $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
>
> -$(LIBBPF): FORCE
> -       $(if $(LIBBPF_OUTPUT),@mkdir -p $(LIBBPF_OUTPUT))
> +$(LIBBPF_OUTPUT):
> +       $(QUIET_MKDIR)mkdir -p $@
> +
> +$(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
>         $(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_OUTPUT) $(LIBBPF_OUTPUT)libbpf.a
>
> -$(LIBBPF)-clean:
> +$(LIBBPF)-clean: $(LIBBPF_OUTPUT)

shouldn't this be `| $(LIBBPF_OUTPUT)` ?

>         $(call QUIET_CLEAN, libbpf)
>         $(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_OUTPUT) clean >/dev/null
>
> --
> 2.29.1
>
