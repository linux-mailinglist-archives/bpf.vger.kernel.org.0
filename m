Return-Path: <bpf+bounces-60862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BBEADDF29
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 00:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3CB189CE42
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 22:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3258329B8E4;
	Tue, 17 Jun 2025 22:51:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80752236F0;
	Tue, 17 Jun 2025 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750200679; cv=none; b=OzHbtZr9ZU04xzsJdsC+9+o8YQHQeaWN5mD5Pw6d0CZTSoZpZm5MNzOmOcPDmphjm5zqQXU4fZgl56n4Igu6/VX2byfMVPR0+xoi9KoKnPiuWRyV1utAbSmSDf3OKOYZ8u/gaUaIgnQ9VDMhwxNxwFMFqGJofsZuapAHkYYfT7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750200679; c=relaxed/simple;
	bh=tQh371Xu4aNv634IWnbNpzI8g0gGO4AVuobSDHJ5Ps4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Tw1WfaV6BiDHEkbUuNhJUQ1RhWjNiTovBm+tg6r4FDnPz/QsYRmg/x6vQlqT8FE+uM1z8svZ2/7Gy5A8tXLKzwzFUcokg232ClztyTHebZOeGiFqNoaawVIU/74MV7itzvrVm0w4e2uM/Gz239DsjqJjvvFvbnPmmLiw0A/W43U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id BC6FA141154;
	Tue, 17 Jun 2025 22:51:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id B1A7D20010;
	Tue, 17 Jun 2025 22:51:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uRf9C-00000002L7M-2r6D;
	Tue, 17 Jun 2025 18:51:18 -0400
Message-ID: <20250617225118.534693313@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 17 Jun 2025 18:50:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 09/12] unwind_user/sframe: Remove .sframe section on detected corruption
References: <20250617225009.233007152@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: B1A7D20010
X-Stat-Signature: ypd7ortim7kq6rpt7cp9pyzhz77fkpzq
X-Rspamd-Server: rspamout05
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ROPDjcbpEBpaHpXKFMHwDedIa85mBo9E=
X-HE-Tag: 1750200671-360188
X-HE-Meta: U2FsdGVkX18vE1pJ16lY9OgNx+z1WFFwrttJb3FBM4snVXAL/KHnaodDh/rVSZgH1O9GXj7mTKGocH/BB6CaN0ECSH1ijzQGBa6y7g06tkm+rGg0JQvTfy9JjhWjt4KOk6ntM7uz63BvlnFXmp9JV78NRGQ3DChWxakKuxAgVBkr3QGCelmPCvPsBjnE6w3EFjjlc07/bqSxz6h2LRSvPvPlhqgQbQRElg/nJSlfp3M0z8byjV3VIgLEHtBZKrqPoFWkCGFRWr9beyfHgDlqEXGkH++vXViSqvkLg2eqPhoy5ceg9T0lZuPSjmawa/eW2p4sobwMbgpPRt8jpCohi77bnPlByBlhB1M409dRPCJVWtCNbhvG2Tqz3BzLhCqSbbl+V/y/VZRgKgPcJk3AqOyROtM2vjhl/HuyPf+cBo35bHZyO2ESHxCvTCVNaaXLMj44G4h8QCk=

From: Josh Poimboeuf <jpoimboe@kernel.org>

To avoid continued attempted use of a bad .sframe section, remove it
on demand when the first sign of corruption is detected.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/unwind/sframe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index b10420d19840..f246ead6c2a0 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -310,6 +310,10 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
 	ret = __find_fre(sec, &fde, ip, frame);
 end:
 	user_read_access_end();
+
+	if (ret == -EFAULT)
+		WARN_ON_ONCE(sframe_remove_section(sec->sframe_start));
+
 	return ret;
 }
 
-- 
2.47.2



