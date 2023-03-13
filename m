Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A6D6B72FF
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 10:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjCMJpF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 05:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCMJpE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 05:45:04 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F4D12CCA;
        Mon, 13 Mar 2023 02:45:03 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so2752575pjt.5;
        Mon, 13 Mar 2023 02:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678700703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Of+FjKvd8s+vxa4KebPCKUMymCE/4pxsMzXCM2VIFgI=;
        b=h7m7ha+Jr3ID7HHwjceLrXT/nNrw+V0JrGtoBM1w+3NKQwGPVbFfjTt4LvwV+EHSp5
         o3FFel3SUS0BsEzxh8Jtqg5gSvzPQ463dkugulalwgJDadPsWEZv0G8cwWtDqpr8NHxG
         Jip2ggqiUPjyybwjzWwzCSYq3J7kJXLWhnTepudhBMd+wfBL4QP2nZvxfPySE5xLPf4K
         v+pqTMfCIqJkLrRB1QF8DmKjQo8+MsBfA/Rk94R+O/Va/oTHB5M7aOLo9bpAUa9nJQx1
         hwMiUEn9Dk9qJi+bzfaP8Ot+4rER6cmRT7MXbtNgi3pTKxYQj0XrbjkJoC1n/sG0uVar
         TfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678700703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Of+FjKvd8s+vxa4KebPCKUMymCE/4pxsMzXCM2VIFgI=;
        b=ZUvViCU834HAjKAnN1YvRXqzgl3HM8C2aPKR8pXiYUkYezfkAM0eG/FYUKPdIdB3Px
         vZtMtk9VKw7+JuygQAShJ1SUkUHPpUZOLaP3i2TsoW8IodJPELGUNAxahtDq1rEet7wW
         NcsRy4JqBIoEnElzhGD2XnGRkKuscd0KUWoXpUtbSDyn05uSYgMNkYaJG+vozYJnmHBN
         Tory/Wu3q8tOD0z18Y9xKsdnIbXAnpZ3wLAxUvjQSpMW6p5ANzOwXHx5we3p3XIwituw
         lWQOmkQkChpMfGY149k6W2KklUDmRDWjYVrDspUEdMay6et3BuJeD5TALUZx3M1IWbCp
         Efww==
X-Gm-Message-State: AO0yUKUws2kxUspWLoQHnJ7sqTjrkPXs14YzaiFql2/LWm4RjJMLzamS
        47o2Z/O0xeOyVkDvJka6tUc=
X-Google-Smtp-Source: AK7set+iHhuVpNlD9WMkgP9eruUEEmzysC7RHGFFNKSVnsdlOXaMn1+BKaVfxKkKp/7vVmfzLux3Pw==
X-Received: by 2002:a05:6a21:9998:b0:d3:73be:3ea2 with SMTP id ve24-20020a056a21999800b000d373be3ea2mr8809433pzb.36.1678700702578;
        Mon, 13 Mar 2023 02:45:02 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-18.three.co.id. [180.214.232.18])
        by smtp.gmail.com with ESMTPSA id a10-20020a62bd0a000000b00593e84f2d08sm4040294pff.52.2023.03.13.02.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 02:45:02 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 688E1105FA7; Mon, 13 Mar 2023 16:44:59 +0700 (WIB)
Date:   Mon, 13 Mar 2023 16:44:59 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sreevani Sreejith <ssreevani@meta.com>, void@manifault.com,
        psreep@gmail.com, bpf@vger.kernel.org,
        Linux-kernel@vger.kernel.org, andrii@kernel.org, mykola@meta.com
Cc:     linux-doc@vger.kernel.org
Subject: Re: [PATCH V3 bpf-next] BPF, docs: libbpf Overview Document
Message-ID: <ZA7wm8scokV+XPav@debian.me>
References: <20230310180928.2462527-1-ssreevani@meta.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="okP/XnxEkGF/S5Bq"
Content-Disposition: inline
In-Reply-To: <20230310180928.2462527-1-ssreevani@meta.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--okP/XnxEkGF/S5Bq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2023 at 10:09:28AM -0800, Sreevani Sreejith wrote:
> From: Sreevani <ssreevani@meta.com>
>=20
> Summary: Document that provides an overview of libbpf features for BPF
> application development.

It seems like you ignore some of my reviews at [1]. Anyway, I repeat
them here, augmenting my new comments.

The patch description should have been "Document overview of libbpf,
including its features for developing BPF programs.".

> +######
>  libbpf
> -=3D=3D=3D=3D=3D=3D
> +######

Why did you add heading overline and change the heading character marker?

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

You may want to also add :lineos: option or manually add line numbers
if you add :emphasize-lines: so that readers can see the line number
it refers to.

> +Also, find the libbpf API documentation `here
> +<https://libbpf.readthedocs.io/en/latest/api.html>`_

"See also `libbpf API documentation <link>`_".

> +
> +libbpf and Rust
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +If you are building BPF applications in Rust, it is recommended to use t=
he
> +`Libbpf-rs <https://github.com/libbpf/libbpf-rs>`_ library instead of bi=
ndgen
> +bindings directly to libbpf. Libbpf-rs wraps libbpf functionality in
> +Rust-idiomatic interfaces and provides libbpf-cargo plugin to handle BPF=
 code
> +compilation and skeleton generation. Using Libbpf-rs will make building =
user
> +space part of the BPF application easier. Note that the BPF program them=
selves
> +must still be written in plain C.

BPF apps are application that use BPF program, right? I thought that
despite there is libbpf-rs, I still have to develop BPF apps in C.

Thanks.

[1]: https://lore.kernel.org/linux-doc/ZAqzeQZLNMyaZOck@debian.me/

--=20
An old man doll... just what I always wanted! - Clara

--okP/XnxEkGF/S5Bq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZA7wlwAKCRD2uYlJVVFO
ow8vAP4rjUd07tAFMNXeoUbvQ2+9unWvXYLxgNH7/5YFykfw7wD/asWTzftMz36d
LRR+Tn7gOkXksj1jB+PZ4+OVTHyIKA0=
=eyQJ
-----END PGP SIGNATURE-----

--okP/XnxEkGF/S5Bq--
