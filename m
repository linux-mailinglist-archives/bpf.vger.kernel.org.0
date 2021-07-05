Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C2D3BB968
	for <lists+bpf@lfdr.de>; Mon,  5 Jul 2021 10:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhGEIhj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Jul 2021 04:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhGEIhi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Jul 2021 04:37:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD4DC061574;
        Mon,  5 Jul 2021 01:35:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g8-20020a1c9d080000b02901f13dd1672aso8636878wme.0;
        Mon, 05 Jul 2021 01:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vGRWvdOK1PgDadGaQtrO3gHLl2eTZPMYHv0bkQBzh00=;
        b=iS+lH8U9/XgWWefVhtVSlFRj5PsQkAjqPPdERklq6ayKTQPmRvs4vnr3SDUy2vNTRw
         f/GdEj1zz4eBn4lZumC+4tZ6ruSYP5Q6MA/CWiyF/15wvxgxkTHVtGfTldj9fvRByZGj
         94YaWvJSt6d+yNDl+FRC2sKu/FDI3T3FyLr+OT7lh+sA88G5p6nwESmiYD6Aybw09+aC
         5CgMTBLfnSe7MOqW6a0cvFo8cFrFCzFkn0vXOiQ7RcnM1LE14HgfDTXFk+MCgcrv3kZ6
         N5tCNlehjL+RxKFY6uKc5V3N2I0Q2ow68v3wn+8+nhS6Y9va5Z3r7c1bVPbPfKIuF/Y1
         drFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vGRWvdOK1PgDadGaQtrO3gHLl2eTZPMYHv0bkQBzh00=;
        b=b4y462iJ2QD5oS4KXuhdjrDhpql2hgENnkkf7QDrhzFRlUzFe+dWxh35b6iZjsI3hX
         /C0SoQMo2gmtMvJru8m7DF+ApO0zDjkRX/nP93PnosHHqUnYYZE3riqOq4J2H+E4qsyO
         lgV6OGhS4XwZqleJZlroQOA6oHde8aGlIQsYJmhlGZhqS4vfZnLed9WSSlOObWmAxgR0
         K6HOnDhqfh5ZPwzw7JUxsdLJvJ08gXeMSFW2yHCJXwQi/hep2KRj2owWnE/5fNQPrnlg
         unQD8Mui6GoIhLP1weXV+qn8n++ikLn19zDVObt389Fo71auJasPE7E64RPXjdL0hG6l
         UHVw==
X-Gm-Message-State: AOAM530pvpVXYirVmJbcEXRHxgg4jdRC6Qlv2Jfxpcvquw9UtaqPozO8
        gSPVzUAwFHnaU59wyN1Zapg=
X-Google-Smtp-Source: ABdhPJwoW+wrIqWbqydnd2SnNFn+Rr7wab7v4jWy971rPZ7WDn00TetlfWn+CwRfKmrKoYP01daj9w==
X-Received: by 2002:a1c:9dce:: with SMTP id g197mr13985028wme.149.1625474100512;
        Mon, 05 Jul 2021 01:35:00 -0700 (PDT)
Received: from gmail.com (178-164-188-14.pool.digikabel.hu. [178.164.188.14])
        by smtp.gmail.com with ESMTPSA id a9sm12092809wrv.37.2021.07.05.01.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 01:35:00 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 5 Jul 2021 10:34:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v8 13/13] x86/kprobes: Fixup return address in
 generic trampoline handler
Message-ID: <YOLEMvR1bCQiIMcl@gmail.com>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
 <162400004562.506599.7549585083316952768.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162400004562.506599.7549585083316952768.stgit@devnote2>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> In x86, kretprobe trampoline address on the stack frame will
> be replaced with the real return address after returning from
> trampoline_handler. Before fixing the return address, the real
> return address can be found in the current->kretprobe_instances.
> 
> However, since there is a window between updating the
> current->kretprobe_instances and fixing the address on the stack,
> if an interrupt caused at that timing and the interrupt handler
> does stacktrace, it may fail to unwind because it can not get
> the correct return address from current->kretprobe_instances.
> 
> This will minimize that window by fixing the return address
> right before updating current->kretprobe_instances.

Is there still a window? I.e. is it "minimized" (to how big of a window?), 
or eliminated?

> +void arch_kretprobe_fixup_return(struct pt_regs *regs,
> +				 unsigned long correct_ret_addr)
> +{
> +	unsigned long *frame_pointer;
> +
> +	frame_pointer = ((unsigned long *)&regs->sp) + 1;
> +
> +	/* Replace fake return address with real one. */
> +	*frame_pointer = correct_ret_addr;

Firstly, why does &regs->sp have to be forced to 'unsigned long *'? 

pt_regs::sp is 'unsigned long' on both 32-bit and 64-bit kernels AFAICS.

Secondly, the new code modified by your patch now looks like this:

        frame_pointer = ((unsigned long *)&regs->sp) + 1;
 
+       kretprobe_trampoline_handler(regs, frame_pointer);

where:

+void arch_kretprobe_fixup_return(struct pt_regs *regs,
+                                unsigned long correct_ret_addr)
+{
+       unsigned long *frame_pointer;
+
+       frame_pointer = ((unsigned long *)&regs->sp) + 1;
+
+       /* Replace fake return address with real one. */
+       *frame_pointer = correct_ret_addr;
+}

So we first do:

        frame_pointer = ((unsigned long *)&regs->sp) + 1;

... and pass that in to arch_kretprobe_fixup_return() as 
'correct_ret_addr', which does:

+       frame_pointer = ((unsigned long *)&regs->sp) + 1;
+	*frame_pointer = correct_ret_addr;

... which looks like the exact same thing as:

	*frame_pointer = frame_pointer;

... obfuscated through a thick layer of type casts?

Thanks,

	Ingo
