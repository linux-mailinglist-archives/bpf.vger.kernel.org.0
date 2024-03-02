Return-Path: <bpf+bounces-23254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C2686F267
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 21:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427C41C20EBB
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 20:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BDD225D5;
	Sat,  2 Mar 2024 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcScbGSd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B8A15EA2
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 20:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709412414; cv=none; b=LIhTvU12XA4ZAWhlQt0ZHWwml6fTD+B/dR8mHgksOzJMLuX+kP/mbue5EKcJQYkDOI3Ib12rY/TUt37zVFzhkynU1Ul9tC3Q9cJ8wN+G+Y3KH9NYSyW1VaNzg6u/YzvJs4/+2EDdxGyqtZKnhYkr4eyYYIp308out0wuOTvElSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709412414; c=relaxed/simple;
	bh=2Q55+bmumvefHHEDMWR7Nwr7whJ2R6dlrd7YMMwk0/g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlSDpcyaOY5w32j9wjNCmBaEoR05a2MayNzM6ElG0sAVNgXbrKZrTHooDKXKMVJeYSRTa2fHG8UJG5NJys+oXXWRQVUAa0SPaRWxrcxI5pQTspx81V2aw5JRpqXQZm0m3UwWyo0Lr/HFrv8due35vpmmEczz/0QoJK2yf312gLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcScbGSd; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-564fd9eea75so4874418a12.3
        for <bpf@vger.kernel.org>; Sat, 02 Mar 2024 12:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709412411; x=1710017211; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o7OSiHBWEF6qfa7u3i+Hlgoe8+BsKAmsXD2n5bNkRPg=;
        b=UcScbGSd1CYhI1oobpKS+hT/lPay7l/Hrhg1gWetyc1yVtqG5m9mUjlFApsF8I3fCk
         HkxZXMIqxgXXHsjhkJKdD5TJF+MjOSFEWTa6kns1ZlZXO0/qo9vkBKwHH22b89hYqWb9
         TUIcjjUv/aAEOw52yt6VMNzLKhgp22Av6kBFbsVbTK+q0+upG+mdg8j7qRdiptmcOf4k
         GLqyrd3imezeZYIMBr4340v9TBoTsBUBbnKbgUJg+r1AHymA1kfPuNCM/Lfb7eCP3aAc
         5fdSShuR8MmqnJhS7boe/4+ldt516X8/sCo2rc0+GlzFGwx5yI365jQzO+8cct0ZJCdM
         ri9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709412411; x=1710017211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7OSiHBWEF6qfa7u3i+Hlgoe8+BsKAmsXD2n5bNkRPg=;
        b=bXsc/pQKPcLAmyQBQeUgFiC/n26Fgvobhgu/tsguTtMhGFgBOn+quD8Hlkz7LUxb7/
         /a6GY2W2p/UCSq9oLZkufZV3IMrcZytmBW5n2xNkCzzeAR5m8ps+49r75NA8cmOklxae
         c/N7anSR0kDYg/FmJ7jsUaWjLfHpK2F5xP5HDOHWro9WC0lrCbEVyAOSm0ByQhek94p/
         2ayGyAY+Jh4DxnmMbBFW1bn10UwyrK4Z8vIBL7YdK0jG7MwXA6xVOSPdyoNZjqgaZzYY
         6ooeW3PvseJn+BNUWJYOAt0xA+UZ0EqUKWrgYbD52wy+f6ifndJhx1uf7bQoUNSo+MWD
         pgyA==
X-Forwarded-Encrypted: i=1; AJvYcCWgSX52qP0xoE47zmroiqdU0XtJzwMitaUlQjvhxXV0YymY5bKXZiRdHfxGV560F9UHJkLLgHt+d2UlGwK6PJewQ9NR
X-Gm-Message-State: AOJu0YxNJI6OdsSYfGEjxYWqY3i0JXkEKKoLmBuc0n9q+/6J9J1Z/p9b
	rrDOaS1d4T4Z8v4p9uSWGokMe2C2tWtVaojiRjnVK58DlzS86iuJhvpnUIr0
X-Google-Smtp-Source: AGHT+IEMSo6v9cPDpIFfpFCT/9vWlvnvLQi9y0cWX7QLOkSCA3JzZ3qIKYeAL/sZkbK/8jWFQkrnPQ==
X-Received: by 2002:a05:6402:1e86:b0:566:8054:56c with SMTP id f6-20020a0564021e8600b005668054056cmr3895891edf.27.1709412411326;
        Sat, 02 Mar 2024 12:46:51 -0800 (PST)
