Return-Path: <bpf+bounces-45750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 044259DADDB
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 20:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0CD2830A4
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 19:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB97205AA2;
	Wed, 27 Nov 2024 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Z+GeIXER"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3C6204082;
	Wed, 27 Nov 2024 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732735254; cv=none; b=ebill7ScvJRTT2hyqByKXWH2J7FAwYiE+p/FXS1dIQwNd4IeWcAnIKQ9JFCvczmTdSo87hTc834GQM8r5e1STeHcsxi6GL47ADCSA6Vv0xWYtwN4r2pVi58xFxLb2R7n5OuaNnSl7ONwpvlXz5xiqVLRUf+ovYlyD2vffgQyngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732735254; c=relaxed/simple;
	bh=3rctmezwlCnJHJyzeUdMtikNSq141Sldc2+hgFUUhjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=APvQga+mIfjT7N3xpIrwCjRGeS/tnEPgelc+FLf71QDRQKcT/S5htuq1NIc4or8pa+DS9ZR77j8GYoYAtNcHoh9R6aDv/rasGIpj6oUbDvFiW16v+pIgGrRsFGB+UGk39qFXZcrdUFHwm68lb0I5SIHpN9KP+MBHby781LL7/I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Z+GeIXER; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732735245;
	bh=3rctmezwlCnJHJyzeUdMtikNSq141Sldc2+hgFUUhjk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z+GeIXER2Zg36gl3BBXVGtEmEZkKCPvmohtmST9bxks1ArkuiByBrVDJlrZOdjlpX
	 fTWxTuOaFqPbqU4cuUEjutTbhoVqXA/0Zl1ErZ1p0C2F5oMFziRn7C4TYsFVAoX0T6
	 eDKCdGlfs3fTIYb5ZsieT64VpejLP/Q7+T1lXuZg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 27 Nov 2024 20:15:23 +0100
Subject: [PATCH bpf-next 4/9] const_structs.checkpatch: add bpf_struct_ops
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-bpf-const-ops-v1-4-a698b8d58680@weissschuh.net>
References: <20241127-bpf-const-ops-v1-0-a698b8d58680@weissschuh.net>
In-Reply-To: <20241127-bpf-const-ops-v1-0-a698b8d58680@weissschuh.net>
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
 Kui-Feng Lee <thinker.li@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, Tejun Heo <tj@kernel.org>, 
 David Vernet <void@manifault.com>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732735245; l=693;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=3rctmezwlCnJHJyzeUdMtikNSq141Sldc2+hgFUUhjk=;
 b=6DzHI/fSbgD40QFAxB1P9wL4KCIvbaHi7tT1rqbM+fUIdlNUTGiKf0h4sanbM4UgP37azYPde
 swQX9s30MU8BhqRRlfEXT2pt5zWs1J/92u8Ku+uBD5cXZCZ9ysB+XTp
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Now that the BPF core can handle "const struct bpf_struct_ops", make
sure that new usages of the struct already enter the tree as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/const_structs.checkpatch | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
index 014b3bfe32374880a5f0cbdcc2763c24ba47b5c7..1457067dbc18e2586f5ef0c8c44367cb3011731d 100644
--- a/scripts/const_structs.checkpatch
+++ b/scripts/const_structs.checkpatch
@@ -1,6 +1,7 @@
 acpi_dock_ops
 address_space_operations
 backlight_ops
+bpf_struct_ops
 block_device_operations
 bus_type
 clk_ops

-- 
2.47.1


