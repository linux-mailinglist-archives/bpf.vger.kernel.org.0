Return-Path: <bpf+bounces-5133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4C4756B3D
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 20:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD52281278
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 18:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB911BE56;
	Mon, 17 Jul 2023 18:05:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8921FD7
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 18:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2388C433CC;
	Mon, 17 Jul 2023 18:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689617095;
	bh=z5xJPNvzuFRjo2lR/l/wLkVKNv1SHd09S5ncMfb7TjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cYt2oIUYUT5pC68a8AdfGvE7WCB9HYuDQCTvgQXOZYLpS4p1Hxh4GFFaGy7Iuj2AT
	 MAoo0tdMoFMV264r7XQFcDWalXuQqA/Tg2hd3g1obZ9k+DGOkOHT4bEEeyW4Usvy8Q
	 PLAJcrOLgPZb9m40+DnRS7yEFB6BL5wcLYNYsfLen+9EpHRfxVZq36bPsRKOHlsMnK
	 1bFVAiFBvrIA8UF17g6tw6Xw40hQGAN+4PceBM2Sx0egUp+QaJ9zs4OGrol7eA2mnG
	 qNbZ0je4cj+eUqLh/tkOKAzZYlVun9e2B62ePPtJh2RnrmbykNJX46G+DIPj/86bhX
	 03iiHStrPifgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5ED95CE0902; Mon, 17 Jul 2023 11:04:55 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Subject: [PATCH rcu 5/5] checkpatch: Complain about unexpected uses of RCU Tasks Trace
Date: Mon, 17 Jul 2023 11:04:54 -0700
Message-Id: <20230717180454.1097714-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
References: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RCU Tasks Trace is quite specialized, having been created specifically
for sleepable BPF programs.  Because it allows general blocking within
readers, any new use of RCU Tasks Trace must take current use cases into
account.  Therefore, update checkpatch.pl to complain about use of any of
the RCU Tasks Trace API members outside of BPF and outside of RCU itself.

Cc: Andy Whitcroft <apw@canonical.com> (maintainer:CHECKPATCH)
Cc: Joe Perches <joe@perches.com> (maintainer:CHECKPATCH)
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com> (reviewer:CHECKPATCH)
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 scripts/checkpatch.pl | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 880fde13d9b8..24bab980bc6f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7457,6 +7457,24 @@ sub process {
 			}
 		}
 
+# Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
+		if ($line =~ /\brcu_read_lock_trace\s*\(/ ||
+		    $line =~ /\brcu_read_lock_trace_held\s*\(/ ||
+		    $line =~ /\brcu_read_unlock_trace\s*\(/ ||
+		    $line =~ /\bcall_rcu_tasks_trace\s*\(/ ||
+		    $line =~ /\bsynchronize_rcu_tasks_trace\s*\(/ ||
+		    $line =~ /\brcu_barrier_tasks_trace\s*\(/ ||
+		    $line =~ /\brcu_request_urgent_qs_task\s*\(/) {
+			if ($realfile !~ m@^kernel/bpf@ &&
+			    $realfile !~ m@^include/linux/bpf@ &&
+			    $realfile !~ m@^net/bpf@ &&
+			    $realfile !~ m@^kernel/rcu@ &&
+			    $realfile !~ m@^include/linux/rcu@) {
+				WARN("RCU_TASKS_TRACE",
+				     "use of RCU tasks trace is incorrect outside BPF or core RCU code\n" . $herecurr);
+			}
+		}
+
 # check for lockdep_set_novalidate_class
 		if ($line =~ /^.\s*lockdep_set_novalidate_class\s*\(/ ||
 		    $line =~ /__lockdep_no_validate__\s*\)/ ) {
-- 
2.40.1


