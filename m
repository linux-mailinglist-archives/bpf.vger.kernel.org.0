Return-Path: <bpf+bounces-76967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CA6CCB2E4
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 10:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09A2230954B5
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 09:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85217330673;
	Thu, 18 Dec 2025 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eocJAw5m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B34330649
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766050244; cv=none; b=N1bU1liFTJ8bJF014/94TFCQp+ysF38pchG87YryUYO009SFJBM1kv+Te4HmUdM0id2zXH5b9UeOA8Z6OPzCVKKA9xs0TOyRGJCeoRhuVe5ZsBoGJIQJ+k5kQ7H9d5y9UqQHCzYBIy2KDGb9CM96kzUojyly+ZuG/MGo5I8WI+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766050244; c=relaxed/simple;
	bh=8Lk1cogg5352nQHgKI1WW/DDJU3qCFewyZmYxMrF1i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtXgmhv/0+oee3/ASuy39W7t0e+hMtOx4QIvUnJRwaI7a9NDm9jLMwIjhARt5nhkW4UcEAjkMgGArwSs2qatrZg59qIsMvYLK8XBvOI6E0SdGo9C2uxaZQVM59SYd9fidEGJOFn2ur72qdIhMgXpFWSPcKsZimWjJmedFyu/bRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eocJAw5m; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43246af170aso215827f8f.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 01:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766050240; x=1766655040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=auj72bQKfXEBr2u68dWzZijoBsCuhcqMu/4EXNR4iyc=;
        b=eocJAw5mX+92e008RBwZIaEwf05myQads/Jhl8qXKEexxlkGJ4GjcCREbnce2A1NKB
         +OWmfgpKVZH6L88XjOjEuUsqoVbIpaOLBigbbysLwhgmgR7rRXTgrsQpOTy1hwj1TgmD
         bldjA3dQMYpmP1A7tiFaMaH+pqNV0uiqJxB6moF/nNApt1e5RIvANfM/0DbwZClcyz5q
         Cpxx2G94ZKa6hGi8+r1ji5A5/k6K85Ryjed8sCwjsZuOHB2gdjjoCeFOpPAg2e6OfQni
         y1pPO0QgyE+sdElIrmfefwFyLNDpwSpspQIl48/rMeDEsf13yYII4Cug502AEMGNabW6
         VUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766050240; x=1766655040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auj72bQKfXEBr2u68dWzZijoBsCuhcqMu/4EXNR4iyc=;
        b=HO+5jM1H5fk0E3w0FmLBDdHNMlmIWkWo2Ce9w/zDiBNVsSGajg/xEbBTW4Az9xriXV
         3vIbKk56QWEpZSraaPaQEyb0IRTiVkFBWBmKugmN443biYlhmhIWjsZ+lLx03gCa1c06
         1MU5ZCmY+EFXFeofXbKI5FMZee45XNwClI8V/S/TTCRkgh4nB9LEhwVYDxFHLWVXUVbC
         M1z2q86PPIHrO3MYVj+xlHrrKtUYgqXjC7XmYoCYEpci8k3+G0rKf6ZmTQNS/5mgkkLs
         xsurG7A45HRPlmwC3ndfhb9R/3/oJfUfzqm97334G2eJj4lMCeA4j9jXbi69ZLEQtmCW
         vIPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0uZBPHeJ3niCDbZJQK0oWjpFK3zELs+rYmufHDgUnrSxFiD/BpP/TXtxcLI9xe/wx7/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLT7PXnrLl7ZrSNv9CSs/I1uQ3oqhnsEzKUZG7Lkq0vrpweMwz
	bY62Nc7zCR883UWafVEf8O6TBLtAGelnMwnvYVZDwFt12PCFsBMu5epspqwoUVPS/bA=
X-Gm-Gg: AY/fxX6qmGwEYT0YgdPpsjVYbMWVayPocp+l6CENDbYpIFijPjE5BcpWWwKXzs8TQgT
	he0mbWQ312tup+KgklxtWzuvmACn+WGjojQ4fkZVABSBAmSqZepzlF0u+CH6o8PvNLRVZjsXDBp
	lgiAYUq5ozjSpVRGVQqdlfUORD/47bf4TQ6jmOBmFPxsUEzRKKaN0daj2e47Ff+wNLHa92aHcok
	iwB3Wmb0CvW+lKQkkSGgoHu2epWVwcaUbf0gu8usfC4B9rMW7Ui2H/dlM3jhMvxgdYolbm7KroQ
	+qWfPAlLLDWjSs9qXjFkYYpb9CeVutcUaD+cxB+okFLJnWpz5H2qcMKg8Y13caE5xKwtx5nDPaS
	muUMufGAnbau5zgvlVmmS+5PP7KmnsfSamjZZ/ZpWVHnBO1/S9xt/8wObtCnYNVTDbsGtjA//PV
	1xnqzDLNwqZQfDKs42+P23qr0c
X-Google-Smtp-Source: AGHT+IHyh7gnIimLVB/hVii5bUcInWlX+sJTJLBC1+RURn9zto3ffEvz7ijXdEVgop3qQY9DVJKifQ==
X-Received: by 2002:a05:6000:2407:b0:430:a803:e49f with SMTP id ffacd0b85a97d-432448b7f43mr2778068f8f.15.1766050235424;
        Thu, 18 Dec 2025 01:30:35 -0800 (PST)
Received: from localhost (109-81-80-251.rct.o2.cz. [109.81.80.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324493fe32sm4092572f8f.14.2025.12.18.01.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 01:30:34 -0800 (PST)
Date: Thu, 18 Dec 2025 10:30:33 +0100
From: Michal Hocko <mhocko@suse.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
	rostedt@goodmis.org, catalin.marinas@arm.com, will@kernel.org,
	ryan.roberts@arm.com, kevin.brodsky@arm.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: mmu: use pagetable_alloc_nolock() while
 stop_machine()
Message-ID: <aUPJuZINNuNxddRX@tiehlicka>
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
 <20251212161832.2067134-3-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212161832.2067134-3-yeoreum.yun@arm.com>

On Fri 12-12-25 16:18:32, Yeoreum Yun wrote:
> linear_map_split_to_ptes() and __kpti_install_ng_mappings()
> are called as callback of stop_machine().
> That means these functions context are preemption disabled.
> 
> Unfortunately, under PREEMPT_RT, the pagetable_alloc() or
> __get_free_pages() couldn't be called in this context
> since spin lock that becomes sleepable on RT,
> potentially causing a sleep during page allocation.
> 
> To address this, pagetable_alloc_nolock().

As you cannot tolerate allocation failure and this is pretty much
permanent allocation (AFAIU) why don't you use a static allocation?

-- 
Michal Hocko
SUSE Labs

