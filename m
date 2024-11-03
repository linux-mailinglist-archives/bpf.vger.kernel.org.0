Return-Path: <bpf+bounces-43853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C849BA96E
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 23:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CD4281A8B
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 22:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0EB18C920;
	Sun,  3 Nov 2024 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5T5aBOs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E95218B497
	for <bpf@vger.kernel.org>; Sun,  3 Nov 2024 22:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730674787; cv=none; b=tZLJs7kJgRXWxsresS0HsLuRYbH4/p+a8I2oyO+s4awKHHKxWlIHI3HuC9SpKucH9aEKhL4pYjqPobOaSvRGAE7iCM+A1lD+qgUj/2hTbUtYfV+qIbvirzceKkpldGFQ3gnXyeRMFOEqai1PuqEBJt8v7veNxMWD9YGdS+fh74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730674787; c=relaxed/simple;
	bh=hTDEHm7KPUVegNa8ajbrO7dQTDhQriCT+IavL4mnmjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFW/q9houDIqS0RFh6XrXoI1rQuPmmMHLYyZmusvvf3OK/TosmRyF0NQsicayWJv6m9NY/l3lwE1bRBk8lh4KVBKJXTCwCl4ND9NmjbhxK2C4JoeHNMDZ1EsyY2QRTnjy8y1o+L5xxVRKPWB7rpcHw6u2uujzsf08L2ELtvtUcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5T5aBOs; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so28139865e9.1
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2024 14:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730674783; x=1731279583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0hbH+nV4kSlKadft/+ZPJqCvizFXnBqrXWROlk1T1Y=;
        b=H5T5aBOsxKGOvEbKw03Zam1Z2aUjP5cSMIh5e0Mt4mhSI4f3H+wq4nDCPbNXuucJ1N
         LC3QxlgvvdNDk4Z9mhn6oqThYOC7gRAUDttUAqU298ytOTkBQpDCwA17D+gSgbfY34oQ
         tgFZg1D/CY22Lho90uRMFtInIGNaU76pHKAmlRAHW24UbDVHoBLsrkcvrlj7o0vfr/9U
         LOM6TEhw5dHZ1I1AST9+cUL0LN3GCPt44DUQAJuyntsFnGJC884OsoYlI6rmcI9ySSq5
         Um/6odzEQl3IGjs26FUxYC6jH6B/QZ3rw3jG/GEQB3ehj6nUwBzEo3HXEPqL5mrtc4gg
         DHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730674783; x=1731279583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0hbH+nV4kSlKadft/+ZPJqCvizFXnBqrXWROlk1T1Y=;
        b=mh6fJSizx9HmpjSWZ3AS9YLV4ig6K1yUkDHIlCFEEQP8GzM0zGb7sUh/PGzQI2TwHR
         n2nn2iaGwcGoCfjxPUSK/zb8ShrlPsAPFxmL3r+6T6EvsUeiK0P/AayYGdAexM5NKJ1h
         z1c/wV+EY4VZ/N2UoWJ1en6weSpTBHshUPkgETFR+zJn6NIXrLrWvtCeThL/MgINvFEr
         IzC1ymyhgiAUOq9YpkV36gXlpOYS8q8slyGwjDip43mlh25spaAMVAkS3Q3K53y/wiAU
         njJGOnt3WtQmoGN8d/glvK3I7rFozN9VSaIanWyAs+1zisDXmI21AIvIt/wjXjI/5QeH
         sfwg==
X-Gm-Message-State: AOJu0YxLEIL8xli1C497Dw978+3nmQ3EXceAGnU0+Tnh3t9unHHBqYT7
	WEEzT1YrxxNUc9o3gsXE2jKPjYwkm7Qqbq/xXSBgtomu4WcYPSuHN6b85xs4d3sQog==
X-Google-Smtp-Source: AGHT+IGklWtXAGWxHGsol5wPAxBAz/rL/cimcjC6G4giFmjDkB7DxDYk8uw9BsghQfP4ESw46Sgmnw==
X-Received: by 2002:a05:600c:468d:b0:42c:a89e:b0e6 with SMTP id 5b1f17b1804b1-431bb98558cmr156470695e9.11.1730674783429;
        Sun, 03 Nov 2024 14:59:43 -0800 (PST)
