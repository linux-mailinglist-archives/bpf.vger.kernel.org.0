Return-Path: <bpf+bounces-8808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A2578A132
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 21:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79DB41C2096D
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 19:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123CD14272;
	Sun, 27 Aug 2023 19:41:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D996B1401C
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 19:41:32 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C445A12E
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 12:41:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bcf2de59cso330758166b.0
        for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 12:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693165289; x=1693770089;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dtOReuCG2LtJLkXPBZy6w7ZugfLsBr/nQL1Exzye5GU=;
        b=n7YgV6+/nEe+PNrDk23EBtXJvDDNU0Hb463SEN5j8ZUetCL6rScYet10m0Yl9Z+Bde
         weDhz+IoDPP5VfYQkholj3zXBCmhFT4HmBSIOwSPCLFMiIoOBCIO64JsvEYg1eUmu7Fm
         LFOC77ONbKSwNgUeKMWwkgqxIZbeU3q+SJK+xytRz4NRHgkAxv+S041RdwO1QAspi9R0
         qaArqDV+uQF6e+h6FNZ0BlUYChtct+xKWxxjfIRDp4svBSfrhUOEbwWDEyZG+ooTG6kh
         w306AP1tP4ONK8Mz7FMWp3CJKZYOCLbLX/qzePUihArVALKf4RiJQ0+ZURKbW7kQUGVn
         HMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693165289; x=1693770089;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dtOReuCG2LtJLkXPBZy6w7ZugfLsBr/nQL1Exzye5GU=;
        b=EZNxoyn9/SbfbMJxizhsCO52Fxg+qlv9K4TjdlH6VpdGp/7m5oFpQCGL8nWrnnGt9C
         DdMUBXEP7IvrF+hbCUPL/DrShHZRU+79ODHssHRLpMfrP92eo1+d4N3qbWppzu/BY5yV
         haYTCrSbw244fDjacizstaWsMi7srWKy5LiUL8vif7e4PdrpElFAIwQRKTsHQQx0+fYS
         UcNQuTQchldJhiS8IhPVB9yecSdl92AeA7HpbjLOKo98lxnhrJoGWdhpQY1nNRo4tnJo
         +KaR3hK9XZlHkXJArjct28UH370oAzhCCXYyvRxPVvrgE+KDAQRbLd6yGmY+UIFQN5mg
         NrzA==
X-Gm-Message-State: AOJu0YzyclEVC6tVhV62xuasVnuS70XYJKOVDZhuHJTsQu5Es3ubh5Go
	OeyX2xhjiE/eq14fXoU1LHHMSjgSzRc=
X-Google-Smtp-Source: AGHT+IFuqSmkJLo+RTdqdoTG5olx7LlmPyAs+/AVl64S4Q9zFjqORp2696DtLCW63gWIrAkWkSCf7Q==
X-Received: by 2002:a17:907:2be0:b0:9a5:a247:5bbc with SMTP id gv32-20020a1709072be000b009a5a2475bbcmr1868830ejc.28.1693165288863;
        Sun, 27 Aug 2023 12:41:28 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id a1-20020a17090640c100b0099bcf9c2ec6sm3720828ejk.75.2023.08.27.12.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 12:41:28 -0700 (PDT)
Date: Sun, 27 Aug 2023 21:41:27 +0200
From: Nam Cao <namcaov@gmail.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
	bpf@vger.kernel.org, Hou Tao <houtao@huaweicloud.com>,
	yonghong.song@linux.dev,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: RISC-V uprobe bug (Was: Re: WARNING: CPU: 3 PID: 261 at
 kernel/bpf/memalloc.c:342)
Message-ID: <ZOum50Py8Vki+Nd3@nam-dell>
References: <87jztjmmy4.fsf@all.your.base.are.belong.to.us>
 <87v8d19aun.fsf@all.your.base.are.belong.to.us>
 <ZOpAjkTtA4jYtuIa@nam-dell>
 <87cyz8sy4y.fsf@all.your.base.are.belong.to.us>
 <ZOsKukBz8i+h4Y8j@nam-dell>
 <87y1hw7t5p.fsf@all.your.base.are.belong.to.us>
 <ZOsZtH+5P0/R6kvd@nam-dell>
 <87jztgwaur.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jztgwaur.fsf@all.your.base.are.belong.to.us>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Aug 27, 2023 at 09:20:44PM +0200, Björn Töpel wrote:
