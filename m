Return-Path: <bpf+bounces-17814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1470812FAE
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 13:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF512816D9
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 12:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CA841233;
	Thu, 14 Dec 2023 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dtucker.co.uk header.i=@dtucker.co.uk header.b="s+9JtdT5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RxmwrFVc"
X-Original-To: bpf@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0503B9
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 04:07:25 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id C21753200A9E;
	Thu, 14 Dec 2023 07:07:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 14 Dec 2023 07:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1702555643; x=1702642043; bh=opSTOvJYza
	lOV7LbQLhoNPTX2pG4D0zIz08f4LvHCmU=; b=s+9JtdT5s33sNmkClHA0e+YPIw
	VH9xRg4dzDhBr5KlelWqBiREF7o7zXzI79/J/JKvTgiHgKt9JuMUQ/a3Qk0xtKas
	O367hv9LPLuakKNu3yh73sPa2S715InruG5w6N3QjkLVkF2eD+pGfoA8N9HRoclq
	hb3HwT73z5TTvyp9jjKOgIoTZouu3x2cmAGm30RAh5Lou3MUzu8pUOVipmrV4hG9
	+lbB0AruJOaMnM6c1a3VJ0nOHLhiLHSxF4sRpFayNIVxdk0JNe6b0Y5tr1/r4kEt
	toosZOWAnPuqx6I6iaMYs/+RD4KCylo4nIfzFtyvqOL8iuXpGxKxUK+xeN2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702555643; x=1702642043; bh=opSTOvJYzalOV7LbQLhoNPTX2pG4
	D0zIz08f4LvHCmU=; b=RxmwrFVcPoXybI9DizRF5qdwGRllYKY0pQjwiImWLT39
	IR0CkOorGIXSWJci+PzaJ0YqYS0kQFxYB8jrDwvThVjQ1raGFt8MvmOKBn1arABB
	yHnPvYMrnqGJZI+9iB3aDG07OxRs7rLncYwGMmNzzL+6gN2LKeWMdwXy48DeZG/4
	tGSPy2cf12k5xKMjmtGRLqncRpal0pDoehUmSU7l74+80/nHHLUpDgCkdArJRf5z
	mMYOgVi3aMmQ/3tghPnLhnXwFZawmGGqQbXy/HfNj5cVlx8odZfB2GluyfglvOKP
	VxI/ZRfOZJ4GxAv3L4tbdU02cZzpFk1THHXBjEGIsA==
X-ME-Sender: <xms:-u96ZbYQIYoVq_-Fcei4T7yYCe-wUouykv6z-IDaH3oi5_lGHUYVag>
    <xme:-u96Zaa91QiyLCnoV27edVj7OeAvVpdiDrLGGuwOVOSIcrPst_UQlssOOdLOuSFCJ
    5-CjXqsPJCP0PEYzw>
X-ME-Received: <xmr:-u96Zd87zYselir5jMrRgdnM4uWMhtAymYj6Gk9HkUllCqKfn_RIiSYsdZ7bDeiyACMj2ii6WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelledgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrvhgvucfv
    uhgtkhgvrhcuoegurghvvgesughtuhgtkhgvrhdrtghordhukheqnecuggftrfgrthhtvg
    hrnhephffftdekgeevieevfefgtdduheekheeijeeludeiheeitdffveejkefhheefhedt
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuggrvh
    gvseguthhutghkvghrrdgtohdruhhk
X-ME-Proxy: <xmx:-u96ZRpEpMLUs_YgF8by4OtaGVcPfj3uBqgnj3TqCnktqm1axTQizg>
    <xmx:-u96ZWofXAXIpD9mEwctThfBl32zAxHXpQJDtIVS7Vzfvr2nQzigKQ>
    <xmx:-u96ZXQ4EW8kE0y5Po_6h8ulrKvAyApK-wojNK7yaecKyvRVvSA6Dw>
    <xmx:--96ZchhqS13rMzwN7EFJkQknD70_koMlSHM2vTVlbCevpe9HZisRA>
Feedback-ID: i559945a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 07:07:22 -0500 (EST)
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
	Dave Tucker <dave@dtucker.co.uk>
Subject: [PATCH bpf-next v1] bpf: Include pid, uid and comm in audit output
Date: Thu, 14 Dec 2023 12:07:16 +0000
Message-ID: <20231214120716.591528-1-dave@dtucker.co.uk>
X-Mailer: git-send-email 2.43.0
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
any context. If we include the pid, uid and comm we get output as
follows:

time->Wed Dec 13 21:59:59 2023
type=BPF msg=audit(1702504799.156:99528): pid=27279 uid=0
	comm="new_name" prog-id=50092 op=UNLOAD

With pid, uid a system administrator has much better context
over which processes and user loaded which eBPF programs.
comm is useful since processes may be short-lived.

Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
---
 kernel/bpf/syscall.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 06320d9abf33..71f418edc014 100644
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
@@ -2120,7 +2123,14 @@ static void bpf_audit_prog(const struct bpf_prog *prog, unsigned int op)
 	ab = audit_log_start(ctx, GFP_ATOMIC, AUDIT_BPF);
 	if (unlikely(!ab))
 		return;
-	audit_log_format(ab, "prog-id=%u op=%s",
+	cred = current_cred();
+
+	audit_log_format(ab, "pid=%u uid=%u",
+			 task_pid_nr(current),
+			 from_kuid(&init_user_ns, cred->uid));
+	audit_log_format(ab, " comm=");
+	audit_log_untrustedstring(ab, get_task_comm(comm, current));
+	audit_log_format(ab, " prog-id=%u op=%s",
 			 prog->aux->id, bpf_audit_str[op]);
 	audit_log_end(ab);
 }
-- 
2.43.0


