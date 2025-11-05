Return-Path: <bpf+bounces-73668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEDBC36A01
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 17:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C25624455
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 15:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F7C33290E;
	Wed,  5 Nov 2025 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2TmOp8w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D8932E74B
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358357; cv=none; b=kvVgqgjkxS5TiTO9hXx4RGGNs8RzUGKQ4nnvMdwXvH8Yoy2gX6uCPQZTGs4wUeoJIiGFDXVYJnD/07EcWaM98iGbV2WdgSF9OL7UyD3zA/cpbwALST8taYfF5mgbD7OAKMESZUvHhyCieXw785QGvqYjWPJRItuyo5fSPxkjbCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358357; c=relaxed/simple;
	bh=bCmcU4LudX5TAv7kFLKO7Bq9aSHcHz23yx8qspcRF9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CEYcDCtLkbo4if4eowSUEhApgv2EDk/SRahyLEGRvfyPklA7O/oPuQ9xUlh9YEwd9+9H6W2epmQIA7WyhoI0ud68C5Q+Y6yisoflnpBMMkB10lxcYYdqBzXGMrvjc/DqJzg4sDxgSQtwPey4nU/ysf8ZRWfLeRdoWuEX6cvAHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2TmOp8w; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429b895458cso4674395f8f.1
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 07:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762358353; x=1762963153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzpXa18194vDE78yUGCXYW3asPwSiYtpmzhcMk+lEkc=;
        b=m2TmOp8w/+s2tP3o5E0TMsGyMKw2AcJgsmBE4hk6dOIPJJR4n8NECDxvQeD91dNrId
         9bRayHtT/lAInyoWPoNbjuoMnvxWtI+LmXnCC8/wRTRm1x38QjVthoVKZsdDOapudilH
         nFQYYJhAFQNG32SEBngfFvgiTrNlUsU1OQyKRV8uQV0vCNzFH1gcqsOGJ5j4waTyxnLl
         tj7kwU8MeM8j8Lt1UTA0Xnnt3YLnbx0LZ+lMlU+BmXVaQm6rVa/J6/5xv6W1xYWOQMJL
         TE+dPBvVU9UQPax/8W7sosAN5iqV9isa9IfzkXw6mq+uudp5WQpsY4jXh+0HSDrR9yoa
         at9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358353; x=1762963153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzpXa18194vDE78yUGCXYW3asPwSiYtpmzhcMk+lEkc=;
        b=LGFsh3ubj7U4lnbzgkNGivqYAJnzRu2o/u1S0gW0+JJ2QQpGXT8cIddpYhRR/mDoQL
         Jr+ZCFpDrWXivEdmu6fpT5KH203pJ9iKjgxytrBNhV0DIHRdJIMG/pBAhIw5UOge556m
         mfwTG+SXVXTcgW2bgrIZeYEtytrHSPjf+9NYuG8q+McHOdy7r+jLpiATLiJH+tSlmB2S
         qFcEA2JPLbC1njG/iEi4irYHaY5MnyFx7r9+FtsgAbn53BQMo6zIDk25DCpwBTHxxtel
         4nBE4ehWEUaMT164juUscwqOYhD3k7DRk2XCv741vmp7EHrc03yZhOVuIYn1vJOdvW8M
         yQrg==
X-Gm-Message-State: AOJu0YyFKZdmAmvsBGTwnHmq+UjaWJ4fqldPIVxlJ3aoJasYwiuMqrba
	0Uv0jFMenYd4wzMxlbLNXdb8qNaXYaKIQ96QoAm2WPjNqkFHSGfX6SIZTcxZrw==
X-Gm-Gg: ASbGncvppkV2eXYSpZdMCegCdDULAv16EFpxW2Fk2oYoeWkGkietMpY5rGmh8N/mMSf
	Gc3LXVC/LLhy8xAb+SIbCaFcHjXvOOZ81+siM15/Pqfg3NeOwr6Yj/VjgikfCjLiQD4jQao40vE
	swoS+XlGkDXTh+KCNAHt/9wA8YnwRQs9ZmLZUMk4yqldDRmg7X3YtGvhUES2uINOt4viKp1AT5F
	a1TcHSfMgWUAErUJjB2xeUKTcvdId5OyS4cbMD8cBgB5gcMkvAfWkiZJhYzXrZN0ghqcI1VRkkl
	FijUus0yuFwx4XckaLDKZqjtXpUEctbUFRfQTPjDfwBO5fzKgENbdTVjbzZGHNgr4zzqleifg9X
	YD25Ccyeq1O1Gkv875IfpYEzrhTEFwgAYBEKpGIJzTqKk3a5DdNrsAsGNs87N
