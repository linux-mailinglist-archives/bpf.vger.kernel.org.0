Return-Path: <bpf+bounces-31154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AEE8D7777
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 20:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862D81C20A11
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 18:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381B76D1B5;
	Sun,  2 Jun 2024 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LstfUTUH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ADE39FDD;
	Sun,  2 Jun 2024 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717352840; cv=none; b=soOFBSjEJM2FacyASRzfwh0OnfwL1IpkUrlpWoNOQ+YqQ/JqVZQHiEBSXdo3FLHDAdxFMNST+b5ElI0/GcgJ9F6FUnoswrPI6VdJtd7PFdA5mzzbKzezuELEfXP68kd4yctDMt07LgdOJHf/3EX0n5YCnegyV8aQqJohnK8DQS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717352840; c=relaxed/simple;
	bh=OlfH/fy/yrVPChwsu+/wusMIhTqj5QvM8psAgNsK0eY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K/ly8iZXkfKy/hALBAN4QAjMH476no/UulPuTagB2EvI6oFI+ji3Yf8KYoviE+8QTu5O70+F6LITVbIVQ7NJTC35lQbDd8suKcXEHDfV7pjPVyNwLhCeX+cA4GykBVNdnyA+3E6Xb54rsRzPMnvny/0GyNk2GQki1pNfhCEbL00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LstfUTUH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70255d5ddb8so845305b3a.0;
        Sun, 02 Jun 2024 11:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717352838; x=1717957638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cz4RbsfTPwYac1XpECU+5e1PfNtGMLY5PUzwpA6s3+Q=;
        b=LstfUTUHLlrvQH3EH24FjRuA4+LvOFVVyVZTcLWe4Tz/iGQi8fEwaP83xPVpMu1IJk
         9A++o0FI2+Bf8KDkZOeZPEIKre6gso69Doi+lbgt01HyID4SltkQyWslZtfQ4sDnz00f
         dVIpf5DB502S01wgR9Y5vWw7YwsfGNgX4jR8sErdRU4jwl35LWGPM5nU8oC3eP+ZMTt6
         caUwOgkC9GylfyiZeYn7bkiSTSwwiQecHhmlpLvsrNbWlHWL+rw9F/RjZJ47XQourOMG
         dyeGlZQK0ZI3WPPlPnb4AQJL6Sb9ijA/xLq0ex1+cgNJnN9R42Yp2FlQBupo32E1yZX5
         Tb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717352838; x=1717957638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cz4RbsfTPwYac1XpECU+5e1PfNtGMLY5PUzwpA6s3+Q=;
        b=Eq6QOkwvnaO2hlxgSzIHLe5FpVDKbMusB+TCw7KQo1OPSMLATdvpKH/u9MYqfNWbCI
         HtzbHL5KAA/QxQ1tdQn0hjZtZZ8MZfsorZ8omJcWqdBBPDCM+dcv/2c31yPNwA8lC2/Z
         me2uI3H74ycDAz5WVFYNHYf4od0cXhWXjmHi8eututTyOmGnYe/x39Bh+DzVHxyfL5kz
         XJzYUYvVXPErNnb4xSGfMyK2BLlSWdFlZAgZGzK9w+FDPA9jnpFONlMiH7JVGxMliLWA
         5BOBa3szxyQAipTPEjA+tW2Rb9gJlwy9STa9xLS3SrJRDHVLtfakrG61AkUXnYZ1FNJS
         IHUQ==
X-Gm-Message-State: AOJu0Yx4godYR5tnlno+dgaVN0W0MftSTAP+HtIaj74d0pKFUEc0T5US
	oZrHC0xRIPwQv0Nf/zLIE6mzbJTX2ONtJflYaaQkCnLW7Q4p+pB8VFTfxQ==
X-Google-Smtp-Source: AGHT+IHfcjaBCK58T8HD+hNvaaffVC3TQmTmd0kTZWY2jqIb2/tRw4wrWTEr9/w8bkUflBqJfw7XKA==
X-Received: by 2002:a05:6a00:9283:b0:702:5f69:54e0 with SMTP id d2e1a72fcca58-7025f695787mr3866593b3a.14.1717352838115;
        Sun, 02 Jun 2024 11:27:18 -0700 (PDT)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:ca2c:f1d4:4d:74a3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423cf27fsm4387564b3a.12.2024.06.02.11.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 11:27:17 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	syzbot+1989ee16d94720836244@syzkaller.appspotmail.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [Patch bpf] bpf: fix a potential use-after-free in bpf_link_free()
Date: Sun,  2 Jun 2024 11:27:03 -0700
Message-Id: <20240602182703.207276-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

After commit 1a80dbcb2dba, bpf_link can be freed by
link->ops->dealloc_deferred, but the code still tests and uses
link->ops->dealloc afterward, which leads to a use-after-free as
reported by syzbot. Actually, one of them should be sufficient, so
just call one of them instead of both. Also add a WARN_ON() in case
of any problematic implementation.

Reported-by: syzbot+1989ee16d94720836244@syzkaller.appspotmail.com
Fixes: 1a80dbcb2dba ("bpf: support deferring bpf_link dealloc to after RCU grace period")
Cc: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 kernel/bpf/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2222c3ff88e7..d8f244069495 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2998,6 +2998,7 @@ static int bpf_obj_get(const union bpf_attr *attr)
 void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
 		   const struct bpf_link_ops *ops, struct bpf_prog *prog)
 {
+	WARN_ON(ops->dealloc && ops->dealloc_deferred);
 	atomic64_set(&link->refcnt, 1);
 	link->type = type;
 	link->id = 0;
@@ -3074,8 +3075,7 @@ static void bpf_link_free(struct bpf_link *link)
 			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
 		else
 			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
-	}
-	if (link->ops->dealloc)
+	} else if (link->ops->dealloc)
 		link->ops->dealloc(link);
 }
 
-- 
2.34.1


