Return-Path: <bpf+bounces-65865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A7AB29C39
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 10:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487781890297
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 08:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249872FFDEC;
	Mon, 18 Aug 2025 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fv4L1aqZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A793F20B80D
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505735; cv=none; b=bjs5DilS1wFRB2Uf6pcozKpVd3NlJ90XN/VbAL+VvfxIGPcXdrglr4ouLtzgoFGzSS6GVzFuW2upN++qYcu55dSCXnfdea9knfKbSo3MRhpvelEv+9tb7EP+WexzCIt/aDbyOgaodMWNeWhnqv7IHCgUHGeKtzEcX2Op2nWj9GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505735; c=relaxed/simple;
	bh=Z321gvxdWOyogGWPGJPsqkjjXoGyumKt6BIu4iL6nyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aru7fY/aEn5MaIrrpbr9cQgvkg4OuTvgWN4+Z+B8T6QgOjHD+7MrZkGrGVFUcdrNE6ujgQW3cPe/Po/FOrAAOnqwbyX8H6GTZ5vgCFbbmlNHBxYF726ehhe2bW8xBVlQje3AERAVEuXMoeX6PJczYIbFTl3VfWwDlqOi95AAFbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fv4L1aqZ; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3b9d41cd38dso3107504f8f.0
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 01:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755505732; x=1756110532; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PSZsQJaXvHKUIopn50ru2Gygq7lFn+7G/Bm6Xhib0vg=;
        b=Fv4L1aqZtdR0bnqxlGI2IHXXTEYDCJs9Nob+pz6SVJO8vNzgC/Ud64EvUxmsmNZhnJ
         KukMtAVjVY6VQfgi0Fat5+i/W0GCp0u96cmtGW6oQ/oQsabaNr/X2jeQxIpBvhj/9Fs/
         vLmUzjGY2kz6QILnNEloc0/lQi+lglEYeiTXjm7LwRNSU7bo5Xg0dmyRXv1qb/q1MDD5
         B8Qgze+3dHyLcvs3KuryMzog94YtgdTnSPKJwDEOg8qP06WO5gEB9/pVBuB/ROoxKcuD
         R+W/RvYIXAUv+kFDdaHOc9500Cj674lqVMyBlvEr7I99BCPT6D7ht0WBDnDyXAUZK3cz
         S7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755505732; x=1756110532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSZsQJaXvHKUIopn50ru2Gygq7lFn+7G/Bm6Xhib0vg=;
        b=wXBr6c0Ho7Op788F1mB/fvzF7FxiZe1vwDzbnDIw9D1mH3/znh1ljPxacgOkdVNkmq
         +hn9aU9s9GpTP3TyQtHxz6OAdcU+wy3kNFZIuCrXK+jwdKURwu3ZHEuxVvUm/g761Fbq
         oYt+yVsWcBmj+crfRcXJxnxTCakwVweFkqYw+Mw2aKqYQdWtq2esUYhQ0ONlbM0u/taX
         fTAFYMxgO0suyHJzFpqQ+faGznkBe9Zkd1aIiPHBdf63EWQ3D+n4u4MXIKf3t+YpKU3S
         atnw/rrkS45tX1FEpPh8mvgp3R4GNw8b3/wNMXJA3GC/6ZwRbd5BGpaaEYUyK7Vna8mL
         Nc2A==
X-Forwarded-Encrypted: i=1; AJvYcCWQ3e6kLieab6OqH3PCJvQ4ZZ0nvSeRHvYLUgvx57ZJrOiABm/ew3Q0bWW8ojabIC9iaxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn3h1zI1cbcwN9rxAtsoxnp5Tt11/RMGnhW9KJ5M4zKcdx7eDl
	m+MK1fByS7GmlPp2pwBMclgrGc7/dI7HFjLfzUcw5EHuPCHDkSDYPpKAXABWlrdwIsU=
