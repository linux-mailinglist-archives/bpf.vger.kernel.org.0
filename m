Return-Path: <bpf+bounces-64905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAE9B1854F
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 17:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A072A8262F
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 15:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C60C27B4E5;
	Fri,  1 Aug 2025 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QtPP2BIY"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B364A27AC54
	for <bpf@vger.kernel.org>; Fri,  1 Aug 2025 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754063685; cv=none; b=TzzsiwHLcbhAfBD/3VJipByG1Yu/4iK6jpRP8MpGpKJzGyJUXWSHw4JJkmc8h20YYN3GKrNUCf1E3TDWRAZUpOdbnf8zoVTWtVFpBZTbXnbFaH9rEDcqBpthBWA5QhMe72O3TWX7Az24onr41PoLh40ahGXrLE2N8oDZPf0cFNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754063685; c=relaxed/simple;
	bh=R0sWKuJzzCsnYBn2G19Zby89bF8xLTfAk4Ms8HmqqpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTMkqp5hWAqD+r+Z0fLktutXVxq+qPXF4F4DT3CUjBcEz3UV0Zt8DD5EoKK3B8LJ9y/ygQYOd/6C7G5Goml3F4AUnPUA1gaJ6IXqVXaXqZUwx42gEtyYF82/Wwrdlg+RvNsfZBkgkCeT2GENsQtM5Z5Dwnnnc0zU0D5l3smOUXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QtPP2BIY; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5960cc57-6f40-42b5-9d51-288a2e7101c0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754063680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0sWKuJzzCsnYBn2G19Zby89bF8xLTfAk4Ms8HmqqpE=;
	b=QtPP2BIYAqcRoDJ7f6JHNKsiMUL4cOoFyZArgt+zwIRW6QY3eFCvoODf3QBcVWVAFbQtbO
	2dnQPKTCJp1Dv4mykxL7nJ6gEnDXmjHdmf4UzlzoSbdad0GQkkPPOO/ECsD8H6dVpwMmrc
	X6Wcn2lTzQh1ZsrLIW/fCuBeVpljz5Q=
Date: Fri, 1 Aug 2025 08:54:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 2/4] bpf: Check netfilter ctx accesses are aligned
Content-Language: en-GB
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, netfilter-devel@vger.kernel.org,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Petar Penkov <ppenkov@google.com>,
 Florian Westphal <fw@strlen.de>
References: <cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>
 <853ae9ed5edaa5196e8472ff0f1bb1cc24059214.1754039605.git.paul.chaignon@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <853ae9ed5edaa5196e8472ff0f1bb1cc24059214.1754039605.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/1/25 2:48 AM, Paul Chaignon wrote:
> Similarly to the previous patch fixing the flow_dissector ctx accesses,
> nf_is_valid_access also doesn't check that ctx accesses are aligned.
> Contrary to flow_dissector programs, netfilter programs don't have
> context conversion. The unaligned ctx accesses are therefore allowed by
> the verifier.
>
> Fixes: fd9c663b9ad6 ("bpf: minimal support for programs hooked into netfilter framework")
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>



