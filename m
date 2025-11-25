Return-Path: <bpf+bounces-75456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112B1C850EC
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 13:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB413B2AFB
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 12:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48CA3242D7;
	Tue, 25 Nov 2025 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="Di7tOTbv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7422D8363
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075442; cv=none; b=e36zXbUNHRvy4RYyJa+CxjLThah3j7arPr8AFJMMxnm9/kPiFAnezR3MMG8WBPzh+YElPJCcecG074GA8wSQwkMtO1BjlCdmVl8YmjNqGMPpUDLTDOym7sqTt8bMQB06d4lMzFVMym1rJwsciTVgtiT5FVKi6wKYJJ1NaMZ8TDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075442; c=relaxed/simple;
	bh=Ru2Ns+TokMVLafEx+QTueQB+WNa/Xf1ygpSb9dSLBBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uAAJGRhWrDme8OJX1VH/ebPntwf3fdQSxDOIzfhxxo+a+FWRkAeASzJrYgmnFa8Eli/8iLGdQTQ6tiNtz8ts1Gmv2D7UDpcOlodW7LNzIVb6lAYH25vEh72A91+80NNBY062Q81LJS63mYSpRdI7ex4UbxsWbV1pAVr1R5W+sk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=Di7tOTbv; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-477632b0621so36829135e9.2
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 04:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1764075437; x=1764680237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvIyDrPREntwLUSQcz5po7GbyScNh/1AdazaUAUh3cg=;
        b=Di7tOTbveLELqYkxbpkXNzmVPyIim8Xhlz2ib3AVB41Sot3RcZnLvtqKCO6WAiOJzq
         gHxDJ0cc18+Vjnby+71Lf6GPU0qAqi6TzVGZPX4AI7IlfsfIk9ccfYZ0IkEJkxQywOkH
         5nh4GFpL91Y0a7b5cLioiQ5CWsHPBXNwYEA1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764075437; x=1764680237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WvIyDrPREntwLUSQcz5po7GbyScNh/1AdazaUAUh3cg=;
        b=wCMTpEHfVCabmm6qSW6CQoAP3tlFrXi0BbAjJMmknGK66C1hU1MVo7Qeu4o/PJt09H
         cfpLua6ngxfzKhUN7Cc3zqvGVAOngQ29/RZKySbfIXJpyq/i0z0QWIYhAbSDLroKKIHi
         WE8sfn3AkHHlkkCt8RzrX5XklB8SFF/M3HkEqSwQbwDJEEr4y/L4NP/8unD+JLn9RHlW
         kj6GoXMN43yIF5F8qjUxqgzQmKLW+CqaflkGqrPtgLNdCCw/efdZanfUhuXLMqA4mTOY
         B9AohxBamuuMH+ari38Hdlugl9Ww601gF4aeBlAFha7sno5T6atqFWM/ompMV30VJGIJ
         gTDQ==
X-Gm-Message-State: AOJu0YwQUEXCWXlQjhBECw/Psjj9w5iZM/gH+0MKZiVZuvmIoilZdyEj
	YcVhoO2/PZHlQFOLLy5zm+eaQgmisgXurLXetrPu59KoLeItEkVbiElwvAT9p9fs4GAFpAaqdqh
	Al7u/NqFoAw==
X-Gm-Gg: ASbGncuafoCuNzi05b8dektyiH6lIKpuDIpw1FbDg+BR3gm7lK68u2gbc+p5lk0rFHt
	VygGlL4N3iG1dCIOV+1sDseyUeNKFAC31I6HNXiP8iGqSSC3jRYtRRjUdwXroCRixMqp1ScITrd
	hULjNnBc/ENPQ1oQ1unDEayrTyn+y5rX3dtUAAWFnZrF4jF2rYjLpJ9j4k9r46lMnSTiQG5ouWp
	Pzowvr3SjlQvOkKkszaOFhtAqPAcBZga/uudyqlUuo+iUS2L2UnQZNLzEE+rLzx4ZXVkozx4BY4
	vFZeYQJuR1FSCox6SlGrmQ6tCicgqyB9hjC0UlnxEsBJU4DUQO/bUsv1R0QfeDR6NyUMY7uzpdR
	w3K4oRAv9EgxJCWJSlB7uSo0yTScgZ5mZnxPbtRXq7qcIBGMZh9KbIXUGqfU/Fl4fhhc1z0onQg
	S5xOXnHS8EsSUzgp0Afamxab8gqft3p+tS727U/mSp9H5Eu0pSpJXSi8ub/EdwFA==
