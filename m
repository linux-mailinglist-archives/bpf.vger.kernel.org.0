Return-Path: <bpf+bounces-68366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54359B56ED2
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 05:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6003518988A7
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 03:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D9824BBEB;
	Mon, 15 Sep 2025 03:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAMohZKE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE95EEAB
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 03:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757906783; cv=none; b=ER24J2NshCMmEnEub4y/EglSX2M07PRk6pdzai6EAva4lrzb64o5VgBHxK1Q2oBjh76S/8y754NQzjVJJ0tkMD6VASR4AwQv6SBx6WuBN571iHnmS6SUCB0MWxKWkUoJPSNHnNAXSt39ygtWDq34PRuEmsVxBnacaFBE9GZOwTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757906783; c=relaxed/simple;
	bh=u/YIbd80uLW5XyQZtjrwKNBqjA3vzh4tYR3Gn9TrdH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dhMnbV+giQAGZtHOiGf+2OvEXu3Nc/oshzxDv1az9hOtLD0TRbbn/PG51k/TlqjPDrgiv/dj9rHBjEnIuPhrOGOyRfwtI5ME+uTLqfgIel523N35rM5foruWijvuf95lPadmUwWLUeOmdcN8DeQsWhox/d4eYztOzjwDVQr/g2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAMohZKE; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-45f29e5e89bso12517195e9.2
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 20:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757906780; x=1758511580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z5xOqlRCWsFBhd/G68jnhHvcjpJyxVIGD/fYdDwO4A=;
        b=fAMohZKEvLZID9PzImcp3WSjyU6aoo6HYsKkzG9U6oBT9WNhPFHG+vWW1ea+XDNcU/
         fI7HeAL2MjKIjUDpadz+mRDnsvx7ZD9FTMscesUgDXxCqPvvibIAPOuJLT6U9AG+rx0z
         invViLrSTaBe7hlXCB4R4MmXRWz9cds19oDsBxXuBi1AgZ3WGxAxuaevt4EKj1kTrIB3
         hMsfjd5PhtBaeuCuqfqQ5nk2wn8q3Z1YCEZ8Uh/A4RzFJLRrNtvx73doW2ZrKo7CkvuA
         VEugvlS0DUQ0G0p6ng6VkFr/Ye7bXi4bztIsR6Z9pacnAI4/UrMXS6PkSN3QGxoCHeqw
         +q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757906780; x=1758511580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Z5xOqlRCWsFBhd/G68jnhHvcjpJyxVIGD/fYdDwO4A=;
        b=lQIA8YjYvW+wnm48XVqWKYqLwxNqmRKifw3yLVNf3iPSRi42p8cWyRE9PsHaCdOZRV
         PcLc4oLICjzCDtRGLx1V15KIZuWQY0TYTHL9aYDloooIr2XFqJpPllb4CVKl+zLGhM+a
         FR8Qe9UITnUOQjfnJDicpl9AKon3/8RLMxkm4NxaBMS2BQp8cqowqWhoBl+WnfxY09PO
         h/hEd+6kn8z+9HQQO2TPimAa2LPo6Gmep66G0yQS4R4VowJFLASBt/9e+FIZ1QKsGnOI
         nJj6QztiiSbsS3u9C9llAyalOeNAMvtRpIjlekP86zhhdQpATvDbrt7CQZh73Od8YO6R
         o/wQ==
X-Gm-Message-State: AOJu0YwB2c9pbrt94M1lkG43rdJwNRCBlT9Yx9iYESufN8MSe7TzTA0A
	yiZKkptJg3TAmNZ2Kxa65iJOffHnhbWPBwKim5KoEeXzdwe+8FewUBcyGkU/ZgPw
X-Gm-Gg: ASbGncubYjw50EyFfe8NnJv2X3mmA7omqZL5Pt2ZvIT7p9Cqe62lwze8fnAnn4S+/7v
	IPyBdZGoPS7LDQjYW81mEZGsxhr7kaE1uirhqh+xQkd1vL7bP7ZQ4ypBCrOaIVKDnWPY9D8AS5h
	4hxDU2JkfE+a2SxLjG7Y+/jxtX+aKA7MLMkpio4Of4jqiU+1ET58a5uCl0/msnvAUDaf21aA68T
	nfOiT4Tsj4PTUHssmKGNPOglrZgqn59tjdQFSScfQbmafpA6OoOsSi4PFYGKwh5nLcTaUS3TMJD
	/koOfEOZMSOPCnkvR3QJnjryzZ22SLpPlZhpbw6RDwXKKNQ3snvCnEYFTAVtIRoFD2ZgsZ9EaLU
	eoRbJTqXmw4yT8tzm3f0yzhIFJFWP+t4rEV4fepO2Jq1M
