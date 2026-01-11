Return-Path: <bpf+bounces-78493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D13CD0EB33
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 12:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68F0E300E166
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 11:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82320331218;
	Sun, 11 Jan 2026 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXlziS46"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F80F3A1DB;
	Sun, 11 Jan 2026 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768131142; cv=none; b=FqBYryUK+e2acX+CUtMt/IDWM44V/b2vJBxDL3Xxr7dJcpjCXimDCzBuixzHaZvz/bAW1cqvvfWoEJDr6XdlMZjRDKpBg0A4L6wgkPRhR1yUvb81QHO2qGW49xnVdInZ3DxRcLmvNyQcqRQUareTk2nrGhZxyUq3M+TdEUBkiFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768131142; c=relaxed/simple;
	bh=7ouPXljRdS3wEh7LWykxzjsCuZAvXUsWhsf54tJGDaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/wnAoDii3gi611/5YhXZmpsnGwP99LEWCS4Kp/36/VuWgd9MVxzn3p7K017+g9pXIDfDiXaQbBYKDVPx/C6NKWkvtp9730VSAgJOcVIwZ/7tlrmA0Q2DwibAunAOXB3XLy5aoFfaWmpuKM6tY9SG5k1fUqFFsMWLn3+JR8a4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXlziS46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1169CC4CEF7;
	Sun, 11 Jan 2026 11:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768131141;
	bh=7ouPXljRdS3wEh7LWykxzjsCuZAvXUsWhsf54tJGDaY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pXlziS46JbQtb4obUeCUECjyqyJEr5ZyH9nT5h4jLiAn/widU8KKyug6r0Wl1Ti+W
	 PiGyBqzBXkSvyvo3laN4Pl4cBsaQOg8P+a8T6Oxr9VziYksODwviTnIPhLaadPQ/H6
	 sF0+N5pbr0PuiJ0TAN5xD8THer42SZvOSRYv6heBjoE0sF/Cy1F+/cZr10v/RTiDlk
	 NUNqU6fCZmfY7WoW1uq/8U5HPTI9v0KMPNgsMZvA9Csqg/D33YK1fyNmzB8A1QQa+P
	 z6b2WH1VkuF8OrL1v12ThaON4SRFgn0yYPvAUI6J1hcZBJg11Mfk/Lri7szuR8klly
	 of9GEpYkhJZUg==
