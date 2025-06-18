Return-Path: <bpf+bounces-60897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF7FADE71F
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 11:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1528403564
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 09:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C16285064;
	Wed, 18 Jun 2025 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNRMV3Rh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BC7283121
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750239109; cv=none; b=IuzQvo8Xc0oCBFqDuav2TwNgAoN5Ex2V7Ouv/Zk/QMefyx4AYlwlMzz8lmpopW53+HJZ7TBdAuNSUbsMQZxdjPOYWI8eNf+zhWe2OcQM25hkqYl7JcXqWFWGNyl5FYpE3G/0iXjRN+NRnLsq4V03nEqsXDeX7rzlrO4bzlrXRVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750239109; c=relaxed/simple;
	bh=OFpDrsIlumr9YxmloXUNYhHGuxyW0/RZOymMpvT6bUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RqapTR656GfKkJh/72Xj22bt3dqz2ueB/9NWPLwEIl9iGJMkeCmUBTQ85yjw1XbIZOxs9SH8pv+QIpL373/boQHYFOXti3NaOnuFdwpAJRH78To+HUG4y3EmhpTLLcEeCCPTes0YQEj3KoXKrvq06Q5XxmK2lXCjAcA2CbY1w5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNRMV3Rh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23633a6ac50so97260015ad.2
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 02:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750239107; x=1750843907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n25T5rP13jFCJDF7vu7wmHkMc18yHtZMuntOcmIOPGw=;
        b=bNRMV3Rh/g3nw1oM4BIDE3b6O6kgqnZnivAYO8Nj4fLwtINZTxUD+GoE4BvFvX/c83
         fLNEtBUXfmxbKusHTG34L4W9vYIbz3rVZghvNEH4yT1hSk7A4Ovi2quJobqEguwYyjMM
         tQm7RsZcQvtxf99jkCh9tCwh88zvPzgd5vq/VDqLB86DUw/115Y1S60Bl6Ey+g6F/+aF
         yTo0QKHpCOsDWY44yZaX4du1l+um5iKs/16bexU0sDrlbs7GH1hTWvbf3wlcR5IYAM2E
         QUW+HFB6B8OkLLe5ZzN4ra2VTqCzL2/azHSKT5OlBRX7zY967rJeIZwQiWMy02Omzy2O
         1BYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750239107; x=1750843907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n25T5rP13jFCJDF7vu7wmHkMc18yHtZMuntOcmIOPGw=;
        b=IAasTTJDwdsYIaPLiFJULWrB1guzTU8J4XQMqA1tWsRsGRUqw7vT510kzihQ66tf77
         Jj1QRpwSaCgdhbtcwGJRQR/0eb/u6O9+baT4xvs4vyyXfQxTuT9V1vQvxxEUKvQYKTJw
         +jc6q9Vh9UABtNFslFkJNC4+51xZBC1VpMfrW4Do8kNCyzEduH/cs7+8BymomOBdpanH
         vFkKg7idHYRBpXLdLG2gA4qWESPgTHgsDd3S6niq0Urt1Pp1kEU/fsyVGc/wlHdJE4hJ
         C7ynghD9yVdQWZaBR4mdl3gHd0FZbgxFbPWu41+sURA/iUZo88UnudeYuvNw1lglLoq6
         vrkA==
X-Gm-Message-State: AOJu0Yyz8lOX/gaHtk9n1SmJ7GknAvGZujuQEoPAMBcglaKbfnh4YEPA
	eYRFgyg3H8KuvFB2sgkxyNF1tfWnmjB4wv6YgTip9q3bqceV5/8rX5pDzzteU//DyKQ=
X-Gm-Gg: ASbGnctQLo3OAlFHNHgdr1DIYATPAEaZkA8sITMpUDoKkeSSwoRtRRoLOXVs3AMqALg
	vtYNHaISUCj0USgHF8eFBvjYR+yfu41yeXVHNPHVvNB5/CGYmTQUXhWcuEV3DNqc2jwVc4cQsaj
	iIZALyHuqy4xK8ERCOzPF2SdtgF2x9ShzoHIPuBJGtpZudsF37BFe2KHGFSZ5qbIHD6vVGkZtES
	m4WhwKaOWB+fI09KP6e+x2tAHwndRQS4Z7Wq83/Eojfcg4FQ0XRAbasl1PYWm3crMsMPhK6UGlg
	TOCVPwRyYDouIBqpcRU3ab6X0/nG34cU77OESVTkreYYYFA4LFYsQfh9Mg==
X-Google-Smtp-Source: AGHT+IGr8k/jFzZ41S1dSLguIaQlCeAmyNoFK7Ksle+V44g+/OVtkdcpyABc3w8pYkcZm7b/9R+Zog==
X-Received: by 2002:a17:902:c412:b0:234:c5c1:9b84 with SMTP id d9443c01a7336-2366b3f8345mr238292445ad.37.1750239106517;
        Wed, 18 Jun 2025 02:31:46 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2369eb1fc31sm16337505ad.200.2025.06.18.02.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 02:31:46 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1] selftests/bpf: include limits.h needed for PATH_MAX directly
Date: Wed, 18 Jun 2025 02:31:34 -0700
Message-ID: <20250618093134.3078870-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Constant PATH_MAX is used in function unpriv_helpers.c:open_config().
This constant is provided by include file <limits.h>.
The dependency was added by commit [1], which does not include
<limits.h> directly, relying instead on <limits.h> being included from
zlib.h -> zconf.h.
As it turns out, this is not the case for all systems, e.g. on
Fedora 41 zlib 1.3.1 is used, and there <limits.h> is not included
from zconf.h. Hence, there is a compilation error on Fedora 41.

[1] commit fc2915bb8bfc ("selftests/bpf: More precise cpu_mitigations state detection")

Fixes: fc2915bb8bfc ("selftests/bpf: More precise cpu_mitigations state detection")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/unpriv_helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
index 3aa9ee80a55e..f997d7ec8fd0 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.c
+++ b/tools/testing/selftests/bpf/unpriv_helpers.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <errno.h>
+#include <limits.h>
 #include <stdbool.h>
 #include <stdlib.h>
 #include <stdio.h>
-- 
2.48.1


