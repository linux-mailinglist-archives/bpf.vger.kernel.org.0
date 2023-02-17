Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF3069AF7E
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 16:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjBQP1w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 10:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjBQP1v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 10:27:51 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0C310D2
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 07:27:48 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id u14-20020a17090a4bce00b002341fadc370so1636588pjl.1
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 07:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FjhxRmxnq7g/s7HTg3+kkGL/XHuH+Vbf1L6uY1gtdZo=;
        b=FI/KCZOninl4pna7XqfUzhnxFpGIrbQeTbMujiTucgT+kYUmTkqKvpqrY0BBWfyGHl
         kGVHGRvlZzrxQgBr1yfxol8SKtKTNnefzdaSMXohxCDU/zWuaKWZDs+j15osVIse5Jbs
         pPrmNP9mEpEy35h4of6Aq3SVWil9eh91QVjrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FjhxRmxnq7g/s7HTg3+kkGL/XHuH+Vbf1L6uY1gtdZo=;
        b=WJ5pfcvgYpqnoc9NNkJjJ9DfNkzI19EivvcKkxu2ALAy8Xnog+biJDFr8TMoNYvUbH
         aalbBhG/hZGHGB465YrDibdWkxuuPhIhS1HS57bL9LCaHDX9b27kkm9FMMLn8bttCmgh
         Idp6OI9846LOT995EyLv4qSt9E6KKFemRp5VAxDy1dPGQF4JY4qTca9fsCzKIV6brJpU
         yFLPuues+tMjbo8Uy6KCi1goAk6QRrx2FcHYLvSxgcVAjNn7Ua3qDjkgtpOt3QDPGUwK
         jgWB+A6UslJ98zmZD5yqfw2EuVQE+QLbRYgG3Kta+8HvFPbPv+1Mp9tRhwgBe0QjrmQi
         uU8A==
X-Gm-Message-State: AO0yUKXZagHTbjFd0pt5jw9q+LqLT75ucjExrbdgqfW8RF+SkxPBOCQo
        ZFgnLZMFGJC4NI+FI2mjLE2/qf2tYCRptuVyNFukRPg2+vGEo9nI+XU=
X-Google-Smtp-Source: AK7set+MhY2O08saH1T5RViqTcHgqAmXt9TEW6+Qid0bDYcQBDwu1dbJU5pEbkggOuOqzWdO29LJIwiJ55IFIJYYaW8=
X-Received: by 2002:a17:90b:3a8f:b0:234:117c:970f with SMTP id
 om15-20020a17090b3a8f00b00234117c970fmr1596590pjb.28.1676647667935; Fri, 17
 Feb 2023 07:27:47 -0800 (PST)
MIME-Version: 1.0
References: <20230217151832.27784-1-revest@chromium.org>
In-Reply-To: <20230217151832.27784-1-revest@chromium.org>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 17 Feb 2023 16:27:36 +0100
Message-ID: <CABRcYmLpAt3R5_2r6AgpnYrSx+1GZ9=827EK0xByFJf=eROd1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix cross compilation with CLANG_CROSS_FLAGS
To:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org
Cc:     andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, kpsingh@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 17, 2023 at 4:18 PM Florent Revest <revest@chromium.org> wrote:
>
> I cross-compile my BPF selftests with the following command:
>
> CLANG_CROSS_FLAGS="--target=aarch64-linux-gnu --sysroot=/sysroot/" \
>   make LLVM=1 CC=clang CROSS_COMPILE=aarch64-linux-gnu- SRCARCH=arm64
>
> (Note the use of CLANG_CROSS_FLAGS to specify a custom sysroot instead
> of letting clang use gcc's default sysroot)
>
> However, CLANG_CROSS_FLAGS gets propagated to host tools builds (libbpf
> and bpftool) and because they reference it directly in their Makefiles,
> they end up cross-compiling host objects which results in linking
> errors.
>
> This patch ensures that CLANG_CROSS_FLAGS is reset if CROSS_COMPILE
> isn't set (for example when reaching a BPF host tool build).

Note: I'm not entirely sure which tree should take that patch. I
tagged this patch as "bpf-next" because 1- that's the tree I know best
2- as far as I can tell, only BPF tools Makefiles reference
CLANG_CROSS_FLAGS directly and are currently broken in this way 3- I
figured this would be a simple enough patch that it's not too hard for
another tree to take it.

Anyway, I tried to CC other relevant folks, I figured there could be
different opinions on how this should get solved, for example the bpf
Makefiles using CLANG_CROSS_FLAGS could check whether CROSS_COMPILE is
set first. I'd be happy to adapt a v2 to any suggestion.
