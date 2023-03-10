Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281E56B35A0
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 05:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjCJEfM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 23:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJEfK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 23:35:10 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7167FD299;
        Thu,  9 Mar 2023 20:35:09 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q23so2376171pgt.7;
        Thu, 09 Mar 2023 20:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678422909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rZEyg2YLs2CSLyVftGC2viHqt3DtUnop0r0wuxQQvOg=;
        b=L4fY2prgHEY01QG+PL0iahqtO96MsjGO/j5vvMERD2Vz3QnmVvNjHDC6ja/Aqh1jsn
         V34kpZSQ1vDOycvDkKyLCuXOPLiUxZZfS6IuTlZKwIdS4R225SEn2oBRR3BaY7RWbuvY
         7VxWyHbWc0EwnxDnFwVG8F7Jn6LSmRjpI+AyEVAFZgezBKbjX7Qk3Xpw+/NqsUVmwf/U
         qEw2WM4MtinmMYD/actrqz9c0w2oEI0AhKefOW/6AhFYqqo404TbS2tbViPkVvy1wmbX
         dRHXeYMQvoVKwobYwj0MkPnlJPU7BNF+deFV51f61UPh1i15vNDOkr/Ue4M9LbilfoLD
         VnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678422909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZEyg2YLs2CSLyVftGC2viHqt3DtUnop0r0wuxQQvOg=;
        b=dhX6SEdUgtUS2qi04h9t7yma8pLRhKhsvBOJXibiIlfZH+FVbKFYhqKAkSD1affCSl
         OQ/Pdto8AlMJVxrjsoIDzupn/WPs81bv6FjsUUFTgnCQaLTVsCDMx2k2zQ+e3f4VE2B6
         j+5Hmay3wuM0Rp3RybgxS0WpPVdXFdrqQXCcIrwE6Ca2/h2eXkUsSloFfliIDLdfZSWI
         xX646PXcYCn2zOvOf6hQ9Ffl08J/IGPl4vz/eXiKZ7pOxeiyATDJgiqz5y+X4KMoalh4
         BNsUIqAwPUYbDXP6evMj+YnH847mJ13V9bWCebLqBPSd3saubc375472mDXATbMuTqJN
         KIcQ==
X-Gm-Message-State: AO0yUKV1TZY2HSFAM0YfHE9T8XPhGFMR+VDtgTQ6YhSpgDupSB1bbWXf
        gcJHm6BEBPBjAS0X2I95dHE=
X-Google-Smtp-Source: AK7set8AkQTjnxl6PgZlr/Vh7yQysN7PX0v9tqyu6R9mcPo6mZ1wdndONGY9ROzJEMkCp8BL6bqbcA==
X-Received: by 2002:aa7:8bd9:0:b0:5db:ba34:36eb with SMTP id s25-20020aa78bd9000000b005dbba3436ebmr19843019pfd.16.1678422909118;
        Thu, 09 Mar 2023 20:35:09 -0800 (PST)
Received: from debian.me (subs32-116-206-28-18.three.co.id. [116.206.28.18])
        by smtp.gmail.com with ESMTPSA id n7-20020a62e507000000b005d72e54a7e1sm359780pff.215.2023.03.09.20.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 20:35:08 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 96A00106628; Fri, 10 Mar 2023 11:35:05 +0700 (WIB)
Date:   Fri, 10 Mar 2023 11:35:05 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sreevani Sreejith <ssreevani@meta.com>, void@manifault.com,
        psreep@gmail.com, Linux BPF <bpf@vger.kernel.org>,
        Linux-kernel@vger.kernel.org, andrii@kernel.org, mykola@meta.com
Cc:     Linux Documentation <linux-doc@vger.kernel.org>
Subject: Re: [PATCH V2 bpf-next] BPF, docs: libbpf Overview Document
Message-ID: <ZAqzeQZLNMyaZOck@debian.me>
References: <20230309224930.4106982-1-ssreevani@meta.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CrzSA/fAm0tW3LNz"
Content-Disposition: inline
In-Reply-To: <20230309224930.4106982-1-ssreevani@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--CrzSA/fAm0tW3LNz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2023 at 02:49:30PM -0800, Sreevani Sreejith wrote:
> From: Sreevani <ssreevani@meta.com>
>=20
> Summary: Document that provides an overview of libbpf features for BPF
> application development.
>=20
> Reviewers:
>=20
> Subscribers:

Please remove the boilerplate above. The summary should become patch
description.

> +=3D=3D=3D=3D=3D=3D
>  libbpf
>  =3D=3D=3D=3D=3D=3D

Why did you promote the heading above to title heading?

> diff --git a/Documentation/bpf/libbpf/libbpf_overview.rst b/Documentation=
/bpf/libbpf/libbpf_overview.rst
> new file mode 100644
> index 000000000000..549469aa2d3b
> --- /dev/null
> +++ b/Documentation/bpf/libbpf/libbpf_overview.rst
> @@ -0,0 +1,238 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.._libbpf-overview-label:

Missing space before label name. Or should the label name be
"_libbpf-overview"?

> +#################################
> +BPF App Lifecycle and libbpf APIs
> +#################################
> <snipped> ...
> +########################
> +BPF Object Skeleton File
> +########################
> <snipped> ...
> +---------------------------------------
> +Other Advantages of Using Skeleton File
> +---------------------------------------
> +
> <snipped> ...
> +###########
> +BPF Helpers
> +###########
> <snipped> ...
> +#########################################
> +BPF CO-RE (Compile Once =E2=80=93 Run Everywhere)
> +#########################################
> <snipped> ...

See the bottom.

> +You can generate the BTF information for the running kernel with the fol=
lowing
> +command:
> +
> +::
> +
> +$ bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h

My htmldocs build renders the code block above fine, but IMO the
convention here is to indent it.

> +The following code snippet shows how to read the parent field of a kernel
> +``task_struct`` using BPF CO-RE and libbf. The basic helper to read a fi=
eld in a
> +CO-RE relocatable manner is ``bpf_core_read(dst, sz, src)``, which will =
read
> +``sz`` bytes from the field referenced by ``src`` into the memory pointe=
d to by
> +``dst``.
> +
> +  .. code-block:: C
> +    :emphasize-lines: 6
> +
> +    //...
> +    struct task_struct *task =3D (void *)bpf_get_current_task();
> +    struct task_struct *parent_task;
> +    int err;
> +
> +    err =3D bpf_core_read(&parent_task, sizeof(void *), &task->parent);
> +    if (err) {
> +      /* handle error */
> +    }
> +
> +    /* parent_task contains the value of task->parent pointer */

I guess :linenos: option also helps locating the highlighted line, right?

> +###########################
> +Getting Started with libbpf
> +###########################
> <snipped> ...
> +###############
> +libbpf and Rust
> +###############
> <snipped> ...
> +########################
> +Additional Documentation
> +########################

For section headings above, I'd like to strip the overline. Yet,
Sphinx is smart when discriminating headings based on underline/overline
character.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--CrzSA/fAm0tW3LNz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZAqzdQAKCRD2uYlJVVFO
o6OcAQClt3tCiKoO8NuaMrOiu4gmgX5OHuWjIm/L7+HHVI7MagD/ZgpKdhv+5eCn
5ITdBbMueewsYJm/fgQmt/UsinBnMQg=
=mWJu
-----END PGP SIGNATURE-----

--CrzSA/fAm0tW3LNz--
