Return-Path: <bpf+bounces-21150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6313848C01
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 08:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A347228240A
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 07:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585BE9479;
	Sun,  4 Feb 2024 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHc1PZTU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17618F72;
	Sun,  4 Feb 2024 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707033462; cv=none; b=aFKJ9nvLKKZt9hlVi2Fdp7lD92httOZsxGlvY0qD02WYOi7PCzB1T1KTQ53lgqXXgvTqulcmA0kxHkW0H5+xTwzEXvAISmos9AsIkBD8H1F6pqnE5ZditFiuNLEkbWdPQ4MDsVCCa1j2fi2czDBrTyaz9fZv2J+HvTNPSX2tFJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707033462; c=relaxed/simple;
	bh=iUmin44j0XR3TQtN9khodNxCLgpk4mSAs/ZltHAV8fI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=auOyobTAGm6HpBVOO5lIlaBwNZwWxgouHMP8fUQPfjjyP0z3GSqrTqfmPdqOm1GyferRhQaZhd5QXuISwIu3sFUlx/HvbQZd5mAVQyUTZeaAJiq6OB9ECEuM7QJ5d2zotTMcJNJ7+j4H9r2fEmhmjY4DOLqB/NPpOIqaO+j7x7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHc1PZTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288A3C433C7;
	Sun,  4 Feb 2024 07:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707033462;
	bh=iUmin44j0XR3TQtN9khodNxCLgpk4mSAs/ZltHAV8fI=;
	h=From:To:Cc:Subject:Date:From;
	b=MHc1PZTUBGUPV64KSSegREl6PIvZQFyCExP3IkGbEJPyRkqwM1o+uta3QBG8R22x+
	 +3DephlHQO4cWDlv9kTMdOwg2UDw/ZRt9qLhL+xIP9guSPy0qMxpgtX+Lvwar+l5hy
	 3+uLCoClvU2Tq4hxWIkVEgY0I6iX5q6URLBwxMjIIxJ/LqFVj4lGhVm7b3p7GhuuTS
	 uHMMZw+sMxnOa3AHL9sHN9eW0y2mAM0DoNmQZv6mokpET8DlJI0bdHygdcex8y3+qK
	 ZGNtjHO7pFE0pZ1v0UqkVYoEFUvtjCNudT73uCk5zK0udnDhDqWwy6HhLLeyQJaRsV
	 8cWKO6BSXcyPQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: merge two CONFIG_BPF entries
Date: Sun,  4 Feb 2024 16:56:34 +0900
Message-Id: <20240204075634.32969-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'config BPF' exists in both init/Kconfig and kernel/bpf/Kconfig.

Commit b24abcff918a ("bpf, kconfig: Add consolidated menu entry for bpf
with core options") added the second one to kernel/bpf/Kconfig instead
of moving the existing one.

Merge them together.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 init/Kconfig       | 5 -----
 kernel/bpf/Kconfig | 1 +
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 8d4e836e1b6b..46ccad83a664 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1457,11 +1457,6 @@ config SYSCTL_ARCH_UNALIGN_ALLOW
 config HAVE_PCSPKR_PLATFORM
 	bool
 
-# interpreter that classic socket filters depend on
-config BPF
-	bool
-	select CRYPTO_LIB_SHA1
-
 menuconfig EXPERT
 	bool "Configure standard kernel features (expert users)"
 	# Unhide debug options, to make the on-by-default options visible
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 6a906ff93006..bc25f5098a25 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -3,6 +3,7 @@
 # BPF interpreter that, for example, classic socket filters depend on.
 config BPF
 	bool
+	select CRYPTO_LIB_SHA1
 
 # Used by archs to tell that they support BPF JIT compiler plus which
 # flavour. Only one of the two can be selected for a specific arch since
-- 
2.40.1


