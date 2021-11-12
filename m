Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B77544DFE4
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 02:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhKLBs6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 20:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhKLBs5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 20:48:57 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D811C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 17:46:08 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so6044147pjl.2
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 17:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDCsBHbV8od8GRczENL1rwrYnS8Z44BcmYulsw6L8NE=;
        b=EdWosODTx6fQ6lKw5r+L8QC4a9W3cxIdt12KBSGpNc/e9j3lTit5ae+Bh1arTGugxe
         2QLBjKQc245ARKiX4ifxJAXaR6jHhaqZRa02B5yr0SDNw6rA6a5iAWIEVXalSXXzC1vr
         7keRCzcQjiSy52OlZfV78RtITqCpApu9R4iqNrnK1QqxEo19KYWfSI5hKRjKj0rgV0cD
         nUBz9yW05q/pHqfM7vLDBC7+BBcm925K1xEqDCZvVRU0tXSXwhyZknt+0f6in9x7y8By
         rv7J4cVX6NszOed+wNs2+BlTygzJeuYUbnvVjeKgJASqlbY0uOlg6do3qU9/Y0sxX5Pn
         nRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDCsBHbV8od8GRczENL1rwrYnS8Z44BcmYulsw6L8NE=;
        b=kVFbp3g15EDYF91SN5mQMPK0xJoYyKjv1jx+fd3t4XEg3qPqeGIVxfCKVDmj6bQJ6R
         UlUz/MYoMtLlVrZTJoS3KTa9tHG4mOesuddXULa5A6/k91uaONK3h9pvO+sWKlajjfte
         ZXbL7Y3rkHRl9dfAAgM0weabFkr2fBIFepd05GS4A5E+rHh++n3X9ZfbbgikybiTVR6y
         e/OVrw6oBfFQW+c4XR3jPFflHbSCTRTVtvuC4z2Bt4sKoQvW5zQE57RKsb5/wS3NPN3e
         ZXBepnvyUYjw6tuHB2gnT879/cIfUdeZJgXmbbei2I1/w5SW89LwnbKoYTe9vzeNgvp1
         lsIA==
X-Gm-Message-State: AOAM532bGyAvIeikJ5cXYm1mC9ryNXrXVOLV19ZRUgViBcZfllU6mh8v
        8wIwhWdXLEziFNihPECTg/zHUd1j9zIyFCtxgqg=
X-Google-Smtp-Source: ABdhPJwyPaXKANCxUPmMEJHFjA+ebOe2yKY0dZPU2SCENjeAkO2xpWkRyPTksOFdvf+cTeqcFSCdH/GkU2SJx6vy6fo=
X-Received: by 2002:a17:902:d491:b0:142:892d:a89 with SMTP id
 c17-20020a170902d49100b00142892d0a89mr4097123plg.20.1636681567514; Thu, 11
 Nov 2021 17:46:07 -0800 (PST)
MIME-Version: 1.0
References: <20211112012604.1504583-1-yhs@fb.com>
In-Reply-To: <20211112012604.1504583-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 11 Nov 2021 17:45:56 -0800
Message-ID: <CAADnVQKm3bT-fA_zXv75MpM6E+UaL-iHnGKQmJ09X6bB2khm+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 00/10] Support BTF_KIND_TYPE_TAG for
 btf_type_tag attributes
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 11, 2021 at 5:26 PM Yonghong Song <yhs@fb.com> wrote:
>
> LLVM patches ([1] for clang, [2] and [3] for BPF backend)
> added support for btf_type_tag attributes. This patch
> added support for the kernel.
>
> The main motivation for btf_type_tag is to bring kernel
> annotations __user, __rcu etc. to btf. With such information
> available in btf, bpf verifier can detect mis-usages
> and reject the program. For example, for __user tagged pointer,
> developers can then use proper helper like bpf_probe_read_kernel()
> etc. to read the data.
>
> BTF_KIND_TYPE_TAG may also useful for other tracing
> facility where instead of to require user to specify
> kernel/user address type, the kernel can detect it
> by itself with btf.
>
> Patch 1 added support in kernel, Patch 2 for libbpf and Patch 3
> for bpftool. Patches 4-9 are for bpf selftests and Patch 10
> updated docs/bpf/btf.rst file with new btf kind.
>
>   [1] https://reviews.llvm.org/D111199
>   [2] https://reviews.llvm.org/D113222
>   [3] https://reviews.llvm.org/D113496
>
> Changelogs:
>   v2 -> v3:
>     - rebase to resolve merge conflicts.
>   v1 -> v2:
>     - add more dedup tests.
>     - remove build requirement for LLVM=1.
>     - remove testing macro __has_attribute in bpf programs
>       as it is always defined in recent clang compilers.

Applied. Thanks.
Cannot wait to get tags available in vmlinux.
