Return-Path: <bpf+bounces-32613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B9C9110B2
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 20:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A801C224C2
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 18:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6734E1B4C2A;
	Thu, 20 Jun 2024 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dc+WVvaX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4102B1B5823;
	Thu, 20 Jun 2024 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907596; cv=none; b=k/7j/x/TTHYl4ESLQXRXwSkNZySRQ2FiwXyo1HgUMrOpfEfzmpcwmCwj0QPJjyUm3hoKyNYC1ly1Kv5fJtF0sMCvRUWCN+XD9QqSs12G6svLvQu+qP+VtxhaBUali2fK0UNicHEbWeoSXfw5HEjlHKHfxhy+FmQfyZXs6FGnRz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907596; c=relaxed/simple;
	bh=9X7Yb+t8+3Mxvy5CM7jGXJM3QybL8bd6is6JbRcpKdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDNHoSQ6dlFy1Zl6v6tlsv7DQgZvnWSjo65Rn+52DyUapPtWa1KVxNxVU2TyQnRexRT0hv1FQp+c0EyvCvXSDlwidoRGS1i3W8sczZo/2DHw8ozyamJQ7efSJTmc6wSXfZcP43L9FGszjaf35QN9XSldKDgVPlfhIhnznmwbebU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dc+WVvaX; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c7dff0f4e4so1019649a91.2;
        Thu, 20 Jun 2024 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718907591; x=1719512391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OH6hJQ+sn/kbO3KU2buAh/pcNEoBmSwZPAIzDWFB4/k=;
        b=Dc+WVvaXygX4iqcPNpXaTi6iQwx8XSdKrLlViYqP49QjVFjrGapuUmWrr45hLCJ340
         LaXY+2oVHLlvZall0CNF9hwxp6vg1YzaHQTKSxfVAiLaXGLHHSfyF8q4dnkfF6sDuzax
         Ccd8n+QQT7rCWpLpxzwq6ssyOLnSRKrJMk1FKzexfHKwT6ibnfLdL5MK8dNkAqnDV9a1
         TjzpywqW8k71ai7+qwG515Nej1YfXXkmJ3+q1ozCpuHG0Lx52JurM6S67gG9Eg3GNGHK
         qz7PKHIUnmtbCbpF6ac9VrmlEA1PDffbn5qYtcQmC0ehdQxIJRUmyYesmyWNTmlgQTLo
         WFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718907591; x=1719512391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OH6hJQ+sn/kbO3KU2buAh/pcNEoBmSwZPAIzDWFB4/k=;
        b=oujRkBQZptEbsAJ7nYtjjufQUvzPd+p8nJHRfuyFRxIOHcEeXwtYKsAK1LDWNdahKO
         IzYRHPT6jRwwzl42tt0Q1gMdeTWQPSAWyNTPoTnv8iwoISFp3XdC1KAAfZ0495wZnjrV
         Pdun+7PBPy2EkoyoJvHrOP42wEwZnAqwmIRdRg5xALZhHPdFiPjZoF9nniRvlhQ9ecIg
         tRTqO8JAPLxxqO7vujOOoxvC8jHfmoA3fwyjS5dnTOaogg0RKzhHIbge3kpE5CUcZpPq
         cjs1tg7aqba+hQr0jBLh3AgVPbbmtXEBP9QxQKXPy/6gYkJ1vPnSqORNyuR4K49hJxIB
         AUKA==
X-Forwarded-Encrypted: i=1; AJvYcCXP0ANpEWXXYNR1pRf43CnfSn+1sD0aIZeAsOpRMvT0b/SSUnDsQ4KLqTBbldPkPjxOf5wGaATohwSlCWn9yukLRvhCEY4nEwSwbnpklyfnRqLEKaVb9Pkdxq41/MiYpwIxa1L77san+rFrXgE8+R50N+/9acuWFTDuNJdUeJtWBQAbo9E1fK0QuX5N8GC9w5JFWZZzdmcDdousat1+umay5uc4r8FO0TT9iBW5xvLl16VUDHPmOEKQK39g
X-Gm-Message-State: AOJu0YzhRwG1Wi9EPpoSx3M7kS9GWZE/4iUgOvkcfh5+uvnakFvNpHAE
	tGzWqFTohc647ikQxj3kTL2IPM2JzfkG0yg1XKq7QuCaYIfgn+QF
X-Google-Smtp-Source: AGHT+IEJA3R6HpM40sY7717r+oNnncawN97nPgYOxcxhaZ0yAJaeMHYl5mxvLf9tAEuiPTyq9VzBTg==
X-Received: by 2002:a17:90a:43a6:b0:2c4:e048:4bec with SMTP id 98e67ed59e1d1-2c7b5da4f97mr5623920a91.47.1718907591152;
        Thu, 20 Jun 2024 11:19:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e53e911asm2035714a91.13.2024.06.20.11.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 11:19:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 20 Jun 2024 11:19:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCHv8 bpf-next 3/9] uprobe: Add uretprobe syscall to speed up
 return probe
