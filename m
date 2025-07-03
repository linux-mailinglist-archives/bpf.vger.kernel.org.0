Return-Path: <bpf+bounces-62331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB65AF8213
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 22:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963841C857E1
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 20:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8042F2BDC26;
	Thu,  3 Jul 2025 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l54plXK9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54355258CDC
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 20:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751575710; cv=none; b=EJ60c2QNylBmypeELD2sY9/PKK4cdgbfKDEjNzYDI0CD84lKcEzO0I9aW7TGcUfEvnTJllLq+b8axf3WkC/AwvQ1tBE8BUHQHA4Gy7owcIQY1hqgZzWBKpDbFhf+35PDoggOyGIVuKvbbxXbLM75s2k742zRvUNh8N06M0pTQLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751575710; c=relaxed/simple;
	bh=DV4sLiCvzIcl8w2ve0tUKG6BCWp1i2hpSmJ0bpBSoUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkD75Z8t7SLpdi/VUiBVqtYI/0DBr1E2ij4v70wvFhorGSFpRYKakBRgBWajjPeA7lNSFuBqIAAQvee4vlB6vL1sxfqF1IiF4LxzEmIpiu93Skdt5bnxmOo4QnILxkR1xTR1RhkZgX0cV91nXTI0QXn7eRc/iDlO1pxivOncs74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l54plXK9; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so50711966b.2
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751575705; x=1752180505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4EMnBy3TvwkYSC5e11BvnvdCBYnS/Hse4vtXea6zAo=;
        b=l54plXK9l1kOXUWGZDSat4le45P22C3envV45p/nj6PNc7HNFr2BANNBwXfGWqbFXl
         /onEYU5p/rayMRnZZUuoqQOuwwS7kvKNQgpPPiLrkibdfbkLVer7IPW7nx6DRLZc8rye
         usz26skHIDcvd68OHSTT2t+mPhNW6NowP53IsyspR1pGHLSYAbCxg+LwbppVz7Erio4g
         mtu9gGVVCNICHvEenm19ec0+hDREnGcZFe5ad6e/ONFvC+L+0iI1lgZSlMzn7oN37/og
         agO445rzUN0IunwPpcvKK+qINJUVC8AzuLE1WDUV6Nr3RMCBf/rA4gr8oUDemwQRqgx9
         0Afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751575705; x=1752180505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4EMnBy3TvwkYSC5e11BvnvdCBYnS/Hse4vtXea6zAo=;
        b=CkKW4Z9lgoh2aAAmDn0FJP8bk79ETtvCL99KNMbrhCUg5EK86ZaAWjJsNtihO4yeRb
         j3779WFRUxGGBLRXylpltf+6e1QEOCsxkAS8sZDJ96U3+bw8mG0cc3Yeuc3Jr0p738ol
         p54NOn7uTw6hV0iOqLNTeZSbWWwfaeCe5OnALRqySVjrTUGwG7Dj2VMPdpHQ4u7akAKr
         B1HACjcfaObUukOEfsXouaxowxt5WAQem1YKlPfcAfz5ro3W6dn/1rZ2eU3La9GDlmYd
         VyTRCURMEqFq67nrFlxtVJNSaHrq5be7a+1JbOesnwcD4fUHHzYYEnr8P6bbLJckZLVn
         FRRw==
X-Gm-Message-State: AOJu0Yy+hmyUHKPpu3LdQIUdglFga6T42inSSHJQOz7ia7aOKSwwTKeT
	1brhbcWII0tdbjr6hEU1DZLdcTpnDvZVOIat/hFBwMeKDN45XhKnu3QuM5pE9ogCLkM=
X-Gm-Gg: ASbGncsrt8s2QXAyQlffumswK2v/uhm07m+wBVdnQUQSmAuPDTXoZ6fdBUJboSgmlqA
	20UuIKysu8jAQzotvssH76PKe6Ds6Enr+eBKWOoY1BEovu/hyOQbEIuZXeG7g0pq5Ec6VJOL3HM
	Bd7xDO6Ej4Ye6+36T0pF1LKMZVz9vDH8jGU4V7qhopOxJzeBkCiVjhIiHii8ZMEUlyfm6tXhv1v
	0PAV3z0juaXp76iiZCg7ILYCSwYgqeqaxripQsfZslH2SLy55pvmdt5umnAFsWqxS/OZGYTvtNW
	xWktOrk4rSibLIGk3+Aogw/IHvwJWMF0VxwHBojRfoKXCnJXF25V
X-Google-Smtp-Source: AGHT+IGG2TX6OwQfzaOvLjEJOV5+vLt6pgMR8r5FR6xn7mNE04DMxNj6oasNhQqnWoazDxmLjKMNgA==
X-Received: by 2002:a17:907:86a1:b0:ae3:cd73:efbc with SMTP id a640c23a62f3a-ae3d8b1ef44mr479973566b.46.1751575705183;
        Thu, 03 Jul 2025 13:48:25 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b5e757sm37272066b.156.2025.07.03.13.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 13:48:24 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 01/12] bpf: Refactor bprintf buffer support
