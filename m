Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9074611B2
	for <lists+bpf@lfdr.de>; Mon, 29 Nov 2021 11:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350106AbhK2KFz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 05:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242770AbhK2KDy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 05:03:54 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C82C061A24
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 01:42:28 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso16256873wmr.4
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 01:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HJ4vgPKclRTx7gnWCT6veGUG2LIjBNMj9wXLIqXMtiQ=;
        b=bmpJ/+9uaYUXZbAlH/mqKzo+nsj9SiX2XqT4Fs+5WA1csfA/qr7q1/Kawir9k8Xi+Z
         euQFQmkGKDR/AO3RDen63gHTFReUP+5U/Xc1jt447VzjVnRC13W6maaytWqTMLi5Wflq
         3b4PLk7os1ikSkueB4QVzgIUmWnUnIUpu+TlLijne+tQ2YozbgPF2jnF+TrRlgezOHI3
         EUFXdgZtUAjHlMjyPp4I+BhFoD9WT7Ls+RJKmtdfz954Zt/RjPW4/IULwHvPhoUXL3Pk
         rkqwOA39BGdlUsiLEwRQClbF8Vh7N2nEo0rO32NqfCGOYix0YwZvD6p5PRWGzfwKYi2f
         cUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HJ4vgPKclRTx7gnWCT6veGUG2LIjBNMj9wXLIqXMtiQ=;
        b=OYzIM9u0TaF2JZFbtVTDVq7PKBJscAELJXt3SNJM50lhw6pGiTQCJz/a9/cN4aLQeT
         UgS6xPbK761trtdWzNR+oHcbU7f8j3hDbTfT6PYBtnw6x3YYfdoSdsSjgEp0dTvqc7ft
         e8yc5cJgRAvNjPeFiB0CjT/0hQpOIwsxgiSXiInRN/jR8MiW3toGPQ6VhdDV1pyO775c
         EajYjRcMZo80xVwz52CS0uWkOvtVg6LD8WcJ7CXnujPJW2pCXXRGv/j8ueJCTYtWuVsW
         SmfeU/6ed4fQowySc87rQZ2YXIKK+Hd+0Ak6hUmoqD+4cXM5U2+uHjM5GI3ftZH08FRM
         UitQ==
X-Gm-Message-State: AOAM530wgcWUgixj9a3Pq8AYDrHyIx2raEYphYhR/V/03o74GB0e+OGC
        pwPofVETRXBLKV6zRxPB+qx8Qg==
X-Google-Smtp-Source: ABdhPJzeUrQVoCN+4J/s7qjpgW9TqTZOqACFEGak3eqXv9pFRQ0XyuJB9n5kt4vU+K/ZdRNrYew2Cg==
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr35235145wmf.185.1638178947291;
        Mon, 29 Nov 2021 01:42:27 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id z6sm13001235wrm.93.2021.11.29.01.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 01:42:26 -0800 (PST)
Date:   Mon, 29 Nov 2021 09:42:04 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Shuah Khan <shuah@kernel.org>, nathan@kernel.org,
        ndesaulniers@google.com, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next 0/6] tools/bpf: Enable cross-building with clang
Message-ID: <YaSgbLJ2uVNrc29Y@myrica>
References: <20211122192019.1277299-1-jean-philippe@linaro.org>
 <CACdoK4JWJRH0VuStA2N+xziTsC5d_ewuWpQEO2aHhVbsWuAq0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdoK4JWJRH0VuStA2N+xziTsC5d_ewuWpQEO2aHhVbsWuAq0g@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 26, 2021 at 08:36:24PM +0000, Quentin Monnet wrote:
> On Mon, 22 Nov 2021 at 19:23, Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > Add support for cross-building BPF tools and selftests with clang, by
> > passing LLVM=1 or CC=clang to make, as well as CROSS_COMPILE. A single
> > clang toolchain can generate binaries for multiple architectures, so
> > instead of having prefixes such as aarch64-linux-gnu-gcc, clang uses the
> > -target parameter: `clang -target aarch64-linux-gnu'.
> >
> > Patch 1 adds the parameter in Makefile.include so tools can easily
> > support this. Patch 2 prepares for the libbpf change from patch 3 (keep
> > building resolve_btfids's libbpf in the host arch, when cross-building
> > the kernel with clang). Patches 3-6 enable cross-building BPF tools with
> > clang.
> 
> The set looks good to me. I checked that the tools are still building
> (without cross-compiling). I currently have issues building the
> selftests on my setup, but they don't appear to be related to this
> patchset.
> 
> Acked-by: Quentin Monnet <quentin@isovalent.com>
> 
> Note that on bpf-next, patch 5 (runqslower) has a conflict with
> be79505caf3f ("tools/runqslower: Install libbpf headers when
> building").

Ah right, I have the series on top of "tools/runqslower: Fix cross-build",
which is in bpf/master but not yet in bpf-next. I'll wait for the branches
to synchronize before resending, since the patches conflict either way.

> Did you consider enabling cross-compiling for the BPF samples too? I'm
> asking because the build system is pretty similar to the BPF tools.

Right, the problems seem similar to the selftests (need to build two
libbpfs, pass $(HOSTCC) etc). Samples aren't as crucial as tools but I can
look into it when I find a bit of time.

Thanks,
Jean
