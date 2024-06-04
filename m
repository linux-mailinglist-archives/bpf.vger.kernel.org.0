Return-Path: <bpf+bounces-31286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C408FA910
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 06:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23B91C23D55
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 04:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39CA839FC;
	Tue,  4 Jun 2024 04:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AarsC3oP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7DB38B
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 04:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717474236; cv=none; b=e2lw+79N0Xnfy/9IyN+MSgt6z/1TdVcmki8ZNRZPVq0rvoONdQLFlxg/dG2uzaEHBLAB7I7NO/WqWD474lF6MmDTjm1TndlVi3pl9zt7zbvG5edzGDNn69A3sy+yptOsrxISv0+vMTWPMWIP2Wec0zXlAaLs1UUPsSGs0KJixOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717474236; c=relaxed/simple;
	bh=r3FL0zQA3rbBPU+IEXv1YPPKsX27K530D26YjN2VVCk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YuHScKi21wgu952S2mJbLaip6kqG+1lfFGUTJpSll4rC/7CEsILYIKUhtbrZBbMnQ5ddqIz1+nsvBX1YewP/yG5M3fIQHs6rvd2IQ9bSRMFgqTAAa9wfk+3CSS5QcVMJd7txaXSx8xi5iGULWAPfRkmOmJCt0IATzTZedd+vTJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AarsC3oP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72CA5C3277B;
	Tue,  4 Jun 2024 04:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717474235;
	bh=r3FL0zQA3rbBPU+IEXv1YPPKsX27K530D26YjN2VVCk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AarsC3oPQhcZtwIG1VlovLStmo2WaZqUz2Dzjtsnv5oXQlgpuFUMZvvltfaYsr3km
	 QWP1lJ9B3r3zVdoBOG/gLEAQOtvIPT88tHrKR7go6KfR4BBmTW7lCyOgPWQ2qc/qFM
	 7S6BAmaCoRkzsICmWHE8VrWjQx3t6bnTL6oW8mpi6EGTsIHau+zzUIvYFkKJmxODgH
	 m047UdYcKlRYiDkzarz63THhAUrNhHK8/dvMKsFDNmHSUszAM3no0ZC+IgxElyUd3U
	 AVQSHoFgoKEa1UcCKovx38fBnvMq9toGegzyVrNEH1xF66fXcGLbUdytywDdxGLisL
	 R6zc9c/JySNdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CB92CF21FD;
	Tue,  4 Jun 2024 04:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/9] Enable BPF programs to declare arrays of
 kptr, bpf_rb_root, and bpf_list_head.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171747423536.12524.18107918763541831213.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jun 2024 04:10:35 +0000
References: <20240523174202.461236-1-thinker.li@gmail.com>
In-Reply-To: <20240523174202.461236-1-thinker.li@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
 sinquersw@gmail.com, kuifeng@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 23 May 2024 10:41:53 -0700 you wrote:
> Some types, such as type kptr, bpf_rb_root, and bpf_list_head, are
> treated in a special way. Previously, these types could not be the
> type of a field in a struct type that is used as the type of a global
> variable. They could not be the type of a field in a struct type that
> is used as the type of a field in the value type of a map either. They
> could not even be the type of array elements. This means that they can
> only be the type of global variables or of direct fields in the value
> type of a map.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/9] bpf: Remove unnecessary checks on the offset of btf_field.
    https://git.kernel.org/bpf/bpf-next/c/c95a3be45ad2
  - [bpf-next,v7,2/9] bpf: Remove unnecessary call to btf_field_type_size().
    https://git.kernel.org/bpf/bpf-next/c/482f7133791e
  - [bpf-next,v7,3/9] bpf: refactor btf_find_struct_field() and btf_find_datasec_var().
    https://git.kernel.org/bpf/bpf-next/c/a7db0d4f872a
  - [bpf-next,v7,4/9] bpf: create repeated fields for arrays.
    https://git.kernel.org/bpf/bpf-next/c/994796c0256c
  - [bpf-next,v7,5/9] bpf: look into the types of the fields of a struct type recursively.
    https://git.kernel.org/bpf/bpf-next/c/64e8ee814819
  - [bpf-next,v7,6/9] bpf: limit the number of levels of a nested struct type.
    https://git.kernel.org/bpf/bpf-next/c/f19caf57d80f
  - [bpf-next,v7,7/9] selftests/bpf: Test kptr arrays and kptrs in nested struct fields.
    https://git.kernel.org/bpf/bpf-next/c/c4c6c3b785a0
  - [bpf-next,v7,8/9] selftests/bpf: Test global bpf_rb_root arrays and fields in nested struct types.
    https://git.kernel.org/bpf/bpf-next/c/d55c765a9b2d
  - [bpf-next,v7,9/9] selftests/bpf: Test global bpf_list_head arrays.
    https://git.kernel.org/bpf/bpf-next/c/43d50ffb1f7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



