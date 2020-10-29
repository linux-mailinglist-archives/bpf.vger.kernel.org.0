Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4D629E908
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 11:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgJ2Kcn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 06:32:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24212 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726266AbgJ2Kcl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 29 Oct 2020 06:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603967518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i23ClnnyN49Bs0oQkdNz5ufbZvaJbHZARzUfXComFHM=;
        b=gao1xJalS6/S79QuRFfzT1/uJd5iUtnrowi92LxJ5hOpjw5t4Z3kopy7M0Vt13QCYx94cf
        sZO4l+N+BwJCUSajU4OGAIZO7be2gWVHbc7Xc4i4GhDYewcZBGlPEpeLGn6Xm7TKSpQWDY
        HbKSPRdlILCRs3dk6tWbNrAilBf1uH0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-0TIf_6xqPpiRhE3kiO5l7g-1; Thu, 29 Oct 2020 06:31:53 -0400
X-MC-Unique: 0TIf_6xqPpiRhE3kiO5l7g-1
Received: by mail-wr1-f69.google.com with SMTP id 33so1075601wrf.22
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2020 03:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i23ClnnyN49Bs0oQkdNz5ufbZvaJbHZARzUfXComFHM=;
        b=ObcWRZEusz7RuDGq8WcUUFxqBVGJHdR0hhZF35fq5/0h+fZ5tYUL8elrjqEif+TA/q
         J9E8twr/C5tloIxCg1BjnsiIoOfe3Vjr0ggtyc7fycpM4iUhUGnthCQKWdxtwxEMANkF
         0BpzgPjw/Sh469JR3YcdSk/RZ/wC2r8Zyj3wXHqi2s2tzv5XcdFpbQCvsgXuGNlSCfXJ
         UH9kqqNdVYseu6tOWFQGpTYZGceQaD6LUJLuUIuBMP1FjIh3ilXLgxUKVzyBAsYCxisQ
         CdB/SZSuxtBLVXKFYXcMlToZtUXVazP0arSI73XLo344f8xeteMn6EYSKHAHTyzPBerT
         M2uA==
X-Gm-Message-State: AOAM533p80GLUsiHhJpHnF+VBkSo47bhGwP7QpAuZydauZ5izYtoBLID
        yVFhvqStQJyV4qP7zGwaDU/NIHvLFC/Pdj0bfoPP3lQHT8xu+iccGtbkEiESod6gl1zpyh55qwQ
        e8uUCnKDeiW78
X-Received: by 2002:a5d:48c2:: with SMTP id p2mr4624774wrs.366.1603967512651;
        Thu, 29 Oct 2020 03:31:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6oeHJAySSImb1xyc8uQK3sXMWtfk43cxoaHH1j1eERXIPshAEEX5yo3EzVkpnZbA6eAIHEA==
X-Received: by 2002:a5d:48c2:: with SMTP id p2mr4624755wrs.366.1603967512446;
        Thu, 29 Oct 2020 03:31:52 -0700 (PDT)
Received: from localhost ([151.66.29.159])
        by smtp.gmail.com with ESMTPSA id x1sm4190106wrl.41.2020.10.29.03.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 03:31:51 -0700 (PDT)
Date:   Thu, 29 Oct 2020 11:31:48 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ilias.apalodimas@linaro.org
Subject: Re: [PATCH net-next 2/4] net: page_pool: add bulk support for
 ptr_ring
Message-ID: <20201029103148.GA15697@lore-desk>
References: <cover.1603824486.git.lorenzo@kernel.org>
 <cd58ca966fbe11cabbd6160decea6ce748ebce9f.1603824486.git.lorenzo@kernel.org>
 <20201029111329.79b86c00@carbon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20201029111329.79b86c00@carbon>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 27 Oct 2020 20:04:08 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > +void page_pool_put_page_bulk(struct page_pool *pool, void **data,
> > +			     int count)
> > +{
> > +	struct page *page_ring[XDP_BULK_QUEUE_SIZE];
>=20
> Maybe we could reuse the 'data' array instead of creating a new array
> (2 cache-lines long) for the array of pages?

I agree, I will try to reuse the data array for that

>=20
> > +	int i, len =3D 0;
> > +
> > +	for (i =3D 0; i < count; i++) {
> > +		struct page *page =3D virt_to_head_page(data[i]);
> > +
> > +		if (unlikely(page_ref_count(page) !=3D 1 ||
> > +			     !pool_page_reusable(pool, page))) {
> > +			page_pool_release_page(pool, page);
> > +			put_page(page);
> > +			continue;
> > +		}
> > +
> > +		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> > +			page_pool_dma_sync_for_device(pool, page, -1);
>=20
> Here we sync the entire DMA area (-1), which have a *huge* cost for
> mvneta (especially on EspressoBin HW).  For this xdp_frame->len is
> unfortunately not enough.  We will need the *maximum* length touch by
> (1) CPU and (2) remote device DMA engine.  DMA-TX completion knows the
> length for (2).  The CPU length (1) is max of original xdp_buff size
> and xdp_frame->len, because BPF-helpers could have shrinked the size.
> (tricky part is that xdp_frame->len isn't correct in-case of header
> adjustments, thus like mvneta_run_xdp we to calc dma_sync size, and
> store this in xdp_frame, maybe via param to xdp_do_redirect). Well, not
> sure if it is too much work to transfer this info, for this use-case.

I was thinking about that but I guess point (1) is tricky since "cpu length"
can be changed even in the middle by devmaps or cpumaps (not just in the dr=
iver
rx napi loop). I guess we can try to address this point in a subsequent ser=
ies.
Agree?

Regards,
Lorenzo

>=20
> > +
> > +		page_ring[len++] =3D page;
>=20
> > +	}
> > +
> > +	page_pool_ring_lock(pool);
> > +	for (i =3D 0; i < len; i++) {
> > +		if (__ptr_ring_produce(&pool->ring, page_ring[i]))
> > +			page_pool_return_page(pool, page_ring[i]);
> > +	}
> > +	page_pool_ring_unlock(pool);
> > +}
> > +EXPORT_SYMBOL(page_pool_put_page_bulk);
>=20
>=20
>=20
> --=20
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>=20

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX5qaEQAKCRA6cBh0uS2t
rMB1APsHlY9DgZ6UUlRWPu0CuQqAE2a2+cAVKEjopWKiSVMc4gEAitWZ+HVdtm2x
8oU/bTR7UYzMb0UTwdiLEn982BdxWAI=
=Pl//
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

