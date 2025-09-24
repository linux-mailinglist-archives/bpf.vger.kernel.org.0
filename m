Return-Path: <bpf+bounces-69618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0618DB9C3FB
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 23:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A53327144
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 21:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321CA281370;
	Wed, 24 Sep 2025 21:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HatGGRro"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ECB25B1CE;
	Wed, 24 Sep 2025 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748564; cv=none; b=aSy2OsJrk7TjNQeuScdW96c+6Z4zTMKB7d3pBcyr4g98fgOQ6V9Ev4tWncU+wC0FZwQmB2jxSj+l9FtqBTCXPN5/7y59zAvIxyPtJpZbH6aC2fWU1i9DYiBK+rp9TuXCFTi+eDoqkVfIwkZ0eA/oLRENjmQ41mLVeyXWvmzmsSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748564; c=relaxed/simple;
	bh=4+tjgcv1kcysAsBQl25lYPrEQGhq9dj0OORP1sz8UBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cu5klOHVvCZYJocpfmVYf4U3aThJHLtARtSct+f2Lfb/IbetShENGYsufE9fw0Fa+NTR4WSIfRFOlSp00kJalOVLMbjxqCTozF5nWtTVUaQDME0UJzQB/6ZGLA/wkKEyjRrzpsXhvgm2r78C41pYuyLKjSJdjbzQIAnWFW87DJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HatGGRro; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758748559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9PGwQHPnVpeQv56lh681eq2C/g3Am9ZKx7kA4WrGWTQ=;
	b=HatGGRroypv/k/ZBYvQ71/gLNpd2rGPmjlG6rEieX+rFD0CjG++jgGN/LnENxBIZ+b/lD1
	9R1/cSDxVDFZPBHjevX7F3oNaMIbw7sY7qVO4GFat9cYc3PjF3ScUhouDA+ZAVWSzk4rom
	fM68gsnjDrAeTIFaijwxZBUAhXBAC6M=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	tj@kernel.org,
	kernel-team@meta.com
Subject: [PATCH dwarves v1 0/2] btf_encoder: KF_IMPLICIT_PROG_AUX_ARG support
Date: Wed, 24 Sep 2025 14:15:10 -0700
Message-ID: <20250924211512.1287298-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series implements KF_IMPLICIT_PROG_AUX_ARG kfunc flag in pahole's
BTF encoding.

The kfunc flag indicates that the last argument of a BPF kfunc is a
pointer to struct bpf_prog_aux implicitly set by the verifier.

BTF function prototype of such a function must omit its last parameter
(expected to be of `struct bpf_prog_aux *` type), despite it being
present in the kernel declaration of the kfunc.

See also a the patch series for BPF:
"bpf: implicit bpf_prog_aux argument for kfuncs"

Ihor Solodrai (2):
  btf_encoder: refactor btf_encoder__add_func_proto
  btf_encoder: implement KF_IMPLICIT_PROG_AUX_ARG kfunc flag handling

 btf_encoder.c | 172 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 116 insertions(+), 56 deletions(-)

-- 
2.51.0


