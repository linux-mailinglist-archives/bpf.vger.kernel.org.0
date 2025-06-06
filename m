Return-Path: <bpf+bounces-59875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6420FAD0678
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 18:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28CF0188EA1C
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 16:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED72A289828;
	Fri,  6 Jun 2025 16:14:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8271A38F9;
	Fri,  6 Jun 2025 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749226451; cv=none; b=ZRXzA5S4Q7pzWrvdxe9jdgSs7X+2lwH+w+b0Lfgi/bZRf5fTZEynL7YbqmFeI9HzUK0u2n+amFEcbrAuD5CX147UxBV297Pt/BZGHZrMhbDFkesJWLPKZ84D5kIcipbyCinpAMgKRpDpK3sKfF0XLb9zmatStt4deVHCroVlsQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749226451; c=relaxed/simple;
	bh=4NCQ1duxdKBQozPwIGVzN4NmGuxP4WE8hhC8wCpppwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAPLqDBtH9JQkSDURjBr3ziCiJyr0wJGTHPTUiFWkKoNhOKwz8rITvBKKuzIOdDwg3RsC5Qq3LRvHLKRofiGg8JWg1I45/wdzBr/Q6TKBv6yWJq0A7RbMA4XDFoxPnDaXV+EHuWJs62OWqMOa2/jxzthxxi7k/BDyAVEej3vQKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7926C153B;
	Fri,  6 Jun 2025 09:13:50 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAAAC3F673;
	Fri,  6 Jun 2025 09:14:07 -0700 (PDT)
Date: Fri, 6 Jun 2025 17:14:06 +0100
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Lorenz Bauer <lmb@isovalent.com>, Andrii Nakryiko <andrii@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: BTF loading failing on perf
Message-ID: <20250606161406.GH8020@e132581.arm.com>
References: <aEMLU2li1x2bAO4w@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEMLU2li1x2bAO4w@x1>

Hi Arnaldo,

On Fri, Jun 06, 2025 at 12:37:55PM -0300, Arnaldo Carvalho de Melo wrote:
> root@number:~# perf trace -e openat --max-events=1
> libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -ENODEV
> libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -ENODEV
>      0.000 ( 0.016 ms): ptyxis-agent/4375 openat(dfd: CWD, filename: "/proc/6593/cmdline", flags: RDONLY|CLOEXEC) = 13
> root@number:~#
> 
> openat(AT_FDCWD, "/sys/kernel/btf/vmlinux", O_RDONLY) = 258
> mmap(NULL, 6519699, PROT_READ, MAP_PRIVATE, 258, 0) = -1 ENODEV (No such device)
> libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -ENODEV

Have you included the commit below in the kernel side?

commit a539e2a6d51d1c12d89eec149ccc72ec561639bc
Author: Lorenz Bauer <lmb@isovalent.com>
Date:   Tue May 20 14:01:17 2025 +0100

    btf: Allow mmap of vmlinux btf
    
    User space needs access to kernel BTF for many modern features of BPF.
    Right now each process needs to read the BTF blob either in pieces or
    as a whole. Allow mmaping the sysfs file so that processes can directly
    access the memory allocated for it in the kernel.
    
    remap_pfn_range is used instead of vm_insert_page due to aarch64
    compatibility issues.
    
    Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
    Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
    Tested-by: Alan Maguire <alan.maguire@oracle.com>
    Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
    Link: https://lore.kernel.org/bpf/20250520-vmlinux-mmap-v5-1-e8c941acc414@isovalent.com

Thanks,
Leo

