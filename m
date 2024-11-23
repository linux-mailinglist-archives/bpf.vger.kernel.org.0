Return-Path: <bpf+bounces-45502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0C89D6955
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 14:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0D9281E92
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 13:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D452B9BB;
	Sat, 23 Nov 2024 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="G+1EnYnP"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1284566A;
	Sat, 23 Nov 2024 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732368827; cv=none; b=oXWNsbSmTUAiE1EvKsmbS0fKJvYzimlDNUOK7u18nGW1OhM2sD7ySsCskpFsWTzZ9iOrAsLgZ0e2fBcbUMLDk0AusaSvP+fRbnqWn7g8KslPk5QFiRA/ghX9rynpFA7BlXBnU+GS90Y6Ih6efV5JdQYhiLU5YDabSheIfNT7vik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732368827; c=relaxed/simple;
	bh=c6CdDGMpfwLEdjJ2eCMkd1FUqsRSkbiB2A1jKRSH2R0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJCkZZyJAjzTfxEsuOuYKn+cu2yOVJ2+Cg1N3slkaU7fWak3O6I9lsaR54mQgUs1KQM6aKlDETuQneG6evu6dMbYBKDFxYTdFl62k1yYg7tEOGmSL455FKYeFtWgt6ETArOriCzdjPp74KumC0178N+lFB2KJgDJHSzNJKtCQtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=G+1EnYnP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732368822;
	bh=c6CdDGMpfwLEdjJ2eCMkd1FUqsRSkbiB2A1jKRSH2R0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G+1EnYnP3Wvn/a4GhQ/bIL6JW6Sje4DBg+z/58yTceYS3vIUcNc1c/4ZRDXni9W+B
	 jNfzv4xmfcsNJcrPmElsrdQuUNXwLn0hATH+gyzDyv4FWWL22xdzc3T+fZS1EptR9t
	 +8NcbdlzGmJ6lHnAqqkcnnjCEpzC79PJldePy6d0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 23 Nov 2024 14:33:37 +0100
Subject: [PATCH 1/3] kbuild: add dependency from vmlinux to resolve_btfids
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241123-resolve_btfids-v1-1-927700b641d1@weissschuh.net>
References: <20241123-resolve_btfids-v1-0-927700b641d1@weissschuh.net>
In-Reply-To: <20241123-resolve_btfids-v1-0-927700b641d1@weissschuh.net>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732368820; l=909;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=c6CdDGMpfwLEdjJ2eCMkd1FUqsRSkbiB2A1jKRSH2R0=;
 b=CrIzTkeL7ZmqLczaKpIoJ60WdaDLhaFzDtFg5Lu3jJ7df/Ynj6jOHRyWKqMwNBE00uKC/Ray7
 tJ9W426ko4xCnkfQkPmpcjG69itJainyqwfO7PhORkaALNUwsEX8WpH
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

resolve_btfids is used by link-vmlinux.sh.
In contrast to other configuration options and targets no transitive
dependency between resolve_btfids and vmlinux.
Add an explicit one.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/Makefile.vmlinux | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index 1284f05555b97f726c6d167a09f6b92f20e120a2..599b486adb31cfb653e54707b7d77052d372b7c1 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -32,6 +32,9 @@ cmd_link_vmlinux =							\
 targets += vmlinux
 vmlinux: scripts/link-vmlinux.sh vmlinux.o $(KBUILD_LDS) FORCE
 	+$(call if_changed_dep,link_vmlinux)
+ifdef CONFIG_DEBUG_INFO_BTF
+vmlinux: $(RESOLVE_BTFIDS)
+endif
 
 # module.builtin.ranges
 # ---------------------------------------------------------------------------

-- 
2.47.0


