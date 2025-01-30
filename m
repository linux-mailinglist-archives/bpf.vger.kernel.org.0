Return-Path: <bpf+bounces-50089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC80DA22765
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 02:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12AA2188611D
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 01:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9591E49F;
	Thu, 30 Jan 2025 01:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmgfQSfo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027C38BE8
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 01:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738199589; cv=none; b=D8JN43k+DJ9Z7ekJAOem2xplu3oHa1GzZcxA8Kq9opSIFjVPtJCEU1PIu367yh+ytSq8QfMeR0WSop1Y3hVqxY0QYaIiob3SfPWuW8aujoNrH+UL7jB0DVYx6H+A7GISEvaxuTO9nCDbMPqRBo1Y6LQpJ64WvSiOG03tOpf1ZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738199589; c=relaxed/simple;
	bh=o7W1kVNPqUawuc9S/lavBcQCWRfn5vjr3TYEDGz3N7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhTXlA/f0WusUstytgma+fGmUSEDjllNPj61hswqEPpKyfAZlQwJNeZEO5fLLopzG6lYX7mQ0OocOlbfaPLXlhA+JrxbV+aySkcyTqstHvjrEUoWEGi8mRaIU71eQYzlNqO9+PSKqLvtVmZ0zA3qvX15EmRjWYXEVFN2MXo4t54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmgfQSfo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21649a7bcdcso4041445ad.1
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 17:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738199587; x=1738804387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8NxlEl5rdRh6mQZqLk8mNBBQXgao6VHvKQ+WQsMrS3Y=;
        b=DmgfQSfobL32wuHr4EgTljpsoGrTbn7uL5v5pJzSm/cqOYcv2ehT0Ynrsn9ARBTjm1
         AFSPF19PQ80d1SZcISKKQFu/XyCNdVh8W2pfk+tRz83r2SYmRJlTPw/zZRA8qYn+SgKE
         Qhr2OTSD1+Q3ORxu+VTfnuUKm7SVzXVacWqf0JE0xzhSXfVgp+2zlc7RHlxVx5unWv9O
         vzPmiHtdeRafrZ8wejUdsMyzCELAZyEAGHjJSE2Xv0k2K110QJ88o+5Z3AElx3l2TxTI
         M1bGXSvOi9cs/xbAGN07nuFCGlnBXH408bo7Kli5azUVIQ8Z/d2dSlCLU/LV9ZCCcdYu
         Crqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738199587; x=1738804387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NxlEl5rdRh6mQZqLk8mNBBQXgao6VHvKQ+WQsMrS3Y=;
        b=DPyCTwgyejOCpClz9k1NUUP+VKwohZPG7qIErX9sPpwoWejGr0DJNy2dImtHZx4+66
         wxi2fpTznBuubif12uNUz/akDnR9okC9vOnwnCGIf9g0pG7Ld57i254kTyYQrRpKyua4
         22AODIeZu1SmDL+o3s0fgmenvSJfXBcoVzgRgDxlHwAWd7r0wbHvmOHG568DIRGSE+Bn
         LjZo9EjKVPtfuWmUKxT/PXEy3yDbF2SkFB1TPF0z0PtxPghyFKHaPNKuFY+4L3EOkO5B
         WLE/26sXhMhA9cHecJH8+o/O7bkeS9dYYPJD0J+l2ippsbnfY0OEz2qeWhh4jmd8RxTa
         nrSQ==
X-Gm-Message-State: AOJu0Yz7rkox1BsO99bLhJuLIbT+eudpw4sKWnJEm2egljlKXqegrwl/
	NDn5l7ukqY0aXP5DUYD4ZSWo/pPqHXdraShm/Ae8fp8Yw1a7/EVo
X-Gm-Gg: ASbGncsX6OzICbVC8zZho+UnAk9Ma5iU6bD/7YPa+5+kU7MfwBHyu3leczgUVMZP3/O
	PDk/qZM4zBsRY+vpnJq3H0tpnFiAr0DVik8DXXDbeKzLHb/Vovu59X3+O/aFyY3fwsFDxI+uZYb
	VJLE4uE0pKp64496DSXudjvoSOPT6Dq/ZDsW0kF5bY3XSoNt24SUsH6UKU4wdNzOGyHQRkyHcar
	bhnSxAG4VBmaHKo6E0BGkXK22HMs7ri9FztM3Tjfy3Rr6RmglCIIR54Ap3h37vJ3caIO+Aczd44
	Tcv5rdT6v9byWSR6zFoKVQ==
