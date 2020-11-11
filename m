Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC392AFA09
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 21:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgKKUuz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 15:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKUuz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 15:50:55 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1684FC0613D1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 12:50:55 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id o71so2868838ybc.2
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 12:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hNl7JVWufokOVAdPKmCahaOrYQipJUzlduEjgrKv7xs=;
        b=VTE+5lmKCK6ugOCZRePdAg1wqVut5d9H7tu5e3NM6GB7MfnnG3LIuGPfPdz/DxU0Mc
         Wdcm6Kqpcj1mDLJcjIRvgAKTV5j9Upk8M2F89XHBAQLij+8zp4jJQ+0dtnq+059qiHcH
         1gFkwLrUGkOYYS/eHjEIcsWIjSD6afjW0/9mHwkoTbWD+jCk9A+njVi5S3/gxONxK3m6
         fNFjOgTbbSAo3qQ0GEbl02r6lgF8bRqPeUqHsmgXlRkp1qjt+gIYoVfkWi0aV6G/HT+7
         e5GVACbPsrVbsTTiwz7sxDgJKHY10w9+bQakpNHPNKHVzsHfmtOqq6834x9Ene8etcF2
         qLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNl7JVWufokOVAdPKmCahaOrYQipJUzlduEjgrKv7xs=;
        b=S00khyIP6iCjGybyDSal3OUDA718W54uiNSjZsEv3euwMU19Z8tvGGOHI1awAi8nGT
         ja7235kVh6KtGaYGdRnEQPU37x8V6MG6g1c+a/cmDPCjg+4+HdR3lycOPFVjrieC3KCa
         3w9frvAsjYJCFtk1GTKFgexg8vZeG3u1rPz5stwHH5b7ExyUZuNyJiN1Ht8zfPEGuMbZ
         oyV2QBf4BeCPERPGhOkd7SdH9Fy23Dx2tAPkgbNCppHoAg+vbOz3rQ+SjLBOgy13efn8
         uAk0s7vcOKXq0z2MvQRB25NWzwRqej0H1yEFHPGtyFC8hxwwh3CIM2UIREc3x9IX0ndC
         yWYw==
X-Gm-Message-State: AOAM532Qx8qgv0/ZzFz+FUF3l+aQhMrX1bLELSsohaISXAFlBHsOS7vV
        ECnHb6kCG1XVBMne3b/vvPDUs13mOACXpVLMFf0=
X-Google-Smtp-Source: ABdhPJyfYRJKJH6oPFQbCzj3oW4Ft0BhZOSN3zelO9PwEi3DVmwZeMV9mBxj8draeicT/TIqijVdlUosDZraT5lnv7E=
X-Received: by 2002:a25:585:: with SMTP id 127mr25107580ybf.425.1605127854295;
 Wed, 11 Nov 2020 12:50:54 -0800 (PST)
MIME-Version: 1.0
References: <20201110164310.2600671-1-jean-philippe@linaro.org> <20201110164310.2600671-4-jean-philippe@linaro.org>
In-Reply-To: <20201110164310.2600671-4-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 Nov 2020 12:50:43 -0800
Message-ID: <CAEf4BzbYcgzbrwS2uH0NDa+0O48BUXvZ0ySV+xcw6-inrro-UA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/7] tools/bpftool: Fix cross-build
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
> The bpftool build first creates an intermediate binary, executed on the
> host, to generate skeletons required by the final build. When
> cross-building bpftool for an architecture different from the host, the
> intermediate binary should be built using the host compiler (gcc) and
> the final bpftool using the cross compiler (e.g. aarch64-linux-gnu-gcc).
>
> Generate the intermediate objects into the bootstrap/ directory using
> the host toolchain.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v3: Always set LIBBPF_OUTPUT. Tidy the clean recipe.
> ---
>  tools/bpf/bpftool/Makefile | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 1358c093b812..d566bced135e 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -19,24 +19,37 @@ BPF_DIR = $(srctree)/tools/lib/bpf/
>  ifneq ($(OUTPUT),)
>    LIBBPF_OUTPUT = $(OUTPUT)/libbpf/
>    LIBBPF_PATH = $(LIBBPF_OUTPUT)
> +  BOOTSTRAP_OUTPUT = $(OUTPUT)/bootstrap/
>  else
> +  LIBBPF_OUTPUT =
>    LIBBPF_PATH = $(BPF_DIR)
> +  BOOTSTRAP_OUTPUT = $(CURDIR)/bootstrap/

This leaves behind bootstrap dir, which is not in .gitignore. Please
follow up with a fix. Thanks!

>  endif
>
>  LIBBPF = $(LIBBPF_PATH)libbpf.a
> +LIBBPF_BOOTSTRAP_OUTPUT = $(BOOTSTRAP_OUTPUT)libbpf/
> +LIBBPF_BOOTSTRAP = $(LIBBPF_BOOTSTRAP_OUTPUT)libbpf.a
>

[...]
