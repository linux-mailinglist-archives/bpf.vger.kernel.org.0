Return-Path: <bpf+bounces-64248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 038E4B109AF
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 13:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98E117B865B
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 11:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E332BE642;
	Thu, 24 Jul 2025 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="R1rD5iD4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2692BE630
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 11:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358168; cv=none; b=kVKstnRSBHHPpMHz8PqeeY4e0f7c+xAVgZV5QVKJ44T7qI+FBM00/pLSJu4EDb2qqLMNcGwnBPE9HIBiW/2Swh7oz/mSxGZptAQpSSiWHv6GxOlkWuiJFWp0Z/ebv1w9qWwXXC8SHGRz+133pMAUi7EJVBip4GTXSw4LuQQCMiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358168; c=relaxed/simple;
	bh=urnvLDEnBW4wv6etiKCX8sOFla/G58/fHUKcD0ZzOhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qsFqH/9Nl+go6Ah2i6RT9segf5u+9dVDEwZsCRpFbkXPxOSy0cm7bR50x0OBg3wWoPgdG8YPBZHsK4T7N1XFeFsD1jeOwmbE652hG5VsrPFcluwSaV/BHyLcG3B+ltgmugZ0YMwFi0E3DhgGYZ0OTzo0hiWCkp6LdXRsAlxpbMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=R1rD5iD4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so211129666b.1
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 04:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753358165; x=1753962965; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=urnvLDEnBW4wv6etiKCX8sOFla/G58/fHUKcD0ZzOhU=;
        b=R1rD5iD4/I3JEgCwmvkiylHv/Qx+NeeRQx65/t8FH1Irfr3wTeW0DqWF8fFsVVISLo
         EFXZYoJZwwMkj6+QLrtF+B/ac5LkP9gn1p8zeFvPuEi7zS+3fpVzbhfzRBlDo1dE4NFI
         ZI26/J36NwNBzSD0JWWxAeuhGuvBadZ0S1I9qw37MqQgS4ecOG+YxDBX0osGnlGC8zmd
         O41oYjgMGMR2P3VZ/j6sIz5Em7C7HeQvEeS5wlY4vCrFOMhgAkxZH/7KNxOGuQZZ0eVf
         8nBY7cv6d37y9PngXp862lpVoJuAB+K0yjY2jTRfhqinMoifPP+wln0jFV9rZAsaHevP
         jSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753358165; x=1753962965;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=urnvLDEnBW4wv6etiKCX8sOFla/G58/fHUKcD0ZzOhU=;
        b=LGqUDifJ95clemc7qu0GCRBG7/eYNQ0flQjb6bvbJfFBKELcvL975hTD5bWSWhwM+S
         Ec96FfuHhFmnKbAJw8xBn3MtYLJIJnYFsp1Hw3ofkYmzwAnfKhutLxkzSEzUDqudkilC
         tW+Ngq06+QBNEaBdf7PZSOZk1WtxPl4h3Id3T7P0CX+oi5FFDBixJMYAZDoFxKdIDadH
         gW+728n5R+0fvv61wXDORX1ksBmtg3blAha+DfOx9xksPqDdgxviTYpSyar6izV1GUSF
         qgWpwseStfxFPet3itzPlifg9Z9XnyWHCuw3ez+uNYBIqF6bbd2UWPIqdXhmP9ifQODR
         MQPg==
X-Forwarded-Encrypted: i=1; AJvYcCWjlVNxgvRBU7kZuAY0bYWqMGespiruGsHCf/pENbStDKfleiI8UNFpnPo+DGSeQFrZi4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0I2ud5SYlYUJHDjnBjcpVSRiIRmoW0YogtGpgJvDhqomxXtHc
	Ui9zrumcuhku29tIC7K3lQLnSzw6MTts3f6pnDTNJCRG7Q+DrOIJg8uzTLSt0/cv02M=
X-Gm-Gg: ASbGncsd041Fp1ERwZ+EfPYPqROiDn1WtIlDU32P1ag+jJoHoOeJegtiZ8p/Zl7fuqL
	BFfN7kmtmVl54nkJMjObHGQwjtDaJPrmr/IaP7nqJtiBPQAXyqVPqjuW/7Szk+UpM1YebMa+o93
	zK+5yFfFskJ4DWFIEGWk8WFMzymFdrJy95PWCDkUHJbBVZWJpo4W7tDIoSV6UyMczV55cB6A1Gs
	I1FASe9y16qB5Lfu1jvkrgrU6g8lIjrLRji4ym3ZPewIrJCWpbG9NkPI08YXJGPmemcDqxT6KX8
	QBJmkMGfgbtIEqWYEhltgbWvVv98zbzt/rptO+lj5FQsdNPPSYUMiML/inUqdAA0JtB21FJMeut
	rTeFXMgcfKeQw4HHB9dDYWNnPjw==
X-Google-Smtp-Source: AGHT+IF918c8okf/WACNVzYyYzvJD7eD9Ppe1ib0SvipyeviwFxo1UpP0mVqL02li897zwj8/2ETmA==
X-Received: by 2002:a17:907:86a4:b0:ae6:d3b8:81d7 with SMTP id a640c23a62f3a-af4c395c91amr183730266b.30.1753358164519;
        Thu, 24 Jul 2025 04:56:04 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:5f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47f44eaf5sm102705166b.80.2025.07.24.04.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:56:03 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,  Andrii Nakryiko
 <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Eduard Zingerman <eddyz87@gmail.com>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Jesper Dangaard Brouer <hawk@kernel.org>,  Jesse Brandeburg
 <jbrandeburg@cloudflare.com>,  Joanne Koong <joannelkoong@gmail.com>,
  Lorenzo Bianconi <lorenzo@kernel.org>,  Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen?=
 <thoiland@redhat.com>,  Yan Zhai <yan@cloudflare.com>,
  kernel-team@cloudflare.com,  netdev@vger.kernel.org,  Stanislav Fomichev
 <sdf@fomichev.me>,  bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/8] bpf: Add dynptr type for skb metadata
In-Reply-To: <00a19156-cf90-48ca-be91-6c218b317044@linux.dev> (Martin KaFai
	Lau's message of "Wed, 23 Jul 2025 18:54:53 -0700")
References: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
	<20250723-skb-metadata-thru-dynptr-v4-1-a0fed48bcd37@cloudflare.com>
	<00a19156-cf90-48ca-be91-6c218b317044@linux.dev>
Date: Thu, 24 Jul 2025 13:56:02 +0200
Message-ID: <87pldpx0od.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 23, 2025 at 06:54 PM -07, Martin KaFai Lau wrote:
> On 7/23/25 10:36 AM, Jakub Sitnicki wrote:
>> More importantly, it abstracts away the fact where the storage for the
>> custom metadata lives, which opens up the way to persist the metadata by
>> relocating it as the skb travels through the network stack layers.
>> A notable difference between the skb and the skb_meta dynptr is that writes
>> to the skb_meta dynptr don't invalidate either skb or skb_meta dynptr
>> slices, since they cannot lead to a skb->head reallocation.
>
> There is not much visibility on how the metadata will be relocated, so trying to
> think out loud. The "no invalidation after bpf_dynptr_write(&meta_dynptr, ..."
> behavior will be hard to change in the future. Will this still hold in the
> future when the metadata can be preserved?
>
> Also, following up on Kuba's point about clone skb, what if the bpf prog wants
> to write metadata to a clone skb in the future by using bpf_dynptr_write?

Good point. If we decide to implement a copy-on-write in the future,
then this will be a problem. Why tie our hands if it's not a huge
nuissance for the user? Let me restrict it.

