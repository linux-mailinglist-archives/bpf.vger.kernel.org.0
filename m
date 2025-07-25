Return-Path: <bpf+bounces-64418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE18B1263B
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 23:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2213A548232
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 21:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1319D262FC1;
	Fri, 25 Jul 2025 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4vgcAjh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE872609D4
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753479865; cv=none; b=gH+KMGowteI9FznhezoiGeMXwlXnW7LpR8y1aPdMgddQbwHMoXqeWosAX/Bz6zu+m2xhvBNWKFSw+4scqwnkkJLqD8OXVHickRO2w68JPfBDMP0+NQBw1+MfLFcwEf3OiMPE1R6RkogZyTU1ioODLVAJC+aI+8Y1Iy/TzsFdQko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753479865; c=relaxed/simple;
	bh=4N95PHaH5sTwnPpy+bRhfgpn+/S4W3TV/v5oApqGZh8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uWh7G3m9NHI0dtvZjKk4hIRVq9PhI4eq1pbVlFRlaBbH6XgHZ5DgiFo6SW90SffvzkaGwWKFOXpdO1ZeM8oQh8CF2503j3DU4E13xM5YJdVJl+jKfgMr4iAavSgwDVzDF9NLIum8Ho1w2HRq1t4OFwZ5OPcJaJmciqTYDgIs1H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E4vgcAjh; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235e1d66fa6so25225815ad.0
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 14:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753479863; x=1754084663; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l30q4xjgSSq02GIRwkV5JkxzVEDFHasp0ZpBbR5DA+c=;
        b=E4vgcAjh3/d6QIa1QrCAD5Z14jDOiLFTxWVtj23ENMutfs/4T6ogUA74HyBeCf6QRB
         O357dV1oz5L3/s/Ecg5N4EB9mJOo12XULyX6NFEwktlpIM59UmIvZ60S0aENFlRXP894
         p46biJXreOoLLoH6Ie42tBjjOaHng5BQ6ReF867OxqYKvu/ozo4dd2g8lilDghlUFdlb
         BrvrQZJF/Y0PMQK2VPft5U4M9GhyFUta1dyPbGOISw3BYIsRHiOxaXPU96H+GVwddWqy
         57otjQa+vMx22nhx2ARdXH+yy6TlDnF/+zC5eoT7JjbX+gDqsZrIB4yw7sTvoZaXtpoR
         KHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753479863; x=1754084663;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l30q4xjgSSq02GIRwkV5JkxzVEDFHasp0ZpBbR5DA+c=;
        b=u8p3l+RUEEU4i21r2yFsmXBfNZwFsJSTKpYX5zHRNYUD6SRynaSltpQWoW6NQerDHQ
         mYtK4udSAyMaeqeKMjSqZ6ut4kZhqVCes0lCTZIEtoSxnNxZluzp2ZpmTEfku7+/UTKf
         XrrQ1KgdU/TCfqo/Ed5udvmc/2ak71GsJiHP33bhaajtmgJbx6kJsbHG0IKy2JVTt912
         gWQ286sf6DNFHqNFa4RmZdioZaQg3a/OOFJdAcDiaSHUeSGOAvSmI/+graFCy4w8FUCY
         vFdUFB4JiVIiRSGnGUQXXRSCSzTs5uF5zWTv9Fr65p3yHY003j95CwvvNRMiHPjDxNtN
         dPiQ==
X-Gm-Message-State: AOJu0Yxl7oYLNsYvdbC009KmpE2pMlC33rw3DfPQAIYWJZno1AkW1y0w
	buNEbIz2X52HgcaQUo7rasx5x+KKWT5e5aI65j5pCeZXEACESKfVypdNuBM1vncq+YWPyoVReUD
	GZhexwXOOAmuvce1UxYVYRfhC69AalfXunhJATYOLKbZZiBh9qR2OjnPt7mQV8b454ba1UFnkfm
	CQ5NXhXoHPicEotK78GezNJ8xTGsow5cCrOrey15OyqZtWMoTvfIg4EDpR/EsQ8DP5
X-Google-Smtp-Source: AGHT+IH2RmYkNP5u1YAotNL4rM7ZeCOu/AMOj9VOuB47c3yjiujrMv9Bt7p2q0nrdOaoANv0rCoAFl9OMd22HLgNjxw=
X-Received: from plbld13.prod.google.com ([2002:a17:902:facd:b0:23c:8603:9e00])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:41c1:b0:235:e8da:8d6 with SMTP id d9443c01a7336-23fb3050a7cmr55292785ad.2.1753479863418;
 Fri, 25 Jul 2025 14:44:23 -0700 (PDT)
Date: Fri, 25 Jul 2025 21:44:06 +0000
In-Reply-To: <20250725214401.1475224-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725214401.1475224-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=853; i=samitolvanen@google.com;
 h=from:subject; bh=4N95PHaH5sTwnPpy+bRhfgpn+/S4W3TV/v5oApqGZh8=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBnNvxYfqK6uYuzr3vB+Q7EW85RJVqe0m9aG/WMJmGv7W
 u7Ql76JHaUsDGJcDLJiiiwtX1dv3f3dKfXV5yIJmDmsTCBDGLg4BWAiTt6MDOs3y1o8sDI/HfW0
 5vwd6c83RMwbXjlsZXTZuYv3bleiSy0jw8VaAaa9Ro8KVbdL3hJfqnTB4kaC9QLufzN890hXWZy czggA
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725214401.1475224-10-samitolvanen@google.com>
Subject: [PATCH bpf-next v2 4/4] bpf, btf: Enforce destructor kfunc type with CFI
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


