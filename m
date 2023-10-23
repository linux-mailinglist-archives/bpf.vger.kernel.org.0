Return-Path: <bpf+bounces-13010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECB47D3A08
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 16:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04745B20EA2
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 14:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6860E1A280;
	Mon, 23 Oct 2023 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="H+gPMoKS"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B411805C;
	Mon, 23 Oct 2023 14:46:59 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C7B171B;
	Mon, 23 Oct 2023 07:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=1u1Kl8+jTBlvjcn5Y8E8suLdFi2oN6a+RJ6jIb/EgK8=; b=H+gPMoKSVW3s9FuBVaBw/l/SHU
	FI4AWeCHareKm6BrnWAb3ITLdzyyv1jI2wY37l8HTgn8iLvnOeW/k48jaM6ssKXY1WKaHmhQ9rZUT
	4LpQxc9zOmnvUOseKpC3w97WKjk7SfhmHq/YlNJ31NL1NrDVr3heZinKFhKsXZFu6ccNRtzhnSzYy
	VaotKR9z61ytjAZmW7rMSRI7EHdZqs+UQKWMA61QqYGJf7WAd4G7FEB11XnKmI3707x2eGvB2qHdY
	Q+RpDyGasjIsytMKcAZHdbooRJyCVNKnsmnzAvpiXkED/idb7cVJ5WVYfJZf9lzHDVGlBwBt/8Bc5
	6Fkn9OUQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1quwCl-0008pD-HT; Mon, 23 Oct 2023 16:46:55 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1quwCl-000FBQ-3y; Mon, 23 Oct 2023 16:46:55 +0200
Subject: Re: [PATCH bpf-next v2 4/7] bpftool: Implement link show support for
 netkit
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
 bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, martin.lau@linux.dev, razor@blackwall.org,
 ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com, sdf@google.com,
 Quentin Monnet <quentin@isovalent.com>
References: <20231019204919.4203-1-daniel@iogearbox.net>
 <20231019204919.4203-5-daniel@iogearbox.net> <87lebtqusi.fsf@toke.dk>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <813f501e-34b9-c46b-fc6f-1e927458a743@iogearbox.net>
Date: Mon, 23 Oct 2023 16:46:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87lebtqusi.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27070/Mon Oct 23 09:53:01 2023)

On 10/23/23 4:26 PM, Toke Høiland-Jørgensen wrote:
> Daniel Borkmann <daniel@iogearbox.net> writes:
> 
>> Add support to dump netkit link information to bpftool in similar way as
>> we have for XDP. The netkit link info only exposes the ifindex.
>>
>> Below shows an example link dump output, and a cgroup link is included for
>> comparison, too:
>>
>>    # bpftool link
>>    [...]
>>    10: cgroup  prog 2466
>>          cgroup_id 1  attach_type cgroup_inet6_post_bind
>>    [...]
>>    8: netkit  prog 35
>>          ifindex nk1(18)
>>    [...]
> 
> Couldn't we make this show whether the program is attached as
> primary/peer as well? Seems like that would be useful (like in the
> cgroup output above)?

Makes sense, will add it.

Thanks,
Daniel

