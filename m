Return-Path: <bpf+bounces-51527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21481A356DA
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 07:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA7D7A5A13
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 06:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9F81DF759;
	Fri, 14 Feb 2025 06:13:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FF913A3EC
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 06:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513609; cv=none; b=o/hFkX3QkHnpMzsS0Zv0JmxJBZKI5Vqk6hC5TrgRLR0r6BfsAAvOPdZRVP2wh77fLfIyuCfUaCRQuY9vO1CGy3ajnqoxKIPpGfgNYpDA0rG1zkI5/t9UO6Sx+TVt3vRSMM7X2I9W7g8wfTyoVznyp9rh2s/MvPWwC2ulswGLKvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513609; c=relaxed/simple;
	bh=PpJmKFdhM7d1FaGcwTUKLfY3IxCS7AnYrTHtnPk8pYk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WMyvqAXjEiHwWzAXzKOcn5FQwFk9Nk8chI3b7OsdT9JjUJNASQ24UUg1xcav8SREJ/kho5SaK4Jn9+x8iZlzaGvdEtg1FbzVZRTw6RkCueQb2ojTcjPrKhthX+mBw88Lu2KD5EbQT8MuXfC2X9EC6D6o4SapkimGzzJnf2ClN4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YvMDK1jnpz4f3jt4
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 14:13:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5B1D11A12F5
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 14:13:21 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgDXhlv93q5nJc80Dw--.54993S2;
	Fri, 14 Feb 2025 14:13:21 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 07/20] bpf: Use map_extra to indicate the max
 data size of dynptrs in map key
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Hou Tao <houtao1@huawei.com>,
 Xu Kuohai <xukuohai@huawei.com>
References: <20250125111109.732718-1-houtao@huaweicloud.com>
 <20250125111109.732718-8-houtao@huaweicloud.com>
 <CAADnVQ+D+eZzLX02XmKCGDFvnxCM_za9pKiCzwkrgzUCShCGTA@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <e61df2a5-d27a-f3f8-8891-48702cc37be5@huaweicloud.com>
Date: Fri, 14 Feb 2025 14:13:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+D+eZzLX02XmKCGDFvnxCM_za9pKiCzwkrgzUCShCGTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgDXhlv93q5nJc80Dw--.54993S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF43Zr4DXFyfXw18KF4xtFb_yoWkArbEvF
	4FkF93twsIy3ZxJF1DKF1rAryjkr4rZr1qvF4DW3s7A3s8Aa97Zrn5ur4Fy3yDKw45ZryU
	GrsFvFWjywnrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/14/2025 2:02 AM, Alexei Starovoitov wrote:
> On Sat, Jan 25, 2025 at 2:59 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> For map with dynptr key support, it needs to use map_extra to specify
>> the maximum data length of these dynptrs. The implementation of the map
>> will check whether map_extra is smaller than the limitation imposed by
>> memory allocation during map creation. It may also use map_extra to
>> optimize the memory allocation for dynptr.
> Why limit it?
> The only piece of code I could find is:
>
> uptr->size > map->map_extra
>
> and it doesn't look necessary.
> Let it consume whatever necessary ?
> .

It will be usable when trying to iterate keys through ->get_next_key()
in kernel (e.g., support map_seq_show_elem in v3), because for now the
data memory for dynptr in the map key is allocated by the caller
(because the callee hold a rcu read lock). If the max length of dynptr
data is unknown, map_iter_alloc()/map_seq_next() may need some logic to
probe the max length of dynptr data during the traversal of keys. Will
check whether or not it is feasible in v3.


