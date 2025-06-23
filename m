Return-Path: <bpf+bounces-61273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58362AE3A9F
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 11:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512F6166A57
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 09:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1563A24A049;
	Mon, 23 Jun 2025 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIFI4lqT"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E049424887F
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671152; cv=none; b=hxaxV2rAAhs3C+6r6V7GzY7AEhpQT+9u8bf2iywAi0DoBMrblkrfCfGVwWcBn3w2stspeqGy8UHVRSiC/ums+BiZH9lzY0DQrwAPGQHdHdFawkMRDF7OPQ946vdCR6xy7OuItnZgr5SPP4KrH8ZQnNcWVLRcUHUDuqSRL/rZitM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671152; c=relaxed/simple;
	bh=bwD9eW6XLEkaosTNuZfRhkGoQLfSAny8Sw7d0cvMtPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WW4gMDQbDLyvXOw7Dzhy4B8N0VPPDWLQMaBhSg+IzNJlPnmiyQQV7ysFmnSXEg5e1H2nWKk6ywyb0eVsgS7jpS1+eNEdeRHgcHzwYQK9DZYFRdH87pHzYW38LppUyFV4TSyFqqxDaPUn19/EL6AqU93woGrCAYDpc7Ve5o9OqSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WIFI4lqT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750671149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mTrcWdB02nU77OEwEz1az1POxXwV/tqDiXNirXy2l0s=;
	b=WIFI4lqTyn1fT4A6DGsjO/fQn+6xmnLIvv97WFSE5s9gwhfs77HISP0YLZEL649YYb76mA
	jv9vTdqiBc8exhhU9uvcDj3gtetqgI9xVRMkGrTthyJzMyrKjJlOc8Me6rkoBv8gcY5B5b
	fE5UywSoSlG1vSVVqqFXvqITCsjgANQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-DYo3MuMMP5CYpLkkCJRZoQ-1; Mon, 23 Jun 2025 05:32:21 -0400
X-MC-Unique: DYo3MuMMP5CYpLkkCJRZoQ-1
X-Mimecast-MFC-AGG-ID: DYo3MuMMP5CYpLkkCJRZoQ_1750671140
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a56b3dee17so2300537f8f.0
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 02:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750671140; x=1751275940;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mTrcWdB02nU77OEwEz1az1POxXwV/tqDiXNirXy2l0s=;
        b=TgQLxfMOSYyfMJZKW5oASP7aUTEg6bWeWxm1ZMHi+YT0HutM/j7JZSUxRs6Y7jtLu1
         fuByYUFln4nrQx45FB+T4a1juQUaNAHxTWxHl14wTVD4fO5lM39ZVR7Vp5x5mgQT5Vgr
         5FoihYnxnAVyYK8cbqe9ktPQegI4zmi6j1CZT+NDQ2YPl0FC0dtfFJz4PeVC4wTwuyBy
         EYuxlyXH5M5rf6ZlrmX2UvyfDSrgF4sX1xDL1X9YeHLswziURTV9WN+lrcvRN9bC+u3c
         wKmvQBCtIG38SOa9gtailtvrGuhkgU0/x8/MHA1f5ElofjAXcToKtQGMW3Q3xQqpyTtS
         XYSA==
X-Forwarded-Encrypted: i=1; AJvYcCVS0wCjDyt/6FoOOr3H2WFjk/hDxGaQsLo9709E9tDSEEbq4P1m69hqVSm0VamuArSu+mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM9yX9o71bGpTM+VUmAynk0mPVzXraJ/9IC2KfP6/NLeNi5VWO
	DFHotvvuEVfvZGc+lNN/gV6IlyRlFA+aKIl/HagNhSG5Hj9Mwy8a084/UGgmPRXdJsMWj5U0qyU
	Ck4YFPtv/h76FrEeQ5b8oiArvcuQdOYbkVH8n35zOYDTZmDzrjPx8qQ==
X-Gm-Gg: ASbGncsLUnUpWKe2G3idPMcqwnZWd5yKh9OG5TUpNmUcqQSQiFngUiDfRsRlNGv5VsX
	/37ToOVWdgjLR+AxlYGbkM37HlXednFpu2KGB0t0NS64I3/G+Gzosdkv8pTbqYPXAs7O0bs2vat
	u57s6dscp2Xy6Fhgif8AVW5tH9LvYxc5h+lJZKPjO4RfwpVwu1Xi93Q+NNnwasvlXLgBetuFPFF
	Xq5WLk8VIYCEwZbuiCmtZz7oYtoJC7rB9AI1YDrBHBGWplaw2YqbpvmGQ+Q8wgrohSAtHa81vd9
	VTPbhEoM9JluR5l1XfnvxoHsycXSqFL/tr6B8wuiyexY/Pxm3+TaMUQ/v8BBMXErsZD/R8vaCm9
	sEijBGzcXIQ7+lFzDB6wURI5LTa+Od/QBd3Sabgs9Mj9DpDldog==
X-Received: by 2002:a05:6000:1a8f:b0:3a5:23c6:eeee with SMTP id ffacd0b85a97d-3a6d27e1c52mr11353884f8f.21.1750671139884;
        Mon, 23 Jun 2025 02:32:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGor7wKAZ3P01jSr1QMYu/cl050P6T/rVM4NiDh4Clu9Hi+P89WUjMMWx5lfE0etKo30wbUPQ==
X-Received: by 2002:a05:6000:1a8f:b0:3a5:23c6:eeee with SMTP id ffacd0b85a97d-3a6d27e1c52mr11353839f8f.21.1750671139434;
        Mon, 23 Jun 2025 02:32:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d117c0fcsm9184999f8f.62.2025.06.23.02.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 02:32:18 -0700 (PDT)
Message-ID: <8eaf52bf-4c3c-4007-afe5-a22da9f228f9@redhat.com>
Date: Mon, 23 Jun 2025 11:32:16 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/9] netmem: introduce struct netmem_desc
 mirroring struct page
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com,
 tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com,
 hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-2-byungchul@sk.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250620041224.46646-2-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.06.25 06:12, Byungchul Park wrote:
> To simplify struct page, the page pool members of struct page should be
> moved to other, allowing these members to be removed from struct page.
> 
> Introduce a network memory descriptor to store the members, struct
> netmem_desc, and make it union'ed with the existing fields in struct
> net_iov, allowing to organize the fields of struct net_iov.

It would be great adding some result from the previous discussions in 
here, such as that the layout of "struct net_iov" can be changed because 
it is not a "struct page" overlay, what the next steps based on this 
patch are etc.

-- 
Cheers,

David / dhildenb


