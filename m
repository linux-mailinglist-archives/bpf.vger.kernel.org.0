Return-Path: <bpf+bounces-51818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97529A3973E
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 10:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378EF3A4430
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 09:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B686F22AE42;
	Tue, 18 Feb 2025 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="bo0MnArw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632C22E40A
	for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871081; cv=none; b=nrAF064KJ4Qey5OJY3RW5kwdGikXaPb71j5XYYX9ZIZdSL4vOyBwj90Gex4E7XcYBzIY3RLpKJOLyYb1kUBKqpgUJKMSMqzWsPOVEEYFrb3KA28heVuVKyfU2iz3SncrwFqQ4/hvuXgLOhCybP09CQNtcuQBB4cXts4rrVLoZY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871081; c=relaxed/simple;
	bh=0rIVfHmYuQu9C9n6fSuBux4N48W3Eya9ljX0NehI/2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AGsECjRb+eKq2CTrcp7U8Vv/cAL6SYxXrCON2L6cMNtVrio1VtR3/7emvF77OpB2RemoJMyeY7m8kY+Qg5h1JiX7trNBF+eSULmdLwDEdOjEma0n5q+24xvjQSnD8kRQramnQjEfTey8RifL2pAiyA0Fi4NE/M2a8COQkTr2w8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=bo0MnArw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220d601886fso67788815ad.1
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 01:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1739871079; x=1740475879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4vEq8YuYjX22iCTkqp+KfcdUrp/BGM6LiRx05Nkkmug=;
        b=bo0MnArwK00ew/TJ0A8F410R2oxT03a14WYuEv8DUIi0dRD97WsZb2wLYNJwH7KYAN
         qMUXZdWpAdNwiuZtOb7vt6D2dRS16JTYDGGwohh3q1U2yeKNqSROGX8r9SwKhQnw5jUT
         pGbPfS1dnkAfpQyD1uWwbHvfGmhlf/j4fVOHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739871079; x=1740475879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vEq8YuYjX22iCTkqp+KfcdUrp/BGM6LiRx05Nkkmug=;
        b=XGRSch3mpEUX+qfg/uDd77uoaqrB6bUhnGVk771Zp5qS3cygOeC80q5x03NVyoCtjG
         Fx+oOzUXqctd9giwIit9eOG095gV0Kdfy2ggmBAfqRlBb+856EzY0yTg5HGrzbPO1lPd
         H8u2rqPvCMwI/Tw/oEhKpss+qe6jqSzu11TFBvbUtDss/6i7bmnNuqqlKM/GrGsiSuqn
         s1HY72YbnDmA1bCyFG3B/zgKiyARZMqZXphJYT9v6jZuzLqkANcy0Lrn1ttiaV65kNvs
         yilxwPukDuJg0brDPk1almh8NeZa7z8jvXcAT8tM/L6F7vvLPka+c+iZ8u7Ry2G8yvgu
         5zfA==
X-Forwarded-Encrypted: i=1; AJvYcCXxq8QEqZ7NG6aE0svhgSe52cPAE7KdxEH+hXR9o4eXa/ECaF7aurlirS2CUm/sERcRGoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwcnycOt/OumHto2e6s6zXZjkxinfkIMqdJKlE3hIgfPPkHbSZ
	7F6P9U+Fu1MBkpCXKEALD/1AogFSi61/FB2Bqm9dUpXuv2kTX8k01JNh853eDe0=
X-Gm-Gg: ASbGnctM2HR2yHFee1Z5osP9ut6lJ5HjjOOy+fvAfayL0nNOrF2z6wuc+5yCp40FRCQ
	n9/I8wW+mp7dWWvYvzIRvhBhmjSageuVvsRieK5FeIQCDw7VN9XTQhPhFnKjDIVx98aTxoRT80F
	FI6PG8eRlwKP2rtvBCbzLMHeVM3PTSIteFmymk6Q7kE06NfT87fdUgL5kNNidGRzRydmjuW0E5U
	1c6AkYUSZBX7e/tM4Avzam/w1JnFlx4UsaRfM+AiL7lTmMeqt7DA8cXTYNJkeZ8C21hBZx2mAfq
	UJx/heLsYPnaItXXqOY4sCoyvZ7ccSiXGl15YA==
X-Google-Smtp-Source: AGHT+IHUE9nU+fRd16ZYqzgrHpEIwCDcbVGFHsFT6spVA3Z3lPynZct4p6JRRFUjv+p/1xpa6jqxoA==
X-Received: by 2002:a17:903:1ce:b0:220:d909:1734 with SMTP id d9443c01a7336-22103f16a3emr196281465ad.14.1739871078757;
        Tue, 18 Feb 2025 01:31:18 -0800 (PST)
