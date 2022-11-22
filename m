Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21953633FF8
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 16:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiKVPTR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 10:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiKVPTQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 10:19:16 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932B568C4D;
        Tue, 22 Nov 2022 07:19:15 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id s4so9445057qtx.6;
        Tue, 22 Nov 2022 07:19:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tys9G1OPmD7a0L5wF8kYfN9TBJfE0VRuK4vNYVNnKw4=;
        b=URNIBvVpNkOcdJpv4zMtQ1fLJX6vjDqVCBmIHtWs9VxlpEjDhMYLjF4alkkwWzGKiH
         X0TiteG9XWlztJmFdpYYo72R71PGZeuv6cb8MDxmlJtoZsM0zI9nKIvKvck75JYK+78O
         J6OciytJcxzdJ1I5T8i63u9hTQWWrOcLxGnVXfI6MIGzAmWKLmtWUSepv4u4tAfux8NV
         FXD+L1VK0+1GBx197/1Ij72SLC2zsatZ5CMWQrotue1eVywMF5B1L/+bv3i/tDadiJ4L
         cHkrlsFcBQT/kiZXzcrPzSfe14/BboN+WDzrGLhdgSx8a/S6ybVHRi/nCvC3DXIyHfB2
         TGHw==
X-Gm-Message-State: ANoB5pkL1t4PHi65DHC/SzBieKA6tw+UsM++J3DzEbZK3JCbEISG9bFG
        xKJcIfBVyBkUKW5uUaQZWGpZfP4gnzW+DowJ
X-Google-Smtp-Source: AA0mqf7egWd9HFPFptQ8WEx7h6ob6R3rDMtQAhlD9VO0qmIH16pxjhNIviJF6kJgxzZpy/UnzkoM4Q==
X-Received: by 2002:a05:622a:4891:b0:3a5:280a:3c9c with SMTP id fc17-20020a05622a489100b003a5280a3c9cmr6543385qtb.282.1669130354509;
        Tue, 22 Nov 2022 07:19:14 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:3170])
        by smtp.gmail.com with ESMTPSA id m2-20020ac86882000000b00399ad646794sm8428660qtq.41.2022.11.22.07.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 07:19:14 -0800 (PST)
Date:   Tue, 22 Nov 2022 09:19:19 -0600
From:   David Vernet <void@manifault.com>
To:     mtahhan@redhat.com
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, donhunte@redhat.com, akiyks@gmail.com
Subject: Re: [PATCH bpf-next v1 1/2] docs: fix sphinx warnings for cpumap
Message-ID: <Y3zodzQZDdom0qXf@maniforge.lan>
References: <20221122103738.65980-1-mtahhan@redhat.com>
 <20221122103738.65980-2-mtahhan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122103738.65980-2-mtahhan@redhat.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 22, 2022 at 10:37:37AM +0000, mtahhan@redhat.com wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Sphinx version >=3.3 warns about duplicate function delcarations in the

s/delcarations/declarations

> CPUMAP documentation. This is because the function name is the same for
> Kernel and Userspace BPF progs but the parameters and return types
> they take is what differs. This patch moves from using the ``c:function::``
> directive to using the ``code-block:: c`` directive. The patches also fix
> the indentation for the text associated with the "new" code block delcarations.
> 
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>

LGTM, just left one optionl nit below. Thanks for fixing this up.

Acked-by: David Vernet <void@manifault.com>

> ---
>  Documentation/bpf/map_cpumap.rst | 48 ++++++++++++++++++++------------
>  1 file changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/bpf/map_cpumap.rst b/Documentation/bpf/map_cpumap.rst
> index 61a797a86342..e8d9f7abf26a 100644
> --- a/Documentation/bpf/map_cpumap.rst
> +++ b/Documentation/bpf/map_cpumap.rst
> @@ -30,15 +30,18 @@ Usage
>  
>  Kernel BPF
>  ----------
> -.. c:function::
> +bpf_redirect_map()
> +^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
>       long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
>  
> - Redirect the packet to the endpoint referenced by ``map`` at index ``key``.
> - For ``BPF_MAP_TYPE_CPUMAP`` this map contains references to CPUs.
> +Redirect the packet to the endpoint referenced by ``map`` at index ``key``.
> +For ``BPF_MAP_TYPE_CPUMAP`` this map contains references to CPUs.
>  
> - The lower two bits of ``flags`` are used as the return code if the map lookup
> - fails. This is so that the return value can be one of the XDP program return
> - codes up to ``XDP_TX``, as chosen by the caller.
> +The lower two bits of ``flags`` are used as the return code if the map lookup
> +fails. This is so that the return value can be one of the XDP program return
> +codes up to ``XDP_TX``, as chosen by the caller.
>  
>  Userspace
>  ---------

Feel free to ignore as this isn't really relevant to your change, but
while you're here would you mind please fixing this up as well:

s/Userspace/User space

> @@ -47,12 +50,15 @@ Userspace
>      from an eBPF program. Trying to call these functions from a kernel eBPF
>      program will result in the program failing to load and a verifier warning.
>  
> -.. c:function::
> +bpf_map_update_elem()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
>      int bpf_map_update_elem(int fd, const void *key, const void *value, __u64 flags);
>  
> - CPU entries can be added or updated using the ``bpf_map_update_elem()``
> - helper. This helper replaces existing elements atomically. The ``value`` parameter
> - can be ``struct bpf_cpumap_val``.
> +CPU entries can be added or updated using the ``bpf_map_update_elem()``
> +helper. This helper replaces existing elements atomically. The ``value`` parameter
> +can be ``struct bpf_cpumap_val``.
>  
>   .. code-block:: c
>  
> @@ -64,23 +70,29 @@ Userspace
>          } bpf_prog;
>      };
>  
> - The flags argument can be one of the following:
> +The flags argument can be one of the following:
>    - BPF_ANY: Create a new element or update an existing element.
>    - BPF_NOEXIST: Create a new element only if it did not exist.
>    - BPF_EXIST: Update an existing element.
>  
> -.. c:function::
> +bpf_map_lookup_elem()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
>      int bpf_map_lookup_elem(int fd, const void *key, void *value);
>  
> - CPU entries can be retrieved using the ``bpf_map_lookup_elem()``
> - helper.
> +CPU entries can be retrieved using the ``bpf_map_lookup_elem()``
> +helper.
> +
> +bpf_map_delete_elem()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
>  
> -.. c:function::
>      int bpf_map_delete_elem(int fd, const void *key);
>  
> - CPU entries can be deleted using the ``bpf_map_delete_elem()``
> - helper. This helper will return 0 on success, or negative error in case of
> - failure.
> +CPU entries can be deleted using the ``bpf_map_delete_elem()``
> +helper. This helper will return 0 on success, or negative error in case of
> +failure.
>  
>  Examples
>  ========
> -- 
> 2.34.1
> 
