Return-Path: <bpf+bounces-50117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B026A22C75
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 12:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A0F3A1E6D
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 11:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A931C1F05;
	Thu, 30 Jan 2025 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="sGYylEUv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E3B1BC065
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738236246; cv=none; b=aiYYe7IXmVwVvMA4iRUGYVh3C3S0LI/NogtteHP+gHEkB6y9ApfDOXyECo2J9bubHDWNfYnOi7NWdkvY8RvaM/j7/FHq6AjyNRgNN87DZbTzHdFb+5o6pzJyl5RvhR/Tl3P1P/EfgoGPrqo7vjHIrzLvvvbtz62HhjwFg3T5M8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738236246; c=relaxed/simple;
	bh=v1oPdERKX3fbXbdEsOpMgyO+3sLyesWUqzTiIeqAIyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MaRpiFFZ9WUTbQMnMzYdV8BEomfBZ1qxN0p3tBa+v7p/98/wq0hq3fAgAauENZVgf6H8oS+d+Tf51yNjyXPnhUrjVNKMXqXSolFE5rx0W13yrtRu9gk3v7AyI2vtlGgCuKyO31wdEgKFDP7o9SH8p4ecbIJib/R5qJ3QJmh1Jco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=sGYylEUv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4363ae65100so7255765e9.0
        for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 03:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1738236243; x=1738841043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xvg6MyU1DU2MCtc9Jk4pLxd20Kiayavou3Y5ZSj56Kg=;
        b=sGYylEUvkqmW0spHPirxF5OUU0dGWZg1DpMJ0/VwU0BYb2fm6GUg9X/5RbqcYIhg5z
         iDK7Se1f282eeYLEtLB3ea9s+GWkt7q6XWm+MFY3/APn7ke3m3puhLmGKF5fmHQXjzY3
         kETRwIMl651b6ZV6CSy4/tJamJWhEsd3Zs33M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738236243; x=1738841043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xvg6MyU1DU2MCtc9Jk4pLxd20Kiayavou3Y5ZSj56Kg=;
        b=p6qPUMX/SJM/tIU24+OMIkrypijqZZJ812hW2d9p8XxrMbU8LHFF/YKrA8jt3m89Yr
         8SDRNXCrEN8fnCc3ZBaLSVc1CPiWwwzsl05Rmw++75w3vNjy59kpaYCYxIXVNiKS9frV
         mQPqDlmdB8rxqyKHmOaVguNcDHrsyxWsw0CunH9xhhy+Y4vc+tz5fEDKHWyFRmuhNBc+
         3HSmQ0J6EYfR2OYawtyoXJF0fu7LYLDrsUQKEkC4O/aH1GTnmw1cetPfEaqKkb0IRQk+
         yv2xPU1a9JO0nRBML+83bedkeA2kpejnUzol/QCs8Iyw5+gaKOHOlHkx/lUiMDXqlWZu
         gVbQ==
X-Gm-Message-State: AOJu0YxmQ4Ix+Zel9olzr4xpQo25aRaRumHBNwpH59J49gZa5MlqcDVm
	eVoceb0KBe25HD2cQ2+VxRhcAS3imqYjTyoSyAZkdNa4ZKxPQ7+V7OUm20KkIjfLJfDVxH4CH2s
	KoCQ=
X-Gm-Gg: ASbGncsSw42wFGmKFAAgmXUy9UTawjEb24iLeIOW1lJkaNdSR6jPfxu0uAzL2wH3/gD
	Pfmh8mCfnOhtm6rXp6Lkfnf7fIeVboch6zGak9f7QXqpjK9pQbYufjxB+nprQ5VurQs4poafYRv
	ibDxYec7dEwSFtm3DbSYpbVbhcSDigudFjGR6IuAAMKyaM6j1I/Ohqc/frG4GPJjt3Swgx8Y4rE
	WKAad1kXI7aC23/tgRrINQlSY8DY3Z38WFMhz7i4RIkaPHMGeO5bq9bvTkZMsTGd+UU0mwYJP95
	aZomuXn7o+4pYeK4thvu4VO1HqMHckjmvodNDnjS6CW+15eeQdQhLR0=
X-Google-Smtp-Source: AGHT+IH03vq/sOIQasPFzmDWm0epxUB+btdz1xpllkROHoDfroHf9sITDYKmZ9/688dg6qn1Q8axiQ==
X-Received: by 2002:a05:6000:18ac:b0:38a:88f8:aadd with SMTP id ffacd0b85a97d-38c520a64b7mr6637706f8f.53.1738236242911;
        Thu, 30 Jan 2025 03:24:02 -0800 (PST)
