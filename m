Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7292D5002D9
	for <lists+bpf@lfdr.de>; Thu, 14 Apr 2022 01:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiDNABH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Apr 2022 20:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiDNABH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 20:01:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C27554BC
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 16:58:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BBA261093
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 23:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87475C385AA
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 23:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649894322;
        bh=C5Iy5vwUi/XKFxayE1x2tDyIRSkmQ+KV4K5zHOkx5lw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P0KSD22yoJ+G1g4V0KweV6Bpru2oDBSjBdKYNsV2HxLFhMvXylxQ+3h94uwAAjy4e
         pp1ZA+XBHiuXNpFvkNvoXnxYXapiR6Bo8ydqOxhL32gbPRcF97IWGMgCQS9Oa/aAfR
         pehtwDbfKvy5fDBWmIzQN7D16YKviASwEnfnZcMXdNRo321ckSHYQN0sh02hD5IBqp
         DPhNOy9T5sRuWiCtVeAEo2Xb+J4Oxs1EMA2ynytqVGclpndxCUzY+zPeU/eu3glVX/
         jZupxAC94qR1PyBAC9YkpOYMStEEQx7Mf/0W0v7QGImegDsPktFPHwlOg9b5i0LryS
         zkOVVCXdhjJ2w==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2ebd70a4cf5so39737787b3.3
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 16:58:42 -0700 (PDT)
X-Gm-Message-State: AOAM530aDC1C/dl9TWjguDS7eA5Nnhk5mLgTQlHZwQ2fiQ5sqsQUWGus
        GLG5rgVYZBvQH3SUrZxfTZGXK6eV0689fbtPWWM=
X-Google-Smtp-Source: ABdhPJy1Yzvb94Db5ElNTK6EVuTqytZUid2o7MKKPVO+jmm8npzFbJEMyCTCIYHOMQMbxBvzK22F48rqJ9Z3z9swIg8=
X-Received: by 2002:a81:5087:0:b0:2ef:33c1:fccd with SMTP id
 e129-20020a815087000000b002ef33c1fccdmr21348ywb.73.1649894321540; Wed, 13 Apr
 2022 16:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220412215431.271150-1-grantseltzer@gmail.com>
In-Reply-To: <20220412215431.271150-1-grantseltzer@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 13 Apr 2022 16:58:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6cbKf4DVr82qGPPT6ozsdLxZANDHzHsd1xx+hifnUMgQ@mail.gmail.com>
Message-ID: <CAPhsuW6cbKf4DVr82qGPPT6ozsdLxZANDHzHsd1xx+hifnUMgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Add documentation to API functions
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 12, 2022 at 4:33 PM grantseltzer <grantseltzer@gmail.com> wrote:
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

The text looks good to me. But please run checkpatch.pl and fix all the errors.

