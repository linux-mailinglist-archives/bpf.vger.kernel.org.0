Return-Path: <bpf+bounces-22297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A9C85B754
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 10:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B360B22724
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 09:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5115FEED;
	Tue, 20 Feb 2024 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TqKIznuo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B72D5FDC5
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421243; cv=none; b=QtQdFUiKUw+ZWjLgeS0nn3ZuSflks42XNgYYw4ca61E9rOAIFj3b8kuFdVYTop97OoSWC0K/L3a8frDkyRy8U7utefPMixVoGHehh0r3WhFdgU1i66onlX4zwBaK4aGLLDI06LTQEykChK1tDJMOLqiQaNFTgG/q0hTSivlege0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421243; c=relaxed/simple;
	bh=kcSwDMjQ4HwXRXDe7nNAi5ffp6zgzfbhOceAg8MaAFU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T59aldB9lF/TkKiTcSJc8IEaoz6gqbuIkmrrJmA2Kj3q2MNgPf3M/fdVyzVq2KIj9OSIXkdkOyCGLPPesMkDAx45Sodzk+MZBtt2CKQYrPUdZrY0kE7+7E5DzC8AbSF1vmSjvSzc+oJByVRdIMPEShtjJj4M2I8Yljr2+ef8T3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TqKIznuo; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563d56ee65cso4917962a12.2
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 01:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708421240; x=1709026040; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hp2TuWu2HbbWzt6t/Ms6hSusaZxhHf6cH//9t+dYHaA=;
        b=TqKIznuofWcwUUivYjnZROHEFKMVi+8Cg6y7+7i4ypf2zJ4J6X2jb8AdccFgy0esHG
         fehcpnT/k0mBZGBVnG69iKp0ylPXH4LMEKu3Nl+zggS48/4HQ9mtotq8v5b/qKz3cjjC
         QxzZ5guDK4rohFYXEEohJy5Lu6lEOsErC0u73OATTwjLkEeW7sdIzwcIaZ196OOXUdRq
         5Vj4F5C1/VLP6NOX2FkZCvoqe6FtY/KQiRulAVWTzOeDR9SvARBXNBVXJ88s2RjyCnmP
         ngIirysRIjxv6/OiPK5Yg1imejhLlxjgRag+sPeV+ShpcYr2e/dU4JM/ZiIu+UarJf+c
         0N/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421240; x=1709026040;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hp2TuWu2HbbWzt6t/Ms6hSusaZxhHf6cH//9t+dYHaA=;
        b=t0wi1scLR073/IvkElG6AYq55yLzMrRW6dEiEDsans3KL63sPEiN89UxIy9qTbMf4C
         VE5EANx9ZFlM7cAb2gNykoM/mnvEnPcGww+xIuDikLTPOR5wbyzEcGMW2qfFFS1Ep03C
         a9f00bcmWhXIJKDthY6uEdOnYWthaNTLlNv9TntAfflrNwVchASjuGlmE/zIiwbxBcbh
         pUDrD+7qsPp5K9B1gkG0uDt7Zy++XN7kyxax09Yd79auGRsBMEhll+elwTFv+OcUTQNl
         GAb5uUhAdWtf9jKTMX//80ocN+QDPJwQ2BmDY/VmnC5nbnTse/vEfzwhZxzh2nnfZ28w
         N0TA==
X-Gm-Message-State: AOJu0YzVbabqOln6mspCfxLlD2qi1XvH8BdGjIFxv6hEp2ASrok75+Lm
	/c/4daSxIhRQ6v77ASIo6sjYTAIKWFMC1eisodS7Bwv27Kwuq/G2DnQqwJ1UP5W7aqyLnSz+4Ca
	KwQ==
X-Google-Smtp-Source: AGHT+IFeB+mh4ygCJyvjBo5cQ9e7OvA6Pdq01PX8Ja4typ3tr+wDucWBaMq8mY0bnpXSck8WivflVg==
X-Received: by 2002:a05:6402:2812:b0:563:c54e:ee with SMTP id h18-20020a056402281200b00563c54e00eemr14001224ede.2.1708421239790;
        Tue, 20 Feb 2024 01:27:19 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id y5-20020aa7d505000000b0056200715130sm3458526edq.54.2024.02.20.01.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:27:19 -0800 (PST)
Date: Tue, 20 Feb 2024 09:27:14 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next 00/11] bpf: probe-read bpf_d_path() and add new
 acquire/release BPF kfuncs
