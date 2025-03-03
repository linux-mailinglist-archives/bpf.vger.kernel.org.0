Return-Path: <bpf+bounces-53106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE34AA4CB7B
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 20:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9683ABF90
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 18:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F30F22FAC3;
	Mon,  3 Mar 2025 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5M2YMHe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966E5217F54;
	Mon,  3 Mar 2025 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028398; cv=none; b=K5NDuc++8N+w0fxk/qPU4PY7YLKHL8uibB0IS8jeDhILKj8/axQC8NvbaOZ3KoSOykckxVUhCcAsjXM6jlu2XHt5xA3e/YW9e7lgAnNUTpw+yIHI5Z5Pe7g/MSmDKhEr/aWT9vrQxjrZLV5QnLgd2NXQfsokaaN4gDya6lkUpRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028398; c=relaxed/simple;
	bh=Gp5b4c1zf97/draGEaY8yH71AhQTNUbCkCfT2p04Ckc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FYMyl0mkiu/UkChYsj5I4/hCUdyuHI4iLVgmJfWYhfqiWm78OZcOodYd7MaWePsz1OhHwpdoLU5wxsV05bZrFK0NEp7qhM/bGU7UCivbnNQ0eX8DKuEAyrn9Qz4hSVYMYuhs4MBr+UlKxJc/PolSPhKg6p9C+M6neO83Ttx6xQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5M2YMHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128A5C4CED6;
	Mon,  3 Mar 2025 18:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741028398;
	bh=Gp5b4c1zf97/draGEaY8yH71AhQTNUbCkCfT2p04Ckc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q5M2YMHe2LJCMAbfg7cXsul2vfgCw+jK6xbaoDHy22zAQaeRbjIZEptLtF5zMYf2C
	 NI7lQsAuXzCRPPtzU7mkqF8IW3uvEJUESZyhXBOQnhz7bu+jsMeTL/Vuau/sq4Qy4J
	 n6h2XyRXx/tOQNduulh93PuocfF1B2AgiKHgtrSI05RAhObY7hep2TIxQ9Vc6Kv6C7
	 GGKJmVYricZwzhj/TFjAKEaZWiRoHfV2MYIOnPnciB6l8WrlNMfYhjvV6m6uyFXySN
	 pjF4vfPXj87/eo0t/8HnVzmsCUBpPMRXg/WAHewjVtACWEjqKC+yrXBDgXwMySrGMP
	 EspRmDXAUFzYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEF23809A8F;
	Mon,  3 Mar 2025 19:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 00/10] Introduce load-acquire and store-release
 BPF instructions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174102843076.3686766.17440507185363251083.git-patchwork-notify@kernel.org>
Date: Mon, 03 Mar 2025 19:00:30 +0000
References: <cover.1740978603.git.yepeilin@google.com>
In-Reply-To: <cover.1740978603.git.yepeilin@google.com>
To: Peilin Ye <yepeilin@google.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bpf@ietf.org,
 ast@kernel.org, xukuohai@huaweicloud.com, eddyz87@gmail.com,
 void@manifault.com, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, corbet@lwn.net, paulmck@kernel.org,
 puranjay@kernel.org, iii@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 catalin.marinas@arm.com, will@kernel.org, qmo@kernel.org, mykolal@fb.com,
 shuah@kernel.org, ihor.solodrai@linux.dev, longyingchi24s@ict.ac.cn,
 joshdon@google.com, brho@google.com, neelnatu@google.com, bsegall@google.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  3 Mar 2025 05:36:27 +0000 you wrote:
> Hi all!
> 
> This patchset adds kernel support for BPF load-acquire and store-release
> instructions (for background, please see [1]), including core/verifier,
> arm64/x86-64 JIT compiler and Documentation/ changes, as well as
> selftests.  riscv64 is also planned to be supported.  The corresponding
> LLVM changes can be found at:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,01/10] bpf/verifier: Factor out atomic_ptr_type_ok()
    https://git.kernel.org/bpf/bpf-next/c/b2d9ef71d4c9
  - [bpf-next,v4,02/10] bpf/verifier: Factor out check_atomic_rmw()
    https://git.kernel.org/bpf/bpf-next/c/d430c46c7580
  - [bpf-next,v4,03/10] bpf/verifier: Factor out check_load_mem() and check_store_reg()
    https://git.kernel.org/bpf/bpf-next/c/d38ad248fb7a
  - [bpf-next,v4,04/10] bpf: Introduce load-acquire and store-release instructions
    (no matching commit)
  - [bpf-next,v4,05/10] arm64: insn: Add BIT(23) to {load,store}_ex's mask
    (no matching commit)
  - [bpf-next,v4,06/10] arm64: insn: Add load-acquire and store-release instructions
    (no matching commit)
  - [bpf-next,v4,07/10] bpf, arm64: Support load-acquire and store-release instructions
    (no matching commit)
  - [bpf-next,v4,08/10] bpf, x86: Support load-acquire and store-release instructions
    (no matching commit)
  - [bpf-next,v4,09/10] selftests/bpf: Add selftests for load-acquire and store-release instructions
    (no matching commit)
  - [bpf-next,v4,10/10] bpf, docs: Update instruction-set.rst for load-acquire and store-release instructions
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



