Return-Path: <bpf+bounces-77440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F34F5CDDD43
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 14:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB99A300E3FF
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 13:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3927B3081D6;
	Thu, 25 Dec 2025 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeEClWCY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC25220F2D
	for <bpf@vger.kernel.org>; Thu, 25 Dec 2025 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766669895; cv=none; b=gzD5uVkGU98PLWq2HJQvk8nBaXjQadwUpCHotqlYGcV/kMqzLqe5Hbwrv3PD7XlTQ7MMP74v+X229nxuKQwbJ0/7FF2Gmj97HTug1QCf41ZXzjK/VUANUJacXFkC9wI6rQw/z44cSrLKHitlPO8Ww3xv3FWY5kv2FcQF0eNDWek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766669895; c=relaxed/simple;
	bh=pmnz0oGl2vjflMVXwJDwVUMJcljdGcnjC9a50JchBI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvqFt8PyeTlyakyKgOrji9RbvHKRSdf1pw0fp/ql2rT7B1Ln8eMw8hHTOdbBcgyINUrxEAVId+NU5p1flW+FHuyAYYr4HCcDh69QVJ9mNTn0AV0Zj+taiSLVu9gbsnkrqh9zXKz3dFtQfQ3u3Nx06vExlD3mFtM3HTjMiMXN+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeEClWCY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b9b0b4d5dso10320627a12.1
        for <bpf@vger.kernel.org>; Thu, 25 Dec 2025 05:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766669892; x=1767274692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=awCVuvgAZaXJOt5osuiXjNYZyCIOZG2/wfsfiJqr6tY=;
        b=jeEClWCYiOd/l5tak/gH7EbJE8IEqVUumjxISpRE7ZAAM6+Zj6W7Vd1sNN3D6Km9aP
         jKkpF+UxuQ1FsaBpi/U8nN92FYmw490G+ySeWKMQ00uIglDQwL02qaUe1eXuPkCSzxN8
         FXVLW+dfpplfsj4qMnorOw5AOZ4ImVu6c8XMBA2fmB7vG0KMpWjaEYCk7tUMjMuYQFio
         nIFHTZUeqEXFC6zWzTgfZ1UT7hIV0bMNjp8kDK4Qvg1QJDGx0rdbaQh+vB7cIRHbEFLW
         fELL7isDNmd2vU8AhsuRGFmg2UFBLMhY+mxv/kAva0LAE7aQsMYBMLURMrij9RHf31hO
         lrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766669892; x=1767274692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awCVuvgAZaXJOt5osuiXjNYZyCIOZG2/wfsfiJqr6tY=;
        b=XD7G68NrOhWhftuwsqVz9nQeGcCweu3Foyuew8wY9FQxmDiniUYPv5krGqIuKgXc1a
         +nM5ZKTwtgQs2MqMhgJDHz7hdX2UaUGrTZFBK89YToUTkH7NpvXRcsqix05bMECw/F+H
         PM+9w7X4Rx4PG9nDJVk6CWWIX4gPywrSPXna7erg51BOcGqaCQmyjhvwXw8x5Z5KM3jb
         zz5NW34xB0soNw/4iI0f9xGK+cScPC8jhaZ2v92ZcMMRIZKt2UDfwEdpyLiRvYzfIC9B
         +CrcV1nuwdMdek7HwM1LcMoV9VozMpNtPxkrWDPHi2lN46SqUxeoi/RZ+mSriSh4Ibxd
         BqUg==
X-Forwarded-Encrypted: i=1; AJvYcCWwPZbNkiMyxQrXlraxPFVeuQXX7VN/ZkllQH8ViGI4bf84FlDH5eQJdcMmobAitJo82Os=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvLYoDf4iGmmrwuu1PbLD7aEuhDhqjPURqFpdf/LP1m6gYNspG
	ajMKRELzrgVe9Zk0XorDs5nZRaMwbntxr6gbITsjhFQo6qc59Vl1IXPeXDlwPw==
