Return-Path: <bpf+bounces-53080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C59AA4C4F4
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39413A5491
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C3322B5A5;
	Mon,  3 Mar 2025 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJseEvj3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44122689C;
	Mon,  3 Mar 2025 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015408; cv=none; b=lBa6jqcrgh6pk8oD93xTvvOMo4bYAZPVFsFADYjWadhH17C8QK7/tL2PU+gI74c3oooX/64JrxkH/o+lo8bU8XPEgyeuyiHTPZ5mWzJoP82cVl9ir8OwasQLdHAN5fQJkuBGDCOTNAiWN7x/H8IsQgLbAbbX5hGXlYn9pi08Qu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015408; c=relaxed/simple;
	bh=Q9a38BvImlUP8RKT7WE0lh2B2I6Iy4KpJSDwsgIePN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCvQqvA4BLUq9vFTKhqbkiglTir4NSX3aRb8wxUgxlpU4WFFJX4CAv3Ag5NUMhLRwpb3nIhl7MAZYCb4VtKXieimOPQMkn0vUx2eRtkYLH/TN0z+WYFxY4yOegQTjb0tRKlTmB8uHkL9Rp/orB7knWnkNuzOSCjkA/eMArqMICo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJseEvj3; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2800841f8f.0;
        Mon, 03 Mar 2025 07:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015404; x=1741620204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HqVASaJxCqTvezKR1/7pImOEJNTa/8ze2+bN0p0ybM=;
        b=OJseEvj3XZ/R5cm5xFxU41w/qS4yftAmuBkTGibF9q7vkW1wx7hAtGwbTaV97shn81
         OO0YspiKCRyqIKU45QR/uhfBDO98FjaurMo2cblur57AigQBPOuD6CbJpn9XajQ3HHgQ
         ywkXLcr3DB1fXTSY2JpfRoMG7ySMpMnmwWt6OdsFJfcis+3vBreIdl74mX+k0H+3AMhD
         +Imxht8gr/0ugpjvQ7N0E97pugH+yrRVRDThr0zxCkc1tXghfvXkpit0KyhthTjbpWfx
         NHP4+/7d7eJd5lAFsPtXveNyA/wkkAmioBhQ6tOslmOGBDHWyvadj6i4N8TvITFMUSyc
         NVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015404; x=1741620204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HqVASaJxCqTvezKR1/7pImOEJNTa/8ze2+bN0p0ybM=;
        b=YRt0e29N05C9pEuSbWyzEy6PctiXbo0pFivHcISG+Bjkqfk17m4WID5QPW6ZmW/YKf
         /zgGzeoBAb70W52Kmj/CeCFXnxU5QMdl7y9ACwDwfcIy1WXz4WlHIGRiDaIq6Hg4HP8V
         635yWfDkr+7CDfwd++VQUtrtA9M1IG/MbKYtPk3QCV1QE0EMvwJc0XlKUeearJ1Oib/1
         Zj7JitRhfmm02kiVWfUZTYJ0vTVGCp7pMyAeh2D7mrsYakxqe7gqdQHURB4h8E5n9UHd
         bVTV68bFIn4pL3p+/1xP9nGXi95FcQs3Rrp3wq1XXjCn504L9qvU0XURITbzLxKOgElH
         NRmg==
X-Forwarded-Encrypted: i=1; AJvYcCWxVa5ad8Bn5Zz4wu2w+VIHkjItAiI1dW82POIbNXCw41zZWgoAbJfdYrdD4AowYC2Ks/huSqjf0fpBfS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVuCQ7HSR3IChRSdfhI8WufXp03rJoF6rzxR/QcwpxEJhqVN1V
	FY74/JrL/mO1FZhRszRqP41QUINjZDzsNBOuKZjp5Xf4Fv8X1Un3VSGK9BL4cgQ=
X-Gm-Gg: ASbGncsWVl1mZu9OKKkuHsUGmv4l1JyIMaMEguUE1sVNW75aC/khFFH+i5a/SjsRWbH
	JJWs+7VpZHfA78jTU9eWsciWjjXnCSV20HS+ZqS7fwnnKOxRyXEjTuPIvOa1rPR/0KJzbcGfwEC
	B8nC/axVyUM61ioQATXk7sQo4RrDQ9EvXi/BXIi3ddLY7/Z2vqHGLOOYNNtNtvP59cZOuQhVEX5
	12SPAq2uGhMb2DOBTPnRYVZVt3xuUopH9vt6rK6OpBM0xkhW4VFrUW/uGdS2VWwSfKu4iSE273u
	ssB83VdqGwitJnBCOIBIQ5DkekxFCsmrcTc=
