Return-Path: <bpf+bounces-73343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 704C2C2BA98
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 13:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447623A43F1
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 12:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE402DC77C;
	Mon,  3 Nov 2025 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gV+oCEZQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAKuRWa2"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2682D0C97
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172769; cv=none; b=VEilPB7Qnsr6sLzgOFGdDI60Pz2No+mW+H3HP1fJ99c8ZSnbbvFFmQz4t7JlptWJubtDeUYHE71tlRMhTNs03Prfug4CpyHKHkM0epdCu/fDmBCfiMRhevXZLafvWPBb/3DnX4PcbKZGOskxDMIT9Osf/Arfbc6U07Lp/SREMaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172769; c=relaxed/simple;
	bh=Si/42XMXJCEofqRHH+RrI534o6OjSI0ZZ/KP8a9kKog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uocp/bvylexV3shXlCXwTnIRMIOP08FgSdKXh5tpe0JCtfBbD9CIgBTM6PpR8A3uB1b7L6WVdkFuEX4O7dkFKswY0Q4W+uXlsrUTinqXRXXfEuRykrXixeQy/ef07eaPFkTp0Hzxgw9CV5Jt3GsbCVbNd7kCYlhfdJ4DlW97+/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gV+oCEZQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAKuRWa2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762172766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g11uOENAhXF6Lz2FLzv66IHWNpx+JPxP5XeReK+9A1c=;
	b=gV+oCEZQpzCxHcpx8JbLGIpjFUJFXkr7Ce3ilCkiN6rYdE8rVrKBuaDkkNwhFmD4ibCVvg
	MbM7L7C91ulEYLMNqZ+pO68DWODoHLs4VDa/QCc5YRzoQWaPfSLlkyWLpwr/T2xjcgC20f
	JNoXO4So/dAVu5i/xwTXldu88ZjWDRY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-DBppyc7fMu69c3OmEJ8Zxg-1; Mon, 03 Nov 2025 07:26:04 -0500
X-MC-Unique: DBppyc7fMu69c3OmEJ8Zxg-1
X-Mimecast-MFC-AGG-ID: DBppyc7fMu69c3OmEJ8Zxg_1762172764
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b70b1778687so72786666b.0
        for <bpf@vger.kernel.org>; Mon, 03 Nov 2025 04:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762172764; x=1762777564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g11uOENAhXF6Lz2FLzv66IHWNpx+JPxP5XeReK+9A1c=;
        b=UAKuRWa2ThRifoqGXh5Ca1Pvm9cEVooPc+adYv+NBJIR0tYzgRyS4005U5EMGsWCpN
         Wk6mhPZ8FZ07XSOdHtirRWe1YU2BnyZfq4l8jhKQ5CLWZydkTozvD7Ai5FknlW6+/d8+
         VMyZsS08ptMgIQY3D5w7RikxAEeKoN/fpkrE+InuhXtvxj+JZMhwuN4zf8/8kgiNj501
         ow/fF4bR5WGU4NFPgIQaNzvC5OyJ7h3uIMv6fAdUnUVlVrbBixxGdSyGJiuaXhPbCPvI
         Y6QgPhvn5oV7F7pikEwRX1p4D6BPRAwrhHL0FynP9yGVsJcIhH5hl4pdt7BK1Jpp5VYM
         8s+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762172764; x=1762777564;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g11uOENAhXF6Lz2FLzv66IHWNpx+JPxP5XeReK+9A1c=;
        b=CPmDFqdXyH8Cu+pLzKk8/p0+Y/+xm/Zcko4jZw9lGmKMxpH/Tw0nmM3sIpf0zvghmo
         nxDHeQR3h+ThD1Su/t80pmnE/X2I1T4rq/Si0oMTXn4iAVYNop8XiqTxuQhw1Sw5X1qQ
         lJ8q6c8fxJeTDjJarqd697ieb7kNpflIas9/akNLlr3Ixpmm7TjXMZFbGTQQBq5Rk2O/
         NdUoSaqPFAKM0wBT8g9yjLpIz5I9tdJDhSwGh8xRTEGHSNSSXwyFBovGK+3dUKolZiA3
         fwCp0Oq1DGUlfhdDF3DPRl9t9DNXmkDsEHqW+azto5NWrRnfnWalPUB7q5Sxyue8HmwI
         PmXw==
