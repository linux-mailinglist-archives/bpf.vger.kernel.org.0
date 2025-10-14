Return-Path: <bpf+bounces-70939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D43BDBAFC
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 00:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B910E4FA882
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 22:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8471230F928;
	Tue, 14 Oct 2025 22:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udPoxrTH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B8230DEDA;
	Tue, 14 Oct 2025 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481815; cv=none; b=rVYQj2efLS97/fVpFb+Q8b0Mh1NpnleTtQvkGnbBqQbTHPNFbzGcE2BpYQVlBLyjDVNbzMeUUL9O6ZYkIAxcWd02+PsxnCQwIlrFA9TpGQzJuLtJOhN5Cvr/qtUp4JdyqfnED1MH7ImpHdD5QndHS2S+E2XD3eWf3pZXTcckQi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481815; c=relaxed/simple;
	bh=bQd5cenkOht/JSwBufm7hRn/50ULrFrxuspR8e8U7QY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oakcMpA3rfXxDGCxl0bF0EyA0PdJB5q8gK+Ky8h2rgW7sIBvLEBvTsIHGCDaAa/qgGozaOWhe01hYGys1lFsRxvIp8W91x8EdTAuP7LtVtXFHjrJShy7DSO8BKked7ghrd4ywLKMxGlJPSB4XkXOveC5JJUN2HFWHasNIzdPZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udPoxrTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D2FC2BCB5;
	Tue, 14 Oct 2025 22:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760481814;
	bh=bQd5cenkOht/JSwBufm7hRn/50ULrFrxuspR8e8U7QY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=udPoxrTHWEDQ+gJCeS8kApqDbTMhjp1jRMk8TQ+jcn2prM640JHFTaAqmyM7BEmZP
	 1NQb6/yAApY1FjFoaY740NjCy6RWecGnvqjBPscLfG5lZgx5kC32Pnk6M2Ie0SvmhD
	 8NS071K59cQcoSDmgrOVnDXesh02Ld54LOQ7VdaHkHD4bMDFYnNuyG1EJZuwm0u2qJ
	 Bf/HQMBySvBmnVYV1GKq8U+9FKU3VSM01Mbn8y6v17FgUXIpdVV6/faD2eFKhrN2lq
	 02Ydhg9Q0iZcOSZMd8e8/Djj6BHpkBgrV7YrCt08zjiuUfw52xOFAgKYlZlB+57YQg
	 lqRAMrs/OBD2w==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 09/10] bpf: Add size validation to bpf_sock_addr_set_sun_path()
Date: Tue, 14 Oct 2025 15:43:31 -0700
Message-Id: <20251014224334.2344521-9-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014223349.it.173-kees@kernel.org>
References: <20251014223349.it.173-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715; i=kees@kernel.org; h=from:subject; bh=bQd5cenkOht/JSwBufm7hRn/50ULrFrxuspR8e8U7QY=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnvLgnnm3fu9I/70BjY4n/SKTnewur1to+njWeLtTvnr WZzm+/aUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJFZFYwMP/nZFk88dfDaBsVF z1Ny/+zaNSGlfVZIylG/RPddR13v3WRkuKT0u4G7cdpihVrBL/tcP/3OOzVJ+neiBPu8jYf2PHh 6kxkA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Add defensive size validation to bpf_sock_addr_set_sun_path() before
writing to the sockaddr buffer. While the underlying buffer is guaranteed
to be sockaddr_storage (128 bytes) from the bind() syscall path, the
function should validate that "sa_kern->uaddrlen" is sufficient for the
sockaddr_un structure being written.

The validation checks that the available buffer size ("sa_kern->uaddrlen")
can accommodate both the sockaddr_un header and the requested path length
before performing the memcpy() operation.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 net/core/filter.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index b96b5ffc7eb3..fa6c5baf0bf3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12089,6 +12089,7 @@ __bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
 					   const u8 *sun_path, u32 sun_path__sz)
 {
 	struct sockaddr_un *un;
+	size_t required_size;
 
 	if (sa_kern->sk->sk_family != AF_UNIX)
 		return -EINVAL;
@@ -12099,9 +12100,14 @@ __bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
 	if (sun_path__sz == 0 || sun_path__sz > UNIX_PATH_MAX)
 		return -EINVAL;
 
+	/* Validate that the buffer is large enough for sockaddr_un + path */
+	required_size = offsetof(struct sockaddr_un, sun_path) + sun_path__sz;
+	if (sa_kern->uaddrlen < required_size)
+		return -EINVAL;
+
 	un = (struct sockaddr_un *)sa_kern->uaddr;
 	memcpy(un->sun_path, sun_path, sun_path__sz);
-	sa_kern->uaddrlen = offsetof(struct sockaddr_un, sun_path) + sun_path__sz;
+	sa_kern->uaddrlen = required_size;
 
 	return 0;
 }
-- 
2.34.1


