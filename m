Return-Path: <bpf+bounces-79150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73432D28A69
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 22:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F366E30A5E97
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 21:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C4132573A;
	Thu, 15 Jan 2026 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4XJgfLQP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396F23246FA
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768511230; cv=pass; b=VxeIdIjUuG/kDQC7XqFeeoCRd/A+p37aIxHms1eDN717DBAOdjqFm8IWaiExK9speOEwT3ldADIOw6Fp39UsBeJ5L2XpKtd33j90G8Um6khLMP6P0QtPntun89cYi9kJbswV3TuxaZTIKG2q7V3FmM8Pyra+ukW9tsTI8Vf2KRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768511230; c=relaxed/simple;
	bh=Yj5Px6CBHG4dfhDnY0aiL+o/Xd3AGh3M1dNNpc7+Hj0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIcSzXahC9405z+EfPz+iuZNsR8TyXV+FLmNcjQry1pVppmelTiw1ScFmUolRFynLlX76wfxjElMlHJ+LhZAZAuzUKSCvDVEIXH3vphtH7zx4xnEKc0Q6j6kZVLmpuYgP5jiGdUrVAe0RmNNZxECjJ5z//VoJjRxfDQ4BtzyPqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4XJgfLQP; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5ebb6392f58so456505137.0
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 13:07:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768511227; cv=none;
        d=google.com; s=arc-20240605;
        b=TKetkCGYDO23nZUA8Sq6CtxuL8KwWfgXhBCgD5GJQ+HN83usc7ucqEA3T511H+N3rT
         Rfydv++DPMJNeOJ1Xr4ytJX7988i0d0nMTz0hXW5PJ3RDN8PmPzlK1F4QlFOxskQjw5c
         KsqynnqgO6ljpAzudBwVnjVBBb9attkaEG9hqBlaH/qBOfCFbCR4/LHr+eJa+z4tdH7v
         HIVqfsKkqOgcqTk8AlX1SEBuSTIa7Xm5D9ypcgicm+x0J4rJMVDGYzuYqC1cH1hTlgJ9
         YIZ00wrnenH9NuZHP0T25IkKbVuBmFnD1ZEi83SzmkJeH6TE0C2DWOOwsndBUy7UAios
         wAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=y4BwArZ5FLhyM5BEN34gjuDvwbvdpN2Nxoskvco/5nM=;
        fh=J8e6y6inhwhLhBjFXPd4PkuCLC0F+uxHLsTd6MHQ5lg=;
        b=L9usWgB5UDVwobgH1R6yrI6f2GHbzf/814Wvem1hPqTyxhMTbHOHAfc2oNfkL+BkcK
         2fdbA8QZEs9neYSKeV9ryE87HOw6bB+fGu4LnuSZmjS1Rd+/biIMfjmY+HsRhy7mtRik
         fmTZSCp14j8d+5Givs29I19V2T8oCuHd7pjB0u7GORaNnssCQbCCiK00oxxovUwtXGDK
         vW8S2yW/IlDTi7ekv7UFmVyjI7bWxWI0QD7jq5Oo0iQJ3D9wWVkIa1V7mR/4dKY81u0o
         TQDMj5GZuTBD6oPMAV9tsa+u4QFozYSe4T6gNtBGypI/h/6jbiCJk3cv3Eb6t9DbajKg
         R7Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768511227; x=1769116027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=y4BwArZ5FLhyM5BEN34gjuDvwbvdpN2Nxoskvco/5nM=;
        b=4XJgfLQPzxM5FXWJkEQS/kXTzEqlaoNNsykVgVssx9ILv7rH2f0RPJB0Dsm8qrAms2
         ca1bhsEOHx0BFLwVRFmof0lTpYymrpbdRKK/1/bgNnjBFJ1AA+33K9xdNQSiAbvhG8Vy
         kL1ZSO+dansx6NIyFH+a86drC/+BMsplkmTtJSR9nFM0y3dL3IKx8KoAfTFU2xpZZJqf
         kXdl+n+ILpES0C/0nzoY1zoUXovu+P1soJ4YMJl215plLGiz7WqYtLuFdstWhf3zf/0K
         vN6yKSUSFWHjiVS56FlbC+Rx9vxZCxMtufdgDE6UWoEzY472DLjt5vOicDkHTSjO/ErR
         NXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768511227; x=1769116027;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4BwArZ5FLhyM5BEN34gjuDvwbvdpN2Nxoskvco/5nM=;
        b=dZxhTsTP0scufzW7XHniz8IT6o6PSJbU/49mgAtmSH5wM9fXQ//TBArKCytjlH060f
         QvI9hhGgc3VpXUPaoyhckzMw/2alcdB+V9bjF5OvaXuUpDv8A6O97iY/dq5yvk3GJxg9
         8xFzlIAaMEXqH0kIFZMPbkXjJyqfkkE73RP6vOf9VG6rsMOfYOVwhzgBMolMLKm2fzJZ
         071xD9THVLLBuiaD8PxN3zUrDeLuKeoKqSdIEXpdiASAIMeqJpDvCRDr7aOTklYEYrdL
         U7gMDCgFtflOG2ee01lprSiTGgyBlxaP2e84pS1oeH7whYozjniIioWMR6OS9Y2cvMC/
         aOdA==
