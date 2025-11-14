Return-Path: <bpf+bounces-74455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDB5C5BA1A
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 07:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42F44232A4
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 06:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC6E2F39D4;
	Fri, 14 Nov 2025 06:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTgee5cC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C0A220F5D
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 06:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763102975; cv=none; b=nI1Xb0ZbP9AByxRhgmex9lnwadBbnmU8/yj6BqIwS1qljCsfEOJ0uYt4Dl9HhBRG0RV5eJYsLage1zOY5A85YfU4if29xRB1rvKASJThtXHUnyFFrK+YOXIBjE2GCgRI5ZgIYHo4c6O7DH7NwRJzJ9sVKbV8YOty7J2y863M13k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763102975; c=relaxed/simple;
	bh=JSE/oS9CAZGvd5rzA4CQnkZVj/6bzRf90ev/Zw+qB2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k9fNNFL+XISkQEl53kOC1HrApP8XPC8xuA75jMbikcGfseooQrC8LZy6TJ3axcuFZ7omZNgI/aI/ETbF33ZZGtlPDgbIzVqbHEryXe9fJiO9HpOjkcTLDcYpXOto8btXsWmh1YlDiIuxLr1baB1G0nnrzEoK4eLRaK3bAkL4vDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTgee5cC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29812589890so20546495ad.3
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 22:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763102972; x=1763707772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iKvtS8zNPbBhND72za3ddTz84FeeQznesMDJ57+V13Y=;
        b=PTgee5cC1iNjyb8GT7En07Nf9ISF0T8v7MpFc6W+8pYBr15r1PEfwyJDXR5mzun/bz
         yLmrXstNmRueipndnVa1SiALV+gcXVxr9WLu0VMpAJIt9isrKl3mgMhPh1RSwsQHsbIF
         kPOoShGsb8dyo+nf2pPeD7L1Ah0E8FiDKyRFXDxt2+WPWVC2QsDbs4SmZQNVQQrNQxgp
         jB5B+LNpEqvNnOAxqyeelldZhYKBleaHGyPl9fPhquWb5J0VOaFJUYslcyowucGFdW/U
         NsM+P6enlKZ2ZoT+7qufWhlBdqHLY0Gl3H+UeMbAEqCOGNGMatDlcT2/IHoCFFKPfTU6
         wQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763102972; x=1763707772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKvtS8zNPbBhND72za3ddTz84FeeQznesMDJ57+V13Y=;
        b=GShDgBPH4vTWO2gPjWn7kRATdtMwyWAUTcy66ogG3Wlc3U+Nf/giKcuCPZXUxqw6IW
         U8DTJu5SV/VLKo4+FMxrVhbiwMWuImIQbCqIBP71TRTuogaTcribK9UuBMY/lJT74eFP
         OHwLlmp+XGElHgcYf2Ivz38oios69VuC9ioyX8pK1cn+STvre4a8M2Jt4TyA+QqMy6u5
         PwfxRWECJV3o4GN70x3xYOude3QwMDutxgXXvN3NOhmdrCO1vGL6O9xMblmLQbY3Pzmt
         owAVMEQnZ6zerXKTZL1Ei1Gr9tO5tFQrfyxmZ/PEC3iLjUN2XBTkd6zbhtEGl8j6mDUP
         PlRA==
X-Forwarded-Encrypted: i=1; AJvYcCWtwgKzwC2iEDQdrWBLs+trfIQUfzrTPN7Rlu6b6GddvlyczORlfVCrDtPwAVVboXHeQgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEoQxEezK4333neAQJQm5rp2yj3cJdOW8j4Xns0zJQpEc75wUs
	WNoWGfkhf+33hV6TJnegaC0BKc9wEzpqC4EG3eny9qoqp5s4z2DlHd3Y
