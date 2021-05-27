Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE27392712
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 08:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhE0GGI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 02:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbhE0GGH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 02:06:07 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFA7C061574
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 23:04:32 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z24so3644544ioi.3
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 23:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=6Kynh6kIcnQNMGQkijl/iwg3ZIKwMY35KO5UajAOr/w=;
        b=dsM6pT+m7jQhZHoI7IpeV8bW3d2GLxNnW6Djb1186LP+Zl4q9gGG+pD7YnIxw9Hnsw
         zJjd5nNtR7xYxakMGX2+gsogwN5Igf41n7KUy8ANd/7M6rvkspEoMScRrQEf2Iy/MPf8
         dFd1b+CnBjQWwmAaJzSFt2PsQ0B9pZdbirZlqZEEWkXlc5RYClokelMc/qGUytcTmXsA
         O2OgkIlFuPuJrdLdjQvYs1mphl0i/QDny2uOxxexnkZnrndzx3rDd1WGsySaaHnGClI0
         OY2crBzGRLrjwxhvwHsIh1NSZhvCv/5m+C6ji/2O8Z0x3c+t6PFtPzUIxpdHBatPf+v8
         0Xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=6Kynh6kIcnQNMGQkijl/iwg3ZIKwMY35KO5UajAOr/w=;
        b=H/r85O+ee5f1Z+12Q29nu2AlXdiKovtrOw+Gso5l/sDu+XYGN6k9JS1WobAgB9B9c7
         DdC0mZ0HA3SKjuCHrca0ftBh7tTpp0y0SzTbC3NW8o7tl4tW0g6GX/wJzFa3O0pSHZkO
         PkAQzs6B94ftnwV1DH41zaq66LgFhcHn2BfdqMf3pScV/0FUjIAoD/8+MQSKGHW6z4bP
         PthBe1xRNh/R8UZfx3fmOXigwn4DkyVLiKPG+RS1q10SHUCizbyMXPdK8jfsYepN4puX
         hJ2uelhPTk/RoWkMafa8JaZ7Lik4TDS9HEkaqof7RrtpHFIH44bvzhsstoodobvFGUea
         saGQ==
X-Gm-Message-State: AOAM53197mmJO8mqobZGZ8z0JMEgJUXN+MdxNsnFbWTJ5H5MT1g8N38j
        c36weMcjcNEiic8yTJB+1Y4=
X-Google-Smtp-Source: ABdhPJyBMlEUvAX6L22ehQZVdYoYCVxZiLCGC+0apgc1zFlKd+T1FdJDoyu+7KVzMt73z5AzEygCGQ==
X-Received: by 2002:a02:688:: with SMTP id 130mr1968976jav.48.1622095472229;
        Wed, 26 May 2021 23:04:32 -0700 (PDT)
Received: from localhost ([172.242.244.146])
        by smtp.gmail.com with ESMTPSA id k8sm674410ils.41.2021.05.26.23.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 23:04:31 -0700 (PDT)
Date:   Wed, 26 May 2021 23:04:24 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Message-ID: <60af36681deca_252212088a@john-XPS-13-9370.notmuch>
In-Reply-To: <20210526152457.335210-1-yhs@fb.com>
References: <20210526152457.335210-1-yhs@fb.com>
Subject: RE: [PATCH bpf-next v3] docs/bpf: add llvm_reloc.rst to explain llvm
 bpf relocations
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song wrote:
> LLVM upstream commit https://reviews.llvm.org/D102712
> made some changes to bpf relocations to make them
> llvm linker lld friendly. The scope of
> existing relocations R_BPF_64_{64,32} is narrowed
> and new relocations R_BPF_64_{ABS32,ABS64,NODYLD32}
> are introduced.
> 
> Let us add some documentation about llvm bpf
> relocations so people can understand how to resolve
> them properly in their respective tools.
> 
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
  
[...]

>  __ https://reviews.llvm.org/D100362
> +
> +Clang relocation changes
> +========================
> +
> +Clang 13 patch `clang reloc patch`_  made some changes on relocations such
> +that existing relocation types are broken into more types and
> +each new type corresponds to only one way to resolve relocation.
> +See `kernel llvm reloc`_ for more explanation and some examples.
> +Using clang 13 to compile old libbpf which has static linker support,
> +there will be a compilation failure::
> +
> +  libbpf: ELF relo #0 in section #6 has unexpected type 2 in .../bpf_tcp_nogpl.o
> +
> +Here, ``type 2`` refers to new relocation type ``R_BPF_64_ABS64``.
> +To fix this issue, user newer libbpf.
> +
> +.. Links
> +.. _clang reloc patch: https://reviews.llvm.org/D102712
> +.. _kernel llvm reloc: /Documentation/bpf/llvm_reloc.rst
> -- 
> 2.30.2
> 

LGTM.

Acked-by: John Fastabend <john.fastabend@gmail.com>

