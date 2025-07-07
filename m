Return-Path: <bpf+bounces-62497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AA4AFB4AD
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 15:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4D9188DA3F
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 13:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF92C2BD58A;
	Mon,  7 Jul 2025 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0qKtf6Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F122BD022;
	Mon,  7 Jul 2025 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895221; cv=none; b=J4IqGhnx8q9N61RSbwDtuctpSXKus3lxbWv80s99sD1ZLnsbznn28p/nhpN59GNyKSCW/9nqWPU1tD3Q1epw7T/PgJkihIhRmnXQgJUpFCAK1eiGSoMSKPPQ6oZEQGOAuv1vM4jyZGVrIOPnWFJTUjD1/Xx3UbrkpMK+yLrT4JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895221; c=relaxed/simple;
	bh=coXCHRXOLr4GBqKYtVnKxnzaHo047ON5CiWcIERo0lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2vIpfUiqvHtAPq+cgZRTERnw65eOlkhp1/IzF90iwGhZjDpy+T/naGbGjirAUPjLI7CsVMAL2IMzb3zQ2P6Xt1ngrSGQubBZS2Si44k8Ba6msDI10hB1lypFYvhQdPNK3zDqEoDA9WfAHHSL/RxSSOiw+CAfYy7blbsuBKm4EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0qKtf6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1A0C4CEF4;
	Mon,  7 Jul 2025 13:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751895221;
	bh=coXCHRXOLr4GBqKYtVnKxnzaHo047ON5CiWcIERo0lI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a0qKtf6ZkWcuQioVgBBE2fdWpt4oO1ur5XMfBRWWrZ5RjZvb6kTnCNB6kp+ejV4o3
	 k+Kpi6UpZEwpZ2RvfWPO1lkfq/nl0qzmz9Zo223jO2b5ksI8yKCVY6xq8lK9qPk7bP
	 v2S4kdjRrytm8XvUtzrFrcjh+AaBgWS+G/jN8Auqnba5i82ZHsXE/4/rwLToM+mTaL
	 PCxbcsdJFT/QGKLAlptqCnitBv0BqK0w/FryzqnmsXLg+y9rl/gLxgEAXvU5Q+h4QK
	 UZGDJuT9xvv+9Eo/uFSLoktRGObHhxsAlBIbjwaE4BFK/VSy6ZK9zK8w/P6pfcQFlA
	 CV7HtlptpvDiQ==
Message-ID: <1017a5b4-478a-48ee-805d-363a4c0ca220@kernel.org>
Date: Mon, 7 Jul 2025 14:33:37 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/libbpf: add WERROR option
To: Daniel Borkmann <daniel@iogearbox.net>, Sam James <sam@gentoo.org>,
 bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <7e6c41e47c6a8ab73945e6aac319e0dd53337e1b.1751712192.git.sam@gentoo.org>
 <c883e328-9d08-4a6c-b02a-f33e0e287555@iogearbox.net>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <c883e328-9d08-4a6c-b02a-f33e0e287555@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-07-07 15:18 UTC+0200 ~ Daniel Borkmann <daniel@iogearbox.net>
> On 7/5/25 12:43 PM, Sam James wrote:
>> Check the 'WERROR' variable and suppress adding '-Werror' if WERROR=0.
>>
>> This mirrors what tools/perf and other directories in tools do to handle
>> -Werror rather than adding it unconditionally.
> 
> Could you also add to the commit desc why you need it? Are there particular
> warnings you specifically need to suppress when building under gentoo?


And if you need to disable the flag on a particular target, have you
considered using the existing variables and pass EXTRA_CFLAGS=-Wno-error
rather than adding another flag?

Quentin

