Return-Path: <bpf+bounces-69677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AE1B9E690
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 11:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45C64C76BA
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 09:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BE7279907;
	Thu, 25 Sep 2025 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsHSPkon"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E988225EF97
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792972; cv=none; b=XTEFogwIokbGodpgWqmid1q+317CG8fio0RYck6JmgpSrXStQBPV3829LoR1Cr7V2CC2AciO7oidiynrKTTpxvK4FHugwtEUlOZjpx8P8P0hXFpgnsXRGSfrG4d3SY0XsI1Mr+SSy3cM+41tGdPseugY9xmBUyeO+DJlUtM4bgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792972; c=relaxed/simple;
	bh=rvmn/9fNBwLXiR/naWUZlKBH+/yw0HMGHd9myyptFrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JB5eZtFs+NcPeK7J0QzVOqVmNSF1Qyz8+sp8jCKYfRK2nfEiq9teGu7pB8kYhhyFFlJIdwNDDrfMQduQ2QOfH0Dby8MxQDhbIKp3Y99XI88Si1oyKbI1ZjRvPO5GzjDu8U7RW4rt1qqEctJVLREPPnGsQvl6JMzI9cJP0e1PLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsHSPkon; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-634578d2276so72373a12.3
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 02:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758792969; x=1759397769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JrLk5BVUfi64hDu8MSXp4iRz7KC+EB7RrIoytg966TM=;
        b=hsHSPkoniy4OM3osSYrthKjNlU3U8eRIKniZJr+FZNd9fkcLB/uwwvTJd3uKtY8c1E
         YUE2361b46Ye8Lr0720uCToRQEc6e8+4Wl+aGmLcr1iIYE0WMnklFDXmyMeQAyeYzbQQ
         uaRVeEKdAcoCQTu4N2kau8It8VrdxJWkBtfVnA+QzPrcDwWc23VwnhgOBTslar2Qukk8
         c5Vzfo3X1Ys4yQ7UKdJSg27RgDXt1XmFMPsAXDqr6tg4JUk7gKh5GkOI29KEPS+nOLQn
         4R1rHedWPpuUC4DXV7BA6DcZOpM5Go3jQgxhGLr1NO8m/jhhRtenf9evBMgW/nxx6RfN
         FBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792969; x=1759397769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrLk5BVUfi64hDu8MSXp4iRz7KC+EB7RrIoytg966TM=;
        b=qdgPiwjoWJaz5YByKO/ddcBURC1SVvQIxX/92I4+AKUiU9op1fSJJ+31zoJkbNP7KI
         EGJFvZDWB5riZIcFSeNa6ZAoJIS2u9t3BaLtguckiSbEaOlUQUiX5hMKiOyWsMiRPPFJ
         9vdazYmwjOtS/mgiY3n9fROVnUYW5BEI+ecbpORaA9vZpBpgiiEcPQCs6ZK6clbh38nD
         Dtf1AkzTS57M/5GPqdZL+/DaxxuHdT3ostF/FZOFz+G77jOkImIO2BYsIrCaleYirPJh
         m7dUQ4kPMsNZSLV2kB3Dr5fBN9/EN1nflYO1iKesBfjBoib5gZt6mJqFghZ1N4fi6XhW
         5j/g==
X-Gm-Message-State: AOJu0YxDmhxZlsvtP8lpVHxnPoyROWLQL5wwjEsnkspAl1hV1ECKTVDm
	LthW4kb8vLjSLkZh30Ih7IJXtQyYoSoPP10mnCQAaO0+BAtCde7UsDrE
