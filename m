Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B176463D9
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 23:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiLGWGA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 17:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiLGWFa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 17:05:30 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2802FDE81;
        Wed,  7 Dec 2022 14:05:04 -0800 (PST)
Received: by mail-qk1-f174.google.com with SMTP id x18so11024131qki.4;
        Wed, 07 Dec 2022 14:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gI+yHmsKWDV9rDnDoEVF7JHAoXUt+16u+BnTF0vBdnE=;
        b=ar4zj5H8Zd7aRHGJq+9sgGqWwhSmciLpya0NhJ/BmE8Psrp7lyHdj7+Bmezw4a+b90
         ezoFwqATvk7Rmloxo0RVT3iaLfeC4LkrbhYTkXQ8n+snacXV0w/Q0PQWmHXtvdtqHjZC
         Vi9auiWggFHs1Ri2CJMOVxAqZqU66Va1aIKTicE1oNesiEg0wENKAs5e8a8oB60hj5HL
         Y4o6auto4mYy+JvnyXL+WsX/G+nrn+nbnkoB0dYN29PXosfXkoIrBZX8Nn2ysuEExrOo
         g8giC4eOBjP6hWoSVZ2SpTL0Z9NwbkCeTw7tNP05swcItOd3kfJXGwhlxIBM3rri4+A7
         adsg==
X-Gm-Message-State: ANoB5pkg3RdznWW6USketlW1Z8Gy29nSjLXRn06rVAVtZ0Oe4EK3VMN7
        O35xkDQRnwEBf4ASzYUpEYI=
X-Google-Smtp-Source: AA0mqf4wtgNYEt8sOnBeI5GbBXrjj3tXgfr3yoUlv7MDAo75tTRhdG2iByWHaVmaWvbRqb1339vVuA==
X-Received: by 2002:a05:620a:159c:b0:6fe:efbe:7b9d with SMTP id d28-20020a05620a159c00b006feefbe7b9dmr2339284qkk.133.1670450702848;
        Wed, 07 Dec 2022 14:05:02 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:629d])
        by smtp.gmail.com with ESMTPSA id dt2-20020a05620a478200b006fbf88667bcsm8554839qkb.77.2022.12.07.14.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:05:02 -0800 (PST)
Date:   Wed, 7 Dec 2022 16:04:59 -0600
From:   David Vernet <void@manifault.com>
To:     mtahhan@redhat.com
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, donhunte@redhat.com, john.fastabend@gmail.com,
        bagasdotme@gmail.com
Subject: Re: [PATCH bpf-next v3 1/1] docs: BPF_MAP_TYPE_SOCK[MAP|HASH]
Message-ID: <Y5EOC7HjtaRFAVfq@maniforge.lan>
References: <20221202114010.22477-1-mtahhan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202114010.22477-1-mtahhan@redhat.com>
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

On Fri, Dec 02, 2022 at 11:40:10AM +0000, mtahhan@redhat.com wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Add documentation for BPF_MAP_TYPE_SOCK[MAP|HASH]
> including kernel versions introduced, usage
> and examples.
> 
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>

Hi Maryam,

Thanks a lot for adding these extensive docs. Overall this is looking
great, but I think readers who aren't yet familiar with these concepts
(and are here to try to better understand them) are potentially going to
struggle a bit to understand some of this without adding a bit more
explanation to a few things.

See suggestions below.

> ---
> v3:
> - Call out that the user attaches the BPF programs to
>   the sock[map|hash] maps explicitly.
> - Rephrase the note that references the TCP and UDP
>   functions that get replaced.
> - Update simple example to attach verdict and parser
>   progs to a map.
> 
> v2:
> - Fixed typos and user space references to BPF helpers.
> - Added update, lookup and delete BPF helpers.
> ---
> ---
>  Documentation/bpf/map_sockmap.rst | 493 ++++++++++++++++++++++++++++++
>  1 file changed, 493 insertions(+)
>  create mode 100644 Documentation/bpf/map_sockmap.rst
> 
> diff --git a/Documentation/bpf/map_sockmap.rst b/Documentation/bpf/map_sockmap.rst
> new file mode 100644
> index 000000000000..e2ef3054fe09
> --- /dev/null
> +++ b/Documentation/bpf/map_sockmap.rst
> @@ -0,0 +1,493 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright Red Hat
> +
> +==============================================
> +BPF_MAP_TYPE_SOCKMAP and BPF_MAP_TYPE_SOCKHASH
> +==============================================
> +
> +.. note::
> +   - ``BPF_MAP_TYPE_SOCKMAP`` was introduced in kernel version 4.14
> +   - ``BPF_MAP_TYPE_SOCKHASH`` was introduced in kernel version 4.18
> +
> +``BPF_MAP_TYPE_SOCKMAP`` is backed by an array that uses an integer key as the
> +index to lookup a reference to a sock struct. The map values are sockets.
> +Similarly, ``BPF_MAP_TYPE_SOCKHASH`` is a hash backed BPF map that holds
> +references to sockets.

