Return-Path: <bpf+bounces-45695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE4F9DA376
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 09:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CB5BB250AC
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 08:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB9C15534D;
	Wed, 27 Nov 2024 08:02:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5439F1272A6
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 08:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732694530; cv=none; b=tvNpnzXyfb7CP6giRpgcV19VY0jFNbbZ/OrGGDOoSbTgY/0kqGehRgKGECXKWFCAvmGiVLGzdaDYPAvwTQgp4BncdHsaG4EDPI/DPO4ryvcA9Sj8+h4chDFsOSi8JP6M3ighXGVj7AngM18Yu0lPeE5egJynfPom509Tnc7WVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732694530; c=relaxed/simple;
	bh=QuB6BIr70LSl/hvFeY5snoPt6jdb+5U2KaSfOJ3UDuk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CglJzHO0i618jTMT5kTI/P9MTbSWMxfOsQ5sjI6xnOsTMEotuXIveT0f8oKEoVIywvx7S+PYFAk362gpQa+V+KdRSvEpGTVF4qzd5ipB5yDkfyedKYDxKicqIctVggIldZHw0KHjBfHb+WAenWyJfAEznvF4zcYMFcVLh44N/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XysN85v6lz4f3nJm
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 16:01:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 891071A0196
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 16:02:04 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgB3bK740UZnryyUCw--.33756S2;
	Wed, 27 Nov 2024 16:02:04 +0800 (CST)
Subject: Re: [PATCH bpf v2 9/9] selftests/bpf: Add more test cases for LPM
 trie
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=c3=9fschuh?=
 <linux@weissschuh.net>, Hou Tao <houtao1@huawei.com>,
 Xu Kuohai <xukuohai@huawei.com>
References: <20241127004641.1118269-1-houtao@huaweicloud.com>
 <20241127004641.1118269-10-houtao@huaweicloud.com>
 <CAADnVQKdgyaC2C6cWxjhrQrrkxGeNYfg1t6mZDEjXfq_4j4-zg@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <69ebc85f-31b0-83eb-d914-0381bd7ea4c4@huaweicloud.com>
Date: Wed, 27 Nov 2024 16:02:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQKdgyaC2C6cWxjhrQrrkxGeNYfg1t6mZDEjXfq_4j4-zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgB3bK740UZnryyUCw--.33756S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4rtFyfGF4furWfCrWDCFg_yoW3ZwcE9F
	WDurW5Ca9rAw18J3Wakr10qr93ZFW8Cw1j9w15Wr97Za4FqFZ5Jr1UuFn0va92yan5Kasx
	Gr9YvayIqw1avjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbakYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIa0PDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/27/2024 1:39 PM, Alexei Starovoitov wrote:
> On Tue, Nov 26, 2024 at 4:34 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> +
>> +/* Use the fixed prefixlen (32) and save integers in LPM trie. The iteration of
>> + * LPM trie will return these integers in big-endian order, therefore, convert
>> + * these integers to big-endian before update. After each iteration, delete the
>> + * found key (the smallest integer) and expect the next iteration will return
>> + * the second smallest number.
>> + */
> bpf ci doesn't run test_maps on s390. So I hope you're correct.

I verified the test cases in big endian environment in a dumb way.
Firstly converted LPM trie and these newly-added test cases into an
userspace application and run the application through qemu-armeb-static,
so I am sure it is correct.


