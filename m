Return-Path: <bpf+bounces-64496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7924B1385A
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 11:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8053117B60A
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C25022C35D;
	Mon, 28 Jul 2025 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOWYAniL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416C47483
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753696208; cv=none; b=iVSbDfDxUAfNkNbgStmNCVKRUAThWVAW1Yj53xQW+1tPbXkzFdroI0cMdIWoVbZc059vTpg1ED1xaT/qnjynYzv8XirYQQHr9pxsHe29GuK18CA6B6cYWRrGkIQRFMobZUWHJBlXD4mJqk5dcTQX2J6QNxfjhwuddbZrZEOBa5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753696208; c=relaxed/simple;
	bh=e6cDI8Ogfv0EHlltsp2y2q1WZAoSJwGBmkTlOPml260=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Uo3xGghvmO8zJiaDEcO4adEf7U+QbHsmBYUz5LHYD50PcBaEAVAekVmdd2PrkbNQKYZy1MM/8f1V4ZQ2o7UK5yY+FbPhHF8aVQKLqrVflqfRMbCpKTNZvlO+g4MvB1tQmx9BLcEc/cwhPTs/8jDnITxMw4M6CElG/sbX0mgyGWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOWYAniL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso30758715e9.2
        for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 02:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753696205; x=1754301005; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7QHZL5hHY/JIBKmejqD+rdVVPsgyK5xjShIQ2xTW/yo=;
        b=HOWYAniLm28R/KSyC9roio4bWSeMbm1AduGybmOAKrIigy38nYNeNOTfGMoSCtW16S
         CG88xES08LRP+e57QE/k/A0iep/yTrbMuPbhRFsz1656gBWSJv2xjBB3W1tkvBiCrG8q
         wFyQyD8cjmPPAt/DTkudDQiXzBbnWnN+BDmyXXYg7vHkyOdSdbzae6UMXhEOhVvfuVa6
         ZwpdfeBHGK5li5hIOfPXpynyBvprSeS14CSHIFmxkdU6xWB38X2tQ6JEKPokKYC53DNL
         u6PcA4i3JJU4oXJKHCZbsn7iYEZdSpSBxx8QOs5X/SJom9ruQPk73tE9l8lQ5AJ2j6iw
         tG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753696205; x=1754301005;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7QHZL5hHY/JIBKmejqD+rdVVPsgyK5xjShIQ2xTW/yo=;
        b=UOkfD4ErqeUqyupbKyd7qfsPQzJ0wtIjCMMdQtjryl6fTd/OD4s30cEMkSou3c5sVr
         KIgFK8lWQlpT1ndnbBd0pFqprYd1gHstLO/dGHBKmpwKTh56FFFBHiQquPqQdnKxm9pv
         DKTuQEjfLVOY+I9F2z+MH+XHlACy7fVo5GpgkWjQgsUtLDffvpAnhTKpeucQe4oa7kt6
         d9A2o/8gsZM5ydfhBEmnIerLItTytAzFbwL0E74ItmochsZ7Gh/1MDaJFu15y9avPUM1
         2EO/Y/qaqv2I+BJprzZwrPo5biZTT3GDVg6CU+JCpAdKNjLO/b7NC1jlJcmicW/ugQ44
         vaSg==
X-Gm-Message-State: AOJu0YzM4Byp51eXTIVfgLKN0My74HcbN4pjl5PPavHM4h3xL+XE+I8p
	4sTptFLw3yNLQ6CuMrbgOiTv/SghtQYt1euzNAq6dJhMmTF3cSc6GFedYz3mswy7
X-Gm-Gg: ASbGncsAhYjQ/MDUJu55/jrH/1Gm1th8hqXn5Q+hRTPWFlSl7m48K6IZ9KB7oBAhi5M
	6H63Rq8HMHhKUqr9SIiUzRJsEQxJBWyZbKX/u9P5TL74hD2p+RVpq2VU60NqRUx32gvcEiGv0TD
	0XxZ963vmyY9eBor8qVVIPOBksjdWEsHNHCylVznvXjQjIRKPH2maPErKayT0yOrQfLoSn/y/uN
	An4tlD9gRJsnAaWwZA4kZpZwlX7YiKF/dfNNOuyCRSe4VvHudI+wh95BBJ5vIhlK9JVK9UcekXI
	rPN98NgicfbTtyv3/hfTeQAZXhdNeNabNVncx4mfTrj2CGCR/UzFWbRwNpfy7pbgvwGGvaWc9oA
	AHjQHl9wAyDBlieWKUGrIAM0suOe1fiGm/sXXS4s1/Z2v/DKC2e7FYEhTxJDt1j979I9pyCTg7c
	mTBtXsYdDTCMS9pUpdKhs=
X-Google-Smtp-Source: AGHT+IEFVyv8hG0UncZDa2dRrpwqpZyhxbXOsLrht1NgKs+cK+yS0rgyH6y4UEme+D1o7wfzVoBRpg==
X-Received: by 2002:a5d:5f4c:0:b0:3a8:38b3:1aa1 with SMTP id ffacd0b85a97d-3b776642cc8mr7843372f8f.27.1753696204789;
        Mon, 28 Jul 2025 02:50:04 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00616c0b53953fa0e3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:616c:b53:953f:a0e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f034a6sm8416552f8f.47.2025.07.28.02.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:50:03 -0700 (PDT)
Date: Mon, 28 Jul 2025 11:50:01 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v4 0/5] bpf: Improve 64bits bounds refinement
Message-ID: <cover.1753695655.git.paul.chaignon@gmail.com>
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
to __reg64_deduce_bounds. The last one explains why we need a third
round of __reg_deduce_bounds. The third patch adds a selftest with a
more complete example of the impact on verification. The second and
fourth patches update the existing selftests to take the new refinement
into account.

This patchset should reduce the number of kernel warnings hit by
syzkaller due to invariant violations [1]. It was also tested with
Agni [2] (and Cilium's CI for good measure).

Link: https://syzkaller.appspot.com/bug?extid=c711ce17dd78e5d4fdcf [1]
Link: https://github.com/bpfverif/agni [2]

Changes in v4:
  - Fixed outdated test comment, noticed by Eduard.
  - Rebased.
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


