Return-Path: <bpf+bounces-73837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B10AC3B0B1
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F003BFD5C
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C86133032B;
	Thu,  6 Nov 2025 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx+2DDAY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A393632ED48
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433621; cv=none; b=NfPtpeRs31//59JXar6XQOSSSHxvXLH7zh4b1WN6pKpuuYbQVHD18bRu+u4T6Aar2+KQf5Gon+0WYOR6XqUjQG8HiFbDqVcE20Jwdy1j9LwVx75VsSg1N0e4nH9x8c153dNrtWZcSZQjtr6RrhI7nk9JbtWkRlI8LFsgLmPrA8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433621; c=relaxed/simple;
	bh=lnliqdz3U4tbAfip1w9XCBAoh+WGXYM0C9rl3tucgdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uhCvMFgub1fny5KfTvo71NOcrDatXOKBpUr/GlNsVtT9A3IOYOAbmwqeutJgZdJ8XDrxs6fovKQjtfdNx7DmV/V2lQQL4wneBLyOgPQepkgb9VaPdsiSYqoA5Tx2vnJpEnAAt66fvINJR1XjCXLsXM4FmxmSMfhVqdHBb2KDV7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sx+2DDAY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4298b865f84so477427f8f.3
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 04:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433617; x=1763038417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtWO+ldHw1Wy/NkP7lvHXeHyDhyCdc2lFNTCoxBTl4g=;
        b=Sx+2DDAYZK9+8aDYXaajurQ2q4cd+nQv1BQmSg83bwUvPWFt0o2BP9L+j4YZljotHb
         ivv7kfyA4uiCX1Z/vz7QSxUgvTUICveElw80SGQPpo11nFDsVx96qWb5wx0Y9UbVmmFs
         fTtseg0F7WuYEeDI23/Wnz1Ya7WExkmlRZIPL1aNP8Ru4Qu7Bh/lBSmLCt461OwGKPmr
         HLmZ2pnIkAilZRzIfez+lfId9D4b7kGgOSEqAtpW9YczPsbZfpgF/3yHlDpi2JDsriO6
         RRYbcreW8VnQ381hSvLNS8i3cqpzbcFfqDwdM87XBJA3otd3YFyFmvEQNE/z/m7ztG8A
         4//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433617; x=1763038417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtWO+ldHw1Wy/NkP7lvHXeHyDhyCdc2lFNTCoxBTl4g=;
        b=S1HgxRhNR7SHd777Tqi6FuuY1fRsdw1maqu8p4ttPdraflpdPleFyhGdT+0Nkj9o0H
         lrNka74TLtOY+Wm/paoirPFCZfIrv06ae35PJK01qMzWsI0SbAqUySiADLENCBLyew25
         YdOptGi+1QxM2Sf01myNc8GjDs02etMGU7TdTcYvTFwbvhqaGZe1kHmM6vphrdNWesrp
         2HA9OKYmZ5z+qH1BVglWJGI9xUMOJqSs2AZVkXQe8ldPYWi5AvoBNW0ONv0r3g1OmGuA
         aN7PE/q36p+YTT0gcOW2CAcophROtUJhwauyUmoLKHADH2m7RXmgqwNHw6CZ9sILCuik
         VllA==
X-Gm-Message-State: AOJu0YwM+mQSzXTidMXHSma9TmDXaz2tYCod/x0txJm3Gu0M1ZKIdry8
	+cBYbM7HbYH/Y6dPVgzfUHx1SJnSwv7mk6uh5NfJa/fht21crvYDDOZfDOOk
X-Gm-Gg: ASbGncu1WY8hQjF5+J34iLlv1yH0eXPSyuovQhsawuLW93oKgBzwIITYidXFb7A23Wo
	K9miqrLNaxKeW8ArqB7pEluZqLB5akzrcSsUTw1ego4ElDPcV73gNEThzLbJnvVlilZSlqcrwMj
	rhG5s2QYGth0OX+DMAV35YiHoA5DDhMddeJfdcouxbcdwKsaU2uH+dZgFngLl0uXvlTH5GW+0Ca
	6n7fy8kYC/tMrfTicnK70tqvxY71kc8LPEVnG35UhcB0+9EXa1cIxpRxfCT/NNsGZOgKQzRoZ0H
	ZjKZ/3wX1TToSeq5beKMJF1wFBpFPE0NZsFceVRNT2GlkQnUOgUVvjk+PCpSheoMMMP2I68mEJE
	jbHykd4wUwUd7EVVT/5ZRz96UssiR87tkQkJvzVqdmnliuR1bkYVU/MxnGY7TGQv18uBTADTcNU
	fIEpBZhrQSiIYtIv7wR2u5drCdFBkVj1Avy5giAZ8J1u2N7NSzFODgoj4+4wrRFBoBLw==
X-Google-Smtp-Source: AGHT+IGueWTt8hn/ZGltEhVjG/PwRBMDPPm6r+dASr9SWGX5Tn9PcRkBUL7A4DVVGKBJwyW+I5n/Iw==
X-Received: by 2002:a05:6000:2885:b0:429:cf86:1247 with SMTP id ffacd0b85a97d-429e331395dmr6073417f8f.57.1762433617479;
        Thu, 06 Nov 2025 04:53:37 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:37 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
X-Google-Original-From: Hao Sun <hao.sun@inf.ethz.ch>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	sunhao.th@gmail.com,
	Hao Sun <hao.sun@inf.ethz.ch>
