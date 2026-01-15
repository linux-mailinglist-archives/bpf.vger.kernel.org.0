Return-Path: <bpf+bounces-79143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B47DBD282F8
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 20:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 995053044BB3
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B20531AF31;
	Thu, 15 Jan 2026 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2xDa2ZDe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8912731A7E1
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505993; cv=pass; b=Z9rK307vH3jbB9AgAiSlQSIMN6ARSTSyHIsIZWBo8NiOJlRa1O+hGFW+Fwefl5swWY+OEYBYQ2s5MGIrq3nEyIWtFfg06puhfrDPUOyyQHu66xFC5/x1Ma7RmrfrdvAY7ddvlyN4YUNGHWJhQBWyUV7QaXPvV2a7EP9O8GvgMEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505993; c=relaxed/simple;
	bh=8lDpvZLaR4z8lIctcEKx9lDd0Hg9OXd26QzQJA3m9FE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwidKIrjsQnNf5wjVM6sunzl7n72O4lVb7R+zKoTefpEwUJdlZb5hzXuqShJRQRyLe5EkNwpm7FK7L4Zt3gWcTyvEdVr/yaDhuqqVQQxc2MI1h5ZgT0woUCExV9EuLKEWWcB0OTTUaYQZ/Kf1ZoF8mG2ZRKqNVFzGUvic20Q8Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2xDa2ZDe; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5eeaae0289bso851264137.2
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 11:39:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768505989; cv=none;
        d=google.com; s=arc-20240605;
        b=Ib9w76gKuQ99TihkdeYgwiqPmymjwPj7IC292GpmyBHLGItlO3+02HqdzQE2pEOaS4
         //MKte8zb4jMYl7hI+Frn4DoRyr1165o9jHYfVk7rpVfeelN8Ly63RL31kDLyEdyC3ik
         K+pYjvMjoTRIqilHXn9qWVwDkK4+Ho8k5Z3zZbtm5bfYhIX7e05c1shvj6JdKNc3wwNa
         KyQwSQsRvyRR+tQVBXpTf/iv6gsElrD4v1mwq0T7uO8z66ClSAGDKQQxDInDKFUdhDqc
         WpS8Ji2mg8CL5hjqsRtsTaxFmBIDu19ZuhxheAQgEN3qb6TdvtYBycvoHxZZrF45RLeX
         llSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=8OTackPsw2h0c8jYnXMkXzgJ/rIyJhkclZPRusTP9Ac=;
        fh=+F9KzYnJHmtqoLRrm8BpAj3aAcxg2/qqfOUziBoc0hU=;
        b=RzUB4dzvOmyHOarv8xOZyc7aGFbPs9Au5iR2sbbc2Uo/Axvr0fgvS9KQEF9wmoU1+D
         ZuMnApJ/NkLVZnjAdegYZl9pU0rsL8U7UPA3JQEdFYbY52Nxysh8YH4xb6UgDrpiyTiy
         a6FwdSEKWABZPyMNRa2Ms8kVzyX+PVirgZ1VhVn1s5ae5LAgJyBVxl6f90ZKEqbnNu5d
         KGhbRgHsY4ao5m+Kiy1nr8Z3AtG4v+fMrYDQN90crLYjKjWt5wk99JOoaHyom73X7nu6
         zzO5DdF6Q9OKmYJYrrbXHu1VeeRBy6YsDy6sJ3cW4WnYMuDEiqr1K7BLREFxg5Z60t9l
         YC6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768505989; x=1769110789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8OTackPsw2h0c8jYnXMkXzgJ/rIyJhkclZPRusTP9Ac=;
        b=2xDa2ZDe6fWga3o9iQ/y68a2kotTMM+5GC5yibxJ1c8aadzFiQ3GNqo1zV6Sx9LEpr
         40WIBz8oKTx87gYkb47xR/rQhXQ0xVaRDugYxlBT2qdaU93joS46RiL1QMoIUrebP5+p
         zknWxMhKAlJ65pvxXJyhV+Y+RjxLsxDcOARl0NpNgG35pJa+VRpWAicnxFyk7cIpEvBm
         YKsParmFsYYWH3HI5gtB/V0vikHKCV/F10+uyO5qeDRcZMddXvxtKwl+/HvLV4CeY9db
         nNuRSUL6TuHpKcYngiOWmRKOu80+ttYncZZwb7oycm+yh9wH8lwNFhihElXn23+CHKFG
         0BOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505989; x=1769110789;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OTackPsw2h0c8jYnXMkXzgJ/rIyJhkclZPRusTP9Ac=;
        b=R25/29EwVoHj20XGLxdjvwmReQSJu1Omk2n8my/mYG684JQU23QLQMyBi7yjXhuU+v
         fp6VfBw8xKlldT1qee3tMYS32mKdJsf4E/uxzBo0BjMldaHNe0j0GwYfVfu1p1uzVtR/
         XF7ZeW0q/gyj4VnMchdZNkzaLPaxtNQcLRWI0uxYr4e1LRBt0QAA89fr6537yicxealD
         aUJWeIrLX4bnyVEa59qSwUj7liRpnBviJr0fFSdX3zvI0HRjs7N5i/CMrDlA0Z9ZQigy
         K609uWsypcP3HzBrqh1eFf9fSqvERe6H9DW+3VUJKtNgP8XbhKlTMXxHGA4gqr4r0tGt
         evdg==
