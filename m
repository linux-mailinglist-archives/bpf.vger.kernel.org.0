Return-Path: <bpf+bounces-64564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC94B143E9
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 23:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E0218C0CAC
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 21:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B27274671;
	Mon, 28 Jul 2025 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B84l7tIG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8347D235055;
	Mon, 28 Jul 2025 21:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753738503; cv=none; b=n4ENnCt30ofv7YhXHOdmXdYQNWazVkrueTE8ZBDdWgCedgctri1ONXoR0/G9F9ImRnqqF79mKIPrLN40RH6bu3tvDsaAqF+M1LtGToyDn3RkKearsWkwt+Oz26RenZY4r5CGdo5ymEIlaYuXg+TKWdptyM65pcMhVCUVHZw3krg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753738503; c=relaxed/simple;
	bh=SEhe9b0vm/AdOxyaJpILo6f605w6Ak2F8v9E8gDBsfU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIT+K88YDqXimj86vwtY7ywRVBu6DV7gtl69BPdNK8O3fMCUcYGRjei5LKvckOAm+RXF/j9E8eLACzDqxW9Bq672B+Lm/h0kkQaTiwVLC8WBgE7TuvIIgTwCSMiZlNLqmOU0FfiOUKgbovteoR0Ue+fDGfgvEhu8CFPiURWScNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B84l7tIG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b7834f2e72so1400493f8f.2;
        Mon, 28 Jul 2025 14:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753738500; x=1754343300; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ybZ2ooGUwXrsUwDkpZ5EZxx8GK7pJ4GgU7lFxlvYUwU=;
        b=B84l7tIG7pBj/RidmIqakr4ZeBemS/kUNrr5tuvycMuWh0ARKONm69FZeQmNUnXR33
         EevvWskM5EaNpeu/poHGj27kC7Mc/9gWVD8V5rnJipBKOtV4lO1ISWaaQjyBfDiSFXjJ
         EmXkQwGJCuSHz0rPPlN/Idk0pU1TOEizujRBV1KOYFR4A53C2inkO1BmMM8QgF6JAN2d
         ksX9bSMMPMesXkBO14ReaN8kWCP5VIgWXcpLtOG5NZY5ZSc0YT+ffk/QXP7ujOamlRip
         GAoo0cJctztFNlWfF/ImtGPoJco6zZMQIboGxjjwzmKYN+QP3vMbcQH+k1VKSm/UhJEH
         B0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753738500; x=1754343300;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybZ2ooGUwXrsUwDkpZ5EZxx8GK7pJ4GgU7lFxlvYUwU=;
        b=XG5FVmUfOpbSVuSwqaqYe8yv+XyGRYW4aKEBSOCyVOYuBZ/YNoImrM3t7N3V+onaae
         GILxJhM+/JzTCs3sOjZjAjUDp1vcpf72ax/6UgoTvwztGF82JESD8cK/ZpJA7XZl7oYk
         mgVrePfAZoXFjC84kPg/1TVFv7i/BPcflchCQLw2qAMc0WmYvw+knOwa7LsV1RIYPWIU
         +n5tNok5TFOBgF2oc7m2NOnnVLbH3HjG0ZyiF4ko3CEZ/AKV7rGIKpJ2Vzi9TOjgvI0q
         qbICe5LU88c4vOAEgFGQCLc1hR8wNztKCVOMa0wlQOjjnyyr48nJuHlzGxIolF2ttFN9
         jgmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF1S3KThqyRikePO/iM6HvmWWqjHUQhqrk9kUlhWCPHxw+0lZwqABt2zHvkLge7c8lPPw=@vger.kernel.org, AJvYcCUH8tdm1oelYkxbf5QAMlCi9+x/w6omP9nI1f4fuimbTQl6Im90ZCqLCXYjYDJt8kA+Xayt8hZs+K6piKJG@vger.kernel.org, AJvYcCX+/t7sLLu8vG/snbLOgnOxcKVFuLC7wtj419s2pInC8/hbHA15GRNl835f/o3LE5eF4c8LRajYk4fHT1ohUArfPuXK@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7GPe8HePPvjPfNskLpybXUr+NfvpPoD4Au1Qw43mL2JovfDj
	0jIyTTHA0ZbW551jNWTXeDNuCzoDzqJmoag3lwNOyuym/M/oKWjXRGR0
X-Gm-Gg: ASbGncvhtKoMiDa7TnaF77rTAEThJcwOYmTw2juBAfYKpKhU3wCq1OV6ZqIYYNgnbHi
	Q89iKcSWgFX1yqJGZjJob2BYT52X6Xb6cl88IXjB7ScJhoqq+bvHHh8y/7aBGuqaEyVtmhmM3R2
	tEHpJ95MScrPHuMIWb6OxF7dIpRpTsCUnt4KUSFIsiR7ai58qBBEzS4aQMt/Clg7jlkBzKgYDiA
	5I4BxacoTmpNXgT0WYd5AaN/AYNicU+XPz7E4OhgI36bMTn4771WU2CMNnC44LdARrULi/7xYlb
	c3vmJ5Ec8CyPgLyN+6OFQEeLcwFIPAfQ5ceJHMA8koT7BVaeSVwUGiy/E4gBnNk7clcc1jFsCmp
	n5LNRmvG6uGQVfQggfTuY
