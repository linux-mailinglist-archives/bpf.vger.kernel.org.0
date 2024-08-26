Return-Path: <bpf+bounces-38106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58B795FC61
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 00:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA53A1C227A7
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 22:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A94A19D88C;
	Mon, 26 Aug 2024 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YITfNBGQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CA719ADAA;
	Mon, 26 Aug 2024 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709711; cv=none; b=NgakVDGtEVSc4Qr51qYn4yzNuZfLqrWQNLv5ot3MzbFl8YP5FW99tRusnKYtPiyeXrIO85s/woLwY/qRQS2tBGflQ6ZTyBMjZuIsbMDmGUwiRYoiwO68mvuMeRKZOB7SlHz/JydkWt3gEI8S+a22pGBcUAzFzQTgbmPDWhAPkb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709711; c=relaxed/simple;
	bh=MAl8QMEg+vUOjw7aHlZYMvDL1CxDVI1xYwxmISPUo+s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVa3YKaTBTYdxbHIQZJWGSwb5mS3Dr3wacNtPNWpK1Otoq4L7xilLCryAKY7YHQEmBsqldJomwKkwklDIgU/XyyrbfXxRg3w0ahXs+dPDDgM3WcVzsu92Hytt1aFl+C/Kr82oUw4Byw7GRgBuUEFbB8HJC5iBycQ6+SBcHiTneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YITfNBGQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42809d6e719so41832945e9.3;
        Mon, 26 Aug 2024 15:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724709707; x=1725314507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=niKhWmEQf+Psg71lFmVBz1Uz8IkSk33YElBT/2u1MMg=;
        b=YITfNBGQFBQ47QRjPieRN6SGX7eKxOR7F1+/QikKJKIq6dsqkqJajcKV/ChM4sfIqR
         1zK8+GkqWU50xTsnEhu93t1rfW3N6bv2y2qb+0FBZb2fKD1UTKX8lgujDwlTzXLotro6
         wyd2ujbItQxAbzdWyaLjDiKcrY3wp/FVSMC/Qbw5TEY5Ol0GCjF9l4ogzrU7towWA8WY
         dhoyXm1Qj2QdHmHVTKYoq6/lilN+tE6FFczpAEHarakjd6F8bF24DGv3Ox4ifapcvAHW
         vTxPYF2ktH+C3AAi/fVEa2bVas6XHGnbXtzQvHWOscHGlpoor2TAKICbPhYV9GrF1q3l
         KyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724709707; x=1725314507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niKhWmEQf+Psg71lFmVBz1Uz8IkSk33YElBT/2u1MMg=;
        b=GwLTCW+COl8xI8LguowfGYRo+XA7gZKTmDcOQdNXdWZPTWcerSeA3/WCEvblqWz4Ef
         PfIfHeGmWXA+G2SoTbKrAzvxoPy3oY2ZK3bqahSzzkjVwXZnHmR3BPw1lMHOyZEEdWIO
         aVtsxMEv76fLcJPiNfcMtYeR78H37QDuuIb9IcAhmXmjDon9L6MOtY4iKgGABaJ4Z4YU
         Ozi/c5xL4rgdBS4mYTGw1s+YIv96C8Lxz1kCvCNHtq8Eiesa302fo3s2ftK1nv2zoa8c
         /Ptsu2dvlvdaxc9uy7uTHcmp6n5Kg4ZFmyG/rDUrO6k0y9KSGDDWIURws1JNgdptHbd6
         HcXw==
X-Forwarded-Encrypted: i=1; AJvYcCVpSCLa7y67YHApwp5D74sjWifcEWZzLN6BaBlUk51TXDqriYzOftuLRy3jodzhOvVhA5U=@vger.kernel.org, AJvYcCX5FJYFDbWFcLw7IwGkWz91Jj3VYb0k86nssy48ZN6FPshmOzrfEOeIWjcUrYP24bacHv9GDYUrwhgSZnHgmhw6vU8T@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4ArVGVCLRAqieUqTR6Suu+1ayzdj85Ql9aWM+D4St8J7CmOu
	bnGo2OBdhGPvlmduXoQhgM/FDaVSNH2DN/FE8R0MVuU3O7foLiXx