Received: from localhost.localdomain ([154.91.3.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ba819asm9535522a91.41.2025.02.18.01.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 01:31:18 -0800 (PST)
From: Chunjie Zhu <chunjie.zhu@cloud.com>
To: Bob Peterson <rpeterso@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>
Cc: Chunjie Zhu <chunjie.zhu@cloud.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] fix "NULL pointer dereference in gfs2_recover_func"
Date: Tue, 18 Feb 2025 09:30:03 +0000
Message-Id: <20250218093003.41966-1-chunjie.zhu@cloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  During gfs2_withdraw, sdp->sd_jdesc->jd_inode might be NULL, in
  gfs2_recover_func, we should first check WITHDRAW flag, then do
  gfs2_inode and gfs2_sbd variable reference, otherwise, we might
  run into kernel panic

  I/O error, dev sdc, sector 125744 op 0x1:(WRITE) flags 0x4200 phys_seg 4 prio class 2
  I/O error, dev dm-1, sector 125776 op 0x1:(WRITE) flags 0x21800 phys_seg 1 prio class 2
  gfs2: fsid=xapi-clusterd:760b13b0-d513-03.1: Error 10 writing to journal, jid=1
  I/O error, dev dm-1, sector 125744 op 0x1:(WRITE) flags 0x0 phys_seg 4 prio class 2
  gfs2: fsid=xapi-clusterd:760b13b0-d513-03.1: about to withdraw this file system
  gfs2: fsid=xapi-clusterd:760b13b0-d513-03.1: recover_prep ignored due to withdraw.
  gfs2: fsid=xapi-clusterd:760b13b0-d513-03.1: recover_done ignored due to withdraw.
  BUG: kernel NULL pointer dereference, address: 0000000000000028
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP NOPTI
  CPU: 15 PID: 614 Comm: kworker/15:4 Not tainted 6.6.22+0 #1
  Hardware name: Dell Inc. PowerEdge C6615/0V93MP, BIOS 1.2.3 12/19/2023
  Workqueue: gfs2_recovery gfs2_recover_func [gfs2]
  RIP: e030:gfs2_recover_func+0x3e/0xb90 [gfs2]
  Code: 89 e5 41 57 41 56 41 55 41 54 41 52 53 48 89 fb 48 81 ec 70 01 00 00 4c 8b 77 20 65 48 8b 04 25 28 00 00 00 48 89 45 c8 31 c0 <49> 8b 46 28 4c 8b a0 70 03 00 00 49 8b 44 24 70 a8 04 75 0a 49 8b
  RSP: e02b:ffffc90040acfcb0 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: ffff8881047a7a68 RCX: ffff88821a7ee9a8
  RDX: 0000000000000001 RSI: 8080808080808080 RDI: ffff8881047a7a68
  RBP: ffffc90040acfe50 R08: 6264715e31726566 R09: ffff888103df9400
  R10: ffffc90040acfe70 R11: fefefefefefefeff R12: ffff88814a0a9600
  R13: ffff88821a7ee980 R14: 0000000000000000 R15: ffff88812b300eb0
  FS:  0000000000000000(0000) GS:ffff88821a7c0000(0000) knlGS:0000000000000000
  CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000028 CR3: 0000000153dfc000 CR4: 0000000000050660
  Call Trace:
   <TASK>
   ? __die+0x1f/0x70
   ? page_fault_oops+0x159/0x440
   ? search_bpf_extables+0xe/0x60
   ? srso_alias_return_thunk+0x5/0x7f
   ? fixup_exception+0x22/0x300
   ? srso_alias_return_thunk+0x5/0x7f
   ? exc_page_fault+0x6d/0x130
   ? asm_exc_page_fault+0x22/0x30
   ? gfs2_recover_func+0x3e/0xb90 [gfs2]
   ? srso_alias_return_thunk+0x5/0x7f
   ? xen_extend_mmuext_op+0x1e/0xc0
   ? srso_alias_return_thunk+0x5/0x7f
   ? srso_alias_return_thunk+0x5/0x7f
   ? update_load_avg+0x7a/0x720
   ? srso_alias_return_thunk+0x5/0x7f
   ? pmu_msr_read+0x38/0xd0
   ? psi_group_change+0x152/0x3d0
   ? xen_mc_flush+0x15f/0x1f0
   ? srso_alias_return_thunk+0x5/0x7f
   ? srso_alias_return_thunk+0x5/0x7f
   ? xen_load_sp0+0x33/0x80
   ? srso_alias_return_thunk+0x5/0x7f
   ? srso_alias_return_thunk+0x5/0x7f
   ? finish_task_switch.isra.0+0x85/0x240
   ? srso_alias_return_thunk+0x5/0x7f
   ? __schedule+0x3a8/0x1330
   ? srso_alias_return_thunk+0x5/0x7f
   ? page_counter_uncharge+0x2f/0x70
   ? process_one_work+0x168/0x310
   ? __pfx_gfs2_recover_func+0x10/0x10 [gfs2]
   process_one_work+0x168/0x310
   worker_thread+0x2f8/0x410
   ? __pfx_worker_thread+0x10/0x10
   kthread+0xcc/0x100
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x30/0x50
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1b/0x30
   </TASK>

Signed-off-by: Chunjie Zhu <chunjie.zhu@cloud.com>
---
 fs/gfs2/recovery.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 5aae02669a40..44806513fc06 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -400,9 +400,9 @@ static void recover_local_statfs(struct gfs2_jdesc *jd,
 
 void gfs2_recover_func(struct work_struct *work)
 {
-	struct gfs2_jdesc *jd = container_of(work, struct gfs2_jdesc, jd_work);
-	struct gfs2_inode *ip = GFS2_I(jd->jd_inode);
-	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
+	struct gfs2_jdesc *jd = NULL;
+	struct gfs2_inode *ip = NULL;
+	struct gfs2_sbd *sdp = NULL;
 	struct gfs2_log_header_host head;
 	struct gfs2_holder j_gh, ji_gh;
 	ktime_t t_start, t_jlck, t_jhd, t_tlck, t_rep;
@@ -416,6 +416,11 @@ void gfs2_recover_func(struct work_struct *work)
 		       jd->jd_jid);
 		goto fail;
 	}
+
+	jd = container_of(work, struct gfs2_jdesc, jd_work);
+	ip = GFS2_I(jd->jd_inode);
+	sdp = GFS2_SB(jd->jd_inode);
+
 	t_start = ktime_get();
 	if (sdp->sd_args.ar_spectator)
 		goto fail;
-- 
2.34.1


