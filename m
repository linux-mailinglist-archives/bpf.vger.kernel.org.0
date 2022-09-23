Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186445E7BB1
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 15:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiIWNW1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 09:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiIWNWV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 09:22:21 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95332142E10;
        Fri, 23 Sep 2022 06:22:20 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id u69so244548pgd.2;
        Fri, 23 Sep 2022 06:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=BEuCLzuc3ENbIRn81OGPoQeMDtExe197i261vnUhmwI=;
        b=UpGBvjOuI55O/7ntd1MnrrZ0y7dTCWIbVcR/mcNAF5O/ni7cVDshw5t3Nhs+cYTB3Z
         4WMBm/rj8dS5QH1XHQEgwizCBEuIKPEnoqoQzx/LndlTpTckcsZYkiuGg9MGqS65/pKG
         AbMokCVnag67yNOKoPrlOrrxi0NaL0xRd2uta/k7vpDoCaDpWfr0FfwLDPA4MugB4MLD
         G5zSGbexEZj49Z2c0YKWTEefpgikBNlQdDE5YtwGpJs9uKGI5QJC5jxQDWgMyAhx/i4s
         B2n85WqDK/YiEHisqwlIVmbzpm4LbCdYAsEUGYtCzCha5TOQpnX77abLxD7FBeOBJLn9
         uwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BEuCLzuc3ENbIRn81OGPoQeMDtExe197i261vnUhmwI=;
        b=CvI6XFG/nOUwzbonN76cUfjCTx4oONCxBqTnBWxATJCV+KFhFLyZU/ju1CmYMSqAdZ
         MbbuGIcxiNf/AFCUZgstIHbOpqeZtsuTdzdR4Se6ZeyjbsQRcErkhjTNdCz23j9arUrJ
         T1Wr9TuTnggVWM3O+pRjjMWKOs4bbyx+298JQpH3jNHSKp9CfSIon8c8Wl1U3/5krOsS
         +abGT8qWd6yV4FFkb4FoULKI1K8GcztirgfcwVqwasvmlky7xcpSUpfh/4ZxH5PGXCge
         QyijyENE3r9MgZA68YJaTvrxOY3iq8G5f0288V8hPr3zMKjl+BPP51O4y9lqW7j40Oze
         4O5A==
X-Gm-Message-State: ACrzQf1swYbiGAFdtyZgigtQVpjz4QqAkdxrAMU8fy2eRxV3H5qSLZ8V
        sOVDoTCpWJ9SKQv/uRU6NP0=
X-Google-Smtp-Source: AMsMyM5dfdLfb7hVgq83LWNLX9AE7mbGw1teE6OivbAEy/+jM1qaarYLAre+ni05RTSyGxyxd+bU8Q==
X-Received: by 2002:a63:4c02:0:b0:43c:96b:e6a6 with SMTP id z2-20020a634c02000000b0043c096be6a6mr7443696pga.288.1663939340054;
        Fri, 23 Sep 2022 06:22:20 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-34.three.co.id. [116.206.12.34])
        by smtp.gmail.com with ESMTPSA id i8-20020aa796e8000000b0053db6f7d2f1sm6373792pfq.181.2022.09.23.06.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 06:22:17 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id BAE5D101070; Fri, 23 Sep 2022 20:22:12 +0700 (WIB)
Date:   Fri, 23 Sep 2022 20:22:12 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] Add table of BPF program types to libbpf
 docs
Message-ID: <Yy2zBAIFGGBMe4k1@debian.me>
References: <20220922115257.99815-1-donald.hunter@gmail.com>
 <20220922115257.99815-3-donald.hunter@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IG2Hjj6xDqLr5q1D"
Content-Disposition: inline
In-Reply-To: <20220922115257.99815-3-donald.hunter@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--IG2Hjj6xDqLr5q1D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 22, 2022 at 12:52:57PM +0100, Donald Hunter wrote:
> +..
> +  program_types.csv is generated from tools/lib/bpf/libbpf.c and is form=
atted like this:
> +    Program Type,Attach Type,ELF Section Name,Sleepable
> +    ``BPF_PROG_TYPE_SOCKET_FILTER``,,``socket``,
> +    ``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT_OR_MIGRATE`=
`,``sk_reuseport/migrate``,
> +    ``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT``,``sk_reus=
eport``,
> +    ``BPF_PROG_TYPE_KPROBE``,,``kprobe+``,
> +    ``BPF_PROG_TYPE_KPROBE``,,``uprobe+``,
> +    ``BPF_PROG_TYPE_KPROBE``,,``uprobe.s+``,Yes

The note above doesn't get rendered on htmldocs output, so I have applied
the fixup:

---- >8 ----

diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/bpf=
/libbpf/program_types.rst
index b74fbf3363dd6c..3ce0ec94b399b4 100644
--- a/Documentation/bpf/libbpf/program_types.rst
+++ b/Documentation/bpf/libbpf/program_types.rst
@@ -16,15 +16,17 @@ When ``extras`` are specified, they provide details of =
how to auto-attach the BP
 The format of ``extras`` depends on the program type, e.g. ``SEC("tracepoi=
nt/<category>/<name>")``
 for tracepoints or ``SEC("usdt/<path-to-binary>:<usdt_provider>:<usdt_name=
>")`` for USDT probes.
=20
-..
-  program_types.csv is generated from tools/lib/bpf/libbpf.c and is format=
ted like this:
-    Program Type,Attach Type,ELF Section Name,Sleepable
-    ``BPF_PROG_TYPE_SOCKET_FILTER``,,``socket``,
-    ``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT_OR_MIGRATE``,=
``sk_reuseport/migrate``,
-    ``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT``,``sk_reusep=
ort``,
-    ``BPF_PROG_TYPE_KPROBE``,,``kprobe+``,
-    ``BPF_PROG_TYPE_KPROBE``,,``uprobe+``,
-    ``BPF_PROG_TYPE_KPROBE``,,``uprobe.s+``,Yes
+.. note::
+   The table below is generated from ``tools/lib/bpf/libbpf.c`` and is
+   formatted like this (in CSV format)::
+
+     Program Type,Attach Type,ELF Section Name,Sleepable
+     BPF_PROG_TYPE_SOCKET_FILTER,,socket,
+     BPF_PROG_TYPE_SK_REUSEPORT,BPF_SK_REUSEPORT_SELECT_OR_MIGRATE,sk_reus=
eport/migrate,
+     BPF_PROG_TYPE_SK_REUSEPORT,BPF_SK_REUSEPORT_SELECT,sk_reuseport,
+     BPF_PROG_TYPE_KPROBE,,kprobe+,
+     BPF_PROG_TYPE_KPROBE,,uprobe+,
+     BPF_PROG_TYPE_KPROBE,,uprobe.s+,Yes
=20
 .. csv-table:: Program Types and Their ELF Section Names
    :file: program_types.csv
=20
Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--IG2Hjj6xDqLr5q1D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYy2y/wAKCRD2uYlJVVFO
o8k8AQD+GgOoCerwCVv4HDW/ksr9rFzvAZnHBb+P3KHSC6GgRwD9Gu+pgY6wkNsy
I9rm3l5ItKuDzrHYPtVb94hXMOzXKgk=
=vo+Z
-----END PGP SIGNATURE-----

--IG2Hjj6xDqLr5q1D--
