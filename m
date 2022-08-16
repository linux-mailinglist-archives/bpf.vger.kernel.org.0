Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6F35959CF
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 13:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbiHPLVh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 07:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbiHPLVO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 07:21:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B97AC3ED73
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 02:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660643136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yvg/jdpiTYU8FTbXqqsbsmwkU/yFqn/1mx8jKK11tYw=;
        b=TCIyAz5TQKaxtaEA5qsXSygGH7vCf8dm/TcxYwznTigxqylbpjNBJ5M/4Zax2luY01wTP4
        RvxQfKy1x/ToYoPw6pXLMIUd88GL9Mp8m720xrFOowAxYA9ssyz49HyAwG0wzFeiqeajq/
        LX3RfVDBRVVsutg2oEpKd6IPC0wrcdg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-551-_T-D2GA1OvGOrkBrVUAx0A-1; Tue, 16 Aug 2022 05:45:33 -0400
X-MC-Unique: _T-D2GA1OvGOrkBrVUAx0A-1
Received: by mail-ed1-f69.google.com with SMTP id z6-20020a05640240c600b0043e1d52fd98so6478803edb.22
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 02:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=yvg/jdpiTYU8FTbXqqsbsmwkU/yFqn/1mx8jKK11tYw=;
        b=CPWxlRKKFA6k0pdec6tI91aJSyv77aF7J6pLPuhUnV4SahZ+VkHvLkY5huYSHk4slu
         PEyXiZZi/Ejr/xzKkNd2cSNXvnMk2LL2IVTxPu+gDvtqJQGSe4XlY8wYNQViVOYG7vqQ
         Q+ZQRJjSK9XCgOt0Xfg0aNHP3+UWNVhAepyquocE7vv0U0TEGEjESPVPb8SKty/jLrMJ
         mO2oeG8Ne+3xR1T54VT9xukY/O1tLYO6oQNRa+UAa2rn4uoatZcmbBQrxF6feiZ6dhSg
         FEJ/1bKsHelCppFpIlS10E9CYcmLnGY/806H3SOr0tZQNqONBTyuynCoqj74I7VF2zF8
         465w==
X-Gm-Message-State: ACgBeo1zD5z6XMtgv/dQl2LYmYQRBIIvt5ND5Bsm3pXNTVoHBZKLPu3M
        fVigYfsSi3yzVVafs11sHnS3Fz4jXVbNvIsuMimBnk7Nsv1LEOxI5vHrLvtZpwucWZG5ZOsIWjf
        2hwMmOzGOTu06
X-Received: by 2002:aa7:cf13:0:b0:43d:603a:b736 with SMTP id a19-20020aa7cf13000000b0043d603ab736mr18868709edy.20.1660643132383;
        Tue, 16 Aug 2022 02:45:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR40EAKTxJPysR9n1WcUKBALU/QpdD7jytJnsqiEczKQBFn1Q2MZfmdgjrIoruj09iUjMFh0lQ==
X-Received: by 2002:aa7:cf13:0:b0:43d:603a:b736 with SMTP id a19-20020aa7cf13000000b0043d603ab736mr18868704edy.20.1660643132211;
        Tue, 16 Aug 2022 02:45:32 -0700 (PDT)
Received: from localhost (net-93-71-3-16.cust.vodafonedsl.it. [93.71.3.16])
        by smtp.gmail.com with ESMTPSA id e20-20020a50ec94000000b0043c83ac66e3sm8148081edr.92.2022.08.16.02.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 02:45:31 -0700 (PDT)
Date:   Tue, 16 Aug 2022 11:45:30 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
        kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
        hawk@kernel.org, john.fastabend@gmail.com
Subject: Re: [PATCH bpf-next] xdp: report rx queue index in xdp_frame
Message-ID: <YvtnOloObaUxpR1O@lore-desk>
References: <181f994e13c816116fa69a1e92c2f69e6330f749.1658746417.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IoiytQITDcaWi1MG"
Content-Disposition: inline
In-Reply-To: <181f994e13c816116fa69a1e92c2f69e6330f749.1658746417.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--IoiytQITDcaWi1MG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Report rx queue index in xdp_frame according to the xdp_buff xdp_rxq_info
> pointer. xdp_frame queue_index is currently used in cpumap code to covert
> the xdp_frame into a xdp_buff.
> xdp_frame size is not increased adding queue_index since an alignment pad=
ding
> in the structure is used to insert queue_index field.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/net/xdp.h   | 2 ++
>  kernel/bpf/cpumap.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)


Hi Alexei and Daniel,

this patch is marked as 'new, archived' in patchwork.
Do I need to rebase and repost it?

Regards,
Lorenzo

>=20
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 04c852c7a77f..3567866b0af5 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -172,6 +172,7 @@ struct xdp_frame {
>  	struct xdp_mem_info mem;
>  	struct net_device *dev_rx; /* used by cpumap */
>  	u32 flags; /* supported values defined in xdp_buff_flags */
> +	u32 queue_index;
>  };
> =20
>  static __always_inline bool xdp_frame_has_frags(struct xdp_frame *frame)
> @@ -301,6 +302,7 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct xd=
p_buff *xdp)
> =20
>  	/* rxq only valid until napi_schedule ends, convert to xdp_mem_info */
>  	xdp_frame->mem =3D xdp->rxq->mem;
> +	xdp_frame->queue_index =3D xdp->rxq->queue_index;
> =20
>  	return xdp_frame;
>  }
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index f4860ac756cd..09a792d088b3 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -228,7 +228,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_ma=
p_entry *rcpu,
> =20
>  		rxq.dev =3D xdpf->dev_rx;
>  		rxq.mem =3D xdpf->mem;
> -		/* TODO: report queue_index to xdp_rxq_info */
> +		rxq.queue_index =3D xdpf->queue_index;
> =20
>  		xdp_convert_frame_to_buff(xdpf, &xdp);
> =20
> --=20
> 2.37.1
>=20

--IoiytQITDcaWi1MG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYvtnOQAKCRA6cBh0uS2t
rLLaAQCdVeAGb/08LQDnH37VEVe/3Fh5Up+YmkCJdqs28Bn2dAD9G+I9nnCKPAhV
1qy8W9DoRIWKeDFHujauI6mv+ZeRigs=
=pyp8
-----END PGP SIGNATURE-----

--IoiytQITDcaWi1MG--

