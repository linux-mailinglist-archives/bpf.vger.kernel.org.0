Return-Path: <bpf+bounces-61312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B418AE4D9C
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 21:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9004C3B70C8
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 19:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891F82D4B49;
	Mon, 23 Jun 2025 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PivDLs6E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688151C6FF3;
	Mon, 23 Jun 2025 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750706834; cv=none; b=lFj4jpCfSTNPj0wae7A+P1EbMbw37WJBRPDsi5LaCBSoiEYNIyGJfNaqsYHYN0x2JkWpVkM9RYuy2oP2GS3gH+RaCg1/7UYbxcekExMQTYihwXGmYZVXNdZrAYw8btsLDgJE+Fmn/qwcrwKRCT868HgpjgItiEfmDkLF6QcvsTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750706834; c=relaxed/simple;
	bh=VajGqpSEAp5ELYK4M9sGUyxfmEefU94Khr0i25CbJ3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVrHJjCrTW3M5CkVDYcODokUnd/9pb08ROiGjn3+zBHAFWPZE53Uv16AjBtev3VH7NJMNzabZiwYKK0vbJ3GAW2dyP1B5FuDiSnv0melSjLYyT+PHzt4sFJlPOrlhGO8SIouebXt7fvZit8auGHtivK3Qi79eZbeORHOldHkLwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PivDLs6E; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-acbb85ce788so877982666b.3;
        Mon, 23 Jun 2025 12:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750706831; x=1751311631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z0pQ8faF0LLlqRUSGGG645sRY5ONBRjSfmgC64O42P8=;
        b=PivDLs6EDtFIQqUfQaA/nxDypvXyYRzxPCA9oO7tYixNU1tSWd2Oh4wgNyDmJuOdaH
         hrBwWUvL2u+3TDNjUnjh6JWI5AaOX22p/AMV5n3RamxqNCXl5ylugOumc6j2A/3NPOzK
         snvL97oERwn6E8BICmWQSAwqfL8D1MvmTFivfV2lpaX5SWf/8R2Y1KNBXL6uPc/tEaXn
         jMwynIBMmsQWFM1i4VfeMUioo0lQXUZnurdoW5StJ1E/vxJH02EP6872EiF5d++nK+rh
         B3UeT864Lon8Iy8DG2fA998vK8+LwHRSs2/POYQVixp4fEpWgymgT5gPFu+aM2i+FTHo
         5CGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750706831; x=1751311631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0pQ8faF0LLlqRUSGGG645sRY5ONBRjSfmgC64O42P8=;
        b=XJmBY7hfd8C3iIQF6KOU0aWY6nl/SIcBeE2O6myc03PKIN16JxpE1g+mEcLYT5vLJN
         v6pLJqVao9mW351wcekMlgnZwiG6UbBCn+hjXgrgbsXQmtRka4unSuksgqPGXa6deoku
         3h4Qhe/iBOcdHbFNvyg4N4ha3ud6RjAp3EkCzexcoxN8RlRIsVx8RIFvCFMqus0e6k4Q
         h1HvWZc+49CWDmfMVSgAvuZj4KLNP5Ymg7p9qoV6PUpTb8EyWgRyhuu1K9ZNxkbjlxdD
         deyIRSh1wYiRpynGrYBAPXQJ4QDnEg1y/+jYNrClnQ22ZjYl+IK8SRDEhJNDAPJytylp
         tbnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3o44140jhz9FvWvFiRttyaZ6t6sH1YoQmUDXJj2SK2GUf3BV981plAPDnrJ5froG1DOMMe+6I@vger.kernel.org, AJvYcCU8HXa32s6eTBfGgOggCvqH4Z0qPKNWOZTJO9YNfBi+5qPd1a15Of+J46s1Y3BelmCUC9btI8Tbjf4tckb/@vger.kernel.org, AJvYcCVDIRhLevWqZybiHqaHQ8wG6SXdi++V/96tpauzbDMBHaIPR0haXfboyT36ZPFZ3PwK1Pk=@vger.kernel.org, AJvYcCWqMTU3pbOPg4myLcr4J8jUth6gmaX0ks+3vSpK/J5z1gefyaXf0ACVZ8Rs8AmV7IhtVBx3/Z+4E9qA0w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3QOGt1NO+YGrcWSMiWGmwbsgysSH8pjTZFgSVgBu4iMDZ2DRD
	MXgvOQUiHB1l8y+pMVc3DRMCZrHDnsiIcD3Z7g4HuV+CockI7rIcw5SCfd4SUBwS
