Return-Path: <bpf+bounces-72905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E559DC1D7C1
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 22:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9A13B4995
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 21:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADDA31DD8A;
	Wed, 29 Oct 2025 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZV4qlgXt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CB631A062;
	Wed, 29 Oct 2025 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774268; cv=none; b=DSgBGQWPW9u4f7Y6WbiJN5lXAYFnOkIqXSqAOAQ95dJIjftpAfOIRa7SkSBCuFNjM0gf+8pfqPX6k5In/J/PPDTfxmHx6zggfCx+uvXvF4qh+uAZGrUSln9YanCaIHe8/5N28KYb8sI5bB8oExSTiLNM1HfkljOPMan+99vEIlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774268; c=relaxed/simple;
	bh=df1PiIrJZqCah2hLW/KzqMjbXuVjxXuE5Xm3CRH5CeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8icR42ksyYxyRL/nfDAqRR8Rx4QNFwPxuPT/BuIN41YhHefsiQzlPwhgAhVrXGM+VTD5wVY7TDbjhSFJciMMuEfGJEI1nrkqywY3EEXB98LNJ3hSxoXsk34ey2nWmcHXULHGrbENx2Rbqvv1Evif6+L5cs66VDDREpDNH1v/R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZV4qlgXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A74C4CEF8;
	Wed, 29 Oct 2025 21:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761774268;
	bh=df1PiIrJZqCah2hLW/KzqMjbXuVjxXuE5Xm3CRH5CeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZV4qlgXtKqoZdqSqqfZpvWI3yqRMfg/yYkiVB4OmMsgwGCci/Q3stmo7n/bdxo+TH
	 niIReZTuF2jmZSsY/+lDPgwRyJyo+H4RoULZ2rDHlEe3R5BJl3B2OAWhIN11G/uJgw
	 x4hpAUMieHRcyiRv9NoC6zX7QMNXtZnll24IgNSt/g7tuPxmkx54L/GxJEmRjj8hLZ
	 c7tuZ9IooZM8pUzvHcE5OEEe7p+roJcAMeKKN6jFZ40ceK3fiS1fFxkVDa8B9dSi9Q
	 9wVjoZvBT+KNK5/M9b9fRS58Z9OZhXKdy1kEWzfXX7NF5Im45krBv7NwOVin/+gzFk
	 JPkLFR5Ts4+3Q==
From: Kees Cook <kees@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [net-next PATCH v4 3/7] net: Remove struct sockaddr from net.h
Date: Wed, 29 Oct 2025 14:44:00 -0700
Message-Id: <20251029214428.2467496-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029214355.work.602-kees@kernel.org>
References: <20251029214355.work.602-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=494; i=kees@kernel.org; h=from:subject; bh=df1PiIrJZqCah2hLW/KzqMjbXuVjxXuE5Xm3CRH5CeU=; b=owGbwMvMwCVmps19z/KJym7G02pJDJlMXYvKt15hP+nyuGXXnfX/LQ4+NOr9vOe/w6Te6vrl+ 95P3d7d3VHKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjCR37mMDJNm1M5XPH7+hdDH PkslI/PnNRNsy9/HqpjJTDm1g5nr1AlGhpXftv0p7OgvkTHacnq6SNRTkZADrYtn1tStr817WyO wjxEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Now that struct sockaddr is no longer used by net.h, remove it.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/net.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index db6bc997ca5b..f58b38ab37f8 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -148,7 +148,6 @@ typedef struct {
 
 struct vm_area_struct;
 struct page;
-struct sockaddr;
 struct msghdr;
 struct module;
 struct sk_buff;
-- 
2.34.1


