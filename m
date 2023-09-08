Return-Path: <bpf+bounces-9498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D07798813
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 15:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E241C20C77
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 13:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D549063B3;
	Fri,  8 Sep 2023 13:45:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898FA5254;
	Fri,  8 Sep 2023 13:45:38 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59F31BF6;
	Fri,  8 Sep 2023 06:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UkfLMtO8fA9PF8uSZuzD5bsvx/rEUFwdpKwoNVFn7eM=; b=RatTUzV8DzA7IgacGyzlKYy6iX
	yvQ1fUxI4r7SHePbiHaOjIlMyWHbQkqA6rLqVIhkDDwwXncTsii0DWoOdeVZPE/RyZY73gteMlo0q
	jk376nc8D46bNM7/CPAwpIChPnJ1KXiTqH3vgo4t/oC1B+BhnDFtLJtZeNhnKgStj50CsauNTcHxv
	obJasEmIlpvuLAx/uIjpJs9Y2ep/uxBfKlADZpdfLLW+/UdF9KRYVsM3ZtKIIY/TKhmYnTS+avcJF
	7uNwqawKPA0BY60S175hZI6njT+XDtEHaIqQhqoZFQQ3N4Y++vYpLr46KXVjpbPQHdBfbJY8wjjK3
	CF5UOIDQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qebnQ-000Ant-Cz; Fri, 08 Sep 2023 15:45:16 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qebnP-000SDn-NO; Fri, 08 Sep 2023 15:45:15 +0200
Subject: Re: [PATCH bpf-next v4 0/7] add BPF_F_PERMANENT flag for sockmap
 skmsg redirect
To: Jakub Sitnicki <jakub@cloudflare.com>, Liu Jian <liujian56@huawei.com>
Cc: john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20230902100744.2687785-1-liujian56@huawei.com>
 <87o7ickfss.fsf@cloudflare.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5b5dd10a-2728-c75b-6c4d-b03cebcaecfe@iogearbox.net>
Date: Fri, 8 Sep 2023 15:45:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87o7ickfss.fsf@cloudflare.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27025/Fri Sep  8 09:37:45 2023)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/8/23 2:29 PM, Jakub Sitnicki wrote:
> On Sat, Sep 02, 2023 at 06:07 PM +08, Liu Jian wrote:
>> v3->v4: Change the two helpers's description.
>> 	Let BPF_F_PERMANENT takes precedence over apply/cork_bytes.
> 
> Sorry, will need some more time to review this.
> 
> I wanted to test it and noticed we have a regression in sockamp in
> bpf-next @ 831c4b3f39c7:

All fixed in bpf, for testing pls use this tree until we have it over in bpf-next.

Thanks,
Daniel

