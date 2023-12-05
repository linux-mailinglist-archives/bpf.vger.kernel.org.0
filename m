Return-Path: <bpf+bounces-16816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD3280621A
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 23:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFBFC1F21764
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 22:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93E03FE51;
	Tue,  5 Dec 2023 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r9ffMWiF"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97A81AA
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 14:51:03 -0800 (PST)
Message-ID: <f4f05bf8-37ad-400a-a38d-0a7061f0a4c3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701816661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wapASRO00cRNKqdtZ2K/6g7Ixmbypc8guQWbt1+VBSY=;
	b=r9ffMWiFF9IVsvn9/1aaC57qrxENyZBSkbTotvihKwjmpSMVl8UIMfbwFSEqeEKtUCNpZF
	I3x+74myCNOmDPlb6kBZ6Gl7jerXGc1Fc027Ag8CTYinMuYwKinKFceECq8csKZ5X8IMmq
	+zG/4UveIScpJkNhNt3kby/rBU4+e4Y=
Date: Tue, 5 Dec 2023 14:50:57 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Fix a race condition between btf_put() and
 map_free()
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231204173946.3066377-1-yonghong.song@linux.dev>
 <CAEf4BzbPtSZxJ16E+gQnw7sgfqwJVYsnkUZaxdk=c+65KWgnTg@mail.gmail.com>
 <81d00866-7824-18e5-af71-e0a15a03e84f@huaweicloud.com>
 <513bafac-03fa-4c2f-ba7f-67de96f79a10@linux.dev>
 <6e6feeef-9d81-38c3-4426-42ab12dc9ad3@huaweicloud.com>
 <9a308dc5-6765-4dcb-ba2b-43d257534ca0@linux.dev>
 <CAADnVQL+uc6VV65_Ezgzw3WH=ME9z1Fdy8Pd6xd0oOq8rgwh7g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQL+uc6VV65_Ezgzw3WH=ME9z1Fdy8Pd6xd0oOq8rgwh7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/5/23 4:13 PM, Alexei Starovoitov wrote:
> On Mon, Dec 4, 2023 at 11:01 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>> Er, it is not what I want, although I have written a similar patch in
>>> which bpf_map_put() will call btf_put() and set map->btf as NULL if
>>> there is no BPF_LIST_HEAD and BPF_RB_ROOT fields in map->record,
>>> otherwise calling bpf_put() in bpf_put_free_deferred(). What I have
>>> suggested is to optionally pin btf in graph_root.btf just like
>>> btf_field_kptr does.
>> Okay, I see what you mean. This is actually what I kind of think
>> as well in below to identify *all* cases btf data might be accessed.
>> I didn't explicitly mention this approach in detail but the idea is
>> to get a reference count for btf and later release it during btf_record_free.
>> I think this should work. I need to do an audit then to find other potential
>> places, if exists, to do similar things. The current approach
>> is simpler but looks like we can do better with existing
>> btf_field_kptr approach.
> imo that would be the only correct way to fix it.
> we btf_get(kptr_btf) before saving it kptr.btf in btf_parse_kptr() and
> btf_put() it eventually in btf_record_free().
> graph_root looks buggy.
> It saved the btf pointer in btf_parse_graph_root() without taking refcnt.

Agreed. Just send v3 patch:

https://lore.kernel.org/bpf/20231205224812.813224-1-yonghong.song@linux.dev/