Message-ID: <cover.1708377880.git.mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On a number of occasions [0, 1, 2], usage of the pre-existing BPF
helper bpf_d_path() under certain circumstances has led to memory
corruption issues.

This patch series intends to address bpf_d_path()'s susceptibility to
such memory corruption issues by fundamentally swapping out the
underlying bpf_d_path() implementation such that it makes use of
probe-read semantics. Enforcing probe-read semantics onto bpf_d_path()
however doesn't come without it's own set of limitations. Therefore,
to overcome such limitations, this patch series also adds new BPF
kfunc based infrastructure which ultimately allows BPF program authors
to adopt a safer and true implementation of d_path() moving forward
which is fundamentally backed by KF_TRUSTED_ARGS semantics.

[0] https://lore.kernel.org/bpf/CAG48ez0ppjcT=QxU-jtCUfb5xQb3mLr=5FcwddF_VKfEBPs_Dg@mail.gmail.com/
[1] https://lore.kernel.org/bpf/20230606181714.532998-1-jolsa@kernel.org/
[2] https://lore.kernel.org/bpf/20220219113744.1852259-1-memxor@gmail.com/

Matt Bobrowski (11):
  bpf: make bpf_d_path() helper use probe-read semantics
  bpf/selftests: adjust selftests for BPF helper bpf_d_path()
  bpf: rename fs_kfunc_set_ids to lsm_kfunc_set_ids
  bpf: add new acquire/release BPF kfuncs for mm_struct
  bpf/selftests: add selftests for mm_struct acquire/release BPF kfuncs
  bpf: add new acquire/release based BPF kfuncs for exe_file
  bpf/selftests: add selftests for exe_file acquire/release BPF kfuncs
  bpf: add acquire/release based BPF kfuncs for fs_struct's paths
  bpf/selftests: add selftests for root/pwd path based BPF kfuncs
  bpf: add trusted d_path() based BPF kfunc bpf_path_d_path()
  bpf/selftests: adapt selftests test_d_path for BPF kfunc
    bpf_path_d_path()

 fs/Makefile                                   |   6 +-
 fs/probe_read_d_path.c                        | 150 +++++++++++
 include/linux/probe_read_d_path.h             |  13 +
 kernel/trace/bpf_trace.c                      | 249 ++++++++++++++++--
 .../testing/selftests/bpf/prog_tests/d_path.c | 182 +++++++++++--
 .../selftests/bpf/prog_tests/exe_file_kfunc.c |  49 ++++
 .../selftests/bpf/prog_tests/mm_kfunc.c       |  48 ++++
 .../selftests/bpf/prog_tests/path_kfunc.c     |  48 ++++
 .../selftests/bpf/progs/d_path_common.h       |  34 +++
 .../bpf/progs/d_path_kfunc_failure.c          |  66 +++++
 .../bpf/progs/d_path_kfunc_success.c          |  25 ++
 .../bpf/progs/exe_file_kfunc_common.h         |  23 ++
 .../bpf/progs/exe_file_kfunc_failure.c        | 181 +++++++++++++
 .../bpf/progs/exe_file_kfunc_success.c        |  52 ++++
 .../selftests/bpf/progs/mm_kfunc_common.h     |  19 ++
 .../selftests/bpf/progs/mm_kfunc_failure.c    | 103 ++++++++
 .../selftests/bpf/progs/mm_kfunc_success.c    |  30 +++
 .../selftests/bpf/progs/path_kfunc_common.h   |  20 ++
 .../selftests/bpf/progs/path_kfunc_failure.c  | 114 ++++++++
 .../selftests/bpf/progs/path_kfunc_success.c  |  30 +++
 .../testing/selftests/bpf/progs/test_d_path.c |  20 +-
 .../bpf/progs/test_d_path_check_rdonly_mem.c  |   6 +-
 .../bpf/progs/test_d_path_check_types.c       |   6 +-
 23 files changed, 1396 insertions(+), 78 deletions(-)
 create mode 100644 fs/probe_read_d_path.c
 create mode 100644 include/linux/probe_read_d_path.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exe_file_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mm_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/path_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/d_path_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/d_path_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/d_path_kfunc_success.c
 create mode 100644 tools/testing/selftests/bpf/progs/exe_file_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/exe_file_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/exe_file_kfunc_success.c
 create mode 100644 tools/testing/selftests/bpf/progs/mm_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/mm_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/mm_kfunc_success.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/path_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_kfunc_success.c

-- 
2.44.0.rc0.258.g7320e95886-goog

/M

