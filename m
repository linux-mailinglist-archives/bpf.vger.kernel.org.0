Return-Path: <bpf+bounces-49652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F61A1B0AB
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 08:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514153AB27F
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 07:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038101DAC8A;
	Fri, 24 Jan 2025 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEMNRxtI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822B33998
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 07:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737702312; cv=none; b=trL1OrGob7fVpD41pW0NZQD+g+wiRCr7SYc6JsLQya8CgcVSYWryYZtIeFVChUGZTl0M5fY3oyqj4GQ4hIltee5fXnB9sHdhI0J/w+pNvR1u1eoKD6QXl86VBqnMyUdmrxUIvmU9t1YyRxMhCmuFvcDrVBpjE2rh57KMsshe/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737702312; c=relaxed/simple;
	bh=8PFXhcti7UuKAKmo89kpMXm8so2HJyeYj0pr26keE7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNPvWHx7Rm9Q2dSU7p4pd19j/3vHJIkSgwKhyuAZnvZG2UTYdSAGN2O+y68Q8dEwVM87HLjP31cyy3Qi5Jrd+cPiYfsWQvLUT9zn2zCPoChFFTRRjtOeHasZB7zWjyV5jINJJIPxKE5f+g6K+UGV2X/70hpVI1lYENUxKhz0UDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEMNRxtI; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so2591926a91.0
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 23:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737702310; x=1738307110; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GegRr7r0lUoq1Mz3zsXgKsiGGR43jheFHIRbHcjM1ME=;
        b=iEMNRxtI63ySYRU4+Rg+thFE7RadKMqeyIRTG/+xjNhD5vwcMfwztEzB61vgVbVhVu
         rYUVRBmgvT5a3dT7b9FF1+dfWcWJxqszS03/XAWbNmb/6eXU0sinr7imRNrO7Jwk4k2a
         NTbN+hXrSThoZNaVIQ2buxZQsWPryU3DgdN5F3LgvXZDZ9iDmJ1b0EFQFOqEKOtyplex
         QdWnbCIlJwYwjLpTLWFBEpX6NYoZ5BY2hC9hExYpAWlcczLxW6SpsnX+ZyeYp04J6+7/
         2PjpNSjuw1WWq+PO3uJfGjn/32wFjsgX1gUfYPYBsIIHLvCd3w16KWXvtOXjKfSzVGAS
         3UcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737702310; x=1738307110;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GegRr7r0lUoq1Mz3zsXgKsiGGR43jheFHIRbHcjM1ME=;
        b=gozIPAWtib6WG8Tg39VBbUQZRWkLL0ep9FrvtiLGQi0f7TZvchwSEHDpVvPBJ2IZOK
         ui4ZhVuylAWRBd3nF4SV4yEUXZY1IrfDVFPHki7+NnQb6HB4XyjXvB7r316dy7KEhxGF
         xklTHXzkeyg0hkGoURqB4Tilx614ipq6cy8oOZNeMygnsyzUwvFzp169RC5X9d3ie0kW
         aIxnSCzwR3pzVXZJsZkhpuSewOq8BbVAw7eb2pkgdrVStLJDLnCOQAnwQRHARqT/Wqqt
         6dcyT1dgfk0CNuC7Nf3qpbWGQV7wu8I22jyb0eUF9pADT+YMxMJMcO8O7JUhdCEF0Xzg
         x2fA==
X-Forwarded-Encrypted: i=1; AJvYcCXWL2y39ksA/Lze12oYhO9NMANmR3V0APkvN9wdLtrbSq1/dQ0G75VIrQOrIQZKrjK6pWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPJIx89TB+6IiBsvziso5XOho9HAP+OEVnDzsju69xfN6z7ibL
	zXVenxCF878W9XBcATMGk5+dHw1A2hepItwWGZWDgt6HYZGjCByH
X-Gm-Gg: ASbGncvo61jhMa7xc9zozM31/SreC+jl4ucTgC/mvP7F0tuStYqscbUw/Fvs9zkIxP1
	FdA30piLmcGvvC7n4HBolk0IjlIyyH6uXb3N5aT5cIwcMuZRqQZGdtPTbVJ1S7/aj7nSt0JxJNg
	T9xPZl8FGdCLFw+vOA0XEPtcEFGQ+S9L0BXUOofs9h1CuxRfY9s7ziq218pqZjtTxjw8v9G66gX
	NQ3Rf03y5G6txBDIJ5GUyOiHH1HJOIiCP8tc7BFvghCMxcnhwPn0VHqZhMxN7ouCiMrhhcm/1fY
	PAlc
X-Google-Smtp-Source: AGHT+IH8KmvaxI4JqYuAr4WuzG4dWeyd1wuNILxo4VIF8YTrvySiHDa8MNgriNueWtOu/oK9grKc9A==
X-Received: by 2002:a17:90b:51c2:b0:2ee:8430:b831 with SMTP id 98e67ed59e1d1-2f782c65787mr43775696a91.2.1737702309979;
        Thu, 23 Jan 2025 23:05:09 -0800 (PST)
