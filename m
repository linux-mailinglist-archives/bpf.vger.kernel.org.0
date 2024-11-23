Return-Path: <bpf+bounces-45495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4DD9D6891
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 11:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C81C1612C2
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 10:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36E51885A0;
	Sat, 23 Nov 2024 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="S04WjwXl"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84B54A0A;
	Sat, 23 Nov 2024 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732357161; cv=none; b=ssCCjRevrNJL610QjtydAdRfT6lWG15QAK1eCsF4h7Zeylf9EzbQAiQz1GSkKO/2cYXM6ieA5+Mk8sK6GpdxLphLcnQ6f9j5s38Kx2OpCB0FvmbjcurDYC4EqCAFqMxLGRXXNvm4zRUErylRqh1mRaCYxBlLFAeOKT7Ah7bmua0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732357161; c=relaxed/simple;
	bh=0ibmJ8f3A4hcCPMhLVIPy6wl6iW3h7ziHqKf6IlJjlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LZ77ZUohvOeVOkLw/lUIY+/vTMnDov2yIx0ChrJH0uwVy4bl1EAiKPkzhFSgga2j+Glu7E7qvIxy/J/dwOzRFZ1j1nYaO8jCbzlzqVdIk5PBv/ewkAJs/msjtoc4YjuhTURoIpfL5vcxEJwjaI/Jqe1mFmjDKpvL+Qb7Yjml19E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=S04WjwXl; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732357147;
	bh=0ibmJ8f3A4hcCPMhLVIPy6wl6iW3h7ziHqKf6IlJjlU=;
	h=From:Date:Subject:To:Cc:From;
	b=S04WjwXlYA5woaAimaYd7wzRVWGRtnalWZnfETYiEPVvkLGkxMQc6RUMztwIMZix7
	 21yqYuJVZheMhpnXRGNns1qN+AE0bmpE7iR8YcWKyYEN2Qxo7+KUc1YfjRnCJgHBJU
	 OOtLf/9OAktOe9KhAMKxJX+UZkpLawLUMG1+Kbcg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 23 Nov 2024 11:19:01 +0100
Subject: [PATCH] bpf, lsm: Fix getlsmprop hooks BTF IDs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241123-bpf_lsm_task_getsecid_obj-v1-1-0d0f94649e05@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIABSsQWcC/x3MTQqEMAxA4atI1hZsLSheRaTUNnHiP43IgHj3K
 bP8Fu89IJgYBbrigYQ3Cx97hi4LCB+/T6g4ZoOpjNXa1Go8ya2yucvL4ia8BANHd4yz8hSjbai
 1oSHI/ZmQ+Pt/98P7/gAXtBbrawAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732357146; l=1280;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=0ibmJ8f3A4hcCPMhLVIPy6wl6iW3h7ziHqKf6IlJjlU=;
 b=HynXczZNRclf1wN9yXh/kJXQfwzyd+8zRhLo+1ga/IcPu61S7BN1OpzOprpnZbNcRi2WCtkKc
 0fSgXz5IEiuASPTTvOgab/oB98tpNfqRgjsdZp53x/ksR1eCpN4vXe1
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The hooks got renamed, adapt the BTF IDs.
Fixes the following build warning:

  BTFIDS  vmlinux
WARN: resolve_btfids: unresolved symbol bpf_lsm_task_getsecid_obj
WARN: resolve_btfids: unresolved symbol bpf_lsm_current_getsecid_subj

Fixes: 37f670aacd48 ("lsm: use lsm_prop in security_current_getsecid")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/bpf/bpf_lsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 3bc61628ab251e05d7837eb27dabc3b62bcc4783..5be76572ab2e8a0c6e18a81f9e4c14812a11aad2 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -375,8 +375,8 @@ BTF_ID(func, bpf_lsm_socket_socketpair)
 
 BTF_ID(func, bpf_lsm_syslog)
 BTF_ID(func, bpf_lsm_task_alloc)
-BTF_ID(func, bpf_lsm_current_getsecid_subj)
-BTF_ID(func, bpf_lsm_task_getsecid_obj)
+BTF_ID(func, bpf_lsm_current_getlsmprop_subj)
+BTF_ID(func, bpf_lsm_task_getlsmprop_obj)
 BTF_ID(func, bpf_lsm_task_prctl)
 BTF_ID(func, bpf_lsm_task_setscheduler)
 BTF_ID(func, bpf_lsm_task_to_inode)

---
base-commit: 228a1157fb9fec47eb135b51c0202b574e079ebf
change-id: 20241123-bpf_lsm_task_getsecid_obj-afdd47f84c7f

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


