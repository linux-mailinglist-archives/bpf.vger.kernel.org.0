Return-Path: <bpf+bounces-70010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62393BAC8D1
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A95A3B1D56
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 10:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5F42F9D8E;
	Tue, 30 Sep 2025 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7sdY25d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8A2221FCF
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229389; cv=none; b=nScxmngEGkGPhPtNfpv43XBHHRf5pPxWIUsywgWwfK11giKnp8Js5g5ug4JPOIxyQz+B+OSu7gn9L1wMCY1zOmqSZ5jA+JC++5WwUqeWt7BanxLx6QrXIxY+FczOw0q7YeROeEbOQilkfiZPsitSGMJlssrDDDSYDAb4Ng4uFTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229389; c=relaxed/simple;
	bh=GJSPhMylDstdKtNjate5XCCIDLbF1tK9xD2Rpiae9kk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g01HsMeGCc6wSX5IHNRVwJsfXYve90cyR0f0snlCMXhuFUw6xVJZVu3KCrdNgucWAGGNYH5n8c1Lf0kGKYMvJmCLAwmcEIA4pljNo03fAAbhUBE90wB0XT9Fdgq86Wqp21pVKvcqM47387g3dy7UGF/lGMaLCt+4pgeZt2iVCks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7sdY25d; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso39125585e9.3
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 03:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759229386; x=1759834186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1InaqL2LHVfwizxF2dcvq1KAD2yJZhjXW2l18aYhKQ=;
        b=C7sdY25d2GNsvaII50uA1pGJ93DgwNKSphxeZ8loguCX33LBkpmghBgO1Fpq11QP82
         Dab1FMYiFMa/pFXoOm+XHy8byLyby0rpJUPG6jeHazVlB+gUamU3AD+iioKSyuOHx6Wy
         cIBO5j5AapXC5WeuFYcZMOI6fCKyV+fzjaQItjBN/8EMaO8tARBZRnTdDzFgsdrD/5SI
         +LPzOZcMFaLvZPE1x23CJgXVEskjMbfuAy9qPA3bsJqlPqvPkQSY7mfBGfc1vJUj/6jp
         jKwbAbXQMbPKGndI13UiypUpmtb6oPnBlTCxi6n3j9kQp03H2eIrXdO/fGD2pxX79lFi
         CH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759229386; x=1759834186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1InaqL2LHVfwizxF2dcvq1KAD2yJZhjXW2l18aYhKQ=;
        b=ocy2Aij3J+nKkckooxIwoQWmUOWF0s67gPYstJ62AG6SPHLCPybYJ7x0v7gA0CgMX/
         LHLf1eK8f6mu/bJ049s+MZc2+mliy5tDqHHhiJSFUWN7yJ58UbEgCR8i7Egi0YWNq1MI
         QlfzpK2cdDGnPA0X/Pug8Ohn8dc5xAYlIeiuhzJoOrGosYiJ8YDm8PXMSVEFDsagggh0
         b8swhNXDnvgxV1+O9p21RS3hWyA3xJpNm4TDgLweK1sxNPESj3vEHaDay2X+eQzL7zmr
         Ve6tcbGYkuBuQhxEkVl3/x2CK3826MC0brLaIN6Ep3A1MoeiQtncFAGo7Bna+P9nV8Ds
         Wsjg==
X-Gm-Message-State: AOJu0YzD03BJGvoQJTcFaVwSJukCekLkHJUUqLRVpJdl7kEiY65ptkdx
	wrJllbmBp2I94Mblr0ZkWBZl+NzF4zea1UVef8OgX5gJUXfU/igWU4VrgAmSWA==
X-Gm-Gg: ASbGncvz5ySZPXOG2QkoZpqjItFtPk+/7JKvPgJwtXREWJvXuuz9VVPMLtXla0H25AS
	FkVBZZTxMdQ8i3I8bS8AwnBx89n+FCOPTW78SiSN1rva3zg2zkBbWWEn6pkwoHqjgowRjW1TTLZ
	HtkOwriMdrLZJ++7sYmh6LniNDYoEXA3PTVNmv1gAOG5MKkIA83cpVB1EAesWB6FSp6Hrf4/2tN
	niqZrjJALTdWgoVa4dQ/9vVVWDL7NtatekBVLR5pWu+pdtbu1zIeN+Y0OPWnMjo851Spw+wScBj
	ZzAeG6vkSqKmO0BolR4w5ug3UvXmpdDVdvQfb96xebQp3JIziDFCHfgof3sNegnUtXcY42O4fu0
	mEcyhVSIdPu3VHKkYAHc5BKsZm61lqvRO9GyH6ra3tQo2Oe98vhgOFmfLI2r9CM1UuNOg4Fw9Mj
	ah
X-Google-Smtp-Source: AGHT+IElhjWPHjFnIU5U3bA7Og1H6di4NgRXKSBNu+tuYwR9IRMev25IN7I7XmseTe8niInc/cBITQ==
X-Received: by 2002:a05:600d:41f0:b0:46e:428a:b50e with SMTP id 5b1f17b1804b1-46e428ab96fmr116199695e9.3.1759229385817;
        Tue, 30 Sep 2025 03:49:45 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dfdsm21982161f8f.33.2025.09.30.03.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:49:45 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 02/15] bpf: save the start of functions in bpf_prog_aux
Date: Tue, 30 Sep 2025 10:55:10 +0000
Message-Id: <20250930105523.1014140-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
References: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
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
index dfc1a27b56d5..50b6fc2071d0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1606,6 +1606,7 @@ struct bpf_prog_aux {
 	u32 ctx_arg_info_size;
 	u32 max_rdonly_access;
 	u32 max_rdwr_access;
+	u32 subprog_start;
 	struct btf *attach_btf;
 	struct bpf_ctx_arg_aux *ctx_arg_info;
 	void __percpu *priv_stack_ptr;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9677006bdfe4..ba95f09679b7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21424,6 +21424,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->func_idx = i;
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
+		func[i]->aux->subprog_start = subprog_start;
 		func[i]->aux->func_info = prog->aux->func_info;
 		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
-- 
2.34.1


