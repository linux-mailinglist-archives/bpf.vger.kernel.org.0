Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3682FC82E
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 03:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbhATCoe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jan 2021 21:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732772AbhATCo3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jan 2021 21:44:29 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710C1C0613D3
        for <bpf@vger.kernel.org>; Tue, 19 Jan 2021 18:43:49 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id m6so13598425pfk.1
        for <bpf@vger.kernel.org>; Tue, 19 Jan 2021 18:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IoAS2iYBLHsRua0ToD9jNwcwJKOxvef2a5weUgRGbk0=;
        b=payUoMdP99ddV95PcEbXHC19WExfJT6yZ/S4Ppoq/PLGAFbIoNn7Ocr9I+rvAyWbCp
         vl8P28OthlrC8/YP790veImXuigRJQ+FCsfMuvuUXkcuWlHIm3ORZYgnSOfFBWVqwrsx
         etQUHaMuNXSZiBSaJug8IAPdQ9Y3kmvOKMD0epVjkDWIzoTugBJ/UJsLq6QRvOCAMGks
         52gEg7tfjfjS/5IPrbkLmpMxaXgQ8LA6lTT+oUp4pmz1yte+4ljxAX1G0rCyimsvXUrJ
         kSRn7OSiizNM1UAmaUFSCvMIBFfNTpucrCHH8toBTyzLLoxOk4H4/MXbBVrxQMm75Y9g
         le8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IoAS2iYBLHsRua0ToD9jNwcwJKOxvef2a5weUgRGbk0=;
        b=n2/3GngrA7gJNo9DzY1DrEnKKTVZmEgJy3MxXJEeqRxKSKLcp+V8+IOmKHxwqtDwoG
         TXehsOhnuL4n3Jtkv3nOI/blZH2QAJjOb8h3/uyoKFPfdy/xv8HZZf23c+6ChU/8coxP
         ys2BxlEVSzSFN9/qTc+t0ducdNlHnt8pKqCbic3JW+hRDxHpXslcu1qEiesYArI3qQAu
         8NzWb4kO/gP25Btn7uOC4NCFz2gTYRqPhqgVyl6rFLBSgW1jgzOGk99QqqV9UqetjIHQ
         OBMvK1viRK7Z9jYWqJfr8y3yPR17+/AHbHcXiSeB94ai7Ehp2oZp4fs1YVuGJ+zrTcEx
         io1g==
X-Gm-Message-State: AOAM532CoNAsE3Ns/McIN5MTC8sWQZp4Q4us5mo/3heJ+YF85baPd6M8
        S7BaTOshX42/SM+SokVEdls4HmXBsR7XKuyHNK6OgQ==
X-Google-Smtp-Source: ABdhPJyP9xx5n3cq0nmNCglbjFT0ogHH0SdoaQC66nze3RSq1u6CYmEK3xfrrNQ97XJvAtKZ+TGeZvsQyiie386D8S0=
X-Received: by 2002:a63:1f47:: with SMTP id q7mr7252992pgm.10.1611110628633;
 Tue, 19 Jan 2021 18:43:48 -0800 (PST)
MIME-Version: 1.0
References: <1611042978-21473-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1611042978-21473-1-git-send-email-yangtiezhu@loongson.cn>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 Jan 2021 18:43:36 -0800
Message-ID: <CAKwvOdkXGx-WogH0o5iuNnEe07sqRfxMpOg5fEEnTWcOfBrbAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] samples/bpf: Update README.rst and Makefile
 for manually compiling LLVM and clang
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 18, 2021 at 11:56 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> The current llvm/clang build procedure in samples/bpf/README.rst is
> out of date. See below that the links are not accessible any more.
>
> $ git clone http://llvm.org/git/llvm.git
> Cloning into 'llvm'...
> fatal: unable to access 'http://llvm.org/git/llvm.git/': Maximum (20) redirects followed
> $ git clone --depth 1 http://llvm.org/git/clang.git
> Cloning into 'clang'...
> fatal: unable to access 'http://llvm.org/git/clang.git/': Maximum (20) redirects followed
>
> The llvm community has adopted new ways to build the compiler. There are
> different ways to build llvm/clang, the Clang Getting Started page [1] has
> one way. As Yonghong said, it is better to just copy the build procedure
> in Documentation/bpf/bpf_devel_QA.rst to keep consistent.
>
> I verified the procedure and it is proved to be feasible, so we should
> update README.rst to reflect the reality. At the same time, update the
> related comment in Makefile.
>
> [1] https://clang.llvm.org/get_started.html

There's also https://www.kernel.org/doc/html/latest/kbuild/llvm.html#getting-llvm
(could cross link in rst/sphinx).

>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>
> v2: Update the commit message suggested by Yonghong,
>     thank you very much.
>
>  samples/bpf/Makefile   |  2 +-
>  samples/bpf/README.rst | 17 ++++++++++-------
>  2 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 26fc96c..d061446 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -208,7 +208,7 @@ TPROGLDLIBS_xdpsock         += -pthread -lcap
>  TPROGLDLIBS_xsk_fwd            += -pthread
>
>  # Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
> -#  make M=samples/bpf/ LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
> +# make M=samples/bpf LLC=~/git/llvm-project/llvm/build/bin/llc CLANG=~/git/llvm-project/llvm/build/bin/clang
>  LLC ?= llc
>  CLANG ?= clang
>  OPT ?= opt
> diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
> index dd34b2d..d1be438 100644
> --- a/samples/bpf/README.rst
> +++ b/samples/bpf/README.rst
> @@ -65,17 +65,20 @@ To generate a smaller llc binary one can use::
>  Quick sniplet for manually compiling LLVM and clang
>  (build dependencies are cmake and gcc-c++)::
>
> - $ git clone http://llvm.org/git/llvm.git
> - $ cd llvm/tools
> - $ git clone --depth 1 http://llvm.org/git/clang.git
> - $ cd ..; mkdir build; cd build
> - $ cmake .. -DLLVM_TARGETS_TO_BUILD="BPF;X86"

Is the BPF target not yet on by default?  I frown upon disabling other backends.

> - $ make -j $(getconf _NPROCESSORS_ONLN)
> + $ git clone https://github.com/llvm/llvm-project.git
> + $ mkdir -p llvm-project/llvm/build/install
> + $ cd llvm-project/llvm/build
> + $ cmake .. -G "Ninja" -DLLVM_TARGETS_TO_BUILD="BPF;X86" \
> +            -DLLVM_ENABLE_PROJECTS="clang"    \
> +            -DBUILD_SHARED_LIBS=OFF           \
> +            -DCMAKE_BUILD_TYPE=Release        \
> +            -DLLVM_BUILD_RUNTIME=OFF
> + $ ninja
>
>  It is also possible to point make to the newly compiled 'llc' or
>  'clang' command via redefining LLC or CLANG on the make command line::
>
> - make M=samples/bpf LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
> + make M=samples/bpf LLC=~/git/llvm-project/llvm/build/bin/llc CLANG=~/git/llvm-project/llvm/build/bin/clang
>
>  Cross compiling samples
>  -----------------------
> --
> 2.1.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/1611042978-21473-1-git-send-email-yangtiezhu%40loongson.cn.



-- 
Thanks,
~Nick Desaulniers
