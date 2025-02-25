Return-Path: <bpf+bounces-52577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F95A44F4D
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 22:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6F03AE847
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 21:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16003211A29;
	Tue, 25 Feb 2025 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FaeO6a5+"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B00210185
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520453; cv=none; b=RfgzfTK8mXNb9KVXrHVpuwcmLn1g8M4ibXD4AYIsQwOKJUrbln8+KSLUSaz9277XucFMbHarlwgP0dRLqOJyCQMcwQGrqjyUNnPbSjn0apdqmZcTHUkJuVFBxNRCM0zhYaRpn4sF3hZ93YpXaE/+JAc3B/6f6YhQyw4r3zyRx2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520453; c=relaxed/simple;
	bh=Ss+e6w8qoyeE0Z+xswI2QGsSyHSG8oyuTlHXERI7L6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S48BKUkny2+5ms0SD7/Arb/mPwFtsqk9XJ15KM3s3/bTkw00yVJoBxhGbcQwR97ImVIAbmR1xlj260YBUu89QCbszTJ6szHxR8hyuofHurvxq/7a8gHy90o2euF3VGHXvZoi1JXrS8JNIyrgomrq56DlIA6t/VK30VZNKqQA1o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FaeO6a5+; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <01e045f5-b11b-44d1-8766-08511c6042d2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740520448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7R7XiOCt/+ZLGbvZk4peIssOu4WB8AgIX3uz1gDktDY=;
	b=FaeO6a5+ybNjPFyyTWZlWIMEb+NVL6/9V+ywxQyhW4gMueOyMPPzuGSjW1CvszjFXGCrII
	rtnjaboVksGbMLohGYcSGLwOIWPDbYtepGmbYzf/zD9hvv4zIrTI9jOtCfzyoTyKAaXx9b
	n0JubdpAiVqOyyo+TzFecgBbAwcBwVI=
Date: Tue, 25 Feb 2025 13:54:03 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Search and add kfuncs in struct_ops
 prologue and epilogue
To: Amery Hung <ameryhung@gmail.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, eddyz87@gmail.com, kernel-team@meta.com,
 bpf@vger.kernel.org
References: <20250225212915.145949-1-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250225212915.145949-1-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/25/25 1:29 PM, Amery Hung wrote:
> From: Amery Hung <amery.hung@bytedance.com>
> 
> Currently, add_kfunc_call() is only invoked once before the main
> verification loop. Therefore, the verifier could not find the
> bpf_kfunc_btf_tab of a new kfunc call which is not seen in user defined
> struct_ops operators but introduced in gen_prologue or gen_epilogue
> during do_misc_fixup(). Fix this by searching kfuncs in the patching
> instruction buffer and add them to prog->aux->kfunc_tab.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


