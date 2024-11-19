Return-Path: <bpf+bounces-45162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A649D2326
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 11:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F4A1F2269C
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 10:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5211C2DB2;
	Tue, 19 Nov 2024 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="R9UTcPM8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDFF19D06E
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 10:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011199; cv=none; b=peMTI9u/YoCfXU1ffF5cGjB5YS5lddrCRWaMgppFOblxKCU/7tqFNDhGyzq3mknpknoRgeXqPLeInIvjhPiTqV8QYWzHOMv3/kFcGBuElYpyAYGS0ipm92ZhIkefvRM3NCXhXbpAH28M1+jGT3KUOkbikWx8QgmwoL9i0NOvsd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011199; c=relaxed/simple;
	bh=+leBIfGTx3qYqG0qr3EMc/+ailKE10I/dQRiyX0z0CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CmqHhoToGYHUM8uu8cgLu5HEU6lRzDbTWtLL7ERTsy8d0KRbojOmD8gN0Hegq8P/i7JOMiR/hYkpbfp29MO+2CXlcwyVqSyKiI2oFPr0DzVLTWBGVp2SZvHOzb+i71uxDOuU9ikCLNKAkC94D+Zqfl0yLhK6dpzSZH33UpJo7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=R9UTcPM8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so247151966b.1
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 02:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732011196; x=1732615996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G329gGS4RBx9EPCJNPCJhs4+g77tte1wqZgFhLBI2LE=;
        b=R9UTcPM8gA0ZOe2mbM+BbpwSuTX7VyXA/mMRpW+wiQ1b9LDrp4tMn/Dd9lfQlYJp1V
         BTxcvjyz4qRrEGwYwOYZXnEWom9R9djQ/qhjPFX+ygShshSCy1a49fJ7QzAYDiiaUP8G
         tv0KYDJ7KL2AtcKhkKyNY8+dUA0tM3zeKy8bSoa3iWBMFa864njoNRWu5Y1bEUZNalAj
         GisYd1uSUbOQ7/2ox8fC+aWM5ENu5lusbTFJntiPCl9JsNlQC3dwcolvI0Z0F2TcNzy9
         6FPqGetjbcv+iany8BVPPvk3cTilPv43WqBLAyb7lDLiTEy+IMeCXwtdcE7k7dqUKpVI
         8veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732011196; x=1732615996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G329gGS4RBx9EPCJNPCJhs4+g77tte1wqZgFhLBI2LE=;
        b=G42s/iHLb4kcUI7vRUHIzr3axvR/0oXyGYUsgGJgJnaQZeYpgZOgd8WOBGlhN1CSy+
         hihKSChy1XqsrtOSxjPCAcsq8Aa1h/b4qCcDSZx+E8Ov5uA0lOOUVGf64ZrChUOlMjN/
         aQ43cx46xSUZm0IwH3FnTTLPa8k7Nr75fshc/2b/8qZB6POpH8yEpSixIPwKwog9UVmX
         FazCcthRXXXZ5WjIZEyoQeN89H1EWkQo6+UB9KLjgxjjFi21vav46r7gR0HpjqMbleDL
         98sWF+CkAo1z7skUjyyqq/HJzs/FHnK+tJA+g3ekDoaSXpq0UyZyTfCjffdQ7GMHM5pq
         LNQg==
X-Gm-Message-State: AOJu0YyLTh/COrS1kjNKMhCQ6gxR6/X/62CVu6BH6iUS735mm1bdZNNi
	8MMi3HpglhYfh8Kw2Wdq+X7juGHjtByERDZuMzUHy7iHzXTeXXUGlmELqx9VNgqDfeIG4pAF9yr
	z
X-Google-Smtp-Source: AGHT+IHJ3MZYqcCV1sUwncobiSFUkCiM7cwd9lBH8dknWp/MRytwCRP+DfXxrhifqDlap4wTQdpRYQ==
X-Received: by 2002:a05:6402:13c4:b0:5cf:14fa:d24d with SMTP id 4fb4d7f45d1cf-5cf8fd2c8b2mr21770494a12.22.1732011195759;
        Tue, 19 Nov 2024 02:13:15 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df7eee4sm629003066b.87.2024.11.19.02.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:13:15 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2 bpf-next 5/6] bpf: fix potential error return
Date: Tue, 19 Nov 2024 10:15:51 +0000
Message-Id: <20241119101552.505650-6-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119101552.505650-1-aspsk@isovalent.com>
References: <20241119101552.505650-1-aspsk@isovalent.com>
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
 kernel/bpf/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 14d9288441f2..a15059918768 100644
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
@@ -546,7 +548,12 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 		sizeof(struct bpf_insn) * (prog->len - off - cnt));
 	prog->len -= cnt;
 
-	return WARN_ON_ONCE(bpf_adj_branches(prog, off, off + cnt, off, false));
+	err = bpf_adj_branches(prog, off, off + cnt, off, false);
+	WARN_ON_ONCE(err);
+	if (err)
+		return err;
+
+	return 0;
 }
 
 static void bpf_prog_kallsyms_del_subprogs(struct bpf_prog *fp)
-- 
2.34.1


