Return-Path: <bpf+bounces-62200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FD1AF6583
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 00:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3985176A57
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 22:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ED624C06A;
	Wed,  2 Jul 2025 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaNWKfm2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821262522A1
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751496140; cv=none; b=eAJsI1GqphRwceWCuPn8nBt2J5krC2vPVqJjjtOQyBcZlgCqiqSx7nnn5e1M4MSLE+WV0BjlKUZB9D8GrtNNXFzCAK1eyk/5LWzo+Yxm7ZiDaVrN8Vu5gnThyciQsXCu3nkIjOpjPbPXDpULb71VtIX/a/Olutym2YQCwSorTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751496140; c=relaxed/simple;
	bh=rfrI/GZzQPOVlt6ywJBHUn5d0kuwUSm43+EGqTf6Z2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlEi/MEZLu1gR6b9pS73I56qebJZROksN9fhCaVif4ozV+TSAVc50kGlytz3zVrFUvPgCGWW4JxHf4TkYFNgM5rzy9uWxsayCprR6O7efPn09KDNhbt0++GaHiP3ir8LzWIrv6ewaqDDVQtoCR7QSD3FHK7ObJr+Q3ZUUe5QlQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaNWKfm2; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e85e06a7f63so4311432276.1
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 15:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751496137; x=1752100937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkUXTfsXfjiXyE7smshxJhZmsgbhG01Grik48hop/44=;
        b=TaNWKfm2mDBoJ00gFlQLvV2aHgCjulSRk2GhTtT6Wrz3OXLMiFYAIXsXZXXTWQkL07
         sgaTy+3l81mOOkrgQ8vYyMknbno8vZh+lUpfQTGATqJAnzFF8cg5b+mgI0eL8Rh/uz2b
         IcbOWGGLeL9wTJ+qAcxS2bsZjYcFA5zrX3v5HzsiT4tqBDhhjtmdAlCiqqJIfLSNibCz
         pF+XQQS2+FGiis3YZXNNWKLHfdxZr7u/Sxng4jd2ecBQ/7Ael12/cpyb69nJ63K8ubcB
         rlv8HNUGRvqEI2Kkp7T1EW57QzeVRAzu6foxN777+N8BUwlJJYKF9OnYvTlSj1JtmAO7
         ViOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751496137; x=1752100937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkUXTfsXfjiXyE7smshxJhZmsgbhG01Grik48hop/44=;
        b=GEmKxw1jbzsz9ouySqfueEO2qW5q5Mwmc5WWLeBwbkJg8HkBovY4+K6sxuETJsbxhW
         BPcC0DyeMGQxp6PJDRLX+EOT5K4AEiwPDxC5zANljbOW9/qvT/Q9aBrgZzwGNtOgAsAv
         /F0O3k3aeuIuKbe6Hl1hmBWb1i0R+65D/+axA56vSPVAc3YXXIq1Xs6BXVHg/4Lblp+X
         XDw/VO8gQbNt1EXdp1si54OOFLIpQM8vt53l+ryO4FpiMxogecwXDuoWrAIV9N57TiQ1
         GPane73J/62nnSG8mZrvDWayVV4EA4+WEgbIUXnZ24+SsvrAdBFNEmM/OqTlBbgCkTh7
         q3yg==
X-Gm-Message-State: AOJu0YzODKhaPJwBLMk9XFjZN0oGfDfoF3rsOYk3s6UcIUylBzhDrn6J
	gQDjRqStTodVgBpFWMydADpPE0a0cNzgDf92aRCXwe+0HkvxbLFNOQRsDQenaqhN
X-Gm-Gg: ASbGncvO56fDSFUxR2htdBYft1mGnVim44kcsOPgwTRxXSKE1tExM68BcwhsbOPwp8K
	NH3H35yJH8rTDKejUYrZ825MIJNYT4eUQSfR23MvI5LlvRvkVooaAtLgBBLvaSJr+TokZ0p0R9q
	1XKjv7CFIoEwOKnm2rVXZgVsGCAAN5vCDRqRvCJWwUlsrPyUKhn/EKruivCp661F8/Od9xeqFHe
	tdBsTjeLq9fs49HD2+hhg0RESVhMbHoIx5xnZDSmh6tIr4nXuyFJTDeIPDYILViUb2xghGWMULW
	GKISqGbGZaoZv1ZHyIBtbbU3V4QiAyXJoZkFyS2bsIUtC2ZI6PcThw==
