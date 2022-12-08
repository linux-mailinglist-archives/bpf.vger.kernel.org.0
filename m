Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53560646F43
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 13:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiLHMGa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 07:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiLHMG2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 07:06:28 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F07588B57;
        Thu,  8 Dec 2022 04:06:27 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso857336wmo.1;
        Thu, 08 Dec 2022 04:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xpDU9yx+8MEMdflS6TVE8l/8qDtq/Bs5OoO4TH4Ckk0=;
        b=ACeXfIxk8VzJ1wl4681g/zJMybscbQcyIYrmKaA/vXh91ZVVhHNdKOoCEmhnrtzqYb
         4+cUsxVDZQaN1KGXUDQV20zeG1OZVar/DgaB6TqizRJ8TyymkrsKiwijz6C4wveim/qZ
         0gO9pt+3LRMsyZzoqgkA/TVd87BwlIhU1aAsXVg7qxexczsUB4jVNJOr0sRLMF798GbH
         GP8c2c56zwQcpCu7Fnt6YZEn51OgwHKUPO+oI7p8j25fijmBmlkoTqnNXLaskdpji61o
         TaSRd1LtcA8jxcC0AM4pQTauqPP4heKIHTX4bf5BtW/1z0/Kzf9qDmhWZxR8vTehoVrn
         XW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpDU9yx+8MEMdflS6TVE8l/8qDtq/Bs5OoO4TH4Ckk0=;
        b=NgLU4m88ty6+24bJrwQH+6IPP5crDssERhhicmysQxhs2WWM0Kax3XwUwVqSsuYOGq
         v7wHfHMW2/6tBOp6/xStlLhw+OTMVjcowhilzGI1acFzqmNXyEbnoPFuw71frBXrg5DD
         9VFkU01tvE+PywQ5w7raS3YwBQzgtNAfzQMpL2I6SGJSudy/R2oduRRWAlWDY/BW9sL+
         MZhuYVV21SxrrL4C5Ze/wlzYAQheEQCDvKn6oxD4/6DTY66CzVaushAM77R7lL0s8sw2
         g7Tp5D48InN/8OsmuNf+sy0LmmpBjzSiBPXnvsupXpcNw/+gGeS8dN7D4YbCKRtuoMkW
         py3Q==
X-Gm-Message-State: ANoB5pniIIQGCwYxNlurntzAjpSmnqBQkSqABPjjpFo7apw5mFr0x2za
        VzgCT4/+vfx4M/PvRWsCxIY=
X-Google-Smtp-Source: AA0mqf7R81Sb7JwXeizwlca2O688t7fbWHJKh/no4olRvvvC5aKXDeP5O/c9dqyLR90+TivJNT/uCA==
X-Received: by 2002:a7b:c301:0:b0:3cf:82b9:2fe6 with SMTP id k1-20020a7bc301000000b003cf82b92fe6mr2148808wmj.8.1670501185785;
        Thu, 08 Dec 2022 04:06:25 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:b4fd:1d0f:5a09:5056])
        by smtp.gmail.com with ESMTPSA id f16-20020a05600c4e9000b003c6c182bef9sm6990804wmq.36.2022.12.08.04.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 04:06:25 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Yonghong Song <yhs@meta.com>
Subject: Re: [PATCH bpf-next v3] docs/bpf: Add documentation for
 BPF_MAP_TYPE_SK_STORAGE
