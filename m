Return-Path: <bpf+bounces-45578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645749D8943
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 16:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2882A2899D4
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 15:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D83F1B394B;
	Mon, 25 Nov 2024 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYrPOkWn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713A8199FD0
	for <bpf@vger.kernel.org>; Mon, 25 Nov 2024 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548390; cv=none; b=d1P2C3qqsUDc8Fc6Dx24dYGbCuzKWqelVzrMlMIN0VM9kYmfLxKSKCg+q9/qLgykZ66cKysjv7xOoxDjg8c2EpyArlNy+zP+kisrQTI+Deafzc0ceZUPlqILCnxqDoP2j+a1gYTo2x7yPgyznczA5RyeAhpyK/a00FRY9Ag6+Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548390; c=relaxed/simple;
	bh=MBHVocct5wgUNQ2BMzMhaLL5JlFSiyh3R85XtRwhijY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fUDHJUvZrIA+gaWbeN4pKQuACQmy4Dj8CsRxeGLxzij22UKEUiYGwjKiVa2xRmIanb7GEcfvOOF49PIrnqSzMnO3qzpJj3kMYkBEruKNXuu8UrzhDgTySi3SE5uwTTxR6vGCoeazQpmUre7ggTqHBPpSv1rkT3aIxigxO/HvPIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYrPOkWn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-431616c23b5so25948205e9.0
        for <bpf@vger.kernel.org>; Mon, 25 Nov 2024 07:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732548385; x=1733153185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M/o/RQoKS+0BoeTliePLVahhp9WrQfWqa4ABMjvMABE=;
        b=EYrPOkWn8ZvmGaVKHMrh+fu29iXkAjZJr2jd0lJNhTIvJ9S1RcYLq2L2lIFIFPzrMf
         F0ruJ+coGNVQC3y8LnNbUOhQ9xh55mwzTVn3nmOuCqSDcfUlaM3cZJdpV7oTxFbeADAQ
         MhUquVVK1LXbR/hO8JQU801PkVOAR6hhmdyoOpAdftK7Kz5LAW3mVw6TJZVQAeY8ndtC
         HOgnwRdu3Bo3lilO4sY1cQfCh8aihkPDceZTQvhNAtuEiwf6Ti6k2LuBzj7GYIcy3eAl
         eThAJwNkSaVjyRtThPV12HBC/QAVBimoHHyxzv2OBSYXVSGLVO5DMqJ6O6PrCzM4KB5v
         YShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732548385; x=1733153185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/o/RQoKS+0BoeTliePLVahhp9WrQfWqa4ABMjvMABE=;
        b=gUDoUw7exwhA+blpid/u80o8xNu17sA1FRJM2pypH7ht52T7yJthLzmf+wFYmepvKR
         thD/o+xrD2b2Q/lH7ZdQzvbKssZAq7BrIYy4e69Owr60gvsfm14pKjp1PxOi6eR4hQ/x
         3wbBWT1T81FS6qVywiNfFfoU2BDMYBS265g0lcyyoFZXCK5mPATzNcjyMT3aJOHMGJaI
         XkIIf1DkCnGKzVCAnHHRS6X0UtBacXUuyhQzp5FR7V9z1Jib38TShbXS9MvglemDr8bF
         a+6CWVEI5fz92eSQAl8LExImqAo2gRoTLkAlrOcWOCOID6rsyaLzpuTetmxeGHfP61C8
         NxWQ==
X-Gm-Message-State: AOJu0Yxk9Cbj+Oewy0OP58cSaA9XUvJFN3ErbTsvQJbEUeUjHXqb96UE
	vOaTVLDzuI8L/yO17VBd4xcNuxCjUw+SXCGNZvvSny3VKi8xzS/EfBL3tUjM+qpEOEF5
X-Gm-Gg: ASbGnctAIo/47VxdT7s8+W2siPq+8OoMqflnk02Ybro+F4M7VVJPajJlADld0Di7wjb
	pLKe+h32lcMXq+foApxYhgNA232Qn2qolO2TOapzZVLAjT+u5dO/nj9PtPZjT6LpppgydM5b5BM
	jj1w+SimpRb+V1/dSufQeeKuXIEVeIfQQf9f2bFsJ0UgywlIjf5DhADsYfXUcsl/lhljERPM/Um
	T6N13VXqQHbCDsou8wRqwVwA4WDabc+OB4a9Mof5k39tY+Kd4zNEZ+be5TGEpoQaUZ63XduOLNE
	2v5wuCIVr/uRU76EWTKq5qYe7sUishOOSrHflwCcUILcnuhhle1LIMQMQMBPtA==
X-Google-Smtp-Source: AGHT+IHICkBuebT1gAPKJXjSybA50lO+QlBGSN7qkgphTYyllFnR0tWTKbWQ+HQkRwukrcklZ8sCsA==
X-Received: by 2002:a05:600c:1d19:b0:433:c463:62d7 with SMTP id 5b1f17b1804b1-433cda11064mr97749345e9.4.1732548385156;
        Mon, 25 Nov 2024 07:26:25 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal (36.24.240.35.bc.googleusercontent.com. [35.240.24.36])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-433b45d4dd6sm202793815e9.24.2024.11.25.07.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 07:26:24 -0800 (PST)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	song@kernel.org,
	ast@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: fix cgroup_skb prog test run direct packet access
Date: Mon, 25 Nov 2024 15:26:02 +0000
Message-Id: <20241125152603.375898-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed in the context of Tetragon to test cgroup_skb programs
using BPF_PROG_TEST_RUN with direct packet access.

Commit b39b5f411dcf ("bpf: add cg_skb_is_valid_access for
BPF_PROG_TYPE_CGROUP_SKB") added direct packet access for cgroup_skb
programs and following commit 2cb494a36c98 ("bpf: add tests for direct
packet access from CGROUP_SKB") added tests to the verifier to ensure
that access to skb fields was possible and also fixed
bpf_prog_test_run_skb. However, is_direct_pkt_access was never set to
true for this program type, so data pointers were not computed when
using prog_test_run, making data_end always equal to zero (data_meta is
not accessible for cgroup_skb).

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/bpf/test_run.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 501ec4249fed..5586c1392607 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1018,6 +1018,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	case BPF_PROG_TYPE_LWT_IN:
 	case BPF_PROG_TYPE_LWT_OUT:
 	case BPF_PROG_TYPE_LWT_XMIT:
+	case BPF_PROG_TYPE_CGROUP_SKB:
 		is_direct_pkt_access = true;
 		break;
 	default:
--
2.34.1


