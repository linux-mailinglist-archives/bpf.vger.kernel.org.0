Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9745FF86E
	for <lists+bpf@lfdr.de>; Sat, 15 Oct 2022 06:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJOEUJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Oct 2022 00:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJOEUI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Oct 2022 00:20:08 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268232BB3A;
        Fri, 14 Oct 2022 21:20:04 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 128so5986906pga.1;
        Fri, 14 Oct 2022 21:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zs5twK6aXSzYSqUpj1TYqBq1ZXOIV27GhCyY3k0ac0k=;
        b=IH0vFmrLYChUOJN2QQfxFqSIWCyZwujkYRExcF4YDs6ZelvewH9jNCrI74+PED0xMb
         UVr6GuiAQrpKc4tNhXJc00AwvNeS6vAUWThIXnxJTEZIXf/M2R8rli2GWNm5QO3LyJy2
         gK3p44Wye5pz8zINtX0zFpUVSC2anh9ezU/TN4QCTdZBr6m9MoTDOpm8/mSRkddQN65I
         iNHHOGN6o6pSwRow8JNUnLRnPHoX4Y+ML3zNcM3R1xQi8YI0UpvyqCEeW1d2U6WBStz9
         3pHEVd+7RTArhmhjzGVAMCuHrrPlxg2i8Pp/Vi9OWd9lI3ByOudYWIvW3lDhjEvMR534
         q8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zs5twK6aXSzYSqUpj1TYqBq1ZXOIV27GhCyY3k0ac0k=;
        b=thZyvT2zoq2pjVyny7vmg2IIdJDKihRYaOMpkpSkSLUQI+szV2Oe6nnaDq98WeP8z1
         FTBKzBGuzyhEOV2PEvbbkAKpccbkY3uQcX/Fe8reNa/+lJNB8Oaif82/Tq3/jjpjaQ1d
         a/NTtPP5gFHTioty0NTixVLj2itWr7LIhKbgOymCATIHCIYp5/YHNNlVRFXToBwUD/S3
         uUi8EcNgUkmjWNphEz2ak5Nx17mNMX/t3q39xAABIGCrvBbWHZvIwzX3/x82k5fPePxo
         1RHm2hTxKWn80/hnvIZ6FbAbByeBiSJGhrNGk+g631Oudg4PBCVQ1f6c96VHP8TnyJG/
         +x9g==
X-Gm-Message-State: ACrzQf0qAiDKT4nhd7PoLLd6daoIQfHUSHUTY7EzFM4LMW/JgoeQjLWa
        bVrTIgKsMIUEwXLgotTZ+tYM4BCfU4M=
X-Google-Smtp-Source: AMsMyM4M2/SaELF6j32JrVfnfNZ5f5JtRDxJXJk/8fi5QBF5youtLVckd6WkGNyuxARh6aWEGpgTSw==
X-Received: by 2002:a05:6a00:1389:b0:566:1549:c5bc with SMTP id t9-20020a056a00138900b005661549c5bcmr1299287pfg.8.1665807603435;
        Fri, 14 Oct 2022 21:20:03 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-28.three.co.id. [116.206.28.28])
        by smtp.gmail.com with ESMTPSA id z14-20020aa79e4e000000b005631a40a00bsm2482248pfq.139.2022.10.14.21.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 21:20:02 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 9B225103A91; Sat, 15 Oct 2022 11:19:59 +0700 (WIB)
Date:   Sat, 15 Oct 2022 11:19:59 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     mtahhan@redhat.com
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/1] doc: DEVMAPs and XDP_REDIRECT
Message-ID: <Y0o07w0OguaTIH1e@debian.me>
References: <20221013111129.401325-1-mtahhan@redhat.com>
 <20221013111129.401325-2-mtahhan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3vAj85k0xYuU7nJ3"
Content-Disposition: inline
In-Reply-To: <20221013111129.401325-2-mtahhan@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--3vAj85k0xYuU7nJ3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 13, 2022 at 07:11:29AM -0400, mtahhan@redhat.com wrote:
> diff --git a/Documentation/bpf/map_devmap.rst b/Documentation/bpf/map_dev=
map.rst
> new file mode 100644
> index 000000000000..bdba55640f4c
> --- /dev/null
> +++ b/Documentation/bpf/map_devmap.rst
> @@ -0,0 +1,192 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +BPF_MAP_TYPE_DEVMAP and BPF_MAP_TYPE_DEVMAP_HASH
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. note::
> +   - ``BPF_MAP_TYPE_DEVMAP`` was introduced in kernel version 4.14
> +   - ``BPF_MAP_TYPE_DEVMAP_HASH`` was introduced in kernel version 5.4
> +
> +``BPF_MAP_TYPE_DEVMAP`` and ``BPF_MAP_TYPE_DEVMAP_HASH`` are BPF maps pr=
imarily
> +used as backend maps for the XDP BPF helper call ``bpf_redirect_map()``.
> +``BPF_MAP_TYPE_DEVMAP`` is backed by an array that uses the key as
> +the index to lookup a reference to a net device. While ``BPF_MAP_TYPE_DE=
VMAP_HASH``
> +is backed by a hash table that uses the ``ifindex`` as the key to lookup=
 a reference
