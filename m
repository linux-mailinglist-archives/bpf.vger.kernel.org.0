Return-Path: <bpf+bounces-53072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF091A4C50F
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABAB97A553F
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DDE215196;
	Mon,  3 Mar 2025 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FF+3ClHU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116B1214A9F;
	Mon,  3 Mar 2025 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015397; cv=none; b=XsuF3zjpYwC8DWuv9B6/dM8NQZxj3fET3S9mwP63jI4OYnjn1EE2GZCZEgjCo4EKM00IHlrA07nn26/qUrMGoZcXfqcXhtlTVZp6x9HXv1+9EuugxD8d6SSJ4COe4exkK9CLDgH6n/8nHVqhdRlFHFPDJQLIPqTmNXVrAcaOwwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015397; c=relaxed/simple;
	bh=WHhXMqIdalfkSexlY5e1BRqspbIYdrDmDQT3rX3AKP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMsz5NTwCHgjjcHc5kj1vRhLV3xaxQNKs4pk6jdBSSSIgUFQonICox/nC/cEPANi6Re8Td5I7oje3HKLWPWvknYL4HE7FZdoBtpnJbaNj5pbM0X89JbiBCGom1fHO65FrskiNOmQWz9YB/LrcrfAJ9BDOIcHuFyzu05OiA2A4LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FF+3ClHU; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-38f406e9f80so3511875f8f.2;
        Mon, 03 Mar 2025 07:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015394; x=1741620194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWs3GXRlx91qlbus5IlQPX+xUrucb3RvojJ3Jxtdv6A=;
        b=FF+3ClHUM5qdsDNkKTJaQppHYYQOWx5AOshQ5SK+m8bovKSGD/6fsotHYAbxxzSHKz
         Pnd8S3v1bmtuG2lLBOB1JCyWbNlpds7KJW1PmT3+aTRYjNowIkiLqgwxDGmYWsqybxbP
         XPyKPtcpU2IcwgaYnFmcmJl4zE6seVO8ZnaPAjz4Cqc9AuqOvMsacKzVtBqBzXsm2bd1
         WhPm96D1sXqyn+1nUnjFu2+dFqzjXsLm4SEcvudV9bKX+tII3eRIsB5vs4FlThElTanX
         nDDaRvo6XPtVeRDYoksAhBo95NvoLtk+mPNc6lxHlrFUq2bf1ybvKY3+9eWC+QDmk3uv
         0jXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015394; x=1741620194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWs3GXRlx91qlbus5IlQPX+xUrucb3RvojJ3Jxtdv6A=;
        b=a9FCb++9XXeMv5Qe856/bQdFNgVGI5/R+0Y34pSN8jLxzucnh+b1fp1VdbHgCmvnUh
         p46XyEW9y1fQm74wcmhUm8rOpe+G9VL0TVXBJeJojZxATcHx0jvGdQHEjZ98XuUnFDqM
         T9bCgPDUNQmgpiqYuGCXD8zAHJhqiPM4/QYM7l1P5+KQn4sJ4JPySLgFVTfgFQ4K28rf
         9bZag51uuo4ZLFzgmtvJoWAFg3dMawn31Wn4eATsJ46WTdxrEPfDbJ0LIcELOZSlbJMp
         uMLJ9ru5nyzpkTmU68+exxovbBPZN3jrNIl9HpEMLkrxDYMIXuqXl7XsqgTbHmnplnuA
         xH3A==
X-Forwarded-Encrypted: i=1; AJvYcCWxZh6Nqt1mv0bqQgZ4tdQG3KeqWyzZwywZSJ73VASPyAdvkecZTPhsev0h/g3r7HpOcCYoIMxFGIL5Wnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Jp2QonbPebGWAw94aQ0MUAnW01tgZlVK9eoNoZw4IrNgjxks
	JhXtFwlI1yAlDGk+MBULZOStAgMCkPcJXYXBb2Mt+e7fkIj1/XFzf0+dqqqO42A=
