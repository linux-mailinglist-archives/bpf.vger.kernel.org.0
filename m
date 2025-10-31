Return-Path: <bpf+bounces-73179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80681C2669E
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 18:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1FCE4FC8A8
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 17:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE38C2F12D1;
	Fri, 31 Oct 2025 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xlTcVDMM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE44B2652A4
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931818; cv=none; b=OD7D9JogW20xtiKw6EcZ+EPjcCIDHVJS7006wTCHxKNQFGRe5+WPn/O8dtAwO7IJCPt6maouTSP/XAdmJJ1EJYr2eIEAUHRBKx/Gu3MH9mYe4jncFwL6rBdDh9RpEoW7gjc8UvWoM1WIU+lQmq7Zwb2I/pxRYfmzNJrQ5wOWVQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931818; c=relaxed/simple;
	bh=ELK/TPtUoa0DdzfjuQJxQqd/fmBurZBKRSXbJIZQLus=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fi9PXAnQJff4BCUj9uDCymhHr7jQjyc74Mign/qkm8peJg/B/kxfEZwFT07q8rkq16texE0G1hyQJW+H8WHZqdKtrGyaQUDSlbxHFt5TTeqheO+3BaLIGqOj19bui7nO9Y3VvoqsiCbXXPMmu5HS1ms1DiQkhiQjLbyAJ/A8E/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xlTcVDMM; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-475dd9906e1so15016835e9.0
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 10:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761931813; x=1762536613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8smNPhdFrk3F9UsFWfFOTzaD0PFIjf/jPl9FFvNvth4=;
        b=xlTcVDMM2YXWR1LtabsCI+fB7WxqP/BNGHnliygKqFjwb59VituBUODZN1s/r/j7LZ
         du8UJEaeZWkJblBUuqdirmTdbacpiHAx4twPldzTYbNbBoYDCQ9FfMNVRWkDAyjcEp9G
         VnuOdx2g5GNGlXD4wmOalAtM+oMDs0akUUdQz3DW6CTXd9MfvTLab+OkNJZSj51jdWq5
         E2JTNX9xt1uVWpzcWaELLrnfwEbKx0glh+eyIDMLENshEB64nz6eacBkPzv78Cn42AmY
         Cwkt7NbGfh2GaG11aiPezj6Y7a9Bg2AFHaCfoUl1eglXUaM/oKEURdSt47gJ/32LFIN5
         gGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761931813; x=1762536613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8smNPhdFrk3F9UsFWfFOTzaD0PFIjf/jPl9FFvNvth4=;
        b=B1SyrCwrpPJXWa101NK7OV/tcwtEfHkd/VHwb4OsnsIfo+d8xbVQgVfha4u1rPRE7o
         m1cgrD0Bm05c3WwEpRG6OLJMglyUxQTjjFZMOaqPNSCZHZNAEwgLrJE58kNISbl0Stvw
         YYFTqQpjxDyQlLK0VoQ+zYGCKCPaTW1mN4aR5YvJBAUWPG3W4Q96WDY2NwpLjzzXkOj6
         1zO0KIrtVl13gxXsKW+No5HlrRRR5UT7h166p5L8ZPDwgBy7K04v2dXS8OuZwUrBLuKP
         FZW2KYfJ1JM9ZMx86UnWArrGqN55fmaUpvF6Kgf7SyR4RGKpwcmF3P047Uv5Ine6kZ49
         EWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFHUOuCiqKOc5Zaiuut7lBiKu8A6QPuONS7+Hs7SfiW4J4CQgeXs/nspCCOSnaLrZf5mo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaabs766W/n5brpY4HiJ4dTGdyHEEFkF3yuwIvWSbt969BIwp7
	+XUQYylM0m/jymdPzGKHXVxTA7QKi7U8h9TVgGTmZ3yd4SeMLI6k+N4U28WVmnMn3cbHaFK5gci
	wjjiGm92SbD4qfw==
X-Google-Smtp-Source: AGHT+IGAlLQK0HkJ6COX6kdvZKn0Ro2fXbdMSgyDJ0pItor316xsKGfib1jQEkdwcGXkq1m1difB1/UltgkgBQ==
X-Received: from wmwp25.prod.google.com ([2002:a05:600d:8319:b0:477:c8e:1959])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:8310:b0:477:326c:b33f with SMTP id 5b1f17b1804b1-477326cb6d3mr20439815e9.16.1761931812961;
 Fri, 31 Oct 2025 10:30:12 -0700 (PDT)
Date: Fri, 31 Oct 2025 17:30:12 +0000
In-Reply-To: <20250924152214.7292-2-roypat@amazon.co.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924151101.2225820-4-patrick.roy@campus.lmu.de>
 <20250924152214.7292-1-roypat@amazon.co.uk> <20250924152214.7292-2-roypat@amazon.co.uk>
X-Mailer: aerc 0.21.0
Message-ID: <DDWOP8GKHESP.2EOY2HGM9RXHU@google.com>
Subject: Re: [PATCH v7 05/12] KVM: guest_memfd: Add flag to remove from direct map
From: Brendan Jackman <jackmanb@google.com>
To: "Roy, Patrick" <roypat@amazon.co.uk>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@redhat.com" <david@redhat.com>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"song@kernel.org" <song@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>, 
	"shuah@kernel.org" <shuah@kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Cali, Marco" <xmarcalx@amazon.co.uk>, 
	"Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "Thomson, Jack" <jackabt@amazon.co.uk>, 
	"derekmn@amazon.co.uk" <derekmn@amazon.co.uk>, "tabba@google.com" <tabba@google.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed Sep 24, 2025 at 3:22 PM UTC, Patrick Roy wrote:
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 1d0585616aa3..73a15cade54a 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -731,6 +731,12 @@ static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
>  bool kvm_arch_supports_gmem_mmap(struct kvm *kvm);
>  #endif
>  
> +#ifdef CONFIG_KVM_GUEST_MEMFD
> +#ifndef kvm_arch_gmem_supports_no_direct_map
> +#define kvm_arch_gmem_supports_no_direct_map can_set_direct_map
> +#endif
> +#endif /* CONFIG_KVM_GUEST_MEMFD */

The test robot seems happy so I think I'm probably mistaken here, but
AFAICS can_set_direct_map only exists when ARCH_HAS_SET_DIRECT_MAP,
which powerpc doesn't set.

If this is indeed an issue I think it can be fixed by just defining
can_set_direct_map() to false when !ARCH_HAS_SET_DIRECT_MAP.