> ---
>  tools/lib/bpf/libbpf.h | 84 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 63d66f1adf1a..09a8bf2fd7d9 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -378,7 +378,31 @@ struct bpf_link;
>  LIBBPF_API struct bpf_link *bpf_link__open(const char *path);
>  LIBBPF_API int bpf_link__fd(const struct bpf_link *link);
>  LIBBPF_API const char *bpf_link__pin_path(const struct bpf_link *link);
> +/**
> + * @brief **bpf_link__pin()** pins the BPF link to a file
> + * in the BPF FS specified by a path. This increments the links
> + * reference count, allowing it to stay loaded after the process
> + * which loaded it has exited.
> + *
> + * @param link BPF link to pin, must already be loaded
> + * @param path file path in a BPF file system
> + * @return 0, on success; negative error code, otherwise
> + */
> +
nit: empty line is not necessary here.
>  LIBBPF_API int bpf_link__pin(struct bpf_link *link, const char *path);
> +
> +/**
> + * @brief **bpf_link__unpin()** unpins the BPF link from a file
> + * in the BPFFS specified by a path. This decrements the links
> + * reference count.
> + *
> + * The file pinning the BPF link can also be unlinked by a different
> + * process in which case this function will return an error.
> + *
> + * @param link BPF link to unpin
> + * @param path file path to the pin in a BPF file system
> + * @return 0, on success; negative error code, otherwise
> + */
>  LIBBPF_API int bpf_link__unpin(struct bpf_link *link);
>  LIBBPF_API int bpf_link__update_program(struct bpf_link *link,
>                                         struct bpf_program *prog);
> @@ -386,6 +410,21 @@ LIBBPF_API void bpf_link__disconnect(struct bpf_link *link);
>  LIBBPF_API int bpf_link__detach(struct bpf_link *link);
>  LIBBPF_API int bpf_link__destroy(struct bpf_link *link);
>
> +/**
> + * @brief **bpf_program__attach()** is a generic function for attaching
> + * a BPF program based on auto-detection of program type, attach type,
> + * and extra parameters, where applicable.
> + *
> + * @param prog BPF program to attach
> + * @return Reference to the newly created BPF link; or NULL is returned on error,
> + * error code is stored in errno
> + *
> + * This is supported for:
> + *   - kprobe/kretprobe
> + *   - tracepoint
> + *   - raw tracepoint
> + *   - tracing programs (typed raw TP/fentry/fexit/fmod_ret)
> + */
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach(const struct bpf_program *prog);
>
> @@ -686,11 +725,36 @@ LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
>  LIBBPF_API int bpf_program__set_sk_lookup(struct bpf_program *prog);
>
>  LIBBPF_API enum bpf_prog_type bpf_program__type(const struct bpf_program *prog);
> +/**
> + * @brief **bpf_program__set_type()** sets the program
> + * type of the passed BPF program.
> + * @param prog BPF program to set the program type for
> + * @param type program type to set the BPF map to have
> + */
>  LIBBPF_API void bpf_program__set_type(struct bpf_program *prog,
>                                       enum bpf_prog_type type);
>
>  LIBBPF_API enum bpf_attach_type
>  bpf_program__expected_attach_type(const struct bpf_program *prog);
> +/**
> + * @brief **bpf_program__set_expected_attach_type()** sets the
> + * attach type of the passed BPF program. This is used for
> + * auto-detection of attachment when programs are loaded.
> + * @param prog BPF program to set the attach type for
> + * @param type attach type to set the BPF map to have
> + *
> + * An example workflow:
> + *
> + * ...
> + *   xdp_fd = bpf_prog_get_fd_by_id(id);
> + *   trace_obj = bpf_object__open_file("func.o", NULL);
> + *   prog = bpf_object__find_program_by_title(trace_obj, "fentry/myfunc");
> + *   bpf_program__set_expected_attach_type(prog, BPF_TRACE_FENTRY);
> + *   bpf_program__set_attach_target(prog, xdp_fd, "xdpfilt_blk_all");
> + *   bpf_object__load(trace_obj);
> + * ...
> + *
> + */
>  LIBBPF_API void
>  bpf_program__set_expected_attach_type(struct bpf_program *prog,
>                                       enum bpf_attach_type type);
> @@ -707,6 +771,26 @@ LIBBPF_API int bpf_program__set_log_level(struct bpf_program *prog, __u32 log_le
>  LIBBPF_API const char *bpf_program__log_buf(const struct bpf_program *prog, size_t *log_size);
>  LIBBPF_API int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log_size);
>
> +/**
> + * @brief **bpf_program__set_attach_target()** sets the
> + * specified BPF program to attach to a specific tracepoint
> + * or kernel function. This can be used to supplement
> + * the BPF program name/section not matching the tracepoint
> + * or function semantics.
> + * @param prog BPF program to set the attach type for
> + * @param type attach type to set the BPF map to have
> + *
> + * An example workflow:
> + *
> + * ...
> + *   xdp_fd = bpf_prog_get_fd_by_id(id);
> + *   trace_obj = bpf_object__open_file("func.o", NULL);
> + *   prog = bpf_object__find_program_by_title(trace_obj, "fentry/myfunc");
> + *   bpf_program__set_expected_attach_type(prog, BPF_TRACE_FENTRY);
> + *   bpf_program__set_attach_target(prog, xdp_fd, "xdpfilt_blk_all");
> + *   bpf_object__load(trace_obj);
> + * ...
> + */
>  LIBBPF_API int
>  bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog_fd,
>                                const char *attach_func_name);
> --
> 2.34.1
>
