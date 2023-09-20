Return-Path: <bpf+bounces-10443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D007A7913
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 12:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEB9281861
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 10:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CD315AF2;
	Wed, 20 Sep 2023 10:21:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8182D15AD6
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 10:21:01 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0929C2
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 03:20:59 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a65f9147ccso873108766b.1
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 03:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1695205258; x=1695810058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DiPSvOokKshBPUexjeZdWsFIcxk+jNh+RekcG+HrWWg=;
        b=Q8EpkBsXTujeK9KdV6Ipi7CIded8Z6A0o/320eaBS2YNI9Zq5bpqELgDYnby1+9NAA
         x0vMxlCZ2/DciYy40fAvHuWP8COzzHiVI/qd3xHjIY3GRS6EgfZ6dxRKS2/tjLVC8i0y
         qvadDtmLzGVtCr0/a8rjv7jgIv0Fu1k67t6AGN/cjILyedNJzrP7qGX0tQ2JKlkUMaZ1
         gaFArQimp1wcn1cCl7VEHSEEHO/NweHipL3Ft+5rqN8IUPRxvL8kPKQps/qBypjSbhAl
         uyBZEqwxJKEGIfQVE3JyWz/MhktcREIMed/6xQo/MoBYXxgfjYjarm8FRtYy1MOpOFgo
         pd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695205258; x=1695810058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DiPSvOokKshBPUexjeZdWsFIcxk+jNh+RekcG+HrWWg=;
        b=acErflrGmJHgDP+zkxum955nLOtctYA76NVF2C4G8Snx74joKn+zpVJb4JPP/VZTGl
         qniRNx58hu/8syAecrDPw+REk7rhtiC6pH1MhGd2A4qV0siZBZxX6MCAcOZjqfnEhJep
         JqM3AcjukIr5dFMjdZ00cO2MZ8oOHmWMbuwyhVBfuezCl9TaVRZEA1qSZoVzUQzl6qZY
         qdSG9O4WVvDAilfz7xr37Dqvb/QA4OTiHJfPkxDOZGazsZ8mYNrLsPvv4pBnyBrKa7fZ
         N4p+4SXkoh01yEsfO8OC9k/pl7Pscu0VFVfP8VfXQHiiP1dUl2e8jrAk0fNl8ZOMz8BC
         QeAQ==
X-Gm-Message-State: AOJu0YwyFIC0gPg6ktLWtpdFu0gW33RUl3IrxzWPXHGyrwQ6+WlSYsio
	tYXQQdEr9NpbTBroWSRi7+CqxJXCqXfonNztUGw=
X-Google-Smtp-Source: AGHT+IH9y572ZzI5LplOgamEjCHT7V9pJ+GhfVOuSFBC7rQC9QWMtvEuhe38Ye8C0++DNoADW9M0qw==
X-Received: by 2002:a17:907:2c4f:b0:9ad:78b7:29ea with SMTP id hf15-20020a1709072c4f00b009ad78b729eamr1394976ejc.44.1695205257896;
        Wed, 20 Sep 2023 03:20:57 -0700 (PDT)
Received: from cloudflare.com (79.184.124.164.ipv4.supernova.orange.pl. [79.184.124.164])
        by smtp.gmail.com with ESMTPSA id c26-20020a170906341a00b00993470682e5sm9122587ejb.32.2023.09.20.03.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 03:20:57 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	kernel-team@cloudflare.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Cong Wang <cong.wang@bytedance.com>
Subject: [PATCH bpf] bpf, sockmap: Reject sk_msg egress redirects to non-TCP sockets
Date: Wed, 20 Sep 2023 12:20:55 +0200
Message-ID: <20230920102055.42662-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With a SOCKMAP/SOCKHASH map and an sk_msg program user can steer messages
sent from one TCP socket (s1) to actually egress from another TCP
socket (s2):

tcp_bpf_sendmsg(s1)		// = sk_prot->sendmsg
  tcp_bpf_send_verdict(s1)	// __SK_REDIRECT case
    tcp_bpf_sendmsg_redir(s2)
      tcp_bpf_push_locked(s2)
	tcp_bpf_push(s2)
	  tcp_rate_check_app_limited(s2) // expects tcp_sock
	  tcp_sendmsg_locked(s2)	 // ditto

There is a hard-coded assumption in the call-chain, that the egress
socket (s2) is a TCP socket.

However in commit 122e6c79efe1 ("sock_map: Update sock type checks for
UDP") we have enabled redirects to non-TCP sockets. This was done for the
sake of BPF sk_skb programs. There was no indention to support sk_msg
send-to-egress use case.

As a result, attempts to send-to-egress through a non-TCP socket lead to a
crash due to invalid downcast from sock to tcp_sock:

 BUG: kernel NULL pointer dereference, address: 000000000000002f
 ...
 Call Trace:
  <TASK>
  ? show_regs+0x60/0x70
  ? __die+0x1f/0x70
  ? page_fault_oops+0x80/0x160
  ? do_user_addr_fault+0x2d7/0x800
  ? rcu_is_watching+0x11/0x50
  ? exc_page_fault+0x70/0x1c0
  ? asm_exc_page_fault+0x27/0x30
  ? tcp_tso_segs+0x14/0xa0
  tcp_write_xmit+0x67/0xce0
  __tcp_push_pending_frames+0x32/0xf0
  tcp_push+0x107/0x140
  tcp_sendmsg_locked+0x99f/0xbb0
  tcp_bpf_push+0x19d/0x3a0
  tcp_bpf_sendmsg_redir+0x55/0xd0
  tcp_bpf_send_verdict+0x407/0x550
  tcp_bpf_sendmsg+0x1a1/0x390
  inet_sendmsg+0x6a/0x70
  sock_sendmsg+0x9d/0xc0
  ? sockfd_lookup_light+0x12/0x80
  __sys_sendto+0x10e/0x160
  ? syscall_enter_from_user_mode+0x20/0x60
  ? __this_cpu_preempt_check+0x13/0x20
  ? lockdep_hardirqs_on+0x82/0x110
  __x64_sys_sendto+0x1f/0x30
  do_syscall_64+0x38/0x90
  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Reject selecting a non-TCP sockets as redirect target from a BPF sk_msg
program to prevent the crash. When attempted, user will receive an EACCES
error from send/sendto/sendmsg() syscall.

Fixes: 122e6c79efe1 ("sock_map: Update sock type checks for UDP")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
FYI, I'm working on revamping the sockmap_listen selftest, which exercises
some of redirect combinations, to cover the whole combination matrix so
that we can catch these kinds of problems early on.

 net/core/sock_map.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index cb11750b1df5..4292c2ed1828 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -668,6 +668,8 @@ BPF_CALL_4(bpf_msg_redirect_map, struct sk_msg *, msg,
 	sk = __sock_map_lookup_elem(map, key);
 	if (unlikely(!sk || !sock_map_redirect_allowed(sk)))
 		return SK_DROP;
+	if (!(flags & BPF_F_INGRESS) && !sk_is_tcp(sk))
+		return SK_DROP;
 
 	msg->flags = flags;
 	msg->sk_redir = sk;
@@ -1267,6 +1269,8 @@ BPF_CALL_4(bpf_msg_redirect_hash, struct sk_msg *, msg,
 	sk = __sock_hash_lookup_elem(map, key);
 	if (unlikely(!sk || !sock_map_redirect_allowed(sk)))
 		return SK_DROP;
+	if (!(flags & BPF_F_INGRESS) && !sk_is_tcp(sk))
+		return SK_DROP;
 
 	msg->flags = flags;
 	msg->sk_redir = sk;
-- 
2.41.0