Subject: [PATCH RFC 03/17] bpf: Add UAPI fields for BCF proof interaction
Date: Thu,  6 Nov 2025 13:52:41 +0100
Message-Id: <20251106125255.1969938-4-hao.sun@inf.ethz.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
References: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend union bpf_attr for BPF_PROG_LOAD to support proof-based verifier
refinement. The new fields let the verifier export the refinement
condition to userspace, preserve its state behind an anon-fd, and later
accept a proof and resume analysis.

- bcf_buf, bcf_buf_size, bcf_buf_true_size: shared buffer used first to
  export expressions+condition to userspace and later to receive a proof.
  true_size refers to the condition size and proof size accordingly.

- bcf_fd: anon-fd that owns the preserved verifier_env. Set by the kernel on
  request; userspace passes it back when submitting a proof.

Tools uapi is also updated.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 include/uapi/linux/bpf.h       | 21 +++++++++++++++++++++
 kernel/bpf/syscall.c           | 23 ++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h | 21 +++++++++++++++++++++
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 1d73f165394d..fbe99fbc39ab 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1484,6 +1484,15 @@ enum {
 	BPF_STREAM_STDERR = 2,
 };
 
+/* bcf_flags used in BPF_PROG_LOAD command to indicate if the verifier
+ * requests or the user provides proofs.
+ */
+enum {
+	BCF_F_PROOF_REQUESTED		= (1U << 0),
+	BCF_F_PROOF_PROVIDED		= (1U << 1),
+	BCF_F_PROOF_PATH_UNREACHABLE	= (1U << 2),
+};
+
 union bpf_attr {
 	struct { /* anonymous struct used by BPF_MAP_CREATE command */
 		__u32	map_type;	/* one of enum bpf_map_type */
@@ -1624,6 +1633,18 @@ union bpf_attr {
 		 * verification.
 		 */
 		__s32		keyring_id;
+		/* BCF buffer for both the condition to be proved required by
+		 * the verifier and the proof provided from user space.
+		 */
+		__aligned_u64	bcf_buf;
+		__u32		bcf_buf_size;
+		__u32		bcf_buf_true_size;
+		/* output: BCF fd for loading proof, set by the verifier when
+		 * proof is requested.
+		 */
+		__u32		bcf_fd;
+		/* input/output: proof requested or provided. */
+		__u32		bcf_flags;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8a129746bd6c..5968b74ed7b2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2854,7 +2854,7 @@ static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr
 }
 
 /* last field in 'union bpf_attr' used by this command */
-#define BPF_PROG_LOAD_LAST_FIELD keyring_id
+#define BPF_PROG_LOAD_LAST_FIELD bcf_flags
 
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
@@ -2869,6 +2869,24 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (CHECK_ATTR(BPF_PROG_LOAD))
 		return -EINVAL;
 
+	if (!!attr->bcf_buf != !!attr->bcf_buf_size ||
+	    (attr->bcf_flags & ~(BCF_F_PROOF_PROVIDED |
+				 BCF_F_PROOF_PATH_UNREACHABLE)))
+		return -EINVAL;
+
+	/* Check proof and resume the last analysis. */
+	if (attr->bcf_flags & BCF_F_PROOF_PROVIDED) {
+		if (attr->bcf_buf_true_size > attr->bcf_buf_size ||
+		    !attr->bcf_buf_size)
+			return -EINVAL;
+		/* The resumed analysis must only uses the old, first attr. */
+		memset(attr, 0, offsetof(union bpf_attr, bcf_buf));
+		return -ENOTSUPP;
+	}
+
+	if (attr->bcf_fd || attr->bcf_buf_true_size || attr->bcf_flags)
+		return -EINVAL;
+
 	if (attr->prog_flags & ~(BPF_F_STRICT_ALIGNMENT |
 				 BPF_F_ANY_ALIGNMENT |
 				 BPF_F_TEST_STATE_FREQ |
@@ -2901,6 +2919,9 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	bpf_cap = bpf_token_capable(token, CAP_BPF);
 	err = -EPERM;
 
+	if (attr->bcf_buf && !bpf_cap)
+		goto put_token;
+
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
 	    (attr->prog_flags & BPF_F_ANY_ALIGNMENT) &&
 	    !bpf_cap)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1d73f165394d..fbe99fbc39ab 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1484,6 +1484,15 @@ enum {
 	BPF_STREAM_STDERR = 2,
 };
 
+/* bcf_flags used in BPF_PROG_LOAD command to indicate if the verifier
+ * requests or the user provides proofs.
+ */
+enum {
+	BCF_F_PROOF_REQUESTED		= (1U << 0),
+	BCF_F_PROOF_PROVIDED		= (1U << 1),
+	BCF_F_PROOF_PATH_UNREACHABLE	= (1U << 2),
+};
+
 union bpf_attr {
 	struct { /* anonymous struct used by BPF_MAP_CREATE command */
 		__u32	map_type;	/* one of enum bpf_map_type */
@@ -1624,6 +1633,18 @@ union bpf_attr {
 		 * verification.
 		 */
 		__s32		keyring_id;
+		/* BCF buffer for both the condition to be proved required by
+		 * the verifier and the proof provided from user space.
+		 */
+		__aligned_u64	bcf_buf;
+		__u32		bcf_buf_size;
+		__u32		bcf_buf_true_size;
+		/* output: BCF fd for loading proof, set by the verifier when
+		 * proof is requested.
+		 */
+		__u32		bcf_fd;
+		/* input/output: proof requested or provided. */
+		__u32		bcf_flags;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
-- 
2.34.1


