Return-Path: <bpf+bounces-58938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C88AC408A
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 15:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4193B8B1D
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 13:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DB620C47C;
	Mon, 26 May 2025 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmhEB+e6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73C7146D6A;
	Mon, 26 May 2025 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748266468; cv=none; b=Rs1WcRwtnglWAzk2/8kPj46LnnoAB4SnwnEMf8JHOwhuOcDTPMgGZ7sLvb3afy8r2jXk4s5oYjOgwHmZI1b46hQdf8D0NWSUG1J2m4vdQlZF6Ikv68zNTvrh1Kn4SFa3wFo5kx1MMJAZVJIsS6ImRaNV75EiSXSVP05ovysr+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748266468; c=relaxed/simple;
	bh=qhrCIuJfCgtFHj5KiNLN5GJLj+0rGePeLKxNcZ4fmCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JCgHQ0SGItvFAazTLaSj1E3hFDAbi/agWLpvVuCcZAmuKUBjdPRcRl2CuYH5cJ35MylA77WR9TraPBh6V0qKVgXCrcYh2SBl4z31iK5Dwx96fjKqJrXAh9BcAbOD9I/Ss5ulIcRQt4G6NYRx00CEt8srp7eGXnslM/CbsyaT+j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmhEB+e6; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b26d7ddbfd7so1816185a12.0;
        Mon, 26 May 2025 06:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748266466; x=1748871266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ngc4VpTkrME/fr8UZiSjHCagVYDhOl50g32sIOmEbQE=;
        b=ZmhEB+e67ecTZxWpL93p/W4yUpPDg8fAknF4YcoO76Mt8UCKEdmQD8qsI/eVy7j2zy
         fkrQjZfqvU5/W1Nz6hu9df5eBXJs6lI4J8cVpQr5cOnf+ee/y+7Gz4pW9wdgwjQ8WOeA
         9h+7m7IkQtP0VrAeoqMzQWjgiqfPDXqIfi7FtpO6Wi9tsr1LKpa0RIcGpmz99ODZyCw7
         pk9QEYxjybayn6NKGo7EifR8X7kdyobc/5t0vZKvPMLS9pSZiCiq0tpGb0sauYxm10DG
         GR5+3XFSo+g2+oQBFSc1P8n+49oCewe2J7v6v/Kpa2ufAKGabOraPmv/WQSoz5smWWPI
         I/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748266466; x=1748871266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngc4VpTkrME/fr8UZiSjHCagVYDhOl50g32sIOmEbQE=;
        b=nVAa33+Y5yzU38CGqmfFaGS8mBnrq447L8gp5N/YKh221xuEQnnIWKdgcJdMUN87zd
         2lKAasFrd5OfzUp340zdjVvtPKgJUIEzFQSrl2G+6LD6/24lGvGQfOZWkKPx3ZXObSVY
         BRkmcG+jwvU6aVudR5MBf8xK4Q+rSmUQtUm2ggMRgbO8X8MGuXMS50vrn5iACEY4A+68
         mZwdQpnXyXMKeqLRRz00hu9Uta6QmvSOcvz1/FUwvWFfL/NoYh2m0OwozlXURL47gV1b
         NFiTfiP/OkmNRtz6YvCXv4c5O8ru6nD5jWIXy+NzTJY+WurvH2eInhrS+Jt1X6Sau+NX
         IEmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAVOQjBj5Mvt8x9vayITiA8V8k81ybWN7GUN+QgHmBoUXuwxs46HmpBIjkNL2yl0rE7gt1y2fRk8YLmuW4@vger.kernel.org, AJvYcCWV+kEyfFnmUqK8H33C/8QOYkADZyLPoc/RHtnMpbmY5nc0bkEkZutv2/Z2V1cSs02x0Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXlunrpbA435PRG4DkPkNDwQvdoU1nVaw1GovDohOoQa6KuhDf
	vf/6+p4ebrpCtCxL2NjdX5RP+2q0E/oH2SUY2Ut+pHU1V+4ezypWTEOs
