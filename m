Return-Path: <bpf+bounces-18413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F92481A6FE
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 19:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3521C2335A
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 18:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6D838DE9;
	Wed, 20 Dec 2023 18:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="HFUPKVeX"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A108482D8
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=KipKjnlsqLUQ1D2O0wJAZ6D+A4TQs2F24xpWUYPAP74=; b=HFUPKVeX19pqBb+O9MDda2zH8S
	w64pm5h4ZlyyAZcVr2GEcbsb88A8/aZ9L+Nk6ISNOJGZkOJEefNNBSpo7eudRky0RfDLc96xhORZZ
	yk5smnSlBze5BpKc9oh6P9Gm4iMp3zvBB3tHyy61uV/fAd8DfFhiE6tOl+iLRTBYKvyL+jHv5w5hF
	0kuelxjdyHvT9O1EOjg7Dcf6HXTKCrNbtRxG62V33Y2SgBJfUvX6imbrlX8Bd2aPaK9iq2VjPv9vk
	93LUTxyczHfeTlfIG5bxv0jI42cMbICJzKqwEFbCs/R0ei/c6vB2eRVqMHTxWe3KvaX34A+zapMc/
	EWxq677A==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rG1af-000K4i-UD; Wed, 20 Dec 2023 19:46:45 +0100
Received: from [178.197.249.36] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rG1af-000DP5-6q; Wed, 20 Dec 2023 19:46:45 +0100
Subject: Re: [PATCH bpf-next 2/3] bpf, x86: Don't generate lock prefix for
 BPF_XCHG
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Hou Tao <houtao1@huawei.com>
References: <20231219135615.2656572-1-houtao@huaweicloud.com>
 <20231219135615.2656572-3-houtao@huaweicloud.com>
 <7f682450-e165-26a9-1247-ef1440d9b7a2@iogearbox.net>
 <CAADnVQKZAsLhZEd8E4_jODJq=V+DexcVCrmifvYNaFwpcbXLgw@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1b1c23b6-467e-d645-cbcb-0c51db2203a1@iogearbox.net>
Date: Wed, 20 Dec 2023 19:46:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQKZAsLhZEd8E4_jODJq=V+DexcVCrmifvYNaFwpcbXLgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27129/Wed Dec 20 10:38:37 2023)

On 12/20/23 7:25 PM, Alexei Starovoitov wrote:
> On Wed, Dec 20, 2023 at 6:58 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 12/19/23 2:56 PM, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> According to the implementation of atomic_xchg() under x86-64, the lock
>>> prefix is not necessary for BPF_XCHG atomic operation, so just remove
>>> it.
>>
>> It's probably a good idea for the commit message to explicitly quote the
>> Intel docs in here, so it's easier to find on why the lock prefix would
>> not be needed for the xchg op.
> 
> It's a surprise to me as well.
> Definitely more info would be good.
> 
> Also if xchg insn without lock somehow implies lock in the HW
> what is the harm of adding it explicitly?
> If it's a lock in HW than performance with and without lock prefix
> should be the same, right?

e.g. 7.3.1.2 Exchange Instructions says:

   The XCHG (exchange) instruction swaps the contents of two operands. This
   instruction takes the place of three MOV instructions and does not require
   a temporary location to save the contents of one operand location while
   the other is being loaded. When a memory operand is used with the XCHG
   instruction, the processor’s LOCK signal is automatically asserted.

Also curious if there is any harm adding it explicitly.

