Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA8A6A53E4
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 08:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjB1HtB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 02:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjB1HtA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 02:49:00 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F8021944;
        Mon, 27 Feb 2023 23:48:59 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id i10so9497787plr.9;
        Mon, 27 Feb 2023 23:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677570539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZ/cMOGvS9DzjygK7cuVRUjCO9JEh86G/ox5bXVC1DM=;
        b=Ij0jwP9fnA69PUrdtWGb8EbhWqgJqexb3xA7TQc08Xu9EHMKIfbkBjj6k5SAkaP40s
         eS31l/nj5qUoJw7wFfyl3+aj2F0r/UuyC7wLJ2jPzFcoNTD12Zcoy05swq2e71FdpcA1
         rZI1mo7OlOr6fU5k648vHXFluETYrJtOiL/p7LGD1qtKkwRCUSEy8numijqUImZ4Zq3r
         xaqqXW2PEc6nc5l/4Ig7aGxNpLCS0VGeO2zdxjQrReirAVcEjr6luYYrfl7Lv1CUoXqq
         t92npfkOzY9LvMNUm+o7RaSEtTg1s6bK9uxsGWE8B7OTWp7+eH+goeJ+qk8X6PeXsL5d
         v4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677570539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ/cMOGvS9DzjygK7cuVRUjCO9JEh86G/ox5bXVC1DM=;
        b=GnZ1bl78bR87Vhpoq21YYFZmhaGEhl/BX2HMz9tytJ50PdpnF6GdpnPvLeirHdeCD9
         IEm+zgc5c2czYXNQlwT3OP/5qGoHGziMqN9pjTw4EkHi6eNlyUuJjiB/GLvakQsQdVHa
         6sk7b76uLSwSTcMLZpZDRm/NfTUT4r6oW/mrekFaGkXsXCC9mugO9jVRJFQ+9vLRILqq
         Q4WwOSgABPjHkxVRyqxT6/ZmkjHfjYBtS+ALXCQQ+eZtYswjR7qUroh6FSCPwUZN6+md
         27fPb5bxyboOmyIfBkIQL993eu/Q/ykmdq+Ju25x0rQFh0cWPcsMWoS9qkIYN9QvdwbU
         dptA==
X-Gm-Message-State: AO0yUKWeoUrRxNETuPN1GDvS6Ec2SayB5QnPMVqHC50OXkxCVQbitv5O
        Lxj3s5HuVCRHq608DKSQlZA=
X-Google-Smtp-Source: AK7set8eLvHNV7YHP1gioNaAbF6VlT10U9X1GZRH6Ak9TXlvMxUhS0gr+7q/4hJWQXEKtTgX1vK5EQ==
X-Received: by 2002:a17:902:8542:b0:19c:eb42:883 with SMTP id d2-20020a170902854200b0019ceb420883mr1546287plo.49.1677570539275;
        Mon, 27 Feb 2023 23:48:59 -0800 (PST)
Received: from debian.me (subs02-180-214-232-86.three.co.id. [180.214.232.86])
        by smtp.gmail.com with ESMTPSA id v1-20020a1709028d8100b00194d2f14ef0sm5840192plo.23.2023.02.27.23.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 23:48:58 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 3407310105C; Tue, 28 Feb 2023 14:48:56 +0700 (WIB)
Date:   Tue, 28 Feb 2023 14:48:56 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Linux BPF <bpf@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Ross Zwisler <zwisler@google.com>
Subject: Re: [PATCH v2] Documentation: bpf: Fix link to BTF doc
Message-ID: <Y/2x6KLsGecrIIok@debian.me>
References: <20230222083530.26136-1-bagasdotme@gmail.com>
 <7cd545a2-4a5c-1961-1cf7-cd0f24e41df8@iogearbox.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NknHNgPSc3zXNhzD"
Content-Disposition: inline
In-Reply-To: <7cd545a2-4a5c-1961-1cf7-cd0f24e41df8@iogearbox.net>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--NknHNgPSc3zXNhzD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2023 at 10:11:52PM +0100, Daniel Borkmann wrote:
> Applied, thanks! Looks like kselftest.rst has a similar issue, could you
> send a fix for this too?
>=20

The fixup is in the recently sent miniseries at [1].

[1]: https://lore.kernel.org/linux-doc/20230228074523.11493-1-bagasdotme@gm=
ail.com/

Thanks!

--=20
An old man doll... just what I always wanted! - Clara

--NknHNgPSc3zXNhzD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY/2x5wAKCRD2uYlJVVFO
ozomAP9wHAiFW7w91ha2sqjjxGSuQd1FWDB+nPzOJ62PKMVVaQEA1XFaqfEd4wkg
5yiZyLLrL5Rxbr05XArUniNHcW0S3gM=
=xS9a
-----END PGP SIGNATURE-----

--NknHNgPSc3zXNhzD--
