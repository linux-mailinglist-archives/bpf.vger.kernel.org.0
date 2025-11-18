Return-Path: <bpf+bounces-74995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BB5C6ADFC
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 18:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8703A4F1DFF
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 17:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DCA3A5E7F;
	Tue, 18 Nov 2025 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flHbb+kv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127D6377E94
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485683; cv=none; b=g2S6DNM5pP2uAJq8TJpDuXiHDX63BWhbsK1vbqc9VD/dbJqy1WpUdeiy3/ieamVq7LRPadVWyUjDmiMQgFYzmyAhDN/vxS3KMTy83Saout/vcg0Dne0suQB49x8HGIqulob9woL4AwzSwlCycP6Ruvr3/sEIEtToaDODKpPeWFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485683; c=relaxed/simple;
	bh=F8CuJeWElMS9iOXMP2He2vLpEk/N7ohjPoqnU46dw5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRXCLfbFR7gGDr6STOiLKxEdOK1imHpSfujghvohmOA7+LxiUKRWu+lmy1q5APYRjo28oHJlzoNUYoWwzUcCtZYXifeEhaVJ/A2DQgFR2TYvuL8vrvX1cuoXC3JEtm89v3Cz3QB71GqUr4TKIqCp4qcCg5Qes2kRtCZoDK6D1Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flHbb+kv; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so4996430b3a.0
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 09:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763485680; x=1764090480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=irwlmmJ0MMkznpqLMQ8QH3n1XaAIkdzPe81PjobofI4=;
        b=flHbb+kvz76jrpKRlW0XXOWHe2wGf/Y1Y6jotFUGfaA9vFeqaYcNhVZzykG2gFYbVm
         9DTjlK142ijxN4FBb42UPYBIUxetfcF/RE0gCDRayBrsefd+ZxAtHcH6kguQUuGJU7e6
         /2XVPq/KMae2Z6TWrH65G7CCb8DLirGbUqCvAC5bZSETCKUyLT5GKtxb07IQW1xSxqzp
         nxfBrI8ihzUZ0kCQowXAQrCyOQAWvWFrl4FQiRZ7Ctv7bUWGHD4elq/PUyo52gz9P882
         PV24GkD5zqG/dgFpFcXUQKM/9lEF9/ECpkxGF+5BSr1JIpsVlkx43Tcc+ktYLYiHSqUZ
         iH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763485680; x=1764090480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irwlmmJ0MMkznpqLMQ8QH3n1XaAIkdzPe81PjobofI4=;
        b=tDPOU5chbsB5uIgzWE2BE+XtsqKXsvfu0a2jm5geUOUKCwho5OI5SwyUt7Womf6IA9
         H/dD/zUlZSXnMkZYzvlp20t0yPiCFg1N7OFAqj7zfpIqVsVq9dxd1bGPw+niSUPwBK6P
         5zYVQLofyFU9KtlQetdeRll3RiU30QL929KhqSJCJbR+eaYW+iB3bvdlDk0fAAr+jFr6
         wb9DEY+gsNNSEXYdOjq34W0NhlVrWRjPZ5eXm/JeOo9achx4qPzZU7xG8Km1FWTpHFxE
         1hsodS9/tnJjQCKnCDKIFPnje8ErPiQiP25hEJqvlnvpaLhR3MLf88KodDUoe3GEYSKn
         y51g==
X-Forwarded-Encrypted: i=1; AJvYcCU4FUJHqNBZAmWcLKhJwrzgxJ4QXH6DIKzUhSNEKekNawZZ01PhXpvKSN0pci+Qv/gz9DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGp86PFMkJZoieJpRdinonSv1xknz6IPCMubjocHErWVKElmcX
	uxe3ArPFjdwrw/0rIYqoavuh5cYwshzL2+5+piimhyNr80FfmGqth/HX
X-Gm-Gg: ASbGncsqfB1CVf0pLCDQUfYFrEigOT6iZmHn0OFfW2KrdYG/C+bJOUlrDv9sZz56lzY
	2IZ5LD9AE+scPFHFXQ8w9cPOtHoGkligLwlsgcRWw/LjoCfT51GnwHK+wDGvOVvio47by9hsByo
	zcp3Lqkg9T2o6XKddkSPWLdBT4SG2CbUrsxLJdljBVsuHSeI//EKaDWdArGbiNAn8Wlo92htNLm
	ygS10qhiSZ5VIs7i398iOs9nYJcVXooRHUGyXVy2fShCQOAjEZIHNZ0cZKyvyJI4j6afoN9YEGG
	/7wGhxm8t9zq0uTrpNq6vh/1VO4e5R3gez4z1kZTo9HAzuBqitnewwfyHqdaD/NdB+nl3akGd+n
	cn0UeUi9686z0DSPAsD6J9BkEIw7n8XXzdABGF10qrI2CRZDRbSly/uoIJ/o5xYV/kZdOoeiaRr
	bYM1wClAkLfNLp5Ix0Szl9+ybqcHGxxTIdJeu8Od89HNkt4brn7nSoMY2XIM3Z2gxr
