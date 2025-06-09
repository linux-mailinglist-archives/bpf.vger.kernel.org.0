Return-Path: <bpf+bounces-60050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03760AD1ED1
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81848188C940
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 13:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB06F25A350;
	Mon,  9 Jun 2025 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7YFsPyQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5831259C84;
	Mon,  9 Jun 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749475634; cv=none; b=q+S/VQRIQHYWDM/FiqdmEXk2rcc6wIGMZ/gTt/X5FHlwVWk8FhgLGh7hjdDlbpeq0omJYqDlFKaKdNEKm9Gp7vE/TuncROT6sPmruWMhXXvOhZzBGL4RxewOZmat3xO0W/YdBcyRjdX1eBD6RV/BzrIiDjgswH1y+UOdj/Cx0yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749475634; c=relaxed/simple;
	bh=nc3g9xIfmPcrqMrMsFOVDXjNJyADJlqvbFOcKHLdW0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ls+2VRcPqLb6ra+tjtm3UqefPcl2zfENGN87GUsl7pVmEZUbTSaBrCGG+PEYhULYbgjCOY/51riuJqhfmKKLslDk54fYl/C88vCGjS+5bOUEnA2NsOlYccjLmdmOYD1ePZ3qUwSDqD7WgDU/YHE8xzU68NfjiZLleOStjYbi/uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7YFsPyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EE28C4CEF2;
	Mon,  9 Jun 2025 13:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749475633;
	bh=nc3g9xIfmPcrqMrMsFOVDXjNJyADJlqvbFOcKHLdW0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=G7YFsPyQWfVCtWpggcPpTq8vp1GM/WFNNFEJPmXUmhjogbil9wXyq37dA03IiAyGj
	 iNc++OyK7l9PgPc+MCS+WrRtoSzM9MJe9eiee751RsmK/vl9Lpb5C5YoXANUsgAsTq
	 QyKMNNNV2S6jygCKwrm14+fiV64e993NATuV4KZtzAa05emBCpiKYy/+Rz95oFF8tw
	 ki9jwEruGmJT1Ma5hMzguxf5rFmmwmntV8oQjZ5hLwredXLQrsMTLmRDDXs6xYHwr7
	 P+Ari0bu/qKW3JKlXVc3gxvZFzkl+wlvvn0CtbGyfOddRUXv3e93pMoKjaUqu1gfsF
	 OxJumofBKcLqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85670C61CE8;
	Mon,  9 Jun 2025 13:27:13 +0000 (UTC)
From: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>
Date: Mon, 09 Jun 2025 15:27:00 +0200
Subject: [PATCH bpf-next v2 3/5] selftests/bpf: sockmap: Exit with error on
 failure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-sockmap-splice-v2-3-9c50645cfa32@datadoghq.com>
References: <20250609-sockmap-splice-v2-0-9c50645cfa32@datadoghq.com>
In-Reply-To: <20250609-sockmap-splice-v2-0-9c50645cfa32@datadoghq.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749475632; l=739;
 i=vincent.whitchurch@datadoghq.com; s=20240606; h=from:subject:message-id;
 bh=zvCxjLCWikXEcOPolUq/9Ge5sJ6PAHHwLBy0hdL4r6w=;
 b=eWw43c2PIjFVk8vp02nfNuVjaQhpIZAAx+un2YJaK6v7SrB30ALbKLzdnb+WUrfgV8tfBR04A
 BdBsyguCu5JAHC5TIt7IbVEaTV1cHUVpcskhe+C+H6i/9Rl5KP4eo+t
X-Developer-Key: i=vincent.whitchurch@datadoghq.com; a=ed25519;
 pk=GwUiPK96WuxbUAD4UjapyK7TOt+aX0EqABOZ/BOj+/M=
X-Endpoint-Received: by B4 Relay for
 vincent.whitchurch@datadoghq.com/20240606 with auth_id=170
X-Original-From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Reply-To: vincent.whitchurch@datadoghq.com

From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>

If any tests failed, exit the program with a non-zero
error code.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index fd2da2234cc9..cf1c36ed32c1 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -2238,7 +2238,9 @@ int main(int argc, char **argv)
 	close(cg_fd);
 	if (cg_created)
 		cleanup_cgroup_environment();
-	return err;
+	if (err)
+		return err;
+	return failed ? 1 : 0;
 }
 
 void running_handler(int a)

-- 
2.34.1



