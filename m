Return-Path: <bpf+bounces-78944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9D0D20CE3
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 19:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 125CE3055F7D
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 18:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC69336EE0;
	Wed, 14 Jan 2026 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1Tv6K7L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE1E3358BC
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414989; cv=none; b=VkwkjQ5SdJ/dn4O/35Sl9lBAc2r13OWVGJ55IsgssEQyODHTC/Uv++co93Ztn1qmaZvCG090oAnwsKtQisAs8VwqdrfKP56/cS1sL9RAsexNVC1QQ9jbbDBDM3pucaQGxgDra39ZtT75LClKD7/rPJjdn3xw7rqpQv709WQ0yEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414989; c=relaxed/simple;
	bh=32Jtb++TKDPgvt+bSXki+qNpr5oyQ0GrGstVt4Nm5Pw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kdPhtLn4Wxr4iame3FMfBNWPq5Ce7TP4lgHq5ShAaXtDdm8ezKGQNPJi5oddhIQyC3zq25zLQvose0lTzNiNhYHIZLr8kl5vED//JhHXJ4Wdf6SSi38Obg9osXKIeZI248kLHM45F6vpqZr0af0D9dCrEnRmW0smMFsrgOSGOjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1Tv6K7L; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fbc305552so135744f8f.0
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 10:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768414986; x=1769019786; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eN+WbU5hF3WZG9H6r1p16sQ+XNyo196wh1LKqIH3GoQ=;
        b=l1Tv6K7LZ9RIsqOZtHFDvcLAJ6WgPiG0lSqiS+BjXXncPGM7n/QHkYs2pp8JtNwSvf
         COQfI3eAQ2ty9vDBinNrBUjYhLWZN1xI7d6jaHSQe0U+rgDeKhoNvuS8mMBjGphNczdb
         3nST+Xf3nn9Tef5qGr5KDdd/x0V57U35hX+F70GbLWum/KdYIJ0qeTEkbeoCLuITzDFF
         XmUv5hHQcQo0bTuazYOb3YXavR98JAhyn8TMldVUM447jCKOCh4+QnzXak7Dxqo61j/z
         Vc31abNWVt7t68A/Kbw/bpeF//42dLGLKzyhFTGMIXtQOPPeS/qld6Fl04YYw7GUILGt
         aNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768414986; x=1769019786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eN+WbU5hF3WZG9H6r1p16sQ+XNyo196wh1LKqIH3GoQ=;
        b=Yncf+2O5WfblPRNSlKAD7LPPYUcERpU6WtD8F+4Zqy0u3FzmK6DlTIgSiEiAOqTtwf
         CDJKeagxcPgdcfVQ4gPzXl529Z/teyTko5qA7NbJgvAsBW6jqWMPqH7sQBnKtAsnO31b
         zvRKXKd4iN7TVsZgTRSvllw5oMREuPfZkyX3EsItl3nwtzQ6zGbXOQJgcKGSaFFFILk6
         bf4gGYBz2KS0XleJha2RJC1jUHaXjm6Z1SMiHZdOaEH64gFM5ofoCZ4uOzLJP2IfikqM
         ZfQnniBMQGay2KCyRkvJ6gkXe6z8tTT6SNx0OpdorvJ3IMO6gGKZ2N4Kw+paRnVeoNfp
         wJ/A==
X-Gm-Message-State: AOJu0YymD5xnrMbbqrBlQLW6xG5VI0SLIxoHniaryEzwb9o4Ul03m9OK
	T6TVC3lr0BYgRJVWBVKLrtLSpBwjUkLEuka/9YxqOvyiPZGlx64rG7MX
