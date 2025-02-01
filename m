Return-Path: <bpf+bounces-50279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1AAA24BF5
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 23:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A0E3A5BE3
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 22:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C471C9DD7;
	Sat,  1 Feb 2025 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOjVkkUf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CDDBA34
	for <bpf@vger.kernel.org>; Sat,  1 Feb 2025 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738448676; cv=none; b=Lk8yJ11ReLBGiW2GI+rGH8I4fKFrwelFnrQbewE304R1YY6k35UWaDDxYY5aemNWDOhR57eYPjuh9I1ivrgwy7RTZ7ES3IeOa2lT0nfB+i4fRYFxx2WKxiCQ6ubLq0RshvkRa9os+KFDpj0FdORUTcpIFXc7p9HR3Ogr7g58ql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738448676; c=relaxed/simple;
	bh=15k7d6d4AR9GG2gPOXbRap2VUwpchfuj8Ppm2V6GTO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=de9Hx2m5m2/IqeN13LGvK6ShcZBmV0ar3IxeqL0BboMX8DIbzAIsyOc668a4YXOn2HxPIB7YHzQsHHUutg5cK7n487TF7fAUDh2RdnrndxvvU6db7yWKUfrU3zr/fj6EcooA7TMuZSbYVplPA0zKAoCXlcO8oYhY8PO1Tpz7jL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOjVkkUf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21636268e43so70455635ad.2
        for <bpf@vger.kernel.org>; Sat, 01 Feb 2025 14:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738448674; x=1739053474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QOO15Ylj2g1k2feudkgueS4IiivubfzxV5zdEl7cbLE=;
        b=HOjVkkUfe2oSyvhrzt+7sj+AVbCwygNUnjSUlFYrVp+SJ7Ol74kNj3IR2IWFP3Zqz+
         0DuSSsg8DJLKZ6NoQzEOZZBM0X3apjV7XoLNi04orzJyndSBxOcNAAM4ux7iQPh50JG3
         8txXzun2/kbQQGnhB7xDyP8l8QuE2X0oFYNhpsdm02/trxm7vxQZrmRMmrznC8XO4vGV
         Y+FAMSJN+z9WWc+QDN1hI/5Y7dUtrqKKY7Ab5u/YoqTZcSUNdkuXQQMlk5ORBGHBMYKN
         zGMh76BzA7heZhps0BukPlRpNtH5liJsXcglzquGH6JMWiTWXMX1D1uW0+8rkgym8ED4
         QJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738448674; x=1739053474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOO15Ylj2g1k2feudkgueS4IiivubfzxV5zdEl7cbLE=;
        b=Qj+aVJfhophYepmAmH21YXEbPXnXbknc+rOlNAN+L0h89p4mhs+0NWzLY0R5seictP
         HAen7d9rJInked3HnB2bo2lHSYE6raXeHZOCvVB4UVKvq/TxBozX5OkpnpvTr1HuR5Ls
         kRHSyLv2DlHkfVNW5/wkGJJmYjiA/mbHhcUjdf/yESoHUk1Y4Yw4DnnbvUahvzWi9RAg
         af1/4z/nXAfTktj6Wux6L1QO6w2bRBmHPzw/8s4UBsSi3/ZUdo2kQmzMtp8yCEil9IsX
         0L7LFW0qk9+DeNxlMexA6D6XDtpvi/FqFrdEfntK9gsRFJoAz2cjhUC8owu3Fj949GD/
         s+nQ==
X-Gm-Message-State: AOJu0YwqWpavS33TKl32LyROelSGzhha3TdDGXDHdXGQaJiKdJChKfz7
	Z+wCX1NW0gXc1ZgKWabXf2l6eh1ZJzUA4NOiJXVTnTGet20xtkQU
X-Gm-Gg: ASbGncvnkDDCYyPa8PdHaoew9ydYGh8oqRKBZFSLPcpk4iV6R/irH3FS1PI9NogBvkl
	ru29G2e4Qb8NfEp4w6+pCyOwNR67pmBVAEhMkqeEhnfJP2dlAUWDFpwbeufUIX6OkRfnTy5vHq8
	D3tdFKc/fLFpDqbsiyx8Fm/SvaDf6tPtIBOUMS8Cjj6uTwjx3CA31NXwl4At6LRcPxUZ+BoNWq8
	RAGMNyu2ePxvMfIercVzu8e+t73DbvSYrtKgeMzDKkE5yrrqgbkYFrZM3ALgAGgB2Ay0gE02uv2
	xZDbIDcCir1UbKP5DWjdcg==
X-Google-Smtp-Source: AGHT+IFhSjLBHn0erqTkApIJAK81Bavc38DvNVdpUnCmf/j0AyT9xeXFeJUnYAa2GjoGzPCp3FgbOQ==
X-Received: by 2002:a17:903:22ce:b0:216:56c7:98a7 with SMTP id d9443c01a7336-21dd7df5fb7mr273092695ad.53.1738448674149;
        Sat, 01 Feb 2025 14:24:34 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:1202:22bf:5692:27f2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31ee19esm49545325ad.7.2025.02.01.14.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 14:24:33 -0800 (PST)
