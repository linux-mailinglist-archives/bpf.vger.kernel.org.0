Return-Path: <bpf+bounces-65368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B410B213A2
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 19:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737293E4B57
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2F02D47EF;
	Mon, 11 Aug 2025 17:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMSj+sZ8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829E44414
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934650; cv=none; b=XA4GhTZRUkvzgtN7YZ66sXtKwXXKhZo+xV9+MkRqGxQ8y/h2Ww2uhf/XC9+5bcudv1ryicDI4tyfMuc5IvOiiDEuOY23ZnPH8RjKE/UEs2kXEEVqqE15RnKo8rZ7euL8jPxQkwua44HhFlO3E9IvE+BsYqdi5OL7GKuf6IP0olI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934650; c=relaxed/simple;
	bh=EZq7lWrygOhlm2f+TPuXNAMJAlhS2MDJ+aHGni2Jgd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NyIX13UxIR4khsXVkTZJlgXiuzf8OxM46KptlyKO1La4drFYIydReZtkrfBENL3k+kFL2DESB9Tu0MApCoXg61cEKo/i9LJr0Y9SZOLbRnU5tkQekUxQ1y9u1hu9HBZssgWpr4ltoTnlFM8ZH8ljOHIr+J8iJrRcNcp8YpJIkVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMSj+sZ8; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-af93150f7c2so709731966b.3
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 10:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754934646; x=1755539446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=52MQYDD4l6bv1T5mHrKA87gxIZoxp22FfKGw/21gYWU=;
        b=nMSj+sZ8LK6aGTenb1EMqkmfDcaLyY9ppoOif+iUflV9wWI0gGHbu+j7aQVnr5jj/r
         NilqDy8s433qXJAGLPPD4NOAc5zNtiyzuSa/HdT4AqFrlq2IymTuJLgQJFQ1UGFmQqPU
         Lf7xAaMNqraZLlHcECht+I712xmnsovdhlgdGdovdTgqsmyeaGr9hlx4lbeJ7hJTrvGU
         vdP3p10t56t21+fs8m10Z3wnKM2lcYK/17DPn+g0Ep1zTzDc5OZBvfnIQL9DAgO4zcJ3
         xTTn52Pb17IGLa3Of6sO51c00uk3tmNsvgxuJNuXKbq8bn8fEUbEmOfqJitOb2XIpxb8
         hCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754934646; x=1755539446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52MQYDD4l6bv1T5mHrKA87gxIZoxp22FfKGw/21gYWU=;
        b=lJat+qNOzTo+eEDjN9twb26L0i8lIjaitJVaNXmULllxXfNKZ1fWNZIWjk+tcfqQJO
         X0zomfDHTqL9FjaP78DyFGxF5i6KqNKDUqSE9C9HTu8lAurVwP9PauhSbpdbmsAxrxFs
         /h0u58KWtb1Hw1RX5MRqHwCEjN6grHGXaQTwZAG0tu3TFlpoLMrbAthjgCENSFYAwc4n
         p0iUsIbfhxBvI/sqEUKaBGyCATc7leVnuLj0YSOIJ4LB3V9fK+CqG1u4iwJByw29GuOS
         WVcWOSkWrkuXVMb2IZGKxkYfHH4XENt/YJU5et6eN9G7NM+bi4xVS7B+GzmRpzW/3dia
         ZNbQ==
X-Gm-Message-State: AOJu0YxM439wyfLFemFgQPBJCZYTyttpXWGhqmszcivVKzQlGWQfGgCk
	gLBvdOUHw87bZjofzNIwk8EzZ63/Cqhaa+sMoaYM5n16fJmpe+Bfs3bQKvC8eix6
X-Gm-Gg: ASbGncuO9ZPwO5/oJTmCv9pyiqsxS2NZMvzVoN51ePQQ4jsjVxOu6viHn/rbQM+EQxe
	Tkp3I3fK6i0uLNztC/w/fCJaFUC6+sWCf/9UBPox1FfZ7P204dPM4Satk8AD8XaCTCZd373UgFX
	2JadzyYOTV+XSM9o9paSsBeDnHSeejgvP9z3E+LeBAjm/mD13ZAm5+zi2LBVbzC4Sxtjppbl7rv
	IU9f3yh+n+5kCR89Zi/n9geFcwcG+4U0JiafJdo+1VqwKtMM8kS+2T0lq5LVZos7FJ6XU8DSbct
	4BDag1heZ4mP46RYIC4iRPfUKomDNyx6Smhe3/UHdQJFhCOEE6cnfWVW4sSBJ0fFAw6V1om53VJ
	FzCtyFeVY+k0=
