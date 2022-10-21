Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E45607E23
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 20:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJUSMQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 14:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiJUSMO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 14:12:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AE72630B4
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 11:12:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t16so8918984edd.2
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 11:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7YyF0Yf2yQIgBfGptTfBGznk6rxPXgyMKW6xwq2XLBQ=;
        b=WWmXrNY8BQdqAM0+DhbFQe+PDLqCDRLeBMBP916T+sOS7CoHJwK/a6cRjfy/1NoQ4+
         L0kSiFVFIs+dCimTclPEv17LA4Bp8lON/bK0pMnlXYIqkvd+f7Usc4roTUdflYKlDDb6
         S8qUFMX5r6OdCpZ7SVT3Q18/MhkHjukY+LVpkxZRHOw1eocx6w7rKDTWbWESvr2cyWJh
         Uyl6q9i0LB6GTGeZW3IyC1dnP8l5eO/u1E6G09tfD1oONyykAe5KYsp4gT7owl1x54qJ
         neEga/mQg9J6FpCaFK9FeLiDphQSN+RMaKPJ1NEAgt5HVndgOpfBMvMOSx5UTxq0ADrU
         qXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YyF0Yf2yQIgBfGptTfBGznk6rxPXgyMKW6xwq2XLBQ=;
        b=YxJ9LBV65rTeTTmz4vcAof+ltenFHYxLJCO45yQLJ/kQ95ZfmDamzk7fxKevDSz6lS
         dGIcQHYhmzCt25ZIrwb6HC84ai0PcFgcdSIuRcInUQeCvShydQAuERY+kCp7H+3gPxK7
         jq8eE9GPI/DFtYllu0TXbl+OkgqeaB48JfIiN8+rw0WfYJNosxztomJlW1UJKT1l5FOw
         udFxJKul2ttic4TfQ5oO5hK3u4EuCh+PtBqzeGC8KAJtBp2ve7kbW5msiRcB53jksFuh
         simkMvsSYOGfaSQJX0QXuqxKVdOOX974hgjxVrz4Bs2DSViKiCIRu4ZwabxgBNGKCA1p
         9T/A==
X-Gm-Message-State: ACrzQf2WNhp92YDzjIUTFTQlC8kbCgJxA0xzgNW80ZB1Cqms6/cj+0Xs
        bmLCuJN/2lZ4dsbTemCzFeuJfel+1F89lz69sEY=
X-Google-Smtp-Source: AMsMyM5Yh+u10TdykGINkNOVdooWkGGzJgtjKj3Penfrj4VsBg/R/zVtzTvKL3wP5lAa+yzkJ58YBunYC69Aw5o44Ms=
X-Received: by 2002:a17:906:8457:b0:78d:b793:5511 with SMTP id
 e23-20020a170906845700b0078db7935511mr16514538ejy.393.1666375931865; Fri, 21
 Oct 2022 11:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221018135920.726360-1-memxor@gmail.com> <20221018135920.726360-9-memxor@gmail.com>
In-Reply-To: <20221018135920.726360-9-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 21 Oct 2022 11:12:00 -0700
Message-ID: <CAJnrk1ZJfBtMVzkbncwP4ZUPWTjEk-8od_n2sngwLaZC=OACbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 08/13] bpf: Use memmove for bpf_dynptr_{read,write}
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
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

On Tue, Oct 18, 2022 at 6:59 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> It may happen that destination buffer memory overlaps with memory dynptr
> points to. Hence, we must use memmove to correctly copy from dynptr to
> destination buffer, or source buffer to dynptr.
>
> This actually isn't a problem right now, as memcpy implementation falls
> back to memmove on detecting overlap and warns about it, but we
> shouldn't be relying on that.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  kernel/bpf/helpers.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 0a4017eb3616..2dc3f5ce8f9b 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1489,7 +1489,7 @@ BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern
>         if (err)
>                 return err;
>
> -       memcpy(dst, src->data + src->offset + offset, len);
> +       memmove(dst, src->data + src->offset + offset, len);
>
>         return 0;
>  }
> @@ -1517,7 +1517,7 @@ BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u32, offset, v
>         if (err)
>                 return err;
>
> -       memcpy(dst->data + dst->offset + offset, src, len);
> +       memmove(dst->data + dst->offset + offset, src, len);
>
>         return 0;
>  }
> --
> 2.38.0
>
