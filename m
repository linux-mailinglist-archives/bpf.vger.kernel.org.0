Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118FD44DB98
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 19:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbhKKSaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 13:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbhKKSaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 13:30:17 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D744C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 10:27:28 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id j75so17273076ybj.6
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 10:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L/miWUa9crEk8f473XvOGWfYqyc5KypibWvYqiBIeZI=;
        b=XB3gPQnOj+LWqwgH6+Vi4+4SRteVrDP2zFYsiNZwN2i4M+UpmelxCN4Q9DXuSn85P/
         so2aaoOEwGbsjNO1arHA9BsHAlLRd5oyw5YcHFIh1Se8xv/dF7vjaj89UkTUJVime8Nd
         kZ5PNVtOcdj+Az4kRa8e0jWgo26AZdkTSkf1f9fU6KZhSjPwKD3LD+NlFZ9DK0JI7+5o
         YxKGgmOaxwFqNaIACIBSylNZY+/ecqJEu536CIPd+R38xkkZgoBjZL8yqBL4MywLuj8E
         TL/KJDIRR8KpNjagEbYEJZNmhO2/wJY5CU0Odm6DEMNrF95cZlLJjKUoN2LpLkGS9JJU
         tiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/miWUa9crEk8f473XvOGWfYqyc5KypibWvYqiBIeZI=;
        b=c1W3/LMswAZu+oijWNEAUKynWKD55yBmniKdh0RTZFinzYs2J3YLqKVxPeHCHoh213
         ixX+Y3x/YkphEhpAEv6ChqpOolW5h16WVhCf7H22rN/BtP3zqBqaZmHzdB1fCT+yUalq
         bvsKpsTelpgmPP34FPKES8Z+mOnqMXKvlPaWbHWkwgXq6VAKXUuxdI2bqk9pChVxal3F
         BzrRWHLNqCmZRX2v8tQOM6aQvvwvCWYESiwDXzbmc8s4ovKY9A0mwRC5TM3bkY8yCewS
         /MJ+xO0f8tfEaCgiy7trv3uJ/oYr02qHdx34XsQ18fowP6y4rsSK7vL9At9kXyeSL8of
         1G+g==
X-Gm-Message-State: AOAM531djV6oUm70zH3SSvOG7Ps4/4RrHN9KStd+GJLm6ds7OYnMHx91
        jqtyTjZFvyzEdWIy7rcjM6VxLfMP9u5dVRhd/lQ=
X-Google-Smtp-Source: ABdhPJz2g+icyCwDfXBrlrjf4VZUO+BzGGFJVDQ2X47nibCHIeEsG1nbbauotQzYpGTHFJlaedINfi5DFUie8o+6JII=
X-Received: by 2002:a25:cec1:: with SMTP id x184mr10345509ybe.455.1636655247429;
 Thu, 11 Nov 2021 10:27:27 -0800 (PST)
MIME-Version: 1.0
References: <20211110051940.367472-1-yhs@fb.com> <20211110051946.368626-1-yhs@fb.com>
In-Reply-To: <20211110051946.368626-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 11 Nov 2021 10:27:16 -0800
Message-ID: <CAEf4Bzbd9X1HOYNt_DiOz4meZVxPNPE=0g7H-R1qZu6D2EGZ3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/10] bpf: Support BTF_KIND_TYPE_TAG for
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

On Tue, Nov 9, 2021 at 9:19 PM Yonghong Song <yhs@fb.com> wrote:
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

probably meant to write bpf_probe_read_user()?

LGTM, otherwise.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> etc. to read the data.
>
> BTF_KIND_TYPE_TAG may also useful for other tracing
> facility where instead of to require user to specify
> kernel/user address type, the kernel can detect it
> by itself with btf.
>
>   [1] https://reviews.llvm.org/D111199
>   [2] https://reviews.llvm.org/D113222
>   [3] https://reviews.llvm.org/D113496
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/uapi/linux/btf.h       |  3 ++-
>  kernel/bpf/btf.c               | 14 +++++++++++++-
>  tools/include/uapi/linux/btf.h |  3 ++-
>  3 files changed, 17 insertions(+), 3 deletions(-)
>

[...]
