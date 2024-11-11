Return-Path: <bpf+bounces-44514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F069C3EF4
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 13:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C63328597B
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 12:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413CF1B4F07;
	Mon, 11 Nov 2024 12:55:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D494A19DF66;
	Mon, 11 Nov 2024 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329703; cv=none; b=bm9mwuMmNSltZEna0RbNmr1apC33M14JXFbyQYE4UKDHm02u4zPuTcwgh40Q5wwh+aNKCc5RskpWG1KQy44MCLa7B44IVYxStBzAQ8si/7mVU8n4RIi+uK81Vvsv20id5iO5Lz34IO8VMmv5lg/mMVAP3buQULS9qQ0R0h1e/xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329703; c=relaxed/simple;
	bh=FrwN6f/ivVvtDxoAVtk1Dom0WhPT+xE8kKmmrcZbIsI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jR0Iys4qnKPweIBx63CRRED68fCQ4F0gv2x/0Xi61h9lbqKe5asWWLr5gBnyvkYN+e+p+BK3h3Y4rZvrKM/KECrc/ItANGTvpM7jBr6lkVMx0kSU7Moj0wSWpnagvt+YX5m72Ys7x0lDYhRharv4KQvjjqeLVLyA2XjKGaILosA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xn8dW4462z4f3nTB;
	Mon, 11 Nov 2024 20:54:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9839B1A0359;
	Mon, 11 Nov 2024 20:54:58 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgDHb7Gf_jFn1hfNBQ--.13673S2;
	Mon, 11 Nov 2024 20:54:56 +0800 (CST)
Message-ID: <1483d9ce-4929-4abb-8a5f-bd91abeeace6@huaweicloud.com>
Date: Mon, 11 Nov 2024 20:54:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/2] Add kernel symbol for struct_ops
 trampoline
Content-Language: en-US
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
References: <20241111121641.2679885-1-xukuohai@huaweicloud.com>
In-Reply-To: <20241111121641.2679885-1-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDHb7Gf_jFn1hfNBQ--.13673S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWrZw1kJF1rKFykuFyDKFg_yoW8GryUpa
	yruwn8Zr40grZF93yfWayUCFWfKa1kXF15ur9rJ34fAFy2qr1DGr1jgr43urWagr9ak34r
	JF909FyvkFyjvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 11/11/2024 8:16 PM, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> Add kernel symbol for struct_ops trampoline.
> 
> Without kernel symbol for struct_ops trampoline, the unwinder may
> produce unexpected stacktraces. For example, the x86 ORC and FP
> unwinder stops stacktrace on a struct_ops trampoline address since
> there is no kernel symbol for the address.
> 
> v3:
> - Add a separate cleanup patch to replace links_cnt with funcs_cnt
> - Allocate ksyms on-demand in update_elem() to stay with the links
>    allocation way
> - Set ksym name to prog__<struct_ops_name>_<member_name>
> 
> v2: https://lore.kernel.org/bpf/20241101111948.1570547-1-xukuohai@huaweicloud.com/
> - Refine the commit message for clarity and fix a test bot warning
> 
> v1: https://lore.kernel.org/bpf/20241030111533.907289-1-xukuohai@huaweicloud.com/
> 
> Xu Kuohai (2):
>    bpf: Use function pointers count as struct_ops links count
>    bpf: Add kernel symbol for struct_ops trampoline
> 
>   include/linux/bpf.h         |   3 +-
>   kernel/bpf/bpf_struct_ops.c | 114 ++++++++++++++++++++++++++++++++----
>   kernel/bpf/dispatcher.c     |   3 +-
>   kernel/bpf/trampoline.c     |   9 ++-
>   4 files changed, 114 insertions(+), 15 deletions(-)
> 

Oops, I messed up the code in v2, the argument for
bpf_image_ksym_add in v3 is not correct.

Sorry for the noise.


