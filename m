Return-Path: <bpf+bounces-77543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B96CEAC2A
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 23:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 396B630194EA
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 22:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C50328A72B;
	Tue, 30 Dec 2025 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gi38zzrl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23501632E7;
	Tue, 30 Dec 2025 22:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767132700; cv=none; b=GBkQ3/WEPipSehSNma7OXkFQG/79KR2lZWlLKZViFFXYDaxI9RTls7cet5Pncba5eUzDScIGyge4ZYV8JiB75SDW6FZLhnGX1el+aWzPFfcP9OaaLuEtFa2dJ7lYvDiKmagOgRlnFOiB3KSXlwHi+cykXr4y8KqDuOqZE6TG3Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767132700; c=relaxed/simple;
	bh=sEX5Qd34F0vADKv9539mMhP7OekiQmLbWsEzlxZOxr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSo1h7jPmdz498Xfm7FzuL0SjEPbnhBwHJrZistQzjjHD6UsSgc0HOPQvUkTMOBKmNfWGzzG9bpm0Hno2nQrFwOM7b0Yi3v8XRQTkdM75OAJUIXvQRipFOhufdeE3xxti40ZUk58Ln79v1636TCX+2nHEr+hQm3SV6TaESUyb9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gi38zzrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612A5C4CEFB;
	Tue, 30 Dec 2025 22:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767132700;
	bh=sEX5Qd34F0vADKv9539mMhP7OekiQmLbWsEzlxZOxr4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gi38zzrluTiM584p85J26cOul3/Zjw/zg0uvLK0ccizyIDyj+fE1dBC3sECIbUUo/
	 tT05nzbtwzEOad4/+5xKVQfPgmWOnI/rQVTcCnvA/aSBvQCTT3NW0tjX/dgJILMzTQ
	 /j1NzzLwXmweMNVxl2vxAoZwu75bYYgq+UC1/ickFPist598DyFdlUfQ2Lcjccc0gr
	 FCQt1dtCKPtNzbKourR3VZ1lIEeB7avE+sWXjncbIKymw1zVemwwlaoFjUFP/hyAzT
	 skqZj7QcUbncIr6VevIGNZ1PHKwIQRgXQTRXsHJobMSdeGbU2iq/P2D88ch6NvdiOX
	 Bes8Ah50WAfow==
Message-ID: <86b3f8af-299a-4ae7-b2dc-0b068046fe92@kernel.org>
Date: Tue, 30 Dec 2025 23:11:31 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] buildid: validate page-backed file before parsing build
 ID
To: Andrew Morton <akpm@linux-foundation.org>,
 Jinchao Wang <wangjinchao600@gmail.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 syzbot+e008db2ac01e282550ee@syzkaller.appspotmail.com,
 Axel Rasmussen <axelrasmussen@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Michal Hocko <mhocko@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Wei Xu <weixugc@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Omar Sandoval <osandov@fb.com>,
 Deepanshu Kartikey <kartikey406@gmail.com>
References: <20251223103214.2412446-1-wangjinchao600@gmail.com>
 <20251223092932.0a804e046fc2e5de236ced69@linux-foundation.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251223092932.0a804e046fc2e5de236ced69@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/23/25 18:29, Andrew Morton wrote:
> On Tue, 23 Dec 2025 18:32:07 +0800 Jinchao Wang <wangjinchao600@gmail.com> wrote:
> 
>> __build_id_parse() only works on page-backed storage.  Its helper paths
>> eventually call mapping->a_ops->read_folio(), so explicitly reject VMAs
>> that do not map a regular file or lack valid address_space operations.
>>
>> Reported-by: syzbot+e008db2ac01e282550ee@syzkaller.appspotmail.com
>> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
>>
>> ...
>>
>> --- a/lib/buildid.c
>> +++ b/lib/buildid.c
>> @@ -280,7 +280,10 @@ static int __build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
>>   	int ret;
>>   
>>   	/* only works for page backed storage  */
>> -	if (!vma->vm_file)
>> +	if (!vma->vm_file ||
>> +	    !S_ISREG(file_inode(vma->vm_file)->i_mode) ||
>> +	    !vma->vm_file->f_mapping->a_ops ||
>> +	    !vma->vm_file->f_mapping->a_ops->read_folio)
>>   		return -EINVAL;

Just wondering, we are fine with MAP_PRIVATE files, right? I guess it's 
not about the actual content in the VMA (which might be different for a 
MAP_PRIVATE VMA), but only about the content of the mapped file.


LGTM, although I wonder whether some of these these checks should be 
exposed as part of the read_cache_folio()/do_read_cache_folio() API.

Like, having a helper function that tells us whether we can use 
do_read_cache_folio() against a given mapping+file.

-- 
Cheers

David

