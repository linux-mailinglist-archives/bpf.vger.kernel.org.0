Return-Path: <bpf+bounces-71905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC7CC013CA
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 14:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0589F1A00DB5
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 12:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E477314A7C;
	Thu, 23 Oct 2025 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="G+KHs4ao"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4E83148C6;
	Thu, 23 Oct 2025 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761224139; cv=none; b=pmuJFWkaa/UXVySaiGx1dT5wXfZkWGciPgxKBVq3HayUtDQn5WD2RmWIEeRfhniAjxcBnYAghvWkqtOGZpkHAMctsT5HqJQZkWRFFy7Qv9ba6sCXtyqmM/gg83Js8v8QN0v8QVRIHT4F5GOdbcAFiQcdh9WxE18OXsK4juDbJ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761224139; c=relaxed/simple;
	bh=CCrD+zL0i7TsZmVaHnMdyzwd9zDVAfQITT4beZIkG3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2jiHgN/UDp+babV4222Hj2USfhmGft5QaYvNTZnqKw+VfEOYb9i0ZC63chm6XtlsFUDDVOkNP6FJWKgguSqxlkwVbSXi84X+IBKfMqX2qNG6LNu1zrLGOKkDRNV43j56IDkoTYrCtLdWhKk8MC2oLuszBxMmNoJ0ISDCcbEwDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=G+KHs4ao; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=sxnVyJf+Cj0EvdJChyG147AAxhoJqCkGEQp7nP4SPS8=; b=G+KHs4aoKTecXJih1UbSuhUveI
	c6XadbTptJ0iWnD37llzNtYNcWnIjXL7ZRfCuPNrDrZotV5osxOr3RhzhGxdLzD5WP/VZOwKHxU8r
	fnB7Kgp6eyjAEAhBl1Q71R9vOTz08LUhTavw6TzYfTFSNIGN7CynfmYJddnZbc58qkCqdfazD0y4s
	NzEKnP1Bhhelp/eeSkckF9Tm7sewXmETzLBbsRwOzgSEwRmIjOVSYYM5acS+gT+jvACjkujR2I3UX
	O5Uf7kITvg/Va2IBHVvxN2EjVexSG5DLCV7fxMnGHxWe7+nAT6kB1Y9AZglu2QDNFBSE10zWmAvUh
	1ZOflCEA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vBuqr-0006AA-03;
	Thu, 23 Oct 2025 14:55:33 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>
Subject: [PATCH bpf] bpf: Reject negative head_room in __bpf_skb_change_head
Date: Thu, 23 Oct 2025 14:55:32 +0200
Message-ID: <20251023125532.182262-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27801/Thu Oct 23 11:45:29 2025)

Yinhao et al. recently reported:

  Our fuzzing tool was able to create a BPF program which triggered
  the below BUG condition inside pskb_expand_head.

  [   23.016047][T10006] kernel BUG at net/core/skbuff.c:2232!
  [...]
  [   23.017301][T10006] RIP: 0010:pskb_expand_head+0x1519/0x1530
  [...]
  [   23.021249][T10006] Call Trace:
  [   23.021387][T10006]  <TASK>
  [   23.021507][T10006]  ? __pfx_pskb_expand_head+0x10/0x10
  [   23.021725][T10006]  __bpf_skb_change_head+0x22a/0x520
  [   23.021939][T10006]  bpf_skb_change_head+0x34/0x1b0
  [   23.022143][T10006]  ___bpf_prog_run+0xf70/0xb670
  [   23.022342][T10006]  __bpf_prog_run32+0xed/0x140
  [...]

The problem is that in __bpf_skb_change_head() we need to reject a
negative head_room as otherwise this propagates all the way to the
pskb_expand_head() from skb_cow(). For example, if the BPF test infra
passes a skb with gso_skb:1 to the BPF helper with a negative head_room
of -22, then this gets passed into skb_cow(). __skb_cow() in this
example calculates a delta of -86 which gets aligned to -64, and then
triggers BUG_ON(nhead < 0). Thus, reject malformed negative input.

Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 76628df1fc82..fa06c5a08e22 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3877,7 +3877,8 @@ static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
 	u32 new_len = skb->len + head_room;
 	int ret;
 
-	if (unlikely(flags || (!skb_is_gso(skb) && new_len > max_len) ||
+	if (unlikely(flags || (int)head_room < 0 ||
+		     (!skb_is_gso(skb) && new_len > max_len) ||
 		     new_len < skb->len))
 		return -EINVAL;
 
-- 
2.43.0


