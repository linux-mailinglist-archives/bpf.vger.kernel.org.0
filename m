Return-Path: <bpf+bounces-35387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 277CD93A087
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 14:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6DF71F2320A
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 12:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6848114C5A4;
	Tue, 23 Jul 2024 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="QmjDZd+7"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08206381B1;
	Tue, 23 Jul 2024 12:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721737936; cv=none; b=AkwIjZrHAf/xmtmMoCXA1yKVGnOFrfLCSRsChOzxS63j/LtZtMpAN6+erPdED7+S5U6X6SZFlGufrSiN+ofSK92oad8mgXxHbbG/ZOsn2MT0Y2DsSLLzfrRYmUb9zz6xdi6l9jLbKHhZMPP0LRzXJDWL2ewB/yYmPNYB5i1uxL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721737936; c=relaxed/simple;
	bh=dUrGEVrh/HvvlRpitrwjxPOkIMAXxHqaRf1h9h7gtvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVzIL9Ox+RTNtNNudbDEV6auKV7Grsk15r9GdVwNcgl5Ga2jMGv+hdfCJL1ylsFpZlIwX1Q33iiMxe1kNazHZIlQmWurHJYophs4aGSzB4+7VVGblHY4nHurnYFVJQvTfTBjdNm9Mu0dTwPywWvh8Ymg3/QQtEvzuMA7s9j7B50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=QmjDZd+7; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sWEgW-005oEO-Ld; Tue, 23 Jul 2024 14:32:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=HKIrEbrGBmfJtypL/EQ6MZNDqKAtq+m8Oo1XI53MmoE=; b=QmjDZd+73bi4ulCp8zp/YPE4li
	D8FFrOmFMAqVO6P/JDj7rC9rVE0FcESwtMsXxEr1Llz8II9X6l+tm/xSX+IbGhdI3XER2gVS0pb9Z
	36362BUBEbDTi0npNS46e/Z6M08wGuVCsaorRA3r4utVbU/6LRok6eYnrWpwlee30BJ7EcefpedvP
	awMgNisLpgskKLMXlJ+ZoaQbEevFkehz9xsgL3buVXOejh3/6PDUpv2A31yMFXZfX4TLaLMA8076q
	0ffekiWVorf3eBGseLTEzGjgqhFxxJ3x7mCmuvBZd4qEBMLBD7k5OSXh0MsETQZcl41bdjaH9xXUa
	eY09QN5A==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sWEgV-0007Ie-Jp; Tue, 23 Jul 2024 14:32:03 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sWEgB-00Dfar-Se; Tue, 23 Jul 2024 14:31:43 +0200
Message-ID: <ff3e2f59-4d3d-46e0-94a1-4268b62c6d0e@rbox.co>
Date: Tue, 23 Jul 2024 14:31:42 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 2/4] selftest/bpf: Support SOCK_STREAM in
 unix_inet_redir_to_connected()
To: Eduard Zingerman <eddyz87@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 john.fastabend@gmail.com, kuniyu@amazon.com, Rao.Shoaib@oracle.com,
 cong.wang@bytedance.com, Andrii Nakryiko <andrii@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>
References: <20240707222842.4119416-1-mhal@rbox.co>
 <20240707222842.4119416-3-mhal@rbox.co> <87zfqqnbex.fsf@cloudflare.com>
 <fb95824c-6068-47f2-b9eb-894ea9182ede@rbox.co>
 <87ikx962wm.fsf@cloudflare.com>
 <2eae7943-38d7-4839-ae72-97f9a3123c8a@rbox.co>
 <87sew57i4v.fsf@cloudflare.com>
 <027fdb41-ee11-4be0-a493-22f28a1abd7c@rbox.co>
 <87ed7lcjnw.fsf@cloudflare.com>
 <205c38e28799bfe4b78a5e61fd369d5a5588694f.camel@gmail.com>
 <459b8eefe371cb227b729ff89160ec36f69273d8.camel@gmail.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <459b8eefe371cb227b729ff89160ec36f69273d8.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/24 00:21, Eduard Zingerman wrote:
> On Mon, 2024-07-22 at 15:07 -0700, Eduard Zingerman wrote:
> 
> [...]
> 
> Digging a little bit further, I think the behaviour mentioned was fixed
> recently by the following commit:
> 
> a3cc56cd2c20 ("selftests/bpf: Use auto-dependencies for test objects")
> 
> From 3 days ago.
> 
> As the dependency is set from sockmap_basic.test.d,
> generated while sockmap_basic.test.o is compiled.

Ah, yes, you're right: bpf-next works for me. Thank you very much for
solving this. And I apologise for the noise.

Michal


