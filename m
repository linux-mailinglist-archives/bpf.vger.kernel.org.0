Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D185621197
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 13:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiKHM5a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 07:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbiKHM53 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 07:57:29 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DA538A8;
        Tue,  8 Nov 2022 04:57:27 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l6so13749116pjj.0;
        Tue, 08 Nov 2022 04:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jK/k+PvJZBDci2Shdd1coRTsixX17pb0c3W6QFBlFlc=;
        b=H2FymrAMS/CptRdaD1SpOFkYy0GNWa9ANxhcugFYEwljcTEmiQR9K3YXEOYnyErG3I
         FdVvO7yCbTCXKCDGUHimZ79PAQdsHuNv3f1bZX3sPq8rJeUghMANdTfxqxrXYM1B4r/5
         iFiGdCG8PEk/gRulCKJm3EqX/Lc4b/BVwWXdNuRr3SwZQeVu964qpa1hyQlq+poY0eSC
         /b/HuFkHbNgTRfz8ZJgXI7SdHs4pHmeb3CH8jrSWYEKM9BAx8UWa+VJwz8kL1aAZA7LF
         aoJn9Bs9SEf2/gZSxAplpSNqMG1Gdfauo78W13TkSYzIrWxs0r6hFA0Qvd7MRkNx+8kW
         XQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK/k+PvJZBDci2Shdd1coRTsixX17pb0c3W6QFBlFlc=;
        b=zPvtUKRvntqcDW5J9xfD/+1L2YZK0Jw4HMF59/2IdU75iS7siLzpvaHj9zNePGUD0o
         h/flBl6IXEFPJRwv51V9jL8/cF+WXYq0Sk1xGlzXxwneNwdjt85w5HLYWPxNlP1rVxu0
         ePnp/vUHqtAFSg3qLRMJYBZMtnW8swewj+XBZx1c/t3U9JdzQ5Wg+JSVcNgYa+07S6Kf
         mH0vg8Q4H6zaLU1goHGo2crj3dXswjJvakmdhojfnszuIUjfb4dyhl1oq9slkrl6phjT
         dgyCp4fA+LdX159xFFKfH3QjZhoTukgO5H89krUIuKqzZJH8FMdqQjwL5mGsDUu+5w03
         vroQ==
X-Gm-Message-State: ACrzQf1B4HL9pk2aqjt/p+k7HEVkccC7JgULzgwl1hHT+Vrl6+g+ECjc
        FHHZ9DHm7skwJLODwWOxuWU=
X-Google-Smtp-Source: AMsMyM51/xiSOrtHakzqd3BxJUk/u9hefb132quqaQFcas0/LGZdjZiB+ATeVzcK/Z9a5UPs+uiFTw==
X-Received: by 2002:a17:90b:1806:b0:213:bf67:4d4f with SMTP id lw6-20020a17090b180600b00213bf674d4fmr55125610pjb.30.1667912247151;
        Tue, 08 Nov 2022 04:57:27 -0800 (PST)
Received: from debian.me (subs09a-223-255-225-66.three.co.id. [223.255.225.66])
        by smtp.gmail.com with ESMTPSA id z25-20020aa79499000000b0056ca3569a66sm6290764pfk.129.2022.11.08.04.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 04:57:26 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 46D3C104200; Tue,  8 Nov 2022 19:57:23 +0700 (WIB)
