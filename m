Return-Path: <bpf+bounces-60206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7ABAD3F41
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 18:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD4417D036
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 16:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436F924395C;
	Tue, 10 Jun 2025 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A5+FU7rw"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD81E242D70
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573721; cv=none; b=tfj5epWdbz4pwDtxRC8HbVS+m/joBwHcGfVA2Vcn/2t/P0ZiQpQziYXWczyDg7yBIHpPLgFldQ75AWp1fp8ncATSV63CE/1Mu0iYILqCFjL/dHd6e31BpylseQxTE5NbBIbyj0vAp6lIpvx+DQmQXzAvP9ar7W/vxchx2m1d1Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573721; c=relaxed/simple;
	bh=oG0agEwdbAiZaE2N1n/SMq35flaiH9baH2aZNlVLJR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oo927o1ryqbsoPDy1lZGNlZKFYS4HTHmbhMcAq4brkG11huN/5CSnqrik+KcWq61xUmN9WTrZhJ2PGinh3s7lmTzHgQKa5IofvG2RtD9xAFoWY7trEY+aK6Gf04IMi8kQYHmsLT3VKHc8U/vFKH6NIgaRCbnUC5DkgXKkAgxRU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A5+FU7rw; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f8ecfb2d-c82f-4785-b5dd-eccec0d13f8a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749573717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oG0agEwdbAiZaE2N1n/SMq35flaiH9baH2aZNlVLJR0=;
	b=A5+FU7rwNiSh5Up/2yQSOwZGDMi2xkwvRRuP6uTg1ZopTqc8pXJEvX9AV7YhGs+umpg84x
	qmCGFuTMtsMpvIKttlQOAFja/Zt+P00wm+iIqizB8Rha3VgDtyIBoci+HHH78QYsIK3qZG
	DzEwwnwCRDKI1NTeXg2VkwmA636Cov0=
Date: Tue, 10 Jun 2025 09:41:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] bpf: Specify access type of bpf_sysctl_get_name
 args
Content-Language: en-GB
To: Jerome Marchand <jmarchan@redhat.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
 Eduard Zingerman <eddyz87@gmail.com>
References: <20250527165412.533335-1-jmarchan@redhat.com>
 <20250610091933.717824-1-jmarchan@redhat.com>
 <20250610091933.717824-2-jmarchan@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250610091933.717824-2-jmarchan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/10/25 2:19 AM, Jerome Marchand wrote:
> The second argument of bpf_sysctl_get_name() helper is a pointer to a
> buffer that is being written to. However that isn't specify in the
> prototype.
>
> Until commit 37cce22dbd51a ("bpf: verifier: Refactor helper access
> type tracking"), all helper accesses were considered as a possible
> write access by the verifier, so no big harm was done. However, since
> then, the verifier might make wrong asssumption about the content of
> that address which might lead it to make faulty optimizations (such as
> removing code that was wrongly labeled dead). This is what happens in
> test_sysctl selftest to the tests related to sysctl_get_name.
>
> Add MEM_WRITE flag the second argument of bpf_sysctl_get_name().
>
> Signed-off-by: Jerome Marchand <jmarchan@redhat.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


