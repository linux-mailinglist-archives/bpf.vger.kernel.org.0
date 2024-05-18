Return-Path: <bpf+bounces-30009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9058C9177
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 16:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3E41C20C0E
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 14:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC98D4087C;
	Sat, 18 May 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="l0JgW8en"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A624323BF;
	Sat, 18 May 2024 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716044378; cv=none; b=Cw93+Kghpi6P/IawTgN4oxwWqBpuTRWdTFj6vjXYnpQf2n+CfsDDiiEaYEBD7fIKbfgWvGt2IAos5q2eAgUXl18O4pmfS9LFGBNdzTxiKgo+DIO6DizpjBgr2qLrpDIXWUSY7kA/65wI3+XrwoOGPC1nECfp43z3oKq/D5WmxYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716044378; c=relaxed/simple;
	bh=0fGyh51Lxcn7TU6P6lAYPGr2VuGKEWub+IV0YkTSPEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fGEhRCNvTZ5qho1CMyJYGzD63SWBoPLLrrTrwY9lpejlWw4UFuYSbPGNHwkJA/wuXD+jhE2KqCxRQ9sn+XuBCEnFWkvnTnwPYRAUou53CrBT7Vcm1Mofxs8OP8QDyz8SkqA10d9L8Q/DjFUiSXJMwSIRbM2RZPPboXXpanhLS5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=l0JgW8en; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716044368;
	bh=0fGyh51Lxcn7TU6P6lAYPGr2VuGKEWub+IV0YkTSPEQ=;
	h=From:Date:Subject:To:Cc:From;
	b=l0JgW8enCugBCQJ/JBPSIsKfg36Xouk52zRDlx+aIJiLzJueUXlrsm2iHLrY7vPnu
	 ycottU6d2t/st2q7/QG4expL/R6PXYqE1uPrpa5w1KaTYYPWie4PHQcAt0yN3r8Oje
	 OhLeO2R9NHcoADwqhF24Cux1dOlU6fTKS2G/eRv4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 18 May 2024 16:58:47 +0200
Subject: [PATCH] bpf: constify member bpf_sysctl_kern::table
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240518-sysctl-const-handler-bpf-v1-1-f0d7186743c1@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIACfCSGYC/x2M2wpAQBBAf0XzbMq6hV+RhzUGU1ra2UTy7zaPp
 845Dyh7YYUuecDzKSq7i2DSBGi1bmGUKTLkWV5mlTGot1LYkHanAaMxbexxPGYcmdrCmsZS3UD
 MD8+zXP+6H973A0C5YjVqAAAA
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Joel Granados <j.granados@samsung.com>, 
 Luis Chamberlain <mcgrof@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716044367; l=3245;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=0fGyh51Lxcn7TU6P6lAYPGr2VuGKEWub+IV0YkTSPEQ=;
 b=WlIH2T60uLwnJe/Gqv5eH9YEvtjEs19gROJhYZ5TXXpzV9jKP9H+MH1iOmZGJIzGvgWDUHux7
 e0wDTl7srI3Dat0/4r7qg0dnTF4d+MlAy+6xh/eqe22+wIAPLt8YtbL
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysctl core is preparing to only expose instances of
struct ctl_table as "const".
This will also affect the ctl_table argument of sysctl handlers,
for which bpf_sysctl_kern::table is also used.

As the function prototype of all sysctl handlers throughout the tree
needs to stay consistent that change will be done in one commit.

To reduce the size of that final commit, switch this utility type which
is not bound by "typedef proc_handler" to "const struct ctl_table".

No functional change.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
This patch(set) is meant to be applied through your subsystem tree.
Or at your preference through the sysctl tree.

Motivation
==========

Moving structures containing function pointers into unmodifiable .rodata
prevents attackers or bugs from corrupting and diverting those pointers.

Also the "struct ctl_table" exposed by the sysctl core were never meant
to be mutated by users.

For this goal changes to both the sysctl core and "const" qualifiers for
various sysctl APIs are necessary.

Full Process
============

* Drop ctl_table modifications from the sysctl core ([0], in mainline)
* Constify arguments to ctl_table_root::{set_ownership,permissions}
  ([1], in mainline)
* Migrate users of "ctl_table_header::ctl_table_arg" to "const".
  (in mainline)
* Afterwards convert "ctl_table_header::ctl_table_arg" itself to const.
  (in mainline)
* Prepare helpers used to implement proc_handlers throughout the tree to
  use "const struct ctl_table *". ([2], in progress, this patch)
* Afterwards switch over all proc_handlers callbacks to use
  "const struct ctl_table *" in one commit. ([2], in progress)
  Only custom handlers will be affected, the big commit avoids a
  disruptive and messy transition phase.
* Switch over the internals of the sysctl core to "const struct ctl_table *" (to be done)
* Switch include/linux/sysctl.h to "const struct ctl_table *" (to be done)
* Transition instances of "struct ctl_table" through the tree to const (to be done)

A work-in-progress view containing all the outlined changes can be found at
https://git.sr.ht/~t-8ch/linux sysctl-constfy

[0] https://lore.kernel.org/lkml/20240322-sysctl-empty-dir-v2-0-e559cf8ec7c0@weissschuh.net/
[1] https://lore.kernel.org/lkml/20240315-sysctl-const-ownership-v3-0-b86680eae02e@weissschuh.net/
[2] https://lore.kernel.org/lkml/20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net/

Cc: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/filter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 0f12cf01070e..b02aea291b7e 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1406,7 +1406,7 @@ struct bpf_sock_ops_kern {
 
 struct bpf_sysctl_kern {
 	struct ctl_table_header *head;
-	struct ctl_table *table;
+	const struct ctl_table *table;
 	void *cur_val;
 	size_t cur_len;
 	void *new_val;

---
base-commit: 4b377b4868ef17b040065bd468668c707d2477a5
change-id: 20240511-sysctl-const-handler-bpf-bec93a18ac68

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


