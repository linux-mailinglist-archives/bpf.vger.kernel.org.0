Return-Path: <bpf+bounces-72614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE718C1665B
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 19:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08C63AF10A
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 18:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4170E34DB41;
	Tue, 28 Oct 2025 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKZMYP9O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53FA339B4F;
	Tue, 28 Oct 2025 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675033; cv=none; b=GVi7Y0cDBubyRDwj0akZ/+8hNdJ85g5+J+b0MnBi7aDcKVkZQSTbk/7mVR71J3Jft8KXWHdhrcscS1gM6Wl6NBCVscPN/BIZcQducBXKPSLmPEuzeFvPxwd1Cf4eqbvpACaZJ87o02jsh8rQUhfn+PbCl5+W3Vt8LE6u7+wWDRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675033; c=relaxed/simple;
	bh=SLMn/3kc2g3NeIOgAlNAgfQ8H1b43hukpaDYyxjJrak=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N8C4AgdFlDnXAOVa+4/LjlSV1a4tv44XSzayH32e31raK8oiCUikPgOiUEFBdFjqmOtdlwJYyaJqnfak4+QrX4Ns/RLuOA051biYax00C+303V4T5shzoc7+k3O7O1JKdSpP/We+HlQpt8vKOS4Es/OydmgIHiehHHxbtYDEwUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKZMYP9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444DCC4CEE7;
	Tue, 28 Oct 2025 18:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761675033;
	bh=SLMn/3kc2g3NeIOgAlNAgfQ8H1b43hukpaDYyxjJrak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NKZMYP9OtLUDDEsANcwMnxgFNC4pH0DS+vl+etxEK2rlEg/rPXqea7IWmo3bh99Y3
	 QOZHik1UvwALmnoBO07Ohd5ueh1q2MMNAYq2cez4mrsJiUp25tMP6A/DauqxeWnhsZ
	 VgWNMF45nnit7iroegIqifYz+qddBmE9lD/GpxQBK1F5saf4pBqsoV8vXr5O1JdCPv
	 9+FPs11Jzh36ZEFS59IpUxJDkdhb6lfAWID4KSk2WvWnmsIpg3kcZsgsdQhD3nrqhG
	 vLoPvaRhxoJXPTJkDKysk59vrScAdDB9rFTFWBDK0T6FeO9Q7VZ3L71qSxsl0N0PNK
	 HLknJ3/t/HRiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DF539EFA72;
	Tue, 28 Oct 2025 18:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/4] bpf: Free special fields when update hash and
 local storage maps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176167501101.2338015.15567107608462065375.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 18:10:11 +0000
References: <20251026154000.34151-1-leon.hwang@linux.dev>
In-Reply-To: <20251026154000.34151-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 memxor@gmail.com, linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun, 26 Oct 2025 23:39:56 +0800 you wrote:
> In the discussion thread
> "[PATCH bpf-next v9 0/7] bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for percpu maps"[1],
> it was pointed out that missing calls to bpf_obj_free_fields() could
> lead to memory leaks.
> 
> A selftest was added to confirm that this is indeed a real issue - the
> refcount of BPF_KPTR_REF field is not decremented when
> bpf_obj_free_fields() is missing after copy_map_value[,_long]().
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/4] bpf: Free special fields when update [lru_,]percpu_hash maps
    https://git.kernel.org/bpf/bpf-next/c/f6de8d643ff1
  - [bpf,v3,2/4] bpf: Free special fields when update hash maps with BPF_F_LOCK
    https://git.kernel.org/bpf/bpf-next/c/c7fcb7972196
  - [bpf,v3,3/4] bpf: Free special fields when update local storage maps
    (no matching commit)
  - [bpf,v3,4/4] selftests/bpf: Add tests to verify freeing the special fields when update hash and local storage maps
    https://git.kernel.org/bpf/bpf-next/c/d5a7e7af14cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