I think it may confuse / throw some readers off for their first
introduction to BPF_MAP_TYPE_SOCKMAP to be an implementation detail.
Can you "introduce" the map type by first explaining what it's used for
at a high level, and only _then_ going into more detail as to how it's
implemented? Consider the fact that someone trying to use
BPF_MAP_TYPE_SOCKMAP doesn't really need to know the fact that it's
backed by an array.

> +
> +.. note::
> +    - The value type must be __u32 or __u64.
> +    - The value type of __u64 is to support socket cookies.

I think this may also confuse some readers. Above you say that the
"value" is a socket, but here you're saying that its value type is __u32
or __u64. IMO describing the connection between the two would be useful.

> +
> +When a user creates these types of maps, they typically attach BPF programs to
> +them. The allowed programs are:
> +
> +.. code-block:: c
> +
> +	struct sk_psock_progs {
> +		struct bpf_prog *msg_parser;
> +		struct bpf_prog *stream_parser;
> +		struct bpf_prog *stream_verdict;
> +		struct bpf_prog	*skb_verdict;
> +	};
> +
> +.. note::
> +    Users are not allowed to attach ``stream_verdict`` and ``skb_verdict``
> +    programs to the same map.

I think this note should maybe be moved a bit lower down in the doc. We
have to explain what these prog types are before we start to tell
readers how they're not allowed to use them.

> +
> +The parser programs determine how much data needs to be queued to come to a
> +verdict. The verdict programs return a verdict ``__SK_DROP``, ``__SK_PASS``, or
> +``__SK_REDIRECT``.

Can you provide a slightly higher level overview of parser programs and
verdicts? This would include defining "parser" and "verdict", and
explaining their purposes in the larger skb-processing pipeline. No need
to go too crazy here, but I think that at least giving a high level
overview in a few sentences would go a long way.

> +
> +The attach types for the map programs are:
> +
> +- ``msg_parser`` program - ``BPF_SK_MSG_VERDICT``.
> +- ``stream_parser`` program - ``BPF_SK_SKB_STREAM_PARSER``.
> +- ``stream_verdict`` program - ``BPF_SK_SKB_STREAM_VERDICT``.
> +- ``skb_verdict`` program - ``BPF_SK_SKB_VERDICT``.
> +
> +These maps can be used to redirect skbs between sockets or to apply policy at
> +the socket level based on the result of a verdict program with the help of the
> +BPF helpers ``bpf_sk_redirect_map()``, ``bpf_sk_redirect_hash()``,
> +``bpf_msg_redirect_map()`` and ``bpf_msg_redirect_hash()``.

Can you add a short sentence informing readers that these helpers (and
the ones below) are described in more details below?

