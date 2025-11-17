Return-Path: <bpf+bounces-74718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E3DC63C9C
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 12:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C233B4D1A
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 11:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A87126CE1E;
	Mon, 17 Nov 2025 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8bYIGgX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Un8PpfQv"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0FE1DE2D8
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763378462; cv=none; b=NvLa5n5g/e+eoqxw+qOdu60IkJokDWkZV+/tzTRo9ElEi+DcDl23RRD/0gBwJStlrsmTBUqU+U1ujGLUIMJvXal39zUN1sESKbsoP3TYPrFM0esA+ODQ3/aj5TZqUXBwuhjkwDuPmUp2QWlSH/TEEr2hlcDhLH8btM0LXg+ZBzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763378462; c=relaxed/simple;
	bh=dPcOQIPBIBCLa/NKsa8a0L2Mq5wMH471wz/f//gTuWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SisYW4B/HuNaAwS4T8dpWXJHyOIpwK80h2znTLoSZq/HLAcUBTVN4AV3nht+3AvTlPokgFB0sr/OdwpG8Mmh/oZbNCr+0jOzNdD+lVUucmWvSuISS6iF+0o1A1IUrMZqv0nT8PfVtjLT2Q75ZCnpixRyeyZCscUsz2URN4/stZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I8bYIGgX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Un8PpfQv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763378459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVf9LxNdBO8TaOKgZFNSQsuTbNOO3hmBDaXVsTWiiWA=;
	b=I8bYIGgXifOH20wmS9+zXtI6/O28rgITo46ljUCAfuNK9KFeoDV4GFP+ayX56s8zODiBrX
	3Dzkwj3TDLulB8RyEXQhdfjrdXNqxjHfdAf/PgDEA2O2K11s4h88z/g05q2Sz55pRaoFb3
	NQX/2Srd7fH1KA5tXOYfTIbNA/Uc4bA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-a8V6LvsQM_q9WZVVeTlINA-1; Mon, 17 Nov 2025 06:20:58 -0500
X-MC-Unique: a8V6LvsQM_q9WZVVeTlINA-1
X-Mimecast-MFC-AGG-ID: a8V6LvsQM_q9WZVVeTlINA_1763378457
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64097bef0e2so5325973a12.3
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 03:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763378457; x=1763983257; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QVf9LxNdBO8TaOKgZFNSQsuTbNOO3hmBDaXVsTWiiWA=;
        b=Un8PpfQvqC5wTzErk38aMO3hEdRvYC+9HtuNTDGBm9eo9yKT41VxFEqSkHgp8wYcnf
         8aQAQoGDUFWK8yN26R0WEYsVQtyGmapOQoHTSi81dPLUDDC6bb2IO9WJdnQxAHMIlIuX
         SJK4J5GZQz/Hq3fbkdDS/Y8Waxb7c7eqBKR9wG7T2mfSFdiLGYd989bXAn0vLTvsC8SL
         bhk3wrqgrmYDyWLgLqUsCJOW6lpgbg3TMTlG8qCGxSrCmY8Ru2F9SC3ir0YU8HoFtzu6
         wq8rR1SU1XpJQR4UMj9DuCQLWS6Lz4Tiz3HXvtBPEEshYksNe8mE3S05vEV4AY2u0gu5
         OH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763378457; x=1763983257;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVf9LxNdBO8TaOKgZFNSQsuTbNOO3hmBDaXVsTWiiWA=;
        b=kdAUR8VtV9yhVCMf6LA8Y8NBEd3eRey1fNdGW5vkRRDod4ugLKtt+O2m55O2+RGST1
         iZ11IQP6PeVX3DKB3nKp6J5iNHrBByX3m/szBIhqyytbfR2OOgFmjgaicZlWNo+kWvpU
         vru4vKHzjqGk6BHMYcPHwq7d/fF4bcQuRxD3+mXjEqcPI/ixDY1vUQzlj2GdJQuUUeBt
         y+o8v010f8RyxB0DceWf74YyjjWpQ/semVcfBA8QRBCVdzK5kbVqVQrlcQQUVnze5iXy
         fyyiODSnZs22t3Ka+zte0iYBwlEodk9k/oxl7XTBZIfsYfVWMAnV6weGDtFZ3Ym84+Xf
         3U6g==