X-Gm-Gg: ASbGncsAJlej33FIP+/zh5+AuDIA5NnFORmkrh+yP/UvHziMV9Q/hBo+v4f7I4FrndA
	btDIUHctBxGV1cp/5B9jfwWo8qzRLOb2TfvwFbWguOOekjitOwvH8dvw+5tb7Y00KXyo9VCtTbI
	JG2e9DleVXRbztYJ/800gnmh3wVHsbaDbFN7kWdCTPBHWWMcDSmO/PzP9tnAtz6e4FX0AG4PMkM
	ILvySrk02YPmLR8gdkmZ05sFUfVv3kqiKR9CxL3IkxLhWN+KbYyJmgYxHFveHUs3yi6RDwRBhHL
	HPcDFecFQj+EqF5iYzOKDU2aRejKfi5uvh+0DUtJkZf5gd+CNQCd3LtvUCWL
X-Google-Smtp-Source: AGHT+IGyAmPwSMTNHXY0kTjb6BlknJVArRxTnQ92Il2y1saRh77jOwe6ylD8no6hccaJku8KIIW9Pg==
X-Received: by 2002:a17:90b:1d51:b0:30e:9aa2:6d34 with SMTP id 98e67ed59e1d1-3110efce72fmr17525256a91.0.1748266465900;
        Mon, 26 May 2025 06:34:25 -0700 (PDT)
Received: from ubuntu2404.. ([36.24.59.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3112292c391sm4187402a91.0.2025.05.26.06.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 06:34:25 -0700 (PDT)
From: KaFai Wan <mannkafai@gmail.com>
To: ast@kernel.org,
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: KaFai Wan <mannkafai@gmail.com>,
	syzbot+0903f6d7f285e41cdf10@syzkaller.appspotmail.com
Subject: [PATCH bpf-next 1/1] bpf: fix WARNING in __bpf_prog_ret0_warn when jit failed
Date: Mon, 26 May 2025 21:33:58 +0800
Message-ID: <20250526133358.2594176-1-mannkafai@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzkaller reported an issue:

WARNING: CPU: 3 PID: 217 at kernel/bpf/core.c:2357 __bpf_prog_ret0_warn+0xa/0x20 kernel/bpf/core.c:2357
Modules linked in:
CPU: 3 UID: 0 PID: 217 Comm: kworker/u32:6 Not tainted 6.15.0-rc4-syzkaller-00040-g8bac8898fe39 #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: ipv6_addrconf addrconf_dad_work
RIP: 0010:__bpf_prog_ret0_warn+0xa/0x20 kernel/bpf/core.c:2357
RSP: 0018:ffffc900031f6c18 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000006e000 RCX: 1ffff9200000dc06
RDX: ffff8880234ba440 RSI: ffffffff81ca6979 RDI: ffff888031e93040
RBP: ffffc900031f6cb8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88802b61e010
R13: ffff888031e93040 R14: 00000000000000a0 R15: ffff88802c3d4800
FS:  0000000000000000(0000) GS:ffff8880d6ce2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055557b6d2ca8 CR3: 000000002473e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 cls_bpf_classify+0x74a/0x1110 net/sched/cls_bpf.c:105
 ...

When creating bpf program, 'fp->jit_requested' depends on bpf_jit_enable.
Currently the value of bpf_jit_enable is available from 0 to 2, 0 means use
interpreter and not jit, 1 and 2 means need to jit. When
CONFIG_BPF_JIT_ALWAYS_ON is enabled, bpf_jit_enable is permanently set
to 1, when it's not set or disabled, we can set bpf_jit_enable via proc.

This issue is triggered because of CONFIG_BPF_JIT_ALWAYS_ON is not set
and bpf_jit_enable is set to 1, causing the arch to attempt JIT the prog,
but jit failed due to FAULT_INJECTION. As a result, incorrectly
treats the program as valid, when the program runs it calls
`__bpf_prog_ret0_warn` and triggers the WARN_ON_ONCE(1).

Reported-by: syzbot+0903f6d7f285e41cdf10@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/6816e34e.a70a0220.254cdc.002c.GAE@google.com
Fixes: fa9dd599b4da ("bpf: get rid of pure_initcall dependency to enable jits")
Signed-off-by: KaFai Wan <mannkafai@gmail.com>
---
 kernel/bpf/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a3e571688421..c20babbf998f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2474,7 +2474,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 	/* In case of BPF to BPF calls, verifier did all the prep
 	 * work with regards to JITing, etc.
 	 */
-	bool jit_needed = false;
+	bool jit_needed = fp->jit_requested;
 
 	if (fp->bpf_func)
 		goto finalize;
-- 
2.43.0


