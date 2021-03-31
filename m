Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E8E34F575
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 02:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhCaAZi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 20:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbhCaAZN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Mar 2021 20:25:13 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC3CC061574
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 17:25:13 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id v186so12915436pgv.7
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 17:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JiHKW01RjgeP+AxOSQjcmRgzm3OlnqFilQWpe+Hu0iU=;
        b=XiudSGq1mSA+kJYRm6uMHlQtLMnIiTd2WL/ptrd88evZ9T/MRqZEDVup0dMyxWd4QO
         gMJTPr9cRYf7B0DFQcQijCT32MzbvpOHNNIi8dwNrkC2KghNIdNxqu1PAyr1XNzlPWnX
         BEbS34Un5pXieoyCKRukLtv6mOpSTcNqKbdqcIa8iczvlpiHNWcNX317XjCtAywnA94h
         ZbzcXzxK7UU6/k1RU1d6scEgN8Y3LK28HqmK81rDU61yNYpuA7t7MD0i8vwrjFGLSaOu
         hR8eDr/TuZhwK//XpOA44Zv5w7DsSMJi0cqaRsvJdxFptCCJWxd0NSqkzslS51lfebr9
         iF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JiHKW01RjgeP+AxOSQjcmRgzm3OlnqFilQWpe+Hu0iU=;
        b=U0g7Z0bxK+j6lDykmVdVxFMyd1fMHhzrthdtXwZFpCW2AAV3jVdf0vTAbRRGyJu1LB
         IbuPyQIK2eWYHbR4iW+H6QUZRhn/lu5/CpSclEe+0SdFkVQmItIkq/Z6jpr5l4NExTdS
         fgJKBiMyKVTlf42+snuQiERgFsQywrxrVxY9gqex5Qspa8zPUG12okMG1Q2foHQ+TaAB
         Q5DQNrPEIco8lkVa1+cNxfM2vJh+UKs53LiuD1Ti2ju37W95imFMWZgBdeuhJ2563zVS
         fa+jgBkKX7OjwG91Y5jOFtTd32wocEebGdQaepVjvvvi4y8AeP8cclTB0ZCYs/oqbEmy
         EDYw==
X-Gm-Message-State: AOAM532v810aDVjxs716V3bCZ7CqPa4dsCqbrTjqlrMPSRmcreezOjBB
        CL7cDQZEPaHI+jT/kZb1TmQr7Q==
X-Google-Smtp-Source: ABdhPJwLq+p6yNn/9+q/FDiltskY5nb+NU0Ab2ZV7w/+FWRi3W5mXt6xs/XuwS55GqnCBfZrkCGhIQ==
X-Received: by 2002:a62:ddd2:0:b029:1f1:533b:b1cf with SMTP id w201-20020a62ddd20000b02901f1533bb1cfmr457601pff.56.1617150312427;
        Tue, 30 Mar 2021 17:25:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:35db:7d2e:3c36:b064])
        by smtp.gmail.com with ESMTPSA id q5sm152275pfk.219.2021.03.30.17.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 17:25:11 -0700 (PDT)
Date:   Tue, 30 Mar 2021 17:25:07 -0700
From:   Fangrui Song <maskray@google.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, arnaldo.melo@gmail.com,
        ast@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        linux-kbuild@vger.kernel.org, masahiroy@kernel.org,
        michal.lkml@markovi.net, clang-built-linux@googlegroups.com,
        sedat.dilek@gmail.com, morbo@google.com
Subject: Re: [PATCH kbuild] kbuild: add -grecord-gcc-switches to clang build
Message-ID: <20210331002507.xv4sxe27dqirmxih@google.com>
References: <20210328064121.2062927-1-yhs@fb.com>
 <20210329225235.1845295-1-ndesaulniers@google.com>
 <0b8d17be-e015-83c3-88d8-7c218cd01536@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0b8d17be-e015-83c3-88d8-7c218cd01536@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021-03-30, 'Yonghong Song' via Clang Built Linux wrote:
>
>
>On 3/29/21 3:52 PM, Nick Desaulniers wrote:
>>(replying to https://lore.kernel.org/bpf/20210328064121.2062927-1-yhs@fb.com/)
>>
>>Thanks for the patch!
>>
>>>+# gcc emits compilation flags in dwarf DW_AT_producer by default
>>>+# while clang needs explicit flag. Add this flag explicitly.
>>>+ifdef CONFIG_CC_IS_CLANG
>>>+DEBUG_CFLAGS	+= -grecord-gcc-switches
>>>+endif
>>>+

Yes, gcc defaults to -grecord-gcc-switches. Clang doesn't.

>>This adds ~5MB/1% to vmlinux of an x86_64 defconfig built with clang. Do we
>>want to add additional guards for CONFIG_DEBUG_INFO_BTF, so that we don't have
>>to pay that cost if that config is not set?
>
>Since this patch is mostly motivated to detect whether the kernel is
>built with clang lto or not. Let me add the flag only if lto is
>enabled. My measurement shows 0.5% increase to thinlto-vmlinux.
>The smaller percentage is due to larger .debug_info section
>(almost double) for thinlto vs. no lto.
>
> ifdef CONFIG_LTO_CLANG
> DEBUG_CFLAGS   += -grecord-gcc-switches
> endif
>
>This will make pahole with any clang built kernels, lto or non-lto.

I share the same concern about sizes. Can't pahole know it is clang LTO
via other means? If pahole just needs to know the one-bit information
(clang LTO vs not), having every compile option seems unnecessary....

>If the maintainer wants further restriction with CONFIG_DEBUG_INFO_BTF,
>I can do that in another revision.
>
>-- 
>You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
>To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
>To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/0b8d17be-e015-83c3-88d8-7c218cd01536%40fb.com.
