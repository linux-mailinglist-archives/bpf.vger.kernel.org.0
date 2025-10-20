Return-Path: <bpf+bounces-71353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E783BEF672
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 08:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EDB94E5C2A
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 06:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49522D0C8B;
	Mon, 20 Oct 2025 06:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtGyDqzr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DB814F9FB
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 06:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760940462; cv=none; b=chZI+MYQ+EgmNn0hn6HQFhdpZWK3f/OPli45c9cp2zcKs/D9sU7fqcSO/qubH3xCy9GrBznD/jKNPLRw7kvdnZdMhxO5LCEl/zyGLhBBH9KvdPogl8KZlvPX1AiCE6M9Ox00WZKkbCrMfLaafDMkrFbXt7bLH9LEG4Wk5Y5y4Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760940462; c=relaxed/simple;
	bh=Jg9JuOzi7l4c7o0L+1aZUokrGEARgu4P12Lm/kcK87A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pU4I6MxEzaudnOM5MlnnjMbN7LXm+cJvK+8HhLGZR1apVm3OOFvgggFNzV7ASbsqwOEHBWGsFZ+Yx2BFLBQ2kGw2MPMTwhCru0v6pPdzNjgFHCvu+cSBLRKe9SRTHmW38w3ebkziSAYz+tNoua82+7BUDry8KtiAvepHacQ8hhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtGyDqzr; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a1603a098eso2438119b3a.1
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 23:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760940460; x=1761545260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0r/HebwMtSzOLnbyrpiSe4atgTE54p/WBgGmH8tLOF4=;
        b=YtGyDqzrFTeprgA7XAzbXQBE66KzB5FoacUxStvXmSCh078QhEObGzgKhtt8a5YyCX
         PeqNGaipyKQPPhaIh9CeXPFKy6tFDIOAw/pARBDriR5N+Ssqo3p+UM+Qw2ZHWUFMvLRo
         9/dlqYy0VoLfeYK/oQBl0wEc34bjXBnXTB2z4UqgJS9zlUOiWlgkrZR+nPJH4Jo5uLdK
         1oyYXhMpTarmocZR5ILmPS3UEn+kYzvNYuz7N9U2X51gYvAu/tFEVUoSU09Ivaagl91l
         OiMLMZo0qNpC058s0KrT+IBXgaDN0CgPtHEul4q6BPaRq9M6vHr3V73JM0oAG7I1mi0c
         mJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760940460; x=1761545260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0r/HebwMtSzOLnbyrpiSe4atgTE54p/WBgGmH8tLOF4=;
        b=gzrKe6c7jhKa1IuAKuyaptUVsAWaguUJRpAN5yvb6kfkL1Lm+3gqAsGIg/0yiO0hxj
         bc85O4p/PRkC354ci/MeKPnmb3fdEi+FBKnyu3pnalcTVnU8gUlenjWBtebNkzlgCp/R
         lC8X6da8qyuWUgCaopEw33/waW3MjOZb+13otA/ox5giHbReb0P8h+q6gPa6yprdVn6W
         LOTLjHOXSAV5Qoj6FjTpdp3WFTPP3fQfDsTDzM5piGxLpBtz7ZpoWlIKe25M0YnR0Jce
         wLlmFRDtPfrRNY/2EzB5C3er3zC+lzADwzln514rfyzqgk8E6fzmQ1q4/s6fuKXScxxj
         U9kQ==
X-Gm-Message-State: AOJu0YzqGZBfF1Nin5EfKl9jIjjlWVBtYufkqxTB/x4SNCg65n2/lfeR
	xKj/uI85KEpoenZCTFRWlT1WiaghBoGeOxtr+OcsMjkKSmOEtKRb2jFUnpg2IMad
X-Gm-Gg: ASbGncuUykf07NXCpYeZHJ61goEyZ2taA4/iSo0ALwJFNYx1dlQmwS/Zou7GzCkBRk8
	cmYAFQ619iaF9sZvHlehejmGrL5D36HkteJ6y1gzmJWU0Booj9BrE2X6JtlzLHi2z2LaUqBuZ+u
	9v9WISIgRAxuqqrf2ytX3lvWPQo0m8a9gyTdi5CJFA2QIDnt+3cihaqhT1fS6BUEPr3h0zeLdpB
	zu6Kp6Ypa50bzsbOra1FYIOmPJpBiaUvA4Kgsl8YHAtVCPzQu1retNxOs7M46QnLi2fs/McOL1b
	Qy+NXfq0Av0f0/usGBiY3LM3wOshSWT10X+04mlfY0hTjtfGpI9qfsEgI2AAaOHh0LoNQiFkX/I
	R94LuyKiy6ZD0a5wr99NfZy4cl1U+SSn0Ik1rSZPCpCFMJLWyh2+jpLTItLmwlC5zh0sSBhHfiv
	pOSasli2pHCg==
X-Google-Smtp-Source: AGHT+IGebHdtAZJ4COLbK3nLBDOFrm3PYuIKKbiQyQpLZnXvgZWtImIB+QRWMbe0w6Q33XK37pJWGg==
X-Received: by 2002:a05:6a20:939d:b0:2fb:62bb:e0e with SMTP id adf61e73a8af0-334a8610fe8mr14568294637.32.1760940460039;
        Sun, 19 Oct 2025 23:07:40 -0700 (PDT)
Received: from Shardul.. ([223.185.41.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f159csm7237105b3a.46.2025.10.19.23.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 23:07:39 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
To: bpf@vger.kernel.org
Cc: shardulsb08@gmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 bpf] bpf: liveness: Handle ERR_PTR from get_outer_instance() in propagate_to_outer_instance()
Date: Mon, 20 Oct 2025 11:37:10 +0530
Message-Id: <20251020060712.4155702-1-shardulsb08@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

propagate_to_outer_instance() calls get_outer_instance() and then uses the
returned pointer to reset/commit stack write marks. When get_outer_instance()
fails (e.g., __lookup_instance() returns -ENOMEM), it may return an ERR_PTR.
Without a check, the code dereferences this error pointer.

Protect the call with IS_ERR() and propagate the error.

Reported-by: kernel-patches-review-bot (https://github.com/kernel-patches/bpf/pull/10006#issuecomment-3409419240)
Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
v2: Drop Fixes tag per Eduard’s review (not a functional bug).
---
 kernel/bpf/liveness.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 3c611aba7f52..ae31f9ee4994 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -522,6 +522,8 @@ static int propagate_to_outer_instance(struct bpf_verifier_env *env,
 
 	this_subprog_start = callchain_subprog_start(callchain);
 	outer_instance = get_outer_instance(env, instance);
+	if (IS_ERR(outer_instance))
+		return PTR_ERR(outer_instance);
 	callsite = callchain->callsites[callchain->curframe - 1];
 
 	reset_stack_write_marks(env, outer_instance, callsite);
-- 
2.34.1