X-Google-Smtp-Source: AGHT+IH6uQJwX/9TDYPKTrazkkgRvjVLnnInMuZp4PL9jQiO9hx/uNZvRY+Qr3dWvu1BvauGDCwkmQ==
X-Received: by 2002:a05:600c:4453:b0:426:4978:65f0 with SMTP id 5b1f17b1804b1-42acc8dd846mr86482815e9.18.1724709707327;
        Mon, 26 Aug 2024 15:01:47 -0700 (PDT)
Received: from krava (i68970762.versanet.de. [104.151.7.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373082096bbsm11577786f8f.89.2024.08.26.15.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 15:01:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 27 Aug 2024 00:01:44 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Tianyi Liu <i.pear@outlook.com>,
	andrii.nakryiko@gmail.com, mhiramat@kernel.org, ajor@meta.com,
	albancrequy@linux.microsoft.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <Zsz7SPp71jPlH4MS@krava>
References: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
 <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240825171417.GB3906@redhat.com>
 <20240825224018.GD3906@redhat.com>
 <ZsxTckUnlU_HWDMJ@krava>
 <20240826115752.GA21268@redhat.com>
 <ZsyHrhG9Q5BpZ1ae@krava>
 <20240826212552.GB30765@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826212552.GB30765@redhat.com>

On Mon, Aug 26, 2024 at 11:25:53PM +0200, Oleg Nesterov wrote:
> This is offtopic, sorry for the spam, but...
> 
> On 08/26, Jiri Olsa wrote:
> >
> > On Mon, Aug 26, 2024 at 01:57:52PM +0200, Oleg Nesterov wrote:
> > >
> > > Does bpftrace use bpf_uprobe_multi_link_attach/etc ? I guess not...
> > > Then which userspace tool uses this code? ;)
> >
> > yes, it will trigger if you attach to multiple uprobes, like with your
> > test example with:
> >
> >   # bpftrace -p xxx -e 'uprobe:./ex:func* { printf("%d\n", pid); }'
> 
> Hmm. I reserved the testing machine with fedora 40 to play with bpftrace.
> 
> dummy.c:
> 
> 	#include <unistd.h>
> 
> 	void func1(void) {}
> 	void func2(void) {}
> 
> 	int main(void) { for (;;) pause(); }
> 
> If I do
> 
> 	# ./dummy &
> 	# bpftrace -p $! -e 'uprobe:./dummy:func* { printf("%d\n", pid); }'
> 
> and run
> 
> 	# bpftrace -e 'kprobe:__uprobe_register { printf("%s\n", kstack); }'

did you just bpftrace-ed bpftrace? ;-) on my setup I'm getting:

[root@qemu ex]# ../bpftrace/build/src/bpftrace -e 'kprobe:uprobe_register { printf("%s\n", kstack); }'
Attaching 1 probe...

        uprobe_register+1
        bpf_uprobe_multi_link_attach+685
        __sys_bpf+9395
        __x64_sys_bpf+26
        do_syscall_64+128
        entry_SYSCALL_64_after_hwframe+118


I'm not sure what's bpftrace version in fedora 40, I'm using upstream build:

[root@qemu ex]# ../bpftrace/build/src/bpftrace --info 2>&1 | grep uprobe_multi
  uprobe_multi: yes
[root@qemu ex]# ../bpftrace/build/src/bpftrace --version
bpftrace v0.20.0


jirka

> 
> on another console I get
> 
> 	Attaching 1 probe...
> 
>         __uprobe_register+1
>         probe_event_enable+399
>         perf_trace_event_init+440
>         perf_uprobe_init+152
>         perf_uprobe_event_init+74
>         perf_try_init_event+71
>         perf_event_alloc+1681
>         __do_sys_perf_event_open+447
>         do_syscall_64+130
>         entry_SYSCALL_64_after_hwframe+118
> 
>         __uprobe_register+1
>         probe_event_enable+399
>         perf_trace_event_init+440
>         perf_uprobe_init+152
>         perf_uprobe_event_init+74
>         perf_try_init_event+71
>         perf_event_alloc+1681
>         __do_sys_perf_event_open+447
>         do_syscall_64+130
>         entry_SYSCALL_64_after_hwframe+118
> 
> so it seems that bpftrace doesn't use bpf_uprobe_multi_link_attach()
> (called by sys_bpf(BPF_LINK_CREATE) ?) in this case.
> 
> But again, this is offtopic, please forget.
> 
> Oleg.
> 

