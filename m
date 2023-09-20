Return-Path: <bpf+bounces-10441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256CF7A75F9
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 10:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F399A1C20E1C
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 08:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5D4C8DE;
	Wed, 20 Sep 2023 08:36:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E83A3FF5
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 08:36:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69A7A1
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 01:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695198963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fyO783HFK2K9KUO8v9jboxC20XyrMbrsezvU6yX9E9k=;
	b=RRQlm9P81vuGXOTgcp9KBNCU9WvgeexmFh+kPkWRHnWyKmr6rF6QhPmh3Tby0SAooS+x5v
	chlpuwLPHNG3m//Ld/Z6DOJcMqsI4MRyQbnVM94Emd6AEG045u7k7jyuJwavF1MTnLxg/L
	6mjNoD1V4M0DpZMlmWvj2xnUmd13tqE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-W7EXuqRtMya6E5jYoYDVdw-1; Wed, 20 Sep 2023 04:35:59 -0400
X-MC-Unique: W7EXuqRtMya6E5jYoYDVdw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07DAE811E7B;
	Wed, 20 Sep 2023 08:35:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9792640C6EBF;
	Wed, 20 Sep 2023 08:35:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAF=yD-+kRXmwuKHVrUUL6oBPhWiPKucm_5-Y+YM==9Bp3DQiGQ@mail.gmail.com>
References: <CAF=yD-+kRXmwuKHVrUUL6oBPhWiPKucm_5-Y+YM==9Bp3DQiGQ@mail.gmail.com> <75315.1695139973@warthog.procyon.org.uk>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com,
    Eric Dumazet <edumazet@google.com>,
    "David S. Miller" <davem@davemloft.net>,
    David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
    syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <108653.1695198956.1@warthog.procyon.org.uk>
Date: Wed, 20 Sep 2023 09:35:56 +0100
Message-ID: <108654.1695198956@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> The proposed fix is non-trivial, and changes not just the new path
> that observes the issue (MSG_SPLICE_PAGES), but also the other more
> common paths that exercise __ip6_append_data.

I realise that.  I broke ping/ping6 briefly, but I corrected that (I
subtracted the ICMP header len from length after copying it out, but forgot
that it needed adding back on for the return value of sendmsg()).  But I don't
think there are that many callers - however, you might be right that this is
too big for a fix.

> There is significant risk to introduce an unintended side effect
> requiring a follow-up fix. Because this function is notoriously
> complex, multiplexing a lot of behavior: with and without transport
> headers, edge cases like fragmentation, MSG_MORE, absence of
> scatter-gather, ....

The problem is that the bug isn't in __ip{,6}_append_data(), I think, it's
actually higher up in ip{,6}_append_data().  I think I see *why* length has
transhdrlen handed into it: because ping and raw sockets come with that
pre-added-in by userspace.

I would actually like to eliminate the length argument entirely and use the
length in the iterator - but that doesn't work in all cases as sometimes there
isn't a msghdr struct.  (And, besides, that's too big a change for a fix).

I think the simplest fix, then, is just to make ip{,6}_append_data() subtract
transhdrlen from length before clearing transhdrlen when there's already a
packet in the queue from MSG_MORE/cork that will be appended to.

> Does the issue discovered only affect MSG_SPLICE_PAGES or can it
> affect other paths too? If the first, it possible to create a more
> targeted fix that can trivially be seen to not affect code prior to
> introduction of splice pages?

It may also affect MSG_ZEROCOPY in interesting ways.  msg_zerocopy_realloc()
looks suspicious as it does things with 'size' bytes from the buffer that
doesn't have 'size' bytes of data in it (because size (aka length) includes
transhdrlen).

I would guess that we don't notice issues with ping sockets because people
don't often use MSG_MORE/corking with them.

Raw sockets shouldn't exhibit this bug as they set transhdrlen to 0 up front,
but I can't help but wonder what the consequences are as some bits of
__ip*_append_data() change behaviour if they see transhdrlen==0 :-/

David