X-Gm-Gg: ASbGnctp7TsqYWSW8YlI0I2nC0SlKwjw/nPWDTD/Ikx0xR2qhWIpoEJccloDY3MjEyF
	CgHfsvkpjnQzy/TwMkhgLk0UfvcxpSsDFfwceVHb/YsbElb3BDHTYYPKqLHjgO3rKk10IFAeQP5
	72UHZN55GDOIowcN9odXemZivc9iZA6euO6IMarvTf0YlafKfvo+9TlJCxuthZ2sZADee9hdZfh
	yOqXzCJ7F/DfK6PMLhEXAQJTYUz5eqJoP+1nQ15C8nxqmEQGQqO/FUmBTU0wKtM9GFzU0uQYZiP
	mX/q09P0GgrR8GnXrgDsv8NpKQROZZpEYhDOVRTV7wsLcRa49r71U6QuDfLgtgyi2IfBqiygCMJ
	zy6nDELLx7ST9vXdlt0YeDJSDcisw5PLuSM17+g==
X-Google-Smtp-Source: AGHT+IEn+TRY3f3rNpLqKcwo/IFO0X1TqRBrGc61qVTD+XlR37lk96NhcpagZXDaWeHbktL+5wxb3A==
X-Received: by 2002:a05:6402:4389:b0:628:d1b5:d207 with SMTP id 4fb4d7f45d1cf-6349f9d26b0mr1238596a12.2.1758792969099;
        Thu, 25 Sep 2025 02:36:09 -0700 (PDT)
Received: from bhk ([165.50.112.244])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae321csm941225a12.24.2025.09.25.02.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 02:36:08 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	linux@jordanrome.com,
	ameryhung@gmail.com,
	toke@redhat.com,
	houtao1@huawei.com,
	emil@etsalapatis.com,
	yatsenko@meta.com,
	isolodrai@meta.com,
	a.s.protopopov@gmail.com,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	vmalik@redhat.com,
	bigeasy@linutronix.de,
	tj@kernel.org,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	bboscaccy@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	mrpre@163.com,
	jakub@cloudflare.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH v3 0/3] selftests/bpf: Prepare to add -Wsign-compare for bpf selftests
Date: Thu, 25 Sep 2025 11:35:38 +0100
Message-ID: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is preparing to add the -Wsign-compare C compilation flag to
the Makefile for bpf selftests as requested by a TODO to help avoid
implicit type conversions and have predictable behavior.

Changelog:

Changes from v2:

-Split up the patch into a patch series as suggested by vivek

-Include only changes to variable types with no casting by my mentor
david

-Removed the -Wsign-compare in Makefile to avoid compilation errors
until adding casting for rest of comparisons.

Link:https://lore.kernel.org/bpf/20250924195731.6374-1-mehdi.benhadjkhelifa@gmail.com/T/#u

Changes from v1:

- Fix CI failed builds where it failed due to do missing .c and
.h files in my patch for working in mainline.

Link:https://lore.kernel.org/bpf/20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com/T/#u

Mehdi Ben Hadj Khelifa (3):
  selftests/bpf: Prepare to add -Wsign-compare for bpf tests
  selftests/bpf: Prepare to add -Wsign-compare for bpf tests
  selftests/bpf: Prepare to add -Wsign-compare for bpf tests

 tools/testing/selftests/bpf/progs/test_global_func11.c       | 2 +-
 tools/testing/selftests/bpf/progs/test_global_func12.c       | 2 +-
 tools/testing/selftests/bpf/progs/test_global_func13.c       | 2 +-
 tools/testing/selftests/bpf/progs/test_global_func9.c        | 2 +-
 tools/testing/selftests/bpf/progs/test_map_init.c            | 2 +-
 tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c   | 2 +-
 .../selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c      | 2 +-
 tools/testing/selftests/bpf/progs/test_skb_ctx.c             | 2 +-
 tools/testing/selftests/bpf/progs/test_snprintf.c            | 2 +-
 tools/testing/selftests/bpf/progs/test_sockmap_strp.c        | 2 +-
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c           | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp.c                 | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp_dynptr.c          | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp_loop.c            | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp_noinline.c        | 4 ++--
 tools/testing/selftests/bpf/progs/uprobe_multi.c             | 4 ++--
 .../selftests/bpf/progs/uprobe_multi_session_recursive.c     | 5 +++--
 .../selftests/bpf/progs/verifier_iterating_callbacks.c       | 2 +-
 18 files changed, 22 insertions(+), 21 deletions(-)

-- 
2.51.0