X-Forwarded-Encrypted: i=1; AJvYcCXW7ZBUroWjo/dsagNZ43t60lmvEcucJYHMh2yNHyS6hYd+SyMGA3qUaGf8Aj0cDyXBLyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy98+mc66msvZi1dxB3CG+o5TSkn3mBACCJeKEFZFOvGUZk6Ky6
	eGlYR0szvSVllagYVdG+vSwufBhL/ygwV3GZTjs0y7pTqdC65eZ1CoSXnF5AROx2rhB8wWnffW+
	ZZISMxwFrR0P1XXOfsPsC/Qgp8pF9+1vwgxZshlAE
X-Gm-Gg: AY/fxX7brdgWUpPsZfXQ/f4SOkP1p6o3PT7vCD80pagXcE5KJ1IlpqQ1lA7vIWKurT0
	Z9M7+SgJr0TG/CLWGenWB8HKVh39eV9aXKNKY4XJu+5Xega4L5C7xzB4OU9raA84fmht0q8jB/P
	q2KwqreOzEANfdliiBEYV/etSL41FDPVKAxgV2e+1V4vEPl8uOHbsg667/ueJl+H8ESNBSRPNX3
	yY6p1/hPKK4C+aGFXRUMpSrJHv/VhWumz0cnjq9IJFYhg15DdE6LgnWvhLKdzc9bjwmjV9cAotY
	FgtQ60xOxtSkgfeMd0qpkkGkkQ==
X-Received: by 2002:a05:6102:945:b0:5df:aff3:c41c with SMTP id
 ada2fe7eead31-5f1a719e362mr155618137.30.1768511226367; Thu, 15 Jan 2026
 13:07:06 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 13:07:05 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 13:07:05 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260114134510.1835-2-kalyazin@amazon.com>
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-2-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Jan 2026 13:07:05 -0800
X-Gm-Features: AZwV_QitN6L4bb0XJb_ZZH7nFdRT7CH1pyddv4cbgutSArI7UeCs00Q7KzDEw7c
Message-ID: <CAEvNRgGXeow48BUJYyuAOUp8qK97v1LdF4KdTB=Nbk7pTs9tfw@mail.gmail.com>
Subject: Re: [PATCH v9 01/13] set_memory: add folio_{zap,restore}_direct_map helpers
To: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "kernel@xen0n.name" <kernel@xen0n.name>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org" <oupton@kernel.org>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>, 
	"shuah@kernel.org" <shuah@kernel.org>, "riel@surriel.com" <riel@surriel.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jgross@suse.com" <jgross@suse.com>, 
	"yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"coxu@redhat.com" <coxu@redhat.com>, "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, 
	"maobibo@loongson.cn" <maobibo@loongson.cn>, "prsampat@amd.com" <prsampat@amd.com>, 
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jmattson@google.com" <jmattson@google.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, 
	"alex@ghiti.fr" <alex@ghiti.fr>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"pjw@kernel.org" <pjw@kernel.org>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>, 
	"thuth@redhat.com" <thuth@redhat.com>, "wyihan@google.com" <wyihan@google.com>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, 
	"vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com" <jackmanb@google.com>, 
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>, 
	"Thomson, Jack" <jackabt@amazon.co.uk>, "Itazuri, Takahiro" <itazur@amazon.co.uk>, 
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco" <xmarcalx@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

