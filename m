Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F82844B2AD
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 19:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242378AbhKISYU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 13:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242366AbhKISYS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 13:24:18 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FA2C061766
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 10:21:31 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id k4so26402plx.8
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 10:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TGxOv0gddSpwluqIrv18wDGZRjC0D9opnAifSiyYv58=;
        b=k0LfeGT39s8+3T4MluMVKw/2ohsDGHgKFC3T07j2Yvq8W900u9h6l5HMXXMU0lJP2Y
         3wH/gnzMnE5vx+sVZlbnbMKxbCFyOjX8IME1DH3F9IxOZgIiyXu1m6KEIFt8wH0GkIOB
         HSnW+rNpJCYh8EFivYY8U/b+4GlGnJip2CKssWJNzFrC/K3qre1iuD9g0iHzXnhV8Hlz
         dXa/w3o9MqkKPKsn9CHRz0/195ZStq/6A1138SGkbr7vCMxUlWzTw9aD2EqIzsVfkKiw
         LfF2gWPMkyXruOMQQB+vxM3If8aUsA6dqqtQD/3K/HqVgoTYgNWQBZ24dlg3IYApvlPu
         cf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TGxOv0gddSpwluqIrv18wDGZRjC0D9opnAifSiyYv58=;
        b=SpA4Bgwf8rDef7WjONjnwlR5jdnfWUn0Fee0sq6yhFrKOFduOMJdBYXXumuC2dcGbS
         8mL4nstj7OUZyl7rWC1bLF+Q4OE80sXcfEZhmibrRBETEIat4NyBTRsfCmNyQqx55Hq2
         r+9J9qpTYkFvSpx0U82ifdHDC0QqwGgea5CXwBbinQxnU70OehlBWDv0h5s4AGQ1gW65
         q/EAZiq/z6frMC+Yud6YmzhEKDV2mVetcGb0JBoA5HVwZ0fIYi9KUx190DeWKNC8iJxR
         NEyYcajD/f8+tUfSKCfYVeztMN0Wa+LPfhOyoW+66XVyJdQKRRZ8soFdIdX2QIwzuCsM
         y8xQ==
X-Gm-Message-State: AOAM530DkT/7dBkHNoQ+LBG8vtd6mankXLKCEFVtL5extQEFhnCkRNQJ
        KYlHEt/bGwGxlTHY0ttYSFk=
X-Google-Smtp-Source: ABdhPJzdE8aXFYR5K1luNdkAgnnSis3nmzJQgwwMDv19Z65i8ovWLlrS2CS8ypeh+86LXL5mwajyWA==
X-Received: by 2002:a17:90a:4a06:: with SMTP id e6mr9562849pjh.228.1636482090986;
        Tue, 09 Nov 2021 10:21:30 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:f8f1])
        by smtp.gmail.com with ESMTPSA id p25sm19977886pfh.86.2021.11.09.10.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 10:21:30 -0800 (PST)
Date:   Tue, 9 Nov 2021 10:21:28 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 0/9] bpf: Clean up _OR_NULL arg types
Message-ID: <20211109182128.hhbaqv3j52fddayq@ast-mbp.dhcp.thefacebook.com>
References: <20211109021624.1140446-1-haoluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109021624.1140446-1-haoluo@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 08, 2021 at 06:16:15PM -0800, Hao Luo wrote:
> This is a pure cleanup patchset that tries to use flag to mark whether
> an arg may be null. It replaces enum bpf_arg_type with a struct. Doing
> so allows us to embed the properties of arguments in the struct, which
> is a more scalable solution than introducing a new enum. This patchset
> performs this transformation only on arg_type. If it looks good,
> follow-up patches will do the same on reg_type and ret_type.
> 
> The first patch replaces 'enum bpf_arg_type' with 'struct bpf_arg_type'
> and each of the rest patches transforms one type of ARG_XXX_OR_NULLs.

Nice. Thank you for working on it!

The enum->struct conversion works for bpf_arg_type, but applying
the same technique to bpf_reg_type could be problematic.
Since it's part of bpf_reg_state which in turn is multiplied by a large factor.
Growing enum from 4 bytes to 8 byte struct will consume quite
a lot of extra memory.

>  19 files changed, 932 insertions(+), 780 deletions(-)

Just bpf_arg_type refactoring adds a lot of churn which could make
backports of future fixes not automatic anymore.
Similar converstion for bpf_reg_type and bpf_return_type will
be even more churn.
Have you considered using upper bits to represent flags?

Instead of diff:
-       .arg1_type      = ARG_CONST_MAP_PTR,
-       .arg2_type      = ARG_PTR_TO_FUNC,
-       .arg3_type      = ARG_PTR_TO_STACK_OR_NULL,
-       .arg4_type      = ARG_ANYTHING,
+       .arg1           = { .type = ARG_CONST_MAP_PTR },
+       .arg2           = { .type = ARG_PTR_TO_FUNC },
+       .arg3           = { .type = ARG_PTR_TO_STACK_OR_NULL },
+       .arg4           = { .type = ARG_ANYTHING },

can we make it look like:
       .arg1_type      = ARG_CONST_MAP_PTR,
       .arg2_type      = ARG_PTR_TO_FUNC,
-      .arg3_type      = ARG_PTR_TO_STACK_OR_NULL,
+      .arg3_type      = ARG_PTR_TO_STACK | MAYBE_NULL,
       .arg4_type      = ARG_ANYTHING,

Ideally all three (bpf_reg_type, bpf_return_type, and bpf_arg_type)
would share the same flag bit: MAYBE_NULL.
Then static bool arg_type_may_be_null() will be comparing only single bit ?

While
        if (arg_type == ARG_PTR_TO_MAP_VALUE ||
            arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE ||
            arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL) {
will become:
        arg_type &= FLAG_MASK;
        if (arg_type == ARG_PTR_TO_MAP_VALUE ||
            arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE) {

Most of the time I would prefer explicit .type and .flag structure,
but saving memory is important for bpf_reg_type, so explicit bit
operations are probably justified.
