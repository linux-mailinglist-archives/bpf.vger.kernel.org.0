Return-Path: <bpf+bounces-51013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B100A2F58C
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C6E16742B
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097A5257446;
	Mon, 10 Feb 2025 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVE84jvw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2460A25742A;
	Mon, 10 Feb 2025 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209435; cv=none; b=e/lG8BwXLFvNbC2dZjjbunCmJHI+aOjHvvbwsnpU+qs7ErGxcsE7ht9jgHKWXVfF4fvFLRY5b7q+R3dIX5JyFc3UybanMOnXVGxX5T7jcOWjDCltgoAVoAZpmOQXXmry+i/CK1VWnV3+eMR7Ihk/ZhUhDAsD9+RcCqqGiV44Ny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209435; c=relaxed/simple;
	bh=eB27qpGeHbnL+g+H5i6dwyeK5gEdO4WsfdSVSblw4mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzWu+MnqfOGdkD7952RanoSJrk+0VEA4In51X5MiFJgEJ9YhfcvjkD+XBHa88hoepQskpnMS0i/Xs25UHjEceii44Z9qQC68qcLLEOVgpwAxiXL/0kWkrrouDrRilnF5QHz1YkTlYa1QKdDb8f2TOs0iJi7XVCreglydl2ftEus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVE84jvw; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fa3fe04dd2so3665048a91.0;
        Mon, 10 Feb 2025 09:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739209433; x=1739814233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bqaa0Rde68BkHu0sINbJqayYMFBgLoQtb5xV4LwmnQE=;
        b=RVE84jvwHuIPFKQ+++vTf8yB9IGi6L5E3G1AtRR7bvDxAy8DKzSWY7HmuaXV6u6QGH
         HITDqtV3Jn/qTU7R2PIE/tLtmcIWpQ6pHwfl3G+Tt7Emzr5xLxOtBkRFIOyStWi5pF8g
         6neFNEjo9FZpoQx+S4AlFyXMfnYWhiwMuLGgMppCWsmtt0uozeisDeLI5uo5Evdqymc/
         I3aJ7V42XMTdjJ1wJPKv62bQVgdjfkf/EShujU/HyiEx/tVSkoNcPxWdQ1yAVrYPKQsj
         IlTTYkCqPxv3XXtoaQKxX17LxEj4PHibpzBjB/0yKwJi9hIA990hxfWRa152w7pEs73n
         EGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209433; x=1739814233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bqaa0Rde68BkHu0sINbJqayYMFBgLoQtb5xV4LwmnQE=;
        b=lG0RfUoX1y1sIM6z5vhe24ZM+wy4+dpjKU7Ae2ZvBAidtUZZgwulsdYGK7hRnT6tAH
         mVlYq93QoNBPVrh3mkIzA3C1oy0L4GxZI6r7G75a9m4sIvKYbdEZ8Bg7pInjz50158bV
         SXARr74Uw+nvTatLXl0EXnl9Upj9uYDBQMzkq7pywMYKHVyP0huUXeV/klD1Xi2jlxD+
         o/zQXfOYK6nnY96Gkgz5nrwcNMCgzUHLyj866+MSjuNMd8pNgxRXqfaV845XAYEiAtj3
         m1AJFH6PuHyaQrTXd3tlonipFyUPzRvCjZCk506V5PDSkz3XR2wfzLT7RLxkeS7h9Z7o
         v5Pw==
X-Gm-Message-State: AOJu0YzkmCvRdSZFuPnQYK0u4yX9BYBrx4PF00F1a7UDjUsSRPXgWpph
	K5iBCxldyRStt5n7XH1Pd+U0jkaLc4QI1GA9tD5njF5QOL9uoA3F9RwVPGbW
X-Gm-Gg: ASbGnctDd8ipBwkfOU7qpQLih/MkcvSTLcy24GAuxjxuOnrRWeUj2JjaUqe3WSdT/iD
	oD01UEtHXux+ljf3EUvkNRUmIFb8ZYlbHgobzNPNyRAzIoCF5bDYC6d9WOF8LDgCfVIhbF9AGv4
	8evpP3G1zs08SLH02J0fK7kJTWux93HO/1jErqjwIyQTY8b3jNYfeWWssKU5BmSMlOr6riN4uDz
	49q10EIXFp7awVqDA5Uu6J43sE4mf4srMBMSToQR/031McZ7iz+YGD3Sc4V5yRr01rgg1tPvaUD
	qRqd9wzjC0Hol0nI3CGdgO/CmiZQoTMK0OfsIYYg2/MZ2DUT14hEhZqPcD4w13X57w==
X-Google-Smtp-Source: AGHT+IH7xj9/pLQPU0J7F7gET9vRaqBouDpQVyF9o4nTg17imPuJDQ5E/IOFc7We+274oVRatybPHg==
X-Received: by 2002:a17:90b:4c02:b0:2ea:59e3:2d2e with SMTP id 98e67ed59e1d1-2fa2406418emr22983490a91.10.1739209433127;
        Mon, 10 Feb 2025 09:43:53 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa3fb55dcasm5554961a91.4.2025.02.10.09.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:43:52 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	cong.wang@bytedance.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 06/19] bpf: Prepare to reuse get_ctx_arg_idx
Date: Mon, 10 Feb 2025 09:43:20 -0800
Message-ID: <20250210174336.2024258-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210174336.2024258-1-ameryhung@gmail.com>
References: <20250210174336.2024258-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename get_ctx_arg_idx to bpf_ctx_arg_idx, and allow others to call it.
No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/btf.h | 1 +
 kernel/bpf/btf.c    | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 2a08a2b55592..ce057c6b3947 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -519,6 +519,7 @@ bool btf_param_match_suffix(const struct btf *btf,
 			    const char *suffix);
 int btf_ctx_arg_offset(const struct btf *btf, const struct btf_type *func_proto,
 		       u32 arg_no);
+u32 btf_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto, int off);
 
 struct bpf_verifier_log;
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index fd3470fbd144..ca5779f6961b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6370,8 +6370,8 @@ static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
 	return btf_type_is_int(t);
 }
 
-static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
-			   int off)
+u32 btf_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
+		    int off)
 {
 	const struct btf_param *args;
 	const struct btf_type *t;
@@ -6549,7 +6549,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			tname, off);
 		return false;
 	}
-	arg = get_ctx_arg_idx(btf, t, off);
+	arg = btf_ctx_arg_idx(btf, t, off);
 	args = (const struct btf_param *)(t + 1);
 	/* if (t == NULL) Fall back to default BPF prog with
 	 * MAX_BPF_FUNC_REG_ARGS u64 arguments.
-- 
2.47.1