X-Gm-Gg: ASbGncs+LCE3cc1g5+oZcLGBzjRdglH6bPzganBHnWsoO7TQo+FSLGCdwEIcBD/Ytih
	W0c2SnCJWH/dwaND63E/FH+pTEnd4HyDlB3unhxvrvVXOj42G/ocUI7loRzOTT3jpnuln0DggfI
	Buu9PZvMRhkaS4Kli++9JiZlDb3MQJgIgK6kXw36+TOIbXxrvtfbsfPDLdGzOVHeJ1j21lUvAeQ
	6LimM3NmDxfpfk+Qs1yIlbLz4DEqgbA1JWD+TyaskQbEgkxy0gOSIDoHLQigO68rUyU1GiWzZY/
	FX1aiepq7JLlANYIzca5xrlWU9QrpVuv2iw=
X-Google-Smtp-Source: AGHT+IErll0m3qO5vPfIOAEgdmC0C+DMiSxgMRXz0/y2x++hKd/Wp+79L1fagMz6mKX2oQCqD0CzfA==
X-Received: by 2002:a5d:59a4:0:b0:390:f822:3ca3 with SMTP id ffacd0b85a97d-390f8223d8amr8118617f8f.37.1741015393939;
        Mon, 03 Mar 2025 07:23:13 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7c4fsm14904499f8f.52.2025.03.03.07.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:13 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Barret Rhoden <brho@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 03/25] locking: Allow obtaining result of arch_mcs_spin_lock_contended
Date: Mon,  3 Mar 2025 07:22:43 -0800
Message-ID: <20250303152305.3195648-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052; h=from:subject; bh=WHhXMqIdalfkSexlY5e1BRqspbIYdrDmDQT3rX3AKP8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWVvzlsIk8Mh+hFnelZKKgCgtqU9iOBLKbPXk+b Hr7ixKqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFlQAKCRBM4MiGSL8Ryow+EA C1eFvCJZOUlVvCcUeprQTPLwv72Q6ykc0vZYM6C30cB2mh8RDYCi22FekqJDDuIBP3ggLIEkBn++iL HayE8E7tcJD+XUme2bPMlycWLuboqWEkhYbEUmsxEiHDMF0tIGq3CXtTX/EFmdPiqhrfYjK2/U0WMS NOVAt9VBBJ2Gkr/Ahg/bKs76BmL83Wf4QvULiFNYpGucOQLCWNYYcOf3+zvSDaQnE1PLiL4lwcEWgJ BWhLal7zLGBO37rSCp8pXZxAjZbOmlIMd7El/c3QBiJ/AUbfRk2SI2aoPiCG7z+vImKhFG9QUUxpHv FXE64wiHpCMTGwLOtsovyQ7+cDSbyd9myY4DYnoOFearxpOGJS6oDKVpKL+YUs0/lrw0EOGtKl8onS nwiFb0cJg40JCw+qXxsA3WdiI5uIK9cMKMra5mIr7h6U3ffX7Tt02zhl0EZujgfUYOKA9Jtck4Hd1x mkS1YmJ/dZEejK5aHgZ5LEBPw9S9BHwJj17/s5GOZti6Ra8ymdC+LLaxSZUDhaBNfI2G2cQJ70ISBx MVd2vcRakzCnM/Eax/CdmqnGby9zEaPOamB6GxfsXaYvqAw9KSqQjVShNIdzUnP/UWD4l5rcaZ50ZC /DEcBbUVqWlsEJY2xKVzRGMI5YAnPpqIb2pZParSp7t5oTMcgQWd2IuyPnAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

To support upcoming changes that require inspecting the return value
once the conditional waiting loop in arch_mcs_spin_lock_contended
terminates, modify the macro to preserve the result of
smp_cond_load_acquire. This enables checking the return value as needed,
which will help disambiguate the MCS node’s locked state in future
patches.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/locking/mcs_spinlock.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index 16160ca8907f..5c92ba199b90 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -24,9 +24,7 @@
  * spinning, and smp_cond_load_acquire() provides that behavior.
  */
 #define arch_mcs_spin_lock_contended(l)					\
-do {									\
-	smp_cond_load_acquire(l, VAL);					\
-} while (0)
+	smp_cond_load_acquire(l, VAL)
 #endif
 
 #ifndef arch_mcs_spin_unlock_contended
-- 
2.43.5


