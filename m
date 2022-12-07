Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D93B64631A
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 22:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiLGVNQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 16:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLGVNO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 16:13:14 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F412AEE;
        Wed,  7 Dec 2022 13:13:13 -0800 (PST)
Received: by mail-qk1-f171.google.com with SMTP id k3so4547666qki.13;
        Wed, 07 Dec 2022 13:13:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxspKIvwELlYMl5b5/5UA+ETxGu6sHx66bMq1Pow9yE=;
        b=0D/1c6E3KgPGnLmFBCmRlgNneNYg9jFqsXqvlkPlxZzYQTKwV2vAcl3yowekuhk35e
         e7Uo5XVAjhXRj4wGlum8MLPM+NNZGdxySWEPlMmQan3WICwkpd5KYCgYLE/a5zq0ByCf
         fGntnYCS6YrMdPzzJJT1pb6zwzKoTucS0t77IhZVVnSsbNCXAvXurJ4eMiqxkopXW0ok
         ZI9pRWBQ1kItGs0uo9OiSuHxJ1IPOq1MJXeFLtnHledGSiTGLHR42a38+RT9l5CHqlzT
         rkZ0cTEcrfzwxTEDGlDFphvTqeS+2HtolsEyLxa9LHsgNtyb1lMrpxRhwEn1P6//rCip
         cZjQ==
X-Gm-Message-State: ANoB5pl2PCRcbW5ElsonNZmfo/YNyVwMcYZZ+TFTbUovsYrCRHHgQXUr
        RiTeGovTlq2LrrcqzRR0vMM=
X-Google-Smtp-Source: AA0mqf6UBseXI/R7pKABAVtU1SHmUNJnKrf1UrYJl18SGvtxTpwGt6pGAcs2qDxXPvMkUN434LOb0A==
X-Received: by 2002:a37:9181:0:b0:6e9:fd9d:65c5 with SMTP id t123-20020a379181000000b006e9fd9d65c5mr81705677qkd.370.1670447592303;
        Wed, 07 Dec 2022 13:13:12 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:629d])
        by smtp.gmail.com with ESMTPSA id u19-20020a05620a0c5300b006fa84082b6dsm17913501qki.128.2022.12.07.13.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 13:13:11 -0800 (PST)
Date:   Wed, 7 Dec 2022 15:13:08 -0600
From:   David Vernet <void@manifault.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Yonghong Song <yhs@meta.com>
Subject: Re: [PATCH bpf-next v3] docs/bpf: Add documentation for
 BPF_MAP_TYPE_SK_STORAGE
Message-ID: <Y5EB5E5NgtN/ihG/@maniforge.lan>
References: <20221207102721.33378-1-donald.hunter@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207102721.33378-1-donald.hunter@gmail.com>
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

On Wed, Dec 07, 2022 at 10:27:21AM +0000, Donald Hunter wrote:
> Add documentation for the BPF_MAP_TYPE_SK_STORAGE including
> kernel version introduced, usage and examples.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
> v2 -> v3:
> - Fix void * return, reported by Yonghong Song
> - Add tracing programs to API note, reported by Yonghong Song
> v1 -> v2:
> - Fix bpf_sk_storage_* function signatures, reported by Yonghong Song
> - Fix NULL return on failure, reported by Yonghong Song
> 
>  Documentation/bpf/map_sk_storage.rst | 142 +++++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/bpf/map_sk_storage.rst
> 
> diff --git a/Documentation/bpf/map_sk_storage.rst b/Documentation/bpf/map_sk_storage.rst
> new file mode 100644
> index 000000000000..955b287bb7de
> --- /dev/null
> +++ b/Documentation/bpf/map_sk_storage.rst
> @@ -0,0 +1,142 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +=======================
> +BPF_MAP_TYPE_SK_STORAGE
> +=======================
> +
> +.. note::
> +   - ``BPF_MAP_TYPE_SK_STORAGE`` was introduced in kernel version 5.2
> +
> +``BPF_MAP_TYPE_SK_STORAGE`` is used to provide socket-local storage for BPF programs. A map of
> +type ``BPF_MAP_TYPE_SK_STORAGE`` declares the type of storage to be provided and acts as the
> +handle for accessing the socket-local storage from a BPF program. The key type must be ``int``
> +and ``max_entries`` must be set to ``0``.
> +
> +The ``BPF_F_NO_PREALLOC`` must be used when creating a map for socket-local storage. The kernel
> +is responsible for allocating storage for a socket when requested and for freeing the storage
> +when either the map or the socket is deleted.

Hi Donald,

Thanks for writing these excellent docs.

Would you mind please wrapping your text to 80 columns (throughout the
document)? It's not a hard and fast rule, but it would be ideal to keep
text that can wrap without formatting issues to 80 columns. For
documentation where you're e.g. showing a function signature (such as
bpf_sk_storage_get() below), it's fine to exceed it.

