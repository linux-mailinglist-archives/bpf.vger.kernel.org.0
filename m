Return-Path: <bpf+bounces-45903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199CB9DF095
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 14:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A140B21748
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 13:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFF819D8B4;
	Sat, 30 Nov 2024 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K90m6ATG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDE319B3EC;
	Sat, 30 Nov 2024 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732973955; cv=none; b=ku+vFsMDm7yvPaHDclYm8NGWnEoGlrjpTja/qz60N8cmwlTwlZCQT6UpW/1AyubiiaqjNl9Ki6qg6s22TY8c2yEQsp0pSi0yneYTHv7K/Demp8FdZj6IVcOsQCjdPSfOMdd0puyFE4NZbiBmUyhg+EMYBqKnIY44Y8FwIgo5cCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732973955; c=relaxed/simple;
	bh=YoSM2//cc1OE75pq1asOHygr+KnTmSM58GCnV79QVXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=STYx8VzZRmF0cdhu/5T0COBc5wnn5x41cE0p0Q07KhRjyFw9FstFXc08jL+KcwpGE41w2zS7g9UJ6oIZHXXJbLoVTkhfwOFNHA9pTT7UyxeoZsF4FJX5uBlHFAtJKrnyaD52QP3eocpOGxG9MmGVCfHg3o38DlntMi44WP2QLD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K90m6ATG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B1E6C4CED9;
	Sat, 30 Nov 2024 13:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732973954;
	bh=YoSM2//cc1OE75pq1asOHygr+KnTmSM58GCnV79QVXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=K90m6ATGI1uKjxBiHQT7I4cq4mR9KgA7lpS8DCJUjc9x2EFHpUsAC6hpvHYVCv+l2
	 USCsStfVNmx2NtiNA5vckPD7TuXflE9weef1+3Pt90qGXsS6a08SxxdyL5MiJhStud
	 WDv/fQT8siw6nTE2SWeUxdW9YBZNYRZ3NCa9VSanphcMM+iP8+hjoADWqDnLO+HhNY
	 iWuoQYS/l/k15LDNN8HG46s8oFyx7hwdYRSx1GcArvQpzgTqdPgyK8Ba1r1iviKPie
	 JAI7k1LzYfFlrF73ZbwZkvi3Z4lSk72KrR8wadadTHQvcV7rctH60d1qIaSaBsOYb1
	 Nflp13jCfwj8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB0BD73607;
	Sat, 30 Nov 2024 13:39:14 +0000 (UTC)
From: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Date: Sat, 30 Nov 2024 21:38:23 +0800
Subject: [PATCH net 2/2] tcp_bpf: fix copied value in tcp_bpf_sendmsg
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-tcp-bpf-sendmsg-v1-2-bae583d014f3@outlook.com>
References: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
In-Reply-To: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Levi Zim <rsworktech@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2613;
 i=rsworktech@outlook.com; h=from:subject:message-id;
 bh=BSkGG9GTRoR+hvU0RGsIgrZN4wSOYMDvwCLwhO4xA0I=;
 b=owEBbQKS/ZANAwAIAW87mNQvxsnYAcsmYgBnSxV/R4dBaQRVcQRIIaNhbEPgxR11GIvnSrfk0
 FNrgI8Ds9qJAjMEAAEIAB0WIQQolnD5HDY18KF0JEVvO5jUL8bJ2AUCZ0sVfwAKCRBvO5jUL8bJ
 2JhIEADFnoc0KrtgtrkTiauoo1Nu6q/SztNB5pqKgENVv6F8U11ZtAThNKgJZ0bAqOedmgz5Sa5
 rNVW2ooN6hS4zKVq5SGypoGoMqx9k+dEX8B7NP7eQpcU+HOhyXx0eTKZs8P8Yre2UL9N4ZJdRMF
 AiCTaPnh+Cs3nnuJTK5yMsPsc9c4miizFTzs34FidtHRZ/mRayXqMkVqBnI5aVx6WzoThrtI/mY
 wGbDC9Qa2jzzAovMCbooG9lxTch9mzRM/p0sbBOAve5eMRnkagDDEqWRPP+sbfhkd+U06REtM8S
 95K8uBtqDgQUXSvVdwD2vv2CgDqvkAtHoSehPN47Rcq9JnATvSLxkQqqi1kWWRKvdgHz6Dmm2cy
 Iy83wsC5iydLapfsWp/vUn60NAHBYBQtaBNpOMl/mZIiWXZCLaq2+UMT+Ybf9tTx3bn/9wdgSUC
 yIiMvdl57DAobJRLzr+tcFQ6AiKTHOAZ1pmuzkAY9sv3VCDdyZWTlvdljJdiGoM1lf1pNX5VAdq
 cQcc2hQ1Kmzz1xoUQGv2eRlZ7yiT0YgDVPWs900RGh5N34V6cml7qhDy36RIpv0EIOu/OIBmstL
 rJ887YIecSfwhK311xHvFjyrCiDcj+4e9SAfYZhV0+ZwirotZ+QM7aiSbZAaoc32pC1pp4ct0HD
 3VbRGGq8Qa/z4rw==
