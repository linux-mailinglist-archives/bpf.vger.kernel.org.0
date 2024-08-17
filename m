Return-Path: <bpf+bounces-37406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB809554B4
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2024 03:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0A41C21B37
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2024 01:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8D08C13;
	Sat, 17 Aug 2024 01:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGvMX6MP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3137C6FD3
	for <bpf@vger.kernel.org>; Sat, 17 Aug 2024 01:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723859520; cv=none; b=ThGbGG3qPmG32knc/YqSs16EFmwciMFpUEd1CVsnXAXXGjcfrN+4QPJKfkCTLN6tpuOHVpbFxJwcoF/VU3DC8Qk7OlB0usoZP4nys0wkXF7SdCBELeUjf0n5zYqKBVhRTupsMjURsUPQYG4pbXjf9qikazdrEKCaXWDBXbIOYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723859520; c=relaxed/simple;
	bh=fAGDUTyrOIhRZfEs3/sNrwJaFQJWEMrdQ10grgd//5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNtyXI1w3o8ttnZHo2nUkx+f6Rn1R9sB4lH6WXI9x/wJJcNmFAF1kcLs+sAvOgNsIQ3WkLhQxVpNNaRL0ii/PP7xjixNZH0c9pEvfWBUtYT2wjOAizOextBply7XwZ6BLl9dKCOTjtzbjKq7+3oRvzE/RSYBYBLW4i5wrMHmT3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGvMX6MP; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-710d1de6ee5so2217686b3a.0
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 18:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723859518; x=1724464318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzLm606NVTr7E+g42mgHbB/WCn0IGd0Nl7yJdrkYGCc=;
        b=GGvMX6MPivzF6ZcqQj1h/buo9nH5w/Tx7IoqyCchieHgWo0CALYnq0foQpmfvADGqJ
         UD0DG3QU7d6sJA6xpC4qlqXm7TzQWmHtyReqcExyUK6cfymZHESX67KimQ6NapBIukAp
         LQYAYTAf4YPkNpyAvKLHuBVKN8K26+YYYVFSzqS8Q50qlqhZwErCu1CRMaggbrGcXKcD
         MLg8Mn7fiDP9BxiVZ+ETZxzjdVyVS6ZGQQECwb+/6Dnmf0aE11ArV2h81sJp/bj2Z3wJ
         i0sqC6Td/2cnajAL4zWqEw1xeOigunsLRvWagvLZWHXV0tnQj/BIY1wab7buFhcX89pR
         EbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723859518; x=1724464318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzLm606NVTr7E+g42mgHbB/WCn0IGd0Nl7yJdrkYGCc=;
        b=ukI5w8yxJhe2fItHZBaIWwsV6uaq6f71FxMnlh0eNFqhqc+iYP+ns/7kIh0RXK4xES
         OPl2J/YL1HKzq8486DOEvchvNl3/bLx9gxMO0jdvgaS7yp1Mpun06KIZcnxt9mb1HUA9
         j6sb1ZHDJ5pVRxyd9F0/U4fk9qYSia0ws3khoa7scnOX8H5BeD3vlUjroXND9s1VoXsp
         eVe6QHiVeaB27C4q4D5f944WY4po43fOUp89+SznpDTImOnFm5o/zte0TRylfPlbbqIR
         /YvozLM6iqrRtld1m9RRprMDkUKXIEgTwQD+zhK8PAHov/ybyFVV8O1+TYZLe47ExNW9
         e6lw==
X-Gm-Message-State: AOJu0Yxvr4Xj3drhcj69U3pbycqxtTQY1hBjG+xXiF4tLBZqaTXkQEgV
	v4oMXh3yWtOVpSnTuycrHyNC37lISiRGDm1/OhPq3zA5HCcnn21zJUzsjI5OjWA=
X-Google-Smtp-Source: AGHT+IGSV5fZ1j1oZ8xPv2I3EtgVeBEHsWmpGGxWYYFJPeOuyOUmzxmZGNRN3qcklZoXuXMxNmvbZQ==
X-Received: by 2002:a05:6a00:1492:b0:710:7ced:fccd with SMTP id d2e1a72fcca58-713c4ef54e9mr5638987b3a.19.1723859518243;
        Fri, 16 Aug 2024 18:51:58 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6356ad2sm3598887a12.69.2024.08.16.18.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 18:51:57 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 4/5] bpf: allow bpf_fastcall for bpf_cast_to_kern_ctx and bpf_rdonly_cast
Date: Fri, 16 Aug 2024 18:51:39 -0700
Message-ID: <20240817015140.1039351-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240817015140.1039351-1-eddyz87@gmail.com>
References: <20240817015140.1039351-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_misc_fixups() relaces bpf_cast_to_kern_ctx() and bpf_rdonly_cast()
by a single instruction "r0 = r1". This follows bpf_fastcall contract.
This commit allows bpf_fastcall pattern rewrite for these two
functions in order to use them in bpf_fastcall selftests.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5dafcfff729e..720163772719 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16159,6 +16159,9 @@ static u32 kfunc_fastcall_clobber_mask(struct bpf_kfunc_call_arg_meta *meta)
 /* Same as verifier_inlines_helper_call() but for kfuncs, see comment above */
 static bool is_fastcall_kfunc_call(struct bpf_kfunc_call_arg_meta *meta)
 {
+	if (meta->btf == btf_vmlinux)
+		return meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+		       meta->func_id == special_kfunc_list[KF_bpf_rdonly_cast];
 	return false;
 }
 
-- 
2.45.2


