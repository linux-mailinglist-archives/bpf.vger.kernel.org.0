Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C0F613ECB
	for <lists+bpf@lfdr.de>; Mon, 31 Oct 2022 21:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiJaUQa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Oct 2022 16:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiJaUQ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Oct 2022 16:16:29 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD2DF024
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 13:16:27 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a67so19037502edf.12
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 13:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ci3+QoHQ25KB/iJMgmn6M3elbqhltdUkE8SPO6WZlmo=;
        b=CTq5gfsrME/R6gLnFUaqNt0aOVbT6FsZdc4Y79sVuG3Ei3LiCj1u1WpbqERv/iHI1M
         iqxNDtg5J9u3HoJ03UQzyZJf+xLFzk90PkvZjo55ZgpkQGiCsyoP/7HnGkk3E2ZI38vZ
         LcWSvxybIs+Xp/rXEFb3lkFepFH32VuGs28NjvTry1Adw289juuZZK0ZEJIgJQxtYuLl
         2aUYIUoFvjytKpnwCI1LD1X6Pr/8HFKhD3ZEk5R/W3TSRSoHxuhEB45kWJ/nrUByxN4Y
         FvRtgj2eEwIemS6gW+ubspkopG/c+k/qRMVBunNq8y7spIeIpRiKOtHpdjwppZ2EAdnl
         33Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ci3+QoHQ25KB/iJMgmn6M3elbqhltdUkE8SPO6WZlmo=;
        b=v4YMQtqR72v7vOqpFmmag4uw4qfR0eUWZ9uTTtybs3NsSkH8E1wtkSt9/VQzs/kR7k
         ByJW6pMcJnvVBV1UM2A1NBgQoRO2dTb8vx+eZ9/Wc55eOU1J7UiRGO1XRUc/lvrYddx6
         Qjg9TrH42F3Vx3JeJHAxp3O2n9g21Gq2j+Us/vuENuQuMsT8nxE8ql1wIyn0FIcyIyTR
         YXAj60LcZW3sDapQKItyJF5NuA7RQP1aJra6dlAkQp2OPaxUDHBz8g+LDC15qvxgkIFY
         f1V8sb0YGW+15LO6wgyQXeDiGPJeTs14scn/0Eq+grU6SerCgzjM3yh9ltjwe7G1DUHY
         8S5Q==
X-Gm-Message-State: ACrzQf3oUM0rwb+eIBjn5PhKOzZeC9/Ce3EUIA5yddotajj8YsZRD+IV
        2EcwVxQsqdxdKz2Gm4c3GY0htN39YscCfGWDd2yA
X-Google-Smtp-Source: AMsMyM7FRCcRFTFbl0DrxIU1Df1+CfE/Y1YzIBEFicyXXX8ZtMZF3eDdxV5jWU80lH6VSNcXEsdIz+04ZtO0WlJW7EY=
X-Received: by 2002:a05:6402:22a5:b0:462:b393:f281 with SMTP id
 cx5-20020a05640222a500b00462b393f281mr15555602edb.379.1667247386069; Mon, 31
 Oct 2022 13:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221029024444.gonna.633-kees@kernel.org> <20221029025433.2533810-1-keescook@chromium.org>
In-Reply-To: <20221029025433.2533810-1-keescook@chromium.org>
From:   Bill Wendling <morbo@google.com>
Date:   Mon, 31 Oct 2022 13:16:09 -0700
Message-ID: <CAGG=3QXYVwQ5pwARdGTenm-mDQn4Tcz6U-=EZ8BDcwBkM5bFfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf/verifier: Fix potential memory leak
 in array reallocation
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 28, 2022 at 7:55 PM Kees Cook <keescook@chromium.org> wrote:
>
> If an error (NULL) is returned by krealloc(), callers of realloc_array()
> were setting their allocation pointers to NULL, but on error krealloc()
> does not touch the original allocation. This would result in a memory
> resource leak. Instead, free the old allocation on the error handling
> path.
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Bill Wendling <morbo@google.com>

> ---
>  kernel/bpf/verifier.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 014ee0953dbd..eb8c34db74c7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1027,12 +1027,17 @@ static void *copy_array(void *dst, const void *src, size_t n, size_t size, gfp_t
>   */
>  static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
>  {
> +       void *new_arr;
> +
>         if (!new_n || old_n == new_n)
>                 goto out;
>
> -       arr = krealloc_array(arr, new_n, size, GFP_KERNEL);
> -       if (!arr)
> +       new_arr = krealloc_array(arr, new_n, size, GFP_KERNEL);
> +       if (!new_arr) {
> +               kfree(arr);
>                 return NULL;
> +       }
> +       arr = new_arr;
>
>         if (new_n > old_n)
>                 memset(arr + old_n * size, 0, (new_n - old_n) * size);
> --
> 2.34.1
>
