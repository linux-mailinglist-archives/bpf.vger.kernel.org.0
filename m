Return-Path: <bpf+bounces-64408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A00B12497
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 21:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707BF3A572A
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 19:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D8A25743D;
	Fri, 25 Jul 2025 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRXlLIgK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADEC242D8B
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753470413; cv=none; b=QObekUCHrT+RBrpqs2wbZX0QxX1t8Qaeiq8Upnj9d6JRRWYDCsdHd1SYanzoW0/0QP22zeLzhDevDgGpxx1bPuWhBoGnU5XEEGVuBg57brOIqTDpejrG2rYlJJNZPRyjjsHe36yWg6qBPGDE3dq2asFMuDlfZ3kYzmWOAAXE1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753470413; c=relaxed/simple;
	bh=7Kk4pAXiyPow9E8btfEGNLBkLI3whrpZG4PRVJSegcU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uOEa+OwkkUcR8sclxAvQiJer/rKOVjTKkrrOg0DilquM5+R4DODwsCf0yN/jr6+VZpQbylAlNcuRqDJAAEMCyczbXTn5yP3VOQB9Hm6SdxfBB6xCi2kU7qaUBn0r0f8AALFk2Dr/gAAGW5U7XLlewDijmWQhseyOATKZ6UazE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRXlLIgK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so20808085e9.0
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 12:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753470410; x=1754075210; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ae2tIkIgMGQ/4jgvRnBIHw2fQYaLECm+6mnRuJuI1Q=;
        b=DRXlLIgKGuJUvvcnIjkXt0uLQyx/Dq85l3/a5/0dXM6UA29HJdBxMVDcCx3wj5afqO
         z8AOtCMBi1cCUMXtZWF6p3vFiMnVwCpKYdTtKOtO0SmG5zvjmcK+/iS8blKtzCNjLBHN
         if4R4tHVoXHrExKuH7JpIY0AFFTWmgBURBbb8taYnY3hcZgr/VI+80JvsvdTDnka0knw
         ABIyRiwe/3fNSz77/qhiEm4hGlqwWwZlc8noGzIp+mLdVUUTiwbhYOeH2vSj0sMJsC48
         1OkXOcWH8LNsYwXVIn6Bi1brGUokZfVzAouHVo2YbsaTxqZG3qRx/KrOAoecRtkiqBXE
         keOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753470410; x=1754075210;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ae2tIkIgMGQ/4jgvRnBIHw2fQYaLECm+6mnRuJuI1Q=;
        b=q+LE6GHekyVhO0B+Dw3yV/wZ8cueDBBTRA5MME8b1nGFtdoV7vihASM1bIsCwGveF4
         7HasFm68CORcOlx1F2YM5/O1CWLVPhfyhJavAet5rBle7lvO5/GMmMku//qk0EysGFl8
         hS0vN1iWGWrKzyaS4HzCeaKtrwkYBFou/Ob+z30NJdpEIl8jmGNe/0IuqZRxQSkR5myU
         PqOW6YGXbD9S6JAHjHgukHwOMyswzqy+8/Vaiuy7qvFa4z/tqDl2J0fGCuTP59EnkoAA
         zHHQEizQdsDbzfwp0Kzgoov45UM33Jr13u7FTAiHTZPgwcBJmJaMoBgIi5TdVSd5WpSF
         ntHA==
X-Gm-Message-State: AOJu0YwGoTmTh1TJR50t9BtY7Pm/Qx5sTxBaNDgyPtwcxtyuwpdNTohG
	E3vjaOh4YjULRfx87UsvVQQpeS9hhn4s96HFth+KPE5r0HqadTr76E9Sdw52Afg8
X-Gm-Gg: ASbGncvEBagHkSKk96OSiudlQgGrD9l00D9zyby3IN1fFrMNAotvR9ugOtSnLLowVo2
	1PbYR14Awl929kMKw2LVoC+mpybWAUJLg82xLzIp4rUpbFc4dnHlOPbRPpiEkXoUcFeFdxPto4x
	k30Fg7LbXLlqZTgbDn8Dt2amO6eGEnAcPKpJN15jVHVpTKksHYVA1yqfWd0Ioytrw+La+TbrgDQ
	VmNNxFP5xiC3uOasNm89b1/7h/rlt+rBG6mI4XFFFqeF2bz24G/NkA79LTNUM2wthNuTQ99UZ69
	lGHuNq84bs9002OrXg0YpM/re5UffWwGBT1o8faxkW2kWhQUgJRpMLO6ex+y423+sKhn0hIrHU1
	EvhOiU/sRK3+XKnBLlHYrQ/WARwleDVy0Q9z5pYK+IdebuoEfnjqUqpFd3pEKyc9T8irD1A132g
	1YtCqcaJHJ3Dw9EzsPoEnK
X-Google-Smtp-Source: AGHT+IFJmZ7qMu+gGJRQinQ4q0DFuSusN5JjY+GBIcaj0KeNzrNhg2BsduGd4q5el2QM5NBe4YgtEg==
X-Received: by 2002:a05:600c:46d1:b0:456:1281:f8dd with SMTP id 5b1f17b1804b1-458755f1f9fmr30869705e9.12.1753470409782;
        Fri, 25 Jul 2025 12:06:49 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e008dd2b4234fb07c80.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:8dd2:b423:4fb0:7c80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587abf4fcdsm6002675e9.14.2025.07.25.12.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 12:06:49 -0700 (PDT)
Date: Fri, 25 Jul 2025 21:06:47 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 0/5] bpf: Improve 64bits bounds refinement
Message-ID: <cover.1753468667.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patchset improves the 64bits bounds refinement when the s64 ranges
crosses the sign boundary. The first patch explains the small addition
to __reg64_deduce_bounds. The third patch adds a selftest with a more
complete example of the impact on verification. The second and last
patches update the existing selftests to take the new refinement into
account.

This patchset should reduce the number of kernel warnings hit by
syzkaller due to invariant violations [1]. It was also tested with
Agni [2] (and Cilium's CI for good measure).

Link: https://syzkaller.appspot.com/bug?extid=c711ce17dd78e5d4fdcf [1]
Link: https://github.com/bpfverif/agni [2]

Changes in v3:
  - Added a 5th patch to call __reg_deduce_bounds a third time in
    reg_bounds_sync following tests from Eduard.
  - Fixed broken indentations in the first patch.
Changes in v2 (all on Eduard's suggestions):
  - Added two tests to ensure we cover all cases of u64/s64 overlap.
  - Improved tests to check deduced ranges with __msg.
  - Improved code comments.

Paul Chaignon (5):
  bpf: Improve bounds when s64 crosses sign boundary
  selftests/bpf: Update reg_bound range refinement logic
  selftests/bpf: Test cross-sign 64bits range refinement
  selftests/bpf: Test invariants on JSLT crossing sign
  bpf: Add third round of bounds deduction

 kernel/bpf/verifier.c                         |  53 ++++++++
 .../selftests/bpf/prog_tests/reg_bounds.c     |  14 ++
 .../selftests/bpf/progs/verifier_bounds.c     | 120 +++++++++++++++++-
 3 files changed, 186 insertions(+), 1 deletion(-)

-- 
2.43.0


