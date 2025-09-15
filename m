Return-Path: <bpf+bounces-68364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2433B56E6E
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 04:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C4B3BDCAC
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 02:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EB222370A;
	Mon, 15 Sep 2025 02:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWDWMcwg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B221CC4D
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 02:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757904460; cv=none; b=b3eYY7GmXzDYfhLZ3HrXPpzIQ8QBvl4HesW0ApaXmdk+bqO+mub/63NHgQM6N44mDvTVuKAkwdwEPcPlXN9Jv3yvXqgwJtmTtNX0lLzVZUlg6p8Z3wOy4cSlpJaAlbo+qElCRqLenuKqLMJSejA2Gpahlq6pq0xAhzV2FebPbAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757904460; c=relaxed/simple;
	bh=N2Qd/DEtvuE4TG0sfnBDyrhMC/YV7lj3t2KAPhRonxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRN66BpEQd/WddFWehE7uR17NCBoMTRQ3wf6zCGH+wTBZ8LGVli3NETP0ncRcAgz3Egy54smGOBbq5aWV2f3k2f+4k/ylDYr1PaldJ0dx8AZ+L0D3NfxPDOXnuTmOfH2oXJwPBGxTtz93ljedE1gx2lThykAhOpeb0OJaRWvTiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWDWMcwg; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3e8123c07d7so731055f8f.0
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 19:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757904456; x=1758509256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fslc39cq+eXAqGzQAThnOD89OtzY033X7uXrXTxYY6s=;
        b=aWDWMcwgjiF9BYfWUHIeV3g5yELroP5CNLZ14BjL6++aYrOaJCfw+ofUkBCdpXCEZ6
         ZHHKgS6VzuCwkXAycoF396wlboUl5D1n1Ca4uu+dpbZL1Za/vHYj8qfE53vXuiZ2nZPA
         Vi3PUx1M06ypUhmjZDaIE8ERTqs1g/RkEK75XUNOAJjEscxoD6mXBA47fM3GHSmeVNjY
         3nC/jD0540PhR7FMmk7+1YxYou05HV34gzvOI2WNDKrXQ4XIHlzOOcyhNU/SD5UeCmju
         9KVGgHhgD16c0Awbu9ngMOoxl2+ND8lMlSDl0lD7QXYcpAoLUgUMlWChNmcMi/3eZB8f
         3siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757904456; x=1758509256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fslc39cq+eXAqGzQAThnOD89OtzY033X7uXrXTxYY6s=;
        b=Q7wUzcFKtcRnyzV1CSwALaAiHXTKqBigOmRdK5f1OGGH3CFuk4IAoz7wk4HoLlRUxV
         SYrOEksGOxuTJDyVFxTMdj+xALqE5NEIZkl2C04p8Ww3udrcMGKk/IuCBZgqWWap6Kr1
         j3DJzRo4+UUaSOYi9E/2aXdbPL8Tu/RykJsp0WLqtgt+jIidkb+gYqhSWGN1gW9F34TX
         C8pCwSz3KB1oUUx2NX1HTsaN94tkAJ9mewfjApjXDNSIUNbsU1Oe7ZAOLbwaUj3+0UGj
         p92ABKi7i0DJPOGDK6g2kER4RzOwifuXzbPvZWQ3aomUNfs6rjlsVZkwz9eNsAuH85F1
         qHJw==
X-Gm-Message-State: AOJu0YwJyH444GNr9DH0a7Yy3r7+zxWpL6OpcECrTdl3o2kmhIF9gnAs
	8wTA5SuvsjE76PP1DNe1Ir2i7rstSXRDOJSJgyYKLzAg4681lPeQdHfXJMKqbTRe
X-Gm-Gg: ASbGncuiWLUflvOjc3gw/D4nywt+be0Kf5ZFr1jWOBCeiDI/5kQGWNWy9gmVN7jH2mf
	x5E+HcLhtUxxAAuGfBAUBmrpHiiiSGQPS1ejMliUCJCoDvYn9ZMCCwd8ZRIX2YZXZtTrzzYtsBg
	7bMvzWXKAnKUlvoew/TFkgG0QqX4kR+xeuKnOklUnr9NqUOZluFekcXHPuchE39nMXpZus9gCeF
	1NlZelNZ96iE8YOyZEdgp2n4GcevLojn/+v5luNsE+CZPJy0RVck5PfXBUiL+b8da+CU3NeAx0p
	SaMVYTMR5kgIXNVBSNj65ioqBUG68iMlD2eryCIlcSSfo0bUpf1nbwG5/CZsY85zsIC0wIi/qnk
	L3a1qmL78NbNoxjX95tYYnhwG2ljLsKM+6McC+zYQZNsg
X-Google-Smtp-Source: AGHT+IGmow4U2wdtga7kpt4kPreobF4yDkF5iksEUHzg3nt3j2SFEd6Up4EHWEvwo0F6t3npyXO6KA==
X-Received: by 2002:a05:6000:22c5:b0:3dc:1a9c:2e7f with SMTP id ffacd0b85a97d-3e7657a9469mr5571500f8f.8.1757904456174;
        Sun, 14 Sep 2025 19:47:36 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e9996f384bsm5124374f8f.56.2025.09.14.19.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 19:47:35 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/3] bpf: Add support for KF_RET_RCU flag