X-Google-Smtp-Source: AGHT+IG/+3lZwfgWo9IUleQbr+IcSEKBYntBQmSRuyUuDrYluDZmYGcJO90j3Rvn6JA7IcpLOqQWiA==
X-Received: by 2002:a05:6000:40c9:b0:3b7:879c:c15c with SMTP id ffacd0b85a97d-3b7879cca06mr4446572f8f.47.1753738499526;
        Mon, 28 Jul 2025 14:34:59 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705bccc5sm168755115e9.22.2025.07.28.14.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 14:34:59 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 28 Jul 2025 23:34:56 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv6 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <aIftAJg1hZGYp4NF@krava>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-11-jolsa@kernel.org>
 <20250725191318.554f2f3afe27584e03a0eaa2@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250725191318.554f2f3afe27584e03a0eaa2@kernel.org>

On Fri, Jul 25, 2025 at 07:13:18PM +0900, Masami Hiramatsu wrote:
> On Sun, 20 Jul 2025 13:21:20 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Putting together all the previously added pieces to support optimized
> > uprobes on top of 5-byte nop instruction.
> > 
> > The current uprobe execution goes through following:
> > 
> >   - installs breakpoint instruction over original instruction
> >   - exception handler hit and calls related uprobe consumers
> >   - and either simulates original instruction or does out of line single step
> >     execution of it
> >   - returns to user space
> > 
> > The optimized uprobe path does following:
> > 
> >   - checks the original instruction is 5-byte nop (plus other checks)
> >   - adds (or uses existing) user space trampoline with uprobe syscall
> >   - overwrites original instruction (5-byte nop) with call to user space
> >     trampoline
> >   - the user space trampoline executes uprobe syscall that calls related uprobe
> >     consumers
> >   - trampoline returns back to next instruction
> > 
> > This approach won't speed up all uprobes as it's limited to using nop5 as
> > original instruction, but we plan to use nop5 as USDT probe instruction
> > (which currently uses single byte nop) and speed up the USDT probes.
> > 
> > The arch_uprobe_optimize triggers the uprobe optimization and is called after
> > first uprobe hit. I originally had it called on uprobe installation but then
> > it clashed with elf loader, because the user space trampoline was added in a
> > place where loader might need to put elf segments, so I decided to do it after
> > first uprobe hit when loading is done.
> > 
> > The uprobe is un-optimized in arch specific set_orig_insn call.
> > 
> > The instruction overwrite is x86 arch specific and needs to go through 3 updates:
> > (on top of nop5 instruction)
> > 
> >   - write int3 into 1st byte
> >   - write last 4 bytes of the call instruction
> >   - update the call instruction opcode
> > 
> > And cleanup goes though similar reverse stages:
> > 
> >   - overwrite call opcode with breakpoint (int3)
> >   - write last 4 bytes of the nop5 instruction
> >   - write the nop5 first instruction byte
> > 
> > We do not unmap and release uprobe trampoline when it's no longer needed,
> > because there's no easy way to make sure none of the threads is still
> > inside the trampoline. But we do not waste memory, because there's just
> > single page for all the uprobe trampoline mappings.
> > 
> > We do waste frame on page mapping for every 4GB by keeping the uprobe
> > trampoline page mapped, but that seems ok.
> > 
> > We take the benefit from the fact that set_swbp and set_orig_insn are
> > called under mmap_write_lock(mm), so we can use the current instruction
> > as the state the uprobe is in - nop5/breakpoint/call trampoline -
> > and decide the needed action (optimize/un-optimize) based on that.
> > 
> > Attaching the speed up from benchs/run_bench_uprobes.sh script:
> > 
> > current:
> >         usermode-count :  152.604 ± 0.044M/s
> >         syscall-count  :   13.359 ± 0.042M/s
> > -->     uprobe-nop     :    3.229 ± 0.002M/s
> >         uprobe-push    :    3.086 ± 0.004M/s
> >         uprobe-ret     :    1.114 ± 0.004M/s
> >         uprobe-nop5    :    1.121 ± 0.005M/s
> >         uretprobe-nop  :    2.145 ± 0.002M/s
> >         uretprobe-push :    2.070 ± 0.001M/s
> >         uretprobe-ret  :    0.931 ± 0.001M/s
> >         uretprobe-nop5 :    0.957 ± 0.001M/s
> > 
> > after the change:
> >         usermode-count :  152.448 ± 0.244M/s
> >         syscall-count  :   14.321 ± 0.059M/s
> >         uprobe-nop     :    3.148 ± 0.007M/s
> >         uprobe-push    :    2.976 ± 0.004M/s
> >         uprobe-ret     :    1.068 ± 0.003M/s
> > -->     uprobe-nop5    :    7.038 ± 0.007M/s
> >         uretprobe-nop  :    2.109 ± 0.004M/s
> >         uretprobe-push :    2.035 ± 0.001M/s
> >         uretprobe-ret  :    0.908 ± 0.001M/s
> >         uretprobe-nop5 :    3.377 ± 0.009M/s
> > 
> > I see bit more speed up on Intel (above) compared to AMD. The big nop5
> > speed up is partly due to emulating nop5 and partly due to optimization.
> > 
> > The key speed up we do this for is the USDT switch from nop to nop5:
> >         uprobe-nop     :    3.148 ± 0.007M/s
> >         uprobe-nop5    :    7.038 ± 0.007M/s
> > 
> 
> This also looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

thanks!

Peter, do you have more comments?

thanks,
jirka

