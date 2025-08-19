Return-Path: <bpf+bounces-65978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39376B2BD77
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 11:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5D16249AD
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 09:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFD1311965;
	Tue, 19 Aug 2025 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5h39Cs9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C983451B7;
	Tue, 19 Aug 2025 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596077; cv=none; b=KfeXN2tTGwKp7Q3gEQotc+N/P9Vig04TbC97aZ9Rd4G4wYsp935UriDDbrto9ba4Oc0cyZNCUSD3WzXEGeaU+JHgeblRTG8JShePnuvwnZJ6f8+aTuM/0qDcJy/FF6cnqp13s7gLymfqAN2AbByQatvq08NVHIS4glzaStaxviI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596077; c=relaxed/simple;
	bh=1o2I4/Wuhe1XU7UfkiFj8aTIHGpgQQgsuj8/ur9OlLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SvM3UnOc7etmmFH3CXY7w3n25RkbFiMEmcM7/tCSjDEkPW2g2p5arSylJyr6f3jqSUjtHTdIX6tDN80CRGX/foKTg2lL286wSk6+oVP0K3AjoHh/Ot23aoLxo3LObrENZLmJUF6vvz3uwQd/QRG63APXAz5p6Wa0oPtips84Tvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5h39Cs9; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-24458194d83so36428835ad.2;
        Tue, 19 Aug 2025 02:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755596075; x=1756200875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w8WkpEF0favtVMusKLPsWqFec66HjBIb7M3zCZDZ6nU=;
        b=i5h39Cs9crfPLOPCgcjdTkilLmr0k5o9aZQXlEDf1GWadHhghzwc/A7y2eEK3DoDb7
         U1Mj7LhpchvYG4pp33QECjK23yl8Qhzd9k3uJ+I7QqgASLv2TeHNQHOc4kx6q+tcff8W
         as29LHB1TuIHKHiueHQ85+SYhRU6Uo4eH8ZutnYUNVf1MR62f/FcXLmq3lryWcpa521w
         rTwhkLVrHtVnxAMR5YzRPTyZP1ySZTtcQOv7xytNP2o5G/5GDD170XZHwDszf/9bqDAB
         aAsoIGs6nN284r91KrKLTmaynMUb0JhKIQZ4mjWUoFujlE79kYPlkbdw87zsMyVTM5Wo
         T/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596075; x=1756200875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8WkpEF0favtVMusKLPsWqFec66HjBIb7M3zCZDZ6nU=;
        b=YMHgPAVBZNePrqeVOQ4izo4LDKH1DvSdmO4M6gwt/2KoUoqehpDaJTk7u30QpWvvwo
         ER/RCK37kv/xScWW2D18pYqsYIzFOjqda6sz0XwVM4PApLFYNWx3sckPozoF1cl7A29g
         zFu0z8eTVgOp/zWNVPUuGgwEOtsK9JRkDaiFH+mkgnzwbRF42X1rSA/MGpj84aAWD7f+
         FtziSwzBjkw3BPdL/1SIV3jXq3UzXoIFMJbdTx5MfsFh1u+GDTFx37Km4heWuV8yYrBU
         KX485TMimjHnhpX834MoA3sgfaQQW6TlwSUPzmkN09APHO+Z59gSHyVC98+COPYmwCKU
         q3YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE9Z0V40w8aEiQRTv9CbQfWFfmkQe86NsSwJ/1uB9zdZfGME7yMNezXrBYHBF4Wdta8yHg@vger.kernel.org, AJvYcCXO6aOZbcREfX8RVVxg7ikko1djJnDIbU3j/5sP1xlfE28loLGUhYy1enmIMS9gOBBNf4E=@vger.kernel.org, AJvYcCXXh+zkcZ5UEPYpkU0rPI3cgin4h7imhnJMMGZf9iCSUwL4PcuOBh9NAbspkRBsNu2ED7+Ep+G0Pk1LyG66@vger.kernel.org
