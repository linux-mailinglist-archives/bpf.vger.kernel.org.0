Return-Path: <bpf+bounces-41545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712BD99809A
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 10:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 779DDB27527
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 08:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3EB1E8845;
	Thu, 10 Oct 2024 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V6GGARyi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E9B1E8828
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549050; cv=none; b=gaApT4ZGe8iztUdw5HSgB6wNOOSkOOESrqhOnqAijQABgstIR2ToVYnO7IW7eQG3I5iokKw90SMNczM/m+Y97YTXxQsC/Xwg2Py0QFfDJbRRGTLHb6phGMFnxC6+kscOPz7daALrrsxxjp2ZoXqRKtmTpQNDDerJhfbE6bwwuPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549050; c=relaxed/simple;
	bh=ciGEzLPrN7XbFB5cK/viPY+fgmysJA4dkt9WpJTF0yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8TBwOqox0yKjvzq6vfW/sVEOcH4IMVorGz4rFKja44E6WWxD6CWzojwCB8JrYNYqEhWxHFmbmdPymeubwnMf2kaTM8DPTwMXiOlGpQrX1KK6ZgnS+JVpZ1QO8dGFKIbX4jRG/ni/oWKCRoau47Jzte8Ysd/BQ2MjDedFeqIPuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V6GGARyi; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2a0a7c035so579731a91.0
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 01:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728549047; x=1729153847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjRgM2erkgK9qh8AbT3u9Jz1xqlQ+SHokymxxsnkwPs=;
        b=V6GGARyi90X+B17khH8hgRXfkBE9ec0tP9aPBognNcsNGhdlAyv2TpWda74Rrygr43
         wm/TFHucQh7st1/A3E0U/wGDw06wEopcR47DAwsyoGCllaHrH5KtzktV31CtVJ2punOw
         q/WMnORmUlcaLeudv40KSjAkX+bc+k5zSVRLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728549047; x=1729153847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjRgM2erkgK9qh8AbT3u9Jz1xqlQ+SHokymxxsnkwPs=;
        b=E+VYNAsw97/7Eq3IyiEUln3fk18WO6vNgSBt+DL9pY+a4bD5RRnpe8PdJLAxkJJjso
         rIs+8FABPAVu3M9ZeX/YDgSNjYE6m8CVutKeTSPymLSHnr5JbHhNXez3TUJg38ggamrW
         xZRX+ZvSD5CwVhhN55EZYlAwTUI5+0//8yi0VRjn238nq1PjICz9gp4d5Sz8dCl0HHk0
         d7z+mdlZdCVJtbd6E0KJG5zjLMKhTYa76ozEMzH/QfxTcQh2Gw/QNeGsV9NbqXLSV89D
         Ksu39dzC48lqKw+w4mfl2ejwiXJEeevKTfSgjp08/yGC254gJZ92WFoQDY5pJ1KEqcL8
         bpUw==
X-Forwarded-Encrypted: i=1; AJvYcCWK2wErix8P807sQ97F+H5DMiqUbkhAoIkqvvPnUk1JU6WIblkRCtqCW7w5RyhxtJ3J3a0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw30AgHRMyaeiEr8kRwgQ60oFEcQ/FLN3UG6HwRVmGWv9nU1L5e
	C0BNgbkpT8OhIT8jjEEiQ8N4Zmg6z4VG5Ul+Q28YS14WXptganeQ8mmrORWIkg==
X-Google-Smtp-Source: AGHT+IGiHJLVn7EEJZoiHDg1IHJwEmo5BKI2W3X+EqMqHJDA19Xi8bq+M3epyy60EICvZVegJa7iQQ==
X-Received: by 2002:a17:90a:178e:b0:2e2:cc47:ce1a with SMTP id 98e67ed59e1d1-2e2cc47ce65mr2245610a91.1.1728549047177;
        Thu, 10 Oct 2024 01:30:47 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:c13a:abb0:1c8:a3c3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5f0a424sm730808a91.28.2024.10.10.01.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:30:46 -0700 (PDT)
Date: Thu, 10 Oct 2024 17:30:33 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Bisected: [PATCH v5 8/8] x86/module: enable ROX caches for module
 text
Message-ID: <20241010083033.GA1279924@google.com>
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-9-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009180816.83591-9-rppt@kernel.org>

