Return-Path: <bpf+bounces-67558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C749B45932
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 15:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4B7A60901
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 13:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F281B352FC6;
	Fri,  5 Sep 2025 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mL4Vl3mW"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27951352FF3
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079165; cv=none; b=pltp7OZMGnwtyfJ6i+D/3rvwJ075BKmSK/OVWz66vFFYbajLodKIN9PtIanHuavXc20t2RZILr/wNngUuL9Es7I+MRHx3MXjU85U8bXvA0IwDVJrYCxAXQNTXdKvApdDouvcp1ZZ2zSZsJNG7LbEL5ahqLwJatEVeMFef7L1bZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079165; c=relaxed/simple;
	bh=p6YT3S3VpFntw3ltRi+MO1cKuvTh+SOV6U2poojX+Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ktCe+RprZOzplTiMZmcLOBkSI79/+RUIFXdazF/1XXUKLfvLeDfqATJHfXJiOhzRe149bqDNxNPgBQR0mjMMZEZsLR4dGIApAkTVcxAxwwwvJr8hGI7hyL9mz8EfKdh1Ak8u1eM5mqfZGP5xnAxea8ISxMGzaceosb7dZRezcF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mL4Vl3mW; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757079161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=akShWS2OzWyatfBn9MCQSZid0gdW7PM6cWZQcbC9JZw=;
	b=mL4Vl3mW/V/3+nQPgfXqLspIII+ALXfiFjbZRFflXd/WCyP6T3i4WeCgLaawR4lBc6+bZg
	hAIlYz40/o+EEfK9SghZXOSNhKsSJVFPuof+5+er/9jh5bKpsn+CG9tzMibpuND4JFtJvW
	kuPnZOvKMl06GFpAO3Wla8TGAqymG9g=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/2] bpf: Support fentry/fexit for functions with union args
Date: Fri,  5 Sep 2025 21:32:24 +0800
Message-ID: <20250905133226.84675-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

While tracing 'release_pages' with bpfsnoop[0], the verifier reports:

The function release_pages arg0 type UNION is unsupported.

However, it should be acceptable to trace functions that have 'union'
arguments.

This patch set enables such support in the verifier by allowing 'union'
as a valid argument type.

Links:
[0] https://github.com/bpfsnoop/bpfsnoop

Leon Hwang (2):
  bpf: Allow tracing union-arg functions
  selftests/bpf: Add test to access union argument in tracing program

 kernel/bpf/btf.c                                   |  4 ++--
 net/bpf/test_run.c                                 | 14 +++++++++++++-
 .../selftests/bpf/progs/verifier_btf_ctx_access.c  | 12 ++++++++++++
 3 files changed, 27 insertions(+), 3 deletions(-)

--
2.50.1


