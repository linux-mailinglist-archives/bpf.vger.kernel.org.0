Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05E86E28BC
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 18:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjDNQxK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 12:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNQxJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 12:53:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D398B2D4A;
        Fri, 14 Apr 2023 09:53:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BDCE6395A;
        Fri, 14 Apr 2023 16:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D56C433D2;
        Fri, 14 Apr 2023 16:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681491187;
        bh=TwhF5J27HzRurokF8R/n+hFAGJwlT8+7oNFFxg5tODM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cOJr7x5nwhbRSI3og+L20yzje9CAcJD1KKuizRZL/ab/CKrQXZsNHZRxWErAqJ0ck
         UrKiMXsqk9KWumBxlTEMIQhVvK9fmu6GPFLuu9TwBXQ1FV8K9soRzIYcfiQwLj5mqi
         Pq90f3u4U605dWTKKvlc6k8UECCLqcm9US3hGWXA/bYu9ynPt0VYSe27p940vO0zfG
         wPx+D1/BvPlrZEwbcFrbs1pFHpzOgPtEzE+tlWAHRK62NbVYYbVvL7Nc7F4q8KXcgh
         NWHHjlnfAvwJdxvLWk0reRXTWrb+0rLnnliQByHhHVhCyl8VDZ82khX6JDZyrBXG2F
         NsyV//+qslIBA==
Date:   Fri, 14 Apr 2023 17:53:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Howlett <liam.howlett@oracle.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>, bpf@vger.kernel.org,
        linux-next@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH] bpftool: fix broken compile on s390 for linux-next
 repository
Message-ID: <9d3489e4-764c-4a42-9064-869fc5d6e0dc@sirena.org.uk>
References: <20230412123636.2358949-1-tmricht@linux.ibm.com>
 <3f952aed-0926-eb26-6472-2d0443c1a0ff@isovalent.com>
 <ZDkTBjBSWTHhvB3B@osiris>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EgWDVP5GzPpbgn1F"
Content-Disposition: inline
In-Reply-To: <ZDkTBjBSWTHhvB3B@osiris>
X-Cookie: One Bell System - it works.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--EgWDVP5GzPpbgn1F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 14, 2023 at 10:47:02AM +0200, Heiko Carstens wrote:
> Full quote below for reference.
>=20
> Mark or Stephen could you please add the patch below to linux-next?

Could someone please send me whatever patch is being referenced here?
This looks like a quoted backtrace of some discussion.

--EgWDVP5GzPpbgn1F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ5hO0ACgkQJNaLcl1U
h9AxOAf/XqtzERiB321Kxo7A9vwc1nRjKbj+A7jCrBYCBwY1CvKnDtrg2rcr96sS
IVoWDnN3H6XwXwl+9SQFv4AZStVUFT+ueLxlARpEr19NjKCJkYuceTwqfJeITOLO
MvdvX2IyiU2Wn2vqpbPN9zuvFl5rNHLpBTUe0jk/W30w+cWdX7T9qe4L5Jv9lg+c
hvqnO5FcBWyjCUmH34aLucF9ZKIfAauI2Avt03FOnBCfMFoao0mI8kSNWbiOjWGW
jsNeNeELjyQ61oOkAtvGjZh2EyTV7ts7GMpJMLaUDtbEaN0LFTzTgiMSmRZcyh0D
SBgpfPZOUU1U/AmtUcsTPZyHmrHIgw==
=3DtP
-----END PGP SIGNATURE-----

--EgWDVP5GzPpbgn1F--
