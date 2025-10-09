Return-Path: <bpf+bounces-70691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69722BCAC17
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 22:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22BA53A6AC4
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 20:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682D0263C69;
	Thu,  9 Oct 2025 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW0oHiy3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCC726159E
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760040623; cv=none; b=T8sBx1DQvOdyZR5yH05OtOxNxRifWXaH+re4fR0Y61e3jmCI3mbnBKqSp5q1uEDj3K6fuCDkTbTNefTfIEsInoFRA1AHhhP+OaVyaC5YnZor574wBdSFWUvo+aa+FSZFghR8tct5MJCi3v7fMbp3FKPMisnyKJMlqE6pT2SZghs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760040623; c=relaxed/simple;
	bh=v/w9JZegeF4ZExl/FXlLBFupZGwUnsZ0ne7Ix8FGV7E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A+/h5cYMl3SXVZD5k/b2ZgEWQGMV1kcf8fT03dKs/zZTwWPvuHGj27oNRgObY0ahKWF1+w3hhCJgEDIOcdf4Z7qu3eg0ZYtCHlL9TwK7QRWtA008reGtBu/fTQjSXSFVHHVQ9RR/mFx2bCa0e2kVuMJeG4FPix0u+PRlcSx9dZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OW0oHiy3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e47cca387so13422645e9.3
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 13:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760040620; x=1760645420; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JrfLoENyZjdzYeixQAT3LIyNq6WGQce8UCljQUgmreE=;
        b=OW0oHiy36v2Y2s7c1iMRK5RzS5zQZ0HGb2GbvojwMBCMn9UgXx2gZVeA60LXRIGQgS
         7RllLdk4sR++YZ3FIOE93hGwHgpvmDAc8Y9P8tLzCzQP1mo/0Wbf+sDlU2Qw4fD0swyD
         CCjLUErwbXrbwoSSGkFhMLaEOJdj7vU96FIJC9p9kr9Jk51L2nUk/LkTUnmKEOuy72mh
         CYROCbHoQk+EbwgApmjFncBr0+wKMLrEksogqAhP8vnceMom+AY229+SZTuSSDqIYjPY
         DwjczOX6pp2YNxtw5o8KFQ0aKrLqhZJPnBtqszNI460h2lRJpULdhBxIW+TY4trJ7wwl
         jHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760040620; x=1760645420;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JrfLoENyZjdzYeixQAT3LIyNq6WGQce8UCljQUgmreE=;
        b=mxyF6PzrNP/M12YLH3p3wUiWdBfVtD7se9rul6hA0icyeEx9oPOJyLatXExR/d4Foa
         3Yul+pglG6yG+1LY4q2M03O0I7o4itoNHSmGShPeH3+PEfrzyx7BWJYgfFRM0MrhF1hP
         /sTcLbctvAoX/n8LaWHPCexRE9dSZVzbmjvG2XB0qc79mjMtyU/VTqOj6hn4/NrC/TgV
         DD0w4dnu8erHT+YZvj1+U2Ga94WlEN9yC6/3zgG5K5G4PFvDqUhtuJi3BR9LDR7TLXKh
         QXGl8JJMf6bv3sEfRSeO/ku67ko83GmtGbxlU1RCMut5C+sy6MiEyqwtFXfNsEx5YwrB
         mrFQ==
X-Gm-Message-State: AOJu0Yy+Q1s+Cf4t1/GSNe0Sy2wTAATCQZfbJxkj92jQvpygwqVVwZKh
	xKI31xfsyOXzyvmE12Dq3UDNgHtpGMiuNtWm6hgA2ssWxa5YGhlDQDnBFaGdFw==
