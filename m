Return-Path: <bpf+bounces-42630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 286079A6AFE
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 15:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75861F228E5
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 13:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4B81F9405;
	Mon, 21 Oct 2024 13:50:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6131F893A
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518614; cv=none; b=Y6UBFNczMb4GUm04tWZ2nQakN/VK/KsH2oBYvU6sas3dEK7bPRj4n9iNGTcjl6V7ExjlAasj72XKYYPVu1VZQyPr1dTXqVhU6WnXKI1wJnY6qawFfsaWWoPi3lkySz2MLgJrP331ATda2Rl/j0YwaasoEwTDhvnkSdXh2nMLoXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518614; c=relaxed/simple;
	bh=5WLQWToZ5AsifC6etORXOGgM9Kaj16G2D3nh/bpxYCg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=A8Rf49rF2sjhOqt0JHWWeNof6aZcoZBLt40rsE5erAhmjfLg6gos1yuaAZoZ/IwXrDv6i8kMMfSddGbEDt7yuvPVzZSmJSUFU2BxWUWqmq3grgmOgeq7Nt/cljV08MpsZgy/v/gUT0Ialt6CnSzn8URUuORyb2IwaBEBBwlgaFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XXGrw17N3z4f3jXp
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 21:49:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7E77D1A0568
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 21:50:09 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgC36sYQXBZnwU_hEg--.59305S2;
	Mon, 21 Oct 2024 21:50:09 +0800 (CST)
Subject: Re: [PATCH bpf-next 05/16] bpf: Support map key with dynptr in
 verifier
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
 xukuohai@huawei.com
References: <20241008091501.8302-1-houtao@huaweicloud.com>
 <20241008091501.8302-6-houtao@huaweicloud.com>
 <39fb92adbad5bacbc2ca9653d346c28ed2e9b3d9.camel@gmail.com>
 <48e8edfd45dced67c32866b8d669bc49d2d01988.camel@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <82767730-9292-eea0-87eb-d88e51b8c469@huaweicloud.com>
Date: Mon, 21 Oct 2024 21:50:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <48e8edfd45dced67c32866b8d669bc49d2d01988.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgC36sYQXBZnwU_hEg--.59305S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr4xJr1xXr1UtFWxtF1fZwb_yoWfWFbEyr
	45Zr95Gwn5WFWDAFnxGa13WF4ktr47AF90qas0qrW7A34fXas5C39xXF9ruF1xG3W2yr12
	9FnIga9rJ3sa9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbakYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUrsqXDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 10/11/2024 4:57 AM, Eduard Zingerman wrote:
> On Thu, 2024-10-10 at 13:30 -0700, Eduard Zingerman wrote:
>
> [...]
>
>> The logic of this patch looks correct, however I find it cumbersome.
>> The only place where access to dynptr key is allowed is 'case ARG_PTR_TO_MAP_KEY'
>> in check_func_arg(), a lot of places are modified to facilitate this.
>> It seems that logic would be easier to follow if there would be a
>> dedicated function to check dynptr key constraints, called only for
>> the 'case ARG_PTR_TO_MAP_KEY'. This would als make 'struct dynptr_key_state'
>> unnecessary as this state would be tracked inside such function.
>> Wdyt?
> Just realized that change to check_stack_range_initialized would still
> be necessary, as it forbids dynptr access at the moment. Unfortunate.
Thanks for the suggestion. Will check later whether a cleaner way is
available or not.


