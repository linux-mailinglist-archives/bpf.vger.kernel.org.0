Return-Path: <bpf+bounces-75806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A987EC97DF7
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 15:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615533A34CA
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 14:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDC731B806;
	Mon,  1 Dec 2025 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS1Yp/Jz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FFA30FC1F
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764599918; cv=none; b=FLOrx4z14pvGfU2q7GDFtzv5XC8C8L1CdWfeUGjX4uK2D9hRCND4EUo0jdsPt65h8ryMEjT1KtnK2PSbBFZ84biEzk6xMNlX2g12q/cGsSL1+A1aU9oUKlSdQg3HDkn/+ami6cZELPkIIXiO6ElKLfatuby3M0z6BKSxFZpkUB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764599918; c=relaxed/simple;
	bh=HDJieKVU1OPAPmWICR7jITnRxxHe+vYqQPrTd5IfbEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZoReYaJjeSANp/GOd+TyhjFIJ/Y11FD+lfewmIu9w7xrll3UUMy9DsRDeqRp4DU2rxCDaPbxZ1qhsmTq+/HuHgw95FSyT2uunSd/pM3E8lRG5U76eKm6NJX2++eeg18nrgJabpTDYfO/Zmohm6Va3udUkE/BcA6oNspKkwyLSPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GS1Yp/Jz; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-640d790d444so3409059d50.0
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 06:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764599916; x=1765204716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhV+wF32u4YWe4M1PbEZf3RsFPpmY7QIKhhlfIeHA4U=;
        b=GS1Yp/Jzhz5JCvYq7FdQms2sl/KVTBHemdR6laLuVDo2q40I9i3C9SUitNA39Gy9dL
         hlP2X+iAht1JWbydeeZltXELRfp1+cIt3NibrG13aF1VtKw6hPAZl2yMRQbVWFLgQJE4
         NGtJl2u7LMf2eorIYqcm9RpCUH5PX7bev/xKzWFngU9wGw0MtBpFKgXm54e7OSo8B3Z0
         lJWFB6PC/6wzf0CGO+Qxv7URIrUYLxgLuSfQHZ+rI2357Wbuku9WmD7f9KBVkyv+oOSI
         DhLPNJOXgWQg9Sq6Z9HsMcbuS7DXV9bwzHo8M4/6h3gpe/6Svu8PCFZd/D72OdozVS5O
         l/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764599916; x=1765204716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhV+wF32u4YWe4M1PbEZf3RsFPpmY7QIKhhlfIeHA4U=;
        b=fARujd6+Tc982FU0LWDvBrzUOzfjg///RWwPjH9ubkW4VD8inP/CiONNYl8ZoQRm+C
         jXf33D4sx8PlkFhrj2cBfEgkyzGMG11g2BTTXXRwFUS45tLjeLpknfkWeMRy9GUlkldA
         YX60H40BEyqpI/RpOJmwrkAYJcZub0INlDMXUQOAUPzNiNyk4ATWp8TLmDkz8lgLbcQu
         O9yy1Sk84fo2hl41xfcNlsGxovdeB8+m8fv2Xfye51fjHawt+AyMX4YHJ9fgAnxYUXLW
         bCnQcOZxbvtPUWxsEMRj0V7iFg3j+aSxobiFSgOMX45uSdLetv5BGuxIyc2xWHLMnpW4
         l5dw==
X-Forwarded-Encrypted: i=1; AJvYcCVPWsxPFBtWe8UaTvlfrCG3RbzaGI7ngIbUo/o+zLA6Cba+P/Dvu7aqbLJDfIqm6X8Y5Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwXyPOTl620i0542MxC+opHwG+R1v0QHtCsZ9B9epFCdTwGetw
	6J0ZDZPesdNEpkrlWV0xGUeehgSSTI07bR3eEjKftUszKrZ1VCzxhPs8
X-Gm-Gg: ASbGncsZiO7NYxoRCveZVYe/t1e/TBxq2A0NbtMoSz6xU+8XYRdcboNup2CJftTPkY/
	otfmLw9umVH+VYIyKC152JSLH48JDrbyC1BQ794gQ/U8bfcT76aQxh/ZNfQ6DwbjKZ9B1J7OC86
	3Agwy16EUBXidD8j2IduVPZE1Cvh3mrM0pV1Dq73RgOJ2YpNLrLEpx+g5iq3t9cV4bu3q8rkF9F
	a2oDtA9mFMTH+NgnLoJzF7GpJu883f1GALb/kySYJgNtq76lMLxQABNZZcnk8qN7b+tHcmscGGI
	wGIC9PGHXuzmNGyOsEJWDdBYkHPcQzZokICGAE2Y3ClgEJbC4FGEqh4qknqcg4tbM+YzBtEK1zd
	ZKe9PeZFNxeR55liFT12+unLKkssaz8ruk9RPcfQc8S1EZq9xSerwWTjI9OhBaHPuBxgToiWeAP
	I9kzVcEQvT06fOTOrH0CLcSfg9htfPc/QYZN3yJCtuKKMFjqRnvTs=
X-Google-Smtp-Source: AGHT+IGcQ9jCsPCNuCGcwtyK2voFJsZm0s38+03mKZJ/R8oA5ommDWOal1w4eF2QNct+gCkN7wdkhw==
X-Received: by 2002:a53:acd6:0:20b0:641:73e:c50b with SMTP id 956f58d0204a3-64302ab7be9mr24371456d50.47.1764599915963;
        Mon, 01 Dec 2025 06:38:35 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c078297sm4889911d50.9.2025.12.01.06.38.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Dec 2025 06:38:35 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org,
	mattbobrowski@google.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	electronlsr@gmail.com,
	Zesen Liu <ftyg@live.com>,
	Peili Gao <gplhust955@gmail.com>,
	Haoran Ni <haoran.ni.cs@gmail.com>
Subject: [PATCH bpf 1/2] bpf: mark bpf_d_path() buffer as writeable
Date: Mon,  1 Dec 2025 22:38:12 +0800
Message-ID: <20251201143813.5212-2-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251201143813.5212-1-electronlsr@gmail.com>
References: <20251201143813.5212-1-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type
tracking") started distinguishing read vs write accesses performed by
helpers.

The second argument of bpf_d_path() is a pointer to a buffer that the
helper fills with the resulting path. However, its prototype currently
uses ARG_PTR_TO_MEM without MEM_WRITE.

Before 37cce22dbd51, helper accesses were conservatively treated as
potential writes, so this mismatch did not cause issues. Since that
commit, the verifier may incorrectly assume that the buffer contents
are unchanged across the helper call and base its optimizations on this
wrong assumption. This can lead to misbehaviour in BPF programs that
read back the buffer, such as prefix comparisons on the returned path.

Fix this by marking the second argument of bpf_d_path() as
ARG_PTR_TO_MEM | MEM_WRITE so that the verifier correctly models the
write to the caller-provided buffer.

Fixes: 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking")
Co-developed-by: Zesen Liu <ftyg@live.com>
Signed-off-by: Zesen Liu <ftyg@live.com>
Co-developed-by: Peili Gao <gplhust955@gmail.com>
Signed-off-by: Peili Gao <gplhust955@gmail.com>
Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Shuran Liu <electronlsr@gmail.com>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4f87c16d915a..49e0bdaa7a1b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -965,7 +965,7 @@ static const struct bpf_func_proto bpf_d_path_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &bpf_d_path_btf_ids[0],
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.allowed	= bpf_d_path_allowed,
 };
-- 
2.52.0