X-Forwarded-Encrypted: i=1; AJvYcCW/+nySwxwve8RRqvu+GhpmRcoRxOqRTibvGZOvC6AUOZlouq3spi4p9x3bBq5jrukk04A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJyeL9aEnDbiZrIOU/SeHpNblO2q7jXv8vavMcR681eW1ccc5
	IziX8ZLr+pzJ1+dqT0dV20PCgEW56/i/S2REhaaHmBN1xBYOIhljcGxS5fYmcfnf4zeO2lONp+I
	o+jxpmL6p3pwDaXIp6euSur029Yj/6Q/Jwlqpe/XYoVrNcWkuogRwyw==
X-Gm-Gg: ASbGncvGAdAxIfx932A2CPx1Mx8NDmm7lzrp8bAmjNtOP9EaBwG4nDjfcb3TCZEDron
	e/1eF9qV9J5JppjAobq7KaiPmHsXEQshMb57YqXhMsk188EPXMf+a9a3ZmWPduIlwupi01+h7gK
	wtsMf+SBw6Z9/F7o4oyNje8KXAL5X30BTJLtuLmB0fQ0noVM/MbLR+Xb9Ap2Y+7HimaFEDtyU3m
	6Ul+bg1slN0U7r1vWjko7rIbpk+6zhF10KXNsWPKDevq3KVBSkjRjkS7pMumQn2sI6LORJDGzie
	C4kWq/GZTuYxChyaNJ6Ubg+ZFbbklddt8Ehnk15j8j00vir2MxhZC6cc1l1OPxqXSVGl+V6oR8e
	58NhP98poDtRfFIKxRJWYNA4=
X-Received: by 2002:a17:907:2d90:b0:b54:25dc:a644 with SMTP id a640c23a62f3a-b707088d70cmr1143620466b.60.1762172763683;
        Mon, 03 Nov 2025 04:26:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGDSUZroE2R0agAHuAggyj7GFeJpoD3zlqyuRNs//UwQQu1Iz9F3y2cjiJMrJtGK3MF6tN8A==
X-Received: by 2002:a17:907:2d90:b0:b54:25dc:a644 with SMTP id a640c23a62f3a-b707088d70cmr1143613966b.60.1762172763188;
        Mon, 03 Nov 2025 04:26:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975d24sm1032752266b.1.2025.11.03.04.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:26:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DCD6D328450; Mon, 03 Nov 2025 13:26:01 +0100 (CET)
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
Subject: Re: [RFC mm v5 2/2] mm: introduce a new page type for page pool in
 page type
In-Reply-To: <20251103075108.26437-3-byungchul@sk.com>
References: <20251103075108.26437-1-byungchul@sk.com>
 <20251103075108.26437-3-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 03 Nov 2025 13:26:01 +0100
Message-ID: <87jz07pajq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Currently, the condition 'page->pp_magic =3D=3D PP_SIGNATURE' is used to
> determine if a page belongs to a page pool.  However, with the planned
> removal of ->pp_magic, we should instead leverage the page_type in
> struct page, such as PGTY_netpp, for this purpose.
>
> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> and __ClearPageNetpp() instead, and remove the existing APIs accessing
> ->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> netmem_clear_pp_magic().
>
> This work was inspired by the following link:
>
> [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmai=
l.com/
>
> While at it, move the sanity check for page pool to on free.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Mina Almasry <almasrymina@google.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

IIUC, this will allow us to move the PP-specific fields out of struct
page entirely at some point, right? What are the steps needed to get to
that point after this?

-Toke


