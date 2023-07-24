Return-Path: <bpf+bounces-5715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70C375F80C
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 15:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E846A1C20AD6
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 13:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC5D8BF9;
	Mon, 24 Jul 2023 13:17:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7A78476
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 13:17:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8DADF
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 06:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690204639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4KQ/tLol2JTMF9SoFlYCSkzvClZr/k6u6hh/oPakP4=;
	b=EIRl0irn2r472I5s4Vl36A+er73gZBAi6jKOTwADujh4K6ROV7fE4Fr8S1z57mImnitu9h
	iksGhIkZAriHacEaW8Kcpy095KLKc/s4WGOK0KPWL1grVqSsDhIxdF6wYsMlDxlOlSXxC5
	iEF8QIoTTD1aM2rszf2o+OM8dl2pOyI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-F2Wq1qF6PVuCC9PMRtj6hg-1; Mon, 24 Jul 2023 09:17:11 -0400
X-MC-Unique: F2Wq1qF6PVuCC9PMRtj6hg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73D201010427;
	Mon, 24 Jul 2023 13:17:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.116])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D8ECA200BA63;
	Mon, 24 Jul 2023 13:17:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <0000000000001416bb06004ebf53@google.com>
References: <0000000000001416bb06004ebf53@google.com>
To: syzbot <syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, bpf@vger.kernel.org, brauner@kernel.org,
    davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
    kuba@kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
    pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
    viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] INFO: task hung in pipe_release (4)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <145369.1690204627.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Jul 2023 14:17:07 +0100
Message-ID: <145370.1690204627@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Note that the test program is dodgy:

    pipe(&(0x7f0000000100)=3D{<r0=3D>0xffffffffffffffff, <r1=3D>0xffffffff=
ffffffff})
    r2 =3D socket$inet_udp(0x2, 0x2, 0x0)

r2 is closed here:

    close(r2)
    r3 =3D socket$inet_udp(0x2, 0x2, 0x0)
    setsockopt$sock_int(r3, 0x1, 0x6, &(0x7f0000000140)=3D0x32, 0x4)
    bind$inet(r3, &(0x7f0000000000)=3D{0x2, 0x0, @dev=3D{0xac, 0x14, 0x14,=
 0x15}}, 0x10)
    connect$inet(r3, &(0x7f0000000200)=3D{0x2, 0x0, @broadcast}, 0x10)
    sendmmsg(r3, &(0x7f0000000180)=3D[{{0x0, 0x0, 0x0}}, {{0x0, 0xffffffff=
fffffed3, &(0x7f0000000940)=3D[{&(0x7f00000006c0)=3D'O', 0x57e}], 0x1}}], =
0x4000000000003bd, 0x8800)
    write$binfmt_misc(r1, &(0x7f0000000440)=3DANY=3D[], 0x8)

but then used here:

    splice(r0, 0x0, r2, 0x0, 0x4ffe0, 0x0)

As it happens, r3 will probably end up referring to the same fd as r2 did,=
 but
that's not guaranteed.

David


