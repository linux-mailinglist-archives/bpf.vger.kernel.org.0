Return-Path: <bpf+bounces-43568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8479E9B68C4
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 17:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D822882C7
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 16:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF282141A1;
	Wed, 30 Oct 2024 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grT93DND"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E84A36126;
	Wed, 30 Oct 2024 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304138; cv=none; b=X2RNuPFeojheiJ/gvFOlcmrA/BYBWLV3Jm0b396YY1t6vKaS6uNm6rHFfkAK4SqG+eK6vXK7pGel+bfRFpUUaeoDZmpbPNDUL+p4hq8S7Jy+CE7ZjWUJLBo6jhdBj1PyJ50AybNcQdRSQXZvcj3VhsR4bHZgz2UaTtoJ4VnqWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304138; c=relaxed/simple;
	bh=ObLb9xVnLmTxDk4I8X448bZDNJQZC+3IyOwYYRurdMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mjOORt8i+AemyY9gq88IeL3TCuR50PDjEqbxNKrQ8lTAkI75+oTL1Xrk9FrTPOxwEB3im9ZzVXrYkBZn5FfaHTmneMWRdPDmAuW4VG5qEgidpz8gENORcGDNz10PGPSQuhO9qHvKO5eLziMPATOwDA9n4faVnQfJS1CkffBDw+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grT93DND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97A9C4CECE;
	Wed, 30 Oct 2024 16:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730304137;
	bh=ObLb9xVnLmTxDk4I8X448bZDNJQZC+3IyOwYYRurdMU=;
	h=From:To:Cc:Subject:Date:From;
	b=grT93DNDl8Vs7yKEC9ZqUrx2yZJcqpQBBwBSb7heHfpPYw7bgkatgF+Bdrd9d/hlY
	 jM7KePkP6IQsEaoduUgU5HfNDEgh5/OQu+axL9ettEb0HP34p84vHrhXuokKi8le03
	 WrNAVZ7SqOE9+6Q/Ywxky9l5Z1pvfloEtSQBGHRSR5wIrtLw3bb3zRZvhTceqfvcMM
	 TgAsjLosVcVHqnjoLG4pl3t+cuqlSP4rT3FRVuMjeH/YPbC2HRKfoof1ER5f7rmOCK
	 ArCDLJbSlVs8Uc0Va+VmrPAfSg+Y0FI4p/PFsBVZJD3HMX/c+9WHpA3qV/0FLYhySN
	 5lSTFemMJHicA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mingo@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH perf/core] uprobes: fix WARN() inside hprobe_consume()
Date: Wed, 30 Oct 2024 09:02:08 -0700
Message-ID: <20241030160208.2115179-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use proper `*hstate` to print unexpected hprobe state. And drop unused
local `state` variable.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202410302020.1jHBLfss-lkp@intel.com/
Fixes: 72a27524a493 ("uprobes: SRCU-protect uretprobe lifetime (with timeout)")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 998a9726b80f..f2beb4b3f5c5 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -704,8 +704,6 @@ static void hprobe_init_stable(struct hprobe *hprobe, struct uprobe *uprobe)
  */
 static inline struct uprobe *hprobe_consume(struct hprobe *hprobe, enum hprobe_state *hstate)
 {
-	enum hprobe_state state;
-
 	*hstate = xchg(&hprobe->state, HPROBE_CONSUMED);
 	switch (*hstate) {
 	case HPROBE_LEASED:
@@ -715,7 +713,7 @@ static inline struct uprobe *hprobe_consume(struct hprobe *hprobe, enum hprobe_s
 	case HPROBE_CONSUMED:	/* uprobe was finalized already, do nothing */
 		return NULL;
 	default:
-		WARN(1, "hprobe invalid state %d", state);
+		WARN(1, "hprobe invalid state %d", *hstate);
 		return NULL;
 	}
 }
-- 
2.43.5


