Return-Path: <bpf+bounces-41040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1606D99135E
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 02:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869DB1F23621
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 00:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CC017F7;
	Sat,  5 Oct 2024 00:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rq7iYsK8"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500E529A0;
	Sat,  5 Oct 2024 00:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728086872; cv=none; b=cWpc3/bihLJHI1duu4x9Ya+4pmswNw2W7vYVdtUwdlJ1OAtjF3nZYUyAsBXVG26r8Kb62OtT6ROYf9aczJBRqi0j8NaI0WvEwHrDeIu0T/iwoXsphoJaInVA0Hk8pNp4R5XsS5Nnx3PFcY2n4NfizMgrMGT4ujfeMwMuO82cjmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728086872; c=relaxed/simple;
	bh=xz79fy6tqxxlcBtITgoH5nzOLA7aGHwgD+bM+S/Eew0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rJ78n/lUJ5scz8DjRJ7V71CIeC1HWGZ40OfrE22wYOjTiI/RyVdNt3w4UkmBFRT0T6P1YgU1CoorjPQM8aEH0yM3Ao2SLPrY4hnGLKUoLC8MjFI2Lbk+Hm5awzjmK2jV7pnsNX4vBK1FRR1jNHxiS7AUSolgBSI99pzjQRqbdjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rq7iYsK8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728086854;
	bh=xz79fy6tqxxlcBtITgoH5nzOLA7aGHwgD+bM+S/Eew0=;
	h=From:Date:Subject:To:Cc:From;
	b=rq7iYsK8o9LHXtBQg3aGv2OqPFfyT/O0hRyEbSv9n4/z1LSU/CJCDSZQQggr0C9c8
	 PtRgw/n6K07FPKYUJUkrGYKcAvBDAoi/265wNS3h3nQwuPD5op868p736BsqgTeRbB
	 bIVG1tTSDJFgxYw267uhmfWDNYDxiyQt+lOlhGJc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 05 Oct 2024 02:06:28 +0200
Subject: [PATCH] bpf, lsm: Remove bpf_lsm_key_free hook
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-lsm-key_free-v1-1-42ea801dbd63@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAODAGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwNT3ZziXN3s1Mr4tKLUVN0kE3MTE9PUVFMj4xQloJaCotS0zAqwcdG
 xtbUAzodRll4AAAA=
X-Change-ID: 20241005-lsm-key_free-b47445ee523d
To: KP Singh <kpsingh@kernel.org>, 
 Matt Bobrowski <mattbobrowski@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
 Paul Moore <paul@paul-moore.com>, 
 John Johansen <john.johansen@canonical.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728086854; l=1180;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xz79fy6tqxxlcBtITgoH5nzOLA7aGHwgD+bM+S/Eew0=;
 b=BmDydbqRz1LdW3RSqSSbU/fCChwX+HiQP0CYDZdd607qI0fezWApQqqHjhEs9Up2ySJH5IVYh
 zvPDO5CcKNKARvfeGRXJlCfMZkFEPd4JHE5fe9JLfAkIFtkE/QIxMBD
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The key_free LSM hook has been removed.
Remove the corresponding BPF hook.

Avoid warnings during the build:
  BTFIDS  vmlinux
WARN: resolve_btfids: unresolved symbol bpf_lsm_key_free

Fixes: 5f8d28f6d7d5 ("lsm: infrastructure management of the key security blob")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
I don't know much about LSMs, so please disregard if this is wrong.
---
 kernel/bpf/bpf_lsm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 6292ac5f9bd139dafb39ecd8bb180be46cd7c7fd..3bc61628ab251e05d7837eb27dabc3b62bcc4783 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -339,10 +339,6 @@ BTF_ID(func, bpf_lsm_path_chmod)
 BTF_ID(func, bpf_lsm_path_chown)
 #endif /* CONFIG_SECURITY_PATH */
 
-#ifdef CONFIG_KEYS
-BTF_ID(func, bpf_lsm_key_free)
-#endif /* CONFIG_KEYS */
-
 BTF_ID(func, bpf_lsm_mmap_file)
 BTF_ID(func, bpf_lsm_netlink_send)
 BTF_ID(func, bpf_lsm_path_notify)

---
base-commit: 0c559323bbaabee7346c12e74b497e283aaafef5
change-id: 20241005-lsm-key_free-b47445ee523d

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


