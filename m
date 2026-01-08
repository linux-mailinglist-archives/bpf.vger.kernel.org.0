Return-Path: <bpf+bounces-78236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 42996D04078
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 16:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A86A304D02F
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 15:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B1D2E0902;
	Thu,  8 Jan 2026 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wxm4TtQ1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="riDIt35j"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625792DB799
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886944; cv=none; b=VMHLWyuES1xaH+JTWEYHq81DV2XkTCLEyH9JFDJNT2V6BHndZe1ujMX5J9zwvYXvkVT4DiSDRyQe+8r5mkGwzU5bMCRG3s0SAN/isGei46lwc9QhGH7iSM2pN5z6XVyJ6Wh7FXF+Z2kCvd9ufSGwaINO4FhWpejyqk+8LjZ5bwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886944; c=relaxed/simple;
	bh=ZEg3oQJaVSZ9gyf64NrqCt6gf+xa+Xosp1a/kSE2/LE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bqtGDBM6RAyK/55EPYgyxU4wBRr+sF2+Cyvui7BSZyd6/4pzAwPBsKV25vnFrkYgJ3/rvraIqNipAMANOZxU8BIv6LZ2eKlpgJLSHaSR17CtrOvMj+egunxflMEq2Qpho3xGArM9xXcz6VeIYbaZ3lVpbBWX/UNbQoPWvl7wYbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wxm4TtQ1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=riDIt35j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767886942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEg3oQJaVSZ9gyf64NrqCt6gf+xa+Xosp1a/kSE2/LE=;
	b=Wxm4TtQ1GOl+VCH9bFbrtxuNpJSdHojluOlV5dRfZIhrYs+qu9uM5tQcaaAGLUfpbVrTJv
	+SweNUz8k0F2YAUG5mbOLLf8TtSYvFaii3BUPqJuSdAg5c6/ZSH5AHueTQajTOlTbCO0ck
	0c+ZWJB19U7IQ2ZPhi4gvGBIGE5hoKM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-75zalNltNKOFngo8SMPrbg-1; Thu, 08 Jan 2026 10:42:21 -0500
X-MC-Unique: 75zalNltNKOFngo8SMPrbg-1
X-Mimecast-MFC-AGG-ID: 75zalNltNKOFngo8SMPrbg_1767886940
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b70b1778687so277453066b.0
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 07:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767886940; x=1768491740; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEg3oQJaVSZ9gyf64NrqCt6gf+xa+Xosp1a/kSE2/LE=;
        b=riDIt35jOyvWopvNnOSj4H68EKyzfApCbkIL/L+s7aLD+nnVweGVb/nqZTXKYoRLpt
         kb/MdCMO7wjZRpRlcmQKewWmi1cRtKXpcFEBUOWEDXIa+LEWrtJr1TNo0gvxmI5P0aDx
         F23e8+vgwKVLXfUC7xoLeNtntxQj2ZjQ6zx8w/+0S8VIc4Oxf6rmQCfuE3zDVdA8PKlN
         KOcIRWx+wVaY3O9sJEVHBuBBeQzglgFOSdGOhFjs8PSOIT+RIjtgdQOtyyE3alDtWmED
         15kTFyn2xrryVdvl+FEKjLTT4eVbc4tfruCHosVS0IjjS7JGmcgJz6LKV28WL4iZ51HK
         mx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767886940; x=1768491740;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEg3oQJaVSZ9gyf64NrqCt6gf+xa+Xosp1a/kSE2/LE=;
        b=o3PdznaN7Lf1VlVSapdiQMVmiPClc7KVSlDNdIinyUAn9kxamyESbAPZBsfvy8nC3X
         r4+xrGsUcLiaQbvR0AvITphwE1ILOKiZgZ8krO0DRlN2MlWbTD5UVuDqqRGA9W8WRuDt
         zJkxpUjWmwKVGMrhKRvPujXGADV6TXa6I/Zf+A13AJowHKkdf4/7HhRVyjUA38Nj3yrL
         qtSqci016D+9bUi+ArjjLkWLk+2mfOy+IS23Kksb4VK46F9SR1pllPVu1q5QUkjiM/3p
         V5enK2BYPuOF2YEPShtCDDmcgm3LsDujuKqj1Cdy9otLZ7F1SE6K69FcB6h9DU8FNnzs
         QTUg==
