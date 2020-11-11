Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F6A2AE7C0
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 06:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgKKFM6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 00:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKFM5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 00:12:57 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876B6C0613D1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 21:12:57 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id 10so772945ybx.9
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 21:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8LDBfPOxnmmx3ZSLaU6+USfRTDqtxqDLKXzibHSWr8=;
        b=PkD4hcK32r3CLxIsZWYUYBZ3TJKZceyVNMMqVGvcHML0ctr0uQ3pxUqgbZ5YT/Z8cS
         TF08AJwiMenuk+JvsoIagoZCWoQOTCV6gNvzQUskmCrXIz+ekaSUQtk4xI8e0SXC62Iu
         Pi8DHtM5OwlSHwUQKp4LhRGPtGYPdHnZ6OiXATYkxf/r+sv41ZPW8RImex2rAA9nKUge
         HjGVH52MPrmhvfS+Id+nAbsG6GeWDuyLfBQ6Nj7AGb45yluq47lBh1vTAJ75raPKD8DA
         CAo4+G+Cxlqvh0cj9LJANWOqboLe5cJC2D/SbpWyL6sAqlsu86fHyM1GGhKBTjj0bnLz
         J3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8LDBfPOxnmmx3ZSLaU6+USfRTDqtxqDLKXzibHSWr8=;
        b=V1axCj85y119qJbo8H3jR2vm8Opgsv/RG+OxFQm6jMHC+A4/QmqONjeAlYPGHZqylt
         h6+ihiaprpS21x7bSv9j5MUyQynFHNphFgkcWkhGG0CB0xkobEUfPCQRZvAk+ylTg7kO
         LxuPtma9iAmTkkxZOXzil4f1zPWsWsd6pCcKkzSC37kVc2OTnt4JrkjgbRzwepTu+uQR
         4eVOpPCADRyrwJh3+r6bRtVMV7KHsrItDc3mM4n27e0zBDLBiy/5segvaWHTJCzvNp+6
         YvXR23dhZ7YAYg8FeEEF0NJ+U0K0yOqx0ypy14fGfPndr6ERiwBqgldKIBKCe00DiIyl
         6HvQ==
X-Gm-Message-State: AOAM533VpRxjDdlIcnhOB7nuvQaZgUVbSBvr21VD45A5+UPTBEZufaYH
        62CigRVz9NtJF7bjOUP3w///m9KIYft+euzaxV5yVICN5JHwSA==
X-Google-Smtp-Source: ABdhPJyDyY4/of+/BmiZ1Cd4BuDh5b6BxPdDSvPD5qBmSfKvf115KYJScb0f/LBOG5Hq1k+Jk3KuHWsRuPxiT7+Mh6Q=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr31912970ybe.403.1605071576834;
 Tue, 10 Nov 2020 21:12:56 -0800 (PST)
MIME-Version: 1.0
References: <20201110164310.2600671-1-jean-philippe@linaro.org> <20201110164310.2600671-8-jean-philippe@linaro.org>
In-Reply-To: <20201110164310.2600671-8-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 Nov 2020 21:12:46 -0800
Message-ID: <CAEf4BzbBmZFzyAsjY-rAr4_zX5Csjtfx4uxRoVjafBJAmCKN1Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 7/7] tools/bpftool: Fix build slowdown
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

On Tue, Nov 10, 2020 at 8:45 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Commit ba2fd563b740 ("tools/bpftool: Support passing BPFTOOL_VERSION to
> make") changed BPFTOOL_VERSION to a recursively expanded variable,
> forcing it to be recomputed on every expansion of CFLAGS and
> dramatically slowing down the bpftool build. Restore BPFTOOL_VERSION as
> a simply expanded variable, guarded by an ifeq().
>
> Fixes: ba2fd563b740 ("tools/bpftool: Support passing BPFTOOL_VERSION to make")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---

Thanks a lot! I verified that it does restore the previous build speed.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> v3: new
> ---
>  tools/bpf/bpftool/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index d566bced135e..804ade95929f 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -30,7 +30,9 @@ LIBBPF = $(LIBBPF_PATH)libbpf.a
>  LIBBPF_BOOTSTRAP_OUTPUT = $(BOOTSTRAP_OUTPUT)libbpf/
>  LIBBPF_BOOTSTRAP = $(LIBBPF_BOOTSTRAP_OUTPUT)libbpf.a
>
> -BPFTOOL_VERSION ?= $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
> +ifeq ($(BPFTOOL_VERSION),)
> +BPFTOOL_VERSION := $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
> +endif
>
>  $(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT) $(LIBBPF_BOOTSTRAP_OUTPUT):
>         $(QUIET_MKDIR)mkdir -p $@
> --
> 2.29.1
>