X-Forwarded-Encrypted: i=1; AJvYcCUq/Hl6dUZNBUZMlxOf+vJRU9q1IhFAGYdf3AAr0ky3JnSMb+Knore7vIw+4VPSHsFGsSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr1Dlv2LpwC5qQsMSUpPI0vfukG0UtWLWqFUbOTslAA14PFmtr
	FBZQg/LI0UQRzb+QCw+O4zZ4rtjkBGEI661mUCk/Id59Pp6OQGxeNdJWp0jSVaTUtAtAeYZZjoD
	62Kh1gJeIV4HtFYo4nW9QfaH3nr0vzpwUMMeY2udX7ReBxNZIUcFddA==
X-Gm-Gg: ASbGnct+sNEqQBxbUsaBiGXT7XiMHYNopApzoAaTt091RJ3lopY6KjyhVnI0kQdwF27
	YPbuaD9DP0lMmEt7cbj2R1fbaw0KZ+qv21DcJU3T8lvcO1aDoUN4MMY9XDEhm9sw/64ykH/m+qN
	gIalsztOF6K3jvpj/h8SW/cCcjUNvXGy9Y45/Fk0qU3vqCAJVhK7zv9AzBxVIbS9ezdvZcouhr5
	0KXULLC+hWdFa8nLNfdUrRIdYOXvh9r8V1F1w0Jtb2IuHJxg8ms1rjvvltcZ7EuIW4L7JJuIMG4
	c/V2gXkFQz4lbCpkV/WVOaogk3y0dyTjHmj6Z8mSJMOO/zX4vEXcMXelN6s85u2LcxKKAF+2Atm
	K6ziNWaxuORRAy+QrCVIyM341Hw==
X-Received: by 2002:a05:6402:51d0:b0:640:b736:6c15 with SMTP id 4fb4d7f45d1cf-64350e23625mr11703535a12.10.1763378456964;
        Mon, 17 Nov 2025 03:20:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4Wdj00OQMd3S1KCNlU9xBz46Uej0UIJ1gNeKRvwBEkwOcay/vlwA/7tWC70CgNVFMvt+NUw==
X-Received: by 2002:a05:6402:51d0:b0:640:b736:6c15 with SMTP id 4fb4d7f45d1cf-64350e23625mr11703494a12.10.1763378456453;
        Mon, 17 Nov 2025 03:20:56 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a49806csm9992622a12.18.2025.11.17.03.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 03:20:55 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1D7AF329B3D; Mon, 17 Nov 2025 12:20:54 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, horms@kernel.org, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, ilias.apalodimas@linaro.org,
 willy@infradead.org, brauner@kernel.org, kas@kernel.org,
 yuzhao@google.com, usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, asml.silence@gmail.com, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
 ap420073@gmail.com, dtatulea@nvidia.com
Subject: Re: [RFC mm v6] mm: introduce a new page type for page pool in page
 type
In-Reply-To: <20251117052041.52143-1-byungchul@sk.com>
References: <20251117052041.52143-1-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 17 Nov 2025 12:20:53 +0100
Message-ID: <87o6p0oqga.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Byungchul Park <byungchul@sk.com> writes:

> Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
> determine if a page belongs to a page pool.  However, with the planned
> removal of @pp_magic, we should instead leverage the page_type in struct
> page, such as PGTY_netpp, for this purpose.
>
> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> and __ClearPageNetpp() instead, and remove the existing APIs accessing
> @pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> netmem_clear_pp_magic().
>
> Plus, add @page_type to struct net_iov at the same offset as struct page
> so as to use the page_type APIs for struct net_iov as well.  While at it,
> reorder @type and @owner in struct net_iov to avoid a hole and
> increasing the struct size.
>
> This work was inspired by the following link:
>
>   https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
>
> While at it, move the sanity check for page pool to on the free path.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Zi Yan <ziy@nvidia.com>
> ---
> I dropped all the Reviewed-by and Acked-by given for network changes
> since I changed how to implement the part on the request from Jakub.
> Can I keep your tags?  Jakub, are you okay with this change?

LGTM, you can keep mine :)

-Toke