X-Gm-Gg: ASbGnct/I1S+g/Z9vMHpxrG9NqHjGXSVbUyZC42cWIxtXDkHjCxcgN8ug4MQBMd1Ism
	+FAZkSs5IVkIlGfvlQP+ic+C2aSEQYBED+UUtbNx0ji3rWBQW1xH9dEBcZh9CBmETAJJH/diJks
	vebaz9nk5iL95ehvOFz466YcupXn5gYru5CbJ/IaajfZZVJB9Hlplep39yrYJtPhk9I2aK+ps3L
	ikTQXIWsNz54mcTN2GZ2Lsm7lcQyUpz9HtgnruSG8BR0jXDRymfFmp9PwiTeRB6pdRNuVNLcUC/
	39PWMSy/i4w77hm64kTtOckgSHJSgJc+dX4F5Q7V9/PMRTgzddhuYyKGDB/NqQ/C/H5bfL5+jdf
	GFjjQWCt8sFxhKRoEQvdwA0INAL+BNvHrEmPwMbRLYBGpfIw8kDohY1NyIpSlpLWOxDiDGRF8f5
	AXysZf4AfbxfhX/lwQ
X-Google-Smtp-Source: AGHT+IGkKh2kbL3kBbYsTBEIKFPMIHVI3BnGOx8dSxRlWjUI8hUMMhPyqzc3c/DDAYwX2WeHF159xw==
X-Received: by 2002:a17:902:e5c3:b0:295:596f:84ef with SMTP id d9443c01a7336-2986a72e380mr20356825ad.31.1763102972503;
        Thu, 13 Nov 2025 22:49:32 -0800 (PST)
Received: from chandna.localdomain ([106.222.228.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346dasm45771085ad.7.2025.11.13.22.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 22:49:31 -0800 (PST)
From: Sahil Chandna <chandna.sahil@gmail.com>
To: yonghong.song@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bigeasy@linutronix.de,
	bpf@vger.kernel.org
Cc: Sahil Chandna <chandna.sahil@gmail.com>,
	syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com
Subject: [PATCH bpf-next v3] bpf: prevent nesting overflow in bpf_try_get_buffers
Date: Fri, 14 Nov 2025 12:19:22 +0530
Message-ID: <20251114064922.11650-1-chandna.sahil@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_try_get_buffers() returns one of multiple per-CPU buffers based on a
per-CPU nesting counter. This mechanism expects that buffers are not
endlessly acquired before being returned. migrate_disable() ensures that a
task remains on the same CPU, but it does not prevent the task from being
preempted by another task on that CPU.

Without disabled preemption, a task may be preempted while holding a
buffer, allowing another task to run on same CPU and acquire an 
additional buffer. Several such preemptions can cause the per-CPU
nest counter to exceed MAX_BPRINTF_NEST_LEVEL and trigger the warning in
bpf_try_get_buffers(). Adding preempt_disable()/preempt_enable() around
buffer acquisition and release prevents this task preemption and
preserves the intended bounded nesting behavior.

Reported-by: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68f6a4c8.050a0220.1be48.0011.GAE@google.com/
Fixes: 4223bf833c849 ("bpf: Remove preempt_disable in bpf_try_get_buffers")
Suggested-by: Yonghong Song <yonghong.song@linux.dev>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sahil Chandna <chandna.sahil@gmail.com>
---
changes since v2 :
Updated commit message as per suggestion from Sebastian

changes since v1:
- Remove additional call to preempt_enable() which may lead to
inconsistent preempt state if invoked without preempt_disable() called.
- Correct tags as suggested by Sebastian

Link to v2:https://lore.kernel.org/all/20251111170628.410641-1-chandna.sahil@gmail.com/
Link to v1:https://lore.kernel.org/all/20251109173648.401996-1-chandna.sahil@gmail.com/

Testing:
Tested using syzkaller reproducers from:
  [1] https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
  [2] https://syzkaller.appspot.com/bug?extid=b0cff308140f79a9c4cb

Validation was done on PREEMPT_FULL and PREEMPT_RT configurations.
---
 kernel/bpf/helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index eb25e70e0bdc..3879eb42a681 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -777,9 +777,11 @@ int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
 {
 	int nest_level;
 
+	preempt_disable();
 	nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
 	if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
 		this_cpu_dec(bpf_bprintf_nest_level);
+		preempt_enable();
 		return -EBUSY;
 	}
 	*bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
@@ -792,6 +794,7 @@ void bpf_put_buffers(void)
 	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
 		return;
 	this_cpu_dec(bpf_bprintf_nest_level);
+	preempt_enable();
 }
 
 void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
-- 
2.50.1