X-Google-Smtp-Source: AGHT+IFp7aKWRAnpg/nz3uAMMrTccHCEVazeBR6Eybowi+fOK2iM3BI0IvxR7anyhC7bwx7kDFbgOQ==
X-Received: by 2002:a05:7022:43aa:b0:119:e55a:9be4 with SMTP id a92af1059eb24-11b40b30ecamr9630301c88.0.1763485679910;
        Tue, 18 Nov 2025 09:07:59 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b0608860fsm52235294c88.5.2025.11.18.09.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 09:07:59 -0800 (PST)
Date: Tue, 18 Nov 2025 09:07:56 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"hch@infradead.org" <hch@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"urezki@gmail.com" <urezki@gmail.com>
Subject: Re: [PATCH v3 0/4] make vmalloc gfp flags usage more apparent
Message-ID: <aRyn7Ibaqa5rlHHx@fedora>
References: <TY3PR01MB11346E8536B69E11A9A9DAB0886D6A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346E8536B69E11A9A9DAB0886D6A@TY3PR01MB11346.jpnprd01.prod.outlook.com>

On Tue, Nov 18, 2025 at 04:14:01PM +0000, Biju Das wrote:
> Hi All,
> 
> I get below warning with today's next. Can you please suggest how to fix this warning?

Thanks Biju. This has been fixed and will be in whenever Andrews tree
gets merged again.

> 
> [   13.122280] systemd[1]: File System Check on Root Device was skipped because of an unmet condition check (ConditionPathIsReadWrite=!/).
> [   13.142562] ------------[ cut here ]------------
> [   13.147308] Unexpected gfp: 0x400000 (__GFP_ACCOUNT). Fixing up to gfp: 0x100dc0 (GFP_USER|__GFP_ZERO). Fix your code!
> [   13.158526] WARNING: mm/vmalloc.c:3937 at vmalloc_fix_flags+0x9c/0xac, CPU#1: systemd/1
> [   13.166576] Modules linked in: backlight ipv6
> [   13.170983] CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.18.0-rc6-next-20251118-gcc318393a5df #175 PREEMPT
> [   13.181082] Hardware name: Renesas SMARC EVK based on r9a07g054l2 (DT)
> [   13.187641] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   13.194675] pc : vmalloc_fix_flags+0x9c/0xac
> [   13.194705] lr : vmalloc_fix_flags+0x9c/0xac
> [   13.194715] sp : ffff8000828fbab0
> [   13.194719] x29: ffff8000828fbad0 x28: 0000000000000000 x27: 0000000000000000
> [   13.194734] x26: 0000000000000000 x25: 0000000000000000 x24: 000000000000000f
> [   13.194746] x23: 0000ffffcc595b58 x22: 0000000000001000 x21: 0000000000100cc0
> [   13.194757] x20: ffff8000801d7af0 x19: 0000000000001000 x18: 0000000000000006
> [   13.194768] x17: 0000000000000000 x16: 0000000000000000 x15: 006c326703000000
> [   13.194779] x14: 00000000000001da x13: 00000000000001da x12: 0000000000000000
> [   13.194790] x11: 00000000000000c0 x10: 0000000000000ac0 x9 : ffff8000828fb920
> [   13.194802] x8 : ffff00000aca8b20 x7 : 00000000021cb08a x6 : 0000000000000186
> [   13.194813] x5 : 000000009d17f2f7 x4 : ffff800037e00000 x3 : 0000000000000010
> [   13.194824] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00000aca8000
> [   13.194836] Call trace:
> [   13.194842]  vmalloc_fix_flags+0x9c/0xac (P)
> [   13.194855]  __vmalloc_noprof+0x60/0x74
> [   13.194865]  bpf_prog_alloc_no_stats+0x44/0x218
> [   13.194879]  bpf_prog_alloc+0x28/0xec
> [   13.194888]  bpf_prog_load+0x168/0xcdc
> [   13.194899]  __sys_bpf+0x814/0x211c
> [   13.194907]  __arm64_sys_bpf+0x24/0x40
> [   13.194916]  invoke_syscall+0x48/0x104
> [   13.194927]  el0_svc_common.constprop.0+0x40/0xe0
> [   13.194935]  do_el0_svc+0x1c/0x28
> [   13.194943]  el0_svc+0x34/0x108
> [   13.194955]  el0t_64_sync_handler+0xa0/0xf0
> [   13.194964]  el0t_64_sync+0x198/0x19c
> [   13.194975] ---[ end trace 0000000000000000 ]---
> [   13.328233] fuse: init (API version 7.45)
> [   13.339395] systemd[1]: Starting Journal Service...
> 
> 
> Cheers,
> Biju