> +
> +When a socket is inserted into one of these maps, its socket callbacks are
> +replaced and a ``struct sk_psock`` is attached to it. Additionally, this
> +``sk_psock`` inherits the programs that are attached to the map.
> +
> +.. note::
> +	For more details of the socket callbacks that get replaced please see
> +	``net/ipv4/tcp_bpf.c`` and ``net/ipv4/udp_bpf.c`` for TCP and UDP
> +	functions, respectively.
> +
> +There are additional helpers available to use with the parser and verdict
> +programs: ``bpf_msg_apply_bytes()`` and ``bpf_msg_cork_bytes()``. With
> +``bpf_msg_apply_bytes()`` BPF programs can tell the infrastructure how many
> +bytes the given verdict should apply to. The helper ``bpf_msg_cork_bytes()``
> +handles a different case where a BPF program can not reach a verdict on a msg
> +until it receives more bytes AND the program doesn't want to forward the packet
> +until it is known to be good.
> +
> +Finally, the helpers ``bpf_msg_pull_data()`` and ``bpf_msg_push_data()`` are
> +available to ``BPF_PROG_TYPE_SK_MSG`` BPF programs to pull in data and set the
> +start and end pointer to given values or to add metadata to the ``struct
> +sk_msg_buff *msg``.
> +
> +Usage
> +=====
> +Kernel BPF
> +----------
> +bpf_msg_redirect_map()
> +^^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +	long bpf_msg_redirect_map(struct sk_msg_buff *msg, struct bpf_map *map, u32 key, u64 flags)
> +
> +This helper is used in programs implementing policies at the socket level. If
> +the message ``msg`` is allowed to pass (i.e. if the verdict BPF program
> +returns ``SK_PASS``), redirect it to the socket referenced by ``map`` (of type
> +``BPF_MAP_TYPE_SOCKMAP``) at index ``key``. Both ingress and egress interfaces
> +can be used for redirection. The ``BPF_F_INGRESS`` value in ``flags`` is used
> +to select the ingress path otherwise the egress path is selected. This is the
> +only flag supported for now.
> +
> +Returns ``SK_PASS`` on success, or ``SK_DROP`` on error.
> +
> +bpf_sk_redirect_map()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    long bpf_sk_redirect_map(struct sk_buff *skb, struct bpf_map *map, u32 key u64 flags)
> +
> +Redirect the packet to the socket referenced by ``map`` (of type
> +``BPF_MAP_TYPE_SOCKMAP``) at index ``key``. Both ingress and egress interfaces
> +can be used for redirection. The ``BPF_F_INGRESS`` value in ``flags`` is used
> +to select the ingress path otherwise the egress path is selected. This is the
> +only flag supported for now.
> +
> +Returns ``SK_PASS`` on success, or ``SK_DROP`` on error.
> +
> +bpf_map_lookup_elem()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> +
> +socket entries of type ``struct sock *`` can be retrieved using the
> +``bpf_map_lookup_elem()`` helper.
> +
> +bpf_sock_map_update()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    long bpf_sock_map_update(struct bpf_sock_ops *skops, struct bpf_map *map, void *key, u64 flags)
> +
> +Add an entry to, or update a ``map`` referencing sockets. The ``skops`` is used
> +as a new value for the entry associated to ``key``. The ``flags`` argument can
> +be one of the following:
> +
> +- ``BPF_ANY``: Create a new element or update an existing element.
> +- ``BPF_NOEXIST``: Create a new element only if it did not exist.
> +- ``BPF_EXIST``: Update an existing element.
> +
> +If the ``map`` has BPF programs (parser and verdict), those will be inherited
> +by the socket being added. If the socket is already attached to BPF programs,
> +this results in an error.
> +
> +Returns 0 on success, or a negative error in case of failure.
> +
> +bpf_sock_hash_update()
> +^^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    long bpf_sock_hash_update(struct bpf_sock_ops *skops, struct bpf_map *map, void *key, u64 flags)
> +
> +Add an entry to, or update a sockhash ``map`` referencing sockets. The ``skops``
> +is used as a new value for the entry associated to ``key``.
> +
> +The ``flags`` argument can be one of the following:
> +
> +- ``BPF_ANY``: Create a new element or update an existing element.
> +- ``BPF_NOEXIST``: Create a new element only if it did not exist.
> +- ``BPF_EXIST``: Update an existing element.
> +
> +If the ``map`` has BPF programs (parser and verdict), those will be inherited
> +by the socket being added. If the socket is already attached to BPF programs,
> +this results in an error.
> +
> +Returns 0 on success, or a negative error in case of failure.
> +
> +bpf_msg_redirect_hash()
> +^^^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    long bpf_msg_redirect_hash(struct sk_msg_buff *msg, struct bpf_map *map, void *key, u64 flags)
> +
> +This helper is used in programs implementing policies at the socket level. If
> +the message ``msg`` is allowed to pass (i.e. if the verdict BPF program returns
> +``SK_PASS``), redirect it to the socket referenced by ``map`` (of type
> +``BPF_MAP_TYPE_SOCKHASH``) using hash ``key``. Both ingress and egress
> +interfaces can be used for redirection. The ``BPF_F_INGRESS`` value in
> +``flags`` is used to select the ingress path otherwise the egress path is
> +selected. This is the only flag supported for now.
> +
> +Returns ``SK_PASS`` on success, or ``SK_DROP`` on error.
> +
> +bpf_sk_redirect_hash()
> +^^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    long bpf_sk_redirect_hash(struct sk_buff *skb, struct bpf_map *map, void *key, u64 flags)
> +
> +This helper is used in programs implementing policies at the skb socket level.
> +If the sk_buff ``skb`` is allowed to pass (i.e. if the verdict BPF program
> +returns ``SK_PASS``), redirect it to the socket referenced by ``map`` (of type
> +``BPF_MAP_TYPE_SOCKHASH``) using hash ``key``. Both ingress and egress
> +interfaces can be used for redirection. The ``BPF_F_INGRESS`` value in
> +``flags`` is used to select the ingress path otherwise the egress path is
> +selected. This is the only flag supported for now.
> +
> +Returns ``SK_PASS`` on success, or ``SK_DROP`` on error.
> +
> +bpf_msg_apply_bytes()
> +^^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    long bpf_msg_apply_bytes(struct sk_msg_buff *msg, u32 bytes)
> +
> +For socket policies, apply the verdict of the BPF program to the next (number
> +of ``bytes``) of message ``msg``. For example, this helper can be used in the
> +following cases:
> +
> +- A single ``sendmsg()`` or ``sendfile()`` system call contains multiple
> +  logical messages that the BPF program is supposed to read and for which it
> +  should apply a verdict.
> +- A BPF program only cares to read the first ``bytes`` of a ``msg``. If the
> +  message has a large payload, then setting up and calling the BPF program
> +  repeatedly for all bytes, even though the verdict is already known, would
> +  create unnecessary overhead.
> +
> +Returns 0
> +
> +bpf_msg_cork_bytes()
> +^^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    long bpf_msg_cork_bytes(struct sk_msg_buff *msg, u32 bytes)
> +
> +For socket policies, prevent the execution of the verdict BPF program for
> +message ``msg`` until the number of ``bytes`` have been accumulated.
> +
> +This can be used when one needs a specific number of bytes before a verdict can
> +be assigned, even if the data spans multiple ``sendmsg()`` or ``sendfile()``
> +calls.
> +
> +Returns 0
> +
> +bpf_msg_pull_data()
> +^^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    long bpf_msg_pull_data(struct sk_msg_buff *msg, u32 start, u32 end, u64 flags)
> +
> +For socket policies, pull in non-linear data from user space for ``msg`` and set
> +pointers ``msg->data`` and ``msg->data_end`` to ``start`` and ``end`` bytes
> +offsets into ``msg``, respectively.
> +
> +If a program of type ``BPF_PROG_TYPE_SK_MSG`` is run on a ``msg`` it can only
> +parse data that the (``data``, ``data_end``) pointers have already consumed.
> +For ``sendmsg()`` hooks this is likely the first scatterlist element. But for
> +calls relying on the ``sendpage`` handler (e.g. ``sendfile()``) this will be
> +the range (**0**, **0**) because the data is shared with user space and by
> +default the objective is to avoid allowing user space to modify data while (or
> +after) BPF verdict is being decided. This helper can be used to pull in data

