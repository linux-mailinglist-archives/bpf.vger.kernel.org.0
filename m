Return-Path: <bpf+bounces-57681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CB0AAE798
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03E51C023CF
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 17:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A14428C5C0;
	Wed,  7 May 2025 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eF5+U9yX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BA528B509
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638258; cv=none; b=djbmEi8mQ5wiUSx5kw0VOGEp3uEw7mHkYHxEEfD0iDoUuxbkoMoY4/Ex2q1CAPq8uOmdJ+pABuUX56+9P9pH7RH/v0Td40MryWJmBZ+7U4tZlMq/hx1AFrbY1+DsnOSFRMfiLwG+5sbUdQ50rHDe4N0t/Ri1CRFQZmLBLJxR+3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638258; c=relaxed/simple;
	bh=r0TSHk2W/NdBG12fIoptJ1Vfw+1dK0mtdjaVDG4t/T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtpA5/gAwoIXUqcv2+BjYnx97xgYiC4pTVVa0i/VYHIIqzkWRellv3gVk1qHoKp3DIB23J1diQl5ieUKBxltuLmj8QBdqw/Xm1D9q0PIKebcEeuzh67i6JuDagwxragdF8/0JQ1+LqRDTLUpYVvv7vYE88UQxeBM4X4HPQRr5Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eF5+U9yX; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso770515e9.3
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746638255; x=1747243055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+ncq/+y5VaFzAIP+pIE28ESSD5CIL8gsDazyQcE1e4=;
        b=eF5+U9yXOe9wFMCUYeZTyQ7jnwvhe/d6MjTkwzCNehxJJ7vxZ3l1hxVRFkqvFkTVJJ
         SXDbtBGZovIbVvxP76TsffhcYNn4+6V7BpRt0QIjLngzRo+wAxxJV+sPb9521sNjeywG
         szH4k0xLiJyThBNySL44MdDNSc15ED5Ra/EDWMGD98gBiArORqXHAFbtYEzmTFQUZIMZ
         uN/LDSGJhVTVnqQv+1emdPKU8qd1joGbYSA8yG5FuEzrJtVJLYQP/EcmrMGFFKuVJGsA
         XavpGttNcVDPRnNvrvRWVlwDOMEf7oGoqKrEPqUaxLjsSrF345IxvCxitgjQMUSc+fuj
         XrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746638255; x=1747243055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+ncq/+y5VaFzAIP+pIE28ESSD5CIL8gsDazyQcE1e4=;
        b=pzB0Rwv+KlIGkK6rDNrLk9Ndj1LPC3FEIrTU8PqKLfTiP64GfxQRZi2W89qaJ2HtkF
         Wreq2nU84LByb1INMWvESnXqkxyl5tlBJO9BwwzbF3/gkHk2+oiv941IGFcs2FxW0UAN
         qdtL9SWskVjgX6KMZct7BWWlKT6rog5463UaOktsDHDpOiqhQl78bFW8pfSeU3So2SSH
         DpTvvvzyKJq5Ke9ouwlo4MJRjoLK+QsXrQiFrht6kdSqm7sqid6uX/0hK7grUhhR/ulQ
         TSf704a0ZMjoqrW7N9qX3UPkuZCgr9G5GHMucpy03UqwPLD/YBqLECjiOi6Mam0FgW/p
         fdlQ==
X-Gm-Message-State: AOJu0YxqboP8bXbqOmvuBhe/VWjFNrwLbbODNHuL1qQiPrM0SXfVmh/d
	oBo3ryio6Tc2RtY/QRDmcriT5tSywiKxplVHVck9WzS+FqXB2FcswTYD2r2ZD+E=