Date: Sat, 1 Feb 2025 14:24:32 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org, nkapron@google.com, teknoraver@meta.com,
	roberto.sassu@huawei.com, gregkh@linuxfoundation.org,
	paul@paul-moore.com, code@tyhicks.com, flaniel@linux.microsoft.com,
	alexei.starovoitov@gmail.com, daniel@iogearbox.net,
	john.fastabend@gmail.com
Subject: Re: [POC][RFC][PATCH] bpf: in-kernel bpf relocations on raw elf files
Message-ID: <Z56fIPr6iNO4l5uJ@pop-os.localdomain>
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
 <Z5rSIaXf4Fm5jeRf@pop-os.localdomain>
 <874j1gf6of.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874j1gf6of.fsf@microsoft.com>

On Thu, Jan 30, 2025 at 11:22:24AM -0800, Blaise Boscaccy wrote:
> Cong Wang <xiyou.wangcong@gmail.com> writes:
> 
> > Hello Blaise,
> >
> 
> Hi!
> 
> > On Thu, Jan 09, 2025 at 01:43:42PM -0800, Blaise Boscaccy wrote:
> >> 
> >> This is a proof-of-concept, based off of bpf-next-6.13. The
> >> implementation will need additional work. The goal of this prototype was
> >> to be able load raw elf object files directly into the kernel and have
> >> the kernel perform all the necessary instruction rewriting and
> >> relocation calculations. Having a file descriptor tied to a bpf program
> >> allowed us to have tighter integration with the existing LSM
> >> infrastructure. Additionally, it opens the door for signature and provenance
> >> checking, along with loading programs without a functioning userspace.
> >> 
> >> The main goal of this RFC is to get some feedback on the overall
> >> approach and feasibility of this design.
> >> 
> >> A new subcommand BPF_LOAD_FD is introduced. This subcommand takes a file
> >> descriptor to an elf object file, along with an array of map fds, and a
> >> sysfs entry to associate programs and metadata with. The kernel then
> >> performs all the relocation calculations and instruction rewriting
> >> inside the kernel. Later BPF_PROG_LOAD can reference this sysfs entry
> >> and load/attach previously loaded programs by name. Userspace is
> >> responsible for generating and populating maps.
> >> 
> >> CO-RE relocation support already existed in the kernel. Support for
> >> everything else, maps, externs, etc., was added. In the same vein as
> >> 29db4bea1d10 ("bpf: Prepare relo_core.c for kernel duty.")
> >> this prototype directly uses code from libbpf.
> >> 
> >> One of the challenges encountered was having different elf and btf
> >> abstractions utilized in the kernel vs libpf. Missing btf functionality
> >> was ported over to the kernel while trying to minimize the number of
> >> changes required to the libpf code. As a result, there is some code
> >> duplication and obvious refactoring opportunities. Additionally, being
> >> able to directly share code between userspace and kernelspace in a
> >> similar fashion to relo_core.c would be a TODO.
> >
> > I recently became aware of this patchset through Alexei's reference
> > in another thread, and I apologize for my delayed involvement.
> >
> > Upon reviewing your proposed changes, I have concerns about the scope
> > of the kernel modifications. This implementation appears to introduce
> > substantial code changes to the kernel (estimated at approximately
> > 1,000+ lines, though a git diff stat wasn't provided).
> >
> 
> Yes, it ended up way bigger than I anticipated. The ultimate goal of
> that was to be able to conditionally compile parts of libbpf directly
> into the kernel and unify the btf and elf libraries. That refactoring
> work was way out of scope for a PoC. 
> 
> > If the primary objective is eBPF program signing, I would like to
> > propose an alternative approach: a two-phase signing mechanism that
> > eliminates the need for kernel modifications. My solution leverages
> > the existing eBPF infrastructure, particularly the BPF LSM framework.
> > So the fundamental architectural difference between these two approaches
> > is pretty much kernel-based versus userspace implementation, which has
> > been extensively discussed and debated within the kernel community.
> >
> 
> Code signing, secure system design and supply-chain attack mitigations
> are some active research areas that we are exploring. BPF programs have
> some interesting ramifications on those topics. Attacks that were
> previously demonstrated in CVE-2021-3444 are an area of interest as
> well. 

Thanks for sharing all the information.

> 
> > I have also developed a proof-of-concept implementation, which is
> > available for review at: https://github.com/congwang/ebpf-2-phase-signing
> >
> 
> Sweet, I'll take a look. It sounds super interesting! At a quick
> glance, it looks like your approach would probably benefit from John's
> suggestions for early-boot un-unloadable bpf programs. 

Oh, mine is unloadable, I just used another eBPF program to do the actual
signature verification. If we unload it (like other regular eBPF
programs), the whole signing enforcement is gone.

> 
> What are your use cases for signature verification if you don't mind me
> asking?
> 

Sure. To be honest, our use case is actually simpler than 2-phase
signing. What we wanted is merely a centralized way to manage all the
_internal_ eBPF programs within our data center, therefore, signing the
original eBPF binary is probably sufficient because we trust our own
eBPF programs and we just want to use signing as an approval. It should
not be hard to modify my 2-phase signing to just 1-phase (by skipping
the 2nd one).

The reason why I proposed 2-phase signing is that I found that in the
past there were multiple attempts in the community trying to solve this
signing problem, so I looked into it a bit deeper and wanted to see if
I could find a solution to benefit the whole community (and ourselves
too).

Thanks!

