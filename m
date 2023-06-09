Return-Path: <bpf+bounces-2262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B11972A4CA
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 22:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B652281A5B
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 20:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90A11548C;
	Fri,  9 Jun 2023 20:38:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77C7408C9
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 20:38:05 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7917330C8;
	Fri,  9 Jun 2023 13:38:03 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-650c89c7e4fso2298172b3a.0;
        Fri, 09 Jun 2023 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686343083; x=1688935083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4QbmTscgL0W4LNSr/7q9vHr3/nK0DxnmRxkiPOyTnLw=;
        b=UPhpET1va9qipboE/8cau9bR3DIRjMvfr1w4qvTl2rexd1cpITZ+sdPHjkYag7SmZH
         Sx4jSVMmVPAvwvR7iG0MMjrC3jfUGGFs8EpwgU5Qljm0idreDw6J6xOLB5TxhaNHXV76
         G5SSCxF3zK/jG2hyCoqawCMCQKAnS5wqX6A+nXHTIGHt3KtUEI5ANpYYsS5fQSNhWoKN
         JQwjpNsQQCvHpzG4oPJlRF5OzVo7zRKUzM/2MUJnqHac/n+X+qyPlCAByHgsuGfUXxf8
         7b9XPCwIVZAZRvExJzEdLx7qgSkfIWdUZFBr7qW4P89bOMxKljMNXVgxk3r+7FGQPswz
         lyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686343083; x=1688935083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4QbmTscgL0W4LNSr/7q9vHr3/nK0DxnmRxkiPOyTnLw=;
        b=Yz0yRFampe4waQRHmU1dUMk60EXi+0vS8MbXaEr2+qKSNzBFrO2KoQcHPkmrVvH121
         P6wtiv7HsFQI3pVHbQtcseAez5MeOK74IMvq8HT6IYtLTtgQPA5pYSB5FSwQxAPyBZ1I
         lzqECdTBl9ZIHYUpIFLwgYqINvbd0PPvksjAGpG4KsofP0tp9a2Jxn7R6WIelQaIJ2iA
         NJFP1xJsR9Xjl0xGmc5TJSvbAxybBysAbb7xjz4lay5g4uDQx7iPUQ2i90jxBNyZIk41
         g2u49llqeb5ePNBny3UyzsvwoFV1/vFOVGvwSVMFqupoKw/5STMp2aobSp3RLaP8Ywr8
         h0RQ==
X-Gm-Message-State: AC+VfDyrYOslfp2cgtBpv0RRmFhl2/KS7B5K8Qj21uC9bnWCcs3FL5BG
	ppOlBW80vzQuZ7XuxN2ng4Y3D47nkmg=
X-Google-Smtp-Source: ACHHUZ7FXyMXhhyVc1ZQ6Dw3Um1qtKihPVk19SWQD+nko2L8uExkP/Clrxvh0ZFZydDCAdMQMQ22kQ==
X-Received: by 2002:a05:6a00:24c9:b0:64d:4412:9923 with SMTP id d9-20020a056a0024c900b0064d44129923mr2899985pfv.3.1686343082568;
        Fri, 09 Jun 2023 13:38:02 -0700 (PDT)
Received: from krava (c-67-160-222-115.hsd1.ca.comcast.net. [67.160.222.115])
        by smtp.gmail.com with ESMTPSA id p18-20020aa78612000000b006414b2c9efasm3034301pfn.123.2023.06.09.13.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:38:02 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 9 Jun 2023 13:37:59 -0700
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Jackie Liu <liu.yun@linux.dev>
Subject: Re: [PATCH RFC] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
Message-ID: <ZIONp3IDiBe+WdeB@krava>
References: <20230608212613.424070-1-jolsa@kernel.org>
 <CAEf4BzbNakGzcycJJJqLsFwonOmya8=hKLD41TWX2zCJbh=r-Q@mail.gmail.com>
 <20230608192748.435a1dbf@gandalf.local.home>
 <CAEf4BzYkNHu7hiMYWQWs_gpYOfHL0FVuf-O0787Si2ze=PFX5w@mail.gmail.com>
 <ZILhqvrjeFIPHauy@FVFF77S0Q05N>
 <ZINW9FqIoja76DRa@krava>
 <CAEf4BzbgsLOoLKyscq6S95QeehVoAzOnQ=xmsFz8dfEUAnhObw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbgsLOoLKyscq6S95QeehVoAzOnQ=xmsFz8dfEUAnhObw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 09, 2023 at 11:29:59AM -0700, Andrii Nakryiko wrote:
> On Fri, Jun 9, 2023 at 9:44 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Fri, Jun 09, 2023 at 09:24:10AM +0100, Mark Rutland wrote:
> > > On Thu, Jun 08, 2023 at 04:55:40PM -0700, Andrii Nakryiko wrote:
> > > > On Thu, Jun 8, 2023 at 4:27 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > > > On Thu, 8 Jun 2023 15:43:03 -0700 Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > > > > On Thu, Jun 8, 2023 at 2:26 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > > There are BPF tools that allow user to specify regex/glob of kernel
> > > > functions to attach to. This regex/glob is checked against
> > > > available_filter_functions to check which functions are traceable. All
> > > > good. But then also it's important to have corresponding memory
> > > > addresses for selected functions (for many reasons, e.g., to have
> > > > non-ambiguous and fast attachment by address instead of by name, or
> > > > for some post-processing based on captured IP addresses, etc). And
> > > > that means that now we need to also parse /proc/kallsyms and
> > > > cross-join it with data fetched from available_filter_functions.
> > > >
> > > > All this is unnecessary if avalable_filter_functions would just
> > > > provide function address in the first place. It's a huge
> > > > simplification. And saves memory and CPU.
> > >
> > > Do you need the address of the function entry-point or the address of the
> > > patch-site within the function? Those can differ, and the rec->ip address won't
> > > necessarily equal the address in /proc/kallsyms, so the pointer in
> > > /proc/kallsyms won't (always) match the address we could print for the ftrace site.
> > >
> > > On arm64, today we can have offsets of +0, +4, and +8, and within a single
> > > kernel image different functions can have different offsets. I suspect in
> > > future that we may have more potential offsets (e.g. due to changes for HW/SW
> > > CFI).
> >
> > so we need that for kprobe_multi bpf link, which is based on fprobe,
> > and that uses ftrace_set_filter_ips to setup the ftrace_ops filter
> >
> > and ftrace_set_filter_ips works fine with ip address being the address
> > of the patched instruction (it's matched in ftrace_location)
> >
> > but right, I did not realize this.. it might cause confusion if people
> > don't know it's patch-side addresses..  not sure if there's easy way to
> > get real function address out of rec->ip, but it will also get more
> > complicated on x86 when IBT is enabled, will check
> 
> ok, sorry, I'm confused. Two questions:
> 
> 1. when attaching kprobe_multi, does bpf() syscall expect function
> address or (func+offset_of_mcount) address? I hope it's the former,
> just function's address?

it can be both, the fprobe/ftrace filter setup will take care of looking
up and translating the provided address to the patch-side address

> 
> 2. If rec->ip is not function's address, can we somehow adjust the
> value to be a function address before printing it?

that's tricky because on x86 with IBT we would need to read the first
instruction and check if it's endbr to get the real address, like we
do in get_entry_ip:

	#ifdef CONFIG_X86_KERNEL_IBT
	static unsigned long get_entry_ip(unsigned long fentry_ip)
	{
		u32 instr;

		/* Being extra safe in here in case entry ip is on the page-edge. */
		if (get_kernel_nofault(instr, (u32 *) fentry_ip - 1))
			return fentry_ip;
		if (is_endbr(instr))
			fentry_ip -= ENDBR_INSN_SIZE;
		return fentry_ip;
	}
	#else
	#define get_entry_ip(fentry_ip) fentry_ip
	#endif


I'm not familiar with arm implementation, so I'm not sure if there's
a way to do this

but in any case Steven wants to keep the patch-side address:
  https://lore.kernel.org/bpf/CAEf4BzbgsLOoLKyscq6S95QeehVoAzOnQ=xmsFz8dfEUAnhObw@mail.gmail.com/T/#m19a97bbc8f8236ad869c9f8ad0cc7dbce0722d92

jirka

> 
> In short, I think it's confusing to have addresses with +0 or +4 or +8
> offsets. It would be great if we can just keep it +0 at the interface
> level (when attach and in available_filter_functions_addrs).
> 
> >
> > or we could just use patch-side addresses and reflect that in the file's
> > name like 'available_filter_functions_patch_addrs' .. it's already long
> > name ;-)
> >
> > jirka