In-Reply-To: <Y5EB5E5NgtN/ihG/@maniforge.lan> (David Vernet's message of "Wed,
        7 Dec 2022 15:13:08 -0600")
Date:   Thu, 08 Dec 2022 12:05:58 +0000
Message-ID: <m2r0xagkwp.fsf@gmail.com>
References: <20221207102721.33378-1-donald.hunter@gmail.com>
        <Y5EB5E5NgtN/ihG/@maniforge.lan>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David Vernet <void@manifault.com> writes:

> On Wed, Dec 07, 2022 at 10:27:21AM +0000, Donald Hunter wrote:
>> Add documentation for the BPF_MAP_TYPE_SK_STORAGE including
>> kernel version introduced, usage and examples.
>> 
>> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
>> ---
>> v2 -> v3:
>> - Fix void * return, reported by Yonghong Song
>> - Add tracing programs to API note, reported by Yonghong Song
>> v1 -> v2:
>> - Fix bpf_sk_storage_* function signatures, reported by Yonghong Song
>> - Fix NULL return on failure, reported by Yonghong Song
>> 
>>  Documentation/bpf/map_sk_storage.rst | 142 +++++++++++++++++++++++++++
>>  1 file changed, 142 insertions(+)
>>  create mode 100644 Documentation/bpf/map_sk_storage.rst
>> 
>> diff --git a/Documentation/bpf/map_sk_storage.rst b/Documentation/bpf/map_sk_storage.rst
>> new file mode 100644
>> index 000000000000..955b287bb7de
>> --- /dev/null
>> +++ b/Documentation/bpf/map_sk_storage.rst
>> @@ -0,0 +1,142 @@
>> +.. SPDX-License-Identifier: GPL-2.0-only
>> +.. Copyright (C) 2022 Red Hat, Inc.
>> +
>> +=======================
>> +BPF_MAP_TYPE_SK_STORAGE
>> +=======================
>> +
>> +.. note::
>> +   - ``BPF_MAP_TYPE_SK_STORAGE`` was introduced in kernel version 5.2
>> +
>> +``BPF_MAP_TYPE_SK_STORAGE`` is used to provide socket-local storage for BPF programs. A map of
>> +type ``BPF_MAP_TYPE_SK_STORAGE`` declares the type of storage to be provided and acts as the
>> +handle for accessing the socket-local storage from a BPF program. The key type must be ``int``
>> +and ``max_entries`` must be set to ``0``.
>> +
>> +The ``BPF_F_NO_PREALLOC`` must be used when creating a map for socket-local storage. The kernel
>> +is responsible for allocating storage for a socket when requested and for freeing the storage
>> +when either the map or the socket is deleted.
>
> Hi Donald,
>
> Thanks for writing these excellent docs.
>
> Would you mind please wrapping your text to 80 columns (throughout the
> document)? It's not a hard and fast rule, but it would be ideal to keep
> text that can wrap without formatting issues to 80 columns. For
> documentation where you're e.g. showing a function signature (such as
> bpf_sk_storage_get() below), it's fine to exceed it.

Yes, of course. That was an oversight on my part.

>> +
>> +Usage
>> +=====
>> +
>> +Kernel BPF
>> +----------
>> +
>> +bpf_sk_storage_get()
>> +~~~~~~~~~~~~~~~~~~~~
>> +
>> +.. code-block:: c
>> +
>> +   void *bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)
>> +
>> +Socket-local storage can be retrieved using the ``bpf_sk_storage_get()`` helper. The helper gets
>> +the storage from ``sk`` that is identified by ``map``.  If the
>> +``BPF_LOCAL_STORAGE_GET_F_CREATE`` flag is used then ``bpf_sk_storage_get()`` will create the
>> +storage for ``sk`` if it does not already exist. ``value`` can be used together with
>> +``BPF_LOCAL_STORAGE_GET_F_CREATE`` to initialize the storage value, otherwise it will be zero
>> +initialized. Returns a pointer to the storage on success, or ``NULL`` in case of failure.
>> +
>> +.. note::
>> +   - ``sk`` is a kernel ``struct sock`` pointer for LSM or tracing programs.
>> +   - ``sk`` is a ``struct bpf_sock`` pointer for other program types.
>> +
>> +bpf_sk_storage_delete()
>> +~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +.. code-block:: c
>> +
>> +   long bpf_sk_storage_delete(struct bpf_map *map, void *sk)
>> +
>> +Socket-local storage can be deleted using the ``bpf_sk_storage_delete()`` helper. The helper
>> +deletes the storage from ``sk`` that is identified by ``map``. Returns ``0`` on success, or negative
>> +error in case of failure.
>> +
>> +User space
>> +----------
>> +
>> +bpf_map_update_elem()
>> +~~~~~~~~~~~~~~~~~~~~~
>> +
>> +.. code-block:: c
>> +
>> +   int bpf_map_update_elem(int map_fd, const void *key, const void *value, __u64 flags)
>> +
>> +Socket-local storage with type identified by ``map_fd`` for the socket identified by ``key`` can
>
> Could you please clarify what you mean by "with type identified by"?
> ``map_fd`` just corresponds to the fd of the map, correct? Not following
> what's meant by "type".

