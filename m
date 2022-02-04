Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FEB4A9E5C
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 18:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377182AbiBDRwM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 12:52:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26598 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237982AbiBDRwL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 12:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643997131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HK+AuNORDNo98x/XtP9cR26cKXMATAPWZr3GXoesQeI=;
        b=Wyw9lxIhIfab9+B3YWdvI6BSPGV3d++UH4GQ2O7jn3nGyRBBjNoJ+xnhQj+NGo0HDuB4NS
        n6XN+KOSVrlgT3Lc1ct/Xe3eGKC7JojG2h1ooFlSCIHXtS5LBpsHAvQeMy5n/MY8R1He0L
        tcC7Psd0jtozLAKYNgVJf1UHDQ3WWE8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-d9E7N-u3P0OTK1U1l-ZtBw-1; Fri, 04 Feb 2022 12:52:10 -0500
X-MC-Unique: d9E7N-u3P0OTK1U1l-ZtBw-1
Received: by mail-qt1-f199.google.com with SMTP id y1-20020ac87041000000b002c3db9c25f8so5214573qtm.5
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 09:52:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HK+AuNORDNo98x/XtP9cR26cKXMATAPWZr3GXoesQeI=;
        b=yZ2qJZsE+R++qTZImgjxKtbg5LzaaABPKfnLqpGzulBoifCMUdClq45qYPL0zNsQgF
         UVHX0rPri5oAiu8551ymruTx3pQA6CHhRk526UiZYOot0DqlsQqc9+BNC0eXKPsfymOz
         57MgyGlNfqIPfMDVHjVxvzgtOJtOn3yKGQuod7vd9qeW61QCuBAf+7468G3XY2db2Ayq
         FWxzBemxwqTKQNBmJs9LYw9q33sjBbCsdivRcIFHdIze9C8BaPq59J4xMPmw8F6AMdIe
         JZMME445/eanuvN2E6UY38uoKQSlIxeQv3cQGttbJTpDD1m/HdGh5BKAu/zGaje2UDHt
         X0Xw==
X-Gm-Message-State: AOAM531om8psChBIthxOUmY73LlOYHkHunvCynaQs6A/XMKlUQxDQRLP
        VwUWKghcy5ze1VQFwkW1JlHdqWuJbyJC291/uS7mXuFh9YT7MRV5nOam+5au5ibDl2tH1MQlWVD
        DCAvzSFjbky9M
X-Received: by 2002:ac8:4b59:: with SMTP id e25mr101090qts.444.1643997129563;
        Fri, 04 Feb 2022 09:52:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgMDT/tu4RNNCY0JhbYF1mo9psOW0l/SkfBmAQS+d7wdZRvnMcxzRduS7XVF2TUGBXheUqTg==
X-Received: by 2002:ac8:4b59:: with SMTP id e25mr101071qts.444.1643997129315;
        Fri, 04 Feb 2022 09:52:09 -0800 (PST)
Received: from localhost (net-37-182-17-113.cust.vodafonedsl.it. [37.182.17.113])
        by smtp.gmail.com with ESMTPSA id y5sm1279642qkj.28.2022.02.04.09.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 09:52:08 -0800 (PST)
Date:   Fri, 4 Feb 2022 18:52:04 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, brouer@redhat.com,
        toke@redhat.com, andrii@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftest/bpf: check invalid length in
 test_xdp_update_frags
Message-ID: <Yf1nxMWEWy4DSwgN@lore-desk>
References: <aff68ca785cae86cd6263355010ceaff24daee1f.1643982947.git.lorenzo@kernel.org>
 <c3858f6b-43d5-18ef-2fc8-b58c13c12b05@fb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AVBZ0SWrL6f0jnJA"
Content-Disposition: inline
In-Reply-To: <c3858f6b-43d5-18ef-2fc8-b58c13c12b05@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--AVBZ0SWrL6f0jnJA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 2/4/22 5:58 AM, Lorenzo Bianconi wrote:
> > Update test_xdp_update_frags adding a test for a buffer size
> > set to (MAX_SKB_FRAGS + 2) * PAGE_SIZE. The kernel is supposed
> > to return -ENOMEM.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >   .../bpf/prog_tests/xdp_adjust_frags.c         | 37 ++++++++++++++++++-
> >   1 file changed, 36 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c =
b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
> > index 134d0ac32f59..61d5b585eb15 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
> > @@ -5,11 +5,12 @@
> >   void test_xdp_update_frags(void)
> >   {
> >   	const char *file =3D "./test_xdp_update_frags.o";
> > +	int err, prog_fd, max_skb_frags, buf_size, num;
> >   	struct bpf_program *prog;
> >   	struct bpf_object *obj;
> > -	int err, prog_fd;
> >   	__u32 *offset;
> >   	__u8 *buf;
> > +	FILE *f;
> >   	LIBBPF_OPTS(bpf_test_run_opts, topts);
> >   	obj =3D bpf_object__open(file);
> > @@ -99,6 +100,40 @@ void test_xdp_update_frags(void)
> >   	ASSERT_EQ(buf[7621], 0xbb, "xdp_update_frag buf[7621]");
> >   	free(buf);
> > +
> > +	/* test_xdp_update_frags: unsupported buffer size */
> > +	f =3D fopen("/proc/sys/net/core/max_skb_frags", "r");
> > +	if (!ASSERT_OK_PTR(f, "max_skb_frag file pointer"))
> > +		goto out;
>=20
> In kernel, the nr_frags checking is against MAX_SKB_FRAGS,
> but if /proc/sys/net/core/max_skb_flags is 2 or more less
> than MAX_SKB_FRAGS, the test won't fail, right?

yes, you are right. Should we use the same definition used in
include/linux/skbuff.h instead? Something like:

if (65536 / page_size + 1 < 16)
	max_skb_flags =3D 16;
else
	max_skb_flags =3D 65536/page_size + 1;

Regards,
Lorenzo

>=20
> > +
> > +	num =3D fscanf(f, "%d", &max_skb_frags);
> > +	fclose(f);
> > +
> > +	if (!ASSERT_EQ(num, 1, "max_skb_frags read failed"))
> > +		goto out;
> > +
> > +	/* xdp_buff linear area size is always set to 4096 in the
> > +	 * bpf_prog_test_run_xdp routine.
> > +	 */
> > +	buf_size =3D 4096 + (max_skb_frags + 1) * sysconf(_SC_PAGE_SIZE);
> > +	buf =3D malloc(buf_size);
> > +	if (!ASSERT_OK_PTR(buf, "alloc buf"))
> > +		goto out;
> > +
> > +	memset(buf, 0, buf_size);
> > +	offset =3D (__u32 *)buf;
> > +	*offset =3D 16;
> > +	buf[*offset] =3D 0xaa;
> > +	buf[*offset + 15] =3D 0xaa;
> > +
> > +	topts.data_in =3D buf;
> > +	topts.data_out =3D buf;
> > +	topts.data_size_in =3D buf_size;
> > +	topts.data_size_out =3D buf_size;
> > +
> > +	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> > +	ASSERT_EQ(err, -ENOMEM, "unsupported buffer size");
> > +	free(buf);
> >   out:
> >   	bpf_object__close(obj);
> >   }
>=20

--AVBZ0SWrL6f0jnJA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYf1nxAAKCRA6cBh0uS2t
rPX0AQDTry6TONyPU9n0lsFL2gzmDp0M/4+qqYuVV55T//eh9gEA+9zOOAajQ6HW
MMsIwc5CduuDxIvQS8wNyjZ71JfZ3QM=
=S445
-----END PGP SIGNATURE-----

--AVBZ0SWrL6f0jnJA--

