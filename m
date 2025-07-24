Return-Path: <bpf+bounces-64311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E74DDB113FF
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 00:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50DEE563A7F
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 22:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E6B2451F3;
	Thu, 24 Jul 2025 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f6pz76tU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED904243951
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396359; cv=none; b=NywFRHNKOEiE7IGR5N6/Q4Ek82Cq+/J5wwZnBTHR40TxPn9sXwhcPKWjrQ4YssNnfRCZLbNMA8pBh/1pmnv/l7VtKIgSUsSDNhnSPE+WQvDbTFPEzYH4MtTm9nIelVkiMjdsQbtPAYdj0UrODWQtJoef96aw2gN/bbqQKUTl/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396359; c=relaxed/simple;
	bh=4N95PHaH5sTwnPpy+bRhfgpn+/S4W3TV/v5oApqGZh8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VE+cuFL/Grggs6cvgT95FoglNqO8XfIJJK8bDiIzeGOH5GmNvaTlV46CklZMWgqDZHQkB0pueUlfx4QDl+tb7zJm/Ul4+ci7ksXxlJI3Ddn4Bfbs0Zv9Caqv9Ns02bASL5ejlbTRFp48j1H0gtRGvTdFvB8lIOqoFNQdLToR8tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f6pz76tU; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2354ba59eb6so22615035ad.1
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 15:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753396357; x=1754001157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l30q4xjgSSq02GIRwkV5JkxzVEDFHasp0ZpBbR5DA+c=;
        b=f6pz76tUwhT6aRhJrd4AwFaRjwyTq9hvQjspqSvTCqjPPwoE5isDKW5fjnzMvUHKJs
         H2I7OtHf1DXX0IZRJZlBer3693ARAw/botWss/g3e77HFdNignoe93i7txYOOfq8jzUn
         nK7R/yxA0DiTXpINVRy4lqac2OtSCgxLRs3eRv/8DCtI93r0UiY6cKP3ioH/dJKlAl/g
         luL0xqREQyuB3RgBaSnDC6z5jSw4IjD92KfZGwVnFZWyWa7WfYG68ctFB5esj7s55/lY
         JkRxS8WijFvjhXky6qh8bDgiR942xCCOqvUj3xdiDeP+3dBYogzKzAaDlVJW4XcwktUg
         AFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753396357; x=1754001157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l30q4xjgSSq02GIRwkV5JkxzVEDFHasp0ZpBbR5DA+c=;
        b=agzZ/JHQiuSdnjhTqnA4sGQToytHZF2y7KchHJENN+cObezS7njc6MteF988iXDr1Y
         /NT/pNDkS2dERiJC9fIGWMulq12vs2BpoJIA2j/aK5lFY5FcyEVCja7lPYHk49N/UZrC
         OaJl4YG8l8cbe4JvmdadOaUOjdsP6Lm2tAY+dhW0fiesVLoLKfCfTMzFnEw5cqblS5zN
         fLbwyMtNtXe9Mw7PgL35imW7YhSNFP2Li+RV10qEASpOP/OUYU3CxVUippHWzDudeaIy
         1rkJ/5yKO50IsjsckL9/+jGT6htWH1RLcnxJ2ial6NQNccQubVPAXWD59z4jt7q2PDMl
         N9Cg==
X-Gm-Message-State: AOJu0Yw8mp7UuEcPGcpE5/Uyzx7k1CNbmUpGNBjmycXDWybVNn+uwXUO
	YI548JDmDvW3KWWKoOUWJkQpA5TO9DYDqaKQaH7MQr5XcAH+6Ul6hw6EbPOkHX7IOhRqSSuEmF+
	ct+My211PlqCy/P4M9KYoDf+HtaFQB6TJ2YK/qVvwPrfbfTPcNeQAE+3vTeMu1wSvsWrQ7ufRd1
	AMEWamJIXZpsN7ZLFwL5w1f/hztoGpBuovEkgJ6daWpjUCb6vOpksVem9rndMAjprm
X-Google-Smtp-Source: AGHT+IEtA2E9+sMjT0EnxYfMCkPY3zq5lHvnVQxkTuwFfK+T/mp7UOYRrBkZNv+MUuGcmJKgNUMqUZbXZBtd12P/kOI=
X-Received: from pjoo3.prod.google.com ([2002:a17:90b:5823:b0:311:a879:981f])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:291:b0:234:df51:d16c with SMTP id d9443c01a7336-23f981b8595mr141323515ad.45.1753396357152;
 Thu, 24 Jul 2025 15:32:37 -0700 (PDT)
Date: Thu, 24 Jul 2025 22:32:30 +0000
In-Reply-To: <20250724223225.1481960-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724223225.1481960-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=853; i=samitolvanen@google.com;
 h=from:subject; bh=4N95PHaH5sTwnPpy+bRhfgpn+/S4W3TV/v5oApqGZh8=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBlNW6oPVFdXMfZ1b3i/oViLecokq1PaTWvD/rEEzLV9L
 XfoS9/EjlIWBjEuBlkxRZaWr6u37v7ulPrqc5EEzBxWJpAhDFycAjCR8wcZ/kfOXf/X9MMFhtYQ
 xVSuoNPiJ7t9nU5aTri79v7eivOBDoKMDHMEDi9+d11Np4HT/+q958yCvDuUDjuE5D8IC0/MjAo 5yAkA
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250724223225.1481960-10-samitolvanen@google.com>
Subject: [PATCH bpf-next 4/4] bpf, btf: Enforce destructor kfunc type with CFI
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Ensure that registered destructor kfuncs have the same type
as btf_dtor_kfunc_t to avoid a kernel panic on systems with
CONFIG_CFI_CLANG enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/bpf/btf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0aff814cb53a..2b0ebd46db4a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8856,6 +8856,13 @@ static int btf_check_dtor_kfuncs(struct btf *btf, const struct btf_id_dtor_kfunc
 		 */
 		if (!t || !btf_type_is_ptr(t))
 			return -EINVAL;
+
+		if (IS_ENABLED(CONFIG_CFI_CLANG)) {
+			/* Ensure the destructor kfunc type matches btf_dtor_kfunc_t */
+			t = btf_type_by_id(btf, t->type);
+			if (!btf_type_is_void(t))
+				return -EINVAL;
+		}
 	}
 	return 0;
 }
-- 
2.50.1.470.g6ba607880d-goog


