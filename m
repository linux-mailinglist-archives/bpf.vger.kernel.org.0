Return-Path: <bpf+bounces-6710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8592276CE65
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 15:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60741C212A3
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 13:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0310748D;
	Wed,  2 Aug 2023 13:21:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A20746C
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 13:21:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D4D1726
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 06:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690982500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nS6ICdo1UiQMcc3JZa9rf8CNFRuNpTXhvpaUSM5J8uw=;
	b=d3NWd8Ygw52+WMqXvEXDvwiSds5l9nETrDEEb/0LzUAqZ+hukQthXoDykh1s9PzYrojKRr
	uXSkwUmKajcFtJYjdbSdeA9wYiwX1P62HsblymIildWSNcj1sKm3qUi34rCuly3UUUQ6FV
	u9pm/sol0766NKesrN2RG7U4Shol5S0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-A_H0zQvBNomvSgE9eCr-IQ-1; Wed, 02 Aug 2023 09:21:37 -0400
X-MC-Unique: A_H0zQvBNomvSgE9eCr-IQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22CB81C09A45;
	Wed,  2 Aug 2023 13:21:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 393BA492CA6;
	Wed,  2 Aug 2023 13:21:35 +0000 (UTC)
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
Content-ID: <1796029.1690982494.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Aug 2023 14:21:34 +0100
Message-ID: <1796030.1690982494@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master

udp: Fix __ip_append_data()'s handling of MSG_SPLICE_PAGES
    =

__ip_append_data() can get into an infinite loop when asked to splice into
a partially-built UDP message that has more than the frag-limit data and u=
p
to the MTU limit.  Something like:

        pipe(pfd);
        sfd =3D socket(AF_INET, SOCK_DGRAM, 0);
        connect(sfd, ...);
        send(sfd, buffer, 8161, MSG_CONFIRM|MSG_MORE);
        write(pfd[1], buffer, 8);
        splice(pfd[0], 0, sfd, 0, 0x4ffe0ul, 0);

where the amount of data given to send() is dependent on the MTU size (in
this instance an interface with an MTU of 8192).

The problem is that the calculation of the amount to copy in
__ip_append_data() goes negative in two places, and, in the second place,
this gets subtracted from the length remaining, thereby increasing it.

This happens when pagedlen > 0 (which happens for MSG_ZEROCOPY and
MSG_SPLICE_PAGES), because the terms in:

        copy =3D datalen - transhdrlen - fraggap - pagedlen;

then mostly cancel when pagedlen is substituted for, leaving just -fraggap=
.
This causes:

        length -=3D copy + transhdrlen;

to increase the length to more than the amount of data in msg->msg_iter,
which causes skb_splice_from_iter() to be unable to fill the request and i=
t
returns less than 'copied' - which means that length never gets to 0 and w=
e
never exit the loop.

Fix this by:

 (1) Insert a note about the dodgy calculation of 'copy'.

 (2) If MSG_SPLICE_PAGES, clear copy if it is negative from the above
     equation, so that 'offset' isn't regressed and 'length' isn't
     increased, which will mean that length and thus copy should match the
     amount left in the iterator.

 (3) When handling MSG_SPLICE_PAGES, give a warning and return -EIO if
     we're asked to splice more than is in the iterator.  It might be
     better to not give the warning or even just give a 'short' write.

[!] Note that this ought to also affect MSG_ZEROCOPY, but MSG_ZEROCOPY
avoids the problem by simply assuming that everything asked for got copied=
,
not just the amount that was in the iterator.  This is a potential bug for
the future.

Fixes: 7ac7c987850c ("udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES"=
)
Reported-by: syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/000000000000881d0606004541d1@google.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: David Ahern <dsahern@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: netdev@vger.kernel.org
---
 net/ipv4/ip_output.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 6e70839257f7..91715603cf6e 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1158,10 +1158,15 @@ static int __ip_append_data(struct sock *sk,
 			}
 =

 			copy =3D datalen - transhdrlen - fraggap - pagedlen;
+			/* [!] NOTE: copy will be negative if pagedlen>0
+			 * because then the equation reduces to -fraggap.
+			 */
 			if (copy > 0 && getfrag(from, data + transhdrlen, offset, copy, fragga=
p, skb) < 0) {
 				err =3D -EFAULT;
 				kfree_skb(skb);
 				goto error;
+			} else if (flags & MSG_SPLICE_PAGES) {
+				copy =3D 0;
 			}
 =

 			offset +=3D copy;
@@ -1209,6 +1214,10 @@ static int __ip_append_data(struct sock *sk,
 		} else if (flags & MSG_SPLICE_PAGES) {
 			struct msghdr *msg =3D from;
 =

+			err =3D -EIO;
+			if (WARN_ON_ONCE(copy > msg->msg_iter.count))
+				goto error;
+
 			err =3D skb_splice_from_iter(skb, &msg->msg_iter, copy,
 						   sk->sk_allocation);
 			if (err < 0)


