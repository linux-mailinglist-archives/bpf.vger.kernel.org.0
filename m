Return-Path: <bpf+bounces-39907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6DB9791DD
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 17:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCC11C2165F
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 15:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D308E1D04B0;
	Sat, 14 Sep 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZs0V33Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0D21E487;
	Sat, 14 Sep 2024 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726328456; cv=none; b=rnAk11EM8Qe11jeGLI6YQr+WN9VKxTMX2KwtgmKlSOMK6ihibjdruIMyq9K+P3Uzbk/+ote6g7vcdNDk8cdnvSJdNsDIIbojh3rVqkYhU7lylkM2F+DZh5P9zJhqGmX35ViS/bqGOrBSTQPLz/MC6dXhmdyxsCAY+l8hQmOwtu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726328456; c=relaxed/simple;
	bh=hGrn4Ijr2Ad5CTcvel+OIItNtTnloC9BiAfdHwX3gm0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g6GIM1KgvudI2d1r/iXYLGj9SjXpjnAZyAo2lgCXepYyp70DUiINRAn8kTm3cVujklhsCG85y9dGyZm8aRvRVJmx2B4l4RAp28p2uKyTKnW7B8utLC3IgoOEshK78CvGm1tA1eSa8JgL3VZsk63hfTwpE95ufwfdiBugfB/L2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZs0V33Z; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so2567431a12.1;
        Sat, 14 Sep 2024 08:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726328454; x=1726933254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dNXiVc6HBB/MX7lj3NuFCRwP2pO9DqNplr5Vwya/2lI=;
        b=RZs0V33ZpGKyrV29EW60Tly3CaqDXJk8akrCg+4x/qdSuUujymSLO/hVvh+y3UqFuh
         g7PV1fAW331iaLDU+ZFoCoiYFWsAcy1iSxrDzl0xUxGF+04r6aA+QhCSv/ZLHVSv//4o
         DaeOj3BVAC4SGrUt1XUqJP/eRoJGo2e7S5W3kNohz7uvZ4nO72tEJd9JC/SEIdFm27U2
         jhzDn936ai6CcoLKf0Jp6sxE1i5g8x4/YrKajL3vNl5WtxpGb0vPfIhOaGakHRTs36Ie
         qYP2A5wPtC3YdLRfMHDyCrXb6WvBkOAWBjK1y/iW51B1Dyt9taxjWVZruFwNnuX1q5wS
         tN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726328454; x=1726933254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNXiVc6HBB/MX7lj3NuFCRwP2pO9DqNplr5Vwya/2lI=;
        b=WIHY1ZfJL3vxlrhnDsOwcrqEujn/4PYXY5OIMHgCTfS4uNlBLBn+urnahUjUPABheP
         RihwZwfp07TfH3O3fYvwh/hdnVRRcfoZFfmIGMq+R+InRg8+fVflWdO5HZrvC/Ew5pYx
         1C+0rgdmZ4muK2H59T0mpCnOylLPT/w25b4Tb/0Wvh0kY5vS+SaFik2tm3lnfcxsfBmw
         i85b94e+ZkfZm0cp+Zwx2Q+2zCm4umwSHUicqV4sjS3xb1hAyy9vk7ni7zvrgIKVn2iu
         EfyN1KHwoAeF8u7SBwDwoid9XBIQh4QDUPL08ymCBdQzUzoemEXYrKTLS6yKNbJ+XkXi
         Sgig==
X-Forwarded-Encrypted: i=1; AJvYcCUbkmeTN9R6AA3QaDN2bfVhgqOzE/GPxGTHNMaH1NhuhQS9ZZbYM8C7PCpVsh7Hany27z7TluToSFyvVOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUDCnwH98Noq8znyOwrsMiwkmffNEyQEYGpwmFRvYh8pZxzvWZ
	PfyKvD91BjgYZAa02dseUMrXiz6W0k9CHfWVyQCjh4r9oWvn+spj
X-Google-Smtp-Source: AGHT+IEKJVnvIE8PfL66jpv6OxO7nXIK2eQAPrsmGX4INkDJIxPzoqcMdyfG4+E22rvDgk7OW8nGLQ==
X-Received: by 2002:a17:902:fb0e:b0:206:a6fe:2343 with SMTP id d9443c01a7336-2074c5eec88mr166782385ad.8.1726328454010;
        Sat, 14 Sep 2024 08:40:54 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207a095944bsm1352995ad.238.2024.09.14.08.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 08:40:53 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@gmail.com>
Subject: [PATCH bpf-next v3] libbpf: Fix expected_attach_type set when kernel not support
Date: Sat, 14 Sep 2024 23:40:40 +0800
Message-Id: <20240914154040.276933-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit "5902da6d8a52" set expected_attach_type again with
field of bpf_program after libpf_prepare_prog_load, which makes
expected_attach_type = 0 no sense when kenrel not support the
attach_type feature, so fix it.

Fixes: 5902da6d8a52 ("libbpf: Add uprobe multi link support to bpf_program__attach_usdt")
Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Change list:
- v2 -> v3:
    - update BPF_TRACE_UPROBE_MULTI both in prog and opts suggedted by
      Andrri
- v1 -> v2:
    - restore the original initialization way suggested by Jiri

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 219facd0e66e..a78e24ff354b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7352,8 +7352,14 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 		opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
 
 	/* special check for usdt to use uprobe_multi link */
-	if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK))
+	if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK)) {
+		/* for BPF_TRACE_KPROBE_MULTI, user might want to query exected_attach_type
+		 * in prog, and expected_attach_type we set in kenrel is from opts, so we
+		 * update both.
+		 */
 		prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
+		opts->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
+	}
 
 	if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
 		int btf_obj_fd = 0, btf_type_id = 0, err;
@@ -7443,6 +7449,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	load_attr.attach_btf_id = prog->attach_btf_id;
 	load_attr.kern_version = kern_version;
 	load_attr.prog_ifindex = prog->prog_ifindex;
+	load_attr.expected_attach_type = prog->expected_attach_type;
 
 	/* specify func_info/line_info only if kernel supports them */
 	if (obj->btf && btf__fd(obj->btf) >= 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {
@@ -7474,9 +7481,6 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 		insns_cnt = prog->insns_cnt;
 	}
 
-	/* allow prog_prepare_load_fn to change expected_attach_type */
-	load_attr.expected_attach_type = prog->expected_attach_type;
-
 	if (obj->gen_loader) {
 		bpf_gen__prog_load(obj->gen_loader, prog->type, prog->name,
 				   license, insns, insns_cnt, &load_attr,
-- 
2.25.1


