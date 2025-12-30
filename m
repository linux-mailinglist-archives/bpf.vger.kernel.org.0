Return-Path: <bpf+bounces-77505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC96CE8DDD
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 08:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB026302D5E3
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 07:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D162FA0DB;
	Tue, 30 Dec 2025 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDmJ+FMO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774062F656E
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767078810; cv=none; b=JVTARnFMpikNzFg3Ak4nWy7GjARp/80ifLgdXS1DUA0Ls0Z6WRy1Vem8tCShGjmljURHiI//m2TFn9YNZ+FJY0mk7ekZUPgpg+11omDRkyuKqOf6U/vMMatXGrtPfgxWPzv525PlG40IpfgqOf3Zs6jht7c2nKPkXkvu/QcjmEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767078810; c=relaxed/simple;
	bh=EUJJrib4dROAKwQUoPcvHHAvj0DDmPqaHZufRiLUIJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWrniSOjRWiXYN9/YqHcf/mB4bUE/Ut/1zFR1B6cdQ9uWWUskwjS18N9Pg8Ru9NNCH3MdmChXHlE5qt7MybpkLCIUZaKKoEBvtqjsWGbKlgq/PDgqBK/oiOCzHMmSEYIKijdttVlM5M5hYKHvPVRTk+kjEJdEt2savAtRJ6UfaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDmJ+FMO; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-34ccbf37205so7304135a91.2
        for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 23:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767078808; x=1767683608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4n6IIaoE7PUoMtMCOOf10wmn84yuGzTpMnwMihyS87k=;
        b=DDmJ+FMOLkbc8ds1+UyFVJ75gTZFRBZxA/+WoyJ/1GlNkU8C1lRNmfI8THb+57+Jdm
         KAXhV60bz6jridHTkcOdj6QCLGmyCPBaWtyFac7kNqfN05abu/gGvm8DBJKbAPn9yYx5
         1V7Z1JIfjwjafURwJRLr6zSeZ+W+KXCsBEbqt4zKOZ1lfjyuxMiAWUEPGghxSgXDvyxB
         KIo7CFPtTKcYQfYLAAleGwTB35bmgGqtEbHDNmAPZQ9JzcfwZxEblKk2X5hZnAgXcsMV
         O2kNCC1z4mZqv74U8cjTWzB85rPYySCGjpb8Zs48TQztzeLiIxtdPsilFB19dyQyE2Sm
         hWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767078808; x=1767683608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4n6IIaoE7PUoMtMCOOf10wmn84yuGzTpMnwMihyS87k=;
        b=J6nsrQ55bp5ZoVsETJP0NmQEIdI2tWU8woNEpoMHmjTn6X/4BiAJ6gMFlMbDqiq46H
         szv860N4WgOd+u5n/S4iTolOq9OY0vMGwi1Q51yRTUcl+nPZUCZ/nEO6p4V3qrdhmSrH
         ZCuVLTNPEN1SAdRm1caBg1OLeWFddcn/FeIwIKdYG8jdkN/low0VNg+lpSAZzj6UP1vq
         IWAPxqjdzqbFZ5/y4cIXNVidplBAjL+QlmTEKxhppl7EPXNpNWBxfuB1TRXj2ZPjxpWf
         Xll4Fh9o2bgsWdloG6I0pPdGttMS/bsTJ88ypumrMeRpJis71+FfP+ru7JWuZ/ByRt8L
         P8Ow==
X-Gm-Message-State: AOJu0YwZgBmTCOS3weDmyHdLms4tNlzjtg89PhJq51apYFumlbQ869R9
	3hiWjZnHOJBZCN/R+X2V/g7DYgIY9EClinpx2zDtwHxBgI4LZh5lVpZQwZe1rb8qFP6IUQ==
