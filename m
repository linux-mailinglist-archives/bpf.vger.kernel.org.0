Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB22231D1DE
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 22:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhBPVLF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Feb 2021 16:11:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:39456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhBPVLE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Feb 2021 16:11:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2921A64EB1
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 21:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613509823;
        bh=zuN//Mi2dqadHAYyFDtFxOXanm3499mh7SOFGrw72PM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EHcR3NV0Tq80HkGPC+eIC8PBXlxPPQGMJXQVwQ+1lSkn7gV2/4Rcp0B6qiUPryxXg
         DGM1zxzew7oP2R62po/tLIKd7hGK2Oc28+SaCCmBM3BXzorI1/V+4/6RkHV37EeCaM
         3D7KE9tlYjEB3n6RDOnbNv4tP797Mw9j67U8iMccT0Fo1AHfm0ouTIE/DuBHalkfK1
         aTdimRDJQP9ryeeFNL3jWaQ2d0f0uwV0HoDw42ak0iLbZlRGhn9in/DirTU10HDsCq
         3EsTHLJDsCBsCzPaO5aen+8YM5gQ1cPOaekyPOiw8uDpsgVsGG4wOBL7x+RhRAcW5L
         cQqpATgaVdQ7w==
Received: by mail-lj1-f173.google.com with SMTP id j6so13618650ljo.5
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 13:10:23 -0800 (PST)
X-Gm-Message-State: AOAM5333NmoblM1tdjMPOKWzljokjFsRcfO66R4yqALf/PZy+Xa1LP1T
        iwrgXcfC1DgyZmdT30gJQ3TChG1bfTs7iumwuyL/Yw==
X-Google-Smtp-Source: ABdhPJwgwy516BjoZrdZrJOhyr/k6Uu8nNx4C91gl4NsH+qZi44hy3J8L1JueNqhpQnF82YBvbfYeMLzGuTLZSqnfEw=
X-Received: by 2002:a05:651c:1249:: with SMTP id h9mr13363326ljh.425.1613509821328;
 Tue, 16 Feb 2021 13:10:21 -0800 (PST)
MIME-Version: 1.0
References: <YCwewjRBJIBm0sew@mwanda>
In-Reply-To: <YCwewjRBJIBm0sew@mwanda>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 16 Feb 2021 22:10:10 +0100
X-Gmail-Original-Message-ID: <CACYkzJ55Ze+aA+qKA8bf=iqNY01H=MuDCKVmn44fLVW1670RxA@mail.gmail.com>
Message-ID: <CACYkzJ55Ze+aA+qKA8bf=iqNY01H=MuDCKVmn44fLVW1670RxA@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix a warning message in mark_ptr_not_null_reg()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Dmitrii Banshchikov <me@ubique.spb.ru>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 16, 2021 at 8:37 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The WARN_ON() argument is a condition, and it generates a stack trace
> but it doesn't print the warning.
>
> Fixes: 4ddb74165ae5 ("bpf: Extract nullable reg type conversion into a helper function")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 056df6be3e30..bd4d1dfca73c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1120,7 +1120,7 @@ static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
>                 reg->type = PTR_TO_RDWR_BUF;
>                 break;
>         default:
> -               WARN_ON("unknown nullable register type");
> +               WARN(1, "unknown nullable register type");

Should we use WARN_ONCE here? Also, I think the fix should be targeted
for bpf-next as
the patch that introduced this hasn't made it to bpf yet.

[...]
