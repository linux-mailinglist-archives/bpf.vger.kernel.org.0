Return-Path: <bpf+bounces-36409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2219482AF
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 21:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DEC01F22358
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 19:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BA016BE26;
	Mon,  5 Aug 2024 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="roFgdKG/"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B753515ECD1
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887667; cv=none; b=G/KayokPK08yDSgIWuNHwcPJW/Gsrall/x7cpOKG7AvPkXjYhygd/B/mxqOy5188HDMhb7I6EO3whMqx8BTt4LSS93NrpxOEHp9lSHAUw4ACil5gFXHccztLvvt7ulGsbvVuXAYMn/X1XlyhcWnRgA0xe9coVjwLZZCzhkrw4jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887667; c=relaxed/simple;
	bh=HZb1KKtE8Me4IRUo9soQ3qk4AZtiCCWu2OpLhxAXO/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ln0O6vfuJ7pnr9ydFR6xWqbp+0U2lIfkPB1xcZmV37myH8XlADlIevaiEdQ3COxKJg5KOF3m9HrTREhEcgjptyh5JP4NqRxXqV5DFV4aS+GJQgEh6u9W0ytaq88T0lBY2WI4qw4qKGDpXJQaoU5UkoqpuVI48bhFjMPV3Vy1TZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=roFgdKG/; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sb3mZ-00BQb4-DQ; Mon, 05 Aug 2024 21:54:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=LETjiGOjSAe6wLQ9jWSXj9vxRADp2ZzD8f44Fu34bLY=; b=roFgdKG/qtlDmzuGLgzychYH3H
	oT/cWG4BTuVkB55Zh3gBAJXy/qRZH3Luqmy7oHylSpVxPaIdnMIqXqejXSodBntInJWnOOqYXTpHU
	j5SDR9SumIgcpPIL0deSD+WfYKaKzaQM9WoCF430haCnmogvM66qOL6KTsKsus8nMHjO9MsmjS2M/
	EiQ+P25NSecj4eeq/xtqj/LnGylRMdmAbnLsZ/P+ZlCT/Wbve579B+VzgjztQ3G4x40X02KDLzDk+
	oqXD3xCjcxFG8/NkJhT5veT9Z2bg3oIvaGSxSD3EjZhbDHHFaNMaZ9EnzE8DfyYGf/D2+cga32rVO
	VzJFpVVQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sb3mY-0002KF-N2; Mon, 05 Aug 2024 21:54:14 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sb3mR-00GKZb-6j; Mon, 05 Aug 2024 21:54:07 +0200
Message-ID: <39b9aa89-ac81-497d-8aa0-94e851044676@rbox.co>
Date: Mon, 5 Aug 2024 21:54:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related
 fixes
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
 <877ccvyoyb.fsf@cloudflare.com>
From: Michal Luczaj <mhal@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <877ccvyoyb.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/24 17:22, Jakub Sitnicki wrote:
> On Wed, Jul 31, 2024 at 12:01 PM +02, Michal Luczaj wrote:
>> Series takes care of few bugs and missing features with the aim to improve
>> the test coverage of sockmap/sockhash.
>>
>> Last patch is a create_pair() rewrite making use of
>> __attribute__((cleanup)) to handle socket fd lifetime.
>>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
> 
> Sorry for the long turn-around time.
> 
> I have opened some kind of Pandora's box with a recent USO change and
> been battling a regression even since. Also it was CfP deadline week.
> 
> I will run & review this today / tomorrow latest.

Thanks for the update. But, really, as far as I'm concerned, no need for
any rush.