X-Gm-Message-State: AOJu0Yxub0EyXNj6yL3sI5pMrB6l1mB2pbCNoORMOynsG5m4f97zdpt9
	2GXUerOyIOqIKHbf5uVhDhoYhh2PArQMpJ4dPiJZQvVJy3p9UpEdlyXa
X-Gm-Gg: ASbGncs9a1TsCwkzDh0NQD6FeF3Mulvt63oAgY7umBZugm1MGi+4Ry9nqYqiCF0JPy/
	GNmReKDYSlEXYwrGIloCO4dndJ1/gGaksa9yLDiMIDLpnB+kHRrHXDsASu401lZN3O0aYQ2rtFo
	p+A+2F7h3h/Cn6nz2nNp9HA8hBAkfLqUTBEtwxs022d+Rnd0RIcJq6HWR2PxfzxyvZ9FW2+q2ui
	F2jmU47PRVqIuPpy9MgJP6S+sshOam/lpTAl+pfYVO3FkzzbmsksU9xmgEKBHq1u7wO84rXg6b4
	afySO1okyvhk+rF3Tfjyrf3D256K0emuCSuoIBWNOGWIx6wiRBseIgtCoVYSWeZaL1G00TAUW0z
	Rg9B6nSdGA0Ke5X59Ee4=
X-Google-Smtp-Source: AGHT+IHQDaIzypbBtW89KAWZWC45E2khsB4Jv/SZyQ+9gu3U9GMlnwRQZ+iF36z+Vl33RKCevxyZRw==
X-Received: by 2002:a17:903:2acb:b0:240:66ff:b276 with SMTP id d9443c01a7336-245e0540873mr25446435ad.31.1755596074956;
        Tue, 19 Aug 2025 02:34:34 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d1314a4sm1990945b3a.41.2025.08.19.02.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:34:34 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	paulmck@kernel.org
Cc: frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 0/7] bpf: introduce and use rcu_read_lock_dont_migrate
Date: Tue, 19 Aug 2025 17:34:17 +0800
Message-ID: <20250819093424.1011645-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

migrate_disable() and rcu_read_lock() are used to together in many case in
bpf. However, when PREEMPT_RCU is not enabled, rcu_read_lock() will
disable preemption, which indicate migrate_disable(), so we don't need to
call it in this case.

In this series, we introduce rcu_read_lock_dont_migrate and
rcu_read_unlock_migrate, which will call migrate_disable and
migrate_enable only when PREEMPT_RCU enabled. And use
rcu_read_lock_dont_migrate in bpf subsystem.

Not sure if I should send the 1st patch to the RCU subsystem :/

Changes since V1:
* introduce rcu_read_lock_dont_migrate() instead of
  rcu_migrate_disable() + rcu_read_lock()

Menglong Dong (7):
  rcu: add rcu_read_lock_dont_migrate()
  bpf: use rcu_read_lock_dont_migrate() for bpf_cgrp_storage_free()
  bpf: use rcu_read_lock_dont_migrate() for bpf_inode_storage_free()
  bpf: use rcu_read_lock_dont_migrate() for bpf_iter_run_prog()
  bpf: use rcu_read_lock_dont_migrate() for bpf_task_storage_free()
  bpf: use rcu_read_lock_dont_migrate() for bpf_prog_run_array_cg()
  bpf: use rcu_read_lock_dont_migrate() for trampoline.c

 include/linux/rcupdate.h       | 24 ++++++++++++++++++++++++
 kernel/bpf/bpf_cgrp_storage.c  |  6 ++----
 kernel/bpf/bpf_inode_storage.c |  6 ++----
 kernel/bpf/bpf_iter.c          |  6 ++----
 kernel/bpf/bpf_task_storage.c  |  6 ++----
 kernel/bpf/cgroup.c            |  6 ++----
 kernel/bpf/trampoline.c        | 18 ++++++------------
 7 files changed, 40 insertions(+), 32 deletions(-)

-- 
2.50.1


