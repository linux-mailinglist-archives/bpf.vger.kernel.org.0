Return-Path: <bpf+bounces-33416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9EA91CBEE
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 11:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00271C21258
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 09:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE893CF63;
	Sat, 29 Jun 2024 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtdpMIBZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E68C39AFD
	for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719654489; cv=none; b=ZOJu2jGxajf3nUKmdBKVFNEmPW9Os+2z/57QOAxBEWSk0Vowa3FjpNSfMkA9+T6Mb56UOj2NyTGcdPSvwFDd3QR4DkuHRvEqqWwxQvq6huf8lPspbouX6QD/gfSidJY4jkKLve0MXwdWL/tAzXLZcMIkfOjtLdbzOBBx4R2X1bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719654489; c=relaxed/simple;
	bh=68p6jS1SGRbOID2C8G6NZjxcNDQc0YTynw+zk8Mq+H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwRsB8n1tvk5m+fCMR1TJjD0nzpCzSxhyebS5igL21IZ+P2kZ2SRTehwY3wtQ9RDgEn3bFwEGs1j32Qr0Il8FHB2k7kGHRykMN/2Tp5fgXpIgU2KY5Q4vxhWCgHNZYp9zV19jNEkb64QmdWaa4cJb0y3VcWPkSwgd0TNS89Kn5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtdpMIBZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7067435d376so1006333b3a.0
        for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 02:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719654487; x=1720259287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxZ1bxAM6zLFt/zwCqSvd+e2s/weo89oqqXWBW/BCjk=;
        b=TtdpMIBZdKOmFeP8zQE2liMAV8GyUG8NbYkz4HGGOCeSdjQhvHQvW+O/lg9lnGKRZr
         4OoQBZw7kXnYAOPEiPM3QVvSFCGNludviYaHyDQGaWCUzKzNhaV0WeUyDX0L4UI3xkIM
         lAXW1NZc34Y0pK3XL21zOiqhifFh+5O8sQSzIpnvtlheJu/tCKiFgNOb8jpSLdPOwdvx
         FG3tznrKLIQf+ShaQn7g1pnt/RSZhZaJJ0KQp8haNni9MOgLpKE2Br6Ol28/QnCb68fU
         H/s3xLIgSYKHB4brlNWqJxtQLhlRi3Nk+/u7ot2G84aOsZ6sQgZIDobiGC2zTE3wiEeq
         k/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719654487; x=1720259287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxZ1bxAM6zLFt/zwCqSvd+e2s/weo89oqqXWBW/BCjk=;
        b=AKzgCngWDssMD5B3lJEfjrw3TrVZIrXPNbeVAR8JOa0cxeon/bBpMyUUt1yBm0H45b
         vvVJo8WuDIQ8X8O4x2ulohPB9OhDA5gGTlm/N1/2Ou7gicrXo9vM/rSUk4mhdv3eMmYZ
         sTXlXHrv8yKUypsumRjK/GTKsPvG5/o5s2CYKD5b+B5rO3T+EsUuQ6rUNYypTxwYlCXj
         J8/wVqvjcrqjOKk5KB2MVRAIetP3JqWnaz80t/3qovQ0kWzmxebcuJw3y5N17fzyvzXm
         x4dpJTIKtOKXRCm5BuhSmooVtP4A5aQgg4iUXOVn6b+TzwMPSE2Mcau9y8bR2OVr/ES1
         gXqQ==
X-Gm-Message-State: AOJu0Yx4itmCdgaxAPCIyfwTN7WPDaCOA/zvD+WkCMM9ABSZXM7k3Npk
	vigP+qnmpWSP2KKmWhDW+mcno0NEZLOOdvsCk2vVX0tnfc3rkb0Dcjp61A==
X-Google-Smtp-Source: AGHT+IFyRFLbVCo3VxCt/w1zexfL0Bx2HHOLqUN/7OHWcdgsH0sltla6Lbm61+VT075LEPXhWm+2TQ==
X-Received: by 2002:a05:6a00:98f:b0:706:3f17:ca2 with SMTP id d2e1a72fcca58-70aaa95bfd8mr1114743b3a.0.1719654486890;
        Sat, 29 Jun 2024 02:48:06 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804989f5asm2948932b3a.195.2024.06.29.02.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 02:48:06 -0700 (PDT)
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
Subject: [RFC bpf-next v1 1/8] bpf: add a get_helper_proto() utility function
Date: Sat, 29 Jun 2024 02:47:26 -0700
Message-ID: <20240629094733.3863850-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240629094733.3863850-1-eddyz87@gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the part of check_helper_call() as a utility function allowing
to query 'struct bpf_func_proto' for a specific helper function id.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d3927d819465..8dd3385cf925 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10261,6 +10261,24 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
 				 state->callback_subprogno == subprogno);
 }
 
+static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
+			    const struct bpf_func_proto **ptr)
+{
+	const struct bpf_func_proto *result = NULL;
+
+	if (func_id < 0 || func_id >= __BPF_FUNC_MAX_ID)
+		return -ERANGE;
+
+	if (env->ops->get_func_proto)
+		result = env->ops->get_func_proto(func_id, env->prog);
+
+	if (!result)
+		return -EINVAL;
+
+	*ptr = result;
+	return 0;
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -10277,17 +10295,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	/* find function prototype */
 	func_id = insn->imm;
-	if (func_id < 0 || func_id >= __BPF_FUNC_MAX_ID) {
-		verbose(env, "invalid func %s#%d\n", func_id_name(func_id),
-			func_id);
-		return -EINVAL;
-	}
-
-	if (env->ops->get_func_proto)
-		fn = env->ops->get_func_proto(func_id, env->prog);
-	if (!fn) {
-		verbose(env, "program of this type cannot use helper %s#%d\n",
-			func_id_name(func_id), func_id);
+	err = get_helper_proto(env, insn->imm, &fn);
+	if (err) {
+		if (err == -ERANGE)
+			verbose(env, "invalid func %s#%d\n", func_id_name(func_id),
+				func_id);
+		else
+			verbose(env, "program of this type cannot use helper %s#%d\n",
+				func_id_name(func_id), func_id);
 		return -EINVAL;
 	}
 
-- 
2.45.2


