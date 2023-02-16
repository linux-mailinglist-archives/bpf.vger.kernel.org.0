Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC102699FDE
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 23:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBPWtI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 17:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjBPWtG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 17:49:06 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C774E48E18
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 14:49:01 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id d40so8661925eda.8
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 14:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+cPx8kUWw13iqo2D7SZPd/YV+n3wmIiW5YPdGGnBYrc=;
        b=i6OoU3+u/g5kh7FuWqmgQrWVhwc+eqUD2ZRH1Mn2a1ZVt62K+8E0Q8GPUTkoaTzrLQ
         OolzkEn8hjNWd5/WfPAEkp4OUgY3kqaFKSn5MWNx2VwArzdrZ2ymTE4cqypThcsiWwtW
         sZ3NrUaFbjrJupKoZcPIv+0C6Q75Cc/cwdjYB5Qs7/VA4BAnD0BX0inPge8edY/3UI1p
         LUu/QtJpyCq93S3jHiQOtBHtZJkZsSLfwWJF6PZZYdYOUCTE/CvZJW603D1U5Wy6c143
         8BObW7PEpvUNqjOSskIoYVpiRkJ2F/8+1r4yQzJaTTTM0y2aqCDkhNwLIPY98e4p2L2S
         uRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cPx8kUWw13iqo2D7SZPd/YV+n3wmIiW5YPdGGnBYrc=;
        b=itJ7wc/T818ruCj2wkzafUVskFtBsxrEYrI5s7L6EuiXnjJI8UJiDiezpwzVO32ftM
         U7A9t3lg2N7U4edBCKiMuoftNiWKKLYFhKQr2Nohdc2oO/uYNSYfxpYyC8mR0dHXwkuh
         1PfTSNHuKJ5SkcotOUcVn9kGoie7X8MX/xmXLmnftt8vR8w9KtIq0gX0RKZVo5aFsPDM
         Ea0EeciqGirG6rIFBWOv4y1EZjxiSdjQCHPYsOM6eoFJ4nBkvIbNyf+xByeafG+5ue1a
         Qm19QFe3cSMnRpT2M8RE4rKCJT/mZRQC6fB/d4LM3k9QCQxav7kmPturyuge34XdTc2i
         l55A==
X-Gm-Message-State: AO0yUKUGR3pCv2zSzMSGjUQYaabjQl7q3Vy93Z9bVpotIoyILIq3Iu/Y
        aIIhYthr0sWnHUddu+NYxQdwna7q2B23Sh+Zgv/ntNlR
X-Google-Smtp-Source: AK7set/1xgp09KYqjMSo0PQ3jXHX0mcbcP0URCTV56GCodmjtNAjC2JDEP25bKGaX35fw4oiKyvSvKCzDvuTg4886z4=
X-Received: by 2002:a17:906:2455:b0:8b0:7e1d:f6fa with SMTP id
 a21-20020a170906245500b008b07e1df6famr3501378ejb.15.1676587740231; Thu, 16
 Feb 2023 14:49:00 -0800 (PST)
MIME-Version: 1.0
References: <20230214221718.503964-1-kuifeng@meta.com> <20230214221718.503964-7-kuifeng@meta.com>
In-Reply-To: <20230214221718.503964-7-kuifeng@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Feb 2023 14:48:48 -0800
Message-ID: <CAEf4BzaKRd2jif4XeKJ1s8Dfpp-wQyTTbXpF-Not6A5kpOGYqQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] libbpf: Update a bpf_link with another struct_ops.
To:     Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org
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

On Tue, Feb 14, 2023 at 2:17 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
>
> Introduce bpf_link__update_struct_ops(), which will allow you to
> effortlessly transition the struct_ops map of any given bpf_link into
> an alternative.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>  tools/lib/bpf/libbpf.c   | 35 +++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   |  1 +
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 37 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1eff6a03ddd9..6f7c72e312d4 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11524,6 +11524,41 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>         return &link->link;
>  }
>
> +/*
> + * Swap the back struct_ops of a link with a new struct_ops map.
> + */
> +int bpf_link__update_struct_ops(struct bpf_link *link, const struct bpf_map *map)

we have bpf_link__update_program(), and so the generic counterpart for
map-based links would be bpf_link__update_map(). Let's call it that.
And it shouldn't probably assume so much struct_ops specific things.

> +{
> +       struct bpf_link_struct_ops_map *st_ops_link;
> +       int err, fd;
> +
> +       if (!bpf_map__is_struct_ops(map) || map->fd == -1)
> +               return -EINVAL;
> +
> +       /* Ensure the type of a link is correct */
> +       if (link->detach != bpf_link__detach_struct_ops)
> +               return -EINVAL;
> +
> +       err = bpf_map__update_vdata(map);

it's a bit weird we do this at attach time, not when bpf_map is
actually instantiated. Should we move this map contents initialization
to bpf_object__load() phase? Same for bpf_map__attach_struct_ops().
What do we lose by doing it after all the BPF programs are loaded in
load phase?

> +       if (err) {
> +               err = -errno;
> +               free(link);
> +               return err;
> +       }
> +
> +       fd = bpf_link_update(link->fd, map->fd, NULL);
> +       if (fd < 0) {
> +               err = -errno;
> +               free(link);
> +               return err;
> +       }
> +
> +       st_ops_link = container_of(link, struct bpf_link_struct_ops_map, link);
> +       st_ops_link->map_fd = map->fd;
> +
> +       return 0;
> +}
> +
>  typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct perf_event_header *hdr,
>                                                           void *private_data);
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 2efd80f6f7b9..dd25cd6759d4 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -695,6 +695,7 @@ bpf_program__attach_freplace(const struct bpf_program *prog,
>  struct bpf_map;
>
>  LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
> +LIBBPF_API int bpf_link__update_struct_ops(struct bpf_link *link, const struct bpf_map *map);

let's rename to bpf_link__update_map() and put it next to
bpf_link__update_program() in libbpf.h

>
>  struct bpf_iter_attach_opts {
>         size_t sz; /* size of this struct for forward/backward compatibility */
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 11c36a3c1a9f..ca6993c744b6 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -373,6 +373,7 @@ LIBBPF_1.1.0 {
>         global:
>                 bpf_btf_get_fd_by_id_opts;
>                 bpf_link_get_fd_by_id_opts;
> +               bpf_link__update_struct_ops;
>                 bpf_map_get_fd_by_id_opts;
>                 bpf_prog_get_fd_by_id_opts;
>                 user_ring_buffer__discard;

we are in LIBBPF_1.2.0 already, please move


> --
> 2.30.2
>
