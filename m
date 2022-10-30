Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22063612AA8
	for <lists+bpf@lfdr.de>; Sun, 30 Oct 2022 14:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJ3NCA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 30 Oct 2022 09:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3NB6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 30 Oct 2022 09:01:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADAEB7ED;
        Sun, 30 Oct 2022 06:01:58 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b11so8325978pjp.2;
        Sun, 30 Oct 2022 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CGx9xgGlypD6vVPYmtIKlqqJfCzM1AZBhS44ab9RgX8=;
        b=jQOTQEKGb+CIG41bB4XJioqsJ7kZmT8CSPy6y7afGzMQSiSUzigjjVXXnzNnGtBpie
         XDGK4QNV9j0Q5nJ4NwjOopdzQBkRctDKCb5xiG34iK0iK6TASwTKT8z817KUGkgHwogG
         aENRy8VOAMUJZsMr45PVeLeGxL5S26daCJKmXjkjK8wt3q27kcATyoFHW5EcMNcL5hLb
         FSHh8zmC9Qc9dw+m9zW3xs8TtRlCw9DkJIbra0x2+LZUJAsNFfflBFcmvidch/zc9e7p
         QvZg41KE62VJkqCS8IHPLHroI2twY4Dp6MDDFqE6oZ1MAXCiqGC3f4UtadVB0xsTr88T
         AEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGx9xgGlypD6vVPYmtIKlqqJfCzM1AZBhS44ab9RgX8=;
        b=CwaESYa1EYr7+XCj0/wbhNtDVHG7ajlaX0H+DQyOS/mp9xfOtR9anU+PGlWdpUkkRz
         WoVQAM6UpgRAbjLu3RbmuRYciok19KDeL0CsimIkTMy53TU/g4M4rbLv5ujJrGY4JkiO
         6vUaUoOv07Jj6MQCGesWBX6tmmVJ7vGI0GkJD7qc/aq2WpjQImvRTdX0E657BVEOXlyl
         3A4+JntkpFFSt2qfWqz0PVEEpDO+dqe7PKD+h04KqXXvt+aIi8QE5g2GyMalHMrztbgQ
         Q4KfEpu0JFw+My3w6HXketyZVIWnVL6fGRNZhv1jMs9BqbTenoKo6YsVhZMJY4cw9T4X
         Hn8A==
X-Gm-Message-State: ACrzQf3Y1j3WxDLsCH3RGcLLbcbn683NKCDXV+boXwgD1M8UrHm9r8WY
        xGiNMyuLyfa8/HYM5/LDLOE=
X-Google-Smtp-Source: AMsMyM6J9IPO9aGKH/fadSzI48k3nLGW6+R3RdwgRUHwae/Pdt8yZIQLkmzKcmpU8JSR0tMe+4o8CA==
X-Received: by 2002:a17:90b:3b49:b0:213:854f:f796 with SMTP id ot9-20020a17090b3b4900b00213854ff796mr16181341pjb.216.1667134917921;
        Sun, 30 Oct 2022 06:01:57 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-87.three.co.id. [180.214.233.87])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902cf0200b0016dbdf7b97bsm2664526plg.266.2022.10.30.06.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 06:01:57 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 9B342103D98; Sun, 30 Oct 2022 20:01:52 +0700 (WIB)
Date:   Sun, 30 Oct 2022 20:01:52 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Kang Minchul <tegongkang@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples: bpf: fix typo in README
Message-ID: <Y151wBUkhDHbhzzq@debian.me>
References: <20221029211520.24033-1-tegongkang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CJGNwHFZsEtqqkbV"
Content-Disposition: inline
In-Reply-To: <20221029211520.24033-1-tegongkang@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--CJGNwHFZsEtqqkbV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 30, 2022 at 06:15:20AM +0900, Kang Minchul wrote:
> This commit fixes a simple typo in samples/bpf/README.rst
>=20
> changed cofiguration to configuration.

Better say "Fix 'cofiguration' typo in BPF samples README".

And please write patch description in imperative mood instead of
descriptive one.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--CJGNwHFZsEtqqkbV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY151uQAKCRD2uYlJVVFO
ox/4AP4ni83os89lwGA309i2eGhaLOIJlFiGESqNNRR6bujGMgD/RCkttusAKxXN
5HuMOkcgMpe7vdD0COjy/M05RHbW1gc=
=Ljlk
-----END PGP SIGNATURE-----

--CJGNwHFZsEtqqkbV--
