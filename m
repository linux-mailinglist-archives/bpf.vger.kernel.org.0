Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CC356B23A
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 07:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbiGHF0Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 01:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiGHF0Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 01:26:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0348229818
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 22:26:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8AFBB824E8
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 05:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592BEC341C8
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 05:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657257977;
        bh=S9NxylcHhuJSJR7SsFgrhdC1V0oBjrwQuLOxj1jXZHc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MvDugCokwQ9dc6E6ki3RtyPesr4IMTRrjX1KP7RgQPBvrbdRrk6QaBC5ydaHMPUMO
         a6kOaOtkjE8o8YaHvPWkqjaYR18ROScmUnNZIgj+7Fi96LaYKB3v5yL2cFEudRw75n
         BjU18pVNak75vwivQ8FfxP7LttLqLS3EscpZ0hsf0yaRGhe/nqtrb2Aehj7FykiMCq
         SM7Kri+E/O+9ZL4Q7SYDxHsBj/sRX+waK+fl3Xv3syK0h9rXOLOyzOtupMce7wX+5M
         sUIhxdET4zSUggH2yPGZblFXKUD+EQPkeo0t4wEt9RiKOwwJcl1wjyYJqpsXYwh/Rk
         XG+6hj+PNoh8Q==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31c8bb90d09so135262017b3.8
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 22:26:17 -0700 (PDT)
X-Gm-Message-State: AJIora/W9sGUNYz+LayN6vTpIO2DbARJCPaMdU7HvT4q67MknHSFzUY4
        1709yd0cgN5j3LjxE8Eerlq01JJqC0TngCLwf00=
X-Google-Smtp-Source: AGRyM1vFQ7Jdfg8XV+LIsKhuBmslaYIbS21n2PJH0yf0fJ3QVIDW1YGHz3Buo4TBdkAI+GLBa7MoxlQlLqnp+GNTjBA=
X-Received: by 2002:a81:3904:0:b0:310:cc3:15a2 with SMTP id
 g4-20020a813904000000b003100cc315a2mr2058365ywa.447.1657257976391; Thu, 07
 Jul 2022 22:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220707071339.1486742-1-arilou@gmail.com> <20220707071339.1486742-2-arilou@gmail.com>
In-Reply-To: <20220707071339.1486742-2-arilou@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 7 Jul 2022 22:26:05 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7k3ExOjjonL=-=sg_rx0kyrgF=k7jxb+W0ZpxgxnoeLA@mail.gmail.com>
Message-ID: <CAPhsuW7k3ExOjjonL=-=sg_rx0kyrgF=k7jxb+W0ZpxgxnoeLA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] libbpf: perfbuf: allow raw access to buffers
To:     Jon Doron <arilou@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Jon Doron <jond@wiz.io>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 7, 2022 at 12:14 AM Jon Doron <arilou@gmail.com> wrote:

Please prefix the patch with the target tree (bpf or bpf-next). For example,
this patch should go via bpf-next.
>
> From: Jon Doron <jond@wiz.io>
>
> Add API for perfbuf to support writing a custom event reader.

This is too brief for such change. It is ok to duplicate text from the cover
letter.

Please also update libbpf.map.

Also, we should add a selftest to use these new APIs.

>
> Signed-off-by: Jon Doron <jond@wiz.io>
> ---
>  tools/lib/bpf/libbpf.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h |  6 ++++++
>  2 files changed, 46 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e89cc9c885b3..37299aa05185 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -12433,6 +12433,46 @@ static int perf_buffer__process_records(struct perf_buffer *pb,
>         return 0;
>  }
>
> +int perf_buffer__raw_ring_buf(const struct perf_buffer *pb, size_t buf_idx,
> +                             void **base, size_t *buf_size, __u64 *head,
> +                             __u64 *tail)

Please add comments to each API function.
> +{
> +       struct perf_cpu_buf *cpu_buf;
> +       struct perf_event_mmap_page *header;
> +
> +       if (buf_idx >= pb->cpu_cnt)
> +               return libbpf_err(-EINVAL);
> +
> +       cpu_buf = pb->cpu_bufs[buf_idx];
> +       if (!cpu_buf)
> +               return libbpf_err(-ENOENT);
> +
> +       header = cpu_buf->base;
> +       *head = ring_buffer_read_head(header);
> +       *tail = header->data_tail;
> +       *base = ((__u8 *)header) + pb->page_size;
> +       *buf_size = pb->mmap_size;
> +       return 0;
> +}
> +
> +int perf_buffer__set_ring_buf_tail(const struct perf_buffer *pb, size_t buf_idx,
> +                                  __u64 tail)
> +{
> +       struct perf_cpu_buf *cpu_buf;
> +       struct perf_event_mmap_page *header;
> +
> +       if (buf_idx >= pb->cpu_cnt)
> +               return libbpf_err(-EINVAL);
> +
> +       cpu_buf = pb->cpu_bufs[buf_idx];
> +       if (!cpu_buf)
> +               return libbpf_err(-ENOENT);
> +
> +       header = cpu_buf->base;
> +       ring_buffer_write_tail(header, tail);
> +       return 0;
> +}
> +
>  int perf_buffer__epoll_fd(const struct perf_buffer *pb)
>  {
>         return pb->epoll_fd;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 9e9a3fd3edd8..b6f6b6a12d70 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1381,6 +1381,12 @@ LIBBPF_API int perf_buffer__consume(struct perf_buffer *pb);
>  LIBBPF_API int perf_buffer__consume_buffer(struct perf_buffer *pb, size_t buf_idx);
>  LIBBPF_API size_t perf_buffer__buffer_cnt(const struct perf_buffer *pb);
>  LIBBPF_API int perf_buffer__buffer_fd(const struct perf_buffer *pb, size_t buf_idx);
> +LIBBPF_API int perf_buffer__raw_ring_buf(const struct perf_buffer *pb,
> +                                        size_t buf_idx, void **base,
> +                                        size_t *buf_size, __u64 *head,
> +                                        __u64 *tail);
> +LIBBPF_API int perf_buffer__set_ring_buf_tail(const struct perf_buffer *pb,
> +                                             size_t buf_idx, __u64 tail);
>
>  typedef enum bpf_perf_event_ret
>         (*bpf_perf_event_print_t)(struct perf_event_header *hdr,
> --
> 2.36.1
>
