Return-Path: <bpf+bounces-50657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA60A2A68F
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 12:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC090168416
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7012288E8;
	Thu,  6 Feb 2025 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCRLAbMD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A58923237C;
	Thu,  6 Feb 2025 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839312; cv=none; b=UfAck2Yp2DlIoCfjVFAkWzhLDGgtFBiH7f7pzdURZUgUesdAwTGu6c4EmbOqDTbzj4I2T5xkAQvQpAHMhxsLN5OITdK5v3vnB7W3CAM1suTpbin3pAeZO7hfDONxluuhja4famDVtG0+C4txc1UpdXDwIKfu9UkA8Vz4hXqHmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839312; c=relaxed/simple;
	bh=a6nXDtyfaaaN5/sxSs0OZmYxp3ViUzHxtEF2nqEtxP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sC0VQz+fcFDGueEFZ26fZweKhP9GIlJA5Bu0PguduQb/aV+9qIcFJ5QTuoSp/6KM/P/kHzCWMoB/5SeEgv5YLONNYJ7bH2aJ2zb5CcK9TAw/oFA1h80ehOAd23E11siFZQpTEzDIGB/UaiaMheNve/msaf3z+svlovXJcJ8We4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCRLAbMD; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-436281c8a38so4827195e9.3;
        Thu, 06 Feb 2025 02:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839308; x=1739444108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMJzjmm9Ssn/2tshx5tAZDCI9Z1engNm3Cw+RIUnYAs=;
        b=QCRLAbMDF0WIGBXbFvFpMtx20YKXbAV4Ipo4ZuE3A+nIQJ5nIp9m9KBiBqbXLvD2iP
         NePB9IjcKfu1x0lZnlc3B1QXxd77wAhYKTgSXLcQC2Hl0I8IxYIYtRhXPteKT9SZnjyK
         XcYd9tAe6IFOn94C2H3Sd88CrVTV6bn4nTmw2aaUCY3bvRiSYQgerNze1VvxX0uoqCDE
         grcPiILwKbI3Zfsu3AOubE3bOfsElBmLRdQ79Ww2bxe6XtHMWOhzlSgWB0ZtoylAbsRh
         5plogVqwpbX+MbhF1JAYQehGbKdfTamjGmB7gUlVMxw25T0w4qN/N7z7PiReRa7spGSq
         XxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839308; x=1739444108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMJzjmm9Ssn/2tshx5tAZDCI9Z1engNm3Cw+RIUnYAs=;
        b=RAsh573amU4BOvZrP+1onlkCN0Pk/9ktrH3gjM5NZLYmPA8oD/vAxaAmmxfMygBL+A
         Rmi4VP1lcv48/kDRdpgNWjIQ0cvMLcxbqgSVpRPxwppTATvY7BL81WVrlP3uh+iUrZk1
         OIgHeTpibqii5mJFh3NU3K4H1/f9Ardutgym77tg/FfFmgBjWfUGeyt3A+zEcFVTkQsT
         dj++x4pCB6/xnOgAP6piBF0ydxf4odx+E6jL72AtPd5tf81l7OQifeKvvM7Oiv8WZE7q
         8IzSgO83VYU1j8xwIGkE3joMc7nQ+vKlg0O0WORPxEJJSaiM/+slHs70KUqAojnxWHK7
         TJOA==
X-Forwarded-Encrypted: i=1; AJvYcCVkt6dawl4p+TGUfEbwDcB25aRaU9nS+lvJzxydGZ/GH6Ks5Tu3LM77H2mAoGJr+DJETXaye5UPLKl9x/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu3tFtyq8OtPagdblmTwjqvGgJXvLxuNCZhqu7Fe+qDZi8Cd6W
	bYsFvA2HHPZmTP4uFFCnRx7STphZCjDssAI6JYFswX5Nd5SZ0d23JVVhZOCWFrg=