Message-ID: <95f3dae0-fc8c-43a8-aa37-8393e66cc75b@kernel.org>
Date: Sun, 11 Jan 2026 12:32:13 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] buildid: validate page-backed file before parsing build
 ID
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jinchao Wang <wangjinchao600@gmail.com>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
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
 <86b3f8af-299a-4ae7-b2dc-0b068046fe92@kernel.org>
 <CAEf4BzaozamTRoK8YromvPZ3b1wNBvxwWrbpfpX4ZFwkMDbMGg@mail.gmail.com>
 <b15ad63d-100e-4326-961b-5cb2de3332d8@kernel.org>
 <CAEf4BzaRABPLFV-tVXqCrAgd07nkvcqNA-QZqt8RvSLcmu16mQ@mail.gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAa2VybmVsLm9yZz7CwY0EEwEIADcWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCaKYhwAIbAwUJJlgIpAILCQQVCgkIAhYCAh4FAheAAAoJEE3eEPcA/4Naa5EP/3a1
 9sgS9m7oiR0uenlj+C6kkIKlpWKRfGH/WvtFaHr/y06TKnWn6cMOZzJQ+8S39GOteyCCGADh
 6ceBx1KPf6/AvMktnGETDTqZ0N9roR4/aEPSMt8kHu/GKR3gtPwzfosX2NgqXNmA7ErU4puf
 zica1DAmTvx44LOYjvBV24JQG99bZ5Bm2gTDjGXV15/X159CpS6Tc2e3KvYfnfRvezD+alhF
 XIym8OvvGMeo97BCHpX88pHVIfBg2g2JogR6f0PAJtHGYz6M/9YMxyUShJfo0Df1SOMAbU1Q
 Op0Ij4PlFCC64rovjH38ly0xfRZH37DZs6kP0jOj4QdExdaXcTILKJFIB3wWXWsqLbtJVgjR
 YhOrPokd6mDA3gAque7481KkpKM4JraOEELg8pF6eRb3KcAwPRekvf/nYVIbOVyT9lXD5mJn
 IZUY0LwZsFN0YhGhQJ8xronZy0A59faGBMuVnVb3oy2S0fO1y/r53IeUDTF1wCYF+fM5zo14
 5L8mE1GsDJ7FNLj5eSDu/qdZIKqzfY0/l0SAUAAt5yYYejKuii4kfTyLDF/j4LyYZD1QzxLC
 MjQl36IEcmDTMznLf0/JvCHlxTYZsF0OjWWj1ATRMk41/Q+PX07XQlRCRcE13a8neEz3F6we
 08oWh2DnC4AXKbP+kuD9ZP6+5+x1H1zEzsFNBFXLn5EBEADn1959INH2cwYJv0tsxf5MUCgh
 Cj/CA/lc/LMthqQ773gauB9mN+F1rE9cyyXb6jyOGn+GUjMbnq1o121Vm0+neKHUCBtHyseB
 fDXHA6m4B3mUTWo13nid0e4AM71r0DS8+KYh6zvweLX/LL5kQS9GQeT+QNroXcC1NzWbitts
 6TZ+IrPOwT1hfB4WNC+X2n4AzDqp3+ILiVST2DT4VBc11Gz6jijpC/KI5Al8ZDhRwG47LUiu
 Qmt3yqrmN63V9wzaPhC+xbwIsNZlLUvuRnmBPkTJwwrFRZvwu5GPHNndBjVpAfaSTOfppyKB
 Tccu2AXJXWAE1Xjh6GOC8mlFjZwLxWFqdPHR1n2aPVgoiTLk34LR/bXO+e0GpzFXT7enwyvF
 FFyAS0Nk1q/7EChPcbRbhJqEBpRNZemxmg55zC3GLvgLKd5A09MOM2BrMea+l0FUR+PuTenh
 2YmnmLRTro6eZ/qYwWkCu8FFIw4pT0OUDMyLgi+GI1aMpVogTZJ70FgV0pUAlpmrzk/bLbRk
 F3TwgucpyPtcpmQtTkWSgDS50QG9DR/1As3LLLcNkwJBZzBG6PWbvcOyrwMQUF1nl4SSPV0L
 LH63+BrrHasfJzxKXzqgrW28CTAE2x8qi7e/6M/+XXhrsMYG+uaViM7n2je3qKe7ofum3s4v
 q7oFCPsOgwARAQABwsF8BBgBCAAmAhsMFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAmic2qsF
 CSZYCKEACgkQTd4Q9wD/g1oq0xAAsAnw/OmsERdtdwRfAMpC74/++2wh9RvVQ0x8xXvoGJwZ
 rk0Jmck1ABIM//5sWDo7eDHk1uEcc95pbP9XGU6ZgeiQeh06+0vRYILwDk8Q/y06TrTb1n4n
 7FRwyskKU1UWnNW86lvWUJuGPABXjrkfL41RJttSJHF3M1C0u2BnM5VnDuPFQKzhRRktBMK4
 GkWBvXlsHFhn8Ev0xvPE/G99RAg9ufNAxyq2lSzbUIwrY918KHlziBKwNyLoPn9kgHD3hRBa
 Yakz87WKUZd17ZnPMZiXriCWZxwPx7zs6cSAqcfcVucmdPiIlyG1K/HIk2LX63T6oO2Libzz
 7/0i4+oIpvpK2X6zZ2cu0k2uNcEYm2xAb+xGmqwnPnHX/ac8lJEyzH3lh+pt2slI4VcPNnz+
 vzYeBAS1S+VJc1pcJr3l7PRSQ4bv5sObZvezRdqEFB4tUIfSbDdEBCCvvEMBgoisDB8ceYxO
 cFAM8nBWrEmNU2vvIGJzjJ/NVYYIY0TgOc5bS9wh6jKHL2+chrfDW5neLJjY2x3snF8q7U9G
 EIbBfNHDlOV8SyhEjtX0DyKxQKioTYPOHcW9gdV5fhSz5tEv+ipqt4kIgWqBgzK8ePtDTqRM
 qZq457g1/SXSoSQi4jN+gsneqvlTJdzaEu1bJP0iv6ViVf15+qHuY5iojCz8fa0=
