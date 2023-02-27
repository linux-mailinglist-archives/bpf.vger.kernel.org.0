Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051746A4D3A
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 22:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjB0Vcw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 16:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjB0Vcv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 16:32:51 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034DB5274
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 13:32:49 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cq23so31679830edb.1
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 13:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=05smJuZBGZGuIiv44WxyABiiIBVDwQchOEte4sinHCY=;
        b=FAs+k8Dr0RPncs7df0X/sMBGOSTgX0ltx/ISwPdJwYarRZOp4wsseRCNbMmilCFElz
         lXydhfqcDJee1/LhkqJOjYlfxYaMKhkxmSwjv9xEhueafX0dxk4nAeejGssp2GlptXmN
         WdQNcUObcSaN/3GyjQK8hYXHEgAY9fqmp1zDvw4ZoouoKS2mPnb7Uj3XrcU9Ax9G4hGL
         XLYiXCOXg9Q9VcylaOhxobqv6z5N/eBw8niC3D4MViKPD4vrkI0W4Z8aqoLF9nyS8Ilo
         6LsO+5wPm+vlBl4FHpIt9T37CG8jMO0+JE7ST5txl+a3OHGV6YmgoPPJ1rDRn982jTvj
         tS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05smJuZBGZGuIiv44WxyABiiIBVDwQchOEte4sinHCY=;
        b=BUwr5g2nOkUp1b7Ctok1HceR3TWjWusZY1Jw6p86tn84m3sQU0kSBm154g2/RgDt/y
         Cnhme4+pp+xc3zXbPKj6/e1qZePSj/qZRqFSPLqH1KoX3RYWSYzyoAxFURj4AyWXx2vk
         5LLvRwNe73fK4kecclYILU6AQZsHZ765ufc05F4NbWO0ZMhg2rc+5VJr1Almn2ORPPSD
         HpDLkmIHNlIIyYfXsL7mYt9OXKYHgEiFGz+Qu4cWSNCtM/dSnravKTXrdE0NIHiOy/b4
         btr/3ZYy1ZEQOWQHW4YHFeQ9In1v78f2lQPG0OyD/62y/yslMYD500o/FGCKf7AmR+Vc
         RkFw==
X-Gm-Message-State: AO0yUKWSCvIaQ5ZKtviq7rRLbylDEiZwy1yJoQf7VulXw3UNh4LBaesG
        B/A9JlKH+X9lTOmKb9LnILJpjvlGdAfB8yW3S5TFNHA1
X-Google-Smtp-Source: AK7set+jB6I55sSJNtXtoQoB+t8C7XwrkAqO1c9nieBcu8GoHf/J4jeG+IXFtoQVseh1X0x8Ym/Eh5dX6BssE7ruB+o=
X-Received: by 2002:a50:d092:0:b0:4ab:4d34:9762 with SMTP id
 v18-20020a50d092000000b004ab4d349762mr542744edd.5.1677533567430; Mon, 27 Feb
 2023 13:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20230220234958.764997-1-iii@linux.ibm.com>
In-Reply-To: <20230220234958.764997-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Feb 2023 13:32:35 -0800
Message-ID: <CAEf4BzZT1WazwB5iJFJ8PDALqKW5uPLYQ6J7YeuNrmuC4YhTeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Document bpf_{btf,link,map,prog}_get_info_by_fd()
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
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

On Mon, Feb 20, 2023 at 3:50 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Replace the short informal description with the proper doc comments.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

Thanks for the follow up! I diff few small adjustments for consistency
(eBPF -> BPF), also updated invalid generic bpf_fd to
{prog,map,btf,link}_fd. Also "BPF BTF" read very awkwardly, so I
called it just "BTF object".

Let me know if you disagree with updates, but otherwise I've pushed
this to bpf-next, thanks.


>  tools/lib/bpf/bpf.h | 67 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 63 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 9ed9bceb4111..e8c5c5832359 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -386,14 +386,73 @@ LIBBPF_API int bpf_link_get_fd_by_id(__u32 id);
>  LIBBPF_API int bpf_link_get_fd_by_id_opts(__u32 id,
>                                 const struct bpf_get_fd_by_id_opts *opts);
>  LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len);
> -/* Type-safe variants of bpf_obj_get_info_by_fd(). The callers still needs to
> - * pass info_len, which should normally be
> - * sizeof(struct bpf_{prog,map,btf,link}_info), in order to be compatible with
> - * different libbpf and kernel versions.
> +
> +/**
> + * @brief **bpf_prog_get_info_by_fd()** obtains information about the eBPF
> + * program corresponding to *bpf_fd*.
> + *
> + * Populates up to *info_len* bytes of *info* and updates *info_len* with the
> + * actual number of bytes written to *info*.
> + *
> + * @param bpf_fd eBPF program file descriptor
> + * @param info pointer to **struct bpf_prog_info** that will be populated with
> + * eBPF program information
> + * @param info_len pointer to the size of *info*; on success updated with the
> + * number of bytes written to *info*
> + * @return 0, on success; negative error code, otherwise (errno is also set to
> + * the error code)
>   */
>  LIBBPF_API int bpf_prog_get_info_by_fd(int prog_fd, struct bpf_prog_info *info, __u32 *info_len);
> +
> +/**
> + * @brief **bpf_map_get_info_by_fd()** obtains information about the eBPF
> + * map corresponding to *bpf_fd*.
> + *
> + * Populates up to *info_len* bytes of *info* and updates *info_len* with the
> + * actual number of bytes written to *info*.
> + *
> + * @param bpf_fd eBPF map file descriptor
> + * @param info pointer to **struct bpf_map_info** that will be populated with
> + * eBPF map information
> + * @param info_len pointer to the size of *info*; on success updated with the
> + * number of bytes written to *info*
> + * @return 0, on success; negative error code, otherwise (errno is also set to
> + * the error code)
> + */
>  LIBBPF_API int bpf_map_get_info_by_fd(int map_fd, struct bpf_map_info *info, __u32 *info_len);
> +
> +/**
> + * @brief **bpf_btf_get_info_by_fd()** obtains information about the eBPF
> + * BTF corresponding to *bpf_fd*.
> + *
> + * Populates up to *info_len* bytes of *info* and updates *info_len* with the
> + * actual number of bytes written to *info*.
> + *
> + * @param bpf_fd eBPF BTF file descriptor
> + * @param info pointer to **struct bpf_btf_info** that will be populated with
> + * eBPF BTF information
> + * @param info_len pointer to the size of *info*; on success updated with the
> + * number of bytes written to *info*
> + * @return 0, on success; negative error code, otherwise (errno is also set to
> + * the error code)
> + */
>  LIBBPF_API int bpf_btf_get_info_by_fd(int btf_fd, struct bpf_btf_info *info, __u32 *info_len);
> +
> +/**
> + * @brief **bpf_btf_get_info_by_fd()** obtains information about the eBPF
> + * link corresponding to *bpf_fd*.
> + *
> + * Populates up to *info_len* bytes of *info* and updates *info_len* with the
> + * actual number of bytes written to *info*.
> + *
> + * @param bpf_fd eBPF link file descriptor
> + * @param info pointer to **struct bpf_link_info** that will be populated with
> + * eBPF link information
> + * @param info_len pointer to the size of *info*; on success updated with the
> + * number of bytes written to *info*
> + * @return 0, on success; negative error code, otherwise (errno is also set to
> + * the error code)
> + */
>  LIBBPF_API int bpf_link_get_info_by_fd(int link_fd, struct bpf_link_info *info, __u32 *info_len);
>
>  struct bpf_prog_query_opts {
> --
> 2.39.1


[...]
