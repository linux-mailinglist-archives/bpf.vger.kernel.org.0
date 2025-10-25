Return-Path: <bpf+bounces-72194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD35C09DB5
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 19:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A09414F389F
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 16:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675A83164DB;
	Sat, 25 Oct 2025 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsqXuqo/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5965B3161B1
	for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410474; cv=none; b=dmupRTfxrmuWfRGbNnhkWUFBDIe6t7mQdoQ7Q3v3b9jDHBTGYhvasZ40TSw0di6bAwxuYJGkr4VbXYtg8a+RjZNq922OHoCLb4eJGn76YpNLX1CjkvRuFSoiqy0tT3JYB+F/omO9EKWWMdmJajg/gXZaTS98SSCGK+Kd2iLywVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410474; c=relaxed/simple;
	bh=BQ3V3TJBGcgRl9M8TTeR9VPGV9MIeZxMNrPM3NKIWvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCE+qRDrphCfe3LTweGZAZYEL3ddBeWWz5e+it36LimsL93so/7m3fZxAsJJiOVWvGvGFWBPDjvyyhBQYAr44NxFfDyd6+xPRS7hd7LRCAHo6UwhHZkh9zgbVLmb7FZHyRw2rV+a8J2ZwbezPQ7u+lL4kTQBp/SedFz4rv5k9DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsqXuqo/; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-87c1ceac7d7so32370196d6.1
        for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 09:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410471; x=1762015271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsJVQgpn61zq+Ge6F8BtEeBoOu3oJNRDvnauUG9sJYA=;
        b=WsqXuqo/Tuhsx8Pu0PZaNI1ZZo6qxE87GS5+EtiO+N9LGzOtQ0k5M+00e2KHd+385p
         j5yXdY/w0jMFqwq/onjBqTNQ8Y0u8pEGljdMCSje/jq0JsBcwi3VB79cWCQtzOFmOdye
         4cL9exeCbeQ+uBHJ1vG8Y7quQKeLMwHy7229GKW6zW7+9d1noMeGoI7TnN9bQ3vI4qRl
         +detcSFdjJZH66iobjs66pNk3Dcju2KrfPnoE9CHyqKlSagJT5Exukig/i6+uSC6uMIw
         QCWGGGkyk1Yj3bVgea9m7NlkeEmjUvjQZZWemkavL35xK3kxORktOPwPcI38y2fD8TJh
         1RVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410471; x=1762015271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsJVQgpn61zq+Ge6F8BtEeBoOu3oJNRDvnauUG9sJYA=;
        b=t5f/8VosEm4s+v5ZwYi1L/RWBEkZ+8iJ3cxOG002+Sx0shD0lf0NxO1qGCkpadbxMx
         d2iaSYOaWxDL457Hyq3F+ObyLo0jJ6fq2HiTEzExgrsgBlavK4v2UBcffN5/QpbhjRmd
         ercBWVL9rMYm+ild+iN64qgga/3C2IO8CIXwzdbr7vDnsVnoMxCbT2Ss4zgN3f4WgZbr
         oPIqn/y/397dod/is4tj1T8iIL2sVlxU14tPU+/ZTsnlurvgRT9WrPrcz1tjCJNyLlxf
         qFKfiuAQUqrlQzWjTF5HO3jv2aInAS666edV7kWNETa4mc2Q1Vu5kg3TACzP6JV5ymZq
         rz6g==
X-Forwarded-Encrypted: i=1; AJvYcCXwAjg5QbJxp4ygACD2OICZXaRM5keA+MkErdMgeThYXo++uy2HsoerbgqMqhBOQIRqfXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1scaxoIY/09jM475do+pkKjBoeIlCM/UeRbxYMr7pzgscB4iO
	ZnZYPfQDaUEcfTTW6d2OVGAkmWfNpFzSa2rbQe1+LkMECdVlCNLDfDhX
X-Gm-Gg: ASbGncujklSSMkzktYgwKHFK3CgnERM29vKLX4C9jK9zIik6JyjL8p+7Cgt0K1fcwNH
	FscsvCIYhZbT/4KpZJugMqyrecltRyxKMZpdIFRD35HsC/u5RLVO4hfCyaDQIZxgfaebpeFicQu
	C3cjAcPp+DytZxfu+8Pj+GVqC9MxIC7e+5ILK4ZXFUP+BXjbXA6GJ4xsnHjCzAv5nsnQ5ao92f/
	eElb5Owf/FcEVWoFAtu7rJrIg5pEL7/Ya9mgFqSF5X3XjjUSNL0ogVnA9tCkCjO71ms7u91roxT
	GD8y9HAPtR2NEQa0bA4qVYspg8Xc2xFnoWZrtANWxUODsCNm/dOrmTwf1ritBoxd7ZWKww4GMSj
	Vl2szgFLYADsFJa38koaFePYcwJ+iQw8t+JiyIiEFLP1eOW4nK4rWm/VS/5sKswdNy3HeNxHg
X-Google-Smtp-Source: AGHT+IEL1Dx+4HYqw+4sQyuOiRieC9Old4SO4wr/AN35TA8qAjfv9mLDb5RqV2L9cyVVu7WfD8Eouw==
X-Received: by 2002:a05:6214:2aa2:b0:87f:bb8e:410f with SMTP id 6a1803df08f44-87fbb8e4dfamr72431596d6.50.1761410471178;
        Sat, 25 Oct 2025 09:41:11 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc49783eesm16403476d6.44.2025.10.25.09.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:41:10 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Alexei Starovoitov <ast@kernel.org>,
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 15/21] bpf: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:40:14 -0400
Message-ID: <20251025164023.308884-16-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(high, low) notation is confusing. BITS(low, high) is more
appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff40e5e65c43..a9d690d3a507 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17676,7 +17676,7 @@ static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
 	 * - includes R1-R5 if corresponding parameter has is described
 	 *   in the function prototype.
 	 */
-	clobbered_regs_mask = GENMASK(cs.num_params, cs.is_void ? 1 : 0);
+	clobbered_regs_mask = BITS(cs.is_void ? 1 : 0, cs.num_params);
 	/* e.g. if helper call clobbers r{0,1}, expect r{2,3,4,5} in the pattern */
 	expected_regs_mask = ~clobbered_regs_mask & ALL_CALLER_SAVED_REGS;
 
@@ -24210,7 +24210,7 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 			def = ALL_CALLER_SAVED_REGS;
 			use = def & ~BIT(BPF_REG_0);
 			if (get_call_summary(env, insn, &cs))
-				use = GENMASK(cs.num_params, 1);
+				use = BITS(1, cs.num_params);
 			break;
 		default:
 			def = 0;
-- 
2.43.0


