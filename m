Return-Path: <bpf+bounces-45876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD88E9DE77B
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 14:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B695C1647AD
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 13:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1982619E82A;
	Fri, 29 Nov 2024 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="YwVW02Uz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1632619C566
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886762; cv=none; b=pgj9/3C+hkcw1MZhFY5gicR9EveetRvjcgvMCy8b/V0Ut/PJy4Tj8F6njt2vQUFf3mxPzn8DRcs2/1xFJTe/43kYS0G5wHhnRNEfGzI/KU/d975ysgCz5OS2+NH5x65BGMXSKJrLd7Rya40dhxjgfXPy9NHw03hLqW/6dxVjndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886762; c=relaxed/simple;
	bh=N4fVQPXJXo2Th6B1WGHku4ZK0MSeXujnBW5iXtm9jAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QB2lhiNrIftXxcsv5+2WFtT1DFlcRqsHcZ6dWsv9JVvb0gJPO+KwSMuIW1kJKCWgtZmWStER83r+YjeL4cI4UuGqOYpVRfuDZmRvlHJn4BCpSo04ExYbMyQ/Qe5ImCug7Pa82NXUjhcMBp8DjKGxj/d3FW0shUsZkvBs5Ky923c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=YwVW02Uz; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d0062e9c80so2294704a12.2
        for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 05:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732886759; x=1733491559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/uCtoS5e1shwI4lkh3m+//bTjTAkVIgPynZLquHrvs=;
        b=YwVW02Uz/MkrSA5ohuiYsFo0wwwPsGl3Fvi+ZEtB/qon2P1UMaXWYXDjXwYKYcoYmU
         NHraJTKJ7AVnEzXi7/7x0YPaz/g1VefkQb29MKX/oFd1Vbpnla/6t1RS2zTWUS1pZNnn
         1UzUy3Szq3Q5Mc0HwzuaFfS2jwUjX9sL5WzWz1z0gol9S7VCdOJvYLXNnUJD+V+wpcgE
         BeG/7bj4jz2q3YREpDw/yOmoKBGvNeEvVt5RZH+JUYFZtbEXbckVRd8cBlTWF05FzDyw
         0N5WrtQBD9cj8gBFRsGpYw1QBuT49oRy++Ev5YiYaft8wgAwsr1LDYpriFSIqIWhax+H
         Ix8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732886759; x=1733491559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/uCtoS5e1shwI4lkh3m+//bTjTAkVIgPynZLquHrvs=;
        b=g6GQ/TKeaP7Sr4eBm/zwA4a6Wlz8MxOl5rAw4EuCySwyZwBapnrilP7nLG0MBT8QI8
         Kg8qzCyfKO2zM9wOwt/04o7IAD6cbtlh/UUc421p6mjSFhkdh7SKGjDHWf+OhI5WU86E
         f+8ge8dU16S7+s9QO7alWfaazhjyz1zrVq1Z196S2z1FeO2gsDDQPwp4j0sUuoq759hW
         qY0TmGbQ7TlmTk+yO51qv0jHBbl4qwq/E5/GJDYnssqj2b5faztriD7KJvYpqwztWm9E
         SY0cu0axwuuvOLqVs5trTb63GzZIytjhgXsUXpFiXG4sz4JA1yfh2PAE0f9v+68mASRW
         EJwg==
X-Gm-Message-State: AOJu0YyPG/8OL7kUNjEEGFM0MjcZdwf1VyE0QYXGmb0f9oSN9/izc78A
	0+a1IeVzqdvvu5dJbqQZkNytJVhPplErgLDEv61tn5jG6x2dZDvm+vjAtSQ/28t80DkxAqIt6wI
	5
X-Gm-Gg: ASbGnctgWxVdLbl8uO/ndN4ty8IwF50zVGvkz6lINr5ahuM+ysvdYA1etCjPHTVkRHi
	akSWaUHO5xQ/QR1D1RpoPS0N0VP3YrHMGO7UpLvGRk3TNLzGcex3/gdXeLApNxL3zh7j28aRkVP
	dDMzZHAy+uaBI4u5U3c5qg44Dg6tt+iF0NwJm2tgZK1Ig5hbpmx9Aot4t0PgH0xEZTu78C+fH4Q
	JGCbLJVo2IP4UY80zPuUvDxfMvRSc4uWpFFiVDoauhSG67mRFskUWMlfGH7uyA=
X-Google-Smtp-Source: AGHT+IFsJu8f4czyvQxnVGXKoGjlPhxC1a5uCdNKPpAQ7SOIAxTb9P03gtVrYjbU4IAzKr5XRl21ZA==
X-Received: by 2002:a17:906:4c9:b0:aa5:33f0:c50e with SMTP id a640c23a62f3a-aa5810634b5mr867375666b.57.1732886759195;
        Fri, 29 Nov 2024 05:25:59 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599904f33sm173295066b.135.2024.11.29.05.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 05:25:58 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v3 bpf-next 6/7] bpf: fix potential error return
Date: Fri, 29 Nov 2024 13:28:12 +0000
Message-Id: <20241129132813.1452294-7-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129132813.1452294-1-aspsk@isovalent.com>
References: <20241129132813.1452294-1-aspsk@isovalent.com>
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
index 14d9288441f2..35a306ce9d94 100644
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


