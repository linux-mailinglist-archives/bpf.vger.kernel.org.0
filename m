Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294F16487FB
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 18:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiLIRw2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 12:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLIRw0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 12:52:26 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C827A192;
        Fri,  9 Dec 2022 09:52:25 -0800 (PST)
Message-ID: <516f48a6-cd8d-4e35-a4e5-69a2c462a7b1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670608344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3B5c2QhyLroQqEO0H48CgkYETxxD9Wcs7Wg5CBjWi3Y=;
        b=IjwYWNoulhpso8JH1yAXCVO4HllZAn018+HGHGoS99W39d2S1Pp/PGlkHAwyeSRPeYftzZ
        krz4eRQ7h7KztZn21kayPpAaaSKISo3F+LW/yPr6K77s4MchSfNt82hZ/gKImieAqMjr4J
        C3d7nm4V7xTc6Qgdo9c2LpQqkOwybos=
Date:   Fri, 9 Dec 2022 09:52:18 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4] docs/bpf: Add documentation for
 BPF_MAP_TYPE_SK_STORAGE
Content-Language: en-US
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Yonghong Song <yhs@meta.com>,
        David Vernet <void@manifault.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221209112401.69319-1-donald.hunter@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221209112401.69319-1-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/9/22 3:24 AM, Donald Hunter wrote:
> Add documentation for the BPF_MAP_TYPE_SK_STORAGE including
> kernel version introduced, usage and examples.

Thanks for writing the doc for sk_storage!

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
> +Socket-local storage for the socket identified by ``key`` belonging to
> +``map_fd`` can be added or updated using the ``bpf_map_update_elem()`` libbpf > +function. ``key`` must be a pointer to a valid ``fd`` in the user space
> +program. The ``flags`` parameter can be used to control the update behaviour:

The "``key`` belonging to ``map_fd``" seems confusing.  Also, it is useful to 
highlight the ``key`` is a _socket_ ``fd``.

May be something like:

A socket-local storage can be added/updated locally to a socket identified by a 
_socket_ ``fd`` stored in the pointer ``key``.  The pointer ``value`` has the 
data to be added/updated to the socket ``fd``.  The type and size of ``value`` 
should be the same as the value type of the map definition.

Feel free to rephrase the above in a better way.

> +
> +- ``BPF_ANY`` will create storage for ``fd`` or update existing storage.
> +- ``BPF_NOEXIST`` will create storage for ``fd`` only if it did not already
> +  exist, otherwise the call will fail with ``-EEXIST``.
> +- ``BPF_EXIST`` will update existing storage for ``fd`` if it already exists,
> +  otherwise the call will fail with ``-ENOENT``.
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
> +Socket-local storage for the socket identified by ``key`` belonging to
> +``map_fd`` can be retrieved using the ``bpf_map_lookup_elem()`` libbpf
> +function. ``key`` must be a pointer to a valid ``fd`` in the user space

Same here.

> +program. Returns ``0`` on success, or negative error in case of failure.
> +
> +bpf_map_delete_elem()
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +.. code-block:: c
> +
> +   int bpf_map_delete_elem(int map_fd, const void *key)
> +
> +Socket-local storage for the socket identified by ``key`` belonging to
> +``map_fd`` can be deleted using the ``bpf_map_delete_elem()`` libbpf
> +function. Returns ``0`` on success, or negative error in case of failure.

Same here.

