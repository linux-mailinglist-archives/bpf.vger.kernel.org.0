Return-Path: <bpf+bounces-55520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24167A82394
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 13:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B0A4487E0
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 11:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6237C25E448;
	Wed,  9 Apr 2025 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XcN+u0A9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C8025DB17
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744198172; cv=none; b=SQv65/ebv0obwa5d4xC2wRPIMO9zenm8EqJa7U2Hw9N8qsazYj0T4YRwLEC9Ncu0vGrMeJY46g4wsloAjHHiZAm3yyfeAlCnZoy0oGEK+STS9ttZJP0BNIxnFNzmeOpMe8lHPEgf4BnWDO441kgs3H7YU2g868SgnonSXjrwkkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744198172; c=relaxed/simple;
	bh=zXYaCCk7Xexl/noIb6OuPUIMVrNTYDA8ydr6oeZbr1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CL9nlIlSPIUzh2DqJ9k0sChUbEHopy+a8EbTIlEFOIN1Cerc4G1WyYgrkNaKcVrAunfCaJb28SpOD0u0TcylYIVpCSbXNrVQ57mcrv5tXZIbOjmAD50e3L5n3Nt3vubv1KvS+QfTHpxZBLLa4IXykQV5d/hIgvxtmqWCj0sra+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XcN+u0A9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744198169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9Of+gzTbsEE9FaHMGyGpxjiy7YHu1Oa9tXAD/zDQnY=;
	b=XcN+u0A9A+esPM0geR1yEjY+BR0j8s3FLa/h/XdxedkAc81HRYTieAn78aGwXIr6mQP/wI
	8CUWtv6uvVrbu2UT0qeMFGmR8LgAH9oTx60bXuOjoT/8EIZ8KNxM3oCamC6+w9k/FxW7b/
	LNx/x2eyAns5f17aHyv7IgN0xXt8nqw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-2Sb6ZC_POsi-lpR4UKm0UQ-1; Wed,
 09 Apr 2025 07:29:23 -0400
X-MC-Unique: 2Sb6ZC_POsi-lpR4UKm0UQ-1
X-Mimecast-MFC-AGG-ID: 2Sb6ZC_POsi-lpR4UKm0UQ_1744198161
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06B321800257;
	Wed,  9 Apr 2025 11:29:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.54])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 18DE1180B487;
	Wed,  9 Apr 2025 11:29:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  9 Apr 2025 13:28:45 +0200 (CEST)
Date: Wed, 9 Apr 2025 13:28:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH 1/2] uprobes/x86: Add support to emulate nop5 instruction
Message-ID: <20250409112839.GA32748@redhat.com>
References: <20250408211310.51491-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408211310.51491-1-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 04/08, Jiri Olsa wrote:
>
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -608,6 +608,16 @@ static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
>  		*sr = utask->autask.saved_scratch_register;
>  	}
>  }
> +
> +static int is_nop5_insn(uprobe_opcode_t *insn)
> +{
> +	return !memcmp(insn, x86_nops[5], 5);
> +}
> +
> +static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
> +{
> +	return is_nop5_insn((uprobe_opcode_t *) &auprobe->insn);
> +}

Why do we need 2 functions? Can't branch_setup_xol_ops() just use
is_nop5_insn(insn->kaddr) ?

>  #else /* 32-bit: */
>  /*
>   * No RIP-relative addressing on 32-bit
> @@ -621,6 +631,10 @@ static void riprel_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
>  static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
>  {
>  }
> +static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
> +{
> +	return false;
> +}

Hmm, why? I mean, why we can't emulate x86_nops[5] if !CONFIG_X86_64 ?

OTOH. What if the kernel is 64-bit, but the probed task is 32-bit and it
uses the 64-bit version of BYTES_NOP5?

Perhaps this is fine, I simply don't know, so let me ask...

> @@ -852,6 +866,8 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
>  		break;
>
>  	case 0x0f:
> +		if (emulate_nop5_insn(auprobe))
> +			goto setup;

I think this will work, but if we want to emulate nop5, then perhaps
we can do the same for other nops?

For the moment, lets forget about compat tasks on a 64-bit kernel, can't
we simply do something like below?

Oleg.
---

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 9194695662b2..76d2cceca6c4 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -840,12 +840,16 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 	insn_byte_t p;
 	int i;
 
+	/* prefix* + nop[i]; same as jmp with .offs = 0 */
+	for (i = 1; i <= ASM_NOP_MAX; ++i) {
+		if (!memcmp(insn->kaddr, x86_nops[i], i))
+			goto setup;
+	}
+
 	switch (opc1) {
 	case 0xeb:	/* jmp 8 */
 	case 0xe9:	/* jmp 32 */
 		break;
-	case 0x90:	/* prefix* + nop; same as jmp with .offs = 0 */
-		goto setup;
 
 	case 0xe8:	/* call relative */
 		branch_clear_offset(auprobe, insn);


