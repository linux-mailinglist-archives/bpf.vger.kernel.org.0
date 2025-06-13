Return-Path: <bpf+bounces-60605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE62AD8EB3
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 16:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D453BA6F9
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 14:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B437818FC91;
	Fri, 13 Jun 2025 13:57:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4930D293C4B
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749823054; cv=none; b=Ask+7euMY3t0P5mBWkvG2ArkPPCc5WTI5xbzW6xWen2FyU1orAJYK9hd763IoUIODcbZB4Cko/5r9nEOtaE0aUSgNI/t9zsyuHQn7IR0HvKMyTsSpaCPlSw3Tp7dSiL0m1e3ES48OPKAkai6f+AsUBUZGv4FV+iwAMPB2C1nJh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749823054; c=relaxed/simple;
	bh=ToXcPYeuvm1yVWWqqIY0L6WjLsn640htLNF4SS5O/GU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JxKVolVmxDq/DcVO93WYhtsuVYdPqjhnSZmWTadwv+0uf813KOPYxjKGpQNwRxB6RBZpbJkt5PEgJpfDrA1BjFFFQRinUlihI6nzXGAzH7FoMbK2iY7b/rB8Zbf1p5xKehuLHNAUfqsbmDabqSBwFd2YfsIxpFYxDR90QNZXtms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bJgv84X1RzYQv4T
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 21:57:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9A18C1A11F9
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 21:57:23 +0800 (CST)
Received: from [10.174.177.163] (unknown [10.174.177.163])
	by APP2 (Coremail) with SMTP id Syh0CgCHj2I_Lkxo9SUbPQ--.38423S2;
	Fri, 13 Jun 2025 21:57:23 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: Implement bpf mem allocator dtor
 for hash map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
References: <20250526062555.1106061-1-houtao@huaweicloud.com>
 <20250526062555.1106061-3-houtao@huaweicloud.com>
 <CAADnVQLH3Ut8dF9t=_zB4acbZYuN=9+fgsACossGqFVTPO6EaQ@mail.gmail.com>
 <137a5a3f-c571-5ade-7ea1-d224ec6b36f0@huaweicloud.com>
 <CAADnVQLBsYU0xysuqzbZCKbSZP=CLdc8FPaMsvxtrwApwVT6EQ@mail.gmail.com>
 <7e0125a1-0a74-8afe-6278-3d3a4387f153@huaweicloud.com>
 <CAADnVQKYR+m03PuOUww=Gvxd3BAQGg1-0ekuf+h_Dc+d7X5tOQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <90fb26c5-0b75-8809-f7bf-368adaf64452@huaweicloud.com>
Date: Fri, 13 Jun 2025 21:57:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQKYR+m03PuOUww=Gvxd3BAQGg1-0ekuf+h_Dc+d7X5tOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgCHj2I_Lkxo9SUbPQ--.38423S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFWkGw4kKr1xur1fXF1DZFb_yoWDCrX_ZF
	WkC3ykJa15Xa47tF1YkrZ7urnrC3y5Z34xGr1xJr1xJryrJaykuFs0qFsIvF4fKFWvqwnr
	JFZIvF9Iqw13WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 6/5/2025 1:55 AM, Alexei Starovoitov wrote:
> On Mon, Jun 2, 2025 at 9:01 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> Maybe adding a
>>>> bit flag to the pointer of the element to indicate that it has been
>>>> destroyed is OK ? Will try it in the next revision.
>>> Not sure what you have in mind.
>> Er. I was just wondering that if it is possible to the bit 0 of the
>> element pointer to indicate that the element has been destroyed,
>> therefore, the second invocation of dtor can be avoided.
> but the element was deleted from htab bucket,
> so what pointer will you tag with extra bit?

Sorry for the late reply. Had a lot of work recently. I was thinking
that when the pointer has been freed through bpf_mem_cache_free(), the
pointer would be tracked in llist_node. It would be possible to reuse
the bit 0 of ->first and ->next of the lockless list to indicate whether
the pointed pointer has already been destroyed or not.  After the second
thought, that would need to duplicate each lockless list API and may not
worth it.