X-Google-Smtp-Source: AGHT+IEaXLHACrAUvdQOszXeLrBGYZmNY/37ImzoEBDmc8jNLWzXemRVvVeMEYvC8J8mRpl6hlnt8w==
X-Received: by 2002:a7b:cd97:0:b0:45d:f7dc:f71 with SMTP id 5b1f17b1804b1-45f211efc4dmr74606965e9.25.1757906779828;
        Sun, 14 Sep 2025 20:26:19 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45e04cf2870sm84536205e9.1.2025.09.14.20.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 20:26:19 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 0/2] Remove use of current->cgns in bpf_cgroup_from_id
Date: Mon, 15 Sep 2025 03:26:16 +0000
Message-ID: <20250915032618.1551762-1-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1591; i=memxor@gmail.com; h=from:subject; bh=u/YIbd80uLW5XyQZtjrwKNBqjA3vzh4tYR3Gn9TrdH0=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBox4bp/82jDKbxJaoQk9KJ5LmWU0MtUITbLKBHS 7WPKnib3oaJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaMeG6QAKCRBM4MiGSL8R yndPD/9yHw+KQnSPcine4obcKdE2zciP0SjyH6LIzWurgt+KqDCtE9yb+bN3TheOtvQhdGLRwd8 nmd4QlUtYzc3AJzSt9c3WR3T37lS3BNE2Hx8bTdtj1Tqz4VDwkmkri96YOUXDZmRDdzsADsjBPd +YWkwq2gFukV9zaNc58jGUb93YvyQO9/wDApp6R0m0nab97P7NSLukVXDyuw++syGopNveuILwY 6a/IQZ00+eQx3rGa8cqIHgubJdvdtkk4yL/FC3kuLJtVMHNoaiYrsqSzVbwkFhnCRzLHcXU0B1d 0YC4aoQf1LuU5eQaL/tf8Mxa6sMKjUkWw8qIpd2N/F6lusB4C4K+bXPxbw76LPF3EXQcvgCaFFA tEEdqPMwpFyryzL8q8yVFbcmpUfQymeEJxhukCacQkMuGGLmFclpsMKXCuX2jnOqJSTh81PfMSk cUu+ADph9ghEhZr3HSza4Dw3E5vWYBzigCNiTSB94rp6xpIHawD5xplslXlAFpvDsoaZiLJuRx/ dUFASDsudZXRsgY3YthK8wm6lB1A1QyG5NKdZgR9s5MXKpoGfUwy12aREi2Ttz43f4DyrWNwd8H qfMgezmugj1BRdyUayo0zrtz3U07nrwp3idcbleJ2q6eyhp+e+mqHi3u82enAXmD1SgDBimJNjC UOb7x+n6oTJzV0g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

bpf_cgroup_from_id currently ends up doing a check on whether the cgroup
being looked up is a descendant of the root cgroup of the current task's
cgroup namespace. This leads to unreliable results since this kfunc can
be invoked from any arbitrary context, for any arbitrary value of
current. Fix this by removing namespace-awarness in the kfunc, and
include a test that detects such a case and fails without the fix.

Changelog:
----------
v2 -> v3
v2: https://lore.kernel.org/bpf/20250811195901.1651800-1-memxor@gmail.com

 * Refactor cgroup_get_from_id into non-ns version. (Andrii)
 * Address nits from Eduard.

v1 -> v2
v1: https://lore.kernel.org/bpf/20250811175045.1055202-1-memxor@gmail.com

 * Add Ack from Tejun.
 * Fix selftest to perform namespace migration and cgroup setup in a
   child process to avoid changing test_progs namespace.

Kumar Kartikeya Dwivedi (2):
  bpf: Do not limit bpf_cgroup_from_id to current's namespace
  selftests/bpf: Add a test for bpf_cgroup_from_id lookup in non-root
    cgns

 include/linux/cgroup.h                        |  1 +
 kernel/bpf/helpers.c                          |  2 +-
 kernel/cgroup/cgroup.c                        | 24 +++++--
 tools/testing/selftests/bpf/cgroup_helpers.c  | 20 ++++++
 tools/testing/selftests/bpf/cgroup_helpers.h  |  1 +
 .../selftests/bpf/prog_tests/cgrp_kfunc.c     | 71 +++++++++++++++++++
 .../selftests/bpf/progs/cgrp_kfunc_success.c  | 12 ++++
 7 files changed, 126 insertions(+), 5 deletions(-)


base-commit: a578b54a8ad282dd739e4d1f4e8352fc8ac1c4a0
-- 
2.51.0


