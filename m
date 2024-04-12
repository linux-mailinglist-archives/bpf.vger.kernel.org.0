Return-Path: <bpf+bounces-26673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C5A8A37BA
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABACF28157C
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071EF14F9DA;
	Fri, 12 Apr 2024 21:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBjox0Pt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE3814A89;
	Fri, 12 Apr 2024 21:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956571; cv=none; b=svFoeu5ltTc4ThCoNi2TSFfihjBKYd9ZPYVL0uL+iTI4Cxo+xya6WCfuqBaK8epMnkWc042l94AnuZSR6ksqFdKjX2fQApzIgWSi+f29TE9ZTvtkC2Nh0gtxCHDpGIoZ4psPkyIv7zrY5e2UErRdQne4xaMKquQvelAbt41gGAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956571; c=relaxed/simple;
	bh=6vmNIqVgq7i86lFZlqoO9YBC5I+VZKyvjvuxU+kLBXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H2xXtPKjMQbKn+byAzvh4DhDigTYncFPjJuc8MuHWLJLHXbwAI0m4ulra7fyS0D95bf2qvW9zMfW2Y8Xg0DCIkXPFxMhIRg9Cf6pDgqWZrVmIb5CDu9P0whzMXxEwcvmkqqGY+mgZTamA5vFD5P6BItO2rMIuY8CbPZwxIqdbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBjox0Pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0A6C113CC;
	Fri, 12 Apr 2024 21:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712956571;
	bh=6vmNIqVgq7i86lFZlqoO9YBC5I+VZKyvjvuxU+kLBXU=;
	h=From:To:Cc:Subject:Date:From;
	b=SBjox0PtT63CMC1tZkQAr0r5cpITGkJlYySFP44i62PLIuilLS2Nb+fsgyNjMuyyc
	 m5KrDbOuvIRJ5yIvEgLYlfeK3xCyrnWfGbqrsGevYu04WT5U1nR6NQ9gUNcYQ1j9MZ
	 +Ac9UW5/e5SPy/DE15euY+bdDZEjdjQfxuZl0Jf2XDym1mPvjJi5RtFthZ2tdPDeWS
	 Fv6iPdHJbDTWSAJGmm+jVGW75P0aVW3QKpOqzJ/muP7FRnxRdk8gO3pq3EdjwIEoOB
	 Ty4MTKREy1WwEQNsttOSUHUm12iiDjgeqJ8bhkWu0SSCX/cQ4Vz45dk2FE0g/esrKE
	 u4XglbmyxSdWw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Kui-Feng Lee <kuifeng@fb.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH 00/12] 
Date: Fri, 12 Apr 2024 18:15:52 -0300
Message-ID: <20240412211604.789632-1-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

   	This allows us to have reproducible builds while keeping the
DWARF loading phase in parallel, achieving a noticeable speedup as
showed in the commit log messages.

- Arnaldo

v2: Don't delete the CUs after encoding BTF for them, we may still have
still references to them from the BTF encoder, as noticed by Alan
Maguire.


Arnaldo Carvalho de Melo (12):
  core: Allow asking for a reproducible build
  pahole: Disable BTF multithreaded encoded when doing reproducible
    builds
  dwarf_loader: Separate creating the cu/dcu pair from processing it
  dwarf_loader: Introduce dwarf_cus__process_cu()
  dwarf_loader: Create the cu/dcu pair in dwarf_cus__nextcu()
  dwarf_loader: Remove unused 'thr_data' arg from
    dwarf_cus__create_and_process_cu()
  core: Add unlocked cus__add() variant
  core: Add cus__remove(), counterpart of cus__add()
  dwarf_loader: Add the cu to the cus list early, remove on LSK_DELETE
  core/dwarf_loader: Add functions to set state of CU processing
  pahole: Encode BTF serially in a reproducible build
  tests: Add a BTF reproducible generation test

 dwarf_loader.c              | 73 ++++++++++++++++++++++++---------
 dwarves.c                   | 62 +++++++++++++++++++++++++++-
 dwarves.h                   | 17 ++++++++
 pahole.c                    | 81 +++++++++++++++++++++++++++++++++++--
 tests/reproducible_build.sh | 56 +++++++++++++++++++++++++
 5 files changed, 265 insertions(+), 24 deletions(-)
 create mode 100755 tests/reproducible_build.sh

-- 
2.44.0


