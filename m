Return-Path: <bpf+bounces-62958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8748B00ADF
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 19:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DC717159B
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 17:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E712F2C4A;
	Thu, 10 Jul 2025 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huO00gNS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016082F362B;
	Thu, 10 Jul 2025 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752170085; cv=none; b=LfIwJ8vi6ifcU0kBv3dQr7iXejmlDxCnp39qSlA1c151j8psx0+YtxMovROl5On22xRFz7YwSS6yjATGBVB5nLxajvRsrbj5cE/ykZkgo2Zmd7dihG8a0/YJ+kmgGH0QizvANQGn4y92oXzNcynSX0vosl+YmV8LRsNVq+LvV10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752170085; c=relaxed/simple;
	bh=FZ759wkYPCZLYzwaQyOHGrsXS7Q57bG8bhHPAbIpo7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltRTA8xcxaSYG0me2yYFOtLYGxQ7m6BxHoVRfmHkY0HpFKrjFAbrY/lZCwtQdL5qQMPnVfvfZgWJWMAu+sc9rpDM4exKXQf8M1Upyz/1BN/yvTo5+pn+6NB8XOYMXwJmsbloHGWHJa3mQ60rDshwSXv6v71R2rHaiA0LjemyTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huO00gNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EEEC4CEE3;
	Thu, 10 Jul 2025 17:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752170083;
	bh=FZ759wkYPCZLYzwaQyOHGrsXS7Q57bG8bhHPAbIpo7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=huO00gNSVsk6XiCouip8O9udsouDPT6ZMu4jD6C9wHwHnqqEQRY8kOuKFRcdo34Th
	 JBGIwoHo0kYICHpkvZZAqvOFsaDkFatPa1HwkGXt/Tq7jI3Cdz/0SBkKGaBLRwTjMn
	 ZQzedxQI+YaVoVcz71W7C/Ob5OR4XqdTee+JbOzOB5eIG284FYN19h1NV1Y4uz0crb
	 mha7PnwZAr1zmzcslSF3LVeH2hLS0Y9rOtUqwXX3eRJ8sNg3/DJzG+duUAFXrO03/i
	 c7/mbg3PjSovtkIZhT0ofWoiTYMK81UN3TPoGUMyX+UfG6sE1H288nM9MGMI7ChlH1
	 yYirzxVwMKHUg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	lkmm@lists.linux.dev
Subject: [PATCH bpf-next 1/1] selftests/bpf: fix implementation of smp_mb()
Date: Thu, 10 Jul 2025 17:54:33 +0000
Message-ID: <20250710175434.18829-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250710175434.18829-1-puranjay@kernel.org>
References: <20250710175434.18829-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As BPF doesn't include any barrier instructions, smp_mb() is implemented
by doing a dummy value returning atomic operation. Such an operation
acts a full barrier as enforced by LKMM and also by the work in progress
BPF memory model.

If the returned value is not used, clang[1] can optimize the value
returning atomic instruction in to a normal atomic instruction which
provides no ordering guarantees.

Mark the variable as volatile so the above optimization is never
performed and smp_mb() works as expected.

[1] https://godbolt.org/z/qzze7bG6z

Fixes: 88d706ba7cc5 ("selftests/bpf: Introduce arena spin lock")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/bpf_atomic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_atomic.h b/tools/testing/selftests/bpf/bpf_atomic.h
index a9674e544322..c550e5711967 100644
--- a/tools/testing/selftests/bpf/bpf_atomic.h
+++ b/tools/testing/selftests/bpf/bpf_atomic.h
@@ -61,7 +61,7 @@ extern bool CONFIG_X86_64 __kconfig __weak;
 
 #define smp_mb()                                 \
 	({                                       \
-		unsigned long __val;             \
+		volatile unsigned long __val;    \
 		__sync_fetch_and_add(&__val, 0); \
 	})
 
-- 
2.47.1


