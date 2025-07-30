Return-Path: <bpf+bounces-64731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8008DB16578
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 19:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89EDF5670DC
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 17:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE0C2E06E4;
	Wed, 30 Jul 2025 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="bphNS+XV";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="6Af2hm4y"
X-Original-To: bpf@vger.kernel.org
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA772616
	for <bpf@vger.kernel.org>; Wed, 30 Jul 2025 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896388; cv=none; b=ptmWuv9FKDAHtDvflgm2dX0MQvhDjfwUEDxUXbBGvrozchNG7b4oLfXFoGB/IkX90nZSGddw7MvepBXtd0irgivGQBH1N3sXtFJD9bGIrJajfpHiXIT7ZiaAT/G5ToVW/KwYVqhEfXhUy3fNgCbWAazbY4cbzW0CV2H5lnQKQEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896388; c=relaxed/simple;
	bh=PGi2Cbl4x5cWD0I2ITAY/N2F9HJW2syAJhuk1NYiQAY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ejYetAht0Fat891UvYXdOtKegE6oJFLfPojZfUAwIr8pFWxD02veCl92yDWM7cA9qvCKwWgHmFC1GCbCYVlD+CnylVqeqFnGK92fvetvehYoDbRXHP5H748JxMZOKNnnqTP4uQcPGEJ64DXP5i2vg+Ij6AMVZppXkA/7SpE/6Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=bphNS+XV; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=6Af2hm4y; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1753896317; x=1754501117;
	d=konsulko.se; s=rsa1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=PGi2Cbl4x5cWD0I2ITAY/N2F9HJW2syAJhuk1NYiQAY=;
	b=bphNS+XVZXoX9g07m5+NodI8iBOu6iCZe9qsYu9hHOvQTKaIzlhzzUQUED7XQoyqJxC+tL7sgGcEa
	 kFrKiQLtjdEWpHN18pKT0HFWZgYq1bbGQLXO/J6P86Lv8MVWqW2GTLshgF3eGaaOt4Uvt7yC1jLF1p
	 r+813EgTmpNicMprW1wyH9yq5Ul2LpQZgZT2fva3wx0Pj1nj6xBbMz+KvJFCfEqMt+NKIWw1n49zQH
	 1QdAlPPrlaK+rPo/FtDeo4VzniYkixsNODYSAqLiGGhV+aVoSF13JWDOg5WB/4NPeSGGF1an7ApX9Z
	 vVF4cGW3eZTre/4hY5gWeDzCXg9XRvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1753896317; x=1754501117;
	d=konsulko.se; s=ed1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=PGi2Cbl4x5cWD0I2ITAY/N2F9HJW2syAJhuk1NYiQAY=;
	b=6Af2hm4yEUeE/Oyl9MPj99Eu4MG7asvfvhfFyRnp28rv0ioRog4XZlBcGDfZGbuAOpPFeijWrfKWl
	 0lE/kdVAg==
X-HalOne-ID: 27e5fc15-6d6a-11f0-98dc-c9fa7b04d629
Received: from smtpclient.apple (unknown [2a01:cb1d:9264:6f00:8e8:6eed:ae4e:a087])
	by mailrelay1.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 27e5fc15-6d6a-11f0-98dc-c9fa7b04d629;
	Wed, 30 Jul 2025 17:25:16 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v13 1/4] :mm/vmalloc: allow to set node and align in
 vrealloc
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <aHZnmevtRYt26LBE@casper.infradead.org>
Date: Wed, 30 Jul 2025 19:25:05 +0200
Cc: linux-mm@kvack.org,
 akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org,
 Uladzislau Rezki <urezki@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 rust-for-linux@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 linux-bcachefs@vger.kernel.org,
 bpf@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B851D9FB-3745-4923-B196-C4D0C618DBF5@konsulko.se>
References: <20250715135645.2230065-1-vitaly.wool@konsulko.se>
 <20250715135724.2230116-1-vitaly.wool@konsulko.se>
 <aHZnmevtRYt26LBE@casper.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3826.200.121)



> On Jul 15, 2025, at 4:37=E2=80=AFPM, Matthew Wilcox =
<willy@infradead.org> wrote:
>=20
> On Tue, Jul 15, 2025 at 03:57:24PM +0200, Vitaly Wool wrote:
>> +void *__must_check vrealloc_node_align_noprof(const void *p, size_t =
size,
>> + unsigned long align, gfp_t flags, int nid) __realloc_size(2);
>> +#define vrealloc_node_noprof(_p, _s, _f, _nid) \
>> + vrealloc_node_align_noprof(_p, _s, 1, _f, _nid)
>> +#define vrealloc_noprof(_p, _s, _f) \
>> + vrealloc_node_align_noprof(_p, _s, 1, _f, NUMA_NO_NODE)
>> +#define vrealloc_node_align(...) =
alloc_hooks(vrealloc_node_align_noprof(__VA_ARGS__))
>> +#define vrealloc_node(...) =
alloc_hooks(vrealloc_node_noprof(__VA_ARGS__))
>> +#define vrealloc(...) alloc_hooks(vrealloc_noprof(__VA_ARGS__))
>=20
> I think we can simplify all of this.
>=20
> void *__must_check vrealloc_noprof(const void *p, size_t size,
> unsigned long align, gfp_t flags, int nid) __realloc_size(2);
> #define vrealloc_node_align(...) \
> alloc_hooks(vrealloc_noprof(__VA_ARGS__))
> #define vrealloc_node(p, s, f, nid) \
> alloc_hooks(vrealloc_noprof(p, s, 1, f, nid))
> #define vrealloc(p, s, f) \
> alloc_hooks(vrealloc_noprof(p, s, 1, f, NUMA_NO_NODE))
>=20
>=20

In this case, to keep things buildable an each step we will need to =
modify slub.c in this patch. Since we change slub.c in the next patch in =
the series I would suggest that we keep things simple (=3D=3D as they =
are now, even if it means some redundant macros have to stay). I can =
come up with a macro simplification like yours when this series is =
accepted.

Thanks,
Vitaly


