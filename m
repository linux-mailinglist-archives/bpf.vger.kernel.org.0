Return-Path: <bpf+bounces-67212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF0EB40CF9
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 20:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A59561DCD
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 18:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E99734A33D;
	Tue,  2 Sep 2025 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p8P1hzXN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340622E2F1F
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837075; cv=none; b=IGbfMWh/enNy+nHtakfkOfzhyJufto59/zzEVKvSv7xmNN8a9qJfAAauJhEpKwl8w3yz6dlvl2+1Ib+KMQNzqEt/ZNkMgUagTCSyi06VNPb7y0fpodzqI1zOGD0RtaSeyyErmU6x/p0wnAFABo/Z/e1w7b0+o3I4alxcmZ25Xlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837075; c=relaxed/simple;
	bh=1pc5MJq/DOmEEO9qJbY5qbt8bUEssrESLh7t0NAJFuE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=OTGjYCEYaYP1aq2FfeQ5pMahPFPeeEMtN1tICIuBVWG9TePLv8VcH4qeesoxkkP94BTo1yW0SxiZmBNGBxz/23g59FixrHZwUXRBHDKgKWwcWZe4YNvQexZQ+Tt0pWlJ/uRoD7QaOEkwEYZ5J621k5C/io2QubFet9lCvpdPrHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p8P1hzXN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-325b2959306so9395715a91.0
        for <bpf@vger.kernel.org>; Tue, 02 Sep 2025 11:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756837073; x=1757441873; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NYRDGWUEa7FzMyNE6ErUXI1q4yIWe6EsYB+9O3a0jhc=;
        b=p8P1hzXNgyH5VaZ3q/Xa05sDfTIBRJ8gsBz5P3YKjWRtH/9NVktKVNhh86+WfJKAv/
         5Oly1SIi7MCiWZzg14d/D6CrxlU8AKCxcocIDpJ4sZbNCBgp9DgpEFbdporuijX5fy2e
         rOF0NEcVDdQ2+rkNYH5dggUYUXvEqj5QknSrXez6lX9id1EaCNuEBUEtCJ/zxNJYFpFH
         vkhurv5GAMQggfrvWAoK1TKbKs4ZO9WUUWCalQebcA0Ptn4QWBFrrIKc7H4Za0iJCvGO
         HWWwbgg4oSkhLgsaJI7dj8vTyOjDj9ofGOPPMbYSciFrvRnUy+KSVsg+Wox/8f0Pq0kg
         fUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756837073; x=1757441873;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYRDGWUEa7FzMyNE6ErUXI1q4yIWe6EsYB+9O3a0jhc=;
        b=CArbryc7sY25DISbIFrJa2TYSQumNldM1FPOHSe+PNFfLe3iUn4b8+0cQrxuJZ13+R
         je93nRhtdZk32I1dPoNpSfvPDSJfX5IyirD5M64h66iv28P80wTAsgMrPE0SQexTMCVW
         Zr5Pk4bsoP+TfxV4B81HhFkbjKtKQ+9NssfXIU2O3dR57VmVNrTiQmJRt+DPZiybACrH
         AC9aG8uVKa/q3U+Cr38tRkjZK4pvehn2fLihiPCfxbZhMOvYUDnh6OSdR9KTv3BdaZZc
         qmPuXyzpUFlwgIYMWstxmMqGRevoxJx6J4+XhPpgfEADdMncfPMxtQzp/FbtQ04Wx4dV
         VO3A==
X-Forwarded-Encrypted: i=1; AJvYcCUVeEVV5MzBrNQgnRGHGnpZj3rC/hsTZDp2dG4rPieGj8ox/7/G/TUpzS61q0XeMAZjubQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDHzQx7ye04lkvIdv7NTRJnNxc0xdq1mwmQ2j2a0rer8R+GOKz
	OJk8j80qGGUTJa0OXPDCx105qw4BwKUcaz+qUz+cb1oCbBbllHzuuk6W38gF9O2FpZhZpsoklZy
	SDyoWCwakoQ==
X-Google-Smtp-Source: AGHT+IEct/ZgBY5J6uSU7NxFc0iEGBl0tZPLIQ9NRRouOzI9G05tCQbxGLMxy1HPjR5iF2k6sMpYooV71Wel
X-Received: from pjbpt6.prod.google.com ([2002:a17:90b:3d06:b0:327:c20a:364])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2785:b0:31f:b51:eef9
 with SMTP id 98e67ed59e1d1-328156c5fbbmr19449455a91.17.1756837073381; Tue, 02
 Sep 2025 11:17:53 -0700 (PDT)
Date: Tue,  2 Sep 2025 11:17:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250902181713.309797-1-irogers@google.com>
Subject: [PATCH v1 0/3] Fix use-after-free race in bpf_prog_info synthesis
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Blake Jones <blakejones@google.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Dave Marchevsky <davemarchevsky@fb.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Howard Chu <howardchu95@gmail.com>, song@kernel.org, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"

The addition of more use of bpf_prog_info for gather BPF metadata in:
https://lore.kernel.org/all/20250612194939.162730-1-blakejones@google.com/
and the ever richer perf trace testing, such as:
https://lore.kernel.org/all/20250528191148.89118-1-howardchu95@gmail.com/
frequently triggered a latent perf bug in v6.17 when the perf and
libbpf updates came together. The bug would cause segvs and was reported here:
https://lore.kernel.org/lkml/CAP-5=fWJQcmUOP7MuCA2ihKnDAHUCOBLkQFEkQES-1ZZTrgf8Q@mail.gmail.com/

To fix the issue the 1st and 3rd patch are necessary. Both patches
address a race of either the sideband thread updating perf's state or
the kernel state changing over two system calls.

The use-after-free was introduced by:
https://lore.kernel.org/r/20241205084500.823660-4-quic_zhonhan@quicinc.com
The lack of failing getting the bpf_prog_info for changes in the
kernel was introduced in:
https://lore.kernel.org/r/20211011082031.4148337-4-davemarchevsky@fb.com

As v6.17 is currently actively segv-ing in perf test I'd recommend
these patches go into v6.17 asap.

When running the perf tests on v6.17 I frequently see less critical
test failures addressed in:
https://lore.kernel.org/all/20250821221834.1312002-1-irogers@google.com/

Ian Rogers (3):
  perf bpf-event: Fix use-after-free in synthesis
  perf bpf-utils: Constify bpil_array_desc
  perf bpf-utils: Harden get_bpf_prog_info_linear

 tools/perf/util/bpf-event.c | 39 ++++++++++++++++--------
 tools/perf/util/bpf-utils.c | 61 ++++++++++++++++++++++++-------------
 2 files changed, 66 insertions(+), 34 deletions(-)

-- 
2.51.0.355.g5224444f11-goog


