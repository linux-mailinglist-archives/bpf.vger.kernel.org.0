Return-Path: <bpf+bounces-20060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAE68380A4
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 03:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F419F1C235FF
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 02:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9102B131E32;
	Tue, 23 Jan 2024 01:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a2Idl6M/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF92131727
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971824; cv=none; b=HU9rfpEFqGGOooPSEAZOWdRmOHRlZrZRd0sXskvWxj11uou+vGQapXzH/bB5PcZHC2EKZW/PQjCVCkX+pCcnPZKun+tqaQ7w9+7jpPgmhFTTH3EENF3i6JJNplOec4NKKUPuE2g46ENneoeaNxuhM2LnT5yIAMLeQWxMMHNKkmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971824; c=relaxed/simple;
	bh=2D/1q+K5ofLS3QNrb17mBia21R1L5nS1NTJwK1+Jywo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pruDOnKHfUIOze9MOrnQOXokfyYoCTcZ+TfJIj+BzqCSQD1rLUs/2YHTd6y7iOzCNg6fVAqcGDLt3/TpXzJrer79x9l47wrTrm194EH+UxoGZw7oHJ1+UjKURJFssG+4IbuTUTd4VJ7e5czat80xEZk9e38oikZvQod1EyWwj1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a2Idl6M/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d730b6943bso6791525ad.2
        for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 17:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705971822; x=1706576622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzCem6cup4TdiKSfzyjJWNqgMtspOXnXOALwscH4Wdk=;
        b=a2Idl6M/nB7uU5CS8xxzI/5QidtiR6E4Q3sFDrKD1RsiwxD4SvHlSntigxg2OfCWvP
         c8rfPE7nnYFHY2q1SxwpkUVxKwA5u1ZiZCJSyFpIRafFLbOAjEGK8VLDKHK1f0EPZK9c
         DfyzEhjlT9cFFPR3DAiY0bQeHB4rNqJhDAha4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705971822; x=1706576622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzCem6cup4TdiKSfzyjJWNqgMtspOXnXOALwscH4Wdk=;
        b=YXp9APGHJDkcgqbGFDMU6VNm3Msnvl5Ws2fA4O301xtID4g8Wj7RRRDQHilIULiywq
         WV2crH7rn5hxPSAxL1i2hRt7nlRTxQPO5ojwa9gSq6pYs1NVSKKME99oP3z0Q1mpiGPd
         caXgXPnz1jKQKWbVVz2oYnWRY+e5+4ZOWg3sTUYUnrkbmiQPIfYhXvy9P5+mrG0n27JH
         waREMUxrWjfOARr66LGRF6vMQ0Ytb1jWBOjO5cYVBEyj/OxyZJdzHCz0b2DaFC9SJO70
         2BT56fmFfj9sOpUh+FvcfxDj86UrzNjFygOwaTsR+G3jtrW5qv4lMVK5dZvzCBmR+EAq
         3UKg==
X-Gm-Message-State: AOJu0Ywgq8QBpTFG4O7+uwWFMtA/7YtFKXQ8QJkyKZyLquHfoXHyo2gz
	01lRbcBVg0zg3c8SfWGvElKspkF2U6oO7FtmyJ03k/9p7S1awwNX2WnpMyvZOg==
X-Google-Smtp-Source: AGHT+IEInhZKVZDWnoUM/i8YQ5PB4DUxgiRH9R14Uyh3DsT8C3iOPJNGdMjkH5Jny8EX7IKezJTeTA==
X-Received: by 2002:a17:902:8e8a:b0:1d4:2ebf:66e9 with SMTP id bg10-20020a1709028e8a00b001d42ebf66e9mr2195121plb.66.1705971822051;
        Mon, 22 Jan 2024 17:03:42 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902f29100b001d707a14316sm7510636plc.75.2024.01.22.17.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 17:03:38 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 43/82] bpf: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:18 -0800
