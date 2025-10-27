Return-Path: <bpf+bounces-72296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084F5C0BC68
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 05:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8129F189D8FB
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 04:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA7C2857C6;
	Mon, 27 Oct 2025 04:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQlCRfm7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E552F99
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 04:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761538080; cv=none; b=hFOfU70rDzlmq4tWE9HmzHkUQxYNA753XW1mWWhUhEP39EFaWyd876KGndvesCHwVGV6SR0nNwu7QfpATtHjfvXm0ZP6d3HgEfUfDIdNUh8BpnGnJgAIWRaxIUD4OcZlQNyLZsniE8LJQiiHVolX1kXoxkqCDi7x0NtY0LDwVSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761538080; c=relaxed/simple;
	bh=jO1osMGdYRs3e14yRN7S9XQzgciumk1NWE4PApqCbB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEm14WMT5k5HJUcxS0qxrQjvn7XpZ8zp0NsEWDugs18SW438JAZCrNEBdmDHBI3XXVstOalm1X1fMFhW1uT18JAjdTYEmKY+2xEFaeU4gwexfcOCfOHnjbRSFDlHEgyu1lZWB3r1lkZ0B9rz/Avx0HrPHsCsL5Ke44xiuyst5UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQlCRfm7; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-89ec7919a62so286329085a.2
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 21:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761538077; x=1762142877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibO/MfxDLcDBhKW6DTcsagfs6zgnKHMHLzVm/Gfs7jw=;
        b=GQlCRfm71golqWGpXWsP3CanG6/9Rya3gJd2O+M+8C6k+CAjjFz9nMs1Gpo2zapecb
         iAayUhRaPTgnQYPqlcfnR9Lf7AKthsVHenrj4U0ndEdOLmfOR70CbG0fcuUcTCjlt58l
         57tkLb3jQgSm4ZVs/lSEzV1tfCo0LtuVz2ErjE4etDsab3ga+f3XRP/l3DPiURktTQ/s
         bNLi25M1/C1a/coDjpnabyqCFBOQQzBo2T2Dj0PTfhOBtIXasFzA8H4UMtOgoj4h6Pa0
         hXkvzNx04wVeLXD42GFjq/42CKUop2mMvAckczS/IP8RH8TevhGt7UrYdAz9ooalOrj4
         nrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761538077; x=1762142877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibO/MfxDLcDBhKW6DTcsagfs6zgnKHMHLzVm/Gfs7jw=;
        b=MeGY8P73bXOQ8I8d9oC2z+KDUbW2ir76FWJ+cQQqAY0oUSdaamUCxMAMJCFmJiaye8
         2fAZsLcwqR9K94NsQEwBXcoThw+Bpr+aJH9G/TLsW2jyGUj4XM8gkWTWXUJ5H89YivVZ
         8qLX5wZs/c8zhrjAuai0AGfQdA0U1Uvz1LQcmVjDHJUQl1TITgZVCJGoMW7kIYVHRkKY
         7j8igaYZF9Rq32R4JUvP26aqq5ewdJWPDPoWEi8goJMfkx5tqCAF9l7SQqNh+75ZhP9W
         DCS0C9EjRYOSHMjyPYfsZFT41NVyIoRe/zgLmArQM67wirXqp/lHwGnlqA1SZspxj175
         EFzg==
X-Forwarded-Encrypted: i=1; AJvYcCVnJbMV1dhGM5n24+aIjiEiFfwzlnwjTG56YrxHCFiOhDgh8ZWGkjskm/MGXcsdAlt5xKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxasnR344XSkstiItFl4qan0MvEASmluquInndGK8fDXODobsY4
	yavSrnMqDTOivtsZc4TWHh3FmSJAgqLbkSVNybGBIk/459ykDfThuCcuU43t6f6MxDterI/jPKo
	ImujWdzv5f/f9CZAZlK4rXinw5tIJZAU=
X-Gm-Gg: ASbGncuOFlng/go3EHAFZ4iGi6SqHsFPYPfGsV05RB0VIc1KIUe+avlHSsjknw65Dbd
	+kbq3dBm7A4xaop5GF/HgeB4+47LkjCi2yk125nGGiMKArVKlq7we5ZCgvg5F8JxgMnEhBzUqfE
	BEBY6+2ANltpFftSmus42morNPKQ4342ykpR8mkYE3AzJ5W8LK9afkNVzSrMkS4HSBCB6aqYIb9
	6/xyJ2metecRCxfm3x1APgFePOAthx9QfgM+x821KgglPRUCFW5Xhz1UAzVrRa15eV9lFgegHXE
	5VYpmIPLXGt7Di/I
X-Google-Smtp-Source: AGHT+IGefw2r8nKdqOS0SwKxCjvapqhvhgaNjigQHwL9BSMI9Uj9YevfnjblAyLG9nJZtA6yZ5tJ9nPfP/17o5LX1lo=
X-Received: by 2002:a05:620a:4556:b0:8a4:e7f6:bf57 with SMTP id
 af79cd13be357-8a4e7f6e1a2mr122937585a.5.1761538077288; Sun, 26 Oct 2025
 21:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026100159.6103-1-laoar.shao@gmail.com> <20251026100159.6103-5-laoar.shao@gmail.com>
In-Reply-To: <20251026100159.6103-5-laoar.shao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 27 Oct 2025 12:07:45 +0800
X-Gm-Features: AWmQ_bnqDQ_nqt4D6_uisIDfd46Kja53Wh7oCLWwA2TUqJRp3ILNLRZozn7IGYE
Message-ID: <CAGsJ_4y+fW1wdvZzfRWbWQT24rvA6vGJ4-oxhJBxXMr9m_d7HA@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 04/10] mm: thp: decouple THP allocation between
 swap and page fault paths
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, ziy@nvidia.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ameryhung@gmail.com, 
	rientjes@google.com, corbet@lwn.net, shakeel.butt@linux.dev, tj@kernel.org, 
	lance.yang@linux.dev, rdunlap@infradead.org, clm@meta.com, 
	bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 6:02=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> The new BPF capability enables finer-grained THP policy decisions by
> introducing separate handling for swap faults versus normal page faults.
>
> As highlighted by Barry:
>
>   We=E2=80=99ve observed that swapping in large folios can lead to more
>   swap thrashing for some workloads- e.g. kernel build. Consequently,
>   some workloads might prefer swapping in smaller folios than those
>   allocated by alloc_anon_folio().
>
> While prtcl() could potentially be extended to leverage this new policy,
> doing so would require modifications to the uAPI.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Usama Arif <usamaarif642@gmail.com>
> Cc: Barry Song <21cnbao@gmail.com>

Thanks for addressing this.
Acked-by: Barry Song <baohua@kernel.org>

Thanks
Barry