X-Google-Smtp-Source: AGHT+IGJtvDm6QNWOZ/Cpj2mx/hKnagicnAIvDMSVdaEmiufPdG1r9WWQB7409X5ARNMd+GMAA5o0g==
X-Received: by 2002:a5d:5c84:0:b0:390:f1cb:286e with SMTP id ffacd0b85a97d-390f1cb2ceemr5781942f8f.27.1741015404157;
        Mon, 03 Mar 2025 07:23:24 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:44::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7473sm14977125f8f.38.2025.03.03.07.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:23 -0800 (PST)
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
Subject: [PATCH bpf-next v3 11/25] rqspinlock: Protect waiters in trylock fallback from stalls
Date: Mon,  3 Mar 2025 07:22:51 -0800
Message-ID: <20250303152305.3195648-12-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1845; h=from:subject; bh=Q9a38BvImlUP8RKT7WE0lh2B2I6Iy4KpJSDwsgIePN4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWXG8w8qbawJw3OszHwUL3Z+OsS55BpLQ/c3hWE /xTGsM2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFlwAKCRBM4MiGSL8Ryn5oD/ 96RVXMaF0ne5BLzCBhyNtkJBr6CAlauxQ3pblR3jmHlcP2GkKE00BZqXSuo5K0M0W8hzmyVBm8WZpv QmAprnJvjPvw3bTmZO232VjrI6ST5tJSd6XooAlRFPv85J3lQFS6z5IVGVtrJ/t6kbOg+xfwatWJVH JpGj9jJXyCIiXjHxaK91EcYxqzLOnLljC6WmGxE1N0lmh870+qkXn0vCZjMQ0lyW8wHEBbZ6Ywy8Gz 55T4SsC+beWbwhBNCJn02UhnONKtZqi0rm69Mb6AY+eRzPn9ZAI/n8F3jYqkY+yDCFq1Z4mdsWAsU+ UcxEA0xxZEA1gBVbVzAhkYvCHyFYnA/ZKE/8EZl6+ARIPGiQVPEqYETfeYZTVMxznw060kQAguI7WX WEFHRA8OzFTHycOX3/U8m+f3+9dgBhhVfpf0wJJHSMzNPR8J1we3rcdGBFiA3d8MdoQPth0iHEU2zP AGaEkhSEo4gXrUXNZnLq3ZpLEB+nn1ImiZ31A2o/3uJ4Vw9/x4a0iPKa01RJjV83Kjms2TGGOvbW2N GPkv4fOWnkSZv94YXDW/lzuzDng6iHB/gMJzFDkesuEjSysN2zSjMlyomMe3ja5puRwyFe2tE80jLM qADm2HxuhDZkxotSHNpoBoyUppVvy95LQycs0czfCa2Iqw1nW/eGWv4P5IYQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

When we run out of maximum rqnodes, the original queued spin lock slow
path falls back to a try lock. In such a case, we are again susceptible
to stalls in case the lock owner fails to make progress. We use the
timeout as a fallback to break out of this loop and return to the
caller. This is a fallback for an extreme edge case, when on the same
CPU we run out of all 4 qnodes. When could this happen? We are in slow
path in task context, we get interrupted by an IRQ, which while in the
slow path gets interrupted by an NMI, whcih in the slow path gets
another nested NMI, which enters the slow path. All of the interruptions
happen after node->count++.

We use RES_DEF_TIMEOUT as our spinning duration, but in the case of this
fallback, no fairness is guaranteed, so the duration may be too small
for contended cases, as the waiting time is not bounded. Since this is
an extreme corner case, let's just prefer timing out instead of
attempting to spin for longer.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/locking/rqspinlock.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index 9ad18b3c46f7..16ec1b9eb005 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -271,8 +271,14 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (unlikely(idx >= _Q_MAX_NODES)) {
 		lockevent_inc(lock_no_node);
-		while (!queued_spin_trylock(lock))
+		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
+		while (!queued_spin_trylock(lock)) {
+			if (RES_CHECK_TIMEOUT(ts, ret)) {
+				lockevent_inc(rqspinlock_lock_timeout);
+				break;
+			}
 			cpu_relax();
+		}
 		goto release;
 	}
 
-- 
2.43.5