X-Google-Smtp-Source: AGHT+IFfLY8yIiqWNVKvk7hKQrkRSUMUN2fzHuB7+xI5ViAtKO/gb0BmFby6YviKzOiWsWCH/CeWzw==
X-Received: by 2002:a05:6000:400d:b0:429:cf88:f7ac with SMTP id ffacd0b85a97d-429e330ab57mr3696405f8f.44.1762358353474;
        Wed, 05 Nov 2025 07:59:13 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::7:64d7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18efbesm11757142f8f.8.2025.11.05.07.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:59:13 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 05 Nov 2025 15:59:06 +0000
Subject: [PATCH RFC v2 4/5] bpf: add refcnt into struct bpf_async_cb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-timer_nolock-v2-4-32698db08bfa@meta.com>
References: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com>
In-Reply-To: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762358348; l=2983;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=D0HVAtPDAxq0Sli8X5BpwauLxK5TQzHFFheBzhAZ3kA=;
 b=lgQAbw9r1IzeOVf8xQCEOwgzl5O98Gas0BBhITb7gyUE5tHfyrgYkdFi8kXlweyUAVWuzYlWP
 KaTh0P8SycHCnlAhJJzFguGnlsNVxCSxvGuwZVMA0vW8UWiX/8Sv4oh
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

To manage lifetime guarantees of the struct bpf_async_cb, when
no lock serializes mutations, introduce refcnt field into the struct.
Implement bpf_async_tryget() and bpf_async_put() to handle the refcnt.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2eb2369cae3ad34fd218387aa237140003cc1853..1cd4011faca519809264b2152c7c446269bee5de 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1102,6 +1102,7 @@ struct bpf_async_cb {
 		struct work_struct delete_work;
 	};
 	u64 flags;
+	refcount_t refcnt;
 };
 
 /* BPF map elements can contain 'struct bpf_timer'.
@@ -1155,6 +1156,33 @@ static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
 
 static void bpf_timer_delete(struct bpf_hrtimer *t);
 
+static bool bpf_async_tryget(struct bpf_async_cb *cb)
+{
+	return refcount_inc_not_zero(&cb->refcnt);
+}
+
+static void bpf_async_put(struct bpf_async_cb *cb, enum bpf_async_type type)
+{
+	if (!refcount_dec_and_test(&cb->refcnt))
+		return;
+
+	switch (type) {
+	case BPF_ASYNC_TYPE_TIMER:
+		bpf_timer_delete((struct bpf_hrtimer *)cb);
+		break;
+	case BPF_ASYNC_TYPE_WQ: {
+		struct bpf_work *work = (void *)cb;
+		/* Trigger cancel of the sleepable work, but *do not* wait for
+		 * it to finish if it was running as we might not be in a
+		 * sleepable context.
+		 * kfree will be called once the work has finished.
+		 */
+		schedule_work(&work->delete_work);
+		break;
+	}
+	}
+}
+
 static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 {
 	struct bpf_hrtimer *t = container_of(hrtimer, struct bpf_hrtimer, timer);
@@ -1304,6 +1332,7 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 	cb->prog = NULL;
 	cb->flags = flags;
 	rcu_assign_pointer(cb->callback_fn, NULL);
+	refcount_set(&cb->refcnt, 1); /* map's own ref */
 
 	WRITE_ONCE(async->cb, cb);
 	/* Guarantee the order between async->cb and map->usercnt. So
@@ -1642,7 +1671,7 @@ void bpf_timer_cancel_and_free(void *val)
 	if (!t)
 		return;
 
-	bpf_timer_delete(t);
+	bpf_async_put(&t->cb, BPF_ASYNC_TYPE_TIMER); /* Put map's own reference */
 }
 
 /* This function is called by map_delete/update_elem for individual element and
@@ -1657,12 +1686,8 @@ void bpf_wq_cancel_and_free(void *val)
 	work = (struct bpf_work *)__bpf_async_cancel_and_free(val);
 	if (!work)
 		return;
-	/* Trigger cancel of the sleepable work, but *do not* wait for
-	 * it to finish if it was running as we might not be in a
-	 * sleepable context.
-	 * kfree will be called once the work has finished.
-	 */
-	schedule_work(&work->delete_work);
+
+	bpf_async_put(&work->cb, BPF_ASYNC_TYPE_WQ); /* Put map's own reference */
 }
 
 BPF_CALL_2(bpf_kptr_xchg, void *, dst, void *, ptr)

-- 
2.51.1


