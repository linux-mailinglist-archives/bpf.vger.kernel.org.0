Return-Path: <bpf+bounces-68362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBB8B56E6C
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 04:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7314189C016
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 02:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054282192F2;
	Mon, 15 Sep 2025 02:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NM7FL8Jd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7B81F8722
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 02:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757904457; cv=none; b=KdkOpIH1x5tVHiRUfaN44eBZqd7UQsEFa9HE0RP00LzRbcgzxd5IRJKXEsO+Nmdkhe3R1Ooxx9hHdeQqb/4jiyrjyFQCD7m/Yk7pq1GngLcPkGJrkB9aQL43k9Nd5fVA4DSUmn/TR25fLX2v0UKPmI5d8khaxfAZvEaJY1OpKEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757904457; c=relaxed/simple;
	bh=RXGVTpoHalDhgZMu4ahTGXSGnvhrr3IbVilpfoUwh28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EutBKu5tr3b6Woqof5q70F1oz5nvr/wzL+xcJQ/C4UPSX1Bj46aOpXYR+lfemfIJIAaeQkcip/6vIqpInxP63ic7yWqEnQSn3/R5JezAkuLImmLOYM7qWW7eCjzUrcKrNzvR7/GHLrv8ewoXh3bxluevfN82BwqxpA0HJbr4x2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NM7FL8Jd; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso2910620f8f.0
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 19:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757904454; x=1758509254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m6huFvTtu97vFiH1HhLYJkQsfgypBzq3FafmsBwGyik=;
        b=NM7FL8JdLnR1nkQXUwyZtcVXjmc6Mndp+0N85JeXBLdhWzit8nN08pIpXWWeS1ep2u
         sxHcB8KhIDfV7VCrhaXFhaXfsycTWQKNQ0Qs2quplVUuGkl0isCmB5AI90u5KXb3smeL
         mRmC6WREE2zjn2yl0gYtUaj271Y3V8XviL7ybnkt7hu8rS1Qbjc0ALPIV+20YqGzOp/l
         x0OeqNMcfrPO6nDWUHn5ac1VMR3LsYS5zEkEHXdlSoNVmVymdOa0sqzUYxvyti9GBlNk
         AVqGdTVc70CD1qMcnC6kkFvvCXpDlQbTjt6h9XyQOfBWqf/G3Q6TvzWnxfX6dcxa4AFk
         LASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757904454; x=1758509254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6huFvTtu97vFiH1HhLYJkQsfgypBzq3FafmsBwGyik=;
        b=lMxP1vtOBFF4YBrGNzkNByhfu+jVGKSsH8GHX/9pR/iOah8Z21XzIya7VUQDMbqOU/
         Zk8vFJzH23gifuBR6VCJgslGak1sxnY/OzymH4zvHDaqlUN8nRJv+jwTwRRLnmgZGXqx
         vBEAy6n2gidZ6ENLs1WWGRYBDtV5L5HQXvJoJRKevc1SSA78esJpQNcHrZeC6IGiTVY8
         HEGw/ZqRUWiAmcCp6YyDhlbZ6idHeCs944NUFb39kv60mNa/6wlYGQiiki+VHVOIiBAL
         9+8ZFhGq2cFdw9BunB9f/CwCKUfrEKdnexwF9q8efBda8thR7M6qg2uiRq7bpcNEkVmj
         bNgg==
X-Gm-Message-State: AOJu0YypUt8rpQjYEvMeFsWCW8h2tASMMEe1Mm4TxmiAnXEtf4nnRRXl
	t6FMUpKEf16vR5dQEBma8DkuHlfA2p2koD6kvbQeghQN79ufwaAolSN4OmGiBTEB
X-Gm-Gg: ASbGncupTbchULOQURDFqW6UCK8YJNucjCXcWcJLe4FH95N8Z4vE0nedjL9r50QhZJN
	I1kbUconrGK5uFv5UQDOGF0e7nytKHEsHBeIkGtlOtajIPq0K6xnrk+GBTYGeKc6SRLVAota26c
	S2TogW0nqaZO8DCsmdmbPZdKhoY1//TxU56LXxDbFgQlfnqX/IZyNLsOdMaNz0Ke7orxK1d+DgH
	PvcvsVvLcf1MUkYCoeQnXeevxUcxEA/49ZBinQrRKtxwyscEUfShf1/u512t6xuDsWkEfPTwAjn
	QbKZFxVja+8LCFXZ3Pm0Rfqee0sKGQCXviD7PqDI80F3bqBNszY4FuWmVwSjEXM+oPWWdRKP3Ao
	uc0/DyGOK+1vwEs6J+u8V5dZWu6lQyIDFeU+dmVEMUirrG6rnRtqLOvE=