X-Gm-Gg: ASbGnctsEbaXUNvgpk/FZWKiRlUZjDZBxsreTYYogf5R5LyeZdaXoc7c+9BMc+C3tV8
	+rmJMjhcdQKZHPTpUxFrEf6V69RTHtfmkgZiKjBw0Dh2Gx9nGpiBAaL0gbEThdwdnHGtLnrpu4N
	/y5MKZKnISHM3JPxrhWxVS4urU5VoPsZODObJGBZ/p1XwqMVnO0d2P6jwufQA6p6NVnkxch+ieV
	PG03Inl/Haku+QAFeQfciRU3trwalPcLzr2asNgmHAUXo8WDXlJptIBwDKbpJaLvuikcfCo2nEo
	ingnT4sUtfTet7RIHGFkCq0MB0my35JH0seGq2QTvwBl0DEDKzM8cnCY7Mpz2UTHXf+XWkyHrsv
	j6Msfds+cm5sNCqBy
X-Google-Smtp-Source: AGHT+IHxrZ7mOXc+YMQV9Y4+9KYPkZWcaECSLTsSiAuX2x7luesKEXbv+RueiR74hUp0wylI6FlhgA==
X-Received: by 2002:a05:6000:4014:b0:3b8:2cb1:5f82 with SMTP id ffacd0b85a97d-3bb690d3335mr8134869f8f.50.1755505731856;
        Mon, 18 Aug 2025 01:28:51 -0700 (PDT)
Received: from u94a ([2401:e180:88b3:6bc9:e717:1624:255:376e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330f8309asm10747387a91.4.2025.08.18.01.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:28:51 -0700 (PDT)
Date: Mon, 18 Aug 2025 16:28:42 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Rolf Eike Beer <eb@emlix.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, KaFai Wan <mannkafai@gmail.com>, bpf@vger.kernel.org
Subject: Re: When did CVE-2025-38280 actually become a problem?
Message-ID: <vavowdnee74rvqwhvwef4hnnvch3eailyzoczhhif557udqbbk@f6jscs2f7yom>
References: <5003841.GXAFRqVoOG@devpool92.emlix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5003841.GXAFRqVoOG@devpool92.emlix.com>

On Mon, Aug 11, 2025 at 10:50:21AM +0200, Rolf Eike Beer wrote:
> Hi all,
> 
> I sent basically the same question to cve@kernel.org but they are out of 
> ideas. They assign the affected version numbers based on the "Fixes" 
> information initially. But I'm unsure if that one is actually correct here, 
> see below.
> 
> The fix is this commit:
> 
> > commit 86bc9c742426a16b52a10ef61f5b721aecca2344
> > Author: KaFai Wan <mannkafai@gmail.com>
> > Date:   Mon May 26 21:33:58 2025 +0800
> >
> >     bpf: Avoid __bpf_prog_ret0_warn when jit fails
> > 
> […]
> > Fixes: fa9dd599b4da ("bpf: get rid of pure_initcall dependency to enable 
> jits")
> 
> And my questions were those:
> 
> =========
> I was staring a while on CVE-2025-38280, especially since the message states:
> 
> > When creating bpf program, 'fp->jit_requested' depends on bpf_jit_enable.
> > This issue is triggered because of CONFIG_BPF_JIT_ALWAYS_ON is not set …
> 
> But the commit that this was attributed to 
> (5124abda3060e2eab506fb14a27acadee3c3e396) added the warning to the code, but 
> the function is only reachable when CONFIG_BPF_JIT_ALWAYS_ON is set. This was 
> the case until 6ebc5030e0c5a698f1dd9a6684cddf6ccaed64a0 moved it out of the 
> define. So is this even an issue before 6.15 after all? Since the fix got 
> backported I think it's more an issue to where the second commit got 
> backported? So in my eyes the 5.10 kernel I'm currently staring at isn't 
> affected at all.
> ==========
> 
> Can anyone comment on this? If there is a conclusion I can relay that to the 
> CVE folks to update the version ranges afterwards.

Agree with the analysis. As far as the kernel warning is concerned, I
don't think it can happen before commit 6ebc5030e0c5.

Best,
Shung-Hsi

> Regards,
> 
> Eike
> -- 
> Rolf Eike Beer
> 
> emlix GmbH
> Headquarters: Berliner Str. 12, 37073 Göttingen, Germany
> Phone +49 (0)551 30664-0, e-mail info@emlix.com
> District Court of Göttingen, Registry Number HR B 3160
> Managing Directors: Heike Jordan, Dr. Uwe Kracke
> VAT ID No. DE 205 198 055
> Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
> Office Bonn: Bachstr. 6, 53115 Bonn, Germany
> http://www.emlix.com
> 
> emlix - your embedded Linux partner

