Return-Path: <bpf+bounces-45169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 745589D2508
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 12:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259341F2545B
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 11:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFCF1C8788;
	Tue, 19 Nov 2024 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="crvWGs36"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322FE1C07C2
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016437; cv=none; b=XOX04h9XSgGNSIKJJlXZQbhvr+jOJZFFayEEXRXl3G/xXinO/TrrbsicKHq3XSQALvsffR5Oz9baLm5xbyc39htrtiutWeEOg+SvkC4VlI9ZTW9skXvicd0HYiPoKvXgZ7Ij3aGv56oFtY17Jo4lgMslWIknYMdxq9opSYnKmDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016437; c=relaxed/simple;
	bh=1wrqr6Ee4ymZiAiKCwpOn0msWn2TBYk3sQkorq1Naq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZpFB56QssB0tgIA3WPFvx1PpV9/nsqTTtTRhvXf43mtkiEqqzUf60Ri6s2q+P/cVvsfk6tFxnkl+JyO/jx93lRItAq+bln7/q2O+9Tb6Iqs+TO8JoOIM/FfASbtyI4+Zn9b11UtKQkSayl5T88G6jh1SkRFN5Xl6nNcae6HhwcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=crvWGs36; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-539e59dadebso1073399e87.0
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 03:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732016432; x=1732621232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uc9qdLSf6FJ9TuHlLaVMeZRMtAnbAPlBNVknnn3vAEM=;
        b=crvWGs369Tp4GEaiJQRv4YohckF27C7OETtI/dEGy0+oCZ/L++EP0ByCXZBqF7Lp5p
         oB+meedMgoGASfiYSTwn0KlshlJs815ZzGLdCWxv+ypBbZZRY6SVjndV/4hPyywBYZZb
         VAq7u5XU/T/Nv7DOtWNqGJ/iUtkyIki5HPi64g3NAW9NV0F/OmWwFo1xDw/F+p1jSgrl
         RCI4n8WydGK1+V/peccrhQnlG9VFX1JBSsx31AtBz0PtmpDYWBFZf/aWYZMNmoJl+8Wn
         nSzmB8jEuff3fDEAMfwtvavnvnwDuAiaorlSHCTngIX6Mdu1WXRgi+O7nbpSW+wxEbmJ
         KZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732016432; x=1732621232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uc9qdLSf6FJ9TuHlLaVMeZRMtAnbAPlBNVknnn3vAEM=;
        b=cA7Im/HcEqS9VExaD+CzJUcCreElBXbXtf1WzIISvdcoCXIA+wCPVDKVXrOeymCg7C
         IXtVawXfdqRyfVVAIvYpLRxn06/xXcqGyT4nkDQa4IRoDoYIClKbpbXtFm7Wig9Ts/bS
         E4Idfto35K5f+u0DfUR43/zccyr19cAMxpg4PW2EiGiOueI+4V22tqIRsUch6osV29qS
         k1XgDD0PEVgTo0AY7MVsGpMiJvb4xL6gEls1+25e5gd8+Ld68ejLCg5wbSLOVxUqEhPN
         NKjpCpcYBwpQxtCx+aSOQilppNdzlQI79DostfYJR8XzKpRaNURZIbtwycseq7+5R7Hm
         1lkA==
X-Gm-Message-State: AOJu0YwYg+4tJXkAPAi3jEfGVT9o8TrLFiO1jNOo6TpLFjrvdg8smzzQ
	SDDrInU+WJ++0FEgf6Hr0NKgGDv/faBozmHNLHIGhrOfK5h3+F+lS6/wvl9fzzhaUTXWg5mwcgA
	hCeCILw==
X-Google-Smtp-Source: AGHT+IFkEalpYnAUPR9XUq894QhVr+94PRjX34zehiSZOyS6HSEwXmdTz9cNpZjBBEUscv3WtTdq3g==
X-Received: by 2002:a05:6512:b19:b0:539:d0c4:5b2c with SMTP id 2adb3069b0e04-53dab3b9865mr7042691e87.51.1732016432109;
        Tue, 19 Nov 2024 03:40:32 -0800 (PST)
Received: from localhost (2001-b011-fa04-f863-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:f863:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ec85fasm72834635ad.81.2024.11.19.03.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:40:31 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [RFC bpf-next v2 0/3] Improve signed ranges reasoning for BPF_AND
Date: Tue, 19 Nov 2024 19:40:18 +0800
Message-ID: <20241119114023.397450-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC because the selftests in the 3rd patch is failing and I couldn't
figure out what's going on, sending out for suggestion.

This is a follow up of Xu Kuohai's "Add BPF LSM return value range
check, BPF part" series[1], where the 5th patch "improve signed ranges
inference for BPF_AND" was omitting because further changes were
required. This series brough back that patch (with modifications as
requested), removed workaround, and bring back 'test 3'[2] from Xu Kuohai
that was also dropped.

Patch 1 add reasoning of signed ranges directly from previous signed
ranges during BPF_AND to the BPF verfier, which allowed better tracking
of signed range for situation like [-1, 0] & -13. See the patch for
complete detail.

Patch 2 and 3 are corresponding tests. Patch 2 brings back an omitted
test[2] from Xu Kuohai. Patch 3 add more specific test in
verifier_and.c.

1: https://lore.kernel.org/bpf/20240719110059.797546-1-xukuohai@huaweicloud.com/
2: https://lore.kernel.org/bpf/20240719110059.797546-10-xukuohai@huaweicloud.com/

Changes since v1:
- address comments
  - add code comment in scalar*_min_max_and() to better explaining the
    reasoning (Eduard, Alexei)
  - point out unsigned range are still propagated to signed range later
    in __reg_deduce_bounds() (Edward)
  - point out the fls(~v) special case in negative_bit_floor() (Edward)
- revert workaround added in 229d6db14942
- add additional tests
- v1 can be found at both
  - https://lore.kernel.org/bpf/20240719110059.797546-6-xukuohai@huaweicloud.com/
  - https://lore.kernel.org/bpf/9505522b-de45-cf52-162b-76a3a52a6efe@gmail.com/

Shung-Hsi Yu (3):
  bpf, verifier: improve signed ranges inference for BPF_AND
  selftests/bpf: bring back verifier tests for bpf lsm
  selftests/bpf: add more verifier tests for signed range deduction of
    BPF_AND

 kernel/bpf/verifier.c                         | 105 ++++++++++++++----
 .../bpf/progs/test_libbpf_get_fd_by_id_opts.c |   1 -
 .../selftests/bpf/progs/verifier_and.c        |  56 ++++++++++
 .../selftests/bpf/progs/verifier_lsm.c        |  16 +++
 4 files changed, 157 insertions(+), 21 deletions(-)

-- 
2.47.0