Received: from gmail.com ([98.97.40.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa450c9sm898573a91.9.2025.01.23.23.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 23:05:09 -0800 (PST)
Date: Thu, 23 Jan 2025 23:05:03 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	bpf <bpf@vger.kernel.org>, nkapron@google.com, Matteo Croce <teknoraver@meta.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Paul Moore <paul@paul-moore.com>, code@tyhicks.com, Francis Laniel <flaniel@linux.microsoft.com>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: bpf signing. Re: [POC][RFC][PATCH] bpf: in-kernel bpf
 relocations on raw elf files
Message-ID: <bqxgv2tqk3hp3q3lcdqsw27btmlwqfkhyg6kohsw7lwdgbeol7@nkbxnrhpn7qr>
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
 <CAADnVQLxgD_7GYWZZ49aY2LqVYOy4uGvK2ikm7MJ1Cj60VPNaw@mail.gmail.com>
 <87ikqm45da.fsf@microsoft.com>
 <CAADnVQLYeV8-nJ-=_4p8U=xax99-i5QavJrQ=hnKS0EK1ZjecA@mail.gmail.com>
 <87sepl5k4z.fsf@microsoft.com>
 <CAADnVQJtbMCVJ4WfNk44QEh0oVRTYqUMBn3zFAgrVP469k7v2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJtbMCVJ4WfNk44QEh0oVRTYqUMBn3zFAgrVP469k7v2g@mail.gmail.com>

On 2025-01-23 21:08:14, Alexei Starovoitov wrote:
> On Tue, Jan 14, 2025 at 10:24 AM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
> >
> > It looks like they are done in the kernel and not necessarily by the
> > kernel? The relocation logic is emitted by emit_relo* functions during
> > skeleton generation and the ebpf program is responsible for relocating
> > itself at runtime, correct? Meaning that the same program is going to
> > appear very different to the kernel if it's loaded via lskel or libbpf?
> 
> Looks like you're reading the code without actually trying to run it.
> 
> > >> Would it be amenable to possibly alter the light skeleton generation
> > >> code to pass btf and some other metadata into the kernel along with
> > >> instructions or are you trying to avoid any sort of fixed dependencies
> > >> on anything in the kernel other than the bpf instrucion set itself?
> > >
> > > BTF is passed in the lskel.
> > > There are few relocation-like things that lskel doesn't support.
> > > One example is __kconfig, but so far there was no request to support that.
> > > This can be added when needs arise.
> >
> > Yes, I ran into the lskel generator doing fun stuff like:
> >
> > libbpf: extern (kcfg) 'LINUX_KERNEL_VERSION': set to 0x6080c
> >
> > Which caused some concern. Is the feature set for the light skeleton
> > generator and the feature set for libbpf is expected to drift, whereas
> > new features will get added to libbpf but they will get added to the
> > lskel generator if and only if someone requests support for it?
> 
> Correct.
> 
> > Ancillary, would there be opposition to passing the symbol table into
> > the kernel via the light skeleton?
> 
> Yes, if by "symbol table" you mean ELF symbol table.
> 
> > I couldn't find anything tangible related to a 'gate keeper' on the bpf
> > mailing list and haven't attended the conferences.  Are you going to
> > shoot down all attempts at code signing of eBPF programs in the kernel?
> 
> gate keeper concept is the sign verification by the kernel.
> 
> > Internally, we want to cryptographically verify all running kernel code
> > with a proper root of trust. Additionally we've been looking into
> > NIST-800-172 requirements. That's currently making eBPF a no-go.  Root
> > and userspace are not trusted either in these contexts, making userspace
> > gate-keeper daemons unworkable.
> 
> The idea was to add LSM-like hook in the prog loading path where
> "gate keeper" bpf program loaded early during the boot
> (without any user space) would validate the signature attached
> to lskel and whatever other prog attributes it might need.
> 
> KP proposed:
> https://lore.kernel.org/bpf/CACYkzJ6xSk_DHO+3JoCYpGrXjFkk9v-LOSWW0=0KLwAj1Gc0SA@mail.gmail.com/
> 
> iirc John had the whole design proposal written somewhere,
> but I cannot find it now.
> 
> John,
> can you summarize how gate keeper bpf prog would work?


Sure. The gate keeper can attach at bpf_prog_load time, note there is
already a security hook there we can hook to with the bpf_prog struct
as the only arg. At this point any number of policy about what/who can
load BPF programs can be applied by looking at the struct and context
its being called. For better use of crypto functions we would want this
to be a sleepable program.

Why it needs to be a BPF prog in this model is because I expect the
policy may be very different depending on the env. We have K8s
systems, DPUs, VMs, embedded systems all running BPF and each has
different requirements and different policy metadata.

With BPF/IMA or fsverity infra the caller can be identified by a
hash giving the identity of the loader. This works today.

We can also check a signature of the skel here if needed. Maybe some
kfuncs are still needed (and make it sleepable) I haven't done this
part yet. I found binding identity of the loader to types of programs
is a good starting point. A roster of all BPF programs loaded in a
cluster is doable now. Anyways a kfunc to consume bpf_prog and key
details to return good/bad is probably fine? Or break it down into
the individual ops would be more flexible. This should be enough
to solve the cryptographically verify BPF programs.

There is also an idea that we could provide more metadata about the
program by having the verifier include a summary. One proposed example
was to track helpers/kfuns in use. For example a network program that
can inspect traffic, but not redirect it.

End result is we could build a policy that says these programs can
load these specific BPF programs. And keep those in maps so it can
be updated dynamically on a bunch of running systems. I think you
want the dynamic part so you can have some process to say I'm
adding these new debug programs or new critical security fixes
to the list of allowed BPF programs.

Some other commentary:

Also to be complete a way to load BPF programs in early boot would
reduce/eliminate a window between launched trusted kernel and gate
keeper launch.

Either the gate keeper can ensure it can't be unloaded by also
monitoring those paths or we could just pin a refcnt on it when a
flag is set or it comes from early boot.

Map updates/manipulation can also wreck BPF logic so you will want to
also have the gate keeper track that.

As a first step just making it sleepable and exposing the needed
kfuncs would be realtively easy and get what you need I suspect.
Added the gatekeeper BPF prog at early boot would likely be all
you need?

Thanks,
John