X-Google-Smtp-Source: AGHT+IFz0Hncp/egYWN7ZC8L5UIpD7dYieMAwBdsxUG08GR3Yt49cJJNKWbgRTqpBWBGRRrMD68ziw==
X-Received: by 2002:a05:690c:3704:b0:716:4da5:a01c with SMTP id 00721157ae682-71658ff8fe7mr25303657b3.11.1751496137391;
        Wed, 02 Jul 2025 15:42:17 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515bf1659sm26620747b3.18.2025.07.02.15.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 15:42:17 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next v1 2/8] bpf: rdonly_untrusted_mem for btf id walk pointer leafs
Date: Wed,  2 Jul 2025 15:42:03 -0700
Message-ID: <20250702224209.3300396-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702224209.3300396-1-eddyz87@gmail.com>
References: <20250702224209.3300396-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When processing a load from a PTR_TO_BTF_ID, the verifier calculates
the type of the loaded structure field based on the load offset.
For example, given the following types:

  struct foo {
    struct foo *a;
    int *b;
  } *p;

The verifier would calculate the type of `p->a` as a pointer to
`struct foo`. However, the type of `p->b` is currently calculated as a
SCALAR_VALUE.

This commit updates the logic for processing PTR_TO_BTF_ID to instead
calculate the type of p->b as PTR_TO_MEM|MEM_RDONLY|PTR_UNTRUSTED.
This change allows further dereferencing of such pointers (using probe
memory instructions).

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/btf.c                                     | 6 ++++++
 kernel/bpf/verifier.c                                | 5 +++++
 tools/testing/selftests/bpf/prog_tests/linked_list.c | 2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 05fd64a371af..b3c8a95d38fb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6915,6 +6915,7 @@ enum bpf_struct_walk_result {
 	/* < 0 error */
 	WALK_SCALAR = 0,
 	WALK_PTR,
+	WALK_PTR_UNTRUSTED,
 	WALK_STRUCT,
 };
 
@@ -7156,6 +7157,8 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 					*field_name = mname;
 				return WALK_PTR;
 			}
+
+			return WALK_PTR_UNTRUSTED;
 		}
 
 		/* Allow more flexible access within an int as long as
@@ -7228,6 +7231,9 @@ int btf_struct_access(struct bpf_verifier_log *log,
 			*next_btf_id = id;
 			*flag = tmp_flag;
 			return PTR_TO_BTF_ID;
+		case WALK_PTR_UNTRUSTED:
+			*flag = MEM_RDONLY | PTR_UNTRUSTED;
+			return PTR_TO_MEM;
 		case WALK_SCALAR:
 			return SCALAR_VALUE;
 		case WALK_STRUCT:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b6d26e8bd767..cd2344e50db8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2813,6 +2813,11 @@ static int mark_btf_ld_reg(struct bpf_verifier_env *env,
 		if (type_may_be_null(flag))
 			regs[regno].id = ++env->id_gen;
 		return 0;
+	case PTR_TO_MEM:
+		mark_reg_known_zero(env, regs, regno);
+		regs[regno].type = PTR_TO_MEM | flag;
+		regs[regno].mem_size = 0;
+		return 0;
 	default:
 		verifier_bug(env, "unexpected reg_type %d in %s\n", reg_type, __func__);
 		return -EFAULT;
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index 5266c7022863..14c5a7ef0e87 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -72,7 +72,7 @@ static struct {
 	{ "new_null_ret", "R0 invalid mem access 'ptr_or_null_'" },
 	{ "obj_new_acq", "Unreleased reference id=" },
 	{ "use_after_drop", "invalid mem access 'scalar'" },
-	{ "ptr_walk_scalar", "type=scalar expected=percpu_ptr_" },
+	{ "ptr_walk_scalar", "type=rdonly_untrusted_mem expected=percpu_ptr_" },
 	{ "direct_read_lock", "direct access to bpf_spin_lock is disallowed" },
 	{ "direct_write_lock", "direct access to bpf_spin_lock is disallowed" },
 	{ "direct_read_head", "direct access to bpf_list_head is disallowed" },
-- 
2.47.1


