Return-Path: <bpf+bounces-31488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B8E8FE2D8
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 11:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DD12829BC
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 09:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FB4178CC3;
	Thu,  6 Jun 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXzy/eDR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEA115381F;
	Thu,  6 Jun 2024 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666083; cv=none; b=sjYdX1EKry1/huwxYV87wAyjdMcgQfQCDfU1L5FYQPmJobiv3VDs0SyMukqWz6cB5wmq7fo1cEWH9Kt+P855CGSMkVUsYgJyjjivDDWnOsvCiKrwc2eA9JIltDUWW2DiRgRyNlfZjh74buRDWHTwYz5V5HMNKa0uxDtKvM8BydY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666083; c=relaxed/simple;
	bh=ZnCu5TajAH5LyP1DnwsqQ7xn4FH1tdoSHV6nygQazWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DLvwYa6sOM5hyBbAb0sXzPJOiXITPOcorWBMyvLlDcESS5ZF3JtOXnQvVq6UUZmR8VqvA9ZOMw4DIzlV2qVigMF3M2w/okkiuN0jUih6/dd/nDQluJAxIRo7sb4t2858JRfvdRY1l8RLOcS7qFVFZrS3DpVTxjJBGnml7tP9QEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXzy/eDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D54E4C4AF0B;
	Thu,  6 Jun 2024 09:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717666082;
	bh=ZnCu5TajAH5LyP1DnwsqQ7xn4FH1tdoSHV6nygQazWc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MXzy/eDRHazjZ5/rqUiAbvlldabqfqNc2YA8Z8I+egAkBBIgpvpZT6drl6u2se9EX
	 +5JLpeHEwD3f6n6dRfsOiN9fJiA+c2Wvl7npz/nlxUTEhTAes43glxArxlyYH7GfK9
	 3qRQsxkubYh6n+EkdVsAP8MwVCq5LXIG3QBQ9QJyvlSpCxe5fnRNaoRPqmhGxgr3gO
	 f05QcOYTYKZxrKkV2NxPaqPYjsjbzqIdo9Mp6H9CXvwhKqyX7jYKs1ACRpfM92pYgN
	 1oE8gaJEwcAzmWcsKiVBuxTvcRHYCp35kGKmx1FKqV+bCyZwgiSxhk5iOhPeye2AHF
	 vUrQ8jvq+Furg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B0DC27C6D;
	Thu,  6 Jun 2024 09:28:02 +0000 (UTC)
From: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>
Date: Thu, 06 Jun 2024 11:27:54 +0200
Subject: [PATCH bpf-next 3/5] selftests/bpf: sockmap: Exit with error on
 failure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-sockmap-splice-v1-3-4820a2ab14b5@datadoghq.com>
References: <20240606-sockmap-splice-v1-0-4820a2ab14b5@datadoghq.com>
In-Reply-To: <20240606-sockmap-splice-v1-0-4820a2ab14b5@datadoghq.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717666080; l=739;
 i=vincent.whitchurch@datadoghq.com; s=20240606; h=from:subject:message-id;
 bh=s+cGvRIItR2T1BSyPd1aAjKIAS5wEiDTK0IA+jXP+Lc=;
 b=v+BA4IwBGIyiVcfjNeL6acPzZDr2tvNeA1MJskBYLiNAd04pwDg4drD5MTBtzX0IalFB66io6
 eh+dTuYoP5yCXyu2MG2WdfLo2IlmVGRV1U9mRx9l+paLqlIozs4uobi
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
index 9cba4ec844a5..ab7e169f5afa 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -2079,7 +2079,9 @@ int main(int argc, char **argv)
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