X-Developer-Key: i=rsworktech@outlook.com; a=openpgp;
 fpr=17AADD6726DDC58B8EE5881757670CCFA42CCF0A
X-Endpoint-Received: by B4 Relay for rsworktech@outlook.com/default with
 auth_id=219
X-Original-From: Levi Zim <rsworktech@outlook.com>
Reply-To: rsworktech@outlook.com

From: Levi Zim <rsworktech@outlook.com>

bpf kselftest sockhash::test_txmsg_cork_hangs in test_sockmap.c triggers a
kernel NULL pointer dereference:

BUG: kernel NULL pointer dereference, address: 0000000000000008
 ? __die_body+0x6e/0xb0
 ? __die+0x8b/0xa0
 ? page_fault_oops+0x358/0x3c0
 ? local_clock+0x19/0x30
 ? lock_release+0x11b/0x440
 ? kernelmode_fixup_or_oops+0x54/0x60
 ? __bad_area_nosemaphore+0x4f/0x210
 ? mmap_read_unlock+0x13/0x30
 ? bad_area_nosemaphore+0x16/0x20
 ? do_user_addr_fault+0x6fd/0x740
 ? prb_read_valid+0x1d/0x30
 ? exc_page_fault+0x55/0xd0
 ? asm_exc_page_fault+0x2b/0x30
 ? splice_to_socket+0x52e/0x630
 ? shmem_file_splice_read+0x2b1/0x310
 direct_splice_actor+0x47/0x70
 splice_direct_to_actor+0x133/0x300
 ? do_splice_direct+0x90/0x90
 do_splice_direct+0x64/0x90
 ? __ia32_sys_tee+0x30/0x30
 do_sendfile+0x214/0x300
 __se_sys_sendfile64+0x8e/0xb0
 __x64_sys_sendfile64+0x25/0x30
 x64_sys_call+0xb82/0x2840
 do_syscall_64+0x75/0x110
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

This is caused by tcp_bpf_sendmsg() returning a larger value(12289) than
size (8192), which causes the while loop in splice_to_socket() to release
an uninitialized pipe buf.

The underlying cause is that this code assumes sk_msg_memcopy_from_iter()
will copy all bytes upon success but it actually might only copy part of
it.

This commit changes it to use the real copied bytes.

Signed-off-by: Levi Zim <rsworktech@outlook.com>
---
 net/ipv4/tcp_bpf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 370993c03d31363c0f82a003d9e5b0ca3bbed721..8e46c4d618cbbff0d120fe4cd917624e5d5cae15 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -496,7 +496,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 {
 	struct sk_msg tmp, *msg_tx = NULL;
-	int copied = 0, err = 0;
+	int copied = 0, err = 0, ret = 0;
 	struct sk_psock *psock;
 	long timeo;
 	int flags;
@@ -539,14 +539,14 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			copy = msg_tx->sg.size - osize;
 		}
 
-		err = sk_msg_memcopy_from_iter(sk, &msg->msg_iter, msg_tx,
+		ret = sk_msg_memcopy_from_iter(sk, &msg->msg_iter, msg_tx,
 					       copy);
-		if (err < 0) {
+		if (ret < 0) {
 			sk_msg_trim(sk, msg_tx, osize);
 			goto out_err;
 		}
 
-		copied += copy;
+		copied += ret;
 		if (psock->cork_bytes) {
 			if (size > psock->cork_bytes)
 				psock->cork_bytes = 0;

-- 
2.47.1