> Nam Cao <namcaov@gmail.com> writes:
> 
> > On Sun, Aug 27, 2023 at 11:04:34AM +0200, Björn Töpel wrote:
> >> Nam Cao <namcaov@gmail.com> writes:
> >> 
> >> > On Sun, Aug 27, 2023 at 10:11:25AM +0200, Björn Töpel wrote:
> >> >> The default implementation of is_trap_insn() which RISC-V is using calls
> >> >> is_swbp_insn(), which is doing what your patch does. Your patch does not
> >> >> address the issue.
> >> >
> >> > is_swbp_insn() does this:
> >> >
> >> >         #ifdef CONFIG_RISCV_ISA_C
> >> >                 return (*insn & 0xffff) == UPROBE_SWBP_INSN;
> >> >         #else
> >> >                 return *insn == UPROBE_SWBP_INSN;
> >> >         #endif
> >> >
> >> > ...so it doesn't even check for 32-bit ebreak if C extension is on. My patch
> >> > is not the same.
> >> 
> >> Ah, was too quick.
> >> 
> >> AFAIU uprobes *always* uses c.ebreak when CONFIG_RISCV_ISA_C is set, and
> >> ebreak otherwise. That's the reason is_swbp_insn() is implemented like
> >> that.
> >
> > That's what I understand too.
> >
> >> If that's not the case, there's a another bug, that your patches
> >> addresses.
> >
> > I think it's a bug regardless. is_trap_insn() is used by uprobes to figure out
> > if there is an instruction that generates trap exception, not just instructions
> > that are "SWBP". The reason is because when there is a trap, but uprobes doesn't
> > see a probe installed here, it needs is_trap_insn() to figure out if the trap
> > is generated by ebreak from something else, or because the probe is just removed.
> > In the latter case, uprobes will return back, because probe has already been removed,
> > so it should be safe to do so. That's why I think the incorrect is_swbp_insn()
> > would cause a hang, because uprobes incorrectly thinks there is no ebreak there,
> > so it should be okay to go back, but there actually is.
> >
> > So, from my understanding, if uprobes encounter a 32-bit ebreak for any reason,
> > the kernel would hang. I think your patch is a great addition nonetheless, but I
> > am guessing that it only masks the problem by preventing uprobes from seeing the
> > 32-bit ebreak in the specific test, not really solve it. So, if there is a 32-bit
> > ebreak in userspace, the bug still causes the kernel to hang.
> >
> > I am still quite confident of my logic, so I would be very suprised if my fix
> > doesn't solve the reported hang. Do you mind testing my patch? My potato of a
> > laptop unfortunately cannot run the test :(
> 
> Maybe I wasn't clear, sorry for that! I did take the patch for a spin,
> and it did not solve this particular problem.

Okay, thanks for the comfirmation!
 
> When we're taking a trap from *kernel*mode, we should never deal with
> uprobes at all. Have a look at uprobe_pre_sstep_notifier(), this
> function returns 1, which then means that the trap handler exit
> premature.
>
> The code you're referring to (called from uprobe_notify_resume()), and
> will never be entered, because we're not exiting the trap to
> userland. Have a look in kernel/entry/common.c (search for
> e.g. TIF_UPROBE).

I will think about this a bit and answer later. I will answer the below part
first.
 
> Now, for your concern, which I see as a potential different bug. Not at
> all related to my issue "trap from kernelmode touches uprobe
> incorrectly"; A "random" ebreak from *userland* is trapped, when uprobes
> is enabled will set the kernel in a hang. I suggest you construct try to
> write a simple program to reproduce this!
> 
> I had a quick look in the uprobe handling code, and AFAIU the was used
> when installing the uprobe as an additional check, and when searching
> for an active uprobe. I'm still a bit puzzled how the issue you're
> describing could trigger. A reproducer would help!

I have just produced the problem, using this small program:

	.global _start                                                                                      
	_start:
		addi x0, x1, 0
		addi x0, x1, 1
	        addi x0, x1, 2
	.option push
	.option arch, -c
	        ebreak
	.option pop
	        ecall

Compile that with
	riscv64-linux-gnu-gcc test.s -nostdlib -static -o ebreak

And setup uprobes by:
	mount -t tracefs nodev /sys/kernel/tracing/
	echo "p /ebreak:0x0000010c" > /sys/kernel/tracing/uprobe_events
	echo 1 > /sys/kernel/tracing/events/uprobes/enable

(obviously you would have to edit the offset value to be _start symbol of your
binary)

Then I execute the program, and the kernel loop indefinitely (it keeps going in
and out of exception handler).

Then I apply my patch, then the kernel doesn't loop anymore.

So I think it is a valid issue, and I will send a proper patch to fix this.

Best regards,
Nam 