> +to a net device. The user provides either <``key``/ ``ifindex``> or
> +<``key``/ ``struct bpf_devmap_val``> pairs to update the maps with new n=
et devices.
> +
> +.. note::
> +    While ``BPF_MAP_TYPE_DEVMAP_HASH`` allows for densely packing the ne=
t devices
> +    it comes at the cost of a hash of the key when performing a look up.
> +
> +The setup and packet enqueue/send code is shared between the two types of
> +devmap; only the lookup and insertion is different.
> +
> +Usage
> +=3D=3D=3D=3D=3D
> +
> +.. c:function::
> +   long bpf_map_update_elem(struct bpf_map *map, const void *key, const =
void *value, u64 flags)
> +
> + Net device entries can be added or updated using the ``bpf_map_update_e=
lem()``
> + helper. This helper replaces existing elements atomically. The ``value`=
` parameter
> + can be ``struct bpf_devmap_val`` or a simple ``int ifindex`` for backwa=
rds
> + compatibility.
> +
> +.. note::
> +    The maps can only be updated from user space and not from a BPF prog=
ram.
> +

Only the sentence above should be in the note directive, so align the
directive to the surrounding text:

---- >8 ----

diff --git a/Documentation/bpf/map_devmap.rst b/Documentation/bpf/map_devma=
p.rst
index bdba55640f4c7d..b4f2b1a9ef9b09 100644
--- a/Documentation/bpf/map_devmap.rst
+++ b/Documentation/bpf/map_devmap.rst
@@ -35,7 +35,7 @@ Usage
  can be ``struct bpf_devmap_val`` or a simple ``int ifindex`` for backwards
  compatibility.
=20
-.. note::
+ .. note::
     The maps can only be updated from user space and not from a BPF progra=
m.
=20
  .. code-block:: c

> + When a program is associated with a device index, the program is run on=
 an
> + ``XDP_REDIRECT`` and before the buffer is added to the per-cpu queue. E=
xamples
> + of how to attach/use xdp_devmap progs can be found in the kernel selfte=
sts:
> +
> + - test_xdp_with_devmap_helpers_
> + - xdp_devmap_attach_
> +
> +.. _xdp_devmap_attach: https://github.com/torvalds/linux/blob/master/too=
ls/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
> +.. _test_xdp_with_devmap_helpers: https://github.com/torvalds/linux/blob=
/master/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c
> +

Instead of external link to the Linus's tree, just specify the file location
of these selftests:

---- >8 ----

diff --git a/Documentation/bpf/map_devmap.rst b/Documentation/bpf/map_devma=
p.rst
index b4f2b1a9ef9b09..55ad36d4a8dbd5 100644
--- a/Documentation/bpf/map_devmap.rst
+++ b/Documentation/bpf/map_devmap.rst
@@ -56,11 +56,8 @@ Usage
  ``XDP_REDIRECT`` and before the buffer is added to the per-cpu queue. Exa=
mples
  of how to attach/use xdp_devmap progs can be found in the kernel selftest=
s:
=20
- - test_xdp_with_devmap_helpers_
- - xdp_devmap_attach_
-
-.. _xdp_devmap_attach: https://github.com/torvalds/linux/blob/master/tools=
/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
-.. _test_xdp_with_devmap_helpers: https://github.com/torvalds/linux/blob/m=
aster/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c
+ - ``test_xdp_with_devmap_helpers`` (in ``tools/testing/selftests/bpf/prog=
s/test_xdp_with_devmap_helpers.c``)
+ - ``xdp_devmap_attach`` (in ``tools/testing/selftests/bpf/prog_tests/xdp_=
devmap_attach.c``)
=20
 .. c:function::
    void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--3vAj85k0xYuU7nJ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY0o06wAKCRD2uYlJVVFO
o2QdAQDQyel5iq1yP2EOXjfVPA7qllBiIbLWvDhiS5QIPlfFLAEAj6IYExWbk740
kxL/7ts92MtTHmKjuBhho0WxR4pWsAo=
=F/zR
-----END PGP SIGNATURE-----

--3vAj85k0xYuU7nJ3--
