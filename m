Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4BF2AE7BF
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 06:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgKKFLt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 00:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKFLt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 00:11:49 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE6BC0613D1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 21:11:49 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id s8so757970yba.13
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 21:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9dicoKSccTbdrwWVEZxcZ0nH6JV7sKH8dAiMaD2RMC4=;
        b=JP1sD4VfqDiuDXxHgyRvLltl60cPwNCxbAeu1xkXF6PdjcG2X2V3ljAJnl2SFNEXmc
         vVODKPapdzKhLJM3cLhvu5b6x0TRxTajvFK2QkoRBtw6xXmY4F7hQSYNiCGT9qVWagAJ
         YzKtNwFk/NePIVnVJNeJIOKZQATFVryU7DLOUXXZkAQg6T9Lx5tXq3MW7kFw7okJqExv
         NAZU+eWDZQtwaDS8I2hi/SBGI7Eo/tecI9wzY5cEKfgnV5K/ZXmdv8Ki+WivbA6qyItG
         4qfa/sseixx+d/Kj4A4kHQwIQdPPzERozVFbFlHHUKXofFOD1nm6Rap+NHH8aV/D/JXe
         PlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9dicoKSccTbdrwWVEZxcZ0nH6JV7sKH8dAiMaD2RMC4=;
        b=MqfBObtlsOZoT4j0HSsRB+ZDmNF4j93BCT6kSNCIcodMmpc82OkQcxxoxcFN2uRw1X
         H4IkL9mYnarb7O9lcKOAh8iPpne7L7A2vzYTHskL4fl0hx6KOlJRjhxUAjwihc+2P0o7
         qjAWyTAqHhiZsNe5z7RYwUg7wqPaCKSIRrmtRVtoBG7u9DbZSL9mPDWRUBu4kM8REB7R
         gcNALVJ9DEbVbYh9+N2FBXjhkX/Qz6MwGlZgXpCN4YMaCEmFhYpUZkZAFqtdkX51UYYW
         879LIJo3hPkx1SoQFveJhdknT0XNnlSnAJvWM/foVioBtCwmtv7tdL/+v2PEODQoZBUg
         iCEA==
X-Gm-Message-State: AOAM532MlSG6bIXQXNYmTSrc5TQaC6m0UVUDBktp/nFqAJyNtb0gNdpu
        JS4gtargXmqvLI5vaahzdtARUllAd6RfHotqXUw=
X-Google-Smtp-Source: ABdhPJxe18gIJK8jsJcHYGvOcuXSLjZ4fEhhVjlpYL4hqlJN2jFqUzTm+P0FLwMg1A0q2WnXenAM8h9kGl5isquh8bo=
X-Received: by 2002:a25:e701:: with SMTP id e1mr6825017ybh.510.1605071508641;
 Tue, 10 Nov 2020 21:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20201110164310.2600671-1-jean-philippe@linaro.org> <20201110164310.2600671-7-jean-philippe@linaro.org>
In-Reply-To: <20201110164310.2600671-7-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 Nov 2020 21:11:37 -0800
Message-ID: <CAEf4BzYsJe6k9_K41VE2rKi8eudjzGp4w8dsyYAiZv9gHUAFHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/7] tools/runqslower: Build bpftool using HOSTCC
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

On Tue, Nov 10, 2020 at 8:44 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> When cross building runqslower for an other architecture, the
> intermediate bpftool used to generate a skeleton must be built using the
> host toolchain. Pass HOSTCC and HOSTLD, defined in Makefile.include, to
> the bpftool Makefile.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/bpf/runqslower/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
> index 0fc4d4046193..4d5ca54fcd4c 100644
> --- a/tools/bpf/runqslower/Makefile
> +++ b/tools/bpf/runqslower/Makefile
> @@ -80,4 +80,5 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(BPFOBJ_OU
>         $(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(BPFOBJ_OUTPUT) $@
>
>  $(DEFAULT_BPFTOOL): | $(BPFTOOL_OUTPUT)
> -       $(Q)$(MAKE) $(submake_extras) -C ../bpftool OUTPUT=$(BPFTOOL_OUTPUT)
> +       $(Q)$(MAKE) $(submake_extras) -C ../bpftool OUTPUT=$(BPFTOOL_OUTPUT)   \
> +                   CC=$(HOSTCC) LD=$(HOSTLD)
> --
> 2.29.1
>
