Return-Path: <bpf+bounces-18000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F469814AA7
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 15:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF90C1C227DA
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 14:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D521C358B6;
	Fri, 15 Dec 2023 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dtucker.co.uk header.i=@dtucker.co.uk header.b="NM4hFjxg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HKgmx+sd"
X-Original-To: bpf@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98B1DFF4
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dtucker.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dtucker.co.uk
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 5E0B23200A85;
	Fri, 15 Dec 2023 09:39:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 15 Dec 2023 09:39:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702651150; x=
	1702737550; bh=L2XmRnoW96MnpG5o0sQCCzIZAjQFsGFTwqbaza+Ek2U=; b=N
	M4hFjxg6/k8ztHS6Vkd9WyeqXV5zIhU09aB3mHneL7sIPvbXpt6QCEJHE4NbYg8w
	C1DBwNCwqFTUZvR+cEw/CgtGf447wd2gf+NbgRUa4yN+TeTCHHiODq9QV8uX63u1
	wVRzZCrsyKGUaXyr35+gr2CgfJXJdxYHA/MvMTJ0U0wl+qQGIF3SmDQGpAb9Kjki
	WgFnSfJDxkadzCyNA50hWpgLcPUPq/MG6u1T1LnWa2p1E/BC4rGVu44jfUNFBMLL
	TR678+cwMelCbILu2gh6+u7bT2fd+RBubOoS1v2sFY4WBmTrFObCejUXoRRyQ2Kq
	fRqW2j4HJi68jS9B9zgxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702651150; x=
	1702737550; bh=L2XmRnoW96MnpG5o0sQCCzIZAjQFsGFTwqbaza+Ek2U=; b=H
	Kgmx+sd1WNeZn9135pOWUydA+JD12QMlvhuAsO60m3reUdtOzXxdcdkRwk3NIZAQ
	otkIegX6gi6QTCLPAbXpfK2iXGGMDR41L2KB7QqHcr+aDvhyTKMrBTKU7gTGjiJQ
	1uZNPr/sFLIKiznxdaoMyOn5e1bwNDVxmME83hqfK0uLCy5QCo8IOP+ZDZrDcZQy
	kUuoUUHE8Sd3dU+oNXN/8QXXbL07BneSmnHuGFjju24afl8NXgZRk0/lGwZcQ07z
	ABpQWCh5J4MmTg4pJGH1tv4isBA9dad/5oQGT3VQ2hU9OsAbQ2U32w6iJyMiqu3F
	3doYJf7LJXS0Mis+ShLVQ==
X-ME-Sender: <xms:DmV8ZZIcWvk7pPdNCXD_MS3DGEYvNj7cwI3FZorMxIkpBz4HgVKrPg>
    <xme:DmV8ZVJyl1uNwmGjmuKnGHH90jPRBI6Xus2N8aTOoKaZZUvglSNBhHK3W-EuWbuv5
    3Ltpy4WGLO5d13yHA>
X-ME-Received: <xmr:DmV8ZRuxKYfdcNyHqXOvD6lLPICY1PKfzBXpGKirsa86DQK-9SR8GPiTC2s5ylrBHWkb92u1Lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtvddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrvhgv
    ucfvuhgtkhgvrhcuoegurghvvgesughtuhgtkhgvrhdrtghordhukheqnecuggftrfgrth
    htvghrnhepleeufeduvdelfffgiedvudduueethfegheegkeeuheffkeffieelueetffet
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepug
    grvhgvseguthhutghkvghrrdgtohdruhhk
X-ME-Proxy: <xmx:DmV8ZaYWpvURsn08lk9nZUv5uvs8fU0UuadUMuF2LAIi3ibkF7HRaA>
    <xmx:DmV8ZQaNXOGFrMWU6u7YMB_nx0euHt9vqmbRiDc0UlXJ8Jhhzv6IQw>
    <xmx:DmV8ZeALitEgVor7CPooeF7Ep9EztxYOrVXvr7Fpj3SPwu2TN5mQ1Q>
    <xmx:DmV8ZQoolZbyHUN0HAJljnSki6uMQL3H_8UeCXMH7WMZsqnfVVqRVQ>
Feedback-ID: i559945a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 09:39:09 -0500 (EST)
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
Subject: [PATCH bpf-next v2 1/1] bpf: Include pid, uid and comm in audit output
Date: Fri, 15 Dec 2023 14:38:36 +0000
Message-ID: <20231215143836.993858-1-dave@dtucker.co.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAADnVQJi1mezWL6BKn=Vw4quev3pgLOW9q3Yz9GF=LjzZoHp6g@mail.gmail.com>
References: <CAADnVQJi1mezWL6BKn=Vw4quev3pgLOW9q3Yz9GF=LjzZoHp6g@mail.gmail.com>
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

v1->v2:
  - Move 'op' to the front of the audit messages
  - Add 'prog-name' to the audit messages
  - Replace deprecated in_irq() with in_hardirq()
  - Remove in_irq() check from bpf_audit_prog since it's always called
    from the task context
  - Only populate pid, uid and comm if not in a kthread

 kernel/bpf/syscall.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 06320d9abf33..fbbaf3b8ad48 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -35,6 +35,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/memcontrol.h>
 #include <linux/trace_events.h>
+#include <linux/uidgid.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 #include <net/netkit.h>
@@ -2110,18 +2111,34 @@ static void bpf_audit_prog(const struct bpf_prog *prog, unsigned int op)
 {
 	struct audit_context *ctx = NULL;
 	struct audit_buffer *ab;
+	const struct cred *cred;
+	char comm[sizeof(current->comm)];
 
 	if (WARN_ON_ONCE(op >= BPF_AUDIT_MAX))
 		return;
 	if (audit_enabled == AUDIT_OFF)
 		return;
-	if (!in_irq() && !irqs_disabled())
-		ctx = audit_context();
+
+	ctx = audit_context();
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
 
@@ -2212,7 +2229,7 @@ static void __bpf_prog_put(struct bpf_prog *prog)
 	struct bpf_prog_aux *aux = prog->aux;
 
 	if (atomic64_dec_and_test(&aux->refcnt)) {
-		if (in_irq() || irqs_disabled()) {
+		if (in_hardirq() || irqs_disabled()) {
 			INIT_WORK(&aux->work, bpf_prog_put_deferred);
 			schedule_work(&aux->work);
 		} else {
-- 
2.43.0