On (24/10/09 21:08), Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Enable execmem's cache of PMD_SIZE'ed pages mapped as ROX for module
> text allocations.
> 

With this modprobe disappoints kmemleak

[   12.700128] kmemleak: Found object by alias at 0xffffffffa000a000
[   12.702179] CPU: 5 UID: 0 PID: 410 Comm: modprobe Tainted: G                 N 6.12.0-rc2+ #760
[   12.704656] Tainted: [N]=TEST
[   12.705526] Call Trace:
[   12.706250]  <TASK>
[   12.706888]  dump_stack_lvl+0x3e/0xdb
[   12.707961]  __find_and_get_object+0x100/0x110
[   12.709256]  kmemleak_no_scan+0x2e/0xb0
[   12.710354]  kmemleak_load_module+0xad/0xe0
[   12.711557]  load_module+0x2391/0x45a0
[   12.712507]  __se_sys_finit_module+0x4e0/0x7a0
[   12.713599]  do_syscall_64+0x54/0xf0
[   12.714477]  ? irqentry_exit_to_user_mode+0x33/0x100
[   12.715696]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   12.716931] RIP: 0033:0x7fc7af51f059
[   12.717816] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   12.722324] RSP: 002b:00007ffc1d0b0c18 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   12.724173] RAX: ffffffffffffffda RBX: 00005618a9439b20 RCX: 00007fc7af51f059
[   12.725884] RDX: 0000000000000000 RSI: 000056187aea098b RDI: 0000000000000003
[   12.727617] RBP: 0000000000000000 R08: 0000000000000060 R09: 00005618a943af60
[   12.729361] R10: 0000000000000038 R11: 0000000000000246 R12: 000056187aea098b
[   12.731101] R13: 0000000000040000 R14: 00005618a9439ac0 R15: 0000000000000000
[   12.732814]  </TASK>
[   12.733362] kmemleak: Object 0xffffffffa0000000 (size 2097152):
[   12.734800] kmemleak:   comm "modprobe", pid 410, jiffies 4294880489
[   12.736334] kmemleak:   min_count = 2
[   12.737228] kmemleak:   count = 0
[   12.738043] kmemleak:   flags = 0x5
[   12.738917] kmemleak:   checksum = 0
[   12.739783] kmemleak:   backtrace:
[   12.740606]  kmemleak_vmalloc+0x29/0xc0
[   12.741532]  kasan_alloc_module_shadow+0xbe/0xe0
[   12.742649]  execmem_vmalloc+0x116/0x220
[   12.743596]  execmem_alloc+0xfb/0x3d0
[   12.744479]  load_module+0x1e84/0x45a0
[   12.745383]  __se_sys_finit_module+0x4e0/0x7a0
[   12.746452]  do_syscall_64+0x54/0xf0
[   12.747319]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   12.748772] kmemleak: Not scanning unknown object at 0xffffffffa000a000
[   12.750364] CPU: 5 UID: 0 PID: 410 Comm: modprobe Tainted: G                 N 6.12.0-rc2+ #760
[   12.752441] Tainted: [N]=TEST
[   12.753165] Call Trace:
[   12.753760]  <TASK>
[   12.754279]  dump_stack_lvl+0x3e/0xdb
[   12.755165]  kmemleak_load_module+0xad/0xe0
[   12.756165]  load_module+0x2391/0x45a0
[   12.757068]  __se_sys_finit_module+0x4e0/0x7a0
[   12.758135]  do_syscall_64+0x54/0xf0
[   12.759099]  ? irqentry_exit_to_user_mode+0x33/0x100
[   12.760292]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   12.761508] RIP: 0033:0x7fc7af51f059
[   12.762372] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   12.772361] RSP: 002b:00007ffc1d0b0c18 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   12.774957] RAX: ffffffffffffffda RBX: 00005618a9439b20 RCX: 00007fc7af51f059
[   12.776635] RDX: 0000000000000000 RSI: 000056187aea098b RDI: 0000000000000003
[   12.778283] RBP: 0000000000000000 R08: 0000000000000060 R09: 00005618a943af60
[   12.779949] R10: 0000000000000038 R11: 0000000000000246 R12: 000056187aea098b
[   12.781619] R13: 0000000000040000 R14: 00005618a9439ac0 R15: 0000000000000000
[   12.783319]  </TASK>

