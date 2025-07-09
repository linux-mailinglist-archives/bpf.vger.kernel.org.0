Return-Path: <bpf+bounces-62786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF35AFE957
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 14:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64A91C81B6B
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 12:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFB72DBF45;
	Wed,  9 Jul 2025 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCjG5CGU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54421DA55;
	Wed,  9 Jul 2025 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065286; cv=none; b=aAuxcJot0JUr9yBmHBm8Wn7+NuiMDWNy8YdxyXJDOKFsBzekZM6/fMNnoPL7rxKxEQ5b73kcD/BfT35T6s3I+k7jf1P/FQ4q5GHykBtx59U1+9bmCN2jJu6I85z1WS9fJjYmQDgC7Y2+WfTb0lEhTsrzGh6ER2SPpWZJ71Qvqqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065286; c=relaxed/simple;
	bh=nc3g9xIfmPcrqMrMsFOVDXjNJyADJlqvbFOcKHLdW0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kP+k7NgmMwLICIEwFYXLP+g0dJKMSq60p/YOfUrCojtM05eHf/UqnU06IYW76RYBXmtQgr68gMkumJP6r6roz0WB6PM8GjBLUhff+llPbtoadVRUGbEezqDB/labb2pfoW7miogdtJBeQhyhBtDszCj9RlU8sxbIbAKrbohCxbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCjG5CGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF36CC4CEF6;
	Wed,  9 Jul 2025 12:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752065285;
	bh=nc3g9xIfmPcrqMrMsFOVDXjNJyADJlqvbFOcKHLdW0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uCjG5CGUXxMvxZDSbRfOmfUx376N1ZW9m3lVwQmkxVpjNOS95BN5Txw6avhXhTr+z
	 O0VypzO63gZwBmBFFV0TaD3Q14M1kZOSqc+Hibh1IwXNxh5tthEHAWfe/s2knEWrmX
	 HDnWmxyiTScFA61bu5jwn4fkIhPUuHs6YS59ofAbLJEZ0GHyo+VhHm4Dvz/nB7hlKm
	 bFJqfo3MO2x6TOQzUK+XrETQxQXMj94M5AItGMyF6YZHrh4prgoUzZuptiQrQhV1I7
	 8jHKrzIxRw+MXMl8bzbjh0mt9FqfBybYRcnQymC3srvLyppJOtkuk2wK45UU2Jbrwc
	 YpjCqzX9WBT+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0990C83F03;
	Wed,  9 Jul 2025 12:48:05 +0000 (UTC)
From: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>
Date: Wed, 09 Jul 2025 14:47:59 +0200
Subject: [PATCH bpf-next v3 3/5] selftests/bpf: sockmap: Exit with error on
 failure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-sockmap-splice-v3-3-b23f345a67fc@datadoghq.com>
References: <20250709-sockmap-splice-v3-0-b23f345a67fc@datadoghq.com>
In-Reply-To: <20250709-sockmap-splice-v3-0-b23f345a67fc@datadoghq.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752065284; l=739;
 i=vincent.whitchurch@datadoghq.com; s=20240606; h=from:subject:message-id;
 bh=zvCxjLCWikXEcOPolUq/9Ge5sJ6PAHHwLBy0hdL4r6w=;
 b=ijVwXxlM0T4A/BbKbsyrkoIzpmHoxHafn0SUi/TfWttOHwJBkxXHr2FCXmqpv74F2UWjePEgk
 C+5DkA+sGqoDR1/X4kvPqLsS932lNm40/doE/wpWnYbMd+MBSrrIhgs
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



