Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8FF69F0BE
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 09:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjBVIyR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 03:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjBVIyQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 03:54:16 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDB91C7EF;
        Wed, 22 Feb 2023 00:54:15 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id c1so8229993plg.4;
        Wed, 22 Feb 2023 00:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/FteTCAip9xec+DoZhdjjZs+92JNbzqUwYicxVMsGlQ=;
        b=aGoCgjDcarCa2PmjCeN0YxhNrhetOWe6yl+VSyd4aMdwnvyZHRYJIdQKVWyJrzvx8n
         tPtWk22yr+zN4LZhh1+C4iB+YBN9ThwqMK2nkbC4OPQqSXfPeqYcCvHvPHqBhvKB7mCi
         9NW20uhPz69uCrl/OS+I6hv5kinGrVl1SLaNW8XXjSYsYAcdcQG2dI4Yt2yYHqIfpXBl
         OFI04XwukOQm01iB3TVRSe5EeN41w0h9m02jtvNRdHzMKdLwjncDikdKcbyUQ44XRFdT
         /xk/uMWdqc9U8fnRubMnD+CYEc8r/i3VsV5mqMXdOco5iwzWHHO1YrH8fSleE2t4rrOq
         zdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FteTCAip9xec+DoZhdjjZs+92JNbzqUwYicxVMsGlQ=;
        b=OKXHormsD49aA6cccbXz2rET6ATuCDb+rWzoW2197qvg5JJ5DthBgiCP4ecPm520QM
         GgxA2Z9anPhMfjJCikVRF/qEIL2R36wn1x/2tFsaE4PKXVn9lojPyEuMD3eHSOPJAPYU
         ZaATlGTMLZbao14sHOLQJzoUL+j8n8EGXGeCm5zJAz2FQye1vWW+QH3C6dz75j5kHLpy
         ILdmfannJ7NyY3c5t5cpKBVAXgubcu8m219zNNL3keSv+hxiRn7WfqhOwUIK4LU9FZ0D
         9dAMw7EWtKKWBN7CRqjmo+XxzAaKjitTORya4xYvurmJlAPsOjinQZ1uIYALIdz05xlZ
         n1rg==
X-Gm-Message-State: AO0yUKX+Xjb+C+QfgPbRj8ohKXxxUNgSW8RjtISqX134pVB/1yJ5cZYT
        hwIDSKt9MqjSeW3zXA1VaZQ=
X-Google-Smtp-Source: AK7set/FmSi0IMiSyGTOnCHsihnPA9q2RCOSxAJ7nTp9KPMf7YWExnxSyvdgWeVK7d3VqQgH0Bpkxg==
X-Received: by 2002:a05:6a20:1452:b0:cb:c8f7:1140 with SMTP id a18-20020a056a20145200b000cbc8f71140mr1559512pzi.21.1677056054579;
        Wed, 22 Feb 2023 00:54:14 -0800 (PST)
Received: from debian.me (subs02-180-214-232-84.three.co.id. [180.214.232.84])
        by smtp.gmail.com with ESMTPSA id t8-20020a1709028c8800b001994a7a662esm6355882plo.201.2023.02.22.00.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 00:54:13 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 2C79A10561D; Wed, 22 Feb 2023 15:54:11 +0700 (WIB)
Date:   Wed, 22 Feb 2023 15:54:11 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/bpf: Fix invalid link of "Documentation/bpf/btf.rst"
Message-ID: <Y/XYM4D1SW/zyhNJ@debian.me>
References: <1677035401-3628-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zZnDlUkIXd7iZ9Tf"
Content-Disposition: inline
In-Reply-To: <1677035401-3628-1-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--zZnDlUkIXd7iZ9Tf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2023 at 11:10:01AM +0800, Tiezhu Yang wrote:
> "Documentation/bpf/btf.rst" is linked to the following invalid web page:
>=20
> https://www.kernel.org/doc/html/latest/bpf/btf.rst
>=20
> The correct link should be:
>=20
> https://www.kernel.org/doc/html/latest/bpf/btf.html
>=20
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Hi,

I have already submitted a different fix to the same problem at [1] (v2
at [2]). Please take a look at there.

[1]: https://lore.kernel.org/linux-doc/20230219030956.22662-1-bagasdotme@gm=
ail.com/
[2]: https://lore.kernel.org/linux-doc/20230222083530.26136-1-bagasdotme@gm=
ail.com/

> diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_d=
evel_QA.rst
> index 03d4993..f54c328 100644
> --- a/Documentation/bpf/bpf_devel_QA.rst
> +++ b/Documentation/bpf/bpf_devel_QA.rst
> @@ -690,6 +690,7 @@ when:
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/tools/testing/selftests/bpf/
>  .. _Documentation/dev-tools/kselftest.rst:
>     https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
> -.. _Documentation/bpf/btf.rst: btf.rst
> +.. _Documentation/bpf/btf.rst:
> +   https://www.kernel.org/doc/html/latest/bpf/btf.html
> =20
>  Happy BPF hacking!

For consistency with my fix above, can you please convert these in-tree lin=
ks
=66rom using external link to simply write the doc path instead?=20

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--zZnDlUkIXd7iZ9Tf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY/XYLwAKCRD2uYlJVVFO
o5iFAQC8pJCj/VFWlPFK/YFAkCc2//kK9QkP0m9kOCGBdbAikQEA5BWum972U2Tb
L8rX+lZL3R20C1dBg/2vxcJL3fS4kQQ=
=lRJM
-----END PGP SIGNATURE-----

--zZnDlUkIXd7iZ9Tf--
