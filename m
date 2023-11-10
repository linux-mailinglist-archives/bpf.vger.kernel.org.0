Return-Path: <bpf+bounces-14809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C817E86C7
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 00:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92078280FF8
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 23:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7933D982;
	Fri, 10 Nov 2023 23:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADE83FB00;
	Fri, 10 Nov 2023 23:57:02 +0000 (UTC)
X-Greylist: delayed 313 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Nov 2023 15:56:35 PST
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AEA47BA;
	Fri, 10 Nov 2023 15:56:35 -0800 (PST)
Received: from localhost ([173.252.127.6]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LtYx8-1rQjKW1h12-010xXD; Sat, 11 Nov
 2023 00:51:04 +0100
From: Jordan Rome <linux@jordanrome.com>
To: linux-perf-users@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Song Liu <songliubraving@fb.com>
Subject: [PATCH perf] perf: get_perf_callchain return NULL for crosstask
Date: Fri, 10 Nov 2023 15:50:21 -0800
Message-Id: <20231110235021.192796-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:a6BVsRL2QRpAGaOBDD1hPPv2MbJ4fjgivIhGK89IR6F1Es22JW5
 EjTfkYVl8kvZNLUGrRy5VhllM84wfApjuMhjhHU9ILgscjvmbFkwp6n0WWlEHZyEFsWuTKk
 uDb7MDVHxR7uBtqx4IfUjTkgKBWAGdgu0eYQtRMRhhoOFEGfbEtp2/Ep0Qo48svwQ0qqpN2
 g868W0KIFAKc6YEDAW6Sw==
UI-OutboundReport: notjunk:1;M01:P0:/ES/WiAn14I=;UDkRPJ6QSK0f/ugHCl3Fxb640kB
 Ko1MpqQFSQrQH+1JMsU5rD9By19oUarED4fhbpGfhRGJNp+b5F/b5KbxHVPdF4Ru2IKMVOx0+
 ayGM25/ztCbgn0YVMk7V3FqIZh1xvPUa4dF/ZrFIVUg5HhK3wTM5/gPpnICeXGdl5aHt9ka+b
 GvnZcHih62dDioJ+y3qNiI8y6/e6OnhEmUhRgJTXoUZHx18BeeVqkp90bZfmjfsIjGekvE89O
 wOhbMuKn+lZQP+MMwcZsMUd8ikjGOe1mlcLOEJEn07xKQRctaMDXkbu6WL4jA6F/3XAZakLTM
 fU/qT/mbQLXuRjPfBVRTZXWBQvx3VL6Dv6C/jLKVnLL5wy1HkC3rowE0G02pIsukaLWv+QfAk
 8eG6mWicO+vTpkjNfSyoA1y/nap20dX8R10rZ/xZkjlKKw01B5H7Ct6VRxz01/DJIX084/GVj
 VpKaxx/JKioGeCySB9MYs06+dzYfCwbqX1CgTIF50qWL3E/0vcNpAdRsZeqAFI45X5sZcPY8N
 J12poUZv6YosamRWCT1542GlyCNfdmRJAAPUgVPWEEmsnLxXV3w0pEufYYnmYQ2QF02yTio02
 SXkiyLae08ZUX1lBoQA0W0fYC9Xs3QyFczN9Fo/F2clpzmgfPsWXxNQMkmhu2axXG70+MxsTW
 G6Ae3uTt/5gAw9muWauTU9TEsRuKHdVHZS9EkN5OMgsn3uY+ra2F7oA2LH3XTHyqExwj57ZCg
 7GJNJ1WHT8wDfUqOMQrwbmg03iI9m6XntrAsNaU7Dtxzy8oZyoLjhLkkI7QGqQuEMrGkqJQ9x
 6HForIw+ibAA+EueskYQosMv6xxtCtACmyvkbqeS8Qji99dkqlCQauqF6gSU3oaL6wZbRe8mD
 4RGZmyl9MB1+zYw==

Return NULL instead of returning 1 incorrect frame, which
currently happens when trying to walk the user stack for
any task that isn't current. Returning NULL is a better
indicator that this behavior is not supported.

This issue was found using bpf_get_task_stack inside a BPF
iterator ("iter/task"), which iterates over all tasks. The
single address/frame in the buffer when getting user stacks
for tasks that aren't current could not be symbolized (testing
multiple symbolizers).

Signed-off-by: Jordan Rome <linux@jordanrome.com>
---
 kernel/events/callchain.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 1273be84392c..430fa544fa80 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -201,6 +201,9 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 	}
 
 	if (user) {
+		if (crosstask)
+			return NULL;
+
 		if (!user_mode(regs)) {
 			if  (current->mm)
 				regs = task_pt_regs(current);
@@ -209,9 +212,6 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 		}
 
 		if (regs) {
-			if (crosstask)
-				goto exit_put;
-
 			if (add_mark)
 				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
@@ -219,7 +219,6 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 		}
 	}
 
-exit_put:
 	put_callchain_entry(rctx);
 
 	return entry;
-- 
2.39.3


