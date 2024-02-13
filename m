Return-Path: <bpf+bounces-21842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D31BC8530DA
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 13:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B017B2120D
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 12:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC35405D8;
	Tue, 13 Feb 2024 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUgFACoi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A393D54D
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828505; cv=none; b=FCoT3tVrhE1uxGHbAVgEFyisM1sbbypCcO5+JKvME22uCmZJLo7+w3xVXMzRhIDSmtUnlQEuJhB0dKwVshLxFLcfavAqCY9S0dpHn3SrotWb/PGH8de/vEpfSE72twRdVTZABqPjybyBiDq9n2vVzol8RONtFR64arPeug3YCrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828505; c=relaxed/simple;
	bh=P7sIK2yqHS07HQ1k+544RzOSBeYoZ/VEh1yqZbf56a8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=okXSadjJPdZcovFD3YYeUNTbinBJAPpQ6H2mdbIL5iq4S8Y9IYapee21WwfiZusGREpoBpB9PRwFfKs53biwbSvWvqWuJcHX9PRk21r2Q/GEB+LjUWDIMdTOyR+yRjvT8LS9GXIJ9EvdwwBQhaBcbiV1uRmIbJ7L9xYwOfnVZr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUgFACoi; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3ce9a33fd8so153966266b.1
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 04:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707828501; x=1708433301; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gNm5+geinFbulU2ZOUVp2aUHAqH8eClWxQ+6AibxjLo=;
        b=KUgFACoiofEKwebcEwljEdlZ6WMy78SNnvjOLfadbJUYCqzMmT+DEMDbrHIguhMsQk
         pj2T2jByRU1ZQA+p5fMiBA1tIqYRPqqqq1iqKi6Xm7MPfyfagkeL3kRNUqtItcdoaPFP
         oe00FrD47rCekD3XHSrbhfddEbKYC2ROGIzj0N5CAjN6p3rO9BJuQjdCWadyYfH3CZOA
         Su+3M1IbvQT9UVI9+3d3wggPlomFlhygoA6JM71Y+IJ2QEvjf69iLOmuD3ZoTWDSFxvr
         7uohfvjHm4ZdNy31VsB7dDVmGQvs5laLB/5vYoID6gH1EV6/kb57tCdBr/sdILir0ISc
         EcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707828501; x=1708433301;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNm5+geinFbulU2ZOUVp2aUHAqH8eClWxQ+6AibxjLo=;
        b=B+ee3qhUKA1qAM12Y6GIxjiFoOFl/eBOoi0fwe2ZRrEBECN+2fC9ZQvj/EaUA82geN
         OBzpgQrFFAAW2MqnTc1kFHnYnS0Wbxnex/ZuTm7qZEpsiSBRM0BBaPSFbAvrPGhE0dbH
         FQxDYZlH4eKw76Zna0uTgf78+JC/qs7c/vYKg/CHizcKHxPQ4bvTBZOoYHkFlXNqcIo4
         cXmRBbxQzKb5Wv501C1U1LvdpFHvo3hLSzkv6OdC4xyd/nytI9akEvexwWrbcko/ABUe
         bouvm1P8zsKy1RoqgyMPIAoc/SQB4bYgxNwqAbgch8M4loDakP7I2a6vYVRPFHdKVCXp
         wVSg==
X-Gm-Message-State: AOJu0Yy15vWC4pvEoyQQ1bdu9qrcYoeI5vWIEFydp2Thna13f58hMxDL
	KHd+vDBmByj/rZfSCi+1iY++xxgbrjc8JrXzMZdyXB/02JhTOFHO
X-Google-Smtp-Source: AGHT+IHyPdc/etRYHhq4qPRfM8CJr6N8DSy8BByvS66oBA89oQGy7dZpzNAEyMKKAuHDtj4c0Ap2nQ==
X-Received: by 2002:a17:906:6acc:b0:a39:d272:3715 with SMTP id q12-20020a1709066acc00b00a39d2723715mr2034707ejs.37.1707828501445;
        Tue, 13 Feb 2024 04:48:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJcP3HuQa5YXe3tseOFZ9pvTgPcc8g5wge9dFOVzYv/Zop05NNy84hOJbzF5viID8n3d8MipAPFb8rKay+GBZQ1j9esHrK/qIFWhKtDwAUYnmpmDvJWCYRLco9LSVLXIVwkA9sMNnAOTmgQFPthm89+r1xXVUNNXuvG6vy4J/RTCoZ1HcAtejkb1YBIUarWhmooxifFTVsFQg3Yaon26MuMnAU3evytynmC52IGGYKhaD8us1IG+iapKm/N35dDViwtIRDTN9Z2h6O00vdxLXYhXa0OC0u1hwTzO/oHQ4H1w29ixZCttcIvCDgenBE0Rk9dryZMH6XzJBCFLqoYrxuNZ/k6W0cWm2QMyp9LIa9n27R85KZ4u+5Bw==
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qo4-20020a170907874400b00a3d00616e1fsm621178ejc.193.2024.02.13.04.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 04:48:20 -0800 (PST)
Message-ID: <ba9560f89193346e03e81c94e92574a8978cbb55.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 14/20] libbpf: Recognize __arena global
 varaibles.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Tejun Heo <tj@kernel.org>,  Barret Rhoden
 <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>,  Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Date: Tue, 13 Feb 2024 14:48:18 +0200
In-Reply-To: <CAADnVQJTQueWz8prUcodxWd4XVX9o+p1h+5R4m9VEFtFyvSkoA@mail.gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
	 <20240209040608.98927-15-alexei.starovoitov@gmail.com>
	 <d84964662e2e11e6c94da99c7c3e8a8591d1376c.camel@gmail.com>
	 <CAADnVQKTHfRWxBm08O7CcKri1NOSTS8vby3+ez2gRVM_XYEfKg@mail.gmail.com>
	 <d5b827ea37af7b5ac71bede71f17c96e8c434422.camel@gmail.com>
	 <CAADnVQJTQueWz8prUcodxWd4XVX9o+p1h+5R4m9VEFtFyvSkoA@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-12 at 18:08 -0800, Alexei Starovoitov wrote:
[...]

> Since it was a surprising behavior we can make libbpf
> to auto-extend max_entries with the number of pages necessary
> for arena global vars, but it will be surprising too.
>=20
> struct {
>   __uint(type, BPF_MAP_TYPE_ARENA);
>   __uint(map_flags, BPF_F_MMAPABLE);
>   __ulong(map_extra, 2ull << 44);  // this is start of user VMA
>   __uint(max_entries, 1000);       // this is length of user VMA in pages
> } arena SEC(".maps");
>=20
> if libbpf adds extra pages to max_entries the user_vm_end shifts too
> and libbpf would need to mmap() it with that size.
> When all is hidden in libbpf it's fine, but still can be a surprise
> to see a different max_entries in map_info and bpftool map list.
> Not sure which way is user friendlier.

Adjusting max_entries would be surprising indeed.
On the other hand, it would remove the error condition about
"Declared arena map size %zd is too small ...".
Probably either way is fine, as long as it is documented.
Don't have a strong opinion.

