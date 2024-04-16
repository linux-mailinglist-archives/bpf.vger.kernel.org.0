Return-Path: <bpf+bounces-26926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB648A6783
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 11:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DEAD1C217E2
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 09:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953EB86AC9;
	Tue, 16 Apr 2024 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="METD/9a7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADCA2907;
	Tue, 16 Apr 2024 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261265; cv=none; b=J0AdPPXRlFH9GuJRAMWhNnc0HRVHKqNgAaX18AM7WddFZJCuplkORd+X1GqPOYK+0ooth0H4mPiNMCijdTOAVapVj8bw4wO/5KeJnU9igVFzc5J/rJPbnHbyuG2EW8Zfe346+FKLmw+8TZw+gq2UX948i3huhfBQG2RCn8cWE3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261265; c=relaxed/simple;
	bh=f6QM5JXdMDO6/yNlxDjFr/vdBADbZovxkibV/MEnESY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=I9CrDgGDayUj2aWu341ThCbXgKclZ3iETImru1/WWvNS9SGpOLnC+1wuw0tceyc6ahQ5coRLjUfnqJunxQXF+RllQH8QkPZfuD+pd1VblEzmqKTwEw8tpmHW44mqtHfUT/1FP0DBTkAcJhTpXdA/7AXhy4yau9dFERTO5grva4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=METD/9a7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e7af7eb4ccso2345705ad.1;
        Tue, 16 Apr 2024 02:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713261263; x=1713866063; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YH8x+9QSdnsXkpAcgDXkNiseSDaJMzAAo+Br2k+QtbI=;
        b=METD/9a7SN4u7xD0q87ia+BhLh+bUFe9INZqVykotDSPcBoJXgWtg9W/CdvE2ofSM4
         4bfyp/is8iD04ORPRTX1rfN/F50Oa9biIovqjL0QHrj8qgZkflWD/2xM1I5LKdsmbtZ7
         HV47JbkYL+syGZbV01d4cgnjreV77dWf3wZMsu7SyFPDk3Dpoj6IhsXOcycMJpjAczel
         2EE9DfgSILkWv5Zk+6z8EOWeG5f3SIXvDUkbz2AiYrxFn55KKib/7/irKRMQXq57LNv8
         eUmyXzbSIIMWAC0m175czl9Jvtbx8l4VD5K0M15x8Ief7gZ1b3gT/ftFqMbs/SzyhEfA
         yG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261263; x=1713866063;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YH8x+9QSdnsXkpAcgDXkNiseSDaJMzAAo+Br2k+QtbI=;
        b=dv1npbNbXi7Yokens11MkIcwRvc2rs1jLruKlU2aNH5ExhXJwrGWWrS4LLy6640VAG
         AogrPEC52baQ4vsc8Jt85q9SqmtQJniELZ0pH10gUQPBYloDxvExDD1PxYt7wZutDMpQ
         ATbOqtY+tZr7OwgMfH5HkdXniYgLLqEyZAw1Xu0d6fpy0iZKK8NPHggd10ZpQ+zcmxue
         JJXaFQ+DFQtRkg4QBXodhD2nLEhxnWcw71fXMHWLPs6vYhe3fYd9kWGRw+R7F/7kBpQH
         m3TO3E1DEk1tRYbA2oCVLPZ7t06ounLuItiMXgwJ1FpbdZDZ8AVu6islee5TujoTJTI6
         0lug==
X-Forwarded-Encrypted: i=1; AJvYcCVMqf7+iNrz9aVWHavP65J2IXHZhkI2MIYJr+bEZm1kCd6Pw5G3sPmwVXrOE7xN6DgfX1gjAexlFzGjgf+LO/4uXxxu
X-Gm-Message-State: AOJu0Yw6CtJp1g2pJM3J20oHWLerw9qwRPqe5rAGzSNf5weGqOzwfmjD
	o26xVqY2chMxOL7yJuUzhNxRVrU28poQn3ROcbz8c3wjMn7VEbhHTkoNc4+XUQk=
X-Google-Smtp-Source: AGHT+IEv9o0nxF3QYyj2CF43eErkchMVPMhJclik0hZqlokvYElxVQFkXN5zNjwWD043eNfq+gRV9g==
X-Received: by 2002:a17:903:32d0:b0:1e4:3299:2acc with SMTP id i16-20020a17090332d000b001e432992accmr14475895plr.3.1713261262893;
        Tue, 16 Apr 2024 02:54:22 -0700 (PDT)
Received: from localhost.localdomain ([111.194.45.84])
        by smtp.gmail.com with ESMTPSA id kf13-20020a17090305cd00b001e29acb2d18sm9393087plb.4.2024.04.16.02.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 02:54:22 -0700 (PDT)
From: Zheng Li <lizheng043@gmail.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	jmorris@namei.org,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org
Cc: James.Z.Li@Dell.com
Subject: [PATCH] neighbour: guarantee the localhost connections be established successfully even the ARP table is full
Date: Tue, 16 Apr 2024 17:53:43 +0800
Message-Id: <20240416095343.540-1-lizheng043@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

From: Zheng Li <James.Z.Li@Dell.com>

Inter-process communication on localhost should be established successfully
even the ARP table is full, many processes on server machine use the
localhost to communicate such as command-line interface (CLI),
servers hope all CLI commands can be executed successfully even the arp
table is full. Right now CLI commands got timeout when the arp table is
full. Set the parameter of exempt_from_gc to be true for LOOPBACK net
device to keep localhost neigh in arp table, not removed by gc.

the steps of reproduced:
server with "gc_thresh3 = 1024" setting, ping server from more than 1024
same netmask Lan IPv4 addresses, run "ssh localhost" on console interface,
then the command will get timeout.

Signed-off-by: Zheng Li <James.Z.Li@Dell.com>
---
 net/core/neighbour.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 552719c3bbc3..47d07b122f7a 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -734,7 +734,9 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 struct neighbour *__neigh_create(struct neigh_table *tbl, const void *pkey,
 				 struct net_device *dev, bool want_ref)
 {
-	return ___neigh_create(tbl, pkey, dev, 0, false, want_ref);
+	bool exempt_from_gc = !!(dev->flags & IFF_LOOPBACK);
+
+	return ___neigh_create(tbl, pkey, dev, 0, exempt_from_gc, want_ref);
 }
 EXPORT_SYMBOL(__neigh_create);
 
-- 
2.17.1


