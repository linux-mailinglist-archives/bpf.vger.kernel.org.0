Return-Path: <bpf+bounces-78021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E366CFB5A8
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 00:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 145E530519CC
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 23:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AA63016E3;
	Tue,  6 Jan 2026 23:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chbx8dxM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1487C2BFC8F
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 23:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767742582; cv=none; b=UuWi1Z4lPkDpwfz5ETZDRGTVum/tv37evcK7faAGbPkYfklPJklBMPkR4IflcYS7YRevINGIHCXS/uMxNbWUgiTBvQdGEkAGuDoq84x28+UEeCfPeCXFSrw/7mU9qaGtq/K47WPFK7TpakOQKsyxc2dfaskcaz09BchPgTlzxJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767742582; c=relaxed/simple;
	bh=PmKk0/DE9rbjasdjCg739Y/gIaZy0D5eB8rt1eVm8OU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tOtZXAhUafe94hG+gDmuFY2xVuHbRAhb0q3v6ybr2X5LnYy9ZIW/lDqu97JBkCCp1yUgXAHpygX5UedRCe6pSqcAWScLvvtkwgbvhzk+HlSQAxG8iXfIT3wMd/xU7bYMmz2SZ9qgz2WyloLFBrU4jON4IqCPKDstm+XC6XoQ1vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chbx8dxM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso12833685ad.1
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 15:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767742580; x=1768347380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oO/UPmm3boDoo4REewsitXgH+S5y5QMnzcd9leEp7bI=;
        b=chbx8dxMJEU7psoE6blQ/UIcNDoib1LNoO5jruPhxPhKCklEoL5Yofy4MbZcJtMV0Y
         KJSxBkfgrHK/mWMMPBIGjqWcN7ewqnDlVqhpb1hcgKGQmcPyAfQBRD6SIYz7k0GOKjqk
         LDqk48yrbkad3qUiedC8cZCo6m3CBNgmnrCH8T0qC+y9gijooiFH3LNQwSVq9lMIGKO7
         ympXFA6oyBgux1tONa7uAm9OBSVHzBKopj2/kr+lwfbEew13xWeflLPUQeXoek5Bl0qi
         0xp9t96XQVNc1x12PABmXetOZ954TQgK5zEbhDwAiTihCxnQyRPx6A0YxAECpn1H0xqT
         mbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767742580; x=1768347380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oO/UPmm3boDoo4REewsitXgH+S5y5QMnzcd9leEp7bI=;
        b=quxq23kc4XLRG7zqSQXi6e7GCrN+9rz7Lj45q0bvD0NtBzmPvBfdkBMEMd0L5Ue37c
         jMaWAOPfTlB3msAUuO+QhT3EO+n9Y8sLGORAZ+TMJHji1ogLft/JLmPUBdwns9dWcgx/
         hkeie9ayNKEZogheuEzZ9OXNZpaapj4uvsP/xiuAtgPn0HtZ3z0eTH4fwuXJUFwKCR+R
         nd8cumtMNgQwG+8GN3/gkCcbhM/G92cu5pE/V7GkxNadKXp15G+YryA7wFV3dSrJcb2n
         890RlXmikQKJsiTAfeHAlxgN3udV6kjTN4ciRiHVydBWU7vxX5pJqO/N+wQ93i4BbTF9
         1amw==
X-Forwarded-Encrypted: i=1; AJvYcCVGSNagCwKZmMhfVP8sUoww97swWxSJV4vhQkWn8J6FORzJqXguE3n3fPtuXqNqlG5ZXF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+GkcrgFS+jK1NtmM6pGgx91W9jo4Gge5BDFko7pNPW81YJTue
	fFIimJXZ0ERuUeaRgOt7/siaCAECzivPnI/eGvv6Vqkyb7DNjd3qtLab
X-Gm-Gg: AY/fxX7pgJAAKsHyTQqcUVMwiR2FEPWOqJalHsWljuM3Mhc9u7mr2sUtgVegbYqfn9a
	o8O6p4svpjpWERL4erD6BCYbmIb5IYgfUVWC04F9Jpu9wu3xqoRy7X+IbiOxyTiZSvkPB7/U6sP
	HlmQ3fCBVIL2TwNWhoOlVF/StF0JaawLlNDjYIlqAN6Lq7UII+bf0RyExpz6WiGw4PCWXb1qDwa
	jDzFRd/BpwHf4PjSoViEymDi72cxFNjvUzakxCG0d2McTRft2uv5/EG9elxvYmtB6eIP3jA60lb
	gqGOYvrPRt8sOM1bJxMqFNvz93bYH9wez3alcyFB8sp9sux/5uDrJEwDyS8bQ4zvcOAL3OyCIHU
	Bk5NpBwr4o77hbWzGGENgzfVf5tsV1IA5p0B7HPIB5hTk4WrjKRHftQrzfN82dxUGQx+RPRY4TP
	wfBoIUKBNbzbPfk6wg1K1gqc6/
X-Google-Smtp-Source: AGHT+IFumtloUmQ/At9choLtKt9RHd50AG/q0g5r4FD4Gxrbgaw0U1sdY0Ss0gw/EID8xTLDUQ4iAg==
X-Received: by 2002:a17:902:f682:b0:2a0:a33f:3049 with SMTP id d9443c01a7336-2a3ee40e4a6mr5017885ad.4.1767742580314;
        Tue, 06 Jan 2026 15:36:20 -0800 (PST)
Received: from computer.goose-salary.ts.net ([2a09:bac5:3b4e:11cd::1c6:10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2debsm31964935ad.65.2026.01.06.15.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 15:36:20 -0800 (PST)
From: Varun R Mallya <varunrmallya@gmail.com>
To: andrii@kernel.org,
	alan.maguire@oracle.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	varunrmallya@gmail.com,
	Harrison Green <harrisonmichaelgreen@gmail.com>
Subject: [PATCH bpf] libbpf: Fix OOB read in btf_dump_get_bitfield_value
Date: Wed,  7 Jan 2026 05:05:27 +0530
Message-ID: <20260106233527.163487-1-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When dumping bitfield data, btf_dump_get_bitfield_value() reads data
based on the underlying type's size (t->size). However, it does not
verify that the provided data buffer (data_sz) is large enough to
contain these bytes.

If btf_dump__dump_type_data() is called with a buffer smaller than
the type's size, this leads to an out-of-bounds read. This was
confirmed by AddressSanitizer in the linked issue.

Fix this by ensuring we do not read past the provided data_sz limit.

Fixes: a1d3cc3c5eca ("libbpf: Avoid use of __int128 in typed dump display")
Reported-by: Harrison Green <harrisonmichaelgreen@gmail.com>
Closes: https://github.com/libbpf/libbpf/issues/928
Suggested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 tools/lib/bpf/btf_dump.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 6388392f49a0..53c6624161d7 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1762,9 +1762,18 @@ static int btf_dump_get_bitfield_value(struct btf_dump *d,
 	__u16 left_shift_bits, right_shift_bits;
 	const __u8 *bytes = data;
 	__u8 nr_copy_bits;
+	__u8 start_bit, nr_bytes;
 	__u64 num = 0;
 	int i;
 
+	/* Calculate how many bytes cover the bitfield */
+	start_bit = bits_offset % 8;
+	nr_bytes = (start_bit + bit_sz + 7) / 8;
+
+	/* Bound check */
+	if (data + nr_bytes > d->typed_dump->data_end)
+		return -E2BIG;
+
 	/* Maximum supported bitfield size is 64 bits */
 	if (t->size > 8) {
 		pr_warn("unexpected bitfield size %d\n", t->size);
-- 
2.52.0


