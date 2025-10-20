Return-Path: <bpf+bounces-71437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B331BF2DB3
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 20:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4731318C1630
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 18:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8222C21E6;
	Mon, 20 Oct 2025 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfowxnnA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B14F28DB46
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983567; cv=none; b=hGPu+QCs4r2MSRtvRZ3BkmJ/pYSDDj2P9fPEX4a31yCAlWOXaht0xZ9RRPXk00Pcd+Iggfs0fz/g5cMu+XC+DJUIEyaDGk9HSjZJrOwFl4MAsiT65Kbh01T23IgbpKGQDWXEAFkhxniSd06HDXqJx/oGR4wC+lHFgF6rxxG04TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983567; c=relaxed/simple;
	bh=7KTD0uaFcyyq2og31+9WBkzgxxC3y7RTURPIR1fnqTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFBUItN3k1vn57HbQkz5QgqMbMbBeEu65Q/j3puXMw3KQIMIIfGbmY6dc7hiqe87MB68zTKevXusDnvLH5gfhWJFsJGYRQgQO6dxcR3DXpFlPGH5Sdk/g8fTkKMIT9RtXlfoadAvLlY135qlto5i3o8auw4YtN5BtOEaQzd6kjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfowxnnA; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33d896debe5so2282844a91.0
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 11:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760983565; x=1761588365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScPigvONXCfVvbrizpOVQT4h67dphCjzneWDHaO1018=;
        b=UfowxnnAN+dJTIK7VQHC3fNAY7OoPwnB6VbGE+CghC5t62xpaaFeCyRqoC9GvD8Z4x
         QaOpthILzLuAzQrA5EH28it3NMi+gR7Xqv6nP7ucrYfbIGMh8cf/+LhPWjM9Kgr4z7ZQ
         SolVwXONM39ZkXnKU6Gm7a7pFArsmT10a+AMsY4KYRYlhOzDsO+hEpG5HIEBVFZUgeZk
         qbgLxKUQ9cNestJlTLeslQM8mRdEfdRoAlaX9EcupNiMGmNVnr8ODe9rTp21wxQOjkw5
         5F5FD2WuQq2/AVjXk4xSu2p31tYOWUEjbgz/basC1OW8AnoZ+xOcdtlImLwtwMfuDSOb
         0Ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760983565; x=1761588365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScPigvONXCfVvbrizpOVQT4h67dphCjzneWDHaO1018=;
        b=A1f8Q5VAs/PCFSsApuYwg5fTiinzfbKhYH8peW35CT2tjuAqTPOaQv4tNfyzcDYw/A
         /zga1TR7RtpAOunxjcsTwV/Jv0OxzTtTdmHtkM+wtFX5HFWtY5wunjsl7OEJQ+45HpOT
         r41ZhgCHDNwG/ZndncrbbMdVKYXYmIVHauETBYdBHnI1pzp3cqHEyF+2tFiE+WFnEw3F
         ZLm12VJ0xM1gz3fa5Isup8mf0ft31y9/sJr1t0LqABG2Snt6CwwYe/WBwD4JjJ6aoTp2
         0sXzka3SH6IoCvmzkgUAAnsyH4KST0/kiGjp3IL2C3J8EH82LXKOxxj0ZBw1yFlBOPEv
         kLVw==
X-Forwarded-Encrypted: i=1; AJvYcCXiCDDEyhNOUFOP3PVCDMmvlZyZsDJwBiW/og27uUY7pQc3LjbQ1RlfzZcoQK0glOa/sHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm4+nozBaMYMtNeXCBZlvLY+kBp3X7Rz78gr6RdxuQaBw95vTQ
	UYwZVzMqK9fH/RNNQwF+lnukUpQE8rJpX9RXtYKTpkyzgCCOlteuKIoK
X-Gm-Gg: ASbGncv2BL2Dy1pMiTjD5xkdIHJgPbWfRRiU04mkF4fYTKETDHl7qQLysilYZSbpA8V
	vODh2rXh66BuTsxUtHlbMIpPFB6JpuC1HOKRi3yOyX+BpfHQ1VfjR8ThGpFGqSPwubVD9yseCEO
	q+magiPKXaeDb1zlRD8Debk5a0uX+jiDlGldIpdVigkp7eN6WLG5yy7gUv2LiOGdhyqXjA4s3K+
	Bu/KnlVouU56BE+CQJ/pkzhB2S79T6BmY6/dfndB2/m2cfVrN7JVJbXj43HDpULkjFGR3rAopvE
	DswfEBQkj7SFXWLbM1BzrDPTj/u+Jpk6GuNe/bA7RjaPX4s6kTUfwyC8uzGjIH7QBN9cCddnOiD
	K/bWd9E+Nslvcbi/DeAQeyOLANezQWB2oi/SoPCBu1Bjb/TM7fdn3OyNBNS69W8sFvXT9JhqR
X-Google-Smtp-Source: AGHT+IGjGOh6awkg0N9FtQOWt/ipEbBqpahFD36PjVlo+wHCIz1HFIb1Ur9JR7ZLvNFYBniOl20qkg==
X-Received: by 2002:a17:90b:54cc:b0:33b:dbdc:65f2 with SMTP id 98e67ed59e1d1-33bdbdc660bmr16924225a91.22.1760983564445;
        Mon, 20 Oct 2025 11:06:04 -0700 (PDT)
Received: from fedora ([45.112.145.77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de14becsm8681623a91.10.2025.10.20.11.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 11:06:03 -0700 (PDT)
From: Noorain Eqbal <nooraineqbal@gmail.com>
To: andrii.nakryiko@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	david.hunter@linuxfoundation.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	nooraineqbal@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	song@kernel.org,
	syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com,
	yonghong.song@linux.dev
Subject: [PATCH v2] bpf: sync pending IRQ work before freeing ring buffer
Date: Mon, 20 Oct 2025 23:33:01 +0530
Message-ID: <20251020180301.103366-1-nooraineqbal@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAEf4BzbtzHsa8DASzOg-Xqp8_-vG5ekC7JXhwuyZqPhrckU1hA@mail.gmail.com>
References: <CAEf4BzbtzHsa8DASzOg-Xqp8_-vG5ekC7JXhwuyZqPhrckU1hA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a race where irq_work can be queued in bpf_ringbuf_commit()
but the ring buffer is freed before the work executes.
In the syzbot reproducer, a BPF program attached to sched_switch
triggers bpf_ringbuf_commit(), queuing an irq_work. If the ring buffer
is freed before this work executes, the irq_work thread may accesses
freed memory.
Calling `irq_work_sync(&rb->work)` ensures that all pending irq_work
complete before freeing the buffer

Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Reported-by: syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2617fc732430968b45d2
Tested-by: syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com
Signed-off-by: Noorain Eqbal <nooraineqbal@gmail.com>
---
v2: Updated the commit message for clarity.
---
 kernel/bpf/ringbuf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 719d73299397..d706c4b7f532 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -216,6 +216,8 @@ static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)
 
 static void bpf_ringbuf_free(struct bpf_ringbuf *rb)
 {
+	irq_work_sync(&rb->work);
+
 	/* copy pages pointer and nr_pages to local variable, as we are going
 	 * to unmap rb itself with vunmap() below
 	 */
-- 
2.51.0


