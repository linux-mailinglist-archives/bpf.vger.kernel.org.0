Return-Path: <bpf+bounces-65819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EDFB28FFB
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 20:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ECD33AA10A
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 18:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213D330100B;
	Sat, 16 Aug 2025 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbzpZ7Ss"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D08433AD
	for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755367324; cv=none; b=S6NKivVwENUCkiVf6fWouRAT/ctH8Dq7ktBAyjpxe2sRSiHGz1XPhgPnwOkCu2yMrRrsfDhITyBFYVGVcoRH3dF5R2J6arGQiy8QFIpIA0N3OsfWpXh+dtmBpXAeIOM9/ZT7W5Oth2fzf+nba2vkh0smZEjorsKJ6bIlApXol8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755367324; c=relaxed/simple;
	bh=5zbpK9Wkd2pNNdLsUw04OfmVfYv3aMZ5lR7pK6mxSwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oNrifRB4Bv9mWtXG885z5xLZbT1r+3h+BJxvLUA60Ua00DTUmF3WVU1MeNAJ1Wb13RZTqrbnDjw1c3zlSrJEJ89IAdTVg7BYIwXfsESYCuv6vxUyGGXP8Qdbqsxc3jsLekmsuAubmY0u0EYBQAnv1mNUuCDnBSqlfF2BNVsbYb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbzpZ7Ss; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9dc5c6521so2016550f8f.1
        for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 11:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755367320; x=1755972120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ei8nQKrAXCzlj3hqqGQpcHY/QKAUA97JNahFpDFliI=;
        b=PbzpZ7SsDUGX9KXgJgTV26KuFVK96GMhsqQhEEcXQtBNXKh/lJ6yAmBPSsaxnnWpBM
         HCQa2OjAbWBjHvwsoQ5sV24iQParhox7fxg896J7KqEp7YezyqlEe9Hp0YQi8vxdjKVF
         QqeYyKEQYGsFQmjI3vQCbP00TX2U9HDcuvrJdY939gzSiYxSr1Eip+tqfytzFenhna3e
         qr/Nv+67yrhfxCWpuMPrVrBlbVSf4v7cU9pJ+etRN8Tzk1Z4BABQxTnmYD2+/M0eQpn1
         2UzxY8IT34dSrAu24aKg7x3/fFYMQ+FM+3+el9wUpzl0z8/VNO152rCm+M62cNBmGbTs
         LM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755367320; x=1755972120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ei8nQKrAXCzlj3hqqGQpcHY/QKAUA97JNahFpDFliI=;
        b=cHxHwKhhKKc3NzfSVbOFQZJMcMwdy7XazjFt2NHgA9ucxS9xXuWFpgp1Oz4OfPwW8X
         e44CfQiFTM9rBWG3TX7Gm//bBh6OsemAPsRSWpEs6C9EVDYCeHvRpkLFxGCg7XSQC9x3
         uMmgy9xcR9coa6criSY46D3NHy3QwYN/u7e9+WztlVZjhfkXTkXNvJT8A/hyC8qamKDb
         hZ38krSBJ4eNcXDZB1N3o/CdujS05yv9Y1Ufq63y625a9PFfIKFriMk86A5BxGA5hgZD
         fd3WdV0wB7lu5i6Y2zQ3xRKkacrmvvbbJ8GlujDCic5OLZuoSRfCb9QMxn/0ONxeyCfy
         nmkQ==
X-Gm-Message-State: AOJu0YzUJWM0eES5p6X9OQwD0bQYsgRM1A2gQxnuK+CGtpeVWqV9oxRu
	wprTrWb2W+4jxy8DSXTIuYJ7SiNrsLOHx49LWAzS8IDTLDZHSndUEH+nQGizQQ==
X-Gm-Gg: ASbGnctn+1AznXlaOyeCvs4Hemx0mVsH0pSUytehpTITHOa5z8t6pQK/EHSc534l8l+
	wl+MiWb1R+ByEKh1ddnMXYq4fBzaoTjoPr2PHX6IU7Q0syECd+GOWBHy/1IYVOgBoEn0s62KeZX
	JP7Gb4K5Fw83UlJySbuWxbhaCDdZQ+LnJYnJSVqAGJ8D5/4K8zsWoKjx583QsYEYFvJ6jDgjBQz
	uHMCCZS0WvFS/VzgpzTyk2j+7PYJjg+xpL5omoSuobqOh1UO9+UeEbjAaLFwuywlc6rWYvO3nHo
	w9BULBewp4VAd2HMuYdBL9wYU0tJodbTYHVjovl6pu8tkSQVHmqznoQmM+gtyDV8DhDdAhMt09e
	l1xaphPEWEseZKv8SLa0s2aQFnmpAOKqgmkJtAuSW7Bw=
X-Google-Smtp-Source: AGHT+IHV2TQUZTU+pCuf3sh9Mo9QIgzKb6MzQjVtH+BwDwHn+1v5dGdmOlk5JDYccogv23RfX7IoUw==
X-Received: by 2002:a05:6000:2511:b0:3b7:999b:1194 with SMTP id ffacd0b85a97d-3bb692bd052mr5130957f8f.50.1755367320497;
        Sat, 16 Aug 2025 11:02:00 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bd736b88besm1080193f8f.67.2025.08.16.11.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 11:01:58 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v1 bpf-next 02/11] bpf: save the start of functions in bpf_prog_aux
Date: Sat, 16 Aug 2025 18:06:22 +0000
Message-Id: <20250816180631.952085-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250816180631.952085-1-a.s.protopopov@gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new subprog_start field in bpf_prog_aux. This field may
be used by JIT compilers wanting to know the real absolute xlated
offset of the function being jitted. The func_info[func_id] may have
served this purpose, but func_info may be NULL, so JIT compilers
can't rely on it.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/verifier.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e7ee089e8a31..baca497163d7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1596,6 +1596,7 @@ struct bpf_prog_aux {
 	u32 ctx_arg_info_size;
 	u32 max_rdonly_access;
 	u32 max_rdwr_access;
+	u32 subprog_start;
 	struct btf *attach_btf;
 	struct bpf_ctx_arg_aux *ctx_arg_info;
 	void __percpu *priv_stack_ptr;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d8a65726cff2..b034f88d72a0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21572,6 +21572,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->func_idx = i;
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
+		func[i]->aux->subprog_start = subprog_start;
 		func[i]->aux->func_info = prog->aux->func_info;
 		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
-- 
2.34.1