X-Gm-Message-State: AOJu0Yz+8fOllVYMP8O7v6KhzHb4lx+xapJKbs55xj7ph4g/Eh8JXUkX
	YhU4F1ovxusp+Sxzwg/gLgcuHXcvI3Vi9CUVlXZPZEEYMJTMf6yj9XxUgZ33qJVqOfwda8+lPP2
	tg2cINVMTwa9eOKe7hNMVKWqOcy5LEIbF8mesO0ldfXhm92OhG3xrlw==
X-Gm-Gg: AY/fxX4q5etN3h+WPC6AXO/e8tuGuk2v/CyKqgKDbFSuVtcdXfAkfx9eskStmY3P47f
	Pau9soYOqlaWEfy/qns56rVpTgP6SDbHCY0JN0ywHYmqWAVQluvQZn+rtMZFAoZ8OrqJMAQ5y1d
	EV5AYtoqwMY72Os/Ap2GKWUMzerA8b1h2g7RIP82D41CXiF1+sLr+/p0NzQ0ee3XntBhhlgo9Nt
	rHnXWqo32Eh0FDkztTZLKiWbj01sy31uEdMcg4h+bvcZ7K5yJUjW4GCWoNUNM1d++psEte4WPfJ
	uZsVePVDyibdGmYo84geqiB8jkty0E4eIOsZeeJSJ1aY9BzKfbKPjwZYMZPc6e2IgQQ4tpR5Mqh
	aVGLUqYTU4OEe3NIbGki5shvUzO5o3t7o+A==
X-Received: by 2002:a17:907:97d3:b0:b76:4c16:6afa with SMTP id a640c23a62f3a-b844520d854mr673246566b.28.1767886939704;
        Thu, 08 Jan 2026 07:42:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEmzm9ojkdaouBuECH5ouH3ZkOr606lOqHVp+y6UkQhX2c6rO2xuikgZvCygfJYLp5GDnXHg==
X-Received: by 2002:a17:907:97d3:b0:b76:4c16:6afa with SMTP id a640c23a62f3a-b844520d854mr673244966b.28.1767886939218;
        Thu, 08 Jan 2026 07:42:19 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a51577bsm822611466b.56.2026.01.08.07.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 07:42:18 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EA652408391; Thu, 08 Jan 2026 16:42:17 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-crypto@vger.kernel.org, Ard Biesheuvel
 <ardb@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH iproute2-next v3] lib/bpf_legacy: Use userspace SHA-1
 code instead of AF_ALG
In-Reply-To: <e1fb9a40-9580-4c6b-8272-2d306a581cd1@kernel.org>
References: <20251218200910.159349-1-ebiggers@kernel.org>
 <e1fb9a40-9580-4c6b-8272-2d306a581cd1@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 08 Jan 2026 16:42:17 +0100
Message-ID: <87h5sw2js6.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Ahern <dsahern@kernel.org> writes:

> On 12/18/25 1:09 PM, Eric Biggers wrote:
>> diff --git a/include/sha1.h b/include/sha1.h
>> new file mode 100644
>> index 00000000..4a2ed513
>> --- /dev/null
>> +++ b/include/sha1.h
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * SHA-1 message digest algorithm
>> + *
>> + * Copyright 2025 Google LLC
>> + */
>> +#ifndef __SHA1_H__
>> +#define __SHA1_H__
>> +
>> +#include <linux/types.h>
>> +#include <stddef.h>
>> +
>> +#define SHA1_DIGEST_SIZE 20
>> +#define SHA1_BLOCK_SIZE 64
>
> How come these are not part of the uapi?
>
> I applied this to iproute2-next to get as much soak time as possible.
> Anyone using legacy bpf (added Toke in case he knows) in particular
> should test with top of tree.

Hmm, not aware of any users of the old code. I believe most distros
build iproute2 with libbpf support these days; that's certainly the case
in Red Hat land.

-Toke


