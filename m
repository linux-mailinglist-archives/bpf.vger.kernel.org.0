Return-Path: <bpf+bounces-43943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB939BBE84
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 21:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBD8BB20F0B
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 20:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0AC1D3195;
	Mon,  4 Nov 2024 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="N28p+SXF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0235B1D319B
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750699; cv=none; b=t7uXYFhaK7rI/iPqS0csTF9+c76lhSJ7gnXIM3cLMKVHblgJBmo0F48YhxAHoiNDeaHVvQm1Y3vnSnz2Y+vVkSR2og+tFqMxqMuujdxQT06IBGTu693NqmbWNNGX2ljazQL4g7lCVvnu931nswZypzbH2PC7pQpotvk3ml8gtMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750699; c=relaxed/simple;
	bh=UnGsEE5T5DTXsTsIkW9CF+IUYDHtMSKcq9qFFdvAaa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ac+R45wAEG6KNBkOdT0E+SwHndTJwgjDwCIOGa2lBagfu/nsU22BKkR+9Pns+h+Eom8EWAFfUP6Oro50PhzuCnJ+H8Cc779RoBW1LLTp1kxnnUh/qX94nthm2AvDoOqvwEaBdf88lXkTV0Cw72PqimtiAgCwNgtdVBQ0Ol8btNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=N28p+SXF; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso7534168a12.1
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 12:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1730750696; x=1731355496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RQIzt8gv504ftPwb1a9V6T/AzSqxkXJl74UqHCDCUHY=;
        b=N28p+SXF00/mVJeAakkP+mu4sO0gU1kuhCKiXE5N1IPzB3HU+AXwlGyLiwkz2FZSYa
         FiKVusQkpkjUx62IPEWBhayOhk6jiEdM+ZQ/C4lQq56GY5PJq+ox4/b1R0tK143k/9Cb
         J3Jz4HztIr3Cr4BPG+EcSXLlCiRFfCR9K17OdtGvTjkXClXAQqcpQgCFk9ZlJsmnYGSz
         zSWgNZh+Kyxgr5GJYAoyCEi0aPFBYZeVJvW5B+tPj6rGpeI8nwXv3rEBk9EV05T4BbsX
         eUMNPFLOSqGLuMkB6G6r6CI7bmOE2Vbe7gI5XC4pkSH11JfyoOBqbIUPr+i3MedPUzzo
         khOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730750696; x=1731355496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQIzt8gv504ftPwb1a9V6T/AzSqxkXJl74UqHCDCUHY=;
        b=j6iPnLuL45Wr5MMAOQgPs5ky5JOnCRhtECFLgbxr8IC78LmdvqqJDQuGxc0oRQ8Oye
         H19jw5ZzS17Z3+5DJLI/ib65918hdrJSM5wwDedjRsVyIU18QFgWBb7R64DoGAmmMl8D
         wUDKoYxpF/gp5IJ081EfilhTPUa5TC6yXCUkbEslL0D3hub8VKmVHyRJV4Lfoq59+8tQ
         41Usns7d/Ws8bab1mhO9b2yq7HAQJqJHSxCE6eGLuuniVYxlWam56+PGj9Xyxd181aT6
         lYUHXI6JfkiyZDxBSC505T8/zpdt+k7DLDnFcuDaG/FAknyRXX8t/HWDGC4ApQ2UMgpa
         gskA==
X-Gm-Message-State: AOJu0YzpFU9ZE6zKr5QfXDpXk7yjY+8Q3khgVhoE9XoVPhPJacMlgz8X
	RAH1WFbH2VjoN7SlU49U4FWGcH/OBNHLJ8+n7boxrR5MGLsPTCtu9Jx0NoB6dzly+iWKFxJCdXZ
	b
X-Google-Smtp-Source: AGHT+IFNGGGXG+hvZ1eNKjoMJ8VwDTGWxf7T/Jmo8VPNspOXKQyrOyp6Lk3JJi0/ZzMdtm2u8WjEkA==
X-Received: by 2002:a05:6402:4148:b0:5ce:caa1:ca5c with SMTP id 4fb4d7f45d1cf-5cecaa1cf10mr8575592a12.17.1730750696016;
        Mon, 04 Nov 2024 12:04:56 -0800 (PST)
Received: from bell.fritz.box (p200300f6af056e00c6570c15b61f00e3.dip0.t-ipconnect.de. [2003:f6:af05:6e00:c657:c15:b61f:e3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6a9a5c6sm249160a12.17.2024.11.04.12.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 12:04:55 -0800 (PST)
From: Mathias Krause <minipli@grsecurity.net>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH bpf-next 0/3] test_bpf.ko blinding fixes
Date: Mon,  4 Nov 2024 21:04:49 +0100
Message-Id: <20241104200452.2651529-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With BPF constant blinding enabled, various tests exercising jump offset
limits currently fail because size assumptions in the code no longer
apply. The created BPF program will be expanded through BPF constant
blinding, pushing jump target offsets over the limit.

This small series fixes these by either avoiding the use of instructions
with immediate values (patch 1) or accounting for the expansion (patch
3).

Before:
root@box:~# sysctl net.core.bpf_jit_harden=2
root@box:~# insmod test_bpf.ko
insmod: ERROR: could not insert module test_bpf.ko: Invalid parameters
root@box:~# dmesg | grep Summary
[  177.628099] test_bpf: Summary: 1000 PASSED, 49 FAILED, [988/988 JIT'ed]

After:
root@box:~# sysctl net.core.bpf_jit_harden=2
root@box:~# insmod test_bpf.ko
root@box:~# dmesg | grep Summary
[  220.437597] test_bpf: Summary: 1049 PASSED, 0 FAILED, [1037/1037 JIT'ed]
[  220.477987] test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
[  220.480525] test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED


Please apply!

Thanks,
Mathias


Mathias Krause (3):
  bpf/tests: Make max jump tests constant blinding compatible
  bpf: Allow calling bpf_jit_blinding_enabled() with a NULL program
  bpf/tests: Make staggered jump tests constant blinding compatible

 include/linux/filter.h |  5 +++--
 kernel/bpf/core.c      |  3 +++
 kernel/bpf/token.c     |  3 +++
 lib/test_bpf.c         | 21 ++++++++++++++++++---
 4 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.30.2