X-Gm-Gg: ASbGnctUslu1ri+6aAaFyy44RbJc/h9x6WQZTViAypx/Bnqdp9Q2w97frhGD755VYKb
	eP980sFg8MCrBGuPH96EuUgtFzsiTlVYgzbBReHPauaX3DeBeQ1j+WC+bIgb8UpwqpDLQM5O9dz
	rd3dYivezm7eIaEDo575me79DId65hlJqQW0cQU9uVwW16ple8jUKgH30YutZ+khZL8SoHNhCb2
	X9gc6qswCWRkkUHEk8F5Sr/M0Z9Sn2bowfRT5GrBvBFmti70SbgtW+q4+85LsHs38oosDGpW1ok
	B+aviuHWPSubp1coIKKCs3NEwr8ZQYVzQf6bV3H3XhWa/JhcToBYQCG1oSmfsaengfpOtWY=
X-Google-Smtp-Source: AGHT+IEXXca94xNAO8z0yI/gJqozBF4gVbj1JqChwHR36kNEKHmNp94k2ZaYauElDPmDtIU5+I1vkA==
X-Received: by 2002:a17:906:f593:b0:aca:c507:a4e8 with SMTP id a640c23a62f3a-ae0579c4416mr1256185566b.21.1750706830494;
        Mon, 23 Jun 2025 12:27:10 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.128.65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054080e28sm753471266b.73.2025.06.23.12.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 12:27:09 -0700 (PDT)
Message-ID: <3b71cfa9-6c6f-48f7-8457-dac915438216@gmail.com>
Date: Mon, 23 Jun 2025 20:28:31 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/9] netmem: introduce struct netmem_desc
 mirroring struct page
To: Mina Almasry <almasrymina@google.com>, Harry Yoo <harry.yoo@oracle.com>
Cc: Byungchul Park <byungchul@sk.com>, David Hildenbrand <david@redhat.com>,
 willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
 ilias.apalodimas@linaro.org, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com,
 hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-2-byungchul@sk.com>
 <8eaf52bf-4c3c-4007-afe5-a22da9f228f9@redhat.com>
 <20250623102821.GC3199@system.software.com> <aFlGCam4_FnkGQYT@hyeyoo>
 <CAHS8izMbtp0dN3+PZsivFD4Zg1DqaL5BJ4cw4jGjs=wCXAns3A@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izMbtp0dN3+PZsivFD4Zg1DqaL5BJ4cw4jGjs=wCXAns3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/23/25 20:09, Mina Almasry wrote:
> On Mon, Jun 23, 2025 at 5:18 AM Harry Yoo <harry.yoo@oracle.com> wrote:
>>
>> On Mon, Jun 23, 2025 at 07:28:21PM +0900, Byungchul Park wrote:
>>> On Mon, Jun 23, 2025 at 11:32:16AM +0200, David Hildenbrand wrote:
>>>> On 20.06.25 06:12, Byungchul Park wrote:
>>>>> To simplify struct page, the page pool members of struct page should be
>>>>> moved to other, allowing these members to be removed from struct page.
>>>>>
>>>>> Introduce a network memory descriptor to store the members, struct
>>>>> netmem_desc, and make it union'ed with the existing fields in struct
>>>>> net_iov, allowing to organize the fields of struct net_iov.
>>>>
>>>> It would be great adding some result from the previous discussions in
>>>> here, such as that the layout of "struct net_iov" can be changed because
>>>> it is not a "struct page" overlay, what the next steps based on this
>>>
>>> I think the network folks already know how to use and interpret their
>>> data struct, struct net_iov for sure.. but I will add the comment if it
>>> you think is needed.  Thanks for the comment.
>>
>> I agree with David - it's not immediately obvious at first glance.
>> That was my feedback on the previous version as well :)
>>
>> I think it'd be great to add that explanation, since this is where MM and
>> networking intersect.
>>
> 
> I think a lot of people are now saying the same thing: (1) lets keep
> net_iov and page/netmem_desc separate, and (2) lets add comments
> explaining their relation so this intersection between MM and
> networking is not confused in the long term .
> 
> For #1, concretely I would recommend removing the union inside struct
> net_iov? And also revert all the changes to net_iov for that matter.

Without it the merge logistics will get more complicated than it
should be because of conflicts with changes in the io_uring tree.
It's a temporary solution, I'll convert once the series is merged
and reaches io_uring.

-- 
Pavel Begunkov


