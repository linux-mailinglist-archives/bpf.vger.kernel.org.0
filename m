Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DC04070EE
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 20:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhIJSdA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 14:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhIJSdA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Sep 2021 14:33:00 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAC2C061574
        for <bpf@vger.kernel.org>; Fri, 10 Sep 2021 11:31:49 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id k13so5879735lfv.2
        for <bpf@vger.kernel.org>; Fri, 10 Sep 2021 11:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8r3eDatvrf7JEZvmv+ZziNT+y6ucD1NzD7GL+TqRWY=;
        b=WH3O3+CxEJ7PW+sGiJeLA47aIsXg2yarB25eHKnwlHZ97jP89ntkUPW2MiNU/L7PjG
         yIQ9kUjsQKgiR3pHJ84rtj4dNTsVZ8Rw1Om8yfVCyUOmXuVFDuEo2sT8V7bZD0c/iWdh
         8hgIZsd1vQSVK55O3HFruK11dh+mSFsHOuFihEY2+BU2nd0DDTYktH0/uQXY0QQqhQ/x
         lQKyBmZCaY0pXzeOmoxGWkpchdUi6fC5CTmWWf5GEejn48h6ln7nULMQbrpr+qtUAu/A
         30zZ4U7hZHCAbhcxb7NoP/P9j+60cN7CwfiQmPoips83ttlgAGdicKb5a22F/9tNQqcn
         DxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8r3eDatvrf7JEZvmv+ZziNT+y6ucD1NzD7GL+TqRWY=;
        b=RMoq92lIDvTxhGPVbY2KaJ1hiMlMvarbsPUtOBVNO8qEDRBLmDgwXoB1kklCr/6wG1
         O+rOECV1R9DnOaZPwrlpzpAvZR/cmRocHWBh6O3Log+hGWxjnaXouJLyKq1NuO2GmBYa
         UC1wsSRIu6VyTfeXfgrfWeEWJXzkA2StoW68JJMA4e3XvOqjO476v9+NA2Bb7khRLjn2
         zF/6IwnXqoJC5mIoRK3xHqn2i17VRg4Z0rBSzrYEKtJTYAjLlIyU6xgt7eLJjW2MxI/t
         RKtmr81DD53mrYfmsjlYLhx0idEJEUHv1kehmM/qSxdF4LkvC7y6iFc5mINQFkzlE6Lo
         gfFA==
X-Gm-Message-State: AOAM530Ysw7BKH6TS/Z5SQIzjqIBZmeorAqGQOSS894w2daZXQAtBCgR
        YNro1voXh0Y4CPeIyYLYW44gtG0JEhGJr8K/12DwwlE/QgzwPg==
X-Google-Smtp-Source: ABdhPJxYE0AVfTphEFoO4/WDe4fx1AqnBJoZEKX7sDkN02XM0jKOnw2v+4lX4ojc2meD7Tq2CvWDSiZ/WWPwzuXRTyM=
X-Received: by 2002:ac2:4103:: with SMTP id b3mr4944609lfi.685.1631298707536;
 Fri, 10 Sep 2021 11:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210909204312.197814-1-grantseltzer@gmail.com>
In-Reply-To: <20210909204312.197814-1-grantseltzer@gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Fri, 10 Sep 2021 14:31:36 -0400
Message-ID: <CAO658oVYm=Pk5EV2-JqceLYeCT9KkH3v_cGSkNnxhQoDYiu1CA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add sphinx code documentation comments
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 9, 2021 at 4:43 PM grantseltzer <grantseltzer@gmail.com> wrote:
>
> From: Grant Seltzer <grantseltzer@gmail.com>
>
> This adds comments above five functions in btf.h which document
> their uses. These comments are of a format that doxygen and sphinx
> can pick up and render. These are rendered by libbpf.readthedocs.org
>
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> ---
>  tools/lib/bpf/btf.h | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 4a711f990904..f928e57c238c 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -30,11 +30,47 @@ enum btf_endianness {
>         BTF_BIG_ENDIAN = 1,
>  };
>
> +/**
> + * @brief **btf__free** frees all data of the BTF representation
> + * @param btf
> + * @return void
> + */
>  LIBBPF_API void btf__free(struct btf *btf);
>
> +/**
> + * @brief **btf__new** creates a representation of a BTF section
> + * (struct btf) from the raw bytes of that section
> + * @param data raw bytes
> + * @param size length of raw bytes
> + * @return struct btf*
> + */
>  LIBBPF_API struct btf *btf__new(const void *data, __u32 size);
> +
> +/**
> + * @brief **btf__new_split** creates a representation of a BTF section
> + * (struct btf) from a combination of raw bytes and a btf struct
> + * where the btf struct provides a basic set of types and strings,
> + * while the raw data adds its own new types and strings
> + * @param data raw bytes
> + * @param size length of raw bytes
> + * @param base_btf the base btf representation
> + * @return struct btf*
> + */
>  LIBBPF_API struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf);
> +
> +/**
> + * @brief **btf__new_empty** creates an unpopulated representation of
> + * a BTF section
> + * @return struct btf*
> + */
>  LIBBPF_API struct btf *btf__new_empty(void);
> +
> +/**
> + * @brief **btf__new_empty_split** creates an unpopulated
> + * representation of a BTF section except with a base BTF
> + * ontop of which split BTF should be based
> + * @return struct btf*q
> + */
>  LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
>
>  LIBBPF_API struct btf *btf__parse(const char *path, struct btf_ext **btf_ext);
> --
> 2.31.1


I should note that you can view what this actually looks like here:
https://libbpf-test.readthedocs.io/en/latest/api.html

Also I would use this (plus your feedback) to make a document laying
out a standard convention for formatting these doc comments and
contribute that via the github mirror.