In-Reply-To: <CAEf4BzaRABPLFV-tVXqCrAgd07nkvcqNA-QZqt8RvSLcmu16mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/10/26 00:43, Andrii Nakryiko wrote:
> On Tue, Jan 6, 2026 at 11:16 AM David Hildenbrand (Red Hat)
> <david@kernel.org> wrote:
>>
>> On 1/5/26 23:52, Andrii Nakryiko wrote:
>>> On Tue, Dec 30, 2025 at 2:11 PM David Hildenbrand (Red Hat)
>>> <david@kernel.org> wrote:
>>>>
>>>> On 12/23/25 18:29, Andrew Morton wrote:
>>>>> On Tue, 23 Dec 2025 18:32:07 +0800 Jinchao Wang <wangjinchao600@gmail.com> wrote:
>>>>>
>>>>>> __build_id_parse() only works on page-backed storage.  Its helper paths
>>>>>> eventually call mapping->a_ops->read_folio(), so explicitly reject VMAs
>>>>>> that do not map a regular file or lack valid address_space operations.
>>>>>>
>>>>>> Reported-by: syzbot+e008db2ac01e282550ee@syzkaller.appspotmail.com
>>>>>> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
>>>>>>
>>>>>> ...
>>>>>>
>>>>>> --- a/lib/buildid.c
>>>>>> +++ b/lib/buildid.c
>>>>>> @@ -280,7 +280,10 @@ static int __build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
>>>>>>        int ret;
>>>>>>
>>>>>>        /* only works for page backed storage  */
>>>>>> -    if (!vma->vm_file)
>>>>>> +    if (!vma->vm_file ||
>>>>>> +        !S_ISREG(file_inode(vma->vm_file)->i_mode) ||
>>>>>> +        !vma->vm_file->f_mapping->a_ops ||
>>>>>> +        !vma->vm_file->f_mapping->a_ops->read_folio)
>>>>>>                return -EINVAL;
>>>>
>>>> Just wondering, we are fine with MAP_PRIVATE files, right? I guess it's
>>>> not about the actual content in the VMA (which might be different for a
>>>> MAP_PRIVATE VMA), but only about the content of the mapped file.
>>>
>>> Yep, this code is fetching contents of a file that backs given VMA.
>>
>> Good!
>>
>>>
>>>>
>>>>
>>>> LGTM, although I wonder whether some of these these checks should be
>>>> exposed as part of the read_cache_folio()/do_read_cache_folio() API.
>>>>
>>>> Like, having a helper function that tells us whether we can use
>>>> do_read_cache_folio() against a given mapping+file.
>>>
>>> I agree, this seems to be leaking a lot of internal mm details into
>>> higher-level caller (__build_id_parse). Right now we try to fetch
>>> folio with filemap_get_folio() and if that succeeds, then we do
>>> read_cache_folio. Would it be possible for filemap_get_folio() to
>>> return error if the folio cannot be read using read_cache_folio()? Or
>>> maybe have a variant of filemap_get_folio() that would have this
>>> semantic?
>>
>> Good question. But really, for files that always have everything in the pagecache,
>> there would not be a problem, right? I'm thinking about hugetlb, for example.
>>
>> There, we never expect to fallback to do_read_cache_folio().
>>
>> So maybe we could just teach do_read_cache_folio() to fail properly?
>>
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index ebd75684cb0a7..3f81b8481af4c 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -4051,8 +4051,11 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
>>           struct folio *folio;
>>           int err;
>>
>> -       if (!filler)
>> +       if (!filler) {
>> +               if (!mapping->a_ops || !mapping->a_ops->read_folio)
>> +                       return ERR_PTR(-EINVAL);
>>                   filler = mapping->a_ops->read_folio;
>> +       }
>>    repeat:
>>           folio = filemap_get_folio(mapping, index);
>>           if (IS_ERR(folio)) {
>>
>> Then __build_id_parse() would only check for the existence of vma->vm_file and maybe
>> the !S_ISREG(file_inode(vma->vm_file)->i_mode).
>>
> 
> That would be great. But something like this was proposed earlier and
> Matthew didn't particularly like this approach ([0]).
> 
>    [0] https://lore.kernel.org/all/aReUv1kVACh3UKv-@casper.infradead.org/

Well, but on the higher level we don't know whether we have to even call 
into read_cache_folio().

Again, hugetlb. Might be worth reproducing with hugetlb/shmem, and 
making sure it keeps working even with your changes.

-- 
Cheers

David

