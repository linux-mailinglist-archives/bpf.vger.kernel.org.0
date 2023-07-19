Return-Path: <bpf+bounces-5284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75838759647
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 15:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A645D1C20FC4
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 13:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C088914AB4;
	Wed, 19 Jul 2023 13:10:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89160569F
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 13:10:12 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E467210FE
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 06:10:10 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-101-5pn_NyH9MXGXe_bzmjcL7g-1; Wed, 19 Jul 2023 14:10:06 +0100
X-MC-Unique: 5pn_NyH9MXGXe_bzmjcL7g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 19 Jul
 2023 14:10:03 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 19 Jul 2023 14:10:03 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Alexei Starovoitov' <alexei.starovoitov@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "kuba@kernel.org" <kuba@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
	<andrii@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "kernel-team@fb.com"
	<kernel-team@fb.com>
Subject: RE: [PATCH bpf-next] bpf, net: Introduce skb_pointer_if_linear().
Thread-Topic: [PATCH bpf-next] bpf, net: Introduce skb_pointer_if_linear().
Thread-Index: AQHZudFDBirvCO7+uU6Dg3V7TfCnp6/BD3ig
Date: Wed, 19 Jul 2023 13:10:03 +0000
Message-ID: <dae5886a8b3b4d9f869e4f8ab3cefa96@AcuMS.aculab.com>
References: <20230718234021.43640-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20230718234021.43640-1-alexei.starovoitov@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alexei Starovoitov
> Sent: 19 July 2023 00:40
>=20
> Network drivers always call skb_header_pointer() with non-null buffer.
> Remove !buffer check to prevent accidental misuse of skb_header_pointer()=
.
> Introduce skb_pointer_if_linear() instead.
>=20
...
> +static inline void * __must_check
> +skb_pointer_if_linear(const struct sk_buff *skb, int offset, int len)
> +{
> +=09if (likely(skb_headlen(skb) - offset >=3D len))
> +=09=09return skb->data + offset;
> +=09return NULL;
> +}

Shouldn't both 'offset' and 'len' be 'unsigned int' ?

The check should probably be written:
=09=09offset + len <=3D skb_headlen(skb)
so that it fails if 'offset' is also large.
(Provided 'offset + len' itself doesn't wrap.)

I've swapped the order because I prefer conditional to be
=09if (variable op constant)
and in this case skb_headlen() is the more constant value.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