> +
> +Usage
> +=====
> +
> +Kernel BPF
> +----------
> +
> +bpf_sk_storage_get()
> +~~~~~~~~~~~~~~~~~~~~
> +
> +.. code-block:: c
> +
> +   void *bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)
> +
> +Socket-local storage can be retrieved using the ``bpf_sk_storage_get()`` helper. The helper gets
> +the storage from ``sk`` that is identified by ``map``.  If the
> +``BPF_LOCAL_STORAGE_GET_F_CREATE`` flag is used then ``bpf_sk_storage_get()`` will create the
> +storage for ``sk`` if it does not already exist. ``value`` can be used together with
> +``BPF_LOCAL_STORAGE_GET_F_CREATE`` to initialize the storage value, otherwise it will be zero
> +initialized. Returns a pointer to the storage on success, or ``NULL`` in case of failure.
> +
> +.. note::
> +   - ``sk`` is a kernel ``struct sock`` pointer for LSM or tracing programs.
> +   - ``sk`` is a ``struct bpf_sock`` pointer for other program types.
> +
> +bpf_sk_storage_delete()
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +.. code-block:: c
> +
> +   long bpf_sk_storage_delete(struct bpf_map *map, void *sk)
> +
> +Socket-local storage can be deleted using the ``bpf_sk_storage_delete()`` helper. The helper
> +deletes the storage from ``sk`` that is identified by ``map``. Returns ``0`` on success, or negative
> +error in case of failure.
> +
> +User space
> +----------
> +
> +bpf_map_update_elem()
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +.. code-block:: c
> +
> +   int bpf_map_update_elem(int map_fd, const void *key, const void *value, __u64 flags)
> +
> +Socket-local storage with type identified by ``map_fd`` for the socket identified by ``key`` can

Could you please clarify what you mean by "with type identified by"?
``map_fd`` just corresponds to the fd of the map, correct? Not following
what's meant by "type".

> +be added or updated using the ``bpf_map_update_elem()`` libbpf function. ``key`` must be a
> +pointer to a valid ``fd`` in the user space program. The ``flags`` parameter can be used to
> +control the update behaviour:
> +
> +- ``BPF_ANY`` will create storage for ``fd`` or update existing storage.
> +- ``BPF_NOEXIST`` will create storage for ``fd`` only if it did not already
> +  exist

I believe that if BPF_NOEXIST is specified, if storage already exists
then in addition to storage not being created, the call will fail with
-EEXIST.

> +- ``BPF_EXIST`` will update existing storage for ``fd``

Can we also mention that if BPF_EXIST is specified, and no element is
present with the specified ``key``, that the call will fail with
-ENOENT?

> +
> +Returns ``0`` on success, or negative error in case of failure.
> +
> +bpf_map_lookup_elem()
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +.. code-block:: c
> +
> +   int bpf_map_lookup_elem(int map_fd, const void *key, void *value)
> +
> +Socket-local storage for the socket identified by ``key`` belonging to ``map_fd`` can be
> +retrieved using the ``bpf_map_lookup_elem()`` libbpf function. ``key`` must be a pointer to a
> +valid ``fd`` in the user space program. Returns ``0`` on success, or negative error in case of
> +failure.
> +
> +bpf_map_delete_elem()
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +.. code-block:: c
> +
> +   int bpf_map_delete_elem (int map_fd, const void *key)

Extra space between _elem and (.

> +
> +Socket-local storage for the socket identified by ``key`` belonging to ``map_fd`` can be deleted
> +using the ``bpf_map_delete_elem()`` libbpf function. Returns ``0`` on success, or negative error
> +in case of failure.
> +
> +Examples
> +========
> +
> +Kernel BPF
> +----------
> +
> +This snippet shows how to declare socket-local storage in a BPF program:
> +
> +.. code-block:: c
> +
> +    struct {
> +            __uint(type, BPF_MAP_TYPE_SK_STORAGE);
> +            __uint(map_flags, BPF_F_NO_PREALLOC);
> +            __type(key, int);
> +            __type(value, struct my_storage);
> +    } socket_storage SEC(".maps");
> +
> +This snippet shows how to retrieve socket-local storage in a BPF program:
> +
> +.. code-block:: c
> +
> +    SEC("sockops")
> +    int _sockops(struct bpf_sock_ops *ctx)
> +    {
> +            struct my_storage *storage;
> +            struct bpf_sock *sk;
> +
> +            sk = ctx->sk;
> +            if (!sk)
> +                    return 1;

Don't feel strongly about this one, but IMO it's nice for examples to
illustrate code that's as close to real and pristine as possible. To
that point, should this example perhaps be updated to return -ENOENT
here, and -ENOMEM below?

> +
> +            storage = bpf_sk_storage_get(&socket_storage, sk, 0,
> +                                         BPF_LOCAL_STORAGE_GET_F_CREATE);
> +            if (!storage)
> +                    return 1;
> +
> +            /* Use 'storage' here */

Let's return 0 at the end to make the example program technically
correct.

> +    }

Thanks,
David
