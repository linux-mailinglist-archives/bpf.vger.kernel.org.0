Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F415501D90
	for <lists+bpf@lfdr.de>; Thu, 14 Apr 2022 23:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbiDNVlL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Apr 2022 17:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237289AbiDNVlK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Apr 2022 17:41:10 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88286A406
        for <bpf@vger.kernel.org>; Thu, 14 Apr 2022 14:38:44 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id r7so3912193iln.9
        for <bpf@vger.kernel.org>; Thu, 14 Apr 2022 14:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pSN/tI6inAWyjYd/BH4s05LKeKdnDUgDSyt1Ttlut4A=;
        b=SS+o6h1sI/O2s//6uR2PnPhJ42Dh4pbONQLDdk+bVj8XcPgVBpKKv85Rh09KFyGVPA
         6jreBecWxRTIXfq+/If7kWYuyXh4FuBLaYTpMeFVVmbqY8aMUKIeSnQxA7RhgaxmEsoU
         R5e3qZGxIs0K3NrrRN+NwZUHFUcuYZbL4GC9tvtHVllu7SraGP4miaIyus+WT1eo8RkX
         PYhSAtQUNBo8hzUTYRD6hsZLK9PgRfC/6AqMLMAFEkV5gnYyhzXH0wOv2N6C6md9fL18
         G9S+Lc745dh5QqQ0s2WQLqrqoREKiUMTkNqDNCYQgOsSJlwes6vZ3EHaDFq1lAf6O2QZ
         5RRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pSN/tI6inAWyjYd/BH4s05LKeKdnDUgDSyt1Ttlut4A=;
        b=LLduR4QPk/1gG8SawvBMKp/GSV7m6yFdOnUg+WlWeVJoML4edSn5s062j3RJIoaI4K
         HSsR3z8RUXYLJOV6P3bZpZSDEXLDoT631TTyCmKBRwatQwf/yNV4rC6v75V7bpAuqYhN
         aZUKm3AN94+K1nGfQ7aX3xXSWL51KIc4u2KUGeOGly3Kh51qx8huJznFFr1KfLrcjaOp
         aurS+CtAUZ35xJR5ImaPL8CP5TFdPXE1DxnHsixUVFFm15jVDNYYSSwtZhBPNXeP0iBo
         2vW2GVrIvSMzKLAGuDtePop67d7dhidou95rvZZzB3xN9wHSMi99IFB+YbYVE1tY+GKV
         PjQw==
X-Gm-Message-State: AOAM533/Sws1F41NUySWdFLWK6z1PWVtawkHSd3n4gO3y+8Q6vivFfJk
        4bkVRL9BSVRY2TnzBu+kOd40z03jwmuBshUlq/U=
X-Google-Smtp-Source: ABdhPJwo9SkWEMuSKtMTWZNzSVsHFC2CUDfwnoWVCUmAN/yQ2rfQnQ2Gc4lVORgzdD1mSSAgKeXHdc/jmGCfbJ/pRmM=
X-Received: by 2002:a92:cd8a:0:b0:2ca:9337:2f47 with SMTP id
 r10-20020a92cd8a000000b002ca93372f47mr1661098ilb.252.1649972324312; Thu, 14
 Apr 2022 14:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220414130832.101112-1-grantseltzer@gmail.com>
In-Reply-To: <20220414130832.101112-1-grantseltzer@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 14 Apr 2022 14:38:33 -0700
Message-ID: <CAEf4BzYFP_Cz8A-zPe9+NpT-SSWvyptRZLxMvnXjY-SXXPh0mg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] Add documentation to API functions
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 14, 2022 at 6:08 AM grantseltzer <grantseltzer@gmail.com> wrote:
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

uprobe/uretprobe as well, though depending on specific SEC()
definition (just like for kprobe/kretprobe now).

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

Can you please mention that the type has to be set before BPF object
is loaded, otherwise it has no effect (though it would be good to
change it to return an error, actually, not sure about ABI
implications, though, but I think we did such changes before, so
probably it's fine).

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

same about the note to do it before load phase, and maybe changing
this to return int error

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

same about the load note, but now we actually have int error being
returned (which probably would be good to mention in @return section)?


>  LIBBPF_API int
>  bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog_fd,
>                                const char *attach_func_name);
> --
> 2.34.1
>