X-Google-Smtp-Source: AGHT+IHwiDA+LFXnd3bNWp3Ykm9wD9SZn7E7z9KWnHbRCu6QBgGDLmHsHNAYlBgDdZC8BcrFcuW2GA==
X-Received: by 2002:a17:903:1c7:b0:215:8dd3:536a with SMTP id d9443c01a7336-21dd7c4973cmr84157655ad.4.1738199587125;
        Wed, 29 Jan 2025 17:13:07 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:4529:d22b:21ed:27d4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31f77acsm2394295ad.98.2025.01.29.17.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 17:13:06 -0800 (PST)
Date: Wed, 29 Jan 2025 17:13:05 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org, nkapron@google.com, teknoraver@meta.com,
	roberto.sassu@huawei.com, gregkh@linuxfoundation.org,
	paul@paul-moore.com, code@tyhicks.com, flaniel@linux.microsoft.com
Subject: Re: [POC][RFC][PATCH] bpf: in-kernel bpf relocations on raw elf files
Message-ID: <Z5rSIaXf4Fm5jeRf@pop-os.localdomain>
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>

Hello Blaise,

On Thu, Jan 09, 2025 at 01:43:42PM -0800, Blaise Boscaccy wrote:
> 
> This is a proof-of-concept, based off of bpf-next-6.13. The
> implementation will need additional work. The goal of this prototype was
> to be able load raw elf object files directly into the kernel and have
> the kernel perform all the necessary instruction rewriting and
> relocation calculations. Having a file descriptor tied to a bpf program
> allowed us to have tighter integration with the existing LSM
> infrastructure. Additionally, it opens the door for signature and provenance
> checking, along with loading programs without a functioning userspace.
> 
> The main goal of this RFC is to get some feedback on the overall
> approach and feasibility of this design.
> 
> A new subcommand BPF_LOAD_FD is introduced. This subcommand takes a file
> descriptor to an elf object file, along with an array of map fds, and a
> sysfs entry to associate programs and metadata with. The kernel then
> performs all the relocation calculations and instruction rewriting
> inside the kernel. Later BPF_PROG_LOAD can reference this sysfs entry
> and load/attach previously loaded programs by name. Userspace is
> responsible for generating and populating maps.
> 
> CO-RE relocation support already existed in the kernel. Support for
> everything else, maps, externs, etc., was added. In the same vein as
> 29db4bea1d10 ("bpf: Prepare relo_core.c for kernel duty.")
> this prototype directly uses code from libbpf.
> 
> One of the challenges encountered was having different elf and btf
> abstractions utilized in the kernel vs libpf. Missing btf functionality
> was ported over to the kernel while trying to minimize the number of
> changes required to the libpf code. As a result, there is some code
> duplication and obvious refactoring opportunities. Additionally, being
> able to directly share code between userspace and kernelspace in a
> similar fashion to relo_core.c would be a TODO.

I recently became aware of this patchset through Alexei's reference
in another thread, and I apologize for my delayed involvement.

Upon reviewing your proposed changes, I have concerns about the scope
of the kernel modifications. This implementation appears to introduce
substantial code changes to the kernel (estimated at approximately
1,000+ lines, though a git diff stat wasn't provided).

If the primary objective is eBPF program signing, I would like to
propose an alternative approach: a two-phase signing mechanism that
eliminates the need for kernel modifications. My solution leverages
the existing eBPF infrastructure, particularly the BPF LSM framework.
So the fundamental architectural difference between these two approaches
is pretty much kernel-based versus userspace implementation, which has
been extensively discussed and debated within the kernel community.

I have also developed a proof-of-concept implementation, which is
available for review at: https://github.com/congwang/ebpf-2-phase-signing

I welcome your thoughts and feedback on this alternative approach.

Thanks!

