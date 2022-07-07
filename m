Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C554756AC3F
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 21:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiGGTwR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 15:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiGGTwR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 15:52:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01AA564DB
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 12:52:15 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m16so8973497edb.11
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5uMeJwWigwX7nArU3NFgeKbmwZTaSJ+b7KA1UdN4EA=;
        b=BWJJupXvt+BXwisBo7ujy+t73p2GMlscRF3cWLHZWqOoXYS5dGy0gYj/lVPAMpew3B
         nsrGTCCiNBp+/y+Ofb4Y5ZVWtjpqlgs9PB9gbWG1MfnecZKl1FsGsP9daky5TcON9F4j
         xPm/H5Hos46WqTHGo6NQYYjPQdolW0BMuSuGvOkmJcBwJWnmRH5G0KFO3gMGkaEM7tzL
         E5Q7dWLle3yXXt6krBHXDsHRHk50KSUU3q9SLO5EkW3/F8+YnVzBkcRsI9dkvRxWKdgb
         CIZw45Z0r3ltIS2kd1lsqiif0PNBOhm3SNSn3DGTi13apgOCTbM+DHMNxYHa83RscwKv
         SafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5uMeJwWigwX7nArU3NFgeKbmwZTaSJ+b7KA1UdN4EA=;
        b=zLPec5zHILT1+d/TmX6OUvpAoSyyFZTjmFVtFkijQmRO+hMoZY+QQDJJdM2KbzKXPl
         q14E63qcRrdTKRZct4jC4kLw++WPcdcbpMFyn1MYsOEFMiise7UljfpRbDv1wD4oxOQM
         mHw2rjisMtwofEanDzsWR511EKIdO7NVJ9ZjChkWz+yeg7W3hyYpBfNVykbROj2PJmh1
         EPl7gFVEsoeR++Yw647lu9t2xIV6Npw4W6/uYE3bKMKH43zhHVd7xbQnl9nZa5mR5wWI
         M4DjlDmEq6NO+dcjzxQvezzZ7zfruN9+KEJ/YmG7bpH3C5P4rO1mlAjcZS/w5LsF0eRb
         rEnw==
X-Gm-Message-State: AJIora8jKV+5O6xytV38tENWEQeWX56EkfaDL+BqpI0Uy8NlWDGvc+aE
        kdjjLfvHlCOaXZmu1rTR/r0lgIHt/GfKtfXL+JdsYneMSiQ=
X-Google-Smtp-Source: AGRyM1sMDFt13BSh2CcefP3zNVdv5rMJVDhFuB2b9k63Dr50FX4uADEg4QjIt/BECkpa9hhpODKS8GUyhDgHfui4POw=
X-Received: by 2002:aa7:c9d3:0:b0:43a:67b9:6eea with SMTP id
 i19-20020aa7c9d3000000b0043a67b96eeamr29384535edt.94.1657223534550; Thu, 07
 Jul 2022 12:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220706232547.4016651-1-joannelkoong@gmail.com>
In-Reply-To: <20220706232547.4016651-1-joannelkoong@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 7 Jul 2022 12:52:03 -0700
Message-ID: <CAADnVQ+cOfMAvz69yjmkvhEA0kZRhGZxGQDAzV-0E+BtmrK71g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Add flags arg to bpf_dynptr_read and
 bpf_dynptr_write APIs
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 6, 2022 at 4:26 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Commit 13bbbfbea759 ("bpf: Add bpf_dynptr_read and bpf_dynptr_write")
> added the bpf_dynptr_write and bpf_dynptr_read APIs.
>
> However, it will be useful for some dynptr types to pass in flags as
> well (eg when writing to a skb, the user may like to invalidate the
> hash or recompute the checksum).
>
> This patch adds a "u64 flags" arg to the bpf_dynptr_read and
> bpf_dynptr_write APIs.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Fixes: 13bbbfbea759 ("bpf: Add bpf_dynptr_read and bpf_dynptr_write")

Ouch. It's an uapi change in the released kernel :(
It has to go via bpf tree instead of bpf-next.

We have to add support for bpf_dynptr to kfunc and the verifier,
so we can use kfunc-s for all future extensions in dynptr area.

> ---
>  include/uapi/linux/bpf.h                           | 11 +++++++----
>  kernel/bpf/helpers.c                               | 12 ++++++++----
>  tools/include/uapi/linux/bpf.h                     | 11 +++++++----
>  tools/testing/selftests/bpf/progs/dynptr_fail.c    | 10 +++++-----
>  tools/testing/selftests/bpf/progs/dynptr_success.c |  4 ++--
>  5 files changed, 29 insertions(+), 19 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 379e68fb866f..3dd13fe738b9 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5226,22 +5226,25 @@ union bpf_attr {
>   *     Return
>   *             Nothing. Always succeeds.
>   *
> - * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offset)
> + * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offset, u64 flags)