Message-ID: <054064c5-704a-4ea7-8a89-1e136e475437@roeck-us.net>
References: <20240611112158.40795-1-jolsa@kernel.org>
 <20240611112158.40795-4-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611112158.40795-4-jolsa@kernel.org>

On Tue, Jun 11, 2024 at 01:21:52PM +0200, Jiri Olsa wrote:
> Adding uretprobe syscall instead of trap to speed up return probe.
> 

This patch results in:

Building loongarch:allmodconfig ... failed
--------------
Error log:
In file included from include/linux/uprobes.h:49,
                 from include/linux/mm_types.h:16,
                 from include/linux/mmzone.h:22,
                 from include/linux/gfp.h:7,
                 from include/linux/xarray.h:16,
                 from include/linux/list_lru.h:14,
                 from include/linux/fs.h:13,
                 from include/linux/highmem.h:5,
                 from kernel/events/uprobes.c:13:
kernel/events/uprobes.c: In function 'arch_uprobe_trampoline':
arch/loongarch/include/asm/uprobes.h:12:33: error: initializer element is not constant
   12 | #define UPROBE_SWBP_INSN        larch_insn_gen_break(BRK_UPROBE_BP)
      |                                 ^~~~~~~~~~~~~~~~~~~~
kernel/events/uprobes.c:1479:39: note: in expansion of macro 'UPROBE_SWBP_INSN'
 1479 |         static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
      |                                       ^~~~~~~~~~~~~~~~

Bisect log attached.

Guenter

---
# bad: [2102cb0d050d34d50b9642a3a50861787527e922] Add linux-next specific files for 20240619
# good: [6ba59ff4227927d3a8530fc2973b80e94b54d58f] Linux 6.10-rc4
git bisect start 'HEAD' 'v6.10-rc4'
# good: [a8fa5261ec87d5aafd3211548d93008d5739457d] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good a8fa5261ec87d5aafd3211548d93008d5739457d
# good: [ee551f4db89753511a399b808db75654facec7c8] Merge branch 'for-linux-next' of https://gitlab.freedesktop.org/drm/i915/kernel
git bisect good ee551f4db89753511a399b808db75654facec7c8
# bad: [ec3557f4b791d72d93bfb69702d441d2c9f8cd0d] Merge branch 'next' of git://git.kernel.org/pub/scm/virt/kvm/kvm.git
git bisect bad ec3557f4b791d72d93bfb69702d441d2c9f8cd0d
# good: [29e7873afb5768f7af65802d021ee0c9bf2167be] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
git bisect good 29e7873afb5768f7af65802d021ee0c9bf2167be
# good: [ffe376e4a4ec29bb29d97664b72ff607e86f5b02] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect good ffe376e4a4ec29bb29d97664b72ff607e86f5b02
# bad: [39264a48da368f5394289133802f7d105dd3a33c] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
git bisect bad 39264a48da368f5394289133802f7d105dd3a33c
# good: [8af40c77dfe215cb8ad60c221d8eb740b056460b] Merge ftrace/for-next
git bisect good 8af40c77dfe215cb8ad60c221d8eb740b056460b
# bad: [5dfebf3c26dc5fe0fe08a5b4f334922b650e43b9] Merge ring-buffer/for-next
git bisect bad 5dfebf3c26dc5fe0fe08a5b4f334922b650e43b9
# bad: [9172a2da3b4162b5af0d2b57a30e844c451e74b7] Merge probes/for-next
git bisect bad 9172a2da3b4162b5af0d2b57a30e844c451e74b7
# bad: [29edd8b003db897d81d82d950785327f164650d3] selftests/x86: Add return uprobe shadow stack test
git bisect bad 29edd8b003db897d81d82d950785327f164650d3
# good: [1b3c86eeea7594eeeb49b8d1c1db0a40f0ce7920] samples: kprobes: add missing MODULE_DESCRIPTION() macros
git bisect good 1b3c86eeea7594eeeb49b8d1c1db0a40f0ce7920
# good: [190fec72df4a5d4d98b1e783c333f471e5e5f344] uprobe: Wire up uretprobe system call
git bisect good 190fec72df4a5d4d98b1e783c333f471e5e5f344
# bad: [ff474a78cef5cb5f32be52fe25b78441327a2e7c] uprobe: Add uretprobe syscall to speed up return probe
git bisect bad ff474a78cef5cb5f32be52fe25b78441327a2e7c
# first bad commit: [ff474a78cef5cb5f32be52fe25b78441327a2e7c] uprobe: Add uretprobe syscall to speed up return probe

