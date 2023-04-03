Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1586D3C2F
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 05:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjDCDlf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Apr 2023 23:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjDCDld (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Apr 2023 23:41:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75778A55;
        Sun,  2 Apr 2023 20:41:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so29108921pjb.0;
        Sun, 02 Apr 2023 20:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680493292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FXg7HFo8IGOwcXz+xhhxTe6e3AAoC5T1g7VGxj4ZrTU=;
        b=GQMh9Mc66DJQmu3ozynlsyvpfEs2UHpQQq3PLKnmT5DOBz73qqb2LSX9XWX8O9sNOk
         LVF7JaOsCdxo4lB8gW09vEx411Dh8psSegvwjBc0H1QBD6TsX1fAm4zbhDfqYdsXrlGO
         ugeUsJ4Ah/04bj/Tye0jIXFl47Y5UsDp/Iab6YNi2L21rLEMOfUZpGdSRZEYs8+6Wluj
         lUEqJDdkp8n8fXf/4wIDaRjQdVZGKipQEnBJVDdEENGgEljZCE/chAFyN0b7+pxWqv+j
         pA+mi6PxK+w72E6M/T0XHUraXxJJKjMQHYpVbXKAQKS56rb/QdhvI9qU3PBez8yLdasw
         NR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680493292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXg7HFo8IGOwcXz+xhhxTe6e3AAoC5T1g7VGxj4ZrTU=;
        b=A0OkkuyJltpFR9naf2X1HK74OiJlTscY6Mrd2eJLls+xdGWIGZ4stS8T0caaE3HFpC
         mf5uFAbJQ8eIslHwNRjNuorfwGWgdLpCFsizPB8EcJcjfDUps20skLPugjOOATgO2DsH
         rjr2SBRu/AeR+OjH1MW9sJM52ibPQ2D+EkXWLc+/EuHN0W9nbA3Y2onLq6SHpUtZgihn
         vjr0F26Csb39Xlm9HWI8AD6Agvt99M3o75hNJt4Jbv6qbEORh+uYIcmKWIEHTL7bFrMe
         xOHgjBZeKwSJfS5HZP6JmIxEfvmil+J1/yYK0apbTGVAi6C/6No77+0MIoOOmoIgzGrS
         mUNg==
X-Gm-Message-State: AAQBX9dm3+INJ/mLNe8SUNvxdicBbBuAgSg1/22ru1hGaCgOrVrbFxG0
        JJ1ZrinCgbxXmqQsefkZEID1Q2VP97c=
X-Google-Smtp-Source: AKy350Zj8qEaJ+ZabiLCgRpf2zuuu+PDP+ydP0Spb/wnTC7MJGQSvPJqCeW61Xy8SbFBrmDX/0gbIQ==
X-Received: by 2002:a17:902:f785:b0:19e:2860:3ae8 with SMTP id q5-20020a170902f78500b0019e28603ae8mr39191402pln.33.1680493292013;
        Sun, 02 Apr 2023 20:41:32 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-12.three.co.id. [116.206.28.12])
        by smtp.gmail.com with ESMTPSA id v19-20020a1709028d9300b0019d397b0f18sm5455896plo.214.2023.04.02.20.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 20:41:31 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5795110679D; Mon,  3 Apr 2023 10:41:27 +0700 (WIB)
Date:   Mon, 3 Apr 2023 10:41:27 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     kernel test robot <lkp@intel.com>,
        Joe Stringer <joe@isovalent.com>, bpf@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, corbet@lwn.net,
        martin.lau@linux.dev, maxtram95@gmail.com, john.fastabend@gmail.com
Subject: Re: [PATCH bpf-next v4 2/2] docs/bpf: Add LRU internals description
 and graph
Message-ID: <ZCpK5wOI0ZEedhrr@debian.me>
References: <20230401200651.1022113-2-joe@isovalent.com>
 <202304022107.IwHc05cs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ilTwJv3f+pqw84Rg"
Content-Disposition: inline
In-Reply-To: <202304022107.IwHc05cs-lkp@intel.com>
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


--ilTwJv3f+pqw84Rg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 02, 2023 at 09:47:49PM +0800, kernel test robot wrote:
> All warnings (new ones prefixed by >>):
>=20
> >> Warning: Orthogonal edges do not currently handle edge labels. Try usi=
ng xlabels.
>=20

Hi,

I can't reproduce the warning above. My system has graphviz 2.42.2
installed (via Debian package). What graphviz version do kernel test
robot have?

--=20
An old man doll... just what I always wanted! - Clara

--ilTwJv3f+pqw84Rg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZCpK4wAKCRD2uYlJVVFO
ozQcAQCj8UTVKu5oY+LWQWX0nnujGgsrcAZl1lt6077X3AedOAEAgYGC9Us8sPRg
ZPi23Z3f3810sBuRzxVOC9SzIa6oqwc=
=bziQ
-----END PGP SIGNATURE-----

--ilTwJv3f+pqw84Rg--
