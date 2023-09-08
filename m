Return-Path: <bpf+bounces-9547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65403798E2B
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 20:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81AA91C20905
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 18:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3431168D8;
	Fri,  8 Sep 2023 18:20:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890D3168CD
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 18:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0F3C433C9;
	Fri,  8 Sep 2023 18:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694197199;
	bh=Bw7BD57gTfmTQejdO40EktYA1m5WMUEbeAZug9wk/Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lrNy+duFj/R93sFt3Lb9gWxHmBvo3GFkbIB2dZPxEi1VoUQO9fMJ1nZxl3VxaodhX
	 FwcZocT5wp+ivGlkbFd5w0qzzD/UHiRCyKi+Jzl7vIyMN2b3t06yXTdmG7T1zJoseG
	 f7B2Nw9AVPlfQPevH10xpFKe4kfg7j7T42m/u5Fa7pFGLVkVez8s2Jbf+yKM0oUWF+
	 hESu0o4OM4fMNIjOzbIghQCxTzNmXxY+l+pl3KkYqn7DqTsUqZplGKFzjhnR6kxLuu
	 wvYtXp/2vdAPiPjt9Dgu0ZCQObVrV6IZLfNyFSa4ELCCvXqqbsBD+dURpgyMN38kMI
	 JoyoPAq58jtOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hao Luo <haoluo@google.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 14/15] libbpf: Free btf_vmlinux when closing bpf_object
Date: Fri,  8 Sep 2023 14:19:17 -0400
Message-Id: <20230908181920.3460520-14-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181920.3460520-1-sashal@kernel.org>
References: <20230908181920.3460520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.131
Content-Transfer-Encoding: 8bit

From: Hao Luo <haoluo@google.com>

[ Upstream commit 29d67fdebc42af6466d1909c60fdd1ef4f3e5240 ]

I hit a memory leak when testing bpf_program__set_attach_target().
Basically, set_attach_target() may allocate btf_vmlinux, for example,
when setting attach target for bpf_iter programs. But btf_vmlinux
is freed only in bpf_object_load(), which means if we only open
bpf object but not load it, setting attach target may leak
btf_vmlinux.

So let's free btf_vmlinux in bpf_object__close() anyway.

Signed-off-by: Hao Luo <haoluo@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20230822193840.1509809-1-haoluo@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f87a15bbf53b3..9b8a0fe0eb1c3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7559,6 +7559,7 @@ void bpf_object__close(struct bpf_object *obj)
 	bpf_object__elf_finish(obj);
 	bpf_object__unload(obj);
 	btf__free(obj->btf);
+	btf__free(obj->btf_vmlinux);
 	btf_ext__free(obj->btf_ext);
 
 	for (i = 0; i < obj->nr_maps; i++)
-- 
2.40.1