Message-Id: <20240123002814.1396804-43-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3267; i=keescook@chromium.org;
 h=from:subject; bh=2D/1q+K5ofLS3QNrb17mBia21R1L5nS1NTJwK1+Jywo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgIT/Z3KUQ2veJhvQyEt4ONL7c5mrClKFuYO
 X8phZz1OWKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICAAKCRCJcvTf3G3A
 JkHTD/4qgBnK24plRIXO+yoz2iQ+LnLu7ceo46R+EFzo/2zE4dZ+2u1CDIt1eEMllnG7GdIK+rx
 pbMn643YxLdpkcs5J68KMVdKkniWV1XXHwbVnmqxCo4f3HtuQS09iFdsyX5XJs2halhjXZuW75R
 y811Tm0ilp4N9T2dCDFe9xf02ruR51njy47egnuRN0VU3wH5eVAM2v+jk3FCeD3rlPEUpSpDQ6P
 IbHZAs1mjAVXG/iORESIdH1l+V5XRdrAhwLvmouMutwbyBdRSeemCsROlWgyRUEMAyCYANg0N2J
 iFtFwycRzbLWW6oOtS9lcxUUXATx7bjcDODVDigeUo9lnVhJgT4k3Eox4y7Xsl6jC7/Wo6rdWDk
 tWxp2TXKIwFm7GrPKQ9G6WCadosfMVqMKU9XxyQU+LGrgXVuV2vtDworRcNS4cTWKdWH32fhgnm
 PbPrx493hufpiEUxiHBg5a0Cx3Vp0nGNmEUyLl0IICmlG8MJJSdrh6iubiBRHOgFdZZIN0MGO0D
 jipUiaIzyLiQ0IoPELof8qAAkUP239U2GzBeV6tfZDmRwot08eR3a1n4Ghqvp72J6PkxFLB94r9
 /D9CqYn4moMTyD6tGRDSqYZ7623ETbGfVy32TpB8S7loBlaOQTbv+FJCb2GqADyXmCvziiN3rOI GVEF4TSjuaYfhyw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/bpf/verifier.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 65f598694d55..21e3f30c8757 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12901,8 +12901,8 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			dst_reg->smin_value = smin_ptr + smin_val;
 			dst_reg->smax_value = smax_ptr + smax_val;
 		}
-		if (umin_ptr + umin_val < umin_ptr ||
-		    umax_ptr + umax_val < umax_ptr) {
+		if (add_would_overflow(umin_ptr, umin_val) ||
+		    add_would_overflow(umax_ptr, umax_val)) {
 			dst_reg->umin_value = 0;
 			dst_reg->umax_value = U64_MAX;
 		} else {
@@ -13023,8 +13023,8 @@ static void scalar32_min_max_add(struct bpf_reg_state *dst_reg,
 		dst_reg->s32_min_value += smin_val;
 		dst_reg->s32_max_value += smax_val;
 	}
-	if (dst_reg->u32_min_value + umin_val < umin_val ||
-	    dst_reg->u32_max_value + umax_val < umax_val) {
+	if (add_would_overflow(umin_val, dst_reg->u32_min_value) ||
+	    add_would_overflow(umax_val, dst_reg->u32_max_value)) {
 		dst_reg->u32_min_value = 0;
 		dst_reg->u32_max_value = U32_MAX;
 	} else {
@@ -13049,8 +13049,8 @@ static void scalar_min_max_add(struct bpf_reg_state *dst_reg,
 		dst_reg->smin_value += smin_val;
 		dst_reg->smax_value += smax_val;
 	}
-	if (dst_reg->umin_value + umin_val < umin_val ||
-	    dst_reg->umax_value + umax_val < umax_val) {
+	if (add_would_overflow(umin_val, dst_reg->umin_value) ||
+	    add_would_overflow(umax_val, dst_reg->umax_value)) {
 		dst_reg->umin_value = 0;
 		dst_reg->umax_value = U64_MAX;
 	} else {
-- 
2.34.1


