Return-Path: <bpf+bounces-30999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53608D5B49
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 09:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144331C247E8
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 07:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463E57FBC1;
	Fri, 31 May 2024 07:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzgeReBT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BC6187569
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 07:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717139789; cv=none; b=HqoOxWoE0TRZTcZ749l+K+sBxd1Tzxhph9cJeEJfuve5DbuQ+5GmoIUsp2EYm/eYZq7Ke+nyeFrWoM3ZYC1oo+Reg87CjyCsqS8FAkNNk/ELSXm3I5Bm+cREFEU/DKj4QM/YrSMgMLeCMiKgScbINXTSLH4PVZ1J73Z73nfMWss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717139789; c=relaxed/simple;
	bh=scbE8qm7+Mt9/n6uv3JXQ4p5D1+X2vZXC7VCe7y+EWw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljav+z5gU4aEd7EFJAfQoYGsSErPUg/VE+mTt5LjgxcwhRi5ARwczfjfoMOZsMzzS3BhccuZuJj0OfhWpR0jJlG3OrvoU9RnorYRpBi8dQ9MejGt0I1nSThzQ3K4KMoNft2wA27DL5881x4tMPDm3D/FfCvHnCHrdpqXWhSOegc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzgeReBT; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso2675004a12.1
        for <bpf@vger.kernel.org>; Fri, 31 May 2024 00:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717139786; x=1717744586; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lSfEylUPpb/fAOmraunPQcgjr5vmuJYrxop4LDtRXhI=;
        b=dzgeReBTuTUzs+e2uJgGHT9RW1mls6KXZGsLykAi6hga++5nSCR1+ywDbpzsFtllUg
         7e5RezfYbv1Oog5++LAGC/gZ3t19Z7sJGSGwF+yHexnLRxua3V31fLWpb2iJVxxiMc6T
         jrKjUyMnkiPCt9+i/JWOQGhaQDaOO9x2cou6wzVTr0XnVnWJqJ8pM9VZ1geWF++osTi5
         AESOUg34oNoc73LlWXYPuGoCTcAWp5Jb7yFcvn1QHa9+y7JIowaqOxa7UFkB1hSd59Vk
         dhdWhivIw2eWC3Z0t4MdpliJiLOSkM/2ivvDt4lr4GcRxJpxDV7Q8H8KEE+dpA0cKctu
         sOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717139786; x=1717744586;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSfEylUPpb/fAOmraunPQcgjr5vmuJYrxop4LDtRXhI=;
        b=Z2p35Wm/bgjPUUlW+CE9x+baeIBVBdxU5M+/X3GROp9N077RJcgNDwKv8H0QfxaJcL
         oJS4H2OS/jG5f8+CflHnMin+xViIgEMHcj+QdL10twt+0ZkAa4KxlI/NL2INhdEmm5lY
         LsktQK3PnrStvq27bb9zs+W4m+A79Q7J6eEtoY8MVGW4bVpMWONekyPuBL3Y/1STjEWX
         CgJqIhs2RthiL6WSOjW4etBSqtaNKmESzY7ew+V+BLwj/9K2CUJ1Lc1yS5qca3uh9Y7s
         kQR9O1w4qOcrCllvy9WEyvcTW1bRhjGRgEPeMvsY/8eKCiivv2qECAonYWsX/p8jl/Pl
         VKAw==
X-Forwarded-Encrypted: i=1; AJvYcCWHKyj2q8ddAIsWZX6qM5MNNBzBKU4APUXVthvDXNqz3yXWxym7S7aUhFKMPG5LaGmmve21fp+5yKgcNkqhJM0Kr0/C
X-Gm-Message-State: AOJu0YxrE65Jn/lo6ZOooYuINYH+JpN9jFjs34qx/+xd3NkRr7nMx/R2
	7V8QUdUWSDOvsX6in8JXdCuLp4FGpu8Uu8+NY9LwEOaiJKRvn0m1AK3ElQ==
X-Google-Smtp-Source: AGHT+IEeO1RC+6vgMSSnSbBhW4EKu4iTMR6YVBEd6njMnortdvFNxAqv7iqg1UJ4QM1YH1jMXw9FmQ==
X-Received: by 2002:a50:8e13:0:b0:578:5f9d:9ab7 with SMTP id 4fb4d7f45d1cf-57a1a313284mr3374636a12.17.1717139785988;
        Fri, 31 May 2024 00:16:25 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c9c0f1sm675099a12.80.2024.05.31.00.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 00:16:25 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 31 May 2024 09:16:24 +0200
