Return-Path: <bpf+bounces-45752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 289E19DADB9
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 20:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2AE828155C
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 19:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4BA205ACF;
	Wed, 27 Nov 2024 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="T2MvmcqV"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC64A204094;
	Wed, 27 Nov 2024 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732735254; cv=none; b=lgBNprP+ELXsH+PR/wuekJahzbnKZhHyT/f1l2FmmCI4cImDbapv1rkcqqVGt/fXwOHQmLRlXGbSUzXo5GskN2YLNHz1dUErrKOVvsY6yepBplUwG/aMPbMx1pc1lwypSDcQIFXNenJ2CuuYw1BR/QD/3IgRP4GO38OiPso9dgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732735254; c=relaxed/simple;
	bh=wNs3Wb11muL3asSVvBpcSkxAu1290QussnP8tf9Yvjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pMqr9aGQyXknYEgfLWFViVI2oq//soik+LMawxLntbIOq8gEQ0Q3hRVUCU0VJxmzBJd7VEfuQ7b1m8RhcRTOIkKk1uIcpF6T/VXP2p2GVIKRxxFuAPlYLGNybk3AG/5PUv/AplMx2uEum1VJu++HY2BLRdP1Me0A5mFM4HLXh9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=T2MvmcqV; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732735246;
	bh=wNs3Wb11muL3asSVvBpcSkxAu1290QussnP8tf9Yvjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T2MvmcqVSqI12EKlTC5q2ll1kYXVttIO6XSzFXkGUBGoqh2/2BeDztPVP5mWvvamt
	 z37jBkjW5BBYXd3CtAfv7A72h/6i+GMOxhrv44aC6rjh+3JJDX+K4FSXhE+X0iFv3K
	 JotN5C214FRrmfD1xEAVk51ex92YnFCPH9frsfl0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 27 Nov 2024 20:15:27 +0100
Subject: [PATCH bpf-next 8/9] HID: bpf: constify BPF ops
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-bpf-const-ops-v1-8-a698b8d58680@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732735245; l=1184;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wNs3Wb11muL3asSVvBpcSkxAu1290QussnP8tf9Yvjg=;
 b=8LGTCLhU0HxX6GwS9jdWYvJajU7R38vOLd7IfmazH1xj2Oo1MF9Y18jR7dDggU3YdzdLFG4am
 fh84tTfDvhkAcYO1QRer7xtXMctCEAXmMJLq7RTffVXUgPcgsuTJu8T
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The BPF core now allows the registration of read-only ops tables,
make use of it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hid/bpf/hid_bpf_struct_ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index 0e611a9d79d753213abbdf81f7ac0557e50c2ede..2baefb351a01fcb351fd6da8ca72f42d27779df5 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -289,14 +289,14 @@ static int __hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, u64 source)
 	return 0;
 }
 
-static struct hid_bpf_ops __bpf_hid_bpf_ops = {
+static const struct hid_bpf_ops __bpf_hid_bpf_ops = {
 	.hid_device_event = __hid_bpf_device_event,
 	.hid_rdesc_fixup = __hid_bpf_rdesc_fixup,
 	.hid_hw_request = __hid_bpf_hw_request,
 	.hid_hw_output_report = __hid_bpf_hw_output_report,
 };
 
-static struct bpf_struct_ops bpf_hid_bpf_ops = {
+static const struct bpf_struct_ops bpf_hid_bpf_ops = {
 	.verifier_ops = &hid_bpf_verifier_ops,
 	.init = hid_bpf_ops_init,
 	.check_member = hid_bpf_ops_check_member,

-- 
2.47.1


