Return-Path: <bpf+bounces-43910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFFE9BBC65
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 18:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882211F23186
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 17:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3703D1C8767;
	Mon,  4 Nov 2024 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXbuN63k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161CB1C7269
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742686; cv=none; b=Vl8QLovgxROR1TU52b2EO+Lg1nqCUTribyprYeIC8yysxqaluwA068Rkjxr/nEAO0M3IGzrLxD1kmbjI6u9DeBzgihlU5BsPXfVHB4atCFOmxWA+sPN33lZl6z1bFQoAIRj3t/eMATeBG6rpWrrTRJczmrzLk7Omd6vgJRrHPaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742686; c=relaxed/simple;
	bh=RzWpfkskYuifVGMv39O6yOfIoLpuig2hZK9XKBuofEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEWJShEzTJllIvSRmKrp0OmdBm5SfvdKVDPCzN2qYQtO57waOtWrzwIu/IpvRRwt/WMsmxzB+twEIhckLCVPvnY0pcEzFU6iwDNYMJ0NJ0qTtvkgVKm5u10FtcdthvTQFmJ6bG9a5HhXcTHVkv6yxTyYka27kr8/TgYRHwtw97c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXbuN63k; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5cec93719ccso2876581a12.2
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 09:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730742683; x=1731347483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/iX6EUeWmPcsoai6gBnRhbwnXD3n3XJwT45NHxedeMg=;
        b=mXbuN63kf6EyhM2UjA71x/pkasmmRUNCIdtMcyHtoTD0Ym+HrmJWwYo1E8pOXDTk7y
         OXzWu6uHBZxS4lV+/GaRw0SdjFOU8u2srAyVDRdIRtIXw16c/GVcjl0LqDluT/gq2FL0
         PHPKFaXuWohseQJ5r6ZWn8w5+vDF8tXvJL1ryemaM2IKtB3jc5tntzbVHUttb1boqj7o
         OcWwILU4lImaZEdaPdS10wQnRzKslmXjsRx5GS3mki1tWwirkB39sHBcYV24olM8x+Ff
         Hoc9cK5SkV0ei7UPCOsH0VEPQzo9WV75tRtslphdaywbZYCQTuDmF1xMIwVeqLyRK/Il
         oDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730742683; x=1731347483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iX6EUeWmPcsoai6gBnRhbwnXD3n3XJwT45NHxedeMg=;
        b=tQaNqy3amhu/VfCHcecd5Ea4L7KgApX7AfYAizrgRVSrxS3/Rp7S2JytQ6JkT7T7NA
         Ac62BRllgaMpyesyn3MjVtUkmlDxtV6HEwmjs6uewRE53LUlMPBlPFDFvZ8w93bETyr1
         mBd4XHrPSQjB9dPf/51A5Sgw9BBe4q9zNgc5Trk47IS6U3exKw9w5LO3z6oqpOvhBphG
         EHeVbLB9jiSNJnlb4PczdtyanyJczGlsInt7wBlkOYKxzpbyq0e/LNTFRu2i3zwuW6Ng
         DgvsZUy5bWJRAfmLUCmWejOmEwR9qtEOWZMTD5LIZtb7BafLpzlrazDHhMGdnCFGmxII
         yjjA==
X-Gm-Message-State: AOJu0YwPDGO85ndbbcQjviwQYLeFIUp3TIVbWGsRzA6MSuQqUCXdm9uQ
	xKYKOrTjSBNuQEbDRkAh8UyNQg/qYrFHVK9HQC4mP5njdMgLMHRgeYaTimkWOkFIyA9Ty1Dn/sN
	Lh7uUAmGv3XtP2qVv4GF8XlOIqVc=
X-Google-Smtp-Source: AGHT+IF3R01A6c/t/++RQPHXeVRRJsV6e6IJyHGET7q39iY6Il/zv2P0Nooc2i4pKwFSgybAe/zKfPmPPbCIH+gY21o=
X-Received: by 2002:a50:c8c9:0:b0:5cb:ee14:d0a8 with SMTP id
 4fb4d7f45d1cf-5cd54b27020mr13375350a12.35.1730742683253; Mon, 04 Nov 2024
 09:51:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241103193512.4076710-1-memxor@gmail.com> <20241103193512.4076710-2-memxor@gmail.com>
 <92dfb8cc-f6eb-4753-950b-944cc26e379f@intel.com>
In-Reply-To: <92dfb8cc-f6eb-4753-950b-944cc26e379f@intel.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 4 Nov 2024 11:50:46 -0600
Message-ID: <CAP01T77v+__RvLOpfyezfwvyZ1EjZ3gGRPkQMn_6uim0HfB31g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] x86: Perform BPF exception fixup in do_user_addr_fault
To: Dave Hansen <dave.hansen@intel.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Rishabh Iyer <rishabh.iyer@berkeley.edu>, Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>, x86@kernel.org, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Nov 2024 at 11:16, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 11/3/24 11:35, Kumar Kartikeya Dwivedi wrote:
> > Currently, on x86, when SMAP is enabled, and a page fault occurs in
> > kernel mode for accessing a user address, the kernel will rightly panic
> > as no valid kernel code can cause such a page fault (unless buggy).
> > There is no valid correct kernel code that can generate such a fault,
> > therefore this behavior would be correct.
> >
> > BPF programs that currently encounter user addresses when doing
> > PROBE_MEM loads (load instructions which are allowed to read any kernel
> > address, only available for root users) avoid a page fault by performing
> > bounds checking on the address.  This requires the JIT to emit a jump
> > over each PROBE_MEM load instruction to avoid hitting page faults.
>
> To be honest, I think the overhead (and complexity) is in the right spot
> today: the BPF program.  I don't want to complicate the x86 page fault
> handler for a debugging feature that already has a functional solution
> today.

This is not a debugging feature in BPF programs. Almost all tracing
BPF programs that potentially execute inside the kernel contain loads
which have to be marked PROBE_MEM because potentially, they may read a
user pointer and dereference it. The BPF runtime relies on PROBE_MEM
whenever reading from  pointers (for programs having root) that cannot
be trusted to be safe statically. While reading invalid memory is a
rare case that should not happen, it may be possible if some kernel
field contains a stale address etc. so loads into such pointers are
allowed statically, and handled/trapped at runtime to zero out the
destination register. So far x86 won't invoke fixup_exception for user
faults, as it wasn't supposed to happen, which is correct behavior
(hence the bounds check).

However, this cost is paid to handle a rare case in the common path of
BPF programs.
It would be nice to avoid it, by deferring to
fixup_exception->ex_handler_bpf in case the pc belongs to BPF text.
This was the least intrusive way I could think of doing it.

On arm64, the fault handler would do exception handling in such a
case. So with this patch we can think of removing the bounds checking
across architectures. We can do something similar for RISC-V as well.

I am fine with changing the commit log/title to reflect that it's an
added cost for the fault handler. I felt that it wouldn't matter
because the kernel was about to panic, so we had bailed anyway, but we
_do_ end up spending extra cycles in case this path is hit now.

