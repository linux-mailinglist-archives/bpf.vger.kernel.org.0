Return-Path: <bpf+bounces-8068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482E5780D62
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 16:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816441C2160D
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 14:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB4218C13;
	Fri, 18 Aug 2023 14:05:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D318417AC1
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 14:05:08 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8AB3C34
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 07:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=nxGvbZACgdcYYG2fbLN11LXaAVLq7SZ5AVyORiYVyK0=; b=Mgw65uPakUjq3el6KQiQLNZgPq
	2sy0XRpciKC221add45kWYNsmL8KgKIyWTqh9dn9LVrcmhYjxuAMUWN47KI9jbbhiYvwLijWJ5QLM
	sPxU7ECWazg997aR6xkXzpT467vuVDB/cXZtoL2oF7zzoRXHBL/vr2PlkYBPb75SjlD6MqsGUWfeA
	0Kx+qywOlrECiJpvd9NbQEMM8W5bzNNy5HJ6zR/WPUf24/eobH4I6T3ch7hX4iMmYMCF4flnuYP71
	1vK2crrQtm8Ny0Dq/33h/A0w8fmBrocO4Lpe1hqopW7WX/FZVQH4VOQANpxTdm60k0rstUWOXwJ4X
	RsH8Eayw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qX05m-000BHo-U8; Fri, 18 Aug 2023 16:04:46 +0200
Received: from [85.1.206.226] (helo=pc-102.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qX05m-000Qtx-1F; Fri, 18 Aug 2023 16:04:46 +0200
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: Enable cpu v4 tests for arm64
To: Xu Kuohai <xukuohai@huawei.com>, yonghong.song@linux.dev,
 Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Yonghong Song <yhs@fb.com>,
 Zi Shen Lim <zlim.lnx@gmail.com>
References: <20230815154158.717901-1-xukuohai@huaweicloud.com>
 <20230815154158.717901-8-xukuohai@huaweicloud.com>
 <f1b6fde2-5097-7a0f-29ad-7390a165bf16@linux.dev>
 <67212714-15f3-84e8-d5c6-84746632eedd@huaweicloud.com>
 <2fd02263-669f-82cf-d2c0-86fb5e4ad993@linux.dev>
 <6e8244b3-acf8-acd3-2dda-8777b2b4c7f9@huawei.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <28f7de40-4941-4554-25bf-370dd2ec3226@iogearbox.net>
Date: Fri, 18 Aug 2023 16:04:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6e8244b3-acf8-acd3-2dda-8777b2b4c7f9@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27004/Fri Aug 18 09:41:49 2023)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/16/23 4:31 AM, Xu Kuohai wrote:
> On 8/16/2023 9:57 AM, Yonghong Song wrote:
>> On 8/15/23 6:28 PM, Xu Kuohai wrote:
>>> On 8/16/2023 12:57 AM, Yonghong Song wrote:
>>>> On 8/15/23 8:41 AM, Xu Kuohai wrote:
>>>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>>>
>>>>> Enable cpu v4 instruction tests for arm64.
>>>>>
>>>>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>>>>
>>>> Thanks for adding cpu v4 support for arm64. The CI looks green as well for arm64.
>>>>
>>>> https://github.com/kernel-patches/bpf/actions/runs/5868919914/job/15912774884?pr=5525
>>>
>>> Well, it looks like the CI's clang doesn't support cpu v4 yet:
>>>
>>>    #306/1   verifier_bswap/cpuv4 is not supported by compiler or jit, use a dummy test:OK
>>>    #306     verifier_bswap:OK
>>>
>>>> Ack this patch which enabled cpu v4 tests for arm64.
>>
>> Ah. Sorry. Could you paste your local cpu v4 run results for
>> these related tests in the commit message then?
> 
> Sure. The results are as follows. I'll post these in the commit message.

Thanks, I've added these to the commit message given Florent's review and
tests came in.

Yonghong, did you ping all other JIT folks as well, so they are aware and have
a chance to look into adding support for their archs?

Thanks,
Daniel

