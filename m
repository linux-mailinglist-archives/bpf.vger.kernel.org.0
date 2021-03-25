Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E14348DC2
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 11:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhCYKPD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 06:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhCYKOw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Mar 2021 06:14:52 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E414C06174A
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 03:14:52 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id j11so1610787ilu.13
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 03:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MLBLoljkQQcfTkhWG5CdGfXFMwGR6QEdjyAM8Zg777A=;
        b=fyeK7jhjoIe0dOBYNQQ4K4TizMRG8CN7Ztzao1QWHaj7U+ApyQ1y25tNz3nscazyu1
         DzSxtmsEZqsjF6n7LPU67A/VLcCoh5gYVWvJDIq+wUj9Qp9Pwyz2U0hCxV9XAunthMU4
         uVp2G6RsNIzjvB5H6nm7KuNdbXvgcp74LJ1ZcRo5MFWdnFUfgbeTwSa7laeyBO5QXBus
         /2KuHUwYIQtaHNnQ9ZsITfRfHo5v38iz3C5SMg/gkabbLZlMWLtRaSBOzMNzmg5ARLkg
         pQ1zmfQ2EL8AwIe/7zYT/PVxkl8PDbcTZD78h7VPeKdpxvuPPhPOOk05VtAG0M99WaqC
         Oc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MLBLoljkQQcfTkhWG5CdGfXFMwGR6QEdjyAM8Zg777A=;
        b=Zkee4dz0xheapjc7/EFr1nF0sGlo/M1dyz64QY6DXo5YZ964XKwF3425GMCu6Gt/yL
         oDR6amh5/J0OUkbUJhcxbPYWSWszFG61pyIt9kze+sw8bF8qHmQxA2DF5xYDi1aPEhsX
         VErzNKa2ZG7gwBWjjgUYiicoknU9yvy92W1r3HMHeiVtWPGP8GmjrYk+LMQKhTBgt8i7
         nDAdgiiFSFvafbNZlxuuRby7O/gyJBnl4l7EGvGtB2SawZlubkpLPGuu5UeyZfGPqkHA
         Rl8/lfQVVQQN19h3s57WWjIhMRPGtXJnECWuja3EiY8q+OwEz2Wi0sJv0zaf1TKM9SG2
         8BrA==
X-Gm-Message-State: AOAM531mi/hMrn8UcV2wNN/G21uym1yacQ1Quv3ToyRM0cL7zwPOudTs
        L11RPSnMT0sjCAY5Hun1d1nSskZGIKYFnCT0R8lpVA==
X-Google-Smtp-Source: ABdhPJxNFYxcimcuG1bDWG6oOKa/CADJFo/uAUPbB/r3P9pJ4kwOmKPjINqoZCK1ueaz4ihIo/sOPHOJhWLxO0DEm9E=
X-Received: by 2002:a05:6e02:1d95:: with SMTP id h21mr6184226ila.276.1616667291741;
 Thu, 25 Mar 2021 03:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210325020511.5891-1-xukuohai@huawei.com>
In-Reply-To: <20210325020511.5891-1-xukuohai@huawei.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Thu, 25 Mar 2021 11:14:40 +0100
Message-ID: <CA+i-1C1hA16BAKQEBP91EJ3WP5ocSo1+DqA+M4ZyWTicYXrxgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix a spelling typo in kernel/bpf/disasm.c
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[Sorry if you get this duplicated - I forgot to switch off HTML mode
the first time]

Oops, thanks.

On Thu, 25 Mar 2021 at 03:04, Xu Kuohai <xukuohai@huawei.com> wrote:
>
> The name string for BPF_XOR is "xor", not "or", fix it.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

Please add:
Fixes: 981f94c3e92146705b ("bpf: Add bitwise atomic instructions")

Except for that:
Acked-by: Brendan Jackman <jackmanb@google.com>

> ---
>  kernel/bpf/disasm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
> index 3acc7e0b6916..faa54d58972c 100644
> --- a/kernel/bpf/disasm.c
> +++ b/kernel/bpf/disasm.c
> @@ -84,7 +84,7 @@ static const char *const bpf_atomic_alu_string[16] = {
>         [BPF_ADD >> 4]  = "add",
>         [BPF_AND >> 4]  = "and",
>         [BPF_OR >> 4]  = "or",
> -       [BPF_XOR >> 4]  = "or",
> +       [BPF_XOR >> 4]  = "xor",
>  };
>
>  static const char *const bpf_ldst_string[] = {
> --
> 2.27.0
>
