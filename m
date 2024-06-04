Return-Path: <bpf+bounces-31392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 636198FC011
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 01:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D782852D8
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 23:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E5F14D446;
	Tue,  4 Jun 2024 23:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vPcNAmgS"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E82414D28E
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544522; cv=none; b=lrFOXHFGu5pHSoy1xEb/pJ89cP4yBO3h2IdcbtS3qcKiGi6uAFrDt9STEUGkzQa1Q2raP5XHj8cLkzHHxydOi4WyfG6Jur0f2W9GsHwLCBr4e1XFMJuJesAfPmWERxY3nxyNR3WU5oNZO3ekValWEpF0f+fmefvJ6Q7qmhj8F0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544522; c=relaxed/simple;
	bh=c346iAURzRJ62La34kA/lEKDO2ryXmxH0kJJpeCSw8U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ju4c3hWO0OsAyAHcQOLpMn6D5e7R+ggcK9ywBPCScdOPEI3xHRc3uBDJE/EufoYPlBzAJ+USgD64jTNw6+73H4xcv6lBI8mGN4sFIkBHLtS2EcmYEVluRhN/LJXejAWsKtwq0KHQh31qR7oUbt4QwsiU+JxGtMCStyxKYRwek38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vPcNAmgS; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717544519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v0JKup1qX14ye2cWkUAPy8WDFmKcMGklFj8uA5s74UU=;
	b=vPcNAmgSCrf937WVhaH1QnW5L42Xc5DGXBXaoDHI/NNp9P2jsD1V/oC6jolZ6+fcq19Rw4
	7mU2OMDp6i1fZn/RH179MvgzrIityTE7qtlljmD6nqk940Trf7Y+Bc18jbFt46IMCOnE/S
	AR3FypN+hRT/wFpO2JdYfmbABO3knco=
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <9ba46c8c-17b0-4600-8b49-1d2c9821be04@linux.dev>
Date: Tue, 4 Jun 2024 16:41:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Support shadow stack
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240604175546.1339303-1-yonghong.song@linux.dev>
 <20240604175552.1339642-1-yonghong.song@linux.dev>
In-Reply-To: <20240604175552.1339642-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Please ignore this patch and the next one shadow stack patch as well.
These patches are my prototype before lsfmmbpf conference.
Alexei has suggested a better approach which I will implement and post
soon.

On 6/4/24 10:55 AM, Yonghong Song wrote:
> Try to add 3rd argument to bpf program where the 3rd argument
> is the frame pointer to bpf program stack.
>
> There are a few issues here:
>    - Currently, only main bpf program is using shadow stack.
>      other sub programs (static or global) still use stack.
>      It is POSSIBLE to a hidden register to pass
>      frame pointer (derived from main program) to those static
>      or global functions.
>    - But tail call and ext programs are not working now we
>      we do not know at jit time what programs will be used
>      in tail call and ext. It is possible to do some jit
>      during text_poke time. But that will need additional
>      stack allocation at jit time and that will be complicated.
>    - For xdp program, need to patch jit for xdp dispatcher.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   arch/x86/net/bpf_jit_comp.c | 105 +++++++++++++++++++++++++++++-------
>   include/linux/bpf-cgroup.h  |   9 ++--
>   include/linux/bpf.h         |  29 ++++++----
>   include/linux/filter.h      |  25 +++++++--
>   kernel/bpf/cgroup.c         |   9 ++--
>   kernel/bpf/core.c           |  36 +++++++++++--
>   kernel/bpf/offload.c        |   3 +-
>   7 files changed, 173 insertions(+), 43 deletions(-)
[...]