Date:   Tue, 8 Nov 2022 19:57:22 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Yonghong Song <yhs@meta.com>
Subject: Re: [PATCH v3] docs/bpf: Document BPF map types QUEUE and STACK
Message-ID: <Y2pSMo6zKm/JT1ok@debian.me>
References: <20221108093314.44851-1-donald.hunter@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OGTMiW6b9aIbxQ5Q"
Content-Disposition: inline
In-Reply-To: <20221108093314.44851-1-donald.hunter@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--OGTMiW6b9aIbxQ5Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2022 at 09:33:14AM +0000, Donald Hunter wrote:
> diff --git a/Documentation/bpf/map_queue_stack.rst b/Documentation/bpf/ma=
p_queue_stack.rst
> new file mode 100644
> index 000000000000..f20e31a647b9
> --- /dev/null
> +++ b/Documentation/bpf/map_queue_stack.rst
> @@ -0,0 +1,122 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +BPF_MAP_TYPE_QUEUE and BPF_MAP_TYPE_STACK
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. note::
> +   - ``BPF_MAP_TYPE_QUEUE`` and ``BPF_MAP_TYPE_STACK`` were introduced
> +     in kernel version 4.20
> +
> +``BPF_MAP_TYPE_QUEUE`` provides FIFO storage and ``BPF_MAP_TYPE_STACK``
> +provides LIFO storage for BPF programs. These maps support peek, pop and
> +push operations that are exposed to BPF programs through the respective
> +helpers. These operations are exposed to userspace applications using
> +the existing ``bpf`` syscall in the following way:
> +
> +- ``BPF_MAP_LOOKUP_ELEM`` -> peek
> +- ``BPF_MAP_LOOKUP_AND_DELETE_ELEM`` -> pop
> +- ``BPF_MAP_UPDATE_ELEM`` -> push
> +
> +``BPF_MAP_TYPE_QUEUE`` and ``BPF_MAP_TYPE_STACK`` do not support
> +``BPF_F_NO_PREALLOC``.
> +
> +Usage
> +=3D=3D=3D=3D=3D
> +
> +Kernel BPF
> +----------
> +
> +.. c:function::
> +   long bpf_map_push_elem(struct bpf_map *map, const void *value, u64 fl=
ags)
> +
> +An element ``value`` can be added to a queue or stack using the
> +``bpf_map_push_elem`` helper. The ``flags`` parameter must be set to
> +``BPF_ANY`` or ``BPF_EXIST``. If ``flags`` is set to ``BPF_EXIST`` then,
> +when the queue or stack is full, the oldest element will be removed to
> +make room for ``value`` to be added. Returns ``0`` on success, or
> +negative error in case of failure.
> +
> +.. c:function::
> +   long bpf_map_peek_elem(struct bpf_map *map, void *value)
> +
> +This helper fetches an element ``value`` from a queue or stack without
> +removing it. Returns ``0`` on success, or negative error in case of
> +failure.
> +
> +.. c:function::
> +   long bpf_map_pop_elem(struct bpf_map *map, void *value)
> +
> +This helper removes an element into ``value`` from a queue or
> +stack. Returns ``0`` on success, or negative error in case of failure.
> +
> +
> +Userspace
> +---------
> +
> +.. c:function::
> +   int bpf_map_update_elem (int fd, const void *key, const void *value, =
__u64 flags)
> +
> +A userspace program can push ``value`` onto a queue or stack using libbp=
f's
> +``bpf_map_update_elem`` function. The ``key`` parameter must be set to
> +``NULL`` and ``flags`` must be set to ``BPF_ANY`` or ``BPF_EXIST``, with=
 the
> +same semantics as the ``bpf_map_push_elem`` kernel helper. Returns ``0``=
 on
> +success, or negative error in case of failure.
> +
> +.. c:function::
> +   int bpf_map_lookup_elem (int fd, const void *key, void *value)
> +
> +A userspace program can peek at the ``value`` at the head of a queue or =
stack
> +using the libbpf ``bpf_map_lookup_elem`` function. The ``key`` parameter=
 must be
> +set to ``NULL``.  Returns ``0`` on success, or negative error in case of
> +failure.
> +
> +.. c:function::
> +   int bpf_map_lookup_and_delete_elem (int fd, const void *key, void *va=
lue)
> +
> +A userspace program can pop a ``value`` from the head of a queue or stac=
k using
> +the libbpf ``bpf_map_lookup_and_delete_elem`` function. The ``key`` para=
meter
> +must be set to ``NULL``. Returns ``0`` on success, or negative error in =
case of
> +failure.
> +
> +Examples
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Kernel BPF
> +----------
> +
> +This snippet shows how to declare a queue in a BPF program:
> +
> +.. code-block:: c
> +
> +    struct {
> +            __uint(type, BPF_MAP_TYPE_QUEUE);
> +            __type(value, __u32);
> +            __uint(max_entries, 10);
> +    } queue SEC(".maps");
> +
> +
> +Userspace
> +---------
> +
> +This snippet shows how to use libbpf's low-level API to create a queue f=
rom
> +userspace:
> +
> +.. code-block:: c
> +
> +    int create_queue()
> +    {
> +            return bpf_map_create(BPF_MAP_TYPE_QUEUE,
> +                                  "sample_queue", /* name */
> +                                  0,              /* key size, must be z=
ero */
> +                                  sizeof(__u32),  /* value size */
> +                                  10,             /* max entries */
> +                                  NULL);          /* create options */
> +    }
> +
> +
> +References
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +https://lwn.net/ml/netdev/153986858555.9127.14517764371945179514.stgit@k=
ernel/

You forgot to add the documentation to BPF toctree:

---- >8 ----

diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index 1b50de1983ee2c..113872fa0193d7 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -22,6 +22,7 @@ that goes into great technical depth about the BPF Archit=
ecture.
    kfuncs
    programs
    maps
+   map_queue_stack
    bpf_prog_run
    classic_vs_extended.rst
    bpf_licensing

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--OGTMiW6b9aIbxQ5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY2pSKgAKCRD2uYlJVVFO
o5lDAQCoOtDqAKrXnerT9JqiL/RKZRslEHP3xc3xt3CySPQoRwD/S5vPt/tvMuvZ
Kfk55UWF+wB2BaItnuMFyQUUWYXLXgw=
=PRXp
-----END PGP SIGNATURE-----

--OGTMiW6b9aIbxQ5Q--
