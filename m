Return-Path: <bpf+bounces-65408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54D0B21AAF
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 04:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6333A9286
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 02:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B9C2DE6EE;
	Tue, 12 Aug 2025 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o1GhKnz1"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7142D3A71
	for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 02:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754965225; cv=none; b=kSvHF88LtPlrgOE1dzBHHWOEWQdKDe+o2WXXqiXGLi3/IsBZu5XFpiVQuWeFPxfujVRnj/dqB++kckXx4m03/UyqwebCOI+ycz2yGez9zlKc29erI+2Z3PauSsqlGBv4VqjWgssU1TPnM660b3EcM5ynG2hjOKrrIUpBQWfmqTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754965225; c=relaxed/simple;
	bh=QvB1rsxL3xgREXQ61kz9noMqaDOXyWbP6sLyZNWrLaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GS8jz3rob0wkklRYyUoFK2QSE00naan03ezvtkwF+ZADsYc2+F7jtjeW88/U8DC80AOlKrAsTp/tejq4AzxVftmkrZXBNGAJLqNja/3ac4Cy0jtv9cy2J0X3wIswZijWNmsu2uJa17DpcEHFGu6qAvkns60qosHbnzuzpKf7Ta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o1GhKnz1; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6482acb9-d41a-4167-8fd3-82bc6893cbc2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754965216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IzdZ6cbqzGjySiI5E/7svKQXRbnU8yiP2iqSu5Y+noM=;
	b=o1GhKnz1KGbxWNy5WaRECZ84ZUtaunNEStD1dtTLj4M2FJFqGc0/8laLiPtJNFLSkPgBZI
	cGhpU140ZkD3FJin2lXAenKNbSao3IlHlx5AnqFlYFFEG6kFJKJVDeELGwq3ixB8E7CkX1
	IX+cq5WLs9H7hovu7fA/opMKy4eopeo=
Date: Mon, 11 Aug 2025 19:20:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Tidy verifier bug message
Content-Language: en-GB
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
References: <aJo9THBrzo8jFXsh@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <aJo9THBrzo8jFXsh@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/11/25 11:58 AM, Paul Chaignon wrote:
> Yonghong noticed that error messages for potential verifier bugs often
> have a '(1)' at the end. This is happening because verifier_bug_if(cond,
> env, fmt, args...) prints "(" #cond ")\n" as part of the message and
> verifier_bug() is defined as:
>
>    #define verifier_bug(env, fmt, args...) verifier_bug_if(1, env, fmt, ##args)
>
> Hence, verifier_bug() always ends up displaying '(1)'. This small patch
> fixes it by having verifier_bug_if conditionally call verifier_bug
> instead of the other way around.
>
> Fixes: 1cb0f56d9618 ("bpf: WARN_ONCE on verifier bugs")
> Reported-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


