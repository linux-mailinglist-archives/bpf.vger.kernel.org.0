Return-Path: <bpf+bounces-46006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFAF9E1E27
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 14:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82E6283534
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 13:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939221F4267;
	Tue,  3 Dec 2024 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="beQqgbS9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A091F1304
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233727; cv=none; b=Tcd7HVi5oSBzB4PjELOVp4wfDuB9yapM7jSN0LzyxOOViJ8S+HQpCAEcaKA4tcDEkICz7AoQ6GUJDdcYqASlEs4sFu5vTZ9YOKWpWzPvCeMbm8sGJjopoMrHPH567hFIICIoUILp2XwBjAd2MnAL8RBKnlMagQwdP9O/j0IdDuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233727; c=relaxed/simple;
	bh=Ni0zh2IwTW4Eo4e12gso0nYbquPYytFmeY9s4Da5xao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qgg3ph2Tk28VRsS9yTTi1W9dWwwaXQs/fcBvhBMbcGyONpx9iNk0dxwDsXrzQvJqYbUGAxvPzDNvBYcRpMytzBxbZPjXO7NqLh+1LB0Qw7YynS5dhW/KFfjh1IFbf+5Q3i/aKDnCjDceJcKCGdwOd1fW2SyoO4vx6LeMi14HKf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=beQqgbS9; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d0d4a2da4dso3586977a12.1
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 05:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733233723; x=1733838523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LK8iEwp1R6Eqbfjz8+ERFHqx0nK18yrWJ/XJarhtfQE=;
        b=beQqgbS9foxAvUdciqg9Ia6ZbQso/KRppbm8zTyYEPn/hXa7bMhDYeSp8//5qvFeAJ
         JKiyJEBa6DmBpSTaWqEdfr17IvCRdWNHXL+6UREaGpJ2cS6p7KuWhZib/spMqQ6tSKSh
         KxHnL3xZYZg4XKEB30f6krFBOyZ4OpyPLI3S9u6R56X+czddg6gCbtoeDFfqCTw1YgzD
         XPLxmNyZ7OLVHiH8E0wOaBCafax4Np8N45vXrgTKKPCdIEIxK1f50shZ3dzBxf3czG/v
         0Us0a839sH8Z2xNTmuyCIsQ58KjEv2x37nNQEgD8KcNEKvNNS0CfiQd1l9YyN+bLH6SC
         3R/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233723; x=1733838523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LK8iEwp1R6Eqbfjz8+ERFHqx0nK18yrWJ/XJarhtfQE=;
        b=EsXm4AntVTXiSIf7QWcQHsxqITr9rufjXU4VYnKK9pEYGSZyB13bbxufFU3qcXH5ua
         qjUWwq+QdCFsnn3Eooy7vGW5Zm3RSQlw4fX3mPo1yrvkrv+1ffghWbswjO30IMlbRwsB
         6Px3iQ6VtrUKdifx2KS48xiCoLXEXjPzwqXc5aZUmo+cPFiRkrGQfT8VayAsiDHQUl5E
         Sg5zW7jB7l/81wbIDVbuas78Qd6P5JdNwGuQtTgqrbzonfViUzvlZ2+70LlcCKCTiIee
         2ibeLwfjobSB4UDSD/GankbMx/fpLRJoowJDS9maSkZeNOOJtJ8l1Oo4hBQVC7pwOaTc
         rJhw==
X-Gm-Message-State: AOJu0YzuGxWYDXZZt5wOHcx/Fj7k5oO+OSx0xrxnLXW3JPjErc6e/U3K
	vQa7T/33OKMejFJUQ9dbzoQzG4ac/avBLxrhwfz5mLlFMimSueqxYijGa+50di9k++drCdRcfxV
	p
X-Gm-Gg: ASbGncsNaqv8RIZyuTSYmCIYWDLpW75E/+6lzIXjbm4sOn0mJaYK2cZT2tranzUarME
	08CDC9IgvPtYaWOv4zeGOu9mZ8Xp2nchhbAosN2D1B+vqg7ddtAobQqB5qmqwkSpRGdh7XFhlV9
	dMapPUBugZvXgRNKMcqgYN08YpTOwIsW9gPh701kbVo7T/W2kt3hcOdy54VDZrq9cKoHPgYKsph
	XvSwygCv6lskuRKFJS5DNqMUVuFK3XGFL2jDlQ0r4W9XF8yZAfAoUPDOuA1sJc=
X-Google-Smtp-Source: AGHT+IHppb3RLV+ZQYQMgG0ulnpXb7F0r60cbufB/TrKv1dWX5Am0bUxdbwrs/wCIsgClpuBPXrOoA==
X-Received: by 2002:a05:6402:3510:b0:5d0:cca6:2344 with SMTP id 4fb4d7f45d1cf-5d10cb55767mr2416796a12.12.1733233723522;
        Tue, 03 Dec 2024 05:48:43 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d098330dd2sm6243394a12.14.2024.12.03.05.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:48:43 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v4 bpf-next 6/7] bpf: fix potential error return
Date: Tue,  3 Dec 2024 13:50:51 +0000
Message-Id: <20241203135052.3380721-7-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203135052.3380721-1-aspsk@isovalent.com>
References: <20241203135052.3380721-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_remove_insns() function returns WARN_ON_ONCE(error), where
error is a result of bpf_adj_branches(), and thus should be always 0
However, if for any reason it is not 0, then it will be converted to
boolean by WARN_ON_ONCE and returned to user space as 1, not an actual
error value. Fix this by returning the original err after the WARN check.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a2327c4fdc8b..8b9711e6da6c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -539,6 +539,8 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 {
+	int err;
+
 	/* Branch offsets can't overflow when program is shrinking, no need
 	 * to call bpf_adj_branches(..., true) here
 	 */
@@ -546,7 +548,9 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 		sizeof(struct bpf_insn) * (prog->len - off - cnt));
 	prog->len -= cnt;
 
-	return WARN_ON_ONCE(bpf_adj_branches(prog, off, off + cnt, off, false));
+	err = bpf_adj_branches(prog, off, off + cnt, off, false);
+	WARN_ON_ONCE(err);
+	return err;
 }
 
 static void bpf_prog_kallsyms_del_subprogs(struct bpf_prog *fp)
-- 
2.34.1


