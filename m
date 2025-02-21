Return-Path: <bpf+bounces-52173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A7AA3F381
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 12:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4610F3BD2A2
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 11:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A14B209F4C;
	Fri, 21 Feb 2025 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="J4o+ey0M"
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0C9202F65;
	Fri, 21 Feb 2025 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138937; cv=none; b=gn2qvIvX2WJQ7DSYSVICbR9EfCsfG+5a5gQS+nD03asjC7kzKVqXMgjii8pIoAJuZfwnAhyqHCyYLHmcP5RQhChXeURUHTW275W34Z9HVqOm1jXXOH8i6pmfYF378fOixYItV6Bk+NyiBIoWJcOGsgK29dKNNEBGMY+0J8D3BRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138937; c=relaxed/simple;
	bh=JC8ogyqOI8xN8zaQhdtMlNxpZBkM46jcluP/sZz9IUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TpGRO7rHeBtUEfBpjazBMxrFpT6HErFXe9rchhOCygk1PAIivuO/s8GIJ9vW5riZlbi/iY6hG8o1fUdJMf0RuE7rQVB8q20sHROStVM2QvKBmwvlWi0Mx5WUcUH06k1mZYTdLL29SLfyAMcGHXItTSTpbH7Eg68yVwP8QRiv4+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=J4o+ey0M; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740138929; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rhCWKZ300d1LYGozeyZzfCVOrsA+uIHUJ8oJ+AoQ8Fw=;
	b=J4o+ey0MdqpYv+khiciAaqTqGoIShlNMfrBa7/8RXZ1N5Q/50PTC96y1nSQjDqFeI6GKpQ0eW7fGmYOZQOM+FKiPAZKG6Nh9GkjllH/hAT/okO2rmlKk4cf3zuc5dXW45HJd+DINg73C8Y5Tm0iQGqvMYg0tWWcLtIW0h+izYZI=
Received: from 30.221.144.133(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WPwJ1x1_1740138927 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Feb 2025 19:55:28 +0800
Message-ID: <365859bd-1457-4f83-91f4-34a7f21e1d8f@linux.alibaba.com>
Date: Fri, 21 Feb 2025 19:55:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipvs: Always clear ipvs_property flag in
 skb_scrub_packet()
To: Julian Anastasov <ja@ssi.bg>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 asml.silence@gmail.com, willemb@google.com, almasrymina@google.com,
 chopps@labn.net, aleksander.lobakin@intel.com, nicolas.dichtel@6wind.com,
 dust.li@linux.alibaba.com, hustcat@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250221013648.35716-1-lulie@linux.alibaba.com>
 <610b255c-51e4-0460-05a2-ab9cd8c43295@ssi.bg>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <610b255c-51e4-0460-05a2-ab9cd8c43295@ssi.bg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/2/21 19:42, Julian Anastasov wrote:
> 
> 	Hello,
> 
> On Fri, 21 Feb 2025, Philo Lu wrote:
> 
>> We found an issue when using bpf_redirect with ipvs NAT mode after
>> commit ff70202b2d1a ("dev_forward_skb: do not scrub skb mark within
>> the same name space"). Particularly, we use bpf_redirect to return
>> the skb directly back to the netif it comes from, i.e., xnet is
>> false in skb_scrub_packet(), and then ipvs_property is preserved
>> and SNAT is skipped in the rx path.
>>
>> ipvs_property has been already cleared when netns is changed in
>> commit 2b5ec1a5f973 ("netfilter/ipvs: clear ipvs_property flag when
>> SKB net namespace changed"). This patch just clears it in spite of
>> netns.
>>
>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
>> ---
>> This is in fact a fix patch, and the issue was found after commit
>> ff70202b2d1a ("dev_forward_skb: do not scrub skb mark within
>> the same name space"). But I'm not sure if a "Fixes" tag should be
>> added to that commit.
> 
> 	You can add 2b5ec1a5f973 as a Fixes tag in v2 and I'll ack it.

Thank you, Julian. You also solve my worries. I'll post v2 soon.

-- 
Philo


