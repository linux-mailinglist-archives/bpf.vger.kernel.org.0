Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97C648802
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 18:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLIRyp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 12:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLIRyn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 12:54:43 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745CB2408B;
        Fri,  9 Dec 2022 09:54:42 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id b2so13225808eja.7;
        Fri, 09 Dec 2022 09:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/5OqLJVpUfa9l/PfdK7S0ZsZO4IY8EwmerqpsVqUt8I=;
        b=jSk3RmWXVhd9IO0D6o2GznA9f8BwyAnOIOcZDmEnCcnRUbVtzGq8l9m84dwEnnMre3
         sof6m2FD4JytbK6ijbUr63US7yZnmGGe1CCiPWpvlfRbvrBSkk55AtL4P94OnnUxsBxI
         JsjAK3N/Mis7oXe5GHnZIhaO9RHdMsaMm1Ha5XBCXbvcbNhzq+baPnp4hvklRDveSiuy
         P7NWcKVgaALRm5VtKZuy3xPB0AyiReZCnxf4q4TEIEzO2Ag7UcbvO20awciJRn73f8FZ
         nE6ntvKaxOTDgJooLdYZSCSFZHzuDXMNNLjrCsoSVjsQ/b7VnqhIfFiqaprT6xpZWSA2
         yjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5OqLJVpUfa9l/PfdK7S0ZsZO4IY8EwmerqpsVqUt8I=;
        b=RXSAvze8aiahxF9vo4NfeCj385UHvHkMi6zNE+Pp7x7oY6+t0nMEbSVv9Kgl0N/MB5
         +XL5Awz0+E/4q3HfBkLhDSk7TsWuBeUg5F5UEIxOmRRyUxJ/SVQdwhyQf8sskxVqaZcc
         +dOaJIID21/aQqJ2BHsFde37Sd47GtkwMAA9RPpmtjSam4B+EKQXDHWZ5NzpXhdKzTTk
         w8LBhe8QtYPs/BO2rM7T76wmQSblzo/o5L3Jyjs0yDpB4v961WGFgGviL/pM3bvL3Tx/
         73DUSEE35vg9CjQTFOyLyd4j7BQ1ZxJgY2s8nGKckgLS6jv3IJWsKYlGQnSYB44tvSTH
         gVzw==
X-Gm-Message-State: ANoB5pmg644xS8y3lRx9ir3JlYf4RRlx4sQ+hw5m9kkE9OGbLSyRF1xo
        VWLhet+xhkNQqa8hUWPcRD3otzhJFvZP0OQ+vnU=
X-Google-Smtp-Source: AA0mqf4hcUXgD5PzzizuG4RJ0uFtfIRs1FHFPP2rHnWJSETSuhp1sPskqumedMHRMWc02ZCGy47uRSoMQ+0Gv2i+Du0=
X-Received: by 2002:a17:906:2ac3:b0:7ad:f2f9:2b49 with SMTP id
 m3-20020a1709062ac300b007adf2f92b49mr65448075eje.94.1670608480888; Fri, 09
 Dec 2022 09:54:40 -0800 (PST)
MIME-Version: 1.0
References: <20221209112401.69319-1-donald.hunter@gmail.com> <516f48a6-cd8d-4e35-a4e5-69a2c462a7b1@linux.dev>
In-Reply-To: <516f48a6-cd8d-4e35-a4e5-69a2c462a7b1@linux.dev>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 9 Dec 2022 09:54:29 -0800
Message-ID: <CAADnVQ+E-fONc6BhT_HxErG43tHu32KE5uWtJTXu95HFb8EvLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] docs/bpf: Add documentation for BPF_MAP_TYPE_SK_STORAGE
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Donald Hunter <donald.hunter@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Yonghong Song <yhs@meta.com>,
        David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
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

On Fri, Dec 9, 2022 at 9:52 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 12/9/22 3:24 AM, Donald Hunter wrote:
> > Add documentation for the BPF_MAP_TYPE_SK_STORAGE including
> > kernel version introduced, usage and examples.
>
> Thanks for writing the doc for sk_storage!
>
> > +User space
> > +----------
> > +
> > +bpf_map_update_elem()
> > +~~~~~~~~~~~~~~~~~~~~~
> > +
> > +.. code-block:: c
> > +
> > +   int bpf_map_update_elem(int map_fd, const void *key, const void *value, __u64 flags)
> > +
> > +Socket-local storage for the socket identified by ``key`` belonging to
> > +``map_fd`` can be added or updated using the ``bpf_map_update_elem()`` libbpf > +function. ``key`` must be a pointer to a valid ``fd`` in the user space
> > +program. The ``flags`` parameter can be used to control the update behaviour:
>
> The "``key`` belonging to ``map_fd``" seems confusing.  Also, it is useful to
> highlight the ``key`` is a _socket_ ``fd``.
>
> May be something like:
>
> A socket-local storage can be added/updated locally to a socket identified by a
> _socket_ ``fd`` stored in the pointer ``key``.  The pointer ``value`` has the
> data to be added/updated to the socket ``fd``.  The type and size of ``value``
> should be the same as the value type of the map definition.
>
> Feel free to rephrase the above in a better way.
>
> > +
> > +- ``BPF_ANY`` will create storage for ``fd`` or update existing storage.
> > +- ``BPF_NOEXIST`` will create storage for ``fd`` only if it did not already
> > +  exist, otherwise the call will fail with ``-EEXIST``.
> > +- ``BPF_EXIST`` will update existing storage for ``fd`` if it already exists,
> > +  otherwise the call will fail with ``-ENOENT``.
> > +
> > +Returns ``0`` on success, or negative error in case of failure.
> > +
> > +bpf_map_lookup_elem()
> > +~~~~~~~~~~~~~~~~~~~~~
> > +
> > +.. code-block:: c
> > +
> > +   int bpf_map_lookup_elem(int map_fd, const void *key, void *value)
> > +
> > +Socket-local storage for the socket identified by ``key`` belonging to
> > +``map_fd`` can be retrieved using the ``bpf_map_lookup_elem()`` libbpf
> > +function. ``key`` must be a pointer to a valid ``fd`` in the user space
>
> Same here.
>
> > +program. Returns ``0`` on success, or negative error in case of failure.
> > +
> > +bpf_map_delete_elem()
> > +~~~~~~~~~~~~~~~~~~~~~
> > +
> > +.. code-block:: c
> > +
> > +   int bpf_map_delete_elem(int map_fd, const void *key)
> > +
> > +Socket-local storage for the socket identified by ``key`` belonging to
> > +``map_fd`` can be deleted using the ``bpf_map_delete_elem()`` libbpf
> > +function. Returns ``0`` on success, or negative error in case of failure.
>
> Same here.


Sorry Martin. I just applied it without seeing your comments.
Should I revert or this can be done in the follow up?
