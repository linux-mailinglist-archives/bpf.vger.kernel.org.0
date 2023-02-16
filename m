Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB91269A21A
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 00:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBPXIS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 18:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBPXIS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 18:08:18 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD73532502
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 15:08:16 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u21so8869466edv.3
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 15:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rc5RxTgVfnfmoR/gtiDaGiQbNFZaPOPQlJwC6Bl5U9g=;
        b=NAU2Vms70sTvSzQAkROim8sfUA2m8vm7WPpSzz7vL07HoY6u07+6bG54en8816FqXG
         ZwwLHn6GtMLpfm+2xahSMWH7UBB074Bk07kO+xISabhQGay/28ogUK2dfpEZvIBX12qR
         lMUyYfy9X86jk3/kJisjJ/ympg/9bGnUerV19FOtADsY06pH0cB/afvdGuVcYLc2gI+N
         Vso7a9dyfC9L5fomNrUXPMLCFPUl4ts6O3XaFy5cUODG0Ajorr+9jwN22hxWmk60QM0s
         0Qtvpmk8vvNd157PRKK7cne/WN5WOe3fQyuBaVVaTf+zMWX2b40MZkEoSBR93PqJy1WZ
         /TrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rc5RxTgVfnfmoR/gtiDaGiQbNFZaPOPQlJwC6Bl5U9g=;
        b=7Z7ZCWYnNpkDxQUe0rli1mUne+/XBJLQVXuxgL6WYJgeEwLMCw5ksvjjR5z+9oT1Sn
         iX2DJo8R1dL6s+nIjBJJeERGAFRLNT98qMTXe7aTLFSB0O2uoj/0PVDdZZUbVVBXs+Lu
         a0k+VJ7RaR3zHWZQK83pyg1sKdaOSi12wif5PbrB/LaOLBcwVBM2PVG2JKbA8WV71goH
         CvlaU36AiTSnWsNadLc4S3rpP9AF0ouKhBuTYNh5xfdABSKSbHUAge9OMd0QaYj+wkaT
         3Xjje81wGMGZ/UYofdr4+kx7qSMWFMI8FGF3YGFnxCdX5SsGk/DfYf5fc6TSw4tQiSO6
         2JNQ==
X-Gm-Message-State: AO0yUKUN0voE39Vntu0GzDf2fZOsWwhDkUV4ugW8cXV4MHDhhKuvj99p
        C9TEigGlyGYy4yCpSq8qwDZZnGenSGDdFurGR6w=
X-Google-Smtp-Source: AK7set8zyRaHDIINll05ocnZj6kg4cyr9MUjcEmDRg1bljB7/twDloduXR+GDHQHIO6JqG+CfaUXp22Mi//QqxAeizg=
X-Received: by 2002:a17:906:9499:b0:8b1:79ef:6923 with SMTP id
 t25-20020a170906949900b008b179ef6923mr816617ejx.15.1676588895143; Thu, 16 Feb
 2023 15:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20230214231221.249277-1-iii@linux.ibm.com> <20230214231221.249277-2-iii@linux.ibm.com>
In-Reply-To: <20230214231221.249277-2-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Feb 2023 15:08:03 -0800
Message-ID: <CAEf4BzZhtgPn795-ExciXvgvhDA5rOhdWtXC7wRX+QT9qVMsdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/8] libbpf: Introduce bpf_{btf,link,map,prog}_get_info_by_fd()
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

On Tue, Feb 14, 2023 at 3:12 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> These are type-safe wrappers around bpf_obj_get_info_by_fd(). They
> found one problem in selftests, and are also useful for adding
> Memory Sanitizer annotations.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/bpf.c      | 24 ++++++++++++++++++++++++
>  tools/lib/bpf/bpf.h      | 13 +++++++++++++
>  tools/lib/bpf/libbpf.map |  5 +++++
>  3 files changed, 42 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 9aff98f42a3d..b562019271fe 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -1044,6 +1044,30 @@ int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len)
>         return libbpf_err_errno(err);
>  }
>
> +int bpf_prog_get_info_by_fd(int prog_fd, struct bpf_prog_info *info,
> +                           __u32 *info_len)
> +{
> +       return bpf_obj_get_info_by_fd(prog_fd, info, info_len);
> +}
> +
> +int bpf_map_get_info_by_fd(int map_fd, struct bpf_map_info *info,
> +                          __u32 *info_len)
> +{
> +       return bpf_obj_get_info_by_fd(map_fd, info, info_len);
> +}
> +
> +int bpf_btf_get_info_by_fd(int btf_fd, struct bpf_btf_info *info,
> +                          __u32 *info_len)
> +{
> +       return bpf_obj_get_info_by_fd(btf_fd, info, info_len);
> +}
> +
> +int bpf_link_get_info_by_fd(int link_fd, struct bpf_link_info *info,
> +                           __u32 *info_len)

fits under 100 characters, please keep on single line

> +{
> +       return bpf_obj_get_info_by_fd(link_fd, info, info_len);
> +}
> +
>  int bpf_raw_tracepoint_open(const char *name, int prog_fd)
>  {
>         const size_t attr_sz = offsetofend(union bpf_attr, raw_tracepoint);
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 7468978d3c27..9f698088c9bc 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -386,6 +386,19 @@ LIBBPF_API int bpf_link_get_fd_by_id(__u32 id);
>  LIBBPF_API int bpf_link_get_fd_by_id_opts(__u32 id,
>                                 const struct bpf_get_fd_by_id_opts *opts);
>  LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len);
> +/* Type-safe variants of bpf_obj_get_info_by_fd(). The callers still needs to
> + * pass info_len, which should normally be
> + * sizeof(struct bpf_{prog,map,btf,link}_info), in order to be compatible with
> + * different libbpf and kernel versions.
> + */

let's add proper doc comments for new APIs, see bpf_map_update_batch
for an example

> +LIBBPF_API int bpf_prog_get_info_by_fd(int prog_fd, struct bpf_prog_info *info,
> +                                      __u32 *info_len);
> +LIBBPF_API int bpf_map_get_info_by_fd(int map_fd, struct bpf_map_info *info,
> +                                     __u32 *info_len);
> +LIBBPF_API int bpf_btf_get_info_by_fd(int btf_fd, struct bpf_btf_info *info,
> +                                     __u32 *info_len);
> +LIBBPF_API int bpf_link_get_info_by_fd(int link_fd, struct bpf_link_info *info,
> +                                      __u32 *info_len);
>

ditto, single lines are the best

>  struct bpf_prog_query_opts {
>         size_t sz; /* size of this struct for forward/backward compatibility */
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 11c36a3c1a9f..50dde1f6521e 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -384,4 +384,9 @@ LIBBPF_1.1.0 {
>  } LIBBPF_1.0.0;
>
>  LIBBPF_1.2.0 {
> +       global:
> +               bpf_btf_get_info_by_fd;
> +               bpf_link_get_info_by_fd;
> +               bpf_map_get_info_by_fd;
> +               bpf_prog_get_info_by_fd;
>  } LIBBPF_1.1.0;
> --
> 2.39.1
>
