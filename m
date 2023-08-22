Return-Path: <bpf+bounces-8250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CF1784268
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 15:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038F41C20B22
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 13:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3F41CA0E;
	Tue, 22 Aug 2023 13:50:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360251CA02
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 13:50:51 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC4C1B9
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 06:50:49 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-162-8E3v38OlNGKU5le7b_tmJw-1; Tue, 22 Aug 2023 14:50:46 +0100
X-MC-Unique: 8E3v38OlNGKU5le7b_tmJw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 22 Aug
 2023 14:50:45 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 22 Aug 2023 14:50:45 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Breno Leitao' <leitao@debian.org>, Gabriel Krisman Bertazi
	<krisman@suse.de>
CC: "sdf@google.com" <sdf@google.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"asml.silence@gmail.com" <asml.silence@gmail.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "io-uring@vger.kernel.org"
	<io-uring@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH v3 8/9] io_uring/cmd: BPF hook for getsockopt cmd
Thread-Topic: [PATCH v3 8/9] io_uring/cmd: BPF hook for getsockopt cmd
Thread-Index: AQHZ1A/0EN7qKGB0O0aA2j2x1rbL4q/2UZaA
Date: Tue, 22 Aug 2023 13:50:45 +0000
Message-ID: <687cf089ecc5451d9e398d71c9e171f0@AcuMS.aculab.com>
References: <20230817145554.892543-1-leitao@debian.org>
 <20230817145554.892543-9-leitao@debian.org> <87pm3l32rk.fsf@suse.de>
 <ZOMrD1DHeys0nFwt@gmail.com>
In-Reply-To: <ZOMrD1DHeys0nFwt@gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

...
> Not really, sock->ops->getsockopt() does not suport sockptr_t, but
> __user addresses, differently from setsockopt()
>=20
...
>           int             (*getsockopt)(struct socket *sock, int level,
>                                         int optname, char __user *optval,=
 int __user *optlen);
>=20
> In order to be able to call sock->ops->getsockopt(), the callback
> function will need to accepted sockptr.

It is also worth looking at whether 'optlen' can be passed in
as a numeric parameter and then returned on success.
That would move the user copy into the syscall wrapper.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


