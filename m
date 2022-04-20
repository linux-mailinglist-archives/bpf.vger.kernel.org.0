Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F64509290
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 00:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351515AbiDTWTR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 18:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353886AbiDTWTQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 18:19:16 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C32A3CFE8
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 15:16:28 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e194so3390619iof.11
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 15:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/7kQ6/5nHZ2LB27/BmguhHxrRD7MZBap8syfyR4ITX0=;
        b=IDaG9MaNNYPTH4cKNmojGydGJbQ9VPKAsPBBwdB/JkOforJw1jrsq5nmzKkoEAE2Ox
         dQ1hmLJU3R6AC+P7X90WV5HzcdtjwMw70/OaXxbAiwf/y5tEeNsR/76wIoRrK2TrInPU
         /93853n/+3qAkWU//2/K/2T+f5R5AkcBewMLUaEk9+h/CYWPf4KKhO6mUhV7OynBXvrE
         JQues6a2Dfuo02Wx+yjdAlq6a69VuFPkWD8d1Ukg3kMUPCs9z04P1ANPXbs0jM41bEat
         +Gu1lt+onyMG1bQNLGGspCBak531J/m5FLUfGsjT4JtiDT4VO5IxXkU7vw2DnKA4lsfd
         8/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/7kQ6/5nHZ2LB27/BmguhHxrRD7MZBap8syfyR4ITX0=;
        b=Yv+OwYOYZ+ohwAEtWiV8A2L27HWIw/Sju9uf7hdWEcv1kwLS0B3vmyju71Z9tJ7H90
         xEcWsehcIcWKuH9P4AqrXTwl5XACpq1qg0op+zBhwlc/DifpslY+KKYIQbkSUD89xT4i
         pn6N+ld672mMDa46dvvvOZnveZ427MlJ2xTsMwgGCbSv0vgtpcmmKq1GpLjXk5AIoVlu
         LFbPrM5klKuQ9ZjQPg11MFBCKWKb7gv1K4hYPmo+4i7ST8WXVxj0kv+u+sDEqaRFiM0u
         4VO/KH8eQIesUwuWFjJDDaX5ZqePk6crNuve8+cKCN/HlCjqddZ9FgsNrZqymELvA3Q8
         /Apw==
X-Gm-Message-State: AOAM533c64MNQLGTgTERaFtLhmP28xQzAXKJP3vxvbt0Kqb3F3DpuJER
        7SeCa2pPnnIdwprAzplWvCpUmTe4cHzDacWxREXSl1WE
X-Google-Smtp-Source: ABdhPJzbOVDCKQSlwdsx66r3dxJ7TmA8mftaUfcn8BwQQ3d//jRJsHAo7B0VSz3sjb47/lXmZxywXia8f+p67IOt9/s=
X-Received: by 2002:a05:6638:16c9:b0:328:5569:fe94 with SMTP id
 g9-20020a05663816c900b003285569fe94mr11281167jat.145.1650492986929; Wed, 20
 Apr 2022 15:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220420161226.86803-1-grantseltzer@gmail.com> <20220420161226.86803-3-grantseltzer@gmail.com>
In-Reply-To: <20220420161226.86803-3-grantseltzer@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Apr 2022 15:16:16 -0700
Message-ID: <CAEf4BzaSQrsU3C7=7AC0eqNv+-+sqPvBRjdU=tk_OhQKOEF+HA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/3] Add documentation to API functions
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>
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

On Wed, Apr 20, 2022 at 9:12 AM grantseltzer <grantseltzer@gmail.com> wrote:
>
> From: Grant Seltzer <grantseltzer@gmail.com>
>
> This adds documentation for the following API functions:
> - bpf_program__set_expected_attach_type()
> - bpf_program__set_type()
> - bpf_program__set_attach_target()
> - bpf_program__attach()
> - bpf_program__pin()
> - bpf_program__unpin()
>
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> ---
>  tools/lib/bpf/libbpf.h | 77 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 75 insertions(+), 2 deletions(-)
>

[...]

>
>  LIBBPF_API enum bpf_attach_type
>  bpf_program__expected_attach_type(const struct bpf_program *prog);
> -LIBBPF_API void
> +
> +/**
> + * @brief **bpf_program__set_expected_attach_type()** sets the
> + * attach type of the passed BPF program. This is used for
> + * auto-detection of attachment when programs are loaded.
> + * @param prog BPF program to set the attach type for
> + * @param type attach type to set the BPF map to have
> + * @return error code; or 0 if no error. An error occurs
> + * if the object is already loaded.
> + *
> + * This must be called before the BPF object is loaded,
> + * otherwise it has no effect and an error is returned.
> + */
> +LIBBPF_API int

you forgot to do this void -> int replacement in libbpf.h. I've fixed
it up while applying, so all the type changes happen in patch #1.

>  bpf_program__set_expected_attach_type(struct bpf_program *prog,
>                                       enum bpf_attach_type type);
>
> @@ -707,6 +772,14 @@ LIBBPF_API int bpf_program__set_log_level(struct bpf_program *prog, __u32 log_le
>  LIBBPF_API const char *bpf_program__log_buf(const struct bpf_program *prog, size_t *log_size);
>  LIBBPF_API int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log_size);
>
> +/**
> + * @brief **bpf_program__set_attach_target()** sets BTF-based attach target
> + * for supported BPF program types:
> + * BTF-aware raw tracepoints, fentry/fexit/fmod_ret, lsm, freplace

also turned this into a proper list

> + * @param prog BPF program to set the attach type for
> + * @param type attach type to set the BPF map to have
> + * @return error code; or 0 if no error occurred.
> + */
>  LIBBPF_API int
>  bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog_fd,
>                                const char *attach_func_name);
> --
> 2.34.1
>
