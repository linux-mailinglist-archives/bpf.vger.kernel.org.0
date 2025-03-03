Return-Path: <bpf+bounces-53061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 293DDA4C294
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 14:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46B367A75EE
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 13:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD23212FAB;
	Mon,  3 Mar 2025 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEGw2Bvp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F47B211479
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010280; cv=none; b=tMmNqvS94dvHtZr2MV7bze9MGq5w31oagrqkSFGxv+3gijyFU34h6lQ1JneRJnD3LQo80r8xTVeT64g1z67eKaYOyk8tSsUYIK54jWsP9XJrnkAG4h9VJcw2JR93Guyv7w2vP12gt23xRVkQPN6ggc+3CLkEnc2mUmHtg4rVuBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010280; c=relaxed/simple;
	bh=iNZjbbY5WqoDM0UnocvRYq2B5rApJe7KMoiB2LyXZgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WnMJtFSvpIw7TBiiuP9TCcdTtOaHOsCQaP+6aQ59du+yagQPUUuzV4ifuXXRSCt9GuYxdqtXLsaW6fCaHcEhkO2cXX+Q+wnTIpxds1a9QSG0mvWS6vXa0xFSG6FiZOj58NjbBC6S7PAG/hRCXnkNs8ebVNbGZ2PNsX2lRg00/UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEGw2Bvp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab771575040so988548766b.1
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 05:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741010277; x=1741615077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HkHKs1Cp2mNFjO4aavN7jPJ8WhoT9cnMli3zWPmr3/I=;
        b=KEGw2Bvp/d/AbM4MKDbOw6UWOBtGRbXEQLmE4RKnPj3Uz5i/fQroUQtMVYX7rfL4Ed
         WkFn/gM/nJ6p8Cw1x4ddkOfCNZu/hLwRckfAi3NYayCoW3NBftfIeI013AdHm6RQ3vKS
         j32gQ1WHC6qnezicgFNGbZ7euxTE0vSVhsW3rJrgvl70vFptTdaSuhbioOxYF/W41iVt
         FUibSfY2P4j9LgrCcTvezaWtqUXUjTsEcu9SSkfdK6Ott5DTMc4kIek3/LlpiUx8S6Ea
         WZWIkY5Gpk22Na7+tWBzp0mmnfBBF78jxzxn+rpHir8z1ssgw+oLNKKJ8sAmmz2JQDKz
         hN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010277; x=1741615077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HkHKs1Cp2mNFjO4aavN7jPJ8WhoT9cnMli3zWPmr3/I=;
        b=TCs24SOJ6zwtLBrHmhU90q7GJ0YOeDJI+mURtkt6zKSf+ikv3zwG/VR25qso/QIpTz
         +TSb7bARXsQVUirGK+vXH+3QVWXfzGFe2wqD/ToiZqs/5PMSuYIxs9ByFoSgSHcsJXda
         sQuNOQPS94QvT/bo+hTgVbX89zB4/vLqpVCQgifOrgtmzUA7GL/bVsw37silWMEOFAeO
         xG9HZYfJ0RPjfrvfCO7tU9g+GQZRHLm7J3/Wt0Nw7ld95BhUbrjxwOYCKK+v77oQY5IV
         3ef2dmGkR0aDl+MSVkLeBQRBHlTSCd7vMatVS/8DjCgoebAXpDBN17aMqIOYroUfIAq4
         jUKg==
X-Gm-Message-State: AOJu0Yw9bpcliSp20O4sFXMDXnR/fiqBGH4HsBaK80xCZGAz5K2g9I1Q
	/UqHscjggUX5CAcRXLIIjCUtagCbsO5Zmqa4HVVQjHTowc+OU5EfZjVZDQ==
X-Gm-Gg: ASbGncs+8pC634qYW87ub/YFqCmtk/ifDrpH7sBqiAyb4tF/b5kpzeyOMir93hewhGg
	HIYtVaJqc9ESa8Ly6VRj75dEryJi6mB8PC05bHmOY3+0YD5ty2h+JT40Qa7T7RFc2Mljdan3Etq
	w+QSUL7WaFng3sndxA4cmOKqgqI2upPx2Km2T2mqb3RLTYerkyqlPQO2G9l7D3XrivyFZivW/vK
	50LIaATaG/7txKjKTmOQmC8EjUmSRxeD2sdx36p3xvnX8nhljR5SphdzJguCWaYhJj/Pb07fNRe
	6NktsEUoF+Kj68Ax5U+XPCH/yBXHQ3AzaGiiLLW4IUN++GiUiG/KuTZCPxo=
X-Google-Smtp-Source: AGHT+IEHr8Rl5IBwW9/b/eXPrvSv816iy+5+cJaucDW+4cxxDJn4DOTx9fSyrkkMJO1t0iRkHIyP5Q==
X-Received: by 2002:a17:907:7f89:b0:abf:7776:7e17 with SMTP id a640c23a62f3a-abf7776893bmr366127966b.19.1741010276483;
        Mon, 03 Mar 2025 05:57:56 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::6:7e2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c75bfd7sm817975366b.148.2025.03.03.05.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:57:56 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 0/4] Introduce bpf_object__prepare
Date: Mon,  3 Mar 2025 13:57:48 +0000
Message-ID: <20250303135752.158343-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

We are introducing a new function in the libbpf API, bpf_object__prepare,
which provides more granular control over the process of loading a
bpf_object. bpf_object__prepare performs ELF processing, relocations,
prepares final state of BPF program instructions (accessible with
bpf_program__insns()), creates and potentially pins maps, and stops short
of loading BPF programs.

There are couple of anticipated usecases for this API:
* Use BPF token for freplace programs that might need to lookup BTF of
other programs (BPF token creation can't be moved to open step, as open
step is "no privilege assumption" step so that tools like bpftool can
generate skeleton, discover the structure of BPF object, etc).
* Stopping at prepare gives users finalized BPF program
instructions (with subprogs appended, everything relocated and
finalized, etc). And that property can be taken advantage of by
veristat (and similar tools) that might want to process one program at
a time, but would like to avoid relatively slow ELF parsing and
processing; and even BPF selftests itself (RUN_TESTS part of it at
least) would benefit from this by eliminating waste of re-processing
ELF many times.

Mykyta Yatsenko (4):
  libbpf: use map_is_created helper in map setters
  libbpf: introduce more granular state for bpf_object
  libbpf: split bpf object load into prepare/load
  selftests/bpf: add tests for bpf_object__prepare

 tools/lib/bpf/libbpf.c                        | 197 ++++++++++++------
 tools/lib/bpf/libbpf.h                        |  13 ++
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/prepare.c        |  99 +++++++++
 tools/testing/selftests/bpf/progs/prepare.c   |  28 +++
 5 files changed, 271 insertions(+), 67 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prepare.c
 create mode 100644 tools/testing/selftests/bpf/progs/prepare.c

-- 
2.48.1


