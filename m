Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A492AFD22
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 02:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgKLBcI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 20:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgKKXUa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 18:20:30 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8698C0613D1;
        Wed, 11 Nov 2020 15:20:29 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id v92so3524543ybi.4;
        Wed, 11 Nov 2020 15:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ljKcG6eaqnPKwzi5dmIbAYfE4A7fOblLOoaQW0tRpBw=;
        b=Jnf51FXS3ER0GGQf5NBem7mVbKAlsRD4ICg7XsS49kGjfYcgvPKtzokrRVnttvMgQO
         GjU+oLrUrKFzIYDfSqADCUfA8ZkX0aJsi5nkAe0u/zD3rXLARFbgjQE3HRKDbGj/i7bI
         Hs39wOax0eLUiv6oKbL+cKVwayTDn3QtFEJJj7eMOqIVvrkW+NxMx/Q792Sl1VefTtVt
         CrQ8vCcwyZOM2nRR+BgM5VU0HRcFfR1RVBbPlUdsSJe11ZvRDRo2VSJrKRYnSZGUDr3M
         jc4Ui5+nUHwugtYlEPgmdVZZY/hkVrx7mAaQeBy+7szVJw7c5qmz2huatu1Xy6u8N3oi
         RaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ljKcG6eaqnPKwzi5dmIbAYfE4A7fOblLOoaQW0tRpBw=;
        b=Gk/5yasO9TbPx1QZvL0R0c50By1ZQmxUyyQEq8mCNkADfy7S6+sNxPPlu0t2zgVxwF
         IB9J51m3AyW32l+9PoM9oe2WHGH5rr82oA3SYVp2LjLhrAo9gWIm7t3nbdLwzH6M49Vd
         Er4cyLCXiqxm6UuEULp37CdpSO8PISTCnsodwMiFjOm4+leQMn8FKyaDMmhZOOtbxTMU
         nV7PalM2ciY4+HHa7mdGFiSwfOIIoHhVpmJFn6C9B6++9Qdb8X5eQRH6JegjHrGQEnQT
         DG9drhEN3ArRcEfP3d9bIk8H/Iby8fANLQpQeTOGCUV5sBNfipcwvm8oXDqhjP/QVfvI
         EtCw==
X-Gm-Message-State: AOAM530aWEsZ42osFkb8W8nQSMthg4PyyZruGPQk26BdBydfxXKZqT31
        Ih0jNBKvcHCfREiaEd2WhLXIPcuqku8/d2EHOZ4=
X-Google-Smtp-Source: ABdhPJyBXzk7WyE9Ja1Kf/DxpJqV7ixcAA8aImBi0SzltyjdbCVa6VImwOwr0PR1km5wtFLXJLLjacLJTRAUqkoQh9I=
X-Received: by 2002:a25:7717:: with SMTP id s23mr24112471ybc.459.1605136829224;
 Wed, 11 Nov 2020 15:20:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605134506.git.dxu@dxuuu.xyz> <f5eed57b42cc077d24807fc6f2f7b961d65691e5.1605134506.git.dxu@dxuuu.xyz>
In-Reply-To: <f5eed57b42cc077d24807fc6f2f7b961d65691e5.1605134506.git.dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 Nov 2020 15:20:18 -0800
Message-ID: <CAEf4BzbUVcRTb=CLkh6VPhPvgypOTACcDqScr0PcKHE80+5H4w@mail.gmail.com>
Subject: Re: [PATCH bpf v5 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 11, 2020 at 2:46 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> do_strncpy_from_user() may copy some extra bytes after the NUL
> terminator into the destination buffer. This usually does not matter for
> normal string operations. However, when BPF programs key BPF maps with
> strings, this matters a lot.
>
> A BPF program may read strings from user memory by calling the
> bpf_probe_read_user_str() helper which eventually calls
> do_strncpy_from_user(). The program can then key a map with the
> resulting string. BPF map keys are fixed-width and string-agnostic,
> meaning that map keys are treated as a set of bytes.
>
> The issue is when do_strncpy_from_user() overcopies bytes after the NUL
> terminator, it can result in seemingly identical strings occupying
> multiple slots in a BPF map. This behavior is subtle and totally
> unexpected by the user.
>
> This commit has strncpy start copying a byte at a time if a NUL is
> spotted.
>
> Fixes: 6ae08ae3dea2 ("bpf: Add probe_read_{user, kernel} and probe_read_{user, kernel}_str helpers")
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

This looks more immediately correct.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  lib/strncpy_from_user.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
> index e6d5fcc2cdf3..83180742e729 100644
> --- a/lib/strncpy_from_user.c
> +++ b/lib/strncpy_from_user.c
> @@ -40,12 +40,11 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src,
>                 /* Fall back to byte-at-a-time if we get a page fault */
>                 unsafe_get_user(c, (unsigned long __user *)(src+res), byte_at_a_time);
>
> +               if (has_zero(c, &data, &constants))
> +                       goto byte_at_a_time;
> +
>                 *(unsigned long *)(dst+res) = c;
> -               if (has_zero(c, &data, &constants)) {
> -                       data = prep_zero_mask(c, data, &constants);
> -                       data = create_zero_mask(data);
> -                       return res + find_zero(data);
> -               }
> +
>                 res += sizeof(unsigned long);
>                 max -= sizeof(unsigned long);
>         }
> --
> 2.29.2
>