Date: Mon, 15 Sep 2025 02:47:30 +0000
Message-ID: <20250915024731.1494251-3-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915024731.1494251-1-memxor@gmail.com>
References: <20250915024731.1494251-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3456; i=memxor@gmail.com; h=from:subject; bh=N2Qd/DEtvuE4TG0sfnBDyrhMC/YV7lj3t2KAPhRonxc=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBox34hlAK9i+d5A1o87CaYOlH+iquS0hf8ZTLu1 P12We2bU8GJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaMd+IQAKCRBM4MiGSL8R yl9AEACXdiVsftrjnF/0R5GqrUT+zFHq18X3rJyykzaMzksGDFG6xVFlAulhEWQKebiBCvcO2nd SQbcwziJRM7XItaqCbdMNhfRzCTiK1n7kJawwh1O1EVB1558sJ5NRP9Xo19xVStfscDlebX69lZ JzRj92Nm57h2myJOLBl+T3x6jQd+jlB3k4L0cR/4BbwAk4Rn9H3rBv0y5eTKK+CtyvNSHjhHci2 aUPvqvVXzCwbLgW4kVD8o+i07o71X0Psf3ihONkfkqfL3nvla3/bAQgjQ7J7yxzqS6JIzj0HCMI aiZuWWlQxGUSTT/hwwXb2S5yQQU7FNbdLBOgkVe8G2H2XoC73QecAYZ4kCF4PoL6LckpULex6jw 5VE8OIdFr3rbtrwQcqR2kG8SI07HfsjTVYNGqOFeu1JcvhPKvVlDPcG06tVeQ4lZvPQcXSyxuWb noQ23GXa+2pXs6eJj1x4rmDG0BtpZW5hTwcMENnQ7v/tjj+6kgFDc8hCtbycqIxt1RJvkGFEnuw Rydjzr9Tc4HlHGH0Q+hWdreEzhbz4TAdJPFXput9oFkZC4OACF3/P4g9BIEw7TU4EpRo2iSZ4Wb Zqpfxs+8+1Inj4ZFYuMsRpqUwisDqw43NkX+cZSD02HP4IHf79Hsn8VLZ5VrDnXjraJ11ICEXm9 CTOkb5M6L5UWnIQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a kfunc annotation 'KF_RET_RCU' to signal that the return type must
be marked MEM_RCU, to return objects that are RCU protected. Naturally,
this must imply that the kfunc is invoked in an RCU critical section,
and thus the presence of this flag implies the presence of the
KF_RCU_PROTECTED flag. Upcoming kfunc scx_bpf_cpu_curr() [0] will be
made to make use of this flag.

  [0]: https://lore.kernel.org/all/20250903212311.369697-3-christian.loehle@arm.com

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 13 +++++++++++--
 include/linux/btf.h          |  1 +
 kernel/bpf/verifier.c        |  7 +++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 18ba1f7c26b3..7d1b7009338b 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -346,10 +346,19 @@ arguments are at least RCU protected pointers. This may transitively imply that
 RCU protection is ensured, but it does not work in cases of kfuncs which require
 RCU protection but do not take RCU protected arguments.
 
+2.4.9 KF_RET_RCU flag
+---------------------
+
+The KF_RET_RCU flag is used for kfuncs which return pointers to RCU protected
+objects. Since this only works when the invocation of the kfunc is made in an
+active RCU critical section, the usage of this flag implies ``KF_RCU_PROTECTED``
+flag automatically. This flag may be combined with other return value modifiers,
+such as ``KF_RET_NULL``.
+
 .. _KF_deprecated_flag:
 
-2.4.9 KF_DEPRECATED flag
-------------------------
+2.4.10 KF_DEPRECATED flag
+-------------------------
 
 The KF_DEPRECATED flag is used for kfuncs which are scheduled to be
 changed or removed in a subsequent kernel release. A kfunc that is
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 9eda6b113f9b..97205b8a938c 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -79,6 +79,7 @@
 #define KF_ARENA_RET    (1 << 13) /* kfunc returns an arena pointer */
 #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
 #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
+#define KF_RET_RCU      ((1 << 16) | KF_RCU_PROTECTED) /* kfunc returns an RCU protected pointer, implies KF_RCU_PROTECTED */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index aa7c82ab50b9..f1cc602ed556 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12342,6 +12342,11 @@ static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_RET_NULL;
 }
 
+static bool is_kfunc_ret_rcu(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_RET_RCU;
+}
+
 static bool is_kfunc_bpf_rcu_read_lock(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->func_id == special_kfunc_list[KF_bpf_rcu_read_lock];
@@ -14042,6 +14047,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 			if (meta.func_id == special_kfunc_list[KF_bpf_get_kmem_cache])
 				regs[BPF_REG_0].type |= PTR_UNTRUSTED;
+			else if (is_kfunc_ret_rcu(&meta))
+				regs[BPF_REG_0].type |= MEM_RCU;
 
 			if (is_iter_next_kfunc(&meta)) {
 				struct bpf_reg_state *cur_iter;
-- 
2.51.0


