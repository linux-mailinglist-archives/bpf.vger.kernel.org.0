Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC48E6220EC
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 01:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiKIAmh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 19:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKIAmh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 19:42:37 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A6B12743
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 16:42:35 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id i21so25000877edj.10
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 16:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv1nWnbAIDLOsIyctEi6ZlbA7wZBV3iPbq2wiLM1C+g=;
        b=LRjxlrXVj8VOQmT651w5yr3oT3R6cNDbZ6fT9+VfZHY3Ghoig3YVRgF5jHi4wG9PMg
         pWVM2zKLvEPz0bupTjIHVTnjE5o+Ptn6kkbnAgiEYpd7W3lNV7I34Ky1fs4fhs37TsNR
         9TFV3aIQS1gJikfdGYO1OoO0GMjbMaZU3CAXfDlSob0R/LNllQMGe7SdfNO4FzgL1EX+
         scOSbar5ry7WUOe4rhpnMSRxoc7t4ehWgaNCvUA/0EGD0U+kzRp9pb36U+GbJ9HDqVCN
         HhQw6nqhUr3ALkgy5BnmYNIsys8/mJyQ9zKMRYrU4OiyxkHofF9zNYzM+5tlSCLpUnnU
         tP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cv1nWnbAIDLOsIyctEi6ZlbA7wZBV3iPbq2wiLM1C+g=;
        b=aafkVJ7LAcIIngIVnvp9zehbtJClO3UcW7xxB6hboQQhrUhamYhTkxmFOYT+tC8ZJP
         GiIJHI19QmGjaGgA36G5hvQMv89aoo5T99pSKQnj+hcH3QRUXfXaNYAQD9ZDGH7fPMLj
         zxWoAjNdIkhu+oJCRoX0d7i+w1ZFFhHRXQWYvkomscGWw0Ks/j64lBH2Llu79BbRSm5Q
         rlJ+G1pykQ9UX7vJ66TBcOgT2yXA3bUhpJENeRNV0eQomeaIImJQT9f2UvNIFK1WSAsX
         OdpdHnW6RzwKlS6vMKvGbV9fOI4RA3BrsaU3jiaZH/IkcaPSLtnrQAX3qOi0Xi3tpnzm
         Uvcg==
X-Gm-Message-State: ACrzQf2PKOY7wWsgtbIRFLVIVgl5zQq+DHFzLMh9Vp8LZWoj1JlvjguF
        VS/cxa5cu0IXd1fiWFr0M4SyCqdAyWNw2iigXwg=
X-Google-Smtp-Source: AMsMyM4QQdBiB5pkJYILFqfPJVvHSBdJv36WInwNhVbm4qdy/VSJwOswFT5WBOoW+tLt7JDwrNRr2QhLIdaMTvXHhqM=
X-Received: by 2002:a05:6402:2791:b0:461:c5b4:d114 with SMTP id
 b17-20020a056402279100b00461c5b4d114mr57164246ede.357.1667954553689; Tue, 08
 Nov 2022 16:42:33 -0800 (PST)
MIME-Version: 1.0
References: <20221108222027.3409437-1-jolsa@kernel.org> <20221108222027.3409437-3-jolsa@kernel.org>
In-Reply-To: <20221108222027.3409437-3-jolsa@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 8 Nov 2022 16:42:20 -0800
Message-ID: <CAADnVQKyT4Mm4EdTCYK8c070E-BwPZS_FOkWKLJC80riSGmLTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add bpf_vma_build_id_parse helper
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 8, 2022 at 2:20 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding bpf_vma_build_id_parse helper that parses build ID of ELF file
> mapped vma struct passed as an argument.
>
> I originally wanted to add this as kfunc, but we need to be sure the
> receiving buffer is big enough and we can't check for that on kfunc
> side.

Let's figure out how to do that with kfunc.

Sorry, but I'm going to insist on everything being kfuncs
from now on.
200+ stable helpers. That's large enough uapi exposure already.
