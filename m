Return-Path: <bpf+bounces-42641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C879A6B8A
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 16:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FD61C20EA5
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 14:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A401F1315;
	Mon, 21 Oct 2024 14:05:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C837D38DF9
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519534; cv=none; b=CebjElJdS9qzYYc0dd5Ru7fNsx0ILYz95gOczmIOOKP6Px/qlOhVcE1kYcIQw4A0QPZFQRSBeXdHn7aIv1Q8C8rvmWxgvkMOCcBM1r+zeySgMs1Z7pjp7jjkSkk9VWZlg0wA7F9rsfbnIHD255uTEvTl8XL9cQBE9DaUBmZ8630=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519534; c=relaxed/simple;
	bh=Kun5v9o54aa7hlOiXRxiusjB8jgnN8v8K/snek54aPo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Q+WJajDFwsBFxTO/Hb1JH1mbChhuVY7c2v7HieQC71/n7j7epWuested+iYiQXojc40JFPBBIJVu/yyMIIvEjENgNFysRPzk4epiEdYOEhEu/9g4YEzFLLIL0v8RoW7kbS+jTfOjptoyLJLwgLv9K+yXhE90XC6W3QQrzsdZHtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XXHBZ0Zq6z4f3jQv
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 22:05:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6D69A1A08DC
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 22:05:27 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgBHfMikXxZnp1PiEg--.50208S2;
	Mon, 21 Oct 2024 22:05:27 +0800 (CST)
Subject: Re: [PATCH bpf-next 16/16] selftests/bpf: Add test cases for hash map
 with dynptr key
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>,
 Xu Kuohai <xukuohai@huawei.com>
References: <20241008091501.8302-1-houtao@huaweicloud.com>
 <20241008091501.8302-17-houtao@huaweicloud.com>
 <CAADnVQJ-z3eFa06FhvTZc7aOJX3R7=SeoXnmgtQ5TpzGNpZ0KA@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <ecf30c24-4ded-6c45-e436-93205a34b2b1@huaweicloud.com>
Date: Mon, 21 Oct 2024 22:05:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJ-z3eFa06FhvTZc7aOJX3R7=SeoXnmgtQ5TpzGNpZ0KA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgBHfMikXxZnp1PiEg--.50208S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr17Zw1xAryUJryDKw4fGrg_yoWxurg_Ar
	s2vr9xAr4DuasFkan0yF47uw4UAFyFqFyfA34vqrZxA3W5u3ZYywsY9ryjyFZxJrsFqF98
	Kw1fu3Z0vrnFyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU10PfPUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/12/2024 2:23 AM, Alexei Starovoitov wrote:
> On Tue, Oct 8, 2024 at 2:02 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> +
>> +SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
>> +int BPF_PROG(pure_dynptr_key)
> ...
>
>> +SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
>> +int BPF_PROG(mixed_dynptr_key)
> ...
>> +SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
>> +int BPF_PROG(multiple_dynptr_key)
> attaching to syscalls with pid filtering is ok-ish,
> but it's a few unnecessary steps.
> Use tracing prog for non-sleepable and syscall prog for sleepable
> and bpf_prog_run() it.
> More predictable and no need for a pid filter.

Thanks for the suggestion. Will do in v2.


