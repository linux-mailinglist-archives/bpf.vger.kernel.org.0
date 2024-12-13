Return-Path: <bpf+bounces-46852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A23E29F0E7A
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 15:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568EA188473A
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0337B1E0DD1;
	Fri, 13 Dec 2024 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaDm9j+Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0881E04B3;
	Fri, 13 Dec 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734098760; cv=none; b=tOrZ0Eo4xh5FieSZQoym88OMUSbCDvPXfO1OsLTzkujT0w49Hd6aFZd/6eG2+W9Z7PdwDhKoDD3rKqKH1f7YqjUjom/a7ZR1PQRHPPtwLxTLTkN5RVfAO2FYF8M5TmFH0/CIVNkAf32nVU5Ot3ki9dIbhBegghajpMcb2pSq/wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734098760; c=relaxed/simple;
	bh=dl7sJS484C9gSv3OoCTqkwXKHjDdICZRB9u08gb9Ic0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9ToNz5ltiiqAxDjpv5HU/l9l9jcP0Ys8waYyAmZ647nmYCMMuam9RhLWFIb9Y0+tnrN/HJ0jaPtEH15SS/ee7L0L6iQCRkX0oJrBzy/0bpbF86Qd2cVdxp8My2mQWUZE8nKrxpcBePlxUaXaunNgpnyMF8bGZ9pA5jH0wsWWoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaDm9j+Z; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so2837322a12.3;
        Fri, 13 Dec 2024 06:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734098757; x=1734703557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F41wkTvJU2o0cPXZH4+QHkoVVi8Q4p8v/WGLh5PuiSc=;
        b=TaDm9j+ZDlFs2+Dy1peNL5tW1ggFO8fkl/Ewxe9MKwZMQGFCKdTBKVyaokeVJP/GFB
         k/YhatOMnUh+X8u/l5o1CzPnEUsLCTl7Zfk0243ghyQMe1m8RNwqTOfukIi54YU/wbd6
         br21qaNifAx7eNwBTnHaNRcv2pp2iCWGbzBAHxku3eZwQRD9DQtCqEGdvWXkrOcnIQ3i
         WuuyT9b66SiHk0amx4MOOQPJBHEHSgn318ZLDUgHlHKbxJnOJ5ziypJ5Ac0ilGQUwWEm
         WTlakQw7mEIkiObox2Jb/T7M43KNwFeyWE9FtGwJUFX7xL7E/tiCeftYH6C9R95c9kI7
         cIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734098757; x=1734703557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F41wkTvJU2o0cPXZH4+QHkoVVi8Q4p8v/WGLh5PuiSc=;
        b=rFBCuL+5hsw4jDbeX1dpoAG6uCgLdfiOgFGPN6IN4/Awta9f24jDuE6QYbbwVVrOR2
         1+JZf4KwRXcQfxRzUFAmXWP37qTP/Nz+WZhXd6DaTKZRrXggtrFnWMIKBYJLhHz5B/rv
         V/WRxkagLjYDbdt0s5e2ITY5adCOZeG+HTol5kCAAIA/u5mmFsNLJw8SF3mHcLt6+d2L
         edzPCahAuhe4M+NcCrCh6MX+piIxEsXuyEtHgpp8sUd6+QkJJ7ZRjXSy2NzA1AYDnEDX
         m6ez34/f3cEYx31DeD16mv/KStJ9r6tFuxxTrH9Ta1eZiBjRT/X780igit98rDeQ3yTr
         L0kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV6abvAJzSX5vZ42BAJTli3P9mUUWigC3LfZKZSMFCVa9PYJWXWDagr9Pvk+XP6cpUzeEMnTLIGbVxhQgl8p78MHCt@vger.kernel.org, AJvYcCWVNmGlQuoY4EpxM6M5IApRelJethUcLsIxoe+fpcGfixVygAYr0qyDAOeSLwJ5RZYBP9qQCQHZ5Jc5LU9M@vger.kernel.org, AJvYcCWdxHbn2dqF9kkFV/0wn3WECpPHMVbfRdL40iyazMjpDvrh6SJIObzF8aN4nviSkBGs4uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjT987wcQpCLNMLV40gfODn8+Xvs5UHNzPCqBaX7PZFPai8x9c
	Cr0BxZtkhnDc0lXaedFGGrpKJ39PCv6TwlT4WXH83aodZ9br2mxR
