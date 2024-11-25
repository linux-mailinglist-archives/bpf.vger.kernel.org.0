Return-Path: <bpf+bounces-45586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4F19D8D20
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 21:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB0EEB23C7A
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 19:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E222A1C3023;
	Mon, 25 Nov 2024 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="UuA1zlJe"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E8A17E00F;
	Mon, 25 Nov 2024 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564402; cv=none; b=OH05U1M5f1JoRqMzqtC7lSZGExyaVdGTEqbFKvQ8FdbIr7TZ8zpgx65x/ObytAT1ATs+SxjakCaLf5Aj7GlSvv0MM8cy1XwE3q5onPhCQl1SLN5Sy5sTKTVgBWPJDIHqB0Oyx+3SgdkTmRK6s/rkyX62GSznG1Ykl5IX/YgxaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564402; c=relaxed/simple;
	bh=Y0vjkXNOQv7YsvMpTIFbCFA7jpQwJmNBV/1YYA4wS0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c7ke7V0YQxcWe74EzJVfMyGo34h/RJ030mlybIv2HmDerL9BRcFJYHWyMeo2rd2EovUUD2gWBPToZr7YWwbGYA7nrGChdKlswnumUPhYKtknyCqRjpzZy8s2bcMhAgeita6ZXJK+WX1R0JYJ3ZCMy2w0IN52bg6gCDeN8mkDt0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=UuA1zlJe; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732564389;
	bh=Y0vjkXNOQv7YsvMpTIFbCFA7jpQwJmNBV/1YYA4wS0I=;
	h=From:Date:Subject:To:Cc:From;
	b=UuA1zlJeyH4Vz50/z4sp/zwLGeteUG0yUztELMOyWVJAvEqQSNoKT7l408zGDiikw
	 k4iYGlQh9CX3iIz9zK+t81FFEKBmOHYVR2D+T/e+8PMoGq/ihEfCfNLcatbffKnQ51
	 sPQrOKscRZKPGeJwyhWxEIWghE1UzaYy8OIrE64Y=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 25 Nov 2024 20:53:07 +0100
Subject: [PATCH v2] bpf, lsm: Remove getlsmprop hooks BTF IDs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241125-bpf_lsm_task_getsecid_obj-v2-1-c8395bde84e0@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAKPVRGcC/42NWw6CMBBFt0L6bU1bq4hf7sOQBtopHR9AOhU1h
 L1bWYGf5yT33JkRRARip2JmESYkHPoMalMwG5q+A44uM1NCaSnVjrejN3d6mNTQzXSQCCw6M7R
 X3njndOmP2pae5f0YweN7bV/qzAEpDfGzXk3yZ/+pTpJLLpzwlT7oCsT+/AIkIhueYdtDYvWyL
 F+hKMGYxwAAAA==
X-Change-ID: 20241123-bpf_lsm_task_getsecid_obj-afdd47f84c7f
To: KP Singh <kpsingh@kernel.org>, 
 Matt Bobrowski <mattbobrowski@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Casey Schaufler <casey@schaufler-ca.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 audit@vger.kernel.org, selinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732564389; l=1466;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Y0vjkXNOQv7YsvMpTIFbCFA7jpQwJmNBV/1YYA4wS0I=;
 b=77nafeHPanYmoDeW/PSaELnfqM9DdY9hTwYLD98U9+4FmIavtKdBEqf7yzHRkgkcRENc+BKMx
 uwFhZv8VZHTDlnvJNbJfQlVELM+8elCA6WpQNUEBUn8lMAJqQtA2/wR
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

These hooks are not useful for BPF LSM currently.
Furthermore a recent renaming introduced build warnings:

  BTFIDS  vmlinux
WARN: resolve_btfids: unresolved symbol bpf_lsm_task_getsecid_obj
WARN: resolve_btfids: unresolved symbol bpf_lsm_current_getsecid_subj

Link: https://lore.kernel.org/lkml/20241123-bpf_lsm_task_getsecid_obj-v1-1-0d0f94649e05@weissschuh.net/
Fixes: 37f670aacd48 ("lsm: use lsm_prop in security_current_getsecid")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Delete instead of rename IDs
- Link to v1: https://lore.kernel.org/r/20241123-bpf_lsm_task_getsecid_obj-v1-1-0d0f94649e05@weissschuh.net
---
 kernel/bpf/bpf_lsm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 3bc61628ab251e05d7837eb27dabc3b62bcc4783..967492b65185fac5333fc22f4d2ad49cf59a6573 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -375,8 +375,6 @@ BTF_ID(func, bpf_lsm_socket_socketpair)
 
 BTF_ID(func, bpf_lsm_syslog)
 BTF_ID(func, bpf_lsm_task_alloc)
-BTF_ID(func, bpf_lsm_current_getsecid_subj)
-BTF_ID(func, bpf_lsm_task_getsecid_obj)
 BTF_ID(func, bpf_lsm_task_prctl)
 BTF_ID(func, bpf_lsm_task_setscheduler)
 BTF_ID(func, bpf_lsm_task_to_inode)

---
base-commit: 9f16d5e6f220661f73b36a4be1b21575651d8833
change-id: 20241123-bpf_lsm_task_getsecid_obj-afdd47f84c7f

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