X-Gm-Gg: AY/fxX6OVX0DXTWycK0p8YgaFFGmPTefYm2CV2maiqWu+n5Z3xuL9Qzy5InMrMFzO5W
	WZFaY2Hy6rcqn4JTWabhwC4OTknmj4i9o38eV103y9qkbSj6D9Eh8jcV9afmclXQfEee2gnI40b
	yanLqYMZZtNIqhPcahOiErpzlJEFgRPvtRPtnojhb7VrhQAOw/vvY1WJ2o3VI2F+sdmW0p3UpKI
	TT9O1u/PF84AEn6ZIQf+JNNiRgqpTXGyKDVlYsttM9a1yCQ/TQmHtSRc/rRhFk6P2HTU2W5/43f
	ZUTgB3/XTxRNUeY+cEJLvCjPCbFEP+R7cNKA24464ysaGt4c7fUzqs+x8/ceRcD58ATjTZx+eWk
	6YyXGzQJEF1kvRPmaZxt32g4Hfh6VRRP3tfDw77MVEHYshRjEOCuRc+hgfhgDaN0FEUkJ8ZSNCm
	bubVdidOfHSGxXt6AYhz4P
X-Google-Smtp-Source: AGHT+IEILxAdqeW8O+YyFkQZdShOQv9nnTYoXvE6RJmcyl/wZHptGG6yij3umskXKM+Yy2R31pQoAg==
X-Received: by 2002:a17:907:6d06:b0:b71:854:4e49 with SMTP id a640c23a62f3a-b80371d4462mr2161942966b.56.1766669892248;
        Thu, 25 Dec 2025 05:38:12 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f519c0sm2052208766b.71.2025.12.25.05.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 05:38:11 -0800 (PST)
Date: Thu, 25 Dec 2025 13:45:41 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH bpf-next v2] bpf: arm64: Fix panic due to missing BTI at
 indirect jump targets
Message-ID: <aU1ABRjEg7RQWub6@mail.gmail.com>
References: <20251223085447.139301-1-xukuohai@huaweicloud.com>
 <15c26b1f-b78d-45d0-b5d2-e8359ddf5bbc@linux.dev>
 <aU0aW3VE1a8FI0Xm@mail.gmail.com>
 <4287f839-d713-44d5-afa0-918f2a44c5c3@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4287f839-d713-44d5-afa0-918f2a44c5c3@huaweicloud.com>

On 25/12/25 07:46PM, Xu Kuohai wrote:
> On 12/25/2025 7:04 PM, Anton Protopopov wrote:
> 
> [...]
> 
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index da6a00dd313f..a3a89d4b4dae 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -3875,13 +3875,32 @@ void bpf_insn_array_release(struct bpf_map *map);
> > > >    void bpf_insn_array_adjust(struct bpf_map *map, u32 off, u32 len);
> > > >    void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
> > > > +enum bpf_insn_array_type {
> > > > +	BPF_INSN_ARRAY_VOID,
> > > 
> > > What is the purpose for BPF_INSN_ARRAY_VOID? Do we really need it?
> > 
> > There seems to be no need for a name for the default case,
> > but BPF_INSN_ARRAY_JUMP_TABLE should be != 0, so can be just
> > 
> > enum bpf_insn_array_type {
> > 	BPF_INSN_ARRAY_JUMP_TABLE = 1,
> > };
> > 
> 
> Having only BPF_INSN_ARRAY_JUMP_TABLE feels incomplete, since there
> would be no enum value to indicate an instruction array without a
> specific purpose, like the insn_arrays created in selftests [1].

Yes, but it is also never used explicitly, right?
The only usage is in "x != BPF_INSN_ARRAY_JUMP_TABLE".

> [1] https://lore.kernel.org/bpf/20251105090410.1250500-5-a.s.protopopov@gmail.com/
> 
> [...]
> 

