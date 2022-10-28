Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81D7611900
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 19:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiJ1RLt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Oct 2022 13:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiJ1RL2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 13:11:28 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0334AB2F;
        Fri, 28 Oct 2022 10:09:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y14so14402936ejd.9;
        Fri, 28 Oct 2022 10:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DmkRUERi/djKN+dUf3WvsFjA+judctr5yaDrjNmVGio=;
        b=jJFCoxM3RAvvEja4GZB2/BapzDQxhh3QnIzT/wXZpRjFyOTy+utBzX7fiOvmhwnV0C
         8x3jVKGfbLsn0UCb8mKpMjvBG2lqI2pTUqS1C365iL1qxpO9VY2Sm9w/bJL4jUYRmSiU
         0xqnARPXB0H9WNJinmuzp2q3wwGLwSUFxDd4Yv+8Bm+kVvdwyMw84lHsUC0KEKgpzTDg
         8hQUvAoEg82WjgVq1lI0NjjhLSxzyP+f3qvxAtK/68+pfF+eSiDBj3FQROHdEx8dSKHs
         7pta2FzaYSzo6UBoub4U7+9ls96o3mQYwGD4Ck2bvXiJKtycWpN0I6Au8SpCtt/HVf2S
         4mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DmkRUERi/djKN+dUf3WvsFjA+judctr5yaDrjNmVGio=;
        b=MfUyUZEbdIv+JWEJ/sNh9go6FvbQM4rHmlHhM4UNo5t3eb0JRr+UgdKl2bLt4KOUN+
         VDWN+PhOQidviM7+OBIbEa6BtNY8jRZq4MecU16wgEEOChmyajoNmPd0Y/x44fMd0Fdm
         ikOKoUy7baL2pJGvJ1+8jwTU9cgJaAq0N96s3Ke5zgCjtdWkLautRnm7S6vvs6g42JSA
         OMuPeWVlu5pIf3LtbgYDiT7jark9mhXoMN1pqrYCmGYxENxJMa9UVgpShr0inDUXE+uJ
         QrYngGTEU+OfMbYRKIJWzoS3wyNorsNOrNaFbrfEs7VWHc9Sebr5OVJvehs8/BauQZ5g
         bwSA==
X-Gm-Message-State: ACrzQf1dx0kc13ivXDb9l+nh3hf2HFznHYjqKD1T9h0TQI3KvKfmcG0Z
        0qv/EgepkbxQW3jI2mVCbzYi7ePqOGWQYsuXdbU=
X-Google-Smtp-Source: AMsMyM5x3xq7JKy8ZurDjYGS7SBsEe8XMnm6tcYj+Aj4zRUp9fKX8RxV/H01DqYiJhujNvTmn65t9bNr6SSovr+NPi0=
X-Received: by 2002:a17:906:99c5:b0:73d:70c5:1a4f with SMTP id
 s5-20020a17090699c500b0073d70c51a4fmr327011ejn.302.1666976968337; Fri, 28 Oct
 2022 10:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzZAOm8Q4U2vcDjQ7T2_PdoMb5NTWUcL-vzzbXH5tntdOQ@mail.gmail.com>
 <tencent_92599297262AE4AF18A39988330606425408@qq.com>
In-Reply-To: <tencent_92599297262AE4AF18A39988330606425408@qq.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 28 Oct 2022 10:09:16 -0700
Message-ID: <CAEf4Bza_6qND8iOuiur+xX0cBVkKJfKoJAOjihnVYRjoB3tWqw@mail.gmail.com>
Subject: Re: [PATCH] samples/bpf: Fix sockex3: missing BPF prog type
To:     Rong Tao <rtoax@foxmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, rongtao@cestc.cn, sdf@google.com,
        song@kernel.org, yhs@fb.com
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

On Thu, Oct 27, 2022 at 6:01 PM Rong Tao <rtoax@foxmail.com> wrote:
>
> Thanks for your reply, actually, i tried another method, which can solved
> this error, recognize "socket/xxx" as "socket". However, it maybe influence
> other BPF prog or not? What do you think the following patch?

Don't fix libbpf, it's not broken. Fix the sample.

>
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8659,7 +8659,7 @@ static bool sec_def_matches(const struct bpf_sec_def *sec_def, const char *sec_n
>                 return false;
>         }
>
> -       return strcmp(sec_name, sec_def->sec) == 0;
> +       return strncmp(sec_name, sec_def->sec, len) == 0;
>  }
