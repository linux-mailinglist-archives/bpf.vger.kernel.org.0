Return-Path: <bpf+bounces-59704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCC2ACED3E
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 12:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357263AC93D
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 10:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DE4213E89;
	Thu,  5 Jun 2025 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioZaRDJf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070273C17;
	Thu,  5 Jun 2025 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749117735; cv=none; b=ENaM1OFrINsLbhJHpRCp/mBPIZ65rcUM/k2Db4hmxy4COgjNyKRU507Fzl08+ppZVZamgsCIzVyty005Prk8k1gwvQKUCKXdUBGxuhBhY1+qm6qVp3J/Xr42eXsH88KCZBsu2nsNvH4c7ZjZBD03EZMCU1VPkefM+p/ujRW2wOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749117735; c=relaxed/simple;
	bh=3wIA8FzM28jTAmLDNYzym8PGR5wMdvCsj7ojq/EphCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtBQ+wbHKow4GUl6DrK+gUCa0zQIk7DZug9KTDNsFiPLHJZVeSnvvKjVtwTdn9DCUZU4cWq/rwoFYbdEeTmx7mfWFAmSu3zI1M0utB0dVo4+wWdoUnBuNM9r2yJSttapj/mkGxbzdw4y6Bcitelsi+kFzDTqnFwgokUr5iEqgos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioZaRDJf; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so1292820a12.2;
        Thu, 05 Jun 2025 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749117732; x=1749722532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=up4swdLNOvslRPxbCj7NvUPbNSrEcnEpawU2SYYjeSs=;
        b=ioZaRDJfpMfd3CkvenTHALAy6pCLzPvtGJCydBNObncWa9p2S6LR9woZlYHoh6HqIy
         I2NVwJN2WJhtVjw2dHsmK6lkl8JNW8jv+OywhIsiDH2H/4X0UgUj+UibZwMkvyODXTs4
         M372Lvz5mvNwO9xh/U5zOl0udkWSN2FHF3Mc71u/shcI7yocGYDmdgzi1UPoyUZJQqha
         Ykd26/AjtgMPiN/n+dxSzEUtXk2oKrpcGUcQnpbfRogme8sbiLF+e/QYMSvLKM2aiORs
         T6NmsU0GCLVyGVU59hSbVzjw96PxZeMzLfLNKlxAuuAdrBi8THw/NJBa6Y5ySLBKJVvh
         ct9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749117732; x=1749722532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=up4swdLNOvslRPxbCj7NvUPbNSrEcnEpawU2SYYjeSs=;
        b=gm+DpfZ0kde1DoxPbDGlte7K7edLBUrHRehnqssTdmKep2q+eF+LTf8bj2xU4iFQVd
         0joNiH89xhBJQgVOxNtpDAcplpSaaDId24IuHFhEMo7ghytq4TCOF7AR0KHdusF6YuPp
         QyJN2WLYaN/JYBu0DrnAiBfvEu3PWCwYGZo+hctgd692xDaKkzl8WKfti/3pXwB9T5L1
         Aq5iZqRHHtjumCKCBKNP+SD+rNrYuFJHCTa6cSm1zorqikDhOcxvbcb2RWE6MMGLyvlW
         DrIQNkltm0dG1qLz6aC+mT1oF6j350uG8D2ihDCgkyI6e9p0YVs4XulUy/cbXRBPhL63
         CSZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUDaxCLV7JG5SyhoNc2Yn4u+Se9x7hEW2Pgp44GwfqxKqOmX5SoxvMQTdcqQgeTPoqLkvMbvNf5m5p8g==@vger.kernel.org, AJvYcCVyoLwctxUlVxw7nYlUsygPJvNuJGRtO8Mu+Dj8lTrOfCQ4LmKC/3Wn3Abvqk+Csn6EUILjI2+P@vger.kernel.org, AJvYcCX5I3kQp6XLBGv8WRhKJOnri+6iGFXQBPyuNA/jgtHWA1gsubFsKjaC7SsrTPGbl75vLs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCxwY5OoMmmGpf4TQ3H5I4AYtqCJjXMr2ZvO2HfjtMh+RWZx2r
	8WWSpg4+Nnrc1a87jL7jYQRniuX54WtTxKcLMAMpM2rc5lrDyDiGpVdKrSFcwZVw
X-Gm-Gg: ASbGncvQ6fHM+0bD1wlO7Cv6cfMYYJoG5p/SaBrTi4E9tyDmAke4vnxOgjUhb1RLs9M
	YoBfYOB/ASCn13FWAiWLc7E95VAAauDwLyF1ywPfYCpO5oqEChZda2z2pnqAun8zNqDaRBJRvoD
	Fyt/8nP6W+o+GT4C0dcqfV5eZ5feGMUKzw2m0C8KhCtaz40oY4ZcJz8I4i5VTittiL6ofiktK+H
	9d1mK0CTmdpZUi9pctQFfhMJwQKu11sCPP0GmVq5O5TqNaAMtj+5HJq4grd4hzLigj4pGD8H8ZB
	gkD9q3E2wqJQO16L3aIbHPEapeXUkEr27iT5itZUKNu10tgIhc1dE7ZRGTXz6rX529g4gbfG9Vg
	=
X-Google-Smtp-Source: AGHT+IEerswt3uaI6aJfTNE+H3AMj09WEw62WDqPCqgipaohetyKETPKo7eDe1WxPbiiU7kRJiNKeA==
X-Received: by 2002:a05:6402:270e:b0:602:2d06:6b21 with SMTP id 4fb4d7f45d1cf-606e9415e96mr5459962a12.5.1749117731874;
        Thu, 05 Jun 2025 03:02:11 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::22f? ([2620:10d:c092:600::1:d66f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-606fe850afasm1809494a12.78.2025.06.05.03.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:02:11 -0700 (PDT)
Message-ID: <37376916-6fd0-4a29-ba40-dec512f9796a@gmail.com>
Date: Thu, 5 Jun 2025 11:03:30 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 01/18] netmem: introduce struct netmem_desc mirroring
 struct page
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-2-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250604025246.61616-2-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/25 03:52, Byungchul Park wrote:
> To simplify struct page, the page pool members of struct page should be
> moved to other, allowing these members to be removed from struct page.
> 
> Introduce a network memory descriptor to store the members, struct
> netmem_desc, and make it union'ed with the existing fields in struct
> net_iov, allowing to organize the fields of struct net_iov.

Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


