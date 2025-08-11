Return-Path: <bpf+bounces-65332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72276B2085F
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 14:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7DA18A03F6
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 12:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187EF2D375E;
	Mon, 11 Aug 2025 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kMgwJnSY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gYAQxtkv"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF952D239F;
	Mon, 11 Aug 2025 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914089; cv=none; b=VbXUmVZsBAmyAtyODOJmeY/ufTsK4DafF0b6lQPjHZA9KIP0UOPdrAvp1mt8hs8BvU3ujawJvOqhbYn41/0ysCLdiyGN1R1/gywS8mSjaZQcs9eshXJPo7VAqqHpCPUDUNW+s4pIzUJ4AHN5N60RmmdR+9TMgTmd/jNKWJHWus0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914089; c=relaxed/simple;
	bh=qb4k3dnsn4fU7MmAJJzINDed5D1nWSWRCKGv9H8d1CU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fGaRK3A5S2pohTWhzG6r/Z10i/YbmjBFR3jWRMwgBNdSY3VXqkjlBXMrVA69Rg9tVbh7h6kdYwRayDYzOl5I7625yriFs+Cbjhw0NVoED52+I2MfX0jubMcmn4iF2hIDJajcECgZdGlbJVJUpY8NhXFnpDDyNODJqygf90QfkEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kMgwJnSY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gYAQxtkv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754914085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vNU9H7AOGT9UEzwAg1eC99sj3253bWGd+eGOH4Eeg8Y=;
	b=kMgwJnSY2j8y7Zs6GnadUUESMyUK9j999ipL6Z/X5Ng2Fui6OCO54ZngWJBVVnpJa7GTD2
	E0/yVNydMsvSbwrYtrASyUeBC32EltdPDkJtrPjGS5w3yN7mdWeAhnscox1sIm6dUYopfF
	GD7XZ/tVtJJUqxVEC55CvVacqIKHblEzcqN/O++6ESG10+doQDl5oXDd2ZgisIu4PzlpT/
	aqpeHWcLYfUYpyk1LCbNLN6fc9qHQCXMC53Q6muxJ49RQM7LPf3zl6i4LMhHxRavytQVQK
	DHcd482WKc0JrRYFRCihx884+sZprT7yhHD4dwaEh1cvGxqmOBS4obbEXHL9+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754914085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vNU9H7AOGT9UEzwAg1eC99sj3253bWGd+eGOH4Eeg8Y=;
	b=gYAQxtkvnqkJnkeqqlZHd4OT0uO7Jx8Wmn8CKVOEoW5E7fAfo2JAjnvH4QtIR40JW9M1s/
	BiKnJRYMsWEgzTAA==
Date: Mon, 11 Aug 2025 14:08:04 +0200
Subject: [PATCH] bpf: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250811-restricted-pointers-bpf-v1-1-a1d7cc3cb9e7@linutronix.de>
X-B4-Tracking: v=1; b=H4sIACPdmWgC/x3MQQrDIBBG4auEWXdAQwrSq5QsjP5pZ2NkRkIhe
 PdIl9/ivYsMKjB6TRcpTjE5yoB/TJS+sXzAkodpdvPTBe9ZYU0lNWSuh5QGNd7qzm7J0S2Ifgu
 RRl0Vu/z+5/fa+w2IRDMkaQAAAA==
X-Change-ID: 20250811-restricted-pointers-bpf-04da04ea1b8a
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754914084; l=1513;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=qb4k3dnsn4fU7MmAJJzINDed5D1nWSWRCKGv9H8d1CU=;
 b=JHnG4dbctRyTrErXIDufQtwc+eg0rDwsFn9d0ntsGI2564ACO0hydRh7mm65LlYxVXjaSnVu0
 mdmaDGMB5xPD69tsvThlPpHJklxlh1580zz5mT0AcW9qVh9Nl1l2RP6
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping locks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/linux/filter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 1e7fd3ee759e07534eee7d8b48cffa1dfea056fb..52fecb7a1fe36d233328aabbe5eadcbd7e07cc5a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1296,7 +1296,7 @@ void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other);
 static inline void bpf_jit_dump(unsigned int flen, unsigned int proglen,
 				u32 pass, void *image)
 {
-	pr_err("flen=%u proglen=%u pass=%u image=%pK from=%s pid=%d\n", flen,
+	pr_err("flen=%u proglen=%u pass=%u image=%p from=%s pid=%d\n", flen,
 	       proglen, pass, image, current->comm, task_pid_nr(current));
 
 	if (image)

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250811-restricted-pointers-bpf-04da04ea1b8a

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


