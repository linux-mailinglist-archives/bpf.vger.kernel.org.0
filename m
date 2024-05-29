Return-Path: <bpf+bounces-30879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4898D4169
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 00:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFF9F1F235F5
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 22:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6501A16F0DE;
	Wed, 29 May 2024 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVYzEaJg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AF8169AC5
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717021969; cv=none; b=qiksEjFi0rraqL3qAkyWItTsCwK1Mbxwq+hsl63pVbTHKXKUcnA8JzQMkC+StVcW50wtDteLyrnV9uT4yNePwheQNhNCUvdH0yC2CJqgqlfMYyRfzZjJDP22Is6kmJ+YyCJK9uACJFmD8P30bHHYu+yp+irx0cLblMZP1Lr5a+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717021969; c=relaxed/simple;
	bh=vEk0TtXp/VZOdERM7/MLigZoBedl/T8Iwtg28gSG9yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=crFo32UeBp52ZrlpvUx/xyiLbEPD5B20HDidjrsu2RmRMM6T4+NchIUmqffAs+HcMXcJuDxvU3qYMKI0+KZdO7cIuiJC13GHHt0dBCyYYmeGq7uEaNG1/cjjGhrfd7zJs2543hxzatQRwubmRkIWIA7mq5IfAVaWJ4ZKzp1zdII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVYzEaJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A556C113CC;
	Wed, 29 May 2024 22:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717021968;
	bh=vEk0TtXp/VZOdERM7/MLigZoBedl/T8Iwtg28gSG9yk=;
	h=From:To:Cc:Subject:Date:From;
	b=ZVYzEaJgHERyarq96bLzWKa/m+gceWF7UoaAwASidorZZoQ9+5vB3UqMgfNKefZTg
	 fh6+szT832nsL40W7UvsxwF6+BKRQcQ4NfawA9t5RUhKQzLVYTYohRJJG8zsVPOIYd
	 MF6TY9IQrMGHEaDN4JjBe6qjnqkLS8F1kncRG9hZfgrspWgDbYYYucTUENhk5eZllg
	 8OG/i/hqW8maI6f2x/Px39+AAT4u2Q4Sx8XUwhoulkKmuK6lUIgb2eSWrZbgcS3+UN
	 qjlKSXu8/SCbTuaCNz7ML/Y8B+kykWOKjSyJVu1Lg2S2d+LUYVI1ulPXO8MjAOILvE
	 PIjL5inhApxjw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Lennart Poettering <lennart@poettering.net>
Subject: [PATCH bpf-next] libbpf: keep FD_CLOEXEC flag when dup()'ing FD
Date: Wed, 29 May 2024 15:32:39 -0700
Message-ID: <20240529223239.504241-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to preserve and/or enforce FD_CLOEXEC flag on duped FDs.
Use dup3() with O_CLOEXEC flag for that.

Without this fix libbpf effectively clears FD_CLOEXEC flag on each of BPF
map/prog FD, which is definitely not the right or expected behavior.

Reported-by: Lennart Poettering <lennart@poettering.net>
Fixes: bc308d011ab8 ("libbpf: call dup2() syscall directly")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf_internal.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index a0dcfb82e455..7e7e686008c6 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -597,13 +597,9 @@ static inline int ensure_good_fd(int fd)
 	return fd;
 }
 
-static inline int sys_dup2(int oldfd, int newfd)
+static inline int sys_dup3(int oldfd, int newfd, int flags)
 {
-#ifdef __NR_dup2
-	return syscall(__NR_dup2, oldfd, newfd);
-#else
-	return syscall(__NR_dup3, oldfd, newfd, 0);
-#endif
+	return syscall(__NR_dup3, oldfd, newfd, flags);
 }
 
 /* Point *fixed_fd* to the same file that *tmp_fd* points to.
@@ -614,7 +610,7 @@ static inline int reuse_fd(int fixed_fd, int tmp_fd)
 {
 	int err;
 
-	err = sys_dup2(tmp_fd, fixed_fd);
+	err = sys_dup3(tmp_fd, fixed_fd, O_CLOEXEC);
 	err = err < 0 ? -errno : 0;
 	close(tmp_fd); /* clean up temporary FD */
 	return err;
-- 
2.43.0


