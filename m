Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDCF6251BE
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 04:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiKKDhO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 22:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKKDhN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 22:37:13 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F45B3FB97;
        Thu, 10 Nov 2022 19:37:12 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso7046755pjn.0;
        Thu, 10 Nov 2022 19:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UpLIPoTOVASCSlXTwISNDCxecZwjTUnBDUOg439sSQM=;
        b=X7t+saoG1f9rGEOEiKdP5URD5BZyPn6p6MiaJZl31dpYGX2OVvavoIMLP4047EAQNp
         GJXRVjK2Oh9xH/mtCk6hMEZHGLEd8mtdEf8oUcc4EOVkqHGzJlPKsSjiD5gpJ+7Q9JmS
         56/5Ny7sEyRHFTBQeCu3OAnRH61VIjl08QdZSclWrIVoMiTOHreOaafvMDi+e+qz5yw7
         V5YvhwRCf4h+eKuIdaBvScagPQNv2H85Dry9i7Y0l6EE28DyvxYmZUC7ajlRFaLNBSkq
         O18zz/OpRDwUPTsWIRX2t7rYr89lzrBKtayvAIRxm0xPPCzOC3wJ//2c2SNSFtkcsMee
         CMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpLIPoTOVASCSlXTwISNDCxecZwjTUnBDUOg439sSQM=;
        b=dGzhyR8vTdaY81KB00+0nUyHqPX0lz98NxlueACqYOYR8+0nVl4HZ/ETi6/Qx2ikCp
         LQKLL1YqQkq1RbuNYjERtArGPtb6NmZomAfSeS5U4Rf0RwgRsUOf4JzfC0uQjZ8+R4ds
         njYpkm3MeUIjQ9ROQlcjJeHpatsAHkhbByy5JNcf/nG0senImimkpRiU4kjxB1WEM0Hv
         DOi4HgFuOrO1L2/B6+FS5xWaPcoXoCoBIiGv2DjqMVE+eK4wagNVfTpn+HAOSFQ8d3oq
         NEnCXMCiG/LysXHEkYtoGSccTfiEHsE79teNEhT0Uwh3JKWWI82rLKJCRV63FtYPqh3w
         1HVQ==
X-Gm-Message-State: ANoB5pmlGXrT4VDPKyKU/B/tVtR5IbF79b/IHni22U1KuKb7v+/dczk5
        LeW50+ls5EuxjAC6kDNR1jU=
X-Google-Smtp-Source: AA0mqf73BjCPxg5HyxMLElofxbPoFQy7G0PeNGYuVaj6gJ28RISfKJKW0IWyvC31auwuO/3a9nsOBw==
X-Received: by 2002:a17:902:ea85:b0:186:8bca:1d50 with SMTP id x5-20020a170902ea8500b001868bca1d50mr606941plb.158.1668137831946;
        Thu, 10 Nov 2022 19:37:11 -0800 (PST)
Received: from debian.me (subs03-180-214-233-90.three.co.id. [180.214.233.90])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902ab8100b00174c1855cd9sm433968plr.267.2022.11.10.19.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 19:37:11 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 8E40E103C71; Fri, 11 Nov 2022 10:28:18 +0700 (WIB)
Date:   Fri, 11 Nov 2022 10:28:18 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     mtahhan@redhat.com
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, donhunte@redhat.com, yhs@meta.com,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next v8 1/1] doc: DEVMAPs and XDP_REDIRECT
Message-ID: <Y23BUlmDrRgPCapY@debian.me>
References: <20221110160818.1053910-1-mtahhan@redhat.com>
 <20221110160818.1053910-2-mtahhan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6sFJFZAKsSLwQKvi"
Content-Disposition: inline
In-Reply-To: <20221110160818.1053910-2-mtahhan@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--6sFJFZAKsSLwQKvi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 10, 2022 at 11:08:18AM -0500, mtahhan@redhat.com wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
>=20
> Add documentation for BPF_MAP_TYPE_DEVMAP and
> BPF_MAP_TYPE_DEVMAP_HASH including kernel version
> introduced, usage and examples.
>=20
> Add documentation that describes XDP_REDIRECT.

Shouldn't two documentations be separated into its own patch (thus
creating 2-patch series)?

=20
> +XDP_REDIRECT works with the following map types:
> +
><snipped>...
> +Silent packet drops for ``XDP_REDIRECT`` can be debugged using:
> +
> +- bpf_trace
> +- perf_record

XDP_REDIRECT is inline-quoted here, but plain on other places. I would
like to keep that above plain instead.

What about below instead?

```
Silent packet drops for ``XDP_REDIRECT`` can be debugged using either
bpf_trace tool or ``perf record`` command.
```

Otherwise LGTM.

--=20
An old man doll... just what I always wanted! - Clara

--6sFJFZAKsSLwQKvi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY23BTQAKCRD2uYlJVVFO
o6wAAP9thL7Ab1Zlgfhrf1+HEMGzGo/CRxS80f3F7DmsM9lbkAD/fsGKk5wixSIT
/IPoDJxiCjeFozuY/dsIUtkOVvrPuAg=
=4NRD
-----END PGP SIGNATURE-----

--6sFJFZAKsSLwQKvi--