Received: from krava ([83.240.61.14])
        by smtp.gmail.com with ESMTPSA id p8-20020a056402500800b005648d0eebdbsm2881902eda.96.2024.03.02.12.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 12:46:50 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 2 Mar 2024 21:46:48 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, yunwei356@gmail.com,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Oleg Nesterov <oleg@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
Message-ID: <ZeOQOE08x0fUpA7d@krava>
References: <ZeCXHKJ--iYYbmLj@krava>
 <CAEf4Bzbs4toMxw62kVTWNHA7sW-CncamyKHCWynCT0GnG+fOfQ@mail.gmail.com>
 <ZeGPU8FRqwNuUJwd@krava>
 <CAADnVQKW4Qk55NjaApx1caPDF_pA8f5JZFE12DKA2R8cKWmtcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKW4Qk55NjaApx1caPDF_pA8f5JZFE12DKA2R8cKWmtcw@mail.gmail.com>

On Fri, Mar 01, 2024 at 09:01:07AM -0800, Alexei Starovoitov wrote:
> On Fri, Mar 1, 2024 at 12:18 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Feb 29, 2024 at 04:25:17PM -0800, Andrii Nakryiko wrote:
> > > On Thu, Feb 29, 2024 at 6:39 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > One of uprobe pain points is having slow execution that involves
> > > > two traps in worst case scenario or single trap if the original
> > > > instruction can be emulated. For return uprobes there's one extra
> > > > trap on top of that.
> > > >
> > > > My current idea on how to make this faster is to follow the optimized
> > > > kprobes and replace the normal uprobe trap instruction with jump to
> > > > user space trampoline that:
> > > >
> > > >   - executes syscall to call uprobe consumers callbacks
> > >
> > > Did you get a chance to measure relative performance of syscall vs
> > > int3 interrupt handling? If not, do you think you'll be able to get
> > > some numbers by the time the conference starts? This should inform the
> > > decision whether it even makes sense to go through all the trouble.
> >
> > right, will do that
> 
> I believe Yusheng measured syscall vs uprobe performance
> difference during LPC. iirc it was something like 3x.
> Certainly necessary to have a benchmark.
> selftests/bpf/bench has one for uprobe.
> Probably should extend with sys_bpf.
> 

ok, did not know there was uprobe benchmark, will check

> Regarding:
> > replace the normal uprobe trap instruction with jump to
> user space trampoline
> 
> it should probably be a call to trampoline instead of a jump.
> Unless you plan to generate a different trampoline for every location ?

I wanted to store the ip of the uprobe as argument for the syscall,
but the call instruction will push return address on stack and we
can use it to get uprobe's address.. great

> 
> Also how would you pick a space for a trampoline in the target process ?
> Analyze /proc/pid/maps and look for gaps in executable sections?

As Andrii mentioned in other response there's already one page mapped
as '[uprobes]' mapping, it's used as trampoline for return uprobes
(contains just int3 instruction) and as buffers to hold the original
instruction for the single step execution

I think if we endup with just single trampoline we can just use some
of the space from that page, our trampoline should not be big

> 
> We can start simple with a USDT that uses nop5 instead of nop1
> and explicit single trampoline for all USDT locations
> that saves all (callee and caller saved) registers and
> then does sys_bpf with a new cmd.

ah, I did not realize USDTs are like that, will check, good idea

> 
> To replace nop5 with a call to trampoline we can use text_poke_bp
> approach: replace 1st byte with int3, replace 2-5 with target addr,
> replace 1st byte to make an actual call insn.

I'm bit in the dark in here, but uprobe_write_opcode stores the int3
byte by allocating new page, copying the contents of the old page over
and updating it with int3 byte.. then calls __replace_page to put new
page in place

should that be enough also for 5 bytes update? the cpu executing that
exact page will page fault and get the new updated page? I discussed
with Oleg and got this understanding, I might be wrong

hm what if the cpu is just executing the address in the middle of the
uprobe's original instructions and the page gets updated.. I need to
check more on this ;-)

> 
> Once patched there will be no simulation of insns or kernel traps.
> Just normal user code that calls into trampoline, that calls sys_bpf,
> and returns back.

I saw this as generic uprobe enhancement, should it be sys_bpf syscall,
not a some generic one? we will call all the uprobe's handlers/consumers

thanks,
jirka