Date: Thu,  3 Jul 2025 13:48:07 -0700
Message-ID: <20250703204818.925464-2-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703204818.925464-1-memxor@gmail.com>
References: <20250703204818.925464-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4136; h=from:subject; bh=DV4sLiCvzIcl8w2ve0tUKG6BCWp1i2hpSmJ0bpBSoUU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZudLZubaehjm3LWRIvLlk+29qOx883+KM2rYTVr7 btbg5myJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGbnSwAKCRBM4MiGSL8RysSZD/ 4xUsSLBRK5k4o0nj2z1J0oFalfy7SMttoG/0cd3Wz5D6SIBjwYYz+mET9E6t3xGpEua/bwuKmyztF1 gAoKINu1KV1Qp9Fei/+EIrU8bQFizpJK4+XmEtKZXJztx2aYFhz+PTy2OAal0omhd2pPZEHdYTh4Uj VfYRJfVS5MlCVOUBKHZEWpg1mGpQpGatiw1ZqHoJj/y2B96h2YQG14YCTMkD+A7L8AsHcRH2UJp7wO zB+XuQwcFq9RczR4QE6O752vBfZd/VjUwSm4LRU9rF5OBrPmdvfr7xQ5/rQyx1rd2AIhove78HzY5h PTgba9aMt+EH8iV2WRqj/uUzA4J6LagZYc2+FyMuyTRMBkhcyTZGm4izY3tgf0KUQU4QdgYCb2a/6y tXnSFW7lBsEtTaPfLEOL5q9+q+Y4iN316DhWB0xPHiOvSe1ehd4C8qWhi+tUCMazhfGNFLOo3EieYj 0mzJ4DPd1mmGkajbpcPfcxq4JF6HlOFDHkqF4OvHa2ZW4s98xiwuQTBqtop2F0/SnxxhEB2Tr/sxGt IudP6r5u/icSat3w41om98r8ro+nWpx5+XB+vCGpw2rkFgbRf/XJhAiMC4gTHG8mu3rTTCAIzQPbP3 YWLjuc2l6w6xHYNccanrMUNBcOr3UqBmv8AyIIoFZKE/rU1UvYHEfFxrZVdg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Refactor code to be able to get and put bprintf buffers and use
bpf_printf_prepare independently. This will be used in the next patch to
implement BPF streams support, particularly as a staging buffer for
strings that need to be formatted and then allocated and pushed into a
stream.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h  | 15 ++++++++++++++-
 kernel/bpf/helpers.c | 26 +++++++++++---------------
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5dd556e89cce..4fff0cee8622 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3550,6 +3550,16 @@ bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 #define MAX_BPRINTF_VARARGS		12
 #define MAX_BPRINTF_BUF			1024
 
+/* Per-cpu temp buffers used by printf-like helpers to store the bprintf binary
+ * arguments representation.
+ */
+#define MAX_BPRINTF_BIN_ARGS	512
+
+struct bpf_bprintf_buffers {
+	char bin_args[MAX_BPRINTF_BIN_ARGS];
+	char buf[MAX_BPRINTF_BUF];
+};
+
 struct bpf_bprintf_data {
 	u32 *bin_args;
 	char *buf;
@@ -3557,9 +3567,12 @@ struct bpf_bprintf_data {
 	bool get_buf;
 };
 
-int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
+int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 			u32 num_args, struct bpf_bprintf_data *data);
 void bpf_bprintf_cleanup(struct bpf_bprintf_data *data);
+int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs);
+void bpf_put_buffers(void);
+
 
 #ifdef CONFIG_BPF_LSM
 void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f48fa3fe8dec..8f1cc1d525db 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -764,22 +764,13 @@ static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
 	return -EINVAL;
 }
 
-/* Per-cpu temp buffers used by printf-like helpers to store the bprintf binary
- * arguments representation.
- */
-#define MAX_BPRINTF_BIN_ARGS	512
-
 /* Support executing three nested bprintf helper calls on a given CPU */
 #define MAX_BPRINTF_NEST_LEVEL	3
-struct bpf_bprintf_buffers {
-	char bin_args[MAX_BPRINTF_BIN_ARGS];
-	char buf[MAX_BPRINTF_BUF];
-};
 
 static DEFINE_PER_CPU(struct bpf_bprintf_buffers[MAX_BPRINTF_NEST_LEVEL], bpf_bprintf_bufs);
 static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
 
-static int try_get_buffers(struct bpf_bprintf_buffers **bufs)
+int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
 {
 	int nest_level;
 
@@ -795,16 +786,21 @@ static int try_get_buffers(struct bpf_bprintf_buffers **bufs)
 	return 0;
 }
 
-void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
+void bpf_put_buffers(void)
 {
-	if (!data->bin_args && !data->buf)
-		return;
 	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
 		return;
 	this_cpu_dec(bpf_bprintf_nest_level);
 	preempt_enable();
 }
 
+void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
+{
+	if (!data->bin_args && !data->buf)
+		return;
+	bpf_put_buffers();
+}
+
 /*
  * bpf_bprintf_prepare - Generic pass on format strings for bprintf-like helpers
  *
@@ -819,7 +815,7 @@ void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
  * In argument preparation mode, if 0 is returned, safe temporary buffers are
  * allocated and bpf_bprintf_cleanup should be called to free them after use.
  */
-int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
+int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 			u32 num_args, struct bpf_bprintf_data *data)
 {
 	bool get_buffers = (data->get_bin_args && num_args) || data->get_buf;
@@ -835,7 +831,7 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 		return -EINVAL;
 	fmt_size = fmt_end - fmt;
 
-	if (get_buffers && try_get_buffers(&buffers))
+	if (get_buffers && bpf_try_get_buffers(&buffers))
 		return -EBUSY;
 
 	if (data->get_bin_args) {
-- 
2.47.1


