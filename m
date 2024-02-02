Return-Path: <bpf+bounces-21011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB28846BB2
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 10:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463061C26302
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 09:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B5B77637;
	Fri,  2 Feb 2024 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gA6SShlS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1238C604B4;
	Fri,  2 Feb 2024 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865542; cv=none; b=o77HobuWggLwVkAKsZ/NnglvxEIS1mtKFP+V19A5N32mAV3wxsaHZg0vrC4cMSaW/ZIEUZ9OWAC+/EAUOEtnJZRBQpuOuIuVDFsLPYIqj5xh8m0PjgHwwBhHXXiW1Z2HE689AvyPJiYhKBavGaBeYT6gRQPEhXIIJJ8uyjmfmWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865542; c=relaxed/simple;
	bh=BvAjd6AT54EdyR0+F+bQ+kRYMX8aE1q5sRg4e+BP+yY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P2oX35R9tqW9xysl80IxxuBNH0QXXmWWGdxU5taX2B2NuSRSNmmlahXKooaFl2hmIU9jRkCqExOPJBhwnB+Og597mbOtGsRkc+E8kv5/z69owGl4Wb5hqQBrEVpnGJl8P7s13/omiIiLZiEvm153dE5dQ1EK4Pw/37r4mL9m3LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gA6SShlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D3CC433F1;
	Fri,  2 Feb 2024 09:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706865541;
	bh=BvAjd6AT54EdyR0+F+bQ+kRYMX8aE1q5sRg4e+BP+yY=;
	h=From:To:Cc:Subject:Date:From;
	b=gA6SShlS13yh/3wPUolB8UJ3AjcOxt8PEGrWwQ7gWRqc+yOLHvL6hoDMw5y2ghUgH
	 MoufyQ37JkzqJMwEi099zpPx6lJCMkcaL+Qz8BUTgB0aRhWlW7ivuAEI1wfo4VpwrI
	 RjFqVA4KyCZ4uJQR6PrQlk9ew9SfdlZGgdF+tzezeLprypK+2O+YcNHvF5kU7/y7oo
	 fQCgoFwDk9jadzp1zY4xbVW2EZ/QTdvhJtqGRGMwqvNpCXdavxLiHA7KE8mwSe7Ho2
	 7F953vyuon+OPuXIlFm4+Ob9RmNTRNGbqJ737tJe4a6M/umZcwG0JrsziLMDjLdaTS
	 gJ7zHQ+V2c/Mg==
From: Geliang Tang <geliang@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH] bpf, btf: Add DEBUG_INFO_BTF checks for __register_bpf_struct_ops
Date: Fri,  2 Feb 2024 17:18:48 +0800
Message-Id: <beca71007a184b2d199f404a471f020fd4359823.1706863036.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Similar to the handling in the functions __register_btf_kfunc_id_set() and
register_btf_id_dtor_kfuncs(), this patch adds CONFIG_DEBUG_INFO_BTF and
CONFIG_DEBUG_INFO_BTF_MODULES checks for __register_bpf_struct_ops() on
error path too when btf_get_module_btf() returns NULL.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 kernel/bpf/btf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ef380e546952..381676add335 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8880,8 +8880,15 @@ int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
 	int err = 0;
 
 	btf = btf_get_module_btf(st_ops->owner);
-	if (!btf)
-		return -EINVAL;
+	if (!btf) {
+		if (!st_ops->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
+			pr_err("missing vmlinux BTF, cannot register structs\n");
+			return -EINVAL;
+		}
+		if (st_ops->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
+			pr_warn("missing module BTF, cannot register structs\n");
+		return 0;
+	}
 
 	log = kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
 	if (!log) {
-- 
2.40.1


