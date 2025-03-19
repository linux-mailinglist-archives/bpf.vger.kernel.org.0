Return-Path: <bpf+bounces-54421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478E3A69C86
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 00:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E1B882CC2
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 23:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23348222590;
	Wed, 19 Mar 2025 23:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k8jdtpog"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401E5221F31
	for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742425541; cv=none; b=uM/aK0ufR7hmzPpH7ytgUvPS8RDbzWg8qmecKn9yTo7vn+T6PxNjA4A3jEAn90EoZmSie7iZm9xhjoKUgcLBKJOvmKbFx2h1mS/uQNltO6/UHw7MdfVi85DvjL+yV1wnGE0eS0dfQDE8DXrBhaF/qouT26/v+H0Zxouwj6kZ0Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742425541; c=relaxed/simple;
	bh=Evxo9UTT0eUb608jqYtYPGkMG/GCc6FBlRO8histrp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+5hk38GkR/XaeFTUeLzNqEPeDS4zmGYBhKbl6RBj6VUqde7wFtdmrEarxbdW/XNf37pTiFP9tqacuVegE/wbD6RT2kjv3mYt2P902tq1AtfhS7kFpgTnOZgr4/pjdaPAztfyIySLMfUyoPZTppMIuxufekXywIVzWf5vp/QcbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k8jdtpog; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c48696b2-62ce-4e6e-8d33-e595580e290a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742425527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3g8xtoD8LUwlFDszpo8JMhI10IGQg9AcPZvetrkE6A=;
	b=k8jdtpog2q++b30sCEoyBZeMtBowjGN/s1AkDay0KCN5B7D7lPdQO6o2yJ2xBsfHbVS46I
	/V4OLu7Yq2v+6CtgcJ9U5klf9R32AZlEJXUGtkVopvn+33KR4IoiuCoxRuupzRdQDrBUzY
	33k71njmFOIETJq25ONFnh6aHUjdiiA=
Date: Wed, 19 Mar 2025 16:05:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/2] selftests/bpf: Migrate test_xdp_vlan.sh into
 test_progs
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250221-xdp_vlan-v1-0-7d29847169af@bootlin.com>
 <Z7yZ8OxdisKbFYBi@mini-arch>
 <f416d179-6405-4a84-8fea-2f6c0a60aef3@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <f416d179-6405-4a84-8fea-2f6c0a60aef3@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/18/25 3:25 AM, Bastien Curutchet wrote:
> Hi all,
> 
> On 2/24/25 5:10 PM, Stanislav Fomichev wrote:
>> On 02/21, Bastien Curutchet (eBPF Foundation) wrote:
>>> Hi all,
>>>
>>> This patch series continues the work to migrate the script tests into
>>> prog_tests.
>>>
>>> test_xdp_vlan.sh tests the ability of an XDP program to modify the VLAN
>>> ids on the fly. This isn't currently covered by an other test in the
>>> test_progs framework so I add a new file prog_tests/xdp_vlan.c that does
>>> the exact same tests (same network topology, same BPF programs) and
>>> remove the script.
>>>
>>> Signed-off-by: Bastien Curutchet (eBPF Foundation) 
>>> <bastien.curutchet@bootlin.com>
>>
>> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Small gentle ping on this, as I haven't received any updates since Stanislav 
> acked it.

I made a small change in the Makefile to resolve a recent conflict. Applied. Thanks.


