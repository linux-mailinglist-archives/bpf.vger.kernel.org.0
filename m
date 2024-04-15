Return-Path: <bpf+bounces-26761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 924738A4A3F
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 10:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40ACC1F26439
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 08:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBD1374E9;
	Mon, 15 Apr 2024 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5Kx8e0e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170B364CD;
	Mon, 15 Apr 2024 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169521; cv=none; b=DgrKZMK1hzoQ4r7kyAjsDIa9T6pTUyYjf87l72PFU1ejZFAMI7aUj9cNr0L38OiSWTlFBES/DBh6/foA/Kxa0vidtHF87DgHmlPa0HDe2yzFUXAbtSmNQ71drled0UJJ88JPJuCzKjLifAYw4haAPJRlb4/3f+1AWBFM4R61icw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169521; c=relaxed/simple;
	bh=1HzYf5lOHsdfN5KdFicmh6QcGO5toCRG2rpD8PAzJyE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWFRZ3WFUNQzZp0nfYpTof+eFyNBRMk6keXPwdxzfKnprdHYdd/sr2hIDtAWhxuQktC0aDpc+TQFnS2gLjd+/yot5ELtlIPG6GH+ex2kr8P3u3EtRLUZY9w+jC3nSzkbdvnCct0qvKqEzDq3YgBhcQLJMndT6fysWf707XuDdAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5Kx8e0e; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a523dad53e0so336818166b.1;
        Mon, 15 Apr 2024 01:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713169518; x=1713774318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=svrY0WgOVENQcdqQ696Y1VOfpDVgzQN8fSQil0UQPzM=;
        b=c5Kx8e0eS7U6QJDT/PMj3Tk3VDlZlUhW29sS845m5voogmdOHbWRFnRzRwFU9eYsW8
         sCe1J0aDa15gB4L2XtZ2Jtw7gEwcDc5wND4TCk+KftDvaOxQKMSIzYPYxT6UMmwq1lA+
         +BQev3u99zBUNv+L5KGr91rV91u826kre3JMJoA4ddWHG58+B1yQjOPEA4WFDvx0TuaI
         r9Eq+Gg90BvUxQf1Iy7TfoddjiATAYsE/ldE7KBamva5AEKaBIy8Mry8KR2KFpis9Fnj
         lDkmqEY5eP/Ez0VosJN4zodHxhLbkfvEKFLn2uVWTcLwZsalRrjkQMj/qjMCpqCjORk0
         d+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713169518; x=1713774318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svrY0WgOVENQcdqQ696Y1VOfpDVgzQN8fSQil0UQPzM=;
        b=Mncq71nnoUYOTIQQDSlSQXh3OPSOkluTBfB+P/bd0iO9UHXAHl2FHkbdhjwu8neHWg
         lagQpBwxzVPJ8lRMLRAVMzKhwVK8M1SLexHXjSwmdU+hcGUJTjJFC/XRsh0g6z5qkvd4
         9bgeSQfnDLn9V6BTi+2KxtsoFxTwRVOKG1RcnuBq/6cXoIlI0H5hrTlbZml5DwKFU6qu
         oDv7arje9o0MBjWSckJD10A5j8rQOXT1oiLx1SQmAiUPK9pe81aydKht70qlxtVQlPBD
         ohEbWgcnniuLRhAXPjcnSIqKQI+cQGtyKtGMnq6Yarx+cFCPmkvTKP8kSHZ0Cd3joGV8
         LgWA==
X-Forwarded-Encrypted: i=1; AJvYcCVGkbzVqkYic/JPbUfvHTq9tIpiFj9SsXU9bLvK3mlUqYPxb9fwCnAZrPwiOiQPk0Jvny+C3R0czhs9mv0vQtvgkooowpyUvyotQe/94s+ouAUzgCuw4YiVE9CxXoen/6vDdwGGAag6
X-Gm-Message-State: AOJu0YxMip6iwzLL2+xyKiHwJ04jErhvCFScwj0Po9yxq1JpWNPNGn2i
	s5yPjGjRe66jmZgpFFTRlvBKQNBCFQqWjGbOF7PhSwxN64FE/6NY
X-Google-Smtp-Source: AGHT+IFWmjtV57uLaXtPRIKWXxLTTlehAo1wJ+uMIHVEpihib60OiiitkAPRFOrAg6PEuiSXIuqTnQ==
X-Received: by 2002:a17:906:510:b0:a52:71d6:d605 with SMTP id j16-20020a170906051000b00a5271d6d605mr859683eja.23.1713169518061;
        Mon, 15 Apr 2024 01:25:18 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id i19-20020a170906115300b00a526a992d82sm1045266eja.4.2024.04.15.01.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 01:25:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 15 Apr 2024 10:25:16 +0200
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return
 probe
Message-ID: <ZhzkbN7DWq6Tzp5G@krava>
References: <20240402093302.2416467-1-jolsa@kernel.org>
 <20240402093302.2416467-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402093302.2416467-2-jolsa@kernel.org>

On Tue, Apr 02, 2024 at 11:33:00AM +0200, Jiri Olsa wrote:

SNIP

>  #include <linux/kdebug.h>
>  #include <asm/processor.h>
> @@ -308,6 +309,88 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
>  }
>  
>  #ifdef CONFIG_X86_64
> +
> +asm (
> +	".pushsection .rodata\n"
> +	".global uretprobe_syscall_entry\n"
> +	"uretprobe_syscall_entry:\n"
> +	"pushq %rax\n"
> +	"pushq %rcx\n"
> +	"pushq %r11\n"
> +	"movq $" __stringify(__NR_uretprobe) ", %rax\n"
> +	"syscall\n"
> +	"popq %r11\n"
> +	"popq %rcx\n"
> +
> +	/* The uretprobe syscall replaces stored %rax value with final
> +	 * return address, so we don't restore %rax in here and just
> +	 * call ret.
> +	 */
> +	"retq\n"
> +	".global uretprobe_syscall_end\n"
> +	"uretprobe_syscall_end:\n"
> +	".popsection\n"
> +);
> +
> +extern u8 uretprobe_syscall_entry[];
> +extern u8 uretprobe_syscall_end[];
> +
> +void *arch_uprobe_trampoline(unsigned long *psize)
> +{
> +	*psize = uretprobe_syscall_end - uretprobe_syscall_entry;
> +	return uretprobe_syscall_entry;

fyi I realized this screws 32-bit programs, we either need to add
compat trampoline, or keep the standard breakpoint for them:

+       struct pt_regs *regs = task_pt_regs(current);
+       static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
+
+       if (user_64bit_mode(regs)) {
+               *psize = uretprobe_syscall_end - uretprobe_syscall_entry;
+               return uretprobe_syscall_entry;
+       }
+
+       *psize = UPROBE_SWBP_INSN_SIZE;
+       return &insn;


not sure it's worth the effort to add the trampoline, I'll check


jirka

