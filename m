Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FE3634011
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 16:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiKVPXO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 10:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiKVPXL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 10:23:11 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF9F95B4;
        Tue, 22 Nov 2022 07:23:09 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id x18so10454550qki.4;
        Tue, 22 Nov 2022 07:23:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sef4pigdrAReblc5yItL9CIsDCVPXWPJnoYEB+ZQhKE=;
        b=AbcyFBy8FAXyiNsAg7t2Ki8xYM6aiS80E0uvCLKGEMKAZcI2o2J1stI40ZBanZUHU4
         7xBt12vudRRPyClcAr9sTbGPBxfP2FrBy21upuKiaXgTik3YljyBLn4MxqCYJFSNGXIp
         BMKZTipeEg5wQisyzA4doMo95jxqbjEK/WwVziPZIN+6oH6DvytF9u1DT8Du2BfoeKlL
         Tm8r/RAUa6zreoMcAr3Z2E7m5Bb55bEtcdnpY3H2Y64ppbv3SL0YpmpNy7y3AlUd+EEi
         NLHIo5L7jq9/z0ScpXOMGS6OyaJ5LH1UHqZQyY0rvXxk8kiH6a9/Xtb/JHovQqTAdA9q
         oOhw==
X-Gm-Message-State: ANoB5pkqoZuifYpIZYc8oHYJ7VnQc2uY963SHoiNaA2iO/qHI1xCMAyb
        2egJ8pVqlSNDmN5tyzCAmSQ=
X-Google-Smtp-Source: AA0mqf4xAluZyXoOfuqrVKtkCg2J0hFkWj7pLBbwe3P1f2HYsNHHp18E2dMCHJyIBl0b4yp3E1RLIg==
X-Received: by 2002:ae9:ee1a:0:b0:6fa:3f2c:c654 with SMTP id i26-20020ae9ee1a000000b006fa3f2cc654mr9161932qkg.78.1669130588362;
        Tue, 22 Nov 2022 07:23:08 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:3170])
        by smtp.gmail.com with ESMTPSA id i23-20020ac87657000000b0038d9555b580sm8324707qtr.44.2022.11.22.07.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 07:23:07 -0800 (PST)
Date:   Tue, 22 Nov 2022 09:23:13 -0600
From:   David Vernet <void@manifault.com>
To:     mtahhan@redhat.com
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, donhunte@redhat.com, akiyks@gmail.com
Subject: Re: [PATCH bpf-next v1 2/2] docs: fix sphinx warnings for devmap
Message-ID: <Y3zpYbtdsEeZRWF5@maniforge.lan>
References: <20221122103738.65980-1-mtahhan@redhat.com>
 <20221122103738.65980-3-mtahhan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122103738.65980-3-mtahhan@redhat.com>
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

On Tue, Nov 22, 2022 at 10:37:38AM +0000, mtahhan@redhat.com wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Sphinx version >=3.3 warns about duplicate function delcarations in the

s/delcarations/declarations

> DEVMAP documentation. This is because the function name is the same for
> Kernel and Userspace BPF progs but the parameters and return types
> they take is what differs. This patch moves from using the ``c:function::``
> directive to using the ``code-block:: c`` directive. The patches also fix
> the indentation for the text associated with the "new" code block delcarations.

s/delcarations/declarations

> 
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>

Acked-by: David Vernet <void@manifault.com>


Optionally while you're here as well, thoughout the doc:

s/Userspace/User space

