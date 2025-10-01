Return-Path: <bpf+bounces-70170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024B3BB2046
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 00:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9614E3A4122
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 22:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE26829B79B;
	Wed,  1 Oct 2025 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkVUyfEc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED1E23505E
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759359015; cv=none; b=T1AHTcGSC78HslecaiKdjghgETylpP2MI3TfAd/bAyrF+cY0+IjibVYkKIqZE1P7IX0cIuziIQPsNi+kVEEtV6h6CkFjgEOipjW1i8Zu/UBKIoxMf/12sjm5WaTlevFqz2dvirZbZmiooPNgURGAr160XP5WWpm6q7fRcB6h/kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759359015; c=relaxed/simple;
	bh=JELwX0igPHWI0YJAZBECaMcxL9pZjasrCYTobZC1bCg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jrzsgG/QvES5/ZyTl0yEUyOFwf1Q+or2gfyp8yj5Eu9OgVUMi+D1o4mbH5RTpF4kmi6W9kHTC4lgM28IuRszZDA3UgzofjeHoPzB6csUTxhmypFeD5IIEgqO6xnfpyuJNKiG5m/ASrS97p6hX1j7Z6T77YyhqXRsChDce7Yz6eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkVUyfEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9515C4CEF1;
	Wed,  1 Oct 2025 22:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759359013;
	bh=JELwX0igPHWI0YJAZBECaMcxL9pZjasrCYTobZC1bCg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JkVUyfEc/QgnXesMt/Y921G+egz7tP+d1m+DeT6HRf7nDp9/8vWn7ARQvs1EAcOdR
	 +OwD2UCv7bdso4QEvOE3T/NdBjeKC/MgR5CZE92+y10qttaZZHghr797F3Agith/+K
	 D26KCB/t5OvHiExG8Uo0B56uVFwclZ/pXqKuCbfa7Kqp8xXaE3JLmglDS553Y3SWde
	 Nnm+J6GXzHsdz5XI6rvL++piSV144y6uRICXYmqn+NxcGX/YUg7UEf+vR2++TWdO3x
	 mBNH7Crf+tDyeRFDBbahw++weaL0xE1MpDRK1+UyJ/LJjhB3QOMohqSRHr8XcMYGmP
	 ABWAuX5aYkENQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C9E39EE03D;
	Wed,  1 Oct 2025 22:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Correctly reject negative offsets for ALU ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175935900628.2646720.18191325542419116892.git-patchwork-notify@kernel.org>
Date: Wed, 01 Oct 2025 22:50:06 +0000
References: <tencent_70D024BAE70A0A309A4781694C7B764B0608@qq.com>
In-Reply-To: <tencent_70D024BAE70A0A309A4781694C7B764B0608@qq.com>
To: None <yazhoutang@foxmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 30 Sep 2025 23:04:33 +0800 you wrote:
> From: Yazhou Tang <tangyazhou518@outlook.com>
> 
> When verifying BPF programs, the check_alu_op() function validates
> instructions with ALU operations. The 'offset' field in these
> instructions is a signed 16-bit integer.
> 
> The existing check 'insn->off > 1' was intended to ensure the offset is
> either 0, or 1 for BPF_MOD/BPF_DIV. However, because 'insn->off' is
> signed, this check incorrectly accepts all negative values (e.g., -1).
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Correctly reject negative offsets for ALU ops
    https://git.kernel.org/bpf/bpf/c/55c0ced59fe1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