X-Gm-Gg: AY/fxX6U750gAtwXV72g1RGGJoTJSkrrMt3+jTUNPs1YXE7/7vi5rGEkKZPUrDu4E5E
	H6CSUkhZjTx5Od6+XJky2YsnyKd4E9xyW34rJnQ9qUA6PTzJ9dX82PX0YnELD0UVaExzfqyyVxV
	yuHtk+y0BYJNHLSHuJV7Kcj4Hp9caJ75E8oEzQB3wT03rhmm3LBW6QuEeXxoRy62AvID97ihcGb
	PW+dWXU6V8Pyw+9R4kYARbt/O68uTICCr52Hwni6hrrqOeKlvLd0R3B2Iz/vqTJphcoDt7UmKat
	uwYesF6a4ThQlUbdpNgqVzE8GevMNAPILqCJ7Zp4jFI4GzWjkXGj3HC7V1vd1Vtq43mMCTkbBO7
	0B5NiDrm198eUELKkPT3th7ox6Xy0c71+gsXtiEvAGmezRYgNeI5n+7SaD5G/pjFYRyo3czBPix
	IXOsgcGiwhwkcrcAHoRV0eehij8u5GtyLHjA==
X-Google-Smtp-Source: AGHT+IEhQQ4p2YNrzbdUUgecDNECuDyeNU2SVTW2NIC0mh2muP1e15TGglV2MNgT8kiawkn0she11w==
X-Received: by 2002:a17:90b:1d83:b0:32a:34d8:33d3 with SMTP id 98e67ed59e1d1-34e91f749d8mr25223385a91.0.1767078808472;
        Mon, 29 Dec 2025 23:13:28 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e7723b3a8sm15578514a91.3.2025.12.29.23.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 23:13:28 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH 1/2] bpf: bpf_scc_visit instance and backedges accumulation for bpf_loop()
Date: Mon, 29 Dec 2025 23:13:07 -0800
Message-ID: <20251229-scc-for-callbacks-v1-1-ceadfe679900@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
References: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Calls like bpf_loop() or bpf_for_each_map_elem() introduce loops that
are not explicitly present in the control-flow graph. The verifier
processes such calls by repeatedly interpreting the callback function
body within the same verification path (until the current state
converges with a previous state).

Such loops require a bpf_scc_visit instance in order to allow the
accumulation of the state graph backedges. Otherwise, certain
checkpoint states created within the bodies of such loops will have
incomplete precision marks.

See the next patch for an example of a program that leads to the
verifier accepting an unsafe program.

Fixes: 96c6aa4c63af ("bpf: compute SCCs in program control flow graph")
Fixes: c9e31900b54c ("bpf: propagate read/precision marks over state graph backedges")
Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2de1a736ef69514fcf599de498aae56eaf24fe33..0baae7828af220accd4086b9bad270e745f4aff9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19830,8 +19830,10 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				}
 			}
 			if (bpf_calls_callback(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur, RANGE_WITHIN))
+				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
+					loop = true;
 					goto hit;
+				}
 				goto skip_inf_loop_check;
 			}
 			/* attempt to detect infinite loop to avoid unnecessary doomed work */
@@ -25071,15 +25073,18 @@ static int compute_scc(struct bpf_verifier_env *env)
 			}
 			/*
 			 * Assign SCC number only if component has two or more elements,
-			 * or if component has a self reference.
+			 * or if component has a self reference, or if instruction is a
+			 * callback calling function (implicit loop).
 			 */
-			assign_scc = stack[stack_sz - 1] != w;
-			for (j = 0; j < succ->cnt; ++j) {
+			assign_scc = stack[stack_sz - 1] != w;	/* two or more elements? */
+			for (j = 0; j < succ->cnt; ++j) {	/* self reference? */
 				if (succ->items[j] == w) {
 					assign_scc = true;
 					break;
 				}
 			}
+			if (bpf_calls_callback(env, w)) /* implicit loop? */
+				assign_scc = true;
 			/* Pop component elements from stack */
 			do {
 				t = stack[--stack_sz];

-- 
2.52.0