X-Gm-Gg: ASbGncthEevwnVuiX4TfDXuuzkOvaUfOe6riRw9ZgJRmwYpBgSxqGqAid0gukOcTZdf
	ef1pfKDgAwULOGv5gnIGfI80USsBCk5N48dkhc5gAB2KQi4OVBr0uMNxLC2HrD7PAXM2R+tQf14
	QJNOJLWyYo8tSH6swl635rE46RlhTINEQIWXFQ6dob+PPeHGQYyp8a5Dh5HKa+KUi+6qnlDGXCr
	pQliJIjccI204zqXGXRwsrf1MStqHBo8f93YT8gn//U+Ie72xkifF1uQwt47IlgRI35o9OrCEo4
	Vx6YE8ANo0FNp3Ol5ELvE/e/FlHmANE=
X-Google-Smtp-Source: AGHT+IEZxzaDqRAkZbozg34RbddnCBBJMGagHkfsPujUoICkjabT4gAcX6MCxCQcqQYw9A4+1Jn1cw==
X-Received: by 2002:a05:600c:3b24:b0:43c:e467:d6ce with SMTP id 5b1f17b1804b1-441d44bb449mr35669585e9.4.1746638254646;
        Wed, 07 May 2025 10:17:34 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:54::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b1726bsm17747917f8f.94.2025.05.07.10.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:17:34 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 09/11] libbpf: Add bpf_stream_printk() macro
Date: Wed,  7 May 2025 10:17:18 -0700
Message-ID: <20250507171720.1958296-10-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250507171720.1958296-1-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4122; h=from:subject; bh=r0TSHk2W/NdBG12fIoptJ1Vfw+1dK0mtdjaVDG4t/T0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoG5WKUejcXEuHc+JiSAF6B4jdZ+jfL/+PgymyCkPz MciDypaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaBuVigAKCRBM4MiGSL8RyuM1EA CiILFySF/bFhGV24CHAN+Qdwifon1Ljr2Sf8TjlFohnwHpMyLs9HLTAqA2ok+GYLII9WLtRnS7NbZv eMjloayAcWqGj/xJ3N3GOz9a6qEEqBBqCGonAEhMCiBXl2uyh4g7/Mi8oGIhuVXb52PxfA+fvjZDjO TyTSJOxLfXfXvFwzyN0wBpTUTJdirqp9bGQw209JVIBzlgiFWLLzi6w7+jK0t3o797pdh0iHQWOZXA gSdG/vYYGubG9f+Iiv72BRLsIcgJK0OGADCqRzrUqxz/kJkr7Dq7Vb1OXQJkfr+B1XLzpvI7q42yy2 XfZKkNS3Wj03kX/IqJ4xyx18BawranD1M99JbTSox40zm/eb/4OT3rp73g7O1HIanqOTkULh6NP0jY Ti9DoGh2epKTyFlKm/o16lJLimEruYsL8G0WXSSJsBx02gfoVsp1bRrNsV5ScsVNFi5al8GxTLMVI3 dB5AqBTfAiEyglUKm5Njc+jS57Bf3o9UWE8fk+kZui4XU7cNuyHJdKzKnnP1MNcggYtFhVYvgX14L/ 6Aq+oZe7fLGYdo6ujGu5JsU00k5SsxLxGCiEJwZtftbgXKy2/RHu47TlQ2xTz+/FZ25L2aRJGgfzDj XCZrejkD/FbhrICQD3wvod25p/2gsYVn+DKMlxwC9IK9WtY6jetH5JyixGoA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce a new macro that allows printing data similar to bpf_printk(),
but to BPF streams. The first argument is the stream ID, the rest of the
arguments are same as what one would pass to bpf_printk().

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/stream.c         | 10 +++++++--
 tools/lib/bpf/bpf_helpers.h | 44 +++++++++++++++++++++++++++++++------
 2 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index eaf0574866b1..d64975486ad1 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -257,7 +257,12 @@ __bpf_kfunc int bpf_stream_vprintk(struct bpf_stream *stream, const char *fmt__s
 	return ret;
 }
 
