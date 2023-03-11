Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF4A6B57BD
	for <lists+bpf@lfdr.de>; Sat, 11 Mar 2023 03:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjCKCOW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 21:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCKCOV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 21:14:21 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B318812B03A;
        Fri, 10 Mar 2023 18:14:19 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so11692726pjg.4;
        Fri, 10 Mar 2023 18:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678500859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Th+pbPHwUfIznt5t3aYufVmsSA6jXeeaBN7D/5f6K1k=;
        b=URVrSNrTk7lDWS57IoA6Fabw22VHJ0/qAwQLyM5yn+Fpjiq0Ib5rqOIvveeMWmFQKY
         CyYelRlNJUxNvTHXB5lqn6KdZgIn8Q36QGjr8vOzmVv1TAxtOQE/c1dqLFwZ0Xuz7sMp
         HI7gzXMOTf06X/C6NltU/ONsJV+acrlB8TsvFOoQDFQP2lyVkDT0TMMOlbrpwgeK1jdo
         YAjxjegMDbFC0LFnoR4ji9LZmCUzs6l67h6afrEAFeIA6tbBQuLaPlJ6mA9oJ6HE16D8
         LK5Y301gpZtdp6PbP3OU7FQW07dlmH1lrTNQgyy8wny0QxL8cqFoie0vdzX/XEmhg5dz
         aTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678500859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Th+pbPHwUfIznt5t3aYufVmsSA6jXeeaBN7D/5f6K1k=;
        b=r8VHEkt0WiHqguOs6q0sh1yI8NzOdQ2eMODyCUeRFKGDUNueXrjk4cH3fX8ibFTQT9
         mqycRtc8GEDnxYK5W36q9eLjoMqNN+89WOEUZQ8/r90bl6Vcf44/+TKgjnXLBqBViFAU
         dexgyTnOKXP6eBRuzsk23QbSgi/PYa4j2cw2nRrZuWmAmB9GLn4Jbq5zen09kStsQaz2
         Vjs3j/FgJFA4lAHIz3O8Fa/WWEUqYLrDJ7iaz5sZMEXIPLJG5F9WQ3VJUoM5mIEDtotD
         KOkz96te4PDUtjXpB47ySaqcChus7dyx3qhpVmPnYzR8hfPLg/8fSdAHJqJbQOaMnHR/
         oXDg==
X-Gm-Message-State: AO0yUKWE+kSRKWWNm0QqdoRI14udfKGbvzbiOP7PJ3kWa6OJEu36fjt/
        +ntqUbKvXKcupFxLHnHkx8o=
X-Google-Smtp-Source: AK7set+m2LCt6qX8jXKfsp0o8SUC4txHmHMqI1q7pruEdftPUf58X6vd9VnTgp511/2BMXL4fDbyUg==
X-Received: by 2002:a05:6a20:3cab:b0:cd:3bca:cfa2 with SMTP id b43-20020a056a203cab00b000cd3bcacfa2mr29722214pzj.23.1678500859071;
        Fri, 10 Mar 2023 18:14:19 -0800 (PST)
Received: from debian.me (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id d5-20020aa78e45000000b00593e4e6516csm417945pfr.124.2023.03.10.18.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 18:14:18 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 3965E1065AA; Sat, 11 Mar 2023 09:14:10 +0700 (WIB)
Date:   Sat, 11 Mar 2023 09:14:10 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sreevani Sreejith <ssreevani@meta.com>
Cc:     void@manifault.com, psreep@gmail.com,
        Linux BPF <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andrii@kernel.org, mykola@meta.com,
        Linux Documentation <linux-doc@vger.kernel.org>
Subject: Re: [PATCH V2 bpf-next] BPF, docs: libbpf Overview Document
Message-ID: <ZAvj8q1C1vhGX4kT@debian.me>
References: <DM4PR15MB53548D70925C64EE3CEF8F86CABA9@DM4PR15MB5354.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mOE/t2XkG9SdZEvj"
Content-Disposition: inline
In-Reply-To: <DM4PR15MB53548D70925C64EE3CEF8F86CABA9@DM4PR15MB5354.namprd15.prod.outlook.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--mOE/t2XkG9SdZEvj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2023 at 04:11:38PM +0000, Sreevani Sreejith wrote:
> Thanks, Sanjaya, for taking the time to review. I will submit a patch wit=
h all the changes you suggested. I left the emphasis on the code line as is=
=2E If you have a strong suggestion to remove it, let me know.
>=20
> Also, this is the first time I am sending a reply to a patch. So please l=
et me know if I have to adjust the reply format.
>=20

Hi,

It seems like you reply with HTML format, which makes plain-text
formatting looks messy. See Documentation/process/email-clients.rst for
how to configure your email client to send plain-text emails.

Also, please reply inline with appropriate context while keeping list of
recipients in To: and Cc: intact (via "Reply all" button in your
client). I have to add original recipients back since these are omitted
=66rom your reply.

Thanks!

--=20
An old man doll... just what I always wanted! - Clara

--mOE/t2XkG9SdZEvj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZAvj6QAKCRD2uYlJVVFO
o9ViAP9MnGibNFkFvnc4fwSPcgj7P86cNwAXoe7to9S12qpljwEArSiIuPpRET+f
lufOY2W/XIXAc4PTUuyF7GHqWpbXggM=
=mPH8
-----END PGP SIGNATURE-----

--mOE/t2XkG9SdZEvj--
