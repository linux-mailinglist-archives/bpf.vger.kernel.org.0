Return-Path: <bpf+bounces-8756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4968078989E
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 20:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC1E28135B
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 18:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961F0100B9;
	Sat, 26 Aug 2023 18:12:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB87DF4F
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 18:12:35 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CC2E7B
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 11:12:34 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99c136ee106so239697666b.1
        for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 11:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693073552; x=1693678352;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Gyzqi9og5VHGej7RqMB/sGNKltacYE0aaQTeJM5H9c=;
        b=GMVg/1oQvsYhhEmYirAtP41Lx/vkOjnyG01n6KTTeUzkspdjzji4xqorSKtk7Uvp1c
         dNDpUXWsvHEv7QTmUv1CzD0MSOwKfLTQmO6bYwPAVuVPJt+DXwtyRHyRiznbaU06cqfT
         vD5reBkDVHjMr1a1Ni8/u1s1+9B0HVAP1SxRVhNn3Z7nbdSNlmwSTi/ltm8Ctg/erFPk
         3arJR/fF1+aLVQmG/UPcU7dRRPtxBBvsvJHzDnCpjCmxK28f6nbp5lOHGixoFN1seDJ/
         U2bJcQMZyZFTuxf13gohWH0p5+2YnVjl0MIPb2kxEd1gwP/WMiOcRqyLoQAgem7YCxRD
         j1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693073552; x=1693678352;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Gyzqi9og5VHGej7RqMB/sGNKltacYE0aaQTeJM5H9c=;
        b=fK00HXvql8oF3qTZByiEK8+iyabwjXvzfWghmTpPVE2GuNKghwENrKr9tclsHRk2Uk
         r0oBTAwcfI6PwIztON26/gZd4tS+trlZZEZayHAKje+KJNSh2jtkT5YYTnq6+8dEiSiq
         Lsn2Pqd3acPyrZ7BZacBa12H3lVqxCClhTKh61xe7ZJ2YDxbRjHPbZcWlAc0nj3MAOng
         q+5KYm5M+u/e8qu2zDFXZXu9y4xcbbccBqO6JfMxaVp+ryplhBlY913FLAL7lIKcBkkH
         EYDcNoCXpEY6sZ//66/2Hd8RlPa6jJdN8daiihCi1yiJnH8WxYuOpwLjL61jBuQ+GJ6P
         tyzw==
X-Gm-Message-State: AOJu0YwDIQ2LdryZgPlYX/TnUO5zvfXDSmsxicRhUOfwW5kVAruFzjPm
	UU7ExVTLnSOr/bArMOJXzXc=
X-Google-Smtp-Source: AGHT+IEkSnUDy4cH+EJxekXscvslKpfZGHS61kq8bBp8TxIYmOpTFGcesNwwLFtzVpMz/YdEFIjesQ==
X-Received: by 2002:a17:906:8468:b0:9a1:f928:dddc with SMTP id hx8-20020a170906846800b009a1f928dddcmr7338705ejc.41.1693073552146;
        Sat, 26 Aug 2023 11:12:32 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id cf20-20020a170906b2d400b0098e78ff1a87sm2461305ejb.120.2023.08.26.11.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 11:12:31 -0700 (PDT)
Date: Sat, 26 Aug 2023 20:12:30 +0200
From: Nam Cao <namcaov@gmail.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
	bpf@vger.kernel.org, Hou Tao <houtao@huaweicloud.com>,
	yonghong.song@linux.dev,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: RISC-V uprobe bug (Was: Re: WARNING: CPU: 3 PID: 261 at
 kernel/bpf/memalloc.c:342)
Message-ID: <ZOpAjkTtA4jYtuIa@nam-dell>
References: <87jztjmmy4.fsf@all.your.base.are.belong.to.us>
 <87v8d19aun.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v8d19aun.fsf@all.your.base.are.belong.to.us>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 26, 2023 at 03:44:48PM +0200, Björn Töpel wrote:
> Björn Töpel <bjorn@kernel.org> writes:
> 
> > I'm chasing a workqueue hang on RISC-V/qemu (TCG), using the bpf
> > selftests on bpf-next 9e3b47abeb8f.
> >
> > I'm able to reproduce the hang by multiple runs of:
> >  | ./test_progs -a link_api -a linked_list
> > I'm currently investigating that.
> 
> +Guo for uprobe
> 
> This was an interesting bug. The hang is an ebreak (RISC-V breakpoint),
> that puts the kernel into an infinite loop.
> 
> To reproduce, simply run the BPF selftest:
> ./test_progs -v -a link_api -a linked_list
> 
> First the link_api test is being run, which exercises the uprobe
> functionality. The link_api test completes, and test_progs will still
> have the uprobe active/enabled. Next the linked_list test triggered a
> WARN_ON (which is implemented via ebreak as well).
> 
> Now, handle_break() is entered, and the uprobe_breakpoint_handler()
> returns true exiting the handle_break(), which returns to the WARN
> ebreak, and we have merry-go-round.
> 
> Lucky for the RISC-V folks, the BPF memory handler had a WARN that
> surfaced the bug! ;-)

Thanks for the analysis.

I couldn't reproduce the problem, so I am just taking a guess here. The problem
is bebcause uprobes didn't find a probe point at that ebreak instruction. However,
it also doesn't think a ebreak instruction is there, then it got confused and just
return back to the ebreak instruction, then everything repeats.

The reason why uprobes didn't think there is a ebreak instruction is because
is_trap_insn() only returns true if it is a 32-bit ebreak, or 16-bit c.ebreak if
C extension is available, not both. So a 32-bit ebreak is not correctly recognized
as a trap instruction.

If my guess is correct, the following should fix it. Can you please try if it works?

(this is the first time I send a patch this way, so please let me know if you can't apply)

Best regards,
Nam

---
 arch/riscv/kernel/probes/uprobes.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index 194f166b2cc4..91f4ce101cd1 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -3,6 +3,7 @@
 #include <linux/highmem.h>
 #include <linux/ptrace.h>
 #include <linux/uprobes.h>
+#include <asm/insn.h>
 
 #include "decode-insn.h"
 
@@ -17,6 +18,15 @@ bool is_swbp_insn(uprobe_opcode_t *insn)
 #endif
 }
 
+bool is_trap_insn(uprobe_opcode_t *insn)
+{
+#ifdef CONFIG_RISCV_ISA_C
+	if (riscv_insn_is_c_ebreak(*insn))
+		return true;
+#endif
+	return riscv_insn_is_ebreak(*insn);
+}
+
 unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
 {
 	return instruction_pointer(regs);
-- 
2.34.1



