Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAAC3615E8
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 01:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbhDOXMK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 19:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbhDOXMK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Apr 2021 19:12:10 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B11BC061756;
        Thu, 15 Apr 2021 16:11:47 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id o10so27995812ybb.10;
        Thu, 15 Apr 2021 16:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j61kcmaXD9c1jysZB1/I7sxKtpHysny10w+VEwri1uA=;
        b=oI5Xry7k3zjmbMVx7M+NYOrZPBIpK7S12TWHgHN9Dz1hKzVddBAfV5YG70LoNBMUHQ
         0LPaBs//bFSD6bZxpCLl2zBIDL8+IRKecDjviPhvwn9QjoS2rFILBeQPPQ+QmDMu8NC5
         VXhFCaEouWYOh2B6UXF93tJ2HUZh4d+eQznepNLgbLdcSfw+0rXjE4K6ExSiVStWDPv7
         iqebIs1HGApJZ/npjzU+rd517jdNx9uQcTk/TmwVoE9N8Kc3yCp72W7uL/whsvPwSb1C
         L0pGcCuWydVeBwc9kkMO0rXP6tYSEm71RxTMiFujO88dj5cquaHZxPwDtH4ZzGjlmUFV
         9z6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j61kcmaXD9c1jysZB1/I7sxKtpHysny10w+VEwri1uA=;
        b=beUs5dDB1RjmKVCoLPfAwb3dSa2VTf2uCYzPyCUJKOJz+xQiLfl2T55hbItt4oYhp/
         5kKfsHDHeeDj7pW8qqRr6rYd08IOoGB1Qb4XoXTrFOuWrwRKgFXI+Tq32diCxY2hYyY7
         9UglWy0RftlVjGossumDHP0YLnu90kigahxrVXuZOIsvwGGNWVx3F6CXcVgQH/7EYel+
         /0ENI4k0fIfcqEWZndNLFD+WoaU2LONVb1qqEQ3JbvTFHR/prpkQuSw/8/TvNHJmcof9
         0a92eVbf3nxq+K7VBowTbeXo/hAI6mzS5/dApjRlem0a7Pdc/5gLq5fSvUHddb+JWR/g
         aycg==
X-Gm-Message-State: AOAM533tSN2L4icFqGx+rCz0VSanHNGry8dXP9ABQKAqgPdeBzK2LGic
        3voFqeYAHzy6jl1JFKMwUUCBh5gk8+hMx5LfNfk=
X-Google-Smtp-Source: ABdhPJxxL7eFQ7F9EBc9MPaVBI56oeazOX6VmNdgQDlEjXnarRPwg4xUYuuu8oozCAqJu/wsbHvRMkVJS/goVQ8ho98=
X-Received: by 2002:a25:d70f:: with SMTP id o15mr7379492ybg.403.1618528306128;
 Thu, 15 Apr 2021 16:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210414185406.917890-1-revest@chromium.org> <20210414185406.917890-4-revest@chromium.org>
In-Reply-To: <20210414185406.917890-4-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 15 Apr 2021 16:11:35 -0700
Message-ID: <CAEf4Bzbt0hmhJVYGwc4wp+jp209ed75oUQcTXg-NTX5ABzFBzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/6] bpf: Add a bpf_snprintf helper
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 11:54 AM Florent Revest <revest@chromium.org> wrote:
>
> The implementation takes inspiration from the existing bpf_trace_printk
> helper but there are a few differences:
>
> To allow for a large number of format-specifiers, parameters are
> provided in an array, like in bpf_seq_printf.
>
> Because the output string takes two arguments and the array of
> parameters also takes two arguments, the format string needs to fit in
> one argument. Thankfully, ARG_PTR_TO_CONST_STR is guaranteed to point to
> a zero-terminated read-only map so we don't need a format string length
> arg.
>
> Because the format-string is known at verification time, we also do
> a first pass of format string validation in the verifier logic. This
> makes debugging easier.
>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---

LGTM.
Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       | 28 +++++++++++++++++++
>  kernel/bpf/helpers.c           | 50 ++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c          | 41 ++++++++++++++++++++++++++++
>  kernel/trace/bpf_trace.c       |  2 ++
>  tools/include/uapi/linux/bpf.h | 28 +++++++++++++++++++
>  6 files changed, 150 insertions(+)
>

[...]