X-Gm-Gg: ASbGncs5fYToN5IMzThHLsuhpQ5Fjaw0yd14StIaVvkdCsIEb6+uW3Qe1ZimgPjv/AL
	ZLaEzgAZCpaJFjY+Nk0mu18Allpizo/vryTfO/I56Y2qSRDO1M01AL/XqXE1J351+nR3R18ntCx
	DRRWrHnFhFFVhWMKwMK8ZZuZtuKRNnpSNdfhYpQcJ76/1JtNriHM+Q/iKW2lK8yzT1MJvDNNwxA
	ftGRKyVUMOlMWfAg9iewm3mNd4DuM7yLPQkgqXn9Bwbd3U27qkUWZN7/AMf/9w63ZggUGRWEoIH
	qEhuowwykYy1A3j2bD3/x33uN2tBgGRzfC8dkzs+UNosJ/Ac/eIJZIgXS5TORTcgmdAk7L5dq9G
	pYk8Et7Tbpgn2Xtsp+yjCHfM+8ZcQPAYJ8aOZzBoV2dCRQn2OTdvtN2l+sQX0tKTCiuTj4gbD7W
	grHqRA+18YoapgH6o7NmiKUUf/wkKKWTSwFQow0j67yvLL8YTs/85ZZ4kI
X-Google-Smtp-Source: AGHT+IHBamQWa0VnDSrAqIEVEEDYzTZ4eMjWVDVMGq+Dn5e7bcdw4I5dv9xtdeQsf2XlLBVrB7hIyg==
X-Received: by 2002:a05:6000:2010:b0:402:4142:c7a7 with SMTP id ffacd0b85a97d-42666ac6f35mr6420527f8f.16.1760040620172;
        Thu, 09 Oct 2025 13:10:20 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b81184fd69385167.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b811:84fd:6938:5167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e7e44sm579065f8f.46.2025.10.09.13.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 13:10:19 -0700 (PDT)
Date: Thu, 9 Oct 2025 22:10:17 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v8 0/5] Support non-linear skbs for BPF_PROG_TEST_RUN
Message-ID: <cover.1760037899.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patchset adds support for non-linear skbs when running tc programs
with BPF_PROG_TEST_RUN.

We've had multiple bugs in the past few years in Cilium caused by
missing calls to bpf_skb_pull_data(). Daniel suggested this new
BPF_PROG_TEST_RUN flag as a way to uncover these bugs in our BPF tests.

Changes in v8:
  - Fix uninitialized data pointer spotted by Martin.
  - Error out in test_loader if __linear_size tag is used on unsupported
    program types.
Changes in v7:
  - Refactor use of 'size' variable as suggested by Martin.
  - Support copying back the non-linear area to data_out.
  - Minor code changes for readability, suggested by Martin.
Changes in v6:
  - Disallow non-linear skb in prog_run_skb only for LWT programs
    instead of all non-L2 program types, on suggestion from Martin.
  - Reject non-null ctx->data and ctx->data_meta, as suggested by Amery.
  - Bound linear_size to 'PAGE_SIZE - headroom - tailroom' to be
    consistent with prog_run_xdp, as suggested by Martin.
  - Allocate exactly linear_size bytes in bpf_test_init, spotted by
    Martin.
  - Fix wrong conflict resolution on double-free fix, spotted by Amery.
  - Rebased.
Changes in v5:
  - Fix double free on data in first patch.
Changes in v4:
  - Per Martin's suggestion, follow the XDP code pattern and use
    bpf_test_init only to initialize the linear area. That way data is
    directly copied to the right areas and we avoid the call to
    __pskb_pull_tail.
  - Fixed outdated commit descriptions.
  - Rebased.
Changes in v3:
  - Dropped BPF_F_TEST_SKB_NON_LINEAR and used the ctx->data_end to
    determine if the user wants non-linear skb, as suggested by Amery.
  - Introduced a second commit with a bit of refactoring to allow for
    the above requested change.
  - Fix bug found by syzkaller on third commit.
  - Rebased.
Changes in v2:
  - Made the linear size configurable via ctx->data_end, as suggested
    by Amery.
  - Reworked the selftests to allow testing the configurable linear
    size.
  - Fix warnings reported by kernel test robot on first commit.
  - Rebased.

Paul Chaignon (5):
  bpf: Refactor cleanup of bpf_prog_test_run_skb
  bpf: Reorder bpf_prog_test_run_skb initialization
  bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN
  selftests/bpf: Support non-linear flag in test loader
  selftests/bpf: Test direct packet access on non-linear skbs

 net/bpf/test_run.c                            | 143 +++++++++++++-----
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   4 +
 .../bpf/progs/verifier_direct_packet_access.c |  59 ++++++++
 tools/testing/selftests/bpf/test_loader.c     |  29 +++-
 4 files changed, 193 insertions(+), 42 deletions(-)

-- 
2.43.0


