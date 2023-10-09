Return-Path: <bpf+bounces-11718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088A87BE1BF
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 15:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CBA281841
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 13:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B09D347BC;
	Mon,  9 Oct 2023 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JLqdBgQx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAA23419D;
	Mon,  9 Oct 2023 13:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CD7C433C7;
	Mon,  9 Oct 2023 13:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696859614;
	bh=YPuwxMRAMtgEqqEgr8dEnI8uvjslGrtnKU3kGNNn0nY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JLqdBgQxWwXlUDAaodC7DB1e69Dt7jBYYf5jIlorJpOsrMNuvQXGBAfGVxL+l0WrQ
	 BiL7Bc+3JdUsomjXsfhlAbgRv1g8OGoYxU+sNh0kZAhr1CuFOwPGsR8+6dYOZsjRGU
	 WcGor+eYgy6bGFDUz/mUiDz/ZKso6+CqjmQBAaXo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 77/91] ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()
Date: Mon,  9 Oct 2023 15:06:49 +0200
Message-ID: <20231009130114.219790966@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
References: <20231009130111.518916887@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 9d4c75800f61e5d75c1659ba201b6c0c7ead3070 ]

Including the transhdrlen in length is a problem when the packet is
partially filled (e.g. something like send(MSG_MORE) happened previously)
when appending to an IPv4 or IPv6 packet as we don't want to repeat the
transport header or account for it twice.  This can happen under some
circumstances, such as splicing into an L2TP socket.

The symptom observed is a warning in __ip6_append_data():

    WARNING: CPU: 1 PID: 5042 at net/ipv6/ip6_output.c:1800 __ip6_append_data.isra.0+0x1be8/0x47f0 net/ipv6/ip6_output.c:1800

that occurs when MSG_SPLICE_PAGES is used to append more data to an already
partially occupied skbuff.  The warning occurs when 'copy' is larger than
the amount of data in the message iterator.  This is because the requested
length includes the transport header length when it shouldn't.  This can be
triggered by, for example:

        sfd = socket(AF_INET6, SOCK_DGRAM, IPPROTO_L2TP);
        bind(sfd, ...); // ::1
        connect(sfd, ...); // ::1 port 7
        send(sfd, buffer, 4100, MSG_MORE);
        sendfile(sfd, dfd, NULL, 1024);

Fix this by only adding transhdrlen into the length if the write queue is
empty in l2tp_ip6_sendmsg(), analogously to how UDP does things.

l2tp_ip_sendmsg() looks like it won't suffer from this problem as it builds
the UDP packet itself.

Fixes: a32e0eec7042 ("l2tp: introduce L2TPv3 IP encapsulation support for IPv6")
Reported-by: syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/0000000000001c12b30605378ce8@google.com/
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/l2tp/l2tp_ip6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index f3f0b4b7c3863..7342344d99a97 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -525,7 +525,6 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	 */
 	if (len > INT_MAX - transhdrlen)
 		return -EMSGSIZE;
-	ulen = len + transhdrlen;
 
 	/* Mirror BSD error message compatibility */
 	if (msg->msg_flags & MSG_OOB)
@@ -649,6 +648,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 back_from_confirm:
 	lock_sock(sk);
+	ulen = len + skb_queue_empty(&sk->sk_write_queue) ? transhdrlen : 0;
 	err = ip6_append_data(sk, ip_generic_getfrag, msg,
 			      ulen, transhdrlen, &ipc6,
 			      &fl6, (struct rt6_info *)dst,
-- 
2.40.1