X-Google-Smtp-Source: AGHT+IExo2JrYaxJ8jWAnjVauALPJWGZQseb9vZokXuFKuxYMLZj4FgCubi4BZUxQMDMQ066KzBLUQ==
X-Received: by 2002:a5d:5c84:0:b0:3e4:f71e:2d7e with SMTP id ffacd0b85a97d-3e765798576mr8749923f8f.23.1757904453498;
        Sun, 14 Sep 2025 19:47:33 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45e037c9d91sm154575455e9.20.2025.09.14.19.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 19:47:32 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 0/3] Update KF_RCU_PROTECTED, add KF_RET_RCU
Date: Mon, 15 Sep 2025 02:47:28 +0000
Message-ID: <20250915024731.1494251-1-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757; i=memxor@gmail.com; h=from:subject; bh=RXGVTpoHalDhgZMu4ahTGXSGnvhrr3IbVilpfoUwh28=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBox34grgQGNFoDvTESXruxqRPCCRx6ij2sqmbl9 /+A6cC+pdyJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaMd+IAAKCRBM4MiGSL8R yljfD/wJUyfael9nunTLp8Mf8cJ5/1p/sfjHlX9ZTyEh6QoOOQ2gKQnbR4x5ztp0GheTVXrE6Xm yRTdk6Pvg6irtHjEXRGI58RVW+nK/al8fcBu/UDQ+2zaNoiCYAk7wapoA+Dv1HO0D8jdHB8rn++ 9fApQWbp/aGlUGVC6IZl792ncbC5zzjv6JWgi3vnejSE0o4N0pZDuKelWgVWbi4QO5mkSzzjOtv svgDSI+bJZDGTrYbGiYdgmCYPPEGw9gS9CXWofCYRQcb8pBclrV1qVMDLOQu6ZhX4Z1xLxl8bIL NvI+IpdE8GlMuGKp9U9DKB7i7uMJQ6GmfAy/tg4Pm+q5nljMevZjmdMs9i2RZrQo+7ayMu4rtSJ rq7r70qAPFL0tx9EGy/cfLDq7lI4VeDUZgna1eU7IP13j/TyWWuj4YgQIY090OZE5r0nRN4s6DC mgEzadBV6uiOD7MH6A+j+PJBJYLv1IqaZvtCbUODajzGq0tlcNL/8OuGcuEP3H+/0PrnpMo24fq nP0CfjNbvYOeCkwBi3nqz1Qo88OMgJryeqOUmGyY5WaplYRkv9d7IZcw01GBdv8M/nPC3F0uv+S /zPMnl4EpjaME3rOaRsm+i5lMPg5zhY5qNwxAY/UfOHdy3NEdOO+bOFZoNZHpl05Xmet3UbGSFH 6W/EU/Klj/OuiNg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Currently, KF_RCU_PROTECTED only applies to iterator APIs and that too
in a convoluted fashion: the presence of this flag on the kfunc is used
to set MEM_RCU in iterator type, and the lack of RCU protection results
in an error only later, once next() or destroy() methods are invoked on
the iterator. While there is no bug, this is certainly a bit unintuitive,
and makes the enforcement of the flag iterator specific.

In the interest of making this flag useful for other upcoming kfuncs,
e.g. scx_bpf_cpu_curr() [0][1], add enforcement for invoking the kfunc
in an RCU critical section in general.

In addition to this, the aforementioned kfunc also needs to return an
RCU protected pointer, which currently has no generic kfunc flag or
annotation. Add such a flag as well while we are at it.

  [0]: https://lore.kernel.org/all/20250903212311.369697-3-christian.loehle@arm.com
  [1]: https://lore.kernel.org/all/20250909195709.92669-1-arighi@nvidia.com

Kumar Kartikeya Dwivedi (3):
  bpf: Enforce RCU protection for KF_RCU_PROTECTED
  bpf: Add support for KF_RET_RCU flag
  selftests/bpf: Add tests for KF_RET_RCU

 Documentation/bpf/kfuncs.rst                  | 24 +++++++++++++++++--
 include/linux/btf.h                           |  1 +
 kernel/bpf/verifier.c                         | 12 ++++++++++
 .../selftests/bpf/progs/cgroup_read_xattr.c   |  2 +-
 .../selftests/bpf/progs/iters_task_failure.c  |  4 ++--
 .../selftests/bpf/progs/iters_testmod.c       | 23 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  6 +++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
 8 files changed, 68 insertions(+), 5 deletions(-)


base-commit: a578b54a8ad282dd739e4d1f4e8352fc8ac1c4a0
-- 
2.51.0