Received: from localhost (fwdproxy-cln-033.fbsv.net. [2a03:2880:31ff:21::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e5e3sm11597146f8f.82.2024.11.03.14.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 14:59:42 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v1 1/3] bpf: Tighten tail call checks for lingering locks, RCU, preempt_disable
Date: Sun,  3 Nov 2024 14:59:38 -0800
Message-ID: <20241103225940.1408302-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241103225940.1408302-1-memxor@gmail.com>
References: <20241103225940.1408302-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1903; h=from:subject; bh=hTDEHm7KPUVegNa8ajbrO7dQTDhQriCT+IavL4mnmjU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnJ//pRuopfpCeJSwHmqLvhBuXNwZoWLYSmJlOgkbl bA31Jq2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZyf/6QAKCRBM4MiGSL8RysFYD/ 9N7NMJ4qhPKZFXBf7AT/5QxfF8UkyWlA7jy9GlldXDB0n8ysniGZLwoBAuKqLLJ7dGZMp6THqx5as/ 9Ses9Mb3ks27kX5orpVY2QkXXEZJW/TCUYxBAJ8N2DfpY9nTO8nZrnvpj0h+N0O6air2C9jT23R/sc UlnayH/4vWlVW2IRx5YCm9A8/Pi9YQTUYk3W17q/WWQ2ll6nRGuNRgsanJ8YieiFy4DPHf+hOKc+tf X5973HvnfNYsxX7Ye0TfIj8QgzLEUpMmBABlX1hpcoGBP39vMiqG0EGrshUvCi+7hcPHtgIvE2HVPw lxQHFb83G51FvZLTOhgz66Zrz81f9Z5GGqlANGmAE0vFV8l9YLkqk6rSEm8RUdVXpA+Wi0McMdcpIj o4mI0n4tPuAbtFkxMLel+pMVwIerObvGjjymyh61TxVkXXFDPyryRtoQ404Z0GGSMzOjYOtxhusbYE UEpvp1POphnVpMwCyVEwlj2ddINo2Hv7w2VmLqMiAqyDEISX/qNDlzM61ShTo1ZuwaFcy0qs4/AImK 5LWhO1TwFCopmyl/75jrIF96+8J6CQ71BcscMiAagvCpuw2YqBWG7v17T27MSNhyRXAuDNNHl9NEhI U1U1D5XoOOCv4pedDwAuRrYk3Q0LZJQPXFATfglSAg/vKVSczbd43WQTaYlA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

There are three situations when a program logically exits and transfers
control to the kernel or another program: bpf_throw, BPF_EXIT, and tail
calls. The former two check for any lingering locks and references, but
tail calls currently do not. Expand the checks to check for spin locks,
RCU read sections and preempt disabled sections.

Spin locks are indirectly preventing tail calls as function calls are
disallowed, but the checks for preemption and RCU are more relaxed,
hence ensure tail calls are prevented in their presence.

Fixes: 9bb00b2895cb ("bpf: Add kfunc bpf_rcu_read_lock/unlock()")
Fixes: fc7566ad0a82 ("bpf: Introduce bpf_preempt_[disable,enable] kfuncs")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 797cf3ed32e0..0844b4383ff3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10620,11 +10620,26 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	switch (func_id) {
 	case BPF_FUNC_tail_call:
+		if (env->cur_state->active_lock.ptr) {
+			verbose(env, "tail_call cannot be used inside bpf_spin_lock-ed region\n");
+			return -EINVAL;
+		}
+
 		err = check_reference_leak(env, false);
 		if (err) {
 			verbose(env, "tail_call would lead to reference leak\n");
 			return err;
 		}
+
+		if (env->cur_state->active_rcu_lock) {
+			verbose(env, "tail_call cannot be used inside bpf_rcu_read_lock-ed region\n");
+			return -EINVAL;
+		}
+
+		if (env->cur_state->active_preempt_lock) {
+			verbose(env, "tail_call cannot be used inside bpf_preempt_disable-ed region\n");
+			return -EINVAL;
+		}
 		break;
 	case BPF_FUNC_get_local_storage:
 		/* check that flags argument in get_local_storage(map, flags) is 0,
-- 
2.43.5