s/BPF verdict/a BPF verdict

> +and to set the start and end pointer to given values. Data will be copied if
> +necessary (i.e. if data was not linear and if start and end pointers do not
> +point to the same chunk).

If the scenario in parens is just one of several possible examples of
when the data will be copied, I think "e.g." is correct rather than
"i.e.".

> +
> +A call to this helper is susceptible to change the underlying packet buffer.
> +Therefore, at load time, all checks on pointers previously done by the verifier
> +are invalidated and must be performed again, if the helper is used in
> +combination with direct packet access.
> +
> +All values for ``flags`` are reserved for future usage, and must be left at
> +zero.
> +
> +Returns 0 on success, or a negative error in case of failure.
> +
> +bpf_map_lookup_elem()
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +.. code-block:: c
> +
> +	void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> +
> +Lookup a socket entry in the sockmap or sockhash map.
> +
> +Returns the socket entry associated to ``key``, or NULL if no entry was found.
> +
> +bpf_map_update_elem()
> +^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +	long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
> +
> +Add or update a socket entry in a sockmap or sockhash.
> +
> +The flags argument can be one of the following:
> +
> +- BPF_ANY: Create a new element or update an existing element.
> +- BPF_NOEXIST: Create a new element only if it did not exist.
> +- BPF_EXIST: Update an existing element.
> +
> +Returns 0 on success, or a negative error in case of failure.
> +
> +bpf_map_delete_elem()
> +^^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    long bpf_map_delete_elem(struct bpf_map *map, const void *key)
> +
> +Delete a socket entry from a sockmap or a sockhash.
> +
> +Returns	0 on success, or a negative error in case of failure.

Can you make this tab a space to make it uniform with the rest of the
doc?

Otherwise everything looks great. Thanks again for writing these docs.

- David
