Return-Path: <bpf+bounces-10442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754347A760C
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 10:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC21281BBC
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 08:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F41D1170B;
	Wed, 20 Sep 2023 08:39:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE2811184
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 08:39:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F30693
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 01:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695199162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+3yBpA5iz82pce6LfLZNujDLBSjE7ZVN1nK9Rsm3ufc=;
	b=czUj6an4tmC8yvo5TCg5v68hUY+mos8NhxGUIUWLHDkmIWnT0OBj7AHmXiH4nETIcsUj+1
	rWY5CjoohHp5KXRSB3Mf6NPY0WnNdERIfQeXy4mNW2/4U8RztNFhJHj3p6FDT8diEjFKbd
	Wm+yOvWnd1VuywC6/NiPZZnAvwJvkf4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-whr9bxVyOA-yv0PPo12ZiA-1; Wed, 20 Sep 2023 04:39:15 -0400
X-MC-Unique: whr9bxVyOA-yv0PPo12ZiA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 139D385A5BA;
	Wed, 20 Sep 2023 08:39:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5788E2156701;
	Wed, 20 Sep 2023 08:39:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
cc: dhowells@redhat.com,
    syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com,
    Eric Dumazet <edumazet@google.com>,
    Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
    "David S. Miller" <davem@davemloft.net>,
    David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
    syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH net v2] ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <108790.1695199151.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Sep 2023 09:39:11 +0100
Message-ID: <108791.1695199151@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Including the transhdrlen in length is a problem when the packet is
partially filled (e.g. something like send(MSG_MORE) happened previously)
when appending to an IPv4 or IPv6 packet as we don't want to repeat the
transport header or account for it twice.  This can happen under some
circumstances, such as splicing into an L2TP socket.

The symptom observed is a warning in __ip6_append_data():

    WARNING: CPU: 1 PID: 5042 at net/ipv6/ip6_output.c:1800 __ip6_append_d=
ata.isra.0+0x1be8/0x47f0 net/ipv6/ip6_output.c:1800

that occurs when MSG_SPLICE_PAGES is used to append more data to an alread=
y
partially occupied skbuff.  The warning occurs when 'copy' is larger than
the amount of data in the message iterator.  This is because the requested
length includes the transport header length when it shouldn't.  This can b=
e
triggered by, for example:

        sfd =3D socket(AF_INET6, SOCK_DGRAM, IPPROTO_L2TP);
        bind(sfd, ...); // ::1
        connect(sfd, ...); // ::1 port 7
        send(sfd, buffer, 4100, MSG_MORE);
        sendfile(sfd, dfd, NULL, 1024);

Fix this by deducting transhdrlen from length in ip{,6}_append_data() righ=
t
before we clear transhdrlen if there is already a packet that we're going
to try appending to.

Reported-by: syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/0000000000001c12b30605378ce8@google.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Dumazet <edumazet@google.com>
cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: David Ahern <dsahern@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: netdev@vger.kernel.org
cc: bpf@vger.kernel.org
cc: syzkaller-bugs@googlegroups.com
Link: https://lore.kernel.org/r/75315.1695139973@warthog.procyon.org.uk/ #=
 v1
---
 net/ipv4/ip_output.c  |    1 +
 net/ipv6/ip6_output.c |    1 +
 2 files changed, 2 insertions(+)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 4ab877cf6d35..9646f2d9afcf 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1354,6 +1354,7 @@ int ip_append_data(struct sock *sk, struct flowi4 *f=
l4,
 		if (err)
 			return err;
 	} else {
+		length -=3D transhdrlen;
 		transhdrlen =3D 0;
 	}
 =

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 54fc4c711f2c..6a4ce7f622e9 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1888,6 +1888,7 @@ int ip6_append_data(struct sock *sk,
 		length +=3D exthdrlen;
 		transhdrlen +=3D exthdrlen;
 	} else {
+		length -=3D transhdrlen;
 		transhdrlen =3D 0;
 	}
 =


