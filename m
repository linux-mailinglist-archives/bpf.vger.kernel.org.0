Return-Path: <bpf+bounces-68254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AE0B556D9
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 21:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5003AFC7F
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 19:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA6D2882BC;
	Fri, 12 Sep 2025 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AC0BcyMj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FB2CA6F
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 19:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757704709; cv=none; b=Zo3Uh0Gylg2R9DQ/0InHooMFpTAkSE2k8EtgFL9i5hD2/vQYlgbjKPsUH15FLfsdaPKFaCgC4varm1Io9uetmgmebLMtYJyCItA45ubmgFbM92ZHyqxzryG8dzDgUqTPT6+rXHmofl24m4bwM+QufVs2MTQdiZuyh5PA/ONZHa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757704709; c=relaxed/simple;
	bh=kPgvWjeS+/PGpME6U98ELZJhwDTHXRyEO8St914MY08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uE2vZ+IlrZwQHTBt5ImaD6MrGIYTgzXcAaBX1wTxJC/yIjB8FZ7ji/zk/e551pzbB4eZv4OvduWu02ZyKi6tuK0a8Xa1RzsS1ExNWqXboOmzkS6o5kaTieBhgZ672UNBS7HRaKShg9iIDW36Gb8gReLn6J5O9VTDEgr+5rPO+wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AC0BcyMj; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77616dce48cso737952b3a.0
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757704707; x=1758309507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cUVNsOJ4whxInU6KU3aQgqVcW9IsCSxJw6qewOGufwc=;
        b=AC0BcyMjpFVN2iR9bDD1idcbKKtQdI6Us3A/1LsGdzLNB+1VXJwTRhcxsRImmpwVhx
         0so4MQjZxpawt70hLyRGBMteXxUlBRoJlm8QW0uS3fCQ3N0522kvDvLQP+8jfEBrsOrd
         Q3UJB3MJHDPZqrM8RLRq2jtYKKKMqvr+f2Y1CTo9jh2EXCv6G2xMM0TodsTDF3fLZk2Q
         Vd1GR6PcrqvoDlcDQN/VjAlHn2xzjk/QesBBt5RbauwQYfjAaQNrg9hjH9D6Fabrl/HA
         Fm2HhjQ74BUdEMwvmq4PLX0sWEnADtf14ivZ9laoV+jUcOYgjfJxgp47I+nWGMLp1GQt
         hitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757704707; x=1758309507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUVNsOJ4whxInU6KU3aQgqVcW9IsCSxJw6qewOGufwc=;
        b=TvvzFAkH0tC8+0ea3aDpFgV1CKapgcnBoc/IiP7YYAaE9RByBRYUf4boyeb4lVzhkC
         sdVr1m5uXWcd/pasmJQCPTQ4qH0oemMwZ1HBD4fPo9sqx+W6tCCmyR6gvp0Q7BI6R+TK
         Ym0c83CrxzP2NaCYIqQxg2X0e0B7v29A2Fmj7E2YwT78WAKJV2Be63nsCqXjBp+l1GTH
         4+oezzDUYl9XHLeIqGPXSPZOplev+rcX0m4C9MmziZV9faXmFegf2JrJBg22EDHfDs9I
         +zTOP3QwUt5dQVon/AhAxTKU4hFT+EsCG/1jY97VBWBzebb1vPJlT39phS1vVBzw9olR
         45kA==
X-Gm-Message-State: AOJu0Yx6rzX9RnppWWrM7971TGURK8jrzTSevl/dy6FgLmuYlMLoMFhF
	h+QgRqm3o2q8Rdy38Y72ac9uFoUWxUw2IDo2Y1dGNdIr8pU7RZQH9WfGgaBoo1we
X-Gm-Gg: ASbGncv1Oy7J1DJrfcXHt7eQcXD0VXoR9LcTER+AWqSCu+TvHdjD1hQmbGaS8+Y6S++
	wr5rkZLu8mbUxs2YB5ePICdVM4hGO4hZtZhrVHfn/Og5L4Vr81bOVrsXBG6JddlQdHWGH3VUofv
	0Qrj929j5kfkTFfcbZqByeMVX4p3Zwsnaxu9aF0Cd7QBvD3fI4y+2gDv8WEWKfrNuimcO7809bD
	VVi11aMCIvpoImFJgMluMiyQ7PYylJ4A/+WRZBbUhz7gwbD1eXpRwvlm0l9ddZc+M2pye86vlab
	+tXycXfe22l3vGC8OavFC5PnhRRPVBSzFpLDC80gDvaLWVNsSeZMM6/bYdKx/1EtN/wuvp4H/H/
	6eGft6pJzCX9I1+aRhWxBjbtxLUWdNkaWhSJqTkHguuUgQ6nX/7fAE4hp8g==
X-Google-Smtp-Source: AGHT+IHVA5yxZYOvX+mqWXetuTqCQltm64GwyrqUVSz4HZJd+7RgXqufZ5DDJOlxzt03zEaDxlhPbg==
X-Received: by 2002:a05:6a20:1586:b0:24c:af7e:e55 with SMTP id adf61e73a8af0-2602a593825mr4626941637.10.1757704706509;
        Fri, 12 Sep 2025 12:18:26 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::4:ca20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77619453fe8sm2319185b3a.75.2025.09.12.12.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:18:26 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	Chris Mason <clm@meta.com>
Subject: [PATCH bpf] bpf: potential double-free of env->insn_aux_data
Date: Fri, 12 Sep 2025 12:18:16 -0700
Message-ID: <20250912-patch-insn-data-double-free-v1-1-af05bd85a21a@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250912-patch-insn-data-double-free-f7be62b9c4a9
Content-Transfer-Encoding: 8bit

Function bpf_patch_insn_data() has the following structure:

  static struct bpf_prog *bpf_patch_insn_data(... env ...)
  {
        struct bpf_prog *new_prog;
        struct bpf_insn_aux_data *new_data = NULL;

        if (len > 1) {
                new_data = vrealloc(...);  // <--------- (1)
                if (!new_data)
                        return NULL;

                env->insn_aux_data = new_data;  // <---- (2)
        }

        new_prog = bpf_patch_insn_single(env->prog, off, patch, len);
        if (IS_ERR(new_prog)) {
                ...
                vfree(new_data);   // <----------------- (3)
                return NULL;
        }
        ... happy path ...
  }

In case if bpf_patch_insn_single() returns an error the `new_data`
allocated at (1) will be freed at (3). However, at (2) this pointer
is stored in `env->insn_aux_data`. Which is freed unconditionally
by verifier.c:bpf_check() on both happy and error paths.
Thus, leading to double-free.

Fix this by removing vfree() call at (3), ownership over `new_data` is
already passed to `env->insn_aux_data` at this point.

Fixes: 77620d126739 ("bpf: use realloc in bpf_patch_insn_data")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9fb1f957a09374e4d148402572b872bec930f34c..92eb0f4e87a4ec3a7e303c6949cb415e3fd0b4ac 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20781,7 +20781,6 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 			verbose(env,
 				"insn %d cannot be patched due to 16-bit range\n",
 				env->insn_aux_data[off].orig_idx);
-		vfree(new_data);
 		return NULL;
 	}
 	adjust_insn_aux_data(env, new_data, new_prog, off, len);

---
base-commit: 22f20375f5b71f30c0d6896583b93b6e4bba7279
change-id: 20250912-patch-insn-data-double-free-f7be62b9c4a9