X-Gm-Gg: ASbGncufgv/2IDqYhHLoHK0DdVK1yS0yA6YpQwjF7NqWFrsm7HJA40cSUnCuks38brH
	Uzs4CHtGsHWNXiBelsD7yoYiTtlWn/lDHQIFOlFo1g4wix1uAq82bFtuPUB1GmHYqYPHWlZHcQB
	yUUC7cwCEBiPgkVG49XxkDxOHJz60g3Yya743ldlKw0U7hVUzcyMYcOPl+1ESYMFojJC0EpV9L5
	9vdCtRukQj9XeAKA56+g5WAGclYeAvs/kq8oemADTfKy44ULCQxGuucm5QLqFShYNeriDhPE8pU
	Pg==
X-Google-Smtp-Source: AGHT+IEmR2/TmkoFR9idBNEPfQquu8zyJPeOqwMAgJpW3/scT3Z5dWwlgX9AEyJpUkJHqzG2L9+0eQ==
X-Received: by 2002:a05:600c:1e1c:b0:434:effb:9f8a with SMTP id 5b1f17b1804b1-43912e54246mr23938815e9.15.1738839308376;
        Thu, 06 Feb 2025 02:55:08 -0800 (PST)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde1dc1dsm1375270f8f.87.2025.02.06.02.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:55:07 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 23/26] bpf: Handle allocation failure in acquire_lock_state
Date: Thu,  6 Feb 2025 02:54:31 -0800
Message-ID: <20250206105435.2159977-24-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=776; h=from:subject; bh=a6nXDtyfaaaN5/sxSs0OZmYxp3ViUzHxtEF2nqEtxP4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRndCMDTSB5KQHWglo8M0qqlVd8f6toksUk+2oC Ok/Xw+iJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZwAKCRBM4MiGSL8RypokD/ 9GP0/dyt61QvEQ+p/5NGWAGtLJXjdj00R6BxemQXfhh7MvCRx41BKujZPuPCBt02Xog2UeoMlXt04D RrFCxgOD/1K7vHK54wFCXnJU1den0sUUyDwfsc7Gj/Z0ifdqhrqr90k3WL27q6L5Ur7ohUWpuvAnjx gB0+Y/CJisy/oVjoFzaGqCN1CzvRRmkSSNLrV8Uz5Tf6Op2AvJ0nuER2FdlG/+j0t9YBcFkR3pothS zfXRfrBvws9/BRL/R8Z15OeRzU1lgVUPjSL6C9RU+hwgIhYDCQ00BoTuMlZh511ojo4sTo3/Zvtf16 9+lkVBS8sPO5bap8JYLBHDl0nLnFTfxJMfDyUryqKVYV3GSM7Y86ST04cPqZ8EhWprpNw+iKmOmCKd gjHx0Q4VcPzA5uy+jmFPpNNMXyT9dmIjrev7NGi5DbvK/DNdjUYWQxJjzN02iC7/EvRTjngcxoWyPe rUBoOvzWn7iv0hRVbYWfJBakloSkfB7eIVP2e7rSgqjtytPi/PjYxdl90c9TqChCBlyDqVB8XPQ1gq y0eDqUv8LC+trmtM6Wr6odaXyc9aKb9guEkmSooa05h3a0/ZFg3aOhTfFbDmyB8nOJC/rMKNjw4sQ7 8dmYH22uTb9/O8oVVtMMomG3b8H8m0yE9UTVXLKxcqjDa8wUn5Y2vIIHFqcQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The acquire_lock_state function needs to handle possible NULL values
returned by acquire_reference_state, and return -ENOMEM.

Fixes: 769b0f1c8214 ("bpf: Refactor {acquire,release}_reference_state")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03adfd5..d6999d085c7d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1501,6 +1501,8 @@ static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum r
 	struct bpf_reference_state *s;
 
 	s = acquire_reference_state(env, insn_idx);
+	if (!s)
+		return -ENOMEM;
 	s->type = type;
 	s->id = id;
 	s->ptr = ptr;
-- 
2.43.5