"Kalyazin, Nikita" <kalyazin@amazon.co.uk> writes:

> From: Nikita Kalyazin <kalyazin@amazon.com>
>
> These allow guest_memfd to remove its memory from the direct map.
> Only implement them for architectures that have direct map.
> In folio_zap_direct_map(), flush TLB on architectures where
> set_direct_map_valid_noflush() does not flush it internally.
>
> The new helpers need to be accessible to KVM on architectures that
> support guest_memfd (x86 and arm64).  Since arm64 does not support
> building KVM as a module, only export them on x86.
>
> Direct map removal gives guest_memfd the same protection that
> memfd_secret does, such as hardening against Spectre-like attacks
> through in-kernel gadgets.
>
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>  arch/arm64/include/asm/set_memory.h     |  2 ++
>  arch/arm64/mm/pageattr.c                | 12 ++++++++++++
>  arch/loongarch/include/asm/set_memory.h |  2 ++
>  arch/loongarch/mm/pageattr.c            | 16 ++++++++++++++++
>  arch/riscv/include/asm/set_memory.h     |  2 ++
>  arch/riscv/mm/pageattr.c                | 16 ++++++++++++++++
>  arch/s390/include/asm/set_memory.h      |  2 ++
>  arch/s390/mm/pageattr.c                 | 18 ++++++++++++++++++
>  arch/x86/include/asm/set_memory.h       |  2 ++
>  arch/x86/mm/pat/set_memory.c            | 20 ++++++++++++++++++++
>  include/linux/set_memory.h              | 10 ++++++++++
>  11 files changed, 102 insertions(+)
>
> diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
> index 90f61b17275e..d949f1deb701 100644
> --- a/arch/arm64/include/asm/set_memory.h
> +++ b/arch/arm64/include/asm/set_memory.h
> @@ -14,6 +14,8 @@ int set_memory_valid(unsigned long addr, int numpages, int enable);
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
>  int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
> +int folio_zap_direct_map(struct folio *folio);
> +int folio_restore_direct_map(struct folio *folio);
>  bool kernel_page_present(struct page *page);
>
>  int set_memory_encrypted(unsigned long addr, int numpages);
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index f0e784b963e6..a94eff324dda 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -357,6 +357,18 @@ int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
>  	return set_memory_valid(addr, nr, valid);
>  }
>
> +int folio_zap_direct_map(struct folio *folio)
> +{
> +	return set_direct_map_valid_noflush(folio_page(folio, 0),
> +					    folio_nr_pages(folio), false);
> +}
> +
> +int folio_restore_direct_map(struct folio *folio)
> +{
> +	return set_direct_map_valid_noflush(folio_page(folio, 0),
> +					    folio_nr_pages(folio), true);
> +}
> +

Was going to suggest a _noflush suffix to these functions, but saw
Aneesh's comment that these functions actually do flush_tlb_kernel [1]

[1] https://lore.kernel.org/all/yq5ajz07czvz.fsf@kernel.org/

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>  #ifdef CONFIG_DEBUG_PAGEALLOC
>  /*
>   * This is - apart from the return value - doing the same
>
> [...snip...]
>

