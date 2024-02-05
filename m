Return-Path: <bpf+bounces-21187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4886884920C
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 01:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C0B1C219D5
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 00:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AE5A928;
	Mon,  5 Feb 2024 00:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l6/p7ies"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E158F49
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 00:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707093187; cv=none; b=phoYKpzeNhPWqd5lsFajM/z1cQNVfJ2tb9z583wbvCgHBS17cPIub4bPrePWeCtF/6MiEYcAY3it3WSoYpEu2YPDnsuxPNHua5wSkFrnwJifQp1aXdb+F0IsW5fXggMttStgAtKor+1SJ7OSz6cm1KreBsZ9YvCJa+8NPuljOFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707093187; c=relaxed/simple;
	bh=D++LDXE+yz9iRRvwYAcmxiBapY3kCCzcq7i6SOL+RyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nu5LPfryVG27BJ7CgNKRDTiB2U/g0H6DlhV7XQedXuAULjRhZb2UkZid3c8wfaah3UMioPiDtZL83IbHynrHc8sG+fi8R/UM3oTZdChwyQj3h5qXhDhrzHtRUtKUVCL3NVixcLUITCyjDaKv7Bl4hXtr1Zkpe83qzzBVmyf+4ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l6/p7ies; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e7900b65-0d2d-48ef-b8fd-cea42ea99810@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707093181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GslBK7Id8SkfqZIeWf++d62uMBUVShGZNxuE1TE6buU=;
	b=l6/p7iesYUtE+zfPINoF64XMtE1IDogXMq7XIKSUaFjN4fZ5wOoSXqJ+M1x07GVnE8oLma
	Z93fM6Eb1ouZ68ilzas/kRuTzjqlqGXAySIOBoRZdGHPQ87xP+v28mv4JmgvoQ/0UbmFYZ
	IDhhPw8FszgsWalQTP2n5ARMuJbHIzk=
Date: Sun, 4 Feb 2024 16:32:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Have bpf_rdonly_cast() take a const
 pointer
Content-Language: en-GB
To: Daniel Xu <dxu@dxuuu.xyz>, andrii@kernel.org, daniel@iogearbox.net,
 ast@kernel.org, olsajiri@gmail.com, quentin@isovalent.com,
 alan.maguire@oracle.com
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1707080349.git.dxu@dxuuu.xyz>
 <dfd3823f11ffd2d4c838e961d61ec9ae8a646773.1707080349.git.dxu@dxuuu.xyz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <dfd3823f11ffd2d4c838e961d61ec9ae8a646773.1707080349.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/4/24 1:06 PM, Daniel Xu wrote:
> Since 20d59ee55172 ("libbpf: add bpf_core_cast() macro"), libbpf is now
> exporting a const arg version of bpf_rdonly_cast(). This causes the
> following conflicting type error when generating kfunc prototypes from
> BTF:
>
> In file included from skeleton/pid_iter.bpf.c:5:
> /home/dxu/dev/linux/tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_core_read.h:297:14: error: conflicting types for 'bpf_rdonly_cast'
> extern void *bpf_rdonly_cast(const void *obj__ign, __u32 btf_id__k) __ksym __weak;
>               ^
> ./vmlinux.h:135625:14: note: previous declaration is here
> extern void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k) __weak __ksym;
>
> This is b/c the kernel defines bpf_rdonly_cast() with non-const arg.
> Since const arg is more permissive and thus backwards compatible, we
> change the kernel definition as well to avoid conflicting type errors.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