X-Google-Smtp-Source: AGHT+IGutcfpe9iWh/ZBr4mGYLIx9E8hs+XWgyKYFNukib+PnKbb8djc673jracC3yEgf4O3IaBuUw==
X-Received: by 2002:a17:907:9625:b0:ad5:d597:561e with SMTP id a640c23a62f3a-afa1e22776emr29025666b.56.1754934646352;
        Mon, 11 Aug 2025 10:50:46 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e8359sm2047249166b.89.2025.08.11.10.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 10:50:45 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	tj@kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/2] Remove use of current->cgns bpf_cgroup_from_id
Date: Mon, 11 Aug 2025 10:50:43 -0700
Message-ID: <20250811175045.1055202-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083; h=from:subject; bh=EZq7lWrygOhlm2f+TPuXNAMJAlhS2MDJ+aHGni2Jgd0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBomizLkZz7HfFrcZy/5CVhIzmUqbF3f9qF+j2vptqz L+PXCoeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaJosywAKCRBM4MiGSL8RyqrvD/ 96bw8KTuZh4jgU9b+wpHb0AaYuprUCiKf+iftEHOJUaqrzvU0qbf/D9MBEnasnuFa+frFrWr/sLqmE moypbXqmzBd3cS/YUcQ1AUV0wkO3A1yxR+jzlJ2j/fabIj2wO1dgB6GQAoqAz+Ijra3KRT/R8FVbf1 /aEdqYjXkpWS2HJ758g2ZO5aeOFtRkU01JFr7G/0/nAaE22K6EwAyEphFE4ozMCm00afAVziuqGdwa aj28pzjh9XQ5msnWtk3DrJnoghhKj8j8F5K6ZBw3brTjwRjZdyLWzYtv+etUg1fbxSAEGZJPyn9aBF Ab5coamj0dikktdlJOLTph/dPr9TFDTIp4m0WWdj//Apf01mFuRQSC3kqoGpa70vTijmApGDllD04W T6MnjfuFyK+14FUqQBM9WXnPhDp1hfZ6HAo+SgCbeRV3QMZDu8xtdujADfbpFTCqYat66ecTCIcOfF 7Z/V6RRKmY/T7uY1V3syh0Z2wZeHLbokzlPvixFhAXWos9IeYJIkxaGq/QKbTfPGpkd0VgEpmaXOpJ 6uyhr6Mx6ncIEe76SlgPjrE379iCfxs3m+kYtKXhwEYC0k2dyZcxWZBFengzp94/cQO6Bza3e95rqn tG98gXN5VuFmI008mEpKv8RRrSYiMqNPFjf2yLMKnUwcYLi4Rq69+C8KBV6w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

bpf_cgroup_from_id currently ends up doing a check on whether the cgroup
being looked up is a descendant of the root cgroup of the current task's
cgroup namespace. This leads to unreliable results since this kfunc can
be invoked from any arbitrary context, for any arbitrary value of
current. Fix this by removing namespace-awarness in the kfunc, and
include a test that detects such a case and fails without the fix.

Kumar Kartikeya Dwivedi (2):
  bpf: Do not limit bpf_cgroup_from_id to current's namespace
  selftests/bpf: Add a test for bpf_cgroup_from_id lookup in non-root
    cgns

 include/linux/cgroup.h                        |  2 +-
 kernel/bpf/cgroup_iter.c                      |  2 +-
 kernel/bpf/helpers.c                          |  2 +-
 kernel/cgroup/cgroup.c                        |  7 ++-
 .../selftests/bpf/prog_tests/cgrp_kfunc.c     | 48 +++++++++++++++++++
 .../selftests/bpf/progs/cgrp_kfunc_success.c  | 12 +++++
 6 files changed, 69 insertions(+), 4 deletions(-)


base-commit: fa479132845e94b60068fad01c2a9979b3efe2dc
-- 
2.47.3