X-Gm-Gg: ASbGncv1qrLNlSgWJITWSEpeiEPi43JjZpr+I3+IV1NxFs/3jjUaJGSVTrc8LHGjkFA
	4bdOmNoCIVNvQ3d4gObX3yqfleyA+axvdcTzmJB6lf4DsycmHQ8ufz+GXguqTcbo3zpHa4cLVc1
	q5ieQg0AAqVPoeGBwIvCcP9TDPmJxYNS+ghJgbN9HOtnn0EBGqhq4IfedRFC0Vcy3oGST5+G29b
	yk6NAJfDEhVLLLLXQWQ5WiC/4PrbbTZoiclWBgeCzyiK7hgP/TRaydwWEbisQI0P5LZwnuxj2P5
	FFiFK9TqRq53Z33CAyKSJXa7FfbGfA==
X-Google-Smtp-Source: AGHT+IFPmChUMSZFX8BiH04WL+oELaDILKLogU4nJpjpy7yyli0RY361SMRylUkLmNjb0s+HB1x3lw==
X-Received: by 2002:a05:6402:3884:b0:5d0:8889:de02 with SMTP id 4fb4d7f45d1cf-5d63c3aa66fmr2592273a12.22.1734098756934;
        Fri, 13 Dec 2024 06:05:56 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c7991a5sm11425859a12.58.2024.12.13.06.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:05:56 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 13 Dec 2024 15:05:54 +0100
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 00/13] uprobes: Add support to optimize usdt
 probes on x86_64
Message-ID: <Z1w_Qi_Wya56YDO_@krava>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241213105105.GB35539@noisy.programming.kicks-ass.net>
 <Z1wxqhwHbDbA2UHc@krava>
 <20241213135433.GD35539@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213135433.GD35539@noisy.programming.kicks-ass.net>

On Fri, Dec 13, 2024 at 02:54:33PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 13, 2024 at 02:07:54PM +0100, Jiri Olsa wrote:
> > On Fri, Dec 13, 2024 at 11:51:05AM +0100, Peter Zijlstra wrote:
> > > On Wed, Dec 11, 2024 at 02:33:49PM +0100, Jiri Olsa wrote:
> > > > hi,
> > > > this patchset adds support to optimize usdt probes on top of 5-byte
> > > > nop instruction.
> > > > 
> > > > The generic approach (optimize all uprobes) is hard due to emulating
> > > > possible multiple original instructions and its related issues. The
> > > > usdt case, which stores 5-byte nop seems much easier, so starting
> > > > with that.
> > > > 
> > > > The basic idea is to replace breakpoint exception with syscall which
> > > > is faster on x86_64. For more details please see changelog of patch 8.
> > > 
> > > So ideally we'd put a check in the syscall, which verifies it comes from
> > > one of our trampolines and reject any and all other usage.
> > > 
> > > The reason to do this is that we can then delete all this code the
> > > moment it becomes irrelevant without having to worry userspace might be
> > > 'creative' somewhere.
> > 
> > yes, we do that already in SYSCALL_DEFINE0(uprobe):
> > 
> >         /* Allow execution only from uprobe trampolines. */
> >         vma = vma_lookup(current->mm, regs->ip);
> >         if (!vma || vma->vm_private_data != (void *) &tramp_mapping) {
> >                 force_sig(SIGILL);
> >                 return -1;
> >         }
> 
> Ah, right I missed that. Doesn't that need more locking through? The
> moment vma_lookup() returns that vma can go bad.

ugh yes.. I guess mmap_read_lock(current->mm) should do, will check

thanks,
jirka

