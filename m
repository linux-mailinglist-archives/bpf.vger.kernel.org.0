Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF27A61DA7E
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 13:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKEMyZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Nov 2022 08:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKEMyY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Nov 2022 08:54:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C299427CD0;
        Sat,  5 Nov 2022 05:54:23 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p21so7217009plr.7;
        Sat, 05 Nov 2022 05:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZ42H0SLRCb6moReftXhDXdbBURVm/UoF5wzsM8xUyc=;
        b=bt94TcYPdUT795A9mV804QOy+ZtYX4QrjGifmwqZU6WM6efHicX/Zuv1VYJdYBFy/Z
         nwrV81Q/boSKhUlv0UMrBpbAo2WqQerfscW0Wf8fp4cwpt40A+dCSRAmqudgTe8S2wXS
         W9pwBtMFI/8rQpuDXh6rRzArdDHActoQgJxpcJFJxGtRN0Ff+8pUpuifgfW6aLqf746s
         k2TqjlYa4VB3pyMOKJBItFYwCES2HSyvvSVo3b+RwW3kk/yy41SUrkCr3OI3mmzM+Oth
         aMmx5ZedOooqUimIcGAQ727gQQDIrcpYKsmYEasnAFUhPC5AyHs01F9bn4n5EeuyPUKL
         bXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZ42H0SLRCb6moReftXhDXdbBURVm/UoF5wzsM8xUyc=;
        b=WnCFvNi5CXhqv88MbnYdCzPPDCDAIaIILHAV4NdxzQe343vrAq7wt3gQT6OkOc1Z/Q
         Xn0NvV4iF0O7i2W5r/cmPksJiRSVr/uoz59GgJWMob7BA6++Q2vU/YkNtRKR0gyjoATU
         aIAq+30RQ0o2hAJ00/ASuyjsjhmIdPwtS17Ia1Kl/hPVuH3D/oWzSh8ODysVEwiDRTzQ
         f73vYps5VT5vhd1RWOv6Gh+H3JpvMMpwx7ogycCEKyoKISxBPiWSUusj3n6AjxRdv+Gu
         t+a7uEePaSDTC/TaV0EdBjh9ZdS+w+ikzFk3ORnMqZkmo4MF5Kn7YIdLGIM/02ZP4Q+K
         H5kQ==
X-Gm-Message-State: ACrzQf09DoRUKuw3PVCM63CEX4agrz74uqtg8MG8bRB/OE3r/Fq/iy8w
        oHn/pW5XJVuDi5yNn3rDTn0=
X-Google-Smtp-Source: AMsMyM5a+/nqgJ2p7Kn5x1+j6lOJAvpowKnoiKWCtowjrieFISNII+1U1wzCXSLPCB0uqGFGwajAhA==
X-Received: by 2002:a17:90b:3a81:b0:213:ff6a:aa0d with SMTP id om1-20020a17090b3a8100b00213ff6aaa0dmr26881004pjb.86.1667652863308;
        Sat, 05 Nov 2022 05:54:23 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-7.three.co.id. [180.214.233.7])
        by smtp.gmail.com with ESMTPSA id 101-20020a17090a0fee00b0020669c8bd87sm1202427pjz.36.2022.11.05.05.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 05:54:22 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A8F8510403A; Sat,  5 Nov 2022 19:54:18 +0700 (WIB)
Date:   Sat, 5 Nov 2022 19:54:18 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Maryam Tahhan <mtahhan@redhat.com>
Subject: Re: [PATCH bpf-next v2] docs/bpf: document BPF ARRAY_OF_MAPS and
 HASH_OF_MAPS
Message-ID: <Y2Zc+vdyQF9a0NnV@debian.me>
References: <20221104101928.9479-1-donald.hunter@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="itayzI8Iw9S89a8P"
Content-Disposition: inline
In-Reply-To: <20221104101928.9479-1-donald.hunter@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--itayzI8Iw9S89a8P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 04, 2022 at 10:19:28AM +0000, Donald Hunter wrote:
> +Kernel BPF
> +----------
<snipped>...
> +Kernel BPF
> +----------
> +

As kernel test robot has reported [1], you need to disambiguate both heading
titles above:

---- >8 ----

diff --git a/Documentation/bpf/map_of_maps.rst b/Documentation/bpf/map_of_m=
aps.rst
index d5a09bc669a34c..4dfe6ef9938e70 100644
--- a/Documentation/bpf/map_of_maps.rst
+++ b/Documentation/bpf/map_of_maps.rst
@@ -50,8 +50,8 @@ used to disable pre-allocation when it is too memory expe=
nsive.
 Usage
 =3D=3D=3D=3D=3D
=20
-Kernel BPF
-----------
+Helpers for kernel BPF
+----------------------
=20
 .. c:function::
    void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
@@ -62,8 +62,8 @@ helper returns a pointer to the inner map, or ``NULL`` if=
 no entry was found.
 Examples
 =3D=3D=3D=3D=3D=3D=3D=3D
=20
-Kernel BPF
-----------
+Kernel BPF examples
+-------------------
=20
 This snippet shows how to create an array of devmaps in a BPF program. Not=
e that
 the outer array can only be modified from user space using the syscall API.

Thanks.

[1]: https://lore.kernel.org/linux-doc/202211051940.yqd37TmX-lkp@intel.com/

--=20
An old man doll... just what I always wanted! - Clara

--itayzI8Iw9S89a8P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY2Zc9AAKCRD2uYlJVVFO
owv9AQCew1ehLnZ3zQ5cuvQ+b5S3pG4hE73oeIhKgFsWWRVZkAEA3E7xPbyTRxo8
kKKQoeX3msv+iVY42ZY7NU7QuWZ2ygA=
=U1Mq
-----END PGP SIGNATURE-----

--itayzI8Iw9S89a8P--
