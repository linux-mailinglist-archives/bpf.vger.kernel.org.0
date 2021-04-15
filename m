Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAE6361590
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 00:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbhDOWhK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 18:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbhDOWhJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Apr 2021 18:37:09 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277A3C061574
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 15:36:46 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id v72so7211319ybe.11
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 15:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNSRFkdD3i+ezT7KLAy5OkIwxeOHUF/TDkJhby//seQ=;
        b=uxQJYE5RLsJ95xorqfptc5hpa8qL4MgfLfXn/aGzOXwRbNoy70PSee9ExKCrNX/jz5
         FZt8H9F5PxcVaCywsNtoSDKwNZ4ErvU+37/I6UaaULSjRWyEAtoFQmxBVsULR5JMlyM7
         s3Zc7y11I/0q16gMvUHjdSWQKOole5/IyhGivd04+8MaCeEs4kZ1O+4yZWpf8ud4zuoq
         Cr8C5Ks+kecThvwhryuP3Ah/oNLjYGg6TbBqANWxexsz1k2WhOBfbhiCfpFCsZsq0EaZ
         9MQr7gTkrX8/WZc00YgnfAIYVUQ2z3qxMrc21S8wqEd/xCCRpiu4IJfJYUxerFLEMUV1
         TP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNSRFkdD3i+ezT7KLAy5OkIwxeOHUF/TDkJhby//seQ=;
        b=sNEauyp5GLj2rmpX5mZX4ipKnuO7FYy+hunZEsLJukGpnAg60o6ISMJXHnukh3AmUr
         mP+Y2hRh2VJReCrV89AYZyatHCuM2sxjnWKnUO4Ab1I9xvwitT0xzA6luFmDktwFPPkE
         1fX3bMU8Do7+twRk6E9yeEw+cj2EpweCAm46rbN44UdHQoKorDjtsAfl8M1qneuZBjJw
         WYwM1xVH+okcFsHK/6KCLYA6BgctJxrd/njPDpZ+2zNx7SQKxss5/jQi8186WxdL/fow
         5xU7GjvGllcYimeE7sHnAe86fQ+qqFvfyMFNvl+QIh7Q44JwSpUQS+h9fVum/M5hy27C
         P3mQ==
X-Gm-Message-State: AOAM533w5OF5w2GirfXC7d5ZZ1TswLfgkHcyRbvrDT9/ixfO7vxL7upG
        y8lHZzKbL/b/20i8N/SbYpn1N/bFjSwdd7nr04M=
X-Google-Smtp-Source: ABdhPJwhCqGgVm5/PkDAATtKEnCUrSW7DVPyaj57ol2iFbFoU69w9lNRPnWzN3iEAH9fLQu6sMjWhD3j7qLI4Nq3dmY=
X-Received: by 2002:a25:3357:: with SMTP id z84mr7612765ybz.260.1618526205504;
 Thu, 15 Apr 2021 15:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210415141817.53136-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20210415141817.53136-1-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 15 Apr 2021 15:36:34 -0700
Message-ID: <CAEf4BzazSWuWGJgseF1WEu5AcRmtmVz9VgAi0sPqzabjVwFNwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Remove unused field.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 15, 2021 at 7:18 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> relo->processed is set, but not used. Remove it.
>

I don't remember now why it was added, but given we haven't used it
for a while and nothing broke, let's remove it. We can always add it
back, if needed. Applied to bpf-next.

> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>

[...]
