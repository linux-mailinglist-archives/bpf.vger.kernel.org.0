Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D196D3C3E
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 05:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjDCDug (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Apr 2023 23:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDCDuf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Apr 2023 23:50:35 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBC73C0D;
        Sun,  2 Apr 2023 20:50:33 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id d8so16650954pgm.3;
        Sun, 02 Apr 2023 20:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680493833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v6vMrCF8OOl5vrU6gL6KNFSlmWSVBdedM89YGlTwZdI=;
        b=Qoabb/yfINl+qeK1wYMdVZKL62BXfVUBEJ8xFkaib6M9R/xK3gfzut1jpBxqNTUSSe
         9kNu2+dK6r1bw7oDatF2TGd4g6luhe4GZY9bTZFi27Kg9zxSAi2FMylP1F9uerXiCHeX
         +pp8gy/xnxjGyfQ8uuSWlsJzuXqihD4rh6BS044uu+vOHaXUTSN0ImK8KMZsBCcacIbE
         t7DAZUZzxAJFgiX9zEXTvcBKTfzuRMIA2qf0yT7WiF3cMWFSv3BP8BgVu+otCdhYhwzx
         r7S/B96duBEz0P/lq3bJH6Ws1Dx6uULdOQHDntXAZZqxMBYiOWU8bYLLlyazn+N02qKa
         Hf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680493833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6vMrCF8OOl5vrU6gL6KNFSlmWSVBdedM89YGlTwZdI=;
        b=D0HL+r596D+ZOqjdUS/W0Te3ylQlqE5ke1D4TwNIDCxHMmF9/F3VXJ+Pws7ETlHcQx
         65R5FlzIrPpwLQz/q6f50KJQPyR9MkmuFwd+W6FjHmaUPe7vlhZkYjqJ2TuQXDwZ1PiF
         +U/BJe6VYsCiu8HUPcFfge5XjxOOfMUgFgBMDZUHmmyPtX3yCmm88jyOHp/HbW0AH6AM
         ZBHQw0Z8DIlnQfvyQNxATnZaB6dH4H5Cu/HhsiFacG4diJPLRjedmWkKWcdIJ2Cbo0C6
         CB8Sv1wqCxjaBnTlKt9m0lIBC1pn9Ir4vK8iDclB3uruvn3hEjYrul/s4/YP1hi6Xy12
         0+SA==
X-Gm-Message-State: AAQBX9cnyPhqgwGN+EZgtqAWgw6V5NZfljACM/V2Fi3MJstkdQz4gavl
        J4tn4UeQm0YQ1quUOcXIL2U=
X-Google-Smtp-Source: AKy350ZbbIhtqecTOv6NN8mhN9enmXzYOgL/QAPhrdx3CoMfHQ/1OyAd/+dzLgt5hzsRUUOrWoK17g==
X-Received: by 2002:a62:7988:0:b0:625:e8ec:4f5b with SMTP id u130-20020a627988000000b00625e8ec4f5bmr35634590pfc.6.1680493833307;
        Sun, 02 Apr 2023 20:50:33 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-12.three.co.id. [116.206.28.12])
        by smtp.gmail.com with ESMTPSA id u20-20020a62ed14000000b0062a56e51fd7sm5612575pfh.188.2023.04.02.20.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 20:50:32 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 508F51067A2; Mon,  3 Apr 2023 10:50:30 +0700 (WIB)
Date:   Mon, 3 Apr 2023 10:50:30 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Joe Stringer <joe@isovalent.com>, bpf@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, corbet@lwn.net, martin.lau@linux.dev,
        maxtram95@gmail.com, john.fastabend@gmail.com
Subject: Re: [PATCH bpf-next v4 2/2] docs/bpf: Add LRU internals description
 and graph
Message-ID: <ZCpNBjKlSnMFmHhf@debian.me>
References: <20230401200651.1022113-1-joe@isovalent.com>
 <20230401200651.1022113-2-joe@isovalent.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FOoe/uNk0CyZUVIL"
Content-Disposition: inline
In-Reply-To: <20230401200651.1022113-2-joe@isovalent.com>
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--FOoe/uNk0CyZUVIL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 01, 2023 at 01:06:51PM -0700, Joe Stringer wrote:
> diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_hash.=
rst
> index 45d923cd16c4..ddc961f98b27 100644
> --- a/Documentation/bpf/map_hash.rst
> +++ b/Documentation/bpf/map_hash.rst
> @@ -1,5 +1,6 @@
>  .. SPDX-License-Identifier: GPL-2.0-only
>  .. Copyright (C) 2022 Red Hat, Inc.
> +.. Copyright (C) 2022-2023 Isovalent, Inc.
> =20
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  BPF_MAP_TYPE_HASH, with PERCPU and LRU Variants
> @@ -215,3 +216,44 @@ Userspace walking the map elements from the map decl=
ared above:
>                      cur_key =3D &next_key;
>              }
>      }
> +
> +Internals
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This section of the document is targeted at Linux developers and describ=
es
> +aspects of the map implementations that are not considered stable ABI. T=
he
> +following details are subject to change in future versions of the kernel.
> +
> +``BPF_MAP_TYPE_LRU_HASH`` and variants
> +--------------------------------------
> +
> +Updating elements in LRU maps may trigger eviction behaviour when the ca=
pacity
> +of the map is reached. There are various steps that the update algorithm
> +attempts in order to enforce the LRU property which have increasing impa=
cts on
> +other CPUs involved in the following operation attempts:
> +
> +- Attempt to use CPU-local state to batch operations
> +- Attempt to fetch free nodes from global lists
> +- Attempt to pull any node from a global list and remove it from the has=
hmap
> +- Attempt to pull any node from any CPU's list and remove it from the ha=
shmap
> +
> +This algorithm is described visually in the following diagram. See the
> +description in commit 3a08c2fd7634 ("bpf: LRU List") for a full explanat=
ion of
> +the corresponding operations:
> +
> +.. kernel-figure::  map_lru_hash_update.dot
> +   :alt:    Diagram outlining the LRU eviction steps taken during map up=
date.
> +
> +   LRU hash eviction during map update for ``BPF_MAP_TYPE_LRU_HASH`` and
> +   variants. See the dot file source for kernel function name code refer=
ences.
> +
> +Map updates start from the oval in the top right "begin ``bpf_map_update=
()``"
> +and progress through the graph towards the bottom where the result may be
> +either a successful update or a failure with various error codes. The ke=
y in
> +the top right provides indicators for which locks may be involved in spe=
cific
> +operations. This is intended as a visual hint for reasoning about how map
> +contention may impact update operations, though the map type and flags m=
ay
> +impact the actual contention on those locks, based on the logic describe=
d in
> +the table above. For instance, if the map is created with type
> +``BPF_MAP_TYPE_LRU_PERCPU_HASH`` and flags ``BPF_F_NO_COMMON_LRU`` then =
all map
> +properties would be per-cpu.

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--FOoe/uNk0CyZUVIL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZCpNBQAKCRD2uYlJVVFO
o3eLAP0XQzRYkXM5fpPRgoalA9a9OqJcsTQNSfQsABEqVwjnWgEAlS+OFwT22pQk
LzuJG51NI7jyg1yDsuFrnfD6cbgOmQ8=
=DDu/
-----END PGP SIGNATURE-----

--FOoe/uNk0CyZUVIL--
