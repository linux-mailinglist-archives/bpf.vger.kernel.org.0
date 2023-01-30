Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A2A6812F1
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 15:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbjA3O0q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 09:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbjA3O01 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 09:26:27 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442B840BEF;
        Mon, 30 Jan 2023 06:25:08 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id y8so12664585vsq.0;
        Mon, 30 Jan 2023 06:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EoK2PPnsf9bafcuD3921ajoctS38QF0C7+TFlgrRio=;
        b=WTiL63muTSPhzf/htiNhZVTeHC9+w4912ydaVgQePyi9kCy2UdVDA/GdAUOD1nM/w0
         9LmbekFlyJcGvaMrjFVew4xbUBe1+zoFk3BW2b3BRAL164HXjWT+59EJmb0KQ9DS1Oti
         4zMJpuaYmAlavZ8RT6pZKT7xvT/cqRVb04pJhLEdDlDf8jvTD2EJUC0B4TbTN8PyZWlA
         EmDKXEhLGMlZG2ab55N7knBcTPGLhZs7jaw+niG1rtqph9pq2yEwAW0Ep9qzgYeX1k/s
         wYxlVjWz+AxCBo/jSiqoXHMs/Atm5HwYhB38UKyCxJm09/zFh1h8y5JnYGFuk22oox6L
         W+xA==
X-Gm-Message-State: AO0yUKUn1U08uMbHDssAZ5erFopc0H4r3VCeVmTjUheZ9Z+DjFZvGpU9
        sq4Nl4Eqb8eLfLbPQ/B8OO+0d2aP2iv0qQ==
X-Google-Smtp-Source: AK7set/+lX1Ckygn7G8bMwSVfHbUm1uNzPTyY/G2PzWCaOMCfyxOEAS9304qsXeB7Qkv2NwshzeuPQ==
X-Received: by 2002:a67:c293:0:b0:3ef:9cd7:eca4 with SMTP id k19-20020a67c293000000b003ef9cd7eca4mr4594028vsj.18.1675088679705;
        Mon, 30 Jan 2023 06:24:39 -0800 (PST)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id m186-20020a37bcc3000000b007068b49b8absm8099922qkf.62.2023.01.30.06.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 06:24:39 -0800 (PST)
Date:   Mon, 30 Jan 2023 08:24:36 -0600
From:   David Vernet <void@manifault.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 04/35] Documentation: bpf: correct spelling
Message-ID: <Y9fTJLNVc5i2/XV5@maniforge>
References: <20230127064005.1558-1-rdunlap@infradead.org>
 <20230127064005.1558-5-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127064005.1558-5-rdunlap@infradead.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 26, 2023 at 10:39:34PM -0800, Randy Dunlap wrote:
> Correct spelling problems for Documentation/bpf/ as reported
> by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: bpf@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/bpf/libbpf/libbpf_naming_convention.rst |    6 +++---
>  Documentation/bpf/map_xskmap.rst                      |    2 +-
>  Documentation/bpf/ringbuf.rst                         |    4 ++--
>  Documentation/bpf/verifier.rst                        |    2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff -- a/Documentation/bpf/libbpf/libbpf_naming_convention.rst b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> --- a/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> +++ b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> @@ -83,8 +83,8 @@ This prevents from accidentally exportin
>  to be a part of ABI what, in turn, improves both libbpf developer- and
>  user-experiences.
>  
> -ABI versionning
> ----------------
> +ABI versioning
> +--------------
>  
>  To make future ABI extensions possible libbpf ABI is versioned.
>  Versioning is implemented by ``libbpf.map`` version script that is
> @@ -148,7 +148,7 @@ API documentation convention
>  The libbpf API is documented via comments above definitions in
>  header files. These comments can be rendered by doxygen and sphinx
>  for well organized html output. This section describes the
> -convention in which these comments should be formated.
> +convention in which these comments should be formatted.
>  
>  Here is an example from btf.h:
>  
> diff -- a/Documentation/bpf/map_xskmap.rst b/Documentation/bpf/map_xskmap.rst
> --- a/Documentation/bpf/map_xskmap.rst
> +++ b/Documentation/bpf/map_xskmap.rst
> @@ -178,7 +178,7 @@ The following code snippet shows how to
>  
>  For an example on how create AF_XDP sockets, please see the AF_XDP-example and
>  AF_XDP-forwarding programs in the `bpf-examples`_ directory in the `libxdp`_ repository.
> -For a detailed explaination of the AF_XDP interface please see:
> +For a detailed explanation of the AF_XDP interface please see:
>  
>  - `libxdp-readme`_.
>  - `AF_XDP`_ kernel documentation.
> diff -- a/Documentation/bpf/ringbuf.rst b/Documentation/bpf/ringbuf.rst
> --- a/Documentation/bpf/ringbuf.rst
> +++ b/Documentation/bpf/ringbuf.rst
> @@ -124,7 +124,7 @@ buffer.  Currently 4 are supported:
>  
>  - ``BPF_RB_AVAIL_DATA`` returns amount of unconsumed data in ring buffer;
>  - ``BPF_RB_RING_SIZE`` returns the size of ring buffer;
> -- ``BPF_RB_CONS_POS``/``BPF_RB_PROD_POS`` returns current logical possition
> +- ``BPF_RB_CONS_POS``/``BPF_RB_PROD_POS`` returns current logical position
>    of consumer/producer, respectively.
>  
>  Returned values are momentarily snapshots of ring buffer state and could be
> @@ -146,7 +146,7 @@ Design and Implementation
>  This reserve/commit schema allows a natural way for multiple producers, either
>  on different CPUs or even on the same CPU/in the same BPF program, to reserve
>  independent records and work with them without blocking other producers. This
> -means that if BPF program was interruped by another BPF program sharing the
> +means that if BPF program was interrupted by another BPF program sharing the

While you're here, could you please also fix this:

s/if BPF program/if a BPF program

>  same ring buffer, they will both get a record reserved (provided there is
>  enough space left) and can work with it and submit it independently. This
>  applies to NMI context as well, except that due to using a spinlock during
> diff -- a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifier.rst
> --- a/Documentation/bpf/verifier.rst
> +++ b/Documentation/bpf/verifier.rst
> @@ -192,7 +192,7 @@ checked and found to be non-NULL, all co
>  As well as range-checking, the tracked information is also used for enforcing
>  alignment of pointer accesses.  For instance, on most systems the packet pointer
>  is 2 bytes after a 4-byte alignment.  If a program adds 14 bytes to that to jump
> -over the Ethernet header, then reads IHL and addes (IHL * 4), the resulting
> +over the Ethernet header, then reads IHL and adds (IHL * 4), the resulting
>  pointer will have a variable offset known to be 4n+2 for some n, so adding the 2
>  bytes (NET_IP_ALIGN) gives a 4-byte alignment and so word-sized accesses through
>  that pointer are safe.

Otherwise, LGTM. I'll wait to add stamp until the v2 sent to bpf-next
instead of bpf.
