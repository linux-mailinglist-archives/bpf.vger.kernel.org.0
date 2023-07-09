Return-Path: <bpf+bounces-4532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED6C74C500
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 17:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FCE42810CF
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 15:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46098F41;
	Sun,  9 Jul 2023 15:13:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD88BE8
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 15:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CC6C433CB;
	Sun,  9 Jul 2023 15:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688915589;
	bh=KK4AJoIaLPPm3zQMlhPjAJ75YEDERv0cDA6Wgc4knj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h8mShvPCZbz4DTjmX1S9WcK8PXiZrD/uQeGTJPgpmMgTXrtjaga4GjlrEd4gsITTO
	 pG0jBnfqEvih+PoogS9mwIFXBHSC9MI7Fvl70k+HzAFEA2A6UHe2mhDHKrGdh/1ieU
	 0wIQGGPj5mH3AstzFQzFd96tExMlOypcPUTiQ5tw1gZoZATq90F5Gqs+fb29ImbjvY
	 lB5/W+xXSsC4Fx7Io1D/K1waUQNPKwDOUJREXQZ0HzFjUA5skBOCM8HJzVBmYWdWHE
	 WEaPEaS2rtCdTkeamMlqKdlqCNp3IvA7Is+Kr3CNj9u95R/UkonXagk9M4p70mNaX7
	 jQqS4tZBqFt4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	syzbot+8b2a08dfbd25fd933d75@syzkaller.appspotmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 07/26] bpf: drop unnecessary user-triggerable WARN_ONCE in verifierl log
Date: Sun,  9 Jul 2023 11:12:36 -0400
Message-Id: <20230709151255.512931-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151255.512931-1-sashal@kernel.org>
References: <20230709151255.512931-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.2
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit cff36398bd4c7d322d424433db437f3c3391c491 ]

It's trivial for user to trigger "verifier log line truncated" warning,
as verifier has a fixed-sized buffer of 1024 bytes (as of now), and there are at
least two pieces of user-provided information that can be output through
this buffer, and both can be arbitrarily sized by user:
  - BTF names;
  - BTF.ext source code lines strings.

Verifier log buffer should be properly sized for typical verifier state
output. But it's sort-of expected that this buffer won't be long enough
in some circumstances. So let's drop the check. In any case code will
work correctly, at worst truncating a part of a single line output.

Reported-by: syzbot+8b2a08dfbd25fd933d75@syzkaller.appspotmail.com
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20230516180409.3549088-1-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/log.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 046ddff37a76d..850494423530e 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -62,9 +62,6 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
 
 	n = vscnprintf(log->kbuf, BPF_VERIFIER_TMP_LOG_SIZE, fmt, args);
 
-	WARN_ONCE(n >= BPF_VERIFIER_TMP_LOG_SIZE - 1,
-		  "verifier log line truncated - local buffer too short\n");
-
 	if (log->level == BPF_LOG_KERNEL) {
 		bool newline = n > 0 && log->kbuf[n - 1] == '\n';
 
-- 
2.39.2


