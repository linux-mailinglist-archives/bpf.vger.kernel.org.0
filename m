Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A91264E26
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 21:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgIJTCh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 15:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbgIJStN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 14:49:13 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98290C061573
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 11:49:12 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id c17so4755913ybe.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 11:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EB4c6MSt3szaXm8+vI0sPunR9WuWgWzkmGplEgM9KjU=;
        b=ioh86+xAdFqjWIasvfd48HsVa9ZN/AMx9pymtbEz8MbZo5gboHNrGkbVurlHcGS+wh
         0fLOswSnPOP+gzluE7bvJsh9wORwsHkalnTbmnoAbf2h/lfwuojsrmgML2MmNCaVFC/a
         aJHRlcTiMApttyACTwFxLdjW3VJRAn2doEWJOVwiq5OG8GLhwtTxpO6fs1fBe7C4D58O
         ZvNuxF0rsT/ejRQoGxIswGpLYY2tcQfQF2Kliixlkoczjs+0Q4wX+JYA8dgc7lwPl1Lx
         Hwh8nEfvrjesQr2uqIFD4gs4SpC+5hqmVLndhIrYhfD+b/efmFcYsmyi+c1oc6tOLd1k
         CpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EB4c6MSt3szaXm8+vI0sPunR9WuWgWzkmGplEgM9KjU=;
        b=umj84O7jyMBvSyvKvSWZ5AQy1FyWZBPHiIHVh4tlq4RaiLwPhQ65AF/1szeVmHyXRv
         m8OPrqVW7sXm9y9qH1qSrPT71sAzw4goBoCQt8fIrucyAFi2oZW4CH/YfXIh8c4xAk0y
         XqnSetUI6/Lrc6Jd6BnbeJzD1O0vrOhhTSz1NVDAxCBEkyIzQ6fFViSV6Ey+Mwfg5zWL
         cmeA9uPy5bBqUzRtc1yJwzklQdkUNSO8l3ADt6J4yzjlPKC93fjJpHNn6h++PJoI9Za5
         pDKBU2mR3rBLXWa241q9S1F8Q5ByuSzJZ0bkl1YN7Zucbyc98851yg9mZRxmI6byAivb
         Fpqw==
X-Gm-Message-State: AOAM531MnvVXy6YQe1wuhcbO8TELarLiwo24meMkMF4lTlaR17OEkn4H
        m7yLIv4Qtcyn4b2Fe9unK5JCAw9Aw0eFGeK8GOI=
X-Google-Smtp-Source: ABdhPJxX9/05h56ptjvnttm1PoQI/FKZKdGzqFhkEQQq+D2kLsj8EkmmSWFoA4FKZgt3KA7adifKu20R0HYeFdfyIRw=
X-Received: by 2002:a25:e655:: with SMTP id d82mr15927573ybh.347.1599763751762;
 Thu, 10 Sep 2020 11:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200909171155.256601-1-lmb@cloudflare.com> <20200909171155.256601-4-lmb@cloudflare.com>
In-Reply-To: <20200909171155.256601-4-lmb@cloudflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 10 Sep 2020 11:49:01 -0700
Message-ID: <CAEf4BzYmsdsCOJvU9Z7qTs1f_1MFspC2Ln5bNnXsmD50RRx-2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 03/11] btf: Add BTF_ID_LIST_SINGLE macro
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 9, 2020 at 10:13 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Add a convenience macro that allows defining a BTF ID list with
> a single item. This lets us cut down on repetitive macros.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> Suggested-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  include/linux/btf_ids.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index 210b086188a3..d6a959572175 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -76,6 +76,13 @@ extern u32 name[];
>  #define BTF_ID_LIST_GLOBAL(name)                       \
>  __BTF_ID_LIST(name, globl)
>
> +/* The BTF_ID_LIST_SINGLE macro defines a BTF_ID_LIST with
> + * a single entry.
> + */
> +#define BTF_ID_LIST_SINGLE(name, prefix, typename)     \
> +       BTF_ID_LIST(name) \
> +       BTF_ID(prefix, typename)
> +

This is a very minor improvement over open coded

BTF_ID_LIST(name)
BTF_ID(prefix, typename)

It made way more sense for SET, due to duplication of set name in START/END.

But I don't mind it either.

>  /*
>   * The BTF_ID_UNUSED macro defines 4 zero bytes.
>   * It's used when we want to define 'unused' entry
> --
> 2.25.1
>
