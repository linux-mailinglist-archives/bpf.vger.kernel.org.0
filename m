Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0815806CE
	for <lists+bpf@lfdr.de>; Mon, 25 Jul 2022 23:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbiGYVbj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jul 2022 17:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237276AbiGYVbV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 17:31:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044692612C
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 14:28:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7122D6120A
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 21:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF0FC341C6;
        Mon, 25 Jul 2022 21:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658784537;
        bh=x6SNcnchPErn0FaTDWKXwVp3khI0kLelzjgjy4jsLUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qaC3jJGUYu/NbbgWUsn9xdi0m15tRBdNp7/EsuQv1d6wHhQa4Sl1oDsPdwg2BsW9d
         zrnfoln0/kR05+/3JXzwSWgtuRs0Zjxko9Cy1NhRRsLh2eUDtWmVuYJxBCCRp6d753
         DdD1XIJ76pNOXOsMnT5XzR+SgTRzItu0aj5DWyg5emoVKdyDJ+f7nmLzo2eeDugRuG
         jUlzTJ23hNBB2fxwSWc9bZfLKHD4vfgAABF/TJa6MJh4mofjCXVgZgUfQFuqLQCUzJ
         sxtsHI7m075SNGbINu8gTQn/OFrsse4TtwPrug9odAWA7ELYAZhb5PdrXrPIHpcgog
         VCqGgQuy54+mw==
Date:   Mon, 25 Jul 2022 23:28:54 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
Subject: Re: [PATCH bpf-next v1 1/1] bpf: Fix bpf_xdp_pointer return pointer
Message-ID: <Yt8LFp7jGUoYiw7Z@lore-desk>
References: <20220722220105.2065466-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cO92oy06YnQQEcZ7"
Content-Disposition: inline
In-Reply-To: <20220722220105.2065466-1-joannelkoong@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--cO92oy06YnQQEcZ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> For the case where offset + len =3D=3D size, bpf_xdp_pointer should retur=
n a
> valid pointer to the addr because that access is permitted. We should
> only return NULL in the case where offset + len exceeds size.
>=20
> Fixes: 3f364222d032 ("net: xdp: introduce bpf_xdp_pointer utility routine=
")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  net/core/filter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 289614887ed5..4307a75eeb4c 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3918,7 +3918,7 @@ static void *bpf_xdp_pointer(struct xdp_buff *xdp, =
u32 offset, u32 len)
>  		offset -=3D frag_size;
>  	}
>  out:
> -	return offset + len < size ? addr + offset : NULL;
> +	return offset + len <=3D size ? addr + offset : NULL;
>  }
> =20
>  BPF_CALL_4(bpf_xdp_load_bytes, struct xdp_buff *, xdp, u32, offset,
> --=20
> 2.30.2
>=20

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

--cO92oy06YnQQEcZ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYt8LFQAKCRA6cBh0uS2t
rCOlAQCCKyApfaDBpyF2mCuc3RhC1sgxcg1CAynlafE+AMp+4QEA4embo1ielTI4
mq9Ol/p9dYOfkBqzC9blWMNrZZksewo=
=3caK
-----END PGP SIGNATURE-----

--cO92oy06YnQQEcZ7--
