Return-Path: <bpf+bounces-18030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78315814F31
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 18:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2AB5B23FA2
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 17:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA4430104;
	Fri, 15 Dec 2023 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dtucker.co.uk header.i=@dtucker.co.uk header.b="jWVn2tai";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="un6n1sEd"
X-Original-To: bpf@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0608347F4E
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dtucker.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dtucker.co.uk
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id F206C3200A92;
	Fri, 15 Dec 2023 12:47:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 15 Dec 2023 12:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702662457; x=
	1702748857; bh=04Hl0wEfh9DaUqU9lxM5z6EztN4bUE09ORrpvbkr5OM=; b=j
	WVn2taiEZJsBCW/vYQ13i9ammjUowajrnxYq/zdXHzC6yg3dtV0AedijnwcGHSGk
	oHKZj7GR/RVXfxH0whXM08e2+gpCnfc82xFX416+8QajCxTd+EnB1MT15DHohCPC
	K7/cXXG5l3ya/OKTaNLC6sIi2TFuJq4mGJ27cyaag/4Uo8oKm03x4Z7fd5SrzEL/
	AI6gzibdhF53gEb3e2XoJoJQ3b22RVBPnAtVrrxOpEJrptOiw30bwzCmkW2xEHJt
	HsoibV5FG8cJIyvaWxlaEiTblV+9hnOK39eYuFqciwigyzL+U0ncYVvR+1SdMWez
	8d0mcNBOPr4tmONR1lWfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702662457; x=
	1702748857; bh=04Hl0wEfh9DaUqU9lxM5z6EztN4bUE09ORrpvbkr5OM=; b=u
	n6n1sEdjIF3GArR8Kyp71I/8rG2Ao0nwPeZJtG+eRgZA3fk2fYpo5UtSxWUgB0AP
	NrhVpfrn6fO07tJ2881JivCbK1x+mWjZJrZOWr6JYW3v+YPcES2UHv39elBn3xD7
	Yc38fn93prCbNDQxviA0jxbLCUgSV2jKejJk348PqnAnCcKzeNckAk7au8xzd9jX
	6lhe/rEIW/tn4b/3u3eCoLenSYWR2E8qW/B/Xnb6qZNLZQh2fohaYiwgpi0vgcbu
	X42iyqS2tt/QuDGWD8ybDixbYoFn5gvQIukM6Awee+8QcWJeCzLiUcLFmqiYDq1K
	Lu7BkbPN5pTIxw92ZTjtw==
X-ME-Sender: <xms:OZF8ZQR0hcVN-kn5VdvO5U7d4AzoqVoQwd5BUcN4ZFYC8sCsm96PjA>
    <xme:OZF8ZdwZtLPrW887o-QIDyrwTKKwcqzE2CLYGkQCZjJgojX4Lk9efZzV0b2FWxnNM
    HQ064KPsbYWm9XSfw>
X-ME-Received: <xmr:OZF8Zd0CG-nXw9IDUDGgDUDflIBhv0D5IRcGH2rp87-Jo-plTpe0XgTneFLTlntzjk4-JYg37Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtvddguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghv
    vgcuvfhutghkvghruceouggrvhgvseguthhutghkvghrrdgtohdruhhkqeenucggtffrrg
    htthgvrhhnpeelueefuddvleffgfeivdduudeutefhgeehgeekueehffekffeileeuteff
    teffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gurghvvgesughtuhgtkhgvrhdrtghordhukh
X-ME-Proxy: <xmx:OZF8ZUAyshPnVKPm24ubyufnP7akPFWF_vU8HNFzqJkkdR3Y7y1gRg>
    <xmx:OZF8ZZipSIsyxy-0bgoGfm1TjiHYzYpd_XOlRdsZstMba-9L0EdjxA>
    <xmx:OZF8ZQpiVT_z8nm0ScDV-8rhn8wX94GMMnVIekilYq6DvoW7b5Tw_Q>
    <xmx:OZF8ZcRlVmcpk4LbqndS33H-amS9-vKaBPivOcAUYoBUH44IRVzCEg>
Feedback-ID: i559945a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 12:47:36 -0500 (EST)
From: Dave Tucker <dave@dtucker.co.uk>
To: bpf@vger.kernel.org
Cc: Dave Tucker <datucker@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Dave Tucker <dave@dtucker.co.uk>
Subject: [PATCH bpf-next v3] bpf: Include pid, uid and comm in audit output
Date: Fri, 15 Dec 2023 17:46:39 +0000
Message-ID: <20231215174639.1034164-1-dave@dtucker.co.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3636f52d-f343-45e5-88c6-3c7e28e87a45@linux.dev>
References: <3636f52d-f343-45e5-88c6-3c7e28e87a45@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current output from auditd is as follows:

time->Wed Dec 13 21:39:24 2023
type=BPF msg=audit(1702503564.519:11241): prog-id=439 op=LOAD

This only tells you that a BPF program was loaded, but without
any context. If we include the prog-name, pid, uid and comm we get
output as follows:

time->Wed Dec 13 21:59:59 2023
type=BPF msg=audit(1702504799.156:99528): op=UNLOAD prog-id=50092
	prog-name="test" pid=27279 uid=0 comm="new_name"

With pid, uid a system administrator has much better context
over which processes and user loaded which eBPF programs.
comm is useful since processes may be short-lived.

Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
---

Changes:

v2->v3:
  - Revert replacing in_irq() with in_hardirq()
  - Revert removal of in_irq() check from bpf_audit_prog since it may
    also be called in the sofirq or nmi contexts

v1->v2:
  - Move 'op' to the front of the audit messages
  - Add 'prog-name' to the audit messages
  - Replace deprecated in_irq() with in_hardirq()
  - Remove in_irq() check from bpf_audit_prog since it's always called
    from the task context
  - Only populate pid, uid and comm if not in a kthread

 kernel/bpf/syscall.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 06320d9abf33..86600ca1f106 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -35,6 +35,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/memcontrol.h>
 #include <linux/trace_events.h>
+#include <linux/uidgid.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 #include <net/netkit.h>
@@ -2110,6 +2111,8 @@ static void bpf_audit_prog(const struct bpf_prog *prog, unsigned int op)
 {
 	struct audit_context *ctx = NULL;
 	struct audit_buffer *ab;
+	const struct cred *cred;
+	char comm[sizeof(current->comm)];
 
 	if (WARN_ON_ONCE(op >= BPF_AUDIT_MAX))
 		return;
@@ -2120,8 +2123,22 @@ static void bpf_audit_prog(const struct bpf_prog *prog, unsigned int op)
 	ab = audit_log_start(ctx, GFP_ATOMIC, AUDIT_BPF);
 	if (unlikely(!ab))
 		return;
-	audit_log_format(ab, "prog-id=%u op=%s",
-			 prog->aux->id, bpf_audit_str[op]);
+
+	audit_log_format(ab, "op=%s prog-id=%u",
+			 bpf_audit_str[op], prog->aux->id);
+	audit_log_format(ab, " prog-name=");
+	audit_log_untrustedstring(ab, prog->aux->name ?: "(none)");
+
+	if (current->mm) {
+		cred = current_cred();
+		audit_log_format(ab, " pid=%u uid=%u",
+				 task_pid_nr(current),
+				 from_kuid(&init_user_ns, cred->uid));
+		audit_log_format(ab, " comm=");
+		audit_log_untrustedstring(ab, get_task_comm(comm, current));
+	} else {
+		audit_log_format(ab, " pid=? uid=? comm=?");
+	}
 	audit_log_end(ab);
 }
 
-- 
2.43.0