-__bpf_kfunc struct bpf_stream *bpf_stream_get(enum bpf_stream_id stream_id, void *aux__ign)
+/* Use int vs enum stream_id here, we use this kfunc in bpf_helpers.h, and
+ * keeping enum stream_id necessitates a complete definition of enum, but we
+ * can't copy it in the header as it may conflict with the definition in
+ * vmlinux.h.
+ */
+__bpf_kfunc struct bpf_stream *bpf_stream_get(int stream_id, void *aux__ign)
 {
 	struct bpf_prog_aux *aux = aux__ign;
 
@@ -351,7 +356,8 @@ __bpf_kfunc struct bpf_stream_elem *bpf_stream_next_elem(struct bpf_stream *stre
 	return elem;
 }
 
-__bpf_kfunc struct bpf_stream *bpf_prog_stream_get(enum bpf_stream_id stream_id, u32 prog_id)
+/* Use int vs enum bpf_stream_id for consistency with bpf_stream_get. */
+__bpf_kfunc struct bpf_stream *bpf_prog_stream_get(int stream_id, u32 prog_id)
 {
 	struct bpf_stream *stream;
 	struct bpf_prog *prog;
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index a50773d4616e..1a748c21e358 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -314,17 +314,47 @@ enum libbpf_tristate {
 			  ___param, sizeof(___param));		\
 })
 
+struct bpf_stream;
+
+extern struct bpf_stream *bpf_stream_get(int stream_id, void *aux__ign) __weak __ksym;
+extern int bpf_stream_vprintk(struct bpf_stream *stream, const char *fmt__str, const void *args,
+			      __u32 len__sz) __weak __ksym;
+
+#define __bpf_stream_vprintk(stream, fmt, args...)				\
+({										\
+	static const char ___fmt[] = fmt;					\
+	unsigned long long ___param[___bpf_narg(args)];				\
+										\
+	_Pragma("GCC diagnostic push")						\
+	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")			\
+	___bpf_fill(___param, args);						\
+	_Pragma("GCC diagnostic pop")						\
+										\
+	int ___id = stream;							\
+	struct bpf_stream *___sptr = bpf_stream_get(___id, NULL);		\
+	if (___sptr)								\
+		bpf_stream_vprintk(___sptr, ___fmt, ___param, sizeof(___param));\
+})
+
 /* Use __bpf_printk when bpf_printk call has 3 or fewer fmt args
- * Otherwise use __bpf_vprintk
+ * Otherwise use __bpf_vprintk. Virtualize choices so stream printk
+ * can override it to bpf_stream_vprintk.
  */
-#define ___bpf_pick_printk(...) \
-	___bpf_nth(_, ##__VA_ARGS__, __bpf_vprintk, __bpf_vprintk, __bpf_vprintk,	\
-		   __bpf_vprintk, __bpf_vprintk, __bpf_vprintk, __bpf_vprintk,		\
-		   __bpf_vprintk, __bpf_vprintk, __bpf_printk /*3*/, __bpf_printk /*2*/,\
-		   __bpf_printk /*1*/, __bpf_printk /*0*/)
+#define ___bpf_pick_printk(choice, choice_3, ...)			\
+	___bpf_nth(_, ##__VA_ARGS__, choice, choice, choice,		\
+		   choice, choice, choice, choice,			\
+		   choice, choice, choice_3 /*3*/, choice_3 /*2*/,	\
+		   choice_3 /*1*/, choice_3 /*0*/)
 
 /* Helper macro to print out debug messages */
-#define bpf_printk(fmt, args...) ___bpf_pick_printk(args)(fmt, ##args)
+#define __bpf_trace_printk(fmt, args...) \
+	___bpf_pick_printk(__bpf_vprintk, __bpf_printk, args)(fmt, ##args)
+#define __bpf_stream_printk(stream, fmt, args...) \
+	___bpf_pick_printk(__bpf_stream_vprintk, __bpf_stream_vprintk, args)(stream, fmt, ##args)
+
+#define bpf_stream_printk(stream, fmt, args...) __bpf_stream_printk(stream, fmt, ##args)
+
+#define bpf_printk(arg, args...) __bpf_trace_printk(arg, ##args)
 
 struct bpf_iter_num;
 
-- 
2.47.1


