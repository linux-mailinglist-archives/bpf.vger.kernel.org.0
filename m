Return-Path: <bpf+bounces-71659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0794BF9A0B
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 03:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278FD467116
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 01:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC1C1F2380;
	Wed, 22 Oct 2025 01:42:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C42486340
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 01:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761097359; cv=none; b=sSrdVkCFATerCQyxuyZxOtIeJUL9apUWDtP1/D1vqNGhoIJHyy9Q7eWRBzZSc//Yu8Kty1Fj6p1FQwzQWLElCHrBrIepklxD+X0aaXHiXXkKPfvNGSZbr0llcHIZQQUWOzQUTwlCBetWiKSH/jpjoyER1gaRPH8mx/cU54Dj2LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761097359; c=relaxed/simple;
	bh=qdiR0z9SHsQoXpjwKzhusUIhqpSOlh82dOkUUtybjLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6eWNpgVdqh+V9iJA9uH1P1D6LfEXhB2XaXIJe1KgWOir/BDKgFB7f7I5x/K2nRT+HUWnzNPBVp0rz5sdEu5iNEjZCo2hhabVru6M1LZf4NANQBCbbtZ3u6xOT8ahCWG6xE/SG9nfc+YBgnO+i+UVhBtri2GQJxi6IVJJrnedno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrABnmsp9NvhotHa5BA--.6936S2;
	Wed, 22 Oct 2025 09:42:21 +0800 (CST)
Received: from [58.206.214.186] (unknown [58.206.214.186])
	by gateway (Coremail) with SMTP id _____wAXH5t7NvhoIiOCAw--.47875S2;
	Wed, 22 Oct 2025 09:42:20 +0800 (CST)
Message-ID: <034fed44-2640-4338-8f7a-89a4c9c4af6f@hust.edu.cn>
Date: Wed, 22 Oct 2025 09:42:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Information Leakage via Type Confusion in bpf_snprintf_btf()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
 dzm91@hust.edu.cn, M202472210@hust.edu.cn,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
References: <636d45a8-cdc4-46ce-b1cb-6d2e4e3226ae@hust.edu.cn>
 <CAADnVQLFuMAYHXXd_=2ebnhsE_tECKrVcLwuOt9b0dK4-Ww+gQ@mail.gmail.com>
From: Yinhao Hu <dddddd@hust.edu.cn>
In-Reply-To: <CAADnVQLFuMAYHXXd_=2ebnhsE_tECKrVcLwuOt9b0dK4-Ww+gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrABnmsp9NvhotHa5BA--.6936S2
Authentication-Results: app1; spf=neutral smtp.mail=dddddd@hust.edu.cn
	;
X-Coremail-Antispam: 1UD129KBjvdXoW7GFy8AFWfGr4DuF1Dtr4xWFg_yoW3Wwb_Z3
	y7Wr47Jwn0va43JF4Skwsavry7Ca1vyrWUX3y5Zwn7GFyfJayfurn3GFZ7Z3s3tr4kXrnI
	9wn5X3ykA3sxKjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkxYjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jr
	v_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r4UJVWxJr1lYx0E74AGY7Cv6c
	x26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcV
	Cjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
	XVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU0KNt3UUUUU==
X-CM-SenderInfo: bgsqjkiyqyjko6kx23oohg3hdfq/

Hi,

Thank you for reviewing our report.
We have verified the content in the report. Could you please point out 
which specific part caused confusion? We would be happy to provide 
additional details or clarification.

On 10/22/25 2:08 AM, Alexei Starovoitov wrote:
> On Sun, Oct 19, 2025 at 8:24 PM Yinhao Hu <dddddd@hust.edu.cn> wrote:
>>
>> Our fuzzer tool discovered a type confusion vulnerability in the
>> `bpf_snprintf_btf()` helper function within the Linux kernel's BPF
>> subsystem. This vulnerability allows BPF programs with `CAP_SYS_ADMIN`
>> to leak kernel memory by constructing fake `btf_ptr` structures with
>> user-controlled addresses.
> 
> Do you proofread what AI generates for you?
> Please do. It's hard to take your reports seriously.


