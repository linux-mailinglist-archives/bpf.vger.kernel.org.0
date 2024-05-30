Return-Path: <bpf+bounces-30947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDF48D4B63
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 14:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6671C218AB
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 12:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F068F1C68B4;
	Thu, 30 May 2024 12:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpVaL8VE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0BB1C0DE6
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071530; cv=none; b=fnBJRj7d9XIZ/wMRf4RqwV5zhE7zZyYZPVwOcNRiFP1sesorlxOVCle78r3P4jJbGKOIBCt/IGiHcfBtFEovLrYQqIXKVh2UrDwbgogM4Trk5URPHOG8JDzH3MyqJd21tVCcdVeCh20hH0/G5KcsP6RoMs5wLdmDGvYAzZwxSz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071530; c=relaxed/simple;
	bh=S5YYRx8xpt/9Z++/PWJ1JPr2UaBZO3HE5kllfNF8hOI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBbZnCpVoILRgOlXxS2hzXjcQIaLVIu2GBab3+gU5gvfH8djb7fIpWLG26Cn1pJAGcSe2zLqz1V4+6qFxzLWKFxqW2qDpO7Sc1hdMSa4C9N/VUtMNAJh3b5/4YmyZfR3g7EBl3CelOTSmHk4ETkD9afRgRWIbuu9M+Z2bBUyUEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpVaL8VE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-420180b58c5so8190755e9.3
        for <bpf@vger.kernel.org>; Thu, 30 May 2024 05:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717071527; x=1717676327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SOQXDfu+UxUcuJk6Lu3sO+SrRwP4Xdc+LdcvLtlwVaU=;
        b=RpVaL8VE6M9y6reGrq7xo7EaTAMbW3A/apNprNLWyGF2ZXAzuncq8driszSQ93uOic
         TcZnk9WLSg0WA4YsTtFrwUp/rXbB9vUif31977M0Ci/x0NtUAdSHXAoKj2Xg+oqeIodN
         vpWIjD74SFjie6iCdjblYB0xQbi2slhexEL9YF2J1pv0Z3THOeg/SZeBoufVT3PbJSz7
         mkAbUmk9TMNvzPDnoP8V8kFd8zLT1sHM/EurXrjgnWRwfO3zye5aJGOMKS18HPNphCsN
         TkWZFxtDGCGVgC+WoGi1NWXToJqXYDU0pcSyPGjT521s4HK5KbG9PcRtv4GoOuEbBc0v
         MPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717071527; x=1717676327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOQXDfu+UxUcuJk6Lu3sO+SrRwP4Xdc+LdcvLtlwVaU=;
        b=m3d8yTnVBklcTGBR9nkCnYsIcYaxdtlaCBU3bxy56Tv5XVKJKA510/cxzZpzzF7x1k
         ZIC6jf9bdh61ou7aIJvyGtpci7JkvxhDFRoGbxDxSd7jvcvKO7D7vUsjgynN7xLpP9N2
         Iom6hU2fdgDD95pY39XJ2y49etBie3lFYzRDJ4M+bItUhtmB2CQ/KgHozTlqOJEzHTYn
         yILG7549sh/WR9SCA31nSA8pNTMN0KLeoqKBSQWuPDYaFrdNNVRtrcF9Nf0KoyGpFUQm
         hOgHIDtoN3nt2EQL4i745pMfxFly/uxbYBYIYpoWwdnYo5S14kaK3q27QI8+EzbCcoxJ
         lAKw==
X-Gm-Message-State: AOJu0Yy8KT85bJ3FXsMDvUgoOQP56EPFyX7JJDtTG2a3zwfpPBnvJ+hs
	pVGXY/2P+ZDOPWoWSUWtPRdGDfeYk+1PgdIHHXx6pAT7ZRDAN1+4FVCIBQ==
X-Google-Smtp-Source: AGHT+IF7iUvZF08y8uj66U/pGmm1nqcF/r2bASOe86ObV/Yf1fLvDSJpwmbCztPqr/G235IpAU2PvA==
X-Received: by 2002:a05:600c:4750:b0:420:fcd:10e0 with SMTP id 5b1f17b1804b1-421278188f2mr21339785e9.15.1717071526906;
        Thu, 30 May 2024 05:18:46 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35586a15f7csm17417643f8f.94.2024.05.30.05.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 05:18:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 30 May 2024 14:18:45 +0200
To: Lennart Poettering <mzxreary@0pointer.net>
Cc: bpf@vger.kernel.org
Subject: Re: bpf kernel code leaks internal error codes to userspace
Message-ID: <Zlhupe1tXj8ZS1go@krava>
References: <Zlb-ojvGgdGZRvR8@gardel-login>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zlb-ojvGgdGZRvR8@gardel-login>

On Wed, May 29, 2024 at 12:08:34PM +0200, Lennart Poettering wrote:
> Hi!
> 
> It seems that the bpf code in the kernel sometimes leaks
> kernel-internal error codes, i.e. those from include/linux/errno.h
> into userspace (as opposed to those from
> include/uapi/asm-generic/errno.h which are public userspace facing
> API).
> 
> According to the comments from that internal header file: "These
> should never be seen by user programs."
> 
> Specifically, this is about ENOTSUPP, which userspace simply cannot
> handle, there's no error 524 defined in glibc or anywhere else.
> 
> We ran into this in systemd recently:
> 
> https://github.com/systemd/systemd/issues/32170#issuecomment-2076928761
> 
> (a google search reveals others were hit by this too)
> 
> We commited a work-around for this for now:
> 
> https://github.com/systemd/systemd/pull/33067
> 
> But it really sucks to work around this in userspace, this is a kernel
> internal definition after all, conflicting with userspace (where
> ENOTSUPP is just an alias for EOPNOTSUPP), hence not really fixable.
> 
> ENOSUPP is kinda useless anyway, since EOPNOTSUPP is pretty much
> equally expressive, and something userspace can actually handle.
> 
> Various kernel subsystems have been fixed over the years in similar
> situations. For example:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20231211085121.3841b71c867d.Idf2ad01d9dfe8d6d6c352bf02deb06e49701ad1d@changeid/
> 
> or
> 
> https://patchwork.kernel.org/project/linux-media/patch/af5b2e8ac6695383111328267a689bcf1c0ecdb1.1702369869.git.sean@mess.org/
> 
> or
> 
> https://patchwork.ozlabs.org/project/linux-mtd/patch/20231129064311.272422-1-acelan.kao@canonical.com/
> 
> I think BPF should really fix that, too.

hm, I don't think we can change that, user space already depends
on those values and we'd break it with new value

it's unfortunate, but I don't think we can do much about that,
other than enforcing EOPNOTSUPP for new code

jirka

> 
> Or if you insist on leaking internals to userspace then please move
> the definition to the public "uapi" headers, but yikes you are in for
> some pain then given the conflicting userspace definitions.
> 
> Lennart
> 

