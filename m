Return-Path: <bpf+bounces-66437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F5DB34AFD
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 21:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074EC17B9A8
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 19:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746D7284686;
	Mon, 25 Aug 2025 19:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPvv8eL1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B1C169AE6;
	Mon, 25 Aug 2025 19:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150763; cv=none; b=PlZ0bcIdVfz5iLEiNmO7zExjeNh+CkpIeZmPCGGEuohgTvA6mFOp15Iyr8Mx9pZmfqFOo4KyBubtPYH+oH8plmZmiSPLY1+m8ISu+SfpnhMXcB7rjWvG6lJper36Bto8AVHRkCS0LK1ysxbjVeIJIB8qsL9j8gNJRgN8bjI4TtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150763; c=relaxed/simple;
	bh=Cn6/HZnCTFo02lLWmt25HP9iNxs2Iqsw3oAhOtx1NVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lVKK6465GKQB2h6F054pzcRAynQb8y4kkvb8e43OILkL+sGFDlSFl25xFbIIgs4GjN3Pzjuoz7eyiAJ8rTQLIBEIdJn4oIsorMK8PTzkTZYZSEX/xmm5iN1ChPg1kwGvG0zsFj4IJP+l6WNWKiWgj6cnD8xsn6Zv22hCvDtv2NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPvv8eL1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso4168828b3a.1;
        Mon, 25 Aug 2025 12:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756150761; x=1756755561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o8W4J+U5EAw2EOUUiz5ymEbsjA13ntkTZm7s0USFxlY=;
        b=TPvv8eL1wF/t++QRSKlrfNpndFFYB56J1oXVUkQGLuE911kl3pieWcQGidgA3+YaMt
         T6gy8fYSVGpcZSeGVINTuUPDERvLlLJuP8APCyEzT87Pvy+wpFSa4NbeDzHRLh8XRRwB
         5NW86kkgHJGul07A2fLzA8l43iyedaqiCpIUIanjUFTatv42ZyftFNS0lU3V5G+Q8cbN
         Sof+Xj8yPiIO9KWoffu2+Hvinmx09nbCF4vL3TzQbuuoDAWBSeuNVMgMJEWXS/+pcjBw
         Fvl9fHxmjifr5UGjisNHjDzxepqk80UH/bxKw7opELvQJms4NG/lK235BAlWByU6qHpx
         8rOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756150761; x=1756755561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8W4J+U5EAw2EOUUiz5ymEbsjA13ntkTZm7s0USFxlY=;
        b=r7OU3dEEFI/rE69raZFGelU9JOXavTKAmv53RfFpNomnytgPggre37RUyzgTnre1U4
         fS/q+6gWJsKh8CowV6pqtDiMNjocNXBWH38Rnfu3F9dWK0VTrVwpXN/DwkehI0IbIA6k
         XT7zj8uuKmF57Mk9K0NSg2jAK0fL7B1/o21SvmSr+Vyx8eiT0zVu1JlbhuTg3tVCawEk
         Z2A5dNRj5ytuZ8KSgrYaBJURcOGNkyneugHRJJiFAPYVyQCj/eAIllgI6XlSp7P4PtWI
         zqmLqLmP/6FLevRnVkh+b5va+iiMvEwX2QBoeKRCJh6SonB2FGiEcUWloMrvncXcn9xu
         L5nQ==
X-Gm-Message-State: AOJu0Yzj0xkC4Gn0X16A5ZXtNWnOFu++6TtXaqGyZ1o/uBd5qlW7Jhzy
	0EqhigCeiCyaztrt5Sj0El8JQmQmjj8XMdnpuqZrBwZYN54ZpoQNuESEFxyExA==
X-Gm-Gg: ASbGncu0TeERaDT1ItsPBIEZdZP2cw0jlvUhz57PJEbSkVOaJOAdb/5NzsWptml30W3
	ggXNv48IpEgntu4OKDxO31Kt/oVynbTxGTxqCnmjIfaa5MCwOSOW59QM25CyAIvGGcH2mifTZcu
	35ui8CbSF+EcFAIpijTAgGqVJJvDbdQFQVzcfJ9EivOIHJEDLvSCRQanEw4lgfmQlBkr2kQVwb6
	0Hug2FDyZ6CTQ0CFqYRtGl3tDK/4zKNPuHiLZzXIb22Sqhjlr1U4D9EII3yKVErpv2ICgwmP4dm
	3s975hidzJKSdSBMSrGL7e6qESgtDUMh1DkoaIWcnUOOweqQThrmrARMIaNfqObMEJzAgSA5EAu
	Jp0bZ8VhQ2XMUA7piQ+2nthRV
X-Google-Smtp-Source: AGHT+IHuS1nL2P//sJJC0fBa2vNYfsxP1MtM2LcOCvaf4K9Jo6sx9SmBRECW48ZlfXL8V9ET+Wo7wA==
X-Received: by 2002:a05:6a00:4b55:b0:76b:fab4:6456 with SMTP id d2e1a72fcca58-7702fadbb34mr16270092b3a.21.1756150760590;
        Mon, 25 Aug 2025 12:39:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771f045b687sm1408383b3a.109.2025.08.25.12.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:39:19 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kuba@kernel.org,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [RFC bpf-next v1 0/7] Add kfunc bpf_xdp_pull_data
Date: Mon, 25 Aug 2025 12:39:11 -0700
Message-ID: <20250825193918.3445531-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patchset introduces a new kfunc bpf_xdp_pull_data() to allow
pulling nonlinear xdp data. This may be useful when a driver places
headers in fragments. When an xdp program would like to keep parsing
packet headers using direct packet access, it can call
bpf_xdp_pull_data() to make the header available in the linear data
area. The kfunc can also be used to decapsulate the header in the
nonlinear data, as currently there is no easy way to do this.

This patchset also tries to fix an issue in the mlx5e driver. The driver
curretly assumes the packet layout to be unchanged after xdp program
runs and may generate packet with corrupted data or trigger kernel warning
if xdp programs calls layout-changing kfunc such as bpf_xdp_adjust_tail(),
bpf_xdp_adjust_head() or bpf_xdp_pull_data() introduced in this set.

Tested with the added bpf selftest using bpf test_run and also on
mlx5e with the tools/testing/selftests/drivers/net/xdp.py. mlx5e with
striding RQ will produce xdp_buff with empty linear data.
xdp.test_xdp_native_pass_mb would fail to parse the header before this
patchset.

Grateful for any feedback (especially the driver part).

Thanks!
Amery

Amery Hung (7):
  net/mlx5e: Fix generating skb from nonlinear xdp_buff
  bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
  bpf: Support pulling non-linear xdp data
  bpf: Clear packet pointers after changing packet data in kfuncs
  bpf: Support specifying linear xdp packet data size in test_run
  selftests/bpf: Test bpf_xdp_pull_data
  selftests: drv-net: Pull data before parsing headers

 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 59 ++++++++----
 include/net/xdp_sock_drv.h                    | 21 +++-
 kernel/bpf/verifier.c                         | 13 +++
 net/bpf/test_run.c                            |  9 +-
 net/core/filter.c                             | 81 +++++++++++++---
 .../bpf/prog_tests/xdp_context_test_run.c     |  4 +-
 .../selftests/bpf/prog_tests/xdp_pull_data.c  | 96 +++++++++++++++++++
 .../selftests/bpf/progs/test_xdp_pull_data.c  | 36 +++++++
 .../selftests/net/lib/xdp_native.bpf.c        | 90 ++++++++++++++---
 9 files changed, 356 insertions(+), 53 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c

-- 
2.47.3