> ---
>  Documentation/bpf/map_devmap.rst | 64 ++++++++++++++++++++------------
>  1 file changed, 40 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/bpf/map_devmap.rst b/Documentation/bpf/map_devmap.rst
> index f64da348dbfe..cdb7c484c425 100644
> --- a/Documentation/bpf/map_devmap.rst
> +++ b/Documentation/bpf/map_devmap.rst
> @@ -29,8 +29,11 @@ Usage
>  =====
>  Kernel BPF
>  ----------
> -.. c:function::
> -     long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
> +bpf_redirect_map()
> +^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
>  
>  Redirect the packet to the endpoint referenced by ``map`` at index ``key``.
>  For ``BPF_MAP_TYPE_DEVMAP`` and ``BPF_MAP_TYPE_DEVMAP_HASH`` this map contains
> @@ -56,7 +59,10 @@ lower bits of the ``flags`` argument if the map lookup fails.
>  
>  More information about redirection can be found :doc:`redirect`
>  
> -.. c:function::
> +bpf_map_lookup_elem()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
>     void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
>  
>  Net device entries can be retrieved using the ``bpf_map_lookup_elem()``
> @@ -69,13 +75,16 @@ Userspace
>      from an eBPF program. Trying to call these functions from a kernel eBPF
>      program will result in the program failing to load and a verifier warning.
>  
> -.. c:function::
> +bpf_map_update_elem()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
>     int bpf_map_update_elem(int fd, const void *key, const void *value, __u64 flags);
>  
> - Net device entries can be added or updated using the ``bpf_map_update_elem()``
> - helper. This helper replaces existing elements atomically. The ``value`` parameter
> - can be ``struct bpf_devmap_val`` or a simple ``int ifindex`` for backwards
> - compatibility.
> +Net device entries can be added or updated using the ``bpf_map_update_elem()``
> +helper. This helper replaces existing elements atomically. The ``value`` parameter
> +can be ``struct bpf_devmap_val`` or a simple ``int ifindex`` for backwards
> +compatibility.
>  
>   .. code-block:: c
>  
> @@ -87,35 +96,42 @@ Userspace
>          } bpf_prog;
>      };
>  
> - The ``flags`` argument can be one of the following:
> -
> +The ``flags`` argument can be one of the following:
>    - ``BPF_ANY``: Create a new element or update an existing element.
>    - ``BPF_NOEXIST``: Create a new element only if it did not exist.
>    - ``BPF_EXIST``: Update an existing element.
>  
> - DEVMAPs can associate a program with a device entry by adding a ``bpf_prog.fd``
> - to ``struct bpf_devmap_val``. Programs are run after ``XDP_REDIRECT`` and have
> - access to both Rx device and Tx device. The  program associated with the ``fd``
> - must have type XDP with expected attach type ``xdp_devmap``.
> - When a program is associated with a device index, the program is run on an
> - ``XDP_REDIRECT`` and before the buffer is added to the per-cpu queue. Examples
> - of how to attach/use xdp_devmap progs can be found in the kernel selftests:
> +DEVMAPs can associate a program with a device entry by adding a ``bpf_prog.fd``
> +to ``struct bpf_devmap_val``. Programs are run after ``XDP_REDIRECT`` and have
> +access to both Rx device and Tx device. The  program associated with the ``fd``
> +must have type XDP with expected attach type ``xdp_devmap``.
> +When a program is associated with a device index, the program is run on an
> +``XDP_REDIRECT`` and before the buffer is added to the per-cpu queue. Examples
> +of how to attach/use xdp_devmap progs can be found in the kernel selftests:
>  
> - - ``tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c``
> - - ``tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c``
> +- ``tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c``
> +- ``tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c``
> +
> +bpf_map_lookup_elem()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
>  
>  .. c:function::
>     int bpf_map_lookup_elem(int fd, const void *key, void *value);
>  
> - Net device entries can be retrieved using the ``bpf_map_lookup_elem()``
> - helper.
> +Net device entries can be retrieved using the ``bpf_map_lookup_elem()``
> +helper.
> +
> +bpf_map_delete_elem()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
>  
>  .. c:function::
>     int bpf_map_delete_elem(int fd, const void *key);
>  
> - Net device entries can be deleted using the ``bpf_map_delete_elem()``
> - helper. This helper will return 0 on success, or negative error in case of
> - failure.
> +Net device entries can be deleted using the ``bpf_map_delete_elem()``
> +helper. This helper will return 0 on success, or negative error in case of
> +failure.
>  
>  Examples
>  ========
> -- 
> 2.34.1
> 