X-Google-Smtp-Source: AGHT+IG63byBI48M07rjrY9paIdwzEDWoy11Ovch8p2ejNqfuQo6o3epd6S1w8egfh1/0E1F5ygs2w==
X-Received: by 2002:a05:600c:4591:b0:477:b642:9dbf with SMTP id 5b1f17b1804b1-477c1132adbmr151945225e9.32.1764075437229;
        Tue, 25 Nov 2025 04:57:17 -0800 (PST)
Received: from Dimitar_Kanaliev.sgnet.lan ([82.118.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1f3e63sm256668925e9.7.2025.11.25.04.57.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Nov 2025 04:57:16 -0800 (PST)
From: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Subject: [PATCH v1 1/3] bpf: Introduce tnum_scast as a tnum native sign extension helper
Date: Tue, 25 Nov 2025 14:56:32 +0200
Message-Id: <20251125125634.2671-2-dimitar.kanaliev@siteground.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251125125634.2671-1-dimitar.kanaliev@siteground.com>
References: <20251125125634.2671-1-dimitar.kanaliev@siteground.com>
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

This is achieved by utilizing the native sign-extension behavior of signed
64-bit integers. By casting the value and mask to s64, shifting left to
align the target sign bit with the 64-bit MSB, and then performing an
arithmetic right shift, the sign bit is automatically propagated to the
upper bits.

For the mask, this works because if the sign bit is unknown (1), the
arithmetic shift propagates 1s (making upper bits unknonw). If known (0),
it propagates 0s (making upper bits known).

a) When the sign bit is known:
Assume a tnum with value = 0xFF, mask = 0x00, size = 1, which corresponds
to an 8-bit subregister of value 0xFF (-1 in 8 bits).
  s = 64 - 8 = 56
  value = ((s64)0xFF << 56) >> 56; // 0xFF...FF (-1)
  mask  = ((s64)0x00 << 56) >> 56; // 0x00...00

Because the sign bit is known to be 1, we sign-extend with 1s. The
resulting tnum is (0xFFFFFFFFFFFFFFFF, 0x0000000000000000).

b) When the sign bit is unknown:
Assume a tnum with value = 0x7F, mask = 0x80, size = 1.
  s = 56
  value = ((s64)0x7F << 56) >> 56; // 0x00...7F
  mask  = ((s64)0x80 << 56) >> 56; // 0xFF...80

The lower 8 bits can be 0x7F or 0xFF. The mask sign bit was 1 (unknown),
so the arithmetic shift propagated 1s, making all higher 56 bits unknown.
In 64-bit form, this tnum correctly represents the range from
0x000000000000007F (+127) to 0xFFFFFFFFFFFFFFFF (-1).

Signed-off-by: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
---
 include/linux/tnum.h |  3 +++
 kernel/bpf/tnum.c    | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index c52b862dad45..ed18ee1148b6 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -63,6 +63,9 @@ struct tnum tnum_union(struct tnum t1, struct tnum t2);
 /* Return @a with all but the lowest @size bytes cleared */
 struct tnum tnum_cast(struct tnum a, u8 size);
 
+/* Return @a sign-extended from @size bytes */
+struct tnum tnum_scast(struct tnum a, u8 size);
+
 /* Returns true if @a is a known constant */
 static inline bool tnum_is_const(struct tnum a)
 {
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index f8e70e9c3998..eabcec2ebc26 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -199,6 +199,19 @@ struct tnum tnum_cast(struct tnum a, u8 size)
 	return a;
 }
 
+struct tnum tnum_scast(struct tnum a, u8 size)
+{
+	u8 s = 64 - size * 8;
+	u64 value, mask;
+
+	if (size >= 8)
+		return a;
+
+	value = ((s64)a.value << s) >> s;
+	mask = ((s64)a.mask << s) >> s;
+	return TNUM(value, mask);
+}
+
 bool tnum_is_aligned(struct tnum a, u64 size)
 {
 	if (!size)
-- 
2.43.0


