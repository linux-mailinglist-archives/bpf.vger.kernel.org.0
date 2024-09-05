Return-Path: <bpf+bounces-39030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5BD96DE37
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 17:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2C61C25E27
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1196C12C81F;
	Thu,  5 Sep 2024 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="oBC/3jdg"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B5319D8A2;
	Thu,  5 Sep 2024 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550211; cv=none; b=joXTGchLf7KWdAucVsBg/rwZfBjnjZJYieHp43WpRoZqpWch1o0Hn6w7xcKRt+4OfzbjvkS7Y4MABACPsECgbTxo6dFjNPdV+5K4EBrQsYNhI8vFKvsGBtnkKkrcMv0QY0Cajkmxa9S+4R2z1v5y+I6rgPB0GlMdsXLuNeiHGBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550211; c=relaxed/simple;
	bh=FYkxytAfTLdktm2KRIN5zwvicEDiyo8FDa89Wiku4xA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=f2GkkBibTJ64g0lRYwHqFQ81xlToAwEP0eTVMxAPGagdVk33Kpj3Fc4FscQXzUlH8VMYCXrg1C1iMgaLTvpO6QI80hjbiLwk+iqfnXSyDL2PptBvQuO4NJVVvh0hOVuVSvPxJy5K5dQiA/3cl06HJJI8dWuAvB1duf6ktm5gGc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=oBC/3jdg; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=W+748PDs7VWuitosbujGj48wCatW4hM4cT/gHZqGVis=; b=oBC/3jdg6uDXD1j+nEaBdQs0gm
	ZJUUOhWw3BPZpLheie6PSGgoRpV1spwGsLn3/0BlP+GIWLtxzfjPCtPafGMR3yebw53W4YkkgMSOD
	CKZhPFrsyLQtEmuKFqanh4bhJicMSCj24XSyt0fBhlGhJOGpbzCRlpI7tbaIg7N82/gexz4mM2Rec
	TlmA+x/ScSs6dGB3b/UZ6idVx7MIwy+10SCKaaXQX56qrefVbhnBBbZpDIpf+IqJsWfH87xzacHS0
	US9RQFRoQimB/oYy3goPysjxda7YVnO+0NzZFc/URuAqfABLP0wrNCATsc/zVBRY/0Lxn/BJmsiFi
	oU87IdIg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1smEQq-0002Hz-Bz; Thu, 05 Sep 2024 17:30:00 +0200
Received: from [178.197.248.23] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1smEQo-000M2I-2G;
	Thu, 05 Sep 2024 17:29:59 +0200
Subject: Re: [PATCH bpf-next v3 03/10] selftests/bpf: Prefer static linking
 for LLVM libraries
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20240905081401.1894789-1-pulehui@huaweicloud.com>
 <20240905081401.1894789-4-pulehui@huaweicloud.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a0e6117a-12ae-388f-bb43-d32a219d08b5@iogearbox.net>
Date: Thu, 5 Sep 2024 17:29:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240905081401.1894789-4-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27389/Thu Sep  5 10:33:25 2024)

On 9/5/24 10:13 AM, Pu Lehui wrote:
> From: Eduard Zingerman <eddyz87@gmail.com>
> 
> It is not always convenient to have LLVM libraries installed inside CI
> rootfs images, thus request static libraries from llvm-config.
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Daniel Borkmann <daniel@iogearbox.net>