Received: from localhost.localdomain ([85.196.187.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1b51e1sm1678981f8f.77.2025.01.30.03.24.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jan 2025 03:24:02 -0800 (PST)
From: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Subject: [PATCH v0 1/3] bpf: Introduce tnum_scast as a tnum native sign extension helper
Date: Thu, 30 Jan 2025 13:23:40 +0200
Message-Id: <20250130112342.69843-2-dimitar.kanaliev@siteground.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250130112342.69843-1-dimitar.kanaliev@siteground.com>
References: <20250130112342.69843-1-dimitar.kanaliev@siteground.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a new helper function - tnum_scast(), which
sign-extends a tnum from a smaller integer size to the full 64-bit bpf
register range.

This is achieved by:

Given a tnum (v, m) and target size S bytes:
  1) Mask value/mask to S bytes: val = v & mask, msk = m & mask
  2) If sign bit (bit S*8-1) is unknown (msk has bit set):
    - Extended bits become unknown (mask |= ~value_mask)
    - Sign possibilities constrain value (if sign could be 1, upper bits
     must allow both 0s and 1s)
   3) If sign bit is known:
    - Upper bits follow sign extension of val
    - Mask upper bits then follow sign extension of msk

a) When the sign bit is known:
Assume a tnum with value = 0xFF, mask = 0x00, size = 1, which corresponds
to an 8-bit subregister of value 0xFF. We extract the sign bit position,
compute the value mask, apply it to the lower bits and check the sign bit
at said position.

  s = size * 8 - 1 // 1 * 8 - 1 = 7.
  value_mask = (1ULL << (s + 1)) - 1; // (1 << (7 + 1)) - 1 = 0xFF
  new_value = a.value & value_mask; // 0xFF & 0xFF = 0xFF
  new_mask = a.mask & value_mask; // 0x00 & 0xFF = 0x00
  sign_bit_unknown = (0x00 >> 7) & 1 = 0;  // sign bit is known
  sign_bit_value   = (0xFF >> 7) & 1 = 1;  // with value 1

Because the sign bit is known to be 1, we sign-extend with 1s above bit 7,
so all upper bits [63,8] become 1, new_value in 64 bits is
0xFFFFFFFFFFFFFFFF and new_mask for those bits is 0 (since we know
for sure they are all 1). So after the tnum_scast call and the sign
extension, the tnum is (0xFFFFFFFFFFFFFFFF, 0x0000000000000000),
which corresponds to the 64-bit value -1.

b) When the sign bit is unknown:
Assume a tnum wih value = 0x7F, mask = 0x80, size = 1. In this case the
lower 8 bits [6,0] are known to be 0x7F or b(0111 1111). Bit 7 is
unknown (mask = 0x80), so it could be 0 or 1. This means the subregister
could be 0x7F (+127) or 0xFF (-1), or otherwise anythnig that differs in
bit 7. Following the same operations as the previous example, we get s = 7
and value_mask = 0xFF. Then:

  new_value = a.value & value_mask; // 0x7F & 0xFF = 0x7F
  new_mask = a.mask & value_mask; // 0x80 & 0xFF = 0x80
  sign_bit_unknown = (0x80 >> 7) & 1 = 1; // bit 7 is unknown
  // sign bit is unkown, so we treat upper bits [63,8] as unknown
  new_mask |= ~value_mask;

This leads to a new tnum with value=0x7F, mask=0xFFFFFFFFFFFFFF80
The lower 8 bits can be 0x7F or 0xFF, and the higher 56 bits are fully
unknown. In 64-bit form, this tnum can represent anything from:
0x000000000000007F (+127) if the sign bit is 0 and all higher bits are 0,
up to 0xFFFFFFFFFFFFFFFF (-1) if the sign bit and all higher bits are 1.

Signed-off-by: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
---
 include/linux/tnum.h |  3 +++
 kernel/bpf/tnum.c    | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index 3c13240077b8..6933db04c9ee 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -55,6 +55,9 @@ struct tnum tnum_intersect(struct tnum a, struct tnum b);
 /* Return @a with all but the lowest @size bytes cleared */
 struct tnum tnum_cast(struct tnum a, u8 size);
 
+/* Return @a sign-extended from @size bytes */
+struct tnum tnum_scast(struct tnum a, u8 size);
+
 /* Returns true if @a is a known constant */
 static inline bool tnum_is_const(struct tnum a)
 {
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index 9dbc31b25e3d..cb29dbc793d4 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -157,6 +157,35 @@ struct tnum tnum_cast(struct tnum a, u8 size)
 	return a;
 }
 
+struct tnum tnum_scast(struct tnum a, u8 size)
+{
+	u64 s = size * 8 - 1;
+	u64 sign_mask;
+	u64 value_mask;
+	u64 new_value, new_mask;
+	u64 sign_bit_unknown, sign_bit_value;
+	u64 mask;
+
+	if (size >= 8) {
+		return a;
+	}
+
+	sign_mask = 1ULL << s;
+	value_mask = (1ULL << (s + 1)) - 1;
+
+	new_value = a.value & value_mask;
+	new_mask = a.mask & value_mask;
+
+	sign_bit_unknown = (a.mask >> s) & 1;
+	sign_bit_value = (a.value >> s) & 1;
+
+	mask = ~value_mask;
+	new_mask |= mask & (0 - sign_bit_unknown);
+	new_value |= mask & (0 - ((sign_bit_unknown ^ 1) & sign_bit_value));
+
+	return TNUM(new_value, new_mask);
+}
+
 bool tnum_is_aligned(struct tnum a, u64 size)
 {
 	if (!size)
-- 
2.43.0


