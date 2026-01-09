Return-Path: <bpf+bounces-78319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0614D0A5EE
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 14:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D13B7317927A
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 13:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C8635BDD9;
	Fri,  9 Jan 2026 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijRnA9f9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E30335C1AD
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963626; cv=none; b=lj6nU4gahZ2b4D0kpvBFIlEhr2kU3N09FhBuarcpsl6NXnwAcmLrbcbcs6Ud/sdd/KvfvLDJ85ic/jDCYOdD03cF2Wiq91S6zzbZQUuFSXlTwKfSVaAIBtIYHRTCDiZ5fEmUbqx+b8d2gY5GQrfZ1K5z720V3TVvurR0petL5zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963626; c=relaxed/simple;
	bh=fY4SCqw0Jj0ycW7LlAgR+ivoerZhzv0oqJ15lIreNgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mhKeug6oMFKl7KOdgVnophBrlgitVUxVSHoC4yi4ZxVcHRiBv4m42Owtx+g3R4SHx6HUbTxmh6+2E7BwcZoe7Rf8ahSXNECHSSUJP7GCVCwjc2yidko+Ft/26uZVf6cXCBnRQgO4FzRU9y0wXBZQuy68EzFkTwrhkb8nCKP08es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijRnA9f9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0fe77d141so34095385ad.1
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 05:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767963625; x=1768568425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wivrf32mp+JOZE3ooRkX5rorWk008Ji1LAtUMbmfi0s=;
        b=ijRnA9f9i8BQUmREMnx5/t4J+B5kGmiKmNFHAAUt5//eYtLcThFSVjH256FmPubtUF
         xj67Tja8P1wgA6s5qUWG1oOl5YsSiJXDASLNNG0NR34ZKHu5fZUWmf/0479DGiyBPCRG
         QBflq9gGBGIpnwC1sHGq1ohmB2UftMznRJ1dX1M63gDRo6subuodHPQYNVoXVAxXJTw7
         8lAdP2fSKlrq73rL2uxzAhbNcQl5c/M1LZXwHGo0gGq1+Fw7VlN3Dt8dQWpn/2vpZj60
         6//yL06BB0GswdXIEemiXwlbCh221Sy8xjLMPDjzqd7k12s+FYAi5RZwpg6xEI+jkXYK
         Nntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963625; x=1768568425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wivrf32mp+JOZE3ooRkX5rorWk008Ji1LAtUMbmfi0s=;
        b=h0yWxoP9dtaocffWjc6rLQ91DnQnozKnUL2VIbxAy13jVIV4i7bTUTLDHqysumSzao
         gr20TKwGGJLX8TWg0hU6lI9R6fizcOyvH5gyE7XxjRNySHGJySi3QXLU45JqWLoz9K5V
         7p5DkZVaoDHi3IBMlerNdPKugCrFTmwY/qgAJDh5QYR6RDXmKUTGQ9Mn2E1FD9o3lBZd
         YJ8ueq4VCjXsIu6T1vgucoIgNglxrQhttxpvaoBf79PlI7UsE+9RnEsCEkfl3FFOXPJ3
         ucG6gXlGx4kp6npdKav11NI6/JUeoQuO9Mj9PlUsls90K2hgTvOrrFkrCjajfHCYIw1D
         euZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe6mGs6GbNdHZiB9mrrD+zdIh6sFH4ES9+resnRzUVWnVJkyqCTWbEPap1O9P8481/96w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUiXfEElR9lg7pJq/rrrqGOr63hfBi3wHy/h9kXsKvptpfDfOk
	EInkM6UQeZpBJpDLEsV5TDy2HNq0v3bIN5QTmPMtmUXKjzZc2ZbOzfk7
X-Gm-Gg: AY/fxX6GYw06RnkONtZiocPeaRyxeIWbwgcRhOczN6FjdsLLoQxhZ/UodrZUl/5HMfX
	nB2G9aFrUjmBqfLPnIavLqj6THmu4BpH911a88blQF80fihsTHmR4EyJ2vavgR5o2KxAbtKo2+E
	e4ak9pg/ha3PBvxQ5GvDvbKKUYt1TNyzJMKkYolyxXG1oeu3Jgy6cv0jznLGKkDkPFIZptQMPgU
	ogBzH0GtiUkQ/KR7QM95kLPt9SFKMHGikaXti3tZu/eBKVyTPDnDyJ9hpyxMI8eeJ0l6ihwTswF
	nKxYBnQc0jmVBdriSUNoTxPv+wfvsJ7dB1Ig2mHR8PCXaAdMkx21wjKE5VKxKTtWIHy2sGb/yHS
	/LaL8aFX3uY/r5/9Z9nUUOHwGTfaSbytyZiTW/WnEGF1aInUdHbE4xYvfd+BDfWBc72YUfysA//
	/+rIwtomckEpg/CBnkCrB0uo/lDHo=
X-Google-Smtp-Source: AGHT+IFjhcrfN6VEyGHpwi6WOA2pu0tBfNL1P3vPmYQwVhUTFDIX7kF8O3o8DgZ/DuuiiTu25Bv5Bw==
X-Received: by 2002:a17:903:1aab:b0:29b:e512:752e with SMTP id d9443c01a7336-2a3ee4dca3bmr100294515ad.47.1767963624328;
        Fri, 09 Jan 2026 05:00:24 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a328sm104927325ad.4.2026.01.09.05.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:00:23 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v12 05/11] libbpf: Verify BTF sorting
Date: Fri,  9 Jan 2026 20:59:57 +0800
Message-Id: <20260109130003.3313716-6-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109130003.3313716-1-dolinux.peng@gmail.com>
References: <20260109130003.3313716-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

This patch checks whether the BTF is sorted by name in ascending
order. If sorted, binary search will be used when looking up types.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 02407a022afb..9a864de59597 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -899,6 +899,30 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
 	return type_id;
 }
 
+static void btf_check_sorted(struct btf *btf)
+{
+	__u32 i, n, named_start_id = 0;
+
+	n = btf__type_cnt(btf);
+	for (i = btf->start_id + 1; i < n; i++) {
+		struct btf_type *ta = btf_type_by_id(btf, i - 1);
+		struct btf_type *tb = btf_type_by_id(btf, i);
+		const char *na = btf__str_by_offset(btf, ta->name_off);
+		const char *nb = btf__str_by_offset(btf, tb->name_off);
+
+		if (strcmp(na, nb) > 0)
+			return;
+
+		if (named_start_id == 0 && na[0] != '\0')
+			named_start_id = i - 1;
+		if (named_start_id == 0 && nb[0] != '\0')
+			named_start_id = i;
+	}
+
+	if (named_start_id)
+		btf->named_start_id = named_start_id;
+}
+
 static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, const char *name,
 					   __s32 start_id)
 {
@@ -1132,6 +1156,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	err = err ?: btf_sanity_check(btf);
 	if (err)
 		goto done;
+	btf_check_sorted(btf);
 
 done:
 	if (err) {
-- 
2.34.1


