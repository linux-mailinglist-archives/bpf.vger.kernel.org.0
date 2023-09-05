Return-Path: <bpf+bounces-9240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F11792187
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 11:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6A91C20932
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 09:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D116AA0;
	Tue,  5 Sep 2023 09:36:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261761C02
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 09:36:44 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7C31AD
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 02:36:41 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-5-RE-OIzy8PuGpYbXqCyuTRw-1; Tue, 05 Sep 2023 10:36:38 +0100
X-MC-Unique: RE-OIzy8PuGpYbXqCyuTRw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 5 Sep
 2023 10:36:34 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 5 Sep 2023 10:36:34 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Breno Leitao' <leitao@debian.org>, "sdf@google.com" <sdf@google.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "asml.silence@gmail.com"
	<asml.silence@gmail.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "krisman@suse.de" <krisman@suse.de>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
	"KP Singh" <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "io-uring@vger.kernel.org"
	<io-uring@vger.kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, "Alexander
 Mikhalitsyn" <alexander@mihalicyn.com>, Xin Long <lucien.xin@gmail.com>,
	"David Howells" <dhowells@redhat.com>, Jason Xing <kernelxing@tencent.com>,
	"Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v4 04/10] net/socket: Break down __sys_getsockopt
Thread-Topic: [PATCH v4 04/10] net/socket: Break down __sys_getsockopt
Thread-Index: AQHZ30xphJKGpfy/Z06Weh22EiUUErAL+aYg
Date: Tue, 5 Sep 2023 09:36:34 +0000
Message-ID: <b9d56ef784ad436c8cb60c4c9fd2d786@AcuMS.aculab.com>
References: <20230904162504.1356068-1-leitao@debian.org>
 <20230904162504.1356068-5-leitao@debian.org>
In-Reply-To: <20230904162504.1356068-5-leitao@debian.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Breno Leitao
> Sent: 04 September 2023 17:25
>=20
> Split __sys_getsockopt() into two functions by removing the core
> logic into a sub-function (do_sock_getsockopt()). This will avoid
> code duplication when doing the same operation in other callers, for
> instance.

Although a lot more work, I think (others may disagree) that
the internal getsockopt() functions should be changed to take
the length as a parameter and return the positive value
to write back.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