To: Lennart Poettering <mzxreary@0pointer.net>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: bpf kernel code leaks internal error codes to userspace
Message-ID: <Zll5SJcJxvu_yXgt@krava>
References: <Zlb-ojvGgdGZRvR8@gardel-login>
 <Zlhupe1tXj8ZS1go@krava>
 <ZliKX5EOU9eWhd2U@gardel-login>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZliKX5EOU9eWhd2U@gardel-login>

On Thu, May 30, 2024 at 04:17:03PM +0200, Lennart Poettering wrote:
> On Do, 30.05.24 14:18, Jiri Olsa (olsajiri@gmail.com) wrote:
> 
> > > It seems that the bpf code in the kernel sometimes leaks
> > > kernel-internal error codes, i.e. those from include/linux/errno.h
> > > into userspace (as opposed to those from
> > > include/uapi/asm-generic/errno.h which are public userspace facing
> > > API).
> > >
> > > According to the comments from that internal header file: "These
> > > should never be seen by user programs."
> > >
> > > Specifically, this is about ENOTSUPP, which userspace simply cannot
> > > handle, there's no error 524 defined in glibc or anywhere else.
> > >
> > > We ran into this in systemd recently:
> > >
> > > https://github.com/systemd/systemd/issues/32170#issuecomment-2076928761
> > >
> > > (a google search reveals others were hit by this too)
> > >
> > > We commited a work-around for this for now:
> > >
> > > https://github.com/systemd/systemd/pull/33067
> > >
> > > But it really sucks to work around this in userspace, this is a kernel
> > > internal definition after all, conflicting with userspace (where
> > > ENOTSUPP is just an alias for EOPNOTSUPP), hence not really fixable.
> > >
> > > ENOSUPP is kinda useless anyway, since EOPNOTSUPP is pretty much
> > > equally expressive, and something userspace can actually handle.
> > >
> > > Various kernel subsystems have been fixed over the years in similar
> > > situations. For example:
> > >
> > > https://patchwork.kernel.org/project/linux-wireless/patch/20231211085121.3841b71c867d.Idf2ad01d9dfe8d6d6c352bf02deb06e49701ad1d@changeid/
> > >
> > > or
> > >
> > > https://patchwork.kernel.org/project/linux-media/patch/af5b2e8ac6695383111328267a689bcf1c0ecdb1.1702369869.git.sean@mess.org/
> > >
> > > or
> > >
> > > https://patchwork.ozlabs.org/project/linux-mtd/patch/20231129064311.272422-1-acelan.kao@canonical.com/
> > >
> > > I think BPF should really fix that, too.
> >
> > hm, I don't think we can change that, user space already depends
> > on those values and we'd break it with new value
> 
> Are you sure about that? To be able to handle this situation that
> userspace program whose existance you are indicating would have had to
> go the extra mile to literally handle error code 524 that is not known
> to userspace otherwise and handle it. If somebody goes the extra mile
> to do that, what makes you think that they didn't just handle it as
> equivalent to regular EOPNOSTUPP? In systemd at least that's what we
> are doing.

cilium/ebpf [1] library is checking return values just for ENOTSUPP(524)
on multiple places, libbpf has one place to check on that value for
program type detection AFAICS

jirka


[1] https://github.com/cilium/ebpf/

> 
> Also: if various other subsystems (I linked examples from wireless,
> media, mtd above) just fixed this, why not bpf, why is it special in
> this regard?
> 
> AFAICS the man pages of most syscalls just list errnos that *can* be
> returned, but usually doesn't list the precise conditions or makes
> guarantees about it. This specific error is not listed at all on any
> man page for the bpf() syscall, hence are you really sure this is
> actually as set in stone as you think it is?
> 
> I mean, bpf() is still a bit of bleeding edge tech, and people playing
> around with this probably tend to have quite new toolchains even, not
> old, hard to fix code?
> 
> > it's unfortunate, but I don't think we can do much about that,
> > other than enforcing EOPNOTSUPP for new code
> 
> I took the liberty to CC Linus on this:
> 
> Linus, what's the policy if some subsystem by mistake is leaking
> internal kernel error codes (such as ENOTSUP) to userspace? Leave it
> be as is (i.e. error number not defined in include/uapi/, not
> documented, but still returned), or fix it to the closest matching
> public error code (which is probably EOPNOTSUPP in this case)
> accepting a – mild, I would say – compat break?
> 
> [BTW, wouldn't it make sense to add a BUG_ON or so on syscalls that
> return an error number > 133 or so? This kind of issue is quite a
> recurring theme, see the patches above, and such a BUG_ON would
> probably catch 95% of all cases like this.]
> 
> Lennart