A clumsy attempt to say that the map definition declares the type of the
storage that gets added to the socket, as opposed to behaving like a
traditional map. I'll rework this to be more clear.

>> +be added or updated using the ``bpf_map_update_elem()`` libbpf function. ``key`` must be a
>> +pointer to a valid ``fd`` in the user space program. The ``flags`` parameter can be used to
>> +control the update behaviour:
>> +
>> +- ``BPF_ANY`` will create storage for ``fd`` or update existing storage.
>> +- ``BPF_NOEXIST`` will create storage for ``fd`` only if it did not already
>> +  exist
>
> I believe that if BPF_NOEXIST is specified, if storage already exists
> then in addition to storage not being created, the call will fail with
> -EEXIST.

Good point, I'll add this.

>> +- ``BPF_EXIST`` will update existing storage for ``fd``
>
> Can we also mention that if BPF_EXIST is specified, and no element is
> present with the specified ``key``, that the call will fail with
> -ENOENT?

I'll add this too.

>> +
>> +Returns ``0`` on success, or negative error in case of failure.
>> +
>> +bpf_map_lookup_elem()
>> +~~~~~~~~~~~~~~~~~~~~~
>> +
>> +.. code-block:: c
>> +
>> +   int bpf_map_lookup_elem(int map_fd, const void *key, void *value)
>> +
>> +Socket-local storage for the socket identified by ``key`` belonging to ``map_fd`` can be
>> +retrieved using the ``bpf_map_lookup_elem()`` libbpf function. ``key`` must be a pointer to a
>> +valid ``fd`` in the user space program. Returns ``0`` on success, or negative error in case of
>> +failure.
>> +
>> +bpf_map_delete_elem()
>> +~~~~~~~~~~~~~~~~~~~~~
>> +
>> +.. code-block:: c
>> +
>> +   int bpf_map_delete_elem (int map_fd, const void *key)
>
> Extra space between _elem and (.

Good catch, thx.

>> +
>> +Socket-local storage for the socket identified by ``key`` belonging to ``map_fd`` can be deleted
>> +using the ``bpf_map_delete_elem()`` libbpf function. Returns ``0`` on success, or negative error
>> +in case of failure.
>> +
>> +Examples
>> +========
>> +
>> +Kernel BPF
>> +----------
>> +
>> +This snippet shows how to declare socket-local storage in a BPF program:
>> +
>> +.. code-block:: c
>> +
>> +    struct {
>> +            __uint(type, BPF_MAP_TYPE_SK_STORAGE);
>> +            __uint(map_flags, BPF_F_NO_PREALLOC);
>> +            __type(key, int);
>> +            __type(value, struct my_storage);
>> +    } socket_storage SEC(".maps");
>> +
>> +This snippet shows how to retrieve socket-local storage in a BPF program:
>> +
>> +.. code-block:: c
>> +
>> +    SEC("sockops")
>> +    int _sockops(struct bpf_sock_ops *ctx)
>> +    {
>> +            struct my_storage *storage;
>> +            struct bpf_sock *sk;
>> +
>> +            sk = ctx->sk;
>> +            if (!sk)
>> +                    return 1;
>
> Don't feel strongly about this one, but IMO it's nice for examples to
> illustrate code that's as close to real and pristine as possible. To
> that point, should this example perhaps be updated to return -ENOENT
> here, and -ENOMEM below?

Will do.

>> +
>> +            storage = bpf_sk_storage_get(&socket_storage, sk, 0,
>> +                                         BPF_LOCAL_STORAGE_GET_F_CREATE);
>> +            if (!storage)
>> +                    return 1;
>> +
>> +            /* Use 'storage' here */
>
> Let's return 0 at the end to make the example program technically
> correct.

Will do.

>> +    }
>
> Thanks,
> David