X-Forwarded-Encrypted: i=1; AJvYcCWjZiAJnkngLDdstRlWVK6ccuqtAH1OtmTZIF47p2ZdUd+VUwu/eyneI7RW1tdC7I0q/Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9y9RdXnUSL8gSBdQXsqTBKne1J2bJt8bJJKcv5g8y7Bs3GX8i
	Rkj0/+t2ZlL+W3d7xjnftSoys2kycg2bcE0APID4M8lE0G42R33mg/WDOBQXLN5/+/+L4iI3G44
	jBSeFlZb9vcO2njxnKCfyGsDDr7xXoDIkCkQHvc8o
X-Gm-Gg: AY/fxX7PIdD7ZM7kNlrLxpwq2QBLKVaT3ss5bEoZT1KaM+cW7qnPJS5qYYZHRXGgQpe
	A6xUPoP9FiX3mD4jy8+fcSQCLwLCDp+DPptPTSojN/b5sr1oL1gu1+dGkeuKEoQQwBRTv71zTkU
	Oe4zUtWUy+h6OdfYp/ewhd/Od5JMRv39gx+3gpPSLGs+la/Dwgmnzolqn+d3fHyohdbu0GdFrst
	MBqBcwkPdMmxxAp4R4mg7sg1/nvGS2hyMLFCl3KKqSXg+k7wBQoKeLB0Kt4RNNiT0+bQytfyPXd
	S4gVbtR9KlNZJXf8YcioBEEKaU4bGeh4fZn7
X-Received: by 2002:a05:6102:3708:b0:5ef:ab71:cbcd with SMTP id
 ada2fe7eead31-5f1a4d8ce85mr377168137.7.1768505988665; Thu, 15 Jan 2026
 11:39:48 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 11:39:47 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 11:39:47 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260114134510.1835-10-kalyazin@amazon.com>
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-10-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Jan 2026 11:39:47 -0800
X-Gm-Features: AZwV_Qiu_D8foB8Z5ZjGyCrmwdkqsKcMaz5fdNTkl-JawXW8yxxzsPZp7V4tbiI
Message-ID: <CAEvNRgGz2gRu2i+OSxasuyZudqsRGXijbDES8uXVe_hH6QCK4g@mail.gmail.com>
Subject: Re: [PATCH v9 09/13] KVM: selftests: set KVM_MEM_GUEST_MEMFD in
 vm_mem_add() if guest_memfd != -1
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

> From: Patrick Roy <patrick.roy@linux.dev>
>
> Have vm_mem_add() always set KVM_MEM_GUEST_MEMFD in the memslot flags if
> a guest_memfd is passed in as an argument. This eliminates the
> possibility where a guest_memfd instance is passed to vm_mem_add(), but
> it ends up being ignored because the flags argument does not specify
> KVM_MEM_GUEST_MEMFD at the same time.
>
> This makes it easy to support more scenarios in which no vm_mem_add() is
> not passed a guest_memfd instance, but is expected to allocate one.
> Currently, this only happens if guest_memfd == -1 but flags &
> KVM_MEM_GUEST_MEMFD != 0, but later vm_mem_add() will gain support for
> loading the test code itself into guest_memfd (via
> GUEST_MEMFD_FLAG_MMAP) if requested via a special
> vm_mem_backing_src_type, at which point having to make sure the src_type
> and flags are in-sync becomes cumbersome.
>
> Signed-off-by: Patrick Roy <patrick.roy@linux.dev>
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 24 +++++++++++++---------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 8279b6ced8d2..56ddbca91850 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1057,21 +1057,25 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>
>  	region->backing_src_type = src_type;
>
> -	if (flags & KVM_MEM_GUEST_MEMFD) {
> -		if (guest_memfd < 0) {
> +	if (guest_memfd < 0) {
> +		if (flags & KVM_MEM_GUEST_MEMFD) {
>  			uint32_t guest_memfd_flags = 0;
>  			TEST_ASSERT(!guest_memfd_offset,
>  				    "Offset must be zero when creating new guest_memfd");
>  			guest_memfd = vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);
> -		} else {
> -			/*
> -			 * Install a unique fd for each memslot so that the fd
> -			 * can be closed when the region is deleted without
> -			 * needing to track if the fd is owned by the framework
> -			 * or by the caller.
> -			 */
> -			guest_memfd = kvm_dup(guest_memfd);
>  		}
> +	} else {
> +		/*
> +		 * Install a unique fd for each memslot so that the fd
> +		 * can be closed when the region is deleted without
> +		 * needing to track if the fd is owned by the framework
> +		 * or by the caller.
> +		 */
> +		guest_memfd = kvm_dup(guest_memfd);
> +	}
> +
> +	if (guest_memfd > 0) {

Might 0 turn out to be a valid return from dup() for a guest_memfd?

> +		flags |= KVM_MEM_GUEST_MEMFD;
>
>  		region->region.guest_memfd = guest_memfd;
>  		region->region.guest_memfd_offset = guest_memfd_offset;

Refactoring vm_mem_add() (/* FIXME: This thing needs to be ripped apart
and rewritten. */) should probably be a separate patch series, but I'd
like to take this opportunity to ask: Sean, what do you have in mind for
the rewritten version?

Would it be something like struct vm_shape, where there are default
mem_shapes, and the shapes get validated and then passed to
vm_mem_add()?

> --
> 2.50.1

