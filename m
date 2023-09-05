Return-Path: <bpf+bounces-9242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A037921FD
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 12:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A64281100
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 10:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D39CA43;
	Tue,  5 Sep 2023 10:55:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B5A38
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 10:55:50 +0000 (UTC)
Received: from m1388.mail.163.com (m1388.mail.163.com [220.181.13.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65670199;
	Tue,  5 Sep 2023 03:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=JNwwYvVvNJhmFDnLWPQOWWhJmo1VIZIdhEFNmT8j+bQ=; b=S
	t+w39o4fft4aX4Vyj/rr0p6mEX1curZShPbTyOg1O465B1tBi51o8hscTHtNCnrW
	qQd+YjO5NH4PhdFiP5WKJ/CgL2vTG6TxmVWqp7iTW/ZcpprASbu1ZqlW4MJk1G4H
	x2gPRvbw3zhKx/99R7wPWi7bR2+ObZhCikBjNxZOFQ=
Received: from 00107082$163.com ( [111.35.184.199] ) by ajax-webmail-wmsvr88
 (Coremail) ; Tue, 5 Sep 2023 18:52:42 +0800 (CST)
X-Originating-IP: [111.35.184.199]
Date: Tue, 5 Sep 2023 18:52:42 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
Cc: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, 
	"Florian Westphal" <fw@strlen.de>, 
	"Alexei Starovoitov" <ast@kernel.org>, 
	"Daniel Borkmann" <daniel@iogearbox.net>, 
	"Andrii Nakryiko" <andrii@kernel.org>, 
	"Martin KaFai Lau" <martin.lau@linux.dev>, 
	"Song Liu" <song@kernel.org>, 
	"Yonghong Song" <yonghong.song@linux.dev>, 
	"John Fastabend" <john.fastabend@gmail.com>, 
	"KP Singh" <kpsingh@kernel.org>, 
	"Stanislav Fomichev" <sdf@google.com>, "Hao Luo" <haoluo@google.com>, 
	"Jiri Olsa" <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] samples/bpf: Add sample usage for
 BPF_PROG_TYPE_NETFILTER
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <87wmx5ovv0.fsf@toke.dk>
References: <20230904102128.11476-1-00107082@163.com>
 <20230904104856.GE11802@breakpoint.cc>
 <CAADnVQJVyQQ5geDuUgoDYygN9R1gJr-21XmQOR8gY5UkZsosCQ@mail.gmail.com>
 <49e1d877.1e64.18a63574e6a.Coremail.00107082@163.com>
 <87wmx5ovv0.fsf@toke.dk>
X-NTES-SC: AL_QuySAfWavkkt5CCZYOkZnEYQheY4XMKyuPkg1YJXOp80oyr99Q0sT01nIlv0y/OUNDKKgiqbeQhXx9RqQbBzZojMZIO+0KTJ1y78mii/4lkh
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <51bb4eb.547e.18a64f91ca1.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:WMGowABns5h7CPdkmkwAAA--.3940W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBEAThqmNfu+chxgACsa
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

CkF0IDIwMjMtMDktMDUgMTY6NDE6MjMsICJUb2tlIEjDuGlsYW5kLUrDuHJnZW5zZW4iIDx0b2tl
QGtlcm5lbC5vcmc+IHdyb3RlOgo+IkRhdmlkIFdhbmciIDwwMDEwNzA4MkAxNjMuY29tPiB3cml0
ZXM6Cj4KCj4+IEdldCBhIGZlZWxpbmcgc2FtcGxlcy9icGYgd291bGQgYmUgZGVwcmVjYXRlZCBz
b29uZXIgb3IgbGF0ZXIsIGhvcGUgdGhhdCB3b3VsZCBub3QgaGFwcGVuLgo+Pgo+PiBBbnl3YXks
IHRoaXMgc2FtcGxlIGNvZGUgaXMgbm90IG1lYW50IHRvIHRlc3QuIAo+Cj5GWUksIHdlIG1haW50
YWluIGEgR2l0aHViIHJlcG9zaXRvcnkgd2l0aCBCUEYgZXhhbXBsZSBwcm9ncmFtcyBvZgo+dmFy
aW91cyB0eXBlcyBhdCBodHRwczovL2dpdGh1Yi5jb20veGRwLXByb2plY3QvYnBmLWV4YW1wbGVz
Cj4KPkhhcHB5IHRvIGluY2x1ZGUgdGhpcyBleGFtcGxlIHRoZXJlIGFzIGFuIGFsdGVybmF0aXZl
IHRvIHRoZSBpbi10cmVlCj5zYW1wbGVzL2JwZiA6KQo+Cj4tVG9rZQoKQ29vbCBwcm9qZWN0fiEg
IEkgd2lsbCBzdWJtaXQgYSBQUiB0aGVyZS4=