X-Gm-Gg: AY/fxX6jiflgMwbN2bNtRgRLixdsGzfwMX7NEaNns1x6n4ss2HRp3niP4fiBlv/R0nY
	FUb4unQ8adpUYPQFrCm7dnL453cyrtt5ReisM2kAFby7ulk/eH6pKhoyxsMWHDoOmPa4Z2PYapd
	Dxy7bGY27qfCK+4VtJmDHrJnQ0Wmx12e//QSdn8c7CtkRl5av72Uhc6vavbQuq2p0PO21VgOYym
	OP7PG7JMFSNtgSaSrrmsqwkjKz2zXRj2U1ixmhfv1uVUj5t6ntgiF8TAVe9gOrth2CJEUM9outD
	wDwOHhHlU0OZ7cQ3ASPhrYc6auyo2nhlBubhRGRFyY19+8K1Ak8P77tD5gvayCQbrvCmdKC01XO
	ppnYqvW9769wjCgZid5X+4VQgaeHxc32XR3Z8mZ+8IXmO5jJoJHiVMnQJ8Ez+ZnX7vmqwGpQ3aO
	+1Vh5QqMIkobJaOuGMGcow
X-Received: by 2002:a5d:5f44:0:b0:432:84f9:9803 with SMTP id ffacd0b85a97d-4342c3f1586mr4161724f8f.3.1768414986370;
        Wed, 14 Jan 2026 10:23:06 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6d90aasm680290f8f.29.2026.01.14.10.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 10:23:06 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 14 Jan 2026 18:22:46 +0000
Subject: [PATCH RFC v4 2/8] bpf: Simplify bpf_timer_cancel()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-timer_nolock-v4-2-fa6355f51fa7@meta.com>
References: <20260114-timer_nolock-v4-0-fa6355f51fa7@meta.com>
In-Reply-To: <20260114-timer_nolock-v4-0-fa6355f51fa7@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768414982; l=2421;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=XGh2CmOtEZqv24Pw617b4wb4E1BTizGndPWziICx9fE=;
 b=3wo0kUOmFwa/5Knw4mgj+TVwpMJ0GiVIgdDUJ28fUX2VI0eavKUR9YX4vHWaZigYHa0VYEsNL
 4rk1c+dyLFgCJEUZdDqhsO2Ax8eeKUa2dASD3mXHKLrmLQcvoqLWmfG
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Remove lock from the bpf_timer_cancel() helper. The lock does not
protect from concurrent modification of the bpf_async_cb data fields as
those are modified in the callback without locking.
Use guard(rcu)() instead of pair of explicit lock()/unlock().

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cbacddc7101a82b2f72278034bba4188829fecd6..19ca6e772165dd5f0015ada560acd97b2ad2c24c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1465,7 +1465,7 @@ static void drop_prog_refcnt(struct bpf_async_cb *async)
 	}
 }
 
-BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
+BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, async)
 {
 	struct bpf_hrtimer *t, *cur_t;
 	bool inc = false;
@@ -1473,13 +1473,12 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
 
 	if (in_nmi())
 		return -EOPNOTSUPP;
-	rcu_read_lock();
-	__bpf_spin_lock_irqsave(&timer->lock);
-	t = timer->timer;
-	if (!t) {
-		ret = -EINVAL;
-		goto out;
-	}
+
+	guard(rcu)();
+
+	t = READ_ONCE(async->timer);
+	if (!t)
+		return -EINVAL;
 
 	cur_t = this_cpu_read(hrtimer_running);
 	if (cur_t == t) {
@@ -1487,8 +1486,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
 		 * its own timer the hrtimer_cancel() will deadlock
 		 * since it waits for callback_fn to finish.
 		 */
-		ret = -EDEADLK;
-		goto out;
+		return -EDEADLK;
 	}
 
 	/* Only account in-flight cancellations when invoked from a timer
@@ -1511,20 +1509,19 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
 		 * cancelling and waiting for it synchronously, since it might
 		 * do the same. Bail!
 		 */
-		ret = -EDEADLK;
-		goto out;
+		atomic_dec(&t->cancelling);
+		return -EDEADLK;
 	}
+
 drop:
-	drop_prog_refcnt(&t->cb);
-out:
-	__bpf_spin_unlock_irqrestore(&timer->lock);
+	__bpf_async_set_callback(async, NULL, NULL);
 	/* Cancel the timer and wait for associated callback to finish
 	 * if it was running.
 	 */
-	ret = ret ?: hrtimer_cancel(&t->timer);
+	ret = hrtimer_cancel(&t->timer);
+
 	if (inc)
 		atomic_dec(&t->cancelling);
-	rcu_read_unlock();
 	return ret;
 }
 

-- 
2.52.0


