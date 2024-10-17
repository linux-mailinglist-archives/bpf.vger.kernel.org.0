Return-Path: <bpf+bounces-42310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F09F9A2533
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 16:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3F51F2257B
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 14:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753D31DE3BB;
	Thu, 17 Oct 2024 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmXv9C5o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD6910F2;
	Thu, 17 Oct 2024 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175808; cv=none; b=Mu1QyE7fYd5Eu8P1owZ9MSfhzJyPbmH0S3CV6xqajvVJZnVBDpEySFd6jin7y/fsQUALjNwRGcj8g3pLcE1xlUeDsvE6TqFbUr7Jayoz8MKaahNDOzGXgSBB5L/r08r9Jo9G/0lkpj4Da0oX3+KOAG2mvG5wBqMdqrm36RDf2Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175808; c=relaxed/simple;
	bh=6rKRf9Y1WXE42KHKwOnG748h/c4WLjfiy4PNeD5tvY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b93JsdNYzjCDLo9s+0ZnEQhzi3iOxhVt5NTsHBE+fd6SoVyhbwzrNOPp31kX2wgwGe2pEEXkouEUQyJ3fO45smrJPUzfU2kuau7sMTFsk5brHoh7ex1YFf8p3jvxWgRARZ+ikL0psrs53cise6HXmkbrgXnuv28ZX+GgHXDWaNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmXv9C5o; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d495d217bso913620f8f.0;
        Thu, 17 Oct 2024 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729175801; x=1729780601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zZagKg02wl0icL3yNm9ZBuvWQr9E3IdxLZ4rUxrkLGY=;
        b=nmXv9C5oxYzEcq6TxtJuN1vI+VZOmrhXIRgqV9qa1bU/9aHmM6x5nw3hCRwRU6Gcxz
         Ch9FqNqxl+hjUzCbXArhvSNAPpED2/uTiF4jiSHHo3hFGzhuvncW/qA4YSUrEJ+JtbLf
         7oEsn84VPTPH0xEmFFdtw5VFYEn0NgyclhqTOIGe63ixbbGW5t9Ugr2yMJkRH4hnDftr
         f2b5IlHZpISeI4x9aNacb1DmOsHKe0Bi13Fy9jzaGeC3KUcPkFbvx+BCsSRik0TdF1m2
         Q6hesiV/sKcC8ikS/snjKZCbr5EJE0NpKh7vZqwdRvicerwCE3TfVJzhodNRMZWdCbEC
         7/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729175801; x=1729780601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZagKg02wl0icL3yNm9ZBuvWQr9E3IdxLZ4rUxrkLGY=;
        b=nS9Xdj0VrqwZb0Z60tczYfqnNY9BveSwVNY1NOzLzQhkrujS3RmboBLPzzK/rnvzbb
         AR1s/CewxbXTnMMwlBymlIRMmX/b5Kq2joBefDJdUwJvDduQhE10Ha3YcxwqP3cnW2/9
         P1fxIYNBXZ+98v+JzDrrDHAyO0yCrPMNAFTh1ULZV2+8WITK6aYrjzBqSV3OvYK4U+0q
         v40JCVblA+luw0VDUZjj6+buiQD9tJfW6UrQEYriK7Upnv56AzjhitW39VcdJDuCoCwn
         81V1+VxPDa0tIgJdj2HnXw/DNY8YuQDtLyvFzXSugrDOFqbQWe8MNcJDrXgj6KP+Ozxv
         18MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqotbgs+TjU/ta5/xB3xlA3jSKCOOrafCWLeO/K0Qdc/gJ/k+nXW4QczLCD406y/dT7TVlWTA0PNA7EQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRPo5hSBwrdJPcXrbDbUInIP8PWUeI7KDhSE5Evh/cDivX1cLj
	PXdKDMAsmrTntwaDVlUU7Xn/uDa8jrl2NiyinD5DYFJRnb2TzERr
X-Google-Smtp-Source: AGHT+IHfffww4ML1derH7Nbp65Ko+ITzCNOIk4WkP160BiZx9OIx2j+xcWvUgSq3w+mw+RHW1zFZsw==
X-Received: by 2002:a5d:59a5:0:b0:37d:53d1:84f2 with SMTP id ffacd0b85a97d-37d5ff27fa8mr21397323f8f.11.1729175800873;
        Thu, 17 Oct 2024 07:36:40 -0700 (PDT)
