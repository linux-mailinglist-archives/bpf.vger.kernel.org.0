Return-Path: <bpf+bounces-59521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94511ACCC61
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 19:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80EAC169195
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 17:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6801C1E5734;
	Tue,  3 Jun 2025 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9kY2LWy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737A4A01;
	Tue,  3 Jun 2025 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748972766; cv=none; b=N1Z6hnB3qK1R/yyQXh/eyWd8xklKtCmU4zJSrLceCJ6x2AAgpfR1wYVQIU0dXvV0ETOSNtrY29q0EBVm5mdq8wYMDB8TJ6N79jxyqfrldGD5cB+XOM3Rs4cIrJZkPtwqt/9tgLOd96ejSK9zLK7a4kZ6WHQH7oUKawftyqWqYQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748972766; c=relaxed/simple;
	bh=6wfRr16erOE3busP1wNW6kRcqcX/VouGl9L27r1lAok=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUJubmwc0bXmDgMOd+Y3mKhPseMGxsSX8EWO0I7Xm0iNg+fbwMqZtMBtTD7KTkOhegnrcbe9G5oAIwnSWBuGGnv4itug9TmxF3BXPk7e1Jl22f2qkMY5M/cFBDCg3gB7dTkkWI3KLGcXbRiWN3mWwIpp5fyDGoKSWntBqUUzyaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9kY2LWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E34C4CEED;
	Tue,  3 Jun 2025 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748972766;
	bh=6wfRr16erOE3busP1wNW6kRcqcX/VouGl9L27r1lAok=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=T9kY2LWyzcFfnmWLQApcaE34f6z99OZv3hREZVLZVa9NUaEuc0W4K/3gN1GZjuaj/
	 ZEFn+a8MI9+xfaBsvzURas4hEfWXQ4pm3szsPT4dwNi563dgKOtb+Yr7PvAEHOb6+Q
	 Qu/FPl50lKnID3Keg1i+nkS3bIeE+30OynY8QMnKqa2TPMPQy9eAzI6Ic+ygwCKcfl
	 vB8dS7A/kRMOqxlBEzC+iCqviPZsPJYS61ITsO2U7QeJUHjdmnA1UkXBi8rBwwqBgO
	 wAW3r0Py+eLxiIs0/uDtwg/pN0J3Uzl178rICHGYUzrA2r0foblHP38aVzebFsw4So
	 q8+7CnggSBhEQ==
Subject: [PATCH bpf-next V1 2/7] selftests/bpf: Adjust test for maximum packet
 size in xdp_do_redirect
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, lorenzo@kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 sdf@fomichev.me, kernel-team@cloudflare.com, arthur@arthurfabre.com,
 jakub@cloudflare.com
Date: Tue, 03 Jun 2025 19:46:01 +0200
Message-ID: <174897276136.1677018.3898333067847227284.stgit@firesoul>
In-Reply-To: <174897271826.1677018.9096866882347745168.stgit@firesoul>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Patchset increased xdp_buff with a pointer 8 bytes, and the bpf/test_run
struct xdp_page_head have two xdp_buff's.  Thus adjust test with 16 bytes.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 .../selftests/bpf/prog_tests/xdp_do_redirect.c     |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
index 7dac044664ac..25904348b954 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
@@ -59,12 +59,12 @@ static int attach_tc_prog(struct bpf_tc_hook *hook, int fd)
 
 /* The maximum permissible size is: PAGE_SIZE - sizeof(struct xdp_page_head) -
  * SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) - XDP_PACKET_HEADROOM =
- * 3408 bytes for 64-byte cacheline and 3216 for 256-byte one.
+ * 3392 bytes for 64-byte cacheline and 3200 for 256-byte one.
  */
 #if defined(__s390x__)
-#define MAX_PKT_SIZE 3216
+#define MAX_PKT_SIZE 3200
 #else
-#define MAX_PKT_SIZE 3408
+#define MAX_PKT_SIZE 3392
 #endif
 static void test_max_pkt_size(int fd)
 {



