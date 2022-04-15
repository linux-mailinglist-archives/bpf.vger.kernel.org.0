Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A4B502E70
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 19:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344322AbiDORw7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 13:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343970AbiDORw4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 13:52:56 -0400
X-Greylist: delayed 422 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Apr 2022 10:50:28 PDT
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A0C8EB4D
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 10:50:28 -0700 (PDT)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1nfPyU-00005a-H1; Fri, 15 Apr 2022 13:43:14 -0400
Message-ID: <2bff92c8080441550416d481d719aa26ebd2e47b.camel@surriel.com>
Subject: Re: [PATCH v4 bpf 1/4] vmalloc: replace VM_NO_HUGE_VMAP with
 VM_ALLOW_HUGE_VMAP
From:   Rik van Riel <riel@surriel.com>
To:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        akpm@linux-foundation.org, rick.p.edgecombe@intel.com,
        hch@infradead.org, imbrenda@linux.ibm.com, mcgrof@kernel.org,
        Christoph Hellwig <hch@lst.de>
Date:   Fri, 15 Apr 2022 13:43:13 -0400
In-Reply-To: <20220415164413.2727220-2-song@kernel.org>
References: <20220415164413.2727220-1-song@kernel.org>
         <20220415164413.2727220-2-song@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-JHt/Js2fL2sMaIIVT/FN"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-JHt/Js2fL2sMaIIVT/FN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-04-15 at 09:44 -0700, Song Liu wrote:
>=20
> Fixes: fac54e2bfb5b ("x86/Kconfig: Select HAVE_ARCH_HUGE_VMALLOC with
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HAVE_ARCH_HUGE_VMAP"=
)
> Link:
> https://lore.kernel.org/netdev/14444103-d51b-0fb3-ee63-c3f182f0b546@molge=
n.mpg.de/
> "
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Song Liu <song@kernel.org>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-JHt/Js2fL2sMaIIVT/FN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmJZrrEACgkQznnekoTE
3oPzPwf/S4QLbls0JXyAHaxYf0wp8jsqRi8kyRfTzTBxnlYxgo/ZEKwouZIr4DuI
RYQ3pixp0bFIQuMVlwEqk9DllZIC/wMgY23xOtXLsXQDABLEVzkgAuE9rAwTMgzc
1u96joK5BvtRGsw2nhOPJ/9HS845VEmjg9paYADV7Hji4I+rVmMqDgAj65foLOXw
/MR/KsFuFzhdH+/QHa5orFpQ3siEE6w8nwD6PL31hjVMr4SsKBzyCcifPQLUMSMS
DhFAa5C3y3A46cL/sAI4habJ7QX6fFs6ha5RWL/F4cTb2fNYbM5gTw2vqMPfRtfw
ois/WPX8s3mh7dlQJHyrmGZj/eEWGQ==
=TGwA
-----END PGP SIGNATURE-----

--=-JHt/Js2fL2sMaIIVT/FN--
