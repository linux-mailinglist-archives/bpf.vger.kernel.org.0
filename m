Return-Path: <bpf+bounces-38748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0259692CB
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 06:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4915CB23A5A
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 04:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB76A1CDFD8;
	Tue,  3 Sep 2024 04:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ItgEBhXO"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF71CDFAC
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 04:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725336651; cv=none; b=n+DE3Z1CmCuojCi4z7acS3DZ94Y0mh/Wrxl8c6+5jImC0K78dFCMX4JXIpaYNdatI/+JB42trfGQ4UgPnChg68zqUpPTAcz9ScrNifDuc8K6yuqPhQs7fOtU9y5JAKzzAdeouZs33pJi8Dg7akbozcK7OYRPnFl0Ia8rztK00jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725336651; c=relaxed/simple;
	bh=8u+i/aP0QJOBFmV+ftpdyw/vtFMxz4xpMsTuqrE8Phw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Kq8EdUqk45iVx8HQIds7uwXE+glcEXI5F7YIr++05QoHpUFhMtYuGLngDY2DzTNZmdatQ1JGRoGq5S8uqy2z0VN6sFIu7FxkdpMV7YafScbI9QUICv3s1oRLyy2/HFyKOnFmEjdSNccOpS7IGyjvZmik0seT3poLmJ/8g1MmHMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ItgEBhXO; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ac144cc8-db10-47ea-b364-c9ebf2fe69d3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725336646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J620BQsZ8Agk/ZdRV2noxzyhchyR8gvllTSAnEpvMQQ=;
	b=ItgEBhXO2YVGWMoemf3dxZQNYaQXMhm8JleuLqkr9zfk8hPhuFWLBUmat1YZ8hyHY9geaF
	RWcFVcbrCrJQsbTykj23XT8OAwouLRsaEzpEyRg9ZC3Ix0gZw0wxgiib17V0e51FrRa/RL
	NVO7Su1nR53x04fwueegNwpftY1mBII=
Date: Mon, 2 Sep 2024 21:10:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
Subject: Change default cpu version from v1 to v3 in llvm20
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

Suggested by Alexei, I put a llvm20 diff to make cpu=v3 as the default
cpu version:
    https://github.com/llvm/llvm-project/pull/107008

cpu=v3 has been introduced in llvm9 (2019 H2) and the kernel cpu=v3
support should be available around the same time although I
cannot remember the exact kernel version.

There are two motivation to move cpu version default from v1 to v3.

First, to resolve correct usage of code like
    (void)__sync_fetch_and_add(&ptr, value);
In cpu v1/v2, the above insn generates locked add insn, and
for cpu >= v3, the above insn generates atomic_fetch_add insn.
The atomic_fetch_add insn is the correct way for the eventual
insn for arm64. Otherwise, with locked add insn in arm64,
proper barrier will be missing and incorrect results may
be generated.

Second, cpu=v3 should have better performance than cpu=v1
in most cases. In Meta, several years ago, we have conducted
performance evaluation to compare v1 and v3 for major bpf
programs running in our platform and we concluded v3 is
better than v1 in most cases and in other rare cases v1 and v3
have the same performance. So moving to v3 can help
performance too.

If in rare cases, e.g. really old kernels, v1/v2 is the only
option, then users can set -mcpu=v1 explicitly.

Please let us know if you still have some concerns in your
setup w.r.t. cpu v1->v3 transition.

Thanks,

Yonghong