Received: from andrea.. ([2a01:5a8:300:22d3:c46d:6fc7:2b80:b267])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa87d56sm7473352f8f.43.2024.10.17.07.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 07:36:40 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bjorn@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	paulmck@kernel.org
Cc: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH] riscv, bpf: Make BPF_CMPXCHG fully ordered
Date: Thu, 17 Oct 2024 17:36:28 +0300
Message-ID: <20241017143628.2673894-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the prototype formal BPF memory consistency model
discussed e.g. in [1] and following the ordering properties of
the C/in-kernel macro atomic_cmpxchg(), a BPF atomic operation
with the BPF_CMPXCHG modifier is fully ordered.  However, the
current RISC-V JIT lowerings fail to meet such memory ordering
property.  This is illustrated by the following litmus test:

BPF BPF__MP+success_cmpxchg+fence
{
 0:r1=x; 0:r3=y; 0:r5=1;
 1:r2=y; 1:r4=f; 1:r7=x;
}
 P0                               | P1                                         ;
 *(u64 *)(r1 + 0) = 1             | r1 = *(u64 *)(r2 + 0)                      ;
 r2 = cmpxchg_64 (r3 + 0, r4, r5) | r3 = atomic_fetch_add((u64 *)(r4 + 0), r5) ;
                                  | r6 = *(u64 *)(r7 + 0)                      ;
exists (1:r1=1 /\ 1:r6=0)

whose "exists" clause is not satisfiable according to the BPF
memory model.  Using the current RISC-V JIT lowerings, the test
can be mapped to the following RISC-V litmus test:

RISCV RISCV__MP+success_cmpxchg+fence
{
 0:x1=x; 0:x3=y; 0:x5=1;
 1:x2=y; 1:x4=f; 1:x7=x;
}
 P0                 | P1                          ;
 sd x5, 0(x1)       | ld x1, 0(x2)                ;
 L00:               | amoadd.d.aqrl x3, x5, 0(x4) ;
 lr.d x2, 0(x3)     | ld x6, 0(x7)                ;
 bne x2, x4, L01    |                             ;
 sc.d x6, x5, 0(x3) |                             ;
 bne x6, x4, L00    |                             ;
 fence rw, rw       |                             ;
 L01:               |                             ;
exists (1:x1=1 /\ 1:x6=0)

where the two stores in P0 can be reordered.  Update the RISC-V
JIT lowerings/implementation of BPF_CMPXCHG to emit an SC with
RELEASE ("rl") annotation in order to meet the expected memory
ordering guarantees.  The resulting RISC-V JIT lowerings of
BPF_CMPXCHG match the RISC-V lowerings of the C atomic_cmpxchg().

Fixes: dd642ccb45ec ("riscv, bpf: Implement more atomic operations for RV64")
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Link: https://lpc.events/event/18/contributions/1949/attachments/1665/3441/bpfmemmodel.2024.09.19p.pdf [1]
---
 arch/riscv/net/bpf_jit_comp64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 99f34409fb60f..c207aa33c980b 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -548,8 +548,8 @@ static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm, bool is64,
 		     rv_lr_w(r0, 0, rd, 0, 0), ctx);
 		jmp_offset = ninsns_rvoff(8);
 		emit(rv_bne(RV_REG_T2, r0, jmp_offset >> 1), ctx);
-		emit(is64 ? rv_sc_d(RV_REG_T3, rs, rd, 0, 0) :
-		     rv_sc_w(RV_REG_T3, rs, rd, 0, 0), ctx);
+		emit(is64 ? rv_sc_d(RV_REG_T3, rs, rd, 0, 1) :
+		     rv_sc_w(RV_REG_T3, rs, rd, 0, 1), ctx);
 		jmp_offset = ninsns_rvoff(-6);
 		emit(rv_bne(RV_REG_T3, 0, jmp_offset >> 1), ctx);
 		emit(rv_fence(0x3, 0x3), ctx);
-- 
2.43.0


